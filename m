Return-Path: <linux-fsdevel+bounces-26443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1A9594D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E69B23AB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91216FF26;
	Wed, 21 Aug 2024 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ar6aPXB0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53116F0D0;
	Wed, 21 Aug 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222355; cv=none; b=SeyCArjxEt5+0575dgiC3+vB6pf6CbooZIPWkhSKcnFXJOSI/sZqa2EJAKXR8ycagw3AQYTHHujT+jGt6naOajDwF8Ew3Dgo1guvOaKdbLrAgpOtIuhHA6pSGNfQsayxuEcRJV/dZRo2U/7aLVe+FEfpXqjmFmxX2JbHF4EuC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222355; c=relaxed/simple;
	bh=+tFNLabH89XCAmqMBYdcKJra7hzgX5QmsA8Ucf6+wS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgcnhY3hcV+Iu9h4f2rXe00LDiFlMTRPNaVvnmhrFAjkmmftUzCe57DNsjc+xvLRlXXCyZ7/ueaBb7y+Ntx9Yf2PcKReccEjOC7GN9NgNXM29GDNHalN79fLy7ApsM7bk/XkmyW0K3pmrlnYZLaVuil5N8P1zIFHlru/h4wGW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ar6aPXB0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S7Tu2BZ/GQZa2HC/sp32AN+OcR/VdTOnqJp/3cDfhPo=; b=ar6aPXB0TE8vvIohllNon+3T1l
	xUnqfWg+2rzBuvR8csOlbq8vrTWuXKfdDb+uekECTEcCjipv/6sRkpw9G2G5cC4c4BiKbU3YmGdJY
	1c7uxocEOZde3MceYFHtxWvXb4N5DZ/v4/TXJKJim5Wj3/iNaoEX1I6LgPSYkkb8gOUOoDjCzBefq
	r2/lPudF3xBmoeBc+b4Jmm7F6p6FO5dmHfz5ZfYKqmPKk7YSfYWTjpB7nGYS2QcMPpEKZNX9s2HEZ
	jMzU4AAb2SdE+6ZDKFPogNrS0pv3gEa68sNAj8N+jwhzQG/7m2YRi6AK248A9Li3+Is6Qcr3OIt6O
	e+QgEA2w==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgezw-00000007kE5-0nHH;
	Wed, 21 Aug 2024 06:39:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] xfs: simplify tagged perag iteration
Date: Wed, 21 Aug 2024 08:38:30 +0200
Message-ID: <20240821063901.650776-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063901.650776-1-hch@lst.de>
References: <20240821063901.650776-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the old perag structure to the tagged loop helpers so that they can
grab the old agno before releasing the reference.  This removes the need
to separately track the agno and the iterator macro, and thus also
obsoletes the for_each_perag_tag syntactic sugar.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_icache.c | 69 +++++++++++++++++++++------------------------
 fs/xfs/xfs_trace.h  |  4 +--
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ac604640d36229..4d71fbfe71299a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -296,60 +296,63 @@ xfs_perag_clear_inode_tag(
  * Search from @first to find the next perag with the given tag set.
  */
 static struct xfs_perag *
-xfs_perag_get_tag(
+xfs_perag_get_next_tag(
 	struct xfs_mount	*mp,
-	xfs_agnumber_t		first,
+	struct xfs_perag	*pag,
 	unsigned int		tag)
 {
-	struct xfs_perag	*pag;
+	unsigned long		index = 0;
 	int			found;
 
+	if (pag) {
+		index = pag->pag_agno + 1;
+		xfs_perag_rele(pag);
+	}
+
 	rcu_read_lock();
 	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
-					(void **)&pag, first, 1, tag);
+					(void **)&pag, index, 1, tag);
 	if (found <= 0) {
 		rcu_read_unlock();
 		return NULL;
 	}
-	trace_xfs_perag_get_tag(pag, _RET_IP_);
+	trace_xfs_perag_get_next_tag(pag, _RET_IP_);
 	atomic_inc(&pag->pag_ref);
 	rcu_read_unlock();
 	return pag;
 }
 
 /*
- * Search from @first to find the next perag with the given tag set.
+ * Find the next AG after @pag, or the first AG if @pag is NULL.
  */
 static struct xfs_perag *
-xfs_perag_grab_tag(
+xfs_perag_grab_next_tag(
 	struct xfs_mount	*mp,
-	xfs_agnumber_t		first,
+	struct xfs_perag	*pag,
 	int			tag)
 {
-	struct xfs_perag	*pag;
+	unsigned long		index = 0;
 	int			found;
 
+	if (pag) {
+		index = pag->pag_agno + 1;
+		xfs_perag_rele(pag);
+	}
+
 	rcu_read_lock();
 	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
-					(void **)&pag, first, 1, tag);
+					(void **)&pag, index, 1, tag);
 	if (found <= 0) {
 		rcu_read_unlock();
 		return NULL;
 	}
