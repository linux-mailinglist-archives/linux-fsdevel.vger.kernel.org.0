Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1478662D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjHXDsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbjHXDrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C81729
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34bbc394fa0so5580515ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848794; x=1693453594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDu/4z0sff3MNLq2Hem41DvJLtW9HR7Ht2OY0+o3IBw=;
        b=NcBMtAaaLE0r3U9cq1G5ArkW7KseQfBeg2oIVpo0zwEHj2pxIXv396lmpHWvqNY6WL
         JjyXJcQ+71rZjpvUyUbfQ8TBZw5eC/hpC4SZQrI5yyx8ZDcSfC61r6xS0cAm/1P5jMWZ
         mkFz/DOMsozI6+D11/YuxeVQCAHIevBxkzEmHriraQYG91HLeEL/u8PL5wK3f8VZRjuT
         cz8d/r+S9nMPLi5iQaiL+tTIS8oLRmffsx3mniOICQT+h1azffq4WqSFD7IduUw5wFnG
         KASaAakXH9kG67rUD+T3XOhVhqWNxRqdqrYEnF7FkbsAyj3LDEWSCHCaKrbISFen/hwS
         Jp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848794; x=1693453594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDu/4z0sff3MNLq2Hem41DvJLtW9HR7Ht2OY0+o3IBw=;
        b=WuWqkxfFc/PraweaYLg/RiQRcdscu/bf8+eVRNS5CI9xW/6J1RzJBstiHDv2GJ0Mh+
         PkPTeHnL74SFht40ZzYfM4FBOkBQsohq2Jb+bOTn9O0SCGlgYyyA2bqVv820Ap8PRhuT
         40hhCNi4yIlPFbnrD6PT96pQFzEceOCyW4YfqFRdAKyywW9IMbVdZLgI0l1OTmY1/9k1
         Cqm9ryAzyfQt4uP+ZqfDVPhwV0l9beJsJ+5lxILatICSiemWeDHxbzFUBUGhuRfXlqdw
         hhP1rhEXv4EWy6sb65RYMKEk1FymYBQVjeTeNd2zSAhbKCYtrvb8NgUqhICSjCBqvZ0w
         SKww==
X-Gm-Message-State: AOJu0YxkilFS4a+r1a6XC0vj45mD5AoH8Twp1a314lWNf/L4lT3VT2Pm
        qHsxYTTGeDRA0IhRV+5Ka/8+Og==
X-Google-Smtp-Source: AGHT+IF6gasrupmNMEd6iGY3g7E0ID/cc6G3nenUlRac5+F8aF1f3dod8FyRICkvmINEgAPLaLvdgQ==
X-Received: by 2002:a92:c90c:0:b0:345:a3d0:f0d4 with SMTP id t12-20020a92c90c000000b00345a3d0f0d4mr15091049ilp.3.1692848794044;
        Wed, 23 Aug 2023 20:46:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:46:33 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 19/45] mm: workingset: dynamically allocate the mm-shadow shrinker
Date:   Thu, 24 Aug 2023 11:42:38 +0800
Message-Id: <20230824034304.37411-20-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the mm-shadow shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..3c53138903a7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -763,13 +763,6 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 					NULL);
 }
 
-static struct shrinker workingset_shadow_shrinker = {
-	.count_objects = count_shadow_nodes,
-	.scan_objects = scan_shadow_nodes,
-	.seeks = 0, /* ->count reports only fully expendable nodes */
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
-};
-
 /*
  * Our list_lru->lock is IRQ-safe as it nests inside the IRQ-safe
  * i_pages lock.
@@ -778,9 +771,10 @@ static struct lock_class_key shadow_nodes_key;
 
 static int __init workingset_init(void)
 {
+	struct shrinker *workingset_shadow_shrinker;
 	unsigned int timestamp_bits;
 	unsigned int max_order;
-	int ret;
+	int ret = -ENOMEM;
 
 	BUILD_BUG_ON(BITS_PER_LONG < EVICTION_SHIFT);
 	/*
@@ -797,17 +791,24 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
-	if (ret)
+	workingset_shadow_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						    SHRINKER_MEMCG_AWARE,
+						    "mm-shadow");
+	if (!workingset_shadow_shrinker)
 		goto err;
+
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
-			      &workingset_shadow_shrinker);
+			      workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
-	register_shrinker_prepared(&workingset_shadow_shrinker);
+
+	workingset_shadow_shrinker->count_objects = count_shadow_nodes;
+	workingset_shadow_shrinker->scan_objects = scan_shadow_nodes;
+
+	shrinker_register(workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	free_prealloced_shrinker(&workingset_shadow_shrinker);
+	shrinker_free(workingset_shadow_shrinker);
 err:
 	return ret;
 }
-- 
2.30.2

