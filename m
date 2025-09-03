Return-Path: <linux-fsdevel+bounces-60040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9553B4130F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 05:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8407E7A62D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA32D062A;
	Wed,  3 Sep 2025 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdrGJtMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F861BC58;
	Wed,  3 Sep 2025 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871099; cv=none; b=AsBkOH2PvkBb29dfigGuIRxQRw7UJplJdDR/+3K3TEIl+3RLbGrdQ53v7elWAaUvb/N9E4DshrhdvidIrAWzNc/YXjB/Dgf4QbXlG8eG2MupUMNnTRE7C70sjkgzPOABJlSdp6B/cZ5lWIY0/hKEqQuVqxk5kxT0TrCD5eMI9qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871099; c=relaxed/simple;
	bh=PvelsWIGe09Yeakjy9VGlt90Ro81lDt3MUlFaNnhHpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANwhU/HPWz3A4VpdrYNO4JyYdJxGSe9WAiK1+iWcwdsy6Ppm0SAJoqCgq2jc0jWkfTIorqrqBg5pSOexZTvg/iZOMzhmXq3Ddl0FnTlARnXEc3K5EY0UcyvrbBuJ4epCJ0vpHNVJ8QesF7lYZFe+62402KJTOx1S7xyHm/7tpFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OdrGJtMP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h+A5Evl7rfK/8SKJfoYihpjhh8MicK5nb9DTqHwAWIE=; b=OdrGJtMPERMxCqBXjxMQ1uhglM
	Dkg2czKqU5Xd2grdCwARTWIluIqz7abkOrYQPr0FHq/CuHsdZnrEFWS+sIWImQP0bKnK4S6g2Vzsm
	konZ7i9syIDZdlf7Qa9OGr90EYSIm/f68+YYHd7H5TpP6J9rzq+J2HGAkWk/bpm9OKoXxX0+kwEVq
	8L3XwOi8ke5/K0qr6VPaJ1ROohEL8aGMhXrC3I3udBN+56SRTDWMUDR696CK0svymxv+Yl/PHH8Om
	euwwd7mxUmo6iDNaGCOqskCmV6Pr3fPMFD34lpeqvbHqjY0wVHE5tayqVUM0vAQXsAqCQNGObi9ym
	wOg65iXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uteQW-0000000EieP-1FlW;
	Wed, 03 Sep 2025 03:44:52 +0000
Date: Wed, 3 Sep 2025 04:44:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
Message-ID: <aLe5tIMaTOPEUaWe@casper.infradead.org>
References: <20250902145428.456510-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902145428.456510-1-mjguzik@gmail.com>

On Tue, Sep 02, 2025 at 04:54:28PM +0200, Mateusz Guzik wrote:
> Following up on my response to the refcount patchset, here is a churn
> patch to retire I_WILL_FREE.
> 
> The only consumer is the drop inode routine in ocfs2.

If the only consumer is ocfs2 ... then you should cc the ocfs2 people,
right?

