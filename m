Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C404179BD6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbjIKUzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbjIKJta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:49:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65555E40
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2684e225a6cso580442a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425766; x=1695030566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOFLy8aeJhd3LY/OhniqtUCJXkFQlNJLK1Gu0rv7etI=;
        b=PwsYykAGeRm1LMFnCOnXSEssUJlijcCLgN2DDAMGhdKKzPStOgksiV7+gXk/lHChiO
         tv1g6tycdghdPdcM/Ut9n5V8qKtXWp+RIORlQjjL46cUJOU8RR8/fx69s0pTNLU/D5jF
         pZOASRHB26JFkVtS5tzxw6EfjJH3PKjQhErePXe1uB8DfnX7LsMgIPH3u7btGVLvY3+G
         aLZNtMDkX65DUqVK6Nmz7+TfJmV1a/JajBVPCXQRAxVos5odvCINs/qd4SOu9hVFZ2JN
         7OidZaCCvkWyF4IuXbMp0m24R0Od/F7tL1vcgElU7EIAHRthekCjX2wty1fwk2Lkzk0P
         nsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425766; x=1695030566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOFLy8aeJhd3LY/OhniqtUCJXkFQlNJLK1Gu0rv7etI=;
        b=SF1chcFaHZZ5s6m0ReGnIGRzueo7CRHKJ/Fu97Ewn0MLgdV5MYByBcofWrzeg/pyHO
         SMVB187qLVGonKac3ziuJrdkesy//3RNqTv3b3V4EqjUmedCQtVi+UgOr32159rVI7kq
         znG8eY9LVzd6qWgLa9SozyA4MfmuqWxPi/AgrMg5rHaTK6EJP/jvcYd0zg60AYNjRybv
         amoqhgR4XyrbcYMsVQVBd/+GVmoJVQwhS/8JviLQdDlbmEtXaUs7c7O5C3EQtWRHBsjK
         Zopkbmo/l+nKKKLBcDhNyWtBghkaUA+gs3GeGyx8lPpkSCKZaMokCeVQ2dyzEIEwO2lr
         R/vQ==
X-Gm-Message-State: AOJu0YzEneUg57+g+z2zsmDGHJ07lmAKv+2stKg8cWp92H06wS6JWaA1
        3EaSoTGfJywqtSTGc3dkcF31Ug==
X-Google-Smtp-Source: AGHT+IFDkXMADJzJ5jjUq9PfJV9F8/TFu1J7WhBiuuPnpwyRrr8PIbDWnsDRVAoYbT3X6OqKjBwp8A==
X-Received: by 2002:a17:90a:6d26:b0:26b:5fad:e71c with SMTP id z35-20020a17090a6d2600b0026b5fade71cmr8202972pjj.2.1694425765927;
        Mon, 11 Sep 2023 02:49:25 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:49:25 -0700 (PDT)
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
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 28/45] virtio_balloon: dynamically allocate the virtio-balloon shrinker
Date:   Mon, 11 Sep 2023 17:44:27 +0800
Message-Id: <20230911094444.68966-29-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the virtio-balloon shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct virtio_balloon.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: David Hildenbrand <david@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: virtualization@lists.linux-foundation.org
---
 drivers/virtio/virtio_balloon.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b15936a5214..5cdc7b081baa 100644
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
@@ -847,16 +845,22 @@ static int virtio_balloon_oom_notify(struct notifier_block *nb,
 
 static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
 {
-	unregister_shrinker(&vb->shrinker);
+	shrinker_free(vb->shrinker);
 }
 
 static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 {
-	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
-	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
-	vb->shrinker.seeks = DEFAULT_SEEKS;
+	vb->shrinker = shrinker_alloc(0, "virtio-balloon");
+	if (!vb->shrinker)
+		return -ENOMEM;
 
-	return register_shrinker(&vb->shrinker, "virtio-balloon");
+	vb->shrinker->scan_objects = virtio_balloon_shrinker_scan;
+	vb->shrinker->count_objects = virtio_balloon_shrinker_count;
+	vb->shrinker->private_data = vb;
+
+	shrinker_register(vb->shrinker);
+
+	return 0;
 }
 
 static int virtballoon_probe(struct virtio_device *vdev)
-- 
2.30.2

