Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807BA6A2660
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBYBTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBYBRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9717CF7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:28 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y184so798240oiy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2cwP2vpbYW44JitUfrxO8oWbr3F8ymhSAf3P0Fo/B8=;
        b=VcfqaeQBk9P+SlUofyvgDTNDg74ioHa3Jsn5/O9S9P0EFXT8gw3Ib/P4o/MKFZRMli
         FKKhyDNzIaPfE716OuVv5GCmYQdY3SVeT/QF5eZXGwFWlIE8oBAUbnzfWm8BUDij//W9
         JJIqNbWVRc1HVd43RpWJ0zCh+AD+l678OPR0Ao+ItfqiFkuffZ6CztkM9yZPWSp5r/lr
         usy5/IxytJ8HUuCPgaTlRdEukMcRXgt/lAi+/Da6qG+k0Qn3/aFJHtY5FFOw5BQNTpaR
         8GWYKkWO2LYj9zHxVgwIfbU0d6pmN32oynO68iwOVp7KWR+fKOVYwXar+rJFj/npScZo
         A9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2cwP2vpbYW44JitUfrxO8oWbr3F8ymhSAf3P0Fo/B8=;
        b=W+wCQpngnKm+CDiqvuj4VmxhDk8FNL+LlKPzn4Na6/aBsiqgy9yiFws0FtLpHsNlb2
         o3YNyTi2p2h3UxgN16ox1SK4ZyHzSdrFKeaLxvUDPGV06xPTqAAUihhQm1yBC0ASjtq0
         Sy857dbOuZJN95nkoyp19vDS4H1fEMh/SZ4aWHxxOYvrHAcD8dEWOn0Y7bNCzIFNDT5q
         uIVjjW/Bc5zswMOYRVkfQgZmtXfeDICmvMfzEWUIQ6qZqX4/9f7OObT2cgZvX743kDGt
         HpI8ezmjtiVMyiKVtN5jCAEEv/iqoz4/tstlyKJw7RVtlsI9uDZHFggNNEgPIYl9T3UG
         QkGw==
X-Gm-Message-State: AO0yUKU8U49d0Bga26hyblGTLdFyGxoQief7OW+JqMqg9gOYB5c4CSMC
        4gpO+IQdi0Dt/f9e8+Gimbt40bYkdHM1hwjK
X-Google-Smtp-Source: AK7set+xZsalrCkTENSemTheTEIoXwYAFA6F1+Bd/ES9QfmtfNd90wzddJbFTTEU+mZbHf7QRafZ7Q==
X-Received: by 2002:a05:6808:a81:b0:378:2ac9:b7bc with SMTP id q1-20020a0568080a8100b003782ac9b7bcmr4495933oij.56.1677287846933;
        Fri, 24 Feb 2023 17:17:26 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:26 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 53/76] ssdfs: search/allocate/insert b-tree node operations
Date:   Fri, 24 Feb 2023 17:09:04 -0800
Message-Id: <20230225010927.813929-54-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

B-tree node implements search, allocation, and insert item or
range of items in the node:
(1) find_item - find item in b-tree node
(2) find_range - find range of items in b-tree node
(3) allocate_item - allocate item in b-tree node
(4) allocate_range - allocate range of items in b-tree node
(5) insert_item - insert/add item into b-tree node
(6) insert_range - insert/add range of items into b-tree node

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_node.c | 3135 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 3135 insertions(+)

diff --git a/fs/ssdfs/btree_node.c b/fs/ssdfs/btree_node.c
index f4402cb8df64..aa9d90ba8598 100644
--- a/fs/ssdfs/btree_node.c
+++ b/fs/ssdfs/btree_node.c
@@ -8207,3 +8207,3138 @@ int ssdfs_btree_node_change_index(struct ssdfs_btree_node *node,
 
 	return err;
 }
