Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5686759B5C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiHUSEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiHUSER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:04:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9A1D0E6;
        Sun, 21 Aug 2022 11:04:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h22so7084524ejk.4;
        Sun, 21 Aug 2022 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w6SKvkLC4OBu3WKKHSHiRs3Yoxkr5LqytzcXu+IR0Bs=;
        b=LdYa0R0lJzFpxj8ot+zbbW9UGIqeRqepnRaEQw597edLKf24TLkrr+xgvmMWQLcQF+
         6xmYOVupoN/dW5kwLJZhRCueK5c9jbG+RAby3Y1+EP/Pp8kfXCMGI6gyJC89esPytIBP
         l+byrhTCfdItcaPTGvzJQ+CctrD7xh2FHPN0aeJXjlFhLMR2R8Tgl9q/wKvb9ZE3LJ7v
         MZLiEX48SqLVhQxuIk7xc4I7B1PP7ATLNdeQY8LBiPn4nPodxiGDDjwh3DlL3K09pkSQ
         ANfXcMBFRj8oWcuRN0F1vt8VVdsW1j8Nr15YqE7IekemrCjvIUWA2Ky8wqLYAu4eeUUF
         GTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w6SKvkLC4OBu3WKKHSHiRs3Yoxkr5LqytzcXu+IR0Bs=;
        b=xIlXS/p+GmCLqGubcPoY64G4uFQmv0xozemmPpwtGgIwjNLuO5h/exLiZC5yb1AZTO
         EpQfslGr5ZDsNLl0GAZKj3oSFaLJ0xvxYtf2Yuqy2DQ9fL0jYua7ybGdgBpdtPSuLQ/b
         ZUIvcLAjdIhQ33JzefFBJucP4pYv/3bTOItpG6VYKYKVr122VvTeVwNqYGWAZ4nWiKOh
         GgPriKJBTFdSbghO09v7fY98Afj8Grlrw2HCCEsUHhdc7HzK/pyslpXcUS0Hn1yogCbG
         zieqkK0TShefZq5XmML9B+jB85r9sWgIIRqnC8lnXZcy4cEwfGIE7JIWl0v/xNrn0Bj8
         Y74w==
X-Gm-Message-State: ACgBeo22+CKs31Sb6L3MiHm8UAOiomGOtlJ0aKus5/69JDf8UCOBru1V
        0WlrPc8GDSwTK3cBWFaUQN4=
X-Google-Smtp-Source: AA6agR73A7CjUFJiPOVLItJqC0yGGoK6vDTYLjGrbWCULimfKAqhuDPYG9RVpRjlj/xQcVj5PHrDUA==
X-Received: by 2002:a17:906:ee89:b0:73d:70c5:1a4e with SMTP id wt9-20020a170906ee8900b0073d70c51a4emr2822482ejb.683.1661105054970;
        Sun, 21 Aug 2022 11:04:14 -0700 (PDT)
Received: from localhost.localdomain (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709061ba900b007317f017e64sm5125916ejg.134.2022.08.21.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:04:13 -0700 (PDT)
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
Subject: [RESEND PATCH 3/3] hfs: Replace kmap() with kmap_local_page() in btree.c
Date:   Sun, 21 Aug 2022 20:04:00 +0200
Message-Id: <20220821180400.8198-4-fmdefrancesco@gmail.com>
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

Since its use in btree.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in btree.c. Where
possible, use the suited standard helpers (memzero_page(), memcpy_page())
instead of open coding kmap_local_page() plus memset() or memcpy().

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfs/btree.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 56c6782436e9..2fa4b1f8cc7f 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -80,7 +80,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 		goto free_inode;
 
 	/* Load the header */
-	head = (struct hfs_btree_header_rec *)(kmap(page) + sizeof(struct hfs_bnode_desc));
+	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
+					       sizeof(struct hfs_bnode_desc));
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
 	tree->leaf_head = be32_to_cpu(head->leaf_head);
@@ -119,12 +120,12 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	tree->node_size_shift = ffs(size) - 1;
 	tree->pages_per_bnode = (tree->node_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	kunmap(page);
+	kunmap_local(head);
 	put_page(page);
 	return tree;
 
 fail_page:
-	kunmap(page);
+	kunmap_local(head);
 	put_page(page);
 free_inode:
 	tree->inode->i_mapping->a_ops = &hfs_aops;
@@ -170,7 +171,8 @@ void hfs_btree_write(struct hfs_btree *tree)
 		return;
 	/* Load the header */
 	page = node->page[0];
-	head = (struct hfs_btree_header_rec *)(kmap(page) + sizeof(struct hfs_bnode_desc));
+	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
+					       sizeof(struct hfs_bnode_desc));
 
 	head->root = cpu_to_be32(tree->root);
 	head->leaf_count = cpu_to_be32(tree->leaf_count);
@@ -181,7 +183,7 @@ void hfs_btree_write(struct hfs_btree *tree)
 	head->attributes = cpu_to_be32(tree->attributes);
 	head->depth = cpu_to_be16(tree->depth);
 
-	kunmap(page);
+	kunmap_local(head);
 	set_page_dirty(page);
 	hfs_bnode_put(node);
 }
@@ -269,7 +271,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap(*pagep);
+	data = kmap_local_page(*pagep);
 	off &= ~PAGE_MASK;
 	idx = 0;
 
@@ -282,7 +284,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 						idx += i;
 						data[off] |= m;
 						set_page_dirty(*pagep);
-						kunmap(*pagep);
+						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
 						hfs_bnode_put(node);
@@ -291,14 +293,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
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
 			printk(KERN_DEBUG "create new bmap node...\n");
@@ -314,7 +316,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		off = off16;
 		off += node->page_offset;
 		pagep = node->page + (off >> PAGE_SHIFT);
-		data = kmap(*pagep);
+		data = kmap_local_page(*pagep);
 		off &= ~PAGE_MASK;
 	}
 }
@@ -361,20 +363,20 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	}
 	off += node->page_offset + nidx / 8;
 	page = node->page[off >> PAGE_SHIFT];
-	data = kmap(page);
+	data = kmap_local_page(page);
 	off &= ~PAGE_MASK;
 	m = 1 << (~nidx & 7);
 	byte = data[off];
 	if (!(byte & m)) {
 		pr_crit("trying to free free bnode %u(%d)\n",
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

