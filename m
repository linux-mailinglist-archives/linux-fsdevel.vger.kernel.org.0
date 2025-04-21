Return-Path: <linux-fsdevel+bounces-46837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF829A95541
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD227A8020
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388861EA7CB;
	Mon, 21 Apr 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LZWhkLhU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE61E5B97
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256379; cv=none; b=s5oGCa7DpQ3iTOl3w4coPwPO8bxvbyDpOqPVm/h8dAuYYOxXzBI8FIHuC11MqkqGdQ83jyYGjYljf+O12+R3QQ9vYAsgNFdyohbh4hByTpR4PPxyipwljtjoSKWEtgN3/UBZrzpm0fYkc2w0rZBPrMmBZtxSZUzMf8mF3yYg3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256379; c=relaxed/simple;
	bh=DrqZj2+5jk92d7YQrhPhvCqPSqgrhSs4R6UXg5jHBBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isDI78IgS2nUk3GzFgw0ESF/EysB8yUrWCslrJKWaJ0+lGD2N0NriZvOh1I27an0wn7Rg8qQakg/c1b5VWYfY5ZXQAEKpH9hoNsXeyOEH1a3gjIt8QScvERybJU3patG6V0rTYSJY+lRenE3lffdePSG8uxvTFFxs1k7oEqIjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LZWhkLhU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745256375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNfQjfwzwV4XIgSb0T6cfh7BeI/JVGEPTlzaJSuDWck=;
	b=LZWhkLhU1Ckm8Q3m3nZEtpGRWrl8AZLxmY7dARRhTzJDD1ENSd5BtJN2BRk1BQphuyjWXy
	D7RiGy53QlU+3Xs24qXlAeInuBMYSItYfEAqYoX0wc3JjD+pPGJNaBmdDGzuD0wfz4RfKp
	qtP1uIAVVfZdncefezl+xfM+imEtfAY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 4/5] bcachefs: Async object debugging
Date: Mon, 21 Apr 2025 13:26:04 -0400
Message-ID: <20250421172607.1781982-5-kent.overstreet@linux.dev>
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

Debugging infrastructure for async objs: this lets us easily create
fast_lists for various object types so they'll be visible in debugfs.

Add new object types to the BCH_ASYNC_OBJS_TYPES() enum, and drop a
pretty-printer wrapper in async_objs.c.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/Kconfig            |   5 ++
 fs/bcachefs/Makefile           |   2 +
 fs/bcachefs/async_objs.c       | 105 +++++++++++++++++++++++++++++++++
 fs/bcachefs/async_objs.h       |  39 ++++++++++++
 fs/bcachefs/async_objs_types.h |  20 +++++++
 fs/bcachefs/bcachefs.h         |   7 +++
 fs/bcachefs/debug.c            |  52 +++++++---------
 fs/bcachefs/debug.h            |  18 ++++++
 fs/bcachefs/errcode.h          |   1 +
 fs/bcachefs/super.c            |   3 +
 10 files changed, 220 insertions(+), 32 deletions(-)
 create mode 100644 fs/bcachefs/async_objs.c
 create mode 100644 fs/bcachefs/async_objs.h
 create mode 100644 fs/bcachefs/async_objs_types.h

diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index 07709b0d7688..b21775f5f3d3 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -103,6 +103,11 @@ config BCACHEFS_PATH_TRACEPOINTS
 	Enable extra tracepoints for debugging btree_path operations; we don't
 	normally want these enabled because they happen at very high rates.
 
+config BCACHEFS_ASYNC_OBJECT_LISTS
+	bool "Keep async objects on fast_lists for debugfs visibility"
+	depends on BCACHEFS_FS && DEBUG_FS
+	default y
+
 config MEAN_AND_VARIANCE_UNIT_TEST
 	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 3be39845e4f6..a5abfa831a86 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -99,6 +99,8 @@ bcachefs-y		:=	\
 	varint.o		\
 	xattr.o
 
+obj-$(CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS)   += async_objs.o
+
 obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
 
 # Silence "note: xyz changed in GCC X.X" messages
