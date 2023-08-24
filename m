Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE1786636
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbjHXDtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjHXDsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:48:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E51BD8
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so756169b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848831; x=1693453631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DERoMXizB4tQD41l3IFVDcK/UoRWwvr52IaKs7kkWyE=;
        b=l3iIlNkEM9G3Cc/znNYH0hjfEGMFScoGFsPDxRlIYD6Nl4f8r8Y4ffur08X22M57wD
         rIlSmJrfx+3UpxggfbKcjCE4Dvgc5I/LQBD+OIaafLzWd7xdzc3eeSUn3jYMqVJn93em
         0W1GznsolsuflbV+uszoAiXaDHnfJ+tiKXIpWvpYd/Ij4f6UXGCJcJb4Hscr3UTl0p3b
         LW0D56skk4nR8+fdc5jfeMFs4SDrmcbSIrL0BJ5k/5kJZyOenUt/nJGwsdGpkJqafAVm
         Vnc6/t5P1QbupbAmEIByI7s5m2r7bE1g7Fg9vHnXnyXTIzG01/FAXBjLAVWjh1RgylMp
         uG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848831; x=1693453631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DERoMXizB4tQD41l3IFVDcK/UoRWwvr52IaKs7kkWyE=;
        b=EEnF1WS0mX4iVQpfgPCf/UOHe4/3X3i70z4zChdaVmWm3txd4ztrXhwXvts9n8d1mA
         xmnl3mHaq3wKmUKDsLc+pc1VO110R/GynaKwer/JcFCFF0egFCM7Ia0sNnOCF+HtAx+f
         rNHvLEJXSsiGL402GgryineX8aDFpsW8CIt+SPoITku1rjeuKS4sQb48a2VB/M8HG7W5
         Sk5Kiz9FZu6JfcmM/nxT+opdpxTChXiFaX8hT9vkaWW71XXnZI9FElLmSTX/U748eWZw
         PfLnPBjWG4p9k1khKIudSaeDwFz9xTd/t1CP66Uf47qFU6VXT7zSEjfKqqP3YyoPuceV
         DHyw==
X-Gm-Message-State: AOJu0YzthLVsUb48OV9i5zORCTur+/M4Re4rHJaxInoNKDz9lKFp1Z+R
        KiqrIuV6rMX7pSp+J0mygyerjg==
X-Google-Smtp-Source: AGHT+IFa4D13lTfF9qI4lzhNEmw+/ylikA2tFRh1ZHmSW0TIoxErglnaTpv3xvyiYGMU4coQffhatQ==
X-Received: by 2002:a05:6a00:3107:b0:68a:4bf9:3b21 with SMTP id bi7-20020a056a00310700b0068a4bf93b21mr11172345pfb.0.1692848831711;
        Wed, 23 Aug 2023 20:47:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:47:11 -0700 (PDT)
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
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Subject: [PATCH v5 23/45] dm: dynamically allocate the dm-bufio shrinker
Date:   Thu, 24 Aug 2023 11:42:42 +0800
Message-Id: <20230824034304.37411-24-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the dm-bufio shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct dm_bufio_client.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Alasdair Kergon <agk@redhat.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: dm-devel@redhat.com
---
 drivers/md/dm-bufio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index bc309e41d074..62eb27639c9b 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -963,7 +963,7 @@ struct dm_bufio_client {
 
 	sector_t start;
 
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 	struct work_struct shrink_work;
 	atomic_long_t need_shrink;
 
@@ -2368,7 +2368,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 {
 	struct dm_bufio_client *c;
 
-	c = container_of(shrink, struct dm_bufio_client, shrinker);
+	c = shrink->private_data;
 	atomic_long_add(sc->nr_to_scan, &c->need_shrink);
 	queue_work(dm_bufio_wq, &c->shrink_work);
 
@@ -2377,7 +2377,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 
 static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
+	struct dm_bufio_client *c = shrink->private_data;
 	unsigned long count = cache_total(&c->cache);
 	unsigned long retain_target = get_retain_buffers(c);
 	unsigned long queued_for_cleanup = atomic_long_read(&c->need_shrink);
@@ -2490,14 +2490,20 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	INIT_WORK(&c->shrink_work, shrink_work);
 	atomic_long_set(&c->need_shrink, 0);
 
-	c->shrinker.count_objects = dm_bufio_shrink_count;
-	c->shrinker.scan_objects = dm_bufio_shrink_scan;
-	c->shrinker.seeks = 1;
-	c->shrinker.batch = 0;
-	r = register_shrinker(&c->shrinker, "dm-bufio:(%u:%u)",
-			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
-	if (r)
+	c->shrinker = shrinker_alloc(0, "dm-bufio:(%u:%u)",
+				     MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	if (!c->shrinker) {
+		r = -ENOMEM;
 		goto bad;
+	}
+
+	c->shrinker->count_objects = dm_bufio_shrink_count;
+	c->shrinker->scan_objects = dm_bufio_shrink_scan;
+	c->shrinker->seeks = 1;
+	c->shrinker->batch = 0;
+	c->shrinker->private_data = c;
+
+	shrinker_register(c->shrinker);
 
 	mutex_lock(&dm_bufio_clients_lock);
 	dm_bufio_client_count++;
@@ -2537,7 +2543,7 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 
 	drop_buffers(c);
 
-	unregister_shrinker(&c->shrinker);
+	shrinker_free(c->shrinker);
 	flush_work(&c->shrink_work);
 
 	mutex_lock(&dm_bufio_clients_lock);
-- 
2.30.2

