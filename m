Return-Path: <linux-fsdevel+bounces-61372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF3B57B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321ED3B6934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CB30BBB6;
	Mon, 15 Sep 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2DDYMFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D292E9EB9;
	Mon, 15 Sep 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940091; cv=none; b=fDV3gTuQIgV0YFplzDbsGCrEQsCg4zZcoM1DhevXBzlGq9tdYquOdNM9A2TlflOU3uLHid82QamKkhDTm9OS4wiEyFXA2FB+KgUYKhd5xw4gGkNBjGd+74KZrl0iMqKUIpjNcWWtwZf1Wa/GsoEFvE6EQWGCZXAjucz1/pKYObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940091; c=relaxed/simple;
	bh=d/Z4NxaPqA5HDvMKw8gD+elhlGBJ6ZM1a8NsV94/jvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1e0Ju974BL8ObmVpsHLgF0SbjQjJiOmaPF35MVS3Da8QpBTgODOXsR6c0HJRbUoCCtjyY+KzjoUeMIxgJDF5olq9ALSPLK+xj/1jR0DCv1M+069P+QBKh8/iA6lYyHl95zrNs8+GekCjGmJvTaJOrpgWO6ZigyPUo8jI5ewnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2DDYMFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27738C4CEF1;
	Mon, 15 Sep 2025 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940091;
	bh=d/Z4NxaPqA5HDvMKw8gD+elhlGBJ6ZM1a8NsV94/jvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2DDYMFXUOnDp2cX8y1Oa8y0nPm1Q5LB6wvkGtTTPW84hDhFPSkeGVlw2Uh2pUeK5
	 ZUy70ODT0Y+q0M7dS15Bl+TR4swR3VcWodkh/g2KJhfPTPxYhtEVp8Qaj9gI268jL/
	 BtbEt3mJlVG8rNe+UpNSoG8A5f+gqkscI1pV0uhIpFcH+JS366lePw6eI23mZ3r4VJ
	 hg3aTypnduIjvBJVusNI0Yvzn+MhRpLXqKgUDNzU/zY54LwznfsmCUlIvrpCINV/KG
	 dCWdl7KcJeSOr2ho+aUnVrGUx//QqS09awGond73Mdh/tBJpe90YkU79TsnYjK34AL
	 lhoE+rCVsdrSA==
Date: Mon, 15 Sep 2025 14:41:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/4] fs: hide ->i_state handling behind accessors
Message-ID: <20250915-erstflug-kassieren-37e5b3f5b998@brauner>
References: <20250911045557.1552002-1-mjguzik@gmail.com>
 <20250911045557.1552002-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911045557.1552002-3-mjguzik@gmail.com>

On Thu, Sep 11, 2025 at 06:55:55AM +0200, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

I would do:

inode_state()
inode_state_raw()

Similar to

rcu_derefence()
rcu_dereference_raw()

Otherwise this seems like a good overall start to me.

But you need some actual commit messages etc...

