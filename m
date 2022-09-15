Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC555B9B2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiIOMnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 08:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIOMmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:42:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DC4DF01
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so22251766pjm.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kfHhRT289dkV3NHpaBsTSxMODd6npbx86OOQkUDFZG8=;
        b=CqsODZW/GWVVMDfU7M0v+xEIBfpXZbXfrx9vanoDgo1+XYUuBd58fyoXCOKgLMlVkm
         J0sp3fW8Q3Pb4YwPVscAFCMF3mjO0nkhJLHVOza7N8CvdsWG8kCGQd4NxpbUyCjQNyUe
         KibKNTOdgSMV3m19mL6MlItVSK+VqtycNzX/kR/oiqdHqPrn2q+ts+PQVxGbFA61HWOt
         UmuBeouX/bZm3f1O3se6JAwLKE6dxvXpIRhOLSo4KPzdwKvKFR5n0WQ9ey12mC1jTEB8
         5qiH3pT3YmXJT8bbZBwtvvTTc25JKvlbTehA03RDg9izJY8fY86b25PVymzsCFU3JOtv
         Ufhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kfHhRT289dkV3NHpaBsTSxMODd6npbx86OOQkUDFZG8=;
        b=CICK8m7h1tsVPodsEgez+wpbvXPpMxf3hCHFW8J89WLsINyE+nhve881Te/PTwtFPq
         6QMwfY1+BZKaQXWGw0NBOXTYGiw6NCLmcHH/f71K8GYvpf/Ir4mKWo8WTDZWNsw7O7EJ
         2xt8Foj7+4QsTlyavzU3AsagHlE/3GHC6unDeqjzvI46mEml8SBJaRVNp8qduGrHyetu
         S+4tDL5PwEVWSDrC4/ywFLV/cfXRgScB+cjlpxVb+rb47L3W+pk5uaOawM6hP6qZtU0E
         Yn6iSM4gO5tT7VMzqrToZsBSVidi0+wypO3hYm5iOO/2DiN2UCqeiEUeEG5BS6UYipSt
         WaMA==
X-Gm-Message-State: ACrzQf1yCiqnOsYNGC0N80tBJ0eBkXheOancya526Lr2Ed0YPdpig44o
        8ykVS5oULABpseX9i72KVvMBVA==
X-Google-Smtp-Source: AMsMyM6WpHNPGFcW0e8BCUEcni/nSFpOFKy9gW9ojucyMUWyZv1iEpnm6FJWtMkn0mJHk5V4oV/KZw==
X-Received: by 2002:a17:90b:1bcd:b0:203:27a3:6d0f with SMTP id oa13-20020a17090b1bcd00b0020327a36d0fmr6192310pjb.234.1663245761657;
        Thu, 15 Sep 2022 05:42:41 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:41 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 3/6] erofs: introduce fscache-based domain
Date:   Thu, 15 Sep 2022 20:42:10 +0800
Message-Id: <20220915124213.25767-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new fscache-based shared domain mode is going to be introduced for
erofs. In which case, same data blobs in same domain will be shared
and reused to reduce on-disk space usage.

The implementation of sharing blobs will be introduced in subsequent
patches.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 130 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |   9 +++
 2 files changed, 121 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index d72e2a7ea6ab..10d3f0511f15 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2022, Alibaba Cloud
+ * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
 #include "internal.h"
 
