Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C857BAB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiGTPni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbiGTPnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:43:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AAE61727;
        Wed, 20 Jul 2022 08:43:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1024356wmq.3;
        Wed, 20 Jul 2022 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9XFtyZUBEmHSP0UKPB3JvGrjlF5rk62miW3xWOoCcU=;
        b=dwQxSlk4cBpogZUFk7SH/pLOiscmOGSBzx9BkiUArsno4SfljApp9rbDpciAGsEwLb
         i0a5rBV8GYkOviAoOtNxvGNorQz0Nq1ot84VrQdkeIL+hlIxkla3FLWbhNonb46oIvux
         EkI28GDorLGGBephBjEgmRuQy7tf54dPrMSVQuDLn0Sd5RguQ9uYfHdLtV33Trj6DBFJ
         2xGhoFSlqZIe21XIgs2mmejDy+RGW32vTyTjZSmxAsQuQtbAZR3uN4QQgj+5k0h68QDj
         JNSDlqwVd1f8E2MaofrHpo/gu19I6K6+MT4MWiLGSsj5ZF+6AXhqXa/WBvVMbdixLNkp
         d8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9XFtyZUBEmHSP0UKPB3JvGrjlF5rk62miW3xWOoCcU=;
        b=PFQY0M7C3CHEu6DyOsuu52BYPBfPBe4Y8AB6lV6q5dFuTDRd0bSXskoDXJbSJ8uTKd
         8kioXZYXdhRImJMsZwTcmqms3hENjQg9UFwlpyHqQcA327saBGqXOf1F+gS7jLi4N/zb
         cD/I0xM0KTTs61E+oWiO4or3iQNrJ9j1Br7SVesycwZX3+FzGhq02rGShDVI6cqUR5cj
         v3HLibrUC6zTLVsaFNxs94ewWQOxzF9Wj6xokvFTy2eDbjjif5v7mD0K9K/Wt7/RPqnH
         STCU/UYjuDwNH4g7IajKWS6O5pr1tFz8xF884+Su3WlmvxeGJN7bRrKOJ+omT01bTkl5
         W21g==
X-Gm-Message-State: AJIora/CouopED2ZXraP6Z2mF3vGfCkuS9EF5Mwwfnx/c6t5wsurn88K
        t5ORMBAVmBXY6pe7gkw7BpwzUYW0lp4=
X-Google-Smtp-Source: AGRyM1tXIzInCbxAYk/MRv2SxI7OsC7xPGxDaL1I09fZw9LRNHwqCKDyyHa0KDY6d1uJ/y2XwQxXHQ==
X-Received: by 2002:a05:600c:1e1e:b0:3a3:10f9:aa02 with SMTP id ay30-20020a05600c1e1e00b003a310f9aa02mr4343762wmb.124.1658331808994;
        Wed, 20 Jul 2022 08:43:28 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b0021e42e7c7dbsm4075322wrt.83.2022.07.20.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:43:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bnode.c
Date:   Wed, 20 Jul 2022 17:43:24 +0200
Message-Id: <20220720154324.8272-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

Two main problems with kmap(): (1) It comes with an overhead as mapping
space is restricted and protected by a global lock for synchronization and
(2) it also requires global TLB invalidation when the kmap’s pool wraps
and it might block when the mapping space is fully utilized until a slot
becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in bnode.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in bnode.c. Where
possible, use the suited standard helpers (memzero_page(), memcpy_page())
instead of open coding kmap_local_page() plus memset() or memcpy().

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/bnode.c | 105 +++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 57 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 177fae4e6581..3a1c77d0df48 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -29,14 +29,12 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	off &= ~PAGE_MASK;
 
 	l = min_t(int, len, PAGE_SIZE - off);
-	memcpy(buf, kmap(*pagep) + off, l);
-	kunmap(*pagep);
+	memcpy_from_page(buf, *pagep, off, l);
 
 	while ((len -= l) != 0) {
 		buf += l;
 		l = min_t(int, len, PAGE_SIZE);
-		memcpy(buf, kmap(*++pagep), l);
-		kunmap(*pagep);
+		memcpy_from_page(buf, *++pagep, 0, l);
 	}
 }
 
