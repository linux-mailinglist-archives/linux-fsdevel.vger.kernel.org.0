Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408F6A2670
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBYBUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBYBTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:40 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A18694
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:06 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bh20so794036oib.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szi3RhYICdmVbKx10qLVhGmU5y2OVUgDDIy8ENOZq/I=;
        b=D7vekgyz0Kw4T/IsoyRn1WwpBKV1qZI0kdQg3yLM/b+Kg4Rje2zcO0VD0q3VrPyKf6
         Y5nlrwI3J0OCZvSw2RaJX6mB4QfNz3skfCfLEVvqGOJCrWeddA/DVzMAj60a/mZxAA0E
         lPA4LvOpZw+WqEnpzq9nh0XfNQSYmRuooiMEjsKcnwPLUHgfP9UklUgr/cG2wprjmAR7
         Yj63E8fiCwAOIs0IhuolH5QVDdd66uBj/eMmgWX8B2XinIyFs0sM8CKLLA02GUFfvOlr
         C7Y4iP6ttbKtdbUslpn20UkYEsYpGBXETkqT2VLJhShmXJHW+LRX/Xsa6pDnDpdbaZIG
         CCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szi3RhYICdmVbKx10qLVhGmU5y2OVUgDDIy8ENOZq/I=;
        b=xYxOdGvaosO3h+WDYh668HpbJ3U+rwdVarMIMbO+oSvXfIebm5XK2xrkDh3SnGsdAV
         OV7Wg/WvYMqCHfQznC2/lvYYeehPgq/h/AJc2vIdJ+eXgZFr73vUevIpUdYl6Vvl9XWl
         p7+12iRyy8BfPkCnL1SMvGsJ/EG0codcivc/yF0gldVUvNWgqNOOAuTKnKCFDSJU2VnM
         ziU2zT+lW/ndA6LwQcQ2Fl+imWDgLjKcGPQfuGPzbG4bOuA+vtE7SUeIhCoN40tCn5YH
         elFqzYalZVeN4EZ20UOIw73Ibq7S68GnC4WuiWBS4b/RfrtbfqqzZvyls9/Wo8MtXNBV
         pXgg==
X-Gm-Message-State: AO0yUKU104mPLh8PAZRPBOcrnkRcklBnJr+IkhYASgEG9/uvF+Do6/lX
        G9L9JFZAb0DEMCRdQ2s/ikPwARzO3RfvkgM6
X-Google-Smtp-Source: AK7set/U1U4SubY8aihSUFO6SdRmchGkblQMG4sarb1NTLUAukVsmGxHIiPQqHe7lWdynGBP0HzHVA==
X-Received: by 2002:a05:6808:687:b0:383:eaea:7dcb with SMTP id k7-20020a056808068700b00383eaea7dcbmr2767247oig.15.1677287885185;
        Fri, 24 Feb 2023 17:18:05 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:18:04 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 71/76] ssdfs: find item in invalidated extents b-tree
Date:   Fri, 24 Feb 2023 17:09:22 -0800
Message-Id: <20230225010927.813929-72-slava@dubeyko.com>
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

Implement lookup logic in invalidated extents b-tree.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/invalidated_extents_tree.c | 1640 +++++++++++++++++++++++++++
 1 file changed, 1640 insertions(+)

diff --git a/fs/ssdfs/invalidated_extents_tree.c b/fs/ssdfs/invalidated_extents_tree.c
index 4cb5ffeac706..d7dc4156a20d 100644
--- a/fs/ssdfs/invalidated_extents_tree.c
+++ b/fs/ssdfs/invalidated_extents_tree.c
@@ -2521,3 +2521,1643 @@ int ssdfs_invextree_flush_node(struct ssdfs_btree_node *node)
 
 	return err;
 }