> For the life of me I could not figure out if write_inode_now() is legal
> to call in ->evict_inode later and have no means to test, so I devised a
> hack: let the fs set I_FREEING ahead of time. Also note iput_final()
> issues write_inode_now() anyway but only for the !drop case, which is the
> opposite of what is being returned.
> 
> One could further hack around it by having ocfs2 return *DON'T* drop but
> also set I_DONTCACHE, which would result in both issuing the write in
> iput_final() and dropping. I think the hack I did implement is cleaner.
> Preferred option is ->evict_inode from ocfs handling the i/o, but per
> the above I don't know how to do it.
> 
> So.. the following is my proposed first step towards sanitisation of
> i_state and the lifecycle flags.
> 
> I verified fs/inode.c and fs/fs-writeback.c compile, otherwise untested.
> 
> Generated against vfs-6.18.inode.refcount.preliminaries
> 
> Comments?
> 
> ---
>  block/bdev.c                     |  2 +-
>  fs/bcachefs/fs.c                 |  2 +-
>  fs/btrfs/inode.c                 |  2 +-
>  fs/crypto/keyring.c              |  2 +-
>  fs/drop_caches.c                 |  2 +-
>  fs/ext4/inode.c                  |  2 +-
>  fs/fs-writeback.c                | 18 +++++++----------
>  fs/gfs2/ops_fstype.c             |  2 +-
>  fs/inode.c                       | 34 +++++++++++++++++---------------
>  fs/notify/fsnotify.c             |  6 +++---
>  fs/ocfs2/inode.c                 |  3 +--
>  fs/quota/dquot.c                 |  2 +-
>  fs/xfs/scrub/common.c            |  3 +--
>  include/linux/fs.h               | 32 ++++++++++++------------------
>  include/trace/events/writeback.h |  3 +--
>  security/landlock/fs.c           | 12 +++++------
>  16 files changed, 58 insertions(+), 69 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index b77ddd12dc06..1801d89e448b 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
>  		struct block_device *bdev;
>  
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
> +		if (inode->i_state & (I_FREEING | I_NEW) ||
>  		    mapping->nrpages == 0) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index 687af0eea0c2..a62d597630d1 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
>  			spin_unlock(&inode->v.i_lock);
>  			return NULL;
>  		}
> -		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
> +		if ((inode->v.i_state & I_FREEING)) {
>  			if (!trans) {
>  				__wait_on_freeing_inode(c, inode, inum);
>  			} else {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5bcd8e25fa78..f1d9336b903f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
>  		ASSERT(ret != -ENOMEM);
>  		return ret;
>  	} else if (existing) {
> -		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
> +		WARN_ON(!(existing->vfs_inode.i_state & I_FREEING));
>  	}
>  
>  	return 0;
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 7557f6a88b8f..97f4c7049222 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> @@ -957,7 +957,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
>  	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
>  		inode = ci->ci_inode;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +		if (inode->i_state & (I_FREEING | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index 019a8b4eaaf9..40fa9b17375b 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -28,7 +28,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  		 * inodes without pages but we deliberately won't in case
>  		 * we need to reschedule to avoid softlockups.
>  		 */
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		if ((inode->i_state & (I_FREEING|I_NEW)) ||
>  		    (mapping_empty(inode->i_mapping) && !need_resched())) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ed54c4d0f2f9..14209758e5be 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
>  	if (!S_ISREG(inode->i_mode) ||
>  	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
>  	    is_special_ino(inode->i_sb, inode->i_ino) ||
> -	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
> +	    (inode->i_state & (I_FREEING | I_NEW)) ||
>  	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>  	    ext4_verity_in_progress(inode))
>  		return;
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6088a67b2aae..5fa388820daf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -405,10 +405,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	xa_lock_irq(&mapping->i_pages);
>  
>  	/*
> -	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
> +	 * Once I_FREEING is visible under i_lock, the eviction
>  	 * path owns the inode and we shouldn't modify ->i_io_list.
>  	 */
> -	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
> +	if (unlikely(inode->i_state & I_FREEING))
>  		goto skip_switch;
>  
>  	trace_inode_switch_wbs(inode, old_wb, new_wb);
> @@ -560,7 +560,7 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> -	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> +	    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
>  	    inode_to_wb(inode) == new_wb) {
>  		spin_unlock(&inode->i_lock);
>  		return false;
> @@ -1758,7 +1758,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>   * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
>   *
>   * To prevent the inode from going away, either the caller must have a reference
> - * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
> + * to the inode, or the inode must have I_FREEING set.
>   */
>  static int writeback_single_inode(struct inode *inode,
>  				  struct writeback_control *wbc)
> @@ -1768,9 +1768,7 @@ static int writeback_single_inode(struct inode *inode,
>  
>  	spin_lock(&inode->i_lock);
>  	if (!icount_read(inode))
> -		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
> -	else
> -		WARN_ON(inode->i_state & I_WILL_FREE);
> +		WARN_ON(!(inode->i_state & I_FREEING));
>  
>  	if (inode->i_state & I_SYNC) {
>  		/*
> @@ -1928,7 +1926,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 * kind writeout is handled by the freer.
>  		 */
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +		if (inode->i_state & (I_NEW | I_FREEING)) {
>  			redirty_tail_locked(inode, wb);
>  			spin_unlock(&inode->i_lock);
>  			continue;
> @@ -2696,7 +2694,7 @@ static void wait_sb_inodes(struct super_block *sb)
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
>  
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
> +		if (inode->i_state & (I_FREEING | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  
>  			spin_lock_irq(&sb->s_inode_wblist_lock);
> @@ -2844,8 +2842,6 @@ EXPORT_SYMBOL(sync_inodes_sb);
>   *
>   * This function commits an inode to disk immediately if it is dirty. This is
>   * primarily needed by knfsd.
> - *
> - * The caller must either have a ref on the inode or must have set I_WILL_FREE.
>   */
>  int write_inode_now(struct inode *inode, int sync)
>  {
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index c770006f8889..1393181a64dc 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1749,7 +1749,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
> +		if ((inode->i_state & (I_FREEING | I_NEW)) &&
>  		    !need_resched()) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> diff --git a/fs/inode.c b/fs/inode.c
> index 2db680a37235..8188b0b5dfa1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -532,7 +532,7 @@ EXPORT_SYMBOL(ihold);
>  
>  static void __inode_add_lru(struct inode *inode, bool rotate)
>  {
> -	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
> +	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING))
>  		return;
>  	if (icount_read(inode))
>  		return;
> @@ -577,7 +577,7 @@ static void inode_lru_list_del(struct inode *inode)
>  static void inode_pin_lru_isolating(struct inode *inode)
>  {
>  	lockdep_assert_held(&inode->i_lock);
> -	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
> +	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING));
>  	inode->i_state |= I_LRU_ISOLATING;
>  }
>  
> @@ -879,7 +879,7 @@ void evict_inodes(struct super_block *sb)
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +		if (inode->i_state & (I_NEW | I_FREEING)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> @@ -1025,7 +1025,7 @@ static struct inode *find_inode(struct super_block *sb,
>  		if (!test(inode, data))
>  			continue;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> +		if (inode->i_state & I_FREEING) {
>  			__wait_on_freeing_inode(inode, is_inode_hash_locked);
>  			goto repeat;
>  		}
> @@ -1066,7 +1066,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  		if (inode->i_sb != sb)
>  			continue;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> +		if (inode->i_state & I_FREEING) {
>  			__wait_on_freeing_inode(inode, is_inode_hash_locked);
>  			goto repeat;
>  		}
> @@ -1538,7 +1538,7 @@ EXPORT_SYMBOL(iunique);
>  struct inode *igrab(struct inode *inode)
>  {
>  	spin_lock(&inode->i_lock);
> -	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
> +	if (!(inode->i_state & I_FREEING)) {
>  		__iget(inode);
>  		spin_unlock(&inode->i_lock);
>  	} else {
> @@ -1728,7 +1728,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
>  
>  	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_sb == sb &&
> -		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
> +		    !(READ_ONCE(inode->i_state) & I_FREEING) &&
>  		    test(inode, data))
>  			return inode;
>  	}
> @@ -1767,7 +1767,7 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
>  	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_ino == ino &&
>  		    inode->i_sb == sb &&
> -		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
> +		    !(READ_ONCE(inode->i_state) & I_FREEING))
>  		    return inode;
>  	}
>  	return NULL;
> @@ -1789,7 +1789,7 @@ int insert_inode_locked(struct inode *inode)
>  			if (old->i_sb != sb)
>  				continue;
>  			spin_lock(&old->i_lock);
> -			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
> +			if (old->i_state & I_FREEING) {
>  				spin_unlock(&old->i_lock);
>  				continue;
>  			}
> @@ -1862,12 +1862,19 @@ static void iput_final(struct inode *inode)
>  	int drop;
>  
>  	WARN_ON(inode->i_state & I_NEW);
> +	VFS_BUG_ON_INODE(inode->i_state & I_FREEING, inode);
>  
>  	if (op->drop_inode)
>  		drop = op->drop_inode(inode);
>  	else
>  		drop = generic_drop_inode(inode);
>  
> +	/*
> +	 * Note: the ->drop_inode routine is allowed to set I_FREEING for us,
> +	 * but this is only legal if they want to drop.
> +	 */
> +	VFS_BUG_ON_INODE(!drop && (inode->i_state & I_FREEING), inode);
> +
>  	if (!drop &&
>  	    !(inode->i_state & I_DONTCACHE) &&
>  	    (sb->s_flags & SB_ACTIVE)) {
> @@ -1877,19 +1884,14 @@ static void iput_final(struct inode *inode)
>  	}
>  
>  	state = inode->i_state;
> +	WRITE_ONCE(inode->i_state, state | I_FREEING);
>  	if (!drop) {
> -		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
>  		spin_unlock(&inode->i_lock);
> -
>  		write_inode_now(inode, 1);
> -
>  		spin_lock(&inode->i_lock);
> -		state = inode->i_state;
> -		WARN_ON(state & I_NEW);
> -		state &= ~I_WILL_FREE;
>  	}
> +	WARN_ON(inode->i_state & I_NEW);
>  
> -	WRITE_ONCE(inode->i_state, state | I_FREEING);
>  	if (!list_empty(&inode->i_lru))
>  		inode_lru_list_del(inode);
>  	spin_unlock(&inode->i_lock);
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 46bfc543f946..cff8417fa6db 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -47,12 +47,12 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		/*
> -		 * We cannot __iget() an inode in state I_FREEING,
> -		 * I_WILL_FREE, or I_NEW which is fine because by that point
> +		 * We cannot __iget() an inode in state I_FREEING
> +		 * or I_NEW which is fine because by that point
>  		 * the inode cannot have any associated watches.
>  		 */
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
> +		if (inode->i_state & (I_FREEING | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 14bf440ea4df..29549fc899e9 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1307,12 +1307,11 @@ int ocfs2_drop_inode(struct inode *inode)
>  				inode->i_nlink, oi->ip_flags);
>  
>  	assert_spin_locked(&inode->i_lock);
> -	inode->i_state |= I_WILL_FREE;
> +	inode->i_state |= I_FREEING;
>  	spin_unlock(&inode->i_lock);
>  	write_inode_now(inode, 1);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state &= ~I_WILL_FREE;
>  
>  	return 1;
>  }
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index df4a9b348769..3aa916040602 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1030,7 +1030,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		if ((inode->i_state & (I_FREEING | I_NEW)) ||
>  		    !atomic_read(&inode->i_writecount) ||
>  		    !dqinit_needed(inode, type)) {
>  			spin_unlock(&inode->i_lock);
> diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
> index 2ef7742be7d3..e678f944206f 100644
> --- a/fs/xfs/scrub/common.c
> +++ b/fs/xfs/scrub/common.c
> @@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
>  
>  /*
>   * Install an already-referenced inode for scrubbing.  Get our own reference to
> - * the inode to make disposal simpler.  The inode must not be in I_FREEING or
> - * I_WILL_FREE state!
> + * the inode to make disposal simpler.  The inode must not have I_FREEING set.
>   */
>  int
>  xchk_install_live_inode(
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c4fd010cf5bf..e8ad8f0a03c7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -671,8 +671,8 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
>   *
>   * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
> - * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
> - * various stages of removing an inode.
> + * until that flag is cleared.  I_FREEING and I_CLEAR are set at various stages
> + * of removing an inode.
>   *
>   * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
>   *
> @@ -696,24 +696,21 @@ is_uncached_acl(struct posix_acl *acl)
>   *			New inodes set I_NEW.  If two processes both create
>   *			the same inode, one of them will release its inode and
>   *			wait for I_NEW to be released before returning.
> - *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
> - *			also cause waiting on I_NEW, without I_NEW actually
> - *			being set.  find_inode() uses this to prevent returning
> - *			nearly-dead inodes.
> - * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
> - *			is zero.  I_FREEING must be set when I_WILL_FREE is
> - *			cleared.
> + *			Inodes in I_FREEING or I_CLEAR state can also cause
> + *			waiting on I_NEW, without I_NEW actually being set.
> + *			find_inode() uses this to prevent returning nearly-dead
> + *			inodes.
>   * I_FREEING		Set when inode is about to be freed but still has dirty
>   *			pages or buffers attached or the inode itself is still
>   *			dirty.
>   * I_CLEAR		Added by clear_inode().  In this state the inode is
>   *			clean and can be destroyed.  Inode keeps I_FREEING.
>   *
> - *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
> - *			prohibited for many purposes.  iget() must wait for
> - *			the inode to be completely released, then create it
> - *			anew.  Other functions will just ignore such inodes,
> - *			if appropriate.  I_NEW is used for waiting.
> + *			Inodes that are I_FREEING or I_CLEAR are prohibited for
> + *			many purposes.  iget() must wait for the inode to be
> + *			completely released, then create it anew.  Other
> + *			functions will just ignore such inodes, if appropriate.
> + *			I_NEW is used for waiting.
>   *
>   * I_SYNC		Writeback of inode is running. The bit is set during
>   *			data writeback, and cleared with a wakeup on the bit
> @@ -743,8 +740,6 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
>   *			i_count.
>   *
> - * Q: What is the difference between I_WILL_FREE and I_FREEING?
> - *
>   * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
>   * upon. There's one free address left.
>   */
> @@ -764,7 +759,7 @@ enum inode_state_flags_t {
>  	I_DIRTY_SYNC		= (1U << 4),
>  	I_DIRTY_DATASYNC	= (1U << 5),
>  	I_DIRTY_PAGES		= (1U << 6),
> -	I_WILL_FREE		= (1U << 7),
> +	I_PINNING_NETFS_WB	= (1U << 7),
>  	I_FREEING		= (1U << 8),
>  	I_CLEAR			= (1U << 9),
>  	I_REFERENCED		= (1U << 10),
> @@ -775,7 +770,6 @@ enum inode_state_flags_t {
>  	I_CREATING		= (1U << 15),
>  	I_DONTCACHE		= (1U << 16),
>  	I_SYNC_QUEUED		= (1U << 17),
> -	I_PINNING_NETFS_WB	= (1U << 18)
>  };
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> @@ -2628,7 +2622,7 @@ static inline int icount_read(const struct inode *inode)
>  static inline bool inode_is_dirtytime_only(struct inode *inode)
>  {
>  	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
> -				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
> +				  I_FREEING)) == I_DIRTY_TIME;
>  }
>  
>  extern void inc_nlink(struct inode *inode);
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 1e23919c0da9..6e3ebecc95e9 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -15,7 +15,7 @@
>  		{I_DIRTY_DATASYNC,	"I_DIRTY_DATASYNC"},	\
>  		{I_DIRTY_PAGES,		"I_DIRTY_PAGES"},	\
>  		{I_NEW,			"I_NEW"},		\
> -		{I_WILL_FREE,		"I_WILL_FREE"},		\
> +		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
>  		{I_FREEING,		"I_FREEING"},		\
>  		{I_CLEAR,		"I_CLEAR"},		\
>  		{I_SYNC,		"I_SYNC"},		\
> @@ -27,7 +27,6 @@
>  		{I_CREATING,		"I_CREATING"},		\
>  		{I_DONTCACHE,		"I_DONTCACHE"},		\
>  		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
> -		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
>  		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
>  	)
>  
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 0bade2c5aa1d..7ffcd62324fa 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1290,13 +1290,13 @@ static void hook_sb_delete(struct super_block *const sb)
>  		 */
>  		spin_lock(&inode->i_lock);
>  		/*
> -		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
> -		 * condition when release_inode() just called iput(), which
> -		 * could lead to a NULL dereference of inode->security or a
> -		 * second call to iput() for the same Landlock object.  Also
> -		 * checks I_NEW because such inode cannot be tied to an object.
> +		 * Checks I_FREEING to protect against a race condition when
> +		 * release_inode() just called iput(), which could lead to a
> +		 * NULL dereference of inode->security or a second call to
> +		 * iput() for the same Landlock object.  Also checks I_NEW
> +		 * because such inode cannot be tied to an object.
>  		 */
> -		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +		if (inode->i_state & (I_FREEING | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -- 
> 2.43.0
> 
> 

