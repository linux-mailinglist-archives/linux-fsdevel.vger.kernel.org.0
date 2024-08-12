Return-Path: <linux-fsdevel+bounces-25633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9F94E6B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF551C203AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016914F9CD;
	Mon, 12 Aug 2024 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v8dCCDjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CD165EFF;
	Mon, 12 Aug 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444317; cv=none; b=AHmb4Dfbj3EHJ4SN3M1uQz7OPsl0ZVwcStrr8YgSETjw/GcS8pe07ZBYwdk4gT+p5CXfbMtABLsLs8ICGvI8sw8F7dc+Hb4wLa4aj4GMQELNvLbhz2HNnf1RHHhBGavAh4giZTO9A1/p/Wqo9pwyC6c3U5clOIZVSMiuLKP1KQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444317; c=relaxed/simple;
	bh=Z2rKMDvRnVUsDNHEJGouG/LnRfw084gmu32pKKx+v3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSf4ERaJTrGTP4hqBuRSlv3munu8Cr9z0agBGjMTUYe9iM5JgOO9EVyrYAb2fanWiVhQPxIbEO+UJ3MOsgus+8/ie3swxIuNfH3byrnYYTxmRlj+GGeGZw8ekQA2BqWKW95YIVJtXomcLvV7BEmBigWN3kf38L/j0Ry8qq97858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v8dCCDjM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1Mf47dsmFdXaLM/5Uz2vFkWWSorSPzCT+SfcQvDKnl4=; b=v8dCCDjMy85t9lz4dQD1eOiMk+
	OZqfIxBSgcM1Caa/Uxqx165Mzst6gpmHn9QrkHaRrZMCwDbL6RBuqDiMqimtgThJEtiCdhvnY16VF
	drd9NUn3Or/qOPcfiwz5bqhFNo5rjGxiLhiRjAGSOcrEwbzrwZ4rB8pBjX0tk7GDvDMBVFbKKwQbm
	25W7VwB4yiJVCUi3qKsHAuRf9ClwpGUsSbQG1EvEo8Fh0G8d7XNki8wV1RrPcov9CAuxj2dxl5hFs
	FHapcKp5TgB8kffCpfeR0dS0U7lC92VeChSl0N3BUOyqI3k+5E70RgkrOWs1xebEsV/RUzBDb7r+k
	fLA8AbKA==;
Received: from 2a02-8389-2341-5b80-ee60-2eea-6f8f-8d7f.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ee60:2eea:6f8f:8d7f] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOaw-0000000H1Me-13e8;
	Mon, 12 Aug 2024 06:31:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] xfs: use kfree_rcu_mightsleep to free the perag structures
Date: Mon, 12 Aug 2024 08:31:02 +0200
Message-ID: <20240812063143.3806677-4-hch@lst.de>
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

Using the kfree_rcu_mightsleep is simpler and removes the need for a
rcu_head in the perag structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_ag.c | 12 +-----------
 fs/xfs/libxfs/xfs_ag.h |  3 ---
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index 5efb1e8b4107a9..55cf41be04d145 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -185,16 +185,6 @@ xfs_initialize_perag_data(
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
@@ -218,7 +208,7 @@ xfs_free_perag(
 		xfs_perag_rele(pag);
 		XFS_IS_CORRUPT(pag->pag_mount,
 				atomic_read(&pag->pag_active_ref) != 0);
-		call_rcu(&pag->rcu_head, __xfs_free_perag);
+		kfree_rcu_mightsleep(pag);
 	}
 }
 
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index b5eee2c787b6b7..d9cccd093b60e0 100644
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


