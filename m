Return-Path: <linux-fsdevel+bounces-74100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 446C5D2F677
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE9930F88FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8D35FF55;
	Fri, 16 Jan 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i40Vzp86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584835BDDB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558377; cv=none; b=jrsAH0QLLxLlbYlBzwYRmFcOsCw5QWg48a4V8yF9bwww5G1Eh6pztk+NH6/0DXmccFTW1y8gF0G2BFiDInhH3NJNePz9M+tcQM4k3oWk4bc1VOHV6YP+VZ+e/dJjDwxfAMwuptUaxqZ6T0PbUCm2IskxlYOAaXxugaOD4gK9Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558377; c=relaxed/simple;
	bh=rUqBb3hy5DoJBLY2noeLoGmA3mIK7NNiH4fSf2cNSx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=eSgTq+NywRu3wk8ZHtsYdeoPD1cwa7/RsMitSmQ99py3rEKr7e5A33paERIM8EAVYGybHQNmmQ0uh8McOeIves0luU+t9ZSdCtpigqpY2q604o/tZx9XNXIvBZcQERwAy5S4LRlrFS5IJrrb3mbOW88Uc2GEUtphtgwYGJZrzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i40Vzp86; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260116101248epoutp03396cce7e8276b38d5dfc9d3df7f6946d~LLncscaQ32848328483epoutp03X
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:12:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260116101248epoutp03396cce7e8276b38d5dfc9d3df7f6946d~LLncscaQ32848328483epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768558368;
	bh=BpzxFl3g/5TPELMzmGzvBSQN5CcPjGy3hoOD59YZp9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i40Vzp86mK+KJk3FkTupWTSO+BkS3RzcIzoiU2Jc88AB2MaIbXgMPVmjoYw7eb8/3
	 ENz3L5+08tou0+EIyr4NQ8vImMaquqCHoxKgdJ9tUIY4mopzNADJ5Gj0n1wyLVVvpW
	 mNNr0U6WGHBgKKpZUH2GuhjqxVQLlcxXLRp3bZfo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260116101247epcas5p44a05f2dc0b46ae9c4abe6b40e7f3a935~LLnbwhVO11433714337epcas5p4Q;
	Fri, 16 Jan 2026 10:12:47 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dswdp0SZCz6B9m4; Fri, 16 Jan
	2026 10:12:46 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7~LLnaQNlS10614306143epcas5p3b;
	Fri, 16 Jan 2026 10:12:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260116101241epsmtip26bf4fc723f2f52008806efa410901587~LLnW-7TWV0710307103epsmtip24;
	Fri, 16 Jan 2026 10:12:41 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, kundan.kumar@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v3 2/6] xfs: add helpers to pack AG prediction info for
 per-folio tracking
Date: Fri, 16 Jan 2026 15:38:14 +0530
Message-Id: <20260116100818.7576-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260116100818.7576-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101245epcas5p30269c6aa35784db67e6d6ca800a683a7@epcas5p3.samsung.com>

Introduce helper routines to pack and unpack AG prediction metadata
for folios. This provides a compact and self-contained representation
for AG tracking.

The packed layout uses:
 - bit 31	: valid
 - bit 24-30	: iomap type
 - bit 0-23	: AG number

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_iomap.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index ebcce7d49446..eaf4513f6759 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -12,6 +12,37 @@ struct xfs_inode;
 struct xfs_bmbt_irec;
 struct xfs_zone_alloc_ctx;
 
+/* pack prediction in a u32 stored in xarray */
+#define XFS_AGP_VALID_SHIFT 31
+#define XFS_AGP_TYPE_SHIFT 24
+#define XFS_AGP_TYPE_MASK 0x7fu
+#define XFS_AGP_AGNO_MASK 0x00ffffffu
+
+static inline u32 xfs_agp_pack(u32 agno, u8 iomap_type, bool valid)
+{
+	u32 v = agno & XFS_AGP_AGNO_MASK;
+
+	v |= ((u32)iomap_type & XFS_AGP_TYPE_MASK) << XFS_AGP_TYPE_SHIFT;
+	if (valid)
+		v |= (1u << XFS_AGP_VALID_SHIFT);
+	return v;
+}
+
+static inline bool xfs_agp_valid(u32 v)
+{
+	return v >> XFS_AGP_VALID_SHIFT;
+}
+
+static inline u32 xfs_agp_agno(u32 v)
+{
+	return v & XFS_AGP_AGNO_MASK;
+}
+
+static inline u8 xfs_agp_type(u32 v)
+{
+	return (u8)((v >> XFS_AGP_TYPE_SHIFT) & XFS_AGP_TYPE_MASK);
+}
+
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
 		struct xfs_bmbt_irec *imap, u64 *sequence);
-- 
2.25.1


