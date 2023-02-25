Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF96A2666
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBYBTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBYBTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51118136F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:45 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y184so798593oiy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTGT6KmQ2vo1h08Z5eusnqR7jQWVuEdSEGSCxP+3mls=;
        b=bmghS9Hzil5PohcNIPo3dBsQKW0WAr763AhmdeYF/P+zC4paxkY3B+IapfLcYVpCXq
         he36P4ZADj8R8ouk0hK0UaEcc/XhaC4jLamvvBZbCqkdSmLmJIiwC2yk+jq+wJc+UziJ
         +NJ9cO/K53gAIC6cfH9MGJk1MJr1xPRzQtoMkotWmZ6822mFDmZanFVzgXN2MhOZc10M
         0tAB6pry2nHA81jwbujT3usvhz93QtZdSgAYOKAhsRgBuzpNYSyzLLMOCqpn0uGM0vcg
         cMkCRx/tYXfGytWsJib8DEiIxMxaCIMD0tMFBJvO5/naHVnK2imPfFLZVLK/qAVoXGSm
         G8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTGT6KmQ2vo1h08Z5eusnqR7jQWVuEdSEGSCxP+3mls=;
        b=RkMzzp0eSigkF3ERik/qq67l+M5tscoWH9fmS1tkce0WoRfB1ZpQro+4DOYLKYlwKQ
         OE5tq29jI42fVpCLzET+09w/EgY19l+wssSdbG1WxytXnh8mPzULIAJvLuMQ0ra314Ut
         n9euHYUO+tCWvJ1jdl4sAJIhyDg/PQwNvhVJRhu+atodaav2viWg2XC7ZMjSdo9IrRPl
         8Um4AWKuPVZnXIgcXtW3WavmaB/xpdvITQkKCuX27igCKyk96VhehQbzZiNku7kXdrsV
         qWxBftvDS/CL/7+I+v8Y/AujRWP/mDpmg2IwjtDX1HutbiPc+JGJOK1f8DZ2rB275oyU
         ydxQ==
X-Gm-Message-State: AO0yUKVk4jKZpUb/ZPYzqdkYHP6/rE/FuxD0X0wm+IhJv8k8Xwr5/XqC
        cGyCq4qKyM59WIdP9/8ou1gB5B4uiaR01V1q
X-Google-Smtp-Source: AK7set9yK8oGhDikfsIXID2ADNM62ACbZtdv0RaSSQTEChbDli4lqSNHm86yw78nt4kLhdghBERhBw==
X-Received: by 2002:aca:181a:0:b0:37a:dbfd:2416 with SMTP id h26-20020aca181a000000b0037adbfd2416mr8084756oih.53.1677287864083;
        Fri, 24 Feb 2023 17:17:44 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:43 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 61/76] ssdfs: inodes b-tree node operations
Date:   Fri, 24 Feb 2023 17:09:12 -0800
Message-Id: <20230225010927.813929-62-slava@dubeyko.com>
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

Inodes b-tree supports operations:
(1) find_item - find item in the b-tree
(2) find_range - find range of items in the b-tree
(3) extract_range - extract range of items from the node of b-tree
(4) allocate_item - allocate item in b-tree
(5) allocate_range - allocate range of items in b-tree
(6) insert_item - insert item into node of the b-tree
(7) insert_range - insert range of items into node of the b-tree
(8) change_item - change item in the b-tree
(9) delete_item - delete item from the b-tree
(10) delete_range - delete range of items from a node of b-tree

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/inodes_tree.c | 2366 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2366 insertions(+)

diff --git a/fs/ssdfs/inodes_tree.c b/fs/ssdfs/inodes_tree.c
index 1cc42cc84513..f17142d9c6db 100644
--- a/fs/ssdfs/inodes_tree.c
+++ b/fs/ssdfs/inodes_tree.c
@@ -3166,3 +3166,2369 @@ int ssdfs_inodes_btree_flush_node(struct ssdfs_btree_node *node)
 
 	return err;
 }
