Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F056A2671
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBYBUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBYBTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0E14EB1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:08 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y184so799099oiy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWskcHFcXnOzVU030JxCrM03sRl41YyxeLn7/rXHJ+0=;
        b=G0kYERFo8Wu3IHW8Us8FKSsl5cBM3Th0mgrcZ/28yumz1At7DfTPFgu3MgqR5aGBxL
         d8QAf/Ff6n31QZ4N96eY9LRDpqiP7wfvhfOXKqrd672u9rqNOG8QDCwSTvgm1ruMlHdV
         uNPuMiJ2YC0NviGclQSRzOq+KbizLiimUokaf6hJvW6no3qqLC0kNElzGN2tjkg6po+I
         M2Tin2TjAvyKt8xezuY0brgL5Pui7RAgpArkg8+Ab9wqNjHPOIN6PWfb6nV6ekKQBmlF
         gMGUfgboWjfpl312JRsDgEWAyz6uK8ZhETD3tAlW7jIIicK3YSU+xNDxOK9EqkW8L4oZ
         5caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWskcHFcXnOzVU030JxCrM03sRl41YyxeLn7/rXHJ+0=;
        b=CDRq07WTj08LbUNCTV+ADZz5g4RsYGDWmfT/jwzvvU2Z0qkkSXDMtNOqtDT/rQWR0C
         aeNMAU2fjRGRS5y8rMTXxPsljY9+RWPNYPqwZoJqZfk9O/6jqggU9UZ8qHc95eDdhvyB
         rDAKMW2EFXTHxxszLp7QRONivENM6/X5OXyXfAISQKtPOnI/kUhi4joyldeUVWEK/PUG
         1k66e4whJ7tFccpvSaSkQQRacjNoBOQ3JSiq7DTfLMEo05KEHw4VUrjjJCGajOxmKbQJ
         0hq4C5pX2yLX0F3yFd5STsgTgqJlk8b7lq37Q5IcAc0JhQ767zL1tnQbw2iuwrxcsODS
         jOzg==
X-Gm-Message-State: AO0yUKX+JppZ/2Txb+iNMq3Batro5eCONofgp4yvJqDtNN7v33nRnlo1
        N8P0ZIsLHj9bjuKmkE9jwVLlLnb03SpKZ+dD
X-Google-Smtp-Source: AK7set/41h6cdVMjtiR0cjENyzQQFFdtYVgxappJAbAQ4A8j54j58xsSqfwK6Y3seXDhlzY984WZig==
X-Received: by 2002:aca:2218:0:b0:384:87c:7579 with SMTP id b24-20020aca2218000000b00384087c7579mr1288000oic.42.1677287887388;
        Fri, 24 Feb 2023 17:18:07 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:18:06 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 72/76] ssdfs: modification operations of invalidated extents b-tree
Date:   Fri, 24 Feb 2023 17:09:23 -0800
Message-Id: <20230225010927.813929-73-slava@dubeyko.com>
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

Implement modification logic of invalidated extents b-tree.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/invalidated_extents_tree.c | 2900 +++++++++++++++++++++++++++
 1 file changed, 2900 insertions(+)

diff --git a/fs/ssdfs/invalidated_extents_tree.c b/fs/ssdfs/invalidated_extents_tree.c
index d7dc4156a20d..0d2a255b9551 100644
--- a/fs/ssdfs/invalidated_extents_tree.c
+++ b/fs/ssdfs/invalidated_extents_tree.c
@@ -4161,3 +4161,2903 @@ int ssdfs_invextree_node_do_insert_range(struct ssdfs_invextree_info *tree,
 
 	return err;
 }
