Return-Path: <linux-fsdevel+bounces-69705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0DC81F98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 18:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3853ABF42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271082C21FC;
	Mon, 24 Nov 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElwnE9O+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1372C0F84
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006477; cv=none; b=Ehu2FAJQlQJlh1KoabqeojXhpavlG+EwwobwkNG21MB4oIjjEW72qG4AOlA5ll/IB+DcNyu6hwDsvojVfkRTvpDy++qVVjaER5H+aJMnyuBa9yTgJH5EY3rWRIkkTPELVIqDH8jbNgCrK0deEkZTOgBXNZbsbDLP3IYQeY3YoTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006477; c=relaxed/simple;
	bh=RRyoWBhG4aeoyKol2E0QwtTfKHwXuv8OtDqO10qKodk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVJ85YUBEcIekzaT5TJqHRuvHvN0CqvKGd1GenhSluAwVly+taHL/RIOt9ETGwDEAQ+rsHoJDa3aDi5vFw4OcKcNemJuPKEhi3MkdN2TOtAux1DxzQe1aMlyDv1MrQduhsPvdJ3GtQvCBdOdQGgjoAB6ZyoU8Sc/NgHVh77ndzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElwnE9O+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764006473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZkMRQxqkvy3Zd/wGTKo2Jr0NjJcWSyxfFS6BXTUz60=;
	b=ElwnE9O+hs7ERuln8k6Wf6ZmQ9qiS2mRY3xkKRvbS3sO0WLQssmThyZ6LKu9zQ+37pNKIw
	4mdnwrMWqW9KiUja/S3Qi6EVKKk+vTyqDCTMfaEDz9esr2spyzT+8XVgUmL4blSzcGyeYI
	UuY1uOiLbDyTPJg0UxxUQwP+cOOfWaA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-Y_1a_ofcNraI4BYiYeYYzQ-1; Mon,
 24 Nov 2025 12:47:49 -0500
X-MC-Unique: Y_1a_ofcNraI4BYiYeYYzQ-1
X-Mimecast-MFC-AGG-ID: Y_1a_ofcNraI4BYiYeYYzQ_1764006468
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2954E195606B;
	Mon, 24 Nov 2025 17:47:46 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCBD81800297;
	Mon, 24 Nov 2025 17:47:43 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
