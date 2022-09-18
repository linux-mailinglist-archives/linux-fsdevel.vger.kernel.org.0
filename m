Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907F5BBBB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIREfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 00:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIREfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:35:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339F17060
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so3641914pja.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Zz/+Lsdw1NAyt93VpvNl+aPHSPA2CVkBmnUTlKe09/0=;
        b=Vpal278u2LJ58CGPsEPXqpT0AKbQZCricS4GhbO5+/GBcyr4GKzoi5Qa9e5QNMO2pf
         w2lPfIK28i3YkAuuaj2/4CImxJf8O6kumBc1rKMr06vxh+8zIdP96KGV3t74Ww5hf+fy
         v1vBmYRqADaDd+/Hh0QGVTHhkBhEWOTkKg1hBXK5ZjrKikjwBc2Q+jjPIPz37RCZOiuz
         jPMgcqNZ1AY9dPLgeqdTNrgrWIuoRV69eib0jXc6UUAXSwEkb7bFdeC3RqXyrtWCDhFq
         wuuvvL6Kr11VxV7fYvzIjSGciTRSuykd65Shkt00XCHD03XFz2LF9RJ4WpE235AxUNXH
         ERKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zz/+Lsdw1NAyt93VpvNl+aPHSPA2CVkBmnUTlKe09/0=;
        b=lrjDLpLxWhpCXZtPTu9jLvA5iQSCj72DRu0wTNsXG3SkxEZMNRZWbk6Hj63yMBVlUK
         foPerr05qW0lujZUO6QzYJ60EJDLoaECeBWJHua+sSJxRNYzG8N7c1MdBGJ32R1ft26T
         E7TT5uiwZPAJurM7g8nDwGE6P3AOfKl2Ml0WYHV3kYccYbzNMWRYGYuuj+QIrH3POaFw
         a6KH4bKZ+LEIpUI+u4eRICJ8fIPWY6esjvwUakNJk7B2o7iFJAN07hTnBKYMAW9h7mO6
         M/AEoRlozMyBJ8A6k88cKWikNJwTmbDdD3k+pxhNW2+1tqlwGe7ApUTBald5JGqSPuNH
         ZZkA==
X-Gm-Message-State: ACrzQf135JfF2dtjyTTL+AfBaVq4ylwyoiWTIJ+hSqnx2SWwpLJi2vw7
        b2TyZab5bXCRWICh+MeBx+J7uQ==
X-Google-Smtp-Source: AMsMyM6u/ABaKXp7fzLz3VnxEa03VfPh5BNRwHrMVloqKWw4UuRDLgvkR1FkRwo9HxTCHp1mCYkz6Q==
X-Received: by 2002:a17:903:1cc:b0:178:44cd:e9e with SMTP id e12-20020a17090301cc00b0017844cd0e9emr7132332plh.158.1663475710647;
        Sat, 17 Sep 2022 21:35:10 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:10 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 3/6] erofs: introduce fscache-based domain
Date:   Sun, 18 Sep 2022 12:34:53 +0800
Message-Id: <20220918043456.147-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 129 ++++++++++++++++++++++++++++++++++++++------
 fs/erofs/internal.h |   9 ++++
 2 files changed, 121 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index d3a90103abb7..9c82284e66ee 100644
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
+		mutex_unlock(&erofs_domain_list_lock);
+		fscache_relinquish_volume(domain->volume, NULL, false);
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
@@ -480,27 +577,19 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 
 int erofs_fscache_register_fs(struct super_block *sb)
 {
+	int ret;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	struct fscache_volume *volume;
 	struct erofs_fscache *fscache;
-	char *name;
-
-	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
-	if (!name)
-		return -ENOMEM;
 
-	volume = fscache_acquire_volume(name, NULL, NULL, 0);
-	if (IS_ERR_OR_NULL(volume)) {
-		erofs_err(sb, "failed to register volume for %s", name);
-		kfree(name);
-		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
-	}
-
-	sbi->volume = volume;
-	kfree(name);
+	if (sbi->opt.domain_id)
+		ret = erofs_fscache_register_domain(sb);
+	else
+		ret = erofs_fscache_register_volume(sb);
+	if (ret)
+		return ret;
 
+	/* acquired domain/volume will be relinquished in kill_sb() on error */
 	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
-	/* acquired volume will be relinquished in kill_sb() */
 	if (IS_ERR(fscache))
 		return PTR_ERR(fscache);
 
@@ -513,7 +602,13 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
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
index b36850dd7813..4c11313a072f 100644
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

