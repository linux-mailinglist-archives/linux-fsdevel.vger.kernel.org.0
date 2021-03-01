Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9A327D09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 12:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhCALVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 06:21:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232584AbhCALVq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:21:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0788FADE5;
        Mon,  1 Mar 2021 11:21:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B27F71E0871; Mon,  1 Mar 2021 12:21:02 +0100 (CET)
Date:   Mon, 1 Mar 2021 12:21:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] block_dump: don't put the last refcount when marking
 inode dirty
Message-ID: <20210301112102.GD25026@quack2.suse.cz>
References: <20210226103103.3048803-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226103103.3048803-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-02-21 18:31:03, zhangyi (F) wrote:
> There is an AA deadlock problem when using block_dump on ext4 file
> system with data=journal mode.
> 
>   watchdog: BUG: soft lockup - CPU#19 stuck for 22s! [jbd2/pmem0-8:1002]
>   CPU: 19 PID: 1002 Comm: jbd2/pmem0-8
>   RIP: 0010:queued_spin_lock_slowpath+0x60/0x3b0
>   ...
>   Call Trace:
>    _raw_spin_lock+0x57/0x70
>    jbd2_journal_invalidatepage+0x166/0x680
>    __ext4_journalled_invalidatepage+0x8c/0x120
>    ext4_journalled_invalidatepage+0x12/0x40
>    truncate_cleanup_page+0x10e/0x1c0
>    truncate_inode_pages_range+0x2c8/0xec0
>    truncate_inode_pages_final+0x41/0x90
>    ext4_evict_inode+0x254/0xac0
>    evict+0x11c/0x2f0
>    iput+0x20e/0x3a0
>    dentry_unlink_inode+0x1bf/0x1d0
>    __dentry_kill+0x14c/0x2c0
>    dput+0x2bc/0x630
>    block_dump___mark_inode_dirty.cold+0x5c/0x111
>    __mark_inode_dirty+0x678/0x6b0
>    mark_buffer_dirty+0x16e/0x1d0
>    __jbd2_journal_temp_unlink_buffer+0x127/0x1f0
>    __jbd2_journal_unfile_buffer+0x24/0x80
>    __jbd2_journal_refile_buffer+0x12f/0x1b0
>    jbd2_journal_commit_transaction+0x244b/0x3030
> 
> The problem is a race between jbd2 committing data buffer and user
> unlink the file concurrently. The jbd2 will get jh->b_state_lock and
> redirty the inode's data buffer and inode itself. If block_dump is
> enabled, it will try to find inode's dentry and invoke the last dput()
> after the inode was unlinked. Then the evict procedure will unmap
> buffer and get jh->b_state_lock again in journal_unmap_buffer(), and
> finally lead to deadlock. It works fine if block_dump is not enabled
> because the last evict procedure is not invoked in jbd2 progress and
> the jh->b_state_lock will also prevent inode use after free.
> 
> jbd2                                xxx
>                                     vfs_unlink
>                                      ext4_unlink
> jbd2_journal_commit_transaction
> **get jh->b_state_lock**
> jbd2_journal_refile_buffer
>  mark_buffer_dirty
>   __mark_inode_dirty
>    block_dump___mark_inode_dirty
>     d_find_alias
>                                      d_delete
>                                       unhash
>     dput  //put the last refcount
>      evict
>       journal_unmap_buffer
>        **get jh->b_state_lock again**
> 
> In most cases of where invoking mark_inode_dirty() will get inode's
> refcount and the last iput may not happen, but it's not safe. After
> checking the block_dump code, it only want to dump the file name of the
> dirty inode, so there is no need to get and put denrty, and dump an
> unhashed dentry is also fine. This patch remove the dget() && dput(),
> print the dentry name directly.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: yebin (H) <yebin10@huawei.com>

Hrm, ok. Honestly, I wanted to just delete that code for a long time. IMO
tracepoints (and we have one in __mark_inode_dirty) are much more useful
for tracing anyway. This code exists only because it was there much before
tracepoints existed... Do you have a strong reason why are you using
block_dump instead of tracepoint trace_writeback_mark_inode_dirty() for
your monitoring?

								Honza

> ---
>  fs/fs-writeback.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index c41cb887eb7d..e9b0952fe236 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2199,21 +2199,29 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
>  static noinline void block_dump___mark_inode_dirty(struct inode *inode)
>  {
>  	if (inode->i_ino || strcmp(inode->i_sb->s_id, "bdev")) {
> -		struct dentry *dentry;
> +		struct dentry *dentry = NULL;
>  		const char *name = "?";
>  
> -		dentry = d_find_alias(inode);
> -		if (dentry) {
> -			spin_lock(&dentry->d_lock);
> -			name = (const char *) dentry->d_name.name;
> +		if (!hlist_empty(&inode->i_dentry)) {
> +			spin_lock(&inode->i_lock);
> +			if (!hlist_empty(&inode->i_dentry)) {
> +				dentry = hlist_entry(inode->i_dentry.first,
> +						     struct dentry, d_u.d_alias);
> +				spin_lock(&dentry->d_lock);
> +				name = (const char *) dentry->d_name.name;
> +			} else {
> +				spin_unlock(&inode->i_lock);
> +			}
>  		}
> +
>  		printk(KERN_DEBUG
>  		       "%s(%d): dirtied inode %lu (%s) on %s\n",
>  		       current->comm, task_pid_nr(current), inode->i_ino,
>  		       name, inode->i_sb->s_id);
> +
>  		if (dentry) {
>  			spin_unlock(&dentry->d_lock);
> -			dput(dentry);
> +			spin_unlock(&inode->i_lock);
>  		}
>  	}
>  }
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
