Return-Path: <linux-fsdevel+bounces-58998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43335B33D81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3002B1A81C19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10062E1C63;
	Mon, 25 Aug 2025 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/quDcXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC72D0623;
	Mon, 25 Aug 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119789; cv=none; b=gdWAVqhqiaQLy3Y4egO/Nlhr8uR1fTNxl83zJ5TC+uwC+oDRQUpslz5JOwUVr68UHKVGalTnSEs6MiRiRdkj/fTJAUKFE9LBk1kYYb1sXv1hx5EYkf6j1uRvxbM6hDnXQJ4eefBSwuW4PReVFH5Nmc1ctLX6Dww3P81DAV9duBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119789; c=relaxed/simple;
	bh=fwrctz1rF3tI30wat7xXKwqxu7qkIBSRaE8+WXj1AL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H605DuXvI7cZAKJVq4Sx614le0s6cl4izvu9GvPtgFljpQUhxcy/oHKlwBfDztbyihJPohm+8T4SoI0VN5Mi2V5vO9S6ZZXP82MLlZcLNFDByqmkfO3OKH3PI6/5YjTkwVng8e3fEJEkXLCbc9OSd217CYYBqCF6E59CjhZgIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/quDcXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF04C4CEED;
	Mon, 25 Aug 2025 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756119788;
	bh=fwrctz1rF3tI30wat7xXKwqxu7qkIBSRaE8+WXj1AL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/quDcXit+tuqXQuhp0NXL46YUg8fwuQhIbmxR23KTq+Sczg0RmSOejw/CjOse1QE
	 a/IZrQvQeDbQQ9zgovHruQmNIaTSXqCGVxxV7+pEeaoEf7cBcFEkacjz90usZj3boW
	 1WmFy+DxeJ6L9h7NwE2R6UjaTT6IhBs4atAeanR8mB099FM01dFnL9Vp1W5q0sh+T7
	 BbnqS/pb4MHMosYyNtg5FAh5/8uU8An7bfwK0fsPx1zaIIymgoRJs7LyK0W+s8GR2p
	 AC9+1z7HepCJRvFDmSRhTSizNf0O9MfJ/5NuFGrDfy1qpPYnUpIxyaWIaD0uyNf7mp
	 6HlYVWdl/lE4Q==
Date: Mon, 25 Aug 2025 13:03:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 20/50] fs: convert i_count to refcount_t
Message-ID: <20250825-gemein-eierkuchen-fab7184a080b@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:31PM -0400, Josef Bacik wrote:
> Now that we do not allow i_count to drop to 0 and be used we can convert
> it to a refcount_t and benefit from the protections those helpers add.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

I've commented on that earlier in the series:
We should have no plain accesses to ->i_count anywhere outside of core
vfs. We should always use accessors. So please add icount_read() and
iobj_count_read() or something similar like we have file_ref_read().

