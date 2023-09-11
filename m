Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131379B472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241823AbjIKU5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjIKJqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D0E40
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5657ca46a56so444944a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425607; x=1695030407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGYwucYG7HTVpzK5CooX1KDKxtCfW/GyjCRxwUVGc8U=;
        b=eEH0IysgfW/e+/D41THiORuguECRCcYUo1loMk6EnEEGIOJVcjkIISqlCF5nFrD4kc
         GAPhgmbLe+ok2ylPHcpHxnJocacKtKF7VeQ4xQwjS6AdEWqYIZXkrkWSjSM4Fr08HiPC
         9R8vp+x5FKxYr26hKAmyIoN7DGLotPcZcqfhgVzeYzcwITmOSxC0WVSEn2orjjtMP9+L
         HZEv57qZPtlnmZg9Dr7pZRWplATVG2GRHHQKHPEy0SWhHMi36VXPix7AE1EGU2rAu7Zu
         cl12woHreIXXS4r0gdENZ+L5lo2ceeWXKpolXVtnQFcP2IoTuvTpEwmDPqm/iv1dAYgp
         E2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425607; x=1695030407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGYwucYG7HTVpzK5CooX1KDKxtCfW/GyjCRxwUVGc8U=;
        b=wmpHM1xnkWuTQ3/ddqQoiaA/yI4E3bV7DnHmcZhZ091iVTOBjXGqLY8QfI/CEUIs3D
         wUZ1A3kwAyjIQhxKlnv9hVGVSPSkvMjHDyIrb9uwcEx0y3ZSntVYfuwsZMLpBu2VX/gb
         TraOx3zO3ORW9rv/tvldG+OaapX4cmNZo6U22NX6SNJDK+UEvIAcVN5BqwyxEqFKhuoF
         K5QoEks+MM+tPMiZxlSraUSicwPSwiAPWsbxbwk08FiATSdeFuhPh8hWI4PZMJRus/nh
         G+LnlG1aJZ/4EQ3VBgVT7yiKkxYX2g1iPo+9fjlJYcNvjvWdBWjVEsu+R2f5Y945Fmbo
         kuNg==
X-Gm-Message-State: AOJu0YwHmolN4vWSh0VmQFpMUHLFE8BUW14RBSQcz2XpjXPQe6BzqSen
        fKgIEWI8mQLnRSQnZa/xTzJO7+6QJrwUgHpl5LI=
X-Google-Smtp-Source: AGHT+IEATGFeLgyETjwn0MpUPq3DvWwKAg9V030xDC3jjIEkUp9pVkRI070K/5NVvqZMyXiud/buJg==
X-Received: by 2002:a05:6a20:5483:b0:140:cb66:73aa with SMTP id i3-20020a056a20548300b00140cb6673aamr12967762pzk.3.1694425607113;
        Mon, 11 Sep 2023 02:46:47 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:46 -0700 (PDT)
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
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH v6 11/45] nfs: dynamically allocate the nfs-acl shrinker
Date:   Mon, 11 Sep 2023 17:44:10 +0800
Message-Id: <20230911094444.68966-12-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the nfs-acl shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
CC: linux-nfs@vger.kernel.org
---
 fs/nfs/super.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb..09ded7f63acf 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -129,11 +129,7 @@ static void nfs_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
-static struct shrinker acl_shrinker = {
-	.count_objects	= nfs_access_cache_count,
-	.scan_objects	= nfs_access_cache_scan,
-	.seeks		= DEFAULT_SEEKS,
-};
+static struct shrinker *acl_shrinker;
 
 /*
  * Register the NFS filesystems
@@ -153,9 +149,18 @@ int __init register_nfs_fs(void)
 	ret = nfs_register_sysctl();
 	if (ret < 0)
 		goto error_2;
-	ret = register_shrinker(&acl_shrinker, "nfs-acl");
-	if (ret < 0)
+
+	acl_shrinker = shrinker_alloc(0, "nfs-acl");
+	if (!acl_shrinker) {
+		ret = -ENOMEM;
 		goto error_3;
+	}
+
+	acl_shrinker->count_objects = nfs_access_cache_count;
+	acl_shrinker->scan_objects = nfs_access_cache_scan;
+
+	shrinker_register(acl_shrinker);
+
 #ifdef CONFIG_NFS_V4_2
 	nfs_ssc_register_ops();
 #endif
@@ -175,7 +180,7 @@ int __init register_nfs_fs(void)
  */
 void __exit unregister_nfs_fs(void)
 {
-	unregister_shrinker(&acl_shrinker);
+	shrinker_free(acl_shrinker);
 	nfs_unregister_sysctl();
 	unregister_nfs4_fs();
 #ifdef CONFIG_NFS_V4_2
-- 
2.30.2