+
+/******************************************************************************
+ *               SPECIALIZED INODES BTREE NODE OPERATIONS                     *
+ ******************************************************************************/
+
+/*
+ * ssdfs_inodes_btree_node_find_range() - find a range of items into the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to find a range of items into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - requested range is out of the node.
+ * %-ENOMEM     - unable to allocate memory.
+ */
+static
+int ssdfs_inodes_btree_node_find_range(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+	size_t item_size = sizeof(struct ssdfs_inode);
+	int state;
+	u16 items_count;
+	u16 items_capacity;
+	u64 start_hash;
+	u64 end_hash;
+	u64 found_index, start_index = U64_MAX;
+	u64 found_bit = U64_MAX;
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long item_start_bit;
+	bool is_allocated = false;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+
+	ssdfs_debug_btree_search_object(search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->items_area.state);
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	if (items_capacity == 0 || items_count > items_capacity) {
+		SSDFS_ERR("corrupted node description: "
+			  "items_count %u, items_capacity %u\n",
+			  items_count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	if (search->request.count == 0 ||
+	    search->request.count > items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "count %u, items_capacity %u\n",
+			  search->request.count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_hash_range(node,
+						items_count,
+						items_capacity,
+						start_hash,
+						end_hash,
+						search);
+	if (err)
+		return err;
+
+	found_index = search->request.start.hash - start_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(found_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((found_index + search->request.count) > items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "found_index %llu, count %u, "
+			  "items_capacity %u\n",
+			  found_index, search->request.count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	down_read(&node->bmap_array.lock);
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP];
+	item_start_bit = node->bmap_array.item_start_bit;
+	if (item_start_bit == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_area_start\n");
+		goto finish_bmap_operation;
+	}
+	start_index = found_index + item_start_bit;
+
+	spin_lock(&bmap->lock);
+
+	found_bit = bitmap_find_next_zero_area(bmap->ptr,
+						items_capacity + item_start_bit,
+						start_index,
+						search->request.count,
+						0);
+
+	if (start_index == found_bit) {
+		/* item isn't allocated yet */
+		is_allocated = false;
+	} else {
+		/* item has been allocated already */
+		is_allocated = true;
+	}
+	spin_unlock(&bmap->lock);
+finish_bmap_operation:
+	up_read(&node->bmap_array.lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, items_capacity %u, "
+		  "item_start_bit %lu, found_index %llu, "
+		  "start_index %llu, found_bit %llu\n",
+		  items_count, items_capacity,
+		  item_start_bit, found_index,
+		  start_index, found_bit);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_allocated) {
+		if (search->request.count == 1) {
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf = &search->raw.inode;
+			search->result.buf_size = item_size;
+			search->result.items_in_buffer = 0;
+		} else {
+			err = ssdfs_btree_search_alloc_result_buf(search,
+					item_size * search->request.count);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate buffer\n");
+				return err;
+			}
+		}
+
+		for (i = 0; i < search->request.count; i++) {
+			err = ssdfs_copy_item_in_buffer(node,
+							(u16)found_index + i,
+							item_size,
+							search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to copy item in buffer: "
+					  "index %d, err %d\n",
+					  i, err);
+				return err;
+			}
+		}
+
+		err = 0;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_VALID_ITEM;
+		search->result.err = 0;
+		search->result.start_index = (u16)found_index;
+		search->result.count = search->request.count;
+		search->result.search_cno =
+			ssdfs_current_cno(node->tree->fsi->sb);
+	} else {
+		err = -ENODATA;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENODATA;
+		search->result.start_index = (u16)found_index;
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
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search result: "
+		  "state %#x, err %d, "
+		  "start_index %u, count %u, "
+		  "search_cno %llu, "
+		  "buf_state %#x, buf %p\n",
+		  search->result.state,
+		  search->result.err,
+		  search->result.start_index,
+		  search->result.count,
+		  search->result.search_cno,
+		  search->result.buf_state,
+		  search->result.buf);
+
+	ssdfs_debug_btree_node_object(node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_inodes_btree_node_find_item() - find item into node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to find an item into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_node_find_item(struct ssdfs_btree_node *node,
+				      struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->request.count != 1 ||
+	    search->request.start.hash != search->request.end.hash) {
+		SSDFS_ERR("invalid request state: "
+			  "count %d, start_hash %llx, end_hash %llx\n",
+			  search->request.count,
+			  search->request.start.hash,
+			  search->request.end.hash);
+		return -ERANGE;
+	}
+
+	return ssdfs_inodes_btree_node_find_range(node, search);
+}
+
+/*
+ * ssdfs_define_allocated_range() - define range for allocation
+ * @search: pointer on search request object
+ * @start_hash: requested starting hash
+ * @end_hash: requested ending hash
+ * @start: pointer on start index value [out]
+ * @count: pointer on count items in the range [out]
+ *
+ * This method checks request in the search object and
+ * to define the range's start index and count of items
+ * in the range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static inline
+int ssdfs_define_allocated_range(struct ssdfs_btree_search *search,
+				 u64 start_hash, u64 end_hash,
+				 unsigned long *start, unsigned int *count)
+{
+	unsigned int calculated_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !start || !count);
+
+	SSDFS_DBG("node (id %u, start_hash %llx, "
+		  "end_hash %llx), "
+		  "request (start_hash %llx, "
+		  "end_hash %llx, flags %#x)\n",
+		  search->node.id, start_hash, end_hash,
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  search->request.flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start = ULONG_MAX;
+	*count = 0;
+
+	if (search->request.flags & SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE) {
+		if (search->request.start.hash < start_hash ||
+		    search->request.start.hash > end_hash) {
+			SSDFS_ERR("invalid hash range: "
+				  "node (id %u, start_hash %llx, "
+				  "end_hash %llx), "
+				  "request (start_hash %llx, "
+				  "end_hash %llx)\n",
+				  search->node.id, start_hash, end_hash,
+				  search->request.start.hash,
+				  search->request.end.hash);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON((search->request.start.hash - start_hash) >= ULONG_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		*start = (unsigned long)(search->request.start.hash -
+				start_hash);
+		calculated_count = search->request.end.hash -
+					search->request.start.hash + 1;
+	} else {
+		*start = 0;
+		calculated_count = search->request.count;
+	}
+
+	if (search->request.flags & SSDFS_BTREE_SEARCH_HAS_VALID_COUNT) {
+		*count = search->request.count;
+
+		if (*count < 0 || *count >= UINT_MAX) {
+			SSDFS_WARN("invalid count %u\n", *count);
+			return -ERANGE;
+		}
+
+		if (*count != calculated_count) {
+			SSDFS_ERR("invalid count: count %u, "
+				  "calculated_count %u\n",
+				  *count, calculated_count);
+			return -ERANGE;
+		}
+	}
+
+	if (*start >= ULONG_MAX || *count >= UINT_MAX) {
+		SSDFS_WARN("invalid range (start %lu, count %u)\n",
+			   *start, *count);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_copy_item_into_node_unlocked() - copy item from buffer into the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ * @item_index: index of item in the node
+ * @buf_index: index of item into the buffer
+ *
+ * This method tries to copy an item from the buffer into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_copy_item_into_node_unlocked(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search,
+					u16 item_index, u16 buf_index)
+{
+	size_t item_size = sizeof(struct ssdfs_inode);
+	u32 area_offset;
+	u32 area_size;
+	u32 item_offset;
+	u32 buf_offset;
+	int page_index;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u, buf_index %u\n",
+		  node->node_id, item_index, buf_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	area_offset = node->items_area.offset;
+	area_size = node->items_area.area_size;
+	up_read(&node->header_lock);
+
+	item_offset = (u32)item_index * item_size;
+	if (item_offset >= area_size) {
+		SSDFS_ERR("item_offset %u >= area_size %u\n",
+			  item_offset, area_size);
+		return -ERANGE;
+	}
+
+	item_offset += area_offset;
+	if (item_offset >= node->node_size) {
+		SSDFS_ERR("item_offset %u >= node_size %u\n",
+			  item_offset, node->node_size);
+		return -ERANGE;
+	}
+
+	page_index = item_offset >> PAGE_SHIFT;
+
+	if (page_index > 0)
+		item_offset %= page_index * PAGE_SIZE;
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("invalid page_index: "
+			  "index %d, pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	page = node->content.pvec.pages[page_index];
+
+	if (!search->result.buf) {
+		SSDFS_ERR("buffer is not created\n");
+		return -ERANGE;
+	}
+
+	if (buf_index >= search->result.items_in_buffer) {
+		SSDFS_ERR("buf_index %u >= items_in_buffer %u\n",
+			  buf_index, search->result.items_in_buffer);
+		return -ERANGE;
+	}
+
+	buf_offset = buf_index * item_size;
+
+	err = ssdfs_memcpy_to_page(page,
+				   item_offset, PAGE_SIZE,
+				   search->result.buf,
+				   buf_offset, search->result.buf_size,
+				   item_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy item: "
+			  "buf_offset %u, item_offset %u, "
+			  "item_size %zu, buf_size %zu\n",
+			  buf_offset, item_offset,
+			  item_size, search->result.buf_size);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_btree_node_allocate_range() - allocate range of items in the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ *
+ * This method tries to allocate range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free items.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int __ssdfs_btree_node_allocate_range(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search,
+					u16 start, u16 count)
+{
+	struct ssdfs_inodes_btree_info *itree;
+	struct ssdfs_inodes_btree_node_header *hdr;
+	size_t inode_size = sizeof(struct ssdfs_inode);
+	struct ssdfs_state_bitmap *bmap;
+	struct timespec64 cur_time;
+	u16 item_size;
+	u16 max_item_size;
+	u16 item_index;
+	u16 items_count;
+	u16 items_capacity;
+	int free_items;
+	u64 start_hash;
+	u64 end_hash;
+	u32 bmap_bytes;
+	u64 free_inodes;
+	u64 allocated_inodes;
+	u64 upper_allocated_ino;
+	u64 inodes_capacity;
+	u32 used_space;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	item_size = node->items_area.item_size;
+	max_item_size = node->items_area.max_item_size;
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, start %u, count %u, "
+		  "items_count %u, items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->node_id, start, count,
+		  items_count, items_capacity,
+		  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (items_capacity == 0 || items_capacity < items_count) {
+		SSDFS_ERR("invalid items accounting: "
+			  "node_id %u, items_capacity %u, items_count %u\n",
+			  search->node.id, items_capacity, items_count);
+		return -ERANGE;
+	}
+
+	if (item_size != inode_size || max_item_size != item_size) {
+		SSDFS_ERR("item_size %u, max_item_size %u, "
+			  "inode_size %zu\n",
+			  item_size, max_item_size, inode_size);
+		return -ERANGE;
+	}
+
+	free_items = items_capacity - items_count;
+	if (unlikely(free_items < 0)) {
+		SSDFS_WARN("invalid free_items %d\n",
+			   free_items);
+		return -ERANGE;
+	} else if (free_items == 0) {
+		SSDFS_DBG("node hasn't free items\n");
+		return -ENOSPC;
+	}
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u, "
+			  "items_capacity %u\n",
+			  item_index, search->request.count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	if ((start_hash + item_index) != search->request.start.hash) {
+		SSDFS_WARN("node (start_hash %llx, index %u), "
+			   "request (start_hash %llx, end_hash %llx)\n",
+			   start_hash, item_index,
+			   search->request.start.hash,
+			   search->request.end.hash);
+		return -ERANGE;
+	}
+
+	if (start != item_index) {
+		SSDFS_WARN("start %u != item_index %u\n",
+			   start, item_index);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	err = ssdfs_lock_items_range(node, start, count);
+	if (err == -ENOENT) {
+		up_write(&node->full_lock);
+		return -ERANGE;
+	} else if (err == -ENODATA) {
+		up_write(&node->full_lock);
+		wake_up_all(&node->wait_queue);
+		return -ERANGE;
+	} else if (unlikely(err))
+		BUG();
+
+	downgrade_write(&node->full_lock);
+
+	err = ssdfs_allocate_items_range(node, search,
+					 items_capacity,
+					 start, count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate: "
+			  "start %u, count %u, err %d\n",
+			  start, count, err);
+		goto finish_allocate_item;
+	}
+
+	search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+	search->result.start_index = start;
+	search->result.count = count;
+	search->result.buf_size = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result.start_index %u\n",
+		  (u32)search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count > 1) {
+		size_t allocated_bytes = item_size * count;
+
+		err = ssdfs_btree_search_alloc_result_buf(search,
+							  allocated_bytes);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			goto finish_allocate_item;
+		}
+		search->result.items_in_buffer = count;
+		search->result.buf_size = allocated_bytes;
+	} else if (count == 1) {
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.inode;
+		search->result.buf_size = item_size;
+		search->result.items_in_buffer = 1;
+	} else
+		BUG();
+
+	memset(search->result.buf, 0, search->result.buf_size);
+
+	for (i = 0; i < count; i++) {
+		struct ssdfs_inode *inode;
+		u32 item_offset = i * item_size;
+
+		inode = (struct ssdfs_inode *)(search->result.buf +
+						item_offset);
+
+		ktime_get_coarse_real_ts64(&cur_time);
+
+		inode->magic = cpu_to_le16(SSDFS_INODE_MAGIC);
+		inode->birthtime = cpu_to_le64(cur_time.tv_sec);
+		inode->birthtime_nsec = cpu_to_le32(cur_time.tv_nsec);
+		inode->ino = cpu_to_le64(search->request.start.hash);
+
+		err = ssdfs_copy_item_into_node_unlocked(node, search,
+							 start + i, i);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to initialized allocated item: "
+				  "index %d, err %d\n",
+				  start + i, err);
+			goto finish_allocate_item;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count == 0 || search->result.count >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&node->header_lock);
+	hdr = &node->raw.inodes_header;
+	le16_add_cpu(&hdr->valid_inodes, (u16)count);
+	down_read(&node->bmap_array.lock);
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP];
+	bmap_bytes = node->bmap_array.bmap_bytes;
+	spin_lock(&bmap->lock);
+	ssdfs_memcpy(hdr->bmap, 0, bmap_bytes,
+		     bmap->ptr, 0, bmap_bytes,
+		     bmap_bytes);
+	spin_unlock(&bmap->lock);
+	up_read(&node->bmap_array.lock);
+	node->items_area.items_count += count;
+	used_space = (u32)node->items_area.item_size * count;
+	if (used_space > node->items_area.free_space) {
+		err = -ERANGE;
+		SSDFS_ERR("used_space %u > free_space %u\n",
+			  used_space,
+			  node->items_area.free_space);
+		goto finish_change_node_header;
+	} else
+		node->items_area.free_space -= used_space;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, area_size %u, "
+		  "free_space %u, valid_inodes %u\n",
+		  node->items_area.items_count,
+		  node->items_area.area_size,
+		  node->items_area.free_space,
+		  le16_to_cpu(hdr->valid_inodes));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	up_write(&node->header_lock);
+
+finish_change_node_header:
+	if (unlikely(err))
+		goto finish_allocate_item;
+
+	err = ssdfs_set_node_header_dirty(node, items_capacity);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set header dirty: err %d\n",
+			  err);
+		goto finish_allocate_item;
+	}
+
+	err = ssdfs_set_dirty_items_range(node, items_capacity,
+					  start, count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  start, count, err);
+		goto finish_allocate_item;
+	}
+
+finish_allocate_item:
+	ssdfs_unlock_items_range(node, (u16)start, (u16)count);
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		return err;
+
+	itree = (struct ssdfs_inodes_btree_info *)node->tree;
+
+	spin_lock(&itree->lock);
+	free_inodes = itree->free_inodes;
+	if (free_inodes < count)
+		err = -ERANGE;
+	else {
+		u64 upper_bound = start_hash + start + count - 1;
+
+		itree->allocated_inodes += count;
+		itree->free_inodes -= count;
+		if (itree->upper_allocated_ino < upper_bound)
+			itree->upper_allocated_ino = upper_bound;
+	}
+
+	upper_allocated_ino = itree->upper_allocated_ino;
+	allocated_inodes = itree->allocated_inodes;
+	free_inodes = itree->free_inodes;
+	inodes_capacity = itree->inodes_capacity;
+	spin_unlock(&itree->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("upper_allocated_ino %llu, allocated_inodes %llu, "
+		  "free_inodes %llu, inodes_capacity %llu\n",
+		  itree->upper_allocated_ino,
+		  itree->allocated_inodes,
+		  itree->free_inodes,
+		  itree->inodes_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct free_inodes count: "
+			  "free_inodes %llu, count %u, err %d\n",
+			  free_inodes, count, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_allocate_item() - allocate item in the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to allocate an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free items.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_inodes_btree_node_allocate_item(struct ssdfs_btree_node *node,
+					  struct ssdfs_btree_search *search)
+{
+	int state;
+	u64 start_hash;
+	u64 end_hash;
+	unsigned long start = ULONG_MAX;
+	unsigned int count = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+
+	ssdfs_debug_btree_search_object(search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND) {
+		SSDFS_ERR("invalid result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.err == -ENODATA) {
+		search->result.err = 0;
+		/*
+		 * Node doesn't contain an item.
+		 */
+	} else if (search->result.err) {
+		SSDFS_WARN("invalid search result: err %d\n",
+			   search->result.err);
+		return search->result.err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->request.count != 1);
+	BUG_ON(search->result.buf);
+	BUG_ON(search->result.buf_state !=
+		SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->items_area.state);
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_allocated_range(search,
+					   start_hash, end_hash,
+					   &start, &count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define allocated range: err %d\n",
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(start >= U16_MAX);
+	BUG_ON(count >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count != 1) {
+		SSDFS_ERR("invalid count %u\n",
+			  count);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_btree_node_allocate_range(node, search,
+						start, count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate range "
+			  "(start %lu, count %u), err %d\n",
+			  start, count, err);
+		return err;
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_allocate_range() - allocate range of items
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to allocate a range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free items.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_inodes_btree_node_allocate_range(struct ssdfs_btree_node *node,
+					   struct ssdfs_btree_search *search)
+{
+	int state;
+	u64 start_hash;
+	u64 end_hash;
+	unsigned long start = ULONG_MAX;
+	unsigned int count = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND) {
+		SSDFS_ERR("invalid result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.err == -ENODATA) {
+		search->result.err = 0;
+		/*
+		 * Node doesn't contain an item.
+		 */
+	} else if (search->result.err) {
+		SSDFS_WARN("invalid search result: err %d\n",
+			   search->result.err);
+		return search->result.err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.buf);
+	BUG_ON(search->result.buf_state !=
+		SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->items_area.state);
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	err = ssdfs_define_allocated_range(search,
+					   start_hash, end_hash,
+					   &start, &count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to define allocated range: err %d\n",
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(start >= U16_MAX);
+	BUG_ON(count >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_btree_node_allocate_range(node, search,
+						start, count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate range "
+			  "(start %lu, count %u), err %d\n",
+			  start, count, err);
+		return err;
+	}
+
+	return 0;
+}
+
+static
+int ssdfs_inodes_btree_node_insert_item(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return -EOPNOTSUPP;
+}
+
+/*
+ * __ssdfs_inodes_btree_node_insert_range() - insert range into node
+ * @node: pointer on node object
+ * @search: search object
+ *
+ * This method tries to insert the range of inodes into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int __ssdfs_inodes_btree_node_insert_range(struct ssdfs_btree_node *node,
+					   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_inodes_btree_info *itree;
+	struct ssdfs_inodes_btree_node_header *hdr;
+	struct ssdfs_btree_node_items_area items_area;
+	size_t item_size = sizeof(struct ssdfs_inode);
+	struct ssdfs_btree_index_key key;
+	u16 item_index;
+	int free_items;
+	u16 inodes_count = 0;
+	u32 used_space;
+	u16 items_count = 0;
+	u16 valid_inodes = 0;
+	u64 free_inodes;
+	u64 allocated_inodes;
+	u64 inodes_capacity;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid items_area state %#x\n",
+			  atomic_read(&node->items_area.state));
+		return -ERANGE;
+	}
+
+	tree = node->tree;
+
+	switch (tree->type) {
+	case SSDFS_INODES_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	itree = (struct ssdfs_inodes_btree_info *)node->tree;
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     &node->items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     sizeof(struct ssdfs_btree_node_items_area));
+	up_read(&node->header_lock);
+
+	if (items_area.items_capacity == 0 ||
+	    items_area.items_capacity < items_area.items_count) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid items accounting: "
+			  "node_id %u, items_capacity %u, items_count %u\n",
+			  node->node_id, items_area.items_capacity,
+			  items_area.items_count);
+		return -EFAULT;
+	}
+
+	if (items_area.min_item_size != 0 ||
+	    items_area.max_item_size != item_size) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("min_item_size %u, max_item_size %u, "
+			  "item_size %zu\n",
+			  items_area.min_item_size, items_area.max_item_size,
+			  item_size);
+		return -EFAULT;
+	}
+
+	if (items_area.area_size == 0 ||
+	    items_area.area_size >= node->node_size) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid area_size %u\n",
+			  items_area.area_size);
+		return -EFAULT;
+	}
+
+	if (items_area.free_space > items_area.area_size) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("free_space %u > area_size %u\n",
+			  items_area.free_space, items_area.area_size);
+		return -EFAULT;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_capacity %u, items_count %u\n",
+		  items_area.items_capacity,
+		  items_area.items_count);
+	SSDFS_DBG("area_size %u, free_space %u\n",
+		  items_area.area_size,
+		  items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	free_items = items_area.items_capacity - items_area.items_count;
+	if (unlikely(free_items < 0)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_WARN("invalid free_items %d\n",
+			   free_items);
+		return -EFAULT;
+	} else if (free_items == 0) {
+		SSDFS_DBG("node hasn't free items\n");
+		return -ENOSPC;
+	}
+
+	if (free_items != items_area.items_capacity) {
+		SSDFS_WARN("free_items %d != items_capacity %u\n",
+			   free_items, items_area.items_capacity);
+		return -ERANGE;
+	}
+
+	if (((u64)free_items * item_size) > items_area.free_space) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid free_items: "
+			  "free_items %d, item_size %zu, free_space %u\n",
+			  free_items, item_size, items_area.free_space);
+		return -EFAULT;
+	}
+
+	item_index = search->result.start_index;
+	if (item_index != 0) {
+		SSDFS_ERR("start_index != 0\n");
+		return -ERANGE;
+	} else if ((item_index + search->request.count) >= items_area.items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	inodes_count = search->request.count;
+
+	if ((item_index + inodes_count) > items_area.items_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid inodes_count: "
+			  "item_index %u, inodes_count %u, "
+			  "items_capacity %u\n",
+			  item_index, inodes_count,
+			  items_area.items_capacity);
+		goto finish_detect_affected_items;
+	}
+
+	err = ssdfs_lock_items_range(node, item_index, inodes_count);
+	if (err == -ENOENT) {
+		up_write(&node->full_lock);
+		wake_up_all(&node->wait_queue);
+		return -ERANGE;
+	} else if (err == -ENODATA) {
+		up_write(&node->full_lock);
+		wake_up_all(&node->wait_queue);
+		return -ERANGE;
+	} else if (unlikely(err))
+		BUG();
+
+finish_detect_affected_items:
+	downgrade_write(&node->full_lock);
+
+	if (unlikely(err))
+		goto finish_insert_item;
+
+	err = ssdfs_generic_insert_range(node, &items_area,
+					 item_size, search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to insert item: err %d\n",
+			  err);
+		goto unlock_items_range;
+	}
+
+	down_write(&node->header_lock);
+
+	node->items_area.items_count += search->request.count;
+	if (node->items_area.items_count > node->items_area.items_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("items_count %u > items_capacity %u\n",
+			  node->items_area.items_count,
+			  node->items_area.items_capacity);
+		goto finish_items_area_correction;
+	}
+	items_count = node->items_area.items_count;
+
+	hdr = &node->raw.inodes_header;
+	le16_add_cpu(&hdr->valid_inodes, (u16)search->request.count);
+	valid_inodes = le16_to_cpu(hdr->valid_inodes);
+
+	used_space = (u32)search->request.count * item_size;
+	if (used_space > node->items_area.free_space) {
+		err = -ERANGE;
+		SSDFS_ERR("used_space %u > free_space %u\n",
+			  used_space,
+			  node->items_area.free_space);
+		goto finish_items_area_correction;
+	}
+	node->items_area.free_space -= used_space;
+
+finish_items_area_correction:
+	up_write(&node->header_lock);
+
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		goto unlock_items_range;
+	}
+
+	err = ssdfs_allocate_items_range(node, search,
+					 items_area.items_capacity,
+					 item_index, inodes_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to allocate range: "
+			  "start %u, len %u, err %d\n",
+			  item_index, inodes_count, err);
+		goto unlock_items_range;
+	}
+
+	err = ssdfs_set_node_header_dirty(node, items_area.items_capacity);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set header dirty: err %d\n",
+			  err);
+		goto unlock_items_range;
+	}
+
+	err = ssdfs_set_dirty_items_range(node, items_area.items_capacity,
+					  item_index, inodes_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, inodes_count, err);
+		goto unlock_items_range;
+	}
+
+unlock_items_range:
+	ssdfs_unlock_items_range(node, item_index, inodes_count);
+
+finish_insert_item:
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		return err;
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		spin_lock(&node->descriptor_lock);
+		ssdfs_memcpy(&key,
+			     0, sizeof(struct ssdfs_btree_index_key),
+			     &node->node_index,
+			     0, sizeof(struct ssdfs_btree_index_key),
+			     sizeof(struct ssdfs_btree_index_key));
+		spin_unlock(&node->descriptor_lock);
+
+		key.index.hash = cpu_to_le64(search->request.start.hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, node_type %#x, "
+			  "node_height %u, hash %llx\n",
+			  le32_to_cpu(key.node_id),
+			  key.node_type,
+			  key.height,
+			  le64_to_cpu(key.index.hash));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_btree_node_add_index(node, &key);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add index: err %d\n", err);
+			return err;
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	spin_lock(&itree->lock);
+	free_inodes = itree->free_inodes;
+	if (free_inodes < search->request.count)
+		err = -ERANGE;
+	else {
+		itree->allocated_inodes += search->request.count;
+		itree->free_inodes -= search->request.count;
+	}
+	allocated_inodes = itree->allocated_inodes;
+	free_inodes = itree->free_inodes;
+	inodes_capacity = itree->inodes_capacity;
+	spin_unlock(&itree->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("valid_inodes %u, items_count %u, "
+		  "allocated_inodes %llu, "
+		  "free_inodes %llu, inodes_capacity %llu, "
+		  "search->request.count %u\n",
+		  valid_inodes, items_count,
+		  allocated_inodes,
+		  free_inodes, inodes_capacity,
+		  search->request.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct allocated_inodes count: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_insert_range() - insert range of items
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to insert a range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - node hasn't free items.
+ * %-ENOMEM     - fail to allocate memory.
+ */
+static
+int ssdfs_inodes_btree_node_insert_range(struct ssdfs_btree_node *node,
+					 struct ssdfs_btree_search *search)
+{
+	int state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+	SSDFS_DBG("free_space %u\n", node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.err == -ENODATA) {
+		/*
+		 * Node doesn't contain inserting items.
+		 */
+	} else if (search->result.err) {
+		SSDFS_WARN("invalid search result: err %d\n",
+			   search->result.err);
+		return search->result.err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count <= 1);
+	BUG_ON(!search->result.buf);
+	BUG_ON(search->result.buf_state != SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_inodes_btree_node_insert_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert range: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("free_space %u\n", node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_change_item() - change an item in the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to change an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_node_change_item(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+	int state;
+	u16 item_index;
+	u16 items_count;
+	u16 items_capacity;
+	u64 start_hash;
+	u64 end_hash;
+	u64 found_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+
+	ssdfs_debug_btree_search_object(search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		SSDFS_ERR("invalid result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.err) {
+		SSDFS_WARN("invalid search result: err %d\n",
+			   search->result.err);
+		return search->result.err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count != 1);
+	BUG_ON(!search->result.buf);
+	BUG_ON(search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER);
+	BUG_ON(search->result.items_in_buffer != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->items_area.state);
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	up_read(&node->header_lock);
+
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	if (items_capacity == 0 || items_capacity < items_count) {
+		SSDFS_ERR("invalid items accounting: "
+			  "node_id %u, items_capacity %u, items_count %u\n",
+			  search->node.id, items_capacity, items_count);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_node_check_hash_range(node,
+						items_count,
+						items_capacity,
+						start_hash,
+						end_hash,
+						search);
+	if (err)
+		return err;
+
+	found_index = search->request.start.hash - start_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(found_index >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((found_index + search->request.count) > items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "found_index %llu, count %u, "
+			  "items_capacity %u\n",
+			  found_index, search->request.count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	item_index = (u16)found_index;
+
+	down_write(&node->full_lock);
+
+	err = ssdfs_lock_items_range(node, item_index, search->result.count);
+	if (err == -ENOENT) {
+		up_write(&node->full_lock);
+		return -ERANGE;
+	} else if (err == -ENODATA) {
+		up_write(&node->full_lock);
+		wake_up_all(&node->wait_queue);
+		return -ERANGE;
+	} else if (unlikely(err))
+		BUG();
+
+	downgrade_write(&node->full_lock);
+
+	if (!is_ssdfs_node_items_range_allocated(node, items_capacity,
+						 item_index,
+						 search->result.count)) {
+		err = -ERANGE;
+		SSDFS_WARN("range wasn't be allocated: "
+			   "start %u, count %u\n",
+			   item_index, search->result.count);
+		goto finish_change_item;
+	}
+
+	err = ssdfs_copy_item_into_node_unlocked(node, search, item_index, 0);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy item into the node: "
+			  "item_index %u, err %d\n",
+			  item_index, err);
+		goto finish_change_item;
+	}
+
+	err = ssdfs_set_dirty_items_range(node, items_capacity,
+					  item_index,
+					  search->result.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, search->result.count, err);
+		goto finish_change_item;
+	}
+
+	ssdfs_unlock_items_range(node, item_index, search->result.count);
+
+finish_change_item:
+	up_read(&node->full_lock);
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+/*
+ * ssdfs_correct_hybrid_node_items_area_hashes() - correct items area hashes
+ * @node: pointer on node object
+ */
+static
+int ssdfs_correct_hybrid_node_hashes(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_index_key key;
+	size_t hdr_size = sizeof(struct ssdfs_inodes_btree_node_header);
+	u64 start_hash;
+	u64 end_hash;
+	u16 items_count;
+	u16 index_count;
+	u32 items_area_size;
+	u32 items_capacity;
+	u16 index_id;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected node type */
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	down_write(&node->header_lock);
+
+	items_count = node->items_area.items_count;
+
+	if (items_count != 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid request: items_count %u\n",
+			  items_count);
+		goto unlock_header;
+	}
+
+	index_count = node->index_area.index_count;
+
+	if (index_count == 0) {
+		err = -ENODATA;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("do nothing: node %u is empty\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto unlock_header;
+	}
+
+	index_id = index_count - 1;
+	err = ssdfs_btree_node_get_index(&node->content.pvec,
+					 node->index_area.offset,
+					 node->index_area.area_size,
+					 node->node_size,
+					 index_id, &key);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to extract index: "
+			  "node_id %u, index %d, err %d\n",
+			  node->node_id, index_id, err);
+		goto unlock_header;
+	}
+
+	items_area_size = node->node_size - hdr_size;
+	items_capacity = items_area_size / node->tree->item_size;
+
+	start_hash = le64_to_cpu(key.index.hash);
+	start_hash += items_capacity;
+	end_hash = start_hash + node->items_area.items_capacity - 1;
+
+	node->items_area.start_hash = start_hash;
+	node->items_area.end_hash = end_hash;
+
+unlock_header:
+	up_write(&node->header_lock);
+
+	if (err == -ENODATA) {
+		err = 0;
+		/* do nothing */
+		goto finish_correct_hybrid_node_hashes;
+	} else if (unlikely(err)) {
+		/* finish logic */
+		goto finish_correct_hybrid_node_hashes;
+	}
+
+	spin_lock(&node->descriptor_lock);
+	ssdfs_memcpy(&key,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     &node->node_index,
+		     0, sizeof(struct ssdfs_btree_index_key),
+		     sizeof(struct ssdfs_btree_index_key));
+	spin_unlock(&node->descriptor_lock);
+
+	key.index.hash = cpu_to_le64(start_hash);
+
+	err = ssdfs_btree_node_add_index(node, &key);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add index: err %d\n",
+			  err);
+		return err;
+	}
+
+finish_correct_hybrid_node_hashes:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, "
+		  "items_area (start_hash %llx, end_hash %llx), "
+		  "index_area (start_hash %llx, end_hash %llx)\n",
+		  node->node_id,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash,
+		  node->index_area.start_hash,
+		  node->index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * __ssdfs_inodes_btree_node_delete_range() - delete range of items
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to delete a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_inodes_btree_node_delete_range(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_inodes_btree_info *itree;
+	struct ssdfs_inodes_btree_node_header *hdr;
+	struct ssdfs_state_bitmap *bmap;
+	int state;
+	u16 item_index;
+	u16 item_size;
+	u16 items_count;
+	u16 items_capacity;
+	u16 index_count = 0;
+	int free_items;
+	u64 start_hash;
+	u64 end_hash;
+	u64 old_hash;
+	u64 index_start_hash;
+	u64 index_end_hash;
+	u32 bmap_bytes;
+	u16 valid_inodes;
+	u64 allocated_inodes;
+	u64 free_inodes;
+	u64 inodes_capacity;
+	u32 area_size;
+	u32 freed_space;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		SSDFS_ERR("invalid result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.err) {
+		SSDFS_WARN("invalid search result: err %d\n",
+			   search->result.err);
+		return search->result.err;
+	}
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->items_area.state);
+	item_size = node->items_area.item_size;
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	old_hash = start_hash;
+	up_read(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, items_capacity %u, "
+		  "node (start_hash %llx, end_hash %llx)\n",
+		  items_count, items_capacity,
+		  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	if (items_capacity == 0 || items_capacity < items_count) {
+		SSDFS_ERR("invalid items accounting: "
+			  "node_id %u, items_capacity %u, items_count %u\n",
+			  search->node.id, items_capacity, items_count);
+		return -ERANGE;
+	}
+
+	free_items = items_capacity - items_count;
+	if (unlikely(free_items < 0 || free_items > items_capacity)) {
+		SSDFS_WARN("invalid free_items %d\n",
+			   free_items);
+		return -ERANGE;
+	} else if (free_items == items_capacity) {
+		SSDFS_DBG("node hasn't any items\n");
+		return 0;
+	}
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u, "
+			  "items_capacity %u\n",
+			  item_index, search->request.count,
+			  items_capacity);
+		return -ERANGE;
+	}
+
+	if ((start_hash + item_index) != search->request.start.hash) {
+		SSDFS_WARN("node (start_hash %llx, index %u), "
+			   "request (start_hash %llx, end_hash %llx)\n",
+			   start_hash, item_index,
+			   search->request.start.hash,
+			   search->request.end.hash);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	err = ssdfs_lock_items_range(node, item_index, search->request.count);
+	if (err == -ENOENT) {
+		up_write(&node->full_lock);
+		return -ERANGE;
+	} else if (err == -ENODATA) {
+		up_write(&node->full_lock);
+		wake_up_all(&node->wait_queue);
+		return -ERANGE;
+	} else if (unlikely(err))
+		BUG();
+
+	downgrade_write(&node->full_lock);
+
+	if (!is_ssdfs_node_items_range_allocated(node, items_capacity,
+						 item_index,
+						 search->result.count)) {
+		err = -ERANGE;
+		SSDFS_WARN("range wasn't be allocated: "
+			   "start %u, count %u\n",
+			   item_index, search->result.count);
+		goto finish_delete_range;
+	}
+
+	err = ssdfs_free_items_range(node, item_index, search->result.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to free range: "
+			  "start %u, count %u, err %d\n",
+			  item_index, search->result.count, err);
+		goto finish_delete_range;
+	}
+
+	err = ssdfs_btree_node_clear_range(node, &node->items_area,
+					   item_size, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear items range: err %d\n",
+			  err);
+		goto finish_delete_range;
+	}
+
+	err = ssdfs_set_dirty_items_range(node, items_capacity,
+					  item_index,
+					  search->result.count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, search->result.count, err);
+		goto finish_delete_range;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count == 0 || search->result.count >= U16_MAX);
+	BUG_ON(search->request.count != search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&node->header_lock);
+
+	hdr = &node->raw.inodes_header;
+	valid_inodes = le16_to_cpu(hdr->valid_inodes);
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(valid_inodes < search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	hdr->valid_inodes = cpu_to_le16(valid_inodes - search->result.count);
+	valid_inodes = le16_to_cpu(hdr->valid_inodes);
+	down_read(&node->bmap_array.lock);
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP];
+	bmap_bytes = node->bmap_array.bmap_bytes;
+	spin_lock(&bmap->lock);
+	ssdfs_memcpy(hdr->bmap, 0, bmap_bytes,
+		     bmap->ptr, 0, bmap_bytes,
+		     bmap_bytes);
+	spin_unlock(&bmap->lock);
+	up_read(&node->bmap_array.lock);
+	node->items_area.items_count -= search->result.count;
+	area_size = node->items_area.area_size;
+	freed_space = (u32)node->items_area.item_size * search->result.count;
+	if ((node->items_area.free_space + freed_space) > area_size) {
+		err = -ERANGE;
+		SSDFS_ERR("freed_space %u, free_space %u, area_size %u\n",
+			  freed_space,
+			  node->items_area.free_space,
+			  area_size);
+		goto finish_change_node_header;
+	} else
+		node->items_area.free_space += freed_space;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %u, valid_inodes %u, "
+		  "area_size %u, free_space %u, "
+		  "node (start_hash %llx, end_hash %llx)\n",
+		  node->items_area.items_count,
+		  valid_inodes,
+		  node->items_area.area_size,
+		  node->items_area.free_space,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	up_write(&node->header_lock);
+
+finish_change_node_header:
+	if (unlikely(err))
+		goto finish_delete_range;
+
+	err = ssdfs_set_node_header_dirty(node, items_capacity);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set header dirty: err %d\n",
+			  err);
+		goto finish_delete_range;
+	}
+
+finish_delete_range:
+	ssdfs_unlock_items_range(node, item_index, search->request.count);
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		return err;
+
+	down_read(&node->header_lock);
+	items_count = node->items_area.items_count;
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+	index_count = node->index_area.index_count;
+	index_start_hash = node->index_area.start_hash;
+	index_end_hash = node->index_area.end_hash;
+	up_read(&node->header_lock);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		state = atomic_read(&node->index_area.state);
+
+		if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+			SSDFS_ERR("invalid area state %#x\n",
+				  state);
+			return -ERANGE;
+		}
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+		case SSDFS_BTREE_SEARCH_DELETE_ALL:
+			/*
+			 * Moving all items into a leaf node
+			 */
+			if (items_count == 0) {
+				err = ssdfs_btree_node_delete_index(node,
+								    old_hash);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to delete index: "
+						  "old_hash %llx, err %d\n",
+						  old_hash, err);
+					return err;
+				}
+
+				if (index_count > 0)
+					index_count--;
+			} else {
+				SSDFS_WARN("unexpected items_count %u\n",
+					   items_count);
+				return -ERANGE;
+			}
+			break;
+
+		case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+			if (items_count == 0) {
+				err = ssdfs_btree_node_delete_index(node,
+								    old_hash);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to delete index: "
+						  "old_hash %llx, err %d\n",
+						  old_hash, err);
+					return err;
+				}
+
+				if (index_count > 0)
+					index_count--;
+
+				err = ssdfs_correct_hybrid_node_hashes(node);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to correct hybrid nodes: "
+						  "err %d\n", err);
+					return err;
+				}
+
+				down_read(&node->header_lock);
+				start_hash = node->items_area.start_hash;
+				end_hash = node->items_area.end_hash;
+				up_read(&node->header_lock);
+			}
+			break;
+
+		default:
+			BUG();
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	itree = (struct ssdfs_inodes_btree_info *)node->tree;
+
+	spin_lock(&itree->lock);
+	free_inodes = itree->free_inodes;
+	inodes_capacity = itree->inodes_capacity;
+	if (itree->allocated_inodes < search->request.count)
+		err = -ERANGE;
+	else if ((free_inodes + search->request.count) > inodes_capacity)
+		err = -ERANGE;
+	else {
+		itree->allocated_inodes -= search->request.count;
+		itree->free_inodes += search->request.count;
+	}
+	free_inodes = itree->free_inodes;
+	allocated_inodes = itree->allocated_inodes;
+	spin_unlock(&itree->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("valid_inodes %u, allocated_inodes %llu, "
+		  "free_inodes %llu, inodes_capacity %llu, "
+		  "search->request.count %u\n",
+		  valid_inodes, allocated_inodes,
+		  free_inodes, inodes_capacity,
+		  search->request.count);
+	SSDFS_DBG("items_area (start_hash %llx, end_hash %llx), "
+		  "index_area (start_hash %llx, end_hash %llx), "
+		  "valid_inodes %u, index_count %u\n",
+		  start_hash, end_hash,
+		  index_start_hash, index_end_hash,
+		  valid_inodes, index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct allocated_inodes count: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	if (valid_inodes == 0 && index_count == 0) {
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("PLEASE, DELETE node_id %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else
+		search->result.state = SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+
+	ssdfs_debug_btree_node_object(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_delete_item() - delete an item from the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to delete an item from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_node_delete_item(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+
+	BUG_ON(search->result.count != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_inodes_btree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete inode: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_delete_range() - delete a range of items
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to delete a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_inodes_btree_node_delete_range(struct ssdfs_btree_node *node,
+					 struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_inodes_btree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete inodes range: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_inodes_btree_node_extract_range() - extract range of items from node
+ * @node: pointer on node object
+ * @start_index: starting index of the range
+ * @count: count of items in the range
+ * @search: pointer on search request object
+ *
+ * This method tries to extract a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-ENODATA    - no such range in the node.
+ */
+static
+int ssdfs_inodes_btree_node_extract_range(struct ssdfs_btree_node *node,
+					  u16 start_index, u16 count,
+					  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_inode *inode;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_index %u, count %u, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  start_index, count,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_node_extract_range(node, start_index, count,
+						sizeof(struct ssdfs_inode),
+						search);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract a range: "
+			  "start %u, count %u, err %d\n",
+			  start_index, count, err);
+		return err;
+	}
+
+	search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+	inode = (struct ssdfs_inode *)search->result.buf;
+	search->request.start.hash = le64_to_cpu(inode->ino);
+	inode += search->result.count - 1;
+	search->request.end.hash = le64_to_cpu(inode->ino);
+	search->request.count = count;
+
+	return 0;
+}
+
+static
+int ssdfs_inodes_btree_resize_items_area(struct ssdfs_btree_node *node,
+					 u32 new_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return -EOPNOTSUPP;
+}
+
+void ssdfs_debug_inodes_btree_object(struct ssdfs_inodes_btree_info *tree)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct list_head *this, *next;
+
+	BUG_ON(!tree);
+
+	SSDFS_DBG("INODES TREE: is_locked %d, upper_allocated_ino %llu, "
+		  "allocated_inodes %llu, free_inodes %llu, "
+		  "inodes_capacity %llu, leaf_nodes %u, "
+		  "nodes_count %u\n",
+		  spin_is_locked(&tree->lock),
+		  tree->upper_allocated_ino,
+		  tree->allocated_inodes,
+		  tree->free_inodes,
+		  tree->inodes_capacity,
+		  tree->leaf_nodes,
+		  tree->nodes_count);
+
+	ssdfs_debug_btree_object(&tree->generic_tree);
+
+	SSDFS_DBG("ROOT FOLDER: magic %#x, mode %#x, flags %#x, "
+		  "uid %u, gid %u, atime %llu, ctime %llu, "
+		  "mtime %llu, birthtime %llu, "
+		  "atime_nsec %u, ctime_nsec %u, mtime_nsec %u, "
+		  "birthtime_nsec %u, generation %llu, "
+		  "size %llu, blocks %llu, parent_ino %llu, "
+		  "refcount %u, checksum %#x, ino %llu, "
+		  "hash_code %llu, name_len %u, "
+		  "private_flags %#x, dentries %u\n",
+		  le16_to_cpu(tree->root_folder.magic),
+		  le16_to_cpu(tree->root_folder.mode),
+		  le32_to_cpu(tree->root_folder.flags),
+		  le32_to_cpu(tree->root_folder.uid),
+		  le32_to_cpu(tree->root_folder.gid),
+		  le64_to_cpu(tree->root_folder.atime),
+		  le64_to_cpu(tree->root_folder.ctime),
+		  le64_to_cpu(tree->root_folder.mtime),
+		  le64_to_cpu(tree->root_folder.birthtime),
+		  le32_to_cpu(tree->root_folder.atime_nsec),
+		  le32_to_cpu(tree->root_folder.ctime_nsec),
+		  le32_to_cpu(tree->root_folder.mtime_nsec),
+		  le32_to_cpu(tree->root_folder.birthtime_nsec),
+		  le64_to_cpu(tree->root_folder.generation),
+		  le64_to_cpu(tree->root_folder.size),
+		  le64_to_cpu(tree->root_folder.blocks),
+		  le64_to_cpu(tree->root_folder.parent_ino),
+		  le32_to_cpu(tree->root_folder.refcount),
+		  le32_to_cpu(tree->root_folder.checksum),
+		  le64_to_cpu(tree->root_folder.ino),
+		  le64_to_cpu(tree->root_folder.hash_code),
+		  le16_to_cpu(tree->root_folder.name_len),
+		  le16_to_cpu(tree->root_folder.private_flags),
+		  le32_to_cpu(tree->root_folder.count_of.dentries));
+
+	SSDFS_DBG("PRIVATE AREA DUMP:\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     &tree->root_folder.internal[0],
+			     sizeof(struct ssdfs_inode_private_area));
+	SSDFS_DBG("\n");
+
+	if (!list_empty_careful(&tree->free_inodes_queue.list)) {
+		SSDFS_DBG("FREE INODES RANGES:\n");
+
+		list_for_each_safe(this, next, &tree->free_inodes_queue.list) {
+			struct ssdfs_inodes_btree_range *range;
+
+			range = list_entry(this,
+					   struct ssdfs_inodes_btree_range,
+					   list);
+
+			if (range) {
+				SSDFS_DBG("[node_id %u, start_hash %llx, "
+					  "start_index %u, count %u], ",
+					  range->node_id,
+					  range->area.start_hash,
+					  range->area.start_index,
+					  range->area.count);
+			}
+		}
+
+		SSDFS_DBG("\n");
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+const struct ssdfs_btree_descriptor_operations ssdfs_inodes_btree_desc_ops = {
+	.init		= ssdfs_inodes_btree_desc_init,
+	.flush		= ssdfs_inodes_btree_desc_flush,
+};
+
+const struct ssdfs_btree_operations ssdfs_inodes_btree_ops = {
+	.create_root_node	= ssdfs_inodes_btree_create_root_node,
+	.create_node		= ssdfs_inodes_btree_create_node,
+	.init_node		= ssdfs_inodes_btree_init_node,
+	.destroy_node		= ssdfs_inodes_btree_destroy_node,
+	.add_node		= ssdfs_inodes_btree_add_node,
+	.delete_node		= ssdfs_inodes_btree_delete_node,
+	.pre_flush_root_node	= ssdfs_inodes_btree_pre_flush_root_node,
+	.flush_root_node	= ssdfs_inodes_btree_flush_root_node,
+	.pre_flush_node		= ssdfs_inodes_btree_pre_flush_node,
+	.flush_node		= ssdfs_inodes_btree_flush_node,
+};
+
+const struct ssdfs_btree_node_operations ssdfs_inodes_btree_node_ops = {
+	.find_item		= ssdfs_inodes_btree_node_find_item,
+	.find_range		= ssdfs_inodes_btree_node_find_range,
+	.extract_range		= ssdfs_inodes_btree_node_extract_range,
+	.allocate_item		= ssdfs_inodes_btree_node_allocate_item,
+	.allocate_range		= ssdfs_inodes_btree_node_allocate_range,
+	.insert_item		= ssdfs_inodes_btree_node_insert_item,
+	.insert_range		= ssdfs_inodes_btree_node_insert_range,
+	.change_item		= ssdfs_inodes_btree_node_change_item,
+	.delete_item		= ssdfs_inodes_btree_node_delete_item,
+	.delete_range		= ssdfs_inodes_btree_node_delete_range,
+	.resize_items_area	= ssdfs_inodes_btree_resize_items_area,
+};
-- 
2.34.1

