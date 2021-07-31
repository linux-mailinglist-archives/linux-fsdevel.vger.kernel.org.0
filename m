Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B63DC608
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhGaM6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 08:58:39 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:47407 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhGaM6h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 08:58:37 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 08:58:37 EDT
X-QQ-mid: bizesmtp53t1627735842tkg0sl5p
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 31 Jul 2021 20:50:40 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: HxmgvvJ9MVvfJ0xJIrY5p3zqOJ6/4wtJkKz+W5k4F9MJGo9gCkqvg3XvBHxGt
        wDGvygWcxTtF25Azs2rRu9PyK1AnIy4+WFCNv8YAY+UyL+PKQy7re2+h3TYO4DbWuDzBst+
        4GR/pACxEdEQhB0SyJ2ZefP7xhRGpS/l2gugdIROFBPfDkchB/iQos1LW1rcuJlTy3/pShC
        5jqXEzWFKwBVWvqwcA/gbRuQH5cIoqxheiRqAvG96j3mGWoRedjUBYbD7bghqlM29Y5MbDn
        aaYbHAgEjxqwFpDKne7Yz9MCNFeFv90WdLs99zsU+GIsPEdxCaKd4KYnDT/jBkDT8BCQogV
        JS4YgSOUYhQWFQpn/4=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] fs: use 'unsigned int' instead of bare 'unsigned'