diff --git a/fs/bcachefs/async_objs.c b/fs/bcachefs/async_objs.c
new file mode 100644
index 000000000000..8d78f390a759
--- /dev/null
+++ b/fs/bcachefs/async_objs.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Async obj debugging: keep asynchronous objects on (very fast) lists, make
+ * them visibile in debugfs:
+ */
+
+#include "bcachefs.h"
+#include "async_objs.h"
+#include "btree_io.h"
+#include "debug.h"
+#include "io_read.h"
+
+#include <linux/debugfs.h>
+
+static int bch2_async_obj_list_open(struct inode *inode, struct file *file)
+{
+	struct async_obj_list *list = inode->i_private;
+	struct dump_iter *i;
+
+	i = kzalloc(sizeof(struct dump_iter), GFP_KERNEL);
+	if (!i)
+		return -ENOMEM;
+
+	file->private_data = i;
+	i->from = POS_MIN;
+	i->iter	= 0;
+	i->c	= container_of(list, struct bch_fs, async_objs[list->idx]);
+	i->list	= list;
+	i->buf	= PRINTBUF;
+	return 0;
+}
+
+static ssize_t bch2_async_obj_list_read(struct file *file, char __user *buf,
+					size_t size, loff_t *ppos)
+{
+	struct dump_iter *i = file->private_data;
+	struct async_obj_list *list = i->list;
+	ssize_t ret = 0;
+
+	i->ubuf = buf;
+	i->size	= size;
+	i->ret	= 0;
+
+	struct genradix_iter iter;
+	void *obj;
+	fast_list_for_each_from(&list->list, iter, obj, i->iter) {
+		ret = bch2_debugfs_flush_buf(i);
+		if (ret)
+			return ret;
+
+		if (!i->size)
+			break;
+
+		list->obj_to_text(&i->buf, obj);
+	}
+
+	if (i->buf.allocation_failure)
+		ret = -ENOMEM;
+	else
+		i->iter = iter.pos;
+
+	if (!ret)
+		ret = bch2_debugfs_flush_buf(i);
+
+	return ret ?: i->ret;
+}
+
+__maybe_unused
+static const struct file_operations async_obj_ops = {
+	.owner		= THIS_MODULE,
+	.open		= bch2_async_obj_list_open,
+	.release	= bch2_dump_release,
+	.read		= bch2_async_obj_list_read,
+};
+
+void bch2_fs_async_obj_debugfs_init(struct bch_fs *c)
+{
+	c->async_obj_dir = debugfs_create_dir("async_objs", c->fs_debug_dir);
+
+#define x(n) debugfs_create_file(#n, 0400, c->async_obj_dir,		\
+			    &c->async_objs[BCH_ASYNC_OBJ_LIST_##n], &async_obj_ops);
+	BCH_ASYNC_OBJ_LISTS()
+#undef x
+}
+
+void bch2_fs_async_obj_exit(struct bch_fs *c)
+{
+	for (unsigned i = 0; i < ARRAY_SIZE(c->async_objs); i++)
+		fast_list_exit(&c->async_objs[i].list);
+}
+
+int bch2_fs_async_obj_init(struct bch_fs *c)
+{
+	for (unsigned i = 0; i < ARRAY_SIZE(c->async_objs); i++) {
+		if (fast_list_init(&c->async_objs[i].list))
+			return -BCH_ERR_ENOMEM_async_obj_init;
+		c->async_objs[i].idx = i;
+	}
+
+#define x(n) c->async_objs[BCH_ASYNC_OBJ_LIST_##n].obj_to_text = n##_obj_to_text;
+	BCH_ASYNC_OBJ_LISTS()
+#undef x
+
+	return 0;
+}
diff --git a/fs/bcachefs/async_objs.h b/fs/bcachefs/async_objs.h
new file mode 100644
index 000000000000..a56f9bb0f0d1
--- /dev/null
+++ b/fs/bcachefs/async_objs.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_ASYNC_OBJS_H
+#define _BCACHEFS_ASYNC_OBJS_H
+
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+static inline void __async_object_list_del(struct fast_list *head, unsigned idx)
+{
+	fast_list_remove(head, idx);
+}
+
+static inline int __async_object_list_add(struct fast_list *head, void *obj, unsigned *idx)
+{
+	int ret = fast_list_add(head, obj);
+	*idx = ret > 0 ? ret : 0;
+	return ret < 0 ? ret : 0;
+}
+
+#define async_object_list_del(_c, _list, idx)		\
+	__async_object_list_del(&(_c)->async_objs[BCH_ASYNC_OBJ_LIST_##_list].list, idx)
+
+#define async_object_list_add(_c, _list, obj, idx)		\
+	__async_object_list_add(&(_c)->async_objs[BCH_ASYNC_OBJ_LIST_##_list].list, obj, idx)
+
+void bch2_fs_async_obj_debugfs_init(struct bch_fs *);
+void bch2_fs_async_obj_exit(struct bch_fs *);
+int bch2_fs_async_obj_init(struct bch_fs *);
+
+#else /* CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS */
+
+#define async_object_list_del(_c, _n, idx)		do {} while (0)
+#define async_object_list_add(_c, _n, obj, idx)		0
+
+static inline void bch2_fs_async_obj_debugfs_init(struct bch_fs *c) {}
+static inline void bch2_fs_async_obj_exit(struct bch_fs *c) {}
+static inline int bch2_fs_async_obj_init(struct bch_fs *c) { return 0; }
+
+#endif /* CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS */
+
+#endif /* _BCACHEFS_ASYNC_OBJS_H */
diff --git a/fs/bcachefs/async_objs_types.h b/fs/bcachefs/async_objs_types.h
new file mode 100644
index 000000000000..28cb73e3f56d
--- /dev/null
+++ b/fs/bcachefs/async_objs_types.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_ASYNC_OBJS_TYPES_H
+#define _BCACHEFS_ASYNC_OBJS_TYPES_H
+
+#define BCH_ASYNC_OBJ_LISTS()
+
+enum bch_async_obj_lists {
+#define x(n)		BCH_ASYNC_OBJ_LIST_##n,
+	BCH_ASYNC_OBJ_LISTS()
+#undef x
+	BCH_ASYNC_OBJ_NR
+};
+
+struct async_obj_list {
+	struct fast_list	list;
+	void			(*obj_to_text)(struct printbuf *, void *);
+	unsigned		idx;
+};
+
+#endif /* _BCACHEFS_ASYNC_OBJS_TYPES_H */
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 3978f86a1131..675b8f8eb961 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -209,6 +209,7 @@
 #include "btree_journal_iter_types.h"
 #include "disk_accounting_types.h"
 #include "errcode.h"
+#include "fast_list.h"
 #include "fifo.h"
 #include "nocow_locking_types.h"
 #include "opts.h"
@@ -474,6 +475,7 @@ enum bch_time_stats {
 };
 
 #include "alloc_types.h"
+#include "async_objs_types.h"
 #include "btree_gc_types.h"
 #include "btree_types.h"
 #include "btree_node_scan_types.h"
@@ -1027,6 +1029,10 @@ struct bch_fs {
 				nocow_locks;
 	struct rhashtable	promote_table;
 
+#ifdef CONFIG_BCACHEFS_ASYNC_OBJECT_LISTS
+	struct async_obj_list	async_objs[BCH_ASYNC_OBJ_NR];
+#endif
+
 	mempool_t		compression_bounce[2];
 	mempool_t		compress_workspace[BCH_COMPRESSION_OPT_NR];
 	size_t			zstd_workspace_size;
@@ -1115,6 +1121,7 @@ struct bch_fs {
 	/* DEBUG JUNK */
 	struct dentry		*fs_debug_dir;
 	struct dentry		*btree_debug_dir;
+	struct dentry		*async_obj_dir;
 	struct btree_debug	btree_debug[BTREE_ID_NR];
 	struct btree		*verify_data;
 	struct btree_node	*verify_ondisk;
diff --git a/fs/bcachefs/debug.c b/fs/bcachefs/debug.c
index 89085bd67044..c24de2e398eb 100644
--- a/fs/bcachefs/debug.c
+++ b/fs/bcachefs/debug.c
@@ -8,6 +8,7 @@
 
 #include "bcachefs.h"
 #include "alloc_foreground.h"
+#include "async_objs.h"
 #include "bkey_methods.h"
 #include "btree_cache.h"
 #include "btree_io.h"
@@ -16,6 +17,7 @@
 #include "btree_update.h"
 #include "btree_update_interior.h"
 #include "buckets.h"
+#include "data_update.h"
 #include "debug.h"
 #include "error.h"
 #include "extents.h"
@@ -306,23 +308,7 @@ void bch2_btree_node_ondisk_to_text(struct printbuf *out, struct bch_fs *c,
 
 #ifdef CONFIG_DEBUG_FS
 
-/* XXX: bch_fs refcounting */
-
-struct dump_iter {
-	struct bch_fs		*c;
-	enum btree_id		id;
-	struct bpos		from;
-	struct bpos		prev_node;
-	u64			iter;
-
-	struct printbuf		buf;
-
-	char __user		*ubuf;	/* destination user buffer */
-	size_t			size;	/* size of requested read */
-	ssize_t			ret;	/* bytes read so far */
-};
-
-static ssize_t flush_buf(struct dump_iter *i)
+ssize_t bch2_debugfs_flush_buf(struct dump_iter *i)
 {
 	if (i->buf.pos) {
 		size_t bytes = min_t(size_t, i->buf.pos, i->size);
@@ -360,7 +346,7 @@ static int bch2_dump_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int bch2_dump_release(struct inode *inode, struct file *file)
+int bch2_dump_release(struct inode *inode, struct file *file)
 {
 	struct dump_iter *i = file->private_data;
 
@@ -378,7 +364,7 @@ static ssize_t bch2_read_btree(struct file *file, char __user *buf,
 	i->size	= size;
 	i->ret	= 0;
 
-	return flush_buf(i) ?:
+	return bch2_debugfs_flush_buf(i) ?:
 		bch2_trans_run(i->c,
 			for_each_btree_key(trans, iter, i->id, i->from,
 					   BTREE_ITER_prefetch|
@@ -387,7 +373,7 @@ static ssize_t bch2_read_btree(struct file *file, char __user *buf,
 				prt_newline(&i->buf);
 				bch2_trans_unlock(trans);
 				i->from = bpos_successor(iter.pos);
-				flush_buf(i);
+				bch2_debugfs_flush_buf(i);
 			}))) ?:
 		i->ret;
 }
@@ -408,7 +394,7 @@ static ssize_t bch2_read_btree_formats(struct file *file, char __user *buf,
 	i->size	= size;
 	i->ret	= 0;
 
-	ssize_t ret = flush_buf(i);
+	ssize_t ret = bch2_debugfs_flush_buf(i);
 	if (ret)
 		return ret;
 
@@ -422,7 +408,7 @@ static ssize_t bch2_read_btree_formats(struct file *file, char __user *buf,
 				? bpos_successor(b->key.k.p)
 				: b->key.k.p;
 
-			drop_locks_do(trans, flush_buf(i));
+			drop_locks_do(trans, bch2_debugfs_flush_buf(i));
 		}))) ?: i->ret;
 }
 
@@ -442,7 +428,7 @@ static ssize_t bch2_read_bfloat_failed(struct file *file, char __user *buf,
 	i->size	= size;
 	i->ret	= 0;
 
-	return flush_buf(i) ?:
+	return bch2_debugfs_flush_buf(i) ?:
 		bch2_trans_run(i->c,
 			for_each_btree_key(trans, iter, i->id, i->from,
 					   BTREE_ITER_prefetch|
@@ -460,7 +446,7 @@ static ssize_t bch2_read_bfloat_failed(struct file *file, char __user *buf,
 				bch2_bfloat_to_text(&i->buf, l->b, _k);
 				bch2_trans_unlock(trans);
 				i->from = bpos_successor(iter.pos);
-				flush_buf(i);
+				bch2_debugfs_flush_buf(i);
 			}))) ?:
 		i->ret;
 }
@@ -521,7 +507,7 @@ static ssize_t bch2_cached_btree_nodes_read(struct file *file, char __user *buf,
 		struct rhash_head *pos;
 		struct btree *b;
 
-		ret = flush_buf(i);
+		ret = bch2_debugfs_flush_buf(i);
 		if (ret)
 			return ret;
 
@@ -544,7 +530,7 @@ static ssize_t bch2_cached_btree_nodes_read(struct file *file, char __user *buf,
 		ret = -ENOMEM;
 
 	if (!ret)
-		ret = flush_buf(i);
+		ret = bch2_debugfs_flush_buf(i);
 
 	return ret ?: i->ret;
 }
@@ -618,7 +604,7 @@ static ssize_t bch2_btree_transactions_read(struct file *file, char __user *buf,
 
 		closure_put(&trans->ref);
 
-		ret = flush_buf(i);
+		ret = bch2_debugfs_flush_buf(i);
 		if (ret)
 			goto unlocked;
 
@@ -631,7 +617,7 @@ static ssize_t bch2_btree_transactions_read(struct file *file, char __user *buf,
 		ret = -ENOMEM;
 
 	if (!ret)
-		ret = flush_buf(i);
+		ret = bch2_debugfs_flush_buf(i);
 
 	return ret ?: i->ret;
 }
@@ -656,7 +642,7 @@ static ssize_t bch2_journal_pins_read(struct file *file, char __user *buf,
 	i->ret	= 0;
 
 	while (1) {
-		err = flush_buf(i);
+		err = bch2_debugfs_flush_buf(i);
 		if (err)
 			return err;
 
@@ -699,7 +685,7 @@ static ssize_t bch2_btree_updates_read(struct file *file, char __user *buf,
 		i->iter++;
 	}
 
-	err = flush_buf(i);
+	err = bch2_debugfs_flush_buf(i);
 	if (err)
 		return err;
 
@@ -757,7 +743,7 @@ static ssize_t btree_transaction_stats_read(struct file *file, char __user *buf,
 	while (1) {
 		struct btree_transaction_stats *s = &c->btree_transaction_stats[i->iter];
 
-		err = flush_buf(i);
+		err = bch2_debugfs_flush_buf(i);
 		if (err)
 			return err;
 
@@ -878,7 +864,7 @@ static ssize_t bch2_simple_print(struct file *file, char __user *buf,
 		ret = -ENOMEM;
 
 	if (!ret)
-		ret = flush_buf(i);
+		ret = bch2_debugfs_flush_buf(i);
 
 	return ret ?: i->ret;
 }
@@ -967,6 +953,8 @@ void bch2_fs_debug_init(struct bch_fs *c)
 	debugfs_create_file("write_points", 0400, c->fs_debug_dir,
 			    c->btree_debug, &write_points_ops);
 
+	bch2_fs_async_obj_debugfs_init(c);
+
 	c->btree_debug_dir = debugfs_create_dir("btrees", c->fs_debug_dir);
 	if (IS_ERR_OR_NULL(c->btree_debug_dir))
 		return;
diff --git a/fs/bcachefs/debug.h b/fs/bcachefs/debug.h
index 2c37143b5fd1..52dbea736709 100644
--- a/fs/bcachefs/debug.h
+++ b/fs/bcachefs/debug.h
@@ -19,6 +19,24 @@ static inline void bch2_btree_verify(struct bch_fs *c, struct btree *b)
 }
 
 #ifdef CONFIG_DEBUG_FS
+struct dump_iter {
+	struct bch_fs		*c;
+	struct async_obj_list	*list;
+	enum btree_id		id;
+	struct bpos		from;
+	struct bpos		prev_node;
+	u64			iter;
+
+	struct printbuf		buf;
+
+	char __user		*ubuf;	/* destination user buffer */
+	size_t			size;	/* size of requested read */
+	ssize_t			ret;	/* bytes read so far */
+};
+
+ssize_t bch2_debugfs_flush_buf(struct dump_iter *);
+int bch2_dump_release(struct inode *, struct file *);
+
 void bch2_fs_debug_exit(struct bch_fs *);
 void bch2_fs_debug_init(struct bch_fs *);
 #else
diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index 996cdf62dad9..83ed5a632f18 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -53,6 +53,7 @@
 	x(ENOMEM,			ENOMEM_dio_write_bioset_init)		\
 	x(ENOMEM,			ENOMEM_nocow_flush_bioset_init)		\
 	x(ENOMEM,			ENOMEM_promote_table_init)		\
+	x(ENOMEM,			ENOMEM_async_obj_init)			\
 	x(ENOMEM,			ENOMEM_compression_bounce_read_init)	\
 	x(ENOMEM,			ENOMEM_compression_bounce_write_init)	\
 	x(ENOMEM,			ENOMEM_compression_workspace_init)	\
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index ae9c56cf0eef..f861583c5c7e 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -10,6 +10,7 @@
 #include "bcachefs.h"
 #include "alloc_background.h"
 #include "alloc_foreground.h"
+#include "async_objs.h"
 #include "bkey_sort.h"
 #include "btree_cache.h"
 #include "btree_gc.h"
@@ -570,6 +571,7 @@ static void __bch2_fs_free(struct bch_fs *c)
 	bch2_free_pending_node_rewrites(c);
 	bch2_free_fsck_errs(c);
 	bch2_fs_accounting_exit(c);
+	bch2_fs_async_obj_exit(c);
 	bch2_fs_sb_errors_exit(c);
 	bch2_fs_counters_exit(c);
 	bch2_fs_snapshots_exit(c);
@@ -981,6 +983,7 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts,
 	}
 
 	ret =
+	    bch2_fs_async_obj_init(c) ?:
 	    bch2_fs_btree_cache_init(c) ?:
 	    bch2_fs_btree_iter_init(c) ?:
 	    bch2_fs_btree_key_cache_init(&c->btree_key_cache) ?:
-- 
2.49.0


