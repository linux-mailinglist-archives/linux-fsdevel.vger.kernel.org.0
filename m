Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F76A266E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBYBUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBYBTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:39 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA636D33A
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:02 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk32so764695oib.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+IdmaVTVSz8oK7ae/4XwLlJsbsUvDZKaVOtigEZIsg=;
        b=uNaKafiMIvxk3tPeHYPIEi9vlNu1UKnBEqb5AKPYJjZdXL4vFQEqQ7mWzLhn7plUwS
         CjOXfn5l8zLeFzffCC+u8aiI6o1pzKNGV4ug/kt+BrEMmgfoGgtrBs9EmgUSjBebi7Vo
         RPP7hD0sga4K2w8n6OtUxQdQKJaOQyIaPtXuR0wbsxa82XA5VTmotZx8oA+wLN0XCFaB
         Vrz8ZmkMUxCJKgJbeVFtR5g0z+pvVgyg78p6qGVFGb96KwiWbZ8IVhTZFeDblJ/d6Oez
         /zlGEB798nwoHeCVNlXK+/TaO7ndhdrJGoR6zG1Dy0K/h6+TBCFdfAPE6BcT+z4u9aGV
         Lgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+IdmaVTVSz8oK7ae/4XwLlJsbsUvDZKaVOtigEZIsg=;
        b=uI3mkJ0Bzyn6KcTA89buytj3LFE66bzIMfitJhFzfaXYZwu33wOJSY6oiFuYH9+OF0
         YyC1zXd7JYz66aRwXSiefu0/orafCL5tzD0GPkOhuvrldTL2xT0UUDAUnGJRqTZ0ameT
         XTJyc/DqGqjePgaSrQmn4RXl1lH5xhhtK46PGza6MqSz9rtZL3KAGm3In5x+VqoSDxAX
         /xlWV0nz/4sIOu8A20cAsE3cY3cCrHqy6UHdznR7SSq08R8P6PZ1bypLWvRcaMg1rBqf
         qR5rt80b4F2m/yXQof77Css96LsphgQXbxcp+TzXtDmwdXWW0UyHm4/S1MePybfBZtDS
         WheQ==
X-Gm-Message-State: AO0yUKX1j2Oo3CMUpkU563yWO8X3cvdW4ka5L4RK0UDpfEK2qa4NN09D
        K/k2eOSXuUzq90jFwLkVHJPvsP3LJ7rwNDjc
X-Google-Smtp-Source: AK7set/mfYBMn+4dybcFuan38LWO10m7Hueg/IpxXTv/OvKRUy6gOcQbpiv3OSCR0vvb7YEU3Cz89Q==
X-Received: by 2002:a05:6808:23c2:b0:383:da56:831 with SMTP id bq2-20020a05680823c200b00383da560831mr773243oib.25.1677287880957;
        Fri, 24 Feb 2023 17:18:00 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:18:00 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 69/76] ssdfs: add/change/delete extent in extents b-tree node
Date:   Fri, 24 Feb 2023 17:09:20 -0800
Message-Id: <20230225010927.813929-70-slava@dubeyko.com>
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

Implement logic of adding, changing, and deleting extents
in extents b-tree.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/extents_tree.c | 3060 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 3060 insertions(+)

diff --git a/fs/ssdfs/extents_tree.c b/fs/ssdfs/extents_tree.c
index 4b183308eff5..77fb8cc60136 100644
--- a/fs/ssdfs/extents_tree.c
+++ b/fs/ssdfs/extents_tree.c
@@ -9998,3 +9998,3063 @@ int ssdfs_calculate_range_blocks_in_node(struct ssdfs_btree_node *node,
 
 	return 0;
 }