+
+/******************************************************************************
+ *           SPECIALIZED INVALIDATED EXTENTS BTREE NODE OPERATIONS            *
+ ******************************************************************************/
+
+/*
+ * ssdfs_convert_lookup2item_index() - convert lookup into item index
+ * @node_size: size of the node in bytes
+ * @lookup_index: lookup index
+ */
+static inline
+u16 ssdfs_convert_lookup2item_index(u32 node_size, u16 lookup_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_size %u, lookup_index %u\n",
+		  node_size, lookup_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_convert_lookup2item_index(lookup_index, node_size,
+					sizeof(struct ssdfs_raw_extent),
+					SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * ssdfs_convert_item2lookup_index() - convert item into lookup index
+ * @node_size: size of the node in bytes
+ * @item_index: item index
+ */
+static inline
+u16 ssdfs_convert_item2lookup_index(u32 node_size, u16 item_index)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_size %u, item_index %u\n",
+		  node_size, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_convert_item2lookup_index(item_index, node_size,
+					sizeof(struct ssdfs_raw_extent),
+					SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * is_hash_for_lookup_table() - should item's hash be into lookup table?
+ * @node_size: size of the node in bytes
+ * @item_index: item index
+ */
+static inline
+bool is_hash_for_lookup_table(u32 node_size, u16 item_index)
+{
+	u16 lookup_index;
+	u16 calculated;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_size %u, item_index %u\n",
+		  node_size, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	lookup_index = ssdfs_convert_item2lookup_index(node_size, item_index);
+	calculated = ssdfs_convert_lookup2item_index(node_size, lookup_index);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lookup_index %u, calculated %u\n",
+		  lookup_index, calculated);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return calculated == item_index;
+}
+
+/*
+ * ssdfs_invextree_node_find_lookup_index() - find lookup index
+ * @node: node object
+ * @search: search object
+ * @lookup_index: lookup index [out]
+ *
+ * This method tries to find a lookup index for requested items.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - lookup index doesn't exist for requested hash.
+ */
+static
+int ssdfs_invextree_node_find_lookup_index(struct ssdfs_btree_node *node,
+					   struct ssdfs_btree_search *search,
+					   u16 *lookup_index)
+{
+	__le64 *lookup_table;
+	int array_size = SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search || !lookup_index);
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
+	lookup_table = node->raw.invextree_header.lookup_table;
+	err = ssdfs_btree_node_find_lookup_index_nolock(search,
+							lookup_table,
+							array_size,
+							lookup_index);
+	up_read(&node->header_lock);
+
+	return err;
+}
+
+/*
+ * __ssdfs_check_extent_for_request() - check invalidated extent
+ * @fsi:  pointer on shared file system object
+ * @extent: pointer on invalidated extent object
+ * @search: search object
+ *
+ * This method tries to check @extent for the @search request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - continue the search.
+ * %-ENODATA    - possible place was found.
+ */
+static
+int __ssdfs_check_extent_for_request(struct ssdfs_fs_info *fsi,
+				     struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search)
+{
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 start_hash;
+	u64 end_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !extent || !search);
+
+	SSDFS_DBG("fsi %p, extent %p, search %p\n",
+		  fsi, extent, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_id = le64_to_cpu(extent->seg_id);
+	logical_blk = le32_to_cpu(extent->logical_blk);
+	len = le32_to_cpu(extent->len);
+
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk);
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk + len - 1);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("request (start_hash %llx, end_hash %llx), "
+		  "extent (start_hash %llx, end_hash %llx)\n",
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start_hash > search->request.end.hash) {
+		/* no data for request */
+		err = -ENODATA;
+	} else if (search->request.start.hash > end_hash) {
+		/* continue the search */
+		err = -EAGAIN;
+	} else {
+		/*
+		 * extent is inside request [start_hash, end_hash]
+		 */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_check_extent_for_request() - check invalidated extent
+ * @fsi:  pointer on shared file system object
+ * @extent: pointer on invalidated extent object
+ * @search: search object
+ *
+ * This method tries to check @extent for the @search request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - continue the search.
+ * %-ENODATA    - possible place was found.
+ */
+static
+int ssdfs_check_extent_for_request(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_raw_extent *extent,
+				   struct ssdfs_btree_search *search)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !extent || !search);
+
+	SSDFS_DBG("fsi %p, extent %p, search %p\n",
+		  fsi, extent, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = __ssdfs_check_extent_for_request(fsi, extent, search);
+	if (err == -EAGAIN) {
+		/* continue the search */
+		return err;
+	} else if (err == -ENODATA) {
+		search->result.err = -ENODATA;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to check invalidated extent: err %d\n",
+			  err);
+		return err;
+	} else {
+		/* valid item found */
+		search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_get_extent_hash_range() - get extent's hash range
+ * @fsi:  pointer on shared file system object
+ * @kaddr: pointer on extent object
+ * @start_hash: pointer on start_hash value [out]
+ * @end_hash: pointer on end_hash value [out]
+ */
+static
+void ssdfs_get_extent_hash_range(struct ssdfs_fs_info *fsi,
+				 void *kaddr,
+				 u64 *start_hash,
+				 u64 *end_hash)
+{
+	struct ssdfs_raw_extent *extent;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !kaddr || !start_hash || !end_hash);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extent = (struct ssdfs_raw_extent *)kaddr;
+
+	seg_id = le64_to_cpu(extent->seg_id);
+	logical_blk = le32_to_cpu(extent->logical_blk);
+	len = le32_to_cpu(extent->len);
+
+	*start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						     logical_blk);
+	*end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						   logical_blk + len - 1);
+}
+
+/*
+ * ssdfs_check_found_extent() - check found invalidated extent
+ * @fsi: pointer on shared file system object
+ * @search: search object
+ * @kaddr: pointer on invalidated extent object
+ * @item_index: index of the extent
+ * @start_hash: pointer on start_hash value [out]
+ * @end_hash: pointer on end_hash value [out]
+ * @found_index: pointer on found index [out]
+ *
+ * This method tries to check the found invalidated extent.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - corrupted invalidated extent.
+ * %-EAGAIN     - continue the search.
+ * %-ENODATA    - possible place was found.
+ */
+static
+int ssdfs_check_found_extent(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_btree_search *search,
+			     void *kaddr,
+			     u16 item_index,
+			     u64 *start_hash,
+			     u64 *end_hash,
+			     u16 *found_index)
+{
+	struct ssdfs_raw_extent *extent;
+	u32 req_flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !kaddr || !found_index);
+	BUG_ON(!start_hash || !end_hash);
+
+	SSDFS_DBG("item_index %u\n", item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+	*found_index = U16_MAX;
+
+	extent = (struct ssdfs_raw_extent *)kaddr;
+	req_flags = search->request.flags;
+
+	if (!(req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE)) {
+		SSDFS_ERR("invalid request: hash is absent\n");
+		return -ERANGE;
+	}
+
+	ssdfs_get_extent_hash_range(fsi, kaddr, start_hash, end_hash);
+
+	err = ssdfs_check_extent_for_request(fsi, extent, search);
+	if (err == -ENODATA) {
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = err;
+		search->result.start_index = item_index;
+		search->result.count = 1;
+
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_ADD_ITEM:
+		case SSDFS_BTREE_SEARCH_ADD_RANGE:
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+			/* do nothing */
+			break;
+
+		default:
+			ssdfs_btree_search_free_result_buf(search);
+
+			search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+			search->result.buf = NULL;
+			search->result.buf_size = 0;
+			search->result.items_in_buffer = 0;
+			break;
+		}
+	} else if (err == -EAGAIN) {
+		/* continue to search */
+		err = 0;
+		*found_index = U16_MAX;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to check extent: err %d\n",
+			  err);
+	} else {
+		*found_index = item_index;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_VALID_ITEM;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "found_index %u\n",
+		  *start_hash, *end_hash,
+		  *found_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * ssdfs_prepare_extents_buffer() - prepare buffer for extents
+ * @search: search object
+ * @found_index: found index of invalidated extent
+ * @start_hash: starting hash
+ * @end_hash: ending hash
+ * @items_count: count of items in the sequence
+ * @item_size: size of the item
+ */
+static
+int ssdfs_prepare_extents_buffer(struct ssdfs_btree_search *search,
+				 u16 found_index,
+				 u64 start_hash,
+				 u64 end_hash,
+				 u16 items_count,
+				 size_t item_size)
+{
+	u16 found_extents = 0;
+	size_t buf_size = sizeof(struct ssdfs_raw_extent);
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("found_index %u, start_hash %llx, end_hash %llx, "
+		  "items_count %u, item_size %zu\n",
+		   found_index, start_hash, end_hash,
+		   items_count, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_btree_search_free_result_buf(search);
+
+	if (start_hash == end_hash) {
+		/* use inline buffer */
+		found_extents = 1;
+	} else {
+		/* use external buffer */
+		if (found_index >= items_count) {
+			SSDFS_ERR("found_index %u >= items_count %u\n",
+				  found_index, items_count);
+			return -ERANGE;
+		}
+		found_extents = items_count - found_index;
+	}
+
+	if (found_extents == 1) {
+		search->result.buf_state =
+			SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf = &search->raw.invalidated_extent;
+		search->result.buf_size = buf_size;
+		search->result.items_in_buffer = 0;
+	} else {
+		if (search->result.buf) {
+			SSDFS_WARN("search->result.buf %p, "
+				   "search->result.buf_state %#x\n",
+				   search->result.buf,
+				   search->result.buf_state);
+		}
+
+		err = ssdfs_btree_search_alloc_result_buf(search,
+						buf_size * found_extents);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			return err;
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found_extents %u, "
+		  "search->result.items_in_buffer %u\n",
+		  found_extents,
+		  search->result.items_in_buffer);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_found_extent() - extract found extent
+ * @fsi: pointer on shared file system object
+ * @search: search object
+ * @item_size: size of the item
+ * @kaddr: pointer on invalidated extent
+ * @start_hash: pointer on start_hash value [out]
+ * @end_hash: pointer on end_hash value [out]
+ *
+ * This method tries to extract the found extent.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_extract_found_extent(struct ssdfs_fs_info *fsi,
+				 struct ssdfs_btree_search *search,
+				 size_t item_size,
+				 void *kaddr,
+				 u64 *start_hash,
+				 u64 *end_hash)
+{
+	struct ssdfs_raw_extent *extent;
+	size_t buf_size = sizeof(struct ssdfs_raw_extent);
+	u32 calculated;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !search || !kaddr);
+	BUG_ON(!start_hash || !end_hash);
+
+	SSDFS_DBG("kaddr %p\n", kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = U64_MAX;
+	*end_hash = U64_MAX;
+
+	calculated = search->result.items_in_buffer * buf_size;
+	if (calculated > search->result.buf_size) {
+		SSDFS_ERR("calculated %u > buf_size %zu\n",
+			  calculated, search->result.buf_size);
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search->result.items_in_buffer %u, "
+		  "calculated %u\n",
+		  search->result.items_in_buffer,
+		  calculated);
+
+	BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	extent = (struct ssdfs_raw_extent *)kaddr;
+	ssdfs_get_extent_hash_range(fsi, extent, start_hash, end_hash);
+
+	err = __ssdfs_check_extent_for_request(fsi, extent, search);
+	if (err == -ENODATA) {
+		SSDFS_DBG("current extent is out of requested range\n");
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to check extent: err %d\n",
+			  err);
+		return err;
+	}
+
+	err = ssdfs_memcpy(search->result.buf,
+			   calculated, search->result.buf_size,
+			   extent, 0, item_size,
+			   item_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: calculated %u, "
+			  "search->result.buf_size %zu, err %d\n",
+			  calculated, search->result.buf_size, err);
+		return err;
+	}
+
+	search->result.items_in_buffer++;
+	search->result.count++;
+	search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_hash %llx, end_hash %llx, "
+		  "search->result.count %u\n",
+		  *start_hash, *end_hash,
+		  search->result.count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_extract_range_by_lookup_index() - extract a range of items
+ * @node: pointer on node object
+ * @lookup_index: lookup index for requested range
+ * @search: pointer on search request object
+ *
+ * This method tries to extract a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - requested range is out of the node.
+ */
+static
+int ssdfs_extract_range_by_lookup_index(struct ssdfs_btree_node *node,
+					u16 lookup_index,
+					struct ssdfs_btree_search *search)
+{
+	int capacity = SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+
+	return __ssdfs_extract_range_by_lookup_index(node, lookup_index,
+						capacity, item_size,
+						search,
+						ssdfs_check_found_extent,
+						ssdfs_prepare_extents_buffer,
+						ssdfs_extract_found_extent);
+}
+
+/*
+ * ssdfs_invextree_node_find_range() - find a range of items into the node
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
+int ssdfs_invextree_node_find_range(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_search *search)
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
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("request (start_hash %llx, end_hash %llx), "
+		  "node (start_hash %llx, end_hash %llx)\n",
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  start_hash, end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	err = ssdfs_invextree_node_find_lookup_index(node, search,
+						     &lookup_index);
+	if (err == -ENODATA) {
+		switch (search->request.type) {
+		case SSDFS_BTREE_SEARCH_CHANGE_ITEM:
+		case SSDFS_BTREE_SEARCH_DELETE_ITEM:
+			/* do nothing */
+			goto try_extract_range_by_lookup_index;
+
+		default:
+			/* continue logic */
+			break;
+		}
+
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENODATA;
+		search->result.start_index =
+			ssdfs_convert_lookup2item_index(node->node_size,
+							lookup_index);
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
+try_extract_range_by_lookup_index:
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(lookup_index >= SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_extract_range_by_lookup_index(node, lookup_index,
+						  search);
+	search->result.search_cno = ssdfs_current_cno(node->tree->fsi->sb);
+
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node contains not all requested extents: "
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
+	return 0;
+}
+
+/*
+ * ssdfs_invextree_node_find_item() - find item into node
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
+int ssdfs_invextree_node_find_item(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_search *search)
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
+	if (search->request.count != 1) {
+		SSDFS_ERR("invalid request state: "
+			  "count %d, start_hash %llx, end_hash %llx\n",
+			  search->request.count,
+			  search->request.start.hash,
+			  search->request.end.hash);
+		return -ERANGE;
+	}
+
+	return ssdfs_invextree_node_find_range(node, search);
+}
+
+static
+int ssdfs_invextree_node_allocate_item(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return -EOPNOTSUPP;
+}
+
+static
+int ssdfs_invextree_node_allocate_range(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("operation is unavailable\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+	return -EOPNOTSUPP;
+}
+
+/*
+ * __ssdfs_invextree_node_get_extent() - extract the invalidated extent
+ * @pvec: pointer on pagevec
+ * @area_offset: area offset from the node's beginning
+ * @area_size: area size
+ * @node_size: size of the node
+ * @item_index: index of the extent in the node
+ * @extent: pointer on extent's buffer [out]
+ *
+ * This method tries to extract the invalidated extent from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_invextree_node_get_extent(struct pagevec *pvec,
+					u32 area_offset,
+					u32 area_size,
+					u32 node_size,
+					u16 item_index,
+					struct ssdfs_raw_extent *extent)
+{
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u32 item_offset;
+	int page_index;
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec || !extent);
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
+
+	err = ssdfs_memcpy_from_page(extent, 0, item_size,
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
+ * ssdfs_invextree_node_get_extent() - extract extent from the node
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_index: index of the extent
+ * @extent: pointer on extracted extent [out]
+ *
+ * This method tries to extract the extent from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_invextree_node_get_extent(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				u16 item_index,
+				struct ssdfs_raw_extent *extent)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !extent);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_index %u\n",
+		  node->node_id, item_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_invextree_node_get_extent(&node->content.pvec,
+						 area->offset,
+						 area->area_size,
+						 node->node_size,
+						 item_index,
+						 extent);
+}
+
+/*
+ * is_requested_position_correct() - check that requested position is correct
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @search: search object
+ *
+ * This method tries to check that requested position of an extent
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
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent extent;
+	u16 item_index;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 start_hash;
+	u64 end_hash;
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
+	fsi = node->tree->fsi;
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
+	err = ssdfs_invextree_node_get_extent(node, area, item_index, &extent);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the extent: "
+			  "item_index %u, err %d\n",
+			  item_index, err);
+		return SSDFS_CHECK_POSITION_FAILURE;
+	}
+
+	seg_id = le64_to_cpu(extent.seg_id);
+	logical_blk = le32_to_cpu(extent.logical_blk);
+	len = le32_to_cpu(extent.len);
+
+	start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk);
+	end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						  logical_blk + len - 1);
+
+	if (search->request.end.hash < start_hash)
+		direction = SSDFS_SEARCH_LEFT_DIRECTION;
+	else if (end_hash < search->request.start.hash)
+		direction = SSDFS_SEARCH_RIGHT_DIRECTION;
+	else
+		direction = SSDFS_CORRECT_POSITION;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("extent (start_hash %llx, end_hash %llx), "
+		  "search (start_hash %llx, end_hash %llx), "
+		  "direction %#x\n",
+		  start_hash, end_hash,
+		  search->request.start.hash,
+		  search->request.end.hash,
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
+ * This method tries to find a correct position of the extent
+ * from the left side of extents' sequence in the node.
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
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent extent;
+	int item_index;
+	u64 seg_id;
+	u32 logical_blk;
+	u64 start_hash;
+	u32 req_flags;
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
+	fsi = node->tree->fsi;
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
+	req_flags = search->request.flags;
+
+	for (; item_index >= 0; item_index--) {
+		err = ssdfs_invextree_node_get_extent(node, area,
+							(u16)item_index,
+							&extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the extent: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+
+		start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+							    logical_blk);
+
+		if (search->request.start.hash == start_hash) {
+			search->result.start_index = (u16)item_index;
+			return 0;
+		} else if (start_hash < search->request.start.hash) {
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
+ * This method tries to find a correct position of the extent
+ * from the right side of extents' sequence in the node.
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
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent extent;
+	int item_index;
+	u64 seg_id;
+	u32 logical_blk;
+	u64 start_hash;
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
+	fsi = node->tree->fsi;
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
+	for (; item_index < area->items_count; item_index++) {
+		err = ssdfs_invextree_node_get_extent(node, area,
+							(u16)item_index,
+							&extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the extent: "
+				  "item_index %d, err %d\n",
+				  item_index, err);
+			return err;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+
+		start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+							    logical_blk);
+
+		if (search->request.start.hash == start_hash) {
+			search->result.start_index = (u16)item_index;
+			return 0;
+		} else if (search->request.end.hash < start_hash) {
+			if (item_index == 0) {
+				search->result.start_index =
+						(u16)item_index;
+			} else {
+				search->result.start_index =
+						(u16)(item_index - 1);
+			}
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
+	lookup_table = node->raw.invextree_header.lookup_table;
+
+	lookup_index = ssdfs_convert_item2lookup_index(node->node_size,
+						       start_index);
+	if (unlikely(lookup_index >= SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE)) {
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
+	cleaning_indexes = SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE - lookup_index;
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
+	struct ssdfs_fs_info *fsi;
+	__le64 *lookup_table;
+	struct ssdfs_raw_extent extent;
+	u64 seg_id;
+	u32 logical_blk;
+	u64 hash;
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
+	fsi = node->tree->fsi;
+
+	if (range_len == 0) {
+		SSDFS_DBG("range_len == 0\n");
+		return 0;
+	}
+
+	lookup_table = node->raw.invextree_header.lookup_table;
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
+			err = ssdfs_invextree_node_get_extent(node,
+								area,
+								item_index,
+								&extent);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to extract extent: "
+					  "item_index %d, err %d\n",
+					  item_index, err);
+				return err;
+			}
+
+			seg_id = le64_to_cpu(extent.seg_id);
+			logical_blk = le32_to_cpu(extent.logical_blk);
+
+			hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+							      logical_blk);
+
+			lookup_table[lookup_index] = hash;
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
+	lookup_table = node->raw.invextree_header.lookup_table;
+	memset(lookup_table, 0xFF,
+		sizeof(__le64) * SSDFS_INVEXTREE_LOOKUP_TABLE_SIZE);
+}
+
+/*
+ * ssdfs_show_extent_items() - show invalidated extent items
+ * @node: pointer on node object
+ * @items_area: items area descriptor
+ */
+static inline
+void ssdfs_show_extent_items(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_items_area *items_area)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_raw_extent extent;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u64 start_hash;
+	u64 end_hash;
+	int i;
+	int err;
+
+	fsi = node->tree->fsi;
+
+	for (i = 0; i < items_area->items_count; i++) {
+		err = ssdfs_invextree_node_get_extent(node,
+						      items_area,
+						      i,
+						      &extent);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get invalidated extent item: "
+				  "err %d\n", err);
+			return;
+		}
+
+		seg_id = le64_to_cpu(extent.seg_id);
+		logical_blk = le32_to_cpu(extent.logical_blk);
+		len = le32_to_cpu(extent.len);
+
+		start_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+							    logical_blk);
+		end_hash = ssdfs_invextree_calculate_hash(fsi, seg_id,
+						    logical_blk + len - 1);
+
+		SSDFS_ERR("index %d, seg_id %llu, logical_blk %u, len %u, "
+			  "start_hash %llxm end_hash %llx\n",
+			  i, seg_id, logical_blk, len,
+			  start_hash, end_hash);
+	}
+}
+
+/*
+ * ssdfs_invextree_node_do_insert_range() - insert range into node
+ * @tree: invalidated extents tree
+ * @node: pointer on node object
+ * @items_area: items area state
+ * @search: search object [in|out]
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
+int ssdfs_invextree_node_do_insert_range(struct ssdfs_invextree_info *tree,
+				struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *items_area,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_invextree_node_header *hdr;
+	struct ssdfs_raw_extent extent;
+	size_t item_size = sizeof(struct ssdfs_raw_extent);
+	u16 item_index;
+	u16 range_len;
+	u32 used_space;
+	u64 seg_id;
+	u32 logical_blk;
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
+	range_len = items_area->items_count - search->result.start_index;
+	extents_count = range_len + search->request.count;
+
+	err = ssdfs_shift_range_right(node, items_area, item_size,
+				      item_index, range_len,
+				      search->request.count);
+	if (unlikely(err)) {
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("fail to shift dentries range: "
+			  "start %u, count %u, err %d\n",
+			  item_index, search->request.count,
+			  err);
+		return err;
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
+		  items_area->items_capacity,
+		  items_area->items_count);
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
+	hdr = &node->raw.invextree_header;
+
+	le32_add_cpu(&hdr->extents_count, search->request.count);
+	atomic64_add(search->request.count, &tree->extents_count);
+
+finish_items_area_correction:
+	up_write(&node->header_lock);
+
+	if (unlikely(err))
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+
+	return err;
+}
-- 
2.34.1