Date:   Sat, 31 Jul 2021 20:50:27 +0800
Message-Id: <20210731125027.404300-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/dcache.c | 75 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..b8feea90df43 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -193,7 +193,8 @@ int proc_nr_dentry(struct ctl_table *table, int write, void *buffer,
  * In contrast, 'ct' and 'tcount' can be from a pathname, and do
  * need the careful unaligned handling.
  */
-static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
+static inline int dentry_string_cmp(const unsigned char *cs,
+		const unsigned char *ct, unsigned int tcount)
 {
 	unsigned long a,b,mask;
 
@@ -216,7 +217,8 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 
 #else
 
-static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
+static inline int dentry_string_cmp(const unsigned char *cs,
+		const unsigned char *ct, unsigned int tcount)
 {
 	do {
 		if (*cs != *ct)
@@ -230,7 +232,8 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 
 #endif
 
-static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *ct, unsigned tcount)
+static inline int dentry_cmp(const struct dentry *dentry,
+		const unsigned char *ct, unsigned int tcount)
 {
 	/*
 	 * Be careful about RCU walk racing with rename:
@@ -270,7 +273,7 @@ static void __d_free(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
 
-	kmem_cache_free(dentry_cache, dentry); 
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 static void __d_free_external(struct rcu_head *head)
@@ -313,9 +316,9 @@ EXPORT_SYMBOL(release_dentry_name_snapshot);
 
 static inline void __d_set_inode_and_type(struct dentry *dentry,
 					  struct inode *inode,
-					  unsigned type_flags)
+					  unsigned int type_flags)
 {
-	unsigned flags;
+	unsigned int flags;
 
 	dentry->d_inode = inode;
 	flags = READ_ONCE(dentry->d_flags);
@@ -326,7 +329,7 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
 
 static inline void __d_clear_type_and_inode(struct dentry *dentry)
 {
-	unsigned flags = READ_ONCE(dentry->d_flags);
+	unsigned int flags = READ_ONCE(dentry->d_flags);
 
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
@@ -840,7 +843,7 @@ static inline bool fast_dput(struct dentry *dentry)
 }
 
 
-/* 
+/*
  * This is dput
  *
  * This is complicated by the fact that we do not want to put
@@ -859,7 +862,7 @@ static inline bool fast_dput(struct dentry *dentry)
 
 /*
  * dput - release a dentry
- * @dentry: dentry to release 
+ * @dentry: dentry to release
  *
  * Release a dentry. This will drop the usage count and if appropriate
  * call the dentry unlink method as well as removing it from the queues and
@@ -932,7 +935,7 @@ struct dentry *dget_parent(struct dentry *dentry)
 {
 	int gotref;
 	struct dentry *ret;
-	unsigned seq;
+	unsigned int seq;
 
 	/*
 	 * Do optimistic parent lookup without any
@@ -1325,7 +1328,7 @@ static void d_walk(struct dentry *parent, void *data,
 {
 	struct dentry *this_parent;
 	struct list_head *next;
-	unsigned seq = 0;
+	unsigned int seq = 0;
 	enum d_walk_ret ret;
 	bool retry = true;
 
@@ -1734,7 +1737,7 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
+
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1761,14 +1764,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 						  GFP_KERNEL_ACCOUNT |
 						  __GFP_RECLAIMABLE);
 		if (!p) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 		atomic_set(&p->u.count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_iname;
-	}	
+	}
 
 	dentry->d_name.len = name->len;
 	dentry->d_name.hash = name->hash;
@@ -1932,9 +1935,9 @@ void d_set_fallthru(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_set_fallthru);
 
-static unsigned d_flags_for_inode(struct inode *inode)
+static unsigned int d_flags_for_inode(struct inode *inode)
 {
-	unsigned add_flags = DCACHE_REGULAR_TYPE;
+	unsigned int add_flags = DCACHE_REGULAR_TYPE;
 
 	if (!inode)
 		return DCACHE_MISS_TYPE;
@@ -1969,7 +1972,7 @@ static unsigned d_flags_for_inode(struct inode *inode)
 
 static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 {
-	unsigned add_flags = d_flags_for_inode(inode);
+	unsigned int add_flags = d_flags_for_inode(inode);
 	WARN_ON(d_in_lookup(dentry));
 
 	spin_lock(&dentry->d_lock);
@@ -2000,7 +2003,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
  * (or otherwise set) by the caller to indicate that it is now
  * in use by the dcache.
  */
- 
+
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
@@ -2055,7 +2058,7 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 					   bool disconnected)
 {
 	struct dentry *res;
-	unsigned add_flags;
+	unsigned int add_flags;
 
 	security_d_instantiate(dentry, inode);
 	spin_lock(&inode->i_lock);
@@ -2210,7 +2213,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2267,7 +2270,7 @@ static inline bool d_same_name(const struct dentry *dentry,
  */
 struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name,
-				unsigned *seqp)
+				unsigned int *seqp)
 {
 	u64 hashlen = name->hash_len;
 	const unsigned char *str = name->name;
@@ -2296,7 +2299,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
-		unsigned seq;
+		unsigned int seq;
 
 seqretry:
 		/*
@@ -2363,7 +2366,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
 {
 	struct dentry *dentry;
-	unsigned seq;
+	unsigned int seq;
 
 	do {
 		seq = read_seqbegin(&rename_lock);
@@ -2419,7 +2422,7 @@ struct dentry *__d_lookup(const struct dentry *parent, const struct qstr *name)
 	 * See Documentation/filesystems/path-lookup.txt for more details.
 	 */
 	rcu_read_lock();
-	
+
 	hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
 
 		if (dentry->d_name.hash != hash)
@@ -2482,7 +2485,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * it from the hash queues and waiting for
  * it to be deleted later when it has no users
  */
- 
+
 /**
  * d_delete - delete a dentry
  * @dentry: The dentry to delete
@@ -2490,7 +2493,7 @@ EXPORT_SYMBOL(d_hash_and_lookup);
  * Turn the dentry into a negative dentry if possible, otherwise
  * remove it from the hash queues so it can be deleted later
  */
- 
+
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -2526,7 +2529,7 @@ static void __d_rehash(struct dentry *entry)
  *
  * Adds a dentry to the hash according to its name.
  */
- 
+
 void d_rehash(struct dentry * entry)
 {
 	spin_lock(&entry->d_lock);
@@ -2535,18 +2538,18 @@ void d_rehash(struct dentry * entry)
 }
 EXPORT_SYMBOL(d_rehash);
 
-static inline unsigned start_dir_add(struct inode *dir)
+static inline unsigned int start_dir_add(struct inode *dir)
 {
 
 	for (;;) {
-		unsigned n = dir->i_dir_seq;
+		unsigned int n = dir->i_dir_seq;
 		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
 			return n;
 		cpu_relax();
 	}
 }
 
-static inline void end_dir_add(struct inode *dir, unsigned n)
+static inline void end_dir_add(struct inode *dir, unsigned int n)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 }
@@ -2574,7 +2577,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	struct hlist_bl_node *node;
 	struct dentry *new = d_alloc(parent, name);
 	struct dentry *dentry;
-	unsigned seq, r_seq, d_seq;
+	unsigned int seq, r_seq, d_seq;
 
 	if (unlikely(!new))
 		return ERR_PTR(-ENOMEM);
@@ -2695,7 +2698,7 @@ EXPORT_SYMBOL(__d_lookup_done);
 static inline void __d_add(struct dentry *dentry, struct inode *inode)
 {
 	struct inode *dir = NULL;
-	unsigned n;
+	unsigned int n;
 	spin_lock(&dentry->d_lock);
 	if (unlikely(d_in_lookup(dentry))) {
 		dir = dentry->d_parent->d_inode;
@@ -2703,7 +2706,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 		__d_lookup_done(dentry);
 	}
 	if (inode) {
-		unsigned add_flags = d_flags_for_inode(inode);
+		unsigned int add_flags = d_flags_for_inode(inode);
 		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 		raw_write_seqcount_begin(&dentry->d_seq);
 		__d_set_inode_and_type(dentry, inode, add_flags);
@@ -2860,7 +2863,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 {
 	struct dentry *old_parent, *p;
 	struct inode *dir = NULL;
-	unsigned n;
+	unsigned int n;
 
 	WARN_ON(!dentry->d_inode);
 	if (WARN_ON(dentry == target))
@@ -3117,11 +3120,11 @@ EXPORT_SYMBOL(d_splice_alias);
  * Returns false otherwise.
  * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
  */
-  
+
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
 	bool result;
-	unsigned seq;
+	unsigned int seq;
 
 	if (new_dentry == old_dentry)
 		return true;
-- 
2.32.0

