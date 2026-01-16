Return-Path: <linux-fsdevel+bounces-74101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3CD2F685
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30AB93100FE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D9135F8CD;
	Fri, 16 Jan 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GSl/06MQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CF35BDDB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558382; cv=none; b=erlnGpuuJjjqT0ZWONA0d2pgiJiRAwm2SR9U79YbbzKA+QEZWMIzaCOy5FrXLk54YHZ6XEkfTYSYYLwNcNQoLiPyDeppfzgCrKYOtDULxyK5CT6Keu+QQ2eZlROB/9GWW25CmwJ90tobOU3i9sqpcJn7YgLSY4DWVuzPJ6MRbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558382; c=relaxed/simple;
	bh=kJvj2LGCDCFFcgMVUpHGCzYO38dPH3J4Z1rkbXhWpkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SzBnuytDkf5jMDQZffCRY5L3Z2pRBF0LUvqhXtRvu2xh1l0SoKh5Zqfu9cvBnTWKoNJjDgJGvHoXnvqBli0HzFh76BV35O9rfr9yBfsC4GV+7KJ40BT6YN6xRztsTesCTXOxCQVB+B2cblQIgQPKAtbTZYWM/81dqd138NRyRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GSl/06MQ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260116101258epoutp021c8adbe661a8b075306773d3832d1e44~LLnmk3q-00374703747epoutp02N
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:12:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260116101258epoutp021c8adbe661a8b075306773d3832d1e44~LLnmk3q-00374703747epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768558378;
	bh=BgNe2KClDQ4hSoLFcOrhtcJFQXeFNHMsjPEUh+pkpmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSl/06MQCTcn6yrKwH56OSOZt3PIWhZ3MeaiPZOxTEyi+iQwUZK8UtF6Gocg2GEji
	 rry/kMmLDkUaeNK1Mw3lK/DFjP2wn3ckcjEB0x1+pt+5MNPUx+6PfNPSWoXYolRUUa
	 IZ1CfLw0VhzP6lKb4M0TblSibEiHPO5ML5Ljr1Gs=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260116101257epcas5p22e003553205af204b04e5d3beb95bd3e~LLnl18QVR0070600706epcas5p2i;
	Fri, 16 Jan 2026 10:12:57 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dswf06Z0Fz6B9m5; Fri, 16 Jan
	2026 10:12:56 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79~LLnkb0WwQ0497304973epcas5p2I;
	Fri, 16 Jan 2026 10:12:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260116101251epsmtip28e575dac3f1710c8d7adf508a92e75e0~LLngPxtb10634506345epsmtip2K;
	Fri, 16 Jan 2026 10:12:51 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, kundan.kumar@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v3 4/6] xfs: tag folios with AG number during buffered write
 via iomap attach hook
Date: Fri, 16 Jan 2026 15:38:16 +0530
Message-Id: <20260116100818.7576-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260116100818.7576-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79@epcas5p2.samsung.com>

Use the iomap attach hook to tag folios with their predicted
allocation group at write time. Mapped extents derive AG directly;
delalloc and hole cases use a lightweight predictor.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_iomap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 490e12cb99be..3c927ce118fe 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -12,6 +12,9 @@
 #include "xfs_trans_resv.h"
 #include "xfs_mount.h"
 #include "xfs_inode.h"
+#include "xfs_alloc.h"
+#include "xfs_ag.h"
+#include "xfs_ag_resv.h"
 #include "xfs_btree.h"
 #include "xfs_bmap_btree.h"
 #include "xfs_bmap.h"
@@ -92,8 +95,119 @@ xfs_iomap_valid(
 	return true;
 }
 
