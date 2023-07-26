Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB82762FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjGZIXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGZIWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CDD6EBA
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-267fc19280bso471287a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359035; x=1690963835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYZiuBqx6ckWFl98anzbTzEwZ+z/345ZUTz3W5AilLA=;
        b=UY37TDKu0twvwszgVhYceWMnSiyklSFwgsOVGywjtmrkLJSXFOYwHm0cFLDDibc+Sl
         +1VrunZVuLNYwXFEBJceFr/7cl/UxJ701yJbZmlFmHYaho6pTuZIdVh8kohzGqcox2X/
         G/9/XrffPAYdh6AMJtIBZLDgcWQHQgF+7I+/jXOXF4gZsOmJ2EzpCo899MIPIqRyjIiP
         tBX/VyS7r4sbEogmJzWTzn/+sREeVGT8Bo+KzycwKdiq633va22OBvw2p+4WStXY6yXA
         Dq0qJbqciYrp/oNwDyzcp9LvnNAVegjxOI8T0ucLR/8q2ebzgfcWV3JK4fIhAIhQI8u4
         kIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359035; x=1690963835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYZiuBqx6ckWFl98anzbTzEwZ+z/345ZUTz3W5AilLA=;
        b=iYk9t05uGC+Oj1G0Jj7+x88CsM8osZS6Rs1IoLMKXaUs7W9VdB22HjJxR/kbgPMw0J
         vquLhs2iOkfa41bKFIqjtM3/ugc+hwY1ByW7QTUAc46MGNe+hkn7EFqJ/UVSfJG9pKzB
         rr/ts83gqlcRs2Y3tjDBDPTfziezy1mAQLR/hokci8D7a4zJPZR/54eX8fBRYA22T9yV
         8Nrd+CEWp395w3j5FQDZte7S+uP/SAiuqbBLLf8xpYcaPVDtwuDXeSUJm0y/QdV8arnK
         vIrxSDNKBB2hIjHBv+hZRKSGNmap9wf5IEyZIKbWbA28gci3QnNgbuBPVwlHb+qza/Ha
         rlaw==
X-Gm-Message-State: ABy/qLZFYJC5hilUJTfYVy184DUUmR9BvIG5t06LX96evELxumr9/NVv
        63yo1czlMlba1ELibCWEQ27Cqg==
X-Google-Smtp-Source: APBJJlF8Oq29jicXQ7LZzSR8Tvg8Z3f0r8jXoW+wL7thrKSoHpxajUTRtxGMChVZFla02C1R6Weu5w==
X-Received: by 2002:a17:90a:1b6c:b0:268:535f:7c15 with SMTP id q99-20020a17090a1b6c00b00268535f7c15mr1294451pjq.0.1690359035369;
        Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:35 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 08/11] maple_tree: Skip other tests when BENCH is enabled
Date:   Wed, 26 Jul 2023 16:09:13 +0800
Message-Id: <20230726080916.17454-9-zhangpeng.00@bytedance.com>
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

Skip other tests when BENCH is enabled so that performance can be
measured in user space.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c            | 8 ++++----
 tools/testing/radix-tree/maple.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 0674aebd4423..0ec0c6a7c0b5 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -3514,10 +3514,6 @@ static int __init maple_tree_seed(void)
 
 	pr_info("\nTEST STARTING\n\n");
 
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_root_expand(&tree);
-	mtree_destroy(&tree);
-
 #if defined(BENCH_SLOT_STORE)
 #define BENCH
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
@@ -3575,6 +3571,10 @@ static int __init maple_tree_seed(void)
 	goto skip;
 #endif
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_root_expand(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_iteration(&tree);
 	mtree_destroy(&tree);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 3052e899e5df..57e6b0bc5984 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36140,7 +36140,9 @@ void farmer_tests(void)
 
 void maple_tree_tests(void)
 {
+#if !defined(BENCH_FORK)
 	farmer_tests();
+#endif
 	maple_tree_seed();
 	maple_tree_harvest();
 }
-- 
2.20.1

