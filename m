Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2C786628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjHXDrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjHXDrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:04 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7A21FF0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64ad88fb05fso13533096d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848774; x=1693453574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX52Pl2ixlte2DgzQshaqIg6eWURIO9mWebQRHEbYyg=;
        b=Q+jrV/hGwdEttsGppUy814f7YoNw7WLWERgtsHAz86kQBKxj+TwydnndBa3fx5Mojy
         ECKGkzHYTccZTk/ju/rx6/0rBO0AWUyJrxTf4tLFtE0NCnjpFETXw7W6EA4c5z8dmmI5
         Mzd1L79nvDcVnmA/mp+Mr5AM+IOB8WlP1Md/ZoMBn6KxpJSqr2P0bUsWrRAqdA3HaOVb
         rXZNiWvWtEzgAe28hRTsBN8wfqOr+4cyoG8c4tVvfgtjY+g8QdJJrjn4Sd/SAgoEdw5l
         Pg6JoFXmZC6Y4NP7c/E9oJrpfxykw6pyY7UCaE+cUQY/aKOjEPVGg7IEt5P1HJPUslAL
         g5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848774; x=1693453574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tX52Pl2ixlte2DgzQshaqIg6eWURIO9mWebQRHEbYyg=;
        b=lXzaYbvHcjuuTKdV0qcw8n8BAogTUP4SsNa9ohloRIn7iOm7Ic9hTSsBmZ1HbT2L3k
         M4k+hs67cfCCsuaZpybZk4PJly3Y0RTaWaAO/v5Oy99LftM+F2+L/PWcV9Yj0dqjmpKY
         VnmZtwG9LaYGtUXnooYM0RziiX4IkvTexLNpCWy55h/YBFMH4p80f4JEAILX3ce13rhX
         mZGbEj8t9XvWKt/F8jduMCiSoQrXMtjoMYd2BVJX0jprwOtB7KJYQod80mZlX4wTWsjl
         oYvmmDVISBcxn/cfzW3+KK9ch6JR0K+NKP+EiGvG3M3GnWbjBlvJpXeLXeyJCT2BkK/6
         M/7A==
X-Gm-Message-State: AOJu0YyGBuyQcU9LOtWf6rAqwH7QG0vgqvzzhF3aCitpV16f20Pn1ipn
        h4Xlh+ey6S7PJEhO8Zeq1uqz8A==
X-Google-Smtp-Source: AGHT+IH/giC2LTn0MvvTP7+hN9g6irIUBPRUUI2oOCQCQVh9on93KM4yAzkZ9PUzh/cWTAn10rsxmg==
X-Received: by 2002:a05:6214:501b:b0:635:e528:521a with SMTP id jo27-20020a056214501b00b00635e528521amr16845477qvb.5.1692848774439;
        Wed, 23 Aug 2023 20:46:14 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:46:13 -0700 (PDT)
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
Subject: [PATCH v5 17/45] mm: thp: dynamically allocate the thp-related shrinkers
Date:   Thu, 24 Aug 2023 11:42:36 +0800
Message-Id: <20230824034304.37411-18-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the thp-zero and thp-deferred_split
shrinkers.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/huge_memory.c | 69 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3e9443082035..3c9c692e3376 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -65,7 +65,11 @@ unsigned long transparent_hugepage_flags __read_mostly =
 	(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
 	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 
-static struct shrinker deferred_split_shrinker;
+static struct shrinker *deferred_split_shrinker;
+static unsigned long deferred_split_count(struct shrinker *shrink,
+					  struct shrink_control *sc);
+static unsigned long deferred_split_scan(struct shrinker *shrink,
+					 struct shrink_control *sc);
 
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
@@ -229,11 +233,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 	return 0;
 }
 
-static struct shrinker huge_zero_page_shrinker = {
-	.count_objects = shrink_huge_zero_page_count,
-	.scan_objects = shrink_huge_zero_page_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *huge_zero_page_shrinker;
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -454,6 +454,40 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 }
 #endif /* CONFIG_SYSFS */
 
+static int __init thp_shrinker_init(void)
+{
+	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_page_shrinker)
+		return -ENOMEM;
+
+	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						 SHRINKER_MEMCG_AWARE |
+						 SHRINKER_NONSLAB,
+						 "thp-deferred_split");
+	if (!deferred_split_shrinker) {
+		shrinker_free(huge_zero_page_shrinker);
+		return -ENOMEM;
+	}
+
+	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
+	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
+	huge_zero_page_shrinker->seeks = DEFAULT_SEEKS;
+	shrinker_register(huge_zero_page_shrinker);
+
+	deferred_split_shrinker->count_objects = deferred_split_count;
+	deferred_split_shrinker->scan_objects = deferred_split_scan;
+	deferred_split_shrinker->seeks = DEFAULT_SEEKS;
+	shrinker_register(deferred_split_shrinker);
+
+	return 0;
+}
+
+static void __init thp_shrinker_exit(void)
+{
+	shrinker_free(huge_zero_page_shrinker);
+	shrinker_free(deferred_split_shrinker);
+}
+
 static int __init hugepage_init(void)
 {
 	int err;
@@ -482,12 +516,9 @@ static int __init hugepage_init(void)
 	if (err)
 		goto err_slab;
 
-	err = register_shrinker(&huge_zero_page_shrinker, "thp-zero");
-	if (err)
-		goto err_hzp_shrinker;
-	err = register_shrinker(&deferred_split_shrinker, "thp-deferred_split");
+	err = thp_shrinker_init();
 	if (err)
-		goto err_split_shrinker;
+		goto err_shrinker;
 
 	/*
 	 * By default disable transparent hugepages on smaller systems,
@@ -505,10 +536,8 @@ static int __init hugepage_init(void)
 
 	return 0;
 err_khugepaged:
-	unregister_shrinker(&deferred_split_shrinker);
-err_split_shrinker:
-	unregister_shrinker(&huge_zero_page_shrinker);
-err_hzp_shrinker:
+	thp_shrinker_exit();
+err_shrinker:
 	khugepaged_destroy();
 err_slab:
 	hugepage_exit_sysfs(hugepage_kobj);
@@ -2828,7 +2857,7 @@ void deferred_split_folio(struct folio *folio)
 #ifdef CONFIG_MEMCG
 		if (memcg)
 			set_shrinker_bit(memcg, folio_nid(folio),
-					 deferred_split_shrinker.id);
+					 deferred_split_shrinker->id);
 #endif
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
@@ -2902,14 +2931,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	return split;
 }
 
-static struct shrinker deferred_split_shrinker = {
-	.count_objects = deferred_split_count,
-	.scan_objects = deferred_split_scan,
-	.seeks = DEFAULT_SEEKS,
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
-		 SHRINKER_NONSLAB,
-};
-
 #ifdef CONFIG_DEBUG_FS
 static void split_huge_pages_all(void)
 {
-- 
2.30.2

