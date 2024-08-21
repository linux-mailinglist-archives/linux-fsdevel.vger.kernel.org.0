Return-Path: <linux-fsdevel+bounces-26445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9659594D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9307286E02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C031741CB;
	Wed, 21 Aug 2024 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+t2+Gnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B5170A2C;
	Wed, 21 Aug 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222360; cv=none; b=FhJojMJbq6z2m414HyBNztycZLyxmmaF42UZD7t/bKdIQ8FIR4XAwue3nitIKdCXikZYHPL4aewbdDTLzqeinHaxnO+W07L0t9HBAMoE6cTOHdcu5JYGWNlVkqiX3YPng0x63EtrFOBIjalJNWdvks2u4JuXOQ6KhOf2R91mBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222360; c=relaxed/simple;
	bh=a1l5H0ZeSXPVmUrT5jKzje4uC6mxacoXnv/Sytvf8LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDTM00qc7IzsFC6WM0a88j6kLkXug7OaiFK7WcoY/IUu5UEVZ9b9sY7TpIkEwU3YYoGob8fxWyBNsM3K+B3jvvUkql0gh1KfEVaHPL3pujsT990ftH7MFQ9q7QBVcZ/9qZNZx6hGIXeXIjCRi9ImmdIcJUCCLVei50CSBuh9/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K+t2+Gnq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ql+VaQTZ7hLkH7bRT5C66iw8O48DAz+gyyCW66CXGQM=; b=K+t2+Gnq+Cz14uZTdmhzBTYsoA
	LJTBOvGnscxKOroGRK20aJA3trjEqhXVVhIGi1TC2hPtQIEkLZMSUTUqXWGoDfXJSeCazkFsnu+tw
	0GSCPZPpvJK1hNFnKFB9VR0JMiBnL3Zy3b3/p/bcCgEkVTO+k/fSG5RjjvrB+tU0wlRuwtEf32Yv7
	2cZ/oFQ6Hhp4qhGp5gq8+aE/krgKF6nQkuNUv4cXwGISZddZHzvnYFvENQARwvHB1Epqw234UZFsS
	MkP+HrnjCKLoMJAvWl1li2TNR+Y2d5/iuZVZpJxeOFuKgcSVj6iUTos34l2gDwSvt4KDV4pa7uy+8
	txASn7rg==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgf00-00000007kGp-46bz;
	Wed, 21 Aug 2024 06:39:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] xfs: use xas_for_each_marked in xfs_reclaim_inodes_count
Date: Wed, 21 Aug 2024 08:38:32 +0200
Message-ID: <20240821063901.650776-6-hch@lst.de>
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

xfs_reclaim_inodes_count iterates over all AGs to sum up the reclaimable
inodes counts.  There is no point in grabbing a reference to the them or
unlock the RCU critical section for each iteration, so switch to the
more efficient xas_for_each_marked iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_icache.c | 36 ++++++++----------------------------
 fs/xfs/xfs_trace.h  |  2 +-
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 5bca845e702f1d..d36dbaba660013 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -300,32 +300,6 @@ xfs_perag_clear_inode_tag(
 	trace_xfs_perag_clear_inode_tag(pag, _RET_IP_);
 }
 
-/*
- * Search from @first to find the next perag with the given tag set.
- */
-static struct xfs_perag *
-xfs_perag_get_next_tag(
-	struct xfs_mount	*mp,
-	struct xfs_perag	*pag,
-	unsigned int		tag)
-{
-	unsigned long		index = 0;
-
-	if (pag) {
-		index = pag->pag_agno + 1;
-		xfs_perag_rele(pag);
-	}
-
-	rcu_read_lock();
-	pag = xa_find(&mp->m_perags, &index, ULONG_MAX, ici_tag_to_mark(tag));
-	if (pag) {
-		trace_xfs_perag_get_next_tag(pag, _RET_IP_);
-		atomic_inc(&pag->pag_ref);
-	}
-	rcu_read_unlock();
-	return pag;
-}
-
 /*
  * Find the next AG after @pag, or the first AG if @pag is NULL.
  */
@@ -1080,11 +1054,17 @@ long
 xfs_reclaim_inodes_count(
 	struct xfs_mount	*mp)
 {
-	struct xfs_perag	*pag = NULL;
+	XA_STATE		(xas, &mp->m_perags, 0);
 	long			reclaimable = 0;
+	struct xfs_perag	*pag;
 
-	while ((pag = xfs_perag_get_next_tag(mp, pag, XFS_ICI_RECLAIM_TAG)))
+	rcu_read_lock();
+	xas_for_each_marked(&xas, pag, ULONG_MAX, XFS_PERAG_RECLAIM_MARK) {
+		trace_xfs_reclaim_inodes_count(pag, _THIS_IP_);
 		reclaimable += pag->pag_ici_reclaimable;
+	}
+	rcu_read_unlock();
+
 	return reclaimable;
 }
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 002d012ebd83cb..d73c0a49d9dc29 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -210,7 +210,6 @@ DEFINE_EVENT(xfs_perag_class, name,	\
 	TP_PROTO(struct xfs_perag *pag, unsigned long caller_ip), \
 	TP_ARGS(pag, caller_ip))
 DEFINE_PERAG_REF_EVENT(xfs_perag_get);
-DEFINE_PERAG_REF_EVENT(xfs_perag_get_next_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_hold);
 DEFINE_PERAG_REF_EVENT(xfs_perag_put);
 DEFINE_PERAG_REF_EVENT(xfs_perag_grab);
@@ -218,6 +217,7 @@ DEFINE_PERAG_REF_EVENT(xfs_perag_grab_next_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_rele);
 DEFINE_PERAG_REF_EVENT(xfs_perag_set_inode_tag);
 DEFINE_PERAG_REF_EVENT(xfs_perag_clear_inode_tag);
+DEFINE_PERAG_REF_EVENT(xfs_reclaim_inodes_count);
 
 TRACE_EVENT(xfs_inodegc_worker,
 	TP_PROTO(struct xfs_mount *mp, unsigned int shrinker_hits),
-- 
2.43.0