+static xfs_agnumber_t
+xfs_predict_delalloc_agno(const struct xfs_inode *ip, loff_t pos, loff_t len)
+{
+	struct xfs_mount *mp = ip->i_mount;
+	xfs_agnumber_t start_agno, agno, best_agno;
+	struct xfs_perag *pag;
+
+	xfs_extlen_t free, resv, avail;
+	xfs_extlen_t need_fsbs, min_free_fsbs;
+	xfs_extlen_t best_free = 0;
+	xfs_agnumber_t agcount = mp->m_sb.sb_agcount;
+
+	/* RT inodes allocate from the realtime volume */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_INO_TO_AGNO(mp, ip->i_ino);
+
+	start_agno =  XFS_INO_TO_AGNO(mp, ip->i_ino);
+
+	/*
+	 * size-based minimum free requirement.
+	 * Convert bytes to fsbs and require some slack.
+	 */
+	need_fsbs = XFS_B_TO_FSB(mp, (xfs_fsize_t)len);
+	min_free_fsbs = need_fsbs + max_t(xfs_extlen_t, need_fsbs >> 2, 128);
+
+	/*
+	 * scan AGs starting at start_agno and wrapping.
+	 * Pick the first AG that meets min_free_fsbs after reservations.
+	 * Keep a "best" fallback = maximum (free - resv).
+	 */
+	best_agno = start_agno;
+
+	for (xfs_agnumber_t i = 0; i < agcount; i++) {
+		agno = (start_agno + i) % agcount;
+		pag = xfs_perag_get(mp, agno);
+
+		if (!xfs_perag_initialised_agf(pag))
+			goto next;
+
+		free = READ_ONCE(pag->pagf_freeblks);
+		resv = xfs_ag_resv_needed(pag, XFS_AG_RESV_NONE);
+
+		if (free <= resv)
+			goto next;
+
+		avail = free - resv;
+
+		if (avail >= min_free_fsbs) {
+			xfs_perag_put(pag);
+			return agno;
+		}
+
+		if (avail > best_free) {
+			best_free = avail;
+			best_agno = agno;
+		}
+next:
+		xfs_perag_put(pag);
+	}
+
+	return best_agno;
+}
+
+static inline xfs_agnumber_t xfs_ag_from_iomap(const struct xfs_mount *mp,
+		const struct iomap *iomap,
+		const struct xfs_inode *ip, loff_t pos, size_t len)
+{
+	if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
+		/* iomap->addr is byte address on device for buffered I/O */
+		xfs_fsblock_t fsb = XFS_BB_TO_FSBT(mp, BTOBB(iomap->addr));
+
+		return XFS_FSB_TO_AGNO(mp, fsb);
+	} else if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_DELALLOC) {
+		return xfs_predict_delalloc_agno(ip, pos, len);
+	}
+
+	return XFS_INO_TO_AGNO(mp, ip->i_ino);
+}
+
+static void xfs_agp_set(struct xfs_inode *ip, pgoff_t index,
+			xfs_agnumber_t agno, u8 type)
+{
+	u32 packed = xfs_agp_pack((u32)agno, type, true);
+
+	/* store as immediate value */
+	xa_store(&ip->i_ag_pmap, index, xa_mk_value(packed), GFP_NOFS);
+
+	/* Mark this AG as having potential dirty work */
+	if (ip->i_ag_dirty_bitmap && (u32)agno < ip->i_ag_dirty_bits)
+		set_bit((u32)agno, ip->i_ag_dirty_bitmap);
+}
+
+static void
+xfs_iomap_tag_folio(const struct iomap *iomap, struct folio *folio,
+		loff_t pos, size_t len)
+{
+	struct inode *inode;
+	struct xfs_inode *ip;
+	struct xfs_mount *mp;
+	xfs_agnumber_t agno;
+
+	inode = folio_mapping(folio)->host;
+	ip = XFS_I(inode);
+	mp = ip->i_mount;
+
+	agno = xfs_ag_from_iomap(mp, iomap, ip, pos, len);
+
+	xfs_agp_set(ip, folio->index, agno, (u8)iomap->type);
+}
+
 const struct iomap_write_ops xfs_iomap_write_ops = {
 	.iomap_valid		= xfs_iomap_valid,
+	.tag_folio		= xfs_iomap_tag_folio,
 };
 
 int
-- 
2.25.1


