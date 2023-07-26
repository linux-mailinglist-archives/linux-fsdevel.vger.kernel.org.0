Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB187762F98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjGZIWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGZIVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:21:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C004C08
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-268030e1be7so1720324a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690358995; x=1690963795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIT4erJsSQIWC2QtZ169UhvGSIUrHQbWmspV6b3RxCk=;
        b=Hi4bTAj2w5H2xNQiLID4Hia2qzuatOrdKEXuIHwgfQq4h5TogE8UlYPLPr4GbRqm0t
         bir4kr6IwT4SUpGIrXSZ4kUtFow9YDCvc0PSsNFaFKeVcnfY/tlQui4eRr3KN7eX274n
         u6Al0q6bZSrERi3GamYqKl9Z2w0C884Shf+SlR3209WA6vvKX5T7a5zszboxPBvYa9QQ
         gz6TciUgktOetIsNxr9d7qgzK6KCCnMoSiwCmg8JTNl2AOqjwe/mUswmU4FcnPJ0zNg4
         SOPE/TJNK04LNOIeKt6aNMQU4jIO/Np2hanV3cU01WxmakYXecUILeywfx6kY/dSyQ0p
         Jxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358995; x=1690963795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIT4erJsSQIWC2QtZ169UhvGSIUrHQbWmspV6b3RxCk=;
        b=THtNjYEHM6KCm4qQYaZkH/GooxXZOKn6B4fijZl4G5+JszIJHJZzWXoDJ272pspqUA
         WBKY2R5jxRbFUQaevz7iFMsulZt7aZGiIBllirLXhB3rZSNfNkvEyzVrFibpb7Tweu73
         dYrk2eVrcRu1WJMGTciAUoCAIHrymXLaWSNc+qjqR6iaoUh6SMcz8BGjHbvJVhN7qUWZ
         Nfmh997xSskTW/TzcZ5J0yAcwSnVh0eryqOYF3pOdozNfPNS69IwoBcyw8J7nM7qyToi
         hpLzhYaoXbAA7ji3XDkry5AKK3axgrwmPouO+zIBo6wGObL6fKQPSXyL38OQ6bwIkw/8
         gnYg==
X-Gm-Message-State: ABy/qLaRfJuutIhdMcYYpsEsUzG298Xx9r94HwWYBjvOHJ2413lyQb94
        yG/DBeFa5uG+qr4NWw3XvpbFrA==
X-Google-Smtp-Source: APBJJlGTCbgSnoEUEY2Im4b6IteSzBL20T2KsQb6OtigwSGhrzItecI4bNmqd6Se4OFmw5iiEF2MyQ==
X-Received: by 2002:a17:90a:c002:b0:268:2500:b17e with SMTP id p2-20020a17090ac00200b002682500b17emr1115938pjt.23.1690358995399;
        Wed, 26 Jul 2023 01:09:55 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.09.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:09:55 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 01/11] maple_tree: Introduce ma_nonleaf_data_end{_nocheck}()
Date:   Wed, 26 Jul 2023 16:09:06 +0800
Message-Id: <20230726080916.17454-2-zhangpeng.00@bytedance.com>
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

Introduce ma_nonleaf_data_end{_nocheck}() to get the data end of
non-leaf nodes without knowing the maximum value of nodes, so that any
ascending can be avoided even if the maximum value of nodes is not known.

The principle is that we introduce MAPLE_ENODE to mark an ENODE, which
cannot be used by metadata, so we can distinguish whether it is ENODE or
metadata.

The nocheck version is to avoid lockdep complaining in some scenarios
where no locks are held.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a3d602cfd030..98e4fdf6f4b9 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -310,12 +310,19 @@ static inline void mte_set_node_dead(struct maple_enode *mn)
 #define MAPLE_ENODE_TYPE_SHIFT		0x03
 /* Bit 2 means a NULL somewhere below */
 #define MAPLE_ENODE_NULL		0x04
+/* Bit 7 means this is an ENODE, instead of metadata */
+#define MAPLE_ENODE			0x80
+
+static inline bool slot_is_mte(unsigned long slot)
+{
+	return slot & MAPLE_ENODE;
+}
 
 static inline struct maple_enode *mt_mk_node(const struct maple_node *node,
 					     enum maple_type type)
 {
-	return (void *)((unsigned long)node |
-			(type << MAPLE_ENODE_TYPE_SHIFT) | MAPLE_ENODE_NULL);
+	return (void *)((unsigned long)node | (type << MAPLE_ENODE_TYPE_SHIFT) |
+			MAPLE_ENODE_NULL | MAPLE_ENODE);
 }
 
 static inline void *mte_mk_root(const struct maple_enode *node)
@@ -1411,6 +1418,65 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 	return NULL;
 }
 
+/*
+ * ma_nonleaf_data_end() - Find the end of the data in a non-leaf node.
+ * @mt: The maple tree
+ * @node: The maple node
+ * @type: The maple node type
+ *
+ * Uses metadata to find the end of the data when possible without knowing the
+ * node maximum.
+ *
+ * Return: The zero indexed last slot with child.
+ */
+static inline unsigned char ma_nonleaf_data_end(struct maple_tree *mt,
+						struct maple_node *node,
+						enum maple_type type)
+{
+	void __rcu **slots;
+	unsigned long slot;
+
+	slots = ma_slots(node, type);
+	slot = (unsigned long)mt_slot(mt, slots, mt_pivots[type]);
+	if (unlikely(slot_is_mte(slot)))
+		return mt_pivots[type];
+
+	return ma_meta_end(node, type);
+}
+
+/*
+ * ma_nonleaf_data_end_nocheck() - Find the end of the data in a non-leaf node.
+ * @node: The maple node
+ * @type: The maple node type
+ *
+ * Uses metadata to find the end of the data when possible without knowing the
+ * node maximum. This is the version of ma_nonleaf_data_end() that does not
+ * check for lock held. This particular version is designed to avoid lockdep
+ * complaining in some scenarios.
+ *
+ * Return: The zero indexed last slot with child.
+ */
+static inline unsigned char ma_nonleaf_data_end_nocheck(struct maple_node *node,
+							enum maple_type type)
+{
+	void __rcu **slots;
+	unsigned long slot;
+
+	slots = ma_slots(node, type);
+	slot = (unsigned long)rcu_dereference_raw(slots[mt_pivots[type]]);
+	if (unlikely(slot_is_mte(slot)))
+		return mt_pivots[type];
+
+	return ma_meta_end(node, type);
+}
+
+/* See ma_nonleaf_data_end() */
+static inline unsigned char mte_nonleaf_data_end(struct maple_tree *mt,
+						 struct maple_enode *enode)
+{
+	return ma_nonleaf_data_end(mt, mte_to_node(enode), mte_node_type(enode));
+}
+
 /*
  * ma_data_end() - Find the end of the data in a node.
  * @node: The maple node
-- 
2.20.1

