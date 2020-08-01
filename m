Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F376D235426
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHATWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgHATWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:22:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DABC061756
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2020 12:22:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u64so31890133qka.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2020 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q4GZi4Kf5DXEeMyZGvNSCtr8zsFMta44KzAXttHuuE0=;
        b=AYRgmSwlCbhmP5pYZUUR4sCshvWjsdzOlDg0JxdJkej1euzDxG9WHW7ZVtWaId1iqf
         ZS0yTLi84i/6FC6dE4H6+jLAfmgUnms8dcvO+xepLw3Oo0yigsqosur9lXmjT2Rq0Hn6
         URq+4lf74PrL0UCa/E09EmtF2JbmMQOez4iOg20hhoHisc/U8i3MwOj1Ow6jc/X8ub0j
         ePncokutdFbDs3FcwJ77BG9yVZ9uYT9A3LSd8uOgFhXRFvbaOv0GHb0tpKki289HRHOr
         HT0O/I0OgTDpqbrCWm+a+zgoBH/NKOudR9TYhShmL3EIz5x1W7OqqcJm09vkXV+W4doG
         4kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q4GZi4Kf5DXEeMyZGvNSCtr8zsFMta44KzAXttHuuE0=;
        b=UXxa4G9pvt252tH7sNxHNgl+LOibTF+Ek8+I50PMyeOJ/gpvVcieGstzJjvnfi1AE9
         RXRm018wwkOpmfR4ea7edSnUZVu8D03ZaNJPh+0dp8b2WNbuAqc6/z1GrVYgXgjZ/14Z
         45E/BBeXC2QdhIUH+CKBwohMTXR6Fct28hX3jjqLlQ5Kt9i8DUkU8dAEqrk9KtUWoptQ
         TGqWv2Z1H/xhkBU9oUAJu9qR+Kq4efK0J/PrA5Y6+XTAN8DFQ3VVmWNq06fLr3OCnWHq
         cBMl5Z0fw/5w7PE3uTznYBpSQ8Z1G+ya4a3J0IW51+OFuua0z9oVVkDO2arvtX8aFjK7
         pSSQ==
X-Gm-Message-State: AOAM530hECIEr14O+IZo1EVIlfj3VMcJi3xQTPz/r8AgD8x3Vszb8ejM
        cp5QOpOsDtGx6pRCage5Jgd+OQ==
X-Google-Smtp-Source: ABdhPJy2uyI6oHAdI+296hCenAVQ2MQXwWTG7fao7gJpbyKCsf10jRdI/Zu/AjOJc0C2TFXKG1dmTg==
X-Received: by 2002:a05:620a:22ee:: with SMTP id p14mr10088938qki.223.1596309773350;
        Sat, 01 Aug 2020 12:22:53 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 15sm5761877qkm.112.2020.08.01.12.22.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 01 Aug 2020 12:22:51 -0700 (PDT)
Date:   Sat, 1 Aug 2020 12:22:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Down <chris@chrisdown.name>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v7 1/2] tmpfs: Per-superblock i_ino support
In-Reply-To: <1986b9d63b986f08ec07a4aa4b2275e718e47d8a.1594661218.git.chris@chrisdown.name>
Message-ID: <alpine.LSU.2.11.2008011131200.10700@eggly.anvils>
References: <cover.1594661218.git.chris@chrisdown.name> <1986b9d63b986f08ec07a4aa4b2275e718e47d8a.1594661218.git.chris@chrisdown.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Jul 2020, Chris Down wrote:

