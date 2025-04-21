Return-Path: <linux-fsdevel+bounces-46838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36365A95543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DB67A7F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E601EB1B6;
	Mon, 21 Apr 2025 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOA2RAWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AC1E8358
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256381; cv=none; b=a52IXJR2u4J9yFs09kvlOQ55pMpKrtBi2AYL9rmuGKD4rhGeZukbUtRxPJBmqB7Ekt/DUtlBQsNrWmEWTQ1Ae6bAI+6VSJ6xYvKk7dzBdrAlITIaO3KM4BSu6WVRVPVhgrtZOOlkQC4ng4cFqT+IZGW4c0jZ7vuK+3oKdmhgBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256381; c=relaxed/simple;
	bh=0TtVprlHWGoalqy9t1tTXlsaPQheTRAc/MCHIKq6hq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbbtWli1qJsj9O4KZhUdHh3wVxtBxGNdiQBVev2JXhndBmqJqZEVdUcsvEqFbbSAD32H6GIf3mXlK+OawMmMfwsy3n8Mp+MW2jdsAHVX3fluEIkJaF4DJKNlPzqPU5hc2slWMmw/B6RpbEIU/8p/CrOM3a6V90aJnB+geeSnRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOA2RAWT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745256376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVrl8pmMF1fR2zNf2WELl+8xyd1WOQmW3gOiuDtvlIY=;
	b=nOA2RAWTiApFoel7zlY6sVfrtWi/A6I/glynTWMJzFAEKjo5Fwib0aVlVF2sTYqC6Nu0TR
	mGhrXQe6Lug/4GurpZrSuq9EZnML31GvtwBhCExn/b08wWKyt+1mb6c+kJLLFIK3OybxE0
	kMh2Qyx5q1+5I28cYzplmkZ3cTJ9OMA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 5/5] bcachefs: Make various async objs visible in debugfs
Date: Mon, 21 Apr 2025 13:26:05 -0400
Message-ID: <20250421172607.1781982-6-kent.overstreet@linux.dev>
In-Reply-To: <20250421172607.1781982-1-kent.overstreet@linux.dev>
References: <20250421172607.1781982-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add async objs list for
- promote_op
- bch_read_bio
- btree_read_bio
- btree_write_bio

This gets us introspection on in-flight async ops, and because under the
hood it uses fast_lists (percpu slot buffer on top of a radix tree),
it'll be fast enough to enable in production.

This will be very helpful for debugging "something got stuck" issues,
which have been cropping up from time to time (in the CI, especially
with folio writeback).

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/async_objs.c       | 23 ++++++++++++++++++-
 fs/bcachefs/async_objs_types.h |  6 ++++-
 fs/bcachefs/btree_io.c         | 12 ++++++++++
 fs/bcachefs/btree_io.h         |  8 +++++++
 fs/bcachefs/data_update.h      | 15 +++++++++++++
 fs/bcachefs/io_read.c          | 41 +++++++++++++++++++++++-----------
 fs/bcachefs/io_read.h          | 12 ++++++++++
 7 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/fs/bcachefs/async_objs.c b/fs/bcachefs/async_objs.c
index 8d78f390a759..57e2fe421461 100644
--- a/fs/bcachefs/async_objs.c
+++ b/fs/bcachefs/async_objs.c
@@ -12,6 +12,28 @@
 
 #include <linux/debugfs.h>
 
