Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6489D7BD622
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjJIJDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 05:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjJIJDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:03:50 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B1C5
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 02:03:49 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57b706f604aso2697866eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842228; x=1697447028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn4VBWQzj5W1GGyecNOIEAPBueVPsjsImBXm9m9YoY4=;
        b=QGiUB/KbptGKegNdzw8jChLi0LdKzrPR5ZDC3coGG31Ekd6yqIcSPF2Bw/5YncY7gC
         BA+HBCOD/9r1P1KDF74CN2H3dyyJnwrYI7nGl+QVpwvRy68D5wNRhFK2XNnOAJugO8b2
         Ea2s/x47W1IqtgvzL0GFk23kvipoabMy6VKpObL4fnH9Z3ANIQPn3crEmN+H2/3msl31
         sN/0kZsbK0aGwWy9Es8byB3DPjTZYAOXd5uCCpi4HEulyRYk13RVN+YDyTCiTL4QH7Yl
         9gzzPUnJFS9EUXEbM7X1I//YeFInsTwlnoRykGF1N8fHF9xKT0Dqvf+gXa+B1qTuLWzD
         Blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842228; x=1697447028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn4VBWQzj5W1GGyecNOIEAPBueVPsjsImBXm9m9YoY4=;
        b=cTL8kccYLHHt06mPHJv810H6+kiQ/zbCVM/ylBNFbRUWKhJvF7FJPB89FlXancBMf+
         JovdPPaHmuqpORRHSWYhgk/UndpVM8uuSBL3EyyEWDZWo0XTU9GqnpSDZzIdmEeKpRjC
         XtrWVyiJRnfB4zt4ZhbP42VwkQSkWrt6W4oS3Gp643oy6J4xZwgyrZfcJLqXLJJg4fFl
         VnCO0PA6nbb5myzLOR2Oxmr5Mt3X8Ig6zbgbyUUOB7BzGOcUfgeeIseCOdLj9VOkUESu
         nrn2ll++3rqXRKW/ZAMQBDT7+lZft2RlO0a9nZMbSgnqzMnKkHL+0TNcFAipQY1KW3Cb
         WV8g==
X-Gm-Message-State: AOJu0YwbxyrAueJ1Q8QelQ1TRBRI1Lu1qAJHhwWQlRpUlgM25MKA/9VN
        TJULQwlNaAZzNUNkNthM8lkXnA==
X-Google-Smtp-Source: AGHT+IEWY+HaVY8fp64WuczHV3IZD4vZBL6+LkZqahkWHktgA14SlAu5iH/y7MbQI8ixDAn9dfnWUA==
X-Received: by 2002:a05:6358:4408:b0:134:c37f:4b64 with SMTP id z8-20020a056358440800b00134c37f4b64mr14018761rwc.30.1696842228498;
        Mon, 09 Oct 2023 02:03:48 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.03.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:03:48 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/10] maple_tree: Add mt_free_one() and mt_attr() helpers
Date:   Mon,  9 Oct 2023 17:03:11 +0800
Message-Id: <20231009090320.64565-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two helpers:
1. mt_free_one(), used to free a maple node.
2. mt_attr(), used to obtain the attributes of maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0e00a84e8e8f..28d8959386e7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -165,6 +165,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
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
@@ -205,6 +210,11 @@ static unsigned int mas_mt_height(struct ma_state *mas)
 	return mt_height(mas->tree);
 }
 
+static inline unsigned int mt_attr(struct maple_tree *mt)
+{
+	return mt->ma_flags & ~MT_FLAGS_HEIGHT_MASK;
+}
+
 static inline enum maple_type mte_node_type(const struct maple_enode *entry)
 {
 	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
@@ -5573,7 +5583,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		kmem_cache_free(maple_node_cache, node);
+		mt_free_one(ma_mnode_ptr(node));
 		total--;
 	}
 
-- 
2.20.1

