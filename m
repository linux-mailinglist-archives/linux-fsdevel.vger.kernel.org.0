Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0B58E122
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 22:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiHIUba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbiHIUb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:31:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A61120A1;
        Tue,  9 Aug 2022 13:31:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so13782179wrp.10;
        Tue, 09 Aug 2022 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4RoVrzLiNKX6VDp/f62qoJyNcP2XJ4q15O/NDEL7778=;
        b=lkZhYyPgtFaS6YtKt5H5hYrG5AVbOFuIz95B5ht09D2GSg3hOj7wpSxlfBVtoJqwrn
         PYXcR/qNpFpGPM9+7uaFt7mgfECaEXvdvnfuqJ5yAKPb2ST1O2hIud7SWa7taZJM61P4
         xO1EUwsF31uPwdpHVlKGV9VD+aZvRZEUe5yXtI786GkNtvF/O/mWP9lhN0RJd00B4wKd
         pz/51LJ69l3qSabGdfjzqu3IvHmikZOOSb9WB0AA+UXjFqR0bL1fAERZd6AWM05/s8ZA
         fE8+Ni1lw5zmmH6/PF0qecHOKeYECYDl8h3j8l85jZd8EP0PEZ48egdW11cVkFNvOiOX
         MOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RoVrzLiNKX6VDp/f62qoJyNcP2XJ4q15O/NDEL7778=;
        b=teYoSNdaf8hIo5cumhESx+SWNYetTj2VCvd/IdzKbjRlwER1oZyaSoXC/VpGU4l8tS
         YttWZuJGhNb1c8u1gwVcZ41TlQm/n4Zy0ioKMbO1Xv9bideoQ4rzJ+w3S3hVKtcGCC9Q
         kmxsYiM6PXdtvdN7pjQLcNVqE7iNrmEAysNi04jTp+FsZsRu1R6o3MgE9bgiNQsh6u1N
         clqVPAbgAn2MDzhcZ3vqtoLxEwticgIleaoFqBhhJxNJTgOyPJlQEKB5K99e1rbkuLxc
         bh5lNmXduUTQ79BWBiHstfnKuvL0i1v+y7hIDVUtWDjn3jIJryFUDUWSoKpKEge1vLWO
         YPFw==
X-Gm-Message-State: ACgBeo2ql8v6ulHuNEadBJ1XyMZ5zj+cPmF5MnfA8IRvvtnMLJZUA3nT
        6vgdt7bE5H1UwcT6l/oIJxo=
X-Google-Smtp-Source: AA6agR5jKgSMlbxVcnogE6rDdMjBvtHP7Haktd0R03K2SIj/vC8FhAmzTo4wVE+6lm5MHnLWrPNhFg==
X-Received: by 2002:adf:fb86:0:b0:21e:3cc8:a917 with SMTP id a6-20020adffb86000000b0021e3cc8a917mr16005778wrr.538.1660077077874;
        Tue, 09 Aug 2022 13:31:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id ck15-20020a5d5e8f000000b002205f0890eesm15085263wrb.77.2022.08.09.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:31:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hfsplus: Convert kmap() to kmap_local_page() in bnode.c
Date:   Tue,  9 Aug 2022 22:31:03 +0200
Message-Id: <20220809203105.26183-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809203105.26183-1-fmdefrancesco@gmail.com>
References: <20220809203105.26183-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/bnode.c | 105 +++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 57 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index a5ab00e54220..87974d5e6791 100644
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
@@ -498,14 +491,14 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
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
@@ -589,14 +582,12 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
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

