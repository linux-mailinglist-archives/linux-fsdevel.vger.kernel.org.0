Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31479C04A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbjIKU53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjIKJvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D45E52
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf1876ef69so11144965ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425848; x=1695030648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTNYXL/R7M/nPTx6n9hiKgpOq1ZzCxN84K5zlnPRsiM=;
        b=NHHtQCqajN3A0AVI+7K1Yw6NT5S2vuORP4hSP5XGt2MLqiB67OWAofdX9SLDQ2mEdY
         0VxTgGhDJpuHmUKoamt4QW3r/YfjheZctJq76K+lyvWiZvgba76UlugBGgxTh80ICEKc
         q9WANM3o1bez4cYF1kZBZvUy4K5rQF5g1tL75fGrns529ru1bz4DqCvFUKGKbwIHF8lD
         LaBTvzaTcdKrkEupo6Byh6Q5mCga/h3vTQRl36sgOFoPdUH82oDkMh9pfyBwcs8WtcsM
         J8m4QLFxISJyOZ5+9lpAmryFsV9jZqyoUn1gYGDe74k+dRA61ICsZlvO6Ks5PxNciCB3
         EECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425848; x=1695030648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTNYXL/R7M/nPTx6n9hiKgpOq1ZzCxN84K5zlnPRsiM=;
        b=TZFQ8hrm3XhBGdOZeMHqQd4stWgAb/iwWFKJ5AXqVfbU/HooD7aCsv4otq+BUg9lc3
         jg/GlkvNVB/tnDRlEut/Y97OYxrM4HcMOyDf1rytvwynrrzZF6mA3TLsuMtdS5tLRRnn
         pryXPlFbJuyOLD6b9a4soan0v0pgzud06DHticLYfuOK1CRZCfL3F4GlKMyMY70+2n0W
         bnhHL8DkHfyiFrO3890WOwhF8bC5ouOVs2Oi1D+mrnS/qDKMY1hJLC9NYEeZo4iKNbRW
         WY3KVPA6xer/EnkzVnoyJOmbDAycJtMJzpPE2fAD8VC/izzlF2OkxGnWOuSaB1MDW6TQ
         DCCQ==
X-Gm-Message-State: AOJu0YyDkiUxvSj4QvbLdhQGxpOqso7oBSQHPFgiv20Q/bTZX652t2aO
        +XyCdEJG/2oqCOSvsWxZ9qXs5A==
X-Google-Smtp-Source: AGHT+IEacDPb0mHmf21GNbuP05fWsDcTy2ksO8DVITs4JFo4XsRI7vg8H5BM+TEndmXxdohti+42Ig==
X-Received: by 2002:a17:902:e5c7:b0:1c1:fc5c:b34a with SMTP id u7-20020a170902e5c700b001c1fc5cb34amr10662458plf.3.1694425848453;
        Mon, 11 Sep 2023 02:50:48 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:50:48 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v6 37/45] zsmalloc: dynamically allocate the mm-zspool shrinker
Date:   Mon, 11 Sep 2023 17:44:36 +0800
Message-Id: <20230911094444.68966-38-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the mm-zspool shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct zs_pool.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b58f957429f0..c743ce7a5f49 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -229,7 +229,7 @@ struct zs_pool {
 	struct zs_pool_stats stats;
 
 	/* Compact classes */
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
@@ -2086,8 +2086,7 @@ static unsigned long zs_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
 	unsigned long pages_freed;
-	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
-			shrinker);
+	struct zs_pool *pool = shrinker->private_data;
 
 	/*
 	 * Compact classes and calculate compaction delta.
@@ -2105,8 +2104,7 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 	int i;
 	struct size_class *class;
 	unsigned long pages_to_free = 0;
-	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
-			shrinker);
+	struct zs_pool *pool = shrinker->private_data;
 
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
@@ -2121,18 +2119,23 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 
 static void zs_unregister_shrinker(struct zs_pool *pool)
 {
-	unregister_shrinker(&pool->shrinker);
+	shrinker_free(pool->shrinker);
 }
 
 static int zs_register_shrinker(struct zs_pool *pool)
 {
-	pool->shrinker.scan_objects = zs_shrinker_scan;
-	pool->shrinker.count_objects = zs_shrinker_count;
-	pool->shrinker.batch = 0;
-	pool->shrinker.seeks = DEFAULT_SEEKS;
+	pool->shrinker = shrinker_alloc(0, "mm-zspool:%s", pool->name);
+	if (!pool->shrinker)
+		return -ENOMEM;
+
+	pool->shrinker->scan_objects = zs_shrinker_scan;
+	pool->shrinker->count_objects = zs_shrinker_count;
+	pool->shrinker->batch = 0;
+	pool->shrinker->private_data = pool;
 
-	return register_shrinker(&pool->shrinker, "mm-zspool:%s",
-				 pool->name);
+	shrinker_register(pool->shrinker);
+
+	return 0;
 }
 
 static int calculate_zspage_chain_size(int class_size)
-- 
2.30.2

