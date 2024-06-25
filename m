Return-Path: <linux-fsdevel+bounces-22448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D812917330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4666B22E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962117F366;
	Tue, 25 Jun 2024 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeepE5g6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AD17CA16;
	Tue, 25 Jun 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350292; cv=none; b=XfpHFwdcSvFcXIvFVoCA1CbjzD7Is5nurT7aE/h3cRnaSfSG55hS+IZ/eMoB9RP5br7bti/nYbF2tNPxC71gHRuYu0w8ihbSY6bE/zC0be3a99RjsplakDjXNhk0h48PjkmqgihV11YE9ILnFOEFqXhYt621qWQ0Faap+Ms1ixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350292; c=relaxed/simple;
	bh=h47z6HO+e2qPPToeoc9r/aR+oTeUb2HZTNOhNNGhHtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA+ZRQQlQOVNckILN+wjOAuLvEeaa2Lr7O3wwjvRGW7tGj9dMfbZ3JR8hrReW3Z0a80Mgpm3ejCLxnkeuoAZJfVKB101cAS/nlUxLnnVGm6aOgj/Gk6pmAPRit5q4YLdbk+UdMBXdOVfOyFmph2FabMyO0EpLJ60t7pfYxCpcFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZeepE5g6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yWCNwPRRR/3MDBLoGzNNPVXBUmyUwBDeOmRQI2p75TA=; b=ZeepE5g6cH2FXhn8x08wOCbkto
	oowhRwK0grOPj8Hbb5ak2SAYrWuhjrc0lzmzO/4ysWZDwYfbnPvSZCniqq6Ydmtiztwn4Dvsg5kTg
	I3EHIcIX+0fNikUjrXJDA/3ZahfV+32UVxInV/3A5Ptx1gsnxlfZcmDatrMENp3kzlBLA4dbD4YHF
	6/Bb/EHtKYq08SnzREQZWlPDeazqBl8CgJHqJrTN2roi6iUFi0prEKYAhov5W/KjZ4HPQThBtN/zR
	3riO4XBYoDmHdgaeqfO/pBioX0mRilzSsjRHSA4IaI6bdW3WKjc9cpvbk7ITb6gyfgrDGfNhKdYJR
	WS+paHnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYG-0000000BXYi-2wFT;
	Tue, 25 Jun 2024 21:18:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: [PATCH v2 5/5] dcache: Convert to use rosebush
Date: Tue, 25 Jun 2024 22:18:00 +0100
Message-ID: <20240625211803.2750563-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625211803.2750563-1-willy@infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the rosebush instead of a custom hashtable.  This is a deliberately
awful patch because I wouldn't want anyone applying it yet.  We need to
figure out how to implement d_unhashed() properly, and what to do about
IS_ROOT() dentries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dcache.c | 152 +++++++++++++++++++---------------------------------
 1 file changed, 54 insertions(+), 98 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 407095188f83..5c2ba8d5f8ff 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -26,6 +26,7 @@
 #include <linux/hash.h>
 #include <linux/cache.h>
 #include <linux/export.h>
+#include <linux/rosebush.h>
 #include <linux/security.h>
 #include <linux/seqlock.h>
 #include <linux/memblock.h>
@@ -87,23 +88,7 @@ EXPORT_SYMBOL(slash_name);
 const struct qstr dotdot_name = QSTR_INIT("..", 2);
 EXPORT_SYMBOL(dotdot_name);
 
-/*
- * This is the single most critical data structure when it comes
- * to the dcache: the hashtable for lookups. Somebody should try
- * to make this good - I've just made it work.
- *
- * This hash-function tries to avoid losing too many bits of hash
- * information, yet avoid using a prime hash-size or similar.
- */
-
-static unsigned int d_hash_shift __ro_after_init;
-
-static struct hlist_bl_head *dentry_hashtable __ro_after_init;
-
-static inline struct hlist_bl_head *d_hash(unsigned int hash)
-{
-	return dentry_hashtable + (hash >> d_hash_shift);
-}
+static DEFINE_ROSEBUSH(all_dentries);
 
 #define IN_LOOKUP_SHIFT 10
 static struct hlist_bl_head in_lookup_hashtable[1 << IN_LOOKUP_SHIFT];
@@ -486,20 +471,22 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 
 static void ___d_drop(struct dentry *dentry)
 {
-	struct hlist_bl_head *b;
 	/*
 	 * Hashed dentries are normally on the dentry hashtable,
 	 * with the exception of those newly allocated by
 	 * d_obtain_root, which are always IS_ROOT:
 	 */
-	if (unlikely(IS_ROOT(dentry)))
-		b = &dentry->d_sb->s_roots;
-	else
-		b = d_hash(dentry->d_name.hash);
+	if (unlikely(IS_ROOT(dentry))) {
+		struct hlist_bl_head *b = &dentry->d_sb->s_roots;
+		hlist_bl_lock(b);
+		__hlist_bl_del(&dentry->d_hash);
+		hlist_bl_unlock(b);
+	} else {
+		dentry->d_hash.pprev = NULL;
+	}
 
-	hlist_bl_lock(b);
-	__hlist_bl_del(&dentry->d_hash);
-	hlist_bl_unlock(b);
+//printk("removing dentry %p at %x\n", dentry, dentry->d_name.hash);
+	rbh_remove(&all_dentries, dentry->d_name.hash, dentry);
 }
 
 void __d_drop(struct dentry *dentry)