>  arch/powerpc/platforms/cell/spufs/file.c |  2 +-
>  fs/btrfs/inode.c                         |  4 ++--
>  fs/ceph/mds_client.c                     |  2 +-
>  fs/ext4/ialloc.c                         |  4 ++--
>  fs/fs-writeback.c                        |  2 +-
>  fs/hpfs/inode.c                          |  2 +-
>  fs/inode.c                               | 11 ++++++-----
>  fs/nfs/inode.c                           |  4 ++--
>  fs/notify/fsnotify.c                     |  2 +-
>  fs/ubifs/super.c                         |  2 +-
>  fs/xfs/xfs_inode.c                       |  2 +-
>  fs/xfs/xfs_trace.h                       |  2 +-
>  include/linux/fs.h                       |  4 ++--
>  include/trace/events/filelock.h          |  2 +-
>  security/landlock/fs.c                   |  2 +-
>  15 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index d5a2c77bc908..3f768b003838 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -1430,7 +1430,7 @@ static int spufs_mfc_open(struct inode *inode, struct file *file)
>  	if (ctx->owner != current->mm)
>  		return -EINVAL;
>  
> -	if (atomic_read(&inode->i_count) != 1)
> +	if (refcount_read(&inode->i_count) != 1)
>  		return -EBUSY;
>  
>  	mutex_lock(&ctx->mapping_lock);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bbbcd96e8f5c..e85e38df3ea0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3418,7 +3418,7 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	unsigned long flags;
>  
> -	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
> +	if (refcount_dec_not_one(&inode->vfs_inode.i_count)) {
>  		iobj_put(&inode->vfs_inode);
>  		return;
>  	}
> @@ -4559,7 +4559,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
>  
>  	inode = btrfs_find_first_inode(root, min_ino);
>  	while (inode) {
> -		if (atomic_read(&inode->vfs_inode.i_count) > 1)
> +		if (refcount_read(&inode->vfs_inode.i_count) > 1)
>  			d_prune_aliases(&inode->vfs_inode);
>  
>  		min_ino = btrfs_ino(inode) + 1;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 0f497c39ff82..ff666d18f6ad 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2221,7 +2221,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
>  			int count;
>  			dput(dentry);
>  			d_prune_aliases(inode);
> -			count = atomic_read(&inode->i_count);
> +			count = refcount_read(&inode->i_count);
>  			if (count == 1)
>  				(*remaining)--;
>  			doutc(cl, "%p %llx.%llx cap %p pruned, count now %d\n",
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index df4051613b29..9a3c7f22a57e 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -252,10 +252,10 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>  		       "nonexistent device\n", __func__, __LINE__);
>  		return;
>  	}
> -	if (atomic_read(&inode->i_count) > 1) {
> +	if (refcount_read(&inode->i_count) > 1) {
>  		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: count=%d",
>  			 __func__, __LINE__, inode->i_ino,
> -			 atomic_read(&inode->i_count));
> +			 refcount_read(&inode->i_count));
>  		return;
>  	}
>  	if (inode->i_nlink) {
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 111a9d8215bf..789c4228412c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1796,7 +1796,7 @@ static int writeback_single_inode(struct inode *inode,
>  	int ret = 0;
>  
>  	spin_lock(&inode->i_lock);
> -	if (!atomic_read(&inode->i_count))
> +	if (!refcount_read(&inode->i_count))
>  		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
>  	else
>  		WARN_ON(inode->i_state & I_WILL_FREE);
> diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
> index a59e8fa630db..ee23a941d8f5 100644
> --- a/fs/hpfs/inode.c
> +++ b/fs/hpfs/inode.c
> @@ -184,7 +184,7 @@ void hpfs_write_inode(struct inode *i)
>  	struct hpfs_inode_info *hpfs_inode = hpfs_i(i);
>  	struct inode *parent;
>  	if (i->i_ino == hpfs_sb(i->i_sb)->sb_root) return;
> -	if (hpfs_inode->i_rddir_off && !atomic_read(&i->i_count)) {
> +	if (hpfs_inode->i_rddir_off && !refcount_read(&i->i_count)) {
>  		if (*hpfs_inode->i_rddir_off)
>  			pr_err("write_inode: some position still there\n");
>  		kfree(hpfs_inode->i_rddir_off);
> diff --git a/fs/inode.c b/fs/inode.c
> index 07c8edb4b58a..28d197731914 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -236,7 +236,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
>  	inode->i_state = 0;
>  	atomic64_set(&inode->i_sequence, 0);
>  	refcount_set(&inode->i_obj_count, 1);
> -	atomic_set(&inode->i_count, 1);
> +	refcount_set(&inode->i_count, 1);
>  	inode->i_op = &empty_iops;
>  	inode->i_fop = &no_open_fops;
>  	inode->i_ino = 0;
> @@ -561,7 +561,8 @@ static void init_once(void *foo)
>  void ihold(struct inode *inode)
>  {
>  	iobj_get(inode);
> -	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
> +	refcount_inc(&inode->i_count);
> +	WARN_ON(refcount_read(&inode->i_count) < 2);
>  }
>  EXPORT_SYMBOL(ihold);
>  
> @@ -614,7 +615,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  
>  	if (inode->i_state & (I_FREEING | I_WILL_FREE))
>  		return;
> -	if (atomic_read(&inode->i_count) != 1)
> +	if (refcount_read(&inode->i_count) != 1)
>  		return;
>  	if (inode->__i_nlink == 0)
>  		return;
> @@ -2019,7 +2020,7 @@ static void __iput(struct inode *inode, bool skip_lru)
>  		return;
>  	BUG_ON(inode->i_state & I_CLEAR);
>  
> -	if (atomic_add_unless(&inode->i_count, -1, 1)) {
> +	if (refcount_dec_not_one(&inode->i_count)) {
>  		iobj_put(inode);
>  		return;
>  	}
> @@ -2039,7 +2040,7 @@ static void __iput(struct inode *inode, bool skip_lru)
>  	 */
>  	drop = maybe_add_lru(inode, skip_lru);
>  
> -	if (atomic_dec_and_test(&inode->i_count))
> +	if (refcount_dec_and_test(&inode->i_count))
>  		iput_final(inode, drop);
>  	else
>  		spin_unlock(&inode->i_lock);
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 338ef77ae423..9cc84f0afa9a 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -608,7 +608,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
>  		inode->i_sb->s_id,
>  		(unsigned long long)NFS_FILEID(inode),
>  		nfs_display_fhandle_hash(fh),
> -		atomic_read(&inode->i_count));
> +		refcount_read(&inode->i_count));
>  
>  out:
>  	return inode;
> @@ -2229,7 +2229,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%llx)\n",
>  			__func__, inode->i_sb->s_id, inode->i_ino,
>  			nfs_display_fhandle_hash(NFS_FH(inode)),
> -			atomic_read(&inode->i_count), fattr->valid);
> +			refcount_read(&inode->i_count), fattr->valid);
>  
>  	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
>  		/* Only a mounted-on-fileid? Just exit */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 079b868552c2..0883696f873d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -66,7 +66,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  		 * removed all zero refcount inodes, in any case.  Test to
>  		 * be sure.
>  		 */
> -		if (!atomic_read(&inode->i_count)) {
> +		if (!refcount_read(&inode->i_count)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index f3e3b2068608..79526f71fa8a 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -358,7 +358,7 @@ static void ubifs_evict_inode(struct inode *inode)
>  		goto out;
>  
>  	dbg_gen("inode %lu, mode %#x", inode->i_ino, (int)inode->i_mode);
> -	ubifs_assert(c, !atomic_read(&inode->i_count));
> +	ubifs_assert(c, !refcount_read(&inode->i_count));
>  
>  	truncate_inode_pages_final(&inode->i_data);
>  
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9c39251961a3..06af749fe5f3 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1035,7 +1035,7 @@ xfs_itruncate_extents_flags(
>  	int			error = 0;
>  
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> -	if (atomic_read(&VFS_I(ip)->i_count))
> +	if (refcount_read(&VFS_I(ip)->i_count))
>  		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
>  	ASSERT(new_size <= XFS_ISIZE(ip));
>  	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index ac344e42846c..167d33b8095c 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1152,7 +1152,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
>  	TP_fast_assign(
>  		__entry->dev = VFS_I(ip)->i_sb->s_dev;
>  		__entry->ino = ip->i_ino;
> -		__entry->count = atomic_read(&VFS_I(ip)->i_count);
> +		__entry->count = refcount_read(&VFS_I(ip)->i_count);
>  		__entry->pincount = atomic_read(&ip->i_pincount);
>  		__entry->iflags = ip->i_flags;
>  		__entry->caller_ip = caller_ip;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8384ed81a5ad..34fb40ba8a94 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -880,7 +880,7 @@ struct inode {
>  	};
>  	atomic64_t		i_version;
>  	atomic64_t		i_sequence; /* see futex */
> -	atomic_t		i_count;
> +	refcount_t		i_count;
>  	atomic_t		i_dio_count;
>  	atomic_t		i_writecount;
>  #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
> @@ -3399,7 +3399,7 @@ static inline void iobj_get(struct inode *inode)
>  static inline void __iget(struct inode *inode)
>  {
>  	iobj_get(inode);
> -	atomic_inc(&inode->i_count);
> +	refcount_inc(&inode->i_count);
>  }
>  
>  extern void iget_failed(struct inode *);
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> index b8d1e00a7982..e745436cfcd2 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -189,7 +189,7 @@ TRACE_EVENT(generic_add_lease,
>  		__entry->i_ino = inode->i_ino;
>  		__entry->wcount = atomic_read(&inode->i_writecount);
>  		__entry->rcount = atomic_read(&inode->i_readcount);
> -		__entry->icount = atomic_read(&inode->i_count);
> +		__entry->icount = refcount_read(&inode->i_count);
>  		__entry->owner = fl->c.flc_owner;
>  		__entry->flags = fl->c.flc_flags;
>  		__entry->type = fl->c.flc_type;
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c04f8879ad03..570f851dc469 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1281,7 +1281,7 @@ static void hook_sb_delete(struct super_block *const sb)
>  		struct landlock_object *object;
>  
>  		/* Only handles referenced inodes. */
> -		if (!atomic_read(&inode->i_count))
> +		if (!refcount_read(&inode->i_count))
>  			continue;
>  
>  		/*
> -- 
> 2.49.0
> 

