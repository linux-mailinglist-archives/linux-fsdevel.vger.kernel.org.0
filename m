Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4335551C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbhDFN3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhDFN3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:29:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E0C06174A;
        Tue,  6 Apr 2021 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1q2gcNgaImp6JkC5/ZdC6lQTQXsW+poOXS8osNA5qbE=; b=LgxU4zVwI9kEgwzIBL2FZ96q5+
        XbDDSMXE9Om/DbaHgg0M1d/vUN+uW+j6ez6taKWNXXV31lqyZeVjllCMlL2qxiDu41afleeJEmTuD
        FHjfOBzgLw90ogF7Q3S/AZXoS98vONyZNavX6pDmCb8e6oTRjEWmMvADUPt8deS8ejxHoO3WKctDh
        qFq5P09k2PDmgldk/tR3mDs5I0hiIO5RKWiODldZOxtBrr3mtpUss0LRfdO7gFerATqX9fum+yfQF
        8aiYtUEZPyMCQTc8niJL2XYAhKtdoeZmJB9C5JAM8iJebT6lArQti6NO9X9b6ZEbhJe0bnDQUrAFD
        Oq8rgwgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTlkw-00CrLq-20; Tue, 06 Apr 2021 13:28:55 +0000
Date:   Tue, 6 Apr 2021 14:28:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de,
        bigeasy@linutronix.de, hch@infradead.org, npiggin@kernel.dk
Subject: bl_list and lockdep
Message-ID: <20210406132834.GP2531743@casper.infradead.org>
References: <20210406123343.1739669-1-david@fromorbit.com>
 <20210406123343.1739669-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123343.1739669-4-david@fromorbit.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:33:43PM +1000, Dave Chinner wrote:
> +++ b/fs/inode.c
> @@ -57,8 +57,7 @@
>  
>  static unsigned int i_hash_mask __read_mostly;
>  static unsigned int i_hash_shift __read_mostly;
> -static struct hlist_head *inode_hashtable __read_mostly;
> -static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
> +static struct hlist_bl_head *inode_hashtable __read_mostly;

I'm a little concerned that we're losing a lockdep map here.  

Nobody seems to have done this for list_bl yet, and I'd be reluctant
to gate your patch on "Hey, Dave, solve this problem nobody else has
done yet".