@@ -2104,15 +2091,14 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
 	unsigned *seqp)
 {
 	u64 hashlen = name->hash_len;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
-	struct hlist_bl_node *node;
+	RBH_ITER(iter, &all_dentries, hashlen_hash(hashlen));
 	struct dentry *dentry;
 
-	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
+	while ((dentry = rbh_next(&iter)) != NULL) {
 		int tlen;
 		const char *tname;
 		unsigned seq;
-
+//printk("%s: got dentry %p with hash %x\n", __func__, dentry, dentry->d_name.hash);
 seqretry:
 		seq = raw_seqcount_begin(&dentry->d_seq);
 		if (dentry->d_parent != parent)
@@ -2131,9 +2117,9 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
 		if (parent->d_op->d_compare(dentry, tlen, tname, name) != 0)
 			continue;
 		*seqp = seq;
-		return dentry;
+		break;
 	}
-	return NULL;
+	return dentry;
 }
 
 /**
@@ -2171,8 +2157,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 {
 	u64 hashlen = name->hash_len;
 	const unsigned char *str = name->name;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
-	struct hlist_bl_node *node;
+	RBH_ITER(iter, &all_dentries, hashlen_hash(hashlen));
 	struct dentry *dentry;
 
 	/*
@@ -2182,6 +2167,8 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	 * Keep the two functions in sync.
 	 */
 
+//printk("%s: Looking up %s with hash %x\n", __func__, name->name, name->hash);
+
 	if (unlikely(parent->d_flags & DCACHE_OP_COMPARE))
 		return __d_lookup_rcu_op_compare(parent, name, seqp);
 
