Return-Path: <linux-fsdevel+bounces-46836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D26A95540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B823B334E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709451E5B7E;
	Mon, 21 Apr 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XFtAfaYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AE1E5B6D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256378; cv=none; b=S06xpR0qtgb87lqcxsLwBsBfXBz/SKa1z/FAcIxdPtrmpgdFDxfEdPdG/qXaywnZHZ/nlgYbQEmIlC4sPdvh9zQENmQPnCJ86awhNewLJnDyq9tktcTycdO1dYEwVWdA63RF93+KvolTz90paEIcLw767O7SyJC9FTLX+JVH+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256378; c=relaxed/simple;
	bh=CrT5/NUZVrkSDW8mFK9kS/KVLdoTyITKWtqyutWB5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYFaiNXjYv9O9BarGkCpOKvNq3CB8PTFYZwMxD1xSmdQl+Z3eaZqSZfnPGsmnJhywvBYPpNERQl4n7/vra2myHms2awEwBuR8ADqiP8a/o1KdSClBziCN5vaD3jkvRACLmu/x4UOZUDGSu8s5o1QkeTJUF77C0hrzTBjy/tTEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XFtAfaYV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745256374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbp5PLryAkwRfcRSXgpvdLZhOMfxBRNMEoTWjrj4MX0=;
	b=XFtAfaYVFwVBeEw3Zv4oBNl78H2TjISsVgTETA3dHHCP0a3xti5QTKa7TYg6SP/7EiIlS6
	I7P8gdOF21crzHj96P+UqNXlcuJecLr3M+JdLxF/PTwmcrmaqildsmD9gG/uzGK/h8muGN
	Wvkwo/laVEAB83LFXUxJVU1r3oKmkio=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 3/5] bcachefs: fast_list
Date: Mon, 21 Apr 2025 13:26:03 -0400
Message-ID: <20250421172607.1781982-4-kent.overstreet@linux.dev>
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

A fast "list" data structure, which is actually a radix tree, with an
IDA for slot allocation and a percpu buffer on top of that.

Items cannot be added or moved to the head or tail, only added at some
(arbitrary) position and removed. The advantage is that adding, removing
and iteration is generally lockless, only hitting the lock in ida when
the percpu buffer is full or empty.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/Makefile    |   1 +
 fs/bcachefs/fast_list.c | 140 ++++++++++++++++++++++++++++++++++++++++
 fs/bcachefs/fast_list.h |  41 ++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 fs/bcachefs/fast_list.c
 create mode 100644 fs/bcachefs/fast_list.h

diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index d2b8aec6ed8c..3be39845e4f6 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -41,6 +41,7 @@ bcachefs-y		:=	\
 	extents.o		\
 	extent_update.o		\
 	eytzinger.o		\
+	fast_list.o		\
 	fs.o			\
 	fs-ioctl.o		\
 	fs-io.o			\
