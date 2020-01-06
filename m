Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA0130BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 03:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgAFCEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 21:04:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbgAFCEF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:04:05 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 82B3A5B94C23C3898F14;
        Mon,  6 Jan 2020 10:04:01 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 Jan 2020
 10:03:58 +0800
Subject: Re: [PATCH v5 1/2] tmpfs: Add per-superblock i_ino support
To:     Chris Down <chris@chrisdown.name>, <linux-mm@kvack.org>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox" <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
References: <cover.1578225806.git.chris@chrisdown.name>
 <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <4106bf3f-5c99-77a4-717e-10a0ffa6a3fa@huawei.com>
Date:   Mon, 6 Jan 2020 10:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <91b4ed6727712cb6d426cf60c740fe2f473f7638.1578225806.git.chris@chrisdown.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2020/1/5 20:06, Chris Down wrote:
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
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
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
>  include/linux/shmem_fs.h |  1 +
>  mm/shmem.c               | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> v5: Nothing in code, just resending with correct linux-mm domain.
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index de8e4b71e3ba..7fac91f490dc 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -35,6 +35,7 @@ struct shmem_sb_info {
>  	unsigned char huge;	    /* Whether to try for hugepages */
>  	kuid_t uid;		    /* Mount uid for root directory */
>  	kgid_t gid;		    /* Mount gid for root directory */
> +	ino_t next_ino;		    /* The next per-sb inode number to use */
>  	struct mempolicy *mpol;     /* default memory policy for mappings */
>  	spinlock_t shrinklist_lock;   /* Protects shrinklist */
>  	struct list_head shrinklist;  /* List of shinkable inodes */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8793e8cc1a48..9e97ba972225 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2236,6 +2236,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +/*
> + * shmem_get_inode - reserve, allocate, and initialise a new inode
> + *
> + * If this tmpfs is from kern_mount we use get_next_ino, which is global, since
> + * inum churn there is low and this avoids taking locks.
> + */
>  static struct inode *shmem_get_inode(struct super_block *sb, const struct inode *dir,
>  				     umode_t mode, dev_t dev, unsigned long flags)
>  {
> @@ -2248,7 +2254,28 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  
>  	inode = new_inode(sb);
>  	if (inode) {
> -		inode->i_ino = get_next_ino();
> +		if (sb->s_flags & SB_KERNMOUNT) {
> +			/*
> +			 * __shmem_file_setup, one of our callers, is lock-free:
> +			 * it doesn't hold stat_lock in shmem_reserve_inode
> +			 * since max_inodes is always 0, and is called from
> +			 * potentially unknown contexts. As such, use the global
> +			 * allocator which doesn't require the per-sb stat_lock.
> +			 */
> +			inode->i_ino = get_next_ino();
> +		} else {
> +			spin_lock(&sbinfo->stat_lock);

Use spin_lock will affect performance, how about define

unsigned long __percpu *last_ino_number; /* Last inode number */
atomic64_t shared_last_ino_number; /* Shared last inode number */
in shmem_sb_info, whose performance will be better?

> +			if (unlikely(sbinfo->next_ino > UINT_MAX)) {
> +				/*
> +				 * Emulate get_next_ino uint wraparound for
> +				 * compatibility
> +				 */
> +				sbinfo->next_ino = 1;
> +			}
> +			inode->i_ino = sbinfo->next_ino++;
> +			spin_unlock(&sbinfo->stat_lock);
> +		}
> +
>  		inode_init_owner(inode, dir, mode);
>  		inode->i_blocks = 0;
>  		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> @@ -3662,6 +3689,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  #else
>  	sb->s_flags |= SB_NOUSER;
>  #endif
> +	sbinfo->next_ino = 1;
>  	sbinfo->max_blocks = ctx->blocks;
>  	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
>  	sbinfo->uid = ctx->uid;

