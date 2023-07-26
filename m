Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51474762FAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGZIXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGZIWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D276A70
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2685102cd16so253568a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359013; x=1690963813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9dsUg7Mi/WzTn56TpcYztC53dUlO7YtHGzVyJj2ahA=;
        b=AxvO2W8WmVjCl+8rJI4ixbPJPEirwx12lLH3TIqpROUBNuTlBFTpwIzvimh0rKV5GO
         jl53Qb/ksDM+V8W/GLFWjp+RoSYw3jS+hUC4AqvaYFObpV+KEgG/doJAkaO3KYxj67D3
         hGPB/vbqL0FvtkEDKiSP2uFPrG+vqg6MD9oePIzWQfrkyb9NfNm5I1GxlLLwR2jNR5xw
         PYqQU1CDGlNTqFeTUH9EsCbpxb5Yp/asxXO7fyvKXIG2Sip5Qaq5nthqVKfov9s0UZnU
         nig8GQjrdik29VC+VZghqXGcKhCir4shFIkMGLbvr/P68Zz7mLMG8OhUaIsqqlWUdBPz
         BlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359013; x=1690963813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9dsUg7Mi/WzTn56TpcYztC53dUlO7YtHGzVyJj2ahA=;
        b=Zqv4wFjxELbN94SKtAAG0roLvhckYKWokiMVWA57x6v7DV8fqFv+6tYnM9hFBsMoya
         jTpnzhEpmMuHizeuidm//mLJYdkGgPbrKXWxDWSl9fyQdcgRXIg6SRuLhQWInobQQQYX
         AQqHjqx04soL3FJ3plsVWXagu/BFRgF6DyaSZGJch57Iu5HcxY9zKNsXrEgDzcQL3NIX
         7TmigWsgthdMSUAbeRxeSBbHX8LoZrZFLaXpFjAE191JWfb6p28vygq65sNl5gl12C1X
         XA55WPp4hcaEHwUZ53c3hhCo27gj/Up4x8RLoN7b01P6yCVpM/hLCYayDSirZVq6PpfC
         MTjg==
X-Gm-Message-State: ABy/qLaQJCIG64L6vKQbf5JS7N9hb+j8UWykwH8F/Yzhaa6mlGZt4aDc
        U9Nnby6X/zcR9g3W6+JtqIz9QA==
X-Google-Smtp-Source: APBJJlGkN+ndt02hEH/zEFcGhY2t+fQ0s2aGudRsTkYsXiwqyld2+wz2kPDM4ySgqmSJx8lp4VguSA==
X-Received: by 2002:a17:90b:1498:b0:268:f56:a2d6 with SMTP id js24-20020a17090b149800b002680f56a2d6mr947545pjb.22.1690359012722;
        Wed, 26 Jul 2023 01:10:12 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:12 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and mt_dup()
Date:   Wed, 26 Jul 2023 16:09:09 +0800
Message-Id: <20230726080916.17454-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce interfaces __mt_dup() and mt_dup(), which are used to
duplicate a maple tree. Compared with traversing the source tree and
reinserting entry by entry in the new tree, it has better performance.
The difference between __mt_dup() and mt_dup() is that mt_dup() holds
an internal lock.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h |   3 +
 lib/maple_tree.c           | 211 +++++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index c962af188681..229fe78e4c89 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -327,6 +327,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
 		void *entry, gfp_t gfp);
 void *mtree_erase(struct maple_tree *mt, unsigned long index);
 
+int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+
 void mtree_destroy(struct maple_tree *mt);
 void __mt_destroy(struct maple_tree *mt);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index da3a2fb405c0..efac6761ae37 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6595,6 +6595,217 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 }
 EXPORT_SYMBOL(mtree_erase);
 
