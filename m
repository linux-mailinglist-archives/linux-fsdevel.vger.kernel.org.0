Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEFA6FCC29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjEIRAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjEIQ7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:59:08 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643776581
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xn5bEL0Ei0eSLZ8JURgH14o2MvwdOSnzFDfE6+pvE7w=;
        b=V93/4IxdB6R1oDyNyXn+vk/3B37TkkxMELqTGRTHIdvE7v0ldmbzKSzJngOfYgV6W6nktq
        6gemnOZwcnJwZ+kRszXRAdPyc6IAAKQfnfywGr1CjONwF7cgLuph94sKOvHMVxnGQn4zEB
        2zXtaZe0mueWaZ7xrmXdVfPRpV15W24=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 25/32] lib/generic-radix-tree.c: Don't overflow in peek()
Date:   Tue,  9 May 2023 12:56:50 -0400
Message-Id: <20230509165657.1735798-26-kent.overstreet@linux.dev>
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

From: Kent Overstreet <kent.overstreet@gmail.com>

When we started spreading new inode numbers throughout most of the 64
bit inode space, that triggered some corner case bugs, in particular
some integer overflows related to the radix tree code. Oops.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/generic-radix-tree.h |  6 ++++++
 lib/generic-radix-tree.c           | 17 ++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 107613f7d7..63080822dc 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -184,6 +184,12 @@ void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
 static inline void __genradix_iter_advance(struct genradix_iter *iter,
 					   size_t obj_size)
 {
+	if (iter->offset + obj_size < iter->offset) {
+		iter->offset	= SIZE_MAX;
+		iter->pos	= SIZE_MAX;
+		return;
+	}
+
 	iter->offset += obj_size;
 
 	if (!is_power_of_2(obj_size) &&
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index f25eb111c0..7dfa88282b 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -166,6 +166,10 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 	struct genradix_root *r;
 	struct genradix_node *n;
 	unsigned level, i;
+
+	if (iter->offset == SIZE_MAX)
+		return NULL;
+
 restart:
 	r = READ_ONCE(radix->root);
 	if (!r)
@@ -184,10 +188,17 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 			(GENRADIX_ARY - 1);
 
 		while (!n->children[i]) {
+			size_t objs_per_ptr = genradix_depth_size(level);
+
+			if (iter->offset + objs_per_ptr < iter->offset) {
+				iter->offset	= SIZE_MAX;
+				iter->pos	= SIZE_MAX;
+				return NULL;
+			}
+
 			i++;
-			iter->offset = round_down(iter->offset +
-					   genradix_depth_size(level),
-					   genradix_depth_size(level));
+			iter->offset = round_down(iter->offset + objs_per_ptr,
+						  objs_per_ptr);
 			iter->pos = (iter->offset >> PAGE_SHIFT) *
 				objs_per_page;
 			if (i == GENRADIX_ARY)
-- 
2.40.1

