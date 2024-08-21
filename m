Return-Path: <linux-fsdevel+bounces-26441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843779594CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A06A1F249AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152316EB5F;
	Wed, 21 Aug 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v+VJW6Fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D816DECC;
	Wed, 21 Aug 2024 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222349; cv=none; b=Yury7LNNkv/OQ957bqUREhq91z203QqUUWZZDJ3vFdAbwrMQHrkbnqo7VAENcnis30yG+zqR59ehNXYLKKfmQU/M3Lj2bTp9nCKa0wSaKy/FUxa71nEx5d26fGu0GAyhPx/AGqPCxsxZy/w78TvQDIVXk5oCMfQAdYwev4+Nubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222349; c=relaxed/simple;
	bh=3PEriSLYVy2I721CyhEIVv9YPOBVQEhnLomR9sCUQZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8PnFPtZIhWfdOIySK8vA3Ts/9jlgv5A0T6Isvx1nPQ67lyo5WXwJxDdD6iED0Z9sH05mrQggdXNUI4sp4Q+UzlHM2FwnTG7jMEEudvqPqX8OPG3l+wQ5mD8V8PY/8ItIT717ECQXL6jEJR+2f7dB5c/LldkFw5uWjDXjXfykv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v+VJW6Fp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=43977Olov3pq7YOdJMItc7minZOgHWWmYFzs7HSfVZo=; b=v+VJW6Fp6Y3mnavruSlKwkSIbm
	03EgURkwhxnXj24J2mOdwIWuSw568Nj8/7nbUyYZr58JYXxAQeeL6b35csHYTF8MSBhNEnFnoRWHs
	Kxx5e5Olxp1ZupiQOCiw2sBKnQLtG/PWbfA6WOpNk6Bo2KpTL3w4TrKxTomdWfUTwNAYDssHZFFn3
	QmHYSxsVIZsLVa1RTo/j3U+t6lzgmS7Iefn2KoNTYdGPkY3azja1eSOJ/7Ql76W3AgwwOFI7XL2Ht
	JxquD6wsKjeExIv1qUQjl851A+XskdWBPF8VJVHhgHd7hTBet/r1NX7o2i4Ak2qg3Q96lcUxGkK3b
	iGR5fvSw==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgezq-00000007kCt-2SQL;
	Wed, 21 Aug 2024 06:39:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] xfs: use kfree_rcu_mightsleep to free the perag structures
Date: Wed, 21 Aug 2024 08:38:28 +0200
Message-ID: <20240821063901.650776-2-hch@lst.de>
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

Using the kfree_rcu_mightsleep is simpler and removes the need for a
rcu_head in the perag structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_ag.c | 12 +-----------
 fs/xfs/libxfs/xfs_ag.h |  3 ---
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index 7e80732cb54708..4b5a39a83f7aed 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -235,16 +235,6 @@ xfs_initialize_perag_data(
 	return error;
 }
 
-STATIC void
-__xfs_free_perag(
-	struct rcu_head	*head)
-{
-	struct xfs_perag *pag = container_of(head, struct xfs_perag, rcu_head);
-
-	ASSERT(!delayed_work_pending(&pag->pag_blockgc_work));
-	kfree(pag);
-}
-
 /*
  * Free up the per-ag resources associated with the mount structure.
  */
@@ -270,7 +260,7 @@ xfs_free_perag(
 		xfs_perag_rele(pag);
 		XFS_IS_CORRUPT(pag->pag_mount,
 				atomic_read(&pag->pag_active_ref) != 0);
-		call_rcu(&pag->rcu_head, __xfs_free_perag);
+		kfree_rcu_mightsleep(pag);
 	}
 }
 
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 35de09a2516c70..d62c266c0b44d5 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -63,9 +63,6 @@ struct xfs_perag {
 	/* Blocks reserved for the reverse mapping btree. */
 	struct xfs_ag_resv	pag_rmapbt_resv;
 
-	/* for rcu-safe freeing */
-	struct rcu_head	rcu_head;
-
 	/* Precalculated geometry info */
 	xfs_agblock_t		block_count;
 	xfs_agblock_t		min_block;
-- 
2.43.0


