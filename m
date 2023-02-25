Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40186A2659
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBYBTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBYBRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901CE19F2B
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:23 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bg11so811275oib.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js+J53dyqfDfOu/8vOUaH+zBocY+L2EC1Afpz5MRyYA=;
        b=zpnFc1O0lebfGp36L4zNlJSpE2/mBMcSaDlUMueFT5i0vZYU+RLNbiDr/qT2ZGfb54
         VKDcwTH+BGyBA2AoWjS5G7ILJA8EssaKd8QBArB64hTduRFH7ymFU7IJWrLnLYLi8qwP
         MWdCVTHWDdzp19Ojjww4bUirtCjgK0hFooALoNnmq/MucBdt5xFedp2UwMo7dLaVNR//
         ymQ5FdclNdxNWkyONpv4qkDZyKJ1fPLueQqNiPbtZwz+sy0MIJBRCbETJvaqPKf85QGY
         KEotkR/tRTqJUmZ1ul9EG/2y13TkSRhvtvd1UzfvOPNlqUZshPkUezpQUswZ2mNRKK7t
         vl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js+J53dyqfDfOu/8vOUaH+zBocY+L2EC1Afpz5MRyYA=;
        b=R+AcA+dsobzsIasSUxbCMSON9YlqUDnk9E4nfatWr4wDPLgktUyg6sjfzDwxrr8L13
         tweKFnfZSzMi4Pz94sD6ZGsp4SNB6ODm/iyiQzcY9HsqPM24P7UuzRAJ6HJXHFKatFZ0
         pkZVTYBgnrTsgxEyR+Di2g5fvT0gGC+H5Pt7OwNjmfmYSu+XqDEYXWEu2UIbJIs7C1+B
         yjFII2qk5Ohz8/EtTMDI6KRidjt7PTBZaSUlD96hHzDrvflzg/HMQVgiAmhT1eQ6YMVP
         +L3uQwkz5EnhDQgBwMpY1dqAk2+eMGuwLwNpXXeiUhliBN2R6Y8Iien8uGDvYY19Ijoh
         zp7Q==
X-Gm-Message-State: AO0yUKWQWZw/JA7JSIUJlq/PApLUs129SKFn6k6MyjCm/o9QI0HfOxvx
        Wx2FuS107XVG4Gxf/RM7vvnvY9HZ6tsTvThY
X-Google-Smtp-Source: AK7set8gkKB7w4X8tK78mV+rGrJlFrYadMzA5/pmGiBrp2iz7qG4/fT1mGo4zgqyAbIsrFw7fcSv4g==
X-Received: by 2002:a05:6808:1385:b0:37b:21c8:4f30 with SMTP id c5-20020a056808138500b0037b21c84f30mr848964oiw.22.1677287842230;
        Fri, 24 Feb 2023 17:17:22 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:21 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 51/76] ssdfs: flush b-tree node object
Date:   Fri, 24 Feb 2023 17:09:02 -0800
Message-Id: <20230225010927.813929-52-slava@dubeyko.com>
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

Dirty b-tree implies the presence of one or several dirty
b-tree node. B-tree flush logic detects the dirty b-tree
nodes and request the flush operation for every dirty b-tree
node. B-tree node can include several memory pages (8K, for
example). It means that one b-tree node can be located in
one or several logical blocks. Finally, flush operation means
that b-tree node's flush logic has to issue update request(s)
for all logical blocks that contain the b-tree node content.
Every b-tree node is described by index record (or key) that
includes: (1) node ID, (2) node type, (3) node height,
(4) starting hash value, (5) raw extent. The raw extent
describes the segment ID, logical block ID, and length.
As a result, flush logic needs to add update request into
an update queue of particular PEB for segment ID. Also,
flush logic has to request the log commit operation because
b-tree node has to be stored peristently right now. Flush
thread(s) of particular PEB(s) executes the update requests.
Finally, b-tree flush logic requires to wait the finish of
update operations for all dirty b-tree node(s).

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_node.c | 3048 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 3048 insertions(+)

diff --git a/fs/ssdfs/btree_node.c b/fs/ssdfs/btree_node.c
index 9f09090e5cfd..a826b1c9699d 100644
--- a/fs/ssdfs/btree_node.c
+++ b/fs/ssdfs/btree_node.c
@@ -2174,3 +2174,3051 @@ int ssdfs_btree_init_node(struct ssdfs_btree_node *node,
 
 	return 0;
 }
