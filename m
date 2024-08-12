Return-Path: <linux-fsdevel+bounces-25632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056694E6B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188E8282A10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1272165EF7;
	Mon, 12 Aug 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vWrlkHFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C915C157;
	Mon, 12 Aug 2024 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444315; cv=none; b=nhUKFzZh9DwFYVfZ1d8sPutZM5ixOJDyly17FKatq6cZbdNALKnlu+Cb9gW9MYhNX/cTr9zp+blGb1T8QO4j+MBTJK7YsQTFDNyucha35IiKwFIVk30K6AZ/QCJj0C0zqJx+QLkw3395L/Z65NLC01Pu5Ygx6xeIdJ/kTIsaK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444315; c=relaxed/simple;
	bh=z9WsgvtPXL4PLeLKM/TzwPleQBrlJBg2Om3ifrrWlxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rlspc8suayG9lefEXvGmpdeZfjwRndXLitk+tpdplIl5I2qH7w0tVHtZrBqArAa3uGJom85R7AYmxXT8jMl/7xf30UyUS85tUJq0uveOBKHEHytEyFJ4CDZUh3iGqXjOZyJDs4D1YrAdRpnFoHzjHHe50KExfHGYIlVAn8qJ05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vWrlkHFH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=COE53Z6EduqkreFysNLA70F47+mSME5DgeSImIVuJ3E=; b=vWrlkHFHDdchAbUsFr86qQccBc
	Qo/A37IK8iG6tT4bHZON+wgkgG3sUnKYqfk58eRveMd72eBn65kYeRGaB62zJo0bemnfyn3vbXnBe
	vuwBBeutoz1U7DWwsk0y78vM6Nb3iP8uqDuBmAY6n4OR00jkc3UIiBnsOpgAxA/AxoYORogAFQHHR
	h9dP6QwvXUX8r4KwHFMw8LYsmzZaUA0AlxCPxuV1Kpti0/tjLkNLNDD8DCcbtSXuE6LCbTlmoyBAl
	5vlTukiRqmeH4YS8cSfIgUZoiwAViGFzfNKpyTEWf3PRz29h3TO9B0k0U4gcKmv7Rcb41doGBfolg
	Ny9Qe1Lg==;
Received: from 2a02-8389-2341-5b80-ee60-2eea-6f8f-8d7f.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ee60:2eea:6f8f:8d7f] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOat-0000000H1MC-3OKF;
	Mon, 12 Aug 2024 06:31:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] xfs: convert perag lookup to xarray
Date: Mon, 12 Aug 2024 08:31:01 +0200
Message-ID: <20240812063143.3806677-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812063143.3806677-1-hch@lst.de>
References: <20240812063143.3806677-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Convert the perag lookup from the legacy radix tree to the xarray,
which allows for much nicer iteration and bulk lookup semantics.

