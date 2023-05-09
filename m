Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379A16FCC25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjEIRAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjEIQ6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:58:51 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8B4C1B
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dk9fEV/nEtfTj8dEq6WD3l9lbR6xxkWjrj5WCgE+oUs=;
        b=xlpORcUQ0MniQ5ub5QSgCiBRk7D8kXP0OSY9kdkEWJmBXZfkdq/yckpdmoPfmndBpOqpyJ
        FSWmrEG8NQtokDyLL7rpwYkcl9hdRKPU4D0oBPfneQWyqg8hEOUKUgs3+Hd4gtgqZQ3k3a
        OmgHesQyP4GuRmhc+w7A9vUMfQt7tDQ=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 22/32] vfs: inode cache conversion to hash-bl
Date:   Tue,  9 May 2023 12:56:47 -0400
Message-Id: <20230509165657.1735798-23-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because scalability of the global inode_hash_lock really, really
sucks.

32-way concurrent create on a couple of different filesystems
before:

-   52.13%     0.04%  [kernel]            [k] ext4_create
   - 52.09% ext4_create
      - 41.03% __ext4_new_inode
         - 29.92% insert_inode_locked
            - 25.35% _raw_spin_lock
               - do_raw_spin_lock
                  - 24.97% __pv_queued_spin_lock_slowpath

-   72.33%     0.02%  [kernel]            [k] do_filp_open
   - 72.31% do_filp_open
      - 72.28% path_openat
         - 57.03% bch2_create
            - 56.46% __bch2_create
               - 40.43% inode_insert5
                  - 36.07% _raw_spin_lock
                     - do_raw_spin_lock
                          35.86% __pv_queued_spin_lock_slowpath
                    4.02% find_inode

Convert the inode hash table to a RCU-aware hash-bl table just like
the dentry cache. Note that we need to store a pointer to the
hlist_bl_head the inode has been added to in the inode so that when
it comes to unhash the inode we know what list to lock. We need to
do this because the hash value that is used to hash the inode is
generated from the inode itself - filesystems can provide this
themselves so we have to either store the hash or the head pointer
in the inode to be able to find the right list head for removal...

Same workload after:

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/inode.c         | 200 ++++++++++++++++++++++++++++-----------------
 include/linux/fs.h |   9 +-
 2 files changed, 132 insertions(+), 77 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 41a10bcda1..d446b054ec 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -57,8 +57,7 @@
 
 static unsigned int i_hash_mask __read_mostly;
 static unsigned int i_hash_shift __read_mostly;
-static struct hlist_head *inode_hashtable __read_mostly;
-static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
+static struct hlist_bl_head *inode_hashtable __read_mostly;
 
 static unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
@@ -70,7 +69,7 @@ static unsigned long hash(struct super_block *sb, unsigned long hashval)
 	return tmp & i_hash_mask;
 }
 
