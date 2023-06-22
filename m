Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D8739A5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjFVImk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFVImI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:42:08 -0400
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0D268F
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:41:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687423279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcTjqzLQd71ZVb4pzslJvUSmaexvFgNd/hk+/QuqHC8=;
        b=sVEpWPhmhMKCP77bE/ObQ4vh36qd8p86S9YTJ/PP2t7O5H1rqOFnAADJATnE/Im2pGl6K+
        faUcWupfoFI2g9i9atXE0VwhccNnX7/0UsnRt6J1CWpSBlTlvvvrCKJ9m/IyCeNWLYDiY/
        S/WTlid4FLB0IXUx+GwQRgK3ap17RFE=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 11/29] virtio_balloon: dynamically allocate the virtio-balloon shrinker
Date:   Thu, 22 Jun 2023 08:39:14 +0000
Message-Id: <20230622083932.4090339-12-qi.zheng@linux.dev>
In-Reply-To: <20230622083932.4090339-1-qi.zheng@linux.dev>
References: <20230622083932.4090339-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

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

