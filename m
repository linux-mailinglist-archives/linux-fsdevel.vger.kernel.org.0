Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8433AF3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCOJsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhCOJrr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:47:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCC60AC1D;
        Mon, 15 Mar 2021 09:47:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CE6971E423D; Mon, 15 Mar 2021 10:47:44 +0100 (CET)
Date:   Mon, 15 Mar 2021 10:47:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        viro@zeniv.linux.org.uk, hch@infradead.org, axboe@kernel.dk,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Subject: Re: [RFC PATCH 1/3] block_dump: remove block_dump feature in
 mark_inode_dirty()
Message-ID: <20210315094744.GA3227@quack2.suse.cz>
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
 <20210313030146.2882027-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313030146.2882027-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 13-03-21 11:01:44, zhangyi (F) wrote:
> block_dump is an old debugging interface, one of it's functions is used
> to print the information about who write which file on disk. If we
> enable block_dump through /proc/sys/vm/block_dump and turn on debug log
> level, we can gather information about write process name, target file
> name and disk from kernel message. This feature is realized in
> block_dump___mark_inode_dirty(), it print above information into kernel
> message directly when marking inode dirty, so it is noisy and can easily
> trigger log storm. At the same time, get the dentry refcount is also not
> safe, we found it will lead to deadlock on ext4 file system with
> data=journal mode.
> 
> After tracepoints has been introduced into the kernel, we got a
> tracepoint in __mark_inode_dirty(), which is a better replacement of
> block_dump___mark_inode_dirty(). The only downside is that it only trace
> the inode number and not a file name, but it probably doesn't matter
> because the original printed file name in block_dump is not accurate in
> some cases, and we can still find it through the inode number and device
> id. So this patch delete the dirting inode part of block_dump feature.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e91980f49388..7c46d1588a19 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2205,28 +2205,6 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
>  	return ret;
>  }
>  
> -static noinline void block_dump___mark_inode_dirty(struct inode *inode)
> -{
> -	if (inode->i_ino || strcmp(inode->i_sb->s_id, "bdev")) {
> -		struct dentry *dentry;
> -		const char *name = "?";
> -
> -		dentry = d_find_alias(inode);
> -		if (dentry) {
> -			spin_lock(&dentry->d_lock);
> -			name = (const char *) dentry->d_name.name;
> -		}
> -		printk(KERN_DEBUG
> -		       "%s(%d): dirtied inode %lu (%s) on %s\n",
> -		       current->comm, task_pid_nr(current), inode->i_ino,
> -		       name, inode->i_sb->s_id);
> -		if (dentry) {
> -			spin_unlock(&dentry->d_lock);
> -			dput(dentry);
> -		}
> -	}
> -}
> -
>  /**
>   * __mark_inode_dirty -	internal function to mark an inode dirty
>   *
> @@ -2296,9 +2274,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	    (dirtytime && (inode->i_state & I_DIRTY_INODE)))
>  		return;
>  
> -	if (unlikely(block_dump))
> -		block_dump___mark_inode_dirty(inode);
> -
>  	spin_lock(&inode->i_lock);
>  	if (dirtytime && (inode->i_state & I_DIRTY_INODE))
>  		goto out_unlock_inode;
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
