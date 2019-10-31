Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476E6EBB01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfJaXsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:48:06 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40223 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728568AbfJaXqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:30 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 541DD7EA8FF;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007CE-Ab; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00041c-8Q; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/28] shrinkers: use defer_work for GFP_NOFS sensitive shrinkers
Date:   Fri,  1 Nov 2019 10:46:00 +1100
Message-Id: <20191031234618.15403-11-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=bIsfdx-f5ddGStTJopEA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

For shrinkers that currently avoid scanning when called under
GFP_NOFS contexts, convert them to use the new ->defer_work flag
rather than checking and returning errors during scans.

This makes it very clear that these shrinkers are not doing any work
because of the context limitations, not because there is no work
that can be done.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 drivers/staging/android/ashmem.c |  8 ++++----
 fs/gfs2/glock.c                  |  5 +++--
 fs/gfs2/quota.c                  |  6 +++---
 fs/nfs/dir.c                     |  6 +++---
 fs/super.c                       |  6 +++---
 fs/xfs/xfs_qm.c                  | 11 ++++++++---
 net/sunrpc/auth.c                |  5 ++---
 7 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d39c5a..0b80149f0ac5 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -438,10 +438,6 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	unsigned long freed = 0;
 
-	/* We might recurse into filesystem code, so bail out if necessary */
-	if (!(sc->gfp_mask & __GFP_FS))
-		return SHRINK_STOP;
-
 	if (!mutex_trylock(&ashmem_mutex))
 		return -1;
 
@@ -478,6 +474,10 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 static unsigned long
 ashmem_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
+	/* We might recurse into filesystem code, so bail out if necessary */
+	if (!(sc->gfp_mask & __GFP_FS))
+		sc->defer_work = true;
+
 	/*
 	 * note that lru_count is count of pages on the lru, not a count of
 	 * objects on the list. This means the scan function needs to return the
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 0290a22ebccf..a25161b93f96 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1614,14 +1614,15 @@ static long gfs2_scan_glock_lru(int nr)
 static unsigned long gfs2_glock_shrink_scan(struct shrinker *shrink,
 					    struct shrink_control *sc)
 {
-	if (!(sc->gfp_mask & __GFP_FS))
-		return SHRINK_STOP;
 	return gfs2_scan_glock_lru(sc->nr_to_scan);
 }
 
 static unsigned long gfs2_glock_shrink_count(struct shrinker *shrink,
 					     struct shrink_control *sc)
 {
+	if (!(sc->gfp_mask & __GFP_FS))
+		sc->defer_work = true;
+
 	return vfs_pressure_ratio(atomic_read(&lru_count));
 }
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 7c016a082aa6..661189b42c31 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -166,9 +166,6 @@ static unsigned long gfs2_qd_shrink_scan(struct shrinker *shrink,
 	LIST_HEAD(dispose);
 	unsigned long freed;
 
-	if (!(sc->gfp_mask & __GFP_FS))
-		return SHRINK_STOP;
-
 	freed = list_lru_shrink_walk(&gfs2_qd_lru, sc,
 				     gfs2_qd_isolate, &dispose);
 
@@ -180,6 +177,9 @@ static unsigned long gfs2_qd_shrink_scan(struct shrinker *shrink,
 static unsigned long gfs2_qd_shrink_count(struct shrinker *shrink,
 					  struct shrink_control *sc)
 {
+	if (!(sc->gfp_mask & __GFP_FS))
+		sc->defer_work = true;
+
 	return vfs_pressure_ratio(list_lru_shrink_count(&gfs2_qd_lru, sc));
 }
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..fd4a70479790 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2211,10 +2211,7 @@ unsigned long
 nfs_access_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int nr_to_scan = sc->nr_to_scan;
-	gfp_t gfp_mask = sc->gfp_mask;
 
-	if ((gfp_mask & GFP_KERNEL) != GFP_KERNEL)
-		return SHRINK_STOP;
 	return nfs_do_access_cache_scan(nr_to_scan);
 }
 
@@ -2222,6 +2219,9 @@ nfs_access_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 unsigned long
 nfs_access_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
+	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
+		sc->defer_work = true;
+
 	return vfs_pressure_ratio(atomic_long_read(&nfs_access_nr_entries));
 }
 
diff --git a/fs/super.c b/fs/super.c
index cfadab2cbf35..6dcab2a92454 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -74,9 +74,6 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	 * Deadlock avoidance.  We may hold various FS locks, and we don't want
 	 * to recurse into the FS that called us in clear_inode() and friends..
 	 */
-	if (!(sc->gfp_mask & __GFP_FS))
-		return SHRINK_STOP;
-
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
@@ -141,6 +138,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 		return 0;
 	smp_rmb();
 
+	if (!(sc->gfp_mask & __GFP_FS))
+		sc->defer_work = true;
+
 	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index ecd8ce152ab1..aa03f2448145 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -502,9 +502,6 @@ xfs_qm_shrink_scan(
 	unsigned long		freed;
 	int			error;
 
-	if ((sc->gfp_mask & (__GFP_FS|__GFP_DIRECT_RECLAIM)) != (__GFP_FS|__GFP_DIRECT_RECLAIM))
-		return 0;
-
 	INIT_LIST_HEAD(&isol.buffers);
 	INIT_LIST_HEAD(&isol.dispose);
 
@@ -534,6 +531,14 @@ xfs_qm_shrink_count(
 	struct xfs_quotainfo	*qi = container_of(shrink,
 					struct xfs_quotainfo, qi_shrinker);
 
+	/*
+	 * __GFP_DIRECT_RECLAIM is used here to avoid blocking kswapd
+	 */
+	if ((sc->gfp_mask & (__GFP_FS|__GFP_DIRECT_RECLAIM)) !=
+					(__GFP_FS|__GFP_DIRECT_RECLAIM)) {
+		sc->defer_work = true;
+	}
+
 	return list_lru_shrink_count(&qi->qi_lru, sc);
 }
 
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index cdb05b48de44..7d11a7034fee 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -527,9 +527,6 @@ static unsigned long
 rpcauth_cache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 {
-	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
-		return SHRINK_STOP;
-
 	/* nothing left, don't come back */
 	if (list_empty(&cred_unused))
 		return SHRINK_STOP;
@@ -541,6 +538,8 @@ static unsigned long
 rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 
 {
+	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
+		sc->defer_work = true;
 	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
 }
 
-- 
2.24.0.rc0

