Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB28658DAF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiHIPU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiHIPUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:20:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA745DF8;
        Tue,  9 Aug 2022 08:20:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id uj29so22919084ejc.0;
        Tue, 09 Aug 2022 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pC0OF0AjNsXgSTVwqSglN9wjX2Yvl3xwZ360yloval8=;
        b=YShFCzczr8rVFsopDHAs3m3b02Qzc0k10OMegHVryz7M9Ek0lJh9zlG9kLjWspm9jc
         vfPOx8yFHOQBaGYPVoaRYchiizkiICPxQRFnOheD1NjdCwKeHX1u7dPeHtwtyNUwZD6i
         8WYm2sooCw95qAzCShpZxQ9nZsoGrebYGy1KpFRqSQQwe5TbiJLKAHfvzT5QYNFP0kW/
         CRaP++Aa8OEpfNQeluJQsOKJm0xPO04uLkAWKmjTXLNUJRFvjyyIe5MY4YfWzhlV8Vkg
         0o47ej2qj4ZdJ7aXFG/Db7fNd+/ilZ8DKEH4XdVEaBI+HXj/EizO0GtFE7obYjkPftsI
         S28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pC0OF0AjNsXgSTVwqSglN9wjX2Yvl3xwZ360yloval8=;
        b=w4L46EMgZBYzTGbXXDeu6sLpZuGlClInIm9fL/4N5H/T2OIFyca3fyyLPivdiZpHHc
         tRnwvB0oK3yqc9qQyryk8U5w/1K5lLDKC0EYQV9evt8hMZobmWP/xI+k0ryRgin3Yua5
         h3urcke5HjAVVd8t0inNwg0h8Z7EQ0XgH3peA3hDyu04NzpygiCFKBV+1SyfZACF2i5w
         CnNSnK3JZe4s3/ZZLLzCHeVoX5LMPAUW8K8uB74JD5Wt07pGmZDoomJmp+wIw8dYK4Us
         cFZoiZCI3numD3yTjNuQmmgmrdyhT7N8WHyiWcCqqnbyT24gGsN8jwRnUvHwNruokmGO
         04kg==
X-Gm-Message-State: ACgBeo2MaQWJ4auOcoKdOnnNhGaCUEKDjlv71yB+UzvPLjL0YQrRlb//
        UI5/o0+6lZQ8z5Mfg6P3ugA=
X-Google-Smtp-Source: AA6agR6YsEEC7pc6ZbIgWfQqy/IxlAdSlmWSf5loKdES2e0ihuNJ80w6bVz2eLoWZ1n16Dn07zd6ZQ==
X-Received: by 2002:a17:907:2722:b0:731:201a:df9c with SMTP id d2-20020a170907272200b00731201adf9cmr11586077ejl.149.1660058418213;
        Tue, 09 Aug 2022 08:20:18 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906721500b0073093eaf53esm1222162ejk.131.2022.08.09.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:20:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/3] hfs: Replace kmap() with kmap_local_page() in bnode.c
Date:   Tue,  9 Aug 2022 17:20:03 +0200
Message-Id: <20220809152004.9223-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809152004.9223-1-fmdefrancesco@gmail.com>
References: <20220809152004.9223-1-fmdefrancesco@gmail.com>
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

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfs/bnode.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index c83fd0e8404d..2015e42e752a 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -21,7 +21,6 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	int pagenum;
 	int bytes_read;
 	int bytes_to_read;
-	void *vaddr;
 
 	off += node->page_offset;
 	pagenum = off >> PAGE_SHIFT;
@@ -33,9 +32,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 		page = node->page[pagenum];
 		bytes_to_read = min_t(int, len - bytes_read, PAGE_SIZE - off);
 
-		vaddr = kmap_atomic(page);
-		memcpy(buf + bytes_read, vaddr + off, bytes_to_read);
-		kunmap_atomic(vaddr);
+		memcpy_from_page(buf + bytes_read, page, off, bytes_to_read);
 
 		pagenum++;
 		off = 0; /* page offset only applies to the first page */
@@ -80,8 +77,7 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	off += node->page_offset;
 	page = node->page[0];
 
-	memcpy(kmap(page) + off, buf, len);
-	kunmap(page);
+	memcpy_to_page(page, off, buf, len);
 	set_page_dirty(page);
 }
 
@@ -105,8 +101,7 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	off += node->page_offset;
 	page = node->page[0];
 
-	memset(kmap(page) + off, 0, len);
-	kunmap(page);
+	memzero_page(page, off, len);
 	set_page_dirty(page);
 }
 
@@ -123,9 +118,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	src_page = src_node->page[0];
 	dst_page = dst_node->page[0];
 
-	memcpy(kmap(dst_page) + dst, kmap(src_page) + src, len);
-	kunmap(src_page);
-	kunmap(dst_page);
+	memcpy_page(dst_page, dst, src_page, src, len);
 	set_page_dirty(dst_page);
 }
 
@@ -140,9 +133,9 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	src += node->page_offset;
 	dst += node->page_offset;
 	page = node->page[0];
-	ptr = kmap(page);
+	ptr = kmap_local_page(page);
 	memmove(ptr + dst, ptr + src, len);
-	kunmap(page);
+	kunmap_local(ptr);
 	set_page_dirty(page);
 }
 
@@ -346,13 +339,14 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 	if (!test_bit(HFS_BNODE_NEW, &node->flags))
 		return node;
 
-	desc = (struct hfs_bnode_desc *)(kmap(node->page[0]) + node->page_offset);
+	desc = (struct hfs_bnode_desc *)(kmap_local_page(node->page[0]) +
+					 node->page_offset);
 	node->prev = be32_to_cpu(desc->prev);
 	node->next = be32_to_cpu(desc->next);
 	node->num_recs = be16_to_cpu(desc->num_recs);
 	node->type = desc->type;
 	node->height = desc->height;
-	kunmap(node->page[0]);
+	kunmap_local(desc);
 
 	switch (node->type) {
 	case HFS_NODE_HEADER:
@@ -436,14 +430,12 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	}
 
 	pagep = node->page;
-	memset(kmap(*pagep) + node->page_offset, 0,
-	       min((int)PAGE_SIZE, (int)tree->node_size));
+	memzero_page(*pagep, node->page_offset,
+		     min((int)PAGE_SIZE, (int)tree->node_size));
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