+static void promote_obj_to_text(struct printbuf *out, void *obj)
+{
+	bch2_promote_op_to_text(out, obj);
+}
+
+static void rbio_obj_to_text(struct printbuf *out, void *obj)
+{
+	bch2_read_bio_to_text(out, obj);
+}
+
+static void btree_read_bio_obj_to_text(struct printbuf *out, void *obj)
+{
+	struct btree_read_bio *rbio = obj;
+	bch2_btree_read_bio_to_text(out, rbio);
+}
+
+static void btree_write_bio_obj_to_text(struct printbuf *out, void *obj)
+{
+	struct btree_write_bio *wbio = obj;
+	bch2_bio_to_text(out, &wbio->wbio.bio);
+}
+
 static int bch2_async_obj_list_open(struct inode *inode, struct file *file)
 {
 	struct async_obj_list *list = inode->i_private;
@@ -65,7 +87,6 @@ static ssize_t bch2_async_obj_list_read(struct file *file, char __user *buf,
 	return ret ?: i->ret;
 }
 
-__maybe_unused
 static const struct file_operations async_obj_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_async_obj_list_open,
diff --git a/fs/bcachefs/async_objs_types.h b/fs/bcachefs/async_objs_types.h
index 28cb73e3f56d..310a4f90f49b 100644
--- a/fs/bcachefs/async_objs_types.h
+++ b/fs/bcachefs/async_objs_types.h
@@ -2,7 +2,11 @@
 #ifndef _BCACHEFS_ASYNC_OBJS_TYPES_H
 #define _BCACHEFS_ASYNC_OBJS_TYPES_H
 
-#define BCH_ASYNC_OBJ_LISTS()
+#define BCH_ASYNC_OBJ_LISTS()						\
+	x(promote)							\
+	x(rbio)								\
+	x(btree_read_bio)						\
+	x(btree_write_bio)
 
 enum bch_async_obj_lists {
 #define x(n)		BCH_ASYNC_OBJ_LIST_##n,
diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index ee923e73fc7b..5cd27a9c35e1 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "bcachefs.h"
+#include "async_objs.h"
 #include "bkey_buf.h"
 #include "bkey_methods.h"
 #include "bkey_sort.h"
@@ -1375,6 +1376,7 @@ static void btree_node_read_work(struct work_struct *work)
 		}
 	}
 
+	async_object_list_del(c, btree_read_bio, rb->list_idx);
 	bch2_time_stats_update(&c->times[BCH_TIME_btree_node_read],
 			       rb->start_time);
 	bio_put(&rb->bio);
@@ -1414,6 +1416,11 @@ static void btree_node_read_endio(struct bio *bio)
 	queue_work(c->btree_read_complete_wq, &rb->work);
 }
 
