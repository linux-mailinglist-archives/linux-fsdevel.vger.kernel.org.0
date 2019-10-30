Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 191BEE9AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 12:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJ3LSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 07:18:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LSg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:18:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50A9DAF27;
        Wed, 30 Oct 2019 11:18:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8D1E11E485C; Wed, 30 Oct 2019 12:18:23 +0100 (CET)
Date:   Wed, 30 Oct 2019 12:18:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 10/11] ext4: update ext4_sync_file() to not use
 __generic_file_fsync()
Message-ID: <20191030111823.GE28525@quack2.suse.cz>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <b58782fcf631b6248174fb69f3314fd60b760404.1572255426.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b58782fcf631b6248174fb69f3314fd60b760404.1572255426.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-10-19 21:53:52, Matthew Bobrowski wrote:
> When the filesystem is created without a journal, we eventually call
> into __generic_file_fsync() in order to write out all the modified
> in-core data to the permanent storage device. This function happens to
> try and obtain an inode_lock() while synchronizing the files buffer
> and it's associated metadata.
> 
> Generally, this is fine, however it becomes a problem when there is
> higher level code that has already obtained an inode_lock() as this
> leads to a recursive lock situation. This case is especially true when
> porting across direct I/O to iomap infrastructure as we obtain an
> inode_lock() early on in the I/O within ext4_dio_write_iter() and hold
> it until the I/O has been completed. Consequently, to not run into
> this specific issue, we move away from calling into
> __generic_file_fsync() and perform the necessary synchronization tasks
> within ext4_sync_file().
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Nice! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Thanks Jan and Christoph for the suggestion on this one, highly
> appreciated.
> 
>  fs/ext4/fsync.c | 72 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> index 5508baa11bb6..e10206e7f4bb 100644
> --- a/fs/ext4/fsync.c
> +++ b/fs/ext4/fsync.c
> @@ -80,6 +80,43 @@ static int ext4_sync_parent(struct inode *inode)
>  	return ret;
>  }
>  
> +static int ext4_fsync_nojournal(struct inode *inode, bool datasync,
> +				bool *needs_barrier)
> +{
> +	int ret, err;
> +
> +	ret = sync_mapping_buffers(inode->i_mapping);
> +	if (!(inode->i_state & I_DIRTY_ALL))
> +		return ret;
> +	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> +		return ret;
> +
> +	err = sync_inode_metadata(inode, 1);
> +	if (!ret)
> +		ret = err;
> +
> +	if (!ret)
> +		ret = ext4_sync_parent(inode);
> +	if (test_opt(inode->i_sb, BARRIER))
> +		*needs_barrier = true;
> +
> +	return ret;
> +}
> +
> +static int ext4_fsync_journal(struct inode *inode, bool datasync,
> +			     bool *needs_barrier)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
> +
> +	if (journal->j_flags & JBD2_BARRIER &&
> +	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
> +		*needs_barrier = true;
> +
> +	return jbd2_complete_transaction(journal, commit_tid);
> +}
> +
>  /*
>   * akpm: A new design for ext4_sync_file().
>   *
> @@ -91,17 +128,14 @@ static int ext4_sync_parent(struct inode *inode)
>   * What we do is just kick off a commit and wait on it.  This will snapshot the
>   * inode to disk.
>   */
> -
>  int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  {
> -	struct inode *inode = file->f_mapping->host;
> -	struct ext4_inode_info *ei = EXT4_I(inode);
> -	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>  	int ret = 0, err;
> -	tid_t commit_tid;
>  	bool needs_barrier = false;
> +	struct inode *inode = file->f_mapping->host;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> +	if (unlikely(ext4_forced_shutdown(sbi)))
>  		return -EIO;
>  
>  	J_ASSERT(ext4_journal_current_handle() == NULL);
> @@ -111,23 +145,15 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	if (sb_rdonly(inode->i_sb)) {
>  		/* Make sure that we read updated s_mount_flags value */
>  		smp_rmb();
> -		if (EXT4_SB(inode->i_sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
> +		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
>  			ret = -EROFS;
>  		goto out;
>  	}
>  
> -	if (!journal) {
> -		ret = __generic_file_fsync(file, start, end, datasync);
> -		if (!ret)
> -			ret = ext4_sync_parent(inode);
> -		if (test_opt(inode->i_sb, BARRIER))
> -			goto issue_flush;
> -		goto out;
> -	}
> -
>  	ret = file_write_and_wait_range(file, start, end);
>  	if (ret)
>  		return ret;
> +
>  	/*
>  	 * data=writeback,ordered:
>  	 *  The caller's filemap_fdatawrite()/wait will sync the data.
> @@ -142,18 +168,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  	 *  (they were dirtied by commit).  But that's OK - the blocks are
>  	 *  safe in-journal, which is all fsync() needs to ensure.
>  	 */
> -	if (ext4_should_journal_data(inode)) {
> +	if (!sbi->s_journal)
> +		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
> +	else if (ext4_should_journal_data(inode))
>  		ret = ext4_force_commit(inode->i_sb);
> -		goto out;
> -	}
> +	else
> +		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
>  
> -	commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
> -	if (journal->j_flags & JBD2_BARRIER &&
> -	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
> -		needs_barrier = true;
> -	ret = jbd2_complete_transaction(journal, commit_tid);
>  	if (needs_barrier) {
> -	issue_flush:
>  		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
>  		if (!ret)
>  			ret = err;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
