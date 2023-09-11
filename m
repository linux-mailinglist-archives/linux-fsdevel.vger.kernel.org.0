Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D36679B05C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbjIKU5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjIKJra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D9AE4F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:05 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5657ca46a56so444984a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425625; x=1695030425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/NLyvMhlfztd4qbZrL/omLXYwwIYQMNFU1MSKt3KHU=;
        b=Zqk0q2lHhsVpuwpvzxLmqDK85EddZO8tAvV9tjuY21Xw/Z1aa10y81Za8Qqt8MOuBB
         x44f++KfDbCQVSjuqPLm2TpsvHjLYaesf8mLnpCQYMDOjMtLRjJWbVf2MWdzyT+k2cPK
         adkJv8CBZmKv2q8cRKgIjuk1K/0HE2ai/W0GJQJE0rxobPA/ofN3Bh1pQAIDe9cZ3meH
         l+OORyEtbDJ9uJgL7NkEzSfWANGl7PdtearjDTwOVQHgQT7//KrkVoH5OKP26QrnDVVk
         9SQzoIIms4udo7F2Z3mkuQ5ch2aOUfUxrWcU8aLxV7tLli2T3MHA3EDVj55Hks2UKEJY
         +/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425625; x=1695030425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/NLyvMhlfztd4qbZrL/omLXYwwIYQMNFU1MSKt3KHU=;
        b=k9E1KVrMAPVtZcYnSW5ydgR+kEGj+EK19Mp4voIxvjxlKRsNF3691EKusK6quuNiMA
         1WLqSAa5S9TosGh8j99rbkVxWdeZom+UijyGRyPVC0XalCxM6q0C7AIpQp7hCr5rmDlv
         lt5yg+uOqzSI/1Y4k/UNWAcOL55FC2QT328sEa98awV2aswnWjZme1/YjgoFa/co/zi+
         NoUSwnwvlA51i7c9xvKjIaViJFDFfQpu173zjmf3dtYC4+8J3ATMxAsVCKD/ZAC+I2l+
         K8L3G403JURoElewX/MCUV3E9mGrVpX+T1fBBmwYlI8buAdvDSk00USSB+k0tlYjpmYX
         Mrwg==
X-Gm-Message-State: AOJu0Yy+beqJFiGe+DmL8FbgWep+BWs158OGsl9vEPzrdUqA0gDSBtVb
        2DmxKyzBhwfx/O/GicwC+hMYIg==
X-Google-Smtp-Source: AGHT+IGDEIcfsclwcXdbuDvH8sZ7NfMus7y6m3aPNdiNFM1+TgiFCKX9tglqgiD/ZZx6tB1zl6Vfxw==
X-Received: by 2002:a05:6a21:a587:b0:123:3ec2:360d with SMTP id gd7-20020a056a21a58700b001233ec2360dmr13693947pzc.5.1694425625285;
        Mon, 11 Sep 2023 02:47:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:04 -0700 (PDT)
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
        Muchun Song <songmuchun@bytedance.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v6 13/45] quota: dynamically allocate the dquota-cache shrinker
Date:   Mon, 11 Sep 2023 17:44:12 +0800
Message-Id: <20230911094444.68966-14-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the dquota-cache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9e72bfe8bbad..15030b0cd1c8 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -791,12 +791,6 @@ dqcache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	percpu_counter_read_positive(&dqstats.counter[DQST_FREE_DQUOTS]));
 }
 
-static struct shrinker dqcache_shrinker = {
-	.count_objects = dqcache_shrink_count,
-	.scan_objects = dqcache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
-
 /*
  * Safely release dquot and put reference to dquot.
  */
@@ -2956,6 +2950,7 @@ static int __init dquot_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
+	struct shrinker *dqcache_shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -2990,8 +2985,14 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
-		panic("Cannot register dquot shrinker");
+	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
+	if (!dqcache_shrinker)
+		panic("Cannot allocate dquot shrinker");
+
+	dqcache_shrinker->count_objects = dqcache_shrink_count;
+	dqcache_shrinker->scan_objects = dqcache_shrink_scan;
+
+	shrinker_register(dqcache_shrinker);
 
 	return 0;
 }
-- 
2.30.2