+
+/*
+ * __ssdfs_extents_btree_node_insert_range() - insert range of forks into node
+ * @node: pointer on node object
+ * @search: search object
+ *
+ * This method tries to insert the range of forks into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int __ssdfs_extents_btree_node_insert_range(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_extents_btree_node_header *hdr;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_raw_fork fork;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+	u16 item_index;
+	int free_items;
+	int direction;
+	u16 range_len;
+	u16 forks_count = 0;
+	u32 used_space;
+	u64 start_hash = U64_MAX;
+	u64 end_hash = U64_MAX;
+	u64 old_hash;
+	u64 blks_count;
+	u32 valid_extents;
+	u32 max_extent_blks;
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
+	case SSDFS_EXTENTS_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	etree = container_of(tree, struct ssdfs_extents_btree_info,
+			     buffer.tree);
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
+	if ((item_index + search->request.count) >= items_area.items_capacity) {
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
+	forks_count = range_len + search->request.count;
+
+	item_index = search->result.start_index;
+	if ((item_index + forks_count) > items_area.items_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid forks_count: "
+			  "item_index %u, forks_count %u, items_capacity %u\n",
+			  item_index, forks_count,
+			  items_area.items_capacity);
+		goto finish_detect_affected_items;
+	}
+
+	err = ssdfs_lock_items_range(node, item_index, forks_count);
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
+		goto finish_insert_range;
+
+	err = ssdfs_shift_range_right(node, &items_area, item_size,
+				      item_index, range_len,
+				      search->request.count);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to shift forks range: "
+			  "start %u, count %u, err %d\n",
+			  item_index, search->request.count,
+			  err);
+		goto unlock_items_range;
+	}
+
+	err = ssdfs_generic_insert_range(node, &items_area,
+					 item_size, search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to insert range: err %d\n",
+			  err);
+		goto unlock_items_range;
+	}
+
+	down_write(&node->header_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_area.items_count %u, search->request.count %u\n",
+		  node->items_area.items_count,
+		  search->request.count);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	err = ssdfs_extents_btree_node_get_fork(node, &node->items_area,
+						0, &fork);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get fork: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+	start_hash = le64_to_cpu(fork.start_offset);
+
+	err = ssdfs_extents_btree_node_get_fork(node,
+					&node->items_area,
+					node->items_area.items_count - 1,
+					&fork);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get fork: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	end_hash = le64_to_cpu(fork.start_offset);
+
+	blks_count = le64_to_cpu(fork.blks_count);
+	if (blks_count == 0 || blks_count >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid blks_count %llu\n",
+			  blks_count);
+		goto finish_items_area_correction;
+	}
+
+	end_hash += blks_count - 1;
+
+	if (start_hash >= U64_MAX || end_hash >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		goto finish_items_area_correction;
+	}
+
+	node->items_area.start_hash = start_hash;
+	node->items_area.end_hash = end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node->items_area: "
+		  "start_hash %llx, end_hash %llx\n",
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+	SSDFS_DBG("items_area.items_count %u, items_area.items_capacity %u\n",
+		  node->items_area.items_count,
+		  node->items_area.items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_correct_lookup_table(node, &node->items_area,
+					 item_index, forks_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	hdr = &node->raw.extents_header;
+
+	le32_add_cpu(&hdr->forks_count, search->request.count);
+	le32_add_cpu(&hdr->allocated_extents,
+		     search->request.count * SSDFS_INLINE_EXTENTS_COUNT);
+
+	err = ssdfs_calculate_range_blocks(search, &valid_extents,
+					   &blks_count, &max_extent_blks);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate range blocks: err %d\n",
+			  err);
+		goto finish_items_area_correction;
+	}
+
+	le32_add_cpu(&hdr->valid_extents, valid_extents);
+	le64_add_cpu(&hdr->blks_count, blks_count);
+
+	if (le32_to_cpu(hdr->max_extent_blks) < max_extent_blks)
+		hdr->max_extent_blks = cpu_to_le32(max_extent_blks);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, forks_count %u, allocated_extents %u, "
+		  "valid_extents %u, blks_count %llu\n",
+		  node->node_id,
+		  le32_to_cpu(hdr->forks_count),
+		  le32_to_cpu(hdr->allocated_extents),
+		  le32_to_cpu(hdr->valid_extents),
+		  le64_to_cpu(hdr->blks_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	atomic64_add(search->request.count, &etree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n",
+		  atomic64_read(&etree->forks_count));
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
+					  item_index, forks_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, forks_count, err);
+		goto unlock_items_range;
+	}
+
+unlock_items_range:
+	ssdfs_unlock_items_range(node, item_index, forks_count);
+
+finish_insert_range:
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		return err;
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
+	return 0;
+}
+
+/*
+ * ssdfs_extents_btree_node_insert_item() - insert item in the node
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
+int ssdfs_extents_btree_node_insert_item(struct ssdfs_btree_node *node,
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
+	if (search->result.err == -ENODATA || search->result.err == -EAGAIN) {
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
+	SSDFS_DBG("search->result: (state %#x, err %d, "
+		  "start_index %u, count %u, buf_state %#x, buf %p, "
+		  "buf_size %zu, items_in_buffer %u)\n",
+		  search->result.state,
+		  search->result.err,
+		  search->result.start_index,
+		  search->result.count,
+		  search->result.buf_state,
+		  search->result.buf,
+		  search->result.buf_size,
+		  search->result.items_in_buffer);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_btree_search_contains_new_item(search)) {
+		switch (search->result.buf_state) {
+		case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+			search->result.buf = &search->raw.fork;
+			search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+			search->result.items_in_buffer = 1;
+			break;
+
+		case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!search->result.buf);
+			BUG_ON(search->result.buf_size !=
+					sizeof(struct ssdfs_raw_fork));
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
+	err = __ssdfs_extents_btree_node_insert_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert range: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_btree_node_insert_range() - insert range of items
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
+int ssdfs_extents_btree_node_insert_range(struct ssdfs_btree_node *node,
+					  struct ssdfs_btree_search *search)
+{
+	int state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("node_id %u, type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %#x, node_id %u, height %u, "
+		  "parent %p, child %p\n",
+		  node->node_id,
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
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
+		 * Node doesn't contain an item.
+		 */
+	} else if (search->result.err) {
+		SSDFS_WARN("invalid serach result: err %d\n",
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
+	err = __ssdfs_extents_btree_node_insert_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert range: "
+			  "node_id %u, err %d\n",
+			  node->node_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_change_item_only() - change fork in the node
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
+	struct ssdfs_raw_fork fork;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+	struct ssdfs_extents_btree_node_header *hdr;
+	u16 item_index;
+	u16 range_len;
+	u64 start_hash, end_hash;
+	u64 old_blks_count, blks_count, diff_blks_count;
+	u32 old_valid_extents, valid_extents, diff_valid_extents;
+	u32 old_max_extent_blks, max_extent_blks;
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
+	range_len = search->result.count;
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
+	err = ssdfs_calculate_range_blocks_in_node(node, area,
+						   item_index, range_len,
+						   &old_valid_extents,
+						   &old_blks_count,
+						   &old_max_extent_blks);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate range's blocks: "
+			  "node_id %u, item_index %u, range_len %u\n",
+			  node->node_id, item_index, range_len);
+		return err;
+	}
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
+		err = ssdfs_extents_btree_node_get_fork(node,
+							&node->items_area,
+							item_index, &fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get fork: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		start_hash = le64_to_cpu(fork.start_offset);
+	}
+
+	if ((item_index + range_len) == node->items_area.items_count) {
+		err = ssdfs_extents_btree_node_get_fork(node,
+						&node->items_area,
+						item_index + range_len - 1,
+						&fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get fork: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+
+		end_hash = le64_to_cpu(fork.start_offset);
+
+		blks_count = le64_to_cpu(fork.blks_count);
+		if (blks_count == 0 || blks_count >= U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid blks_count %llu\n",
+				  blks_count);
+			goto finish_items_area_correction;
+		}
+
+		end_hash += blks_count - 1;
+
+		if (start_hash >= U64_MAX || end_hash >= U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("start_hash %llx, end_hash %llx\n",
+				  start_hash, end_hash);
+			goto finish_items_area_correction;
+		}
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
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_area: start_hash %llx, end_hash %llx\n",
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_correct_lookup_table(node, &node->items_area,
+					 item_index, range_len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	err = ssdfs_calculate_range_blocks(search, &valid_extents,
+					   &blks_count, &max_extent_blks);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate range blocks: err %d\n",
+			  err);
+		goto finish_items_area_correction;
+	}
+
+	hdr = &node->raw.extents_header;
+
+	if (old_valid_extents < valid_extents) {
+		diff_valid_extents = valid_extents - old_valid_extents;
+		valid_extents = le32_to_cpu(hdr->valid_extents);
+
+		if (valid_extents >= (U32_MAX - diff_valid_extents)) {
+			err = -ERANGE;
+			SSDFS_ERR("valid_extents %u, diff_valid_extents %u\n",
+				  valid_extents, diff_valid_extents);
+			goto finish_items_area_correction;
+		}
+
+		valid_extents += diff_valid_extents;
+		hdr->valid_extents = cpu_to_le32(valid_extents);
+	} else if (old_valid_extents > valid_extents) {
+		diff_valid_extents = old_valid_extents - valid_extents;
+		valid_extents = le32_to_cpu(hdr->valid_extents);
+
+		if (valid_extents < diff_valid_extents) {
+			err = -ERANGE;
+			SSDFS_ERR("valid_extents %u < diff_valid_extents %u\n",
+				  valid_extents, diff_valid_extents);
+			goto finish_items_area_correction;
+		}
+
+		valid_extents -= diff_valid_extents;
+		hdr->valid_extents = cpu_to_le32(valid_extents);
+	}
+
+	if (old_blks_count < blks_count) {
+		diff_blks_count = blks_count - old_blks_count;
+		blks_count = le64_to_cpu(hdr->blks_count);
+
+		if (blks_count >= (U64_MAX - diff_blks_count)) {
+			err = -ERANGE;
+			SSDFS_ERR("blks_count %llu, diff_blks_count %llu\n",
+				  blks_count, diff_blks_count);
+			goto finish_items_area_correction;
+		}
+
+		blks_count += diff_blks_count;
+		hdr->blks_count = cpu_to_le64(blks_count);
+	} else if (old_blks_count > blks_count) {
+		diff_blks_count = old_blks_count - blks_count;
+		blks_count = le32_to_cpu(hdr->blks_count);
+
+		if (blks_count < diff_blks_count) {
+			err = -ERANGE;
+			SSDFS_ERR("blks_count %llu < diff_blks_count %llu\n",
+				  blks_count, diff_blks_count);
+			goto finish_items_area_correction;
+		}
+
+		blks_count -= diff_blks_count;
+		hdr->blks_count = cpu_to_le64(blks_count);
+	}
+
+	if (le32_to_cpu(hdr->max_extent_blks) < max_extent_blks)
+		hdr->max_extent_blks = cpu_to_le32(max_extent_blks);
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
+ * ssdfs_invalidate_forks_range() - invalidate range of forks
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @start_index: starting index of the fork
+ * @range_len: number of forks in the range
+ *
+ * This method tries to add the range of forks into
+ * pre-invalid queue of the shared extents tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invalidate_forks_range(struct ssdfs_btree_node *node,
+				 struct ssdfs_btree_node_items_area *area,
+				 u16 start_index, u16 range_len)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_raw_fork fork;
+	u64 ino;
+	u16 cur_index;
+	u16 i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u, range_len %u\n",
+		  node->node_id, start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = node->tree->owner_ino;
+
+	if ((start_index + range_len) > area->items_count) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, range_len %u\n",
+			  start_index, range_len);
+		return -ERANGE;
+	}
+
+	for (i = 0; i < range_len; i++) {
+		cur_index = start_index + i;
+
+		err = ssdfs_extents_btree_node_get_fork(node, area,
+							cur_index,
+							&fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get fork: "
+				  "cur_index %u, err %d\n",
+				  cur_index, err);
+			return err;
+		}
+
+		err = ssdfs_shextree_add_pre_invalid_fork(shextree, ino, &fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to make the fork pre-invalid: "
+				  "cur_index %u, err %d\n",
+				  cur_index, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_define_first_invalid_index() - find the first index for hash
+ * @node: pointer on node object
+ * @hash: searching hash
+ * @start_index: found index [out]
+ *
+ * The method tries to find the index for the hash.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - unable to find an index.
+ */
+static
+int ssdfs_define_first_invalid_index(struct ssdfs_btree_node *node,
+				     u64 hash, u16 *start_index)
+{
+	bool node_locked_outside = false;
+	struct ssdfs_btree_node_index_area area;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !start_index);
+
+	SSDFS_DBG("node_id %u, hash %llx\n",
+		  node->node_id, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	}
+
+	node_locked_outside = rwsem_is_locked(&node->full_lock);
+
+	if (!node_locked_outside) {
+		/* lock node locally */
+		down_read(&node->full_lock);
+	}
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     &node->index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     sizeof(struct ssdfs_btree_node_index_area));
+	err = ssdfs_find_index_by_hash(node, &area, hash,
+					start_index);
+	up_read(&node->header_lock);
+
+	if (err == -EEXIST) {
+		/* hash == found hash */
+		err = 0;
+	} else if (err == -ENODATA) {
+		err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find an index: "
+			  "node_id %u, hash %llx\n",
+			  node->node_id, hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find an index: "
+			  "node_id %u, hash %llx, err %d\n",
+			  node->node_id, hash, err);
+	}
+
+	if (!node_locked_outside) {
+		/* unlock node locally */
+		up_read(&node->full_lock);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_invalidate_index_tail() - invalidate the tail of index sequence
+ * @node: pointer on node object
+ * @start_index: starting index
+ *
+ * The method tries to invalidate the tail of index sequence.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invalidate_index_tail(struct ssdfs_btree_node *node,
+				u16 start_index)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_btree *tree;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_btree_node_index_area index_area;
+	struct ssdfs_btree_index_key index;
+	int node_type;
+	int index_type = SSDFS_EXTENT_INFO_UNKNOWN_TYPE;
+	u64 ino;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, start_index %u\n",
+		  node->node_id, start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	ino = node->tree->owner_ino;
+
+	tree = node->tree;
+	switch (tree->type) {
+	case SSDFS_EXTENTS_BTREE:
+		index_type = SSDFS_EXTENT_INFO_INDEX_DESCRIPTOR;
+		break;
+
+	case SSDFS_DENTRIES_BTREE:
+		index_type = SSDFS_EXTENT_INFO_DENTRY_INDEX_DESCRIPTOR;
+		break;
+
+	default:
+		SSDFS_ERR("unsupported tree type %#x\n",
+			  tree->type);
+		return -ERANGE;
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+		SSDFS_ERR("index area is absent\n");
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+	ssdfs_memcpy(&items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     &node->items_area,
+		     0, sizeof(struct ssdfs_btree_node_items_area),
+		     sizeof(struct ssdfs_btree_node_items_area));
+	ssdfs_memcpy(&index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     &node->index_area,
+		     0, sizeof(struct ssdfs_btree_node_index_area),
+		     sizeof(struct ssdfs_btree_node_index_area));
+	up_read(&node->header_lock);
+
+	if (is_ssdfs_btree_node_items_area_exist(node)) {
+		err = ssdfs_invalidate_forks_range(node, &items_area,
+						   0, items_area.items_count);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to invalidate forks range: "
+				  "node_id %u, range (start %u, count %u), "
+				  "err %d\n",
+				  node->node_id, 0, items_area.items_count,
+				  err);
+			goto finish_invalidate_index_tail;
+		}
+	}
+
+	err = ssdfs_lock_whole_index_area(node);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to lock source's index area: err %d\n",
+			  err);
+		goto finish_invalidate_index_tail;
+	}
+
+	if (start_index >= index_area.index_count) {
+		err = -ERANGE;
+		SSDFS_ERR("start_index %u >= index_count %u\n",
+			  start_index, index_area.index_count);
+		goto finish_process_index_area;
+	}
+
+	node_type = atomic_read(&node->type);
+
+	for (i = start_index; i < index_area.index_count; i++) {
+		if (node_type == SSDFS_BTREE_ROOT_NODE) {
+			err = __ssdfs_btree_root_node_extract_index(node,
+								    (u16)i,
+								    &index);
+		} else {
+			err = ssdfs_btree_node_get_index(&node->content.pvec,
+							 index_area.offset,
+							 index_area.area_size,
+							 node->node_size,
+							 (u16)i, &index);
+		}
+
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to extract index: "
+				  "node_id %u, index %d, err %d\n",
+				  node->node_id, i, err);
+			goto finish_process_index_area;
+		}
+
+		err = ssdfs_shextree_add_pre_invalid_index(shextree,
+							   ino,
+							   index_type,
+							   &index);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to pre-invalid index: "
+				  "index_id %d, err %d\n",
+				  i, err);
+			goto finish_process_index_area;
+		}
+	}
+
+	down_write(&node->header_lock);
+
+	for (i = index_area.index_count - 1; i >= start_index; i--) {
+		if (node_type == SSDFS_BTREE_ROOT_NODE) {
+			err = ssdfs_btree_root_node_delete_index(node,
+								 (u16)i);
+		} else {
+			err = ssdfs_btree_common_node_delete_index(node,
+								   (u16)i);
+		}
+
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to delete index: "
+				  "node_id %u, index %d, err %d\n",
+				  node->node_id, i, err);
+			goto finish_index_deletion;
+		}
+	}
+
+finish_index_deletion:
+	up_write(&node->header_lock);
+
+finish_process_index_area:
+	ssdfs_unlock_whole_index_area(node);
+
+finish_invalidate_index_tail:
+	return err;
+}
+
+/*
+ * __ssdfs_invalidate_items_area() - invalidate the items area
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @start_index: starting index of the fork
+ * @range_len: number of forks in the range
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
+	struct ssdfs_btree_node *parent = NULL, *found = NULL;
+	struct ssdfs_extents_btree_node_header *hdr;
+	bool items_area_empty = false;
+	bool is_hybrid = false;
+	bool has_index_area = false;
+	bool index_area_empty = false;
+	int parent_type = SSDFS_BTREE_LEAF_NODE;
+	u64 hash;
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
+	if (range_len == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("nothing should be done: range_len %u\n",
+			  range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
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
+	if (!(search->request.flags & SSDFS_BTREE_SEARCH_NOT_INVALIDATE)) {
+		err = ssdfs_invalidate_forks_range(node, area,
+						   start_index, range_len);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to invalidate range of forks: "
+				  "node_id %u, start_index %u, "
+				  "range_len %u, err %d\n",
+				  node->node_id, start_index,
+				  range_len, err);
+			return err;
+		}
+	}
+
+	down_write(&node->header_lock);
+
+	hdr = &node->raw.extents_header;
+	if (node->items_area.items_count == range_len) {
+		items_area_empty = true;
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
+	if (!(search->request.flags & SSDFS_BTREE_SEARCH_NOT_INVALIDATE))
+		goto finish_invalidate_items_area;
+
+	if (!items_area_empty)
+		goto finish_invalidate_items_area;
+
+	switch (search->request.type) {
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
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		if (is_hybrid && has_index_area && !index_area_empty) {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+		} else {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE;
+		}
+
+		hash = search->request.start.hash;
+
+		switch (atomic_read(&node->index_area.state)) {
+		case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+			err = ssdfs_define_first_invalid_index(node, hash,
+								&start_index);
+			if (err == -EAGAIN) {
+				err = 0;
+				/* continue to search */
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to define first index: "
+					  "err %d\n", err);
+				return err;
+			} else if (start_index >= U16_MAX) {
+				SSDFS_ERR("invalid start index\n");
+				return -ERANGE;
+			} else {
+				found = node;
+				goto try_invalidate_tail;
+			}
+			break;
+
+		case SSDFS_BTREE_NODE_AREA_ABSENT:
+			/* need to check the parent */
+			break;
+
+		default:
+			SSDFS_ERR("invalid index area: "
+				  "node_id %u, state %#x\n",
+				  node->node_id,
+				  atomic_read(&node->index_area.state));
+			return -ERANGE;
+		}
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
+
+			switch (atomic_read(&parent->index_area.state)) {
+			case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+				err = ssdfs_define_first_invalid_index(parent,
+								hash,
+								&start_index);
+				if (err == -EAGAIN) {
+					err = 0;
+					/* continue to search */
+				} else if (unlikely(err)) {
+					SSDFS_ERR("fail to define first index: "
+						  "err %d\n", err);
+					return err;
+				} else if (start_index >= U16_MAX) {
+					SSDFS_ERR("invalid start index\n");
+					return -ERANGE;
+				} else {
+					found = parent;
+					goto try_invalidate_tail;
+				}
+				break;
+
+			default:
+				SSDFS_ERR("index area is absent: "
+					  "node_id %u, height %d\n",
+					  parent->node_id,
+					  atomic_read(&parent->height));
+				return -ERANGE;
+			}
+		} while (parent_type != SSDFS_BTREE_ROOT_NODE);
+
+		if (found == NULL) {
+			SSDFS_ERR("fail to find start index\n");
+			return -ERANGE;
+		}
+
+try_invalidate_tail:
+		err = ssdfs_invalidate_index_tail(found, start_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to invalidate the index tail: "
+				  "node_id %u, start_index %u, err %d\n",
+				  found->node_id, start_index, err);
+			return err;
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
+finish_invalidate_items_area:
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
+ * @start_index: starting index of the fork
+ * @range_len: number of forks in the range
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
+ * ssdfs_change_item_and_invalidate_tail() - change fork and invalidate tail
+ * @node: pointer on node object
+ * @area: pointer on items area's descriptor
+ * @search: pointer on search request object
+ *
+ * This method tries to change an item in the node and invalidate
+ * the tail forks sequence.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_change_item_and_invalidate_tail(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_items_area *area,
+				    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork fork;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+	struct ssdfs_extents_btree_node_header *hdr;
+	u16 item_index;
+	u16 range_len;
+	u64 start_hash, end_hash;
+	u64 old_blks_count, blks_count, diff_blks_count;
+	u32 old_valid_extents, valid_extents, diff_valid_extents;
+	u32 old_max_extent_blks, max_extent_blks;
+	u16 invalidate_index, invalidate_range;
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
+	range_len = search->result.count;
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
+	err = ssdfs_calculate_range_blocks_in_node(node, area,
+						   item_index, range_len,
+						   &old_valid_extents,
+						   &old_blks_count,
+						   &old_max_extent_blks);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate range's blocks: "
+			  "node_id %u, item_index %u, range_len %u\n",
+			  node->node_id, item_index, range_len);
+		return err;
+	}
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
+	invalidate_index = item_index + range_len;
+	invalidate_range = area->items_count - invalidate_index;
+
+	err = ssdfs_invalidate_items_area_partially(node, area,
+						    invalidate_index,
+						    invalidate_range,
+						    search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to invalidate items range: err %d\n",
+			  err);
+		return err;
+	}
+
+	down_write(&node->header_lock);
+
+	start_hash = node->items_area.start_hash;
+	end_hash = node->items_area.end_hash;
+
+	err = ssdfs_extents_btree_node_get_fork(node,
+						&node->items_area,
+						item_index,
+						&fork);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get fork: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	if (item_index == 0)
+		start_hash = le64_to_cpu(fork.start_offset);
+
+	end_hash = le64_to_cpu(fork.start_offset);
+
+	blks_count = le64_to_cpu(fork.blks_count);
+	if (blks_count == 0 || blks_count >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid blks_count %llu\n",
+			  blks_count);
+		goto finish_items_area_correction;
+	}
+
+	end_hash += blks_count - 1;
+
+	if (start_hash >= U64_MAX || end_hash >= U64_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("start_hash %llx, end_hash %llx\n",
+			  start_hash, end_hash);
+		goto finish_items_area_correction;
+	}
+
+	err = ssdfs_correct_lookup_table(node, &node->items_area,
+					 item_index, range_len);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	err = ssdfs_calculate_range_blocks(search, &valid_extents,
+					   &blks_count, &max_extent_blks);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate range blocks: err %d\n",
+			  err);
+		goto finish_items_area_correction;
+	}
+
+	hdr = &node->raw.extents_header;
+
+	if (old_valid_extents < valid_extents) {
+		diff_valid_extents = valid_extents - old_valid_extents;
+		valid_extents = le32_to_cpu(hdr->valid_extents);
+
+		if (valid_extents >= (U32_MAX - diff_valid_extents)) {
+			err = -ERANGE;
+			SSDFS_ERR("valid_extents %u, diff_valid_extents %u\n",
+				  valid_extents, diff_valid_extents);
+			goto finish_items_area_correction;
+		}
+
+		valid_extents += diff_valid_extents;
+		hdr->valid_extents = cpu_to_le32(valid_extents);
+	} else if (old_valid_extents > valid_extents) {
+		diff_valid_extents = old_valid_extents - valid_extents;
+		valid_extents = le32_to_cpu(hdr->valid_extents);
+
+		if (valid_extents < diff_valid_extents) {
+			err = -ERANGE;
+			SSDFS_ERR("valid_extents %u < diff_valid_extents %u\n",
+				  valid_extents, diff_valid_extents);
+			goto finish_items_area_correction;
+		}
+
+		valid_extents -= diff_valid_extents;
+		hdr->valid_extents = cpu_to_le32(valid_extents);
+	}
+
+	if (old_blks_count < blks_count) {
+		diff_blks_count = blks_count - old_blks_count;
+		blks_count = le64_to_cpu(hdr->blks_count);
+
+		if (blks_count >= (U64_MAX - diff_blks_count)) {
+			err = -ERANGE;
+			SSDFS_ERR("blks_count %llu, diff_blks_count %llu\n",
+				  blks_count, diff_blks_count);
+			goto finish_items_area_correction;
+		}
+
+		blks_count += diff_blks_count;
+		hdr->blks_count = cpu_to_le64(blks_count);
+	} else if (old_blks_count > blks_count) {
+		diff_blks_count = old_blks_count - blks_count;
+		blks_count = le32_to_cpu(hdr->blks_count);
+
+		if (blks_count < diff_blks_count) {
+			err = -ERANGE;
+			SSDFS_ERR("blks_count %llu < diff_blks_count %llu\n",
+				  blks_count, diff_blks_count);
+			goto finish_items_area_correction;
+		}
+
+		blks_count -= diff_blks_count;
+		hdr->blks_count = cpu_to_le64(blks_count);
+	}
+
+	if (le32_to_cpu(hdr->max_extent_blks) < max_extent_blks)
+		hdr->max_extent_blks = cpu_to_le32(max_extent_blks);
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
+ * ssdfs_extents_btree_node_change_item() - change item in the node
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
+int ssdfs_extents_btree_node_change_item(struct ssdfs_btree_node *node,
+					 struct ssdfs_btree_search *search)
+{
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
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
+			search->result.buf = &search->raw.fork;
+			search->result.buf_size = sizeof(struct ssdfs_raw_fork);
+			search->result.items_in_buffer = 1;
+			break;
+
+		case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(!search->result.buf);
+			BUG_ON(search->result.buf_size !=
+					sizeof(struct ssdfs_raw_fork));
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
+	range_len = search->result.count;
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
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		range_len = items_area.items_count - item_index;
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
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		err = ssdfs_change_item_only(node, &items_area, search);
+		break;
+
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		err = ssdfs_change_item_and_invalidate_tail(node, &items_area,
+							    search);
+		break;
+
+	default:
+		BUG();
+	}
+
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
+	return err;
+}
+
+/*
+ * __ssdfs_extents_btree_node_delete_range() - delete range of items
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
+int __ssdfs_extents_btree_node_delete_range(struct ssdfs_btree_node *node,
+					    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree *tree;
+	struct ssdfs_extents_btree_info *etree;
+	struct ssdfs_extents_btree_node_header *hdr;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_raw_fork fork;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
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
+	u32 old_forks_count = 0, forks_count = 0;
+	u32 forks_diff;
+	u32 allocated_extents;
+	u32 valid_extents;
+	u64 blks_count;
+	u32 max_extent_blks;
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
+	case SSDFS_EXTENTS_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	etree = container_of(tree, struct ssdfs_extents_btree_info,
+			     buffer.tree);
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
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_area: items_count %u, items_capacity %u, "
+		  "area_size %u, free_space %u\n",
+		  items_area.items_count,
+		  items_area.items_capacity,
+		  items_area.area_size,
+		  items_area.free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	forks_count = items_area.items_count;
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
+				  "item_index %d, count %u\n",
+				  item_index, range_len);
+			return -ERANGE;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
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
+			SSDFS_ERR("invalid forks_count: "
+				  "item_index %u, forks_count %u, "
+				  "items_count %u\n",
+				  item_index, range_len,
+				  items_area.items_count);
+			goto finish_detect_affected_items;
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
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
+		SSDFS_ERR("fail to lock items range\n");
+		return -ERANGE;
+	} else if (err == -ENODATA) {
+		up_write(&node->full_lock);
+		wake_up_all(&node->wait_queue);
+		SSDFS_ERR("fail to lock items range\n");
+		return -ERANGE;
+	} else if (unlikely(err))
+		BUG();
+
+finish_detect_affected_items:
+	downgrade_write(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: err %d\n",
+			  err);
+		goto finish_delete_range;
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
+		goto finish_delete_range;
+	}
+
+	switch (search->request.type) {
+	case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+	case SSDFS_BTREE_SEARCH_DELETE_RANGE:
+		/* continue to shift rest forks to left */
+		break;
+
+	case SSDFS_BTREE_SEARCH_DELETE_ALL:
+	case SSDFS_BTREE_SEARCH_INVALIDATE_TAIL:
+		err = ssdfs_set_node_header_dirty(node,
+						  items_area.items_capacity);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set header dirty: err %d\n",
+				  err);
+			goto finish_delete_range;
+		}
+		break;
+
+	default:
+		BUG();
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
+			goto finish_delete_range;
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
+			goto finish_delete_range;
+		}
+	}
+
+	down_write(&node->header_lock);
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
+		SSDFS_ERR("deleted_space %u, free_space %u, area_size %u\n",
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
+		err = ssdfs_extents_btree_node_get_fork(node,
+							&node->items_area,
+							0, &fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get fork: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		start_hash = le64_to_cpu(fork.start_offset);
+
+		err = ssdfs_extents_btree_node_get_fork(node,
+					&node->items_area,
+					node->items_area.items_count - 1,
+					&fork);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get fork: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+		end_hash = le64_to_cpu(fork.start_offset);
+
+		blks_count = le64_to_cpu(fork.blks_count);
+		if (blks_count == 0 || blks_count >= U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid blks_count %llu\n",
+				  blks_count);
+			goto finish_items_area_correction;
+		}
+
+		end_hash += blks_count - 1;
+	}
+
+	node->items_area.start_hash = start_hash;
+	node->items_area.end_hash = end_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_area.start_hash %llx, "
+		  "items_area.end_hash %llx\n",
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
+	hdr = &node->raw.extents_header;
+	old_forks_count = le32_to_cpu(hdr->forks_count);
+
+	if (node->items_area.items_count == 0) {
+		hdr->forks_count = cpu_to_le32(0);
+		hdr->allocated_extents = cpu_to_le32(0);
+		hdr->valid_extents = cpu_to_le32(0);
+		hdr->blks_count = cpu_to_le64(0);
+		hdr->max_extent_blks = cpu_to_le32(0);
+	} else {
+		if (old_forks_count < search->request.count) {
+			hdr->forks_count = cpu_to_le32(0);
+			hdr->allocated_extents = cpu_to_le32(0);
+			hdr->valid_extents = cpu_to_le32(0);
+			hdr->blks_count = cpu_to_le64(0);
+			hdr->max_extent_blks = cpu_to_le32(0);
+		} else {
+			forks_count = le32_to_cpu(hdr->forks_count);
+			forks_count -= search->request.count;
+			hdr->forks_count = cpu_to_le32(forks_count);
+
+			allocated_extents = le32_to_cpu(hdr->allocated_extents);
+			allocated_extents -=
+				search->request.count *
+				SSDFS_INLINE_EXTENTS_COUNT;
+			hdr->allocated_extents = cpu_to_le32(allocated_extents);
+
+			err = ssdfs_calculate_range_blocks_in_node(node,
+							&node->items_area,
+							0, forks_count,
+							&valid_extents,
+							&blks_count,
+							&max_extent_blks);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to calculate range's blocks: "
+					  "node_id %u, item_index %u, "
+					  "range_len %u\n",
+					  node->node_id, 0, forks_count);
+				goto finish_items_area_correction;
+			}
+
+			hdr->valid_extents = cpu_to_le32(valid_extents);
+			hdr->blks_count = cpu_to_le64(blks_count);
+			hdr->max_extent_blks = cpu_to_le32(max_extent_blks);
+		}
+	}
+
+	forks_count = le32_to_cpu(hdr->forks_count);
+	forks_diff = old_forks_count - forks_count;
+	atomic64_sub(forks_diff, &etree->forks_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("forks_count %lld\n",
+		  atomic64_read(&etree->forks_count));
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
+	if (forks_count != 0) {
+		err = ssdfs_set_dirty_items_range(node,
+						  items_area.items_capacity,
+						  item_index,
+						  old_forks_count - item_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set items range as dirty: "
+				  "start %u, count %u, err %d\n",
+				  item_index,
+				  old_forks_count - item_index,
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
+finish_delete_range:
+	ssdfs_unlock_items_range(node, item_index, locked_len);
+	up_read(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: err %d\n",
+			  err);
+		return err;
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (forks_count == 0) {
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
+	if (forks_count == 0 && index_count == 0)
+		search->result.state = SSDFS_BTREE_SEARCH_PLEASE_DELETE_NODE;
+	else
+		search->result.state = SSDFS_BTREE_SEARCH_OBSOLETE_RESULT;
+
+	if (search->request.type == SSDFS_BTREE_SEARCH_DELETE_RANGE) {
+		if (search->request.count > range_len) {
+			search->request.start.hash = items_area.end_hash;
+			search->request.count -= range_len;
+			SSDFS_DBG("continue to delete range\n");
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
+ * ssdfs_extents_btree_node_delete_item() - delete an item from node
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
+int ssdfs_extents_btree_node_delete_item(struct ssdfs_btree_node *node,
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
+		  "parent %p, child %p, result.count %u\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child, search->result.count);
+
+	BUG_ON(search->result.count != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_extents_btree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete fork: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_btree_node_delete_range() - delete range of items from node
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
+int ssdfs_extents_btree_node_delete_range(struct ssdfs_btree_node *node,
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
+		  "parent %p, child %p\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height), search->node.parent,
+		  search->node.child);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_extents_btree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete forks range: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_extents_btree_node_extract_range() - extract range of items from node
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
+int ssdfs_extents_btree_node_extract_range(struct ssdfs_btree_node *node,
+					    u16 start_index, u16 count,
+					    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_fork *fork;
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
+						sizeof(struct ssdfs_raw_fork),
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
+	fork = (struct ssdfs_raw_fork *)search->result.buf;
+	search->request.start.hash = le64_to_cpu(fork->start_offset);
+	fork += search->result.count - 1;
+	search->request.end.hash = le64_to_cpu(fork->start_offset);
+	search->request.count = count;
+
+	return 0;
+
+}
+
+/*
+ * ssdfs_extents_btree_resize_items_area() - resize items area of the node
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
+int ssdfs_extents_btree_resize_items_area(struct ssdfs_btree_node *node,
+					  u32 new_size)
+{
+	struct ssdfs_fs_info *fsi;
+	size_t item_size = sizeof(struct ssdfs_raw_fork);
+	size_t index_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	SSDFS_DBG("node_id %u, new_size %u\n",
+		  node->node_id, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+	index_size = le16_to_cpu(fsi->vh->extents_btree.desc.index_size);
+
+	return __ssdfs_btree_node_resize_items_area(node,
+						    item_size,
+						    index_size,
+						    new_size);
+}
+
+void ssdfs_debug_extents_btree_object(struct ssdfs_extents_btree_info *tree)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i, j;
+
+	BUG_ON(!tree);
+
+	SSDFS_DBG("EXTENTS TREE: type %#x, state %#x, "
+		  "forks_count %llu, is_locked %d, "
+		  "generic_tree %p, inline_forks %p, "
+		  "root %p, owner %p, fsi %p\n",
+		  atomic_read(&tree->type),
+		  atomic_read(&tree->state),
+		  (u64)atomic64_read(&tree->forks_count),
+		  rwsem_is_locked(&tree->lock),
+		  tree->generic_tree,
+		  tree->inline_forks,
+		  tree->root,
+		  tree->owner,
+		  tree->fsi);
+
+	if (tree->generic_tree) {
+		/* debug dump of generic tree */
+		ssdfs_debug_btree_object(tree->generic_tree);
+	}
+
+	if (tree->inline_forks) {
+		for (i = 0; i < SSDFS_INLINE_FORKS_COUNT; i++) {
+			struct ssdfs_raw_fork *fork;
+
+			fork = &tree->inline_forks[i];
+
+			SSDFS_DBG("INLINE FORK: index %d, "
+				  "start_offset %llu, blks_count %llu\n",
+				  i,
+				  le64_to_cpu(fork->start_offset),
+				  le64_to_cpu(fork->blks_count));
+
+			for (j = 0; j < SSDFS_INLINE_EXTENTS_COUNT; j++) {
+				struct ssdfs_raw_extent *extent;
+
+				extent = &fork->extents[j];
+
+				SSDFS_DBG("EXTENT: index %d, "
+					  "seg_id %llu, logical_blk %u, "
+					  "len %u\n",
+					  j,
+					  le64_to_cpu(extent->seg_id),
+					  le32_to_cpu(extent->logical_blk),
+					  le32_to_cpu(extent->len));
+			}
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
+const struct ssdfs_btree_descriptor_operations ssdfs_extents_btree_desc_ops = {
+	.init		= ssdfs_extents_btree_desc_init,
+	.flush		= ssdfs_extents_btree_desc_flush,
+};
+
+const struct ssdfs_btree_operations ssdfs_extents_btree_ops = {
+	.create_root_node	= ssdfs_extents_btree_create_root_node,
+	.create_node		= ssdfs_extents_btree_create_node,
+	.init_node		= ssdfs_extents_btree_init_node,
+	.destroy_node		= ssdfs_extents_btree_destroy_node,
+	.add_node		= ssdfs_extents_btree_add_node,
+	.delete_node		= ssdfs_extents_btree_delete_node,
+	.pre_flush_root_node	= ssdfs_extents_btree_pre_flush_root_node,
+	.flush_root_node	= ssdfs_extents_btree_flush_root_node,
+	.pre_flush_node		= ssdfs_extents_btree_pre_flush_node,
+	.flush_node		= ssdfs_extents_btree_flush_node,
+};
+
+const struct ssdfs_btree_node_operations ssdfs_extents_btree_node_ops = {
+	.find_item		= ssdfs_extents_btree_node_find_item,
+	.find_range		= ssdfs_extents_btree_node_find_range,
+	.extract_range		= ssdfs_extents_btree_node_extract_range,
+	.allocate_item		= ssdfs_extents_btree_node_allocate_item,
+	.allocate_range		= ssdfs_extents_btree_node_allocate_range,
+	.insert_item		= ssdfs_extents_btree_node_insert_item,
+	.insert_range		= ssdfs_extents_btree_node_insert_range,
+	.change_item		= ssdfs_extents_btree_node_change_item,
+	.delete_item		= ssdfs_extents_btree_node_delete_item,
+	.delete_range		= ssdfs_extents_btree_node_delete_range,
+	.resize_items_area	= ssdfs_extents_btree_resize_items_area,
+};
-- 
2.34.1