+/*
+ * mt_dup_free() - Free the nodes of a incomplete maple tree.
+ * @mt: The incomplete maple tree
+ * @node: Free nodes from @node
+ *
+ * This function frees all nodes starting from @node in the reverse order of
+ * mt_dup_build(). At this point we don't need to hold the source tree lock.
+ */
+static void mt_dup_free(struct maple_tree *mt, struct maple_node *node)
+{
+	void **slots;
+	unsigned char offset;
+	struct maple_enode *enode;
+	enum maple_type type;
+	unsigned char count = 0, i;
+
+try_ascend:
+	if (ma_is_root(node)) {
+		mt_free_one(node);
+		return;
+	}
+
+	offset = ma_parent_slot(node);
+	type = ma_parent_type(mt, node);
+	node = ma_parent(node);
+	if (!offset)
+		goto free;
+
+	offset--;
+
+descend:
+	slots = (void **)ma_slots(node, type);
+	enode = slots[offset];
+	if (mte_is_leaf(enode))
+		goto free;
+
+	type = mte_node_type(enode);
+	node = mte_to_node(enode);
+	offset = ma_nonleaf_data_end_nocheck(node, type);
+	goto descend;
+
+free:
+	slots = (void **)ma_slots(node, type);
+	count = ma_nonleaf_data_end_nocheck(node, type) + 1;
+	for (i = 0; i < count; i++)
+		((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
+
+	/* Cast to __rcu to avoid sparse checker complaining. */
+	mt_free_bulk(count, (void __rcu **)slots);
+	goto try_ascend;
+}
+
+/*
+ * mt_dup_build() - Build a new maple tree from a source tree
+ * @mt: The source maple tree to copy from
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ * @to_free: Free nodes starting from @to_free if the build fails
+ *
+ * This function builds a new tree in DFS preorder. If it fails due to memory
+ * allocation, @to_free will store the last failed node to free the incomplete
+ * tree. Use mt_dup_free() to free nodes.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated.
+ */
+static inline int mt_dup_build(struct maple_tree *mt, struct maple_tree *new,
+			       gfp_t gfp, struct maple_node **to_free)
+{
+	struct maple_enode *enode;
+	struct maple_node *new_node, *new_parent = NULL, *node;
+	enum maple_type type;
+	void __rcu **slots;
+	void **new_slots;
+	unsigned char count, request, i, offset;
+	unsigned long *set_parent;
+	unsigned long new_root;
+
+	mt_init_flags(new, mt->ma_flags);
+	enode = mt_root_locked(mt);
+	if (unlikely(!xa_is_node(enode))) {
+		rcu_assign_pointer(new->ma_root, enode);
+		return 0;
+	}
+
+	new_node = mt_alloc_one(gfp);
+	if (!new_node)
+		return -ENOMEM;
+
+	new_root = (unsigned long)new_node;
+	new_root |= (unsigned long)enode & MAPLE_NODE_MASK;
+
+copy_node:
+	node = mte_to_node(enode);
+	type = mte_node_type(enode);
+	memcpy(new_node, node, sizeof(struct maple_node));
+
+	set_parent = (unsigned long *)&(new_node->parent);
+	*set_parent &= MAPLE_NODE_MASK;
+	*set_parent |= (unsigned long)new_parent;
+	if (ma_is_leaf(type))
+		goto ascend;
+
+	new_slots = (void **)ma_slots(new_node, type);
+	slots = ma_slots(node, type);
+	request = ma_nonleaf_data_end(mt, node, type) + 1;
+	count = mt_alloc_bulk(gfp, request, new_slots);
+	if (!count) {
+		*to_free = new_node;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < count; i++)
+		((unsigned long *)new_slots)[i] |=
+				((unsigned long)mt_slot_locked(mt, slots, i) &
+				 MAPLE_NODE_MASK);
+	offset = 0;
+
+descend:
+	new_parent = new_node;
+	enode = mt_slot_locked(mt, slots, offset);
+	new_node = mte_to_node(new_slots[offset]);
+	goto copy_node;
+
+ascend:
+	if (ma_is_root(node)) {
+		new_node = mte_to_node((void *)new_root);
+		new_node->parent = ma_parent_ptr((unsigned long)new |
+						 MA_ROOT_PARENT);
+		rcu_assign_pointer(new->ma_root, (void *)new_root);
+		return 0;
+	}
+
+	offset = ma_parent_slot(node);
+	type = ma_parent_type(mt, node);
+	node = ma_parent(node);
+	new_node = ma_parent(new_node);
+	if (offset < ma_nonleaf_data_end(mt, node, type)) {
+		offset++;
+		new_slots = (void **)ma_slots(new_node, type);
+		slots = ma_slots(node, type);
+		goto descend;
+	}
+
+	goto ascend;
+}
+
+/**
+ * __mt_dup(): Duplicate a maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree using a faster method than traversing
+ * the source tree and inserting entries into the new tree one by one. The user
+ * needs to lock the source tree manually. Before calling this function, @new
+ * must be an empty tree or an uninitialized tree. If @mt uses an external lock,
+ * we may also need to manually set @new's external lock using
+ * mt_set_external_lock().
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated.
+ */
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret;
+	struct maple_node *to_free = NULL;
+
+	ret = mt_dup_build(mt, new, gfp, &to_free);
+
+	if (unlikely(ret == -ENOMEM)) {
+		if (to_free)
+			mt_dup_free(new, to_free);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(__mt_dup);
+
+/**
+ * mt_dup(): Duplicate a maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree using a faster method than traversing
+ * the source tree and inserting entries into the new tree one by one. The
+ * function will lock the source tree with an internal lock, and the user does
+ * not need to manually handle the lock. Before calling this function, @new must
+ * be an empty tree or an uninitialized tree. If @mt uses an external lock, we
+ * may also need to manually set @new's external lock using
+ * mt_set_external_lock().
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated.
+ */
+int mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret;
+	struct maple_node *to_free = NULL;
+
+	mtree_lock(mt);
+	ret = mt_dup_build(mt, new, gfp, &to_free);
+	mtree_unlock(mt);
+
+	if (unlikely(ret == -ENOMEM)) {
+		if (to_free)
+			mt_dup_free(new, to_free);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(mt_dup);
+
 /**
  * __mt_destroy() - Walk and free all nodes of a locked maple tree.
  * @mt: The maple tree
-- 
2.20.1

