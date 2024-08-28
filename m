Return-Path: <linux-fsdevel+bounces-27590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C999629C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF24281EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4B18A6B4;
	Wed, 28 Aug 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lUPrPAEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34718030
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854013; cv=none; b=tR+PQOgsHoLrgpsJ0J/rs4fq5s2/auF7vTPy0nDVVf2CUA67a64GRhiNBXsEHhyc54zF8xiEYbf7dsHfW2rYq+fHu+/UlPDFovASfqv5Ac0QbDW6PSAtFfq2oDrqvXeiBxjW2PMs6Mug38OW7pKj0V2uhmzIbs3ZMJ4si9RNI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854013; c=relaxed/simple;
	bh=zzK14fWrPUuudbxqi6ng+t4f17P5uwJ8zh/WvUmUxtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAyizNyQbAm6QQnCBEugHVLc4vU/VXJyoOoer4XMYwWJ3oB5N4EpuwJzZCa06V/YKQwA/gS8u329+rvK28KH/YIwvxo4PZcUinJvSuS92HH3ZeRgp7r6ugWfkzQ7mrDiCOpwovGrGX0LMqE1xwpkX5QNzPoiD157rWMhrus1UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lUPrPAEb; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724854007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJbp8fr1GlW6ECEDnV4RCK1aKov0prOyDv8ht3obM7k=;
	b=lUPrPAEbk1pnf69ukK55YVxXYzYSeFvObJ68IrWkasWn8ycrQLHu/FMQiB3eoZG3/YrUw/
	C1RPji6tJPOs7xCJhn+J27nWK9OhIRMv/1I3NF80+i5jMDpLTq8FCiZ9eThYdQe94WbqDn
	lQBsQ/cH2XFoc7v7kCR1G568Zq7RGJ8=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: 
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Dave Chinner <dchinner@redhat.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc allocations
Date: Wed, 28 Aug 2024 10:06:36 -0400
Message-ID: <20240828140638.3204253-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

vmalloc doesn't correctly respect gfp flags - gfp flags aren't used for
pte allocation, so doing vmalloc/kvmalloc allocations with reclaim
unsafe locks is a potential deadlock.

Note that we also want to use PF_MEMALLOC_NORECLAIM, not
PF_MEMALLOC_NOFS, because when we're doing allocations with btree locks
held we have a fallback available - drop locks and do a normal
GFP_KERNEL allocation. We don't want to be invoking reclaim with btree
locks held at all, since these are big shared locks and overalll system
performance is sensitive to hold times.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/acl.c             |  5 ++--
 fs/bcachefs/btree_cache.c     |  3 ++-
 fs/bcachefs/btree_iter.h      | 46 +++++++++++++++++++----------------
 fs/bcachefs/btree_key_cache.c | 10 ++++----
 fs/bcachefs/ec.c              | 12 ++++-----
 fs/bcachefs/fs.c              |  8 ------
 6 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/fs/bcachefs/acl.c b/fs/bcachefs/acl.c