+static DEFINE_MUTEX(erofs_domain_list_lock);
+static LIST_HEAD(erofs_domain_list);
+
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
@@ -417,6 +421,99 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
+static void erofs_fscache_domain_put(struct erofs_domain *domain)
+{
+	if (!domain)
+		return;
+	mutex_lock(&erofs_domain_list_lock);
+	if (refcount_dec_and_test(&domain->ref)) {
+		list_del(&domain->list);
+		fscache_relinquish_volume(domain->volume, NULL, false);
+		mutex_unlock(&erofs_domain_list_lock);
+		kfree(domain->domain_id);
+		kfree(domain);
+		return;
+	}
+	mutex_unlock(&erofs_domain_list_lock);
+}
+
+static int erofs_fscache_register_volume(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *domain_id = sbi->opt.domain_id;
+	struct fscache_volume *volume;
+	char *name;
+	int ret = 0;
+
+	name = kasprintf(GFP_KERNEL, "erofs,%s",
+			 domain_id ? domain_id : sbi->opt.fsid);
+	if (!name)
+		return -ENOMEM;
+
+	volume = fscache_acquire_volume(name, NULL, NULL, 0);
+	if (IS_ERR_OR_NULL(volume)) {
+		erofs_err(sb, "failed to register volume for %s", name);
+		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
+		volume = NULL;
+	}
+
+	sbi->volume = volume;
+	kfree(name);
+	return ret;
+}
+
+static int erofs_fscache_init_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
+	if (!domain->domain_id) {
+		kfree(domain);
+		return -ENOMEM;
+	}
+
+	err = erofs_fscache_register_volume(sb);
+	if (err)
+		goto out;
+
+	domain->volume = sbi->volume;
+	refcount_set(&domain->ref, 1);
+	list_add(&domain->list, &erofs_domain_list);
+	sbi->domain = domain;
+	return 0;
+out:
+	kfree(domain->domain_id);
+	kfree(domain);
+	return err;
+}
+
+static int erofs_fscache_register_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	mutex_lock(&erofs_domain_list_lock);
+	list_for_each_entry(domain, &erofs_domain_list, list) {
+		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
+			sbi->domain = domain;
+			sbi->volume = domain->volume;
+			refcount_inc(&domain->ref);
+			mutex_unlock(&erofs_domain_list_lock);
+			return 0;
+		}
+	}
+	err = erofs_fscache_init_domain(sb);
+	mutex_unlock(&erofs_domain_list_lock);
+	return err;
+}
+
 struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 						     char *name, bool need_inode)
 {
@@ -481,27 +578,18 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct fscache_volume *volume;
 	struct erofs_fscache *fscache;
-	char *name;
-	int ret = 0;
-
-	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
-	if (!name)
-		return -ENOMEM;
-
-	volume = fscache_acquire_volume(name, NULL, NULL, 0);
-	if (IS_ERR_OR_NULL(volume)) {
-		erofs_err(sb, "failed to register volume for %s", name);
-		kfree(name);
-		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
-	}
+	int ret;
 
-	sbi->volume = volume;
-	kfree(name);
+	if (sbi->opt.domain_id)
+		ret = erofs_fscache_register_domain(sb);
+	else
+		ret = erofs_fscache_register_volume(sb);
+	if (ret)
+		return ret;
 
+	/* acquired domain/volume will be relinquished in kill_sb() if error occurs */
 	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
-	/* acquired volume will be relinquished in kill_sb() */
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
@@ -514,7 +602,13 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	erofs_fscache_unregister_cookie(sbi->s_fscache);
-	fscache_relinquish_volume(sbi->volume, NULL, false);
+
+	if (sbi->domain)
+		erofs_fscache_domain_put(sbi->domain);
+	else
+		fscache_relinquish_volume(sbi->volume, NULL, false);
+
 	sbi->s_fscache = NULL;
 	sbi->volume = NULL;
+	sbi->domain = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index aa71eb65e965..7f0939f4005b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -76,6 +76,7 @@ struct erofs_mount_opts {
 #endif
 	unsigned int mount_opt;
 	char *fsid;
+	char *domain_id;
 };
 
 struct erofs_dev_context {
@@ -98,6 +99,13 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_domain {
+	refcount_t ref;
+	struct list_head list;
+	struct fscache_volume *volume;
+	char *domain_id;
+};
+
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
@@ -157,6 +165,7 @@ struct erofs_sb_info {
 	/* fscache support */
 	struct fscache_volume *volume;
 	struct erofs_fscache *s_fscache;
+	struct erofs_domain *domain;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
-- 
2.20.1

