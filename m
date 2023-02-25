Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18B6A265E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjBYBTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBYBRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:41 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA41B2D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:30 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id be35so815810oib.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcX2bwxCaphM4LGPdHyekYkzySQ65p1ZEfBWv9igM5o=;
        b=Ga9fpXyU4UfkCFEE/thbX7FtMlfJWUXgZDo/knxxPnxreNDX6krJmlWTDllrM/3n2l
         jrUsCvF4RR2c8/Yh8Cd+A6gB5x2B3QFbCj4cwWnK2WFSJF3kEjFcePxXOAiNdMcFdouB
         sbAf6lGD9QGuURE0jDVd+ItBcPMzaOTjV3feQz3kmZiS8L4XgZ4cYenhwRF1fC30TyLQ
         j4o+cIVTinD2/gVNnUU1EdYdmHBd4aifxncnJSY+dxK99+KchFTKS6bYwy8bJqLq7g6v
         BA8lZeD+hqOhgG2Rc+2I8FmAwR77U2IAJuzsOdSKG1i2dlb9ow+efIxXX7oCQMRYP3Qd
         +BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcX2bwxCaphM4LGPdHyekYkzySQ65p1ZEfBWv9igM5o=;
        b=xywNKPQmrhk4nAjoZ1bpvR6ELhEP0YrtrwRsy63ng2dwcp09LEiizXkQQTS80gHMKP
         DcOf59e3Z3D7NUZZglSQdLy+9dvGX8PbyBsKzsivwMY0DAQIjsM7g+swRy6/VxJYm690
         bCGg7OH8gcPp4WwbILJhIS0RCxLT4TMVvohc72uvBOCgyCAW13VOssg0qpBCVXun9+xY
         yaePmQKfg1kC/iYMCFOSJEX5dPEqmSdo5qBGOnAoKDjc3LjOc+xf3wIkU+sw21oMl/k8
         fk+LEMYM0+lRllSaAJJSo9Wp9bNTvrkIe/oS2qTR+BcThpwpGHzYdpvkNLPCTehVaKde
         t95w==
X-Gm-Message-State: AO0yUKVO1tTnQwE1gIRE6NTSjNiRFtviN62zOOJn3R2tgQuP9bdMfig8
        i/8S3vjtK1r50gujTRvWPrdGBzLQN76Q0tle
X-Google-Smtp-Source: AK7set+HvvpgHCTm/cnJcSRhJXshylckLX67cKUX+dVGYfj12mfznClyLVd1DnQoptYg1C0WznRJkQ==
X-Received: by 2002:a05:6808:6249:b0:37b:562:2138 with SMTP id dt9-20020a056808624900b0037b05622138mr4501879oib.42.1677287849272;
        Fri, 24 Feb 2023 17:17:29 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:28 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 54/76] ssdfs: change/delete b-tree node operations
Date:   Fri, 24 Feb 2023 17:09:05 -0800
Message-Id: <20230225010927.813929-55-slava@dubeyko.com>
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

B-tree node implements change and delete item or
range of items in the node:
(1) change_item - change item in the b-tre node
(2) delete_item - delete item from b-tree node
(3) delete_range - delete range of items from b-tree node

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/btree_node.c | 2577 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2577 insertions(+)

diff --git a/fs/ssdfs/btree_node.c b/fs/ssdfs/btree_node.c
index aa9d90ba8598..8d939451de05 100644
--- a/fs/ssdfs/btree_node.c
+++ b/fs/ssdfs/btree_node.c
@@ -11342,3 +11342,2580 @@ int ssdfs_btree_node_insert_range(struct ssdfs_btree_search *search)
 
 	return 0;
 }
