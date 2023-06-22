Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB79C739B53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjFVIzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjFVIzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:55:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20211BF4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668842bc50dso866025b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424091; x=1690016091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=161EjO+w9TmzA/a8qJytM8fXp/e7+Gx/R5PIlDH2uAk=;
        b=VsUY2aigV4ZcD/zqH6R6qf5YjeDjgcBdr5DWNiFL+xj8FWQJXfxqjN+JjtQQqPUTZU
         y/hvwjl2otPmZYcL1mDMWeSCzXx77cZKx3CoOlix2I89OTP/XqbmazxkdkRcxT8IoFUn
         2QEonOktxP7xKSbe3Xt0JkWeJ0vXY7bYmU0ntULjSwRJaXbaN1TAoEufMFnqYH3EWbZ2
         epggxRJm4wrl127Vz5WoCbm7/HM2e7h8o7U+VP/mEnC0Icgf0KIm3PI/NPbIYz3ozq3C
         dpiJUcJ4yXe7UOxEIQJgQOohxTSbyOV1lnJIMgAbmswsZtfNIYimqUElkeBCjB3tvm0/
         8Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424091; x=1690016091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=161EjO+w9TmzA/a8qJytM8fXp/e7+Gx/R5PIlDH2uAk=;
        b=LB9iKnU4fX82mmAFw+71e01Xr0bfQ8UvrJm1PfhfLtMxyxKEqhuhLakCU5GCpNtPyA
         b0nK8AH3tDfDoNXjc/IqfiuYuzmQzm5GHjEvHtJB3pcRS2x2A8fRGO+z7NimuWXp2Fm4
         jJApelzmKfaacI4GGaitVpYfeebE9gZxtBXQecLJ8KbZyUJ9IxExB6t5+lHITgGEw2fp
         zgnjFyglYg3WdAZIF2PlBpMCYMJ6r4uI/bgaQfKredLXGqbN03iejzvZfLaWaNOjL803
         0pFcyK1AkIMXPWZkeDmA68IMk7Rcq1s6D++ZEAjkYP0QjXQ4gzKkGUk7h9LLZvIKMCq9
         6fSw==
X-Gm-Message-State: AC+VfDxq8fTCoMTKuV+AUX8Wyvqy1RzQ4StTapGR4omJvu7omTP2yv+k
        nuUDgGqbnbR5q5QG0QIKcIk9UA==
X-Google-Smtp-Source: ACHHUZ6Zp8ahuhiEYJqMKGH6XvbaL5lpWamc0XC/4KRVYsGWUu1w4+GFAcXsiV5/9t8MrDqgvh99eg==
X-Received: by 2002:a17:902:ea01:b0:1b3:e842:40a7 with SMTP id s1-20020a170902ea0100b001b3e84240a7mr20959635plg.1.1687424091188;
        Thu, 22 Jun 2023 01:54:51 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:54:50 -0700 (PDT)
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
Subject: [PATCH 06/29] dm: dynamically allocate the dm-bufio shrinker
Date:   Thu, 22 Jun 2023 16:53:12 +0800
Message-Id: <20230622085335.77010-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the dm-bufio shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct dm_bufio_client.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/dm-bufio.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index eea977662e81..9472470d456d 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -963,7 +963,7 @@ struct dm_bufio_client {
 
 	sector_t start;
 
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 	struct work_struct shrink_work;
 	atomic_long_t need_shrink;
 
@@ -2385,7 +2385,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 {
 	struct dm_bufio_client *c;
 
-	c = container_of(shrink, struct dm_bufio_client, shrinker);
+	c = shrink->private_data;
 	atomic_long_add(sc->nr_to_scan, &c->need_shrink);
 	queue_work(dm_bufio_wq, &c->shrink_work);
 
@@ -2394,7 +2394,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 
 static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
+	struct dm_bufio_client *c = shrink->private_data;
 	unsigned long count = cache_total(&c->cache);
 	unsigned long retain_target = get_retain_buffers(c);
 	unsigned long queued_for_cleanup = atomic_long_read(&c->need_shrink);
@@ -2507,14 +2507,15 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	INIT_WORK(&c->shrink_work, shrink_work);
 	atomic_long_set(&c->need_shrink, 0);
 
-	c->shrinker.count_objects = dm_bufio_shrink_count;
-	c->shrinker.scan_objects = dm_bufio_shrink_scan;
-	c->shrinker.seeks = 1;
-	c->shrinker.batch = 0;
-	r = register_shrinker(&c->shrinker, "dm-bufio:(%u:%u)",
+	c->shrinker = shrinker_alloc_and_init(dm_bufio_shrink_count,
+					      dm_bufio_shrink_scan, 0, 1, 0, c);
+	if (!c->shrinker)
+		goto bad;
+
+	r = register_shrinker(c->shrinker, "dm-bufio:(%u:%u)",
 			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
 	if (r)
-		goto bad;
+		goto bad_shrinker;
 
 	mutex_lock(&dm_bufio_clients_lock);
 	dm_bufio_client_count++;
@@ -2524,6 +2525,8 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 
 	return c;
 
+bad_shrinker:
+	shrinker_free(c->shrinker);
 bad:
 	while (!list_empty(&c->reserved_buffers)) {
 		struct dm_buffer *b = list_to_buffer(c->reserved_buffers.next);
@@ -2554,7 +2557,7 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 
 	drop_buffers(c);
 
-	unregister_shrinker(&c->shrinker);
+	unregister_and_free_shrinker(c->shrinker);
 	flush_work(&c->shrink_work);
 
 	mutex_lock(&dm_bufio_clients_lock);
-- 
2.30.2

