Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4138875F019
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGXJtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGXJs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:48:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52791BEC
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:47:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb85ed352bso2233345ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192039; x=1690796839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBNhxmwoWFukUMFCa6L5K1ksS1zA9QvfN1MSwW+LOvg=;
        b=PYcbzrtYJQj413Q0/SwymVhgK8hPc8ex6XZDsNX+o4IV2cADzaV/i2ya7gUKq/uTsu
         wsioX/oC9g6+AR05yLYLolp75BAxO+vtAgmvegSP/6oS7xyFJbaLjDx8bzKHReC/LdPy
         ZD0p0zqCSm4I20GpIy4a7cDW1rypHC1YzlPKbmR7fKpS+iPZ3nobfzQ/pyKjlQMwP8jK
         Nmzke41P9dSVS9eDDUNJUwzSb8mk0vo1CuJyAAX+qbcUvC6mBpCbrcmY6qwTVXPENs8X
         jAMFBNAsAWQ6gQ7fzECuFMhzmmAgzRWBECByoqxf+ey+4diWRhb6HmTmtKgQ50al6pO0
         t6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192039; x=1690796839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBNhxmwoWFukUMFCa6L5K1ksS1zA9QvfN1MSwW+LOvg=;
        b=d2RU404pBNVn9tjKnvyAMDxRq1ADtPFQMgLZc+Od1U+iqFbl9w2RQKe33apF/IUWfv
         tPRJRQuTrcMfJZgfjRF370FFfzj7RH6IGeYOWYFql9LyEeN4X+U+IeobQlGx4B922SJU
         Wklo2W595pNh/Zpys824GJaPXtLgzDPda82iUnKJnbHyBMP/ZhSwvAsw+fAVoj5Vwlu3
         vPm1kThsNb21nbtZ/4SV3IvV1tmX+Hrj6MfomH/WHuNutF0A7U2t23tubrKLaGlO5erD
         +jr+oi/Kkn/uEpyZWAC4AQCzZ7i4TXn2yJLMq7dAj50lZqDzWNzeoDdjOuFtSjQbcZuZ
         U1ag==
X-Gm-Message-State: ABy/qLYD5N/Zv7U6dObMM+732LuQweuKj0/7T4KPnTuVO3OA1Cx57mju
        jscTjDIBFvrlWrAJXgrg1SyDUg==
X-Google-Smtp-Source: APBJJlF/3KLtCT6eHhEfIce84TGjlwCK5paHy95Ixo7dnPUARJYmTi5EEMpBHN4EFiKTP+Yjoiy13g==
X-Received: by 2002:a17:903:24f:b0:1b8:ac61:ffcd with SMTP id j15-20020a170903024f00b001b8ac61ffcdmr12333562plh.3.1690192038795;
        Mon, 24 Jul 2023 02:47:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:47:18 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 11/47] gfs2: dynamically allocate the gfs2-qd shrinker
Date:   Mon, 24 Jul 2023 17:43:18 +0800
Message-Id: <20230724094354.90817-12-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the gfs2-qd shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/gfs2/main.c  |  6 +++---
 fs/gfs2/quota.c | 26 ++++++++++++++++++++------
 fs/gfs2/quota.h |  3 ++-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index afcb32854f14..e47b1cc79f59 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -147,7 +147,7 @@ static int __init init_gfs2_fs(void)
 	if (!gfs2_trans_cachep)
 		goto fail_cachep8;
 
-	error = register_shrinker(&gfs2_qd_shrinker, "gfs2-qd");
+	error = gfs2_qd_shrinker_init();
 	if (error)
 		goto fail_shrinker;
 
@@ -196,7 +196,7 @@ static int __init init_gfs2_fs(void)
 fail_wq2:
 	destroy_workqueue(gfs_recovery_wq);
 fail_wq1:
-	unregister_shrinker(&gfs2_qd_shrinker);
+	gfs2_qd_shrinker_exit();
 fail_shrinker:
 	kmem_cache_destroy(gfs2_trans_cachep);
 fail_cachep8:
@@ -229,7 +229,7 @@ static int __init init_gfs2_fs(void)
 
 static void __exit exit_gfs2_fs(void)
 {
-	unregister_shrinker(&gfs2_qd_shrinker);
+	gfs2_qd_shrinker_exit();
 	gfs2_glock_exit();
 	gfs2_unregister_debugfs();
 	unregister_filesystem(&gfs2_fs_type);
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 704192b73605..bc9883cea847 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -186,13 +186,27 @@ static unsigned long gfs2_qd_shrink_count(struct shrinker *shrink,
 	return vfs_pressure_ratio(list_lru_shrink_count(&gfs2_qd_lru, sc));
 }
 
-struct shrinker gfs2_qd_shrinker = {
-	.count_objects = gfs2_qd_shrink_count,
-	.scan_objects = gfs2_qd_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-	.flags = SHRINKER_NUMA_AWARE,
-};
+static struct shrinker *gfs2_qd_shrinker;
+
+int gfs2_qd_shrinker_init(void)
+{
+	gfs2_qd_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "gfs2-qd");
+	if (!gfs2_qd_shrinker)
+		return -ENOMEM;
+
+	gfs2_qd_shrinker->count_objects = gfs2_qd_shrink_count;
+	gfs2_qd_shrinker->scan_objects = gfs2_qd_shrink_scan;
+	gfs2_qd_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(gfs2_qd_shrinker);
 
+	return 0;
+}
+
+void gfs2_qd_shrinker_exit(void)
+{
+	shrinker_unregister(gfs2_qd_shrinker);
+}
 
 static u64 qd2index(struct gfs2_quota_data *qd)
 {
diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
index 21ada332d555..f9cb863373f7 100644
--- a/fs/gfs2/quota.h
+++ b/fs/gfs2/quota.h
@@ -59,7 +59,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode *ip,
 }
 
 extern const struct quotactl_ops gfs2_quotactl_ops;
-extern struct shrinker gfs2_qd_shrinker;
+int gfs2_qd_shrinker_init(void);
+void gfs2_qd_shrinker_exit(void);
 extern struct list_lru gfs2_qd_lru;
 extern void __init gfs2_quota_hash_init(void);
 
-- 
2.30.2