+void bch2_btree_read_bio_to_text(struct printbuf *out, struct btree_read_bio *rbio)
+{
+	bch2_bio_to_text(out, &rbio->bio);
+}
+
 struct btree_node_read_all {
 	struct closure		cl;
 	struct bch_fs		*c;
@@ -1744,6 +1751,8 @@ void bch2_btree_node_read(struct btree_trans *trans, struct btree *b,
 	bio->bi_end_io		= btree_node_read_endio;
 	bch2_bio_map(bio, b->data, btree_buf_bytes(b));
 
+	async_object_list_add(c, btree_read_bio, rb, &rb->list_idx);
+
 	if (rb->have_ioref) {
 		this_cpu_add(ca->io_done->sectors[READ][BCH_DATA_btree],
 			     bio_sectors(bio));
@@ -2115,6 +2124,7 @@ static void btree_node_write_work(struct work_struct *work)
 			goto err;
 	}
 out:
+	async_object_list_del(c, btree_write_bio, wbio->list_idx);
 	bio_put(&wbio->wbio.bio);
 	btree_node_write_done(c, b, start_time);
 	return;
@@ -2466,6 +2476,8 @@ void __bch2_btree_node_write(struct bch_fs *c, struct btree *b, unsigned flags)
 	atomic64_inc(&c->btree_write_stats[type].nr);
 	atomic64_add(bytes_to_write, &c->btree_write_stats[type].bytes);
 
+	async_object_list_add(c, btree_write_bio, wbio, &wbio->list_idx);
+
 	INIT_WORK(&wbio->work, btree_write_submit);
 	queue_work(c->btree_write_submit_wq, &wbio->work);
 	return;
diff --git a/fs/bcachefs/btree_io.h b/fs/bcachefs/btree_io.h
index dbf76d22c660..afdb11a9f71c 100644
--- a/fs/bcachefs/btree_io.h
+++ b/fs/bcachefs/btree_io.h
@@ -41,6 +41,9 @@ struct btree_read_bio {
 	u64			start_time;
 	unsigned		have_ioref:1;
 	unsigned		idx:7;
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	unsigned		list_idx;
+#endif
 	struct extent_ptr_decoded	pick;
 	struct work_struct	work;
 	struct bio		bio;
@@ -53,6 +56,9 @@ struct btree_write_bio {
 	unsigned		data_bytes;
 	unsigned		sector_offset;
 	u64			start_time;
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	unsigned		list_idx;
+#endif
 	struct bch_write_bio	wbio;
 };
 
@@ -133,6 +139,8 @@ void bch2_btree_node_read(struct btree_trans *, struct btree *, bool);
 int bch2_btree_root_read(struct bch_fs *, enum btree_id,
 			 const struct bkey_i *, unsigned);
 
+void bch2_btree_read_bio_to_text(struct printbuf *, struct btree_read_bio *);
+
 int bch2_btree_node_scrub(struct btree_trans *, enum btree_id, unsigned,
 			  struct bkey_s_c, unsigned);
 
diff --git a/fs/bcachefs/data_update.h b/fs/bcachefs/data_update.h
index ed05125867da..5e14d13568de 100644
--- a/fs/bcachefs/data_update.h
+++ b/fs/bcachefs/data_update.h
@@ -50,6 +50,21 @@ struct data_update {
 	struct bio_vec		*bvecs;
 };
 
+struct promote_op {
+	struct rcu_head		rcu;
+	u64			start_time;
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	unsigned		list_idx;
+#endif
+
+	struct rhash_head	hash;
+	struct bpos		pos;
+
+	struct work_struct	work;
+	struct data_update	write;
+	struct bio_vec		bi_inline_vecs[]; /* must be last */
+};
+
 void bch2_data_update_to_text(struct printbuf *, struct data_update *);
 void bch2_data_update_inflight_to_text(struct printbuf *, struct data_update *);
 
diff --git a/fs/bcachefs/io_read.c b/fs/bcachefs/io_read.c
index acec8ddf7081..f23c3bfe9145 100644
--- a/fs/bcachefs/io_read.c
+++ b/fs/bcachefs/io_read.c
@@ -9,6 +9,7 @@
 #include "bcachefs.h"
 #include "alloc_background.h"
 #include "alloc_foreground.h"
+#include "async_objs.h"
 #include "btree_update.h"
 #include "buckets.h"
 #include "checksum.h"
@@ -82,18 +83,6 @@ static bool bch2_target_congested(struct bch_fs *c, u16 target)
 
 /* Cache promotion on read */
 
-struct promote_op {
-	struct rcu_head		rcu;
-	u64			start_time;
-
-	struct rhash_head	hash;
-	struct bpos		pos;
-
-	struct work_struct	work;
-	struct data_update	write;
-	struct bio_vec		bi_inline_vecs[]; /* must be last */
-};
-
 static const struct rhashtable_params bch_promote_params = {
 	.head_offset		= offsetof(struct promote_op, hash),
 	.key_offset		= offsetof(struct promote_op, pos),
@@ -171,6 +160,8 @@ static noinline void promote_free(struct bch_read_bio *rbio)
 					 bch_promote_params);
 	BUG_ON(ret);
 
+	async_object_list_del(c, promote, op->list_idx);
+
 	bch2_data_update_exit(&op->write);
 
 	enumerated_ref_put(&c->writes, BCH_WRITE_REF_promote);
@@ -256,6 +247,10 @@ static struct bch_read_bio *__promote_alloc(struct btree_trans *trans,
 		goto err;
 	}
 
+	ret = async_object_list_add(c, promote, op, &op->list_idx);
+	if (ret < 0)
+		goto err_remove_hash;
+
 	ret = bch2_data_update_init(trans, NULL, NULL, &op->write,
 			writepoint_hashed((unsigned long) current),
 			&orig->opts,
@@ -267,7 +262,7 @@ static struct bch_read_bio *__promote_alloc(struct btree_trans *trans,
 	 * -BCH_ERR_ENOSPC_disk_reservation:
 	 */
 	if (ret)
-		goto err_remove_hash;
+		goto err_remove_list;
 
 	rbio_init_fragment(&op->write.rbio.bio, orig);
 	op->write.rbio.bounce	= true;
@@ -275,6 +270,8 @@ static struct bch_read_bio *__promote_alloc(struct btree_trans *trans,
 	op->write.op.end_io = promote_done;
 
 	return &op->write.rbio;
+err_remove_list:
+	async_object_list_del(c, promote, op->list_idx);
 err_remove_hash:
 	BUG_ON(rhashtable_remove_fast(&c->promote_table, &op->hash,
 				      bch_promote_params));
@@ -347,6 +344,18 @@ static struct bch_read_bio *promote_alloc(struct btree_trans *trans,
 	return NULL;
 }
 
+void bch2_promote_op_to_text(struct printbuf *out, struct promote_op *op)
+{
+	if (!op->write.read_done) {
+		prt_printf(out, "parent read: %px\n", op->write.rbio.parent);
+		printbuf_indent_add(out, 2);
+		bch2_read_bio_to_text(out, op->write.rbio.parent);
+		printbuf_indent_sub(out, 2);
+	}
+
+	bch2_data_update_to_text(out, &op->write);
+}
+
 /* Read */
 
 static int bch2_read_err_msg_trans(struct btree_trans *trans, struct printbuf *out,
@@ -415,6 +424,8 @@ static inline struct bch_read_bio *bch2_rbio_free(struct bch_read_bio *rbio)
 			else
 				promote_free(rbio);
 		} else {
+			async_object_list_del(rbio->c, rbio, rbio->list_idx);
+
 			if (rbio->bounce)
 				bch2_bio_free_pages_pool(rbio->c, &rbio->bio);
 
@@ -1194,6 +1205,8 @@ int __bch2_read_extent(struct btree_trans *trans, struct bch_read_bio *orig,
 
 		bch2_bio_alloc_pages_pool(c, &rbio->bio, sectors << 9);
 		rbio->bounce	= true;
+
+		async_object_list_add(c, rbio, rbio, &rbio->list_idx);
 	} else if (flags & BCH_READ_must_clone) {
 		/*
 		 * Have to clone if there were any splits, due to error
@@ -1207,6 +1220,8 @@ int __bch2_read_extent(struct btree_trans *trans, struct bch_read_bio *orig,
 						 &c->bio_read_split),
 				 orig);
 		rbio->bio.bi_iter = iter;
+
+		async_object_list_add(c, rbio, rbio, &rbio->list_idx);
 	} else {
 		rbio = orig;
 		rbio->bio.bi_iter = iter;
diff --git a/fs/bcachefs/io_read.h b/fs/bcachefs/io_read.h
index 13bb68eb91c4..c08b9c047b3e 100644
--- a/fs/bcachefs/io_read.h
+++ b/fs/bcachefs/io_read.h
@@ -4,6 +4,7 @@
 
 #include "bkey_buf.h"
 #include "btree_iter.h"
+#include "extents_types.h"
 #include "reflink.h"
 
 struct bch_read_bio {
@@ -48,6 +49,9 @@ struct bch_read_bio {
 	u16			_state;
 	};
 	s16			ret;
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	unsigned		list_idx;
+#endif
 
 	struct extent_ptr_decoded pick;
 
@@ -173,6 +177,9 @@ static inline struct bch_read_bio *rbio_init_fragment(struct bio *bio,
 	rbio->split		= true;
 	rbio->parent		= orig;
 	rbio->opts		= orig->opts;
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	rbio->list_idx	= 0;
+#endif
 	return rbio;
 }
 
@@ -190,9 +197,14 @@ static inline struct bch_read_bio *rbio_init(struct bio *bio,
 	rbio->ret		= 0;
 	rbio->opts		= opts;
 	rbio->bio.bi_end_io	= end_io;
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	rbio->list_idx	= 0;
+#endif
 	return rbio;
 }
 
+struct promote_op;
+void bch2_promote_op_to_text(struct printbuf *, struct promote_op *);
 void bch2_read_bio_to_text(struct printbuf *, struct bch_read_bio *);
 
 void bch2_fs_io_read_exit(struct bch_fs *);
-- 
2.49.0


