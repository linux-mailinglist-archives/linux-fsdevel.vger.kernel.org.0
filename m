Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF175EFE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGXJsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjGXJsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:48:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C432699
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:47:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b867f9198dso8895215ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192015; x=1690796815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKcV3vb4MClJJQ+mNTta07ndMYtKKP0SAkTwCVeOX0w=;
        b=a7lFhyKpvN91nijv1nVs3JeaaLMDFPSuaWY4NCEQD9DCJQdlhcmwFlvKgxp6H5QA07
         3dkX4W4M1txISO3DSWoCDCRM1ysYCDf7oPJVOFGCIfe+DlrmZLhiur4I07AdWC0aW3Dw
         CVnibojO6zdjwPP037s+ZGzHTbYwQp1TRk5IbZ0gf2icMTq1nF1E5wJ/BtOX4xZvFUp0
         NkBwNV73kgVtBd1NdtpFu3djSHL7HyBXhuBz5mRGNaBtssuegwQh/61PWGRXQCMhsibP
         +eC6XYGvARqk02NWbIzA2EZWiSinAW1FFs+vgwRWCCseEycqYRnDfiCLO/I65f90R1Q3
         zmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192015; x=1690796815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKcV3vb4MClJJQ+mNTta07ndMYtKKP0SAkTwCVeOX0w=;
        b=IhmxJzC+v5FrZDDC+N8uGsNprg+0a0ji7Tskg0TVNgu3jeYyUOSH8hCJmy9iTYYsl5
         wwMS2A+VPhyImPOIPV9o2rmC4Z0kRUz/TaIHryKAuUM3v4MiH90PrLPbhG23+qTxhwuI
         C1EBDKeUuPuGPZ7VAmnpoqotHJZslx1TJbH40y5OAgzway8hafSSiFZdGPJZMDOxb16V
         5pEAbwqgUxnn9IYJNSL6tKzm8aAlur+y3tMHw8uJmnPS7XupRLGxalCeckSL6ybdbDFu
         4XY1cp0amtmIXknLy4idKdUU7cibLRWF4a1A5CZH0lbtSmY5FTwwLJnsqJEu4jVMhELC
         Yp2Q==
X-Gm-Message-State: ABy/qLaPbnPUezQ8QbfWcH63r8DORo6WmLp5Nkew8aQqkrJvEaGGe91g
        4kl5bhyBkXnoVUdqVAhOwRv26w==
X-Google-Smtp-Source: APBJJlFJGAUudAfwbE4FzEeIId9jY33sdTrNWRyhFQwrzl0Tx9fNVh9CNxBzY73cH6rP3yfMJCnueA==
X-Received: by 2002:a17:902:dace:b0:1b8:811:b079 with SMTP id q14-20020a170902dace00b001b80811b079mr12305026plx.0.1690192015077;
        Mon, 24 Jul 2023 02:46:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:46:54 -0700 (PDT)
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
Subject: [PATCH v2 09/47] f2fs: dynamically allocate the f2fs-shrinker
Date:   Mon, 24 Jul 2023 17:43:16 +0800
Message-Id: <20230724094354.90817-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the f2fs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/f2fs/super.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca31163da00a..8b08473db358 100644
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
+static int f2fs_init_shrinker(void)
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
+	shrinker_unregister(f2fs_shrinker_info);
+}
 
 enum {
 	Opt_gc_background,
@@ -4941,7 +4957,7 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_sysfs();
 	if (err)
 		goto free_garbage_collection_cache;
-	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
+	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
@@ -4986,7 +5002,7 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
-	unregister_shrinker(&f2fs_shrinker_info);
+	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
 free_garbage_collection_cache:
@@ -5018,7 +5034,7 @@ static void __exit exit_f2fs_fs(void)
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

