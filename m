Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D4778DBDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbjH3Sh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbjH3M52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:57:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2701B2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso35195585ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693400245; x=1694005045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP6g95MTpMxGO+X1eOP4Lih7hj+Gz/gWGNfVacVPrOc=;
        b=D2BcaqjVPO/gzlkDGqLxR4Cu3/LnZyAeaV3VAZQQARePdLsqtmWsIITHmSPR2Rc1zS
         SG33/PIy8p9d1+OC82IeZaaF0nx8p5Binm5j31I/rhLP0Y5Y4ptG+iBIS8crit4PHJHR
         5oKXE2TkpTbISwljRWGTNRqe3iWgsnYuw9/aG5I2GKLetUeG0/BzPco2GHrKu3+ubi/G
         hW5UQObQRQjPS2Qw1MM1vqQXcCqWTFYf7jq4l/soaEwneg1oNu4Ke/Pn1p8NNE+VfCs+
         Il5/cJv5MpPxSsxSCoW2AmAaKQeG5EfJ9pa7oDem7ORUMkPRp/vg9k3UF3WDeHl/AMrw
         Kolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693400245; x=1694005045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP6g95MTpMxGO+X1eOP4Lih7hj+Gz/gWGNfVacVPrOc=;
        b=RMqNBrJXQRT97ZjaR9HmxrhRzppzW7AWJVzzn0y9WQWK5wUN7qslAX0ltZ+3qOlxhe
         eYGz/PAIQwFaK1xev9eaCqtObHSn0bPkSyR2eoPfPuu+/N/D4ZRdd89Kkw5DfWR9qjWR
         qiAd2t+LJuA8QIAam/3R7dqdmWU94qm7XfJjSeOUYSU18buGZM429/CO96LZhvv+9JqQ
         /C4LZ3TkRXS6HgpdmZPSr9VxHmZigZinPUA5GdbQKIqD3zFK929Agk28Ltj41WPXSWBJ
         sy96XD03kHn2JpmulJWabd0GnJyK0ojY3iLQ45ZZ1DE6M919vEA6yst3l4YUhDyjvcdA
         erig==
X-Gm-Message-State: AOJu0YyaNA8j9e7jml7pesXdXfv+R/aLHe6ZmesH6P7kyEodwrClaE7K
        E2u1RG894fuyXhQME1lENQAeqZlXaHBikUO9KMg=
X-Google-Smtp-Source: AGHT+IE0rSvilLu9O36gttI/TkP4I00cCFIGMgIKwGw6O7fql+LFdULSrt81PWAZjYw7XwKOPHgFQA==
X-Received: by 2002:a17:903:487:b0:1bd:ccee:8f26 with SMTP id jj7-20020a170903048700b001bdccee8f26mr1802973plb.15.1693400245360;
        Wed, 30 Aug 2023 05:57:25 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001bbd8cf6b57sm11023265plb.230.2023.08.30.05.57.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Aug 2023 05:57:25 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 1/6] maple_tree: Add two helpers
Date:   Wed, 30 Aug 2023 20:56:49 +0800
Message-Id: <20230830125654.21257-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
References: <20230830125654.21257-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two helpers, which will be used later.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..ef234cf02e3e 100644
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
@@ -5520,7 +5530,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		kmem_cache_free(maple_node_cache, node);
+		mt_free_one(ma_mnode_ptr(node));
 		total--;
 	}
 
-- 
2.20.1

