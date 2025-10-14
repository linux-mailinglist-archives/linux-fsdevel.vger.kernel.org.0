Return-Path: <linux-fsdevel+bounces-64113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE6BD9430
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2758A4FFC80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC73288C13;
	Tue, 14 Oct 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W05Y14re"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DA312823
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443846; cv=none; b=tVavy4KU15nfF4zRQwMwCtbNvsR2miodjIBaKg3PLa7XmkyMw8iyfKrUW2lqXYmxHb6UZPY9Q9zMD1DgSwMeX+4JAOY+Fvcad5OjorUaT2aLx6ll9S6UuYMj87WVnInCU2OXSFmY6ERDe7Tb2wFOsSzf0rZaBLiREdMPNDtlGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443846; c=relaxed/simple;
	bh=ldxgAyj9/VqFwMSe3xT93eZXRlJRqfwdk2Rwfgr5R/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=KsDow5ZHOeMoxKQycXJ6sG353zT3gpCDATbJu6niWOqb/TQjpq/Oscu8/vopKdScmMsGYbBpDtti3zOA1kTKWiuEEtSaeTcd0nwLgnvVU/QPAF9yrbJMoVqQ+jgLvApYL8VRCYVKbIa4oMho+NQcOvjwFVmvOPE1t0SDNyBEtJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W05Y14re; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251014121034epoutp02f9f9c95acb77cabe4f75df48a5509c5d~uWlcD4CMi2267922679epoutp028
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251014121034epoutp02f9f9c95acb77cabe4f75df48a5509c5d~uWlcD4CMi2267922679epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443834;
	bh=rKJH8bwqA59RYOc+B5sM49aSVlRkW4PvNX4CEB13cCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W05Y14rePZ8RFgXUzU42idAHG2tHyqnxyTHEGnyOuTLnJCR/PBRpmpxJAYeWIdafb
	 wDeLhW0PSZ/QiE4Za8cKFfPoUyj6W/ieVWNi+AasoDHJtSKXrhQXMrBrzXsJ31gnd4
	 J5rZ2dJ/Xi23b+2H3bT+d4wVB81A2+1H8pW1F1c4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251014121033epcas5p1d8391adbcd15cb4c8848b8cb66b6cfeb~uWlbWfGcV0673806738epcas5p1Z;
	Tue, 14 Oct 2025 12:10:33 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cmCj42h5Qz6B9mF; Tue, 14 Oct
	2025 12:10:32 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014121031epcas5p37b0c4e23a7ad2d623ba776498f795fb0~uWlZtq5xY0650006500epcas5p33;
	Tue, 14 Oct 2025 12:10:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121026epsmtip1b892e5a7d3af784888e5b4d33982dd8f~uWlVOMbrO1256112561epsmtip1n;
	Tue, 14 Oct 2025 12:10:26 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 04/16] writeback: affine inode to a writeback ctx within
 a bdi
Date: Tue, 14 Oct 2025 17:38:33 +0530
Message-Id: <20251014120845.2361-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121031epcas5p37b0c4e23a7ad2d623ba776498f795fb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121031epcas5p37b0c4e23a7ad2d623ba776498f795fb0
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121031epcas5p37b0c4e23a7ad2d623ba776498f795fb0@epcas5p3.samsung.com>

Affine inode to a writeback context. This helps in minimizing the
filesytem fragmentation due to inode being processed by different
threads.

To support parallel writeback, wire up a new superblock operation
get_inode_wb_ctx(). Filesystems can override this callback and select
desired writeback context for a inode. FS can use the wb context based
on its geometry and also use 64 bit inode numbers.

If a filesystem doesn't implement this callback, it defaults to
DEFALT_WB_CTX = 0, maintaining its original behavior.

An example implementation for XFS is provided, where XFS selects the
writeback context based on its Allocation Group number.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 fs/fs-writeback.c           |  3 ++-
 fs/xfs/xfs_super.c          | 13 +++++++++++++
 include/linux/backing-dev.h |  5 ++++-
 include/linux/fs.h          |  1 +
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 0715a7617391..56c048e22f72 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -265,7 +265,8 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct bdi_writeback *wb = NULL;
-	struct bdi_writeback_ctx *bdi_writeback_ctx = bdi->wb_ctx[0];
+	struct bdi_writeback_ctx *bdi_writeback_ctx =
+						fetch_bdi_writeback_ctx(inode);
 
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bb0a82635a77..b3ec9141d902 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -53,6 +53,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/backing-dev.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -1294,6 +1295,17 @@ xfs_fs_show_stats(
 	return 0;
 }
 
+static struct bdi_writeback_ctx *
+xfs_get_inode_wb_ctx(
+	struct inode		*inode)
+{
+	struct xfs_inode *ip = XFS_I(inode);
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	xfs_agino_t agno = XFS_INO_TO_AGNO(ip->i_mount, ip->i_ino);
+
+	return bdi->wb_ctx[agno % bdi->nr_wb_ctx];
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1310,6 +1322,7 @@ static const struct super_operations xfs_super_operations = {
 	.free_cached_objects	= xfs_fs_free_cached_objects,
 	.shutdown		= xfs_fs_shutdown,
 	.show_stats		= xfs_fs_show_stats,
+	.get_inode_wb_ctx       = xfs_get_inode_wb_ctx,
 };
 
 static int
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 951ab5497500..59bbb69d300c 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -148,6 +148,7 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
 }
 
+#define DEFAULT_WB_CTX 0
 #define for_each_bdi_wb_ctx(bdi, wbctx) \
 	for (int __i = 0; __i < (bdi)->nr_wb_ctx \
 		&& ((wbctx) = (bdi)->wb_ctx[__i]) != NULL; __i++)
@@ -157,7 +158,9 @@ fetch_bdi_writeback_ctx(struct inode *inode)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 
-	return bdi->wb_ctx[0];
+	if (inode->i_sb->s_op->get_inode_wb_ctx)
+		return inode->i_sb->s_op->get_inode_wb_ctx(inode);
+	return bdi->wb_ctx[DEFAULT_WB_CTX];
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 754fec84f350..5199b0d49fa5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2379,6 +2379,7 @@ struct super_operations {
 	 */
 	int (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
 	void (*shutdown)(struct super_block *sb);
+	struct bdi_writeback_ctx *(*get_inode_wb_ctx)(struct inode *inode);
 };
 
 /*
-- 
2.25.1


