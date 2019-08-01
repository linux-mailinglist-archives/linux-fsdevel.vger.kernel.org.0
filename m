Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0197D330
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfHACSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:07 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:32913 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728677AbfHACSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:04 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B23C543DD1A;
        Thu,  1 Aug 2019 12:17:57 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eA-0003aQ-OS; Thu, 01 Aug 2019 12:16:50 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fG-0001kb-MB; Thu, 01 Aug 2019 12:17:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/24] shrinkers: use will_defer for GFP_NOFS sensitive shrinkers
Date:   Thu,  1 Aug 2019 12:17:30 +1000
Message-Id: <20190801021752.4986-3-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=bIsfdx-f5ddGStTJopEA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

For shrinkers that currently avoid scanning when called under
GFP_NOFS contexts, conver them to use the new ->will_defer flag
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
 fs/xfs/xfs_buf.c                 |  4 ++++
 fs/xfs/xfs_qm.c                  | 11 ++++++++---
 net/sunrpc/auth.c                |  5 ++---
 8 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d39c5a..fd9027dbd28c 100644
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
+		sc->will_defer = true;
+
 	/*
 	 * note that lru_count is count of pages on the lru, not a count of
 	 * objects on the list. This means the scan function needs to return the
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e23fb8b7b020..08c95172d0e5 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1517,14 +1517,15 @@ static long gfs2_scan_glock_lru(int nr)
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
+		sc->will_defer = true;
+
 	return vfs_pressure_ratio(atomic_read(&lru_count));
 }
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 69c4b77f127b..d35beda906e8 100644
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
+		sc->will_defer = true;
+
 	return vfs_pressure_ratio(list_lru_shrink_count(&gfs2_qd_lru, sc));
 }
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8d501093660f..73735ab1d623 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2202,10 +2202,7 @@ unsigned long
 nfs_access_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int nr_to_scan = sc->nr_to_scan;
-	gfp_t gfp_mask = sc->gfp_mask;
 
-	if ((gfp_mask & GFP_KERNEL) != GFP_KERNEL)
-		return SHRINK_STOP;
 	return nfs_do_access_cache_scan(nr_to_scan);
 }
 
@@ -2213,6 +2210,9 @@ nfs_access_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 unsigned long
 nfs_access_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
+	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
+		sc->will_defer = true;
+
 	return vfs_pressure_ratio(atomic_long_read(&nfs_access_nr_entries));
 }
 
diff --git a/fs/super.c b/fs/super.c
index 113c58f19425..66dd2af6cfde 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -73,9 +73,6 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	 * Deadlock avoidance.  We may hold various FS locks, and we don't want
 	 * to recurse into the FS that called us in clear_inode() and friends..
 	 */
-	if (!(sc->gfp_mask & __GFP_FS))
-		return SHRINK_STOP;
-
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
@@ -140,6 +137,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 		return 0;
 	smp_rmb();
 
+	if (!(sc->gfp_mask & __GFP_FS))
+		sc->will_defer = true;
+
 	if (sb->s_op && sb->s_op->nr_cached_objects)
 		total_objects = sb->s_op->nr_cached_objects(sb, sc);
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index ca0849043f54..6e0f76532535 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1680,6 +1680,10 @@ xfs_buftarg_shrink_count(
 {
 	struct xfs_buftarg	*btp = container_of(shrink,
 					struct xfs_buftarg, bt_shrinker);
+
+	if (!(sc->gfp_mask & __GFP_FS))
+		sc->will_defer = true;
+
 	return list_lru_shrink_count(&btp->bt_lru, sc);
 }
 
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 5e7a37f0cf84..13c842e8f13b 100644
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
+		sc->will_defer = true;
+	}
+
 	return list_lru_shrink_count(&qi->qi_lru, sc);
 }
 
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index cdb05b48de44..6babcbac4a00 100644
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
+		sc->will_defer = true;
 	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
 }
 
-- 
2.22.0

