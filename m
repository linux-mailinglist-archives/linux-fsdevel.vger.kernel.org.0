Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0BA78661E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjHXDrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbjHXDq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:46:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F421FD0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so755959b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848751; x=1693453551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txor78tbBDUbFlDeMsr+ZFPB/YYvYFMci1CkfHTVP5Y=;
        b=f2vdVUxrd53niqhHN3lu7O/qQCjl9NcyQMCaxNn5T6viuJuL5MKYfAonmu/gm5BijH
         nC5Wpi4a7PWBB7q8tUPiP0oHBb2PXMLT03b/6gYrtmaZCnd6Mt+uzRWvKmEXemtjQCQG
         ZqOtchTpFwMV/kb2DFtC6mLoj+uRINLATigvC/sQxB1HuNKMTQhQNfDZaNKW7QuCPmlO
         ar3szccuZEbmvlHzXFE8IKU2droLxg3xvWMPq6hPvSFYUp81Eg8+xfvSTACAFhtcNIz4
         psn56S58o40IpPO+R5N36OuNZcU3R6vH+0jY7JcoeFkHzXkKohk/Mg5hsgTkh16avUea
         DzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848751; x=1693453551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txor78tbBDUbFlDeMsr+ZFPB/YYvYFMci1CkfHTVP5Y=;
        b=Yg3ZQGzsWlMcMwm2+gd5VgEdZf8mAiDwrATP5JOCc0Qbis8fKalGVWahMqAs0H1cOi
         Jlk+aLfnAdGKb1L5lEr309jNg+PeVoIAwv8xfT6+7pv8gQXuJUsVqK7a28skhMgfRwga
         WfslUAzDPMMfDpqptsuBhQUPUJMk9SLoWJHlQxfofBMBaWundqtUN9fvIAmyIB05/hrH
         CJl6mBi9vd/EMvpZBL8Ot+qV10agTYTlPKooUnu9gpa62d/+52gJ9G4HZxYOwXeJyBN1
         wX3pQAR+lHyvs1tilaSUT4vN3jW1jrBhytqr/OrOkJ64PL6mfefE5SbmnEOf5FY/dq44
         SiZA==
X-Gm-Message-State: AOJu0YxwOds1YaaFNgIqkvI8/lrFwcIfAZc/tWW+8tfXluOuEw37upY3
        6nswXeWyaxYNiKv4IR00mEExqw==
X-Google-Smtp-Source: AGHT+IEvg2+/eMxtzAUOdXGTx3O6wsmWYf8GYszkDdU34p+/e066zZfZMwabjJVp+KFh4Fxn8XPDyg==
X-Received: by 2002:a05:6a00:1d87:b0:67f:8ef5:2643 with SMTP id z7-20020a056a001d8700b0067f8ef52643mr15497296pfw.2.1692848751025;
        Wed, 23 Aug 2023 20:45:51 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:45:50 -0700 (PDT)
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
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v5 14/45] ubifs: dynamically allocate the ubifs-slab shrinker
Date:   Thu, 24 Aug 2023 11:42:33 +0800
Message-Id: <20230824034304.37411-15-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the ubifs-slab shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Richard Weinberger <richard@nod.at>
CC: linux-mtd@lists.infradead.org
---
 fs/ubifs/super.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b5..c690782388a8 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -54,11 +54,7 @@ module_param_cb(default_version, &ubifs_default_version_ops, &ubifs_default_vers
 static struct kmem_cache *ubifs_inode_slab;
 
 /* UBIFS TNC shrinker description */
-static struct shrinker ubifs_shrinker_info = {
-	.scan_objects = ubifs_shrink_scan,
-	.count_objects = ubifs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *ubifs_shrinker_info;
 
 /**
  * validate_inode - validate inode.
@@ -2373,7 +2369,7 @@ static void inode_slab_ctor(void *obj)
 
 static int __init ubifs_init(void)
 {
-	int err;
+	int err = -ENOMEM;
 
 	BUILD_BUG_ON(sizeof(struct ubifs_ch) != 24);
 
@@ -2439,10 +2435,16 @@ static int __init ubifs_init(void)
 	if (!ubifs_inode_slab)
 		return -ENOMEM;
 
-	err = register_shrinker(&ubifs_shrinker_info, "ubifs-slab");
-	if (err)
+	ubifs_shrinker_info = shrinker_alloc(0, "ubifs-slab");
+	if (!ubifs_shrinker_info)
 		goto out_slab;
 
+	ubifs_shrinker_info->count_objects = ubifs_shrink_count;
+	ubifs_shrinker_info->scan_objects = ubifs_shrink_scan;
+	ubifs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(ubifs_shrinker_info);
+
 	err = ubifs_compressors_init();
 	if (err)
 		goto out_shrinker;
@@ -2467,7 +2469,7 @@ static int __init ubifs_init(void)
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
 out_shrinker:
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_free(ubifs_shrinker_info);
 out_slab:
 	kmem_cache_destroy(ubifs_inode_slab);
 	return err;
@@ -2483,7 +2485,7 @@ static void __exit ubifs_exit(void)
 	dbg_debugfs_exit();
 	ubifs_sysfs_exit();
 	ubifs_compressors_exit();
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_free(ubifs_shrinker_info);
 
 	/*
 	 * Make sure all delayed rcu free inodes are flushed before we
-- 
2.30.2

