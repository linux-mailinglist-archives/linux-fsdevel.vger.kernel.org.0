Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290AB6A2661
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBYBTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBYBRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:41 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AACE22DD9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:33 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id e21so830339oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gV0dLF2EK75xk2PFWcxPsanjOEOWuwferiU4ssff4Y=;
        b=sl4LuDOlRi076O4X0SFMTEQjQExbYl9tzNFR70+9aBWYJo4Fqcs0xQEvaK10DH2BNU
         /xAlaAPXoG1LUlsXsPsxwcBPAnWCpcOvQay2Nux8PW+wopRAm9bxOm6KIfAe20yPfcMb
         1Y6WuzQ/8ma2zndVbdjW9Fut02ICtlVnbnK8dml7yWd1T2OMQlvTn5EGY4JFTs4dSFp9
         ZX0OFRip1ZMccTmw3PySQNuaFmHrI+hsqPKBeyuCCuojCGDL/JAusbcQUDn9JbhQplgE
         vhzx72wh0ua48qF59AU3LJOONLjHC5d0zABuez1xJ9wgxufnT/dMo+zsIhnWcnresxkl
         zRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gV0dLF2EK75xk2PFWcxPsanjOEOWuwferiU4ssff4Y=;
        b=vxDo3AGCadr1qn/6y0If8gokzzSQfoDg8pxrBStdApVl8cXOgxE4d+rBAzf6dWRjas
         ZVVrRgWKe4WlZnbJGcg/qZrujjXX0aLN8eduKM+mvUM8kCFhFh/WGYGZMCYLlNyzk2AB
         I5keG0ZGpbyVqhQPx0srOz6Dbo4GK4JsoR+2MsNel34AL3CerOQjBAdlAlu7eb8AmJP7
         YQgbdpMU8rjTRhp9wcbvzrpUsRCkcMezYwvZ5TvQibAykBhd0zCAu36eKv3y3R4Ej9QK
         ue736kWWOKd+ycSkF5L4f3Bn4w4IHRm1Q1OjMmZoAeo8mZP9kvT20KM4G/7bq+Py8pcO
         W/hg==
X-Gm-Message-State: AO0yUKX+09y+aYjmg4y0qYEjE9U3lSxbS40Opn2k0d67rT+a3JONqezJ
        +Z5EgpGE5cRjH5Z6wJQmMWhoReRzrsq7VMMC
X-Google-Smtp-Source: AK7set/tpVNk6kuuKmSqt+bFMyx7ooAsr3bcR620pcWN2ya4KPeR4cdfOiNNfizAL7eLGyv7/exlNQ==
X-Received: by 2002:aca:f19:0:b0:368:a6f6:bfdf with SMTP id 25-20020aca0f19000000b00368a6f6bfdfmr4157513oip.20.1677287851647;
        Fri, 24 Feb 2023 17:17:31 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:30 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 55/76] ssdfs: range operations of b-tree node
Date:   Fri, 24 Feb 2023 17:09:06 -0800
Message-Id: <20230225010927.813929-56-slava@dubeyko.com>
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

Hybrid b-tree node plays very special role in b-tree architecture.
First of all, hybrid node includes index and item areas. The goal is
to combine in one node index and items records for the case of small
b-trees. B-tree starts by creation of root node that can contain only
two index keys. It means that root node keeps knowledge about two
nodes only. At first, b-tree logic creates leaf nodes until the root
node will contain two index keys for leaf nodes. Next step implies
the creation of hybrid node that contains index records for two
existing leaf nodes. The root node contains index key for hybrid node.
Now hybrid node becomes to play. New items will be added into items area
of hybrid node until this area becomes completely full. B-tree logic
allocates new leaf node, all existing items in hybrid node are moved
into newly created leaf node, and index key is added into hybrid node's
index area. Such operation repeat multiple times until index area of
hybrid node becomes completely full. Now index area is resized by
increasing twice in size after moving existing items into newly
created node. Finally, hybrid node will be converted into index node.
Important point that small b-tree has one hybrid node with index keys
and items instead of two nodes (index + leaf). Hybrid node combines
as index as items operations that makes this type of node by "hot"
type of metadata and it provides the way to isolate/distinguish
hot, warm, and cold data. As a result, it provides the way to make
b-tree more compact by decreasing number of nodes, makes GC operations
not neccessary because update operations of "hot" hybrid node(s)
makes migration scheme efficient, and decrease write amplification.

Hybrid nodes require range operations that are represented by:
(1) extract_range - extract range of items (or all items) from node
(2) insert_range - insert range of items into node
(3) delete_range - remove range of items from node

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_node.c | 3007 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 3007 insertions(+)

diff --git a/fs/ssdfs/btree_node.c b/fs/ssdfs/btree_node.c
index 8d939451de05..45a992064154 100644
--- a/fs/ssdfs/btree_node.c
+++ b/fs/ssdfs/btree_node.c
@@ -13919,3 +13919,3010 @@ int ssdfs_calculate_item_offset(struct ssdfs_btree_node *node,
 
 	return 0;
 }
