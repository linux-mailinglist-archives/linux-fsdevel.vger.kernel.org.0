Return-Path: <linux-fsdevel+bounces-66561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73775C23CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7D51887B43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A092EDD75;
	Fri, 31 Oct 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eatq96c3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006830F951;
	Fri, 31 Oct 2025 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899408; cv=none; b=QKaESQWkUtX/KSfjI68D+EKeZHHT9vB8SGmbStE1/XHXsHRA7+y94h+Smr8rH0tEJEqgH/qO+omGFwPpLisoT6soAmfj8msbhA8IdMNkgRGrrAHvQVbjIgDFlB6gVTsGdF6J90Nym2JjuSLRTyF0nFJfDpYVbI4D4dTas0mv/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899408; c=relaxed/simple;
	bh=j4C7cyamyKgvsuDDQde9W86J7YZV/Xt3hz7KoyxBKl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLGR08IiJ70edYIaNtImL5W3+RZEYvCzD7icKkqycL8o7k76P0SIQJ6rdxtVKLrt9sOn7WjRf3aogaHDOdWQkAciWazu1tNkmy6mRfYAUKECygXDC0VTYO2vuQweu3oNRA5UrTzK0PpMmcFvlH8LWGJ+Rb1mbvcWE9mo42aLBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eatq96c3; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761899407; x=1793435407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j4C7cyamyKgvsuDDQde9W86J7YZV/Xt3hz7KoyxBKl8=;
  b=eatq96c3WdFwI+T7++DzLEDqhcdfh3pyK/3pHIdH6wlT8m9NEsJ75HNT
   T4liz9uSr4sUlVxvpd6Z50wcIKypJHrVetN4AUib9C0evKF/KsoiOFZmk
   cSY5/tkKL4scKXjGv+VpaPkSUaMGCwi76l4HDagrC7/ZbdCaCG2qWBwjE
   r/aLcbpF1nQp1iYShxU7ETpgniBo4gibpUQVKPOO5oPgMKK/X51329C3G
   m3dvBnumqmMGjm/VVRmA2wInSY0pFgiovd16ws0vHsqSfZ7VtzLRYdNxK
   yXwyN2C+70lQkWG3ZWs/ApLxqbopOwutncmp0/lDQcx0PylZdBtR+g80T
   A==;
X-CSE-ConnectionGUID: AJhUr+OaSwqVCyC8saEp+g==
X-CSE-MsgGUID: t2W1Nap7SziMdWDVFxFx0Q==
X-IronPort-AV: E=Sophos;i="6.19,268,1754928000"; 
   d="scan'208";a="134260587"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 16:30:04 +0800
IronPort-SDR: 6904738b_iX5NWxEhp3pRhKOPQ+wUD/tjnOAFGODAioszSbkEB6gVAy4
 QLa6KXGECMZQ5DeST0CWW6CD5KZsQVnEPhogWYA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2025 01:30:03 -0700
