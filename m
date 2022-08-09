Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7E58E124
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbiHIUbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiHIUb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:31:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDECF13DD6;
        Tue,  9 Aug 2022 13:31:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so15538130wrs.9;
        Tue, 09 Aug 2022 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f3+n0Fr4Dmr0J8VHjNmeb+vPcJAaEfynrop3hOhGh8g=;
        b=QdEZ4HrX4KDml4KQBZ/oxM902Rc1z6+W9ZamXWr85PjuzWIhiqn8iOr+pBQkCXoZjJ
         UymUYqSj7bHXo43TViMugq8IaWLVBJ1ELpNHLTF1/CAXmRIvUZX7etWdBNAVia6mngLH
         2pDtKDzxwGJ+16NZyTHMc5AbMN74AP42a8wVhIVjUY3lCD/um66HnBXOgpQW5kCzLRDo
         mnND5kNRpST5jdL1pHSzurdeBHx3ZhafdwsjKQciLEbO9dQDZv+2SFcZjhhrYt1w2Gs5
         idLjJhgKUdAaWqGI/JG0g47ILSqqkFQtxGqVrW1XxUc6J7ojNp0AheMeHMJk4ThgYhzD
         f2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3+n0Fr4Dmr0J8VHjNmeb+vPcJAaEfynrop3hOhGh8g=;
        b=nNziE377GqdMtTenQiur4pXZYhGYKr6xFh7dXK+5Z30YwgJqghoCnK41B0vUZD3PG2
         XrxHy6r430j8J5yGezzlT55uF0TVKs56Iu9z6SJWNXYD1hu6LSx49KUVpLYJoWUqTzN+
         OQSDQ+6WZYdrrU7xMMaxRik6RJGXJIf8kIobDdXL5p+cK3jrKnPbZtaAGo472vhRZli9
         jUfzYIi+ptMIGrHhq1REXXzAm8R4iOebBGhORfkaYBQjW88q51ONXZfAskll78hb9MMv
         3WDrOvuoHfC3ecEACk8nw65tp9nUC1ObOr7+RD5+KROF0FXq8zA1+s30T2tYtabBDXye
         HMVQ==
X-Gm-Message-State: ACgBeo3yEGV5vEZG9gMEy9IQVmKDQ5qCxEdeXglwguAFQ4soHTCTd26k
        d1+PQCYspccVpD5xXA0WhW8=
X-Google-Smtp-Source: AA6agR6AkcBeH5RcZED8BkmM34nQ5n0eFMEQVEtsjzoODsgzyOYZDjkkbylWyD1nmrASXPHroZhLyA==
X-Received: by 2002:a05:6000:78d:b0:220:6259:2874 with SMTP id bu13-20020a056000078d00b0022062592874mr15613809wrb.678.1660077083332;
        Tue, 09 Aug 2022 13:31:23 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id ck15-20020a5d5e8f000000b002205f0890eesm15085263wrb.77.2022.08.09.13.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:31:22 -0700 (PDT)
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
Subject: [PATCH 4/4] hfsplus: Convert kmap() to kmap_local_page() in btree.c
Date:   Tue,  9 Aug 2022 22:31:05 +0200
Message-Id: <20220809203105.26183-5-fmdefrancesco@gmail.com>
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

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in btree.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in btree.c.

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Cc: Viacheslav Dubeyko <slava@dubeyko.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfsplus/btree.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 3a917a9a4edd..9e1732a2b92a 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -163,7 +163,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		goto free_inode;
 
 	/* Load the header */
-	head = (struct hfs_btree_header_rec *)(kmap(page) +
+	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
 		sizeof(struct hfs_bnode_desc));
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
@@ -240,12 +240,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 		(tree->node_size + PAGE_SIZE - 1) >>
 		PAGE_SHIFT;
 
-	kunmap(page);
+	kunmap_local(head);
 	put_page(page);
 	return tree;
 
  fail_page:
-	kunmap(page);
+	kunmap_local(head);
 	put_page(page);
  free_inode:
 	tree->inode->i_mapping->a_ops = &hfsplus_aops;
@@ -292,7 +292,7 @@ int hfs_btree_write(struct hfs_btree *tree)
 		return -EIO;
 	/* Load the header */
 	page = node->page[0];
-	head = (struct hfs_btree_header_rec *)(kmap(page) +
+	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
 		sizeof(struct hfs_bnode_desc));
 
 	head->root = cpu_to_be32(tree->root);
@@ -304,7 +304,7 @@ int hfs_btree_write(struct hfs_btree *tree)
 	head->attributes = cpu_to_be32(tree->attributes);
 	head->depth = cpu_to_be16(tree->depth);
 
-	kunmap(page);
+	kunmap_local(head);
 	set_page_dirty(page);
 	hfs_bnode_put(node);
 	return 0;
@@ -395,7 +395,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap(*pagep);
+	data = kmap_local_page(*pagep);
 	off &= ~PAGE_MASK;
 	idx = 0;
 
@@ -408,7 +408,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 						idx += i;
 						data[off] |= m;
 						set_page_dirty(*pagep);
-						kunmap(*pagep);
+						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
 						hfs_bnode_put(node);
@@ -418,14 +418,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 				}
 			}
 			if (++off >= PAGE_SIZE) {
-				kunmap(*pagep);
-				data = kmap(*++pagep);
+				kunmap_local(data);
+				data = kmap_local_page(*++pagep);
 				off = 0;
 			}
 			idx += 8;
 			len--;
 		}
-		kunmap(*pagep);
+		kunmap_local(data);
 		nidx = node->next;
 		if (!nidx) {
 			hfs_dbg(BNODE_MOD, "create new bmap node\n");
@@ -441,7 +441,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		off = off16;
 		off += node->page_offset;
 		pagep = node->page + (off >> PAGE_SHIFT);
-		data = kmap(*pagep);
+		data = kmap_local_page(*pagep);
 		off &= ~PAGE_MASK;
 	}
 }
@@ -491,7 +491,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	}
 	off += node->page_offset + nidx / 8;
 	page = node->page[off >> PAGE_SHIFT];
-	data = kmap(page);
+	data = kmap_local_page(page);
 	off &= ~PAGE_MASK;
 	m = 1 << (~nidx & 7);
 	byte = data[off];
@@ -499,13 +499,13 @@ void hfs_bmap_free(struct hfs_bnode *node)
 		pr_crit("trying to free free bnode "
 				"%u(%d)\n",
 			node->this, node->type);
-		kunmap(page);
+		kunmap_local(data);
 		hfs_bnode_put(node);
 		return;
 	}
 	data[off] = byte & ~m;
 	set_page_dirty(page);
-	kunmap(page);
+	kunmap_local(data);
 	hfs_bnode_put(node);
 	tree->free_nodes++;
 	mark_inode_dirty(tree->inode);
-- 
2.37.1

