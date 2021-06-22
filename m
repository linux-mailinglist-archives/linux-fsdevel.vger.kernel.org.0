Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588AA3B00CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFVJ4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 05:56:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42260 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJ4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:56:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4FC7B21971;
        Tue, 22 Jun 2021 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624355653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98oHbO3xbIWGY6iWjq4cc/TM2Gd76Sa3sYzYIdOT4wU=;
        b=L4lQ6YLfL63yCa/e3tbt/jq8R1xqWm+v2o/DH7dIcIJYJv6pCcTVNq3enDeN65HvGZjSBS
        BtjIZcn4cYdBzXcmTSl4lB59pDTG0HaxAngEQ4SytbdshJK92vht4zKX5UBRWZwllnfhYE
        H6m2edrKvIOA+whkfYvQ0EKzIdIeHgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624355653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98oHbO3xbIWGY6iWjq4cc/TM2Gd76Sa3sYzYIdOT4wU=;
        b=85ksBjtuJLcIg5Iuw2jFfRQxornaqU4uad+4RWAz20kuSJZGqvqhFEv9Fc7gdmAFR/hcHz
        DG7BqAJf3K/1ieAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id EB580A3B85;
        Tue, 22 Jun 2021 09:54:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B717F1E1515; Tue, 22 Jun 2021 11:54:12 +0200 (CEST)
Date:   Tue, 22 Jun 2021 11:54:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 05/14] ext4: Convert to use mapping->invalidate_lock
Message-ID: <20210622095412.GD14261@quack2.suse.cz>
References: <20210615090844.6045-1-jack@suse.cz>
 <20210615091814.28626-5-jack@suse.cz>
 <20210617162240.GP158209@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617162240.GP158209@locust>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-06-21 09:22:40, Darrick J. Wong wrote:
> On Tue, Jun 15, 2021 at 11:17:55AM +0200, Jan Kara wrote:
> > Convert ext4 to use mapping->invalidate_lock instead of its private
> > EXT4_I(inode)->i_mmap_sem. This is mostly search-and-replace. By this
> > conversion we fix a long standing race between hole punching and read(2)
> > / readahead(2) paths that can lead to stale page cache contents.
> > 
> > CC: <linux-ext4@vger.kernel.org>
> > CC: Ted Tso <tytso@mit.edu>
> 
> Hmm, still no ACK from Ted?

On ext4 call he mentioned he's fine with the patches and testing has passed
for him but he has not given an official tag...

> This looks like a pretty straightforward i_mmap_sem conversion, though
> in general I'd like /some/ kind of response from anyone in the ext4
> community who has been writing code more recently than me...
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Yeah, this was basically search-and-replace. Thanks for review!

								Honza


