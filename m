Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C286786633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjHXDto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239796AbjHXDrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4461BF0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a751bd3372so714428b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848840; x=1693453640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TonPN3sOzzr59sXAa9zxRsvaBjeGBq6wcTvb6FyTRQ=;
        b=bbA3Zsc7IUD2am3ZTycHTYFrd1TQOR2glffiwOM82rWGJwmsEaewPHgueylM3TI4X4
         0fy4O6kMrGiUtL6xCEMYVrA+5o0Hn4Kl2D80XUo6h+baumFzOxU3hlmu5grhjO+IbPzm
         0Uz4Dp92EA1hhQawccSf0cOE3hJY+x9I9BT2m0Ds2y/4AnFG96IDKy5xezBiRKN7Ab6Q
         PgHyunTCKsFw+M5x4A8AQoFknpJ2TzQZwk+4YGLx+7riuxwrefcMbTmVYfJj2kzThdO+
         gDjVOwdTnyJz+D7/eOkQqtXKM2jWS7D+5yPSU6HoCPAEzbJ75/odbhA8G4sUffTeNM2E
         kT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848840; x=1693453640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TonPN3sOzzr59sXAa9zxRsvaBjeGBq6wcTvb6FyTRQ=;
        b=IRULn7Ue+TNseHckFLo9aHK3Y8GPTV4CT77O7JH5gptgiKQEQhGEMdJUogwlaroaFA
         9wKIQJa8IT31oiVj8WIEQNUZLSELz/qWQttfSoAj2RFBEcwAnwKR7Wa5ZPJ6K5NMgwml
         Jn255Df2GIpTY2dCmkkrpFbCpHoZ3YLpKe4VW7JqlRQ+VdTOtLHowR45ifriCUHVbBYN
         y1z0//kOtXlVsQsIQFeBZancBkTbj8woyrs7zViO7zZ7ryq8N2Mrzuel0aI+pbHViVnM
         Xbdeo4eOeA5e9ac1O2+9++3C89c1aPSAkBvejT2W1Nf3HHaY7h2pPSQWOXZ52Sm2f1hQ
         wm0A==
X-Gm-Message-State: AOJu0Yz9M5lzMSeff3d6h6BX7qnWiXiNbIhFuy7EhoAiZz2vv+rNTM0B
        H5CVFkwCFk4/8lFUnph09XCxgA==
X-Google-Smtp-Source: AGHT+IE6mZg6R/C4hkqYLeG6aoFn5MZe1GYXgvIXJGbCBTW0CHE8uReLaaEVve/T8KY77idOwBUD4A==
X-Received: by 2002:a05:6808:448d:b0:3a7:56a6:bd2b with SMTP id eq13-20020a056808448d00b003a756a6bd2bmr15345498oib.4.1692848840631;
        Wed, 23 Aug 2023 20:47:20 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:47:20 -0700 (PDT)
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
Subject: [PATCH v5 24/45] dm zoned: dynamically allocate the dm-zoned-meta shrinker
Date:   Thu, 24 Aug 2023 11:42:43 +0800
Message-Id: <20230824034304.37411-25-zhengqi.arch@bytedance.com>
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
dynamically allocate the dm-zoned-meta shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct dmz_metadata.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Alasdair Kergon <agk@redhat.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: dm-devel@redhat.com
---
 drivers/md/dm-zoned-metadata.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 9d3cca8e3dc9..bbb0e69a7908 100644
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
@@ -2936,19 +2936,24 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
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
+		ret = -ENOMEM;
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
@@ -2995,7 +3000,7 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
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

