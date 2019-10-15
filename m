Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840FCD7047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfJOHhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 03:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfJOHhp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:37:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA59DB588;
        Tue, 15 Oct 2019 07:37:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E9A41E4A8A; Tue, 15 Oct 2019 09:37:40 +0200 (CEST)
Date:   Tue, 15 Oct 2019 09:37:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191015073740.GA21550@quack2.suse.cz>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-10-19 16:30:24, Eric Sandeen wrote:
> Anything that walks all inodes on sb->s_inodes list without rescheduling
> risks softlockups.
> 
> Previous efforts were made in 2 functions, see:
> 
> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
> ac05fbb inode: don't softlockup when evicting inodes
> 
> but there hasn't been an audit of all walkers, so do that now.  This
> also consistently moves the cond_resched() calls to the bottom of each
> loop in cases where it already exists.
> 
> One loop remains: remove_dquot_ref(), because I'm not quite sure how
> to deal with that one w/o taking the i_lock.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Thanks Eric. The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I suppose you need to add Al to pickup the patch?

								Honza

> ---
> 
> V2: Drop unrelated iput cleanups in fsnotify
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d31b6c72b476..dc1a1d5d825b 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -35,11 +35,11 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  		spin_unlock(&inode->i_lock);
>  		spin_unlock(&sb->s_inode_list_lock);
> -		cond_resched();
>  		invalidate_mapping_pages(inode->i_mapping, 0, -1);
>  		iput(toput_inode);
>  		toput_inode = inode;
> +		cond_resched();
>  		spin_lock(&sb->s_inode_list_lock);
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a42882..b0c789bb3dba 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -676,6 +676,7 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
>  	struct inode *inode, *next;
>  	LIST_HEAD(dispose);
> +again:
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> @@ -698,6 +699,13 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		list_add(&inode->i_lru, &dispose);
> +
> +		if (need_resched()) {
> +			spin_unlock(&sb->s_inode_list_lock);
> +			cond_resched();
> +			dispose_list(&dispose);
> +			goto again;
> +		}
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 2ecef6155fc0..ac9eb273e28c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -77,6 +77,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  		iput_inode = inode;
> +		cond_resched();
>  		spin_lock(&sb->s_inode_list_lock);
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 6e826b454082..4a085b3c7cac 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -985,6 +985,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
>  		 * later.
>  		 */
>  		old_inode = inode;
> +		cond_resched();
>  		spin_lock(&sb->s_inode_list_lock);
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
