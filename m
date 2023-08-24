Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA5786638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbjHXDty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbjHXDsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:48:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD6173E
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5657ca46a56so833100a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848859; x=1693453659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa4A7mARo9UASqTNF5nYV+l5Qm4MYZjHRGtSJYP4Y4U=;
        b=d1wXSjPKCFEr8z/p/byM5kRgXe8PbCA56N3zhbP1G8RyclSiP3MfoWO1VjUBFEfLu8
         Jv8srfHUD4wK1EF90VWGYzVLQFM3cgUH6eOrKYXPD/cVeTsc5WoF/vQIJUe26UY/Ow3z
         ENqa6anDehpg55dE40ykBpXSJ3cGdh/QxK3Pyn1kpms/fmsU04YXRAopjkNGU4+76Pq8
         3Y9zyUnnRNr/yzJsGa3A3VHXMPXaHq1XkZzHyi87cd+Y6LY4TdHFbhSuzevUvRulOVyP
         sd5aajfZ70TnWEP93V/mOvFrzj1icTTQnnd4xRKj7zmyKuiZMzeQiMH8vplG2YqtFRs+
         1NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848859; x=1693453659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa4A7mARo9UASqTNF5nYV+l5Qm4MYZjHRGtSJYP4Y4U=;
        b=aAiSWXbPB8n91OErc3G1zcaZpXxo4/MOX481xyvXg4Kbrjqn2B2hY7VCZpwtxz6WyY
         XjvV0xa02TW88GSPLZUuilXSRiGBLfla8hz/IbkH9+C161vYQzwD8T4a2dHFQwJpcz42
         c3arwTNIdhZK6O9cIGy20NlqQe0vSSHJfYmdvRnKngRYCB07yjuPKYvUEDdGBBAuZSLz
         ICpJ2qzhTxWiz9+A29OiODo9R52Wpp9+0fkjLrluU+p+uMS8b9S1Svug3Pn1W8C2o+30
         X+bmw12uZ14Z0tbX+ckdAKhrfzRVfqlWD5mbK60p7jL8jIsCUhaAPz41P9peTdLKi2yB
         NVLg==
X-Gm-Message-State: AOJu0YwVJN7IBw5SMgES2REQbb8psbfe1Ek/tT+Iclt6ZZtKpE6+uAMY
        O5H0saks34b5J0hF8454zHwQJg==
X-Google-Smtp-Source: AGHT+IF3djZSCs4jg/UQUu42D+/WSQ6VNsO0pvWsZu5aji18gl8AMoEFfV4hmz2xAgIkNtsfI3eNSg==
X-Received: by 2002:a05:6a20:3941:b0:111:a0e5:d2b7 with SMTP id r1-20020a056a20394100b00111a0e5d2b7mr16582686pzg.4.1692848858975;
        Wed, 23 Aug 2023 20:47:38 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:47:38 -0700 (PDT)
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
        Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org
Subject: [PATCH v5 26/45] bcache: dynamically allocate the md-bcache shrinker
Date:   Thu, 24 Aug 2023 11:42:45 +0800
Message-Id: <20230824034304.37411-27-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the md-bcache shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct cache_set.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
CC: Coly Li <colyli@suse.de>
CC: Kent Overstreet <kent.overstreet@gmail.com>
CC: linux-bcache@vger.kernel.org
---
 drivers/md/bcache/bcache.h |  2 +-
 drivers/md/bcache/btree.c  | 27 ++++++++++++++++-----------
 drivers/md/bcache/sysfs.c  |  3 ++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 5a79bb3c272f..c622bc50f81b 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -541,7 +541,7 @@ struct cache_set {
 	struct bio_set		bio_split;
 
 	/* For the btree cache */
-	struct shrinker		shrink;
+	struct shrinker		*shrink;
 
 	/* For the btree cache and anything allocation related */
 	struct mutex		bucket_lock;
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fd121a61f17c..ae5cbb55861f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int min_order, bool flush)
 static unsigned long bch_mca_scan(struct shrinker *shrink,
 				  struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 	struct btree *b, *t;
 	unsigned long i, nr = sc->nr_to_scan;
 	unsigned long freed = 0;
@@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 static unsigned long bch_mca_count(struct shrinker *shrink,
 				   struct shrink_control *sc)
 {
-	struct cache_set *c = container_of(shrink, struct cache_set, shrink);
+	struct cache_set *c = shrink->private_data;
 
 	if (c->shrinker_disabled)
 		return 0;
@@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
 
 	closure_init_stack(&cl);
 
-	if (c->shrink.list.next)
-		unregister_shrinker(&c->shrink);
+	if (c->shrink)
+		shrinker_free(c->shrink);
 
 	mutex_lock(&c->bucket_lock);
 
@@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
 		c->verify_data = NULL;
 #endif
 
-	c->shrink.count_objects = bch_mca_count;
-	c->shrink.scan_objects = bch_mca_scan;
-	c->shrink.seeks = 4;
-	c->shrink.batch = c->btree_pages * 2;
+	c->shrink = shrinker_alloc(0, "md-bcache:%pU", c->set_uuid);
+	if (!c->shrink) {
+		pr_warn("bcache: %s: could not allocate shrinker\n", __func__);
+		return 0;
+	}
+
+	c->shrink->count_objects = bch_mca_count;
+	c->shrink->scan_objects = bch_mca_scan;
+	c->shrink->seeks = 4;
+	c->shrink->batch = c->btree_pages * 2;
+	c->shrink->private_data = c;
 
-	if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
-		pr_warn("bcache: %s: could not register shrinker\n",
-				__func__);
+	shrinker_register(c->shrink);
 
 	return 0;
 }
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 0e2c1880f60b..45d8af755de6 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -866,7 +866,8 @@ STORE(__bch_cache_set)
 
 		sc.gfp_mask = GFP_KERNEL;
 		sc.nr_to_scan = strtoul_or_return(buf);
-		c->shrink.scan_objects(&c->shrink, &sc);
+		if (c->shrink)
+			c->shrink->scan_objects(c->shrink, &sc);
 	}
 
 	sysfs_strtoul_clamp(congested_read_threshold_us,
-- 
2.30.2