> 
> --D
> 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/ext4.h     | 10 ----------
> >  fs/ext4/extents.c  | 25 +++++++++++++-----------
> >  fs/ext4/file.c     | 13 +++++++------
> >  fs/ext4/inode.c    | 47 +++++++++++++++++-----------------------------
> >  fs/ext4/ioctl.c    |  4 ++--
> >  fs/ext4/super.c    | 13 +++++--------
> >  fs/ext4/truncate.h |  8 +++++---
> >  7 files changed, 50 insertions(+), 70 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 37002663d521..ed64b4b217a1 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1077,15 +1077,6 @@ struct ext4_inode_info {
> >  	 * by other means, so we have i_data_sem.
> >  	 */
> >  	struct rw_semaphore i_data_sem;
> > -	/*
> > -	 * i_mmap_sem is for serializing page faults with truncate / punch hole
> > -	 * operations. We have to make sure that new page cannot be faulted in
> > -	 * a section of the inode that is being punched. We cannot easily use
> > -	 * i_data_sem for this since we need protection for the whole punch
> > -	 * operation and i_data_sem ranks below transaction start so we have
> > -	 * to occasionally drop it.
> > -	 */
> > -	struct rw_semaphore i_mmap_sem;
> >  	struct inode vfs_inode;
> >  	struct jbd2_inode *jinode;
> >  
> > @@ -2962,7 +2953,6 @@ extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
> >  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
> >  			     loff_t lstart, loff_t lend);
> >  extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
> > -extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
> >  extern qsize_t *ext4_get_reserved_space(struct inode *inode);
> >  extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
> >  extern void ext4_da_release_space(struct inode *inode, int to_free);
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index cbf37b2cf871..db5d38af9ba8 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -4470,6 +4470,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >  			    loff_t len, int mode)
> >  {
> >  	struct inode *inode = file_inode(file);
> > +	struct address_space *mapping = file->f_mapping;
> >  	handle_t *handle = NULL;
> >  	unsigned int max_blocks;
> >  	loff_t new_size = 0;
> > @@ -4556,17 +4557,17 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >  		 * Prevent page faults from reinstantiating pages we have
> >  		 * released from page cache.
> >  		 */
> > -		down_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_lock(mapping);
> >  
> >  		ret = ext4_break_layouts(inode);
> >  		if (ret) {
> > -			up_write(&EXT4_I(inode)->i_mmap_sem);
> > +			filemap_invalidate_unlock(mapping);
> >  			goto out_mutex;
> >  		}
> >  
> >  		ret = ext4_update_disksize_before_punch(inode, offset, len);
> >  		if (ret) {
> > -			up_write(&EXT4_I(inode)->i_mmap_sem);
> > +			filemap_invalidate_unlock(mapping);
> >  			goto out_mutex;
> >  		}
> >  		/* Now release the pages and zero block aligned part of pages */
> > @@ -4575,7 +4576,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >  
> >  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> >  					     flags);
> > -		up_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_unlock(mapping);
> >  		if (ret)
> >  			goto out_mutex;
> >  	}
> > @@ -5217,6 +5218,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
> >  static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  {
> >  	struct super_block *sb = inode->i_sb;
> > +	struct address_space *mapping = inode->i_mapping;
> >  	ext4_lblk_t punch_start, punch_stop;
> >  	handle_t *handle;
> >  	unsigned int credits;
> > @@ -5270,7 +5272,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  	 * Prevent page faults from reinstantiating pages we have released from
> >  	 * page cache.
> >  	 */
> > -	down_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_lock(mapping);
> >  
> >  	ret = ext4_break_layouts(inode);
> >  	if (ret)
> > @@ -5285,15 +5287,15 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  	 * Write tail of the last page before removed range since it will get
> >  	 * removed from the page cache below.
> >  	 */
> > -	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset, offset);
> > +	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
> >  	if (ret)
> >  		goto out_mmap;
> >  	/*
> >  	 * Write data that will be shifted to preserve them when discarding
> >  	 * page cache below. We are also protected from pages becoming dirty
> > -	 * by i_mmap_sem.
> > +	 * by i_rwsem and invalidate_lock.
> >  	 */
> > -	ret = filemap_write_and_wait_range(inode->i_mapping, offset + len,
> > +	ret = filemap_write_and_wait_range(mapping, offset + len,
> >  					   LLONG_MAX);
> >  	if (ret)
> >  		goto out_mmap;
> > @@ -5346,7 +5348,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  	ext4_journal_stop(handle);
> >  	ext4_fc_stop_ineligible(sb);
> >  out_mmap:
> > -	up_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_unlock(mapping);
> >  out_mutex:
> >  	inode_unlock(inode);
> >  	return ret;
> > @@ -5363,6 +5365,7 @@ static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  {
> >  	struct super_block *sb = inode->i_sb;
> > +	struct address_space *mapping = inode->i_mapping;
> >  	handle_t *handle;
> >  	struct ext4_ext_path *path;
> >  	struct ext4_extent *extent;
> > @@ -5421,7 +5424,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  	 * Prevent page faults from reinstantiating pages we have released from
> >  	 * page cache.
> >  	 */
> > -	down_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_lock(mapping);
> >  
> >  	ret = ext4_break_layouts(inode);
> >  	if (ret)
> > @@ -5522,7 +5525,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  	ext4_journal_stop(handle);
> >  	ext4_fc_stop_ineligible(sb);
> >  out_mmap:
> > -	up_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_unlock(mapping);
> >  out_mutex:
> >  	inode_unlock(inode);
> >  	return ret;
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 816dedcbd541..d3b4ed91aa68 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -704,22 +704,23 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
> >  	 */
> >  	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
> >  		(vmf->vma->vm_flags & VM_SHARED);
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> >  	pfn_t pfn;
> >  
> >  	if (write) {
> >  		sb_start_pagefault(sb);
> >  		file_update_time(vmf->vma->vm_file);
> > -		down_read(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_lock_shared(mapping);
> >  retry:
> >  		handle = ext4_journal_start_sb(sb, EXT4_HT_WRITE_PAGE,
> >  					       EXT4_DATA_TRANS_BLOCKS(sb));
> >  		if (IS_ERR(handle)) {
> > -			up_read(&EXT4_I(inode)->i_mmap_sem);
> > +			filemap_invalidate_unlock_shared(mapping);
> >  			sb_end_pagefault(sb);
> >  			return VM_FAULT_SIGBUS;
> >  		}
> >  	} else {
> > -		down_read(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_lock_shared(mapping);
> >  	}
> >  	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
> >  	if (write) {
> > @@ -731,10 +732,10 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
> >  		/* Handling synchronous page fault? */
> >  		if (result & VM_FAULT_NEEDDSYNC)
> >  			result = dax_finish_sync_fault(vmf, pe_size, pfn);
> > -		up_read(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_unlock_shared(mapping);
> >  		sb_end_pagefault(sb);
> >  	} else {
> > -		up_read(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_unlock_shared(mapping);
> >  	}
> >  
> >  	return result;
> > @@ -756,7 +757,7 @@ static const struct vm_operations_struct ext4_dax_vm_ops = {
> >  #endif
> >  
> >  static const struct vm_operations_struct ext4_file_vm_ops = {
> > -	.fault		= ext4_filemap_fault,
> > +	.fault		= filemap_fault,
> >  	.map_pages	= filemap_map_pages,
> >  	.page_mkwrite   = ext4_page_mkwrite,
> >  };
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index fe6045a46599..ee6e69d6f949 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3950,20 +3950,19 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> >  	return ret;
> >  }
> >  
> > -static void ext4_wait_dax_page(struct ext4_inode_info *ei)
> > +static void ext4_wait_dax_page(struct inode *inode)
> >  {
> > -	up_write(&ei->i_mmap_sem);
> > +	filemap_invalidate_unlock(inode->i_mapping);
> >  	schedule();
> > -	down_write(&ei->i_mmap_sem);
> > +	filemap_invalidate_lock(inode->i_mapping);
> >  }
> >  
> >  int ext4_break_layouts(struct inode *inode)
> >  {
> > -	struct ext4_inode_info *ei = EXT4_I(inode);
> >  	struct page *page;
> >  	int error;
> >  
> > -	if (WARN_ON_ONCE(!rwsem_is_locked(&ei->i_mmap_sem)))
> > +	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
> >  		return -EINVAL;
> >  
> >  	do {
> > @@ -3974,7 +3973,7 @@ int ext4_break_layouts(struct inode *inode)
> >  		error = ___wait_var_event(&page->_refcount,
> >  				atomic_read(&page->_refcount) == 1,
> >  				TASK_INTERRUPTIBLE, 0, 0,
> > -				ext4_wait_dax_page(ei));
> > +				ext4_wait_dax_page(inode));
> >  	} while (error == 0);
> >  
> >  	return error;
> > @@ -4005,9 +4004,9 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
> >  
> >  	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> >  	if (ext4_has_inline_data(inode)) {
> > -		down_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_lock(mapping);
> >  		ret = ext4_convert_inline_data(inode);
> > -		up_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_unlock(mapping);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -4058,7 +4057,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
> >  	 * Prevent page faults from reinstantiating pages we have released from
> >  	 * page cache.
> >  	 */
> > -	down_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_lock(mapping);
> >  
> >  	ret = ext4_break_layouts(inode);
> >  	if (ret)
> > @@ -4131,7 +4130,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
> >  out_stop:
> >  	ext4_journal_stop(handle);
> >  out_dio:
> > -	up_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_unlock(mapping);
> >  out_mutex:
> >  	inode_unlock(inode);
> >  	return ret;
> > @@ -5426,11 +5425,11 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> >  			inode_dio_wait(inode);
> >  		}
> >  
> > -		down_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_lock(inode->i_mapping);
> >  
> >  		rc = ext4_break_layouts(inode);
> >  		if (rc) {
> > -			up_write(&EXT4_I(inode)->i_mmap_sem);
> > +			filemap_invalidate_unlock(inode->i_mapping);
> >  			goto err_out;
> >  		}
> >  
> > @@ -5506,7 +5505,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> >  				error = rc;
> >  		}
> >  out_mmap_sem:
> > -		up_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_unlock(inode->i_mapping);
> >  	}
> >  
> >  	if (!error) {
> > @@ -5983,10 +5982,10 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
> >  	 * data (and journalled aops don't know how to handle these cases).
> >  	 */
> >  	if (val) {
> > -		down_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_lock(inode->i_mapping);
> >  		err = filemap_write_and_wait(inode->i_mapping);
> >  		if (err < 0) {
> > -			up_write(&EXT4_I(inode)->i_mmap_sem);
> > +			filemap_invalidate_unlock(inode->i_mapping);
> >  			return err;
> >  		}
> >  	}
> > @@ -6019,7 +6018,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
> >  	percpu_up_write(&sbi->s_writepages_rwsem);
> >  
> >  	if (val)
> > -		up_write(&EXT4_I(inode)->i_mmap_sem);
> > +		filemap_invalidate_unlock(inode->i_mapping);
> >  
> >  	/* Finally we can mark the inode as dirty. */
> >  
> > @@ -6063,7 +6062,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >  	sb_start_pagefault(inode->i_sb);
> >  	file_update_time(vma->vm_file);
> >  
> > -	down_read(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_lock_shared(mapping);
> >  
> >  	err = ext4_convert_inline_data(inode);
> >  	if (err)
> > @@ -6176,7 +6175,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >  out_ret:
> >  	ret = block_page_mkwrite_return(err);
> >  out:
> > -	up_read(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_unlock_shared(mapping);
> >  	sb_end_pagefault(inode->i_sb);
> >  	return ret;
> >  out_error:
> > @@ -6184,15 +6183,3 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
> >  	ext4_journal_stop(handle);
> >  	goto out;
> >  }
> > -
> > -vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
> > -{
> > -	struct inode *inode = file_inode(vmf->vma->vm_file);
> > -	vm_fault_t ret;
> > -
> > -	down_read(&EXT4_I(inode)->i_mmap_sem);
> > -	ret = filemap_fault(vmf);
> > -	up_read(&EXT4_I(inode)->i_mmap_sem);
> > -
> > -	return ret;
> > -}
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index 31627f7dc5cd..c5ed562b4185 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -148,7 +148,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
> >  		goto journal_err_out;
> >  	}
> >  
> > -	down_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_lock(inode->i_mapping);
> >  	err = filemap_write_and_wait(inode->i_mapping);
> >  	if (err)
> >  		goto err_out;
> > @@ -256,7 +256,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
> >  	ext4_double_up_write_data_sem(inode, inode_bl);
> >  
> >  err_out:
> > -	up_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_unlock(inode->i_mapping);
> >  journal_err_out:
> >  	unlock_two_nondirectories(inode, inode_bl);
> >  	iput(inode_bl);
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index d29f6aa7d96e..c3c3cd8b0966 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -90,12 +90,9 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
> >  /*
> >   * Lock ordering
> >   *
> > - * Note the difference between i_mmap_sem (EXT4_I(inode)->i_mmap_sem) and
> > - * i_mmap_rwsem (inode->i_mmap_rwsem)!
> > - *
> >   * page fault path:
> > - * mmap_lock -> sb_start_pagefault -> i_mmap_sem (r) -> transaction start ->
> > - *   page lock -> i_data_sem (rw)
> > + * mmap_lock -> sb_start_pagefault -> invalidate_lock (r) -> transaction start
> > + *   -> page lock -> i_data_sem (rw)
> >   *
> >   * buffered write path:
> >   * sb_start_write -> i_mutex -> mmap_lock
> > @@ -103,8 +100,9 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
> >   *   i_data_sem (rw)
> >   *
> >   * truncate:
> > - * sb_start_write -> i_mutex -> i_mmap_sem (w) -> i_mmap_rwsem (w) -> page lock
> > - * sb_start_write -> i_mutex -> i_mmap_sem (w) -> transaction start ->
> > + * sb_start_write -> i_mutex -> invalidate_lock (w) -> i_mmap_rwsem (w) ->
> > + *   page lock
> > + * sb_start_write -> i_mutex -> invalidate_lock (w) -> transaction start ->
> >   *   i_data_sem (rw)
> >   *
> >   * direct IO:
> > @@ -1350,7 +1348,6 @@ static void init_once(void *foo)
> >  	INIT_LIST_HEAD(&ei->i_orphan);
> >  	init_rwsem(&ei->xattr_sem);
> >  	init_rwsem(&ei->i_data_sem);
> > -	init_rwsem(&ei->i_mmap_sem);
> >  	inode_init_once(&ei->vfs_inode);
> >  	ext4_fc_init_inode(&ei->vfs_inode);
> >  }
> > diff --git a/fs/ext4/truncate.h b/fs/ext4/truncate.h
> > index bcbe3668c1d4..ce84aa2786c7 100644
> > --- a/fs/ext4/truncate.h
> > +++ b/fs/ext4/truncate.h
> > @@ -11,14 +11,16 @@
> >   */
> >  static inline void ext4_truncate_failed_write(struct inode *inode)
> >  {
> > +	struct address_space *mapping = inode->i_mapping;
> > +
> >  	/*
> >  	 * We don't need to call ext4_break_layouts() because the blocks we
> >  	 * are truncating were never visible to userspace.
> >  	 */
> > -	down_write(&EXT4_I(inode)->i_mmap_sem);
> > -	truncate_inode_pages(inode->i_mapping, inode->i_size);
> > +	filemap_invalidate_lock(mapping);
> > +	truncate_inode_pages(mapping, inode->i_size);
> >  	ext4_truncate(inode);
> > -	up_write(&EXT4_I(inode)->i_mmap_sem);
> > +	filemap_invalidate_unlock(mapping);
> >  }
> >  
> >  /*
> > -- 
> > 2.26.2
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
