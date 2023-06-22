Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF3739B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjFVI7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjFVI6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:58:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289452940
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b693afe799so2465225ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424148; x=1690016148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFTuD75yazkbkprx1nDK+J2a+gsKcpdTH5uLLFxlsCE=;
        b=YL01pLqxeJdJ3yx7vlwGwrScHLp900A8hEE3Wf+RWJNlhx4L8kHsp9yLDKLvMKBCnC
         3rsy/Bt3MovGZd9xDykjB2GgcKTKrjV0UKR/p/LUcqeAgCcK1oeyqL4lKiu0nVi2NGBN
         TaYF2c0QLLlLRjtauaahzpKEMrC5bmEQ14igH5gpZVZzZ5PZmJEXxyLsPSab+WZLJtP7
         soRQ7v+HKrW5nh3UOzeGEOAr+30lPAAddvMLxo2KnZ7MK/KtFrltdlmvaznhvWw7dzRl
         oronsxPEPE0DLPq3etiyjPQ96cDhygWHhtXaurPBhnnq3MU+faq6ga287Qti+jNFsnPy
         uaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424148; x=1690016148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFTuD75yazkbkprx1nDK+J2a+gsKcpdTH5uLLFxlsCE=;
        b=TnrszB+EEXeOxHhQ54kwBif6MRW1qKPYIOZ8tcEFp08zH1tTdNznifWUmFjs+2Ut/J
         3MiRuDClsa5EwUlsVI1zpT9DUMxVJMLwM/z+GIJfm9kKbw3sw9KU1PEV77mQCXqYmzlJ
         TXh2tONMCtaOOo6lpgs+Rr1QCHLjpuWuLsL/JP6aLP/OTROs2fT1ACT2jlne5/CppQBk
         xiLgqfEXcCitwO/6HVhtYMMfR6E07jgoH+DCZkdrg7w7YpBPylWIn4B9iouyeIouC7Jl
         bBC4t9iPCcBUPrtg1zoeGnymZnlmPQN8vF2YvgeTg4Uwg8l5vBTC76HtpFMUm//T1Wew
         PawQ==
X-Gm-Message-State: AC+VfDx26PAIGlYADO5iBVWytKK+scITvrsLIcX97mm63drxmW61B0uI
        4faKgkt5MQtxJDJlR4j3lvhfAg==
X-Google-Smtp-Source: ACHHUZ6jVuCzKKZsdSS1vKWkjhi+wc7lz2Kfe1cJ6l4zUout3MX707Lbn9nWcxBb7Ur8w7srUJ3z+g==
X-Received: by 2002:a17:903:2451:b0:1b0:34c6:3bf2 with SMTP id l17-20020a170903245100b001b034c63bf2mr21540496pls.5.1687424148210;
        Thu, 22 Jun 2023 01:55:48 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:55:47 -0700 (PDT)
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
Subject: [PATCH 13/29] ext4: dynamically allocate the ext4-es shrinker
Date:   Thu, 22 Jun 2023 16:53:19 +0800
Message-Id: <20230622085335.77010-14-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the ext4-es shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct ext4_sb_info.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/ext4/ext4.h           |  2 +-
 fs/ext4/extents_status.c | 21 ++++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..1bd150d454f5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1651,7 +1651,7 @@ struct ext4_sb_info {
 	__u32 s_csum_seed;
 
 	/* Reclaim extents from extent status tree */
-	struct shrinker s_es_shrinker;
+	struct shrinker *s_es_shrinker;
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9b5b8951afb4..fea82339f4b4 100644
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
 
@@ -1690,15 +1689,19 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 	if (err)
 		goto err3;
 
-	sbi->s_es_shrinker.scan_objects = ext4_es_scan;
-	sbi->s_es_shrinker.count_objects = ext4_es_count;
-	sbi->s_es_shrinker.seeks = DEFAULT_SEEKS;
-	err = register_shrinker(&sbi->s_es_shrinker, "ext4-es:%s",
+	sbi->s_es_shrinker = shrinker_alloc_and_init(ext4_es_count, ext4_es_scan,
+						     0, DEFAULT_SEEKS, 0, sbi);
+	if (!sbi->s_es_shrinker)
+		goto err4;
+
+	err = register_shrinker(sbi->s_es_shrinker, "ext4-es:%s",
 				sbi->s_sb->s_id);
 	if (err)
-		goto err4;
+		goto err5;
 
 	return 0;
+err5:
+	shrinker_free(sbi->s_es_shrinker);
 err4:
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
 err3:
@@ -1716,7 +1719,7 @@ void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi)
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
-	unregister_shrinker(&sbi->s_es_shrinker);
+	unregister_and_free_shrinker(sbi->s_es_shrinker);
 }
 
 /*
-- 
2.30.2