@@ -82,16 +80,14 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	off &= ~PAGE_MASK;
 
 	l = min_t(int, len, PAGE_SIZE - off);
-	memcpy(kmap(*pagep) + off, buf, l);
+	memcpy_to_page(*pagep, off, buf, l);
 	set_page_dirty(*pagep);
-	kunmap(*pagep);
 
 	while ((len -= l) != 0) {
 		buf += l;
 		l = min_t(int, len, PAGE_SIZE);
-		memcpy(kmap(*++pagep), buf, l);
+		memcpy_to_page(*++pagep, 0, buf, l);
 		set_page_dirty(*pagep);
-		kunmap(*pagep);
 	}
 }
 
@@ -112,15 +108,13 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	off &= ~PAGE_MASK;
 
 	l = min_t(int, len, PAGE_SIZE - off);
-	memset(kmap(*pagep) + off, 0, l);
+	memzero_page(*pagep, off, l);
 	set_page_dirty(*pagep);
-	kunmap(*pagep);
 
 	while ((len -= l) != 0) {
 		l = min_t(int, len, PAGE_SIZE);
-		memset(kmap(*++pagep), 0, l);
+		memzero_page(*++pagep, 0, l);
 		set_page_dirty(*pagep);
-		kunmap(*pagep);
 	}
 }
 