+
+/*
+ * ssdfs_invextree_node_merge_range_left() - merge range with left extent
+ * @tree: invalidated extents tree
+ * @node: pointer on node object
+ * @items_area: items area state
+ * @search: search object [in|out]
+ *
+ * This method tries to merge a left extent with inserting range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_invextree_node_merge_range_left(struct ssdfs_invextree_info *tree,
+				struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *items_area,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_invextree_node_header *hdr;
+	struct ssdfs_raw_extent *prepared = NULL;
+	struct ssdfs_raw_extent extent;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u16 item_index;
+	u16 range_len;
+	u32 used_space;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 added_extents = 0;
+	u16 extents_count = 0;
+	u32 len;
+	u64 start_hash, end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node || !items_area || !search);
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
+	fsi = node->tree->fsi;
+
+	item_index = search->result.start_index;
+	if (item_index == 0) {
+		SSDFS_ERR("there is no item from the left\n");
+		return -ERANGE;
+	}
+
+	search->result.start_index--;
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > items_area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	range_len = items_area->items_count - search->result.start_index;
+	extents_count = range_len + search->request.count;
+
+	prepared = (struct ssdfs_raw_extent *)search->result.buf;
+	len = le32_to_cpu(prepared->len);
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      items_area,
+					      item_index - 1,
+					      &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		return err;
+	}
+
+	le32_add_cpu(&extent.len, len);
+
+	ssdfs_memcpy(search->result.buf, 0, search->result.buf_size,
+		     &extent, 0, item_size,
+		     item_size);
+
+	added_extents = search->request.count - 1;
+
+	if (search->request.count > 1) {
+		err = ssdfs_shift_range_right(node, items_area, item_size,
+					      item_index + 1, range_len - 1,
+					      added_extents);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to shift dentries range: "
+				  "start %u, count %u, err %d\n",
+				  item_index, added_extents, err);
+			return err;
+		}
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	err = ssdfs_generic_insert_range(node, items_area,
+					 item_size, search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to insert item: err %d\n",
+			  err);
+		return err;
+	}
+
+	down_write(&node->header_lock);
+
+	if (search->request.count > 1) {
+		node->items_area.items_count += added_extents;
+		if (node->items_area.items_count >
+					node->items_area.items_capacity) {
+			err = -ERANGE;
+			SSDFS_ERR("items_count %u > items_capacity %u\n",
+				  node->items_area.items_count,
+				  node->items_area.items_capacity);
+			goto finish_items_area_correction;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_capacity %u, items_count %u\n",
+			  items_area->items_capacity,
+			  items_area->items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		used_space = added_extents * item_size;
+		if (used_space > node->items_area.free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("used_space %u > free_space %u\n",
+				  used_space,
+				  node->items_area.free_space);
+			goto finish_items_area_correction;
+		}
+		node->items_area.free_space -= used_space;
+	}
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      &node->items_area,
+					      0, &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk);
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      &node->items_area,
+					      node->items_area.items_count - 1,
+					      &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk);
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
+					 item_index, extents_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	if (search->request.count > 1) {
+		hdr = &node->raw.invextree_header;
+
+		le32_add_cpu(&hdr->extents_count, added_extents);
+		atomic64_add(added_extents, &tree->extents_count);
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
+ * ssdfs_invextree_node_merge_range_right() - merge range with right extent
+ * @tree: invalidated extents tree
+ * @node: pointer on node object
+ * @items_area: items area state
+ * @search: search object [in|out]
+ *
+ * This method tries to merge a right extent with inserting range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_invextree_node_merge_range_right(struct ssdfs_invextree_info *tree,
+				struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *items_area,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_invextree_node_header *hdr;
+	struct ssdfs_raw_extent extent;
+	struct ssdfs_raw_extent *prepared = NULL;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u16 item_index;
+	u16 range_len;
+	u32 used_space;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 offset;
+	u32 len;
+	u32 added_extents = 0;
+	u16 extents_count = 0;
+	u64 start_hash, end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node || !items_area || !search);
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
+	fsi = node->tree->fsi;
+
+	item_index = search->result.start_index + search->request.count - 1;
+	if (item_index >= items_area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, items_capacity %u\n",
+			  item_index, items_area->items_capacity);
+		return -ERANGE;
+	}
+
+	range_len = items_area->items_count - search->result.start_index;
+	extents_count = range_len + search->request.count;
+
+	offset = (search->result.items_in_buffer - 1) *
+			sizeof(struct ssdfs_raw_extent);
+
+	prepared =
+		(struct ssdfs_raw_extent *)((u8 *)search->result.buf + offset);
+	len = le32_to_cpu(prepared->len);
+
+	err = ssdfs_invextree_node_get_extent(node,
+						items_area,
+						item_index,
+						&extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		return err;
+	}
+
+	extent.logical_blk = prepared->logical_blk;
+	le32_add_cpu(&extent.len, len);
+
+	ssdfs_memcpy(search->result.buf, offset, search->result.buf_size,
+		     &extent, 0, item_size,
+		     item_size);
+
+	item_index = search->result.start_index + 1;
+	added_extents = search->request.count - 1;
+
+	if (search->request.count > 1) {
+		err = ssdfs_shift_range_right(node, items_area, item_size,
+					      item_index, range_len - 1,
+					      added_extents);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to shift dentries range: "
+				  "start %u, count %u, err %d\n",
+				  item_index, added_extents, err);
+			return err;
+		}
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	err = ssdfs_generic_insert_range(node, items_area,
+					 item_size, search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to insert item: err %d\n",
+			  err);
+		return err;
+	}
+
+	down_write(&node->header_lock);
+
+	if (search->request.count > 1) {
+		node->items_area.items_count += added_extents;
+		if (node->items_area.items_count >
+					node->items_area.items_capacity) {
+			err = -ERANGE;
+			SSDFS_ERR("items_count %u > items_capacity %u\n",
+				  node->items_area.items_count,
+				  node->items_area.items_capacity);
+			goto finish_items_area_correction;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_capacity %u, items_count %u\n",
+			  items_area->items_capacity,
+			  items_area->items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		used_space = added_extents * item_size;
+		if (used_space > node->items_area.free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("used_space %u > free_space %u\n",
+				  used_space,
+				  node->items_area.free_space);
+			goto finish_items_area_correction;
+		}
+		node->items_area.free_space -= used_space;
+	}
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      &node->items_area,
+					      0, &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk);
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      &node->items_area,
+					      node->items_area.items_count - 1,
+					      &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk);
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
+					 item_index, extents_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	if (search->request.count > 1) {
+		hdr = &node->raw.invextree_header;
+
+		le32_add_cpu(&hdr->extents_count, added_extents);
+		atomic64_add(added_extents, &tree->extents_count);
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
+ * ssdfs_invextree_node_merge_left_and_right() - merge range with neighbours
+ * @tree: invalidated extents tree
+ * @node: pointer on node object
+ * @items_area: items area state
+ * @search: search object [in|out]
+ *
+ * This method tries to merge inserting range with left and right extents.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static int
+ssdfs_invextree_node_merge_left_and_right(struct ssdfs_invextree_info *tree,
+				struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *items_area,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_invextree_node_header *hdr;
+	struct ssdfs_raw_extent extent;
+	struct ssdfs_raw_extent *prepared = NULL;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u16 item_index;
+	u16 range_len;
+	u32 used_space;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 offset;
+	u32 len;
+	int added_extents = 0;
+	u16 extents_count = 0;
+	u64 start_hash, end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !node || !items_area || !search);
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
+	fsi = node->tree->fsi;
+
+	item_index = search->result.start_index;
+	if ((item_index + search->request.count) > items_area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "item_index %u, count %u\n",
+			  item_index, search->request.count);
+		return -ERANGE;
+	}
+
+	prepared = (struct ssdfs_raw_extent *)search->result.buf;
+	len = le32_to_cpu(prepared->len);
+
+	if (item_index == 0) {
+		SSDFS_ERR("there is no item from the left\n");
+		return -ERANGE;
+	}
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      items_area,
+					      item_index - 1,
+					      &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		return err;
+	}
+
+	le32_add_cpu(&extent.len, len);
+
+	ssdfs_memcpy(search->result.buf, 0, search->result.buf_size,
+		     &extent, 0, item_size,
+		     item_size);
+
+	item_index = search->result.start_index + search->request.count - 1;
+
+	offset = (search->result.items_in_buffer - 1) *
+			sizeof(struct ssdfs_raw_extent);
+
+	prepared =
+		(struct ssdfs_raw_extent *)((u8 *)search->result.buf + offset);
+	len = le32_to_cpu(prepared->len);
+
+	err = ssdfs_invextree_node_get_extent(node,
+						items_area,
+						item_index,
+						&extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		return err;
+	}
+
+	if (search->request.count > 1)
+		extent.logical_blk = prepared->logical_blk;
+
+	le32_add_cpu(&extent.len, len);
+
+	ssdfs_memcpy(search->result.buf, offset, search->result.buf_size,
+		     &extent, 0, item_size,
+		     item_size);
+
+	range_len = items_area->items_count - search->result.start_index;
+	extents_count = range_len + search->request.count;
+	added_extents = search->request.count - 2;
+
+	if (search->request.count <= 0) {
+		SSDFS_ERR("invalid request count %d\n",
+			  search->request.count);
+		return -ERANGE;
+	} else if (search->request.count == 1) {
+		err = ssdfs_shift_range_left(node, items_area, item_size,
+					     item_index, range_len,
+					     search->request.count);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to shift dentries range: "
+				  "start %u, count %u, err %d\n",
+				  item_index, search->request.count, err);
+			return err;
+		}
+
+		item_index = search->result.start_index - 1;
+	} else if (search->request.count == 2) {
+		/* no shift */
+		item_index = search->result.start_index - 1;
+	} else {
+		item_index = search->result.start_index + 1;
+
+		err = ssdfs_shift_range_right(node, items_area, item_size,
+					      item_index, range_len - 1,
+					      added_extents);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to shift dentries range: "
+				  "start %u, count %u, err %d\n",
+				  item_index, added_extents, err);
+			return err;
+		}
+
+		item_index = search->result.start_index - 1;
+	}
+
+	ssdfs_debug_btree_node_object(node);
+
+	err = ssdfs_generic_insert_range(node, items_area,
+					 item_size, search);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to insert item: err %d\n",
+			  err);
+		return err;
+	}
+
+	down_write(&node->header_lock);
+
+	if (search->request.count <= 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid request count %d\n",
+			  search->request.count);
+		goto finish_items_area_correction;
+	} else if (search->request.count == 1) {
+		if (node->items_area.items_count == 0) {
+			err = -ERANGE;
+			SSDFS_ERR("node's items area is empty\n");
+			goto finish_items_area_correction;
+		}
+
+		/* two items are exchanged on one */
+		node->items_area.items_count--;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_capacity %u, items_count %u\n",
+			  items_area->items_capacity,
+			  items_area->items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		node->items_area.free_space += item_size;
+	} else if (search->request.count == 2) {
+		/*
+		 * Nothing has been added.
+		 */
+	} else {
+		node->items_area.items_count += added_extents;
+		if (node->items_area.items_count >
+					node->items_area.items_capacity) {
+			err = -ERANGE;
+			SSDFS_ERR("items_count %u > items_capacity %u\n",
+				  node->items_area.items_count,
+				  node->items_area.items_capacity);
+			goto finish_items_area_correction;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_capacity %u, items_count %u\n",
+			  items_area->items_capacity,
+			  items_area->items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		used_space = added_extents * item_size;
+		if (used_space > node->items_area.free_space) {
+			err = -ERANGE;
+			SSDFS_ERR("used_space %u > free_space %u\n",
+				  used_space,
+				  node->items_area.free_space);
+			goto finish_items_area_correction;
+		}
+		node->items_area.free_space -= used_space;
+	}
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      &node->items_area,
+					      0, &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk);
+
+	err = ssdfs_invextree_node_get_extent(node,
+					      &node->items_area,
+					      node->items_area.items_count - 1,
+					      &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk);
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
+					 item_index, extents_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to correct lookup table: "
+			  "err %d\n", err);
+		goto finish_items_area_correction;
+	}
+
+	if (search->request.count == 1) {
+		hdr = &node->raw.invextree_header;
+
+		le32_add_cpu(&hdr->extents_count, added_extents);
+		atomic64_add(added_extents, &tree->extents_count);
+	} else if (search->request.count == 2) {
+		/*
+		 * Nothing has been added.
+		 */
+	} else {
+		hdr = &node->raw.invextree_header;
+
+		le32_add_cpu(&hdr->extents_count, added_extents);
+		atomic64_add(added_extents, &tree->extents_count);
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
+ * __ssdfs_invextree_node_insert_range() - insert range into node
+ * @node: pointer on node object
+ * @search: search object
+ *
+ * This method tries to insert the range of extents into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int __ssdfs_invextree_node_insert_range(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree *tree;
+	struct ssdfs_invextree_info *tree_info;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_raw_extent found;
+	struct ssdfs_raw_extent *prepared = NULL;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u64 old_hash;
+	u64 start_hash = U64_MAX, end_hash = U64_MAX;
+	u64 cur_hash;
+	u16 item_index;
+	int free_items;
+	u16 range_len;
+	u16 extents_count = 0;
+	u64 seg_id1, seg_id2;
+	u32 logical_blk1, logical_blk2;
+	u32 len;
+	int direction;
+	bool need_merge_with_left = false;
+	bool need_merge_with_right = false;
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
+	fsi = tree->fsi;
+
+	switch (tree->type) {
+	case SSDFS_INVALIDATED_EXTENTS_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	tree_info = container_of(tree,
+				 struct ssdfs_invextree_info,
+				 generic_tree);
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
+	extents_count = range_len + search->request.count;
+
+	item_index = search->result.start_index;
+	if ((item_index + extents_count) > items_area.items_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid snapshots_count: "
+			  "item_index %u, extents_count %u, "
+			  "items_capacity %u\n",
+			  item_index, extents_count,
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
+		err = ssdfs_invextree_node_get_extent(node,
+						      &items_area,
+						      item_index - 1,
+						      &found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get extent: err %d\n", err);
+			goto finish_detect_affected_items;
+		}
+
+		seg_id1 = le64_to_cpu(found.seg_id);
+		logical_blk1 = le32_to_cpu(found.logical_blk);
+		len = le32_to_cpu(found.len);
+
+		cur_hash = ssdfs_invextree_calculate_hash(fsi, seg_id1,
+						    logical_blk1 + len - 1);
+
+		if (cur_hash < start_hash) {
+			prepared =
+				(struct ssdfs_raw_extent *)search->result.buf;
+
+			seg_id2 = le64_to_cpu(prepared->seg_id);
+			logical_blk2 = le32_to_cpu(prepared->logical_blk);
+
+			if (seg_id1 == seg_id2 &&
+			    (logical_blk1 + len) == logical_blk2) {
+				/*
+				 * Left and prepared extents need to be merged
+				 */
+				need_merge_with_left = true;
+			}
+		} else {
+			SSDFS_ERR("invalid range: item_index %u, "
+				  "cur_hash %llx, "
+				  "start_hash %llx, end_hash %llx\n",
+				  item_index, cur_hash,
+				  start_hash, end_hash);
+
+			ssdfs_show_extent_items(node, &items_area);
+
+			err = -ERANGE;
+			goto finish_detect_affected_items;
+		}
+	}
+
+	if (item_index < items_area.items_count) {
+		err = ssdfs_invextree_node_get_extent(node,
+						      &items_area,
+						      item_index,
+						      &found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get extent: err %d\n", err);
+			goto finish_detect_affected_items;
+		}
+
+		seg_id1 = le64_to_cpu(found.seg_id);
+		logical_blk1 = le32_to_cpu(found.logical_blk);
+
+		cur_hash = ssdfs_invextree_calculate_hash(fsi, seg_id1,
+							  logical_blk1);
+
+		if (end_hash < cur_hash) {
+			prepared =
+				(struct ssdfs_raw_extent *)search->result.buf;
+			prepared += search->result.items_in_buffer - 1;
+
+			seg_id2 = le64_to_cpu(prepared->seg_id);
+			logical_blk2 = le32_to_cpu(prepared->logical_blk);
+			len = le32_to_cpu(prepared->len);
+
+			if (seg_id1 == seg_id2 &&
+			    (logical_blk2 + len) == logical_blk1) {
+				/*
+				 * Right and prepared extents need to be merged
+				 */
+				need_merge_with_right = true;
+			}
+		} else {
+			SSDFS_ERR("invalid range: item_index %u, "
+				  "cur_hash %llx, "
+				  "start_hash %llx, end_hash %llx\n",
+				  item_index, cur_hash,
+				  start_hash, end_hash);
+
+			ssdfs_show_extent_items(node, &items_area);
+
+			err = -ERANGE;
+			goto finish_detect_affected_items;
+		}
+	}
+
+	if (need_merge_with_left) {
+		item_index -= 1;
+		search->result.start_index = item_index;
+
+		range_len = items_area.items_count - search->result.start_index;
+		extents_count = range_len + search->request.count;
+	}
+
+lock_items_range:
+	err = ssdfs_lock_items_range(node, item_index, extents_count);
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
+	if (need_merge_with_left && need_merge_with_right) {
+		err = ssdfs_invextree_node_merge_left_and_right(tree_info,
+								node,
+								&items_area,
+								search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert range: err %d\n", err);
+			goto unlock_items_range;
+		}
+	} else if (need_merge_with_left) {
+		err = ssdfs_invextree_node_merge_range_left(tree_info,
+							    node,
+							    &items_area,
+							    search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert range: err %d\n", err);
+			goto unlock_items_range;
+		}
+	} else if (need_merge_with_right) {
+		err = ssdfs_invextree_node_merge_range_right(tree_info,
+							     node,
+							     &items_area,
+							     search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert range: err %d\n", err);
+			goto unlock_items_range;
+		}
+	} else {
+		err = ssdfs_invextree_node_do_insert_range(tree_info, node,
+							   &items_area,
+							   search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to insert range: err %d\n", err);
+			goto unlock_items_range;
+		}
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
+					  item_index, extents_count);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to set items range as dirty: "
+			  "start %u, count %u, err %d\n",
+			  item_index, extents_count, err);
+		goto unlock_items_range;
+	}
+
+unlock_items_range:
+	ssdfs_unlock_items_range(node, item_index, extents_count);
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
+ * ssdfs_invextree_node_insert_item() - insert item in the node
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
+int ssdfs_invextree_node_insert_item(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_search *search)
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
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count != 1);
+	BUG_ON(!search->result.buf);
+	BUG_ON(search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST) {
+		SSDFS_ERR("invalid area state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	err = __ssdfs_invextree_node_insert_range(node, search);
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
+ * ssdfs_invextree_node_insert_range() - insert range of items
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
+int ssdfs_invextree_node_insert_range(struct ssdfs_btree_node *node,
+				      struct ssdfs_btree_search *search)
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
+	err = __ssdfs_invextree_node_insert_range(node, search);
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
+ * ssdfs_change_item_only() - change snapshot in the node
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
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent extent;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u16 range_len;
+	u16 item_index;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
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
+	fsi = node->tree->fsi;
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
+	err = ssdfs_invextree_node_get_extent(node, area, item_index, &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get extent: err %d\n", err);
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
+		err = ssdfs_invextree_node_get_extent(node,
+						      &node->items_area,
+						      item_index,
+						      &extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get extent: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+
+		start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+							    logical_blk);
+	}
+
+	if ((item_index + range_len) == node->items_area.items_count) {
+		err = ssdfs_invextree_node_get_extent(node,
+						    &node->items_area,
+						    item_index + range_len - 1,
+						    &extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get extent: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+		len = le32_to_cpu(extent.len);
+
+		end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk + len - 1);
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
+ * ssdfs_invextree_node_change_item() - change item in the node
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
+int ssdfs_invextree_node_change_item(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node_items_area items_area;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
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
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(search->result.count != 1);
+	BUG_ON(!search->result.buf);
+	BUG_ON(search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER);
+	BUG_ON(search->result.items_in_buffer != 1);
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
+		/* expected type */
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
+	spinlock_t  *lock;
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
+ * __ssdfs_invextree_node_delete_range() - delete range of items
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
+int __ssdfs_invextree_node_delete_range(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree *tree;
+	struct ssdfs_invextree_info *tree_info;
+	struct ssdfs_invextree_node_header *hdr;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_raw_extent extent;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u16 index_count = 0;
+	int free_items;
+	u16 item_index;
+	int direction;
+	u16 range_len;
+	u16 shift_range_len = 0;
+	u16 locked_len = 0;
+	u32 deleted_space, free_space;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 start_hash = U64_MAX;
+	u64 end_hash = U64_MAX;
+	u64 old_hash;
+	u32 old_extents_count = 0, extents_count = 0;
+	u32 extents_diff;
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
+	fsi = node->tree->fsi;
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
+	case SSDFS_INVALIDATED_EXTENTS_BTREE:
+		/* expected btree type */
+		break;
+
+	default:
+		SSDFS_ERR("invalid btree type %#x\n", tree->type);
+		return -ERANGE;
+	}
+
+	tree_info = container_of(tree,
+				 struct ssdfs_invextree_info,
+				 generic_tree);
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
+	extents_count = items_area.items_count;
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
+	err = ssdfs_btree_node_clear_range(node, &node->items_area,
+					   item_size, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear items range: err %d\n",
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
+		err = ssdfs_invextree_node_get_extent(node,
+						      &node->items_area,
+						      0, &extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get extent: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+
+		start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+							    logical_blk);
+
+		err = ssdfs_invextree_node_get_extent(node,
+					&node->items_area,
+					node->items_area.items_count - 1,
+					&extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get extent: err %d\n", err);
+			goto finish_items_area_correction;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+		len = le32_to_cpu(extent.len);
+
+		end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk + len - 1);
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
+	hdr = &node->raw.invextree_header;
+
+	old_extents_count = le32_to_cpu(hdr->extents_count);
+
+	if (node->items_area.items_count == 0) {
+		hdr->extents_count = cpu_to_le32(0);
+	} else {
+		if (old_extents_count < search->request.count) {
+			hdr->extents_count = cpu_to_le32(0);
+		} else {
+			extents_count = le32_to_cpu(hdr->extents_count);
+			extents_count -= search->request.count;
+			hdr->extents_count = cpu_to_le32(extents_count);
+		}
+	}
+
+	extents_count = le32_to_cpu(hdr->extents_count);
+	extents_diff = old_extents_count - extents_count;
+	atomic64_sub(extents_diff, &tree_info->extents_count);
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
+	if (extents_count != 0) {
+		err = ssdfs_set_dirty_items_range(node,
+					items_area.items_capacity,
+					item_index,
+					old_extents_count - item_index);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to set items range as dirty: "
+				  "start %u, count %u, err %d\n",
+				  item_index,
+				  old_extents_count - item_index,
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
+	if (unlikely(err))
+		return err;
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (extents_count == 0) {
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
+	SSDFS_DBG("node_type %#x, extents_count %u, index_count %u\n",
+		  atomic_read(&node->type),
+		  extents_count, index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (extents_count == 0 && index_count == 0)
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
+ * ssdfs_invextree_node_delete_item() - delete an item from node
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
+int ssdfs_invextree_node_delete_item(struct ssdfs_btree_node *node,
+				     struct ssdfs_btree_search *search)
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
+
+	BUG_ON(search->result.count != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_invextree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete extent: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_node_delete_range() - delete range of items from node
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
+int ssdfs_invextree_node_delete_range(struct ssdfs_btree_node *node,
+				      struct ssdfs_btree_search *search)
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
+	err = __ssdfs_invextree_node_delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete extents range: err %d\n",
+			  err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_node_extract_range() - extract range of items from node
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
+int ssdfs_invextree_node_extract_range(struct ssdfs_btree_node *node,
+				       u16 start_index, u16 count,
+				       struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent *extent;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
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
+	fsi = node->tree->fsi;
+
+	down_read(&node->full_lock);
+	err = __ssdfs_btree_node_extract_range(node, start_index, count,
+						sizeof(struct ssdfs_raw_extent),
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
+
+	extent = (struct ssdfs_raw_extent *)search->result.buf;
+
+	seg_id = le64_to_cpu(extent->seg_id);
+	logical_blk = le32_to_cpu(extent->logical_blk);
+	search->request.start.hash =
+		ssdfs_invextree_calculate_hash(fsi, seg_id,
+						logical_blk);
+
+	extent += search->result.count - 1;
+
+	seg_id = le64_to_cpu(extent->seg_id);
+	logical_blk = le32_to_cpu(extent->logical_blk);
+	len = le32_to_cpu(extent->len);
+	search->request.end.hash =
+		ssdfs_invextree_calculate_hash(fsi, seg_id,
+						logical_blk + len - 1);
+
+	search->request.count = count;
+
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_resize_items_area() - resize items area of the node
+ * @node: node object
+ * @new_size: new size of the items area
+ *
+ * This method tries to resize the items area of the node.
+ *
+ * It makes sense to allocate the bitmap with taking into
+ * account that we will resize the node. So, it needs
+ * to allocate the index area in bitmap is equal to
+ * the whole node and items area is equal to the whole node.
+ * This technique provides opportunity not to resize or
+ * to shift the content of the bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - node is corrupted.
+ */
+static
+int ssdfs_invextree_resize_items_area(struct ssdfs_btree_node *node,
+				      u32 new_size)
+{
+	struct ssdfs_fs_info *fsi;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
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
+	index_size = le16_to_cpu(fsi->vh->invextree.desc.index_size);
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
+	return 0;
+}
+
+void ssdfs_debug_invextree_object(struct ssdfs_invextree_info *tree)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree);
+
+	SSDFS_DBG("INVALIDATED EXTENTS TREE: state %#x, "
+		  "extents_count %llu, is_locked %d, fsi %p\n",
+		  atomic_read(&tree->state),
+		  (u64)atomic64_read(&tree->extents_count),
+		  rwsem_is_locked(&tree->lock),
+		  tree->fsi);
+
+	ssdfs_debug_btree_object(&tree->generic_tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+const struct ssdfs_btree_descriptor_operations ssdfs_invextree_desc_ops = {
+	.init		= ssdfs_invextree_desc_init,
+	.flush		= ssdfs_invextree_desc_flush,
+};
+
+const struct ssdfs_btree_operations ssdfs_invextree_ops = {
+	.create_root_node	= ssdfs_invextree_create_root_node,
+	.create_node		= ssdfs_invextree_create_node,
+	.init_node		= ssdfs_invextree_init_node,
+	.destroy_node		= ssdfs_invextree_destroy_node,
+	.add_node		= ssdfs_invextree_add_node,
+	.delete_node		= ssdfs_invextree_delete_node,
+	.pre_flush_root_node	= ssdfs_invextree_pre_flush_root_node,
+	.flush_root_node	= ssdfs_invextree_flush_root_node,
+	.pre_flush_node		= ssdfs_invextree_pre_flush_node,
+	.flush_node		= ssdfs_invextree_flush_node,
+};
+
+const struct ssdfs_btree_node_operations ssdfs_invextree_node_ops = {
+	.find_item		= ssdfs_invextree_node_find_item,
+	.find_range		= ssdfs_invextree_node_find_range,
+	.extract_range		= ssdfs_invextree_node_extract_range,
+	.allocate_item		= ssdfs_invextree_node_allocate_item,
+	.allocate_range		= ssdfs_invextree_node_allocate_range,
+	.insert_item		= ssdfs_invextree_node_insert_item,
+	.insert_range		= ssdfs_invextree_node_insert_range,
+	.change_item		= ssdfs_invextree_node_change_item,
+	.delete_item		= ssdfs_invextree_node_delete_item,
+	.delete_range		= ssdfs_invextree_node_delete_range,
+	.resize_items_area	= ssdfs_invextree_resize_items_area,
+};
-- 
2.34.1