diff --git a/fs/bcachefs/fast_list.c b/fs/bcachefs/fast_list.c
new file mode 100644
index 000000000000..2831cfeff6b6
--- /dev/null
+++ b/fs/bcachefs/fast_list.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Fast, unordered lists
+ *
+ * Supports add, remove, and iterate
+ *
+ * Underneath, they're a radix tree and an IDA, with a percpu buffer for slot
+ * allocation and freeing.
+ *
+ * This means that adding, removing, and iterating over items is lockless,
+ * except when refilling/emptying the percpu slot buffers.
+ */
+
+#include "fast_list.h"
+
+struct fast_list_pcpu {
+	size_t			nr;
+	size_t			entries[31];
+};
+
+/**
+ * fast_list_get_idx - get a slot in a fast_list
+ * @l:		list to get slot in
+ *
+ * This allocates a slot in the radix tree without storing to it, so that we can
+ * take the potential memory allocation failure early and do the list add later
+ * when we can't take an allocation failure.
+ *
+ * Returns: positive integer on success, -ENOMEM on failure
+ */
+int fast_list_get_idx(struct fast_list *l)
+{
+	int idx;
+
+	preempt_disable();
+	struct fast_list_pcpu *lp = this_cpu_ptr(l->buffer);
+
+	if (unlikely(!lp->nr))
+		while (lp->nr <= ARRAY_SIZE(lp->entries) / 2) {
+			idx = ida_alloc_range(&l->slots_allocated, 1, ~0, GFP_NOWAIT|__GFP_NOWARN);
+			if (unlikely(idx < 0)) {
+				preempt_enable();
+				idx = ida_alloc_range(&l->slots_allocated, 1, ~0, GFP_KERNEL);
+				if (unlikely(idx < 0))
+					return idx;
+
+				preempt_disable();
+				lp = this_cpu_ptr(l->buffer);
+			}
+
+			if (unlikely(!genradix_ptr_alloc_inlined(&l->items, idx,
+							GFP_NOWAIT|__GFP_NOWARN))) {
+				preempt_enable();
+				if (!genradix_ptr_alloc(&l->items, idx, GFP_KERNEL)) {
+					ida_free(&l->slots_allocated, idx);
+					return -ENOMEM;
+				}
+
+				preempt_disable();
+				lp = this_cpu_ptr(l->buffer);
+			}
+
+			if (unlikely(lp->nr == ARRAY_SIZE(lp->entries)))
+				ida_free(&l->slots_allocated, idx);
+			else
+				lp->entries[lp->nr++] = idx;
+		}
+
+	idx = lp->entries[--lp->nr];
+	preempt_enable();
+
+	return idx;
+}
+
+/**
+ * fast_list_add - add an item to a fast_list
+ * @l:		list
+ * @item:	item to add
+ *
+ * Allocates a slot in the radix tree and stores to it and then returns the
+ * slot index, which must be passed to fast_list_remove().
+ *
+ * Returns: positive integer on success, -ENOMEM on failure
+ */
+int fast_list_add(struct fast_list *l, void *item)
+{
+	int idx = fast_list_get_idx(l);
+	if (idx < 0)
+		return idx;
+
+	*genradix_ptr_inlined(&l->items, idx) = item;
+	return idx;
+}
+
+/**
+ * fast_list_remove - remove an item from a fast_list
+ * @l:		list
+ * @idx:	item's slot index
+ *
+ * Zeroes out the slot in the radix tree and frees the slot for future
+ * fast_list_add() operations.
+ */
+void fast_list_remove(struct fast_list *l, unsigned idx)
+{
+	if (!idx)
+		return;
+
+	*genradix_ptr_inlined(&l->items, idx) = NULL;
+
+	preempt_disable();
+	struct fast_list_pcpu *lp = this_cpu_ptr(l->buffer);
+
+	if (unlikely(lp->nr == ARRAY_SIZE(lp->entries)))
+		while (lp->nr >= ARRAY_SIZE(lp->entries) / 2) {
+			ida_free(&l->slots_allocated, idx);
+			idx = lp->entries[--lp->nr];
+		}
+
+	lp->entries[lp->nr++] = idx;
+	preempt_enable();
+}
+
+void fast_list_exit(struct fast_list *l)
+{
+	/* XXX: warn if list isn't empty */
+	free_percpu(l->buffer);
+	ida_destroy(&l->slots_allocated);
+	genradix_free(&l->items);
+}
+
+int fast_list_init(struct fast_list *l)
+{
+	genradix_init(&l->items);
+	ida_init(&l->slots_allocated);
+	l->buffer = alloc_percpu(*l->buffer);
+	if (!l->buffer)
+		return -ENOMEM;
+	return 0;
+}
diff --git a/fs/bcachefs/fast_list.h b/fs/bcachefs/fast_list.h
new file mode 100644
index 000000000000..73c9bf591fd6
--- /dev/null
+++ b/fs/bcachefs/fast_list.h
@@ -0,0 +1,41 @@
+#ifndef _LINUX_FAST_LIST_H
+#define _LINUX_FAST_LIST_H
+
+#include <linux/generic-radix-tree.h>
+#include <linux/idr.h>
+#include <linux/percpu.h>
+
+struct fast_list_pcpu;
+
+struct fast_list {
+	GENRADIX(void *)	items;
+	struct ida		slots_allocated;;
+	struct fast_list_pcpu __percpu
+				*buffer;
+};
+
+static inline void *fast_list_iter_peek(struct genradix_iter *iter,
+					struct fast_list *list)
+{
+	void **p;
+	while ((p = genradix_iter_peek(iter, &list->items)) && !*p)
+		genradix_iter_advance(iter, &list->items);
+
+	return p ? *p : NULL;
+}
+
+#define fast_list_for_each_from(_list, _iter, _i, _start)		\
+	for (_iter = genradix_iter_init(&(_list)->items, _start);	\
+	     (_i = fast_list_iter_peek(&(_iter), _list)) != NULL;	\
+	     genradix_iter_advance(&(_iter), &(_list)->items))
+
+#define fast_list_for_each(_list, _iter, _i)				\
+	fast_list_for_each_from(_list, _iter, _i, 0)
+
+int fast_list_get_idx(struct fast_list *l);
+int fast_list_add(struct fast_list *l, void *item);
+void fast_list_remove(struct fast_list *l, unsigned idx);
+void fast_list_exit(struct fast_list *l);
+int fast_list_init(struct fast_list *l);
+
+#endif /* _LINUX_FAST_LIST_H */
-- 
2.49.0