index 87f1be9d4db4..1def61875a6f 100644
--- a/fs/bcachefs/acl.c
+++ b/fs/bcachefs/acl.c
@@ -137,7 +137,7 @@ static struct posix_acl *bch2_acl_from_disk(struct btree_trans *trans,
 		return NULL;
 
 	acl = allocate_dropping_locks(trans, ret,
-			posix_acl_alloc(count, _gfp));
+			posix_acl_alloc(count, GFP_KERNEL));
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
 	if (ret) {
@@ -427,7 +427,8 @@ int bch2_acl_chmod(struct btree_trans *trans, subvol_inum inum,
 	if (ret)
 		goto err;
 
-	ret = allocate_dropping_locks_errcode(trans, __posix_acl_chmod(&acl, _gfp, mode));
+	ret = allocate_dropping_locks_errcode(trans,
+					 __posix_acl_chmod(&acl, GFP_KERNEL, mode));
 	if (ret)
 		goto err;
 
diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 9f096fdcaf9a..e0090fa551d7 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -729,7 +729,8 @@ struct btree *bch2_btree_node_mem_alloc(struct btree_trans *trans, bool pcpu_rea
 
 	mutex_unlock(&bc->lock);
 
-	if (btree_node_data_alloc(c, b, GFP_NOWAIT|__GFP_NOWARN)) {
+	if (memalloc_flags_do(PF_MEMALLOC_NORECLAIM,
+			      btree_node_data_alloc(c, b, GFP_KERNEL|__GFP_NOWARN))) {
 		bch2_trans_unlock(trans);
 		if (btree_node_data_alloc(c, b, GFP_KERNEL|__GFP_NOWARN))
 			goto err;
diff --git a/fs/bcachefs/btree_iter.h b/fs/bcachefs/btree_iter.h
index 6d87e57745da..0ea21a5f6d86 100644
--- a/fs/bcachefs/btree_iter.h
+++ b/fs/bcachefs/btree_iter.h
@@ -865,29 +865,33 @@ struct bkey_s_c bch2_btree_iter_peek_and_restart_outlined(struct btree_iter *);
 	(_do) ?: bch2_trans_relock(_trans);				\
 })
 
-#define allocate_dropping_locks_errcode(_trans, _do)			\
-({									\
-	gfp_t _gfp = GFP_NOWAIT|__GFP_NOWARN;				\
-	int _ret = _do;							\
-									\
-	if (bch2_err_matches(_ret, ENOMEM)) {				\
-		_gfp = GFP_KERNEL;					\
-		_ret = drop_locks_do(_trans, _do);			\
-	}								\
-	_ret;								\
+#define memalloc_flags_do(_flags, _do)						\
+({										\
+	unsigned _saved_flags = memalloc_flags_save(_flags);			\
+	typeof(_do) _ret = _do;							\
+	memalloc_noreclaim_restore(_saved_flags);				\
+	_ret;									\
 })
 
-#define allocate_dropping_locks(_trans, _ret, _do)			\
-({									\
-	gfp_t _gfp = GFP_NOWAIT|__GFP_NOWARN;				\
-	typeof(_do) _p = _do;						\
-									\
-	_ret = 0;							\
-	if (unlikely(!_p)) {						\
-		_gfp = GFP_KERNEL;					\
-		_ret = drop_locks_do(_trans, ((_p = _do), 0));		\
-	}								\
-	_p;								\
+#define allocate_dropping_locks_errcode(_trans, _do)				\
+({										\
+	int _ret = memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN, _do);\
+										\
+	if (bch2_err_matches(_ret, ENOMEM)) {					\
+		_ret = drop_locks_do(_trans, _do);				\
+	}									\
+	_ret;									\
+})
+
+#define allocate_dropping_locks(_trans, _ret, _do)				\
+({										\
+	typeof(_do) _p = memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN, _do);\
+										\
+	_ret = 0;								\
+	if (unlikely(!_p)) {							\
+		_ret = drop_locks_do(_trans, ((_p = _do), 0));			\
+	}									\
+	_p;									\
 })
 
 #define bch2_trans_run(_c, _do)						\
diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index af84516fb607..feea58778d44 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -117,12 +117,12 @@ static void bkey_cached_free(struct btree_key_cache *bc,
 	this_cpu_inc(*bc->nr_pending);
 }
 
-static struct bkey_cached *__bkey_cached_alloc(unsigned key_u64s, gfp_t gfp)
+static struct bkey_cached *__bkey_cached_alloc(unsigned key_u64s)
 {
-	struct bkey_cached *ck = kmem_cache_zalloc(bch2_key_cache, gfp);
+	struct bkey_cached *ck = kmem_cache_zalloc(bch2_key_cache, GFP_KERNEL);
 	if (unlikely(!ck))
 		return NULL;
-	ck->k = kmalloc(key_u64s * sizeof(u64), gfp);
+	ck->k = kmalloc(key_u64s * sizeof(u64), GFP_KERNEL);
 	if (unlikely(!ck->k)) {
 		kmem_cache_free(bch2_key_cache, ck);
 		return NULL;
@@ -146,7 +146,7 @@ bkey_cached_alloc(struct btree_trans *trans, struct btree_path *path, unsigned k
 		goto lock;
 
 	ck = allocate_dropping_locks(trans, ret,
-				     __bkey_cached_alloc(key_u64s, _gfp));
+				     __bkey_cached_alloc(key_u64s));
 	if (ret) {
 		if (ck)
 			kfree(ck->k);
@@ -240,7 +240,7 @@ static int btree_key_cache_create(struct btree_trans *trans, struct btree_path *
 		mark_btree_node_locked_noreset(path, 0, BTREE_NODE_UNLOCKED);
 
 		struct bkey_i *new_k = allocate_dropping_locks(trans, ret,
-				kmalloc(key_u64s * sizeof(u64), _gfp));
+						kmalloc(key_u64s * sizeof(u64), GFP_KERNEL));
 		if (unlikely(!new_k)) {
 			bch_err(trans->c, "error allocating memory for key cache key, btree %s u64s %u",
 				bch2_btree_id_str(ck->key.btree_id), key_u64s);
diff --git a/fs/bcachefs/ec.c b/fs/bcachefs/ec.c
index 141a4c63142f..e2163cbf63a9 100644
--- a/fs/bcachefs/ec.c
+++ b/fs/bcachefs/ec.c
@@ -890,12 +890,12 @@ int bch2_ec_read_extent(struct btree_trans *trans, struct bch_read_bio *rbio)
 
 /* stripe bucket accounting: */
 
-static int __ec_stripe_mem_alloc(struct bch_fs *c, size_t idx, gfp_t gfp)
+static int __ec_stripe_mem_alloc(struct bch_fs *c, size_t idx)
 {
 	ec_stripes_heap n, *h = &c->ec_stripes_heap;
 
 	if (idx >= h->size) {
-		if (!init_heap(&n, max(1024UL, roundup_pow_of_two(idx + 1)), gfp))
+		if (!init_heap(&n, max(1024UL, roundup_pow_of_two(idx + 1)), GFP_KERNEL))
 			return -BCH_ERR_ENOMEM_ec_stripe_mem_alloc;
 
 		mutex_lock(&c->ec_stripes_heap_lock);
@@ -909,11 +909,11 @@ static int __ec_stripe_mem_alloc(struct bch_fs *c, size_t idx, gfp_t gfp)
 		free_heap(&n);
 	}
 
-	if (!genradix_ptr_alloc(&c->stripes, idx, gfp))
+	if (!genradix_ptr_alloc(&c->stripes, idx, GFP_KERNEL))
 		return -BCH_ERR_ENOMEM_ec_stripe_mem_alloc;
 
 	if (c->gc_pos.phase != GC_PHASE_not_running &&
-	    !genradix_ptr_alloc(&c->gc_stripes, idx, gfp))
+	    !genradix_ptr_alloc(&c->gc_stripes, idx, GFP_KERNEL))
 		return -BCH_ERR_ENOMEM_ec_stripe_mem_alloc;
 
 	return 0;
@@ -923,7 +923,7 @@ static int ec_stripe_mem_alloc(struct btree_trans *trans,
 			       struct btree_iter *iter)
 {
 	return allocate_dropping_locks_errcode(trans,
-			__ec_stripe_mem_alloc(trans->c, iter->pos.offset, _gfp));
+			__ec_stripe_mem_alloc(trans->c, iter->pos.offset));
 }
 
 /*
@@ -2193,7 +2193,7 @@ int bch2_stripes_read(struct bch_fs *c)
 			if (k.k->type != KEY_TYPE_stripe)
 				continue;
 
-			ret = __ec_stripe_mem_alloc(c, k.k->p.offset, GFP_KERNEL);
+			ret = __ec_stripe_mem_alloc(c, k.k->p.offset);
 			if (ret)
 				break;
 
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index bc8dd89ec15c..153ec4e5c0f4 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -273,14 +273,6 @@ static struct bch_inode_info *bch2_inode_hash_insert(struct bch_fs *c,
 	}
 }
 
-#define memalloc_flags_do(_flags, _do)						\
-({										\
-	unsigned _saved_flags = memalloc_flags_save(_flags);			\
-	typeof(_do) _ret = _do;							\
-	memalloc_noreclaim_restore(_saved_flags);				\
-	_ret;									\
-})
-
 static struct inode *bch2_alloc_inode(struct super_block *sb)
 {
 	BUG();
-- 
2.45.2


