Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FC786644
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbjHXDuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjHXDty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:49:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451A1FF6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a86b1114ceso349536b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848895; x=1693453695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCUdhxTNgYopmfrUvm5tWP9/UPIt4enx1ZSflKLoeW0=;
        b=kvKgrGQv1mYZZS4wF3iCkRztwK2mmzphcIiXW0hKBcBmpcBvr4ErwgCDxT0L2eW0Zv
         DJtsfJPfQXVQjgbnZU8cUPbTUerpeh1mFrxeeqphvRnfm0XvYoY6wkXj976IEu2KPv8M
         UY81aGvh1S2CZkAubHr77TRlgVTQj3S+O6bIip73XKRxSzJ3mZvjOtnJ5IA9wdPa4ZiS
         bWHD8dtc86fBmv8R6Lmll8JjHXVoefuawXEuLIf69c5aeNKZ5HFce3zJFQbqcfZDtHTW
         00qh3ZW5H0/jsYXIB/RBrVJBng/341ReHz9UooUbIAK8ltPn7oPpr+d+F95I3H7EoQOD
         4xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848895; x=1693453695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCUdhxTNgYopmfrUvm5tWP9/UPIt4enx1ZSflKLoeW0=;
        b=J3JM/gK7sSV1VYhQWSyp6J24bREgjyu+NOg6YLcdPmNsncXg5iexnBinDxexvMAbkC
         a1GcgPi5uSrDmhUxK2zxfKAjQxpEyXmJBALJaZWV1ztSO7AQDxLKpTl+DTemc6LgjMjW
         9g6bZ55uWsMx+MF+HGfBJ2vAYaGPsCmOGP9FlFFqv/xSbWv/hfDRcUJIA6adYY5tmzF5
         Fs25kSQ3aQba+6oSkSUI9W04rVN14F5j4gPkubr0m3rl8X+8UjOne1DHZJ0fobU3cCXg
         2/j5tcey157HgV6iMgllKA81Dd3VS5XKeUdRula8JK1s2n9qw0ttWLrsbi8T5UmOETnd
         RA0g==
X-Gm-Message-State: AOJu0YxpGlpIpx5xp5do3PNC0yBQ4g47aTgx5MQyvlEWowxMUTRj+HiL
        J5aa0QvfZUk3JFpcP2OIOaKJkA==
X-Google-Smtp-Source: AGHT+IH2JbF6bibig8NYJYSBcTW5xuf5z4s3TwsXtyBJWRygTdPzsu3RVfUJVPK/hAkIo2xRy+AgMQ==
X-Received: by 2002:a05:6808:180a:b0:3a7:8e1b:9d4f with SMTP id bh10-20020a056808180a00b003a78e1b9d4fmr16979066oib.3.1692848895236;
        Wed, 23 Aug 2023 20:48:15 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:48:14 -0700 (PDT)
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
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v5 30/45] ext4: dynamically allocate the ext4-es shrinker
Date:   Thu, 24 Aug 2023 11:42:49 +0800
Message-Id: <20230824034304.37411-31-zhengqi.arch@bytedance.com>
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
dynamically allocate the ext4-es shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct ext4_sb_info.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: "Theodore Ts'o" <tytso@mit.edu>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: linux-ext4@vger.kernel.org
---
 fs/ext4/ext4.h           |  2 +-
 fs/ext4/extents_status.c | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e5055eac42f6..353a7fcd609a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1653,7 +1653,7 @@ struct ext4_sb_info {
 	__u32 s_csum_seed;
 
 	/* Reclaim extents from extent status tree */
-	struct shrinker s_es_shrinker;
+	struct shrinker *s_es_shrinker;
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9b5b8951afb4..0532a81a7669 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1596,7 +1596,7 @@ static unsigned long ext4_es_count(struct shrinker *shrink,
 	unsigned long nr;
 	struct ext4_sb_info *sbi;
 
-	sbi = container_of(shrink, struct ext4_sb_info, s_es_shrinker);
+	sbi = shrink->private_data;
 	nr = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
 	trace_ext4_es_shrink_count(sbi->s_sb, sc->nr_to_scan, nr);
 	return nr;
@@ -1605,8 +1605,7 @@ static unsigned long ext4_es_count(struct shrinker *shrink,
 static unsigned long ext4_es_scan(struct shrinker *shrink,
 				  struct shrink_control *sc)
 {
-	struct ext4_sb_info *sbi = container_of(shrink,
-					struct ext4_sb_info, s_es_shrinker);
+	struct ext4_sb_info *sbi = shrink->private_data;
 	int nr_to_scan = sc->nr_to_scan;
 	int ret, nr_shrunk;
 
@@ -1690,13 +1689,18 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 	if (err)
 		goto err3;
 
-	sbi->s_es_shrinker.scan_objects = ext4_es_scan;
-	sbi->s_es_shrinker.count_objects = ext4_es_count;
-	sbi->s_es_shrinker.seeks = DEFAULT_SEEKS;
-	err = register_shrinker(&sbi->s_es_shrinker, "ext4-es:%s",
-				sbi->s_sb->s_id);
-	if (err)
+	sbi->s_es_shrinker = shrinker_alloc(0, "ext4-es:%s", sbi->s_sb->s_id);
+	if (!sbi->s_es_shrinker) {
+		err = -ENOMEM;
 		goto err4;
+	}
+
+	sbi->s_es_shrinker->scan_objects = ext4_es_scan;
+	sbi->s_es_shrinker->count_objects = ext4_es_count;
+	sbi->s_es_shrinker->seeks = DEFAULT_SEEKS;
+	sbi->s_es_shrinker->private_data = sbi;
+
+	shrinker_register(sbi->s_es_shrinker);
 
 	return 0;
 err4:
@@ -1716,7 +1720,7 @@ void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi)
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
-	unregister_shrinker(&sbi->s_es_shrinker);
+	shrinker_free(sbi->s_es_shrinker);
 }
 
 /*
-- 
2.30.2