Note that this removes the helpers for tagged get and grab and the
for_each* wrappers built around them and instead uses the xa_for_each*
iteration helpers directly in xfs_icache.c, which simplifies the code
nicely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_ag.c | 81 +++++-------------------------------------
 fs/xfs/libxfs/xfs_ag.h | 11 ------
 fs/xfs/xfs_icache.c    | 77 +++++++++++++++++++++++++--------------
 fs/xfs/xfs_mount.h     |  3 +-
 fs/xfs/xfs_super.c     |  3 +-
 fs/xfs/xfs_trace.h     |  3 +-
 6 files changed, 61 insertions(+), 117 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index 7e80732cb54708..5efb1e8b4107a9 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -46,7 +46,7 @@ xfs_perag_get(
 	struct xfs_perag	*pag;
 
 	rcu_read_lock();
-	pag = radix_tree_lookup(&mp->m_perag_tree, agno);
+	pag = xa_load(&mp->m_perags, agno);
 	if (pag) {
 		trace_xfs_perag_get(pag, _RET_IP_);
 		ASSERT(atomic_read(&pag->pag_ref) >= 0);
@@ -56,31 +56,6 @@ xfs_perag_get(
 	return pag;
 }
 
-/*
- * search from @first to find the next perag with the given tag set.
- */
-struct xfs_perag *
-xfs_perag_get_tag(
-	struct xfs_mount	*mp,
-	xfs_agnumber_t		first,
-	unsigned int		tag)
-{
-	struct xfs_perag	*pag;
-	int			found;
-
-	rcu_read_lock();
-	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
-					(void **)&pag, first, 1, tag);
-	if (found <= 0) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	trace_xfs_perag_get_tag(pag, _RET_IP_);
-	atomic_inc(&pag->pag_ref);
-	rcu_read_unlock();
-	return pag;
-}
-
 /* Get a passive reference to the given perag. */
 struct xfs_perag *
 xfs_perag_hold(
@@ -117,38 +92,13 @@ xfs_perag_grab(
 	struct xfs_perag	*pag;
 
 	rcu_read_lock();
-	pag = radix_tree_lookup(&mp->m_perag_tree, agno);
+	pag = xa_load(&mp->m_perags, agno);
 	if (pag) {
 		trace_xfs_perag_grab(pag, _RET_IP_);
 		if (!atomic_inc_not_zero(&pag->pag_active_ref))
 			pag = NULL;
 	}
-	rcu_read_unlock();
-	return pag;
-}
 
-/*
- * search from @first to find the next perag with the given tag set.
- */
-struct xfs_perag *
-xfs_perag_grab_tag(
-	struct xfs_mount	*mp,
-	xfs_agnumber_t		first,
-	int			tag)
-{
-	struct xfs_perag	*pag;
-	int			found;
-
-	rcu_read_lock();
-	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
-					(void **)&pag, first, 1, tag);
-	if (found <= 0) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	trace_xfs_perag_grab_tag(pag, _RET_IP_);
-	if (!atomic_inc_not_zero(&pag->pag_active_ref))
-		pag = NULL;
 	rcu_read_unlock();
 	return pag;
 }
@@ -256,9 +206,7 @@ xfs_free_perag(
 	xfs_agnumber_t		agno;
 
 	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
-		spin_lock(&mp->m_perag_lock);
-		pag = radix_tree_delete(&mp->m_perag_tree, agno);
-		spin_unlock(&mp->m_perag_lock);
+		pag = xa_erase(&mp->m_perags, agno);
 		ASSERT(pag);
 		XFS_IS_CORRUPT(pag->pag_mount, atomic_read(&pag->pag_ref) != 0);
 		xfs_defer_drain_free(&pag->pag_intents_drain);
@@ -347,9 +295,7 @@ xfs_free_unused_perag_range(
 	xfs_agnumber_t		index;
 
 	for (index = agstart; index < agend; index++) {
-		spin_lock(&mp->m_perag_lock);
-		pag = radix_tree_delete(&mp->m_perag_tree, index);
-		spin_unlock(&mp->m_perag_lock);
+		pag = xa_erase(&mp->m_perags, index);
 		if (!pag)
 			break;
 		xfs_buf_cache_destroy(&pag->pag_bcache);
@@ -390,20 +336,11 @@ xfs_initialize_perag(
 		pag->pag_agno = index;
 		pag->pag_mount = mp;
 
-		error = radix_tree_preload(GFP_KERNEL | __GFP_RETRY_MAYFAIL);
-		if (error)
-			goto out_free_pag;
-
-		spin_lock(&mp->m_perag_lock);
-		if (radix_tree_insert(&mp->m_perag_tree, index, pag)) {
-			WARN_ON_ONCE(1);
-			spin_unlock(&mp->m_perag_lock);
-			radix_tree_preload_end();
-			error = -EEXIST;
+		error = xa_set(&mp->m_perags, index, pag, GFP_KERNEL);
+		if (error) {
+			WARN_ON_ONCE(error == -EEXIST);
 			goto out_free_pag;
 		}
-		spin_unlock(&mp->m_perag_lock);
-		radix_tree_preload_end();
 
 #ifdef __KERNEL__
 		/* Place kernel structure only init below this point. */
@@ -451,9 +388,7 @@ xfs_initialize_perag(
 
 out_remove_pag:
 	xfs_defer_drain_free(&pag->pag_intents_drain);
-	spin_lock(&mp->m_perag_lock);
-	radix_tree_delete(&mp->m_perag_tree, index);
-	spin_unlock(&mp->m_perag_lock);
+	pag = xa_erase(&mp->m_perags, index);
 out_free_pag:
 	kfree(pag);
 out_unwind_new_pags:
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 35de09a2516c70..b5eee2c787b6b7 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -156,15 +156,11 @@ void xfs_free_perag(struct xfs_mount *mp);
 
 /* Passive AG references */
 struct xfs_perag *xfs_perag_get(struct xfs_mount *mp, xfs_agnumber_t agno);
-struct xfs_perag *xfs_perag_get_tag(struct xfs_mount *mp, xfs_agnumber_t agno,
-		unsigned int tag);
 struct xfs_perag *xfs_perag_hold(struct xfs_perag *pag);
 void xfs_perag_put(struct xfs_perag *pag);
 
 /* Active AG references */
 struct xfs_perag *xfs_perag_grab(struct xfs_mount *, xfs_agnumber_t);
-struct xfs_perag *xfs_perag_grab_tag(struct xfs_mount *, xfs_agnumber_t,
-				   int tag);
 void xfs_perag_rele(struct xfs_perag *pag);
 
 /*
@@ -266,13 +262,6 @@ xfs_perag_next(
 	(agno) = 0; \
 	for_each_perag_from((mp), (agno), (pag))
 
-#define for_each_perag_tag(mp, agno, pag, tag) \
-	for ((agno) = 0, (pag) = xfs_perag_grab_tag((mp), 0, (tag)); \
-		(pag) != NULL; \
-		(agno) = (pag)->pag_agno + 1, \
-		xfs_perag_rele(pag), \
-		(pag) = xfs_perag_grab_tag((mp), (agno), (tag)))
-
 static inline struct xfs_perag *
 xfs_perag_next_wrap(
 	struct xfs_perag	*pag,
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index cf629302d48e74..c37f22a4c79f31 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -191,7 +191,7 @@ xfs_reclaim_work_queue(
 {
 
 	rcu_read_lock();
-	if (radix_tree_tagged(&mp->m_perag_tree, XFS_ICI_RECLAIM_TAG)) {
+	if (xa_marked(&mp->m_perags, XFS_ICI_RECLAIM_TAG)) {
 		queue_delayed_work(mp->m_reclaim_workqueue, &mp->m_reclaim_work,
 			msecs_to_jiffies(xfs_syncd_centisecs / 6 * 10));
 	}
@@ -241,9 +241,7 @@ xfs_perag_set_inode_tag(
 		return;
 
 	/* propagate the tag up into the perag radix tree */
-	spin_lock(&mp->m_perag_lock);
-	radix_tree_tag_set(&mp->m_perag_tree, pag->pag_agno, tag);
-	spin_unlock(&mp->m_perag_lock);
+	xa_set_mark(&mp->m_perags, pag->pag_agno, tag);
 
 	/* start background work */
 	switch (tag) {
@@ -285,9 +283,7 @@ xfs_perag_clear_inode_tag(
 		return;
 
 	/* clear the tag from the perag radix tree */
-	spin_lock(&mp->m_perag_lock);
-	radix_tree_tag_clear(&mp->m_perag_tree, pag->pag_agno, tag);
-	spin_unlock(&mp->m_perag_lock);
+	xa_clear_mark(&mp->m_perags, pag->pag_agno, tag);
 
 	trace_xfs_perag_clear_inode_tag(pag, _RET_IP_);
 }
@@ -977,7 +973,7 @@ xfs_reclaim_inodes(
 	if (xfs_want_reclaim_sick(mp))
 		icw.icw_flags |= XFS_ICWALK_FLAG_RECLAIM_SICK;
 
-	while (radix_tree_tagged(&mp->m_perag_tree, XFS_ICI_RECLAIM_TAG)) {
+	while (xa_marked(&mp->m_perags, XFS_ICI_RECLAIM_TAG)) {
 		xfs_ail_push_all_sync(mp->m_ail);
 		xfs_icwalk(mp, XFS_ICWALK_RECLAIM, &icw);
 	}
@@ -1020,14 +1016,16 @@ xfs_reclaim_inodes_count(
 	struct xfs_mount	*mp)
 {
 	struct xfs_perag	*pag;
-	xfs_agnumber_t		ag = 0;
+	unsigned long		index = 0;
 	long			reclaimable = 0;
 
-	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
-		ag = pag->pag_agno + 1;
+	rcu_read_lock();
+	xa_for_each_marked(&mp->m_perags, index, pag, XFS_ICI_RECLAIM_TAG) {
+		trace_xfs_reclaim_inodes_count(pag, _THIS_IP_);
 		reclaimable += pag->pag_ici_reclaimable;
-		xfs_perag_put(pag);
 	}
+	rcu_read_unlock();
+
 	return reclaimable;
 }
 
@@ -1370,14 +1368,20 @@ xfs_blockgc_start(
 	struct xfs_mount	*mp)
 {
 	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno;
+	unsigned long		index = 0;
 
 	if (xfs_set_blockgc_enabled(mp))
 		return;
 
 	trace_xfs_blockgc_start(mp, __return_address);
-	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
+
+	rcu_read_lock();
+	xa_for_each_marked(&mp->m_perags, index, pag, XFS_ICI_BLOCKGC_TAG) {
+		if (!atomic_read(&pag->pag_active_ref))
+			continue;
 		xfs_blockgc_queue(pag);
+	}
+	rcu_read_unlock();
 }
 
 /* Don't try to run block gc on an inode that's in any of these states. */
@@ -1493,21 +1497,32 @@ xfs_blockgc_flush_all(
 	struct xfs_mount	*mp)
 {
 	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno;
+	unsigned long		index = 0;
 
 	trace_xfs_blockgc_flush_all(mp, __return_address);
 
 	/*
-	 * For each blockgc worker, move its queue time up to now.  If it
-	 * wasn't queued, it will not be requeued.  Then flush whatever's
-	 * left.
+	 * For each blockgc worker, move its queue time up to now.  If it wasn't
+	 * queued, it will not be requeued.  Then flush whatever is left.
 	 */
-	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
-		mod_delayed_work(pag->pag_mount->m_blockgc_wq,
-				&pag->pag_blockgc_work, 0);
+	rcu_read_lock();
+	xa_for_each_marked(&mp->m_perags, index, pag, XFS_ICI_BLOCKGC_TAG)
+		mod_delayed_work(mp->m_blockgc_wq, &pag->pag_blockgc_work, 0);
+	rcu_read_unlock();
+
+	index = 0;
+	rcu_read_lock();
+	xa_for_each_marked(&mp->m_perags, index, pag, XFS_ICI_BLOCKGC_TAG) {
+		if (!atomic_inc_not_zero(&pag->pag_active_ref))
+			continue;
+		rcu_read_unlock();
 
-	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
 		flush_delayed_work(&pag->pag_blockgc_work);
+		xfs_perag_rele(pag);
+
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
 
 	return xfs_inodegc_flush(mp);
 }
@@ -1755,18 +1770,26 @@ xfs_icwalk(
 	struct xfs_perag	*pag;
 	int			error = 0;
 	int			last_error = 0;
-	xfs_agnumber_t		agno;
+	unsigned long		index = 0;
+
+	rcu_read_lock();
+	xa_for_each_marked(&mp->m_perags, index, pag, goal) {
+		if (!atomic_inc_not_zero(&pag->pag_active_ref))
+			continue;
+		rcu_read_unlock();
 
-	for_each_perag_tag(mp, agno, pag, goal) {
 		error = xfs_icwalk_ag(pag, goal, icw);
+		xfs_perag_rele(pag);
+
+		rcu_read_lock();
 		if (error) {
 			last_error = error;
-			if (error == -EFSCORRUPTED) {
-				xfs_perag_rele(pag);
+			if (error == -EFSCORRUPTED)
 				break;
-			}
 		}
 	}
+	rcu_read_unlock();
+
 	return last_error;
 	BUILD_BUG_ON(XFS_ICWALK_PRIVATE_FLAGS & XFS_ICWALK_FLAGS_VALID);
 }
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d0567dfbc0368d..dce2d832e1e6d1 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -208,8 +208,7 @@ typedef struct xfs_mount {
 	 */
 	atomic64_t		m_allocbt_blks;
 
-	struct radix_tree_root	m_perag_tree;	/* per-ag accounting info */
-	spinlock_t		m_perag_lock;	/* lock for m_perag_tree */
+	struct xarray		m_perags;	/* per-ag accounting info */
 	uint64_t		m_resblks;	/* total reserved blocks */
 	uint64_t		m_resblks_avail;/* available reserved blocks */
 	uint64_t		m_resblks_save;	/* reserved blks @ remount,ro */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7fc..c41b543f2e9121 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2009,8 +2009,7 @@ static int xfs_init_fs_context(
 		return -ENOMEM;
 
 	spin_lock_init(&mp->m_sb_lock);
-	INIT_RADIX_TREE(&mp->m_perag_tree, GFP_ATOMIC);
-	spin_lock_init(&mp->m_perag_lock);
+	xa_init(&mp->m_perags);
 	mutex_init(&mp->m_growlock);
 	INIT_WORK(&mp->m_flush_inodes_work, xfs_flush_inodes_worker);
 	INIT_DELAYED_WORK(&mp->m_reclaim_work, xfs_reclaim_worker);
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 180ce697305a92..f3ddee49071c16 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -210,14 +210,13 @@ DEFINE_EVENT(xfs_perag_class, name,	\
 	TP_PROTO(struct xfs_perag *pag, unsigned long caller_ip), \
 	TP_ARGS(pag, caller_ip))
 DEFINE_PERAG_REF_EVENT(xfs_perag_get);
-DEFINE_PERAG_REF_EVENT(xfs_perag_get_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_hold);
 DEFINE_PERAG_REF_EVENT(xfs_perag_put);
 DEFINE_PERAG_REF_EVENT(xfs_perag_grab);
-DEFINE_PERAG_REF_EVENT(xfs_perag_grab_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_rele);
 DEFINE_PERAG_REF_EVENT(xfs_perag_set_inode_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_clear_inode_tag);
+DEFINE_PERAG_REF_EVENT(xfs_reclaim_inodes_count);
 
 TRACE_EVENT(xfs_inodegc_worker,
 	TP_PROTO(struct xfs_mount *mp, unsigned int shrinker_hits),
-- 
2.43.0