WDCIronportException: Internal
Received: from wdap-s2ed6nrh3f.ad.shared (HELO gcv.wdc.com) ([10.224.178.7])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Oct 2025 01:30:02 -0700
From: Hans Holmberg <hans.holmberg@wdc.com>
To: linux-xfs@vger.kernel.org
Cc: Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>
Subject: [PATCH] xfs: remove xarray mark for reclaimable zones
Date: Fri, 31 Oct 2025 09:29:48 +0100
Message-ID: <20251031082948.128062-1-hans.holmberg@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can easily check if there are any reclaimble zones by just looking
at the used counters in the reclaim buckets, so do that to free up the
xarray mark we currently use for this purpose.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 fs/xfs/libxfs/xfs_rtgroup.h  |  6 ------
 fs/xfs/xfs_zone_alloc.c      | 26 ++++++++++++++++++++++----
 fs/xfs/xfs_zone_gc.c         |  2 +-
 fs/xfs/xfs_zone_priv.h       |  1 +
 fs/xfs/xfs_zone_space_resv.c |  2 +-
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtgroup.h b/fs/xfs/libxfs/xfs_rtgroup.h
index d36a6ae0abe5..1ac7a4764813 100644
--- a/fs/xfs/libxfs/xfs_rtgroup.h
+++ b/fs/xfs/libxfs/xfs_rtgroup.h
@@ -58,12 +58,6 @@ struct xfs_rtgroup {
  */
 #define XFS_RTG_FREE			XA_MARK_0
 
-/*
- * For zoned RT devices this is set on groups that are fully written and that
- * have unused blocks.  Used by the garbage collection to pick targets.
- */
-#define XFS_RTG_RECLAIMABLE		XA_MARK_1
-
 static inline struct xfs_rtgroup *to_rtg(struct xfs_group *xg)
 {
 	return container_of(xg, struct xfs_rtgroup, rtg_group);
diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 23cdab4515bb..a0486a1473d2 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -103,9 +103,6 @@ xfs_zone_account_reclaimable(
 		 */
 		trace_xfs_zone_emptied(rtg);
 
-		if (!was_full)
-			xfs_group_clear_mark(xg, XFS_RTG_RECLAIMABLE);
-
 		spin_lock(&zi->zi_used_buckets_lock);
 		if (!was_full)
 			xfs_zone_remove_from_bucket(zi, rgno, from_bucket);
@@ -127,7 +124,6 @@ xfs_zone_account_reclaimable(
 		xfs_zone_add_to_bucket(zi, rgno, to_bucket);
 		spin_unlock(&zi->zi_used_buckets_lock);
 
-		xfs_group_set_mark(xg, XFS_RTG_RECLAIMABLE);
 		if (zi->zi_gc_thread && xfs_zoned_need_gc(mp))
 			wake_up_process(zi->zi_gc_thread);
 	} else if (to_bucket != from_bucket) {
@@ -142,6 +138,28 @@ xfs_zone_account_reclaimable(
 	}
 }
 
+/*
+ * Check if we have any zones that can be reclaimed by looking at the entry
+ * counters for the zone buckets.
+ */
+bool
+xfs_zoned_have_reclaimable(
+	struct xfs_zone_info	*zi)
+{
+	int i;
+
+	spin_lock(&zi->zi_used_buckets_lock);
+	for (i = 0; i < XFS_ZONE_USED_BUCKETS; i++) {
+		if (zi->zi_used_bucket_entries[i]) {
+			spin_unlock(&zi->zi_used_buckets_lock);
+			return true;
+		}
+	}
+	spin_unlock(&zi->zi_used_buckets_lock);
+
+	return false;
+}
+
 static void
 xfs_open_zone_mark_full(
 	struct xfs_open_zone	*oz)
diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index 109877d9a6bf..683835626d48 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -173,7 +173,7 @@ xfs_zoned_need_gc(
 	s64			available, free, threshold;
 	s32			remainder;
 
-	if (!xfs_group_marked(mp, XG_TYPE_RTG, XFS_RTG_RECLAIMABLE))
+	if (!xfs_zoned_have_reclaimable(mp->m_zone_info))
 		return false;
 
 	available = xfs_estimate_freecounter(mp, XC_FREE_RTAVAILABLE);
diff --git a/fs/xfs/xfs_zone_priv.h b/fs/xfs/xfs_zone_priv.h
index 4322e26dd99a..ce7f0e2f4598 100644
--- a/fs/xfs/xfs_zone_priv.h
+++ b/fs/xfs/xfs_zone_priv.h
@@ -113,6 +113,7 @@ struct xfs_open_zone *xfs_open_zone(struct xfs_mount *mp,
 
 int xfs_zone_gc_reset_sync(struct xfs_rtgroup *rtg);
 bool xfs_zoned_need_gc(struct xfs_mount *mp);
+bool xfs_zoned_have_reclaimable(struct xfs_zone_info *zi);
 int xfs_zone_gc_mount(struct xfs_mount *mp);
 void xfs_zone_gc_unmount(struct xfs_mount *mp);
 
diff --git a/fs/xfs/xfs_zone_space_resv.c b/fs/xfs/xfs_zone_space_resv.c
index 9cd38716fd25..4cb6bf4f9586 100644
--- a/fs/xfs/xfs_zone_space_resv.c
+++ b/fs/xfs/xfs_zone_space_resv.c
@@ -174,7 +174,7 @@ xfs_zoned_reserve_available(
 		 * processing a pending GC request give up as we're fully out
 		 * of space.
 		 */
-		if (!xfs_group_marked(mp, XG_TYPE_RTG, XFS_RTG_RECLAIMABLE) &&
+		if (!xfs_zoned_have_reclaimable(mp->m_zone_info) &&
 		    !xfs_is_zonegc_running(mp))
 			break;
 
-- 
2.34.1