+
+/*
+ * ssdfs_btree_root_node_delete_index() - delete index record from root node
+ * @node: node object
+ * @position: position in the node of the deleting index record
+ *
+ * This method tries to delete the index record from the root node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_root_node_delete_index(struct ssdfs_btree_node *node,
+					u16 position)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("index 0: node_id %u; index 1: node_id %u\n",
+		  cpu_to_le32(node->raw.root_node.header.node_ids[0]),
+		  cpu_to_le32(node->raw.root_node.header.node_ids[1]));
+	SSDFS_DBG("node_id %u, position %u\n",
+		  node->node_id, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->index_area.index_count > node->index_area.index_capacity) {
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+		return -ERANGE;
+	}
+
+	if (position >= node->index_area.index_count) {
+		SSDFS_ERR("invalid position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	if (node->index_area.index_count == 0) {
+		SSDFS_WARN("index_count == 0\n");
+		return -ERANGE;
+	}
+
+	switch (position) {
+	case SSDFS_ROOT_NODE_LEFT_LEAF_NODE:
+		if ((position + 1) < node->index_area.index_count) {
+			node->index_area.start_hash = node->index_area.end_hash;
+			ssdfs_memcpy(&node->raw.root_node.indexes[position],
+				     0, index_size,
+				     &node->raw.root_node.indexes[position + 1],
+				     0, index_size,
+				     index_size);
+			memset(&node->raw.root_node.indexes[position + 1], 0xFF,
+				index_size);
+			node->raw.root_node.header.node_ids[position + 1] =
+							cpu_to_le32(U32_MAX);
+		} else {
+			node->index_area.start_hash = U64_MAX;
+			node->index_area.end_hash = U64_MAX;
+			memset(&node->raw.root_node.indexes[position], 0xFF,
+				index_size);
+			node->raw.root_node.header.node_ids[position] =
+							cpu_to_le32(U32_MAX);
+		}
+		break;
+
+	case SSDFS_ROOT_NODE_RIGHT_LEAF_NODE:
+		node->index_area.end_hash = node->index_area.start_hash;
+		memset(&node->raw.root_node.indexes[position], 0xFF,
+			index_size);
+		node->raw.root_node.header.node_ids[position] =
+						cpu_to_le32(U32_MAX);
+		break;
+
+	default:
+		BUG();
+	}
+
+	node->index_area.index_count--;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node->index_area.index_count %u\n",
+		  node->index_area.index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_delete_tail_index() - delete the tail index record
+ * @node: node object
+ * @position: position in the node of the deleting index record
+ * @ptr: index record before @position [out]
+ *
+ * This method tries to delete the tail index record from the common node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_common_node_delete_tail_index(struct ssdfs_btree_node *node,
+					      u16 position,
+					      struct ssdfs_btree_index_key *ptr)
+{
+	size_t index_size = sizeof(struct ssdfs_btree_index_key);
+	struct page *page;
+	u32 page_index;
+	u32 page_off;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u\n",
+		  node->node_id, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((position + 1) != node->index_area.index_count) {
+		SSDFS_ERR("cannot delete index: "
+			  "position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_memory_page(node, &node->index_area,
+					position,
+					&page_index, &page_off);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define memory page: "
+			  "node_id %u, position %u, err %d\n",
+			  node->node_id, position, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(page_index >= U32_MAX);
+	BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("page_index %u > pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	if ((page_off + index_size) > PAGE_SIZE) {
+		SSDFS_ERR("invalid page_off %u\n",
+			  page_off);
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+	ssdfs_lock_page(page);
+	ssdfs_memset_page(page, page_off, PAGE_SIZE,
+			  0xFF, index_size);
+	ssdfs_unlock_page(page);
+
+	if (position == 0)
+		memset(ptr, 0xFF, index_size);
+	else {
+		err = ssdfs_define_memory_page(node, &node->index_area,
+						position - 1,
+						&page_index, &page_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define memory page: "
+				  "node_id %u, position %u, err %d\n",
+				  node->node_id, position - 1, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(page_index >= U32_MAX);
+		BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("page_index %u > pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		page = node->content.pvec.pages[page_index];
+		ssdfs_lock_page(page);
+		ssdfs_memcpy_from_page(ptr, 0, index_size,
+					page, page_off, PAGE_SIZE,
+					index_size);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_remove_index() - remove the index record
+ * @node: node object
+ * @position: position in the node of the deleting index record
+ * @ptr: index record on @position after deletion [out]
+ *
+ * This method tries to delete the index record from the common node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_common_node_remove_index(struct ssdfs_btree_node *node,
+					 u16 position,
+					 struct ssdfs_btree_index_key *ptr)
+{
+	struct ssdfs_btree_index_key buffer;
+	struct page *page;
+	void *kaddr;
+	u32 page_index;
+	u32 page_off;
+	u16 cur_pos = position;
+	u8 index_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !ptr);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u\n",
+		  node->node_id, position);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!((position + 1) < node->index_area.index_count)) {
+		SSDFS_ERR("cannot remove index: "
+			  "position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	index_size = node->index_area.index_size;
+	if (index_size != sizeof(struct ssdfs_btree_index_key)) {
+		SSDFS_ERR("invalid index_size %u\n",
+			  index_size);
+		return -ERANGE;
+	}
+
+	do {
+		u32 rest_capacity;
+		u32 moving_count;
+		u32 moving_bytes;
+
+		err = ssdfs_define_memory_page(node, &node->index_area,
+						cur_pos,
+						&page_index, &page_off);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to define memory page: "
+				  "node_id %u, position %u, err %d\n",
+				  node->node_id, cur_pos, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("cur_pos %u, page_index %u, page_off %u\n",
+			  cur_pos, page_index, page_off);
+
+		BUG_ON(page_index >= U32_MAX);
+		BUG_ON(page_off >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		rest_capacity = PAGE_SIZE - (page_off + index_size);
+		rest_capacity /= index_size;
+
+		moving_count = node->index_area.index_count - (cur_pos + 1);
+		moving_count = min_t(u32, moving_count, rest_capacity);
+		moving_bytes = moving_count * index_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("rest_capacity %u, index_count %u, "
+			  "moving_count %u, moving_bytes %u\n",
+			  rest_capacity,
+			  node->index_area.index_count,
+			  moving_count, moving_bytes);
+
+		if ((page_off + index_size) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "page_off %u, index_size %u\n",
+				   page_off, index_size);
+			return -ERANGE;
+		}
+
+		if ((page_off + moving_bytes) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "page_off %u, moving_bytes %u\n",
+				   page_off, moving_bytes);
+			return -ERANGE;
+		}
+
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("page_index %u > pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = node->content.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_lock_page(page);
+		kaddr = kmap_local_page(page);
+
+		if (moving_count == 0) {
+			err = ssdfs_memcpy(&buffer, 0, index_size,
+					   kaddr, page_off, PAGE_SIZE,
+					   index_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				goto finish_copy;
+			}
+
+			memset((u8 *)kaddr + page_off, 0xFF, index_size);
+		} else {
+			err = ssdfs_memcpy(&buffer, 0, index_size,
+					   kaddr, page_off, PAGE_SIZE,
+					   index_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				goto finish_copy;
+			}
+
+			err = ssdfs_memmove(kaddr,
+					    page_off, PAGE_SIZE,
+					    kaddr,
+					    page_off + index_size, PAGE_SIZE,
+					    moving_bytes);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				goto finish_copy;
+			}
+
+			memset((u8 *)kaddr + page_off + moving_bytes,
+				0xFF, index_size);
+		}
+
+		if (cur_pos == position) {
+			err = ssdfs_memcpy(ptr, 0, index_size,
+					   kaddr, page_off, PAGE_SIZE,
+					   index_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				goto finish_copy;
+			}
+		}
+
+finish_copy:
+		flush_dcache_page(page);
+		kunmap_local(kaddr);
+		ssdfs_unlock_page(page);
+
+		if (unlikely(err))
+			return err;
+
+		if (cur_pos != position) {
+			err = ssdfs_define_memory_page(node, &node->index_area,
+							cur_pos - 1,
+							&page_index, &page_off);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to define memory page: "
+					  "node_id %u, position %u, err %d\n",
+					  node->node_id, cur_pos - 1, err);
+				return err;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("cur_pos %u, page_index %u, page_off %u\n",
+				  cur_pos, page_index, page_off);
+
+			BUG_ON(page_index >= U32_MAX);
+			BUG_ON(page_off >= U32_MAX);
+
+			if ((page_off + index_size) > PAGE_SIZE) {
+				SSDFS_WARN("invalid offset: "
+					   "page_off %u, index_size %u\n",
+					   page_off, index_size);
+				return -ERANGE;
+			}
+
+			if (page_index >= pagevec_count(&node->content.pvec)) {
+				SSDFS_ERR("page_index %u > pvec_size %u\n",
+					  page_index,
+					  pagevec_count(&node->content.pvec));
+				return -ERANGE;
+			}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			page = node->content.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_lock_page(page);
+			err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+						   &buffer, 0, index_size,
+						   index_size);
+			ssdfs_unlock_page(page);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy: err %d\n", err);
+				return err;
+			}
+		}
+
+		cur_pos += moving_count + 1;
+	} while (cur_pos < node->index_area.index_count);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_common_node_delete_index() - delete the index record
+ * @node: node object
+ * @position: position in the node of the deleting index record
+ *
+ * This method tries to delete the index record from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_common_node_delete_index(struct ssdfs_btree_node *node,
+					 u16 position)
+{
+	struct ssdfs_btree_index_key buffer;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, position %u, index_count %u\n",
+		  node->node_id, position,
+		  node->index_area.index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->index_area.index_count > node->index_area.index_capacity) {
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+		return -ERANGE;
+	}
+
+	if (node->index_area.index_count == 0) {
+		SSDFS_WARN("index_count == 0\n");
+		return -ERANGE;
+	}
+
+	if (position >= node->index_area.index_count) {
+		SSDFS_ERR("invalid index place: "
+			  "position %u, index_count %u\n",
+			  position,
+			  node->index_area.index_count);
+		return -ERANGE;
+	}
+
+	if ((position + 1) == node->index_area.index_count) {
+		err = ssdfs_btree_common_node_delete_tail_index(node, position,
+								&buffer);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete index: "
+				  "node_id %u, position %u, err %d\n",
+				  node->node_id, position, err);
+			return err;
+		}
+	} else {
+		err = ssdfs_btree_common_node_remove_index(node, position,
+							   &buffer);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to remove index: "
+				  "node_id %u, position %u, err %d\n",
+				  node->node_id, position, err);
+			return err;
+		}
+	}
+
+	node->index_area.index_count--;
+
+	switch (node->tree->type) {
+	case SSDFS_INODES_BTREE:
+		/* keep the index range unchanged */
+		goto finish_common_node_delete_index;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	if (node->index_area.index_count == 0) {
+		node->index_area.start_hash = U64_MAX;
+		node->index_area.end_hash = U64_MAX;
+	} else {
+		if (position == 0) {
+			node->index_area.start_hash =
+					le64_to_cpu(buffer.index.hash);
+		} else if (position == node->index_area.index_count) {
+			node->index_area.end_hash =
+					le64_to_cpu(buffer.index.hash);
+		}
+	}
+
+finish_common_node_delete_index:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "index_count %u, index_capacity %u\n",
+		  node->index_area.start_hash,
+		  node->index_area.end_hash,
+		  node->index_area.index_count,
+		  node->index_area.index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * need_shrink_index_area() - check that index area should be shrinked
+ * @node: node object
+ * @new_size: new size of the node after shrinking [out]
+ */
+static
+bool need_shrink_index_area(struct ssdfs_btree_node *node, u32 *new_size)
+{
+	u16 index_area_min_size;
+	u16 count, capacity;
+	u8 index_size;
+	bool need_check_size = false;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !new_size);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*new_size = U32_MAX;
+	index_area_min_size = node->tree->index_area_min_size;
+
+	down_read(&node->header_lock);
+	count = node->index_area.index_count;
+	capacity = node->index_area.index_capacity;
+	index_size = node->index_area.index_size;
+	if (capacity == 0)
+		err = -ERANGE;
+	if (count > capacity)
+		err = -ERANGE;
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_WARN("count %u > capacity %u\n",
+			   count, capacity);
+		return false;
+	}
+
+	if (index_area_min_size == 0 || index_area_min_size % index_size) {
+		SSDFS_WARN("invalid index size: "
+			   "index_area_min_size %u, index_size %u\n",
+			   index_area_min_size, index_size);
+		return false;
+	}
+
+	if (count == 0)
+		need_check_size = true;
+	else
+		need_check_size = ((capacity / count) >= 2);
+
+	if (need_check_size) {
+		*new_size = (capacity / 2) * index_size;
+		if (*new_size >= index_area_min_size)
+			return true;
+		else
+			*new_size = U32_MAX;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("count %u, capacity %u, index_size %u, "
+		  "index_area_min_size %u, new_size %u\n",
+		  count, capacity, index_size,
+		  index_area_min_size, *new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return false;
+}
+
+/*
+ * ssdfs_btree_node_delete_index() - delete existing index
+ * @node: node object
+ * @hash: hash value
+ *
+ * This method tries to delete index for @hash from node's
+ * index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node's index area doesn't contain index for @hash.
+ * %-ENOENT     - node hasn't the index area.
+ * %-EFAULT     - corrupted node's index area.
+ * %-EACCES     - node is under initialization yet.
+ */
+int ssdfs_btree_node_delete_index(struct ssdfs_btree_node *node,
+				  u64 hash)
+{
+	struct ssdfs_fs_info *fsi;
+	int node_type;
+	u16 found = U16_MAX;
+	u16 count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, hash %llx\n",
+		  node->node_id, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (hash == U64_MAX) {
+		SSDFS_ERR("invalid hash %llx\n", hash);
+		return -ERANGE;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node_type = atomic_read(&node->type);
+	if (node_type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    node_type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  node_type);
+		return -ERANGE;
+	}
+
+	if (node_type == SSDFS_BTREE_ROOT_NODE) {
+		down_read(&node->full_lock);
+		down_write(&node->header_lock);
+
+		err = ssdfs_find_index_by_hash(node, &node->index_area,
+						hash, &found);
+		if (err == -EEXIST) {
+			/* hash == found hash */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find an index: "
+				  "node_id %u, hash %llx, err %d\n",
+				  node->node_id, hash, err);
+			goto finish_change_root_node;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found == U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_btree_root_node_delete_index(node, found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete index: "
+				  "node_id %u, node_type %#x, "
+				  "found_index %u, err %d\n",
+				  node->node_id, node_type,
+				  found, err);
+		}
+
+finish_change_root_node:
+		up_write(&node->header_lock);
+		up_read(&node->full_lock);
+
+		if (unlikely(err))
+			return err;
+	} else {
+		down_write(&node->full_lock);
+		down_write(&node->header_lock);
+
+		err = ssdfs_find_index_by_hash(node, &node->index_area,
+						hash, &found);
+		if (err == -EEXIST) {
+			/* hash == found hash */
+			err = 0;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find an index: "
+				  "node_id %u, hash %llx, err %d\n",
+				  node->node_id, hash, err);
+			up_write(&node->header_lock);
+			up_write(&node->full_lock);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(found == U16_MAX);
+
+		SSDFS_DBG("index_count %u, found %u\n",
+			  node->index_area.index_count, found);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		count = node->index_area.index_count - found;
+		err = ssdfs_lock_index_range(node, found, count);
+		BUG_ON(err == -ENODATA);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to lock index range: "
+				  "start %u, count %u, err %d\n",
+				  found, count, err);
+			up_write(&node->header_lock);
+			up_write(&node->full_lock);
+			return err;
+		}
+
+		downgrade_write(&node->full_lock);
+
+		err = ssdfs_btree_common_node_delete_index(node, found);
+		ssdfs_unlock_index_range(node, found, count);
+
+		if (!err)
+			err = ssdfs_set_dirty_index_range(node, found, count);
+
+		up_write(&node->header_lock);
+		up_read(&node->full_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete index: "
+				  "node_id %u, node_type %#x, "
+				  "found_index %u, err %d\n",
+				  node->node_id, node_type,
+				  found, err);
+		}
+	}
+
+	ssdfs_set_node_update_cno(node);
+	set_ssdfs_btree_node_dirty(node);
+
+	if (node_type != SSDFS_BTREE_ROOT_NODE) {
+		u32 new_size;
+
+		if (need_shrink_index_area(node, &new_size)) {
+			err = ssdfs_btree_node_resize_index_area(node,
+								 new_size);
+			if (err == -ENOSPC) {
+				err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("index area cannot be resized: "
+					  "node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to resize index area: "
+					  "node_id %u, new_size %u, err %d\n",
+					  node->node_id, new_size, err);
+				return err;
+			}
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "index_count %u, index_capacity %u\n",
+		  node->index_area.start_hash,
+		  node->index_area.end_hash,
+		  node->index_area.index_count,
+		  node->index_area.index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_move_root2common_node_index_range() - move index range (root -> common)
+ * @src: source node
+ * @src_start: starting index in the source node
+ * @dst: destination node
+ * @dst_start: starting index in the destination node
+ * @count: count of indexes in the range
+ *
+ * This method tries to move the index range from the source node
+ * into destination one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_move_root2common_node_index_range(struct ssdfs_btree_node *src,
+					    u16 src_start,
+					    struct ssdfs_btree_node *dst,
+					    u16 dst_start, u16 count)
+{
+	struct ssdfs_fs_info *fsi;
+	int i, j;
+	int upper_bound;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!src || !dst);
+	BUG_ON(!src->tree || !src->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&src->tree->lock));
+
+	if (!is_ssdfs_btree_node_index_area_exist(src)) {
+		SSDFS_DBG("src node %u hasn't index area\n",
+			  src->node_id);
+		return -EINVAL;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(dst)) {
+		SSDFS_DBG("dst node %u hasn't index area\n",
+			  dst->node_id);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&src->type) != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_ERR("invalid src node type %#x\n",
+			  atomic_read(&src->type));
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("src_node %u, src_start %u, "
+		  "dst_node %u, dst_start %u, "
+		  "count %u\n",
+		  src->node_id, src_start,
+		  dst->node_id, dst_start, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = src->tree->fsi;
+
+	if (src_start >= SSDFS_BTREE_ROOT_NODE_INDEX_COUNT) {
+		SSDFS_ERR("invalid src_start %u\n",
+			  src_start);
+		return -ERANGE;
+	}
+
+	if (count == 0) {
+		SSDFS_ERR("count is zero\n");
+		return -ERANGE;
+	}
+
+	atomic_set(&src->state, SSDFS_BTREE_NODE_CREATED);
+	atomic_set(&dst->state, SSDFS_BTREE_NODE_CREATED);
+
+	count = min_t(u16, count,
+		      SSDFS_BTREE_ROOT_NODE_INDEX_COUNT - src_start);
+
+	upper_bound = src_start + count;
+	for (i = src_start, j = dst_start; i < upper_bound; i++, j++) {
+		struct ssdfs_btree_index_key index;
+
+		down_write(&src->full_lock);
+
+		err = __ssdfs_btree_root_node_extract_index(src, i,
+							    &index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail extract index: "
+				  "index %u, err %d\n",
+				  i, err);
+		}
+
+		up_write(&src->full_lock);
+
+		if (unlikely(err)) {
+			atomic_set(&src->state, SSDFS_BTREE_NODE_CORRUPTED);
+			atomic_set(&dst->state, SSDFS_BTREE_NODE_CORRUPTED);
+			return err;
+		}
+
+		down_write(&dst->full_lock);
+
+		down_write(&dst->header_lock);
+		err = ssdfs_btree_common_node_add_index(dst, j, &index);
+		up_write(&dst->header_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert index: "
+				  "index %u, err %d\n",
+				  j, err);
+		}
+
+		up_write(&dst->full_lock);
+
+		if (unlikely(err)) {
+			atomic_set(&src->state, SSDFS_BTREE_NODE_CORRUPTED);
+			atomic_set(&dst->state, SSDFS_BTREE_NODE_CORRUPTED);
+			return err;
+		}
+	}
+
+	for (i = 0; i < count; i++) {
+		down_write(&src->full_lock);
+
+		down_write(&src->header_lock);
+		err = ssdfs_btree_root_node_delete_index(src, src_start);
+		up_write(&src->header_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to delete index: "
+				  "index %u, err %d\n",
+				  i, err);
+		}
+
+		up_write(&src->full_lock);
+
+		if (unlikely(err)) {
+			atomic_set(&src->state, SSDFS_BTREE_NODE_CORRUPTED);
+			atomic_set(&dst->state, SSDFS_BTREE_NODE_CORRUPTED);
+			return err;
+		}
+	}
+
+	ssdfs_set_node_update_cno(src);
+	set_ssdfs_btree_node_dirty(src);
+
+	ssdfs_set_node_update_cno(dst);
+	set_ssdfs_btree_node_dirty(dst);
+
+	return 0;
+}
+
+/*
+ * ssdfs_copy_index_range_in_buffer() - copy index range in buffer
+ * @node: node object
+ * @start: starting index in the node
+ * @count: requested count of indexes in the range
+ * @area_offset: offset of the index area in the node
+ * @index_size: size of the index in bytes
+ * @buf: pointer on buffer
+ * @range_len: pointer on value of count of indexes in the buffer [out]
+ *
+ * This method tries to copy the index range into  the buffer.
+ * If a current memory page of node contains lesser amount of indexes
+ * then @range_len will contain real number of indexes in the @buf.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_copy_index_range_in_buffer(struct ssdfs_btree_node *node,
+				     u16 start, u16 count,
+				     u32 area_offset, u16 index_size,
+				     struct ssdfs_btree_index_key *buf,
+				     u16 *range_len)
+{
+	struct page *page;
+	u32 offset;
+	u32 page_index;
+	u32 page_off;
+	u32 copy_bytes;
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+#endif /* CONFIG_SSDFS_DEBUG */
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !buf || !range_len);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("node %u, start %u, count %u\n",
+		  node->node_id, start, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count == 0) {
+		SSDFS_ERR("count is zero\n");
+		return -ERANGE;
+	}
+
+	*range_len = U16_MAX;
+
+	offset = area_offset + (start * index_size);
+	page_index = offset / PAGE_SIZE;
+	page_off = offset % PAGE_SIZE;
+
+	*range_len = PAGE_SIZE - page_off;
+	*range_len /= index_size;
+	*range_len = min_t(u32, *range_len, (u32)count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("offset %u, page_index %u, page_off %u\n",
+		  offset, page_index, page_off);
+	SSDFS_DBG("start %u, count %u, range_len %u\n",
+		  start, count, *range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (*range_len == 0) {
+		SSDFS_ERR("range_len == 0\n");
+		return -ERANGE;
+	}
+
+	copy_bytes = *range_len * index_size;
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("invalid page_index: "
+			  "page_index %u, pagevec %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+
+	if (!page) {
+		SSDFS_ERR("page is NULL\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_memcpy_from_page(buf, 0, PAGE_SIZE,
+				     page, page_off, PAGE_SIZE,
+				     copy_bytes);
+	if (unlikely(err)) {
+		SSDFS_ERR("buffer is too small: "
+			  "range_len %u, index_size %u, "
+			  "buf_size %lu\n",
+			  *range_len, index_size,
+			  PAGE_SIZE);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	for (i = 0; i < *range_len; i++) {
+		SSDFS_DBG("index %d, node_id %u, "
+			  "node_type %#x, height %u, "
+			  "flags %#x, hash %llx, seg_id %llu, "
+			  "logical_blk %u, len %u\n",
+			  i,
+			  le32_to_cpu(buf[i].node_id),
+			  buf[i].node_type,
+			  buf[i].height,
+			  le16_to_cpu(buf[i].flags),
+			  le64_to_cpu(buf[i].index.hash),
+			  le64_to_cpu(buf[i].index.extent.seg_id),
+			  le32_to_cpu(buf[i].index.extent.logical_blk),
+			  le32_to_cpu(buf[i].index.extent.len));
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_save_index_range_in_node() - save index range in the node
+ * @node: node object
+ * @start: starting index in the node
+ * @count: requested count of indexes in the range
+ * @area_offset: offset of the index area in the node
+ * @index_size: size of the index in bytes
+ * @buf: pointer on buffer
+ *
+ * This method tries to save the index range from @buf into @node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_save_index_range_in_node(struct ssdfs_btree_node *node,
+				  u16 start, u16 count,
+				  u32 area_offset, u16 index_size,
+				  struct ssdfs_btree_index_key *buf)
+{
+	struct page *page;
+	u32 offset;
+	u32 page_index;
+	u32 page_off;
+	int i;
+	u16 copied = 0;
+	u32 sub_range_len = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !buf);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("node %u, start %u, count %u\n",
+		  node->node_id, start, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count == 0) {
+		SSDFS_ERR("count is zero\n");
+		return -ERANGE;
+	}
+
+	i = start;
+
+	while (count > 0) {
+		offset = area_offset + (i * index_size);
+		page_index = offset / PAGE_SIZE;
+		page_off = offset % PAGE_SIZE;
+
+		sub_range_len = PAGE_SIZE - page_off;
+		sub_range_len /= index_size;
+		sub_range_len = min_t(u32, sub_range_len, count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("i %d, offset %u, page_index %u, "
+			  "page_off %u, sub_range_len %u\n",
+			  i, offset, page_index,
+			  page_off, sub_range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (sub_range_len == 0) {
+			SSDFS_ERR("invalid sub_range_len: "
+				  "i %d, count %u, "
+				  "page_index %u, page_off %u, "
+				  "sub_range_len %u\n",
+				  i, count, page_index, page_off,
+				  sub_range_len);
+			return -ERANGE;
+		}
+
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "page_index %u, pagevec %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		page = node->content.pvec.pages[page_index];
+
+		if (!page) {
+			SSDFS_ERR("page is NULL\n");
+			return -ERANGE;
+		}
+
+		if ((page_off + (sub_range_len * index_size)) > PAGE_SIZE) {
+			SSDFS_ERR("out of page: "
+				  "page_off %u, sub_range_len %u, "
+				  "index_size %u, page_size %lu\n",
+				  page_off, sub_range_len, index_size,
+				  PAGE_SIZE);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("i %u, count %u, page_index %u, "
+			  "page_off %u, copied %u, sub_range_len %u\n",
+			  i, count, page_index,
+			  page_off, copied, sub_range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_memcpy_to_page(page, page_off, PAGE_SIZE,
+					   buf, copied * index_size, PAGE_SIZE,
+					   sub_range_len * index_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("out of page: "
+				  "sub_range_len %u, index_size %u, "
+				  "page_size %lu\n",
+				  sub_range_len, index_size,
+				  PAGE_SIZE);
+			return err;
+		}
+
+		err = ssdfs_set_dirty_index_range(node, i,
+						  (u16)sub_range_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set dirty index range: "
+				  "start %u, len %u, err %d\n",
+				  i, sub_range_len, err);
+			return err;
+		}
+
+		i += sub_range_len;
+		copied += sub_range_len;
+		count -= sub_range_len;
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_clear_index_range_in_node() - clear index range in the node
+ * @node: node object
+ * @start: starting index in the node
+ * @count: requested count of indexes in the range
+ * @area_offset: offset of the index area in the node
+ * @index_size: size of the index in bytes
+ *
+ * This method tries to clear the index range into @node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_clear_index_range_in_node(struct ssdfs_btree_node *node,
+				    u16 start, u16 count,
+				    u32 area_offset, u16 index_size)
+{
+	struct page *page;
+	u32 offset;
+	u32 page_index;
+	u32 page_off;
+	int i;
+	u32 sub_range_len = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		SSDFS_DBG("node %u hasn't index area\n",
+			  node->node_id);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("node %u, start %u, count %u\n",
+		  node->node_id, start, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count == 0) {
+		SSDFS_ERR("count is zero\n");
+		return -ERANGE;
+	}
+
+	i = start;
+
+	while (count > 0) {
+		offset = area_offset + (i * index_size);
+		page_index = offset / PAGE_SIZE;
+		page_off = offset % PAGE_SIZE;
+
+		sub_range_len = PAGE_SIZE - page_off;
+		sub_range_len /= index_size;
+		sub_range_len = min_t(u32, sub_range_len, count);
+
+		if (sub_range_len == 0) {
+			SSDFS_ERR("invalid sub_range_len: "
+				  "i %d, count %u, "
+				  "page_index %u, page_off %u, "
+				  "sub_range_len %u\n",
+				  i, count, page_index, page_off,
+				  sub_range_len);
+			return -ERANGE;
+		}
+
+		if ((sub_range_len * index_size) > PAGE_SIZE) {
+			SSDFS_ERR("out of page: "
+				  "sub_range_len %u, index_size %u, "
+				  "page_size %lu\n",
+				  sub_range_len, index_size,
+				  PAGE_SIZE);
+			return -ERANGE;
+		}
+
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "page_index %u, pagevec %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		page = node->content.pvec.pages[page_index];
+
+		if (!page) {
+			SSDFS_ERR("page is NULL\n");
+			return -ERANGE;
+		}
+
+		if ((page_off + (sub_range_len * index_size)) > PAGE_SIZE) {
+			SSDFS_ERR("out of page: "
+				  "page_off %u, sub_range_len %u, "
+				  "index_size %u, page_size %lu\n",
+				  page_off, sub_range_len, index_size,
+				  PAGE_SIZE);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %u, count %u, page_index %u, "
+			  "page_off %u, sub_range_len %u\n",
+			  start, count, page_index,
+			  page_off, sub_range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_memset_page(page, page_off, PAGE_SIZE,
+				  0xFF, sub_range_len * index_size);
+
+		i += sub_range_len;
+		count -= sub_range_len;
+	};
+
+	return 0;
+}
+
+/*
+ * ssdfs_move_common2common_node_index_range() - move index range
+ * @src: source node
+ * @src_start: starting index in the source node
+ * @dst: destination node
+ * @dst_start: starting index in the destination node
+ * @count: count of indexes in the range
+ *
+ * This method tries to move the index range from the common node
+ * @src into the common node @dst.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_move_common2common_node_index_range(struct ssdfs_btree_node *src,
+					      u16 src_start,
+					      struct ssdfs_btree_node *dst,
+					      u16 dst_start, u16 count)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_index_key *buf;
+	u16 i, j;
+	u32 src_offset, dst_offset;
+	u32 src_area_size, dst_area_size;
+	u16 index_size;
+	u16 src_index_count, dst_index_count;
+	u16 dst_index_capacity;
+	u64 src_start_hash, src_end_hash;
+	u64 dst_start_hash, dst_end_hash;
+	u16 processed = 0;
+	u16 copied = 0;
+	u16 rest_unmoved = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!src || !dst);
+	BUG_ON(!src->tree || !src->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&src->tree->lock));
+
+	if (!is_ssdfs_btree_node_index_area_exist(src)) {
+		SSDFS_DBG("src node %u hasn't index area\n",
+			  src->node_id);
+		return -EINVAL;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(dst)) {
+		SSDFS_DBG("dst node %u hasn't index area\n",
+			  dst->node_id);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("src_node %u, src_start %u, "
+		  "dst_node %u, dst_start %u, "
+		  "count %u\n",
+		  src->node_id, src_start,
+		  dst->node_id, dst_start, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = src->tree->fsi;
+
+	if (count == 0) {
+		SSDFS_ERR("count is zero\n");
+		return -ERANGE;
+	}
+
+	buf = ssdfs_btree_node_kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf) {
+		SSDFS_ERR("fail to allocate buffer\n");
+		return -ERANGE;
+	}
+
+	atomic_set(&src->state, SSDFS_BTREE_NODE_CREATED);
+	atomic_set(&dst->state, SSDFS_BTREE_NODE_CREATED);
+
+	down_read(&src->header_lock);
+	src_offset = src->index_area.offset;
+	src_area_size = src->index_area.area_size;
+	index_size = src->index_area.index_size;
+	src_index_count = src->index_area.index_count;
+	src_start_hash = src->index_area.start_hash;
+	src_end_hash = src->index_area.end_hash;
+	up_read(&src->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("src_node %u, index_count %u, count %u\n",
+		  src->node_id, src_index_count, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&dst->header_lock);
+	dst_offset = dst->index_area.offset;
+	dst_area_size = dst->index_area.area_size;
+	dst_index_count = dst->index_area.index_count;
+	dst_index_capacity = dst->index_area.index_capacity;
+	dst_start_hash = dst->index_area.start_hash;
+	dst_end_hash = dst->index_area.end_hash;
+	up_read(&dst->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dst_node %u, index_count %u, "
+		  "count %u, dst_index_capacity %u\n",
+		  dst->node_id, dst_index_count,
+		  count, dst_index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((src_start + count) > src_index_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid count: "
+			  "src_start %u, count %u, "
+			  "src_index_count %u\n",
+			  src_start, count, src_index_count);
+		goto finish_index_moving;
+	}
+
+	if ((dst_index_count + count) > dst_index_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid count: "
+			  "dst_index_count %u, count %u, "
+			  "dst_index_capacity %u\n",
+			  dst_index_count, count,
+			  dst_index_capacity);
+		goto finish_index_moving;
+	}
+
+	i = src_start;
+	j = dst_start;
+
+	down_write(&src->full_lock);
+	err = ssdfs_lock_whole_index_area(src);
+	downgrade_write(&src->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock source's index area: err %d\n",
+			  err);
+		goto unlock_src_node;
+	}
+
+	down_write(&dst->full_lock);
+	err = ssdfs_lock_whole_index_area(dst);
+	downgrade_write(&dst->full_lock);
+
+	if (unlikely(err)) {
+		ssdfs_unlock_whole_index_area(src);
+		SSDFS_ERR("fail to lock destination's index area: err %d\n",
+			  err);
+		goto unlock_dst_node;
+	}
+
+	if (dst_start == 0 && dst_start != dst_index_count) {
+		down_write(&dst->header_lock);
+		err = ssdfs_shift_range_right2(dst, &dst->index_area,
+						index_size,
+						0, dst_index_count,
+						count);
+		up_write(&dst->header_lock);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to shift index range right: "
+				  "dst_node %u, index_count %u, "
+				  "shift %u, err %d\n",
+				  dst->node_id, dst_index_count,
+				  count, err);
+			goto unlock_index_area;
+		}
+	} else if (dst_start != dst_index_count) {
+		err = -ERANGE;
+		SSDFS_ERR("dst_start %u != dst_index_count %u\n",
+			  dst_start, dst_index_count);
+		SSDFS_ERR("source (start_hash %llx, end_hash %llx), "
+			  "destination (start_hash %llx, end_hash %llx)\n",
+			  src_start_hash, src_end_hash,
+			  dst_start_hash, dst_end_hash);
+		goto unlock_index_area;
+	}
+
+	while (processed < count) {
+		u16 range_len = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("i %u, j %u, processed %u, "
+			  "count %u, range_len %u\n",
+			  i, j, processed, count, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_copy_index_range_in_buffer(src, i,
+							count - processed,
+							src_offset,
+							index_size,
+							buf,
+							&range_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy index range in buffer: "
+				  "err %d\n", err);
+			goto unlock_index_area;
+		}
+
+		err = ssdfs_save_index_range_in_node(dst, j, range_len,
+						     dst_offset, index_size,
+						     buf);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to save index range into node: "
+				  "err %d\n", err);
+			goto unlock_index_area;
+		}
+
+		i += range_len;
+		j += range_len;
+		processed += range_len;
+	}
+
+	err = ssdfs_clear_index_range_in_node(src, src_start, count,
+					      src_offset, index_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear the source node's index range: "
+			  "err %d\n", err);
+		goto unlock_index_area;
+	}
+
+	down_write(&dst->header_lock);
+	dst->index_area.index_count += processed;
+	err = __ssdfs_init_index_area_hash_range(dst,
+						 dst->index_area.index_count,
+						 &dst->index_area.start_hash,
+						 &dst->index_area.end_hash);
+	up_write(&dst->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set the destination node's index range: "
+			  "err %d\n", err);
+		goto unlock_index_area;
+	}
+
+	if ((src_start + processed) < src_index_count) {
+		i = src_start + processed;
+		j = src_start;
+
+		rest_unmoved = src_index_count - (src_start + processed);
+		copied = 0;
+
+		while (copied < rest_unmoved) {
+			u16 range_len = 0;
+
+			err = ssdfs_copy_index_range_in_buffer(src, i,
+							rest_unmoved - copied,
+							src_offset,
+							index_size,
+							buf,
+							&range_len);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy index range in buffer: "
+					  "err %d\n", err);
+				goto finish_source_correction;
+			}
+
+			err = ssdfs_save_index_range_in_node(src, j, range_len,
+							     src_offset,
+							     index_size,
+							     buf);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to save index range into node: "
+					  "err %d\n", err);
+				goto finish_source_correction;
+			}
+
+finish_source_correction:
+			if (unlikely(err))
+				goto unlock_index_area;
+
+			i += range_len;
+			j += range_len;
+			copied += range_len;
+		}
+
+		err = ssdfs_clear_index_range_in_node(src,
+						      src_start + processed,
+						      rest_unmoved,
+						      src_offset, index_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clear the src node's index range: "
+				  "err %d\n", err);
+			goto unlock_index_area;
+		}
+
+		err = ssdfs_set_dirty_index_range(src, src_start,
+						  rest_unmoved);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set dirty index range: "
+				  "start %u, len %u, err %d\n",
+				  src_start, rest_unmoved, err);
+			goto unlock_index_area;
+		}
+	}
+
+	down_write(&src->header_lock);
+	src->index_area.index_count -= processed;
+	err = __ssdfs_init_index_area_hash_range(src,
+						 src->index_area.index_count,
+						 &src->index_area.start_hash,
+						 &src->index_area.end_hash);
+	up_write(&src->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set the source node's hash range: "
+			  "err %d\n", err);
+		goto unlock_index_area;
+	}
+
+unlock_index_area:
+	ssdfs_unlock_whole_index_area(dst);
+	ssdfs_unlock_whole_index_area(src);
+
+unlock_dst_node:
+	up_read(&dst->full_lock);
+
+unlock_src_node:
+	up_read(&src->full_lock);
+
+finish_index_moving:
+	if (unlikely(err)) {
+		atomic_set(&src->state, SSDFS_BTREE_NODE_CORRUPTED);
+		atomic_set(&dst->state, SSDFS_BTREE_NODE_CORRUPTED);
+	} else {
+		ssdfs_set_node_update_cno(src);
+		set_ssdfs_btree_node_dirty(src);
+
+		ssdfs_set_node_update_cno(dst);
+		set_ssdfs_btree_node_dirty(dst);
+	}
+
+	ssdfs_btree_node_kfree(buf);
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_move_index_range() - move index range
+ * @src: source node
+ * @src_start: starting index in the source node
+ * @dst: destination node
+ * @dst_start: starting index in the destination node
+ * @count: count of indexes in the range
+ *
+ * This method tries to move the index range from @src into @dst.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - index area is absent.
+ */
+int ssdfs_btree_node_move_index_range(struct ssdfs_btree_node *src,
+				      u16 src_start,
+				      struct ssdfs_btree_node *dst,
+				      u16 dst_start, u16 count)
+{
+	int src_type, dst_type;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!src || !dst);
+	BUG_ON(!rwsem_is_locked(&src->tree->lock));
+
+	SSDFS_DBG("src_node %u, src_start %u, "
+		  "dst_node %u, dst_start %u, "
+		  "count %u\n",
+		  src->node_id, src_start,
+		  dst->node_id, dst_start, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&src->state)) {
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&src->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(src)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("src node %u hasn't index area\n",
+			  src->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	switch (atomic_read(&dst->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&dst->state));
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(dst)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("dst node %u hasn't index area\n",
+			  dst->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	src_type = atomic_read(&src->type);
+	switch (src_type) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid src node type %#x\n",
+			  src_type);
+		return -ERANGE;
+	}
+
+	dst_type = atomic_read(&dst->type);
+	switch (dst_type) {
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dst node type %#x\n",
+			  dst_type);
+		return -ERANGE;
+	}
+
+	if (src_type == SSDFS_BTREE_ROOT_NODE) {
+		err = ssdfs_move_root2common_node_index_range(src, src_start,
+							      dst, dst_start,
+							      count);
+	} else {
+		err = ssdfs_move_common2common_node_index_range(src, src_start,
+								dst, dst_start,
+								count);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move index range: err %d\n",
+			  err);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_check_result_for_search() - check search result for search
+ * @search: btree search object
+ */
+static
+int ssdfs_btree_node_check_result_for_search(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	u64 update_cno;
+	u64 start_hash, end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node = search->node.child;
+
+	down_read(&node->header_lock);
+	update_cno = node->update_cno;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search (state %#x, search_cno %llu, "
+		  "start_hash %llx, end_hash %llx), "
+		  "node (update_cno %llu, "
+		  "start_hash %llx, end_hash %llx)\n",
+		  search->result.state,
+		  search->result.search_cno,
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  update_cno, start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		if (search->result.search_cno < update_cno) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+			return -EAGAIN;
+		}
+
+		if (search->request.start.hash < start_hash &&
+		    search->request.start.hash > end_hash) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+			return -EAGAIN;
+		}
+
+		return 0;
+
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		if (search->result.search_cno < update_cno) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+			return -EAGAIN;
+		}
+
+		return 0;
+
+	case SSDFS_BTREE_SEARCH_UNKNOWN_RESULT:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_SEARCH_FAILURE:
+	case SSDFS_BTREE_SEARCH_EMPTY_RESULT:
+	case SSDFS_BTREE_SEARCH_OBSOLETE_RESULT:
+		search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+		break;
+
+	case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+		SSDFS_DBG("search result requests to add a node already\n");
+		break;
+
+	case SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE:
+		SSDFS_WARN("unexpected search result state\n");
+		search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+		break;
+
+	default:
+		SSDFS_WARN("invalid search result state\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result.state %#x\n",
+		  search->result.state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_check_hash_range() - check necessity to do search
+ * @node: pointer on node object
+ * @items_count: items count in the node
+ * @items_capacity: node's capacity for items
+ * @start_hash: items' area starting hash
+ * @end_hash: items' area ending hash
+ * @search: pointer on search request object
+ *
+ * This method tries to check the necessity to do
+ * the real search in the node..
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - requested range is out of the node.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+int ssdfs_btree_node_check_hash_range(struct ssdfs_btree_node *node,
+				      u16 items_count,
+				      u16 items_capacity,
+				      u64 start_hash,
+				      u64 end_hash,
+				      struct ssdfs_btree_search *search)
+{
+	u16 vacant_items;
+	bool have_enough_space;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "search (start_hash %llx, end_hash %llx), "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  start_hash, end_hash,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	vacant_items = items_capacity - items_count;
+	have_enough_space = search->request.count <= vacant_items;
+
+	switch (RANGE_WITHOUT_INTERSECTION(search->request.start.hash,
+					   search->request.end.hash,
+					   start_hash, end_hash)) {
+	case 0:
+		/* ranges have intersection */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("ranges have intersection\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	case -1: /* range1 < range2 */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range1 < range2\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		if (have_enough_space) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		} else {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+		}
+
+		search->result.err = -ENODATA;
+		search->result.start_index = 0;
+		search->result.count = search->request.count;
+		search->result.search_cno =
+			ssdfs_current_cno(node->tree->fsi->sb);
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+			/* do nothing */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("search->result.start_index %u, "
+			  "search->result.state %#x, "
+			  "search->result.err %d\n",
+			  search->result.start_index,
+			  search->result.state,
+			  search->result.err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+
+	case 1: /* range1 > range2 */
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range1 > range2\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (have_enough_space) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OUT_OF_RANGE;
+		} else {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE;
+		}
+
+		search->result.err = -ENODATA;
+		search->result.start_index = items_count;
+		search->result.count = search->request.count;
+		search->result.search_cno =
+			ssdfs_current_cno(node->tree->fsi->sb);
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+			/* do nothing */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("search->result.start_index %u, "
+			  "search->result.state %#x, "
+			  "search->result.err %d\n",
+			  search->result.start_index,
+			  search->result.state,
+			  search->result.err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return -ENODATA;
+
+	default:
+		BUG();
+	}
+
+	if (!RANGE_HAS_PARTIAL_INTERSECTION(search->request.start.hash,
+					    search->request.end.hash,
+					    start_hash, end_hash)) {
+		SSDFS_ERR("invalid request: "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "node (start_hash %llx, end_hash %llx)\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  start_hash, end_hash);
+		return -ERANGE;
+	}
+
+	if (items_count == 0) {
+		search->result.state =
+			SSDFS_BTREE_SEARCH_OUT_OF_RANGE;
+
+		search->result.err = -ENODATA;
+		search->result.start_index = 0;
+		search->result.count = search->request.count;
+		search->result.search_cno =
+			ssdfs_current_cno(node->tree->fsi->sb);
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+			/* do nothing */
+			break;
+
+		default:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("search->result.start_index %u, "
+			  "search->result.state %#x, "
+			  "search->result.err %d\n",
+			  search->result.start_index,
+			  search->result.state,
+			  search->result.err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_find_item() - find the item in the node
+ * @search: btree search object
+ *
+ * This method tries to find an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node doesn't contain item for the requested hash.
+ * %-ENOENT     - node hasn't the items area.
+ * %-ENOSPC     - node hasn't free space.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ * %-EOPNOTSUPP - specialized searching method doesn't been implemented
+ */
+int ssdfs_btree_node_find_item(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_node_desc_consistent(search)) {
+		SSDFS_WARN("node descriptor is inconsistent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_result_for_search(search);
+	if (err)
+		return err;
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   search->node.id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return -ERANGE;
+	}
+
+	if (!node->node_ops || !node->node_ops->find_item) {
+		SSDFS_WARN("unable to search in the node\n");
+		return -EOPNOTSUPP;
+	}
+
+	down_read(&node->full_lock);
+	err = node->node_ops->find_item(node, search);
+	up_read(&node->full_lock);
+
+	if (err == -ENODATA) {
+		u16 items_count;
+		u16 items_capacity;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u "
+			  "hasn't item for request "
+			  "(start_hash %llx, end_hash %llx)\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ALLOCATE_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+			down_read(&node->header_lock);
+			items_count = node->items_area.items_count;
+			items_capacity = node->items_area.items_capacity;
+			up_read(&node->header_lock);
+
+			if (items_count >= items_capacity) {
+				err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("node hasn't free space: "
+					  "items_count %u, "
+					  "items_capacity %u\n",
+					  items_count,
+					  items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+				search->result.err = -ENODATA;
+			}
+			break;
+
+		default:
+			search->result.err = err;
+			break;
+		}
+	} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u "
+			  "hasn't all items for request "
+			  "(start_hash %llx, end_hash %llx)\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't items area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find: "
+			  "node %u, "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_find_range() - find the range in the node
+ * @search: btree search object
+ *
+ * This method tries to find a range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node doesn't contain items for the requested range.
+ * %-ENOENT     - node hasn't the items area.
+ * %-ENOSPC     - node hasn't free space.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ * %-EOPNOTSUPP - specialized searching method doesn't been implemented
+ */
+int ssdfs_btree_node_find_range(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *node;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_node_desc_consistent(search)) {
+		SSDFS_WARN("node descriptor is inconsistent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_result_for_search(search);
+	if (err)
+		return err;
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   search->node.id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return -ERANGE;
+	}
+
+	if (!node->node_ops || !node->node_ops->find_range) {
+		SSDFS_WARN("unable to search in the node\n");
+		return -EOPNOTSUPP;
+	}
+
+	down_read(&node->full_lock);
+	err = node->node_ops->find_range(node, search);
+	up_read(&node->full_lock);
+
+	if (err == -ENODATA) {
+		u16 items_count;
+		u16 items_capacity;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u "
+			  "hasn't item for request "
+			  "(start_hash %llx, end_hash %llx)\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ALLOCATE_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+			down_read(&node->header_lock);
+			items_count = node->items_area.items_count;
+			items_capacity = node->items_area.items_capacity;
+			up_read(&node->header_lock);
+
+			if (items_count >= items_capacity) {
+				err = -ENOSPC;
+				search->result.err = -ENODATA;
+			}
+			break;
+
+		default:
+			search->result.err = err;
+			break;
+		}
+	} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u "
+			  "hasn't all items for request "
+			  "(start_hash %llx, end_hash %llx)\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't items area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find: "
+			  "node %u, "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_check_result_for_alloc() - check search result for alloc
+ * @search: btree search object
+ */
+static inline
+int ssdfs_btree_node_check_result_for_alloc(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		return -EEXIST;
+
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid search result state %#x\n",
+			   search->result.state);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_allocate_item() - allocate the item in the node
+ * @search: btree search object
+ *
+ * This method tries to allocate an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - item is used already.
+ * %-ENOSPC     - item is out of node.
+ * %-ENOENT     - node hasn't the items area.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ */
+int ssdfs_btree_node_allocate_item(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+	BUG_ON(search->request.start.hash > search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#else
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_node_desc_consistent(search)) {
+		SSDFS_WARN("node descriptor is inconsistent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_result_for_alloc(search);
+	if (err)
+		return err;
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   search->node.id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return -ERANGE;
+	}
+
+	if (node->node_ops && node->node_ops->allocate_item) {
+		err = node->node_ops->allocate_item(node, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate item: err %d\n",
+				  err);
+			search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+			search->result.search_cno = U64_MAX;
+			search->result.start_index = U16_MAX;
+			search->result.count = U16_MAX;
+			return err;
+		}
+	} else
+		return -EOPNOTSUPP;
+
+	spin_lock(&node->descriptor_lock);
+	search->result.search_cno = ssdfs_current_cno(fsi->sb);
+	node->update_cno = search->result.search_cno;
+	flags = le16_to_cpu(node->node_index.flags);
+	flags &= ~SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE;
+	node->node_index.flags = cpu_to_le16(flags);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node->update_cno %llu\n",
+		  search->result.search_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	set_ssdfs_btree_node_dirty(node);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_allocate_range() - allocate the range in the node
+ * @search: btree search object
+ *
+ * This method tries to allocate a range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - range of items is used already.
+ * %-ENOSPC     - range is out of node.
+ * %-ENOENT     - node hasn't the items area.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ */
+int ssdfs_btree_node_allocate_range(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+	BUG_ON(search->request.start.hash > search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#else
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_node_desc_consistent(search)) {
+		SSDFS_WARN("node descriptor is inconsistent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_result_for_alloc(search);
+	if (err)
+		return err;
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   search->node.id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return -ERANGE;
+	}
+
+	if (node->node_ops && node->node_ops->allocate_range) {
+		err = node->node_ops->allocate_range(node, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate item: err %d\n",
+				  err);
+			search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+			search->result.search_cno = U64_MAX;
+			search->result.start_index = U16_MAX;
+			search->result.count = U16_MAX;
+			return err;
+		}
+	} else
+		return -EOPNOTSUPP;
+
+	spin_lock(&node->descriptor_lock);
+	search->result.search_cno = ssdfs_current_cno(fsi->sb);
+	node->update_cno = search->result.search_cno;
+	flags = le16_to_cpu(node->node_index.flags);
+	flags &= ~SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE;
+	node->node_index.flags = cpu_to_le16(flags);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node->update_cno %llu\n",
+		  search->result.search_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	set_ssdfs_btree_node_dirty(node);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_check_result_for_insert() - check search result for insert
+ * @search: btree search object
+ */
+static inline
+int ssdfs_btree_node_check_result_for_insert(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+		return -EEXIST;
+
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid search result state\n");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_insert_item() - insert the item in the node
+ * @search: btree search object
+ *
+ * This method tries to insert an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - item exists.
+ * %-ENOSPC     - node hasn't free space.
+ * %-EFBIG      - some items were pushed out from the node.
+ * %-ENOENT     - node hasn't the items area.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ * %-EOPNOTSUPP - specialized insert method doesn't been implemented
+ */
+int ssdfs_btree_node_insert_item(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+	BUG_ON(search->request.start.hash > search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#else
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_space %u\n", node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_btree_search_node_desc_consistent(search)) {
+		SSDFS_WARN("node descriptor is inconsistent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_result_for_insert(search);
+	if (err)
+		return err;
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   search->node.id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return -ERANGE;
+	}
+
+	if (!node->node_ops || !node->node_ops->insert_item) {
+		SSDFS_WARN("unable to insert item\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = node->node_ops->insert_item(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert: "
+			  "node %u, "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+		return err;
+	}
+
+	spin_lock(&node->descriptor_lock);
+	search->result.search_cno = ssdfs_current_cno(fsi->sb);
+	node->update_cno = search->result.search_cno;
+	flags = le16_to_cpu(node->node_index.flags);
+	flags &= ~SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE;
+	node->node_index.flags = cpu_to_le16(flags);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node->update_cno %llu\n",
+		  search->result.search_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	set_ssdfs_btree_node_dirty(node);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_insert_range() - insert the range in the node
+ * @search: btree search object
+ *
+ * This method tries to insert a range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free space.
+ * %-EFBIG      - some items were pushed out from the node.
+ * %-ENOENT     - node hasn't the items area.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ */
+int ssdfs_btree_node_insert_range(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+	BUG_ON(search->request.start.hash > search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#else
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	node = search->node.child;
+	if (!node) {
+		SSDFS_WARN("child node is NULL\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EACCES;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	if (!is_btree_search_node_desc_consistent(search)) {
+		SSDFS_WARN("node descriptor is inconsistent\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_result_for_insert(search);
+	if (err)
+		return err;
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   search->node.id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   search->node.id);
+		return -ERANGE;
+	}
+
+	if (!node->node_ops || !node->node_ops->insert_range) {
+		SSDFS_WARN("unable to insert range\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = node->node_ops->insert_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert: "
+			  "node %u, "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  node->node_id,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+		return err;
+	}
+
+	spin_lock(&node->descriptor_lock);
+	search->result.search_cno = ssdfs_current_cno(fsi->sb);
+	node->update_cno = search->result.search_cno;
+	flags = le16_to_cpu(node->node_index.flags);
+	flags &= ~SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE;
+	node->node_index.flags = cpu_to_le16(flags);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node->update_cno %llu\n",
+		  search->result.search_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	set_ssdfs_btree_node_dirty(node);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
-- 
2.34.1

