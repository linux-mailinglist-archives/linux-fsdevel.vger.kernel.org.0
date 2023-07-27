Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308B764C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjG0IUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjG0ITU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:19:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B8C7688
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:11:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f74a8992so78043b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445477; x=1691050277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uDURfJnJhgp6SdQN0dR835bsVpn4QFEXgmrOE/fnW4=;
        b=XMYYvlyXrTmu7TBUMUrS0fAERGM3ULbRWCn4in2BRNinhRwId1ryL35VoKr2h4Rx+U
         HjLlRWIKGbBKN0lkokdfiXe7DL4/cW8JhUixM/OhO46u6zDYby/ZSHvD4zMfuAy6v0wa
         kMUIVYEZOCmoajTRWB9O5pPKf2KXDL1RA9QX/iWGDKdd+7AiEQpaXll5+7XF5hXMtboW
         QGfdfOEZoiLr6B07ra4S8ESol/cU0lfuHqis0vxsY6ajpZNCyt33YYUETwhkXmLJyVVM
         wWI0H3b2jkyty5FrIH3eGt0u2K+zpCq6JQc2FhUeW7es/kOOMNTlHxQiuG1Uqt5RUvfA
         07oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445477; x=1691050277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uDURfJnJhgp6SdQN0dR835bsVpn4QFEXgmrOE/fnW4=;
        b=hHSfcONZdCY3834ppI0MO1trg0N4tyuLDkFaa4B2VYENvz+lnsJuuyhvPeJkxPgr38
         PrZXmW+2S5VELpPxlWgVbXK13HpLXB348xlJUY1FeqEAcZPI0lFWB1zL+C+qAGsKMRak
         pwLO/d124vGa3SBhfuqzOW00u4n5kmdBgwTLYSXxXeO1z7pcIx64v8gzp1MTavwayOdp
         2kOQOBc6Bt/GoV6cOs1UE9HXbExYyweqAXGs7IshOZsoxeSqV1sp2K5yq/1QjWR+a3DZ
         jB5H7nB6OcJ8m6kt1OIRkMmhzB6m2k17TGeGjkpcVfIxsndMdOEgWKUn1P/B85YfQswZ
         8F5g==
X-Gm-Message-State: ABy/qLYd3WrPN6R2vU72Cfs2PaSc11mYI9bjlKNmYzzQ4K+IKUfLqRPG
        Dng6+PLj4zK7Gk5nPnLNiMlaJg==
X-Google-Smtp-Source: APBJJlG87NINI+/+i4SJ1KgSTM1EJ+JwVd/Dy5o7cICQ6coQ1cuBExOC2izM/xbO/Jy48XOYsOKRHA==
X-Received: by 2002:a05:6a00:2b90:b0:67d:308b:97ef with SMTP id dv16-20020a056a002b9000b0067d308b97efmr4590349pfb.2.1690445477689;
        Thu, 27 Jul 2023 01:11:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:11:17 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 27/49] dm: dynamically allocate the dm-bufio shrinker
Date:   Thu, 27 Jul 2023 16:04:40 +0800
Message-Id: <20230727080502.77895-28-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the dm-bufio shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct dm_bufio_client.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/md/dm-bufio.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index bc309e41d074..5a9124b83d53 100644
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
@@ -2490,15 +2490,19 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
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
+	if (!c->shrinker)
 		goto bad;
 
+	c->shrinker->count_objects = dm_bufio_shrink_count;
+	c->shrinker->scan_objects = dm_bufio_shrink_scan;
+	c->shrinker->seeks = 1;
+	c->shrinker->batch = 0;
+	c->shrinker->private_data = c;
+
+	shrinker_register(c->shrinker);
+
 	mutex_lock(&dm_bufio_clients_lock);
 	dm_bufio_client_count++;
 	list_add(&c->client_list, &dm_bufio_all_clients);
@@ -2537,7 +2541,7 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 
 	drop_buffers(c);
 
-	unregister_shrinker(&c->shrinker);
+	shrinker_free(c->shrinker);
 	flush_work(&c->shrink_work);
 
 	mutex_lock(&dm_bufio_clients_lock);
-- 
2.30.2

