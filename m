Return-Path: <linux-fsdevel+bounces-30775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B0998E371
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C15B1F23C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28845216A0C;
	Wed,  2 Oct 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HwLHPqCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB72141C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897358; cv=none; b=mAxk0kZezmbI1BYQb7EXVjeJMYllsxxx8Xm7+Ibgvq97ISsvtLcoUkpQ+hmXX8fO9shXIObizF3Mdh/ZB0kYGYwF6v1P9Mr2MR29sL2RqRAUR9IJy2tmq+BBXYJq62OonH41WMdYltvw1nji9vmRTT2poCRqVstUG6FMJXkLYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897358; c=relaxed/simple;
	bh=wjK0yT5JPmEf5G2Uq8EHfLJmZLzi7OMsEXbamwKy40E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/o/Wux+9ekHR1NnoARrj++TcPwDpFYhSkVQUqkCrbW9TP49sO0hZ800j8IWq2S1ZHa7C0dO2OP3xV9kXeNKnnpDNx9rKGkHLZAFLbIT7F7nJLO7Yb1xbr//CWRTgfH+gIptexm4JsM9fh3ggh2SMD8PnYvObfsD52yrOnQ3fwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HwLHPqCn; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 15:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727897353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWJ9pxxtWMmCuuRCPO5AlhR0Cmnz0wTRR6c9OG5nDe4=;
	b=HwLHPqCnuo/0K8UQx/5hWY8jqN2/WFm/ZRg6TGLahWBSywoyMsmL2PV8boYh+Xa3dC85JI
	7WF7uQq2bS3sYpPs1Tibh3BhBasPAQQgoszJiKv9kJdY5vy+D9jsG3F1NwIA9KUerFr1ag
	V14M72Qo7cq0osy9x2y/TbxqDNb29yc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <3lukwhxkfyqz5xsp4r7byjejrgvccm76azw37pmudohvxcxqld@kiwf5f5vjshk>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv098heGHOtGfw1R@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 02, 2024 at 10:34:58PM GMT, Dave Chinner wrote:
> On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> > On Wed, Oct 02, 2024 at 11:33:17AM GMT, Dave Chinner wrote:
> > > What do people think of moving towards per-sb inode caching and
> > > traversal mechanisms like this?
> > 
> > Patches 1-4 are great cleanups that I would like us to merge even
> > independent of the rest.
> 
> Yes, they make it much easier to manage the iteration code.
> 
> > I don't have big conceptual issues with the series otherwise. The only
> > thing that makes me a bit uneasy is that we are now providing an api
> > that may encourage filesystems to do their own inode caching even if
> > they don't really have a need for it just because it's there.  So really
> > a way that would've solved this issue generically would have been my
> > preference.
> 
> Well, that's the problem, isn't it? :/
> 
> There really isn't a good generic solution for global list access
> and management.  The dlist stuff kinda works, but it still has
> significant overhead and doesn't get rid of spinlock contention
> completely because of the lack of locality between list add and
> remove operations.

There is though; I haven't posted it yet because it still needs some
work, but the concept works and performs about the same as dlock-list.

https://evilpiepirate.org/git/bcachefs.git/log/?h=fast_list

The thing that needs to be sorted before posting is that it can't shrink
the radix tree. generic-radix-tree doesn't support shrinking, and I
could add that, but then ida doesn't provide a way to query the highest
id allocated (xarray doesn't support backwards iteration).

So I'm going to try it using idr and see how that performs (idr is not
really the right data structure for this, split ida and item radix tree
is better, so might end up doing something else).

But - this approach with more work will work for the list_lru lock
contention as well.

From 32cb8103ecfacdd5ed8e1eb390221c3f8339de6f Mon Sep 17 00:00:00 2001
From: Kent Overstreet <kent.overstreet@linux.dev>
Date: Sat, 28 Sep 2024 16:22:38 -0400
Subject: [PATCH] lib/fast_list.c

A fast "list" data structure, which is actually a radix tree, with an
IDA for slot allocation and a percpu buffer on top of that.

Items cannot be added or moved to the head or tail, only added at some
(arbitrary) position and removed. The advantage is that adding, removing
and iteration is generally lockless, only hitting the lock in ida when
the percpu buffer is full or empty.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/include/linux/fast_list.h b/include/linux/fast_list.h
new file mode 100644
index 000000000000..7d5d8592864d
--- /dev/null
+++ b/include/linux/fast_list.h
@@ -0,0 +1,22 @@
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
+	struct fast_list_pcpu	*buffer;
+};
+
+int fast_list_get_idx(struct fast_list *l);
+int fast_list_add(struct fast_list *l, void *item);
+void fast_list_remove(struct fast_list *l, unsigned idx);
+void fast_list_exit(struct fast_list *l);
+int fast_list_init(struct fast_list *l);
+
+#endif /* _LINUX_FAST_LIST_H */
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..85cf5a0d36b1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -49,7 +49,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o bitmap-str.o
+	 generic-radix-tree.o bitmap-str.o fast_list.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
diff --git a/lib/fast_list.c b/lib/fast_list.c
new file mode 100644
index 000000000000..bbb69bb29687
--- /dev/null
+++ b/lib/fast_list.c
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
+#include <linux/fast_list.h>
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

