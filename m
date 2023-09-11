Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA5279BCEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjIKUyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbjIKJt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:49:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E71ED
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c3c4eafe95so469085ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425793; x=1695030593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZpBnX4Z9eqEuCcIq983vZteHkZX7uUM6cDHYd9irL8=;
        b=WTl7QxEdalYnW2SrShiVlmdwwFN+PosQHXFFjzkmbKshIgvY/Qq8VHEO7hyfaK6vum
         K8Rq5pxCYbxjvUIycBBB358ZDcgkFmD0asbURnuL1e3xIVkFkVTwGMrjurD8SY6IUasD
         PI9ZRFK+gxSNtDdM7BQHvwZs/tcfa2o5Hzaiujs5SOEUGxn55vIdxiPXoJYAqTVkooti
         PnrzX4J8xyw93eZEHns2FkUBaSj+h+2RRzDDqYfdG/R6Hg0539zjJSY4g1+3uu4Juk8x
         prlD2GZXWrjT4o8tIsOIjk+HqqmshTWL2yyBRSmRndDK0YSqWKq6fJFCqzKDj7mU7+3s
         7o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425793; x=1695030593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZpBnX4Z9eqEuCcIq983vZteHkZX7uUM6cDHYd9irL8=;
        b=rOw/h/VW+oMHK3GySE9+ovGZguwJd5PLJX6uGQzKPY2FjG4cj9frvIOyKC5luXbQJf
         tzOHZJbVCrJmHRM/esK4hGnWw+ZM04or35lsDbdwF/fNlG31sM+e8knVWFNdFmd92BTM
         mN0DUDczj73JplmG3f0xSsHo3PMXCNSHXcWDEbptUBQE8hCYWkfjKGjtZYiVMO3TSPUv
         hjVzglPQJRELrODoQAbZXQA2ckUQ4pqipTnqKuFZKvBzVGalOehfGCFOwNwe2Oc92kTe
         eAgoJ47V22qcnkdOGDalsf3y+Hoo1Tk8kk4FZvu3pdel8udgZI9CizMWd+GpzG03/oSL
         bEpg==
X-Gm-Message-State: AOJu0Yx4PawURX/St+N6tsd/e5CNPu87GnmJn9BDrqfITttuZjau+8u8
        Xhnk5JcuwjozBAsVhLH5X7vnuw==
X-Google-Smtp-Source: AGHT+IFvqXY+jnOST4BZIc6AyFCejSJWSQ6rLQGam1YrCI9mLJF9ktChTLGkYjxBiW6SC49Zt3tINQ==
X-Received: by 2002:a17:902:ced1:b0:1b8:a469:53d8 with SMTP id d17-20020a170902ced100b001b8a46953d8mr11187928plg.0.1694425792768;
        Mon, 11 Sep 2023 02:49:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:49:52 -0700 (PDT)
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
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: [PATCH v6 31/45] jbd2,ext4: dynamically allocate the jbd2-journal shrinker
Date:   Mon, 11 Sep 2023 17:44:30 +0800
Message-Id: <20230911094444.68966-32-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the jbd2-journal shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct journal_s.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Jan Kara <jack@suse.cz>
CC: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-ext4@vger.kernel.org
---
 fs/jbd2/journal.c    | 29 ++++++++++++++++++-----------
 include/linux/jbd2.h |  2 +-
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 768fa05bcbed..0ae19d527b22 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1290,7 +1290,7 @@ static int jbd2_min_tag_size(void)
 static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 					      struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long nr_to_scan = sc->nr_to_scan;
 	unsigned long nr_shrunk;
 	unsigned long count;
@@ -1316,7 +1316,7 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
 					       struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long count;
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
@@ -1588,14 +1588,21 @@ static journal_t *journal_init_common(struct block_device *bdev,
 		goto err_cleanup;
 
 	journal->j_shrink_transaction = NULL;
-	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
-	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
-	journal->j_shrinker.seeks = DEFAULT_SEEKS;
-	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
-	err = register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
-				MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
-	if (err)
+
+	journal->j_shrinker = shrinker_alloc(0, "jbd2-journal:(%u:%u)",
+					     MAJOR(bdev->bd_dev),
+					     MINOR(bdev->bd_dev));
+	if (!journal->j_shrinker) {
+		err = -ENOMEM;
 		goto err_cleanup;
+	}
+
+	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
+	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
+	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
+	journal->j_shrinker->private_data = journal;
+
+	shrinker_register(journal->j_shrinker);
 
 	return journal;
 
@@ -2170,9 +2177,9 @@ int jbd2_journal_destroy(journal_t *journal)
 		brelse(journal->j_sb_buffer);
 	}
 
-	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
+	if (journal->j_shrinker) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
-		unregister_shrinker(&journal->j_shrinker);
+		shrinker_free(journal->j_shrinker);
 	}
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 52772c826c86..6dcbb4eb80fb 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -886,7 +886,7 @@ struct journal_s
 	 * Journal head shrinker, reclaim buffer's journal head which
 	 * has been written back.
 	 */
-	struct shrinker		j_shrinker;
+	struct shrinker		*j_shrinker;
 
 	/**
 	 * @j_checkpoint_jh_count:
-- 
2.30.2