-static inline struct hlist_head *i_hash_head(struct super_block *sb,
+static inline struct hlist_bl_head *i_hash_head(struct super_block *sb,
 		unsigned int hashval)
 {
 	return inode_hashtable + hash(sb, hashval);
@@ -433,7 +432,7 @@ EXPORT_SYMBOL(address_space_init_once);
 void inode_init_once(struct inode *inode)
 {
 	memset(inode, 0, sizeof(*inode));
-	INIT_HLIST_NODE(&inode->i_hash);
+	INIT_HLIST_BL_NODE(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_devices);
 	INIT_LIST_HEAD(&inode->i_io_list);
 	INIT_LIST_HEAD(&inode->i_wb_list);
@@ -522,6 +521,17 @@ static inline void inode_sb_list_del(struct inode *inode)
 	}
 }
 
+/*
+ * Ensure that we store the hash head in the inode when we insert the inode into
+ * the hlist_bl_head...
+ */
+static inline void
+__insert_inode_hash_head(struct inode *inode, struct hlist_bl_head *b)
+{
+	hlist_bl_add_head_rcu(&inode->i_hash, b);
+	inode->i_hash_head = b;
+}
+
 /**
  *	__insert_inode_hash - hash an inode
  *	@inode: unhashed inode
@@ -532,13 +542,13 @@ static inline void inode_sb_list_del(struct inode *inode)
  */
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
-	struct hlist_head *b = inode_hashtable + hash(inode->i_sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(inode->i_sb, hashval);
 
-	spin_lock(&inode_hash_lock);
+	hlist_bl_lock(b);
 	spin_lock(&inode->i_lock);
-	hlist_add_head_rcu(&inode->i_hash, b);
+	__insert_inode_hash_head(inode, b);
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 }
 EXPORT_SYMBOL(__insert_inode_hash);
 
@@ -550,11 +560,44 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
-	spin_lock(&inode_hash_lock);
-	spin_lock(&inode->i_lock);
-	hlist_del_init_rcu(&inode->i_hash);
-	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	struct hlist_bl_head *b = inode->i_hash_head;
+
+	/*
+	 * There are some callers that come through here without synchronisation
+	 * and potentially with multiple references to the inode. Hence we have
+	 * to handle the case that we might race with a remove and insert to a
+	 * different list. Coda, in particular, seems to have a userspace API
+	 * that can directly trigger "unhash/rehash to different list" behaviour
+	 * without any serialisation at all.
+	 *
+	 * Hence we have to handle the situation where the inode->i_hash_head
+	 * might point to a different list than what we expect, indicating that
+	 * we raced with another unhash and potentially a new insertion. This
+	 * means we have to retest the head once we have everything locked up
+	 * and loop again if it doesn't match.
+	 */
+	while (b) {
+		hlist_bl_lock(b);
+		spin_lock(&inode->i_lock);
+		if (b != inode->i_hash_head) {
+			hlist_bl_unlock(b);
+			b = inode->i_hash_head;
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		/*
+		 * Need to set the pprev pointer to NULL after list removal so
+		 * that both RCU traversals and hlist_bl_unhashed() work
+		 * correctly at this point.
+		 */
+		hlist_bl_del_rcu(&inode->i_hash);
+		inode->i_hash.pprev = NULL;
+		inode->i_hash_head = NULL;
+		spin_unlock(&inode->i_lock);
+		hlist_bl_unlock(b);
+		break;
+	}
+
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -904,26 +947,28 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
-static void __wait_on_freeing_inode(struct inode *inode);
+static void __wait_on_freeing_inode(struct hlist_bl_head *b,
+				struct inode *inode);
 /*
  * Called with the inode lock held.
  */
 static struct inode *find_inode(struct super_block *sb,
-				struct hlist_head *head,
+				struct hlist_bl_head *b,
 				int (*test)(struct inode *, void *),
 				void *data)
 {
+	struct hlist_bl_node *node;
 	struct inode *inode = NULL;
 
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_bl_for_each_entry(inode, node, b, i_hash) {
 		if (inode->i_sb != sb)
 			continue;
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode);
+			__wait_on_freeing_inode(b, inode);
 			goto repeat;
 		}
 		if (unlikely(inode->i_state & I_CREATING)) {
@@ -942,19 +987,20 @@ static struct inode *find_inode(struct super_block *sb,
  * iget_locked for details.
  */
 static struct inode *find_inode_fast(struct super_block *sb,
-				struct hlist_head *head, unsigned long ino)
+				struct hlist_bl_head *b, unsigned long ino)
 {
+	struct hlist_bl_node *node;
 	struct inode *inode = NULL;
 
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_bl_for_each_entry(inode, node, b, i_hash) {
 		if (inode->i_ino != ino)
 			continue;
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode);
+			__wait_on_freeing_inode(b, inode);
 			goto repeat;
 		}
 		if (unlikely(inode->i_state & I_CREATING)) {
@@ -1162,25 +1208,25 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
  * return it locked, hashed, and with the I_NEW flag set. The file system gets
  * to fill it in before unlocking it via unlock_new_inode().
  *
- * Note both @test and @set are called with the inode_hash_lock held, so can't
- * sleep.
+ * Note both @test and @set are called with the inode hash chain lock held,
+ * so can't sleep.
  */
 struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 			    int (*test)(struct inode *, void *),
 			    int (*set)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = i_hash_head(inode->i_sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(inode->i_sb, hashval);
 	struct inode *old;
 
 again:
-	spin_lock(&inode_hash_lock);
-	old = find_inode(inode->i_sb, head, test, data);
+	hlist_bl_lock(b);
+	old = find_inode(inode->i_sb, b, test, data);
 	if (unlikely(old)) {
 		/*
 		 * Uhhuh, somebody else created the same inode under us.
 		 * Use the old inode instead of the preallocated one.
 		 */
-		spin_unlock(&inode_hash_lock);
+		hlist_bl_unlock(b);
 		if (IS_ERR(old))
 			return NULL;
 		wait_on_inode(old);
@@ -1202,7 +1248,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 */
 	spin_lock(&inode->i_lock);
 	inode->i_state |= I_NEW;
-	hlist_add_head_rcu(&inode->i_hash, head);
+	__insert_inode_hash_head(inode, b);
 	spin_unlock(&inode->i_lock);
 
 	/*
@@ -1212,7 +1258,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	if (list_empty(&inode->i_sb_list))
 		inode_sb_list_add(inode);
 unlock:
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 
 	return inode;
 }
@@ -1273,12 +1319,12 @@ EXPORT_SYMBOL(iget5_locked);
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_lock(b);
+	inode = find_inode_fast(sb, b, ino);
+	hlist_bl_unlock(b);
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
@@ -1294,17 +1340,17 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 	if (inode) {
 		struct inode *old;
 
-		spin_lock(&inode_hash_lock);
+		hlist_bl_lock(b);
 		/* We released the lock, so.. */
-		old = find_inode_fast(sb, head, ino);
+		old = find_inode_fast(sb, b, ino);
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
 			inode->i_state = I_NEW;
-			hlist_add_head_rcu(&inode->i_hash, head);
+			__insert_inode_hash_head(inode, b);
 			spin_unlock(&inode->i_lock);
 			inode_sb_list_add(inode);
-			spin_unlock(&inode_hash_lock);
+			hlist_bl_unlock(b);
 
 			/* Return the locked inode with I_NEW set, the
 			 * caller is responsible for filling in the contents
@@ -1317,7 +1363,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		 * us. Use the old inode instead of the one we just
 		 * allocated.
 		 */
-		spin_unlock(&inode_hash_lock);
+		hlist_bl_unlock(b);
 		destroy_inode(inode);
 		if (IS_ERR(old))
 			return NULL;
@@ -1341,10 +1387,11 @@ EXPORT_SYMBOL(iget_locked);
  */
 static int test_inode_iunique(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *b = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
+	struct hlist_bl_node *node;
 	struct inode *inode;
 
-	hlist_for_each_entry_rcu(inode, b, i_hash) {
+	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
 		if (inode->i_ino == ino && inode->i_sb == sb)
 			return 0;
 	}
@@ -1428,12 +1475,12 @@ EXPORT_SYMBOL(igrab);
 struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = i_hash_head(sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(sb, hashval);
 	struct inode *inode;
 
-	spin_lock(&inode_hash_lock);
-	inode = find_inode(sb, head, test, data);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_lock(b);
+	inode = find_inode(sb, b, test, data);
+	hlist_bl_unlock(b);
 
 	return IS_ERR(inode) ? NULL : inode;
 }
@@ -1483,12 +1530,12 @@ EXPORT_SYMBOL(ilookup5);
  */
 struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_lock(b);
+	inode = find_inode_fast(sb, b, ino);
+	hlist_bl_unlock(b);
 
 	if (inode) {
 		if (IS_ERR(inode))
@@ -1532,12 +1579,13 @@ struct inode *find_inode_nowait(struct super_block *sb,
 					     void *),
 				void *data)
 {
-	struct hlist_head *head = i_hash_head(sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(sb, hashval);
+	struct hlist_bl_node *node;
 	struct inode *inode, *ret_inode = NULL;
 	int mval;
 
-	spin_lock(&inode_hash_lock);
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_bl_lock(b);
+	hlist_bl_for_each_entry(inode, node, b, i_hash) {
 		if (inode->i_sb != sb)
 			continue;
 		mval = match(inode, hashval, data);
@@ -1548,7 +1596,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
 		goto out;
 	}
 out:
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 	return ret_inode;
 }
 EXPORT_SYMBOL(find_inode_nowait);
@@ -1577,13 +1625,14 @@ EXPORT_SYMBOL(find_inode_nowait);
 struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 			     int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = i_hash_head(sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(sb, hashval);
+	struct hlist_bl_node *node;
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious find_inode_rcu() usage");
 
-	hlist_for_each_entry_rcu(inode, head, i_hash) {
+	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
 		if (inode->i_sb == sb &&
 		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
 		    test(inode, data))
@@ -1615,13 +1664,14 @@ EXPORT_SYMBOL(find_inode_rcu);
 struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 				    unsigned long ino)
 {
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
+	struct hlist_bl_node *node;
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious find_inode_by_ino_rcu() usage");
 
-	hlist_for_each_entry_rcu(inode, head, i_hash) {
+	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
 		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
@@ -1635,39 +1685,42 @@ int insert_inode_locked(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	ino_t ino = inode->i_ino;
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
 
 	while (1) {
-		struct inode *old = NULL;
-		spin_lock(&inode_hash_lock);
-		hlist_for_each_entry(old, head, i_hash) {
-			if (old->i_ino != ino)
+		struct hlist_bl_node *node;
+		struct inode *old = NULL, *t;
+
+		hlist_bl_lock(b);
+		hlist_bl_for_each_entry(t, node, b, i_hash) {
+			if (t->i_ino != ino)
 				continue;
-			if (old->i_sb != sb)
+			if (t->i_sb != sb)
 				continue;
-			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
+			spin_lock(&t->i_lock);
+			if (t->i_state & (I_FREEING|I_WILL_FREE)) {
+				spin_unlock(&t->i_lock);
 				continue;
 			}
+			old = t;
 			break;
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
 			inode->i_state |= I_NEW | I_CREATING;
-			hlist_add_head_rcu(&inode->i_hash, head);
+			__insert_inode_hash_head(inode, b);
 			spin_unlock(&inode->i_lock);
-			spin_unlock(&inode_hash_lock);
+			hlist_bl_unlock(b);
 			return 0;
 		}
 		if (unlikely(old->i_state & I_CREATING)) {
 			spin_unlock(&old->i_lock);
-			spin_unlock(&inode_hash_lock);
+			hlist_bl_unlock(b);
 			return -EBUSY;
 		}
 		__iget(old);
 		spin_unlock(&old->i_lock);
-		spin_unlock(&inode_hash_lock);
+		hlist_bl_unlock(b);
 		wait_on_inode(old);
 		if (unlikely(!inode_unhashed(old))) {
 			iput(old);
@@ -2192,17 +2245,18 @@ EXPORT_SYMBOL(inode_needs_sync);
  * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
  * will DTRT.
  */
-static void __wait_on_freeing_inode(struct inode *inode)
+static void __wait_on_freeing_inode(struct hlist_bl_head *b,
+				struct inode *inode)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
 	wq = bit_waitqueue(&inode->i_state, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 	schedule();
 	finish_wait(wq, &wait.wq_entry);
-	spin_lock(&inode_hash_lock);
+	hlist_bl_lock(b);
 }
 
 static __initdata unsigned long ihash_entries;
@@ -2228,7 +2282,7 @@ void __init inode_init_early(void)
 
 	inode_hashtable =
 		alloc_large_system_hash("Inode-cache",
-					sizeof(struct hlist_head),
+					sizeof(struct hlist_bl_head),
 					ihash_entries,
 					14,
 					HASH_EARLY | HASH_ZERO,
@@ -2254,7 +2308,7 @@ void __init inode_init(void)
 
 	inode_hashtable =
 		alloc_large_system_hash("Inode-cache",
-					sizeof(struct hlist_head),
+					sizeof(struct hlist_bl_head),
 					ihash_entries,
 					14,
 					HASH_ZERO,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1a6f951942..db8d49cbf7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -647,7 +647,8 @@ struct inode {
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 	unsigned long		dirtied_time_when;
 
-	struct hlist_node	i_hash;
+	struct hlist_bl_node	i_hash;
+	struct hlist_bl_head	*i_hash_head;
 	struct list_head	i_io_list;	/* backing dev IO list */
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback	*i_wb;		/* the associated cgroup wb */
@@ -713,7 +714,7 @@ static inline unsigned int i_blocksize(const struct inode *node)
 
 static inline int inode_unhashed(struct inode *inode)
 {
-	return hlist_unhashed(&inode->i_hash);
+	return hlist_bl_unhashed(&inode->i_hash);
 }
 
 /*
@@ -724,7 +725,7 @@ static inline int inode_unhashed(struct inode *inode)
  */
 static inline void inode_fake_hash(struct inode *inode)
 {
-	hlist_add_fake(&inode->i_hash);
+	hlist_bl_add_fake(&inode->i_hash);
 }
 
 /*
@@ -2695,7 +2696,7 @@ static inline void insert_inode_hash(struct inode *inode)
 extern void __remove_inode_hash(struct inode *);
 static inline void remove_inode_hash(struct inode *inode)
 {
-	if (!inode_unhashed(inode) && !hlist_fake(&inode->i_hash))
+	if (!inode_unhashed(inode) && !hlist_bl_fake(&inode->i_hash))
 		__remove_inode_hash(inode);
 }
 
-- 
2.40.1

