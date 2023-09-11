Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE31E79BD8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbjIKUz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjIKJqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9AED
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3aa44c0faso1780585ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425571; x=1695030371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2z5ZP0td7rQio33ZrusFB6X25vGZrzEp4fIJ4zc7l4=;
        b=HSpP6V8JhO7VGQ498iaJcQvf8Rf9W7pEOTG1Ylcv2Z5iBXeI/rdJxydxeluCIFALFF
         hE3FoN2SSZFvLUUx5tuOuipaYQO4NG8Tj8eqJqZjzEO41XsOBWN8QW+qM5acytu3VIri
         m8ONKUMBc77sU11Nt9RAHikB/6NJkdOBnxfrX4sVFsa6KUYLDZyp+FJkmWucWmZTDeDP
         lC3rnkG5+7K/WokzPQTHdFqbe8ciitg2sgANNs4xKEDdcCLqHvtKaMvR5IOmXhXWgthz
         bMXrnaSNT7hOdAZOMwN7kklUzK0Pcl/OrFRkFJtCgij1xk9cfdi6EL71tlk7HOQ47nYH
         wScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425571; x=1695030371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2z5ZP0td7rQio33ZrusFB6X25vGZrzEp4fIJ4zc7l4=;
        b=TpIomgPxYut9XYLRRxmWVl7+H6ZkyarzvH0PLtdn3zz1cDtoXtP1pdTIRQtgvzUxE9
         4eN68iuy6xASDK8a4RjKgnyr2cduUhEY6g2lfLGGa6qW29JCx0GllyBXJcRS8IX0Zocx
         z3rFw6FIAaX/ypE3xRoxc9NkBW95tj/rD0HcjHWKWZSSTYlM33AbpE6AriHkeNCYyR3g
         ldHnZCIdl387XK/4XP505Kw98xHvjXGT1FIEwU/zsXhx4bc8/vkw1NKlZtW/houBqswh
         8k05gw8ztTRKFWJytpBnrM+E4/vJLgtQ27s7Rh4ScLs8zYLhk7WXCvCJSX7jEmYaZV5r
         akLA==
X-Gm-Message-State: AOJu0YzXJwAc1bFcdgKfykfCKv2eWtoBwfJvs2yglHrN0mVnzekfwhFR
        u1DZE9DAN9+6z2Qflfn+lwDZEw==
X-Google-Smtp-Source: AGHT+IGMazOb/vYj+YAbB56aNimJAjHvQ95oEZj3vNPDNUhDjsPyS/sjYbZ6xZxadrVaoBmmMuhKhg==
X-Received: by 2002:a17:902:da92:b0:1b8:2ba0:c9a8 with SMTP id j18-20020a170902da9200b001b82ba0c9a8mr11823440plx.2.1694425571312;
        Mon, 11 Sep 2023 02:46:11 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:10 -0700 (PDT)
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
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v6 07/45] f2fs: dynamically allocate the f2fs-shrinker
Date:   Mon, 11 Sep 2023 17:44:06 +0800
Message-Id: <20230911094444.68966-8-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the f2fs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Chao Yu <chao@kernel.org>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/super.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb..fe25ff9cebbe 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -83,11 +83,26 @@ void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
 #endif
 
 /* f2fs-wide shrinker description */
-static struct shrinker f2fs_shrinker_info = {
-	.scan_objects = f2fs_shrink_scan,
-	.count_objects = f2fs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *f2fs_shrinker_info;
+
+static int __init f2fs_init_shrinker(void)
+{
+	f2fs_shrinker_info = shrinker_alloc(0, "f2fs-shrinker");
+	if (!f2fs_shrinker_info)
+		return -ENOMEM;
+
+	f2fs_shrinker_info->count_objects = f2fs_shrink_count;
+	f2fs_shrinker_info->scan_objects = f2fs_shrink_scan;
+
+	shrinker_register(f2fs_shrinker_info);
+
+	return 0;
+}
+
+static void f2fs_exit_shrinker(void)
+{
+	shrinker_free(f2fs_shrinker_info);
+}
 
 enum {
 	Opt_gc_background,
@@ -4944,7 +4959,7 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_sysfs();
 	if (err)
 		goto free_garbage_collection_cache;
-	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
+	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
@@ -4989,7 +5004,7 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
 free_garbage_collection_cache:
@@ -5021,7 +5036,7 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
 	f2fs_destroy_extent_cache();
-- 
2.30.2

