Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34136739B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjFVI5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjFVIzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:55:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D14F2123
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6664ac3be47so1328500b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424107; x=1690016107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJl14vOz0XQFz+azMteX8g8XWQLmhD27loPyzQxCyWo=;
        b=dSY63dBGkLY8Soj8dXVS98dEuYYMZ3kYNqwn6f5//glPXLQFLJz27NFKmb5CQWTM2k
         APxbCFally5Ye2wcKhRjXEzkXpY2MMujAr7sHxpWVpY6Tw+UW8TdBughq+A6CDzAWoWy
         +AmwZXYTUtj1EVbssFnJPqE+UVXszSk7I45NYzxDje6ZfgHjeGWZHMg6aUv73LqWwWwW
         5itKACc99wkxtDt6xsJWBL2urtctKzIlWYA5VnKnCf1Z8lrwitknq6fV+Y7yJzzApX1O
         ankK3WiQYH84OGQwTOkmZRg+avhtQPcT8KVvO5N8KslMNgzr0qkBoxHulDKJPx12AE+X
         /x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424107; x=1690016107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJl14vOz0XQFz+azMteX8g8XWQLmhD27loPyzQxCyWo=;
        b=B3HizCCGda802MUL4uzxj2qLVDMjryDk1P3/9vzj5mWhpd4bbXajDq/sNVcFzDodBd
         H0jzoPGdGx6UpUA2fw89I8FPaE9grUwBt9ApkDmYVlmkaTDr8hwCiZRHN4/aG3bjHYdz
         vNajmX4lR17VQMxxLFGcFmDnTw5N8hG0BAZzYWDZUA7umDzlaNv5XMWhT6rg1yYJdHn7
         DVLWiTVCp6PjTUigQxzM7rAWAeMEWJ95spWQcNRS1L4QKR1YcyJ7FdV7CqIqN/HZURjv
         UdnAQmlB/BmVXtpxgx9PDgZCJYI5Y7emcp2uKrRtFzfaht5GgoopXKo/zTWz1gsCM5tL
         GODg==
X-Gm-Message-State: AC+VfDwOSYP1Js5H0TMnAsWI7KOkQNjeSjBdMNephOwTu1RT628qCTQL
        jkXA4fHVftmvHfGbatI9bhL4sA==
X-Google-Smtp-Source: ACHHUZ4GugeqE/IaG8xLwh4Bzf5woebFV8d7i9CEhVh9D6pBJJ8ySrAWkjhYmHqxBxnT9m8efiqyXQ==
X-Received: by 2002:a17:902:c945:b0:1ac:40f7:8b5a with SMTP id i5-20020a170902c94500b001ac40f78b5amr21000858pla.3.1687424106926;
        Thu, 22 Jun 2023 01:55:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:06 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 08/29] md/raid5: dynamically allocate the md-raid5 shrinker
Date:   Thu, 22 Jun 2023 16:53:14 +0800
Message-Id: <20230622085335.77010-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the md-raid5 shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct r5conf.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/raid5.c | 28 +++++++++++++++++-----------
 drivers/md/raid5.h |  2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f4eea1bbbeaf..4866cad1ad62 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7391,7 +7391,7 @@ static void free_conf(struct r5conf *conf)
 
 	log_exit(conf);
 
-	unregister_shrinker(&conf->shrinker);
+	unregister_and_free_shrinker(conf->shrinker);
 	free_thread_groups(conf);
 	shrink_stripes(conf);
 	raid5_free_percpu(conf);
@@ -7439,7 +7439,7 @@ static int raid5_alloc_percpu(struct r5conf *conf)
 static unsigned long raid5_cache_scan(struct shrinker *shrink,
 				      struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 	unsigned long ret = SHRINK_STOP;
 
 	if (mutex_trylock(&conf->cache_size_mutex)) {
@@ -7460,7 +7460,7 @@ static unsigned long raid5_cache_scan(struct shrinker *shrink,
 static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 
 	if (conf->max_nr_stripes < conf->min_nr_stripes)
 		/* unlikely, but not impossible */
@@ -7695,16 +7695,21 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	 * it reduces the queue depth and so can hurt throughput.
 	 * So set it rather large, scaled by number of devices.
 	 */
-	conf->shrinker.seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
-	conf->shrinker.scan_objects = raid5_cache_scan;
-	conf->shrinker.count_objects = raid5_cache_count;
-	conf->shrinker.batch = 128;
-	conf->shrinker.flags = 0;
-	ret = register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev));
+	conf->shrinker = shrinker_alloc_and_init(raid5_cache_count,
+						 raid5_cache_scan, 128,
+						 DEFAULT_SEEKS * conf->raid_disks * 4,
+						 0, conf);
+	if (!conf->shrinker) {
+		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
+			mdname(mddev));
+		goto abort;
+	}
+
+	ret = register_shrinker(conf->shrinker, "md-raid5:%s", mdname(mddev));
 	if (ret) {
 		pr_warn("md/raid:%s: couldn't register shrinker.\n",
 			mdname(mddev));
-		goto abort;
+		goto abort_shrinker;
 	}
 
 	sprintf(pers_name, "raid%d", mddev->new_level);
@@ -7717,7 +7722,8 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	}
 
 	return conf;
-
+abort_shrinker:
+	shrinker_free(conf->shrinker);
  abort:
 	if (conf)
 		free_conf(conf);
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 6a92fafb0748..806f84681599 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -670,7 +670,7 @@ struct r5conf {
 	wait_queue_head_t	wait_for_stripe;
 	wait_queue_head_t	wait_for_overlap;
 	unsigned long		cache_state;
-	struct shrinker		shrinker;
+	struct shrinker		*shrinker;
 	int			pool_size; /* number of disks in stripeheads in pool */
 	spinlock_t		device_lock;
 	struct disk_info	*disks;
-- 
2.30.2