Date: Mon, 24 Nov 2025 17:47:41 +0000
Message-ID: <20251124174742.2939610-1-agruenba@redhat.com>
In-Reply-To: <20251010221737.1403539-1-mjguzik@gmail.com>
References: <20251010221737.1403539-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Oct 11, 2025 at 12:17 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> In the inode hash code grab the state while ->i_lock is held. If found
> to be set, synchronize the sleep once more with the lock held.
> 
> In the real world the flag is not set most of the time.
> 
> Apart from being simpler to reason about, it comes with a minor speed up
> as now clearing the flag does not require the smp_mb() fence.
> 
> While here rename wait_on_inode() to wait_on_new_inode() to line it up
> with __wait_on_freeing_inode().
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> This temporarily duplicated sleep code from inode_wait_for_lru_isolating().
> This is going to get dedupped later.
> 
> There is high repetition of:
> 	if (unlikely(isnew)) {
> 		wait_on_new_inode(old);
> 		if (unlikely(inode_unhashed(old))) {
> 			iput(old);
> 			goto again;
> 		}
> 
> I expect this is going to go away after I post a patch to sanitize the
> current APIs for the hash.
> 
> 
>  fs/afs/dir.c       |   4 +-
>  fs/dcache.c        |  10 ----
>  fs/gfs2/glock.c    |   2 +-
>  fs/inode.c         | 146 +++++++++++++++++++++++++++------------------
>  include/linux/fs.h |  12 +---
>  5 files changed, 93 insertions(+), 81 deletions(-)
> 
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 89d36e3e5c79..f4e9e12373ac 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -779,7 +779,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
>  	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
>  	struct inode *inode = NULL, *ti;
>  	afs_dataversion_t data_version = READ_ONCE(dvnode->status.data_version);
> -	bool supports_ibulk;
> +	bool supports_ibulk, isnew;
>  	long ret;
>  	int i;
>  
> @@ -850,7 +850,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
>  			 * callback counters.
>  			 */
>  			ti = ilookup5_nowait(dir->i_sb, vp->fid.vnode,
> -					     afs_ilookup5_test_by_fid, &vp->fid);
> +					     afs_ilookup5_test_by_fid, &vp->fid, &isnew);
>  			if (!IS_ERR_OR_NULL(ti)) {
>  				vnode = AFS_FS_I(ti);
>  				vp->dv_before = vnode->status.data_version;
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 78ffa7b7e824..25131f105a60 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1981,17 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	__d_instantiate(entry, inode);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> -	/*
> -	 * Pairs with smp_rmb in wait_on_inode().
> -	 */
> -	smp_wmb();
>  	inode_state_clear(inode, I_NEW | I_CREATING);
> -	/*
> -	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> -	 * ___wait_var_event() either sees the bit cleared or
> -	 * waitqueue_active() check in wake_up_var() sees the waiter.
> -	 */
> -	smp_mb();
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);
>  }
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index b677c0e6b9ab..c9712235e7a0 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -957,7 +957,7 @@ static struct gfs2_inode *gfs2_grab_existing_inode(struct gfs2_glock *gl)
>  		ip = NULL;
>  	spin_unlock(&gl->gl_lockref.lock);
>  	if (ip) {
> -		wait_on_inode(&ip->i_inode);
> +		wait_on_new_inode(&ip->i_inode);
>  		if (is_bad_inode(&ip->i_inode)) {
>  			iput(&ip->i_inode);
>  			ip = NULL;
> diff --git a/fs/inode.c b/fs/inode.c
> index 3153d725859c..1396f79b2551 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -558,6 +558,32 @@ struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
>  }
>  EXPORT_SYMBOL(inode_bit_waitqueue);
>  
> +void wait_on_new_inode(struct inode *inode)
> +{
> +	struct wait_bit_queue_entry wqe;
> +	struct wait_queue_head *wq_head;
> +
> +	spin_lock(&inode->i_lock);
> +	if (!(inode_state_read(inode) & I_NEW)) {
> +		spin_unlock(&inode->i_lock);
> +		return;
> +	}
> +
> +	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
> +	for (;;) {
> +		prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
> +		if (!(inode_state_read(inode) & I_NEW))
> +			break;
> +		spin_unlock(&inode->i_lock);
> +		schedule();
> +		spin_lock(&inode->i_lock);
> +	}
> +	finish_wait(wq_head, &wqe.wq_entry);
> +	WARN_ON(inode_state_read(inode) & I_NEW);
> +	spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL(wait_on_new_inode);
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
>   *
> @@ -1008,7 +1034,8 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
>  static struct inode *find_inode(struct super_block *sb,
>  				struct hlist_head *head,
>  				int (*test)(struct inode *, void *),
> -				void *data, bool is_inode_hash_locked)
> +				void *data, bool is_inode_hash_locked,
> +				bool *isnew)
>  {
>  	struct inode *inode = NULL;
>  
> @@ -1035,6 +1062,7 @@ static struct inode *find_inode(struct super_block *sb,
>  			return ERR_PTR(-ESTALE);
>  		}
>  		__iget(inode);
> +		*isnew = !!(inode_state_read(inode) & I_NEW);

Nit: the not-nots here and in the other two places in this patch are not
doing anything.  Please avoid that kind of thing.

>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
>  		return inode;
> @@ -1049,7 +1077,7 @@ static struct inode *find_inode(struct super_block *sb,
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
>  				struct hlist_head *head, unsigned long ino,
> -				bool is_inode_hash_locked)
> +				bool is_inode_hash_locked, bool *isnew)
>  {
>  	struct inode *inode = NULL;
>  
> @@ -1076,6 +1104,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  			return ERR_PTR(-ESTALE);
>  		}
>  		__iget(inode);
> +		*isnew = !!(inode_state_read(inode) & I_NEW);
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
>  		return inode;
> @@ -1181,17 +1210,7 @@ void unlock_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> -	/*
> -	 * Pairs with smp_rmb in wait_on_inode().
> -	 */
> -	smp_wmb();
>  	inode_state_clear(inode, I_NEW | I_CREATING);
> -	/*
> -	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> -	 * ___wait_var_event() either sees the bit cleared or
> -	 * waitqueue_active() check in wake_up_var() sees the waiter.
> -	 */
> -	smp_mb();
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);
>  }
> @@ -1202,17 +1221,7 @@ void discard_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_NEW));
> -	/*
> -	 * Pairs with smp_rmb in wait_on_inode().
> -	 */
> -	smp_wmb();
>  	inode_state_clear(inode, I_NEW);
> -	/*
> -	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> -	 * ___wait_var_event() either sees the bit cleared or
> -	 * waitqueue_active() check in wake_up_var() sees the waiter.
> -	 */
> -	smp_mb();
>  	inode_wake_up_bit(inode, __I_NEW);
>  	spin_unlock(&inode->i_lock);
>  	iput(inode);
> @@ -1286,12 +1295,13 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  {
>  	struct hlist_head *head = inode_hashtable + hash(inode->i_sb, hashval);
>  	struct inode *old;
> +	bool isnew;
>  
>  	might_sleep();
>  
>  again:
>  	spin_lock(&inode_hash_lock);
> -	old = find_inode(inode->i_sb, head, test, data, true);
> +	old = find_inode(inode->i_sb, head, test, data, true, &isnew);
>  	if (unlikely(old)) {
>  		/*
>  		 * Uhhuh, somebody else created the same inode under us.
> @@ -1300,10 +1310,12 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  		spin_unlock(&inode_hash_lock);
>  		if (IS_ERR(old))
>  			return NULL;
> -		wait_on_inode(old);
> -		if (unlikely(inode_unhashed(old))) {
> -			iput(old);
> -			goto again;
> +		if (unlikely(isnew)) {
> +			wait_on_new_inode(old);
> +			if (unlikely(inode_unhashed(old))) {
> +				iput(old);
> +				goto again;
> +			}
>  		}
>  		return old;
>  	}
> @@ -1391,18 +1403,21 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
>  {
>  	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
>  	struct inode *inode, *new;
> +	bool isnew;
>  
>  	might_sleep();
>  
>  again:
> -	inode = find_inode(sb, head, test, data, false);
> +	inode = find_inode(sb, head, test, data, false, &isnew);
>  	if (inode) {
>  		if (IS_ERR(inode))
>  			return NULL;
> -		wait_on_inode(inode);
> -		if (unlikely(inode_unhashed(inode))) {
> -			iput(inode);
> -			goto again;
> +		if (unlikely(isnew)) {
> +			wait_on_new_inode(inode);
> +			if (unlikely(inode_unhashed(inode))) {
> +				iput(inode);
> +				goto again;
> +			}
>  		}
>  		return inode;
>  	}
> @@ -1434,18 +1449,21 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  {
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  	struct inode *inode;
> +	bool isnew;
>  
>  	might_sleep();
>  
>  again:
> -	inode = find_inode_fast(sb, head, ino, false);
> +	inode = find_inode_fast(sb, head, ino, false, &isnew);
>  	if (inode) {
>  		if (IS_ERR(inode))
>  			return NULL;
> -		wait_on_inode(inode);
> -		if (unlikely(inode_unhashed(inode))) {
> -			iput(inode);
> -			goto again;
> +		if (unlikely(isnew)) {
> +			wait_on_new_inode(inode);
> +			if (unlikely(inode_unhashed(inode))) {
> +				iput(inode);
> +				goto again;
> +			}
>  		}
>  		return inode;
>  	}
> @@ -1456,7 +1474,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  
>  		spin_lock(&inode_hash_lock);
>  		/* We released the lock, so.. */
> -		old = find_inode_fast(sb, head, ino, true);
> +		old = find_inode_fast(sb, head, ino, true, &isnew);
>  		if (!old) {
>  			inode->i_ino = ino;
>  			spin_lock(&inode->i_lock);
> @@ -1482,10 +1500,12 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  		if (IS_ERR(old))
>  			return NULL;
>  		inode = old;
> -		wait_on_inode(inode);
> -		if (unlikely(inode_unhashed(inode))) {
> -			iput(inode);
> -			goto again;
> +		if (unlikely(isnew)) {
> +			wait_on_new_inode(inode);
> +			if (unlikely(inode_unhashed(inode))) {
> +				iput(inode);
> +				goto again;
> +			}
>  		}
>  	}
>  	return inode;
> @@ -1586,13 +1606,13 @@ EXPORT_SYMBOL(igrab);
>   * Note2: @test is called with the inode_hash_lock held, so can't sleep.
>   */
>  struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
> -		int (*test)(struct inode *, void *), void *data)
> +		int (*test)(struct inode *, void *), void *data, bool *isnew)
>  {
>  	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
>  	struct inode *inode;
>  
>  	spin_lock(&inode_hash_lock);
> -	inode = find_inode(sb, head, test, data, true);
> +	inode = find_inode(sb, head, test, data, true, isnew);
>  	spin_unlock(&inode_hash_lock);
>  
>  	return IS_ERR(inode) ? NULL : inode;
> @@ -1620,16 +1640,19 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *), void *data)
>  {
>  	struct inode *inode;
> +	bool isnew;
>  
>  	might_sleep();
>  
>  again:
> -	inode = ilookup5_nowait(sb, hashval, test, data);
> +	inode = ilookup5_nowait(sb, hashval, test, data, &isnew);
>  	if (inode) {
> -		wait_on_inode(inode);
> -		if (unlikely(inode_unhashed(inode))) {
> -			iput(inode);
> -			goto again;
> +		if (unlikely(isnew)) {
> +			wait_on_new_inode(inode);
> +			if (unlikely(inode_unhashed(inode))) {
> +				iput(inode);
> +				goto again;
> +			}
>  		}
>  	}
>  	return inode;
> @@ -1648,19 +1671,22 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  {
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
>  	struct inode *inode;
> +	bool isnew;
>  
>  	might_sleep();
>  
>  again:
> -	inode = find_inode_fast(sb, head, ino, false);
> +	inode = find_inode_fast(sb, head, ino, false, &isnew);
>  
>  	if (inode) {
>  		if (IS_ERR(inode))
>  			return NULL;
> -		wait_on_inode(inode);
> -		if (unlikely(inode_unhashed(inode))) {
> -			iput(inode);
> -			goto again;
> +		if (unlikely(isnew)) {
> +			wait_on_new_inode(inode);
> +			if (unlikely(inode_unhashed(inode))) {
> +				iput(inode);
> +				goto again;
> +			}
>  		}
>  	}
>  	return inode;
> @@ -1800,6 +1826,7 @@ int insert_inode_locked(struct inode *inode)
>  	struct super_block *sb = inode->i_sb;
>  	ino_t ino = inode->i_ino;
>  	struct hlist_head *head = inode_hashtable + hash(sb, ino);
> +	bool isnew;
>  
>  	might_sleep();
>  
> @@ -1832,12 +1859,15 @@ int insert_inode_locked(struct inode *inode)
>  			return -EBUSY;
>  		}
>  		__iget(old);
> +		isnew = !!(inode_state_read(old) & I_NEW);
>  		spin_unlock(&old->i_lock);
>  		spin_unlock(&inode_hash_lock);
> -		wait_on_inode(old);
> -		if (unlikely(!inode_unhashed(old))) {
> -			iput(old);
> -			return -EBUSY;
> +		if (isnew) {
> +			wait_on_new_inode(old);
> +			if (unlikely(!inode_unhashed(old))) {
> +				iput(old);
> +				return -EBUSY;
> +			}
>  		}
>  		iput(old);
>  	}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21c73df3ce75..a813abdcf218 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1030,15 +1030,7 @@ static inline void inode_fake_hash(struct inode *inode)
>  	hlist_add_fake(&inode->i_hash);
>  }
>  
> -static inline void wait_on_inode(struct inode *inode)
> -{
> -	wait_var_event(inode_state_wait_address(inode, __I_NEW),
> -		       !(inode_state_read_once(inode) & I_NEW));
> -	/*
> -	 * Pairs with routines clearing I_NEW.
> -	 */
> -	smp_rmb();
> -}
> +void wait_on_new_inode(struct inode *inode);
>  
>  /*
>   * inode->i_rwsem nesting subclasses for the lock validator:
> @@ -3417,7 +3409,7 @@ extern void d_mark_dontcache(struct inode *inode);
>  
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
>  		unsigned long hashval, int (*test)(struct inode *, void *),
> -		void *data);
> +		void *data, bool *isnew);
>  extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *), void *data);
>  extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
> -- 
> 2.34.1
> 
> 

Thanks,
Andreas


