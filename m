Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF37F764C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjG0IWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjG0IUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:20:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE9A7A99
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:12:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-682eef7d752so204441b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445490; x=1691050290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze2BfjPj3zI6XK14aBXxwpj9cG5VKS+QoT9VkWxAsig=;
        b=lwOoY+OdQN9yyaycuuDe1xOBPNuMdpjPWf9iVdWyTJX4Rze1Ujyu7FqyyXfPUD3aU2
         0geNSiBV+SjLplmH7ILvbtRHCHKM3vLFmOVDmsv1BEm9fkWkTRAM1imR53z99mDpf0IW
         ffoAdzAoMkEyhpVqT3oRFQGqTsCjJOMqkqnQ0DFV07QdT6HdoSrpGoFduwBz2OfpOwFt
         CWOX0mmKGcSRamco0Cg7QpPpz6Lx/kpTjodIKj6Sfbh0QvlZA2O3b8FhSM1hAbz32D/P
         0DhVwgLc1Xu9esSsJfTXPYkz1XSyCT4LoDf/9vVVRpeHu2USWPZ+XNt9qGqYRzfEx2BR
         Y6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445490; x=1691050290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze2BfjPj3zI6XK14aBXxwpj9cG5VKS+QoT9VkWxAsig=;
        b=LUIO7ftYI/RADF6H5+BrqDliVOXrWS1jjVbPHC6wnVlpAz4f9NWDofFEQ7d+ZaZy2o
         jfOwxBySWe6qUpKQPs4ndr6NtnG2sMTa0XPn91qJeCfma0tgG0Fls0j2/I78AhMO8tWC
         TH0k4e6M66VVz2qastamHJGiF//conUR2Y/MZymjVGk6aikXcC2YYbbfgYcCB47pq9Dk
         pvY8mBGBQQvIzSCXulYOwywZQgMOkOwOJCu3q30JOHiqUdEtUi6CpLZNjB8GmP0Ww2ae
         nSsHZ+asUhTrFDBV/sdY770FIRecfVtWeT/sUUK+flyGxNIx4x+roY+zcykeWKr9k3Uy
         biOQ==
X-Gm-Message-State: ABy/qLbZVJSDg9PPLPGOflp9zByBhEPgnA96rQ8GH49P9DgcD/z2KSBf
        fbmd3IKQSE8XA1ALvsXkeGKe+w==
X-Google-Smtp-Source: APBJJlFMZtECqV3NWJubuagzux89byKCTiavknA18umD2w/BadGADzl49oXppHX8YppKwxO9L0rdOg==
X-Received: by 2002:a05:6a00:1586:b0:67f:8ef5:2643 with SMTP id u6-20020a056a00158600b0067f8ef52643mr5208150pfk.2.1690445490190;
        Thu, 27 Jul 2023 01:11:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:11:29 -0700 (PDT)
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
Subject: [PATCH v3 28/49] dm zoned: dynamically allocate the dm-zoned-meta shrinker
Date:   Thu, 27 Jul 2023 16:04:41 +0800
Message-Id: <20230727080502.77895-29-zhengqi.arch@bytedance.com>
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
dynamically allocate the dm-zoned-meta shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct dmz_metadata.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/md/dm-zoned-metadata.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 9d3cca8e3dc9..0bcb26a43578 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -187,7 +187,7 @@ struct dmz_metadata {
 	struct rb_root		mblk_rbtree;
 	struct list_head	mblk_lru_list;
 	struct list_head	mblk_dirty_list;
-	struct shrinker		mblk_shrinker;
+	struct shrinker		*mblk_shrinker;
 
 	/* Zone allocation management */
 	struct mutex		map_lock;
@@ -615,7 +615,7 @@ static unsigned long dmz_shrink_mblock_cache(struct dmz_metadata *zmd,
 static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
 					       struct shrink_control *sc)
 {
-	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
+	struct dmz_metadata *zmd = shrink->private_data;
 
 	return atomic_read(&zmd->nr_mblks);
 }
@@ -626,7 +626,7 @@ static unsigned long dmz_mblock_shrinker_count(struct shrinker *shrink,
 static unsigned long dmz_mblock_shrinker_scan(struct shrinker *shrink,
 					      struct shrink_control *sc)
 {
-	struct dmz_metadata *zmd = container_of(shrink, struct dmz_metadata, mblk_shrinker);
+	struct dmz_metadata *zmd = shrink->private_data;
 	unsigned long count;
 
 	spin_lock(&zmd->mblk_lock);
@@ -2936,19 +2936,23 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
 	 */
 	zmd->min_nr_mblks = 2 + zmd->nr_map_blocks + zmd->zone_nr_bitmap_blocks * 16;
 	zmd->max_nr_mblks = zmd->min_nr_mblks + 512;
-	zmd->mblk_shrinker.count_objects = dmz_mblock_shrinker_count;
-	zmd->mblk_shrinker.scan_objects = dmz_mblock_shrinker_scan;
-	zmd->mblk_shrinker.seeks = DEFAULT_SEEKS;
 
 	/* Metadata cache shrinker */
-	ret = register_shrinker(&zmd->mblk_shrinker, "dm-zoned-meta:(%u:%u)",
-				MAJOR(dev->bdev->bd_dev),
-				MINOR(dev->bdev->bd_dev));
-	if (ret) {
-		dmz_zmd_err(zmd, "Register metadata cache shrinker failed");
+	zmd->mblk_shrinker = shrinker_alloc(0,  "dm-zoned-meta:(%u:%u)",
+					    MAJOR(dev->bdev->bd_dev),
+					    MINOR(dev->bdev->bd_dev));
+	if (!zmd->mblk_shrinker) {
+		dmz_zmd_err(zmd, "Allocate metadata cache shrinker failed");
 		goto err;
 	}
 
+	zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
+	zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
+	zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
+	zmd->mblk_shrinker->private_data = zmd;
+
+	shrinker_register(zmd->mblk_shrinker);
+
 	dmz_zmd_info(zmd, "DM-Zoned metadata version %d", zmd->sb_version);
 	for (i = 0; i < zmd->nr_devs; i++)
 		dmz_print_dev(zmd, i);
@@ -2995,7 +2999,7 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
  */
 void dmz_dtr_metadata(struct dmz_metadata *zmd)
 {
-	unregister_shrinker(&zmd->mblk_shrinker);
+	shrinker_free(zmd->mblk_shrinker);
 	dmz_cleanup_metadata(zmd);
 	kfree(zmd);
 }
-- 
2.30.2