@@ -2198,9 +2185,10 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	 *
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
-	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
+	while ((dentry = rbh_next(&iter)) != NULL) {
 		unsigned seq;
 
+//printk("%s: got dentry %p with hash %x\n", __func__, dentry, dentry->d_name.hash);
 		/*
 		 * The dentry sequence count protects us from concurrent
 		 * renames, and thus protects parent and name fields.
@@ -2228,9 +2216,10 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 		if (dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0)
 			continue;
 		*seqp = seq;
-		return dentry;
+		break;
 	}
-	return NULL;
+//printk("%s: found %p\n", __func__, dentry);
+	return dentry;
 }
 
 /**
@@ -2276,10 +2265,7 @@ EXPORT_SYMBOL(d_lookup);
  */
 struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 {
-	unsigned int hash = name->hash;
-	struct hlist_bl_head *b = d_hash(hash);
-	struct hlist_bl_node *node;
-	struct dentry *found = NULL;
+	RBH_ITER(iter, &all_dentries, name->hash);
 	struct dentry *dentry;
 
 	/*
@@ -2289,6 +2275,8 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * Keep the two functions in sync.
 	 */
 
+//printk("%s: Looking up %s with hash %x\n", __func__, name->name, name->hash);
+
 	/*
 	 * The hash list is protected using RCU.
 	 *
@@ -2303,12 +2291,8 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
 	rcu_read_lock();
-	
-	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
-
-		if (dentry->d_name.hash != hash)
-			continue;
-
+	while ((dentry = rbh_next(&iter)) != NULL) {
+//printk("%s: got dentry %p with hash %x\n", __func__, dentry, dentry->d_name.hash);
 		spin_lock(&dentry->d_lock);
 		if (dentry->d_parent != parent)
 			goto next;
@@ -2319,15 +2303,15 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 			goto next;
 
 		dentry->d_lockref.count++;
-		found = dentry;
 		spin_unlock(&dentry->d_lock);
 		break;
 next:
 		spin_unlock(&dentry->d_lock);
- 	}
- 	rcu_read_unlock();
+	}
+	rcu_read_unlock();
 
- 	return found;
+//printk("%s: found %p\n", __func__, dentry);
+	return dentry;
 }
 
 /**
@@ -2397,11 +2381,10 @@ EXPORT_SYMBOL(d_delete);
 
 static void __d_rehash(struct dentry *entry)
 {
-	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
-
-	hlist_bl_lock(b);
-	hlist_bl_add_head_rcu(&entry->d_hash, b);
-	hlist_bl_unlock(b);
+//printk("%s: using dentry %p at %x\n", __func__, entry, entry->d_name.hash);
+	
+	entry->d_hash.pprev = (void *)&all_dentries;
+	rbh_use(&all_dentries, entry->d_name.hash, entry);
 }
 
 /**
@@ -2413,6 +2396,8 @@ static void __d_rehash(struct dentry *entry)
  
 void d_rehash(struct dentry * entry)
 {
+//printk("%s: reserving dentry %p at %x\n", __func__, entry, entry->d_name.hash);
+	rbh_reserve(&all_dentries, entry->d_name.hash);
 	spin_lock(&entry->d_lock);
 	__d_rehash(entry);
 	spin_unlock(&entry->d_lock);
@@ -2601,6 +2586,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	wait_queue_head_t *d_wait;
 	struct inode *dir = NULL;
 	unsigned n;
+
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
@@ -2625,20 +2611,21 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 
 /**
  * d_add - add dentry to hash queues
- * @entry: dentry to add
+ * @dentry: dentry to add
  * @inode: The inode to attach to this dentry
  *
  * This adds the entry to the hash queues and initializes @inode.
  * The entry was actually filled in earlier during d_alloc().
  */
-
-void d_add(struct dentry *entry, struct inode *inode)
+void d_add(struct dentry *dentry, struct inode *inode)
 {
+//printk("%s: reserving dentry %p at %x\n", __func__, dentry, dentry->d_name.hash);
+	rbh_reserve(&all_dentries, dentry->d_name.hash);
 	if (inode) {
-		security_d_instantiate(entry, inode);
+		security_d_instantiate(dentry, inode);
 		spin_lock(&inode->i_lock);
 	}
-	__d_add(entry, inode);
+	__d_add(dentry, inode);
 }
 EXPORT_SYMBOL(d_add);
 
@@ -2658,6 +2645,8 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 	struct dentry *alias;
 	unsigned int hash = entry->d_name.hash;
 
+//printk("%s: reserving dentry %p at %x\n", __func__, entry, hash);
+	rbh_reserve(&all_dentries, hash);
 	spin_lock(&inode->i_lock);
 	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
 		/*
@@ -2675,6 +2664,7 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 		if (!d_unhashed(alias)) {
 			spin_unlock(&alias->d_lock);
 			alias = NULL;
+			rbh_release(&all_dentries, hash);
 		} else {
 			dget_dlock(alias);
 			__d_rehash(alias);
@@ -2684,6 +2674,7 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 		return alias;
 	}
 	spin_unlock(&inode->i_lock);
+	rbh_release(&all_dentries, hash);
 	return NULL;
 }
 EXPORT_SYMBOL(d_exact_alias);
@@ -2967,6 +2958,8 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 
 	BUG_ON(!d_unhashed(dentry));
 
+//printk("%s: reserving dentry %p at %x\n", __func__, dentry, dentry->d_name.hash);
+	rbh_reserve(&all_dentries, dentry->d_name.hash);
 	if (!inode)
 		goto out;
 
@@ -3002,6 +2995,7 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 				write_sequnlock(&rename_lock);
 			}
 			iput(inode);
+			rbh_release(&all_dentries, dentry->d_name.hash);
 			return new;
 		}
 	}
@@ -3110,27 +3104,6 @@ static int __init set_dhash_entries(char *str)
 }
 __setup("dhash_entries=", set_dhash_entries);
 
-static void __init dcache_init_early(void)
-{
-	/* If hashes are distributed across NUMA nodes, defer
-	 * hash allocation until vmalloc space is available.
-	 */
-	if (hashdist)
-		return;
-
-	dentry_hashtable =
-		alloc_large_system_hash("Dentry cache",
-					sizeof(struct hlist_bl_head),
-					dhash_entries,
-					13,
-					HASH_EARLY | HASH_ZERO,
-					&d_hash_shift,
-					NULL,
-					0,
-					0);
-	d_hash_shift = 32 - d_hash_shift;
-}
-
 static void __init dcache_init(void)
 {
 	/*
@@ -3141,22 +3114,6 @@ static void __init dcache_init(void)
 	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
 		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_ACCOUNT,
 		d_iname);
-
-	/* Hash may have been set up in dcache_init_early */
-	if (!hashdist)
-		return;
-
-	dentry_hashtable =
-		alloc_large_system_hash("Dentry cache",
-					sizeof(struct hlist_bl_head),
-					dhash_entries,
-					13,
-					HASH_ZERO,
-					&d_hash_shift,
-					NULL,
-					0,
-					0);
-	d_hash_shift = 32 - d_hash_shift;
 }
 
 /* SLAB cache for __getname() consumers */
@@ -3170,7 +3127,6 @@ void __init vfs_caches_init_early(void)
 	for (i = 0; i < ARRAY_SIZE(in_lookup_hashtable); i++)
 		INIT_HLIST_BL_HEAD(&in_lookup_hashtable[i]);
 
-	dcache_init_early();
 	inode_init_early();
 }
 
-- 
2.43.0


