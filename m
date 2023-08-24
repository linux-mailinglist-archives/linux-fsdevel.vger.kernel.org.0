Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671F0786637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbjHXDtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbjHXDsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:48:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72E810FB
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a32506e90so1062651b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848850; x=1693453650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDzcwqaIquIVzn8OsvZGliHXRbA8ENN1qRnYnmk/Xe8=;
        b=DVQw6x+wRokChvzx3mB2d4JjmEZ8a52hJE0l07W8P8nNrlDhrotmyt3pUv3GQHPCXs
         1BrfBypCNsEERgBF0IuI0x1Xr96Fhh2+gAJZZ0EK/1xIsaeYYxT6/EN1k9efrylQkcM1
         zJ6XM0kKzaSamlFOt/zlkCHRnLHEfp7PkHOGXd5kLYVg7nejR+dkAMm4O/6awNT3a3Qc
         xgwMhP+Jmrs8A3VyzQgEal/ZVI5LfCXDTSkiUmeyykfwpxK0jmaWMGlHcl5rKNUdpgen
         WbYpfAOHKT2MQ9cGHKqu8Hq5a4pOBrfkWUy88QExaDxN1iywSQ8vpGlmHWNB0IOXICaV
         VZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848850; x=1693453650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDzcwqaIquIVzn8OsvZGliHXRbA8ENN1qRnYnmk/Xe8=;
        b=F0FjFTm6Vy3fE+/bv0tas81SRC8KEy1EZOoyNg61aLKGMJmPM9qOWdGhayqizYPhQd
         9P7wQAywWlOMn7kOx4gqLuYEC6GYi+V+Znmu/FCJLlEpiFdyHkmxL8pxlk2W7EWMU8oR
         rgACcrxd6tScmojXMJ+dVACGD0cfVZK2rSU820r7pdJH8pNM/B3ycA157LKQSStAkj4y
         fsFKz60DAVhSBb+VqaQb6J/z4CdwbKO8s6/YsfRSY/CojtnaIu9RxWTEnwUlLX4PKpJR
         uCpyP0Hu0vHSb32SEfdwdAeLxn5oE0gDZpFzK6ZLsu7XYvvn9NGGB7QFbiU+nErEXvZq
         GU9Q==
X-Gm-Message-State: AOJu0Yxqa17ZmQ1jjuC6HgeBzXpMgQoDSu4fUcfBmrBaXRPpnADKYAVt
        hYR97F1yrQUOEa1nPsD7l7DuNA==
X-Google-Smtp-Source: AGHT+IHnOiXJrClBMOyGTENJi9JIt4dG4SRfFKrPyHzsQUg0+5rqtXlfzEqyCDyUa5PDhlr05atJeA==
X-Received: by 2002:a05:6a00:1791:b0:68a:42d0:6b9b with SMTP id s17-20020a056a00179100b0068a42d06b9bmr11893102pfg.3.1692848849886;
        Wed, 23 Aug 2023 20:47:29 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:47:29 -0700 (PDT)
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
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH v5 25/45] md/raid5: dynamically allocate the md-raid5 shrinker
Date:   Thu, 24 Aug 2023 11:42:44 +0800
Message-Id: <20230824034304.37411-26-zhengqi.arch@bytedance.com>
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
dynamically allocate the md-raid5 shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct r5conf.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Song Liu <song@kernel.org>
CC: linux-raid@vger.kernel.org
---
 drivers/md/raid5.c | 26 +++++++++++++++-----------
 drivers/md/raid5.h |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4cb9c608ee19..c8d2c6e50aa1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7401,7 +7401,7 @@ static void free_conf(struct r5conf *conf)
 
 	log_exit(conf);
 
-	unregister_shrinker(&conf->shrinker);
+	shrinker_free(conf->shrinker);
 	free_thread_groups(conf);
 	shrink_stripes(conf);
 	raid5_free_percpu(conf);
@@ -7449,7 +7449,7 @@ static int raid5_alloc_percpu(struct r5conf *conf)
 static unsigned long raid5_cache_scan(struct shrinker *shrink,
 				      struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 	unsigned long ret = SHRINK_STOP;
 
 	if (mutex_trylock(&conf->cache_size_mutex)) {
@@ -7470,7 +7470,7 @@ static unsigned long raid5_cache_scan(struct shrinker *shrink,
 static unsigned long raid5_cache_count(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
+	struct r5conf *conf = shrink->private_data;
 
 	if (conf->max_nr_stripes < conf->min_nr_stripes)
 		/* unlikely, but not impossible */
@@ -7705,18 +7705,22 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	 * it reduces the queue depth and so can hurt throughput.
 	 * So set it rather large, scaled by number of devices.
 	 */
-	conf->shrinker.seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
-	conf->shrinker.scan_objects = raid5_cache_scan;
-	conf->shrinker.count_objects = raid5_cache_count;
-	conf->shrinker.batch = 128;
-	conf->shrinker.flags = 0;
-	ret = register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev));
-	if (ret) {
-		pr_warn("md/raid:%s: couldn't register shrinker.\n",
+	conf->shrinker = shrinker_alloc(0, "md-raid5:%s", mdname(mddev));
+	if (!conf->shrinker) {
+		ret = -ENOMEM;
+		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
 			mdname(mddev));
 		goto abort;
 	}
 
+	conf->shrinker->seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
+	conf->shrinker->scan_objects = raid5_cache_scan;
+	conf->shrinker->count_objects = raid5_cache_count;
+	conf->shrinker->batch = 128;
+	conf->shrinker->private_data = conf;
+
+	shrinker_register(conf->shrinker);
+
 	sprintf(pers_name, "raid%d", mddev->new_level);
 	rcu_assign_pointer(conf->thread,
 			   md_register_thread(raid5d, mddev, pers_name));
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 97a795979a35..22bea20eccbd 100644
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