+
+/*
+ * ssdfs_btree_node_check_result_for_change() - check search result for change
+ * @search: btree search object
+ */
+static inline
+int ssdfs_btree_node_check_result_for_change(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
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
+ * ssdfs_btree_node_change_item() - change the item in the node
+ * @search: btree search object
+ *
+ * This method tries to change an item in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node doesn't contain the item.
+ * %-ENOSPC     - the new item's state cannot be stored in the node.
+ * %-ENOENT     - node hasn't the items area.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ */
+int ssdfs_btree_node_change_item(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
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
+	err = ssdfs_btree_node_check_result_for_change(search);
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
+	if (!node->node_ops || !node->node_ops->change_item) {
+		SSDFS_WARN("unable to change item\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = node->node_ops->change_item(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change item: "
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
+ * ssdfs_btree_node_check_result_for_delete() - check search result for delete
+ * @search: btree search object
+ */
+static inline
+int ssdfs_btree_node_check_result_for_delete(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_VALID_ITEM:
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
+ * ssdfs_btree_node_delete_item() - delete the item from the node
+ * @search: btree search object
+ *
+ * This method tries to delete an item from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node doesn't contain the item.
+ * %-ENOENT     - node's items area is empty.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ */
+int ssdfs_btree_node_delete_item(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
+	u16 items_count, index_count;
+	bool is_node_empty = false;
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
+	err = ssdfs_btree_node_check_result_for_delete(search);
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
+	if (!node->node_ops || !node->node_ops->delete_item) {
+		SSDFS_WARN("unable to delete item\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = node->node_ops->delete_item(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete item: "
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
+	down_read(&node->header_lock);
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_count = node->items_area.items_count;
+		break;
+
+	default:
+		items_count = 0;
+		break;
+	}
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		index_count = node->index_area.index_count;
+		break;
+
+	default:
+		index_count = 0;
+		break;
+	}
+
+	is_node_empty = index_count == 0 && items_count == 0;
+
+	up_read(&node->header_lock);
+
+	spin_lock(&node->descriptor_lock);
+	search->result.search_cno = ssdfs_current_cno(fsi->sb);
+	node->update_cno = search->result.search_cno;
+	if (is_node_empty) {
+		flags = le16_to_cpu(node->node_index.flags);
+		flags = SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE;
+		node->node_index.flags = cpu_to_le16(flags);
+	}
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
+ * ssdfs_btree_node_delete_range() - delete the range of items from the node
+ * @search: btree search object
+ *
+ * This method tries to delete a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node doesn't contain the range of items.
+ * %-ENOENT     - node's items area is empty.
+ * %-EACCES     - node is under initialization yet.
+ * %-EAGAIN     - search object contains obsolete result.
+ */
+int ssdfs_btree_node_delete_range(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_btree_node *node;
+	u16 items_count, index_count;
+	bool is_node_empty = false;
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
+	err = ssdfs_btree_node_check_result_for_delete(search);
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
+	if (!node->node_ops || !node->node_ops->delete_range) {
+		SSDFS_WARN("unable to delete item\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = node->node_ops->delete_range(node, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: "
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
+	down_read(&node->header_lock);
+
+	switch (atomic_read(&node->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		items_count = node->items_area.items_count;
+		break;
+
+	default:
+		items_count = 0;
+		break;
+	}
+
+	switch (atomic_read(&node->index_area.state)) {
+	case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+		index_count = node->index_area.index_count;
+		break;
+
+	default:
+		index_count = 0;
+		break;
+	}
+
+	is_node_empty = index_count == 0 && items_count == 0;
+
+	up_read(&node->header_lock);
+
+	spin_lock(&node->descriptor_lock);
+	search->result.search_cno = ssdfs_current_cno(fsi->sb);
+	node->update_cno = search->result.search_cno;
+	if (is_node_empty) {
+		flags = le16_to_cpu(node->node_index.flags);
+		flags = SSDFS_BTREE_INDEX_SHOW_EMPTY_NODE;
+		node->node_index.flags = cpu_to_le16(flags);
+	}
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
+ * ssdfs_btree_node_clear_range() - clear range of deleted items
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_size: size of item in bytes
+ * @search: search object
+ *
+ * This method tries to clear the range of deleted items.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int __ssdfs_btree_node_clear_range(struct ssdfs_btree_node *node,
+				   struct ssdfs_btree_node_items_area *area,
+				   size_t item_size,
+				   u16 start_index,
+				   unsigned int range_len)
+{
+	int page_index;
+	int dst_index;
+	struct page *page;
+	u32 item_offset;
+	u16 cleared_items = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu\n",
+		  node->node_id, item_size);
+	SSDFS_DBG("start_index %u, range_len %u\n",
+		  start_index, range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range_len == 0) {
+		SSDFS_WARN("range_len == 0\n");
+		return -ERANGE;
+	}
+
+	if ((start_index + range_len) > area->items_capacity) {
+		SSDFS_ERR("range is out of capacity: "
+			  "start_index %u, range_len %u, items_capacity %u\n",
+			  start_index, range_len, area->items_capacity);
+		return -ERANGE;
+	}
+
+	dst_index = start_index;
+
+	do {
+		u32 clearing_items;
+		u32 vacant_positions;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_index %u, dst_index %d\n",
+			  start_index, dst_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		item_offset = (u32)dst_index * item_size;
+		if (item_offset >= area->area_size) {
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset, area->area_size);
+			return -ERANGE;
+		}
+
+		item_offset += area->offset;
+		if (item_offset >= node->node_size) {
+			SSDFS_ERR("item_offset %u >= node_size %u\n",
+				  item_offset, node->node_size);
+			return -ERANGE;
+		}
+
+		page_index = item_offset >> PAGE_SHIFT;
+		if (page_index >= pagevec_count(&node->content.pvec)) {
+			SSDFS_ERR("invalid page_index: "
+				  "index %d, pvec_size %u\n",
+				  page_index,
+				  pagevec_count(&node->content.pvec));
+			return -ERANGE;
+		}
+
+		if (page_index > 0)
+			item_offset %= page_index * PAGE_SIZE;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(start_index > dst_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		clearing_items = dst_index - start_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(clearing_items > range_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		clearing_items = range_len - clearing_items;
+
+		if (clearing_items == 0) {
+			SSDFS_WARN("no items for clearing\n");
+			return -ERANGE;
+		}
+
+		vacant_positions = PAGE_SIZE - item_offset;
+		vacant_positions /= item_size;
+
+		if (vacant_positions == 0) {
+			SSDFS_WARN("invalid vacant_positions %u\n",
+				   vacant_positions);
+			return -ERANGE;
+		}
+
+		clearing_items = min_t(u32, clearing_items, vacant_positions);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(clearing_items >= U16_MAX);
+
+		SSDFS_DBG("clearing_items %u, item_offset %u\n",
+			  clearing_items, item_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if ((item_offset + (clearing_items * item_size)) > PAGE_SIZE) {
+			SSDFS_ERR("invalid request: "
+				  "item_offset %u, clearing_items %u, "
+				  "item_size %zu\n",
+				  item_offset, clearing_items, item_size);
+			return -ERANGE;
+		}
+
+		page = node->content.pvec.pages[page_index];
+		ssdfs_memset_page(page, item_offset, PAGE_SIZE,
+				  0x0, clearing_items * item_size);
+
+		dst_index += clearing_items;
+		cleared_items += clearing_items;
+	} while (cleared_items < range_len);
+
+	if (cleared_items != range_len) {
+		SSDFS_ERR("cleared_items %u != range_len %u\n",
+			  cleared_items, range_len);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_btree_node_clear_range() - clear range of deleted items
+ * @node: pointer on node object
+ * @area: items area descriptor
+ * @item_size: size of item in bytes
+ * @search: search object
+ *
+ * This method tries to clear the range of deleted items.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_btree_node_clear_range(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_node_items_area *area,
+				size_t item_size,
+				struct ssdfs_btree_search *search)
+{
+	u16 start_index;
+	unsigned int range_len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !area || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, item_size %zu\n",
+		  node->node_id, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_index = search->result.start_index;
+	range_len = search->request.count;
+
+	return __ssdfs_btree_node_clear_range(node, area, item_size,
+						start_index, range_len);
+}
+
+/*
+ * ssdfs_btree_node_extract_range() - extract the range from the node
+ * @start_index: starting index in the node
+ * @count: count of items in the range
+ * @search: btree search object
+ *
+ * This method tries to extract a range of items from the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - node doesn't contain items for the requested range.
+ * %-ENOENT     - node hasn't the items area.
+ * %-EACCES     - node is under initialization yet.
+ * %-EOPNOTSUPP - specialized extract method doesn't been implemented
+ */
+int ssdfs_btree_node_extract_range(u16 start_index, u16 count,
+				   struct ssdfs_btree_search *search)
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
+		  "parent %p, child %p, "
+		  "start_index %u, count %u\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  search->node.state, search->node.id,
+		  search->node.height, search->node.parent,
+		  search->node.child, start_index, count);
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
+	if (!node->node_ops || !node->node_ops->extract_range) {
+		SSDFS_WARN("unable to extract the range from the node\n");
+		return -EOPNOTSUPP;
+	}
+
+	err = node->node_ops->extract_range(node, start_index, count, search);
+	if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u "
+			  "hasn't item for request "
+			  "(start_index %u, count %u)\n",
+			  node->node_id,
+			  start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		search->result.state = SSDFS_BTREE_SEARCH_EMPTY_RESULT;
+		search->result.err = err;
+	} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node %u hasn't items area\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to extract the range: "
+			  "node %u, "
+			  "request (start_index %u, count %u), "
+			  "err %d\n",
+			  node->node_id,
+			  start_index, count, err);
+
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	}
+
+	return err;
+}
+
+/*
+ * __ssdfs_btree_node_move_items_range() - move range between nodes
+ * @src: source node
+ * @dst: destination node
+ * @start_item: starting index of the item
+ * @count: count of items in the range
+ *
+ * This method tries to move a range of items from @src node into
+ * @dst node.
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
+int __ssdfs_btree_node_move_items_range(struct ssdfs_btree_node *src,
+					struct ssdfs_btree_node *dst,
+					u16 start_item, u16 count)
+{
+	struct ssdfs_btree_search *search;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!src || !dst);
+
+	SSDFS_DBG("src node_id %u, dst node_id %u, "
+		  "start_item %u, count %u\n",
+		  src->node_id, dst->node_id,
+		  start_item, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		SSDFS_ERR("fail to allocate btree search object\n");
+		return -ENOMEM;
+	}
+
+	ssdfs_btree_search_init(search);
+
+	if (!src->node_ops) {
+		if (!src->node_ops->extract_range) {
+			SSDFS_WARN("unable to extract the items range\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (!src->node_ops->delete_range) {
+			SSDFS_WARN("unable to delete the items range\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (!dst->node_ops) {
+		if (!dst->node_ops->find_range) {
+			SSDFS_WARN("unable to find the items range\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (!dst->node_ops->insert_range) {
+			SSDFS_WARN("unable to insert the items range\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	err = src->node_ops->extract_range(src, start_item, count, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to extract range: "
+			  "node_id %u, start_item %u, "
+			  "count %u, err %d\n",
+			  src->node_id, start_item, count, err);
+		goto finish_move_items_range;
+	}
+
+	ssdfs_debug_btree_search_object(search);
+
+	if (count != search->result.count) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid count (request %u, result %u)\n",
+			  count, search->result.count);
+		goto finish_move_items_range;
+	}
+
+	switch (src->tree->type) {
+	case SSDFS_EXTENTS_BTREE:
+	case SSDFS_XATTR_BTREE:
+		search->request.flags |= SSDFS_BTREE_SEARCH_NOT_INVALIDATE;
+		break;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_DELETE_RANGE;
+
+	err = src->node_ops->delete_range(src, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to delete range: "
+			  "node_id %u, start_item %u, "
+			  "count %u, err %d\n",
+			  src->node_id, start_item, count, err);
+		goto finish_move_items_range;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_ADD_RANGE;
+
+	err = dst->node_ops->find_range(dst, search);
+	if (err == -ENODATA) {
+		err = 0;
+		/*
+		 * Node is empty. We are ready to insert.
+		 */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find range: "
+			  "node_id %u, err %d\n",
+			  dst->node_id, err);
+		goto finish_move_items_range;
+	}
+
+	err = dst->node_ops->insert_range(dst, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to insert range: "
+			  "node_id %u, err %d\n",
+			  dst->node_id, err);
+		goto finish_move_items_range;
+	}
+
+finish_move_items_range:
+	ssdfs_btree_search_free(search);
+	return err;
+}
+
+/*
+ * ssdfs_btree_node_move_items_range() - move items range
+ * @src: source node
+ * @dst: destination node
+ * @start_item: startig index of the item
+ * @count: count of items in the range
+ *
+ * This method tries to move the range of items from @src into @dst.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - items area is absent.
+ * %-EOPNOTSUPP - btree doesn't support the items moving operation.
+ */
+int ssdfs_btree_node_move_items_range(struct ssdfs_btree_node *src,
+				      struct ssdfs_btree_node *dst,
+				      u16 start_item, u16 count)
+{
+	struct ssdfs_fs_info *fsi;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!src || !dst);
+	BUG_ON(!src->tree);
+	BUG_ON(!rwsem_is_locked(&src->tree->lock));
+
+	SSDFS_DBG("src node_id %u, dst node_id %u, "
+		  "start_item %u, count %u\n",
+		  src->node_id, dst->node_id,
+		  start_item, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = src->tree->fsi;
+
+	switch (atomic_read(&src->state)) {
+	case SSDFS_BTREE_NODE_INITIALIZED:
+	case SSDFS_BTREE_NODE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid src node state %#x\n",
+			  atomic_read(&src->state));
+		return -ERANGE;
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
+		SSDFS_ERR("invalid dst node state %#x\n",
+			  atomic_read(&dst->state));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&src->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   src->node_id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   src->node_id);
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&dst->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	case SSDFS_BTREE_NODE_AREA_ABSENT:
+		SSDFS_WARN("items area is absent: node_id %u\n",
+			   dst->node_id);
+		return -ENOENT;
+
+	default:
+		SSDFS_WARN("invalid items area state: node_id %u\n",
+			   dst->node_id);
+		return -ERANGE;
+	}
+
+	if (!src->node_ops) {
+		SSDFS_WARN("unable to move the items range\n");
+		return -EOPNOTSUPP;
+	} else if (!src->node_ops->move_items_range) {
+		err = __ssdfs_btree_node_move_items_range(src, dst,
+							  start_item, count);
+	} else {
+		err = src->node_ops->move_items_range(src, dst,
+							start_item, count);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to move the items range: "
+			  "src node_id %u, dst node_id %u, "
+			  "start_item %u, count %u\n",
+			  src->node_id, dst->node_id,
+			  start_item, count);
+		return err;
+	}
+
+	ssdfs_set_node_update_cno(src);
+	ssdfs_set_node_update_cno(dst);
+	set_ssdfs_btree_node_dirty(src);
+	set_ssdfs_btree_node_dirty(dst);
+
+	return 0;
+}
+
+/*
+ * ssdfs_copy_item_in_buffer() - copy item from node into buffer
+ * @node: pointer on node object
+ * @index: item index
+ * @item_size: size of item in bytes
+ * @search: pointer on search request object [in|out]
+ *
+ * This method tries to copy item from the node into buffer.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_copy_item_in_buffer(struct ssdfs_btree_node *node,
+			      u16 index,
+			      size_t item_size,
+			      struct ssdfs_btree_search *search)
+{
+	DEFINE_WAIT(wait);
+	struct ssdfs_state_bitmap *bmap;
+	u32 area_offset;
+	u32 area_size;
+	u32 item_offset;
+	u32 buf_offset;
+	int page_index;
+	struct page *page;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+
+	SSDFS_DBG("node_id %u, index %u\n",
+		  node->node_id, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->header_lock);
+	area_offset = node->items_area.offset;
+	area_size = node->items_area.area_size;
+	up_read(&node->header_lock);
+
+	item_offset = (u32)index * item_size;
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
+	down_read(&node->full_lock);
+
+	if (page_index >= pagevec_count(&node->content.pvec)) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid page_index: "
+			  "index %d, pvec_size %u\n",
+			  page_index,
+			  pagevec_count(&node->content.pvec));
+		goto finish_copy_item;
+	}
+
+	page = node->content.pvec.pages[page_index];
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+
+	down_read(&node->bmap_array.lock);
+
+try_lock_area:
+	spin_lock(&bmap->lock);
+
+	err = bitmap_allocate_region(bmap->ptr, (unsigned int)index, 0);
+	if (err == -EBUSY) {
+		err = 0;
+		prepare_to_wait(&node->wait_queue, &wait,
+				TASK_UNINTERRUPTIBLE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("waiting unlocked state of item %u\n",
+			   index);
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
+	up_read(&node->bmap_array.lock);
+
+	if (err) {
+		SSDFS_ERR("fail to lock: index %u, err %d\n",
+			  index, err);
+		goto finish_copy_item;
+	}
+
+	if (!search->result.buf) {
+		err = -ERANGE;
+		SSDFS_ERR("buffer is not created\n");
+		goto finish_copy_item;
+	}
+
+	buf_offset = search->result.items_in_buffer * item_size;
+
+	err = ssdfs_memcpy_from_page(search->result.buf,
+				     buf_offset, search->result.buf_size,
+				     page, item_offset, PAGE_SIZE,
+				     item_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to copy: err %d\n", err);
+		goto unlock_area;
+	}
+
+	search->result.items_in_buffer++;
+
+unlock_area:
+	down_read(&node->bmap_array.lock);
+	spin_lock(&bmap->lock);
+	bitmap_clear(bmap->ptr, (unsigned int)index, 1);
+	spin_unlock(&bmap->lock);
+	up_read(&node->bmap_array.lock);
+
+	wake_up_all(&node->wait_queue);
+
+finish_copy_item:
+	up_read(&node->full_lock);
+
+	if (unlikely(err))
+		return err;
+
+	return 0;
+}
+
+/*
+ * ssdfs_lock_items_range() - lock range of items in the node
+ * @node: pointer on node object
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ *
+ * This method tries to lock range of items in the node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - unable to lock the node's header
+ * %-ENODATA    - unable to lock the range of items
+ */
+int ssdfs_lock_items_range(struct ssdfs_btree_node *node,
+			   u16 start_index, u16 count)
+{
+	DEFINE_WAIT(wait);
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long start_area;
+	int i = 0;
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
+
+	start_area = node->bmap_array.item_start_bit;
+	if (start_area == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_area_start\n");
+		goto finish_lock;
+	}
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("lock bitmap is empty\n");
+		goto finish_lock;
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
+finish_lock:
+	up_read(&node->bmap_array.lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_unlock_items_range() - unlock range of items in the node
+ * @node: pointer on node object
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ */
+void ssdfs_unlock_items_range(struct ssdfs_btree_node *node,
+				u16 start_index, u16 count)
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
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+	start_area = node->bmap_array.item_start_bit;
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!bmap->ptr);
+	BUG_ON(start_area == ULONG_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	spin_lock(&bmap->lock);
+	bitmap_clear(bmap->ptr, start_area + start_index, count);
+	spin_unlock(&bmap->lock);
+
+	up_read(&node->bmap_array.lock);
+	wake_up_all(&node->wait_queue);
+}
+
+/*
+ * ssdfs_allocate_items_range() - allocate range of items in bitmap
+ * @node: pointer on node object
+ * @search: pointer on search request object
+ * @items_capacity: items capacity in the node
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ *
+ * This method tries to allocate range of items in bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - range is allocated already.
+ */
+int ssdfs_allocate_items_range(struct ssdfs_btree_node *node,
+				struct ssdfs_btree_search *search,
+				u16 items_capacity,
+				u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long found = ULONG_MAX;
+	unsigned long start_area;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !search);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("items_capacity %u, start_index %u, count %u\n",
+		  items_capacity, start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+
+	start_area = node->bmap_array.item_start_bit;
+	if (start_area == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_area_start\n");
+		goto finish_allocate_items_range;
+	}
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("alloc bitmap is empty\n");
+		goto finish_allocate_items_range;
+	}
+
+	spin_lock(&bmap->lock);
+
+	found = bitmap_find_next_zero_area(bmap->ptr,
+					   start_area + items_capacity,
+					   start_area + start_index,
+					   count, 0);
+	if (search->request.flags & SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE &&
+	    found != (start_area + start_index)) {
+		/* area is allocated already */
+		err = -EEXIST;
+	}
+
+	if (!err)
+		bitmap_set(bmap->ptr, found, count);
+
+	spin_unlock(&bmap->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found %lu, start_area %lu, start_index %u\n",
+		  found, start_area, start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (unlikely(err)) {
+		SSDFS_ERR("found %lu != start %lu\n",
+			  found, start_area + start_index);
+	}
+
+finish_allocate_items_range:
+	up_read(&node->bmap_array.lock);
+
+	return err;
+}
+
+/*
+ * is_ssdfs_node_items_range_allocated() - check that range is allocated
+ * @node: pointer on node object
+ * @items_capacity: items capacity in the node
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ */
+bool is_ssdfs_node_items_range_allocated(struct ssdfs_btree_node *node,
+					 u16 items_capacity,
+					 u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long found = ULONG_MAX;
+	unsigned long start_area;
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
+
+	start_area = node->bmap_array.item_start_bit;
+	BUG_ON(start_area == ULONG_MAX);
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP];
+	if (!bmap->ptr)
+		BUG();
+
+	spin_lock(&bmap->lock);
+	found = bitmap_find_next_zero_area(bmap->ptr,
+					   start_area + items_capacity,
+					   start_area + start_index, count, 0);
+	if (found != (start_area + start_index)) {
+		/* area is allocated already */
+		err = -EEXIST;
+	}
+	spin_unlock(&bmap->lock);
+
+	up_read(&node->bmap_array.lock);
+
+	if (err == -EEXIST)
+		return true;
+
+	return false;
+}
+
+/*
+ * ssdfs_free_items_range() - free range of items in bitmap
+ * @node: pointer on node object
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ *
+ * This method tries to free the range of items in bitmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_free_items_range(struct ssdfs_btree_node *node,
+			   u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long start_area;
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
+
+	start_area = node->bmap_array.item_start_bit;
+	if (start_area == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_area_start\n");
+		goto finish_free_items_range;
+	}
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_ALLOC_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("alloc bitmap is empty\n");
+		goto finish_free_items_range;
+	}
+
+	spin_lock(&bmap->lock);
+	bitmap_clear(bmap->ptr, start_area + start_index, count);
+	spin_unlock(&bmap->lock);
+
+finish_free_items_range:
+	up_read(&node->bmap_array.lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_set_node_header_dirty() - mark the node's header as dirty
+ * @node: pointer on node object
+ * @items_capacity: items capacity in the node
+ *
+ * This method tries to mark the node's header as dirty.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_set_node_header_dirty(struct ssdfs_btree_node *node,
+				u16 items_capacity)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long found = ULONG_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, items_capacity %u\n",
+		  node->node_id, items_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_set_header_dirty;
+	}
+
+	spin_lock(&bmap->lock);
+
+	found = bitmap_find_next_zero_area(bmap->ptr, items_capacity,
+					    SSDFS_BTREE_NODE_HEADER_INDEX,
+					    1, 0);
+	if (found == SSDFS_BTREE_NODE_HEADER_INDEX)
+		bitmap_set(bmap->ptr, found, 1);
+
+	spin_unlock(&bmap->lock);
+
+finish_set_header_dirty:
+	up_read(&node->bmap_array.lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_clear_node_header_dirty_state() - clear node's header dirty state
+ * @node: pointer on node object
+ *
+ * This method tries to clear the node's header dirty state.
+ */
+void ssdfs_clear_node_header_dirty_state(struct ssdfs_btree_node *node)
+{
+	struct ssdfs_state_bitmap *bmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u\n", node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+	if (!bmap->ptr)
+		BUG();
+
+	spin_lock(&bmap->lock);
+	bitmap_clear(bmap->ptr, SSDFS_BTREE_NODE_HEADER_INDEX, 1);
+	spin_unlock(&bmap->lock);
+
+	up_read(&node->bmap_array.lock);
+}
+
+/*
+ * ssdfs_set_dirty_items_range() - mark the range of items as dirty
+ * @node: pointer on node object
+ * @items_capacity: items capacity in the node
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ *
+ * This method tries to mark the range of items as dirty.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_set_dirty_items_range(struct ssdfs_btree_node *node,
+				u16 items_capacity,
+				u16 start_index, u16 count)
+{
+	struct ssdfs_state_bitmap *bmap;
+	unsigned long found = ULONG_MAX;
+	unsigned long start_area;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("items_capacity %u, start_index %u, count %u\n",
+		  items_capacity, start_index, count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&node->bmap_array.lock);
+
+	start_area = node->bmap_array.item_start_bit;
+	if (start_area == ULONG_MAX) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid items_area_start\n");
+		goto finish_set_dirty_items;
+	}
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_DIRTY_BMAP];
+	if (!bmap->ptr) {
+		err = -ERANGE;
+		SSDFS_WARN("dirty bitmap is empty\n");
+		goto finish_set_dirty_items;
+	}
+
+	spin_lock(&bmap->lock);
+
+	found = bitmap_find_next_zero_area(bmap->ptr,
+					   start_area + items_capacity,
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
+
+	SSDFS_DBG("BMAP DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     bmap->ptr,
+			     node->bmap_array.bmap_bytes);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bitmap_set(bmap->ptr, start_area + start_index, count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BMAP DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     bmap->ptr,
+			     node->bmap_array.bmap_bytes);
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
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
+finish_set_dirty_items:
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
+ * ssdfs_clear_dirty_items_range_state() - clear items range's dirty state
+ * @node: pointer on node object
+ * @start_index: start index of the range
+ * @count: count of items in the range
+ *
+ * This method tries to clear the range of items' dirty state.
+ */
+void ssdfs_clear_dirty_items_range_state(struct ssdfs_btree_node *node,
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
+	start_area = node->bmap_array.item_start_bit;
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
+
+/*
+ * is_last_leaf_node_found() - check that found leaf node is the last
+ * @search: pointer on search object
+ */
+bool is_last_leaf_node_found(struct ssdfs_btree_search *search)
+{
+	struct ssdfs_btree_node *parent;
+	u64 leaf_end_hash;
+	u64 index_end_hash;
+	int node_type = SSDFS_BTREE_LEAF_NODE;
+	spinlock_t * lock;
+	int state;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+
+	SSDFS_DBG("start_hash %llx, end_hash %llx, node_id %u\n",
+		  search->request.start.hash,
+		  search->request.end.hash,
+		  search->node.id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!search->node.child) {
+		SSDFS_WARN("empty child node pointer\n");
+		return false;
+	}
+
+	if (!search->node.parent) {
+		SSDFS_WARN("empty parent node pointer\n");
+		return false;
+	}
+
+	switch (atomic_read(&search->node.child->items_area.state)) {
+	case SSDFS_BTREE_NODE_ITEMS_AREA_EXIST:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_WARN("invalid area state %#x\n",
+			   atomic_read(&search->node.child->items_area.state));
+		return false;
+	}
+
+	down_read(&search->node.child->header_lock);
+	leaf_end_hash = search->node.child->items_area.end_hash;
+	up_read(&search->node.child->header_lock);
+
+	if (leaf_end_hash >= U64_MAX) {
+		SSDFS_WARN("leaf node end_hash %llx\n",
+			   leaf_end_hash);
+		return false;
+	}
+
+	parent = search->node.parent;
+
+	do {
+		if (!parent) {
+			SSDFS_WARN("empty parent node pointer\n");
+			return false;
+		}
+
+		node_type = atomic_read(&parent->type);
+
+		switch (node_type) {
+		case SSDFS_BTREE_ROOT_NODE:
+		case SSDFS_BTREE_INDEX_NODE:
+		case SSDFS_BTREE_HYBRID_NODE:
+			state = atomic_read(&parent->index_area.state);
+
+			switch (state) {
+			case SSDFS_BTREE_NODE_INDEX_AREA_EXIST:
+				/* expected state */
+				break;
+
+			default:
+				SSDFS_WARN("invalid area state %#x\n",
+					   state);
+				return false;
+			}
+
+			down_read(&parent->header_lock);
+			index_end_hash = parent->index_area.end_hash;
+			up_read(&parent->header_lock);
+
+			if (index_end_hash >= U64_MAX) {
+				SSDFS_WARN("index area: end hash %llx\n",
+					   index_end_hash);
+				return false;
+			}
+
+			if (leaf_end_hash < index_end_hash) {
+				/* internal node */
+				return false;
+			}
+			break;
+
+		default:
+			SSDFS_WARN("invalid node type %#x\n",
+				   node_type);
+			return false;
+		}
+
+		lock = &parent->descriptor_lock;
+		spin_lock(lock);
+		parent = parent->parent_node;
+		spin_unlock(lock);
+		lock = NULL;
+	} while (node_type != SSDFS_BTREE_ROOT_NODE);
+
+	return true;
+}
+
+/*
+ * ssdfs_btree_node_find_lookup_index_nolock() - find lookup index
+ * @search: search object
+ * @lookup_table: lookup table
+ * @table_capacity: capacity of the lookup table
+ * @lookup_index: lookup index [out]
+ *
+ * This method tries to find a lookup index for requested items.
+ * It needs to lock the lookup table before calling this method.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - lookup index doesn't exist for requested hash.
+ */
+int
+ssdfs_btree_node_find_lookup_index_nolock(struct ssdfs_btree_search *search,
+					  __le64 *lookup_table,
+					  int table_capacity,
+					  u16 *lookup_index)
+{
+	u64 hash;
+	u64 lower_bound, upper_bound;
+	int index;
+	int lower_index, upper_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search || !lookup_table || !lookup_index);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "lookup_table %p, table_capacity %d\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  lookup_table, table_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*lookup_index = U16_MAX;
+	hash = search->request.start.hash;
+
+	if (hash >= U64_MAX) {
+		SSDFS_ERR("invalid hash for search\n");
+		return -ERANGE;
+	}
+
+	lower_index = 0;
+	lower_bound = le64_to_cpu(lookup_table[lower_index]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lower_index %d, lower_bound %llu\n",
+		  lower_index, lower_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (lower_bound >= U64_MAX) {
+		err = -ENODATA;
+		*lookup_index = lower_index;
+		goto finish_index_search;
+	} else if (hash < lower_bound) {
+		err = -ENODATA;
+		*lookup_index = lower_index;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("hash %llx < lower_bound %llx\n",
+			  hash, lower_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_index_search;
+	} else if (hash == lower_bound) {
+		err = -EEXIST;
+		*lookup_index = lower_index;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("hash %llx == lower_bound %llx\n",
+			  hash, lower_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_index_search;
+	}
+
+	upper_index = table_capacity - 1;
+	upper_bound = le64_to_cpu(lookup_table[upper_index]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("upper_index %d, upper_bound %llu\n",
+		  upper_index, upper_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (upper_bound >= U64_MAX) {
+		/*
+		 * continue to search
+		 */
+	} else if (hash == upper_bound) {
+		err = -EEXIST;
+		*lookup_index = upper_index;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("hash %llx == upper_bound %llx\n",
+			  hash, upper_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_index_search;
+	} else if (hash > upper_bound) {
+		err = 0;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("hash %llx > upper_bound %llx\n",
+			  hash, upper_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+		*lookup_index = upper_index;
+		goto finish_index_search;
+	}
+
+	do {
+		int diff = upper_index - lower_index;
+
+		index = lower_index + (diff / 2);
+
+		lower_bound = le64_to_cpu(lookup_table[index]);
+		upper_bound = le64_to_cpu(lookup_table[index + 1]);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("index %d, lower_index %d, upper_index %d, "
+			  "lower_bound %llx, upper_bound %llx\n",
+			  index, lower_index, upper_index,
+			  lower_bound, upper_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (lower_bound >= U64_MAX)
+			upper_index = index;
+		else if (hash < lower_bound)
+			upper_index = index;
+		else if (hash == lower_bound) {
+			err = -EEXIST;
+			*lookup_index = index;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("hash %llx == lower_bound %llx\n",
+				  hash, lower_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_index_search;
+		}
+
+		if (lower_bound < hash && upper_bound >= U64_MAX) {
+			err = 0;
+			*lookup_index = index;
+			goto finish_index_search;
+		} else if (lower_bound < hash && hash < upper_bound) {
+			err = 0;
+			lower_index = index;
+		} else if (hash == upper_bound) {
+			err = -EEXIST;
+			*lookup_index = index;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("hash %llx == upper_bound %llx\n",
+				  hash, upper_bound);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_index_search;
+		} else if (hash > upper_bound)
+			lower_index = index;
+	} while ((upper_index - lower_index) > 1);
+
+	if ((upper_index - lower_index) > 1) {
+		err = -ERANGE;
+		SSDFS_ERR("lower_index %d, upper_index %d\n",
+			  lower_index, upper_index);
+		goto finish_index_search;
+	}
+
+	*lookup_index = lower_index;
+
+finish_index_search:
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("lookup_index %u\n", *lookup_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (err == -EEXIST) {
+		/* index found */
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(*lookup_index >= table_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	return err;
+}
+
+/*
+ * __ssdfs_extract_range_by_lookup_index() - extract a range of items
+ * @node: pointer on node object
+ * @lookup_index: lookup index for requested range
+ * @lookup_table_capacity: maximal number of items in lookup table
+ * @item_size: size of item in bytes
+ * @search: pointer on search request object
+ * @check_item: specialized method of checking item
+ * @prepare_buffer: specialized method of buffer preparing
+ * @get_hash_range: specialized method of getting hash range
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
+int __ssdfs_extract_range_by_lookup_index(struct ssdfs_btree_node *node,
+				u16 lookup_index,
+				int lookup_table_capacity,
+				size_t item_size,
+				struct ssdfs_btree_search *search,
+				ssdfs_check_found_item check_item,
+				ssdfs_prepare_result_buffer prepare_buffer,
+				ssdfs_extract_found_item extract_item)
+{
+	DEFINE_WAIT(wait);
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_state_bitmap *bmap;
+	u16 index, found_index;
+	u16 items_count;
+	u32 area_offset;
+	u32 area_size;
+	u32 item_offset;
+	u64 start_hash = U64_MAX;
+	u64 end_hash = U64_MAX;
+	int page_index;
+	struct page *page;
+	void *kaddr;
+	unsigned long start_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !node->tree || !node->tree->fsi || !search);
+	BUG_ON(lookup_index >= lookup_table_capacity);
+
+	SSDFS_DBG("type %#x, flags %#x, "
+		  "start_hash %llx, end_hash %llx, "
+		  "state %d, node_id %u, height %d, "
+		  "lookup_index %u\n",
+		  search->request.type, search->request.flags,
+		  search->request.start.hash, search->request.end.hash,
+		  atomic_read(&node->state), node->node_id,
+		  atomic_read(&node->height),
+		  lookup_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = node->tree->fsi;
+
+	down_read(&node->header_lock);
+	area_offset = node->items_area.offset;
+	area_size = node->items_area.area_size;
+	items_count = node->items_area.items_count;
+	up_read(&node->header_lock);
+
+	if (items_count == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("node_id %u is empty\n",
+			  node->node_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	found_index = U16_MAX;
+	index = __ssdfs_convert_lookup2item_index(lookup_index,
+						  node->node_size,
+						  item_size,
+						  lookup_table_capacity);
+	if (index >= items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("index %u >= items_count %u\n",
+			  index, items_count);
+		return err;
+	}
+
+	down_read(&node->full_lock);
+
+	bmap = &node->bmap_array.bmap[SSDFS_BTREE_NODE_LOCK_BMAP];
+
+	if (found_index != U16_MAX)
+		goto try_extract_range;
+
+	for (; index < items_count; index++) {
+		item_offset = (u32)index * item_size;
+		if (item_offset >= area_size) {
+			err = -ERANGE;
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset, area_size);
+			goto finish_extract_range;
+		}
+
+		item_offset += area_offset;
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
+		page = node->content.pvec.pages[page_index];
+
+		down_read(&node->bmap_array.lock);
+
+try_lock_checking_item:
+		spin_lock(&bmap->lock);
+
+		start_index = node->bmap_array.item_start_bit + index;
+		err = bitmap_allocate_region(bmap->ptr,
+					     (unsigned int)start_index, 0);
+		if (err == -EBUSY) {
+			err = 0;
+			prepare_to_wait(&node->wait_queue, &wait,
+					TASK_UNINTERRUPTIBLE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("waiting unlocked state of item %lu\n",
+				   start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			spin_unlock(&bmap->lock);
+
+			schedule();
+			finish_wait(&node->wait_queue, &wait);
+			goto try_lock_checking_item;
+		}
+
+		spin_unlock(&bmap->lock);
+
+		up_read(&node->bmap_array.lock);
+
+		if (err) {
+			SSDFS_ERR("fail to lock: index %lu, err %d\n",
+				  start_index, err);
+			goto finish_extract_range;
+		}
+
+		if ((item_offset + item_size) > PAGE_SIZE) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid offset: "
+				  "item_offset %u, item_size %zu\n",
+				  item_offset, item_size);
+			goto finish_extract_range;
+		}
+
+		kaddr = kmap_local_page(page);
+		err = check_item(fsi, search,
+				 (u8 *)kaddr + item_offset,
+				 index,
+				 &start_hash, &end_hash,
+				 &found_index);
+		kunmap_local(kaddr);
+
+		down_read(&node->bmap_array.lock);
+		spin_lock(&bmap->lock);
+		bitmap_clear(bmap->ptr, (unsigned int)start_index, 1);
+		spin_unlock(&bmap->lock);
+		up_read(&node->bmap_array.lock);
+
+		wake_up_all(&node->wait_queue);
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("requested (start_hash %llx, end_hash %llx), "
+			  "start_hash %llx, end_hash %llx, "
+			  "index %u, found_index %u, err %d\n",
+			  search->request.start.hash, search->request.end.hash,
+			  start_hash, end_hash, index, found_index, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (err == -EAGAIN)
+			continue;
+		else if (unlikely(err))
+			goto finish_extract_range;
+		else if (found_index != U16_MAX)
+			break;
+	}
+
+	if (err == -EAGAIN) {
+		if (found_index >= U16_MAX) {
+			SSDFS_ERR("fail to find index\n");
+			goto finish_extract_range;
+		} else if (found_index == items_count) {
+			err = 0;
+			found_index = items_count - 1;
+		} else {
+			err = -ERANGE;
+			SSDFS_ERR("fail to find index\n");
+			goto finish_extract_range;
+		}
+	}
+
+	if (found_index > items_count) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found_index %u, items_count %u\n",
+			  found_index, items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = -ENODATA;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENODATA;
+		search->result.start_index = items_count;
+		search->result.count = 1;
+		goto finish_extract_range;
+	} else if (is_btree_search_contains_new_item(search)) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found_index %u, items_count %u\n",
+			  found_index, items_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		err = -ENODATA;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		search->result.err = -ENODATA;
+		search->result.start_index = found_index;
+		search->result.count = 0;
+		goto finish_extract_range;
+	} else {
+		err = prepare_buffer(search, found_index,
+				     search->request.start.hash,
+				     search->request.end.hash,
+				     items_count, item_size);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to prepare buffers: "
+				  "requested (start_hash %llx, end_hash %llx), "
+				  "found_index %u, start_hash %llx, "
+				  "end_hash %llx, items_count %u, "
+				  "item_size %zu, err %d\n",
+				  search->request.start.hash,
+				  search->request.end.hash,
+				  found_index, start_hash, end_hash,
+				  items_count, item_size, err);
+			goto finish_extract_range;
+		}
+
+		search->result.start_index = found_index;
+		search->result.count = 0;
+	}
+
+try_extract_range:
+	for (; found_index < items_count; found_index++) {
+		item_offset = (u32)found_index * item_size;
+		if (item_offset >= area_size) {
+			err = -ERANGE;
+			SSDFS_ERR("item_offset %u >= area_size %u\n",
+				  item_offset, area_size);
+			goto finish_extract_range;
+		}
+
+		item_offset += area_offset;
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
+		page = node->content.pvec.pages[page_index];
+
+		down_read(&node->bmap_array.lock);
+
+try_lock_extracting_item:
+		spin_lock(&bmap->lock);
+
+		start_index = node->bmap_array.item_start_bit + found_index;
+		err = bitmap_allocate_region(bmap->ptr,
+					     (unsigned int)start_index, 0);
+		if (err == -EBUSY) {
+			err = 0;
+			prepare_to_wait(&node->wait_queue, &wait,
+					TASK_UNINTERRUPTIBLE);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("waiting unlocked state of item %lu\n",
+				   start_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			spin_unlock(&bmap->lock);
+
+			schedule();
+			finish_wait(&node->wait_queue, &wait);
+			goto try_lock_extracting_item;
+		}
+
+		spin_unlock(&bmap->lock);
+
+		up_read(&node->bmap_array.lock);
+
+		if (err) {
+			SSDFS_ERR("fail to lock: index %lu, err %d\n",
+				  start_index, err);
+			goto finish_extract_range;
+		}
+
+		if ((item_offset + item_size) > PAGE_SIZE) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid offset: "
+				  "item_offset %u, item_size %zu\n",
+				  item_offset, item_size);
+			goto finish_extract_range;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("item_offset %u, item_size %zu\n",
+			  item_offset, item_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		kaddr = kmap_local_page(page);
+		err = extract_item(fsi, search, item_size,
+				   (u8 *)kaddr + item_offset,
+				   &start_hash, &end_hash);
+		kunmap_local(kaddr);
+
+		down_read(&node->bmap_array.lock);
+		spin_lock(&bmap->lock);
+		bitmap_clear(bmap->ptr, (unsigned int)start_index, 1);
+		spin_unlock(&bmap->lock);
+		up_read(&node->bmap_array.lock);
+
+		wake_up_all(&node->wait_queue);
+
+		if (err == -ENODATA && search->result.count > 0) {
+			err = 0;
+			search->result.err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("stop search: "
+				  "found_index %u, start_hash %llx, "
+				  "end_hash %llx, search->request.end.hash %llx\n",
+				  found_index, start_hash, end_hash,
+				  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			goto finish_extract_range;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to extract item: "
+				  "kaddr %p, item_offset %u, err %d\n",
+				  kaddr, item_offset, err);
+			goto finish_extract_range;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found_index %u, start_hash %llx, "
+			  "end_hash %llx, search->request.end.hash %llx\n",
+			  found_index, start_hash, end_hash,
+			  search->request.end.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (search->request.end.hash <= end_hash)
+			break;
+	}
+
+	if (search->request.end.hash > end_hash)
+		err = -EAGAIN;
+
+finish_extract_range:
+	up_read(&node->full_lock);
+
+	if (err == -ENODATA || err == -EAGAIN) {
+		/*
+		 * do nothing
+		 */
+		search->result.err = err;
+	} else if (unlikely(err)) {
+		search->result.state = SSDFS_BTREE_SEARCH_FAILURE;
+		search->result.err = err;
+	}
+
+	return err;
+}
+
+/*
+ * ssdfs_calculate_item_offset() - calculate item's offset
+ * @node: pointer on node object
+ * @area_offset: area offset in bytes from the node's beginning
+ * @area_size: area size in bytes
+ * @index: item's index in the node
+ * @item_size: size of item in bytes
+ * @page_index: index of a page in the node [out]
+ * @item_offset: offset in bytes from a page's beginning
+ *
+ * This method tries to calculate item's offset in a page.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_calculate_item_offset(struct ssdfs_btree_node *node,
+				u32 area_offset, u32 area_size,
+				int index, size_t item_size,
+				int *page_index,
+				u32 *item_offset)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!node || !page_index || !item_offset);
+	BUG_ON(!rwsem_is_locked(&node->full_lock));
+
+	SSDFS_DBG("node_id %u, area_offset %u, area_size %u, "
+		  "item_size %zu, index %d\n",
+		  node->node_id, area_offset, area_size,
+		  item_size, index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*item_offset = (u32)index * item_size;
+	if (*item_offset >= area_size) {
+		SSDFS_ERR("item_offset %u >= area_size %u\n",
+			  *item_offset, area_size);
+		return -ERANGE;
+	}
+
+	*item_offset += area_offset;
+	if (*item_offset >= node->node_size) {
+		SSDFS_ERR("item_offset %u >= node_size %u\n",
+			  *item_offset, node->node_size);
+		return -ERANGE;
+	}
+
+	*page_index = *item_offset >> PAGE_SHIFT;
+	if (*page_index >= pagevec_count(&node->content.pvec)) {
+		SSDFS_ERR("invalid page_index: "
+			  "index %d, pvec_size %u\n",
+			  *page_index,
+			  pagevec_count(&node->content.pvec));
+		return -ERANGE;
+	}
+
+	if (*page_index != 0)
+		*item_offset %= PAGE_SIZE;
+
+	return 0;
+}
-- 
2.34.1

