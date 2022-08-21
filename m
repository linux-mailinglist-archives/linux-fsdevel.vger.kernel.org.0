Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6D759B5C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiHUSER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiHUSEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:04:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707CD1D0E6;
        Sun, 21 Aug 2022 11:04:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ca13so6082758ejb.9;
        Sun, 21 Aug 2022 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xvYbbgr6M/luqTV703HLx2cmWfU4tDlaXdSaXZbUyHM=;
        b=NUegbYQwz3FF2aGh1cFNGBkpLo2y3gwRRMzeE1sVCpowYI6s+4kXQFeI3xFhgysf5B
         AoNg7joEpp3YrZE+ptzmsZsw5RAdOjmC2hQHzDZyRVlBu7OEI+EmLL8hb7VwqOuc/Msr
         5Tfhk3Tzzv8DVV81fzDgNFLp/MfCEXADbEqjHqUUtCCxQQy2Rf6lP3u1g/91N+PqOKIy
         Sfbdnx0y8LpGJlHa1C4j9JtElaiqthEemAcFBxYwvoz9VEp4E5xScHmRtohs7Tm+vjqh
         df8f76DkiCOqvyYbg6L8qCPAXWxV2/HQlwBjd0IiSnN1yd+NJkZM9TOFYD57m//e3BHN
         6YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xvYbbgr6M/luqTV703HLx2cmWfU4tDlaXdSaXZbUyHM=;
        b=H0RiZfl1fk3FHy+p40kY193fOxtjBHmKsCAvUhqSy5PQ7ZnRwtbEzLu0QZ3V4EHExb
         azkENh5hv8K1x6U3VfuBsveMckK/OcQSNZ6RAosKdjsz91d5NeKFRkB1NWiUs4AA395W
         AS6oejNp2GsYRG+e4zeqXp2mxmW5kTNPdFUN3xLx/CLompidE3FSdyYYoC0VyAwSXseS
         iCgh1D3NTt1Nl6DS5f0mJI3GtQUzq5kAadQRXwLjB1F6bbYvYatZBcXmpAz4vg1Y5fg7
         aFJ3k3IrGXFmq8A3Mw9Cxq+gWQ6ouVYj/4RcbsCFvJs94uK9MZi6wb+o0X7tid9JdQtq
         RlXg==
X-Gm-Message-State: ACgBeo1Pe80LU2h8huD6NHoOe/6gC5AMAp4GAPW2HrGawae6Ws+cL0kz
        7wqtP4jqo8/0rRcC1DH58VE=
X-Google-Smtp-Source: AA6agR7vxJJpgxqTGpKAOFSGxqLF6P8Ma3cXL8yHW+VhYE/crTz0WFt1ftrG4JcMJoq9+uXjEHgXVQ==
X-Received: by 2002:a17:906:6a03:b0:730:a20e:cf33 with SMTP id qw3-20020a1709066a0300b00730a20ecf33mr11154941ejc.620.1661105051992;
        Sun, 21 Aug 2022 11:04:11 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007317f017e64sm5125916ejg.134.2022.08.21.11.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:04:10 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Layton <jlayton@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RESEND PATCH 2/3] hfs: Replace kmap() with kmap_local_page() in bnode.c
Date:   Sun, 21 Aug 2022 20:03:59 +0200
Message-Id: <20220821180400.8198-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821180400.8198-1-fmdefrancesco@gmail.com>
References: <20220821180400.8198-1-fmdefrancesco@gmail.com>
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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
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

