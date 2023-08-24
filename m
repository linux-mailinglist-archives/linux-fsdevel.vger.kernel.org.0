Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4B786607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjHXDpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbjHXDpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:45:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E3110F0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68824a0e747so1237890b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848690; x=1693453490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH+UWxgsfED4SOG31SRsciPnOVwoHjCv5sMnfhtq6Bc=;
        b=L5s18IvPmkO1Yi1aX8xoUBVbVs+NYj2wes5Iop5itsw/50mmjZRe3mo5xjdm+YoYr+
         LilfHyHML7A/wtK+y3tmj6oJnO9F477J4r8ASwXsJMy1GqlaxC/IRlgArGQhd91MGOHK
         3A/nIh3uIHjjesEmVDhRjQQGnpOSt+ZUZIXZCdxBGM+Ld1QW0fUX6EUASA/OZvpRDifX
         PZxVf/aQ+feX6zs1fU4hK4chLezuy6pKGNDjYDnCsIRpGw/8fLGUh1PWhw7uWepXLMd7
         7iamIzVc5Mglw5KEkqKNqjKvoDX13NmQ/PUea91yy3q87XQGMlCFJxJ4OLm3P8rzsoMA
         cazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848690; x=1693453490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RH+UWxgsfED4SOG31SRsciPnOVwoHjCv5sMnfhtq6Bc=;
        b=WwTPn123gC1BnEXqusfvF/TMJOoUQj/TQJk9sVKq0MLAROY7wUwEBzYfYStXuGq5bU
         oLeRoJSCKaVgeIasYCpzi9wttByAYbGFxFIO8e7Pm2LYe0jPc/xmS3HtuGgdpncdM/0f
         zTJwj3OgWgWRR5Zux3CfK28zF9v78KyJnz4oqfhvgFsD4UhFnGegSyMVjJnJXwfu4ugl
         YNtkip9VzCG8nLvBrlS0qZjU8UEtb5vaMgfD6AnBx51vIk+PK76du3bl8WyvoB/F8EmG
         3VUw8eOFXxrpd3NTDgzZIvgr+LTl52YLZKU23c8dyokRLPbII+C57JpX1tNQHdJ7Uvy6
         aF+w==
X-Gm-Message-State: AOJu0Ywx5yZVLjkGcqnB0TLYfKQBbT+m2NnIsIa8SYbSyoQMWA+ZpUPZ
        9RD88ibkwRJ0p1uYMWvjcDp8WQ==
X-Google-Smtp-Source: AGHT+IGADDIb7FS/BEzlD2NDaSR5lL9y4k3FkTUBZvyAz9qvN4bXZycSD4+PZlpH8/QgOFEsYt18oQ==
X-Received: by 2002:a05:6a00:1d85:b0:68a:6cec:e538 with SMTP id z5-20020a056a001d8500b0068a6cece538mr7248281pfw.3.1692848690333;
        Wed, 23 Aug 2023 20:44:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:44:49 -0700 (PDT)
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
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v5 07/45] f2fs: dynamically allocate the f2fs-shrinker
Date:   Thu, 24 Aug 2023 11:42:26 +0800
Message-Id: <20230824034304.37411-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the f2fs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/super.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 050f4f8ee8f5..86047da85856 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -83,11 +83,27 @@ void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
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
+	f2fs_shrinker_info->seeks = DEFAULT_SEEKS;
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
@@ -4944,7 +4960,7 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_sysfs();
 	if (err)
 		goto free_garbage_collection_cache;
-	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
+	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
@@ -4989,7 +5005,7 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
 free_garbage_collection_cache:
@@ -5021,7 +5037,7 @@ static void __exit exit_f2fs_fs(void)
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