+
+/*
+ * ssdfs_btree_pre_flush_root_node() - pre-flush the dirty root node
+ * @node: node object
+ *
+ * This method tries to pre-flush the dirty root node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_pre_flush_root_node(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_btree_inline_root_node *root_node;
+	size_t root_node_size = sizeof(struct ssdfs_btree_inline_root_node);
+	int height, tree_height;
+	int type;
+	u32 area_size, calculated_area_size;
+	u32 area_offset;
+	u16 index_count;
+	u16 index_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	root_node = &node->raw.root_node;
+
+	height = atomic_read(&node->height);
+	if (height >= U8_MAX || height <= 0) {
+		SSDFS_ERR("invalid height %d\n", height);
+		return -ERANGE;
+	}
+
+	tree_height = atomic_read(&node->tree->height);
+	if (tree_height >= U8_MAX || tree_height <= 0) {
+		SSDFS_ERR("invalid tree's height %d\n",
+			  tree_height);
+		return -ERANGE;
+	}
+
+	if ((tree_height - 1) != height) {
+		SSDFS_ERR("tree_height %d, root node's height %d\n",
+			  tree_height, height);
+		return -ERANGE;
+	}
+
+	root_node->header.height = (u8)height;
+
+	if (node->node_size != root_node_size) {
+		SSDFS_ERR("corrupted root node size %u\n",
+			  node->node_size);
+		return -ERANGE;
+	}
+
+	calculated_area_size = sizeof(struct ssdfs_btree_index);
+	calculated_area_size *= SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+
+	area_size = node->index_area.area_size;
+	if (area_size != calculated_area_size) {
+		SSDFS_ERR("corrupted index area size %u\n",
+			  area_size);
+		return -ERANGE;
+	}
+
+	type = atomic_read(&node->type);
+	if (type != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  type);
+		return -ERANGE;
+	}
+
+	root_node->header.type = (u8)type;
+
+	area_offset = node->index_area.offset;
+	if (area_offset < sizeof(struct ssdfs_btree_root_node_header) ||
+	    area_offset >= node->node_size) {
+		SSDFS_ERR("corrupted index area offset %u\n",
+			  area_offset);
+		return -ERANGE;
+	}
+
+	if (node->index_area.index_count > node->index_area.index_capacity) {
+		SSDFS_ERR("corrupted index area descriptor: "
+			  "index_count %u, index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+		return -ERANGE;
+	}
+
+	index_count = node->index_area.index_count;
+
+	if (index_count > SSDFS_BTREE_ROOT_NODE_INDEX_COUNT) {
+		SSDFS_ERR("invalid index count %u\n",
+			  index_count);
+		return -ERANGE;
+	}
+
+	root_node->header.items_count = (u8)index_count;
+
+	index_size = node->index_area.index_size;
+
+	if (index_size != sizeof(struct ssdfs_btree_index)) {
+		SSDFS_ERR("invalid index size %u\n", index_size);
+		return -ERANGE;
+	}
+
+	if (((u32)index_count * index_size) > area_size) {
+		SSDFS_ERR("corrupted index area: "
+			  "index_count %u, index_size %u, area_size %u\n",
+			  index_count,
+			  index_size,
+			  area_size);
+		return -ERANGE;
+	}
+
+	root_node->header.upper_node_id =
+		cpu_to_le32(node->tree->upper_node_id);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_pre_flush_header() - pre-flush node's header
+ * @node: node object
+ * @hdr: node's header
+ *
+ * This method tries to pre-flush the node's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_pre_flush_header(struct ssdfs_btree_node *node,
+					struct ssdfs_btree_node_header *hdr)
+{
+	int height;
+	int type;
+	int flags;
+	u32 area_size;
+	u32 area_offset;
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u16 items_capacity;
+	u16 item_size;
+	u8 min_item_size;
+	u16 max_item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !hdr);
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, state %#x\n",
+		  node->node_id, atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	height = atomic_read(&node->height);
+	if (height >= U8_MAX || height < 0) {
+		SSDFS_ERR("invalid height %d\n", height);
+		return -ERANGE;
+	}
+
+	hdr->height = (u8)height;
+
+	if ((1 << ilog2(node->node_size)) != node->node_size) {
+		SSDFS_ERR("corrupted node size %u\n",
+			  node->node_size);
+		return -ERANGE;
+	}
+
+	hdr->log_node_size = (u8)ilog2(node->node_size);
+
+	type = atomic_read(&node->type);
+	if (type <= SSDFS_BTREE_NODE_UNKNOWN_TYPE ||
+	    type >= SSDFS_BTREE_NODE_TYPE_MAX) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  type);
+		return -ERANGE;
+	}
+
+	hdr->type = (u8)type;
+
+	flags = atomic_read(&node->flags);
+	if (flags & ~SSDFS_BTREE_NODE_FLAGS_MASK) {
+		SSDFS_ERR("corrupted set of flags %#x\n",
+			  flags);
+		return -ERANGE;
+	}
+
+	/*
+	 * Flag SSDFS_BTREE_NODE_PRE_ALLOCATED needs to be excluded.
+	 * The pre-allocated node will be created during the flush
+	 * operation. This flag needs only on kernel side.
+	 */
+	flags &= ~SSDFS_BTREE_NODE_PRE_ALLOCATED;
+
+	hdr->flags = cpu_to_le16((u16)flags);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, type %#x, flags %#x\n",
+		  node->node_id, type, flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		switch (atomic_read(&node->type)) {
+		case SSDFS_BTREE_INDEX_NODE:
+			/*
+			 * Initialization code expect the node size.
+			 * As a result, the index area's size is calculated
+			 * by means of subtraction the header size
+			 * from the node size.
+			 */
+			area_size = node->node_size;
+			if ((1 << ilog2(area_size)) != area_size) {
+				SSDFS_ERR("corrupted index area size %u\n",
+					  area_size);
+				return -ERANGE;
+			}
+
+			hdr->log_index_area_size = (u8)ilog2(area_size);
+
+			/*
+			 * Real area size is used for checking
+			 * the rest of fields.
+			 */
+			area_size = node->index_area.area_size;
+			break;
+
+		default:
+			area_size = node->index_area.area_size;
+			if ((1 << ilog2(area_size)) != area_size) {
+				SSDFS_ERR("corrupted index area size %u\n",
+					  area_size);
+				return -ERANGE;
+			}
+
+			hdr->log_index_area_size = (u8)ilog2(area_size);
+			break;
+		}
+
+		area_offset = node->index_area.offset;
+		if (area_offset <= sizeof(struct ssdfs_btree_node_header) ||
+		    area_offset >= node->node_size ||
+		    area_offset >= node->items_area.offset) {
+			SSDFS_ERR("corrupted index area offset %u\n",
+				  area_offset);
+			return -ERANGE;
+		}
+
+		hdr->index_area_offset = cpu_to_le16((u16)area_offset);
+
+		index_count = node->index_area.index_count;
+		index_capacity = node->index_area.index_capacity;
+
+		if (index_count > index_capacity) {
+			SSDFS_ERR("corrupted index area descriptor: "
+				  "index_count %u, index_capacity %u\n",
+				  index_count, index_capacity);
+			return -ERANGE;
+		}
+
+		hdr->index_count = cpu_to_le16(index_count);
+
+		index_size = node->index_area.index_size;
+
+		if (((u32)index_count * index_size) > area_size) {
+			SSDFS_ERR("corrupted index area: "
+				  "index_count %u, index_size %u, "
+				  "area_size %u\n",
+				  index_count, index_size, area_size);
+			return -ERANGE;
+		}
+
+		hdr->index_size = index_size;
+		break;
+
+	default:
+		hdr->log_index_area_size = (u8)ilog2(0);
+		hdr->index_area_offset = cpu_to_le16(U16_MAX);
+		hdr->index_count = cpu_to_le16(0);
+		hdr->index_size = U8_MAX;
+		break;
+	}
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		item_size = node->items_area.item_size;
+		min_item_size = node->items_area.min_item_size;
+		max_item_size = node->items_area.max_item_size;
+		items_capacity = node->items_area.items_capacity;
+		area_size = node->items_area.area_size;
+		break;
+
+	default:
+		item_size = U16_MAX;
+		min_item_size = 0;
+		max_item_size = 0;
+		items_capacity = 0;
+		area_size = 0;
+		break;
+	}
+
+	switch (type) {
+	case SSDFS_BTREE_LEAF_NODE:
+		if (item_size == 0) {
+			SSDFS_ERR("corrupted items area: "
+				  "item_size %u\n",
+				  item_size);
+			return -ERANGE;
+		} else if (min_item_size > item_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "min_item_size %u, "
+				  "item_size %u\n",
+				  min_item_size, item_size);
+			return -ERANGE;
+		} else if (item_size > max_item_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "item_size %u, "
+				  "max_item_size %u\n",
+				  item_size, max_item_size);
+			return -ERANGE;
+		} else if (item_size > area_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "item_size %u, "
+				  "area_size %u\n",
+				  item_size, area_size);
+			return -ERANGE;
+		} else
+			hdr->min_item_size = min_item_size;
+
+		if (max_item_size == 0) {
+			SSDFS_ERR("corrupted items area: "
+				  "max_item_size %u\n",
+				  max_item_size);
+			return -ERANGE;
+		} else if (max_item_size > area_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "max_item_size %u, "
+				  "area_size %u\n",
+				  max_item_size, area_size);
+			return -ERANGE;
+		} else
+			hdr->max_item_size = cpu_to_le16(max_item_size);
+
+		if (items_capacity == 0) {
+			SSDFS_ERR("corrupted items area's state\n");
+			return -ERANGE;
+		} else if (((u32)items_capacity * item_size) > area_size) {
+			SSDFS_ERR("corrupted items area's state: "
+				  "items_capacity %u, item_size %u, "
+				  "area_size %u\n",
+				  items_capacity,
+				  item_size,
+				  area_size);
+			return -ERANGE;
+		} else
+			hdr->items_capacity = cpu_to_le16(items_capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, node_type %#x, "
+			  "start_hash %llx, end_hash %llx\n",
+			  node->node_id,
+			  atomic_read(&node->type),
+			  node->items_area.start_hash,
+			  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		hdr->start_hash = cpu_to_le64(node->items_area.start_hash);
+		hdr->end_hash = cpu_to_le64(node->items_area.end_hash);
+
+		area_offset = node->items_area.offset;
+		area_size = node->items_area.area_size;
+		if ((area_offset + area_size) > node->node_size) {
+			SSDFS_ERR("corrupted items area offset %u\n",
+				  area_offset);
+			return -ERANGE;
+		}
+
+		hdr->item_area_offset = cpu_to_le32(area_offset);
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		if (item_size == 0) {
+			SSDFS_ERR("corrupted items area: "
+				  "item_size %u\n",
+				  item_size);
+			return -ERANGE;
+		} else if (min_item_size > item_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "min_item_size %u, "
+				  "item_size %u\n",
+				  min_item_size, item_size);
+			return -ERANGE;
+		} else if (item_size > max_item_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "item_size %u, "
+				  "max_item_size %u\n",
+				  item_size, max_item_size);
+			return -ERANGE;
+		} else if (item_size > area_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "item_size %u, "
+				  "area_size %u\n",
+				  item_size, area_size);
+			return -ERANGE;
+		} else
+			hdr->min_item_size = min_item_size;
+
+		if (max_item_size == 0) {
+			SSDFS_ERR("corrupted items area: "
+				  "max_item_size %u\n",
+				  max_item_size);
+			return -ERANGE;
+		} else if (max_item_size > area_size) {
+			SSDFS_ERR("corrupted items area: "
+				  "max_item_size %u, "
+				  "area_size %u\n",
+				  max_item_size, area_size);
+			return -ERANGE;
+		} else
+			hdr->max_item_size = cpu_to_le16(max_item_size);
+
+		if (items_capacity == 0) {
+			SSDFS_ERR("corrupted items area's state\n");
+			return -ERANGE;
+		} else if (((u32)items_capacity * min_item_size) > area_size) {
+			SSDFS_ERR("corrupted items area's state: "
+				  "items_capacity %u, min_item_szie %u, "
+				  "area_size %u\n",
+				  items_capacity,
+				  min_item_size,
+				  area_size);
+			return -ERANGE;
+		} else
+			hdr->items_capacity = cpu_to_le16(items_capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, node_type %#x, "
+			  "start_hash %llx, end_hash %llx\n",
+			  node->node_id,
+			  atomic_read(&node->type),
+			  node->items_area.start_hash,
+			  node->items_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		hdr->start_hash = cpu_to_le64(node->items_area.start_hash);
+		hdr->end_hash = cpu_to_le64(node->items_area.end_hash);
+
+		area_offset = node->items_area.offset;
+		area_size = node->items_area.area_size;
+		if ((area_offset + area_size) > node->node_size) {
+			SSDFS_ERR("corrupted items area offset %u\n",
+				  area_offset);
+			return -ERANGE;
+		}
+
+		hdr->item_area_offset = cpu_to_le32(area_offset);
+
+		area_offset = node->index_area.offset;
+		area_size = node->index_area.area_size;
+		if ((area_offset + area_size) > node->node_size) {
+			SSDFS_ERR("corrupted index area offset %u\n",
+				  area_offset);
+			return -ERANGE;
+		} else if ((area_offset + area_size) > node->items_area.offset) {
+			SSDFS_ERR("corrupted index area offset %u\n",
+				  area_offset);
+			return -ERANGE;
+		}
+
+		hdr->index_area_offset = cpu_to_le32(area_offset);
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		if (min_item_size != 0) {
+			SSDFS_ERR("corrupted items area: "
+				  "min_item_size %u\n",
+				  min_item_size);
+			return -ERANGE;
+		} else
+			hdr->min_item_size = min_item_size;
+
+		if (max_item_size != 0) {
+			SSDFS_ERR("corrupted items area: "
+				  "max_item_size %u\n",
+				  max_item_size);
+			return -ERANGE;
+		} else
+			hdr->max_item_size = cpu_to_le16(max_item_size);
+
+		if (items_capacity != 0) {
+			SSDFS_ERR("corrupted items area's state\n");
+			return -ERANGE;
+		} else
+			hdr->items_capacity = cpu_to_le16(items_capacity);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, node_type %#x, "
+			  "start_hash %llx, end_hash %llx\n",
+			  node->node_id,
+			  atomic_read(&node->type),
+			  node->index_area.start_hash,
+			  node->index_area.end_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		hdr->start_hash = cpu_to_le64(node->index_area.start_hash);
+		hdr->end_hash = cpu_to_le64(node->index_area.end_hash);
+
+		area_offset = node->index_area.offset;
+		area_size = node->index_area.area_size;
+		if ((area_offset + area_size) > node->node_size) {
+			SSDFS_ERR("corrupted index area offset %u\n",
+				  area_offset);
+			return -ERANGE;
+		}
+
+		hdr->index_area_offset = cpu_to_le32(area_offset);
+		break;
+
+	default:
+		SSDFS_ERR("invalid node type %#x\n", type);
+		return -ERANGE;
+	}
+
+	hdr->create_cno = cpu_to_le64(node->create_cno);
+	hdr->node_id = cpu_to_le32(node->node_id);
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_pre_flush() - pre-flush the dirty btree node
+ * @node: node object
+ *
+ * This method tries to pre-flush the dirty btree node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_pre_flush(struct ssdfs_btree_node *node)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+
+	SSDFS_DBG("node_id %u, height %u, type %#x, state %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type),
+		  atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_btree_node_dirty(node))
+		return 0;
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		if (!node->tree->btree_ops ||
+		    !node->tree->btree_ops->pre_flush_root_node) {
+			SSDFS_WARN("unable to pre-flush the root node\n");
+			return -EOPNOTSUPP;
+		}
+
+		err = node->tree->btree_ops->pre_flush_root_node(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to pre-flush root node: "
+				  "node_id %u, height %u, err %d\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  err);
+		}
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		if (!node->tree->btree_ops ||
+		    !node->tree->btree_ops->pre_flush_node) {
+			SSDFS_WARN("unable to pre-flush common node\n");
+			return -EOPNOTSUPP;
+		}
+
+		err = node->tree->btree_ops->pre_flush_node(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to pre-flush common node: "
+				  "node_id %u, height %u, err %d\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid node type %#x\n",
+			   atomic_read(&node->type));
+		break;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_flush_root_node() - flush root node
+ * @node: node object
+ * @root_node: pointer on the on-disk root node object
+ */
+void ssdfs_btree_flush_root_node(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_inline_root_node *root_node)
+{
+	size_t node_ids_len = sizeof(__le32) *
+				SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+	size_t indexes_len = sizeof(struct ssdfs_btree_index) *
+				SSDFS_BTREE_ROOT_NODE_INDEX_COUNT;
+	u16 items_count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !root_node);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_write(&node->header_lock);
+
+	items_count = node->index_area.index_count;
+	root_node->header.height = (u8)atomic_read(&node->tree->height);
+	root_node->header.items_count = cpu_to_le16(items_count);
+	root_node->header.flags = (u8)atomic_read(&node->flags);
+	root_node->header.type = (u8)atomic_read(&node->type);
+	ssdfs_memcpy(root_node->header.node_ids, 0, node_ids_len,
+		     node->raw.root_node.header.node_ids, 0, node_ids_len,
+		     node_ids_len);
+	ssdfs_memcpy(root_node->indexes, 0, indexes_len,
+		     node->raw.root_node.indexes, 0, indexes_len,
+		     indexes_len);
+	clear_ssdfs_btree_node_dirty(node);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("left index (node_id %u, hash %llx), "
+		  "right index (node_id %u, hash %llx)\n",
+		  le32_to_cpu(root_node->header.node_ids[0]),
+		  le64_to_cpu(root_node->indexes[0].hash),
+		  le32_to_cpu(root_node->header.node_ids[1]),
+		  le64_to_cpu(root_node->indexes[1].hash));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	up_write(&node->header_lock);
+
+	spin_lock(&node->tree->nodes_lock);
+	root_node->header.upper_node_id =
+		cpu_to_le32(node->tree->upper_node_id);
+	spin_unlock(&node->tree->nodes_lock);
+
+	ssdfs_request_init(&node->flush_req);
+	atomic_set(&node->flush_req.result.state, SSDFS_REQ_FINISHED);
+}
+
+/*
+ * ssdfs_btree_node_copy_header_nolock() - copy btree node's header
+ * @node: node object
+ * @page: memory page to store the metadata [out]
+ * @write_offset: current write offset [out]
+ *
+ * This method tries to save the btree node's header.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_copy_header_nolock(struct ssdfs_btree_node *node,
+					struct page *page,
+					u32 *write_offset)
+{
+	size_t hdr_size;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !page);
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, height %u, type %#x, write_offset %u\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type), *write_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr_size = sizeof(node->raw);
+
+	if (*write_offset >= PAGE_SIZE) {
+		SSDFS_ERR("invalid write_offset %u\n",
+			  *write_offset);
+		return -EINVAL;
+	}
+
+	/* all btrees have the same node's header size */
+	err = ssdfs_memcpy_to_page(page, *write_offset, PAGE_SIZE,
+				   &node->raw, 0, hdr_size,
+				   hdr_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy node's header: "
+			  "write_offset %u, size %zu, err %d\n",
+			  *write_offset, hdr_size, err);
+		return err;
+	}
+
+	*write_offset += hdr_size;
+
+	if (*write_offset >= PAGE_SIZE) {
+		SSDFS_ERR("invalid write_offset %u\n",
+			  *write_offset);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_prepare_flush_request() - prepare node's content for flush
+ * @node: node object
+ *
+ * This method tries to prepare the node's content
+ * for flush operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_btree_node_prepare_flush_request(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	struct ssdfs_state_bitmap *bmap;
+	struct page *page;
+	u64 logical_offset;
+	u32 data_bytes;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	u32 pvec_size;
+	int node_flags;
+	u32 write_offset = 0;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	};
+
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+	pvec_size = node->node_size >> PAGE_SHIFT;
+
+	if (pvec_size == 0 || pvec_size > PAGEVEC_SIZE) {
+		SSDFS_WARN("invalid memory pages count: "
+			   "node_size %u, pvec_size %u\n",
+			   node->node_size, pvec_size);
+		return -ERANGE;
+	}
+
+	if (pagevec_count(&node->content.pvec) != pvec_size) {
+		SSDFS_ERR("invalid pvec_size: "
+			  "pvec_size1 %u != pvec_size2 %u\n",
+			  pagevec_count(&node->content.pvec),
+			  pvec_size);
+		return -ERANGE;
+	}
+
+	ssdfs_request_init(&node->flush_req);
+	ssdfs_get_request(&node->flush_req);
+
+	logical_offset = (u64)node->node_id * node->node_size;
+	data_bytes = node->node_size;
+	ssdfs_request_prepare_logical_extent(node->tree->owner_ino,
+					     (u64)logical_offset,
+					     (u32)data_bytes,
+					     0, 0, &node->flush_req);
+
+	for (i = 0; i < pvec_size; i++) {
+		err = ssdfs_request_add_allocated_page_locked(&node->flush_req);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add page into request: "
+				  "err %d\n",
+				  err);
+			goto fail_prepare_flush_request;
+		}
+
+		page = node->flush_req.result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!page);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		set_page_writeback(page);
+	}
+
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	ssdfs_lock_page(node->content.pvec.pages[0]);
+	ssdfs_btree_node_copy_header_nolock(node,
+					    node->content.pvec.pages[0],
+					    &write_offset);
+	ssdfs_unlock_page(node->content.pvec.pages[0]);
+
+	spin_lock(&node->descriptor_lock);
+	si = node->seg;
+	seg_id = le64_to_cpu(node->extent.seg_id);
+	logical_blk = le32_to_cpu(node->extent.logical_blk);
+	len = le32_to_cpu(node->extent.len);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+	BUG_ON(seg_id != si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_define_segment(seg_id, &node->flush_req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(logical_blk >= U16_MAX);
+	BUG_ON(len >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	ssdfs_request_define_volume_extent((u16)logical_blk, (u16)len,
+					   &node->flush_req);
+
+	for (i = 0; i < pvec_size; i++) {
+		struct page *page;
+
+		ssdfs_lock_page(node->content.pvec.pages[i]);
+
+		page = node->flush_req.result.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("REQUEST: page %p, count %d, "
+			  "flags %#lx, page_index %lu\n",
+			  page, page_ref_count(page),
+			  page->flags, page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = node->content.pvec.pages[i];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("NODE CONTENT: page %p, count %d, "
+			  "flags %#lx, page_index %lu\n",
+			  page, page_ref_count(page),
+			  page->flags, page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		ssdfs_memmove_page(node->flush_req.result.pvec.pages[i],
+				   0, PAGE_SIZE,
+				   node->content.pvec.pages[i],
+				   0, PAGE_SIZE,
+				   PAGE_SIZE);
+
+		ssdfs_unlock_page(node->content.pvec.pages[i]);
+	}
+
+	node_flags = atomic_read(&node->flags);
+
+	if (node_flags & SSDFS_BTREE_NODE_PRE_ALLOCATED) {
+		/* update pre-allocated extent */
+		err = ssdfs_segment_update_pre_alloc_extent_async(si,
+							SSDFS_REQ_ASYNC_NO_FREE,
+							&node->flush_req);
+	} else {
+		/* update extent */
+		err = ssdfs_segment_update_extent_async(si,
+							SSDFS_REQ_ASYNC_NO_FREE,
+							&node->flush_req);
+	}
+
+	if (!err) {
+		down_read(&node->bmap_array.lock);
+		bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+		spin_lock(&bmap->lock);
+		bitmap_clear(bmap->ptr, 0, node->bmap_array.bits_count);
+		spin_unlock(&bmap->lock);
+		up_read(&node->bmap_array.lock);
+		clear_ssdfs_btree_node_dirty(node);
+	}
+
+	up_write(&node->header_lock);
+	up_write(&node->full_lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("update request failed: "
+			  "ino %llu, logical_offset %llu, size %u, err %d\n",
+			  node->flush_req.extent.ino,
+			  node->flush_req.extent.logical_offset,
+			  node->flush_req.extent.data_bytes,
+			  err);
+		return err;
+	}
+
+	return 0;
+
+fail_prepare_flush_request:
+	for (i = 0; i < pagevec_count(&node->flush_req.result.pvec); i++) {
+		page = node->flush_req.result.pvec.pages[i];
+
+		if (!page)
+			continue;
+
+		SetPageError(page);
+		end_page_writeback(page);
+	}
+
+	ssdfs_request_unlock_and_remove_pages(&node->flush_req);
+	ssdfs_put_request(&node->flush_req);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_common_node_flush() - common method of node flushing
+ * @node: node object
+ *
+ * This method tries to flush the node in general way.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_common_node_flush(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct page *page;
+	size_t index_key_size = sizeof(struct ssdfs_btree_index_key);
+	u32 pvec_size;
+	int node_flags;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	};
+
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	pvec_size = node->node_size >> PAGE_SHIFT;
+
+	if (pvec_size == 0 || pvec_size > PAGEVEC_SIZE) {
+		SSDFS_WARN("invalid memory pages count: "
+			   "node_size %u, pvec_size %u\n",
+			   node->node_size, pvec_size);
+		return -ERANGE;
+	}
+
+	if (pagevec_count(&node->content.pvec) != pvec_size) {
+		SSDFS_ERR("invalid pvec_size: "
+			  "pvec_size1 %u != pvec_size2 %u\n",
+			  pagevec_count(&node->content.pvec),
+			  pvec_size);
+		return -ERANGE;
+	}
+
+	node_flags = atomic_read(&node->flags);
+
+	if (can_diff_on_write_metadata_be_used(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u, height %u, type %#x\n",
+			  node->node_id, atomic_read(&node->height),
+			  atomic_read(&node->type));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_btree_node_prepare_diff(node);
+		if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node %u is not ready for diff: "
+				  "ino %llu, logical_offset %llu, size %u\n",
+				  node->node_id,
+				  node->flush_req.extent.ino,
+				  node->flush_req.extent.logical_offset,
+				  node->flush_req.extent.data_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = ssdfs_btree_node_prepare_flush_request(node);
+		}
+	} else {
+		err = ssdfs_btree_node_prepare_flush_request(node);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("update request failed: "
+			  "ino %llu, logical_offset %llu, size %u, err %d\n",
+			  node->flush_req.extent.ino,
+			  node->flush_req.extent.logical_offset,
+			  node->flush_req.extent.data_bytes,
+			  err);
+		goto fail_flush_node;
+	} else if (node_flags & SSDFS_BTREE_NODE_PRE_ALLOCATED) {
+		struct ssdfs_btree_node *parent;
+		struct ssdfs_btree_index_key old_key, new_key;
+		u16 flags;
+
+		spin_lock(&node->descriptor_lock);
+		ssdfs_memcpy(&old_key, 0, index_key_size,
+			     &node->node_index, 0, index_key_size,
+			     index_key_size);
+		spin_unlock(&node->descriptor_lock);
+
+		ssdfs_memcpy(&new_key, 0, index_key_size,
+			     &old_key, 0, index_key_size,
+			     index_key_size);
+
+		flags = le16_to_cpu(old_key.flags);
+		flags &= ~SSDFS_BTREE_INDEX_SHOW_PREALLOCATED_CHILD;
+		new_key.flags = le16_to_cpu(flags);
+
+		spin_lock(&node->descriptor_lock);
+		parent = node->parent_node;
+		spin_unlock(&node->descriptor_lock);
+
+		err = ssdfs_btree_node_change_index(parent,
+						    &old_key,
+						    &new_key);
+		if (!err) {
+			spin_lock(&node->descriptor_lock);
+			ssdfs_memcpy(&node->node_index, 0, index_key_size,
+				     &new_key, 0, index_key_size,
+				     index_key_size);
+			spin_unlock(&node->descriptor_lock);
+
+			atomic_and(~SSDFS_BTREE_NODE_PRE_ALLOCATED,
+				   &node->flags);
+		}
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_start_bit %lu, item_start_bit %lu, "
+		  "bits_count %lu\n",
+		  node->bmap_array.index_start_bit,
+		  node->bmap_array.item_start_bit,
+		  node->bmap_array.bits_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+
+fail_flush_node:
+	for (i = 0; i < pagevec_count(&node->flush_req.result.pvec); i++) {
+		page = node->flush_req.result.pvec.pages[i];
+
+		if (!page)
+			continue;
+
+		SetPageError(page);
+		end_page_writeback(page);
+	}
+
+	ssdfs_request_unlock_and_remove_pages(&node->flush_req);
+	ssdfs_put_request(&node->flush_req);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_flush() - flush the dirty btree node
+ * @node: node object
+ *
+ * This method tries to flush the dirty btree node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_flush(struct ssdfs_btree_node *node)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("node_id %u, height %u, type %#x, state %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type),
+		  atomic_read(&node->state));
+#else
+	SSDFS_DBG("node_id %u, height %u, type %#x, state %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type),
+		  atomic_read(&node->state));
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (!is_ssdfs_btree_node_dirty(node))
+		return 0;
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		if (!node->tree->btree_ops ||
+		    !node->tree->btree_ops->flush_root_node) {
+			SSDFS_WARN("unable to flush the root node\n");
+			return -EOPNOTSUPP;
+		}
+
+		err = node->tree->btree_ops->flush_root_node(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush root node: "
+				  "node_id %u, height %u, err %d\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  err);
+		}
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		if (!node->tree->btree_ops ||
+		    !node->tree->btree_ops->flush_node) {
+			SSDFS_WARN("unable to flush the common node\n");
+			return -EOPNOTSUPP;
+		}
+
+		err = node->tree->btree_ops->flush_node(node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush common node: "
+				  "node_id %u, height %u, err %d\n",
+				  node->node_id,
+				  atomic_read(&node->height),
+				  err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid node type %#x\n",
+			   atomic_read(&node->type));
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_btree_node_object(node);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_commit_log() - request the log commit for the node
+ * @node: node object
+ *
+ * This method tries to request the log commit for the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_commit_log(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	u64 logical_offset;
+	u64 seg_id;
+	u32 logical_blk;
+	u32 len;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	};
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	ssdfs_request_init(&node->flush_req);
+	ssdfs_get_request(&node->flush_req);
+
+	logical_offset = (u64)node->node_id * node->node_size;
+	ssdfs_request_prepare_logical_extent(node->tree->owner_ino,
+					     (u64)logical_offset,
+					     0, 0, 0, &node->flush_req);
+
+	spin_lock(&node->descriptor_lock);
+	si = node->seg;
+	seg_id = le64_to_cpu(node->extent.seg_id);
+	logical_blk = le32_to_cpu(node->extent.logical_blk);
+	len = le32_to_cpu(node->extent.len);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+	BUG_ON(seg_id != si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_define_segment(seg_id, &node->flush_req);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(logical_blk >= U16_MAX);
+	BUG_ON(len >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	ssdfs_request_define_volume_extent((u16)logical_blk, (u16)len,
+					   &node->flush_req);
+
+	err = ssdfs_segment_commit_log_async(si, SSDFS_REQ_ASYNC_NO_FREE,
+					     &node->flush_req);
+	if (unlikely(err)) {
+		SSDFS_ERR("commit log request failed: "
+			  "ino %llu, logical_offset %llu, err %d\n",
+			  node->flush_req.extent.ino,
+			  node->flush_req.extent.logical_offset,
+			  err);
+		ssdfs_put_request(&node->flush_req);
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_deleted_node_commit_log() - request the log commit (deleted node)
+ * @node: node object
+ *
+ * This method tries to request the log commit for the deleted node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_deleted_node_commit_log(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	u64 seg_id;
+	int i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	SSDFS_DBG("node_id %u, height %u, type %#x\n",
+		  node->node_id, atomic_read(&node->height),
+		  atomic_read(&node->type));
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_INDEX_NODE:
+	case SSDFS_BTREE_HYBRID_NODE:
+	case SSDFS_BTREE_LEAF_NODE:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	};
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!is_ssdfs_btree_node_pre_deleted(node)) {
+		SSDFS_ERR("node %u is not pre-deleted\n",
+			  node->node_id);
+		return -ERANGE;
+	}
+
+	fsi = node->tree->fsi;
+
+	spin_lock(&node->descriptor_lock);
+	si = node->seg;
+	seg_id = le64_to_cpu(node->extent.seg_id);
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+	BUG_ON(seg_id != si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < si->pebs_count; i++) {
+		struct ssdfs_segment_request *req;
+		struct ssdfs_peb_container *pebc;
+		struct ssdfs_requests_queue *rq;
+		wait_queue_head_t *wait;
+
+		pebc = &si->peb_array[i];
+
+		req = ssdfs_request_alloc();
+		if (IS_ERR_OR_NULL(req)) {
+			err = (req == NULL ? -ENOMEM : PTR_ERR(req));
+			SSDFS_ERR("fail to allocate segment request: err %d\n",
+				  err);
+			return err;
+		}
+
+		ssdfs_request_init(req);
+		ssdfs_get_request(req);
+
+		ssdfs_request_prepare_internal_data(SSDFS_PEB_UPDATE_REQ,
+						    SSDFS_COMMIT_LOG_NOW,
+						    SSDFS_REQ_ASYNC, req);
+		ssdfs_request_define_segment(si->seg_id, req);
+
+		ssdfs_segment_create_request_cno(si);
+
+		rq = &pebc->update_rq;
+		ssdfs_requests_queue_add_tail_inc(si->fsi, rq, req);
+
+		wait = &si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+		wake_up_all(wait);
+	}
+
+	return 0;
+}
+
+/*
+ * is_ssdfs_btree_node_dirty() - check that btree node is dirty
+ * @node: node object
+ */
+bool is_ssdfs_btree_node_dirty(struct ssdfs_btree_node *node)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->state);
+
+	switch (state) {
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		return true;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+		return false;
+
+	default:
+		SSDFS_WARN("invalid node state %#x\n",
+			   state);
+		/* FALLTHRU */
+	};
+
+	return false;
+}
+
+/*
+ * set_ssdfs_btree_node_dirty() - set btree node in dirty state
+ * @node: node object
+ */
+void set_ssdfs_btree_node_dirty(struct ssdfs_btree_node *node)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->state);
+
+	switch (state) {
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_CREATED:
+		atomic_set(&node->state, SSDFS_BTREE_NODE_DIRTY);
+		spin_lock(&node->tree->nodes_lock);
+		radix_tree_tag_set(&node->tree->nodes, node->node_id,
+				   SSDFS_BTREE_NODE_DIRTY_TAG);
+		spin_unlock(&node->tree->nodes_lock);
+		break;
+
+	default:
+		SSDFS_WARN("invalid node state %#x\n",
+			   state);
+		/* FALLTHRU */
+	};
+}
+
+/*
+ * clear_ssdfs_btree_node_dirty() - clear dirty state of btree node
+ * @node: node object
+ */
+void clear_ssdfs_btree_node_dirty(struct ssdfs_btree_node *node)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->state);
+
+	switch (state) {
+	case SSDFS_BTREE_NODE_DIRTY:
+		atomic_set(&node->state, SSDFS_BTREE_NODE_INITIALIZED);
+		spin_lock(&node->tree->nodes_lock);
+		radix_tree_tag_clear(&node->tree->nodes, node->node_id,
+				     SSDFS_BTREE_NODE_DIRTY_TAG);
+		spin_unlock(&node->tree->nodes_lock);
+		break;
+
+	case SSDFS_BTREE_NODE_CORRUPTED:
+		spin_lock(&node->tree->nodes_lock);
+		radix_tree_tag_clear(&node->tree->nodes, node->node_id,
+				     SSDFS_BTREE_NODE_DIRTY_TAG);
+		spin_unlock(&node->tree->nodes_lock);
+		break;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+		/* do nothing */
+		break;
+
+	default:
+		SSDFS_WARN("invalid node state %#x\n",
+			   state);
+		/* FALLTHRU */
+	};
+}
+
+/*
+ * is_ssdfs_btree_node_pre_deleted() - check that btree node is pre-deleted
+ * @node: node object
+ */
+bool is_ssdfs_btree_node_pre_deleted(struct ssdfs_btree_node *node)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->state);
+
+	switch (state) {
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		return true;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		return false;
+
+	default:
+		SSDFS_WARN("invalid node state %#x\n",
+			   state);
+		/* FALLTHRU */
+	};
+
+	return false;
+}
+
+/*
+ * set_ssdfs_btree_node_pre_deleted() - set btree node in pre-deleted state
+ * @node: node object
+ */
+void set_ssdfs_btree_node_pre_deleted(struct ssdfs_btree_node *node)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->state);
+
+	switch (state) {
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_CREATED:
+		atomic_set(&node->state, SSDFS_BTREE_NODE_PRE_DELETED);
+		spin_lock(&node->tree->nodes_lock);
+		radix_tree_tag_set(&node->tree->nodes, node->node_id,
+				   SSDFS_BTREE_NODE_DIRTY_TAG);
+		spin_unlock(&node->tree->nodes_lock);
+		break;
+
+	default:
+		SSDFS_WARN("invalid node state %#x\n",
+			   state);
+		/* FALLTHRU */
+	};
+}
+
+/*
+ * clear_ssdfs_btree_node_pre_deleted() - clear pre-deleted state of btree node
+ * @node: node object
+ */
+void clear_ssdfs_btree_node_pre_deleted(struct ssdfs_btree_node *node)
+{
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+	BUG_ON(!rwsem_is_locked(&node->tree->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	state = atomic_read(&node->state);
+
+	switch (state) {
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		atomic_set(&node->state, SSDFS_BTREE_NODE_INITIALIZED);
+		spin_lock(&node->tree->nodes_lock);
+		radix_tree_tag_clear(&node->tree->nodes, node->node_id,
+				     SSDFS_BTREE_NODE_DIRTY_TAG);
+		spin_unlock(&node->tree->nodes_lock);
+		break;
+
+	case SSDFS_BTREE_NODE_CORRUPTED:
+		spin_lock(&node->tree->nodes_lock);
+		radix_tree_tag_clear(&node->tree->nodes, node->node_id,
+				     SSDFS_BTREE_NODE_DIRTY_TAG);
+		spin_unlock(&node->tree->nodes_lock);
+		break;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+		/* do nothing */
+		break;
+
+	default:
+		SSDFS_WARN("invalid node state %#x\n",
+			   state);
+		/* FALLTHRU */
+	};
+}
+
+/*
+ * is_ssdfs_btree_node_index_area_exist() - check that node has index area
+ * @node: node object
+ */
+bool is_ssdfs_btree_node_index_area_exist(struct ssdfs_btree_node *node)
+{
+	u16 flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is not initialized\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		return true;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA)
+			return true;
+		else {
+			SSDFS_WARN("index node %u hasn't index area\n",
+				   node->node_id);
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA)
+			return true;
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		/* do nothing */
+		break;
+
+	default:
+		BUG();
+	}
+
+	return false;
+}
+
+/*
+ * is_ssdfs_btree_node_index_area_empty() - check that index area is empty
+ * @node: node object
+ */
+bool is_ssdfs_btree_node_index_area_empty(struct ssdfs_btree_node *node)
+{
+	bool is_empty = false;
+	int state;
+	int flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is not initialized\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+		/* need to check the index area */
+		break;
+
+	case SSDFS_BTREE_INDEX_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+			/*
+			 * need to check the index area
+			 */
+		} else {
+			SSDFS_WARN("index node %u hasn't index area\n",
+				   node->node_id);
+			return false;
+		}
+		break;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_INDEX_AREA) {
+			/*
+			 * need to check the index area
+			 */
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node %u hasn't index area\n",
+				  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return true;
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is leaf node\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return true;
+
+	default:
+		BUG();
+	}
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->index_area.state);
+	if (state != SSDFS_BTREE_NODE_INDEX_AREA_EXIST)
+		err = -ERANGE;
+	else if (node->index_area.index_capacity == 0)
+		err = -ERANGE;
+	else
+		is_empty = node->index_area.index_count == 0;
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_WARN("node %u is corrupted\n", node->node_id);
+		return false;
+	}
+
+	return is_empty;
+}
+
+/*
+ * is_ssdfs_btree_node_items_area_exist() - check that node has items area
+ * @node: node object
+ */
+bool is_ssdfs_btree_node_items_area_exist(struct ssdfs_btree_node *node)
+{
+	u16 flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		return false;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA)
+			return true;
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA)
+			return true;
+		else {
+			SSDFS_WARN("corrupted leaf node %u\n",
+				   node->node_id);
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	return false;
+}
+
+/*
+ * is_ssdfs_btree_node_items_area_empty() - check that items area is empty
+ * @node: node object
+ */
+bool is_ssdfs_btree_node_items_area_empty(struct ssdfs_btree_node *node)
+{
+	bool is_empty = false;
+	int state;
+	int flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_CREATED:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u is under initialization\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return false;
+
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+	case SSDFS_BTREE_NODE_PRE_DELETED:
+		/* expected state */
+		break;
+
+	default:
+		BUG();
+	}
+
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+		return true;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+			/*
+			 * need to check the items area
+			 */
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("node %u hasn't items area\n",
+				  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return true;
+		}
+		break;
+
+	case SSDFS_BTREE_LEAF_NODE:
+		flags = atomic_read(&node->flags);
+		if (flags & SSDFS_BTREE_NODE_HAS_ITEMS_AREA) {
+			/*
+			 * need to check the items area
+			 */
+		} else {
+			SSDFS_WARN("leaf node %u hasn't items area\n",
+				  node->node_id);
+			return false;
+		}
+		break;
+
+	default:
+		BUG();
+	}
+
+	down_read(&node->header_lock);
+	state = atomic_read(&node->items_area.state);
+	if (state != SSDFS_BTREE_NODE_ITEMS_AREA_EXIST)
+		err = -ERANGE;
+	else if (node->items_area.items_capacity == 0)
+		err = -ERANGE;
+	else
+		is_empty = node->items_area.items_count == 0;
+	up_read(&node->header_lock);
+
+	if (unlikely(err)) {
+		SSDFS_WARN("node %u is corrupted\n", node->node_id);
+		return false;
+	}
+
+	return is_empty;
+}
+
+/*
+ * ssdfs_btree_node_shrink_index_area() - shrink the index area
+ * @node: node object
+ * @new_size: the new size of index area in bytes
+ *
+ * This method tries to shrink the index area in size.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE       - internal error.
+ * %-EOPNOTSUPP   - requsted action is not supported.
+ */
+static
+int ssdfs_btree_node_shrink_index_area(struct ssdfs_btree_node *node,
+					u32 new_size)
+{
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u32 area_size;
+	u32 cur_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, new_size %u\n",
+		  node->node_id, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	index_size = node->index_area.index_size;
+	index_count = node->index_area.index_count;
+	index_capacity = node->index_area.index_capacity;
+	area_size = node->index_area.area_size;
+
+	cur_size = (u32)index_size * index_count;
+
+	if (area_size <= new_size) {
+		SSDFS_ERR("cannot grow index area: "
+			  "area_size %u, new_size %u\n",
+			  area_size, new_size);
+		return -EOPNOTSUPP;
+	}
+
+	if (new_size % index_size) {
+		SSDFS_ERR("unaligned new_size: "
+			  "index_size %u, new_size %u\n",
+			  index_size, new_size);
+		return -ERANGE;
+	}
+
+	if (cur_size > area_size) {
+		SSDFS_WARN("invalid cur_size: "
+			   "cur_size %u, area_size %u\n",
+			   cur_size, area_size);
+		return -ERANGE;
+	}
+
+	if (cur_size == area_size || cur_size > new_size) {
+		SSDFS_ERR("unable to shrink index area: "
+			  "cur_size %u, new_size %u, area_size %u\n",
+			  cur_size, new_size, area_size);
+		return -ERANGE;
+	}
+
+	node->index_area.area_size = new_size;
+	node->index_area.index_capacity = new_size / index_size;
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_grow_index_area() - grow the index area
+ * @node: node object
+ * @new_size: the new size of index area in bytes
+ *
+ * This method tries to increase the size of index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE       - internal error.
+ * %-EOPNOTSUPP   - requsted action is not supported.
+ */
+static
+int ssdfs_btree_node_grow_index_area(struct ssdfs_btree_node *node,
+				     u32 new_size)
+{
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u32 area_size;
+	u32 cur_size;
+	unsigned long offset1, offset2;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, new_size %u\n",
+		  node->node_id, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (new_size > node->node_size) {
+		SSDFS_ERR("invalid new size: "
+			  "new_size %u, node_size %u\n",
+			  new_size, node->node_size);
+		return -ERANGE;
+	}
+
+	index_size = node->index_area.index_size;
+	index_count = node->index_area.index_count;
+	index_capacity = node->index_area.index_capacity;
+	area_size = node->index_area.area_size;
+
+	cur_size = (u32)index_size * index_count;
+
+	if (area_size > new_size) {
+		SSDFS_ERR("cannot shrink index area: "
+			  "area_size %u, new_size %u\n",
+			  area_size, new_size);
+		return -EOPNOTSUPP;
+	}
+
+	if (new_size % index_size) {
+		SSDFS_ERR("unaligned new_size: "
+			  "index_size %u, new_size %u\n",
+			  index_size, new_size);
+		return -ERANGE;
+	}
+
+	if (cur_size > area_size) {
+		SSDFS_WARN("invalid cur_size: "
+			   "cur_size %u, area_size %u\n",
+			   cur_size, area_size);
+		return -ERANGE;
+	}
+
+	offset1 = node->items_area.offset;
+	offset2 = node->index_area.offset;
+
+	if (new_size == node->node_size) {
+		node->index_area.index_capacity =
+			(new_size - node->index_area.offset) / index_size;
+	} else if ((offset1 - offset2) != new_size) {
+		SSDFS_ERR("unable to resize the index area: "
+			  "items_area.offset %u, index_area.offset %u, "
+			  "new_size %u\n",
+			  node->items_area.offset,
+			  node->index_area.offset,
+			  new_size);
+		return -ERANGE;
+	} else
+		node->index_area.index_capacity = new_size / index_size;
+
+	down_read(&node->bmap_array.lock);
+	offset1 = node->bmap_array.item_start_bit;
+	offset2 = node->bmap_array.index_start_bit;
+	if ((offset1 - offset2) < node->index_area.index_capacity)
+		err = -ERANGE;
+	up_read(&node->bmap_array.lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("unable to resize the index area: "
+			  "items_start_bit %lu, index_start_bit %lu, "
+			  "new_index_capacity %u\n",
+			  node->bmap_array.item_start_bit,
+			  node->bmap_array.index_start_bit,
+			  new_size / index_size);
+		return -ERANGE;
+	}
+
+	if (new_size == node->node_size)
+		node->index_area.area_size = new_size - node->index_area.offset;
+	else
+		node->index_area.area_size = new_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_area: offset %u, area_size %u, "
+		  "free_space %u, capacity %u; "
+		  "index_area: offset %u, area_size %u, "
+		  "capacity %u\n",
+		  node->items_area.offset,
+		  node->items_area.area_size,
+		  node->items_area.free_space,
+		  node->items_area.items_capacity,
+		  node->index_area.offset,
+		  node->index_area.area_size,
+		  node->index_area.index_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_check_btree_node_after_resize() - check btree node's consistency
+ * @node: node object
+ *
+ * This method tries to check the consistency of btree node
+ * after resize.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE  - btree node is inconsistent.
+ */
+#ifdef CONFIG_SSDFS_DEBUG
+static
+int ssdfs_check_btree_node_after_resize(struct ssdfs_btree_node *node)
+{
+	u32 offset;
+	u32 area_size;
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u16 items_count;
+	u16 items_capacity;
+	u32 average_item_size;
+	unsigned long bits_count;
+	unsigned long index_start_bit, item_start_bit;
+	int err = 0;
+
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	offset = node->index_area.offset;
+	area_size = node->index_area.area_size;
+
+	if ((offset + area_size) == node->node_size) {
+		/*
+		 * Continue logic
+		 */
+	} else if ((offset + area_size) != node->items_area.offset) {
+		SSDFS_ERR("invalid index area: "
+			  "index_area.offset %u, "
+			  "index_area.area_size %u, "
+			  "items_area.offset %u\n",
+			  node->index_area.offset,
+			  node->index_area.area_size,
+			  node->items_area.offset);
+		return -ERANGE;
+	}
+
+	index_size = node->index_area.index_size;
+	index_count = node->index_area.index_count;
+	index_capacity = node->index_area.index_capacity;
+
+	if (index_count > index_capacity) {
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  node->index_area.index_count,
+			  node->index_area.index_capacity);
+		return -ERANGE;
+	}
+
+	if (((u32)index_size * index_capacity) > area_size) {
+		SSDFS_ERR("invalid index area: "
+			  "index_size %u, index_capacity %u, "
+			  "area_size %u\n",
+			  node->index_area.index_size,
+			  node->index_area.index_capacity,
+			  node->index_area.area_size);
+		return -ERANGE;
+	}
+
+	offset = node->items_area.offset;
+	area_size = node->items_area.area_size;
+
+	if (area_size > 0) {
+		if ((offset + area_size) != node->node_size) {
+			SSDFS_ERR("invalid items area: "
+				  "items_area.offset %u, "
+				  "items_area.area_size %u, "
+				  "node_size %u\n",
+				  node->items_area.offset,
+				  node->items_area.area_size,
+				  node->node_size);
+			return -ERANGE;
+		}
+	}
+
+	items_count = node->items_area.items_count;
+	items_capacity = node->items_area.items_capacity;
+
+	if (items_count > items_capacity) {
+		SSDFS_ERR("invalid items area: "
+			  "items_area.items_count %u, "
+			  "items_area.items_capacity %u\n",
+			  node->items_area.items_count,
+			  node->items_area.items_capacity);
+		return -ERANGE;
+	}
+
+	if (items_capacity > 0) {
+		average_item_size = area_size / items_capacity;
+		if (average_item_size < node->items_area.item_size ||
+		    average_item_size > node->items_area.max_item_size) {
+			SSDFS_ERR("invalid items area: "
+				  "average_item_size %u, "
+				  "item_size %u, max_item_size %u\n",
+				  average_item_size,
+				  node->items_area.item_size,
+				  node->items_area.max_item_size);
+			return -ERANGE;
+		}
+	}
+
+	down_read(&node->bmap_array.lock);
+	bits_count = node->bmap_array.bits_count;
+	index_start_bit = node->bmap_array.index_start_bit;
+	item_start_bit = node->bmap_array.item_start_bit;
+	if ((index_capacity + items_capacity + 1) > bits_count)
+		err = -ERANGE;
+	if ((item_start_bit - index_start_bit) < index_capacity)
+		err = -ERANGE;
+	if ((bits_count - item_start_bit) < items_capacity)
+		err = -ERANGE;
+	up_read(&node->bmap_array.lock);
+
+	if (unlikely(err)) {
+		SSDFS_ERR("invalid bmap_array: "
+			  "bits_count %lu, index_start_bit %lu, "
+			  "item_start_bit %lu, index_capacity %u, "
+			  "items_capacity %u\n",
+			  bits_count, index_start_bit,
+			  item_start_bit, index_capacity,
+			  items_capacity);
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+static inline
+void ssdfs_set_node_update_cno(struct ssdfs_btree_node *node)
+{
+	u64 current_cno = ssdfs_current_cno(node->tree->fsi->sb);
+
+	spin_lock(&node->descriptor_lock);
+	node->update_cno = current_cno;
+	spin_unlock(&node->descriptor_lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("current_cno %llu\n", current_cno);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_btree_node_resize_index_area() - resize the node's index area
+ * @node: node object
+ * @new_size: new size of node's index area
+ *
+ * This method tries to resize the index area of btree node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EACCES     - node is under initialization yet.
+ * %-ENOENT     - index area is absent.
+ * %-ENOSPC     - index area cannot be resized.
+ * %-EOPNOTSUPP - resize operation is not supported.
+ */
+int ssdfs_btree_node_resize_index_area(struct ssdfs_btree_node *node,
+					u32 new_size)
+{
+	struct ssdfs_fs_info *fsi;
+	u16 flags;
+	u8 index_size;
+	u16 index_count;
+	u16 index_capacity;
+	u32 area_size;
+	u32 cur_size;
+	u32 new_items_area_size;
+	int err = 0, err2;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	SSDFS_DBG("node_id %u, new_size %u\n",
+		  node->node_id, new_size);
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
+	switch (atomic_read(&node->type)) {
+	case SSDFS_BTREE_ROOT_NODE:
+	case SSDFS_BTREE_INDEX_NODE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("resize operation is unavailable: "
+			   "node_id %u\n",
+			   node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+
+	case SSDFS_BTREE_LEAF_NODE:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index area is absent: "
+			  "node_id %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+
+	case SSDFS_BTREE_HYBRID_NODE:
+		/* expected node type */
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (!is_ssdfs_btree_node_index_area_exist(node)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index area is absent: "
+			  "node_id %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOENT;
+	}
+
+	flags = atomic_read(&node->tree->flags);
+	if (!(flags & SSDFS_BTREE_DESC_INDEX_AREA_RESIZABLE)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to resize the index area: "
+			  "node_id %u\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	if (new_size < node->tree->index_area_min_size ||
+	    new_size > node->node_size) {
+		SSDFS_ERR("invalid new_size %u\n",
+			  new_size);
+		return -ERANGE;
+	}
+
+	if (!node->node_ops || !node->node_ops->resize_items_area) {
+		SSDFS_DBG("unable to resize items area\n");
+		return -EOPNOTSUPP;
+	}
+
+	down_write(&node->full_lock);
+	down_write(&node->header_lock);
+
+	index_size = node->index_area.index_size;
+	index_count = node->index_area.index_count;
+	index_capacity = node->index_area.index_capacity;
+	area_size = node->index_area.area_size;
+
+	if (index_count > index_capacity) {
+		err = -ERANGE;
+		SSDFS_ERR("index_count %u > index_capacity %u\n",
+			  index_count, index_capacity);
+		goto finish_resize_operation;
+	}
+
+	if (new_size % index_size) {
+		err = -ERANGE;
+		SSDFS_ERR("unaligned new_size: "
+			  "new_size %u, index_size %u\n",
+			  new_size, index_size);
+		goto finish_resize_operation;
+	}
+
+	if ((index_size * index_capacity) != area_size) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid index area descriptor: "
+			  "index_size %u, index_capacity %u, "
+			  "area_size %u\n",
+			  index_size, index_capacity, area_size);
+		goto finish_resize_operation;
+	}
+
+	cur_size = (u32)index_size * index_count;
+
+	if (cur_size > area_size) {
+		err = -ERANGE;
+		SSDFS_ERR("cur_size %u > area_size %u\n",
+			  cur_size, area_size);
+		goto finish_resize_operation;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("index_size %u, index_count %u, "
+		  "index_capacity %u, index_area_size %u, "
+		  "cur_size %u, new_size %u\n",
+		  index_size, index_count,
+		  index_capacity, area_size,
+		  cur_size, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (new_size < node->index_area.area_size) {
+		/* shrink index area */
+
+		if (cur_size > new_size) {
+			err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to resize: "
+				  "cur_size %u, new_size %u\n",
+				  cur_size, new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_resize_operation;
+		}
+
+		err = ssdfs_btree_node_shrink_index_area(node, new_size);
+		if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to shrink index area: "
+				  "new_size %u\n",
+				  new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_resize_operation;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to shrink index area: "
+				  "new_size %u, err %d\n",
+				  new_size, err);
+			goto finish_resize_operation;
+		}
+
+		new_items_area_size = node->items_area.area_size;
+		new_items_area_size += area_size - new_size;
+
+		err = node->node_ops->resize_items_area(node,
+							new_items_area_size);
+		if (err) {
+			err2 = ssdfs_btree_node_grow_index_area(node,
+								cur_size);
+			if (err == -EOPNOTSUPP || err == -ENOSPC) {
+				err = err2;
+				SSDFS_ERR("fail to recover node state: "
+					  "err %d\n", err);
+				goto finish_resize_operation;
+			}
+		}
+
+		if (err == -EOPNOTSUPP) {
+			err = -ENOSPC;
+			SSDFS_DBG("resize operation is unavailable\n");
+			goto finish_resize_operation;
+		} else if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to resize items area: "
+				  "new_size %u\n",
+				  new_items_area_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_resize_operation;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to resize items area: "
+				  "new_size %u, err %d\n",
+				  new_items_area_size, err);
+			goto finish_resize_operation;
+		}
+	} else if (new_size > node->index_area.area_size) {
+		/* grow index area */
+
+		if (new_size == node->node_size) {
+			/* eliminate items area */
+			new_items_area_size = 0;
+		} else if ((new_size - area_size) > node->items_area.area_size) {
+			err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to resize items area: "
+				  "new_size %u, index_area_size %u, "
+				  "items_area_size %u\n",
+				  new_size,
+				  node->index_area.area_size,
+				  node->items_area.area_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_resize_operation;
+		} else {
+			new_items_area_size = node->items_area.area_size;
+			new_items_area_size -= new_size - area_size;
+		}
+
+		err = node->node_ops->resize_items_area(node,
+							new_items_area_size);
+		if (err == -EOPNOTSUPP) {
+			err = -ENOSPC;
+			SSDFS_DBG("resize operation is unavailable\n");
+			goto finish_resize_operation;
+		} else if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to resize items area: "
+				  "new_size %u\n",
+				  new_items_area_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_resize_operation;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to resize items area: "
+				  "new_size %u, err %d\n",
+				  new_items_area_size, err);
+			goto finish_resize_operation;
+		}
+
+		err = ssdfs_btree_node_grow_index_area(node, new_size);
+		if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to grow index area: "
+				  "new_size %u\n",
+				  new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_resize_operation;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to grow index area: "
+				  "new_size %u, err %d\n",
+				  new_size, err);
+			goto finish_resize_operation;
+		}
+	} else {
+		err = -EOPNOTSUPP;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("resize is not necessary: "
+			  "old_size %u, new_size %u\n",
+			  node->index_area.area_size,
+			  new_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_resize_operation;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	err = ssdfs_check_btree_node_after_resize(node);
+	if (unlikely(err)) {
+		SSDFS_ERR("node %u is corrupted after resize\n",
+			  node->node_id);
+		goto finish_resize_operation;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_resize_operation:
+	up_write(&node->header_lock);
+	up_write(&node->full_lock);
+
+	if (err == -EOPNOTSUPP)
+		return 0;
+	else if (unlikely(err))
+		return err;
+
+	ssdfs_set_node_update_cno(node);
+	set_ssdfs_btree_node_dirty(node);
+
+	return 0;
+}
+
+/*
+ * ssdfs_set_dirty_index_range() - set index range as dirty
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to mark an index range as dirty.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - area is dirty already.
+ */
+static
+int ssdfs_set_dirty_index_range(struct ssdfs_btree_node *node,
+				u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long found = ULONG_MAX;
+	unsigned long start_area;
+	u16 capacity = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("capacity %u, start_index %u, count %u\n",
+		  capacity, start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+
+	start_area = node->bmap_array.index_start_bit;
+	if (start_area == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_area_start\n");
+		goto finish_set_dirty_index;
+	}
+
+	if (node->bmap_array.item_start_bit == ULONG_MAX)
+		capacity = node->bmap_array.bits_count;
+	else
+		capacity = node->bmap_array.item_start_bit - start_area;
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_set_dirty_index;
+	}
+
+	spin_lock(&bmap->lock);
+
+	found = bitmap_find_next_zero_area(bmap->ptr, capacity,
+					   start_area + start_index,
+					   count, 0);
+	if (found != (start_area + start_index)) {
+		/* area is dirty already */
+		err = -EEXIST;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("set bit: start_area %lu, start_index %u, len %u\n",
+		  start_area, start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bitmap_set(bmap->ptr, start_area + start_index, count);
+
+	spin_unlock(&bmap->lock);
+
+	if (unlikely(err)) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found %lu != start %lu\n",
+			  found, start_area + start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+finish_set_dirty_index:
+	up_read(&node->bmap_array.lock);
+
+	if (!err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u, tree_type %#x, "
+			  "start_index %u, count %u\n",
+			  node->node_id, node->tree->type,
+			  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_clear_dirty_index_range_state() - clear an index range as dirty
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to clear the state of index range as dirty.
+ */
+#ifdef CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC
+static
+void ssdfs_clear_dirty_index_range_state(struct ssdfs_btree_node *node,
+					 u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long start_area;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("start_index %u, count %u\n",
+		  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+
+	start_area = node->bmap_array.index_start_bit;
+	BUG_ON(start_area == ULONG_MAX);
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+	BUG_ON(!bmap->ptr);
+
+	spin_lock(&bmap->lock);
+	bitmap_clear(bmap->ptr, start_area + start_index, count);
+	spin_unlock(&bmap->lock);
+
+	up_read(&node->bmap_array.lock);
+}
+#endif /* CONFIG_SSDFS_UNDER_DEVELOPMENT_FUNC */
+
+/*
+ * __ssdfs_lock_index_range() - lock index range
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to lock index range without semaphore protection.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to lock the index range.
+ */
+static
+int __ssdfs_lock_index_range(struct ssdfs_btree_node *node,
+				u16 start_index, u16 count)
+{
+	DEFINE_WAIT(wait);
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long start_area;
+	unsigned long upper_bound;
+	int i = 0;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->bmap_array.lock));
+
+	SSDFS_DBG("start_index %u, count %u\n",
+		  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_area = node->bmap_array.index_start_bit;
+	if (start_area == ULONG_MAX) {
+		SSDFS_ERR("invalid items_area_start\n");
+		return -ERANGE;
+	}
+
+	upper_bound = start_area + start_index + count;
+	if (upper_bound > node->bmap_array.item_start_bit) {
+		SSDFS_ERR("invalid request: "
+			  "start_area %lu, start_index %u, "
+			  "count %u, item_start_bit %lu\n",
+			  start_area, start_index, count,
+			  node->bmap_array.item_start_bit);
+		return -ERANGE;
+	}
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+	if (!bmap->ptr) {
+		SSDFS_WARN("lock bitmap is empty\n");
+		return -ERANGE;
+	}
+
+try_lock_area:
+	spin_lock(&bmap->lock);
+
+	for (; i < count; i++) {
+		err = bitmap_allocate_region(bmap->ptr,
+					     start_area + start_index + i, 0);
+		if (err)
+			break;
+	}
+
+	if (err == -EBUSY) {
+		err = 0;
+		bitmap_clear(bmap->ptr, start_area + start_index, i);
+		prepare_to_wait(&node->wait_queue, &wait,
+				TASK_UNINTERRUPTIBLE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("waiting unlocked state of item %u\n",
+			   start_index + i);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		spin_unlock(&bmap->lock);
+
+		schedule();
+		finish_wait(&node->wait_queue, &wait);
+		goto try_lock_area;
+	}
+
+	spin_unlock(&bmap->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_lock_index_range() - lock index range
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to lock index range.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to lock the index range.
+ */
+static inline
+int ssdfs_lock_index_range(struct ssdfs_btree_node *node,
+			   u16 start_index, u16 count)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("start_index %u, count %u\n",
+		  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+	err = __ssdfs_lock_index_range(node, start_index, count);
+	up_read(&node->bmap_array.lock);
+
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to lock range: "
+			  "start %u, count %u, err %d\n",
+			  start_index, count, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_lock_whole_index_area() - lock the whole index area
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to lock the whole index area.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to lock the index range.
+ */
+int ssdfs_lock_whole_index_area(struct ssdfs_btree_node *node)
+{
+	unsigned long start, count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+	start = node->bmap_array.index_start_bit;
+	count = node->bmap_array.item_start_bit - start;
+#ifdef CONFIG_SSDFS_DEBUG
+	if (start >= U16_MAX || count >= U16_MAX) {
+		SSDFS_ERR("start %lu, count %lu\n",
+			  start, count);
+	}
+
+	BUG_ON(start >= U16_MAX);
+	BUG_ON(count >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	err = __ssdfs_lock_index_range(node, 0, (u16)count);
+	up_read(&node->bmap_array.lock);
+
+	if (err) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to lock range: "
+			  "start %lu, count %lu, err %d\n",
+			  start, count, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+	return err;
+}
+
+/*
+ * __ssdfs_unlock_index_range() - unlock an index range
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to unlock an index range without node's
+ * semaphore protection.
+ */
+static
+void __ssdfs_unlock_index_range(struct ssdfs_btree_node *node,
+				u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long upper_bound;
+	unsigned long start_area;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->bmap_array.lock));
+
+	SSDFS_DBG("start_index %u, count %u\n",
+		  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+	start_area = node->bmap_array.index_start_bit;
+	upper_bound = start_area + start_index + count;
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap->ptr);
+	BUG_ON(start_area == ULONG_MAX);
+	BUG_ON(upper_bound > node->bmap_array.item_start_bit);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&bmap->lock);
+	bitmap_clear(bmap->ptr, start_area + start_index, count);
+	spin_unlock(&bmap->lock);
+}
+
+/*
+ * ssdfs_unlock_index_range() - unlock an index range
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to unlock an index range.
+ */
+static inline
+void ssdfs_unlock_index_range(struct ssdfs_btree_node *node,
+				u16 start_index, u16 count)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("start_index %u, count %u\n",
+		  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+	__ssdfs_unlock_index_range(node, start_index, count);
+	up_read(&node->bmap_array.lock);
+	wake_up_all(&node->wait_queue);
+}
+
+/*
+ * ssdfs_unlock_whole_index_area() - unlock the whole index area
+ * @node: node object
+ * @start_index: starting index
+ * @count: count of indexes in the range
+ *
+ * This method tries to unlock the whole index area.
+ */
+void ssdfs_unlock_whole_index_area(struct ssdfs_btree_node *node)
+{
+	unsigned long start, count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+	start = node->bmap_array.index_start_bit;
+	count = node->bmap_array.item_start_bit - start;
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(start >= U16_MAX);
+	BUG_ON(count >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+	__ssdfs_unlock_index_range(node, 0, (u16)count);
+	up_read(&node->bmap_array.lock);
+	wake_up_all(&node->wait_queue);
+}
+
+/*
+ * ssdfs_btree_node_get() - increment node's reference counter
+ * @node: pointer on node object
+ */
+void ssdfs_btree_node_get(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	WARN_ON(atomic_inc_return(&node->refs_count) <= 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree_type %#x, node_id %u, refs_count %d\n",
+		  node->tree->type, node->node_id,
+		  atomic_read(&node->refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_btree_node_put() - decrement node's reference counter
+ * @node: pointer on node object
+ */
+void ssdfs_btree_node_put(struct ssdfs_btree_node *node)
+{
+	if (!node)
+		return;
+
+	WARN_ON(atomic_dec_return(&node->refs_count) < 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("tree_type %#x, node_id %u, refs_count %d\n",
+		  node->tree->type, node->node_id,
+		  atomic_read(&node->refs_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * is_ssdfs_node_shared() - check that node is shared between threads
+ * @node: pointer on node object
+ */
+bool is_ssdfs_node_shared(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&node->refs_count) > 1;
+}
-- 
2.34.1

