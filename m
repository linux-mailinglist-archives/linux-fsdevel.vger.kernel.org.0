Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD2739B35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjFVI6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjFVI6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:58:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCAB26BB
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f64817809so680027a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424131; x=1690016131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw+THIB7nYtdEoKFrcRpf+DtRSemfk8nQmXyWQCWLOU=;
        b=DMwdTIl9g+okPZHJv8qTrb+gYAPEj9v1sxcSDlzK5ch7N+TuIC/BcFHKohEZo55ND8
         XU29tOhBmT8qLwPtzV/wEHQ6iOqaUqSy8YTL9GNxgMKyLojaih+JCKFRV8sA50VDaMhL
         4ENhUxcmuP8buO31FrzpXihlkiHbj7xjQ5jQCZ/XAAfjoNJ005ZfE8KQlMXJnunKzCcO
         Fe2zvwkJ/uki5/MCqM+WcH9ckA1bFEYVaXIUmwP+4s7h2vpQxpmZaq/OfODYIqbWYJLH
         gNO1EGlemqhIu8SDpgbpJo6kXONx1A4ErgZXcMZMC3KoLi5/PQ7Kas2P+1tIIIXAXu47
         3GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424131; x=1690016131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rw+THIB7nYtdEoKFrcRpf+DtRSemfk8nQmXyWQCWLOU=;
        b=lw2pxdQzqtkCH1drc5e9D0bJ+V+3G0dIVMUusm2XIw+s+rLc6JoGbWFah3rPjODD4T
         NRVpIPpW5OEMXJwG41zcIPVinn5uSS7W8sYRT9Uaa0YcDhZYqfpqGGz1Ee8wyo5843hb
         cdAIGbyBNAjtcjvu80iWX62kKG/cC2Ux638vTseOHQcSem5SwqXcfIEa7wVoWg6xoXec
         8OJvyAthj23LC/u23C7qYuLsic29rz0Q8InrlPLT/Es5VabQe3edbhspU+kuhyS4iBXg
         apRaVrLGTbltCr586vPe1AUYMh/f8ttwsdEbL8QsTnKLhmSK89UcdFefqVKFPI46Nnjx
         OY0A==
X-Gm-Message-State: AC+VfDwFrXZkq2ZRe4xSZxqbD0pLvEGJzVmBcs4unvnRdrmzyGBHmmn3
        dZZGBY8BTS7LSJUsw0T4vXNaRQ==
X-Google-Smtp-Source: ACHHUZ74w6zUyxxONmkdhWFpbjqcQv1Ri8s1BW02LunWtr1K9sXtmODVbQHvvX6jLBNiniDuaX5mmA==
X-Received: by 2002:a17:902:d489:b0:1b4:ddef:841e with SMTP id c9-20020a170902d48900b001b4ddef841emr21417877plg.4.1687424131373;
        Thu, 22 Jun 2023 01:55:31 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:31 -0700 (PDT)
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
Subject: [PATCH 11/29] virtio_balloon: dynamically allocate the virtio-balloon shrinker
Date:   Thu, 22 Jun 2023 16:53:17 +0800
Message-Id: <20230622085335.77010-12-zhengqi.arch@bytedance.com>
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
we need to dynamically allocate the virtio-balloon shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct virtio_balloon.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b15936a5214..fa051bff8d90 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -111,7 +111,7 @@ struct virtio_balloon {
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
 
 	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 	/* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
 	struct notifier_block oom_nb;
@@ -816,8 +816,7 @@ static unsigned long shrink_free_pages(struct virtio_balloon *vb,
 static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
 						  struct shrink_control *sc)
 {
-	struct virtio_balloon *vb = container_of(shrinker,
-					struct virtio_balloon, shrinker);
+	struct virtio_balloon *vb = shrinker->private_data;
 
 	return shrink_free_pages(vb, sc->nr_to_scan);
 }
@@ -825,8 +824,7 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
 static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
 						   struct shrink_control *sc)
 {
-	struct virtio_balloon *vb = container_of(shrinker,
-					struct virtio_balloon, shrinker);
+	struct virtio_balloon *vb = shrinker->private_data;
 
 	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
@@ -847,16 +845,24 @@ static int virtio_balloon_oom_notify(struct notifier_block *nb,
 
 static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
 {
-	unregister_shrinker(&vb->shrinker);
+	unregister_and_free_shrinker(vb->shrinker);
 }
 
 static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 {
-	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
-	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
-	vb->shrinker.seeks = DEFAULT_SEEKS;
+	int ret;
+
+	vb->shrinker = shrinker_alloc_and_init(virtio_balloon_shrinker_count,
+					       virtio_balloon_shrinker_scan,
+					       0, DEFAULT_SEEKS, 0, vb);
+	if (!vb->shrinker)
+		return -ENOMEM;
+
+	ret = register_shrinker(vb->shrinker, "virtio-balloon");
+	if (ret)
+		shrinker_free(vb->shrinker);
 
-	return register_shrinker(&vb->shrinker, "virtio-balloon");
+	return ret;
 }
 
 static int virtballoon_probe(struct virtio_device *vdev)
-- 
2.30.2