But maybe we can figure out how to do this?  I think we want one lockdep
map for the entire hashtable (it's split for performance, not because
they're logically separate locks).  So something like ...

static struct lockdep_map inode_hash_map =
	STATIC_LOCKDEP_MAP_INIT("inode_hash", &inode_hash_map);

and add:

static inline void hlist_bl_lock_map(struct hlist_bl_head *b,
					struct lockdep_map *map)
{
	bit_spin_lock(0, (unsigned long *)b);
	spin_acquire(map, 0, 0, _RET_IP_);
}

then use hlist_bl_lock_map() throughout.  Would that work?
Adding lockdep experts for opinions.

>  static unsigned long hash(struct super_block *sb, unsigned long hashval)
>  {
> @@ -70,7 +69,7 @@ static unsigned long hash(struct super_block *sb, unsigned long hashval)
>  	return tmp & i_hash_mask;
>  }
>  
> -static inline struct hlist_head *i_hash_head(struct super_block *sb,
> +static inline struct hlist_bl_head *i_hash_head(struct super_block *sb,
>  		unsigned int hashval)
>  {
>  	return inode_hashtable + hash(sb, hashval);
> @@ -407,7 +406,7 @@ EXPORT_SYMBOL(address_space_init_once);
>  void inode_init_once(struct inode *inode)
>  {
>  	memset(inode, 0, sizeof(*inode));
> -	INIT_HLIST_NODE(&inode->i_hash);
> +	INIT_HLIST_BL_NODE(&inode->i_hash);
>  	INIT_LIST_HEAD(&inode->i_devices);
>  	INIT_LIST_HEAD(&inode->i_io_list);
>  	INIT_LIST_HEAD(&inode->i_wb_list);
> @@ -491,6 +490,17 @@ static inline void inode_sb_list_del(struct inode *inode)
>  	}
>  }
>  
> +/*
> + * Ensure that we store the hash head in the inode when we insert the inode into
> + * the hlist_bl_head...
> + */
> +static inline void
> +__insert_inode_hash_head(struct inode *inode, struct hlist_bl_head *b)
> +{
> +	hlist_bl_add_head_rcu(&inode->i_hash, b);
> +	inode->i_hash_head = b;
> +}
> +
>  /**
>   *	__insert_inode_hash - hash an inode
>   *	@inode: unhashed inode
> @@ -501,13 +511,13 @@ static inline void inode_sb_list_del(struct inode *inode)
>   */
>  void __insert_inode_hash(struct inode *inode, unsigned long hashval)
>  {
> -	struct hlist_head *b = inode_hashtable + hash(inode->i_sb, hashval);
> +	struct hlist_bl_head *b = i_hash_head(inode->i_sb, hashval);
>  
> -	spin_lock(&inode_hash_lock);
> +	hlist_bl_lock(b);
>  	spin_lock(&inode->i_lock);
> -	hlist_add_head_rcu(&inode->i_hash, b);
> +	__insert_inode_hash_head(inode, b);
>  	spin_unlock(&inode->i_lock);
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_unlock(b);
>  }
>  EXPORT_SYMBOL(__insert_inode_hash);
>  
> @@ -519,11 +529,44 @@ EXPORT_SYMBOL(__insert_inode_hash);
>   */
>  void __remove_inode_hash(struct inode *inode)
>  {
> -	spin_lock(&inode_hash_lock);
> -	spin_lock(&inode->i_lock);
> -	hlist_del_init_rcu(&inode->i_hash);
> -	spin_unlock(&inode->i_lock);
> -	spin_unlock(&inode_hash_lock);
> +	struct hlist_bl_head *b = inode->i_hash_head;
> +
> +	/*
> +	 * There are some callers that come through here without synchronisation
> +	 * and potentially with multiple references to the inode. Hence we have
> +	 * to handle the case that we might race with a remove and insert to a
> +	 * different list. Coda, in particular, seems to have a userspace API
> +	 * that can directly trigger "unhash/rehash to different list" behaviour
> +	 * without any serialisation at all.
> +	 *
> +	 * Hence we have to handle the situation where the inode->i_hash_head
> +	 * might point to a different list than what we expect, indicating that
> +	 * we raced with another unhash and potentially a new insertion. This
> +	 * means we have to retest the head once we have everything locked up
> +	 * and loop again if it doesn't match.
> +	 */
> +	while (b) {
> +		hlist_bl_lock(b);
> +		spin_lock(&inode->i_lock);
> +		if (b != inode->i_hash_head) {
> +			hlist_bl_unlock(b);
> +			b = inode->i_hash_head;
> +			spin_unlock(&inode->i_lock);
> +			continue;
> +		}
> +		/*
> +		 * Need to set the pprev pointer to NULL after list removal so
> +		 * that both RCU traversals and hlist_bl_unhashed() work
> +		 * correctly at this point.
> +		 */
> +		hlist_bl_del_rcu(&inode->i_hash);
> +		inode->i_hash.pprev = NULL;
> +		inode->i_hash_head = NULL;
> +		spin_unlock(&inode->i_lock);
> +		hlist_bl_unlock(b);
> +		break;
> +	}
> +
>  }
>  EXPORT_SYMBOL(__remove_inode_hash);
>  
> @@ -813,26 +856,28 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  	return freed;
>  }
>  
> -static void __wait_on_freeing_inode(struct inode *inode);
> +static void __wait_on_freeing_inode(struct hlist_bl_head *b,
> +				struct inode *inode);
>  /*
>   * Called with the inode lock held.
>   */
>  static struct inode *find_inode(struct super_block *sb,
> -				struct hlist_head *head,
> +				struct hlist_bl_head *b,
>  				int (*test)(struct inode *, void *),
>  				void *data)
>  {
> +	struct hlist_bl_node *node;
>  	struct inode *inode = NULL;
>  
>  repeat:
> -	hlist_for_each_entry(inode, head, i_hash) {
> +	hlist_bl_for_each_entry(inode, node, b, i_hash) {
>  		if (inode->i_sb != sb)
>  			continue;
>  		if (!test(inode, data))
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode);
> +			__wait_on_freeing_inode(b, inode);
>  			goto repeat;
>  		}
>  		if (unlikely(inode->i_state & I_CREATING)) {
> @@ -851,19 +896,20 @@ static struct inode *find_inode(struct super_block *sb,
>   * iget_locked for details.
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
> -				struct hlist_head *head, unsigned long ino)
> +				struct hlist_bl_head *b, unsigned long ino)
>  {
> +	struct hlist_bl_node *node;
>  	struct inode *inode = NULL;
>  
>  repeat:
> -	hlist_for_each_entry(inode, head, i_hash) {
> +	hlist_bl_for_each_entry(inode, node, b, i_hash) {
>  		if (inode->i_ino != ino)
>  			continue;
>  		if (inode->i_sb != sb)
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode);
> +			__wait_on_freeing_inode(b, inode);
>  			goto repeat;
>  		}
>  		if (unlikely(inode->i_state & I_CREATING)) {
> @@ -1072,26 +1118,26 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
>   * return it locked, hashed, and with the I_NEW flag set. The file system gets
>   * to fill it in before unlocking it via unlock_new_inode().
>   *
> - * Note both @test and @set are called with the inode_hash_lock held, so can't
> - * sleep.
> + * Note both @test and @set are called with the inode hash chain lock held,
> + * so can't sleep.
>   */
>  struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  			    int (*test)(struct inode *, void *),
>  			    int (*set)(struct inode *, void *), void *data)
>  {
> -	struct hlist_head *head = i_hash_head(inode->i_sb, hashval);
> +	struct hlist_bl_head *b = i_hash_head(inode->i_sb, hashval);
>  	struct inode *old;
>  	bool creating = inode->i_state & I_CREATING;
>  
>  again:
> -	spin_lock(&inode_hash_lock);
> -	old = find_inode(inode->i_sb, head, test, data);
> +	hlist_bl_lock(b);
> +	old = find_inode(inode->i_sb, b, test, data);
>  	if (unlikely(old)) {
>  		/*
>  		 * Uhhuh, somebody else created the same inode under us.
>  		 * Use the old inode instead of the preallocated one.
>  		 */
> -		spin_unlock(&inode_hash_lock);
> +		hlist_bl_unlock(b);
>  		if (IS_ERR(old))
>  			return NULL;
>  		wait_on_inode(old);
> @@ -1113,12 +1159,12 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  	 */
>  	spin_lock(&inode->i_lock);
>  	inode->i_state |= I_NEW;
> -	hlist_add_head_rcu(&inode->i_hash, head);
> +	__insert_inode_hash_head(inode, b);
>  	spin_unlock(&inode->i_lock);
>  	if (!creating)
>  		inode_sb_list_add(inode);
>  unlock:
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_unlock(b);
>  
>  	return inode;
>  }
> @@ -1179,12 +1225,12 @@ EXPORT_SYMBOL(iget5_locked);
>   */
>  struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  {
> -	struct hlist_head *head = i_hash_head(sb, ino);
> +	struct hlist_bl_head *b = i_hash_head(sb, ino);
>  	struct inode *inode;
>  again:
> -	spin_lock(&inode_hash_lock);
> -	inode = find_inode_fast(sb, head, ino);
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_lock(b);
> +	inode = find_inode_fast(sb, b, ino);
> +	hlist_bl_unlock(b);
>  	if (inode) {
>  		if (IS_ERR(inode))
>  			return NULL;
> @@ -1200,17 +1246,17 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  	if (inode) {
>  		struct inode *old;
>  
> -		spin_lock(&inode_hash_lock);
> +		hlist_bl_lock(b);
>  		/* We released the lock, so.. */
> -		old = find_inode_fast(sb, head, ino);
> +		old = find_inode_fast(sb, b, ino);
>  		if (!old) {
>  			inode->i_ino = ino;
>  			spin_lock(&inode->i_lock);
>  			inode->i_state = I_NEW;
> -			hlist_add_head_rcu(&inode->i_hash, head);
> +			__insert_inode_hash_head(inode, b);
>  			spin_unlock(&inode->i_lock);
>  			inode_sb_list_add(inode);
> -			spin_unlock(&inode_hash_lock);
> +			hlist_bl_unlock(b);
>  
>  			/* Return the locked inode with I_NEW set, the
>  			 * caller is responsible for filling in the contents
> @@ -1223,7 +1269,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  		 * us. Use the old inode instead of the one we just
>  		 * allocated.
>  		 */
> -		spin_unlock(&inode_hash_lock);
> +		hlist_bl_unlock(b);
>  		destroy_inode(inode);
>  		if (IS_ERR(old))
>  			return NULL;
> @@ -1247,10 +1293,11 @@ EXPORT_SYMBOL(iget_locked);
>   */
>  static int test_inode_iunique(struct super_block *sb, unsigned long ino)
>  {
> -	struct hlist_head *b = i_hash_head(sb, ino);
> +	struct hlist_bl_head *b = i_hash_head(sb, ino);
> +	struct hlist_bl_node *node;
>  	struct inode *inode;
>  
> -	hlist_for_each_entry_rcu(inode, b, i_hash) {
> +	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
>  		if (inode->i_ino == ino && inode->i_sb == sb)
>  			return 0;
>  	}
> @@ -1334,12 +1381,12 @@ EXPORT_SYMBOL(igrab);
>  struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *), void *data)
>  {
> -	struct hlist_head *head = i_hash_head(sb, hashval);
> +	struct hlist_bl_head *b = i_hash_head(sb, hashval);
>  	struct inode *inode;
>  
> -	spin_lock(&inode_hash_lock);
> -	inode = find_inode(sb, head, test, data);
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_lock(b);
> +	inode = find_inode(sb, b, test, data);
> +	hlist_bl_unlock(b);
>  
>  	return IS_ERR(inode) ? NULL : inode;
>  }
> @@ -1389,12 +1436,12 @@ EXPORT_SYMBOL(ilookup5);
>   */
>  struct inode *ilookup(struct super_block *sb, unsigned long ino)
>  {
> -	struct hlist_head *head = i_hash_head(sb, ino);
> +	struct hlist_bl_head *b = i_hash_head(sb, ino);
>  	struct inode *inode;
>  again:
> -	spin_lock(&inode_hash_lock);
> -	inode = find_inode_fast(sb, head, ino);
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_lock(b);
> +	inode = find_inode_fast(sb, b, ino);
> +	hlist_bl_unlock(b);
>  
>  	if (inode) {
>  		if (IS_ERR(inode))
> @@ -1438,12 +1485,13 @@ struct inode *find_inode_nowait(struct super_block *sb,
>  					     void *),
>  				void *data)
>  {
> -	struct hlist_head *head = i_hash_head(sb, hashval);
> +	struct hlist_bl_head *b = i_hash_head(sb, hashval);
> +	struct hlist_bl_node *node;
>  	struct inode *inode, *ret_inode = NULL;
>  	int mval;
>  
> -	spin_lock(&inode_hash_lock);
> -	hlist_for_each_entry(inode, head, i_hash) {
> +	hlist_bl_lock(b);
> +	hlist_bl_for_each_entry(inode, node, b, i_hash) {
>  		if (inode->i_sb != sb)
>  			continue;
>  		mval = match(inode, hashval, data);
> @@ -1454,7 +1502,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
>  		goto out;
>  	}
>  out:
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_unlock(b);
>  	return ret_inode;
>  }
>  EXPORT_SYMBOL(find_inode_nowait);
> @@ -1483,13 +1531,14 @@ EXPORT_SYMBOL(find_inode_nowait);
>  struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
>  			     int (*test)(struct inode *, void *), void *data)
>  {
> -	struct hlist_head *head = i_hash_head(sb, hashval);
> +	struct hlist_bl_head *b = i_hash_head(sb, hashval);
> +	struct hlist_bl_node *node;
>  	struct inode *inode;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
>  			 "suspicious find_inode_rcu() usage");
>  
> -	hlist_for_each_entry_rcu(inode, head, i_hash) {
> +	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
>  		if (inode->i_sb == sb &&
>  		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
>  		    test(inode, data))
> @@ -1521,13 +1570,14 @@ EXPORT_SYMBOL(find_inode_rcu);
>  struct inode *find_inode_by_ino_rcu(struct super_block *sb,
>  				    unsigned long ino)
>  {
> -	struct hlist_head *head = i_hash_head(sb, ino);
> +	struct hlist_bl_head *b = i_hash_head(sb, ino);
> +	struct hlist_bl_node *node;
>  	struct inode *inode;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
>  			 "suspicious find_inode_by_ino_rcu() usage");
>  
> -	hlist_for_each_entry_rcu(inode, head, i_hash) {
> +	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
>  		if (inode->i_ino == ino &&
>  		    inode->i_sb == sb &&
>  		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
> @@ -1541,39 +1591,42 @@ int insert_inode_locked(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	ino_t ino = inode->i_ino;
> -	struct hlist_head *head = i_hash_head(sb, ino);
> +	struct hlist_bl_head *b = i_hash_head(sb, ino);
>  
>  	while (1) {
> -		struct inode *old = NULL;
> -		spin_lock(&inode_hash_lock);
> -		hlist_for_each_entry(old, head, i_hash) {
> -			if (old->i_ino != ino)
> +		struct hlist_bl_node *node;
> +		struct inode *old = NULL, *t;
> +
> +		hlist_bl_lock(b);
> +		hlist_bl_for_each_entry(t, node, b, i_hash) {
> +			if (t->i_ino != ino)
>  				continue;
> -			if (old->i_sb != sb)
> +			if (t->i_sb != sb)
>  				continue;
> -			spin_lock(&old->i_lock);
> -			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
> -				spin_unlock(&old->i_lock);
> +			spin_lock(&t->i_lock);
> +			if (t->i_state & (I_FREEING|I_WILL_FREE)) {
> +				spin_unlock(&t->i_lock);
>  				continue;
>  			}
> +			old = t;
>  			break;
>  		}
>  		if (likely(!old)) {
>  			spin_lock(&inode->i_lock);
>  			inode->i_state |= I_NEW | I_CREATING;
> -			hlist_add_head_rcu(&inode->i_hash, head);
> +			__insert_inode_hash_head(inode, b);
>  			spin_unlock(&inode->i_lock);
> -			spin_unlock(&inode_hash_lock);
> +			hlist_bl_unlock(b);
>  			return 0;
>  		}
>  		if (unlikely(old->i_state & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
> -			spin_unlock(&inode_hash_lock);
> +			hlist_bl_unlock(b);
>  			return -EBUSY;
>  		}
>  		__iget(old);
>  		spin_unlock(&old->i_lock);
> -		spin_unlock(&inode_hash_lock);
> +		hlist_bl_unlock(b);
>  		wait_on_inode(old);
>  		if (unlikely(!inode_unhashed(old))) {
>  			iput(old);
> @@ -2046,17 +2099,18 @@ EXPORT_SYMBOL(inode_needs_sync);
>   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
>   * will DTRT.
>   */
> -static void __wait_on_freeing_inode(struct inode *inode)
> +static void __wait_on_freeing_inode(struct hlist_bl_head *b,
> +				struct inode *inode)
>  {
>  	wait_queue_head_t *wq;
>  	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
>  	wq = bit_waitqueue(&inode->i_state, __I_NEW);
>  	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>  	spin_unlock(&inode->i_lock);
> -	spin_unlock(&inode_hash_lock);
> +	hlist_bl_unlock(b);
>  	schedule();
>  	finish_wait(wq, &wait.wq_entry);
> -	spin_lock(&inode_hash_lock);
> +	hlist_bl_lock(b);
>  }
>  
>  static __initdata unsigned long ihash_entries;
> @@ -2082,7 +2136,7 @@ void __init inode_init_early(void)
>  
>  	inode_hashtable =
>  		alloc_large_system_hash("Inode-cache",
> -					sizeof(struct hlist_head),
> +					sizeof(struct hlist_bl_head),
>  					ihash_entries,
>  					14,
>  					HASH_EARLY | HASH_ZERO,
> @@ -2108,7 +2162,7 @@ void __init inode_init(void)
>  
>  	inode_hashtable =
>  		alloc_large_system_hash("Inode-cache",
> -					sizeof(struct hlist_head),
> +					sizeof(struct hlist_bl_head),
>  					ihash_entries,
>  					14,
>  					HASH_ZERO,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec8f3ddf4a6a..89c9e49a71a6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -664,7 +664,8 @@ struct inode {
>  	unsigned long		dirtied_when;	/* jiffies of first dirtying */
>  	unsigned long		dirtied_time_when;
>  
> -	struct hlist_node	i_hash;
> +	struct hlist_bl_node	i_hash;
> +	struct hlist_bl_head	*i_hash_head;
>  	struct list_head	i_io_list;	/* backing dev IO list */
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	struct bdi_writeback	*i_wb;		/* the associated cgroup wb */
> @@ -730,7 +731,7 @@ static inline unsigned int i_blocksize(const struct inode *node)
>  
>  static inline int inode_unhashed(struct inode *inode)
>  {
> -	return hlist_unhashed(&inode->i_hash);
> +	return hlist_bl_unhashed(&inode->i_hash);
>  }
>  
>  /*
> @@ -741,7 +742,7 @@ static inline int inode_unhashed(struct inode *inode)
>   */
>  static inline void inode_fake_hash(struct inode *inode)
>  {
> -	hlist_add_fake(&inode->i_hash);
> +	hlist_bl_add_fake(&inode->i_hash);
>  }
>  
>  /*
> @@ -3065,7 +3066,7 @@ static inline void insert_inode_hash(struct inode *inode)
>  extern void __remove_inode_hash(struct inode *);
>  static inline void remove_inode_hash(struct inode *inode)
>  {
> -	if (!inode_unhashed(inode) && !hlist_fake(&inode->i_hash))
> +	if (!inode_unhashed(inode) && !hlist_bl_fake(&inode->i_hash))
>  		__remove_inode_hash(inode);
>  }
>  
> -- 
> 2.31.0
> 
