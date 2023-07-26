Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA5762FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGZIXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGZIWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:16 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D649A49FD
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:07 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-55b8f1c930eso3846367eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359007; x=1690963807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZrshQXwnAab1vq3lU/ajvCxU9+VU+QRXf7AvvzKBtQ=;
        b=kOcNz33W7J/uTghRxfKlgF2t8o8j/nb23QuZ5yZKbuyUJEAo08ew/cyJIJar+ZMNgI
         tgX5YgFX3m0skq8DC+gLxzllvMuDg70EjDBiGJDh1Mpz7+05ViTUmcEq2WUbohgItCxV
         YzHy4oRBemHEGHrvA5A3alCBAqXAz65/Txxwwd4nWao7MA8/0+hF3gmQ7txN/UghIKky
         8G26vNuHfNxrsQXaTfctaOFa7a6rjySrzwk2OVDEFJEhTEGkky1CjAN/cm37djIrSV0x
         6o0qqSUTea0zqTSaIEA6OD8+/F51B8lA3bJ3ibFJVMxXHbff0W8kAffd204aDfDk8A1R
         +z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359007; x=1690963807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZrshQXwnAab1vq3lU/ajvCxU9+VU+QRXf7AvvzKBtQ=;
        b=dQQCpj7KZ/iNfoFOJLKP1QC56897LDJHbMhpg3/x+5JE6chC/vl+bh7AzZIzZi7T7l
         kIy61aHtPAajNS3QnCAb7ec8dd0XyKV3vroUyt5KOHcteTeROmLNUCYcsYcLzvxm4ZDj
         6gELoNFG1dNBR9hoN+LaRNYo5yJ0aIXOMFQcZtUSajIzHvldHiXuj2FM5vzzntMfvfpH
         dqKOuiq2Pxgo0A63yvfo3S/5tglN66yC/oo2so086ZNCpsZxRxNR1rq+XR7bzYXAYUGq
         z7kXhjNyAqMELgSFLeLmhHDRKc6DqEO46VsGzz4Ps1rYGmP91mG9l6H3kLKbQOGxSHqp
         r8zg==
X-Gm-Message-State: ABy/qLbdl6AUnvGMuHbYWGLf/GiNcEFaonASil55gZ23ECjpfJdjqGBj
        MhBvGtiZAV+PTkUOiS2AOpbMog==
X-Google-Smtp-Source: APBJJlFLmfT+cuxvJMJSvIXCYHo32FQ7ykqGokpbQY3Wi2ttJPt4o99SYQCfgC/jOX0M+MMpT8vadQ==
X-Received: by 2002:a05:6358:2794:b0:133:b33:3b9a with SMTP id l20-20020a056358279400b001330b333b9amr1284440rwb.3.1690359006957;
        Wed, 26 Jul 2023 01:10:06 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:06 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 03/11] maple_tree: Add some helper functions
Date:   Wed, 26 Jul 2023 16:09:08 +0800
Message-Id: <20230726080916.17454-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some helper functions so that their parameters are maple node
instead of maple enode, these functions will be used later.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 71 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e0e9a87bdb43..da3a2fb405c0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -164,6 +164,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
 
+static inline void mt_free_one(struct maple_node *node)
+{
+	kmem_cache_free(maple_node_cache, node);
+}
+
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -432,18 +437,18 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
 }
 
 /*
- * mas_parent_type() - Return the maple_type of the parent from the stored
- * parent type.
- * @mas: The maple state
- * @enode: The maple_enode to extract the parent's enum
+ * ma_parent_type() - Return the maple_type of the parent from the stored parent
+ * type.
+ * @mt: The maple tree
+ * @node: The maple_node to extract the parent's enum
  * Return: The node->parent maple_type
  */
 static inline
-enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
+enum maple_type ma_parent_type(struct maple_tree *mt, struct maple_node *node)
 {
 	unsigned long p_type;
 
-	p_type = (unsigned long)mte_to_node(enode)->parent;
+	p_type = (unsigned long)node->parent;
 	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
 		return 0;
 
@@ -451,7 +456,7 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 	p_type &= ~mte_parent_slot_mask(p_type);
 	switch (p_type) {
 	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
-		if (mt_is_alloc(mas->tree))
+		if (mt_is_alloc(mt))
 			return maple_arange_64;
 		return maple_range_64;
 	}
@@ -459,6 +464,19 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 	return 0;
 }
 
+/*
+ * mas_parent_type() - Return the maple_type of the parent from the stored
+ * parent type.
+ * @mas: The maple state
+ * @enode: The maple_enode to extract the parent's enum
+ * Return: The node->parent maple_type
+ */
+static inline
+enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
+{
+	return ma_parent_type(mas->tree, mte_to_node(enode));
+}
+
 /*
  * mas_set_parent() - Set the parent node and encode the slot
  * @enode: The encoded maple node.
@@ -499,14 +517,14 @@ void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
 }
 
 /*
- * mte_parent_slot() - get the parent slot of @enode.
- * @enode: The encoded maple node.
+ * ma_parent_slot() - get the parent slot of @node.
+ * @node: The maple node.
  *
- * Return: The slot in the parent node where @enode resides.
+ * Return: The slot in the parent node where @node resides.
  */
-static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
+static inline unsigned int ma_parent_slot(const struct maple_node *node)
 {
-	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
+	unsigned long val = (unsigned long)node->parent;
 
 	if (val & MA_ROOT_PARENT)
 		return 0;
@@ -519,15 +537,36 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
 }
 
 /*
- * mte_parent() - Get the parent of @node.
- * @node: The encoded maple node.
+ * mte_parent_slot() - get the parent slot of @enode.
+ * @enode: The encoded maple node.
+ *
+ * Return: The slot in the parent node where @enode resides.
+ */
+static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
+{
+	return ma_parent_slot(mte_to_node(enode));
+}
+
+/*
+ * ma_parent() - Get the parent of @node.
+ * @node: The maple node.
+ *
+ * Return: The parent maple node.
+ */
+static inline struct maple_node *ma_parent(const struct maple_node *node)
+{
+	return (void *)((unsigned long)(node->parent) & ~MAPLE_NODE_MASK);
+}
+
+/*
+ * mte_parent() - Get the parent of @enode.
+ * @enode: The encoded maple node.
  *
  * Return: The parent maple node.
  */
 static inline struct maple_node *mte_parent(const struct maple_enode *enode)
 {
-	return (void *)((unsigned long)
-			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
+	return ma_parent(mte_to_node(enode));
 }
 
 /*
-- 
2.20.1