@@ -142,24 +136,20 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 
 	if (src == dst) {
 		l = min_t(int, len, PAGE_SIZE - src);
-		memcpy(kmap(*dst_page) + src, kmap(*src_page) + src, l);
-		kunmap(*src_page);
+		memcpy_page(*dst_page, src, *src_page, src, l);
 		set_page_dirty(*dst_page);
-		kunmap(*dst_page);
 
 		while ((len -= l) != 0) {
 			l = min_t(int, len, PAGE_SIZE);
-			memcpy(kmap(*++dst_page), kmap(*++src_page), l);
-			kunmap(*src_page);
+			memcpy_page(*++dst_page, 0, *++src_page, 0, l);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
 		}
 	} else {
 		void *src_ptr, *dst_ptr;
 
 		do {
-			src_ptr = kmap(*src_page) + src;
-			dst_ptr = kmap(*dst_page) + dst;
+			dst_ptr = kmap_local_page(*dst_page) + dst;
+			src_ptr = kmap_local_page(*src_page) + src;
 			if (PAGE_SIZE - src < PAGE_SIZE - dst) {
 				l = PAGE_SIZE - src;
 				src = 0;
@@ -171,9 +161,9 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 			}
 			l = min(len, l);
 			memcpy(dst_ptr, src_ptr, l);
-			kunmap(*src_page);
+			kunmap_local(src_ptr);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
+			kunmap_local(dst_ptr);
 			if (!dst)
 				dst_page++;
 			else
@@ -185,6 +175,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 {
 	struct page **src_page, **dst_page;
+	void *src_ptr, *dst_ptr;
 	int l;
 
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
@@ -202,27 +193,28 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 
 		if (src == dst) {
 			while (src < len) {
-				memmove(kmap(*dst_page), kmap(*src_page), src);
-				kunmap(*src_page);
+				dst_ptr = kmap_local_page(*dst_page);
+				src_ptr = kmap_local_page(*src_page);
+				memmove(dst_ptr, src_ptr, src);
+				kunmap_local(src_ptr);
 				set_page_dirty(*dst_page);
-				kunmap(*dst_page);
+				kunmap_local(dst_ptr);
 				len -= src;
 				src = PAGE_SIZE;
 				src_page--;
 				dst_page--;
 			}
 			src -= len;
-			memmove(kmap(*dst_page) + src,
-				kmap(*src_page) + src, len);
-			kunmap(*src_page);
+			dst_ptr = kmap_local_page(*dst_page);
+			src_ptr = kmap_local_page(*src_page);
+			memmove(dst_ptr + src, src_ptr + src, len);
+			kunmap_local(src_ptr);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
+			kunmap_local(dst_ptr);
 		} else {
-			void *src_ptr, *dst_ptr;
-
 			do {
-				src_ptr = kmap(*src_page) + src;
-				dst_ptr = kmap(*dst_page) + dst;
+				dst_ptr = kmap_local_page(*dst_page) + dst;
+				src_ptr = kmap_local_page(*src_page) + src;
 				if (src < dst) {
 					l = src;
 					src = PAGE_SIZE;
@@ -234,9 +226,9 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 				}
 				l = min(len, l);
 				memmove(dst_ptr - l, src_ptr - l, l);
-				kunmap(*src_page);
+				kunmap_local(src_ptr);
 				set_page_dirty(*dst_page);
-				kunmap(*dst_page);
+				kunmap_local(dst_ptr);
 				if (dst == PAGE_SIZE)
 					dst_page--;
 				else
@@ -251,26 +243,27 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 
 		if (src == dst) {
 			l = min_t(int, len, PAGE_SIZE - src);
-			memmove(kmap(*dst_page) + src,
-				kmap(*src_page) + src, l);
-			kunmap(*src_page);
+
+			dst_ptr = kmap_local_page(*dst_page) + src;
+			src_ptr = kmap_local_page(*src_page) + src;
+			memmove(dst_ptr, src_ptr, l);
+			kunmap_local(src_ptr);
 			set_page_dirty(*dst_page);
-			kunmap(*dst_page);
+			kunmap_local(dst_ptr);
 
 			while ((len -= l) != 0) {
 				l = min_t(int, len, PAGE_SIZE);
-				memmove(kmap(*++dst_page),
-					kmap(*++src_page), l);
-				kunmap(*src_page);
+				dst_ptr = kmap_local_page(*++dst_page);
+				src_ptr = kmap_local_page(*++src_page);
+				memmove(dst_ptr, src_ptr, l);
+				kunmap_local(src_ptr);
 				set_page_dirty(*dst_page);
-				kunmap(*dst_page);
+				kunmap_local(dst_ptr);
 			}
 		} else {
-			void *src_ptr, *dst_ptr;
-
 			do {
-				src_ptr = kmap(*src_page) + src;
-				dst_ptr = kmap(*dst_page) + dst;
+				dst_ptr = kmap_local_page(*dst_page) + dst;
+				src_ptr = kmap_local_page(*src_page) + src;
 				if (PAGE_SIZE - src <
 						PAGE_SIZE - dst) {
 					l = PAGE_SIZE - src;
@@ -283,9 +276,9 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 				}
 				l = min(len, l);
 				memmove(dst_ptr, src_ptr, l);
-				kunmap(*src_page);
+				kunmap_local(src_ptr);
 				set_page_dirty(*dst_page);
-				kunmap(*dst_page);
+				kunmap_local(dst_ptr);
 				if (!dst)
 					dst_page++;
 				else
@@ -502,14 +495,14 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 	if (!test_bit(HFS_BNODE_NEW, &node->flags))
 		return node;
 
-	desc = (struct hfs_bnode_desc *)(kmap(node->page[0]) +
-			node->page_offset);
+	desc = (struct hfs_bnode_desc *)(kmap_local_page(node->page[0]) +
+							 node->page_offset);
 	node->prev = be32_to_cpu(desc->prev);
 	node->next = be32_to_cpu(desc->next);
 	node->num_recs = be16_to_cpu(desc->num_recs);
 	node->type = desc->type;
 	node->height = desc->height;
-	kunmap(node->page[0]);
+	kunmap_local(desc);
 
 	switch (node->type) {
 	case HFS_NODE_HEADER:
@@ -593,14 +586,12 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	}
 
 	pagep = node->page;
-	memset(kmap(*pagep) + node->page_offset, 0,
-	       min_t(int, PAGE_SIZE, tree->node_size));
+	memzero_page(*pagep, node->page_offset,
+		     min_t(int, PAGE_SIZE, tree->node_size));
 	set_page_dirty(*pagep);
-	kunmap(*pagep);
 	for (i = 1; i < tree->pages_per_bnode; i++) {
-		memset(kmap(*++pagep), 0, PAGE_SIZE);
+		memzero_page(*++pagep, 0, PAGE_SIZE);
 		set_page_dirty(*pagep);
-		kunmap(*pagep);
 	}
 	clear_bit(HFS_BNODE_NEW, &node->flags);
 	wake_up(&node->lock_wq);
-- 
2.37.1

