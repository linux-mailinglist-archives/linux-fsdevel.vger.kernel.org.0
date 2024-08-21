Return-Path: <linux-fsdevel+bounces-26442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052069594CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882861F24B02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDAE16F0DC;
	Wed, 21 Aug 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uHzwyWhl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45016EB7B;
	Wed, 21 Aug 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222352; cv=none; b=XdLizZfYgD5wuoT4D3duHUznvE3ONrsZoXvB7fY8Hs2da3SqaN54PnefNxA6otgrhETDeMZfgGX2LZowjNqCVVY0PBlxnVarqqZcncLkJ8mJv3uIqLZBloHFnlV1ePxLCaoCBsAk9OUwAomMxF5qDZ93MdrgtX0rPby26GJcmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222352; c=relaxed/simple;
	bh=0waLtysnOHAUvH60W5Gr4XbwJ4FFRc2G+HMNYYxu0Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5LEg6RKgnvx1JSJ5t5dwhCw0AzSBLOn9UZdYL0ZuuF112SxKgtfInWkK1TVNu4YvaCvM24F5xAXG5TcxOoQpcutTp42yfqPrK+p3ROC9t+BzxWAC82fKTDrzk2VaeYCxXNOyMm6jdleWbvW7NkL73+73xStY//Qq8/R0ReCQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uHzwyWhl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vI0/E315PFUaTzw3qYllv8e5O+KvAos68zEyjwSiHfk=; b=uHzwyWhlRsulVmnIFLcMUuwJvi
	V3ccA119XpfDISZqPIjC6HeLZaGCWJ4xoNEosvhLjyhDItOpHfQHBt0jqIEVAGnEwVx6K/m0O5ey6
	oDNPP+Lu/UL9UjTDJ/ym63GMcxNQvDZV0ZI49mzG+MGzdUwo3E0DDbNHCsLLAF084l1K1b4tIjrmk
	+nACcMRFBnk2rhtmJ1/LtebPTPRq04uHbL37ct7uU5W9Ysxadxf2eUQEBYFV55REAo3K+MF+Z7S3t
	3Gq4vY3QtyIsBCaDWJzbyRyb4z1ouRBQpwlFVLZUPJDaSHzdpxAampA0mohQF5y/IFrlq21XJYZBV
	JrgHn8mg==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgezt-00000007kDV-1AuY;
	Wed, 21 Aug 2024 06:39:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] xfs: move the tagged perag lookup helpers to xfs_icache.c
Date: Wed, 21 Aug 2024 08:38:29 +0200
Message-ID: <20240821063901.650776-3-hch@lst.de>
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

The tagged perag helpers are only used in xfs_icache.c in the kernel code
and not at all in xfsprogs.  Move them to xfs_icache.c in preparation for
switching to an xarray, for which I have no plan to implement the tagged
lookup functions for userspace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_ag.c | 51 -------------------------------------
 fs/xfs/libxfs/xfs_ag.h | 11 --------
 fs/xfs/xfs_icache.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index 4b5a39a83f7aed..87f00f0180846f 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
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
@@ -127,32 +102,6 @@ xfs_perag_grab(
 	return pag;
 }
 
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
-	rcu_read_unlock();
-	return pag;
-}
-
 void
 xfs_perag_rele(
 	struct xfs_perag	*pag)
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index d62c266c0b44d5..d9cccd093b60e0 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -153,15 +153,11 @@ void xfs_free_perag(struct xfs_mount *mp);
 
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
@@ -263,13 +259,6 @@ xfs_perag_next(
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
index cf629302d48e74..ac604640d36229 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -292,6 +292,64 @@ xfs_perag_clear_inode_tag(
 	trace_xfs_perag_clear_inode_tag(pag, _RET_IP_);
 }
 
+/*
+ * Search from @first to find the next perag with the given tag set.
+ */
+static struct xfs_perag *
+xfs_perag_get_tag(
+	struct xfs_mount	*mp,
+	xfs_agnumber_t		first,
+	unsigned int		tag)
+{
+	struct xfs_perag	*pag;
+	int			found;
+
+	rcu_read_lock();
+	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
+					(void **)&pag, first, 1, tag);
+	if (found <= 0) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	trace_xfs_perag_get_tag(pag, _RET_IP_);
+	atomic_inc(&pag->pag_ref);
+	rcu_read_unlock();
+	return pag;
+}
+
+/*
+ * Search from @first to find the next perag with the given tag set.
+ */
+static struct xfs_perag *
+xfs_perag_grab_tag(
+	struct xfs_mount	*mp,
+	xfs_agnumber_t		first,
+	int			tag)
+{
+	struct xfs_perag	*pag;
+	int			found;
+
+	rcu_read_lock();
+	found = radix_tree_gang_lookup_tag(&mp->m_perag_tree,
+					(void **)&pag, first, 1, tag);
+	if (found <= 0) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	trace_xfs_perag_grab_tag(pag, _RET_IP_);
+	if (!atomic_inc_not_zero(&pag->pag_active_ref))
+		pag = NULL;
+	rcu_read_unlock();
+	return pag;
+}
+
+#define for_each_perag_tag(mp, agno, pag, tag) \
+	for ((agno) = 0, (pag) = xfs_perag_grab_tag((mp), 0, (tag)); \
+		(pag) != NULL; \
+		(agno) = (pag)->pag_agno + 1, \
+		xfs_perag_rele(pag), \
+		(pag) = xfs_perag_grab_tag((mp), (agno), (tag)))
+
 /*
  * When we recycle a reclaimable inode, we need to re-initialise the VFS inode
  * part of the structure. This is made more complex by the fact we store
-- 
2.43.0


