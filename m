Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2F6A2669
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBYBT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBYBTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574E86A4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:52 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y184so798753oiy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0yvaQH4FC0lXUcbryy9NJTCK5J4j44PbJd9H8gjxoo=;
        b=1T6a+GInO6Tql0q1Qti+zRx1iRELLFjHGjfSDZh/1mMk0xSVszBbeXbC4cElFDe9bX
         6c5XgqGD0+is48DrT33E7rewc+oVk6cxtcogaKlmDcvEHo4irCjX2XgHccDEdgLPQhgA
         BhieFl4MmcNaaEaD1cvav0zT46fraW+AjDOD134DiQ2SKrhJuA0QhuXHHN+DV9SwkDCx
         PKVoYm6OHAO+/Yt6tWHhHLlfcq5e5yUjnsvTkNSzT/NP61pni0KT48+rVIRLAY/tv+TB
         Cs41xHmNRUcIDrG6x0wTXAdGsa3EugyC4RMxWv3jwWcedTUXCS3jnQ07ND3b/yz3g9qf
         wFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0yvaQH4FC0lXUcbryy9NJTCK5J4j44PbJd9H8gjxoo=;
        b=Q0wJNVIt7azuxRPNCiAFKCY5uMxjQ6sHT13FN8PgP6G4X7n9wuUEnsXMm2HrenhuMc
         UKGzsbToXwwD9qYn42qyp7DVrI6WrnGKCatlVNU0idAdWTTQ3xaChlAHwD4/SuLjGpYK
         I6kfg/9lb8emcYd5KQxj9KFQLTItkUPy7y2m7oDftD+TDEhLCDMa2Qm7iabz9rbgCheV
         giR2aS25C7704SsoRp+n/cNS2fnwJFhwhljiIr5CGIYpPIJWsQt0Gbp+5FKLUybAM/n5
         Vm2UiFMMi3hCz/xHm4LxY+V8kPYVTThWQsiNfSNzdPx3K7mb6S07L4YBu1yAXCaJT+7O
         ZNVw==
X-Gm-Message-State: AO0yUKVGhNaTWgLT6N6aJdBqH3CqPIEk4eqDU/y+JmyhIM633siQcwTT
        VZqVIDFIL0TYQPvr1PWlOtYWzGa0CHlc3iPb
X-Google-Smtp-Source: AK7set+ZjCMSHm41UETr6XfkPmwW/ozE4/VNCTBzCRCqSLqwiLHm4G3gpiRprYHYcW/Sqi+3rnCMUg==
X-Received: by 2002:a05:6808:ab3:b0:378:5f75:bf27 with SMTP id r19-20020a0568080ab300b003785f75bf27mr4186671oij.50.1677287870814;
        Fri, 24 Feb 2023 17:17:50 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:49 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 64/76] ssdfs: dentries b-tree node's specialized operations
Date:   Fri, 24 Feb 2023 17:09:15 -0800
Message-Id: <20230225010927.813929-65-slava@dubeyko.com>
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

Dentries b-tree node implements a specialized API:
(1) find_item - find item in the node
(2) find_range - find range of items in the node
(3) extract_range - extract range of items (or all items) from node
(4) insert_item - insert item in the node
(5) insert_range - insert range of items in the node
(6) change_item - change item in the node
(7) delete_item - delete item from the node
(8) delete_range - delete range of items from the node

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/dentries_tree.c | 3344 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 3344 insertions(+)

diff --git a/fs/ssdfs/dentries_tree.c b/fs/ssdfs/dentries_tree.c
index 9b4115b6bffa..55abc05d1e99 100644
--- a/fs/ssdfs/dentries_tree.c
+++ b/fs/ssdfs/dentries_tree.c
@@ -6380,3 +6380,3347 @@ int ssdfs_extract_range_by_lookup_index(struct ssdfs_btree_node *node,
 						ssdfs_prepare_dentries_buffer,
 						ssdfs_extract_found_dentry);
 }