> get_next_ino has a number of problems:
> 
> - It uses and returns a uint, which is susceptible to become overflowed
>   if a lot of volatile inodes that use get_next_ino are created.
> - It's global, with no specificity per-sb or even per-filesystem. This
>   means it's not that difficult to cause inode number wraparounds on a
>   single device, which can result in having multiple distinct inodes
>   with the same inode number.
> 
> This patch adds a per-superblock counter that mitigates the second case.
> This design also allows us to later have a specific i_ino size
> per-device, for example, allowing users to choose whether to use 32- or
> 64-bit inodes for each tmpfs mount. This is implemented in the next
> commit.
> 
> For internal shmem mounts which may be less tolerant to spinlock delays,
> we implement a percpu batching scheme which only takes the stat_lock at
> each batch boundary.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks for coming back and completing this, Chris.
Some comments below, nothing to detract from that Ack, more notes to
myself: things I might change slightly when I get back here later on.
I'm glad to see Andrew pulled your 0/2 text into this 1/2.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> ---
>  include/linux/fs.h       | 15 +++++++++
>  include/linux/shmem_fs.h |  2 ++
>  mm/shmem.c               | 66 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f15848899945..b70b334f8e16 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2961,6 +2961,21 @@ extern void discard_new_inode(struct inode *);
>  extern unsigned int get_next_ino(void);
>  extern void evict_inodes(struct super_block *sb);
>  
> +/*
> + * Userspace may rely on the the inode number being non-zero. For example, glibc
> + * simply ignores files with zero i_ino in unlink() and other places.
> + *
> + * As an additional complication, if userspace was compiled with
> + * _FILE_OFFSET_BITS=32 on a 64-bit kernel we'll only end up reading out the
> + * lower 32 bits, so we need to check that those aren't zero explicitly. With
> + * _FILE_OFFSET_BITS=64, this may cause some harmless false-negatives, but
> + * better safe than sorry.
> + */
> +static inline bool is_zero_ino(ino_t ino)
> +{
> +	return (u32)ino == 0;
> +}

Hmm, okay. The value of this unnecessary, and inaccurately named,
wrapper is in the great comment above it: which then suffers a bit
from being hidden away in a header file.  I'd understand its placing
better if you had also changed get_next_ino() to use it.

And I have another reason for wondering whether this function is
the right thing to abstract out: 1 is also somewhat special, being
the ino of the root.  It seems a little unfortunate, when we recycle
through the 32-bit space, to reuse the one ino that is certain to be
still in use (maybe all the others get "rm -rf"ed every day).  But
I haven't yet decided whether that's worth bothering about at all.

