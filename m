Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC075125F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGLVNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjGLVM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:28 -0400
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8A271F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZhmCl+n4yHEwTa1THztHgqHnTTx5bTorYdBdx9eWUk=;
        b=ar1/5lc8IAM7Z8BzOkLoU2YlkHGHAS4kG+QX0/lExGk2OoopvseIafuYmBhl6W1Zx04myh
        UrotI8xhx5WzEasXrp5tb/o83g6LqYA7F97RfuOWZzOD0DukizF0612so6eQyI/eC2mleu
        VRzaexEyVeM+X9m529dxxdoNvTHItdc=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 20/20] lib/generic-radix-tree.c: Add peek_prev()
Date:   Wed, 12 Jul 2023 17:11:15 -0400
Message-Id: <20230712211115.2174650-21-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This patch adds genradix_peek_prev(), genradix_iter_rewind(), and
genradix_for_each_reverse(), for iterating backwards over a generic
radix tree.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/generic-radix-tree.h | 61 +++++++++++++++++++++++++++++-
 lib/generic-radix-tree.c           | 59 +++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index f6cd0f909d..c74b737699 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -117,6 +117,11 @@ static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
 
 #define __genradix_cast(_radix)		(typeof((_radix)->type[0]) *)
 #define __genradix_obj_size(_radix)	sizeof((_radix)->type[0])
+#define __genradix_objs_per_page(_radix)			\
+	(PAGE_SIZE / sizeof((_radix)->type[0]))
+#define __genradix_page_remainder(_radix)			\
+	(PAGE_SIZE % sizeof((_radix)->type[0]))
+
 #define __genradix_idx_to_offset(_radix, _idx)			\
 	__idx_to_offset(_idx, __genradix_obj_size(_radix))
 
@@ -180,7 +185,25 @@ void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
 #define genradix_iter_peek(_iter, _radix)			\
 	(__genradix_cast(_radix)				\
 	 __genradix_iter_peek(_iter, &(_radix)->tree,		\
-			      PAGE_SIZE / __genradix_obj_size(_radix)))
+			__genradix_objs_per_page(_radix)))
+
+void *__genradix_iter_peek_prev(struct genradix_iter *, struct __genradix *,
+				size_t, size_t);
+
+/**
+ * genradix_iter_peek - get first entry at or below iterator's current
+ *			position
+ * @_iter:	a genradix_iter
+ * @_radix:	genradix being iterated over
+ *
+ * If no more entries exist at or below @_iter's current position, returns NULL
+ */
+#define genradix_iter_peek_prev(_iter, _radix)			\
+	(__genradix_cast(_radix)				\
+	 __genradix_iter_peek_prev(_iter, &(_radix)->tree,	\
+			__genradix_objs_per_page(_radix),	\
+			__genradix_obj_size(_radix) +		\
+			__genradix_page_remainder(_radix)))
 
 static inline void __genradix_iter_advance(struct genradix_iter *iter,
 					   size_t obj_size)
@@ -203,6 +226,25 @@ static inline void __genradix_iter_advance(struct genradix_iter *iter,
 #define genradix_iter_advance(_iter, _radix)			\
 	__genradix_iter_advance(_iter, __genradix_obj_size(_radix))
 
+static inline void __genradix_iter_rewind(struct genradix_iter *iter,
+					  size_t obj_size)
+{
+	if (iter->offset == 0 ||
+	    iter->offset == SIZE_MAX) {
+		iter->offset = SIZE_MAX;
+		return;
+	}
+
+	if ((iter->offset & (PAGE_SIZE - 1)) == 0)
+		iter->offset -= PAGE_SIZE % obj_size;
+
+	iter->offset -= obj_size;
+	iter->pos--;
+}
+
+#define genradix_iter_rewind(_iter, _radix)			\
+	__genradix_iter_rewind(_iter, __genradix_obj_size(_radix))
+
 #define genradix_for_each_from(_radix, _iter, _p, _start)	\
 	for (_iter = genradix_iter_init(_radix, _start);	\
 	     (_p = genradix_iter_peek(&_iter, _radix)) != NULL;	\
@@ -220,6 +262,23 @@ static inline void __genradix_iter_advance(struct genradix_iter *iter,
 #define genradix_for_each(_radix, _iter, _p)			\
 	genradix_for_each_from(_radix, _iter, _p, 0)
 
+#define genradix_last_pos(_radix)				\
+	(SIZE_MAX / PAGE_SIZE * __genradix_objs_per_page(_radix) - 1)
+
+/**
+ * genradix_for_each_reverse - iterate over entry in a genradix, reverse order
+ * @_radix:	genradix to iterate over
+ * @_iter:	a genradix_iter to track current position
+ * @_p:		pointer to genradix entry type
+ *
+ * On every iteration, @_p will point to the current entry, and @_iter.pos
+ * will be the current entry's index.
+ */
+#define genradix_for_each_reverse(_radix, _iter, _p)		\
+	for (_iter = genradix_iter_init(_radix,	genradix_last_pos(_radix));\
+	     (_p = genradix_iter_peek_prev(&_iter, _radix)) != NULL;\
+	     genradix_iter_rewind(&_iter, _radix))
+
 int __genradix_prealloc(struct __genradix *, size_t, gfp_t);
 
 /**
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 7dfa88282b..41f1bcdc44 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -1,4 +1,5 @@
 
+#include <linux/atomic.h>
 #include <linux/export.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/gfp.h>
@@ -212,6 +213,64 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 }
 EXPORT_SYMBOL(__genradix_iter_peek);
 
+void *__genradix_iter_peek_prev(struct genradix_iter *iter,
+				struct __genradix *radix,
+				size_t objs_per_page,
+				size_t obj_size_plus_page_remainder)
+{
+	struct genradix_root *r;
+	struct genradix_node *n;
+	unsigned level, i;
+
+	if (iter->offset == SIZE_MAX)
+		return NULL;
+
+restart:
+	r = READ_ONCE(radix->root);
+	if (!r)
+		return NULL;
+
+	n	= genradix_root_to_node(r);
+	level	= genradix_root_to_depth(r);
+
+	if (ilog2(iter->offset) >= genradix_depth_shift(level)) {
+		iter->offset = genradix_depth_size(level);
+		iter->pos = (iter->offset >> PAGE_SHIFT) * objs_per_page;
+
+		iter->offset -= obj_size_plus_page_remainder;
+		iter->pos--;
+	}
+
+	while (level) {
+		level--;
+
+		i = (iter->offset >> genradix_depth_shift(level)) &
+			(GENRADIX_ARY - 1);
+
+		while (!n->children[i]) {
+			size_t objs_per_ptr = genradix_depth_size(level);
+
+			iter->offset = round_down(iter->offset, objs_per_ptr);
+			iter->pos = (iter->offset >> PAGE_SHIFT) * objs_per_page;
+
+			if (!iter->offset)
+				return NULL;
+
+			iter->offset -= obj_size_plus_page_remainder;
+			iter->pos--;
+
+			if (!i)
+				goto restart;
+			--i;
+		}
+
+		n = n->children[i];
+	}
+
+	return &n->data[iter->offset & (PAGE_SIZE - 1)];
+}
+EXPORT_SYMBOL(__genradix_iter_peek_prev);
+
 static void genradix_free_recurse(struct genradix_node *n, unsigned level)
 {
 	if (level) {
-- 
2.40.1