+
+/*
+ * __ssdfs_shift_range_right() - shift the items' range to the right
+ * @node: pointer on node object
+ * @area_offset: area offset in bytes from the node's beginning
+ * @area_size: area size in bytes
+ * @item_size: size of item in bytes
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @shift: number of position in the requested shift
+ *
+ * This method tries to shift the range of items to the right
+ * direction.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_shift_range_right(struct ssdfs_btree_node *node,
+			      u32 area_offset, u32 area_size,
+			      size_t item_size,
+			      u16 start_index, u16 range_len,
+			      u16 shift)
+{
+	int page_index1, page_index2;
+	int src_index, dst_index;
+	struct page *page1, *page2;
+	u32 item_offset1, item_offset2;
+	void *kaddr;
+	u32 moved_items = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, area_offset %u, area_size %u, "
+		  "item_size %zu, start_index %u, "
+		  "range_len %u, shift %u\n",
+		  node->node_id, area_offset, area_size,
+		  item_size, start_index, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	src_index = start_index + range_len - 1;
+	dst_index = src_index + shift;
+
+	if ((dst_index * item_size) > area_size) {
+		SSDFS_ERR("shift is out of area: "
+			  "src_index %d, shift %u, "
+			  "item_size %zu, area_size %u\n",
+			  src_index, shift, item_size, area_size);
+		return -ERANGE;
+	}
+
+	do {
+		u32 offset_diff;
+		u32 index_diff;
+		int moving_items;
+		u32 moving_bytes;
+
+		item_offset2 = (u32)dst_index * item_size;
+		if (item_offset2 >= area_size) {
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset2, area_size);
+			return -ERANGE;
+		}
+
+		item_offset2 += area_offset;
+		if (item_offset2 >= node->node_size) {
+			SSDFS_ERR("item_offset %u >= node_size %u\n",
+				  item_offset2, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index2 = item_offset2 >> PAGE_SHIFT;
+		if (page_index2 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index2,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index2 == 0)
+			offset_diff = item_offset2 - area_offset;
+		else
+			offset_diff = item_offset2 - (page_index2 * PAGE_SIZE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(offset_diff % item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		index_diff = offset_diff / item_size;
+		index_diff++;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(index_diff >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (index_diff < shift) {
+			/*
+			 * The shift moves data out of the node.
+			 * This is the reason that index_diff is
+			 * lesser than shift. Keep the index_diff
+			 * the same.
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index_diff %u, shift %u\n",
+				  index_diff, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (index_diff == shift) {
+			/*
+			 * It's the case when destination page
+			 * has no items at all. Otherwise,
+			 * it is the case of presence of free
+			 * space in the begin of the page is equal
+			 * to the @shift. This space was prepared
+			 * by previous move operation. Simply,
+			 * keep the index_diff the same.
+			 */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("index_diff %u, shift %u\n",
+				  index_diff, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else {
+			/*
+			 * It needs to know the number of items
+			 * from the page's beginning or area's beginning.
+			 * So, excluding the shift from the account.
+			 */
+			index_diff -= shift;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moved_items > range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moving_items = range_len - moved_items;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moving_items < 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moving_items = min_t(int, moving_items, (int)index_diff);
+
+		if (moving_items == 0) {
+			SSDFS_WARN("no items for moving\n");
+			return -ERANGE;
+		}
+
+		moving_bytes = moving_items * item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moving_items >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		src_index -= moving_items - 1;
+		dst_index = src_index + shift;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("moving_items %d, src_index %d, dst_index %d\n",
+			  moving_items, src_index, dst_index);
+
+		BUG_ON(start_index > src_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_calculate_item_offset(node, area_offset, area_size,
+						  src_index, item_size,
+						  &page_index1, &item_offset1);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to calculate item's offset: "
+				  "item_index %d, err %d\n",
+				  src_index, err);
+			return err;
+		}
+
+		err = ssdfs_calculate_item_offset(node, area_offset, area_size,
+						  dst_index, item_size,
+						  &page_index2, &item_offset2);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to calculate item's offset: "
+				  "item_index %d, err %d\n",
+				  dst_index, err);
+			return err;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_offset1 %u, item_offset2 %u\n",
+			  item_offset1, item_offset2);
+
+		if ((item_offset1 + moving_bytes) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "item_offset1 %u, moving_bytes %u\n",
+				   item_offset1, moving_bytes);
+			return -ERANGE;
+		}
+
+		if ((item_offset2 + moving_bytes) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "item_offset2 %u, moving_bytes %u\n",
+				   item_offset2, moving_bytes);
+			return -ERANGE;
+		}
+
+		SSDFS_DBG("pvec_size %u, page_index1 %d, item_offset1 %u, "
+			  "page_index2 %d, item_offset2 %u, "
+			  "moving_bytes %u\n",
+			  pagevec_count(&node->content.pvec),
+			  page_index1, item_offset1,
+			  page_index2, item_offset2,
+			  moving_bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index1 != page_index2) {
+			page1 = node->content.pvec.pages[page_index1];
+			page2 = node->content.pvec.pages[page_index2];
+			ssdfs_lock_page(page1);
+			ssdfs_lock_page(page2);
+			err = ssdfs_memmove_page(page2, item_offset2, PAGE_SIZE,
+						 page1, item_offset1, PAGE_SIZE,
+						 moving_bytes);
+			ssdfs_unlock_page(page1);
+			ssdfs_unlock_page(page2);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		} else {
+			page1 = node->content.pvec.pages[page_index1];
+			ssdfs_lock_page(page1);
+			kaddr = kmap_local_page(page1);
+			err = ssdfs_memmove(kaddr, item_offset2, PAGE_SIZE,
+					    kaddr, item_offset1, PAGE_SIZE,
+					    moving_bytes);
+			flush_dcache_page(page1);
+			kunmap_local(kaddr);
+			ssdfs_unlock_page(page1);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		}
+
+		src_index--;
+		dst_index--;
+		moved_items += moving_items;
+	} while (src_index >= start_index);
+
+	if (moved_items != range_len) {
+		SSDFS_ERR("moved_items %u != range_len %u\n",
+			  moved_items, range_len);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_shift_range_right2() - shift the items' range to the right
+ * @node: pointer on node object
+ * @area: area descriptor
+ * @item_size: size of item in bytes
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @shift: number of position in the requested shift
+ *
+ * This method tries to shift the range of items to the right
+ * direction.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_range_right2(struct ssdfs_btree_node *node,
+			     struct ssdfs_btree_node_index_area *area,
+			     size_t item_size,
+			     u16 start_index, u16 range_len,
+			     u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu, "
+		  "start_index %u, range_len %u, shift %u\n",
+		  node->node_id, item_size,
+		  start_index, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start_index > area->index_count) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, index_count %u\n",
+			  start_index, area->index_count);
+		return -ERANGE;
+	} else if (start_index == area->index_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u == index_count %u\n",
+			  start_index, area->index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if ((start_index + range_len) > area->index_count) {
+		SSDFS_ERR("range is out of existing items: "
+			  "start_index %u, range_len %u, index_count %u\n",
+			  start_index, range_len, area->index_count);
+		return -ERANGE;
+	} else if ((start_index + range_len + shift) > area->index_capacity) {
+		SSDFS_ERR("shift is out of capacity: "
+			  "start_index %u, range_len %u, "
+			  "shift %u, index_capacity %u\n",
+			  start_index, range_len,
+			  shift, area->index_capacity);
+		return -ERANGE;
+	}
+
+	return __ssdfs_shift_range_right(node, area->offset, area->area_size,
+					 item_size, start_index, range_len,
+					 shift);
+}
+
+/*
+ * ssdfs_shift_range_right() - shift the items' range to the right
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_size: size of item in bytes
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @shift: number of position in the requested shift
+ *
+ * This method tries to shift the range of items to the right
+ * direction.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_range_right(struct ssdfs_btree_node *node,
+			    struct ssdfs_btree_node_items_area *area,
+			    size_t item_size,
+			    u16 start_index, u16 range_len,
+			    u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu, "
+		  "start_index %u, range_len %u, shift %u\n",
+		  node->node_id, item_size,
+		  start_index, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start_index > area->items_count) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, items_count %u\n",
+			  start_index, area->items_count);
+		return -ERANGE;
+	} else if (start_index == area->items_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u == items_count %u\n",
+			  start_index, area->items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if ((start_index + range_len) > area->items_count) {
+		SSDFS_ERR("range is out of existing items: "
+			  "start_index %u, range_len %u, items_count %u\n",
+			  start_index, range_len, area->items_count);
+		return -ERANGE;
+	} else if ((start_index + range_len + shift) > area->items_capacity) {
+		SSDFS_ERR("shift is out of capacity: "
+			  "start_index %u, range_len %u, "
+			  "shift %u, items_capacity %u\n",
+			  start_index, range_len,
+			  shift, area->items_capacity);
+		return -ERANGE;
+	}
+
+	return __ssdfs_shift_range_right(node, area->offset, area->area_size,
+					 item_size, start_index, range_len,
+					 shift);
+}
+
+/*
+ * __ssdfs_shift_range_left() - shift the items' range to the left
+ * @node: pointer on node object
+ * @area_offset: area offset in bytes from the node's beginning
+ * @area_size: area size in bytes
+ * @item_size: size of item in bytes
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @shift: number of position in the requested shift
+ *
+ * This method tries to shift the range of items to the left
+ * direction.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_shift_range_left(struct ssdfs_btree_node *node,
+			     u32 area_offset, u32 area_size,
+			     size_t item_size,
+			     u16 start_index, u16 range_len,
+			     u16 shift)
+{
+	int page_index1, page_index2;
+	int src_index, dst_index;
+	struct page *page1, *page2;
+	u32 item_offset1, item_offset2;
+	void *kaddr;
+	u16 moved_items = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, area_offset %u, area_size %u, "
+		  "item_size %zu, start_index %u, "
+		  "range_len %u, shift %u\n",
+		  node->node_id, area_offset, area_size,
+		  item_size, start_index, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	src_index = start_index;
+	dst_index = start_index - shift;
+
+	do {
+		u32 range_len1, range_len2;
+		u32 moving_items;
+		u32 moving_bytes;
+
+		if (moved_items >= range_len) {
+			SSDFS_ERR("moved_items %u >= range_len %u\n",
+			      moved_items, range_len);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("src_index %d, dst_index %d\n",
+			  src_index, dst_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		item_offset1 = (u32)src_index * item_size;
+		if (item_offset1 >= area_size) {
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset1, area_size);
+			return -ERANGE;
+		}
+
+		item_offset1 += area_offset;
+		if (item_offset1 >= node->node_size) {
+			SSDFS_ERR("item_offset %u >= node_size %u\n",
+				  item_offset1, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index1 = item_offset1 >> PAGE_SHIFT;
+		if (page_index1 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index1,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index1 > 0)
+			item_offset1 %= page_index1 * PAGE_SIZE;
+
+		item_offset2 = (u32)dst_index * item_size;
+		if (item_offset2 >= area_size) {
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset2, area_size);
+			return -ERANGE;
+		}
+
+		item_offset2 += area_offset;
+		if (item_offset2 >= node->node_size) {
+			SSDFS_ERR("item_offset %u >= node_size %u\n",
+				  item_offset2, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index2 = item_offset2 >> PAGE_SHIFT;
+		if (page_index2 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index2,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index2 > 0)
+			item_offset2 %= page_index2 * PAGE_SIZE;
+
+		range_len1 = (PAGE_SIZE - item_offset1) / item_size;
+		range_len2 = (PAGE_SIZE - item_offset2) / item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(range_len1 == 0);
+		BUG_ON(range_len2 == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moving_items = min_t(u32, range_len1, range_len2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moved_items > range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moving_items = min_t(u32, moving_items,
+				     (u32)range_len - moved_items);
+
+		if (moving_items == 0) {
+			SSDFS_WARN("no items for moving\n");
+			return -ERANGE;
+		}
+
+		moving_bytes = moving_items * item_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page_index1 %d, item_offset1 %u, "
+			  "page_index2 %d, item_offset2 %u\n",
+			  page_index1, item_offset1,
+			  page_index2, item_offset2);
+
+		if ((item_offset1 + moving_bytes) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "item_offset1 %u, moving_bytes %u\n",
+				   item_offset1, moving_bytes);
+			return -ERANGE;
+		}
+
+		if ((item_offset2 + moving_bytes) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "item_offset2 %u, moving_bytes %u\n",
+				   item_offset2, moving_bytes);
+			return -ERANGE;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index1 != page_index2) {
+			page1 = node->content.pvec.pages[page_index1];
+			page2 = node->content.pvec.pages[page_index2];
+			err = ssdfs_memmove_page(page2, item_offset2, PAGE_SIZE,
+						 page1, item_offset1, PAGE_SIZE,
+						moving_bytes);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		} else {
+			page1 = node->content.pvec.pages[page_index1];
+			kaddr = kmap_local_page(page1);
+			err = ssdfs_memmove(kaddr, item_offset2, PAGE_SIZE,
+					    kaddr, item_offset1, PAGE_SIZE,
+					    moving_bytes);
+			flush_dcache_page(page1);
+			kunmap_local(kaddr);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		}
+
+		src_index += moving_items;
+		dst_index += moving_items;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("moving_items %u, src_index %d, dst_index %d\n",
+			  moving_items, src_index, dst_index);
+
+		BUG_ON(moving_items >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moved_items += moving_items;
+	} while (moved_items < range_len);
+
+	return 0;
+}
+
+/*
+ * ssdfs_shift_range_left2() - shift the items' range to the left
+ * @node: pointer on node object
+ * @area: area descriptor
+ * @item_size: size of item in bytes
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @shift: number of position in the requested shift
+ *
+ * This method tries to shift the range of items to the left
+ * direction.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_range_left2(struct ssdfs_btree_node *node,
+			    struct ssdfs_btree_node_index_area *area,
+			    size_t item_size,
+			    u16 start_index, u16 range_len,
+			    u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu, "
+		  "start_index %u, range_len %u, shift %u\n",
+		  node->node_id, item_size,
+		  start_index, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start_index > area->index_count) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, index_count %u\n",
+			  start_index, area->index_count);
+		return -ERANGE;
+	} else if (start_index == area->index_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u == index_count %u\n",
+			  start_index, area->index_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	} else if ((start_index + range_len) > area->index_count) {
+		SSDFS_ERR("range is out of existing items: "
+			  "start_index %u, range_len %u, index_count %u\n",
+			  start_index, range_len, area->index_count);
+		return -ERANGE;
+	} else if (shift > start_index) {
+		SSDFS_ERR("shift is out of node: "
+			  "start_index %u, shift %u\n",
+			  start_index, shift);
+		return -ERANGE;
+	}
+
+	return __ssdfs_shift_range_left(node, area->offset, area->area_size,
+					item_size, start_index, range_len,
+					shift);
+}
+
+/*
+ * ssdfs_shift_range_left() - shift the items' range to the left
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_size: size of item in bytes
+ * @start_index: starting index of the range
+ * @range_len: number of items in the range
+ * @shift: number of position in the requested shift
+ *
+ * This method tries to shift the range of items to the left
+ * direction.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_range_left(struct ssdfs_btree_node *node,
+			   struct ssdfs_btree_node_items_area *area,
+			   size_t item_size,
+			   u16 start_index, u16 range_len,
+			   u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu, "
+		  "start_index %u, range_len %u, shift %u\n",
+		  node->node_id, item_size,
+		  start_index, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (start_index >= area->items_capacity) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, items_capacity %u\n",
+			  start_index, area->items_capacity);
+		return -ERANGE;
+	} else if ((start_index + range_len) > area->items_capacity) {
+		SSDFS_ERR("range is out of capacity: "
+			  "start_index %u, range_len %u, items_capacity %u\n",
+			  start_index, range_len, area->items_capacity);
+		return -ERANGE;
+	} else if (shift > start_index) {
+		SSDFS_ERR("shift is out of node: "
+			  "start_index %u, shift %u\n",
+			  start_index, shift);
+		return -ERANGE;
+	}
+
+	return __ssdfs_shift_range_left(node, area->offset, area->area_size,
+					item_size, start_index, range_len,
+					shift);
+}
+
+/*
+ * __ssdfs_shift_memory_range_right() - shift the memory range to the right
+ * @node: pointer on node object
+ * @area_offset: area offset in bytes from the node's beginning
+ * @area_size: area size in bytes
+ * @offset: offset from the area's beginning to the range start
+ * @range_len: length of the range in bytes
+ * @shift: value of the shift in bytes
+ *
+ * This method tries to move the memory range (@offset; @range_len)
+ * in the @node for the @shift in bytes to the right.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_shift_memory_range_right(struct ssdfs_btree_node *node,
+				     u32 area_offset, u32 area_size,
+				     u16 offset, u16 range_len,
+				     u16 shift)
+{
+	int page_index1, page_index2;
+	int src_offset, dst_offset;
+	struct page *page1, *page2;
+	u32 range_offset1, range_offset2;
+	void *kaddr;
+	u32 cur_range;
+	u32 moved_range = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, area_offset %u, area_size %u, "
+		  "offset %u, range_len %u, shift %u\n",
+		  node->node_id, area_offset, area_size,
+		  offset, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (((u32)offset + range_len + shift) > (area_offset + area_size)) {
+		SSDFS_ERR("invalid request: "
+			  "offset %u, range_len %u, shift %u, "
+			  "area_offset %u, area_size %u\n",
+			  offset, range_len, shift,
+			  area_offset, area_size);
+		return -ERANGE;
+	}
+
+	src_offset = offset + range_len;
+	dst_offset = src_offset + shift;
+
+	do {
+		u32 offset_diff;
+		u32 moving_range;
+
+		range_offset1 = src_offset;
+		if (range_offset1 > area_size) {
+			SSDFS_ERR("range_offset1 %u > area_size %u\n",
+				  range_offset1, area_size);
+			return -ERANGE;
+		}
+
+		range_offset1 += area_offset;
+		if (range_offset1 > node->node_size) {
+			SSDFS_ERR("range_offset1 %u > node_size %u\n",
+				  range_offset1, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index1 = (range_offset1 - 1) >> PAGE_SHIFT;
+		if (page_index1 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index1,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (range_len <= moved_range) {
+			SSDFS_ERR("range_len %u <= moved_range %u\n",
+				  range_len, moved_range);
+			return -ERANGE;
+		}
+
+		cur_range = range_len - moved_range;
+		offset_diff = range_offset1 - (page_index1 * PAGE_SIZE);
+
+		moving_range = min_t(u32, cur_range, offset_diff);
+		range_offset1 -= moving_range;
+
+		if (page_index1 > 0)
+			range_offset1 %= page_index1 * PAGE_SIZE;
+
+		if ((range_offset1 + moving_range + shift) > PAGE_SIZE) {
+			range_offset1 += moving_range - shift;
+			moving_range = shift;
+		}
+
+		range_offset2 = range_offset1 + shift;
+
+		if (range_offset2 > area_size) {
+			SSDFS_ERR("range_offset2 %u > area_size %u\n",
+				  range_offset2, area_size);
+			return -ERANGE;
+		}
+
+		page_index2 = range_offset2 >> PAGE_SHIFT;
+		if (page_index2 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index2,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index2 > 0)
+			range_offset2 %= page_index2 * PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		if ((range_offset1 + moving_range) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "range_offset1 %u, moving_range %u\n",
+				   range_offset1, moving_range);
+			return -ERANGE;
+		}
+
+		if ((range_offset2 + moving_range) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "range_offset2 %u, moving_range %u\n",
+				   range_offset2, moving_range);
+			return -ERANGE;
+		}
+
+		SSDFS_DBG("page_index1 %d, page_index2 %d, "
+			  "range_offset1 %u, range_offset2 %u\n",
+			  page_index1, page_index2,
+			  range_offset1, range_offset2);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index1 != page_index2) {
+			page1 = node->content.pvec.pages[page_index1];
+			page2 = node->content.pvec.pages[page_index2];
+			err = ssdfs_memmove_page(page2,
+						 range_offset2, PAGE_SIZE,
+						 page1,
+						 range_offset1, PAGE_SIZE,
+						 moving_range);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		} else {
+			page1 = node->content.pvec.pages[page_index1];
+			kaddr = kmap_local_page(page1);
+			err = ssdfs_memmove(kaddr, range_offset2, PAGE_SIZE,
+					    kaddr, range_offset1, PAGE_SIZE,
+					    moving_range);
+			flush_dcache_page(page1);
+			kunmap_local(kaddr);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		}
+
+		src_offset -= moving_range;
+		dst_offset -= moving_range;
+
+		if (src_offset < 0 || dst_offset < 0) {
+			SSDFS_ERR("src_offset %d, dst_offset %d\n",
+				  src_offset, dst_offset);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moving_range >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moved_range += moving_range;
+	} while (src_offset > offset);
+
+	if (moved_range != range_len) {
+		SSDFS_ERR("moved_range %u != range_len %u\n",
+			  moved_range, range_len);
+		return -ERANGE;
+	}
+
+	if (src_offset != offset) {
+		SSDFS_ERR("src_offset %d != offset %u\n",
+			  src_offset, offset);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_shift_memory_range_right() - shift the memory range to the right
+ * @node: pointer on node object
+ * @area: pointer on the area descriptor
+ * @offset: offset from the area's beginning to the range start
+ * @range_len: length of the range in bytes
+ * @shift: value of the shift in bytes
+ *
+ * This method tries to move the memory range (@offset; @range_len)
+ * in the @node for the @shift in bytes to the right.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_memory_range_right(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_items_area *area,
+				   u16 offset, u16 range_len,
+				   u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, offset %u, range_len %u, shift %u\n",
+		  node->node_id, offset, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_shift_memory_range_right(node,
+						area->offset, area->area_size,
+						offset, range_len,
+						shift);
+}
+
+/*
+ * ssdfs_shift_memory_range_right2() - shift the memory range to the right
+ * @node: pointer on node object
+ * @area: pointer on the area descriptor
+ * @offset: offset from the area's beginning to the range start
+ * @range_len: length of the range in bytes
+ * @shift: value of the shift in bytes
+ *
+ * This method tries to move the memory range (@offset; @range_len)
+ * in the @node for the @shift in bytes to the right.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_memory_range_right2(struct ssdfs_btree_node *node,
+				    struct ssdfs_btree_node_index_area *area,
+				    u16 offset, u16 range_len,
+				    u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, offset %u, range_len %u, shift %u\n",
+		  node->node_id, offset, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_shift_memory_range_right(node,
+						area->offset, area->area_size,
+						offset, range_len,
+						shift);
+}
+
+/*
+ * __ssdfs_shift_memory_range_left() - shift the memory range to the left
+ * @node: pointer on node object
+ * @area_offset: offset area from the node's beginning
+ * @area_size: size of area in bytes
+ * @offset: offset from the area's beginning to the range start
+ * @range_len: length of the range in bytes
+ * @shift: value of the shift in bytes
+ *
+ * This method tries to move the memory range (@offset; @range_len)
+ * in the @node for the @shift in bytes to the left.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_shift_memory_range_left(struct ssdfs_btree_node *node,
+				    u32 area_offset, u32 area_size,
+				    u16 offset, u16 range_len,
+				    u16 shift)
+{
+	int page_index1, page_index2;
+	int src_offset, dst_offset;
+	struct page *page1, *page2;
+	u32 range_offset1, range_offset2;
+	void *kaddr;
+	u32 range_len1, range_len2;
+	u32 moved_range = 0;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, area_offset %u, area_size %u, "
+		  "offset %u, range_len %u, shift %u\n",
+		  node->node_id, area_offset, area_size,
+		  offset, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((offset + range_len) >= (area_offset + area_size)) {
+		SSDFS_ERR("invalid request: "
+			  "offset %u, range_len %u, "
+			  "area_offset %u, area_size %u\n",
+			  offset, range_len,
+			  area_offset, area_size);
+		return -ERANGE;
+	} else if (shift > offset) {
+		SSDFS_ERR("shift is out of area: "
+			  "offset %u, shift %u\n",
+			  offset, shift);
+		return -ERANGE;
+	}
+
+	src_offset = offset;
+	dst_offset = offset - shift;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("src_offset %u, dst_offset %u\n",
+		  src_offset, dst_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	do {
+		u32 moving_range;
+
+		range_offset1 = src_offset;
+		if (range_offset1 > area_size) {
+			SSDFS_ERR("range_offset1 %u > area_size %u\n",
+				  range_offset1, area_size);
+			return -ERANGE;
+		}
+
+		range_offset1 += area_offset;
+		if (range_offset1 > node->node_size) {
+			SSDFS_ERR("range_offset1 %u > node_size %u\n",
+				  range_offset1, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index1 = range_offset1 >> PAGE_SHIFT;
+		if (page_index1 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index1,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index1 > 0)
+			range_offset1 %= page_index1 * PAGE_SIZE;
+
+		range_offset2 = dst_offset;
+		if (range_offset2 >= area_size) {
+			SSDFS_ERR("range_offset2 %u >= area_size %u\n",
+				  range_offset2, area_size);
+			return -ERANGE;
+		}
+
+		range_offset2 += area_offset;
+		if (range_offset2 >= node->node_size) {
+			SSDFS_ERR("range_offset2 %u >= node_size %u\n",
+				  range_offset2, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index2 = range_offset2 >> PAGE_SHIFT;
+		if (page_index2 >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index2,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index2 > 0)
+			range_offset2 %= page_index2 * PAGE_SIZE;
+
+		range_len1 = PAGE_SIZE - range_offset1;
+		range_len2 = PAGE_SIZE - range_offset2;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(range_len1 == 0);
+		BUG_ON(range_len2 == 0);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moving_range = min_t(u32, range_len1, range_len2);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moved_range > range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moving_range = min_t(u32, moving_range,
+				     (u32)range_len - moved_range);
+
+		if (moving_range == 0) {
+			SSDFS_WARN("no items for moving\n");
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		if ((range_offset1 + moving_range) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "range_offset1 %u, moving_range %u\n",
+				   range_offset1, moving_range);
+			return -ERANGE;
+		}
+
+		if ((range_offset2 + moving_range) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "range_offset2 %u, moving_range %u\n",
+				   range_offset2, moving_range);
+			return -ERANGE;
+		}
+
+		SSDFS_DBG("page_index1 %d, page_index2 %d, "
+			  "range_offset1 %u, range_offset2 %u\n",
+			  page_index1, page_index2,
+			  range_offset1, range_offset2);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (page_index1 != page_index2) {
+			page1 = node->content.pvec.pages[page_index1];
+			page2 = node->content.pvec.pages[page_index2];
+			err = ssdfs_memmove_page(page2,
+						 range_offset2, PAGE_SIZE,
+						 page1,
+						 range_offset1, PAGE_SIZE,
+						 moving_range);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		} else {
+			page1 = node->content.pvec.pages[page_index1];
+			kaddr = kmap_local_page(page1);
+			err = ssdfs_memmove(kaddr, range_offset2, PAGE_SIZE,
+					    kaddr, range_offset1, PAGE_SIZE,
+					    moving_range);
+			flush_dcache_page(page1);
+			kunmap_local(kaddr);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+		}
+
+		src_offset += moving_range;
+		dst_offset += moving_range;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(moving_range >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		moved_range += moving_range;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("src_offset %u, dst_offset %u, "
+			  "moving_range %u, moved_range %u\n",
+			  src_offset, dst_offset,
+			  moving_range, moved_range);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} while (moved_range < range_len);
+
+	if (moved_range != range_len) {
+		SSDFS_ERR("moved_range %u != range_len %u\n",
+			  moved_range, range_len);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_shift_memory_range_left() - shift the memory range to the left
+ * @node: pointer on node object
+ * @area: pointer on the area descriptor
+ * @offset: offset from the area's beginning to the range start
+ * @range_len: length of the range in bytes
+ * @shift: value of the shift in bytes
+ *
+ * This method tries to move the memory range (@offset; @range_len)
+ * in the @node for the @shift in bytes to the left.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_memory_range_left(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_items_area *area,
+				   u16 offset, u16 range_len,
+				   u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, offset %u, range_len %u, shift %u\n",
+		  node->node_id, offset, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_shift_memory_range_left(node,
+						area->offset, area->area_size,
+						offset, range_len, shift);
+}
+
+/*
+ * ssdfs_shift_memory_range_left2() - shift the memory range to the left
+ * @node: pointer on node object
+ * @area: pointer on the area descriptor
+ * @offset: offset from the area's beginning to the range start
+ * @range_len: length of the range in bytes
+ * @shift: value of the shift in bytes
+ *
+ * This method tries to move the memory range (@offset; @range_len)
+ * in the @node for the @shift in bytes to the left.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_shift_memory_range_left2(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_index_area *area,
+				   u16 offset, u16 range_len,
+				   u16 shift)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, offset %u, range_len %u, shift %u\n",
+		  node->node_id, offset, range_len, shift);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_shift_memory_range_left(node,
+						area->offset, area->area_size,
+						offset, range_len, shift);
+}
+
+/*
+ * ssdfs_generic_insert_range() - insert range of items into the node
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_size: size of item in bytes
+ * @search: search object
+ *
+ * This method tries to insert the range of items into the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_generic_insert_range(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				size_t item_size,
+				struct ssdfs_btree_search *search)
+{
+	int page_index;
+	int src_index, dst_index;
+	struct page *page;
+	u32 item_offset1, item_offset2;
+	u16 copied_items = 0;
+	u16 start_index;
+	unsigned int range_len;
+	u32 items;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu\n",
+		  node->node_id, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	if (!search->result.buf) {
+		SSDFS_ERR("buffer pointer is NULL\n");
+		return -ERANGE;
+	}
+
+	items = search->result.items_in_buffer;
+	if (search->result.buf_size != (items * item_size)) {
+		SSDFS_ERR("buf_size %zu, items_in_buffer %u, "
+			  "item_size %zu\n",
+			  search->result.buf_size,
+			  items, item_size);
+		return -ERANGE;
+	}
+
+	start_index = search->result.start_index;
+	range_len = search->result.count;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items %u, start_index %u, range_len %u\n",
+		  items, start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range_len == 0) {
+		SSDFS_WARN("search->request.count == 0\n");
+		return -ERANGE;
+	}
+
+	if (start_index > area->items_count) {
+		SSDFS_ERR("invalid request: "
+			  "start_index %u, items_count %u\n",
+			  start_index, area->items_count);
+		return -ERANGE;
+	} else if ((start_index + range_len) > area->items_capacity) {
+		SSDFS_ERR("range is out of capacity: "
+			  "start_index %u, range_len %u, items_capacity %u\n",
+			  start_index, range_len, area->items_capacity);
+		return -ERANGE;
+	}
+
+	src_index = start_index;
+	dst_index = 0;
+
+	do {
+		u32 copying_items;
+		u32 copying_bytes;
+		u32 vacant_positions;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u, src_index %d, dst_index %d\n",
+			  start_index, src_index, dst_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		item_offset1 = (u32)src_index * item_size;
+		if (item_offset1 >= area->area_size) {
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset1, area->area_size);
+			return -ERANGE;
+		}
+
+		item_offset1 += area->offset;
+		if (item_offset1 >= node->node_size) {
+			SSDFS_ERR("item_offset %u >= node_size %u\n",
+				  item_offset1, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index = item_offset1 >> PAGE_SHIFT;
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index > 0)
+			item_offset1 %= page_index * PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(start_index > src_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		copying_items = src_index - start_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(copying_items > range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		copying_items = range_len - copying_items;
+
+		if (copying_items == 0) {
+			SSDFS_WARN("no items for moving\n");
+			return -ERANGE;
+		}
+
+		vacant_positions = PAGE_SIZE - item_offset1;
+		vacant_positions /= item_size;
+
+		if (vacant_positions == 0) {
+			SSDFS_WARN("invalid vacant_positions %u\n",
+				   vacant_positions);
+			return -ERANGE;
+		}
+
+		copying_items = min_t(u32, copying_items, vacant_positions);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(copying_items >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		copying_bytes = copying_items * item_size;
+
+		item_offset2 = (u32)dst_index * item_size;
+		if (item_offset2 >= search->result.buf_size) {
+			SSDFS_ERR("item_offset %u >= buf_size %zu\n",
+				  item_offset2, search->result.buf_size);
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("copying_items %u, item_offset1 %u, "
+			  "item_offset2 %u\n",
+			  copying_items, item_offset1, item_offset2);
+
+		if ((item_offset1 + copying_bytes) > PAGE_SIZE) {
+			SSDFS_WARN("invalid offset: "
+				   "item_offset1 %u, copying_bytes %u\n",
+				   item_offset1, copying_bytes);
+			return -ERANGE;
+		}
+
+		if ((item_offset2 + copying_bytes) > search->result.buf_size) {
+			SSDFS_WARN("invalid offset: "
+				   "item_offset2 %u, copying_bytes %u, "
+				   "result.buf_size %zu\n",
+				   item_offset2, copying_bytes,
+				   search->result.buf_size);
+			return -ERANGE;
+		}
+
+		SSDFS_DBG("page_index %d, pvec_size %u, "
+			  "item_offset1 %u, item_offset2 %u, "
+			  "copying_bytes %u, result.buf_size %zu\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec),
+			  item_offset1, item_offset2,
+			  copying_bytes,
+			  search->result.buf_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = node->content.pvec.pages[page_index];
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("page %p, count %d, "
+			  "flags %#lx, page_index %d\n",
+			  page, page_ref_count(page),
+			  page->flags, page_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = ssdfs_memcpy_to_page(page,
+					   item_offset1,
+					   PAGE_SIZE,
+					   search->result.buf,
+					   item_offset2,
+					   search->result.buf_size,
+					  copying_bytes);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to move: err %d\n", err);
+			return err;
+		}
+
+		src_index += copying_items;
+		dst_index += copying_items;
+		copied_items += copying_items;
+	} while (copied_items < range_len);
+
+	if (copied_items != range_len) {
+		SSDFS_ERR("copied_items %u != range_len %u\n",
+			  copied_items, range_len);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_invalidate_root_node_hierarchy() - invalidate the whole hierarchy
+ * @node: pointer on node object
+ *
+ * This method tries to add the whole hierarchy of forks into
+ * pre-invalid queue of the shared extents tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_invalidate_root_node_hierarchy(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree *tree;
+	struct ssdfs_btree_index_key indexes[SSDFS_BTREE_ROOT_NODE_INDEX_COUNT];
+	struct ssdfs_shared_extents_tree *shextree;
+	u16 index_count;
+	int index_type = SSDFS_EXTENT_INFO_UNKNOWN_TYPE;
+	u16 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi);
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
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
+	case SSDFS_XATTR_BTREE:
+		index_type = SSDFS_EXTENT_INFO_XATTR_INDEX_DESCRIPTOR;
+		break;
+
+	case SSDFS_SHARED_DICTIONARY_BTREE:
+		index_type = SSDFS_EXTENT_INFO_SHDICT_INDEX_DESCRIPTOR;
+		break;
+
+	default:
+		SSDFS_ERR("unsupported tree type %#x\n",
+			  tree->type);
+		return -ERANGE;
+	}
+
+	if (atomic_read(&node->type) != SSDFS_BTREE_ROOT_NODE) {
+		SSDFS_ERR("invalid node type %#x\n",
+			  atomic_read(&node->type));
+		return -ERANGE;
+	}
+
+	fsi = tree->fsi;
+	shextree = fsi->shextree;
+
+	if (!shextree) {
+		SSDFS_ERR("shared extents tree is absent\n");
+		return -ERANGE;
+	}
+
+	down_write(&node->full_lock);
+
+	for (i = 0; i < SSDFS_BTREE_ROOT_NODE_INDEX_COUNT; i++) {
+		err = __ssdfs_btree_root_node_extract_index(node, i,
+							    &indexes[i]);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to extract the index: "
+				  "index_id %u, err %d\n",
+				  i, err);
+			goto finish_invalidate_root_node_hierarchy;
+		}
+	}
+
+	down_write(&node->header_lock);
+
+	index_count = node->index_area.index_count;
+
+	if (index_count == 0) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid index_count %u\n",
+			  index_count);
+		goto finish_process_root_node;
+	}
+
+	for (i = 0; i < index_count; i++) {
+		if (le64_to_cpu(indexes[i].index.hash) >= U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("index %u has invalid hash\n", i);
+			goto finish_process_root_node;
+		}
+
+		err = ssdfs_btree_root_node_delete_index(node, i);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to delete index: "
+				  "index_id %u, err %d\n",
+				  i, err);
+			goto finish_process_root_node;
+		}
+
+		err = ssdfs_shextree_add_pre_invalid_index(shextree,
+							   tree->owner_ino,
+							   index_type,
+							   &indexes[i]);
+		if (unlikely(err)) {
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("fail to pre-invalid index: "
+				  "index_id %u, err %d\n",
+				  i, err);
+			goto finish_process_root_node;
+		}
+	}
+
+finish_process_root_node:
+	up_write(&node->header_lock);
+
+finish_invalidate_root_node_hierarchy:
+	up_write(&node->full_lock);
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_node_extract_range() - extract range of items from node
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
+int __ssdfs_btree_node_extract_range(struct ssdfs_btree_node *node,
+				     u16 start_index, u16 count,
+				     size_t item_size,
+				     struct ssdfs_btree_search *search)
+{
+	DEFINE_WAIT(wait);
+	struct ssdfs_btree *tree;
+	struct ssdfs_btree_node_items_area items_area;
+	struct ssdfs_state_bitmap *bmap;
+	struct page *page;
+	size_t desc_size = sizeof(struct ssdfs_btree_node_items_area);
+	size_t buf_size;
+	u32 item_offset;
+	int page_index;
+	u32 calculated;
+	unsigned long cur_index;
+	u16 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_index %u, count %u, "
+		  "state %d, node_id %u, height %d\n",
+		  search->request.type, search->request.flags,
+		  start_index, count,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	tree = node->tree;
+	search->result.start_index = U16_MAX;
+	search->result.count = 0;
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
+	ssdfs_memcpy(&items_area, 0, desc_size,
+		     &node->items_area, 0, desc_size,
+		     desc_size);
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
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("node_id %u, items_capacity %u, items_count %u\n",
+		  search->node.id,
+		  items_area.items_capacity,
+		  items_area.items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (count == 0) {
+		SSDFS_ERR("empty request\n");
+		return -ERANGE;
+	}
+
+	if (start_index >= items_area.items_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u >= items_count %u\n",
+			  start_index, items_area.items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	if ((start_index + count) > items_area.items_count)
+		count = items_area.items_count - start_index;
+
+	buf_size = count * item_size;
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+		if (count == 1) {
+			switch (tree->type) {
+			case SSDFS_INODES_BTREE:
+				search->result.buf = &search->raw.inode;
+				break;
+
+			case SSDFS_EXTENTS_BTREE:
+				search->result.buf = &search->raw.fork;
+				break;
+
+			case SSDFS_DENTRIES_BTREE:
+				search->result.buf = &search->raw.dentry;
+				break;
+
+			case SSDFS_XATTR_BTREE:
+				search->result.buf = &search->raw.xattr;
+				break;
+
+			default:
+				SSDFS_ERR("unsupported tree type %#x\n",
+					  tree->type);
+				return -ERANGE;
+			}
+
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf_size = buf_size;
+			search->result.items_in_buffer = 0;
+		} else {
+			err = ssdfs_btree_search_alloc_result_buf(search,
+								  buf_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate buffer\n");
+				return err;
+			}
+		}
+		break;
+
+	case SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER:
+		if (count == 1) {
+			ssdfs_btree_search_free_result_buf(search);
+
+			switch (tree->type) {
+			case SSDFS_INODES_BTREE:
+				search->result.buf = &search->raw.inode;
+				break;
+
+			case SSDFS_EXTENTS_BTREE:
+				search->result.buf = &search->raw.fork;
+				break;
+
+			case SSDFS_DENTRIES_BTREE:
+				search->result.buf = &search->raw.dentry;
+				break;
+
+			case SSDFS_XATTR_BTREE:
+				search->result.buf = &search->raw.xattr;
+				break;
+
+			default:
+				SSDFS_ERR("unsupported tree type %#x\n",
+					  tree->type);
+				return -ERANGE;
+			}
+
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+			search->result.buf_size = buf_size;
+			search->result.items_in_buffer = 0;
+		} else {
+			search->result.buf = krealloc(search->result.buf,
+						      buf_size, GFP_KERNEL);
+			if (!search->result.buf) {
+				SSDFS_ERR("fail to allocate buffer\n");
+				return -ENOMEM;
+			}
+			search->result.buf_state =
+					SSDFS_BTREE_SEARCH_EXTERNAL_BUFFER;
+			search->result.buf_size = buf_size;
+			search->result.items_in_buffer = 0;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+
+	for (i = start_index; i < (start_index + count); i++) {
+		item_offset = (u32)i * item_size;
+		if (item_offset >= items_area.area_size) {
+			err = -ERANGE;
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset, items_area.area_size);
+			goto finish_extract_range;
+		}
+
+		item_offset += items_area.offset;
+		if (item_offset >= node->node_size) {
+			err = -ERANGE;
+			SSDFS_ERR("item_offset %u >= node_size %u\n",
+				  item_offset, node->node_size);
+			goto finish_extract_range;
+		}
+
+		page_index = item_offset >> PAGE_SHIFT;
+
+		if (page_index > 0)
+			item_offset %= page_index * PAGE_SIZE;
+
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			goto finish_extract_range;
+		}
+
+		calculated = search->result.items_in_buffer * item_size;
+		if (calculated >= search->result.buf_size) {
+			err = -ERANGE;
+			SSDFS_ERR("calculated %u >= buf_size %zu\n",
+				  calculated, search->result.buf_size);
+			goto finish_extract_range;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		page = node->content.pvec.pages[page_index];
+
+		down_read(&node->bmap_array.lock);
+
+try_lock_item:
+		spin_lock(&bmap->lock);
+
+		cur_index = node->bmap_array.item_start_bit + i;
+		err = bitmap_allocate_region(bmap->ptr,
+					     (unsigned int)cur_index, 0);
+		if (err == -EBUSY) {
+			err = 0;
+			prepare_to_wait(&node->wait_queue, &wait,
+					TASK_UNINTERRUPTIBLE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("waiting unlocked state of item %lu\n",
+				  cur_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			spin_unlock(&bmap->lock);
+
+			schedule();
+			finish_wait(&node->wait_queue, &wait);
+			goto try_lock_item;
+		}
+
+		spin_unlock(&bmap->lock);
+
+		up_read(&node->bmap_array.lock);
+
+		if (err) {
+			SSDFS_ERR("fail to lock: index %lu, err %d\n",
+				  cur_index, err);
+			goto finish_extract_range;
+		}
+
+		err = ssdfs_memcpy_from_page(search->result.buf,
+					     calculated,
+					     search->result.buf_size,
+					     page,
+					     item_offset,
+					     PAGE_SIZE,
+					     item_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to copy: err %d\n",
+				  err);
+		} else {
+			search->result.items_in_buffer++;
+			search->result.count++;
+			search->result.state = SSDFS_BTREE_SEARCH_VALID_ITEM;
+		}
+
+		down_read(&node->bmap_array.lock);
+		spin_lock(&bmap->lock);
+		bitmap_clear(bmap->ptr, (unsigned int)cur_index, 1);
+		spin_unlock(&bmap->lock);
+		up_read(&node->bmap_array.lock);
+
+		wake_up_all(&node->wait_queue);
+
+		if (unlikely(err))
+			goto finish_extract_range;
+	}
+
+finish_extract_range:
+	if (err == -ENODATA) {
+		/*
+		 * do nothing
+		 */
+	} else if (unlikely(err)) {
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	} else
+		search->result.start_index = start_index;
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_node_resize_items_area() - resize items area of the node
+ * @node: node object
+ * @item_size: size of the item in bytes
+ * @index_size: size of the index in bytes
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
+int __ssdfs_btree_node_resize_items_area(struct ssdfs_btree_node *node,
+					 size_t item_size,
+					 size_t index_size,
+					 u32 new_size)
+{
+	size_t hdr_size = sizeof(struct ssdfs_extents_btree_node_header);
+	bool index_area_exist = false;
+	bool items_area_exist = false;
+	u32 indexes_offset, items_offset;
+	u32 indexes_size, items_size;
+	u32 indexes_free_space, items_free_space;
+	u32 space_capacity, used_space = 0;
+	u16 capacity, count;
+	u32 diff_size;
+	u16 start_index, range_len;
+	u32 shift;
+	unsigned long index_start_bit;
+	unsigned long item_start_bit;
+	unsigned long bits_count;
+	u16 index_capacity;
+	u16 items_capacity;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+	BUG_ON(!rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu, new_size %u\n",
+		  node->node_id, item_size, new_size);
+
+	ssdfs_debug_btree_node_object(node);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&node->state)) {
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_CORRUPTED:
+		SSDFS_WARN("node %u is corrupted\n",
+			   node->node_id);
+		return -EFAULT;
+
+	default:
+		SSDFS_ERR("invalid node state %#x\n",
+			  atomic_read(&node->state));
+		return -ERANGE;
+	}
+
+	down_write(&node->bmap_array.lock);
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		index_area_exist = true;
+
+		indexes_offset = node->index_area.offset;
+		indexes_size = node->index_area.area_size;
+
+		if (indexes_offset != hdr_size) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("corrupted index area: "
+				  "offset %u, hdr_size %zu\n",
+				  node->index_area.offset,
+				  hdr_size);
+			goto finish_area_resize;
+		}
+
+		if ((indexes_offset + indexes_size) > node->node_size) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("corrupted index area: "
+				  "area_offset %u, area_size %u, "
+				  "node_size %u\n",
+				  node->index_area.offset,
+				  node->index_area.area_size,
+				  node->node_size);
+			goto finish_area_resize;
+		}
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		index_area_exist = false;
+		indexes_offset = 0;
+		indexes_size = 0;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid area state %#x\n",
+			  atomic_read(&node->index_area.state));
+		goto finish_area_resize;
+	}
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_area_exist = true;
+
+		items_offset = node->items_area.offset;
+		items_size = node->items_area.area_size;
+
+		if ((hdr_size + indexes_size) > items_offset) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("corrupted items area: "
+				  "hdr_size %zu, index area_size %u, "
+				  "offset %u\n",
+				  hdr_size,
+				  node->index_area.area_size,
+				  node->items_area.offset);
+			goto finish_area_resize;
+		}
+
+		if ((items_offset + items_size) > node->node_size) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("corrupted items area: "
+				  "area_offset %u, area_size %u, "
+				  "node_size %u\n",
+				  node->items_area.offset,
+				  node->items_area.area_size,
+				  node->node_size);
+			goto finish_area_resize;
+		}
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		items_area_exist = false;
+		items_offset = 0;
+		items_size = 0;
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid area state %#x\n",
+			  atomic_read(&node->items_area.state));
+		goto finish_area_resize;
+	}
+
+	if ((hdr_size + indexes_size + items_size) > node->node_size) {
+		err = -EFAULT;
+		atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("corrupted node: "
+			  "hdr_size %zu, index area_size %u, "
+			  "items area_size %u, node_size %u\n",
+			  hdr_size,
+			  node->index_area.area_size,
+			  node->items_area.area_size,
+			  node->node_size);
+		goto finish_area_resize;
+	}
+
+	if (index_area_exist) {
+		space_capacity = node->index_area.index_size;
+		space_capacity *= node->index_area.index_capacity;
+
+		if (space_capacity != indexes_size) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("space_capacity %u != indexes_size %u\n",
+				  space_capacity, indexes_size);
+			goto finish_area_resize;
+		}
+
+		used_space = node->index_area.index_size;
+		used_space *= node->index_area.index_count;
+
+		if (used_space > space_capacity) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("used_space %u > space_capacity %u\n",
+				  used_space, space_capacity);
+			goto finish_area_resize;
+		}
+
+		indexes_free_space = space_capacity - used_space;
+	} else
+		indexes_free_space = 0;
+
+	if (items_area_exist) {
+		space_capacity = item_size;
+		space_capacity *= node->items_area.items_capacity;
+
+		if (space_capacity != items_size) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("space_capacity %u != items_size %u\n",
+				  space_capacity, items_size);
+			goto finish_area_resize;
+		}
+
+		used_space = item_size;
+		used_space *= node->items_area.items_count;
+
+		if (used_space > space_capacity) {
+			err = -EFAULT;
+			atomic_set(&node->state, SSDFS_BTREE_NODE_CORRUPTED);
+			SSDFS_ERR("used_space %u > space_capacity %u\n",
+				  used_space, space_capacity);
+			goto finish_area_resize;
+		}
+
+		items_free_space = space_capacity - used_space;
+	} else
+		items_free_space = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("indexes_offset %u, indexes_size %u, "
+		  "items_offset %u, items_size %u, "
+		  "indexes_free_space %u, items_free_space %u\n",
+		  indexes_offset, indexes_size,
+		  items_offset, items_size,
+		  indexes_free_space, items_free_space);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (new_size > items_size) {
+		/* increase items area */
+		u32 unused_space;
+
+		if ((hdr_size + indexes_size) > items_offset) {
+			err = -EFAULT;
+			SSDFS_ERR("corrupted node: "
+				  "hdr_size %zu, indexes_size %u, "
+				  "items_offset %u\n",
+				  hdr_size, indexes_size, items_offset);
+			goto finish_area_resize;
+		}
+
+		unused_space = items_offset - (hdr_size + indexes_size);
+		diff_size = new_size - items_size;
+
+		if ((indexes_free_space + unused_space) < diff_size) {
+			err = -EFAULT;
+			SSDFS_ERR("corrupted_node: "
+				  "indexes_free_space %u, unused_space %u, "
+				  "diff_size %u\n",
+				  indexes_free_space,
+				  unused_space,
+				  diff_size);
+			goto finish_area_resize;
+		}
+
+		shift = diff_size / item_size;
+
+		if (shift == 0 || shift >= U16_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid shift %u\n", shift);
+			goto finish_area_resize;
+		}
+
+		start_index = (u16)shift;
+		range_len = node->items_area.items_count;
+
+		if (unused_space >= diff_size) {
+			/*
+			 * Do nothing.
+			 * It doesn't need to correct index area.
+			 */
+		} else if (indexes_free_space >= diff_size) {
+			node->index_area.area_size -= diff_size;
+			node->index_area.index_capacity =
+				node->index_area.area_size /
+					node->index_area.index_size;
+
+			if (node->index_area.area_size == 0) {
+				node->index_area.offset = U32_MAX;
+				node->index_area.start_hash = U64_MAX;
+				node->index_area.end_hash = U64_MAX;
+				atomic_set(&node->index_area.state,
+					   SSDFS_BTREE_NODE_AREA_ABSENT);
+			}
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("node is corrupted: "
+				  "indexes_free_space %u, "
+				  "unused_space %u\n",
+				  indexes_free_space,
+				  unused_space);
+			goto finish_area_resize;
+		}
+
+		switch (atomic_read(&node->items_area.state)) {
+		case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+			node->items_area.offset -= diff_size;
+			node->items_area.area_size += diff_size;
+			node->items_area.free_space += diff_size;
+			node->items_area.items_capacity =
+				node->items_area.area_size / item_size;
+
+			if (node->items_area.items_capacity == 0) {
+				err = -ERANGE;
+				atomic_set(&node->state,
+					   SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("invalid items_capacity %u\n",
+					  node->items_area.items_capacity);
+				goto finish_area_resize;
+			}
+			break;
+
+		case SSDFS_BTREE_NODE_AREA_ABSENT:
+			node->items_area.offset = node->index_area.offset;
+			node->items_area.offset += node->index_area.area_size;
+			node->items_area.area_size = new_size;
+			node->items_area.free_space = new_size;
+			node->items_area.item_size = item_size;
+			if (item_size >= U8_MAX)
+				node->items_area.min_item_size = 0;
+			else
+				node->items_area.min_item_size = item_size;
+			node->items_area.max_item_size = item_size;
+			node->items_area.items_count = 0;
+			node->items_area.items_capacity =
+				node->items_area.area_size / item_size;
+
+			if (node->items_area.items_capacity == 0) {
+				err = -ERANGE;
+				atomic_set(&node->state,
+					   SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("invalid items_capacity %u\n",
+					  node->items_area.items_capacity);
+				goto finish_area_resize;
+			}
+
+			node->items_area.start_hash = U64_MAX;
+			node->items_area.end_hash = U64_MAX;
+
+			atomic_set(&node->items_area.state,
+				   SSDFS_BTREE_NODE_ITEMS_AREA_EXIST);
+			break;
+
+		default:
+			BUG();
+		}
+
+		if (range_len > 0) {
+			err = ssdfs_shift_range_left(node, &node->items_area,
+						     item_size,
+						     start_index, range_len,
+						     (u16)shift);
+			if (unlikely(err)) {
+				atomic_set(&node->state,
+						SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("fail to shift range to left: "
+					  "start_index %u, range_len %u, "
+					  "shift %u, err %d\n",
+					  start_index, range_len,
+					  shift, err);
+				goto finish_area_resize;
+			}
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("items shift is not necessary: "
+				  "range_len %u\n",
+				  range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+
+		/*
+		 * It makes sense to allocate the bitmap with taking into
+		 * account that we will resize the node. So, it needs
+		 * to allocate the index area in bitmap is equal to
+		 * the whole node and items area is equal to the whole node.
+		 * This technique provides opportunity not to resize or
+		 * to shift the content of the bitmap.
+		 */
+	} else if (new_size < items_size) {
+		/* decrease items area */
+		diff_size = items_size - new_size;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("items_size %u, used_space %u, "
+			  "node->items_area.items_count %u\n",
+			  items_size, used_space,
+			  node->items_area.items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (items_free_space < diff_size) {
+			err = -EFAULT;
+			SSDFS_ERR("items_free_space %u < diff_size %u\n",
+				  items_free_space, diff_size);
+			goto finish_area_resize;
+		}
+
+		shift = diff_size / item_size;
+
+		if (shift == 0 || shift >= U16_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid shift %u\n", shift);
+			goto finish_area_resize;
+		}
+
+		if (node->items_area.items_count > 0) {
+			start_index = 0;
+			range_len = node->items_area.items_count;
+
+			err = ssdfs_shift_range_right(node, &node->items_area,
+						      item_size,
+						      start_index, range_len,
+						      (u16)shift);
+			if (unlikely(err)) {
+				atomic_set(&node->state,
+					   SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("fail to shift range to left: "
+					  "start_index %u, range_len %u, "
+					  "shift %u, err %d\n",
+					  start_index, range_len,
+					  shift, err);
+				goto finish_area_resize;
+			}
+		}
+
+		if (node->items_area.area_size < diff_size)
+			BUG();
+		else if (node->items_area.area_size == diff_size) {
+			node->items_area.offset = U32_MAX;
+			node->items_area.area_size = 0;
+			node->items_area.free_space = 0;
+			node->items_area.items_count = 0;
+			node->items_area.items_capacity = 0;
+			node->items_area.start_hash = U64_MAX;
+			node->items_area.end_hash = U64_MAX;
+			atomic_set(&node->items_area.state,
+				   SSDFS_BTREE_NODE_AREA_ABSENT);
+		} else {
+			node->items_area.offset += diff_size;
+			node->items_area.area_size -= diff_size;
+			node->items_area.free_space -= diff_size;
+			node->items_area.items_capacity =
+				node->items_area.area_size / item_size;
+
+			capacity = node->items_area.items_capacity;
+			count = node->items_area.items_count;
+			if (capacity < count) {
+				err = -ERANGE;
+				atomic_set(&node->state,
+					   SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("capacity %u < count %u\n",
+					  capacity, count);
+				goto finish_area_resize;
+			}
+		}
+
+		switch (atomic_read(&node->index_area.state)) {
+		case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+			node->index_area.area_size += diff_size;
+			node->index_area.index_capacity =
+				node->index_area.area_size /
+					node->index_area.index_size;
+
+			capacity = node->index_area.index_capacity;
+			count = node->index_area.index_count;
+			if (capacity < count) {
+				err = -ERANGE;
+				atomic_set(&node->state,
+					   SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("capacity %u < count %u\n",
+					  capacity, count);
+				goto finish_area_resize;
+			}
+			break;
+
+		case SSDFS_BTREE_NODE_AREA_ABSENT:
+			node->index_area.offset = hdr_size;
+			node->index_area.area_size = diff_size;
+			node->index_area.index_size = index_size;
+			node->index_area.index_count = 0;
+			node->index_area.index_capacity =
+				node->index_area.area_size /
+					node->index_area.index_size;
+
+			if (node->index_area.index_capacity == 0) {
+				err = -ERANGE;
+				atomic_set(&node->state,
+					   SSDFS_BTREE_NODE_CORRUPTED);
+				SSDFS_ERR("capacity == 0\n");
+				goto finish_area_resize;
+			}
+
+			node->index_area.start_hash = U64_MAX;
+			node->index_area.end_hash = U64_MAX;
+
+			atomic_set(&node->items_area.state,
+				   SSDFS_BTREE_NODE_INDEX_AREA_EXIST);
+			break;
+
+		default:
+			BUG();
+		}
+
+		/*
+		 * It makes sense to allocate the bitmap with taking into
+		 * account that we will resize the node. So, it needs
+		 * to allocate the index area in bitmap is equal to
+		 * the whole node and items area is equal to the whole node.
+		 * This technique provides opportunity not to resize or
+		 * to shift the content of the bitmap.
+		 */
+	} else {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("no necessity to resize: "
+			  "new_size %u, items_size %u\n",
+			  new_size, items_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_area_resize;
+	}
+
+	node->bmap_array.item_start_bit =
+			node->bmap_array.index_start_bit +
+			node->index_area.index_capacity;
+
+	index_capacity = node->index_area.index_capacity;
+	items_capacity = node->items_area.items_capacity;
+	index_start_bit = node->bmap_array.index_start_bit;
+	item_start_bit = node->bmap_array.item_start_bit;
+	bits_count = node->bmap_array.bits_count;
+
+	if ((index_start_bit + index_capacity) > item_start_bit) {
+		err = -ERANGE;
+		atomic_set(&node->state,
+				SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid shift: "
+			  "index_start_bit %lu, index_capacity %u, "
+			  "item_start_bit %lu\n",
+			  index_start_bit, index_capacity, item_start_bit);
+		goto finish_area_resize;
+	}
+
+	if ((index_start_bit + index_capacity) > bits_count) {
+		err = -ERANGE;
+		atomic_set(&node->state,
+				SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid shift: "
+			  "index_start_bit %lu, index_capacity %u, "
+			  "bits_count %lu\n",
+			  index_start_bit, index_capacity, bits_count);
+		goto finish_area_resize;
+	}
+
+	if ((item_start_bit + items_capacity) > bits_count) {
+		err = -ERANGE;
+		atomic_set(&node->state,
+				SSDFS_BTREE_NODE_CORRUPTED);
+		SSDFS_ERR("invalid shift: "
+			  "item_start_bit %lu, items_capacity %u, "
+			  "bits_count %lu\n",
+			  item_start_bit, items_capacity, bits_count);
+		goto finish_area_resize;
+	}
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		index_area_exist = true;
+		break;
+
+	default:
+		index_area_exist = false;
+		break;
+	}
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_area_exist = true;
+		break;
+
+	default:
+		items_area_exist = false;
+		break;
+	}
+
+	if (index_area_exist && items_area_exist) {
+		atomic_set(&node->type, SSDFS_BTREE_HYBRID_NODE);
+		atomic_or(SSDFS_BTREE_NODE_HAS_INDEX_AREA,
+			  &node->flags);
+		atomic_or(SSDFS_BTREE_NODE_HAS_ITEMS_AREA,
+			  &node->flags);
+	} else if (index_area_exist) {
+		atomic_set(&node->type, SSDFS_BTREE_INDEX_NODE);
+		atomic_or(SSDFS_BTREE_NODE_HAS_INDEX_AREA,
+			  &node->flags);
+		atomic_and(~SSDFS_BTREE_NODE_HAS_ITEMS_AREA,
+			  &node->flags);
+	} else if (items_area_exist) {
+		atomic_set(&node->type, SSDFS_BTREE_LEAF_NODE);
+		atomic_and(~SSDFS_BTREE_NODE_HAS_INDEX_AREA,
+			  &node->flags);
+		atomic_or(SSDFS_BTREE_NODE_HAS_ITEMS_AREA,
+			  &node->flags);
+	} else
+		BUG();
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
+	atomic_set(&node->state, SSDFS_BTREE_NODE_DIRTY);
+
+finish_area_resize:
+	up_write(&node->bmap_array.lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_get_hash_range() - extract hash range
+ */
+int ssdfs_btree_node_get_hash_range(struct ssdfs_btree_search *search,
+				    u64 *start_hash, u64 *end_hash,
+				    u16 *items_count)
+{
+	struct ssdfs_btree_node *node = NULL;
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !start_hash || !end_hash || !items_count);
+
+	SSDFS_DBG("search %p, start_hash %p, "
+		  "end_hash %p, items_count %p\n",
+		  search, start_hash, end_hash, items_count);
+
+	ssdfs_debug_btree_search_object(search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*start_hash = *end_hash = U64_MAX;
+	*items_count = 0;
+
+	switch (search->node.state) {
+	case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+	case SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC:
+		node = search->node.child;
+		if (!node) {
+			SSDFS_ERR("node pointer is NULL\n");
+			return -ERANGE;
+		}
+		break;
+
+	default:
+		SSDFS_ERR("unexpected node state %#x\n",
+			  search->node.state);
+		return -ERANGE;
+	}
+
+	state = atomic_read(&node->items_area.state);
+	switch (state) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected items area's state %#x\n",
+			  state);
+		return -ERANGE;
+	}
+
+	down_read(&node->header_lock);
+	*start_hash = node->items_area.start_hash;
+	*end_hash = node->items_area.end_hash;
+	*items_count = node->items_area.items_count;
+	up_read(&node->header_lock);
+
+	return 0;
+}
+
+void ssdfs_show_btree_node_info(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK
+	int i;
+
+	BUG_ON(!node);
+
+	SSDFS_ERR("STATIC DATA: node_id %u, height %d, "
+		  "owner_ino %llu, "
+		  "node_size %u, pages_per_node %u, "
+		  "create_cno %llu, tree %p, "
+		  "parent_node %p, node_ops %p\n",
+		  node->node_id, atomic_read(&node->height),
+		  node->tree->owner_ino,
+		  node->node_size, node->pages_per_node,
+		  node->create_cno, node->tree,
+		  node->parent_node, node->node_ops);
+
+	if (node->parent_node) {
+		SSDFS_ERR("PARENT_NODE: node_id %u, height %d, "
+			  "state %#x, type %#x\n",
+			  node->parent_node->node_id,
+			  atomic_read(&node->parent_node->height),
+			  atomic_read(&node->parent_node->state),
+			  atomic_read(&node->parent_node->type));
+	}
+
+	SSDFS_ERR("MUTABLE DATA: refs_count %d, state %#x, "
+		  "flags %#x, type %#x\n",
+		  atomic_read(&node->refs_count),
+		  atomic_read(&node->state),
+		  atomic_read(&node->flags),
+		  atomic_read(&node->type));
+
+	down_read(&node->header_lock);
+
+	SSDFS_ERR("INDEX_AREA: state %#x, "
+		  "offset %u, size %u, "
+		  "index_size %u, index_count %u, "
+		  "index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->index_area.state),
+		  node->index_area.offset,
+		  node->index_area.area_size,
+		  node->index_area.index_size,
+		  node->index_area.index_count,
+		  node->index_area.index_capacity,
+		  node->index_area.start_hash,
+		  node->index_area.end_hash);
+
+	SSDFS_ERR("ITEMS_AREA: state %#x, "
+		  "offset %u, size %u, free_space %u, "
+		  "item_size %u, min_item_size %u, "
+		  "max_item_size %u, items_count %u, "
+		  "items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->items_area.state),
+		  node->items_area.offset,
+		  node->items_area.area_size,
+		  node->items_area.free_space,
+		  node->items_area.item_size,
+		  node->items_area.min_item_size,
+		  node->items_area.max_item_size,
+		  node->items_area.items_count,
+		  node->items_area.items_capacity,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+
+	SSDFS_ERR("LOOKUP_TBL_AREA: state %#x, "
+		  "offset %u, size %u, "
+		  "index_size %u, index_count %u, "
+		  "index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->lookup_tbl_area.state),
+		  node->lookup_tbl_area.offset,
+		  node->lookup_tbl_area.area_size,
+		  node->lookup_tbl_area.index_size,
+		  node->lookup_tbl_area.index_count,
+		  node->lookup_tbl_area.index_capacity,
+		  node->lookup_tbl_area.start_hash,
+		  node->lookup_tbl_area.end_hash);
+
+	SSDFS_ERR("HASH_TBL_AREA: state %#x, "
+		  "offset %u, size %u, "
+		  "index_size %u, index_count %u, "
+		  "index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->hash_tbl_area.state),
+		  node->hash_tbl_area.offset,
+		  node->hash_tbl_area.area_size,
+		  node->hash_tbl_area.index_size,
+		  node->hash_tbl_area.index_count,
+		  node->hash_tbl_area.index_capacity,
+		  node->hash_tbl_area.start_hash,
+		  node->hash_tbl_area.end_hash);
+
+	up_read(&node->header_lock);
+
+	spin_lock(&node->descriptor_lock);
+
+	SSDFS_ERR("NODE DESCRIPTOR: is_locked %d, "
+		  "update_cno %llu, seg %p, "
+		  "completion_done %d\n",
+		  spin_is_locked(&node->descriptor_lock),
+		  node->update_cno, node->seg,
+		  completion_done(&node->init_end));
+
+	SSDFS_ERR("NODE_INDEX: node_id %u, node_type %#x, "
+		  "height %u, flags %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(node->node_index.node_id),
+		  node->node_index.node_type,
+		  node->node_index.height,
+		  le16_to_cpu(node->node_index.flags),
+		  le64_to_cpu(node->node_index.index.hash),
+		  le64_to_cpu(node->node_index.index.extent.seg_id),
+		  le32_to_cpu(node->node_index.index.extent.logical_blk),
+		  le32_to_cpu(node->node_index.index.extent.len));
+
+	SSDFS_ERR("EXTENT: seg_id %llu, logical_blk %u, len %u\n",
+		  le64_to_cpu(node->extent.seg_id),
+		  le32_to_cpu(node->extent.logical_blk),
+		  le32_to_cpu(node->extent.len));
+
+	if (node->seg) {
+		SSDFS_ERR("SEGMENT: seg_id %llu, seg_type %#x, "
+			  "seg_state %#x, refs_count %d\n",
+			  node->seg->seg_id,
+			  node->seg->seg_type,
+			  atomic_read(&node->seg->seg_state),
+			  atomic_read(&node->seg->refs_count));
+	}
+
+	spin_unlock(&node->descriptor_lock);
+
+	down_read(&node->bmap_array.lock);
+
+	SSDFS_ERR("BITMAP ARRAY: bits_count %lu, "
+		  "bmap_bytes %zu, index_start_bit %lu, "
+		  "item_start_bit %lu\n",
+		  node->bmap_array.bits_count,
+		  node->bmap_array.bmap_bytes,
+		  node->bmap_array.index_start_bit,
+		  node->bmap_array.item_start_bit);
+
+	for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+		struct ssdfs_state_bitmap *bmap;
+
+		bmap = &node->bmap_array.bmap[i];
+
+		SSDFS_ERR("BITMAP: index %d, is_locked %d, "
+			  "flags %#x, ptr %p\n",
+			  i, spin_is_locked(&bmap->lock),
+			  bmap->flags, bmap->ptr);
+	}
+
+	SSDFS_ERR("WAIT_QUEUE: is_active %d\n",
+		  waitqueue_active(&node->wait_queue));
+
+	up_read(&node->bmap_array.lock);
+#endif /* CONFIG_SSDFS_BTREE_CONSISTENCY_CHECK */
+}
+
+void ssdfs_debug_btree_node_object(struct ssdfs_btree_node *node)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+
+	BUG_ON(!node);
+
+	SSDFS_DBG("STATIC DATA: node_id %u, height %d, "
+		  "owner_ino %llu, "
+		  "node_size %u, pages_per_node %u, "
+		  "create_cno %llu, tree %p, "
+		  "parent_node %p, node_ops %p\n",
+		  node->node_id, atomic_read(&node->height),
+		  node->tree->owner_ino,
+		  node->node_size, node->pages_per_node,
+		  node->create_cno, node->tree,
+		  node->parent_node, node->node_ops);
+
+	if (node->parent_node) {
+		SSDFS_DBG("PARENT_NODE: node_id %u, height %d, "
+			  "state %#x, type %#x\n",
+			  node->parent_node->node_id,
+			  atomic_read(&node->parent_node->height),
+			  atomic_read(&node->parent_node->state),
+			  atomic_read(&node->parent_node->type));
+	}
+
+	SSDFS_DBG("MUTABLE DATA: refs_count %d, state %#x, "
+		  "flags %#x, type %#x\n",
+		  atomic_read(&node->refs_count),
+		  atomic_read(&node->state),
+		  atomic_read(&node->flags),
+		  atomic_read(&node->type));
+
+	SSDFS_DBG("NODE HEADER: is_locked %d\n",
+		  rwsem_is_locked(&node->header_lock));
+
+	SSDFS_DBG("RAW HEADER DUMP:\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				&node->raw,
+				sizeof(node->raw));
+	SSDFS_DBG("\n");
+
+	SSDFS_DBG("INDEX_AREA: state %#x, "
+		  "offset %u, size %u, "
+		  "index_size %u, index_count %u, "
+		  "index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->index_area.state),
+		  node->index_area.offset,
+		  node->index_area.area_size,
+		  node->index_area.index_size,
+		  node->index_area.index_count,
+		  node->index_area.index_capacity,
+		  node->index_area.start_hash,
+		  node->index_area.end_hash);
+
+	SSDFS_DBG("ITEMS_AREA: state %#x, "
+		  "offset %u, size %u, free_space %u, "
+		  "item_size %u, min_item_size %u, "
+		  "max_item_size %u, items_count %u, "
+		  "items_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->items_area.state),
+		  node->items_area.offset,
+		  node->items_area.area_size,
+		  node->items_area.free_space,
+		  node->items_area.item_size,
+		  node->items_area.min_item_size,
+		  node->items_area.max_item_size,
+		  node->items_area.items_count,
+		  node->items_area.items_capacity,
+		  node->items_area.start_hash,
+		  node->items_area.end_hash);
+
+	SSDFS_DBG("LOOKUP_TBL_AREA: state %#x, "
+		  "offset %u, size %u, "
+		  "index_size %u, index_count %u, "
+		  "index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->lookup_tbl_area.state),
+		  node->lookup_tbl_area.offset,
+		  node->lookup_tbl_area.area_size,
+		  node->lookup_tbl_area.index_size,
+		  node->lookup_tbl_area.index_count,
+		  node->lookup_tbl_area.index_capacity,
+		  node->lookup_tbl_area.start_hash,
+		  node->lookup_tbl_area.end_hash);
+
+	SSDFS_DBG("HASH_TBL_AREA: state %#x, "
+		  "offset %u, size %u, "
+		  "index_size %u, index_count %u, "
+		  "index_capacity %u, "
+		  "start_hash %llx, end_hash %llx\n",
+		  atomic_read(&node->hash_tbl_area.state),
+		  node->hash_tbl_area.offset,
+		  node->hash_tbl_area.area_size,
+		  node->hash_tbl_area.index_size,
+		  node->hash_tbl_area.index_count,
+		  node->hash_tbl_area.index_capacity,
+		  node->hash_tbl_area.start_hash,
+		  node->hash_tbl_area.end_hash);
+
+	SSDFS_DBG("NODE DESCRIPTOR: is_locked %d, "
+		  "update_cno %llu, seg %p, "
+		  "completion_done %d\n",
+		  spin_is_locked(&node->descriptor_lock),
+		  node->update_cno, node->seg,
+		  completion_done(&node->init_end));
+
+	SSDFS_DBG("NODE_INDEX: node_id %u, node_type %#x, "
+		  "height %u, flags %#x, hash %llx, "
+		  "seg_id %llu, logical_blk %u, len %u\n",
+		  le32_to_cpu(node->node_index.node_id),
+		  node->node_index.node_type,
+		  node->node_index.height,
+		  le16_to_cpu(node->node_index.flags),
+		  le64_to_cpu(node->node_index.index.hash),
+		  le64_to_cpu(node->node_index.index.extent.seg_id),
+		  le32_to_cpu(node->node_index.index.extent.logical_blk),
+		  le32_to_cpu(node->node_index.index.extent.len));
+
+	SSDFS_DBG("EXTENT: seg_id %llu, logical_blk %u, len %u\n",
+		  le64_to_cpu(node->extent.seg_id),
+		  le32_to_cpu(node->extent.logical_blk),
+		  le32_to_cpu(node->extent.len));
+
+	if (node->seg) {
+		SSDFS_DBG("SEGMENT: seg_id %llu, seg_type %#x, "
+			  "seg_state %#x, refs_count %d\n",
+			  node->seg->seg_id,
+			  node->seg->seg_type,
+			  atomic_read(&node->seg->seg_state),
+			  atomic_read(&node->seg->refs_count));
+	}
+
+	SSDFS_DBG("BITMAP ARRAY: is_locked %d, bits_count %lu, "
+		  "bmap_bytes %zu, index_start_bit %lu, "
+		  "item_start_bit %lu\n",
+		  rwsem_is_locked(&node->bmap_array.lock),
+		  node->bmap_array.bits_count,
+		  node->bmap_array.bmap_bytes,
+		  node->bmap_array.index_start_bit,
+		  node->bmap_array.item_start_bit);
+
+	for (i = 0; i < SSDFS_BTREE_NODE_BMAP_COUNT; i++) {
+		struct ssdfs_state_bitmap *bmap;
+
+		bmap = &node->bmap_array.bmap[i];
+
+		SSDFS_DBG("BITMAP: index %d, is_locked %d, "
+			  "flags %#x, ptr %p\n",
+			  i, spin_is_locked(&bmap->lock),
+			  bmap->flags, bmap->ptr);
+
+		if (bmap->ptr) {
+			SSDFS_DBG("BMAP DUMP: ");
+			print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					     bmap->ptr,
+					     node->bmap_array.bmap_bytes);
+			SSDFS_DBG("\n");
+		}
+	}
+
+	SSDFS_DBG("WAIT_QUEUE: is_active %d\n",
+		  waitqueue_active(&node->wait_queue));
+
+	SSDFS_DBG("NODE CONTENT: is_locked %d, pvec_size %u\n",
+		  rwsem_is_locked(&node->full_lock),
+		  pagevec_count(&node->content.pvec));
+
+	for (i = 0; i < pagevec_count(&node->content.pvec); i++) {
+		struct page *page;
+		void *kaddr;
+
+		page = node->content.pvec.pages[i];
+
+		if (!page)
+			continue;
+
+		kaddr = kmap_local_page(page);
+		SSDFS_DBG("PAGE DUMP: index %d\n",
+			  i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+				     kaddr,
+				     PAGE_SIZE);
+		SSDFS_DBG("\n");
+		kunmap_local(kaddr);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
-- 
2.34.1

