Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8783A739B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjFVJCq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjFVJCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:02:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E4420B
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:57:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-51f64817809so680154a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424196; x=1690016196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuTRU39Llc4f1pG+4j4EE0WoT0ftJSPXyoG6lJxyplk=;
        b=Ekn/zV8B3Pykd2GrPoTdVnpJwk5evd2tyUP0vKsA0sao3e0fC5CJiY4BTrhaxMXIHV
         uTPkEPgehKIEn13/c91Rf6hAUh1pL4moe2PR0AHRF6Kdv1EoYZyskenz8RKeyckC9Itb
         y+HACd1zVUdu9ru2Mkg+skG1k3PTY0I37XiwGKuN4fZctDPgzdbV+AVCjywsN0HsaZ69
         Cuv8lvpq3tEmZe+xhsg7ur6ivxEYcTfKMKXUZmg3vRSFd562H9J1GbGm5bH6oFZpkxLe
         LAGfy+lFWFcKu0xxXlVXi22gjm4qtT4oNXfdGZLZ8KWmVvCWym8e4Apiabz+y3j9a60o
         NyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424196; x=1690016196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuTRU39Llc4f1pG+4j4EE0WoT0ftJSPXyoG6lJxyplk=;
        b=AH76BjTSfSRN9gCIN6mahx0Ywm+HNMNfWA+sNKGPuOQgoIIxJyOu3LaD4hPKx927y+
         iWrppU4CCkTNezw4CaRzA9NQWiCY7dKrZh0UkIxnegxqSjliePRLhsZuqUJGBEAGRKvO
         0OIz1UnAyz/U30MYW+RSoUlU6fRnn3riwGyKkC+QCw0sYhdnlHq1qMusqRtputSfqVJX
         0hupqnYBhuKUZngmBwuLwMrUuz9Vkxr7W0eLeeaT/8ZpYK7UWTdAssGMDXu6JKH1X/5k
         sdLRPYtVry6e92jzHpN85VnuKCQXFD4TfbTQRn5PRDNzECu8/1PlISKYYLYqQZo4AtHt
         UwEg==
X-Gm-Message-State: AC+VfDykITSCe61+gEzDjNaCQJesyfMMFVayueDLyaoW8ycZERA5sN6A
        6moUAoRFeS+0+dpwS6aFDgmnPQ==
X-Google-Smtp-Source: ACHHUZ67Tf+k1CheKb86ycYHhx5x/FfiuFJZEOT7coQiqeyoaYPxA8zsjGzghk4F71F8kxwZIRTJAQ==
X-Received: by 2002:a17:902:ecc6:b0:1ae:1364:6086 with SMTP id a6-20020a170902ecc600b001ae13646086mr21603647plh.2.1687424195747;
        Thu, 22 Jun 2023 01:56:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:56:35 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 19/29] xfs: dynamically allocate the xfs-qm shrinker
Date:   Thu, 22 Jun 2023 16:53:25 +0800
Message-Id: <20230622085335.77010-20-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink,
we need to dynamically allocate the xfs-qm shrinker,
so that it can be freed asynchronously using kfree_rcu().
Then it doesn't need to wait for RCU read-side critical
section when releasing the struct xfs_quotainfo.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/xfs/xfs_qm.c | 24 +++++++++++++-----------
 fs/xfs/xfs_qm.h |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 6abcc34fafd8..b15320d469cc 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -504,8 +504,7 @@ xfs_qm_shrink_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_quotainfo	*qi = container_of(shrink,
-					struct xfs_quotainfo, qi_shrinker);
+	struct xfs_quotainfo	*qi = shrink->private_data;
 	struct xfs_qm_isolate	isol;
 	unsigned long		freed;
 	int			error;
@@ -539,8 +538,7 @@ xfs_qm_shrink_count(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_quotainfo	*qi = container_of(shrink,
-					struct xfs_quotainfo, qi_shrinker);
+	struct xfs_quotainfo	*qi = shrink->private_data;
 
 	return list_lru_shrink_count(&qi->qi_lru, sc);
 }
@@ -680,18 +678,22 @@ xfs_qm_init_quotainfo(
 	if (XFS_IS_PQUOTA_ON(mp))
 		xfs_qm_set_defquota(mp, XFS_DQTYPE_PROJ, qinf);
 
-	qinf->qi_shrinker.count_objects = xfs_qm_shrink_count;
-	qinf->qi_shrinker.scan_objects = xfs_qm_shrink_scan;
-	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
-	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
+	qinf->qi_shrinker = shrinker_alloc_and_init(xfs_qm_shrink_count,
+						    xfs_qm_shrink_scan,
+						    0, DEFAULT_SEEKS,
+						    SHRINKER_NUMA_AWARE, qinf);
+	if (!qinf->qi_shrinker)
+		goto out_free_inos;
 
-	error = register_shrinker(&qinf->qi_shrinker, "xfs-qm:%s",
+	error = register_shrinker(qinf->qi_shrinker, "xfs-qm:%s",
 				  mp->m_super->s_id);
 	if (error)
-		goto out_free_inos;
+		goto out_shrinker;
 
 	return 0;
 
+out_shrinker:
+	shrinker_free(qinf->qi_shrinker);
 out_free_inos:
 	mutex_destroy(&qinf->qi_quotaofflock);
 	mutex_destroy(&qinf->qi_tree_lock);
@@ -718,7 +720,7 @@ xfs_qm_destroy_quotainfo(
 	qi = mp->m_quotainfo;
 	ASSERT(qi != NULL);
 
-	unregister_shrinker(&qi->qi_shrinker);
+	unregister_and_free_shrinker(qi->qi_shrinker);
 	list_lru_destroy(&qi->qi_lru);
 	xfs_qm_destroy_quotainos(qi);
 	mutex_destroy(&qi->qi_tree_lock);
diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
index 9683f0457d19..d5c9fc4ba591 100644
--- a/fs/xfs/xfs_qm.h
+++ b/fs/xfs/xfs_qm.h
@@ -63,7 +63,7 @@ struct xfs_quotainfo {
 	struct xfs_def_quota	qi_usr_default;
 	struct xfs_def_quota	qi_grp_default;
 	struct xfs_def_quota	qi_prj_default;
-	struct shrinker		qi_shrinker;
+	struct shrinker		*qi_shrinker;
 
 	/* Minimum and maximum quota expiration timestamp values. */
 	time64_t		qi_expiry_min;
-- 
2.30.2