-	trace_xfs_perag_grab_tag(pag, _RET_IP_);
+	trace_xfs_perag_grab_next_tag(pag, _RET_IP_);
 	if (!atomic_inc_not_zero(&pag->pag_active_ref))
 		pag = NULL;
 	rcu_read_unlock();
 	return pag;
 }
 
-#define for_each_perag_tag(mp, agno, pag, tag) \
-	for ((agno) = 0, (pag) = xfs_perag_grab_tag((mp), 0, (tag)); \
-		(pag) != NULL; \
-		(agno) = (pag)->pag_agno + 1, \
-		xfs_perag_rele(pag), \
-		(pag) = xfs_perag_grab_tag((mp), (agno), (tag)))
-
 /*
  * When we recycle a reclaimable inode, we need to re-initialise the VFS inode
  * part of the structure. This is made more complex by the fact we store
@@ -1077,15 +1080,11 @@ long
 xfs_reclaim_inodes_count(
 	struct xfs_mount	*mp)
 {
-	struct xfs_perag	*pag;
-	xfs_agnumber_t		ag = 0;
+	struct xfs_perag	*pag = NULL;
 	long			reclaimable = 0;
 
-	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
-		ag = pag->pag_agno + 1;
+	while ((pag = xfs_perag_get_next_tag(mp, pag, XFS_ICI_RECLAIM_TAG)))
 		reclaimable += pag->pag_ici_reclaimable;
-		xfs_perag_put(pag);
-	}
 	return reclaimable;
 }
 
@@ -1427,14 +1426,13 @@ void
 xfs_blockgc_start(
 	struct xfs_mount	*mp)
 {
-	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno;
+	struct xfs_perag	*pag = NULL;
 
 	if (xfs_set_blockgc_enabled(mp))
 		return;
 
 	trace_xfs_blockgc_start(mp, __return_address);
-	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
+	while ((pag = xfs_perag_grab_next_tag(mp, pag, XFS_ICI_BLOCKGC_TAG)))
 		xfs_blockgc_queue(pag);
 }
 
@@ -1550,21 +1548,19 @@ int
 xfs_blockgc_flush_all(
 	struct xfs_mount	*mp)
 {
-	struct xfs_perag	*pag;
-	xfs_agnumber_t		agno;
+	struct xfs_perag	*pag = NULL;
 
 	trace_xfs_blockgc_flush_all(mp, __return_address);
 
 	/*
-	 * For each blockgc worker, move its queue time up to now.  If it
-	 * wasn't queued, it will not be requeued.  Then flush whatever's
-	 * left.
+	 * For each blockgc worker, move its queue time up to now.  If it wasn't
+	 * queued, it will not be requeued.  Then flush whatever is left.
 	 */
-	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
+	while ((pag = xfs_perag_grab_next_tag(mp, pag, XFS_ICI_BLOCKGC_TAG)))
 		mod_delayed_work(pag->pag_mount->m_blockgc_wq,
 				&pag->pag_blockgc_work, 0);
 
-	for_each_perag_tag(mp, agno, pag, XFS_ICI_BLOCKGC_TAG)
+	while ((pag = xfs_perag_grab_next_tag(mp, pag, XFS_ICI_BLOCKGC_TAG)))
 		flush_delayed_work(&pag->pag_blockgc_work);
 
 	return xfs_inodegc_flush(mp);
@@ -1810,12 +1806,11 @@ xfs_icwalk(
 	enum xfs_icwalk_goal	goal,
 	struct xfs_icwalk	*icw)
 {
-	struct xfs_perag	*pag;
+	struct xfs_perag	*pag = NULL;
 	int			error = 0;
 	int			last_error = 0;
-	xfs_agnumber_t		agno;
 
-	for_each_perag_tag(mp, agno, pag, goal) {
+	while ((pag = xfs_perag_grab_next_tag(mp, pag, goal))) {
 		error = xfs_icwalk_ag(pag, goal, icw);
 		if (error) {
 			last_error = error;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 180ce697305a92..002d012ebd83cb 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -210,11 +210,11 @@ DEFINE_EVENT(xfs_perag_class, name,	\
 	TP_PROTO(struct xfs_perag *pag, unsigned long caller_ip), \
 	TP_ARGS(pag, caller_ip))
 DEFINE_PERAG_REF_EVENT(xfs_perag_get);
-DEFINE_PERAG_REF_EVENT(xfs_perag_get_tag);
+DEFINE_PERAG_REF_EVENT(xfs_perag_get_next_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_hold);
 DEFINE_PERAG_REF_EVENT(xfs_perag_put);
 DEFINE_PERAG_REF_EVENT(xfs_perag_grab);
-DEFINE_PERAG_REF_EVENT(xfs_perag_grab_tag);
+DEFINE_PERAG_REF_EVENT(xfs_perag_grab_next_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_rele);
 DEFINE_PERAG_REF_EVENT(xfs_perag_set_inode_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_clear_inode_tag);
-- 
2.43.0