> +
>  extern void __iget(struct inode * inode);
>  extern void iget_failed(struct inode *);
>  extern void clear_inode(struct inode *);
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 7a35a6901221..eb628696ec66 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -36,6 +36,8 @@ struct shmem_sb_info {
>  	unsigned char huge;	    /* Whether to try for hugepages */
>  	kuid_t uid;		    /* Mount uid for root directory */
>  	kgid_t gid;		    /* Mount gid for root directory */
> +	ino_t next_ino;		    /* The next per-sb inode number to use */
> +	ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
>  	struct mempolicy *mpol;     /* default memory policy for mappings */
>  	spinlock_t shrinklist_lock;   /* Protects shrinklist */
>  	struct list_head shrinklist;  /* List of shinkable inodes */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a0dbe62f8042..0ae250b4da28 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -260,18 +260,67 @@ bool vma_is_shmem(struct vm_area_struct *vma)
>  static LIST_HEAD(shmem_swaplist);
>  static DEFINE_MUTEX(shmem_swaplist_mutex);
>  
> -static int shmem_reserve_inode(struct super_block *sb)
> +/*
> + * shmem_reserve_inode() performs bookkeeping to reserve a shmem inode, and
> + * produces a novel ino for the newly allocated inode.
> + *
> + * It may also be called when making a hard link to permit the space needed by
> + * each dentry. However, in that case, no new inode number is needed since that
> + * internally draws from another pool of inode numbers (currently global
> + * get_next_ino()). This case is indicated by passing NULL as inop.
> + */
> +#define SHMEM_INO_BATCH 1024
> +static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
>  {
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
> -	if (sbinfo->max_inodes) {
> +	ino_t ino;
> +
> +	if (!(sb->s_flags & SB_KERNMOUNT)) {

I was disappointed to find that this is still decided by SB_KERNMOUNT
instead of max_inodes, as we had discussed previously.  But it may just
be me who sees that as a regression (taking stat_lock when minimizing
stat_lock was the mounter's choice), so I'll accept responsibility to
follow that up later (and in no great hurry).  And I may discover why
you didn't make the change - remount with different options might
well turn out to be a pain, and may entail some compromises.

>  		spin_lock(&sbinfo->stat_lock);
>  		if (!sbinfo->free_inodes) {
>  			spin_unlock(&sbinfo->stat_lock);
>  			return -ENOSPC;
>  		}
>  		sbinfo->free_inodes--;
> +		if (inop) {
> +			ino = sbinfo->next_ino++;
> +			if (unlikely(is_zero_ino(ino)))
> +				ino = sbinfo->next_ino++;
> +			if (unlikely(ino > UINT_MAX)) {
> +				/*
> +				 * Emulate get_next_ino uint wraparound for
> +				 * compatibility
> +				 */
> +				ino = 1;
> +			}
> +			*inop = ino;
> +		}
>  		spin_unlock(&sbinfo->stat_lock);
> +	} else if (inop) {
> +		/*
> +		 * __shmem_file_setup, one of our callers, is lock-free: it
> +		 * doesn't hold stat_lock in shmem_reserve_inode since
> +		 * max_inodes is always 0, and is called from potentially
> +		 * unknown contexts. As such, use a per-cpu batched allocator
> +		 * which doesn't require the per-sb stat_lock unless we are at
> +		 * the batch boundary.
> +		 */
> +		ino_t *next_ino;
> +		next_ino = per_cpu_ptr(sbinfo->ino_batch, get_cpu());
> +		ino = *next_ino;
> +		if (unlikely(ino % SHMEM_INO_BATCH == 0)) {
> +			spin_lock(&sbinfo->stat_lock);
> +			ino = sbinfo->next_ino;
> +			sbinfo->next_ino += SHMEM_INO_BATCH;
> +			spin_unlock(&sbinfo->stat_lock);
> +			if (unlikely(is_zero_ino(ino)))
> +				ino++;
> +		}
> +		*inop = ino;
> +		*next_ino = ++ino;
> +		put_cpu();
>  	}
> +
>  	return 0;
>  }
>  
> @@ -2222,13 +2271,14 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  	struct inode *inode;
>  	struct shmem_inode_info *info;
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
> +	ino_t ino;
>  
> -	if (shmem_reserve_inode(sb))
> +	if (shmem_reserve_inode(sb, &ino))
>  		return NULL;
>  
>  	inode = new_inode(sb);
>  	if (inode) {
> -		inode->i_ino = get_next_ino();
> +		inode->i_ino = ino;
>  		inode_init_owner(inode, dir, mode);
>  		inode->i_blocks = 0;
>  		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> @@ -2932,7 +2982,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>  	 * first link must skip that, to get the accounting right.
>  	 */
>  	if (inode->i_nlink) {
> -		ret = shmem_reserve_inode(inode->i_sb);
> +		ret = shmem_reserve_inode(inode->i_sb, NULL);
>  		if (ret)
>  			goto out;
>  	}
> @@ -3584,6 +3634,7 @@ static void shmem_put_super(struct super_block *sb)
>  {
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
>  
> +	free_percpu(sbinfo->ino_batch);
>  	percpu_counter_destroy(&sbinfo->used_blocks);
>  	mpol_put(sbinfo->mpol);
>  	kfree(sbinfo);
> @@ -3626,6 +3677,11 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #endif
>  	sbinfo->max_blocks = ctx->blocks;
>  	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
> +	if (sb->s_flags & SB_KERNMOUNT) {
> +		sbinfo->ino_batch = alloc_percpu(ino_t);
> +		if (!sbinfo->ino_batch)
> +			goto failed;
> +	}
>  	sbinfo->uid = ctx->uid;
>  	sbinfo->gid = ctx->gid;
>  	sbinfo->mode = ctx->mode;
> -- 
> 2.27.0
