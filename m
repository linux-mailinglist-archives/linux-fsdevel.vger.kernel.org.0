Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5982786658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbjHXDwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239915AbjHXDuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:50:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E71998
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:49:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so756375b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848939; x=1693453739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo3gwSlnAgdCIAM8+Km1Wnkr2Sb5aG/GGOSO40v1R40=;
        b=RUQ+uBY1HAkfCuT5ESlCEEytul9G5hnDaEVThHfRmA0LYTVOc7WWLKd9hCsS1rFFHa
         mc0eH/7dbqdo9EHUE6UmTighkCrSbumK03htQygf67qHe27shmRyY9JK85wG49kiZv2z
         8oDCaIHdONUv8zGek6e3NspoTl+vC5Qq39AmSoZP1rBLnuHQgP5BJHtoJVHrZETVj2Kd
         egVF4zYA6OPsk/LsQqBBw1iTIY44FdHii7ecD8x2+R4p3ld0ut8Qk1kr8FgQOf8sZhM2
         fnGgLEb2c03dR+jZvgTtYnp33H09H+otZtQe2aqa0mDWv5FhBJgI53BmsuMQs8rFkhal
         gCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848940; x=1693453740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo3gwSlnAgdCIAM8+Km1Wnkr2Sb5aG/GGOSO40v1R40=;
        b=V2IHSB/8iNK4Ob3tlHb43VcSdT4qd0k1t4hN76PrzuQnnIRVdOj3ceTcPBtXZt4hXp
         Bvc24Kh0D9s6lcS4WuC4ATAMitbfClqGiPQ/GQIQLdTZLBlMnE795iyqOK0sqScYmUcv
         MM3JJ1kDCFiAqKIt/frXv2qIppXUMZ0Z1oZCDSg38p9iNFsaNjJ2QCzC7dEoKWthG2n1
         wyVSgv4XbPFWurIWwXamx62Gxi6Pp52AlXr3kWcUhtg/LGPu45tCmqmsZPhKp5NFTg9q
         mb1O5ktPf2XtLC7cpzR8OH3MDAf8mkL34YuwGZIjci/8jogpuBPgpPxp0Ln2dZTYyH2i
         jrGg==
X-Gm-Message-State: AOJu0YzedDQby9iir/j0VrqSAPtGc+j0XfrYkwfYvmwyfKWFItWhhHYC
        swQZOWr0ZamYrNaENvYIlfs5hQ==
X-Google-Smtp-Source: AGHT+IFx2iJ97bW+6mvf322k3W+3GQwieeJP9La15RA3gyZWBJ7q6L8OZOACecxW0xeTb1cw72OuKQ==
X-Received: by 2002:a05:6a00:418f:b0:68b:c562:da46 with SMTP id ca15-20020a056a00418f00b0068bc562da46mr3997585pfb.1.1692848939719;
        Wed, 23 Aug 2023 20:48:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:48:59 -0700 (PDT)
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
        Chandan Babu R <chandan.babu@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 35/45] xfs: dynamically allocate the xfs-inodegc shrinker
Date:   Thu, 24 Aug 2023 11:42:54 +0800
Message-Id: <20230824034304.37411-36-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the xfs-inodegc shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct xfs_mount.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chandan Babu R <chandan.babu@oracle.com>
CC: "Darrick J. Wong" <djwong@kernel.org>
CC: linux-xfs@vger.kernel.org
---
 fs/xfs/xfs_icache.c | 26 +++++++++++++++-----------
 fs/xfs/xfs_mount.c  |  4 ++--
 fs/xfs/xfs_mount.h  |  2 +-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e541f5c0bc25..aacc7eec2497 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -2187,8 +2187,7 @@ xfs_inodegc_shrinker_count(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_mount	*mp = container_of(shrink, struct xfs_mount,
-						   m_inodegc_shrinker);
+	struct xfs_mount	*mp = shrink->private_data;
 	struct xfs_inodegc	*gc;
 	int			cpu;
 
@@ -2209,8 +2208,7 @@ xfs_inodegc_shrinker_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
-	struct xfs_mount	*mp = container_of(shrink, struct xfs_mount,
-						   m_inodegc_shrinker);
+	struct xfs_mount	*mp = shrink->private_data;
 	struct xfs_inodegc	*gc;
 	int			cpu;
 	bool			no_items = true;
@@ -2246,13 +2244,19 @@ int
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
index 0a0fd19573d8..aed5be5508fe 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1021,7 +1021,7 @@ xfs_mountfs(
  out_log_dealloc:
 	xfs_log_mount_cancel(mp);
  out_inodegc_shrinker:
-	unregister_shrinker(&mp->m_inodegc_shrinker);
+	shrinker_free(mp->m_inodegc_shrinker);
  out_fail_wait:
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
 		xfs_buftarg_drain(mp->m_logdev_targp);
@@ -1104,7 +1104,7 @@ xfs_unmountfs(
 #if defined(DEBUG)
 	xfs_errortag_clearall(mp);
 #endif
-	unregister_shrinker(&mp->m_inodegc_shrinker);
+	shrinker_free(mp->m_inodegc_shrinker);
 	xfs_free_perag(mp);
 
 	xfs_errortag_del(mp);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index a25eece3be2b..b8796bfc9ba4 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -221,7 +221,7 @@ typedef struct xfs_mount {
 	atomic_t		m_agirotor;	/* last ag dir inode alloced */
 
 	/* Memory shrinker to throttle and reprioritize inodegc */
-	struct shrinker		m_inodegc_shrinker;
+	struct shrinker		*m_inodegc_shrinker;
 	/*
 	 * Workqueue item so that we can coalesce multiple inode flush attempts
 	 * into a single flush.
-- 
2.30.2

