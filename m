Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB6764CFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjG0IaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjG0I1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:27:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B97EE7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:14:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f74a8992so78437b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445625; x=1691050425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAE6p5mA5n3yxm+4IPfXfMLc8MGv4J5wg3qHubren08=;
        b=dkRrWVkSv9/U3+e6QsQd29dMPuttcg2M13ZLMDEEIMbfSamBJHJdLtNY2sbEZ+YzhY
         5BtYLYzutGknAA+e956eNSlbl7nK+9UwGbTk4YjZb6fHHFpCk0FXoHpJAi6M0jM7aFZF
         +CarAybA7Fmb9F2zoNtgG1DfzDYBp6eqgkICDj2Asy83tRT0LF5pvIpkdtR75UYStLmf
         37kqliTWk9DV3Fw2NufQf0BV5/WVkKX05IEilefRJ/OwJCaH2LBTkZCCI3ZIC5RNHqLc
         p1thIF8tkbzc9m+CHBYGB6mtVDqiYNqHlAVUDSIfQN8XwfU9rYwJVwEXJvC3bJUByZYt
         Gdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445625; x=1691050425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAE6p5mA5n3yxm+4IPfXfMLc8MGv4J5wg3qHubren08=;
        b=llapKwIO2buVJDNM6sqh5Hi2n3zrRSsi6pPpjziLtqdSDaMSGaueEElqjW3TfUTLH1
         5T/kmQYY+XmMMx1EZUe2NpOwGP0OfB88/YqTJuPTY1kdtPZXtzFmw+4yZkrqPBRe01GS
         njZjbHF6rgUk0ucDi87uGdgMbdpSGNrpQ0puO/4hPYXcHSYzU4oEeXjFEe2eqcCrzU2+
         i178z78ljSBeBQGZaTjjfjLz+3xWxN2lf1hXL+8G+kvf3UVsHINXHVE3zDOpEA6LHebV
         ioTi+TkmyHvSQ4BsCWZ75kjH83HTNw9SjYWF2/5LXvBVBlnn3Qef1fE1F7weTTitCjL6
         2+UQ==
X-Gm-Message-State: ABy/qLamp+kv3IX1hr8KRfyq21KTrKFpn/+yN/rcINdKq86vx2IFrYz1
        XWYwqH58mo4siNrfLKYEm/Xc5w==
X-Google-Smtp-Source: APBJJlGsGKc/yd3ypxFPLcm5JieT1oixTNIsPQhWBcbXzQEArQwAQppjIOSAREcWHLbqRGZH8ALcGA==
X-Received: by 2002:a05:6a20:7d87:b0:12e:f6e6:882b with SMTP id v7-20020a056a207d8700b0012ef6e6882bmr6446407pzj.1.1690445625322;
        Thu, 27 Jul 2023 01:13:45 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:13:44 -0700 (PDT)
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 39/49] xfs: dynamically allocate the xfs-inodegc shrinker
Date:   Thu, 27 Jul 2023 16:04:52 +0800
Message-Id: <20230727080502.77895-40-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the xfs-inodegc shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct xfs_mount.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/xfs/xfs_icache.c | 26 +++++++++++++++-----------
 fs/xfs/xfs_mount.c  |  4 ++--
 fs/xfs/xfs_mount.h  |  2 +-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 453890942d9f..751c380afd5a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -2225,8 +2225,7 @@ xfs_inodegc_shrinker_count(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_mount	*mp = container_of(shrink, struct xfs_mount,
-						   m_inodegc_shrinker);
+	struct xfs_mount	*mp = shrink->private_data;
 	struct xfs_inodegc	*gc;
 	int			cpu;
 
@@ -2247,8 +2246,7 @@ xfs_inodegc_shrinker_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_mount	*mp = container_of(shrink, struct xfs_mount,
-						   m_inodegc_shrinker);
+	struct xfs_mount	*mp = shrink->private_data;
 	struct xfs_inodegc	*gc;
 	int			cpu;
 	bool			no_items = true;
@@ -2284,13 +2282,19 @@ int
 xfs_inodegc_register_shrinker(
 	struct xfs_mount	*mp)
 {
-	struct shrinker		*shrink = &mp->m_inodegc_shrinker;
+	mp->m_inodegc_shrinker = shrinker_alloc(SHRINKER_NONSLAB,
+						"xfs-inodegc:%s",
+						mp->m_super->s_id);
+	if (!mp->m_inodegc_shrinker)
+		return -ENOMEM;
+
+	mp->m_inodegc_shrinker->count_objects = xfs_inodegc_shrinker_count;
+	mp->m_inodegc_shrinker->scan_objects = xfs_inodegc_shrinker_scan;
+	mp->m_inodegc_shrinker->seeks = 0;
+	mp->m_inodegc_shrinker->batch = XFS_INODEGC_SHRINKER_BATCH;
+	mp->m_inodegc_shrinker->private_data = mp;
 
-	shrink->count_objects = xfs_inodegc_shrinker_count;
-	shrink->scan_objects = xfs_inodegc_shrinker_scan;
-	shrink->seeks = 0;
-	shrink->flags = SHRINKER_NONSLAB;
-	shrink->batch = XFS_INODEGC_SHRINKER_BATCH;
+	shrinker_register(mp->m_inodegc_shrinker);
 
-	return register_shrinker(shrink, "xfs-inodegc:%s", mp->m_super->s_id);
+	return 0;
 }
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index fb87ffb48f7f..640d09891a4e 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1018,7 +1018,7 @@ xfs_mountfs(
  out_log_dealloc:
 	xfs_log_mount_cancel(mp);
  out_inodegc_shrinker:
-	unregister_shrinker(&mp->m_inodegc_shrinker);
+	shrinker_free(mp->m_inodegc_shrinker);
  out_fail_wait:
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
 		xfs_buftarg_drain(mp->m_logdev_targp);
@@ -1100,7 +1100,7 @@ xfs_unmountfs(
 #if defined(DEBUG)
 	xfs_errortag_clearall(mp);
 #endif
-	unregister_shrinker(&mp->m_inodegc_shrinker);
+	shrinker_free(mp->m_inodegc_shrinker);
 	xfs_free_perag(mp);
 
 	xfs_errortag_del(mp);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e2866e7fa60c..562c294ca08e 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -217,7 +217,7 @@ typedef struct xfs_mount {
 	atomic_t		m_agirotor;	/* last ag dir inode alloced */
 
 	/* Memory shrinker to throttle and reprioritize inodegc */
-	struct shrinker		m_inodegc_shrinker;
+	struct shrinker		*m_inodegc_shrinker;
 	/*
 	 * Workqueue item so that we can coalesce multiple inode flush attempts
 	 * into a single flush.
-- 
2.30.2