+
+/*
+ * ssdfs_btree_search_result_no_data() - prepare result state for no data case
+ * @node: pointer on node object
+ * @lookup_index: lookup index
+ * @search: pointer on search request object [in|out]
+ *
+ * This method prepares result state for no data case.
+ */
+static inline
+void ssdfs_btree_search_result_no_data(struct ssdfs_btree_node *node,
+					u16 lookup_index,
+					struct ssdfs_btree_search *search)
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
+	search->result.state = SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+	search->result.err = -ENODATA;
+	search->result.start_index =
+			ssdfs_convert_lookup2item_index(node->node_size,
+							lookup_index);
+	search->result.count = search->request.count;
+	search->result.search_cno = ssdfs_current_cno(node->tree->fsi->sb);
+
+	if (!is_btree_search_contains_new_item(search)) {
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
+}
+
+/*
+ * ssdfs_dentries_btree_node_find_range() - find a range of items into the node
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
+int ssdfs_dentries_btree_node_find_range(struct ssdfs_btree_node *node,
+					 struct ssdfs_btree_search *search)
+{
+	int state;
+	u16 items_count;
+	u16 items_capacity;
+	u64 start_hash;
+	u64 end_hash;
+	u16 lookup_index;
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
+	err = ssdfs_dentries_btree_node_find_lookup_index(node, search,
+							 &lookup_index);
+	if (err == -ENODATA) {
+		ssdfs_btree_search_result_no_data(node, lookup_index, search);
+		return -ENODATA;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find the index: "
+			  "start_hash %llx, end_hash %llx, err %d\n",
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		return err;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(lookup_index >= SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_extract_range_by_lookup_index(node, lookup_index,
+						  search);
+	search->result.search_cno = ssdfs_current_cno(node->tree->fsi->sb);
+
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node contains not all requested dentries: "
+			  "node (start_hash %llx, end_hash %llx), "
+			  "request (start_hash %llx, end_hash %llx)\n",
+			  start_hash, end_hash,
+			  search->request.start.hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to extract range: "
+			  "node (start_hash %llx, end_hash %llx), "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  start_hash, end_hash,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		ssdfs_btree_search_result_no_data(node, lookup_index, search);
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to extract range: "
+			  "node (start_hash %llx, end_hash %llx), "
+			  "request (start_hash %llx, end_hash %llx), "
+			  "err %d\n",
+			  start_hash, end_hash,
+			  search->request.start.hash,
+			  search->request.end.hash,
+			  err);
+		return err;
+	}
+
+	search->request.flags &= ~SSDFS_BTREE_SEARCH_INLINE_BUF_HAS_NEW_ITEM;
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_btree_node_find_item() - find item into node
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
+int ssdfs_dentries_btree_node_find_item(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
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
+	return ssdfs_dentries_btree_node_find_range(node, search);
+}
+
+static
+int ssdfs_dentries_btree_node_allocate_item(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -EOPNOTSUPP;
+}
+
+static
+int ssdfs_dentries_btree_node_allocate_range(struct ssdfs_btree_node *node,
+					     struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -EOPNOTSUPP;
+}
+
+/*
+ * __ssdfs_dentries_btree_node_get_dentry() - extract the dentry from pagevec
+ * @pvec: pointer on pagevec
+ * @area_offset: area offset from the node's beginning
+ * @area_size: area size
+ * @node_size: size of the node
+ * @item_index: index of the dentry in the node
+ * @dentry: pointer on dentry's buffer [out]
+ *
+ * This method tries to extract the dentry from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_dentries_btree_node_get_dentry(struct pagevec *pvec,
+					   u32 area_offset,
+					   u32 area_size,
+					   u32 node_size,
+					   u16 item_index,
+					   struct ssdfs_dir_entry *dentry)
+{
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+	u32 item_offset;
+	int page_index;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec || !dentry);
+
+	SSDFS_DBG("area_offset %u, area_size %u, item_index %u\n",
+		  area_offset, area_size, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_offset = (u32)item_index * item_size;
+	if (item_offset >= area_size) {
+		SSDFS_ERR("item_offset %u >= area_size %u\n",
+			  item_offset, area_size);
+		return -ERANGE;
+	}
+
+	item_offset += area_offset;
+	if (item_offset >= node_size) {
+		SSDFS_ERR("item_offset %u >= node_size %u\n",
+			  item_offset, node_size);
+		return -ERANGE;
+	}
+
+	page_index = item_offset >> PAGE_SHIFT;
+
+	if (page_index > 0)
+		item_offset %= page_index * PAGE_SIZE;
+
+	if (page_index >= pagevec_count(pvec)) {
+		SSDFS_ERR("invalid page_index: "
+			  "index %d, pvec_size %u\n",
+			  page_index,
+			  pagevec_count(pvec));
+		return -ERANGE;
+	}
+
+	page = pvec->pages[page_index];
+	err = ssdfs_memcpy_from_page(dentry, 0, item_size,
+				     page, item_offset, PAGE_SIZE,
+				     item_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_btree_node_get_dentry() - extract dentry from the node
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_index: index of the dentry
+ * @dentry: pointer on extracted dentry [out]
+ *
+ * This method tries to extract the dentry from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_dentries_btree_node_get_dentry(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				u16 item_index,
+				struct ssdfs_dir_entry *dentry)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !dentry);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_dentries_btree_node_get_dentry(&node->content.pvec,
+						      area->offset,
+						      area->area_size,
+						      node->node_size,
+						      item_index,
+						      dentry);
+}
+
+/*
+ * is_requested_position_correct() - check that requested position is correct
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to check that requested position of a dentry
+ * into the node is correct.
+ *
+ * RETURN:
+ * [success]
+ *
+ * %SSDFS_CORRECT_POSITION        - requested position is correct.
+ * %SSDFS_SEARCH_LEFT_DIRECTION   - correct position from the left.
+ * %SSDFS_SEARCH_RIGHT_DIRECTION  - correct position from the right.
+ *
+ * [failure] - error code:
+ *
+ * %SSDFS_CHECK_POSITION_FAILURE  - internal error.
+ */
+static
+int is_requested_position_correct(struct ssdfs_btree_node *node,
+				  struct ssdfs_btree_node_items_area *area,
+				  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dir_entry dentry;
+	u16 item_index;
+	u64 ino;
+	u64 hash;
+	u32 req_flags;
+	size_t name_len;
+	int direction = SSDFS_CHECK_POSITION_FAILURE;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return SSDFS_CHECK_POSITION_FAILURE;
+	}
+
+	if (item_index >= area->items_count) {
+		if (area->items_count == 0)
+			item_index = area->items_count;
+		else
+			item_index = area->items_count - 1;
+
+		search->result.start_index = item_index;
+	}
+
+
+	err = ssdfs_dentries_btree_node_get_dentry(node, area,
+						   item_index, &dentry);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the dentry: "
+			  "item_index %u, err %d\n",
+			  item_index, err);
+		return SSDFS_CHECK_POSITION_FAILURE;
+	}
+
+	ino = le64_to_cpu(dentry.ino);
+	hash = le64_to_cpu(dentry.hash_code);
+	req_flags = search->request.flags;
+
+	if (search->request.end.hash < hash)
+		direction = SSDFS_SEARCH_LEFT_DIRECTION;
+	else if (hash < search->request.start.hash)
+		direction = SSDFS_SEARCH_RIGHT_DIRECTION;
+	else {
+		/* search->request.start.hash == hash */
+
+		if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_INO) {
+			if (search->request.start.ino < ino)
+				direction = SSDFS_SEARCH_LEFT_DIRECTION;
+			else if (ino < search->request.start.ino)
+				direction = SSDFS_SEARCH_RIGHT_DIRECTION;
+			else
+				direction = SSDFS_CORRECT_POSITION;
+		} else if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_NAME) {
+			int res;
+
+			if (!search->request.start.name) {
+				SSDFS_ERR("empty name pointer\n");
+				return -ERANGE;
+			}
+
+			name_len = min_t(size_t, search->request.start.name_len,
+					 SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+			res = strncmp(search->request.start.name,
+					dentry.inline_string,
+					name_len);
+			if (res < 0)
+				direction = SSDFS_SEARCH_LEFT_DIRECTION;
+			else if (res > 0)
+				direction = SSDFS_SEARCH_RIGHT_DIRECTION;
+			else
+				direction = SSDFS_CORRECT_POSITION;
+		} else
+			direction = SSDFS_CORRECT_POSITION;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("ino %llu, hash %llx, "
+		  "search (start_hash %llx, ino %llu; "
+		  "end_hash %llx, ino %llu), "
+		  "direction %#x\n",
+		  ino, hash,
+		  search->request.start.hash,
+		  search->request.start.ino,
+		  search->request.end.hash,
+		  search->request.end.ino,
+		  direction);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return direction;
+}
+
+/*
+ * ssdfs_find_correct_position_from_left() - find position from the left
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to find a correct position of the dentry
+ * from the left side of dentries' sequence in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_find_correct_position_from_left(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dir_entry dentry;
+	int item_index;
+	u64 ino;
+	u64 hash;
+	u32 req_flags;
+	size_t name_len;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) >= area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	if (item_index >= area->items_count) {
+		if (area->items_count == 0)
+			item_index = area->items_count;
+		else
+			item_index = area->items_count - 1;
+
+		search->result.start_index = (u16)item_index;
+		return 0;
+	}
+
+
+	req_flags = search->request.flags;
+
+	for (; item_index >= 0; item_index--) {
+		err = ssdfs_dentries_btree_node_get_dentry(node, area,
+							   (u16)item_index,
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the dentry: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		ino = le64_to_cpu(dentry.ino);
+		hash = le64_to_cpu(dentry.hash_code);
+
+		if (search->request.start.hash == hash) {
+			if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_INO) {
+				if (ino == search->request.start.ino) {
+					search->result.start_index =
+							(u16)item_index;
+					return 0;
+				} else if (ino < search->request.start.ino) {
+					search->result.start_index =
+							(u16)(item_index + 1);
+					return 0;
+				} else
+					continue;
+			}
+
+			if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_NAME) {
+				int res;
+
+				if (!search->request.start.name) {
+					SSDFS_ERR("empty name pointer\n");
+					return -ERANGE;
+				}
+
+				name_len = min_t(size_t,
+					    search->request.start.name_len,
+					    SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+				res = strncmp(search->request.start.name,
+						dentry.inline_string,
+						name_len);
+				if (res == 0) {
+					search->result.start_index =
+							(u16)item_index;
+					return 0;
+				} else if (res < 0) {
+					search->result.start_index =
+							(u16)(item_index + 1);
+					return 0;
+				} else
+					continue;
+			}
+
+			search->result.start_index = (u16)item_index;
+			return 0;
+		} else if (hash < search->request.start.hash) {
+			search->result.start_index = (u16)(item_index + 1);
+			return 0;
+		}
+	}
+
+	search->result.start_index = 0;
+	return 0;
+}
+
+/*
+ * ssdfs_find_correct_position_from_right() - find position from the right
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to find a correct position of the dentry
+ * from the right side of dentries' sequence in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_find_correct_position_from_right(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dir_entry dentry;
+	int item_index;
+	u64 ino;
+	u64 hash;
+	u32 req_flags;
+	size_t name_len;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, search->result.start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) >= area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	if (item_index >= area->items_count) {
+		if (area->items_count == 0)
+			item_index = area->items_count;
+		else
+			item_index = area->items_count - 1;
+
+		search->result.start_index = (u16)item_index;
+
+		return 0;
+	}
+
+	req_flags = search->request.flags;
+
+	for (; item_index < area->items_count; item_index++) {
+		err = ssdfs_dentries_btree_node_get_dentry(node, area,
+							   (u16)item_index,
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the dentry: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		ino = le64_to_cpu(dentry.ino);
+		hash = le64_to_cpu(dentry.hash_code);
+
+		if (search->request.start.hash == hash) {
+			if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_INO) {
+				if (ino == search->request.start.ino) {
+					search->result.start_index =
+							(u16)item_index;
+					return 0;
+				} else if (search->request.start.ino < ino) {
+					if (item_index == 0) {
+						search->result.start_index =
+								(u16)item_index;
+					} else {
+						search->result.start_index =
+							(u16)(item_index - 1);
+					}
+					return 0;
+				} else
+					continue;
+			}
+
+			if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_NAME) {
+				int res;
+
+				if (!search->request.start.name) {
+					SSDFS_ERR("empty name pointer\n");
+					return -ERANGE;
+				}
+
+				name_len = min_t(size_t,
+					    search->request.start.name_len,
+					    SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+				res = strncmp(search->request.start.name,
+						dentry.inline_string,
+						name_len);
+				if (res < 0)
+					continue;
+				else {
+					search->result.start_index =
+							(u16)item_index;
+				}
+			}
+
+			search->result.start_index = (u16)item_index;
+			return 0;
+		} else if (search->request.end.hash < hash) {
+			search->result.start_index = (u16)item_index;
+			return 0;
+		}
+	}
+
+	search->result.start_index = area->items_count;
+	return 0;
+}
+
+/*
+ * ssdfs_clean_lookup_table() - clean unused space of lookup table
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @start_index: starting index
+ *
+ * This method tries to clean the unused space of lookup table.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_clean_lookup_table(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_items_area *area,
+			     u16 start_index)
+{
+	__le64 *lookup_table;
+	u16 lookup_index;
+	u16 item_index;
+	u16 items_count;
+	u16 items_capacity;
+	u16 cleaning_indexes;
+	u32 cleaning_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u\n",
+		  node->node_id, start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	items_capacity = node->items_area.items_capacity;
+	if (start_index >= items_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u >= items_capacity %u\n",
+			  start_index, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	lookup_table = node->raw.dentries_header.lookup_table;
+
+	lookup_index = ssdfs_convert_item2lookup_index(node->node_size,
+						       start_index);
+	if (unlikely(lookup_index >= SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE)) {
+		SSDFS_ERR("invalid lookup_index %u\n",
+			  lookup_index);
+		return -ERANGE;
+	}
+
+	items_count = node->items_area.items_count;
+	item_index = ssdfs_convert_lookup2item_index(node->node_size,
+						     lookup_index);
+	if (unlikely(item_index >= items_capacity)) {
+		SSDFS_ERR("item_index %u >= items_capacity %u\n",
+			  item_index, items_capacity);
+		return -ERANGE;
+	}
+
+	if (item_index != start_index)
+		lookup_index++;
+
+	cleaning_indexes =
+		SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE - lookup_index;
+	cleaning_bytes = cleaning_indexes * sizeof(__le64);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lookup_index %u, cleaning_indexes %u, cleaning_bytes %u\n",
+		  lookup_index, cleaning_indexes, cleaning_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(&lookup_table[lookup_index], 0xFF, cleaning_bytes);
+
+	return 0;
+}
+
+/*
+ * ssdfs_correct_lookup_table() - correct lookup table of the node
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ *
+ * This method tries to correct the lookup table of the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_correct_lookup_table(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				u16 start_index, u16 range_len)
+{
+	__le64 *lookup_table;
+	struct ssdfs_dir_entry dentry;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u, range_len %u\n",
+		  node->node_id, start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range_len == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("range_len == 0\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	lookup_table = node->raw.dentries_header.lookup_table;
+
+	for (i = 0; i < range_len; i++) {
+		int item_index = start_index + i;
+		u16 lookup_index;
+
+		if (is_hash_for_lookup_table(node->node_size, item_index)) {
+			lookup_index =
+				ssdfs_convert_item2lookup_index(node->node_size,
+								item_index);
+
+			err = ssdfs_dentries_btree_node_get_dentry(node, area,
+								   item_index,
+								   &dentry);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to extract dentry: "
+					  "item_index %d, err %d\n",
+					  item_index, err);
+				return err;
+			}
+
+			lookup_table[lookup_index] = dentry.hash_code;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_initialize_lookup_table() - initialize lookup table
+ * @node: pointer on node object
+ */
+static
+void ssdfs_initialize_lookup_table(struct ssdfs_btree_node *node)
+{
+	__le64 *lookup_table;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lookup_table = node->raw.dentries_header.lookup_table;
+	memset(lookup_table, 0xFF,
+		sizeof(__le64) * SSDFS_DENTRIES_BTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * __ssdfs_dentries_btree_node_insert_range() - insert range into node
+ * @node: pointer on node object
+ * @search: search object
+ *
+ * This method tries to insert the range of dentries into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int __ssdfs_dentries_btree_node_insert_range(struct ssdfs_btree_node *node,
+					     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *dtree;
+	struct ssdfs_dentries_btree_node_header *hdr;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_dir_entry dentry;
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+	u16 item_index;
+	int free_items;
+	u16 range_len;
+	u16 dentries_count = 0;
+	int direction;
+	u32 used_space;
+	u64 start_hash = U64_MAX;
+	u64 end_hash = U64_MAX;
+	u64 cur_hash;
+	u64 old_hash;
+	u16 inline_names = 0;
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
+	case SSDFS_DENTRIES_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	dtree = container_of(tree, struct ssdfs_dentries_btree_info,
+				buffer.tree);
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     &node->items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     sizeof(struct ssdfs_btree_node_items_area));
+	old_hash = node->items_area.start_hash;
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
+	if (items_area.min_item_size != item_size ||
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
+	SSDFS_DBG("items_area: start_hash %llx, end_hash %llx\n",
+		  items_area.start_hash, items_area.end_hash);
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
+	if (((u64)free_items * item_size) > items_area.free_space) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid free_items: "
+			  "free_items %d, item_size %zu, free_space %u\n",
+			  free_items, item_size, items_area.free_space);
+		return -EFAULT;
+	}
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > items_area.items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	direction = is_requested_position_correct(node, &items_area,
+						  search);
+	switch (direction) {
+	case SSDFS_CORRECT_POSITION:
+		/* do nothing */
+		break;
+
+	case SSDFS_SEARCH_LEFT_DIRECTION:
+		err = ssdfs_find_correct_position_from_left(node, &items_area,
+							    search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the correct position: "
+				  "err %d\n",
+				  err);
+			goto finish_detect_affected_items;
+		}
+		break;
+
+	case SSDFS_SEARCH_RIGHT_DIRECTION:
+		err = ssdfs_find_correct_position_from_right(node, &items_area,
+							     search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the correct position: "
+				  "err %d\n",
+				  err);
+			goto finish_detect_affected_items;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("fail to check requested position\n");
+		goto finish_detect_affected_items;
+	}
+
+	range_len = items_area.items_count - search->result.start_index;
+	dentries_count = range_len + search->request.count;
+
+	item_index = search->result.start_index;
+	if ((item_index + dentries_count) > items_area.items_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid dentries_count: "
+			  "item_index %u, dentries_count %u, "
+			  "items_capacity %u\n",
+			  item_index, dentries_count,
+			  items_area.items_capacity);
+		goto finish_detect_affected_items;
+	}
+
+	if (items_area.items_count == 0)
+		goto lock_items_range;
+
+	start_hash = search->request.start.hash;
+	end_hash = search->request.end.hash;
+
+	if (item_index > 0) {
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+							   &items_area,
+							   item_index - 1,
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_detect_affected_items;
+		}
+
+		cur_hash = le64_to_cpu(dentry.hash_code);
+
+		if (cur_hash < start_hash) {
+			/*
+			 * expected state
+			 */
+		} else {
+			SSDFS_ERR("invalid range: item_index %u, "
+				  "cur_hash %llx, "
+				  "start_hash %llx, end_hash %llx\n",
+				  item_index, cur_hash,
+				  start_hash, end_hash);
+
+			for (i = 0; i < items_area.items_count; i++) {
+				err = ssdfs_dentries_btree_node_get_dentry(node,
+								   &items_area,
+								   i, &dentry);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to get dentry: "
+						  "err %d\n", err);
+					goto finish_detect_affected_items;
+				}
+
+				SSDFS_ERR("index %d, ino %llu, hash %llx\n",
+					  i,
+					  le64_to_cpu(dentry.ino),
+					  le64_to_cpu(dentry.hash_code));
+			}
+
+			err = -ERANGE;
+			goto finish_detect_affected_items;
+		}
+	}
+
+	if (item_index < items_area.items_count) {
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+							   &items_area,
+							   item_index,
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_detect_affected_items;
+		}
+
+		cur_hash = le64_to_cpu(dentry.hash_code);
+
+		if (end_hash < cur_hash) {
+			/*
+			 * expected state
+			 */
+		} else {
+			SSDFS_ERR("invalid range: item_index %u, "
+				  "cur_hash %llx, "
+				  "start_hash %llx, end_hash %llx\n",
+				  item_index, cur_hash,
+				  start_hash, end_hash);
+
+			for (i = 0; i < items_area.items_count; i++) {
+				err = ssdfs_dentries_btree_node_get_dentry(node,
+								   &items_area,
+								   i, &dentry);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to get dentry: "
+						  "err %d\n", err);
+					goto finish_detect_affected_items;
+				}
+
+				SSDFS_ERR("index %d, ino %llu, hash %llx\n",
+					  i,
+					  le64_to_cpu(dentry.ino),
+					  le64_to_cpu(dentry.hash_code));
+			}
+
+			err = -ERANGE;
+			goto finish_detect_affected_items;
+		}
+	}
+
+lock_items_range:
+	err = ssdfs_lock_items_range(node, item_index, dentries_count);
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
+	err = ssdfs_shift_range_right(node, &items_area, item_size,
+				      item_index, range_len,
+				      search->request.count);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to shift dentries range: "
+			  "start %u, count %u, err %d\n",
+			  item_index, search->request.count,
+			  err);
+		goto unlock_items_range;
+	}
+
+	ssdfs_debug_btree_node_object(node);
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
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_capacity %u, items_count %u\n",
+		  items_area.items_capacity,
+		  items_area.items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	err = ssdfs_dentries_btree_node_get_dentry(node, &node->items_area,
+						   0, &dentry);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get dentry: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+	start_hash = le64_to_cpu(dentry.hash_code);
+
+	err = ssdfs_dentries_btree_node_get_dentry(node,
+					&node->items_area,
+					node->items_area.items_count - 1,
+					&dentry);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get dentry: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+	end_hash = le64_to_cpu(dentry.hash_code);
+
+	if (start_hash >= U64_MAX || end_hash >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		goto finish_items_area_correction;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BEFORE: node_id %u, start_hash %llx, end_hash %llx\n",
+		  node->node_id,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node->items_area.start_hash = start_hash;
+	node->items_area.end_hash = end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("AFTER: node_id %u, start_hash %llx, end_hash %llx\n",
+		  node->node_id, start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_correct_lookup_table(node, &node->items_area,
+					 item_index, dentries_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	hdr = &node->raw.dentries_header;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("NODE (BEFORE): dentries_count %u\n",
+		  le16_to_cpu(hdr->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	le16_add_cpu(&hdr->dentries_count, search->request.count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("NODE (AFTER): dentries_count %u\n",
+		  le16_to_cpu(hdr->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	inline_names = 0;
+	for (i = 0; i < search->request.count; i++) {
+		u16 name_len;
+
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+							   &items_area,
+							   (i + item_index),
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+
+		name_len = le16_to_cpu(dentry.name_len);
+		if (name_len <= SSDFS_DENTRY_INLINE_NAME_MAX_LEN)
+			inline_names++;
+	}
+
+	le16_add_cpu(&hdr->inline_names, inline_names);
+	hdr->free_space = cpu_to_le16(node->items_area.free_space);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("TREE (BEFORE): dentries_count %llu\n",
+		  atomic64_read(&dtree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic64_add(search->request.count, &dtree->dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("TREE (AFTER): dentries_count %llu\n",
+		  atomic64_read(&dtree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_items_area_correction:
+	up_write(&node->header_lock);
+
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
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
+					  item_index, dentries_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, dentries_count, err);
+		goto unlock_items_range;
+	}
+
+unlock_items_range:
+	ssdfs_unlock_items_range(node, item_index, dentries_count);
+
+finish_insert_item:
+	up_read(&node->full_lock);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (items_area.items_count == 0) {
+			struct ssdfs_btree_index_key key;
+
+			spin_lock(&node->descriptor_lock);
+			ssdfs_memcpy(&key,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     &node->node_index,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     sizeof(struct ssdfs_btree_index_key));
+			spin_unlock(&node->descriptor_lock);
+
+			key.index.hash = cpu_to_le64(start_hash);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node_id %u, node_type %#x, "
+				  "node_height %u, hash %llx\n",
+				  le32_to_cpu(key.node_id),
+				  key.node_type,
+				  key.height,
+				  le64_to_cpu(key.index.hash));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = ssdfs_btree_node_add_index(node, &key);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add index: err %d\n", err);
+				return err;
+			}
+		} else if (old_hash != start_hash) {
+			struct ssdfs_btree_index_key old_key, new_key;
+
+			spin_lock(&node->descriptor_lock);
+			ssdfs_memcpy(&old_key,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     &node->node_index,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     sizeof(struct ssdfs_btree_index_key));
+			ssdfs_memcpy(&new_key,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     &node->node_index,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     sizeof(struct ssdfs_btree_index_key));
+			spin_unlock(&node->descriptor_lock);
+
+			old_key.index.hash = cpu_to_le64(old_hash);
+			new_key.index.hash = cpu_to_le64(start_hash);
+
+			err = ssdfs_btree_node_change_index(node,
+							&old_key, &new_key);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change index: err %d\n",
+					  err);
+				return err;
+			}
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_node_insert_item() - insert item in the node
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to insert an item in the node.
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
+int ssdfs_dentries_btree_node_insert_item(struct ssdfs_btree_node *node,
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
+		search->result.err = 0;
+		/*
+		 * Node doesn't contain requested item.
+		 */
+	} else if (search->result.err) {
+		SSDFS_WARN("invalid search result: err %d\n",
+			   search->result.err);
+		return search->result.err;
+	}
+
+	if (is_btree_search_contains_new_item(search)) {
+		switch (search->result.buf_state) {
+		case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+			search->result.buf = &search->raw.dentry;
+			search->result.buf_size =
+					sizeof(struct ssdfs_raw_dentry);
+			search->result.items_in_buffer = 1;
+			break;
+
+		case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!search->result.buf);
+			BUG_ON(search->result.buf_size !=
+					sizeof(struct ssdfs_raw_dentry));
+			BUG_ON(search->result.items_in_buffer != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		default:
+			SSDFS_ERR("unexpected buffer state %#x\n",
+				  search->result.buf_state);
+			return -ERANGE;
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.count != 1);
+		BUG_ON(!search->result.buf);
+		BUG_ON(search->result.buf_state !=
+				SSDFS_BTREE_SEARCH_INLINE_BUFFER);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_dentries_btree_node_insert_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert item: "
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
+ * ssdfs_dentries_btree_node_insert_range() - insert range of items
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
+int ssdfs_dentries_btree_node_insert_range(struct ssdfs_btree_node *node,
+					   struct ssdfs_btree_search *search)
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
+	BUG_ON(search->result.count < 1);
+	BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_dentries_btree_node_insert_range(node, search);
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
+ * ssdfs_change_item_only() - change dentry in the node
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @search: pointer on search request object
+ *
+ * This method tries to change an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_change_item_only(struct ssdfs_btree_node *node,
+			   struct ssdfs_btree_node_items_area *area,
+			   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dentries_btree_node_header *hdr;
+	struct ssdfs_dir_entry dentry;
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+	u16 range_len;
+	u16 old_name_len, name_len;
+	bool name_was_inline, name_become_inline;
+	u16 item_index;
+	u64 start_hash, end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
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
+	range_len = search->request.count;
+
+	if (range_len == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("empty range\n");
+		return err;
+	}
+
+	item_index = search->result.start_index;
+	if ((item_index + range_len) > area->items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, range_len %u, items_count %u\n",
+			  item_index, range_len,
+			  area->items_count);
+		return err;
+	}
+
+	err = ssdfs_dentries_btree_node_get_dentry(node, area, item_index,
+						   &dentry);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get dentry: err %d\n", err);
+		return err;
+	}
+
+	old_name_len = le16_to_cpu(dentry.name_len);
+
+	err = ssdfs_generic_insert_range(node, area,
+					 item_size, search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to insert range: err %d\n",
+			  err);
+		return err;
+	}
+
+	down_write(&node->header_lock);
+
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+
+	if (item_index == 0) {
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+							   &node->items_area,
+							   item_index,
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		start_hash = le64_to_cpu(dentry.hash_code);
+	}
+
+	if ((item_index + range_len) == node->items_area.items_count) {
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+						    &node->items_area,
+						    item_index + range_len - 1,
+						    &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		end_hash = le64_to_cpu(dentry.hash_code);
+	} else if ((item_index + range_len) > node->items_area.items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid range_len: "
+			  "item_index %u, range_len %u, items_count %u\n",
+			  item_index, range_len,
+			  node->items_area.items_count);
+		goto finish_items_area_correction;
+	}
+
+	node->items_area.start_hash = start_hash;
+	node->items_area.end_hash = end_hash;
+
+	err = ssdfs_correct_lookup_table(node, &node->items_area,
+					 item_index, range_len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	err = ssdfs_dentries_btree_node_get_dentry(node,
+						&node->items_area,
+						item_index,
+						&dentry);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get dentry: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	name_len = le16_to_cpu(dentry.name_len);
+
+	name_was_inline = old_name_len <= SSDFS_DENTRY_INLINE_NAME_MAX_LEN;
+	name_become_inline = name_len <= SSDFS_DENTRY_INLINE_NAME_MAX_LEN;
+
+	hdr = &node->raw.dentries_header;
+
+	if (!name_was_inline && name_become_inline) {
+		/* increment number of inline names */
+		le16_add_cpu(&hdr->inline_names, 1);
+	} else if (name_was_inline && !name_become_inline) {
+		/* decrement number of inline names */
+		if (le16_to_cpu(hdr->inline_names) == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid number of inline names: %u\n",
+				  le16_to_cpu(hdr->inline_names));
+			goto finish_items_area_correction;
+		} else
+			le16_add_cpu(&hdr->inline_names, -1);
+	}
+
+finish_items_area_correction:
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_btree_node_change_item() - change item in the node
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
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_dentries_btree_node_change_item(struct ssdfs_btree_node *node,
+					  struct ssdfs_btree_search *search)
+{
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+	struct ssdfs_btree_node_items_area items_area;
+	u16 item_index;
+	int direction;
+	u16 range_len;
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
+	if (is_btree_search_contains_new_item(search)) {
+		switch (search->result.buf_state) {
+		case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+			search->result.buf = &search->raw.dentry;
+			search->result.buf_size =
+					sizeof(struct ssdfs_raw_dentry);
+			search->result.items_in_buffer = 1;
+			break;
+
+		case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!search->result.buf);
+			BUG_ON(search->result.buf_size !=
+					sizeof(struct ssdfs_raw_dentry));
+			BUG_ON(search->result.items_in_buffer != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+
+		default:
+			SSDFS_ERR("unexpected buffer state %#x\n",
+				  search->result.buf_state);
+			return -ERANGE;
+		}
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.count != 1);
+		BUG_ON(!search->result.buf);
+		BUG_ON(search->result.buf_state !=
+				SSDFS_BTREE_SEARCH_INLINE_BUFFER);
+		BUG_ON(search->result.items_in_buffer != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
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
+	if (items_area.min_item_size != item_size ||
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
+	down_write(&node->full_lock);
+
+	direction = is_requested_position_correct(node, &items_area,
+						  search);
+	switch (direction) {
+	case SSDFS_CORRECT_POSITION:
+		/* do nothing */
+		break;
+
+	case SSDFS_SEARCH_LEFT_DIRECTION:
+		err = ssdfs_find_correct_position_from_left(node, &items_area,
+							    search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the correct position: "
+				  "err %d\n",
+				  err);
+			goto finish_define_changing_items;
+		}
+		break;
+
+	case SSDFS_SEARCH_RIGHT_DIRECTION:
+		err = ssdfs_find_correct_position_from_right(node, &items_area,
+							     search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the correct position: "
+				  "err %d\n",
+				  err);
+			goto finish_define_changing_items;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("fail to check requested position\n");
+		goto finish_define_changing_items;
+	}
+
+	range_len = search->request.count;
+
+	if (range_len == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("empty range\n");
+		goto finish_define_changing_items;
+	}
+
+	item_index = search->result.start_index;
+	if ((item_index + range_len) > items_area.items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, range_len %u, items_count %u\n",
+			  item_index, range_len,
+			  items_area.items_count);
+		goto finish_define_changing_items;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		/* range_len doesn't need to be changed */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid request type: %#x\n",
+			  search->request.type);
+		goto finish_define_changing_items;
+	}
+
+	err = ssdfs_lock_items_range(node, item_index, range_len);
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
+finish_define_changing_items:
+	downgrade_write(&node->full_lock);
+
+	if (unlikely(err))
+		goto finish_change_item;
+
+	err = ssdfs_change_item_only(node, &items_area, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change item: err %d\n",
+			  err);
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
+					  item_index, range_len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, range_len, err);
+		goto unlock_items_range;
+	}
+
+unlock_items_range:
+	ssdfs_unlock_items_range(node, item_index, range_len);
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
+ * __ssdfs_invalidate_items_area() - invalidate the items area
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @start_index: starting index of the item
+ * @range_len: number of items in the range
+ * @search: pointer on search request object
+ *
+ * The method tries to invalidate the items area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_invalidate_items_area(struct ssdfs_btree_node *node,
+				  struct ssdfs_btree_node_items_area *area,
+				  u16 start_index, u16 range_len,
+				  struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *parent = NULL;
+	bool is_hybrid = false;
+	bool has_index_area = false;
+	bool index_area_empty = false;
+	bool items_area_empty = false;
+	int parent_type = SSDFS_BTREE_LEAF_NODE;
+	spinlock_t *lock;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u, range_len %u\n",
+		  node->node_id, start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (((u32)start_index + range_len) > area->items_count) {
+		SSDFS_ERR("start_index %u, range_len %u, items_count %u\n",
+			  start_index, range_len,
+			  area->items_count);
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		is_hybrid = true;
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		is_hybrid = false;
+		break;
+
+	default:
+		SSDFS_WARN("invalid node type %#x\n",
+			   atomic_read(&node->type));
+		return -ERANGE;
+	}
+
+	down_write(&node->header_lock);
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		if (node->items_area.items_count == range_len)
+			items_area_empty = true;
+		else
+			items_area_empty = false;
+		break;
+
+	default:
+		items_area_empty = false;
+		break;
+	}
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		has_index_area = true;
+		if (node->index_area.index_count == 0)
+			index_area_empty = true;
+		else
+			index_area_empty = false;
+		break;
+
+	default:
+		has_index_area = false;
+		index_area_empty = false;
+		break;
+	}
+
+	up_write(&node->header_lock);
+
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		return err;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+		if (is_hybrid && has_index_area && !index_area_empty) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+		} else if (items_area_empty) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE;
+		} else {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		search->result.state =
+			SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+
+		parent = node;
+
+		do {
+			lock = &parent->descriptor_lock;
+			spin_lock(lock);
+			parent = parent->parent_node;
+			spin_unlock(lock);
+			lock = NULL;
+
+			if (!parent) {
+				SSDFS_ERR("node %u hasn't parent\n",
+					  node->node_id);
+				return -ERANGE;
+			}
+
+			parent_type = atomic_read(&parent->type);
+			switch (parent_type) {
+			case SSDFS_BTREE_ROOT_NODE:
+			case SSDFS_BTREE_INDEX_NODE:
+			case SSDFS_BTREE_HYBRID_NODE:
+				/* expected state */
+				break;
+
+			default:
+				SSDFS_ERR("invalid parent node's type %#x\n",
+					  parent_type);
+				return -ERANGE;
+			}
+		} while (parent_type != SSDFS_BTREE_ROOT_NODE);
+
+		err = ssdfs_invalidate_root_node_hierarchy(parent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to invalidate root node hierarchy: "
+				  "err %d\n", err);
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		atomic_set(&node->state,
+			   SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_invalidate_whole_items_area() - invalidate the whole items area
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @search: pointer on search request object
+ *
+ * The method tries to invalidate the items area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invalidate_whole_items_area(struct ssdfs_btree_node *node,
+				      struct ssdfs_btree_node_items_area *area,
+				      struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, area %p, search %p\n",
+		  node->node_id, area, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_invalidate_items_area(node, area,
+					     0, area->items_count,
+					     search);
+}
+
+/*
+ * ssdfs_invalidate_items_area_partially() - invalidate the items area
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @start_index: starting index
+ * @range_len: number of items in the range
+ * @search: pointer on search request object
+ *
+ * The method tries to invalidate the items area partially.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invalidate_items_area_partially(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    u16 start_index, u16 range_len,
+				    struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u, range_len %u\n",
+		  node->node_id, start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_invalidate_items_area(node, area,
+					     start_index, range_len,
+					     search);
+}
+
+/*
+ * __ssdfs_dentries_btree_node_delete_range() - delete range of items
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ *
+ * This method tries to delete a range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ * %-EAGAIN     - continue deletion in the next node.
+ */
+static
+int __ssdfs_dentries_btree_node_delete_range(struct ssdfs_btree_node *node,
+					     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_dentries_btree_info *dtree;
+	struct ssdfs_dentries_btree_node_header *hdr;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_dir_entry dentry;
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+	u16 index_count = 0;
+	int free_items;
+	u16 item_index;
+	int direction;
+	u16 range_len;
+	u16 shift_range_len = 0;
+	u16 locked_len = 0;
+	u32 deleted_space, free_space;
+	u64 start_hash = U64_MAX;
+	u64 end_hash = U64_MAX;
+	u64 old_hash;
+	u32 old_dentries_count = 0, dentries_count = 0;
+	u32 dentries_diff;
+	u16 deleted_inline_names = 0, inline_names = 0;
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
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid result state %#x\n",
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
+	case SSDFS_DENTRIES_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	dtree = container_of(tree, struct ssdfs_dentries_btree_info,
+				buffer.tree);
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     &node->items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     sizeof(struct ssdfs_btree_node_items_area));
+	old_hash = node->items_area.start_hash;
+	up_read(&node->header_lock);
+
+	if (items_area.items_capacity == 0 ||
+	    items_area.items_capacity < items_area.items_count) {
+		SSDFS_ERR("invalid items accounting: "
+			  "node_id %u, items_capacity %u, items_count %u\n",
+			  search->node.id,
+			  items_area.items_capacity,
+			  items_area.items_count);
+		return -ERANGE;
+	}
+
+	if (items_area.min_item_size != item_size ||
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
+	free_items = items_area.items_capacity - items_area.items_count;
+	if (unlikely(free_items < 0)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_WARN("invalid free_items %d\n",
+			   free_items);
+		return -EFAULT;
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
+	dentries_count = items_area.items_count;
+	item_index = search->result.start_index;
+
+	range_len = search->request.count;
+	if (range_len == 0) {
+		SSDFS_ERR("range_len == 0\n");
+		return -ERANGE;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+		if ((item_index + range_len) > items_area.items_count) {
+			SSDFS_ERR("invalid request: "
+				  "item_index %u, range_len %u, "
+				  "items_count %u\n",
+				  item_index, range_len,
+				  items_area.items_count);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		/* request can be distributed between several nodes */
+		break;
+
+	default:
+		atomic_set(&node->state,
+			   SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid request type %#x\n",
+			  search->request.type);
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	direction = is_requested_position_correct(node, &items_area,
+						  search);
+	switch (direction) {
+	case SSDFS_CORRECT_POSITION:
+		/* do nothing */
+		break;
+
+	case SSDFS_SEARCH_LEFT_DIRECTION:
+		err = ssdfs_find_correct_position_from_left(node, &items_area,
+							    search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the correct position: "
+				  "err %d\n",
+				  err);
+			goto finish_detect_affected_items;
+		}
+		break;
+
+	case SSDFS_SEARCH_RIGHT_DIRECTION:
+		err = ssdfs_find_correct_position_from_right(node, &items_area,
+							     search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the correct position: "
+				  "err %d\n",
+				  err);
+			goto finish_detect_affected_items;
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("fail to check requested position\n");
+		goto finish_detect_affected_items;
+	}
+
+	item_index = search->result.start_index;
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+		if ((item_index + range_len) > items_area.items_count) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid dentries_count: "
+				  "item_index %u, dentries_count %u, "
+				  "items_count %u\n",
+				  item_index, range_len,
+				  items_area.items_count);
+			goto finish_detect_affected_items;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+		/* request can be distributed between several nodes */
+		range_len = min_t(unsigned int, range_len,
+				  items_area.items_count - item_index);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, item_index %u, "
+			  "request.count %u, items_count %u\n",
+			  node->node_id, item_index,
+			  search->request.count,
+			  items_area.items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		BUG();
+	}
+
+	locked_len = items_area.items_count - item_index;
+
+	err = ssdfs_lock_items_range(node, item_index, locked_len);
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
+		goto finish_delete_range;
+
+	for (i = 0; i < range_len; i++) {
+		u16 name_len;
+
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+							   &items_area,
+							   (i + item_index),
+							   &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto unlock_items_range;
+		}
+
+		name_len = le16_to_cpu(dentry.name_len);
+		if (name_len <= SSDFS_DENTRY_INLINE_NAME_MAX_LEN)
+			deleted_inline_names++;
+	}
+
+	err = ssdfs_btree_node_clear_range(node, &node->items_area,
+					   item_size, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear items range: err %d\n",
+			  err);
+		goto unlock_items_range;
+	}
+
+	if (range_len == items_area.items_count) {
+		/* items area is empty */
+		err = ssdfs_invalidate_whole_items_area(node, &items_area,
+							search);
+	} else {
+		err = ssdfs_invalidate_items_area_partially(node, &items_area,
+							    item_index,
+							    range_len,
+							    search);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to invalidate items area: "
+			  "node_id %u, start_index %u, "
+			  "range_len %u, err %d\n",
+			  node->node_id, item_index,
+			  range_len, err);
+		goto unlock_items_range;
+	}
+
+	shift_range_len = locked_len - range_len;
+	if (shift_range_len != 0) {
+		err = ssdfs_shift_range_left(node, &items_area, item_size,
+					     item_index + range_len,
+					     shift_range_len, range_len);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to shift the range: "
+				  "start %u, count %u, err %d\n",
+				  item_index + range_len,
+				  shift_range_len,
+				  err);
+			goto unlock_items_range;
+		}
+
+		err = __ssdfs_btree_node_clear_range(node,
+						&items_area, item_size,
+						item_index + shift_range_len,
+						range_len);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clear range: "
+				  "start %u, count %u, err %d\n",
+				  item_index + range_len,
+				  shift_range_len,
+				  err);
+			goto unlock_items_range;
+		}
+	}
+
+	down_write(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("INITIAL STATE: node_id %u, "
+		  "items_count %u, free_space %u\n",
+		  node->node_id,
+		  node->items_area.items_count,
+		  node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->items_area.items_count < search->request.count)
+		node->items_area.items_count = 0;
+	else
+		node->items_area.items_count -= search->request.count;
+
+	deleted_space = (u32)search->request.count * item_size;
+	free_space = node->items_area.free_space;
+	if ((free_space + deleted_space) > node->items_area.area_size) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid request: "
+			  "deleted_space %u, free_space %u, area_size %u\n",
+			  deleted_space,
+			  node->items_area.free_space,
+			  node->items_area.area_size);
+		goto finish_items_area_correction;
+	}
+	node->items_area.free_space += deleted_space;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("NEW STATE: node_id %u, "
+		  "items_count %u, free_space %u\n",
+		  node->node_id,
+		  node->items_area.items_count,
+		  node->items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->items_area.items_count == 0) {
+		start_hash = U64_MAX;
+		end_hash = U64_MAX;
+	} else {
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+						    &node->items_area,
+						    0, &dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		start_hash = le64_to_cpu(dentry.hash_code);
+
+		err = ssdfs_dentries_btree_node_get_dentry(node,
+					&node->items_area,
+					node->items_area.items_count - 1,
+					&dentry);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get dentry: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		end_hash = le64_to_cpu(dentry.hash_code);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BEFORE: node_id %u, items_area.start_hash %llx, "
+		  "items_area.end_hash %llx\n",
+		  node->node_id,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	node->items_area.start_hash = start_hash;
+	node->items_area.end_hash = end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("AFTER: node_id %u, items_area.start_hash %llx, "
+		  "items_area.end_hash %llx\n",
+		  node->node_id,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (node->items_area.items_count == 0)
+		ssdfs_initialize_lookup_table(node);
+	else {
+		err = ssdfs_clean_lookup_table(node,
+						&node->items_area,
+						node->items_area.items_count);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clean the rest of lookup table: "
+				  "start_index %u, err %d\n",
+				  node->items_area.items_count, err);
+			goto finish_items_area_correction;
+		}
+
+		if (shift_range_len != 0) {
+			int start_index =
+				node->items_area.items_count - shift_range_len;
+
+			if (start_index < 0) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid start_index %d\n",
+					  start_index);
+				goto finish_items_area_correction;
+			}
+
+			err = ssdfs_correct_lookup_table(node,
+						&node->items_area,
+						start_index,
+						shift_range_len);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to correct lookup table: "
+					  "err %d\n", err);
+				goto finish_items_area_correction;
+			}
+		}
+	}
+
+	hdr = &node->raw.dentries_header;
+
+	hdr->free_space = cpu_to_le16(node->items_area.free_space);
+	old_dentries_count = le16_to_cpu(hdr->dentries_count);
+
+	if (node->items_area.items_count == 0) {
+		hdr->dentries_count = cpu_to_le16(0);
+		hdr->inline_names = cpu_to_le16(0);
+	} else {
+		if (old_dentries_count < search->request.count) {
+			hdr->dentries_count = cpu_to_le16(0);
+			hdr->inline_names = cpu_to_le16(0);
+		} else {
+			dentries_count = le16_to_cpu(hdr->dentries_count);
+			dentries_count -= search->request.count;
+			hdr->dentries_count = cpu_to_le16(dentries_count);
+
+			inline_names = le16_to_cpu(hdr->inline_names);
+			if (deleted_inline_names > inline_names) {
+				err = -ERANGE;
+				SSDFS_ERR("invalid inline names: "
+					  "deleted_inline_names %u, "
+					  "inline_names %u\n",
+					  deleted_inline_names,
+					  inline_names);
+				goto finish_items_area_correction;
+			}
+			inline_names -= deleted_inline_names;
+			hdr->inline_names = cpu_to_le16(inline_names);
+		}
+	}
+
+	dentries_count = le16_to_cpu(hdr->dentries_count);
+	dentries_diff = old_dentries_count - dentries_count;
+	atomic64_sub(dentries_diff, &dtree->dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&dtree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_memcpy(&items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     &node->items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     sizeof(struct ssdfs_btree_node_items_area));
+
+	err = ssdfs_set_node_header_dirty(node, items_area.items_capacity);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set header dirty: err %d\n",
+			  err);
+		goto finish_items_area_correction;
+	}
+
+	if (dentries_count != 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("set items range as dirty: "
+			  "node_id %u, start %u, count %u\n",
+			  node->node_id, item_index,
+			  old_dentries_count - item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_set_dirty_items_range(node,
+					items_area.items_capacity,
+					item_index,
+					old_dentries_count - item_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set items range as dirty: "
+				  "start %u, count %u, err %d\n",
+				  item_index,
+				  old_dentries_count - item_index,
+				  err);
+			goto finish_items_area_correction;
+		}
+	}
+
+finish_items_area_correction:
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+
+unlock_items_range:
+	ssdfs_unlock_items_range(node, item_index, locked_len);
+
+finish_delete_range:
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		return err;
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (dentries_count == 0) {
+			int state;
+
+			down_read(&node->header_lock);
+			state = atomic_read(&node->index_area.state);
+			index_count = node->index_area.index_count;
+			end_hash = node->index_area.end_hash;
+			up_read(&node->header_lock);
+
+			if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST) {
+				SSDFS_ERR("invalid area state %#x\n",
+					  state);
+				return -ERANGE;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index_count %u, end_hash %llx, "
+				  "old_hash %llx\n",
+				  index_count, end_hash, old_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (index_count <= 1 || end_hash == old_hash) {
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
+			}
+		} else if (old_hash != start_hash) {
+			struct ssdfs_btree_index_key old_key, new_key;
+
+			spin_lock(&node->descriptor_lock);
+			ssdfs_memcpy(&old_key,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     &node->node_index,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     sizeof(struct ssdfs_btree_index_key));
+			ssdfs_memcpy(&new_key,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     &node->node_index,
+				     0, sizeof(struct ssdfs_btree_index_key),
+				     sizeof(struct ssdfs_btree_index_key));
+			spin_unlock(&node->descriptor_lock);
+
+			old_key.index.hash = cpu_to_le64(old_hash);
+			new_key.index.hash = cpu_to_le64(start_hash);
+
+			err = ssdfs_btree_node_change_index(node,
+							&old_key, &new_key);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change index: err %d\n",
+					  err);
+				return err;
+			}
+		}
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_type %#x, dentries_count %u, index_count %u\n",
+		  atomic_read(&node->type),
+		  dentries_count, index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentries_count == 0 && index_count == 0)
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE;
+	else
+		search->result.state = SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+
+	if (search->request.type == SSDFS_BTREE_SEARCH_DELETE_RANGE) {
+		if (search->request.count > range_len) {
+			search->request.start.hash = items_area.end_hash;
+			search->request.count -= range_len;
+			return -EAGAIN;
+		}
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_btree_node_delete_item() - delete an item from node
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
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_dentries_btree_node_delete_item(struct ssdfs_btree_node *node,
+					  struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p, "
+		  "search->result.count %d\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child,
+		  search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_dentries_btree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete dentry: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_btree_node_delete_range() - delete range of items from node
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
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_dentries_btree_node_delete_range(struct ssdfs_btree_node *node,
+					   struct ssdfs_btree_search *search)
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
+	err = __ssdfs_dentries_btree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete dentries range: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_btree_node_extract_range() - extract range of items from node
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
+int ssdfs_dentries_btree_node_extract_range(struct ssdfs_btree_node *node,
+					    u16 start_index, u16 count,
+					    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dir_entry *dentry;
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
+						sizeof(struct ssdfs_dir_entry),
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
+	dentry = (struct ssdfs_dir_entry *)search->result.buf;
+	search->request.start.hash = le64_to_cpu(dentry->hash_code);
+	dentry += search->result.count - 1;
+	search->request.end.hash = le64_to_cpu(dentry->hash_code);
+	search->request.count = count;
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_btree_resize_items_area() - resize items area of the node
+ * @node: node object
+ * @new_size: new size of the items area
+ *
+ * This method tries to resize the items area of the node.
+ *
+ * TODO: It makes sense to allocate the bitmap with taking into
+ *       account that we will resize the node. So, it needs
+ *       to allocate the index area in bitmap is equal to
+ *       the whole node and items area is equal to the whole node.
+ *       This technique provides opportunity not to resize or
+ *       to shift the content of the bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_dentries_btree_resize_items_area(struct ssdfs_btree_node *node,
+					   u32 new_size)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_dentries_btree_node_header *dentries_header;
+	size_t item_size = sizeof(struct ssdfs_dir_entry);
+	size_t index_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, new_size %u\n",
+		  node->node_id, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+	index_size = le16_to_cpu(fsi->vh->dentries_btree.desc.index_size);
+
+	err = __ssdfs_btree_node_resize_items_area(node,
+						   item_size,
+						   index_size,
+						   new_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to resize items area: "
+			  "node_id %u, new_size %u, err %d\n",
+			  node->node_id, new_size, err);
+		return err;
+	}
+
+	dentries_header = &node->raw.dentries_header;
+	dentries_header->free_space =
+		cpu_to_le16((u16)node->items_area.free_space);
+
+	return 0;
+}
+
+void ssdfs_debug_dentries_btree_object(struct ssdfs_dentries_btree_info *tree)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+
+	BUG_ON(!tree);
+
+	SSDFS_DBG("DENTRIES TREE: type %#x, state %#x, "
+		  "dentries_count %llu, is_locked %d, "
+		  "generic_tree %p, inline_dentries %p, "
+		  "root %p, owner %p, fsi %p\n",
+		  atomic_read(&tree->type),
+		  atomic_read(&tree->state),
+		  (u64)atomic64_read(&tree->dentries_count),
+		  rwsem_is_locked(&tree->lock),
+		  tree->generic_tree,
+		  tree->inline_dentries,
+		  tree->root,
+		  tree->owner,
+		  tree->fsi);
+
+	if (tree->generic_tree) {
+		/* debug dump of generic tree */
+		ssdfs_debug_btree_object(tree->generic_tree);
+	}
+
+	if (tree->inline_dentries) {
+		for (i = 0; i < SSDFS_INLINE_DENTRIES_COUNT; i++) {
+			struct ssdfs_dir_entry *dentry;
+
+			dentry = &tree->inline_dentries[i];
+
+			SSDFS_DBG("INLINE DENTRY: index %d, ino %llu, "
+				  "hash_code %llx, name_len %u, "
+				  "dentry_type %#x, file_type %#x, "
+				  "flags %#x\n",
+				  i,
+				  le64_to_cpu(dentry->ino),
+				  le64_to_cpu(dentry->hash_code),
+				  dentry->name_len,
+				  dentry->dentry_type,
+				  dentry->file_type,
+				  dentry->flags);
+
+			SSDFS_DBG("RAW STRING DUMP: index %d\n",
+				  i);
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					    dentry->inline_string,
+					    SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+			SSDFS_DBG("\n");
+		}
+	}
+
+	if (tree->root) {
+		SSDFS_DBG("ROOT NODE HEADER: height %u, items_count %u, "
+			  "flags %#x, type %#x, upper_node_id %u, "
+			  "node_ids (left %u, right %u)\n",
+			  tree->root->header.height,
+			  tree->root->header.items_count,
+			  tree->root->header.flags,
+			  tree->root->header.type,
+			  le32_to_cpu(tree->root->header.upper_node_id),
+			  le32_to_cpu(tree->root->header.node_ids[0]),
+			  le32_to_cpu(tree->root->header.node_ids[1]));
+
+		for (i = 0; i < SSDFS_BTREE_ROOT_NODE_INDEX_COUNT; i++) {
+			struct ssdfs_btree_index *index;
+
+			index = &tree->root->indexes[i];
+
+			SSDFS_DBG("NODE_INDEX: index %d, hash %llx, "
+				  "seg_id %llu, logical_blk %u, len %u\n",
+				  i,
+				  le64_to_cpu(index->hash),
+				  le64_to_cpu(index->extent.seg_id),
+				  le32_to_cpu(index->extent.logical_blk),
+				  le32_to_cpu(index->extent.len));
+		}
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+const struct ssdfs_btree_descriptor_operations ssdfs_dentries_btree_desc_ops = {
+	.init		= ssdfs_dentries_btree_desc_init,
+	.flush		= ssdfs_dentries_btree_desc_flush,
+};
+
+const struct ssdfs_btree_operations ssdfs_dentries_btree_ops = {
+	.create_root_node	= ssdfs_dentries_btree_create_root_node,
+	.create_node		= ssdfs_dentries_btree_create_node,
+	.init_node		= ssdfs_dentries_btree_init_node,
+	.destroy_node		= ssdfs_dentries_btree_destroy_node,
+	.add_node		= ssdfs_dentries_btree_add_node,
+	.delete_node		= ssdfs_dentries_btree_delete_node,
+	.pre_flush_root_node	= ssdfs_dentries_btree_pre_flush_root_node,
+	.flush_root_node	= ssdfs_dentries_btree_flush_root_node,
+	.pre_flush_node		= ssdfs_dentries_btree_pre_flush_node,
+	.flush_node		= ssdfs_dentries_btree_flush_node,
+};
+
+const struct ssdfs_btree_node_operations ssdfs_dentries_btree_node_ops = {
+	.find_item		= ssdfs_dentries_btree_node_find_item,
+	.find_range		= ssdfs_dentries_btree_node_find_range,
+	.extract_range		= ssdfs_dentries_btree_node_extract_range,
+	.allocate_item		= ssdfs_dentries_btree_node_allocate_item,
+	.allocate_range		= ssdfs_dentries_btree_node_allocate_range,
+	.insert_item		= ssdfs_dentries_btree_node_insert_item,
+	.insert_range		= ssdfs_dentries_btree_node_insert_range,
+	.change_item		= ssdfs_dentries_btree_node_change_item,
+	.delete_item		= ssdfs_dentries_btree_node_delete_item,
+	.delete_range		= ssdfs_dentries_btree_node_delete_range,
+	.resize_items_area	= ssdfs_dentries_btree_resize_items_area,
+};
-- 
2.34.1