>  block/bdev.c                     |   4 +-
>  drivers/dax/super.c              |   2 +-
>  fs/buffer.c                      |   4 +-
>  fs/crypto/keyring.c              |   2 +-
>  fs/crypto/keysetup.c             |   2 +-
>  fs/dcache.c                      |   8 +-
>  fs/drop_caches.c                 |   2 +-
>  fs/fs-writeback.c                | 123 ++++++++++++++++---------------
>  fs/inode.c                       | 103 +++++++++++++-------------
>  fs/libfs.c                       |   6 +-
>  fs/namei.c                       |   8 +-
>  fs/notify/fsnotify.c             |   2 +-
>  fs/pipe.c                        |   2 +-
>  fs/quota/dquot.c                 |   2 +-
>  fs/sync.c                        |   2 +-
>  include/linux/backing-dev.h      |   5 +-
>  include/linux/fs.h               |  55 +++++++++++++-
>  include/linux/writeback.h        |   4 +-
>  include/trace/events/writeback.h |   8 +-
>  mm/backing-dev.c                 |   2 +-
>  security/landlock/fs.c           |   2 +-
>  21 files changed, 198 insertions(+), 150 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index b77ddd12dc06..77f04042ac67 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -67,7 +67,7 @@ static void bdev_write_inode(struct block_device *bdev)
>  	int ret;
>  
>  	spin_lock(&inode->i_lock);
> -	while (inode->i_state & I_DIRTY) {
> +	while (inode_state_read(inode) & I_DIRTY) {
>  		spin_unlock(&inode->i_lock);
>  		ret = write_inode_now(inode, true);
>  		if (ret)
> @@ -1265,7 +1265,7 @@ void sync_bdevs(bool wait)
>  		struct block_device *bdev;
>  
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
> +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW) ||
>  		    mapping->nrpages == 0) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 54c480e874cb..900e488105d3 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -433,7 +433,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
>  		return NULL;
>  
>  	dax_dev = to_dax_dev(inode);
> -	if (inode->i_state & I_NEW) {
> +	if (inode_state_read_unstable(inode) & I_NEW) {
>  		set_bit(DAXDEV_ALIVE, &dax_dev->flags);
>  		inode->i_cdev = &dax_dev->cdev;
>  		inode->i_mode = S_IFCHR;
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ead4dc85debd..b732842fb060 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -611,9 +611,9 @@ int generic_buffers_fsync_noflush(struct file *file, loff_t start, loff_t end,
>  		return err;
>  
>  	ret = sync_mapping_buffers(inode->i_mapping);
> -	if (!(inode->i_state & I_DIRTY_ALL))
> +	if (!(inode_state_read_unstable(inode) & I_DIRTY_ALL))
>  		goto out;
> -	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> +	if (datasync && !(inode_state_read_unstable(inode) & I_DIRTY_DATASYNC))
>  		goto out;
>  
>  	err = sync_inode_metadata(inode, 1);
> diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> index 7557f6a88b8f..34beb60bc24e 100644
> --- a/fs/crypto/keyring.c
> +++ b/fs/crypto/keyring.c
> @@ -957,7 +957,7 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
>  	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
>  		inode = ci->ci_inode;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index c1f85715c276..b801c47f5699 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -859,7 +859,7 @@ int fscrypt_drop_inode(struct inode *inode)
>  	 * userspace is still using the files, inodes can be dirtied between
>  	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
>  	 */
> -	if (inode->i_state & I_DIRTY_ALL)
> +	if (inode_state_read(inode) & I_DIRTY_ALL)
>  		return 0;
>  
>  	/*
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60046ae23d51..e01c8b678a6f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -794,7 +794,7 @@ void d_mark_dontcache(struct inode *inode)
>  		de->d_flags |= DCACHE_DONTCACHE;
>  		spin_unlock(&de->d_lock);
>  	}
> -	inode->i_state |= I_DONTCACHE;
> +	inode_state_add(inode, I_DONTCACHE);
>  	spin_unlock(&inode->i_lock);
>  }
>  EXPORT_SYMBOL(d_mark_dontcache);
> @@ -1073,7 +1073,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
>  	// used without having I_FREEING set, which means no aliases left
> -	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
> +	if (likely(!(inode_state_read(inode) & I_FREEING) && !hlist_empty(l))) {
>  		if (S_ISDIR(inode->i_mode)) {
>  			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
>  		} else {
> @@ -1980,8 +1980,8 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	security_d_instantiate(entry, inode);
>  	spin_lock(&inode->i_lock);
>  	__d_instantiate(entry, inode);
> -	WARN_ON(!(inode->i_state & I_NEW));
> -	inode->i_state &= ~I_NEW & ~I_CREATING;
> +	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	inode_state_del(inode, I_NEW | I_CREATING);
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
>  	 * ___wait_var_event() either sees the bit cleared or
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index 019a8b4eaaf9..73175ac2fe92 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -28,7 +28,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  		 * inodes without pages but we deliberately won't in case
>  		 * we need to reschedule to avoid softlockups.
>  		 */
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		if ((inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) ||
>  		    (mapping_empty(inode->i_mapping) && !need_resched())) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 6088a67b2aae..3ce3a636c061 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -121,7 +121,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
> -	WARN_ON_ONCE(inode->i_state & I_FREEING);
> +	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
>  
>  	list_move(&inode->i_io_list, head);
>  
> @@ -304,9 +304,9 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
> -	WARN_ON_ONCE(inode->i_state & I_FREEING);
> +	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
>  
> -	inode->i_state &= ~I_SYNC_QUEUED;
> +	inode_state_del(inode, I_SYNC_QUEUED);
>  	if (wb != &wb->bdi->wb)
>  		list_move(&inode->i_io_list, &wb->b_attached);
>  	else
> @@ -408,7 +408,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
>  	 * path owns the inode and we shouldn't modify ->i_io_list.
>  	 */
> -	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
> +	if (unlikely(inode_state_read(inode) & (I_FREEING | I_WILL_FREE)))
>  		goto skip_switch;
>  
>  	trace_inode_switch_wbs(inode, old_wb, new_wb);
> @@ -452,7 +452,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	if (!list_empty(&inode->i_io_list)) {
>  		inode->i_wb = new_wb;
>  
> -		if (inode->i_state & I_DIRTY_ALL) {
> +		if (inode_state_read(inode) & I_DIRTY_ALL) {
>  			struct inode *pos;
>  
>  			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
> @@ -475,10 +475,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  	switched = true;
>  skip_switch:
>  	/*
> -	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
> +	 * Paired with an acquire fence in unlocked_inode_to_wb_begin() and
>  	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
>  	 */
> -	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
> +	smp_wmb();
> +	inode_state_del(inode, I_WB_SWITCH);
>  
>  	xa_unlock_irq(&mapping->i_pages);
>  	spin_unlock(&inode->i_lock);
> @@ -560,12 +561,12 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
> -	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
> +	    inode_state_read(inode) & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
>  	    inode_to_wb(inode) == new_wb) {
>  		spin_unlock(&inode->i_lock);
>  		return false;
>  	}
> -	inode->i_state |= I_WB_SWITCH;
> +	inode_state_add(inode, I_WB_SWITCH);
>  	__iget(inode);
>  	spin_unlock(&inode->i_lock);
>  
> @@ -587,7 +588,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	struct inode_switch_wbs_context *isw;
>  
>  	/* noop if seems to be already in progress */
> -	if (inode->i_state & I_WB_SWITCH)
> +	if (inode_state_read_unstable(inode) & I_WB_SWITCH)
>  		return;
>  
>  	/* avoid queueing a new switch if too many are already in flight */
> @@ -1197,9 +1198,9 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
>  {
>  	assert_spin_locked(&wb->list_lock);
>  	assert_spin_locked(&inode->i_lock);
> -	WARN_ON_ONCE(inode->i_state & I_FREEING);
> +	WARN_ON_ONCE(inode_state_read(inode) & I_FREEING);
>  
> -	inode->i_state &= ~I_SYNC_QUEUED;
> +	inode_state_del(inode, I_SYNC_QUEUED);
>  	list_del_init(&inode->i_io_list);
>  	wb_io_lists_depopulated(wb);
>  }
> @@ -1312,7 +1313,7 @@ void inode_io_list_del(struct inode *inode)
>  	wb = inode_to_wb_and_lock_list(inode);
>  	spin_lock(&inode->i_lock);
>  
> -	inode->i_state &= ~I_SYNC_QUEUED;
> +	inode_state_del(inode, I_SYNC_QUEUED);
>  	list_del_init(&inode->i_io_list);
>  	wb_io_lists_depopulated(wb);
>  
> @@ -1370,13 +1371,13 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
>  {
>  	assert_spin_locked(&inode->i_lock);
>  
> -	inode->i_state &= ~I_SYNC_QUEUED;
> +	inode_state_del(inode, I_SYNC_QUEUED);
>  	/*
>  	 * When the inode is being freed just don't bother with dirty list
>  	 * tracking. Flush worker will ignore this inode anyway and it will
>  	 * trigger assertions in inode_io_list_move_locked().
>  	 */
> -	if (inode->i_state & I_FREEING) {
> +	if (inode_state_read(inode) & I_FREEING) {
>  		list_del_init(&inode->i_io_list);
>  		wb_io_lists_depopulated(wb);
>  		return;
> @@ -1410,7 +1411,7 @@ static void inode_sync_complete(struct inode *inode)
>  {
>  	assert_spin_locked(&inode->i_lock);
>  
> -	inode->i_state &= ~I_SYNC;
> +	inode_state_del(inode, I_SYNC);
>  	/* If inode is clean an unused, put it into LRU now... */
>  	inode_add_lru(inode);
>  	/* Called with inode->i_lock which ensures memory ordering. */
> @@ -1454,7 +1455,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		spin_lock(&inode->i_lock);
>  		list_move(&inode->i_io_list, &tmp);
>  		moved++;
> -		inode->i_state |= I_SYNC_QUEUED;
> +		inode_state_add(inode, I_SYNC_QUEUED);
>  		spin_unlock(&inode->i_lock);
>  		if (sb_is_blkdev_sb(inode->i_sb))
>  			continue;
> @@ -1540,14 +1541,14 @@ void inode_wait_for_writeback(struct inode *inode)
>  
>  	assert_spin_locked(&inode->i_lock);
>  
> -	if (!(inode->i_state & I_SYNC))
> +	if (!(inode_state_read(inode) & I_SYNC))
>  		return;
>  
>  	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
>  	for (;;) {
>  		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
>  		/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
> -		if (!(inode->i_state & I_SYNC))
> +		if (!(inode_state_read(inode) & I_SYNC))
>  			break;
>  		spin_unlock(&inode->i_lock);
>  		schedule();
> @@ -1573,7 +1574,7 @@ static void inode_sleep_on_writeback(struct inode *inode)
>  	wq_head = inode_bit_waitqueue(&wqe, inode, __I_SYNC);
>  	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
>  	/* Checking I_SYNC with inode->i_lock guarantees memory ordering. */
> -	sleep = !!(inode->i_state & I_SYNC);
> +	sleep = !!(inode_state_read(inode) & I_SYNC);
>  	spin_unlock(&inode->i_lock);
>  	if (sleep)
>  		schedule();
> @@ -1592,7 +1593,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  			  struct writeback_control *wbc,
>  			  unsigned long dirtied_before)
>  {
> -	if (inode->i_state & I_FREEING)
> +	if (inode_state_read(inode) & I_FREEING)
>  		return;
>  
>  	/*
> @@ -1600,7 +1601,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  	 * shot. If still dirty, it will be redirty_tail()'ed below.  Update
>  	 * the dirty time to prevent enqueue and sync it again.
>  	 */
> -	if ((inode->i_state & I_DIRTY) &&
> +	if ((inode_state_read(inode) & I_DIRTY) &&
>  	    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages))
>  		inode->dirtied_when = jiffies;
>  
> @@ -1611,7 +1612,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  		 * is odd for clean inodes, it can happen for some
>  		 * filesystems so handle that gracefully.
>  		 */
> -		if (inode->i_state & I_DIRTY_ALL)
> +		if (inode_state_read(inode) & I_DIRTY_ALL)
>  			redirty_tail_locked(inode, wb);
>  		else
>  			inode_cgwb_move_to_attached(inode, wb);
> @@ -1637,17 +1638,17 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  			 */
>  			redirty_tail_locked(inode, wb);
>  		}
> -	} else if (inode->i_state & I_DIRTY) {
> +	} else if (inode_state_read(inode) & I_DIRTY) {
>  		/*
>  		 * Filesystems can dirty the inode during writeback operations,
>  		 * such as delayed allocation during submission or metadata
>  		 * updates after data IO completion.
>  		 */
>  		redirty_tail_locked(inode, wb);
> -	} else if (inode->i_state & I_DIRTY_TIME) {
> +	} else if (inode_state_read(inode) & I_DIRTY_TIME) {
>  		inode->dirtied_when = jiffies;
>  		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
> -		inode->i_state &= ~I_SYNC_QUEUED;
> +		inode_state_del(inode, I_SYNC_QUEUED);
>  	} else {
>  		/* The inode is clean. Remove from writeback lists. */
>  		inode_cgwb_move_to_attached(inode, wb);
> @@ -1673,7 +1674,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	unsigned dirty;
>  	int ret;
>  
> -	WARN_ON(!(inode->i_state & I_SYNC));
> +	WARN_ON(!(inode_state_read_unstable(inode) & I_SYNC));
>  
>  	trace_writeback_single_inode_start(inode, wbc, nr_to_write);
>  
> @@ -1697,7 +1698,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	 * mark_inode_dirty_sync() to notify the filesystem about it and to
>  	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
>  	 */
> -	if ((inode->i_state & I_DIRTY_TIME) &&
> +	if ((inode_state_read_unstable(inode) & I_DIRTY_TIME) &&
>  	    (wbc->sync_mode == WB_SYNC_ALL ||
>  	     time_after(jiffies, inode->dirtied_time_when +
>  			dirtytime_expire_interval * HZ))) {
> @@ -1712,8 +1713,8 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	 * after handling timestamp expiration, as that may dirty the inode too.
>  	 */
>  	spin_lock(&inode->i_lock);
> -	dirty = inode->i_state & I_DIRTY;
> -	inode->i_state &= ~dirty;
> +	dirty = inode_state_read(inode) & I_DIRTY;
> +	inode_state_del(inode, dirty);
>  
>  	/*
>  	 * Paired with smp_mb() in __mark_inode_dirty().  This allows
> @@ -1729,10 +1730,10 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	smp_mb();
>  
>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> -		inode->i_state |= I_DIRTY_PAGES;
> -	else if (unlikely(inode->i_state & I_PINNING_NETFS_WB)) {
> -		if (!(inode->i_state & I_DIRTY_PAGES)) {
> -			inode->i_state &= ~I_PINNING_NETFS_WB;
> +		inode_state_add(inode, I_DIRTY_PAGES);
> +	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
> +		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
> +			inode_state_del(inode, I_PINNING_NETFS_WB);
>  			wbc->unpinned_netfs_wb = true;
>  			dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
>  		}
> @@ -1768,11 +1769,11 @@ static int writeback_single_inode(struct inode *inode,
>  
>  	spin_lock(&inode->i_lock);
>  	if (!icount_read(inode))
> -		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
> +		WARN_ON(!(inode_state_read(inode) & (I_WILL_FREE|I_FREEING)));
>  	else
> -		WARN_ON(inode->i_state & I_WILL_FREE);
> +		WARN_ON(inode_state_read(inode) & I_WILL_FREE);
>  
> -	if (inode->i_state & I_SYNC) {
> +	if (inode_state_read(inode) & I_SYNC) {
>  		/*
>  		 * Writeback is already running on the inode.  For WB_SYNC_NONE,
>  		 * that's enough and we can just return.  For WB_SYNC_ALL, we
> @@ -1783,7 +1784,7 @@ static int writeback_single_inode(struct inode *inode,
>  			goto out;
>  		inode_wait_for_writeback(inode);
>  	}
> -	WARN_ON(inode->i_state & I_SYNC);
> +	WARN_ON(inode_state_read(inode) & I_SYNC);
>  	/*
>  	 * If the inode is already fully clean, then there's nothing to do.
>  	 *
> @@ -1791,11 +1792,11 @@ static int writeback_single_inode(struct inode *inode,
>  	 * still under writeback, e.g. due to prior WB_SYNC_NONE writeback.  If
>  	 * there are any such pages, we'll need to wait for them.
>  	 */
> -	if (!(inode->i_state & I_DIRTY_ALL) &&
> +	if (!(inode_state_read(inode) & I_DIRTY_ALL) &&
>  	    (wbc->sync_mode != WB_SYNC_ALL ||
>  	     !mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK)))
>  		goto out;
> -	inode->i_state |= I_SYNC;
> +	inode_state_add(inode, I_SYNC);
>  	wbc_attach_and_unlock_inode(wbc, inode);
>  
>  	ret = __writeback_single_inode(inode, wbc);
> @@ -1808,18 +1809,18 @@ static int writeback_single_inode(struct inode *inode,
>  	 * If the inode is freeing, its i_io_list shoudn't be updated
>  	 * as it can be finally deleted at this moment.
>  	 */
> -	if (!(inode->i_state & I_FREEING)) {
> +	if (!(inode_state_read(inode) & I_FREEING)) {
>  		/*
>  		 * If the inode is now fully clean, then it can be safely
>  		 * removed from its writeback list (if any). Otherwise the
>  		 * flusher threads are responsible for the writeback lists.
>  		 */
> -		if (!(inode->i_state & I_DIRTY_ALL))
> +		if (!(inode_state_read(inode) & I_DIRTY_ALL))
>  			inode_cgwb_move_to_attached(inode, wb);
> -		else if (!(inode->i_state & I_SYNC_QUEUED)) {
> -			if ((inode->i_state & I_DIRTY))
> +		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
> +			if ((inode_state_read(inode) & I_DIRTY))
>  				redirty_tail_locked(inode, wb);
> -			else if (inode->i_state & I_DIRTY_TIME) {
> +			else if (inode_state_read(inode) & I_DIRTY_TIME) {
>  				inode->dirtied_when = jiffies;
>  				inode_io_list_move_locked(inode,
>  							  wb,
> @@ -1928,12 +1929,12 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 * kind writeout is handled by the freer.
>  		 */
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  			redirty_tail_locked(inode, wb);
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -		if ((inode->i_state & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
> +		if ((inode_state_read(inode) & I_SYNC) && wbc.sync_mode != WB_SYNC_ALL) {
>  			/*
>  			 * If this inode is locked for writeback and we are not
>  			 * doing writeback-for-data-integrity, move it to
> @@ -1955,14 +1956,14 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 * are doing WB_SYNC_NONE writeback. So this catches only the
>  		 * WB_SYNC_ALL case.
>  		 */
> -		if (inode->i_state & I_SYNC) {
> +		if (inode_state_read(inode) & I_SYNC) {
>  			/* Wait for I_SYNC. This function drops i_lock... */
>  			inode_sleep_on_writeback(inode);
>  			/* Inode may be gone, start again */
>  			spin_lock(&wb->list_lock);
>  			continue;
>  		}
> -		inode->i_state |= I_SYNC;
> +		inode_state_add(inode, I_SYNC);
>  		wbc_attach_and_unlock_inode(&wbc, inode);
>  
>  		write_chunk = writeback_chunk_size(wb, work);
> @@ -2000,7 +2001,7 @@ static long writeback_sb_inodes(struct super_block *sb,
>  		 */
>  		tmp_wb = inode_to_wb_and_lock_list(inode);
>  		spin_lock(&inode->i_lock);
> -		if (!(inode->i_state & I_DIRTY_ALL))
> +		if (!(inode_state_read(inode) & I_DIRTY_ALL))
>  			total_wrote++;
>  		requeue_inode(inode, tmp_wb, &wbc, dirtied_before);
>  		inode_sync_complete(inode);
> @@ -2506,10 +2507,10 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		 * We tell ->dirty_inode callback that timestamps need to
>  		 * be updated by setting I_DIRTY_TIME in flags.
>  		 */
> -		if (inode->i_state & I_DIRTY_TIME) {
> +		if (inode_state_read_unstable(inode) & I_DIRTY_TIME) {
>  			spin_lock(&inode->i_lock);
> -			if (inode->i_state & I_DIRTY_TIME) {
> -				inode->i_state &= ~I_DIRTY_TIME;
> +			if (inode_state_read(inode) & I_DIRTY_TIME) {
> +				inode_state_del(inode, I_DIRTY_TIME);
>  				flags |= I_DIRTY_TIME;
>  			}
>  			spin_unlock(&inode->i_lock);
> @@ -2546,16 +2547,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	 */
>  	smp_mb();
>  
> -	if ((inode->i_state & flags) == flags)
> +	if ((inode_state_read_unstable(inode) & flags) == flags)
>  		return;
>  
>  	spin_lock(&inode->i_lock);
> -	if ((inode->i_state & flags) != flags) {
> -		const int was_dirty = inode->i_state & I_DIRTY;
> +	if ((inode_state_read(inode) & flags) != flags) {
> +		const int was_dirty = inode_state_read(inode) & I_DIRTY;
>  
>  		inode_attach_wb(inode, NULL);
>  
> -		inode->i_state |= flags;
> +		inode_state_add(inode, flags);
>  
>  		/*
>  		 * Grab inode's wb early because it requires dropping i_lock and we
> @@ -2574,7 +2575,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  		 * the inode it will place it on the appropriate superblock
>  		 * list, based upon its state.
>  		 */
> -		if (inode->i_state & I_SYNC_QUEUED)
> +		if (inode_state_read(inode) & I_SYNC_QUEUED)
>  			goto out_unlock;
>  
>  		/*
> @@ -2585,7 +2586,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			if (inode_unhashed(inode))
>  				goto out_unlock;
>  		}
> -		if (inode->i_state & I_FREEING)
> +		if (inode_state_read(inode) & I_FREEING)
>  			goto out_unlock;
>  
>  		/*
> @@ -2600,7 +2601,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			if (dirtytime)
>  				inode->dirtied_time_when = jiffies;
>  
> -			if (inode->i_state & I_DIRTY)
> +			if (inode_state_read(inode) & I_DIRTY)
>  				dirty_list = &wb->b_dirty;
>  			else
>  				dirty_list = &wb->b_dirty_time;
> @@ -2696,7 +2697,7 @@ static void wait_sb_inodes(struct super_block *sb)
>  		spin_unlock_irq(&sb->s_inode_wblist_lock);
>  
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
> +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  
>  			spin_lock_irq(&sb->s_inode_wblist_lock);
> diff --git a/fs/inode.c b/fs/inode.c
> index e8c712211822..af9b7cf784d2 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -233,7 +233,7 @@ int inode_init_always_gfp(struct super_block *sb, struct inode *inode, gfp_t gfp
>  	inode->i_sb = sb;
>  	inode->i_blkbits = sb->s_blocksize_bits;
>  	inode->i_flags = 0;
> -	inode->i_state = 0;
> +	inode_state_set_unchecked(inode, 0);
>  	atomic64_set(&inode->i_sequence, 0);
>  	atomic_set(&inode->i_count, 1);
>  	inode->i_op = &empty_iops;
> @@ -471,7 +471,7 @@ EXPORT_SYMBOL(set_nlink);
>  void inc_nlink(struct inode *inode)
>  {
>  	if (unlikely(inode->i_nlink == 0)) {
> -		WARN_ON(!(inode->i_state & I_LINKABLE));
> +		WARN_ON(!(inode_state_read_unstable(inode) & I_LINKABLE));
>  		atomic_long_dec(&inode->i_sb->s_remove_count);
>  	}
>  
> @@ -532,7 +532,7 @@ EXPORT_SYMBOL(ihold);
>  
>  static void __inode_add_lru(struct inode *inode, bool rotate)
>  {
> -	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
> +	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
>  		return;
>  	if (icount_read(inode))
>  		return;
> @@ -544,7 +544,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
>  		this_cpu_inc(nr_unused);
>  	else if (rotate)
> -		inode->i_state |= I_REFERENCED;
> +		inode_state_add(inode, I_REFERENCED);
>  }
>  
>  struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> @@ -577,15 +577,15 @@ static void inode_lru_list_del(struct inode *inode)
>  static void inode_pin_lru_isolating(struct inode *inode)
>  {
>  	lockdep_assert_held(&inode->i_lock);
> -	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
> -	inode->i_state |= I_LRU_ISOLATING;
> +	WARN_ON(inode_state_read(inode) & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
> +	inode_state_add(inode, I_LRU_ISOLATING);
>  }
>  
>  static void inode_unpin_lru_isolating(struct inode *inode)
>  {
>  	spin_lock(&inode->i_lock);
> -	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
> -	inode->i_state &= ~I_LRU_ISOLATING;
> +	WARN_ON(!(inode_state_read(inode) & I_LRU_ISOLATING));
> +	inode_state_del(inode, I_LRU_ISOLATING);
>  	/* Called with inode->i_lock which ensures memory ordering. */
>  	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
>  	spin_unlock(&inode->i_lock);
> @@ -597,7 +597,7 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
>  	struct wait_queue_head *wq_head;
>  
>  	lockdep_assert_held(&inode->i_lock);
> -	if (!(inode->i_state & I_LRU_ISOLATING))
> +	if (!(inode_state_read(inode) & I_LRU_ISOLATING))
>  		return;
>  
>  	wq_head = inode_bit_waitqueue(&wqe, inode, __I_LRU_ISOLATING);
> @@ -607,14 +607,14 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
>  		 * Checking I_LRU_ISOLATING with inode->i_lock guarantees
>  		 * memory ordering.
>  		 */
> -		if (!(inode->i_state & I_LRU_ISOLATING))
> +		if (!(inode_state_read(inode) & I_LRU_ISOLATING))
>  			break;
>  		spin_unlock(&inode->i_lock);
>  		schedule();
>  		spin_lock(&inode->i_lock);
>  	}
>  	finish_wait(wq_head, &wqe.wq_entry);
> -	WARN_ON(inode->i_state & I_LRU_ISOLATING);
> +	WARN_ON(inode_state_read(inode) & I_LRU_ISOLATING);
>  }
>  
>  /**
> @@ -761,11 +761,11 @@ void clear_inode(struct inode *inode)
>  	 */
>  	xa_unlock_irq(&inode->i_data.i_pages);
>  	BUG_ON(!list_empty(&inode->i_data.i_private_list));
> -	BUG_ON(!(inode->i_state & I_FREEING));
> -	BUG_ON(inode->i_state & I_CLEAR);
> +	BUG_ON(!(inode_state_read_unstable(inode) & I_FREEING));
> +	BUG_ON(inode_state_read_unstable(inode) & I_CLEAR);
>  	BUG_ON(!list_empty(&inode->i_wb_list));
>  	/* don't need i_lock here, no concurrent mods to i_state */
> -	inode->i_state = I_FREEING | I_CLEAR;
> +	inode_state_set_unchecked(inode, I_FREEING | I_CLEAR);
>  }
>  EXPORT_SYMBOL(clear_inode);
>  
> @@ -786,7 +786,7 @@ static void evict(struct inode *inode)
>  {
>  	const struct super_operations *op = inode->i_sb->s_op;
>  
> -	BUG_ON(!(inode->i_state & I_FREEING));
> +	BUG_ON(!(inode_state_read_unstable(inode) & I_FREEING));
>  	BUG_ON(!list_empty(&inode->i_lru));
>  
>  	if (!list_empty(&inode->i_io_list))
> @@ -829,7 +829,7 @@ static void evict(struct inode *inode)
>  	 * This also means we don't need any fences for the call below.
>  	 */
>  	inode_wake_up_bit(inode, __I_NEW);
> -	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
> +	BUG_ON(inode_state_read_unstable(inode) != (I_FREEING | I_CLEAR));
>  
>  	destroy_inode(inode);
>  }
> @@ -879,12 +879,12 @@ void evict_inodes(struct super_block *sb)
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
> +		if (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
>  
> -		inode->i_state |= I_FREEING;
> +		inode_state_add(inode, I_FREEING);
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		list_add(&inode->i_lru, &dispose);
> @@ -938,7 +938,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	 * sync, or the last page cache deletion will requeue them.
>  	 */
>  	if (icount_read(inode) ||
> -	    (inode->i_state & ~I_REFERENCED) ||
> +	    (inode_state_read(inode) & ~I_REFERENCED) ||
>  	    !mapping_shrinkable(&inode->i_data)) {
>  		list_lru_isolate(lru, &inode->i_lru);
>  		spin_unlock(&inode->i_lock);
> @@ -947,8 +947,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	}
>  
>  	/* Recently referenced inodes get one more pass */
> -	if (inode->i_state & I_REFERENCED) {
> -		inode->i_state &= ~I_REFERENCED;
> +	if (inode_state_read(inode) & I_REFERENCED) {
> +		inode_state_del(inode, I_REFERENCED);
>  		spin_unlock(&inode->i_lock);
>  		return LRU_ROTATE;
>  	}
> @@ -975,8 +975,8 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  		return LRU_RETRY;
>  	}
>  
> -	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state |= I_FREEING;
> +	WARN_ON(inode_state_read(inode) & I_NEW);
> +	inode_state_add(inode, I_FREEING);
>  	list_lru_isolate_move(lru, &inode->i_lru, freeable);
>  	spin_unlock(&inode->i_lock);
>  
> @@ -1025,11 +1025,11 @@ static struct inode *find_inode(struct super_block *sb,
>  		if (!test(inode, data))
>  			continue;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE)) {
>  			__wait_on_freeing_inode(inode, is_inode_hash_locked);
>  			goto repeat;
>  		}
> -		if (unlikely(inode->i_state & I_CREATING)) {
> +		if (unlikely(inode_state_read(inode) & I_CREATING)) {
>  			spin_unlock(&inode->i_lock);
>  			rcu_read_unlock();
>  			return ERR_PTR(-ESTALE);
> @@ -1066,11 +1066,11 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  		if (inode->i_sb != sb)
>  			continue;
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE)) {
>  			__wait_on_freeing_inode(inode, is_inode_hash_locked);
>  			goto repeat;
>  		}
> -		if (unlikely(inode->i_state & I_CREATING)) {
> +		if (unlikely(inode_state_read(inode) & I_CREATING)) {
>  			spin_unlock(&inode->i_lock);
>  			rcu_read_unlock();
>  			return ERR_PTR(-ESTALE);
> @@ -1180,8 +1180,8 @@ void unlock_new_inode(struct inode *inode)
>  {
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
> -	WARN_ON(!(inode->i_state & I_NEW));
> -	inode->i_state &= ~I_NEW & ~I_CREATING;
> +	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	inode_state_del(inode, I_NEW | I_CREATING);
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
>  	 * ___wait_var_event() either sees the bit cleared or
> @@ -1197,8 +1197,8 @@ void discard_new_inode(struct inode *inode)
>  {
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
> -	WARN_ON(!(inode->i_state & I_NEW));
> -	inode->i_state &= ~I_NEW;
> +	WARN_ON(!(inode_state_read(inode) & I_NEW));
> +	inode_state_del(inode, I_NEW);
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
>  	 * ___wait_var_event() either sees the bit cleared or
> @@ -1308,7 +1308,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  	 * caller is responsible for filling in the contents
>  	 */
>  	spin_lock(&inode->i_lock);
> -	inode->i_state |= I_NEW;
> +	inode_state_add(inode, I_NEW);
>  	hlist_add_head_rcu(&inode->i_hash, head);
>  	spin_unlock(&inode->i_lock);
>  
> @@ -1445,7 +1445,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  		if (!old) {
>  			inode->i_ino = ino;
>  			spin_lock(&inode->i_lock);
> -			inode->i_state = I_NEW;
> +			inode_state_add(inode, I_NEW);
>  			hlist_add_head_rcu(&inode->i_hash, head);
>  			spin_unlock(&inode->i_lock);
>  			spin_unlock(&inode_hash_lock);
> @@ -1538,7 +1538,7 @@ EXPORT_SYMBOL(iunique);
>  struct inode *igrab(struct inode *inode)
>  {
>  	spin_lock(&inode->i_lock);
> -	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
> +	if (!(inode_state_read(inode) & (I_FREEING|I_WILL_FREE))) {
>  		__iget(inode);
>  		spin_unlock(&inode->i_lock);
>  	} else {
> @@ -1728,7 +1728,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
>  
>  	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_sb == sb &&
> -		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
> +		    !(inode_state_read_unstable(inode) & (I_FREEING | I_WILL_FREE)) &&
>  		    test(inode, data))
>  			return inode;
>  	}
> @@ -1767,7 +1767,7 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
>  	hlist_for_each_entry_rcu(inode, head, i_hash) {
>  		if (inode->i_ino == ino &&
>  		    inode->i_sb == sb &&
> -		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
> +		    !(inode_state_read_unstable(inode) & (I_FREEING | I_WILL_FREE)))
>  		    return inode;
>  	}
>  	return NULL;
> @@ -1789,7 +1789,7 @@ int insert_inode_locked(struct inode *inode)
>  			if (old->i_sb != sb)
>  				continue;
>  			spin_lock(&old->i_lock);
> -			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
> +			if (inode_state_read(old) & (I_FREEING|I_WILL_FREE)) {
>  				spin_unlock(&old->i_lock);
>  				continue;
>  			}
> @@ -1797,13 +1797,13 @@ int insert_inode_locked(struct inode *inode)
>  		}
>  		if (likely(!old)) {
>  			spin_lock(&inode->i_lock);
> -			inode->i_state |= I_NEW | I_CREATING;
> +			inode_state_add(inode, I_NEW | I_CREATING);
>  			hlist_add_head_rcu(&inode->i_hash, head);
>  			spin_unlock(&inode->i_lock);
>  			spin_unlock(&inode_hash_lock);
>  			return 0;
>  		}
> -		if (unlikely(old->i_state & I_CREATING)) {
> +		if (unlikely(inode_state_read(old) & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
>  			spin_unlock(&inode_hash_lock);
>  			return -EBUSY;
> @@ -1826,7 +1826,7 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
>  {
>  	struct inode *old;
>  
> -	inode->i_state |= I_CREATING;
> +	inode_state_add_unchecked(inode, I_CREATING);
>  	old = inode_insert5(inode, hashval, test, NULL, data);
>  
>  	if (old != inode) {
> @@ -1858,10 +1858,9 @@ static void iput_final(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	const struct super_operations *op = inode->i_sb->s_op;
> -	unsigned long state;
>  	int drop;
>  
> -	WARN_ON(inode->i_state & I_NEW);
> +	WARN_ON(inode_state_read(inode) & I_NEW);
>  
>  	if (op->drop_inode)
>  		drop = op->drop_inode(inode);
> @@ -1869,27 +1868,25 @@ static void iput_final(struct inode *inode)
>  		drop = generic_drop_inode(inode);
>  
>  	if (!drop &&
> -	    !(inode->i_state & I_DONTCACHE) &&
> +	    !(inode_state_read(inode) & I_DONTCACHE) &&
>  	    (sb->s_flags & SB_ACTIVE)) {
>  		__inode_add_lru(inode, true);
>  		spin_unlock(&inode->i_lock);
>  		return;
>  	}
>  
> -	state = inode->i_state;
>  	if (!drop) {
> -		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> +		inode_state_add(inode, I_WILL_FREE);
>  		spin_unlock(&inode->i_lock);
>  
>  		write_inode_now(inode, 1);
>  
>  		spin_lock(&inode->i_lock);
> -		state = inode->i_state;
> -		WARN_ON(state & I_NEW);
> -		state &= ~I_WILL_FREE;
> +		inode_state_del(inode, I_WILL_FREE);
> +		WARN_ON(inode_state_read(inode) & I_NEW);
>  	}
>  
> -	WRITE_ONCE(inode->i_state, state | I_FREEING);
> +	inode_state_add(inode, I_FREEING);
>  	if (!list_empty(&inode->i_lru))
>  		inode_lru_list_del(inode);
>  	spin_unlock(&inode->i_lock);
> @@ -1913,7 +1910,7 @@ void iput(struct inode *inode)
>  
>  retry:
>  	lockdep_assert_not_held(&inode->i_lock);
> -	VFS_BUG_ON_INODE(inode->i_state & I_CLEAR, inode);
> +	VFS_BUG_ON_INODE(inode_state_read_unstable(inode) & I_CLEAR, inode);
>  	/*
>  	 * Note this assert is technically racy as if the count is bogusly
>  	 * equal to one, then two CPUs racing to further drop it can both
> @@ -1924,14 +1921,14 @@ void iput(struct inode *inode)
>  	if (atomic_add_unless(&inode->i_count, -1, 1))
>  		return;
>  
> -	if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
> +	if ((inode_state_read_unstable(inode) & I_DIRTY_TIME) && inode->i_nlink) {
>  		trace_writeback_lazytime_iput(inode);
>  		mark_inode_dirty_sync(inode);
>  		goto retry;
>  	}
>  
>  	spin_lock(&inode->i_lock);
> -	if (unlikely((inode->i_state & I_DIRTY_TIME) && inode->i_nlink)) {
> +	if (unlikely((inode_state_read(inode) & I_DIRTY_TIME) && inode->i_nlink)) {
>  		spin_unlock(&inode->i_lock);
>  		goto retry;
>  	}
> @@ -2946,7 +2943,7 @@ void dump_inode(struct inode *inode, const char *reason)
>  	pr_warn("%s encountered for inode %px\n"
>  		"fs %s mode %ho opflags %hx flags %u state %x\n",
>  		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
> -		inode->i_flags, inode->i_state);
> +		inode->i_flags, inode_state_read_unstable(inode));
>  }
>  
>  EXPORT_SYMBOL(dump_inode);
> diff --git a/fs/libfs.c b/fs/libfs.c
> index ce8c496a6940..469ca3314889 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1542,9 +1542,9 @@ int __generic_file_fsync(struct file *file, loff_t start, loff_t end,
>  
>  	inode_lock(inode);
>  	ret = sync_mapping_buffers(inode->i_mapping);
> -	if (!(inode->i_state & I_DIRTY_ALL))
> +	if (!(inode_state_read_unstable(inode) & I_DIRTY_ALL))
>  		goto out;
> -	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> +	if (datasync && !(inode_state_read_unstable(inode) & I_DIRTY_DATASYNC))
>  		goto out;
>  
>  	err = sync_inode_metadata(inode, 1);
> @@ -1664,7 +1664,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
>  	 * list because mark_inode_dirty() will think
>  	 * that it already _is_ on the dirty list.
>  	 */
> -	inode->i_state = I_DIRTY;
> +	inode_state_set_unchecked(inode, I_DIRTY);
>  	/*
>  	 * Historically anonymous inodes don't have a type at all and
>  	 * userspace has come to rely on this.
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa..b0742d7376d5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3948,7 +3948,7 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>  	inode = file_inode(file);
>  	if (!(open_flag & O_EXCL)) {
>  		spin_lock(&inode->i_lock);
> -		inode->i_state |= I_LINKABLE;
> +		inode_state_add(inode, I_LINKABLE);
>  		spin_unlock(&inode->i_lock);
>  	}
>  	security_inode_post_create_tmpfile(idmap, inode);
> @@ -4844,7 +4844,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  
>  	inode_lock(inode);
>  	/* Make sure we don't allow creating hardlink to an unlinked file */
> -	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
> +	if (inode->i_nlink == 0 && !(inode_state_read_unstable(inode) & I_LINKABLE))
>  		error =  -ENOENT;
>  	else if (max_links && inode->i_nlink >= max_links)
>  		error = -EMLINK;
> @@ -4854,9 +4854,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  			error = dir->i_op->link(old_dentry, dir, new_dentry);
>  	}
>  
> -	if (!error && (inode->i_state & I_LINKABLE)) {
> +	if (!error && (inode_state_read_unstable(inode) & I_LINKABLE)) {
>  		spin_lock(&inode->i_lock);
> -		inode->i_state &= ~I_LINKABLE;
> +		inode_state_del(inode, I_LINKABLE);
>  		spin_unlock(&inode->i_lock);
>  	}
>  	inode_unlock(inode);
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 46bfc543f946..8e504b40fb39 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -52,7 +52,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
>  		 * the inode cannot have any associated watches.
>  		 */
>  		spin_lock(&inode->i_lock);
> -		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
> +		if (inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 731622d0738d..81ad740af963 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -906,7 +906,7 @@ static struct inode * get_pipe_inode(void)
>  	 * list because "mark_inode_dirty()" will think
>  	 * that it already _is_ on the dirty list.
>  	 */
> -	inode->i_state = I_DIRTY;
> +	inode_state_set_unchecked(inode, I_DIRTY);
>  	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
>  	inode->i_uid = current_fsuid();
>  	inode->i_gid = current_fsgid();
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index df4a9b348769..beb3d82a2915 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -1030,7 +1030,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		spin_lock(&inode->i_lock);
> -		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		if ((inode_state_read(inode) & (I_FREEING|I_WILL_FREE|I_NEW)) ||
>  		    !atomic_read(&inode->i_writecount) ||
>  		    !dqinit_needed(inode, type)) {
>  			spin_unlock(&inode->i_lock);
> diff --git a/fs/sync.c b/fs/sync.c
> index 2955cd4c77a3..def938b28c2a 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -182,7 +182,7 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
>  
>  	if (!file->f_op->fsync)
>  		return -EINVAL;
> -	if (!datasync && (inode->i_state & I_DIRTY_TIME))
> +	if (!datasync && (inode_state_read_unstable(inode) & I_DIRTY_TIME))
>  		mark_inode_dirty_sync(inode);
>  	return file->f_op->fsync(file, start, end, datasync);
>  }
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index e721148c95d0..4f461eb4232a 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -289,10 +289,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
>  	rcu_read_lock();
>  
>  	/*
> -	 * Paired with store_release in inode_switch_wbs_work_fn() and
> +	 * Paired with a release fence in inode_do_switch_wbs() and
>  	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
>  	 */
> -	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
> +	cookie->locked = inode_state_read_unstable(inode) & I_WB_SWITCH;
> +	smp_rmb();
>  
>  	if (unlikely(cookie->locked))
>  		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c4fd010cf5bf..ed482e5d14a6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -756,7 +756,7 @@ enum inode_state_bits {
>  	/* reserved wait address bit 3 */
>  };
>  
> -enum inode_state_flags_t {
> +enum inode_state_flags_enum {
>  	I_NEW			= (1U << __I_NEW),
>  	I_SYNC			= (1U << __I_SYNC),
>  	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
> @@ -840,7 +840,7 @@ struct inode {
>  #endif
>  
>  	/* Misc */
> -	enum inode_state_flags_t	i_state;
> +	enum inode_state_flags_enum i_state;
>  	/* 32-bit hole */
>  	struct rw_semaphore	i_rwsem;
>  
> @@ -899,6 +899,55 @@ struct inode {
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> +
> +/*
> + * i_state handling
> + *
> + * We hide all of it behind helpers so that we can validate consumers.
> + */
> +static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	return inode->i_state;
> +}
> +
> +static inline enum inode_state_flags_enum inode_state_read_unstable(struct inode *inode)
> +{
> +	return READ_ONCE(inode->i_state);
> +}
> +
> +static inline void inode_state_add(struct inode *inode,
> +				   enum inode_state_flags_enum newflags)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	WRITE_ONCE(inode->i_state, inode->i_state | newflags);
> +}
> +
> +static inline void inode_state_add_unchecked(struct inode *inode,
> +					     enum inode_state_flags_enum newflags)
> +{
> +	WRITE_ONCE(inode->i_state, inode->i_state | newflags);
> +}
> +
> +static inline void inode_state_del(struct inode *inode,
> +				   enum inode_state_flags_enum rmflags)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +	WRITE_ONCE(inode->i_state, inode->i_state & ~rmflags);
> +}
> +
> +static inline void inode_state_del_unchecked(struct inode *inode,
> +					     enum inode_state_flags_enum rmflags)
> +{
> +	WRITE_ONCE(inode->i_state, inode->i_state & ~rmflags);
> +}
> +
> +static inline void inode_state_set_unchecked(struct inode *inode,
> +					     enum inode_state_flags_enum newflags)
> +{
> +	WRITE_ONCE(inode->i_state, newflags);
> +}
> +
>  static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
>  {
>  	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
> @@ -2627,7 +2676,7 @@ static inline int icount_read(const struct inode *inode)
>   */
>  static inline bool inode_is_dirtytime_only(struct inode *inode)
>  {
> -	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
> +	return (inode_state_read_unstable(inode) & (I_DIRTY_TIME | I_NEW |
>  				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
>  }
>  
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index a2848d731a46..c24b581ed61f 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -193,7 +193,7 @@ void inode_io_list_del(struct inode *inode);
>  static inline void wait_on_inode(struct inode *inode)
>  {
>  	wait_var_event(inode_state_wait_address(inode, __I_NEW),
> -		       !(READ_ONCE(inode->i_state) & I_NEW));
> +		       !(inode_state_read_unstable(inode) & I_NEW));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -234,7 +234,7 @@ static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
>  static inline void inode_detach_wb(struct inode *inode)
>  {
>  	if (inode->i_wb) {
> -		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
> +		WARN_ON_ONCE(!(inode_state_read_unstable(inode) & I_CLEAR));
>  		wb_put(inode->i_wb);
>  		inode->i_wb = NULL;
>  	}
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 1e23919c0da9..a6efa3ad37a9 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -120,7 +120,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  		/* may be called for files on pseudo FSes w/ unregistered bdi */
>  		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
>  		__entry->ino		= inode->i_ino;
> -		__entry->state		= inode->i_state;
> +		__entry->state		= inode_state_read_unstable(inode);
>  		__entry->flags		= flags;
>  	),
>  
> @@ -719,7 +719,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		strscpy_pad(__entry->name,
>  			    bdi_dev_name(inode_to_bdi(inode)), 32);
>  		__entry->ino		= inode->i_ino;
> -		__entry->state		= inode->i_state;
> +		__entry->state		= inode_state_read_unstable(inode);
>  		__entry->dirtied_when	= inode->dirtied_when;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
>  	),
> @@ -758,7 +758,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  		strscpy_pad(__entry->name,
>  			    bdi_dev_name(inode_to_bdi(inode)), 32);
>  		__entry->ino		= inode->i_ino;
> -		__entry->state		= inode->i_state;
> +		__entry->state		= inode_state_read_unstable(inode);
>  		__entry->dirtied_when	= inode->dirtied_when;
>  		__entry->writeback_index = inode->i_mapping->writeback_index;
>  		__entry->nr_to_write	= nr_to_write;
> @@ -810,7 +810,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->ino	= inode->i_ino;
> -		__entry->state	= inode->i_state;
> +		__entry->state	= inode_state_read_unstable(inode);
>  		__entry->mode	= inode->i_mode;
>  		__entry->dirtied_when = inode->dirtied_when;
>  	),
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 783904d8c5ef..0636abae1c5c 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -72,7 +72,7 @@ static void collect_wb_stats(struct wb_stats *stats,
>  	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
>  		stats->nr_more_io++;
>  	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
> -		if (inode->i_state & I_DIRTY_TIME)
> +		if (inode_state_read_unstable(inode) & I_DIRTY_TIME)
>  			stats->nr_dirty_time++;
>  	spin_unlock(&wb->list_lock);
>  
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 0bade2c5aa1d..d4d72f406d58 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1296,7 +1296,7 @@ static void hook_sb_delete(struct super_block *const sb)
>  		 * second call to iput() for the same Landlock object.  Also
>  		 * checks I_NEW because such inode cannot be tied to an object.
>  		 */
> -		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
> +		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> -- 
> 2.43.0
> 

