Return-Path: <linux-fsdevel+bounces-71945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FACD7D40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 03:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD68E30436A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28D29AB11;
	Tue, 23 Dec 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oyXsdRvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FAC4C92;
	Tue, 23 Dec 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766455757; cv=none; b=MUVbrg5Trjg1x+5C/FeZuPfI2Hvke7Ehc9L8Xsf3JMtXieUGkbXAgOUwx0Fb71Huq6or82j8GbddXy6p6G8rcp4a/jrOehqub7MV3IFXtQEBcBbUpBM5Ug6W3TR4CizrxOELyXcp6jg91O1CfWsETxGbXvN68LL9k8ND4r8DkiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766455757; c=relaxed/simple;
	bh=tWepDqbbX6TWq5S+3UMsZ/LYuiqOHhp9T9F3WbuhMfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcwe6OuorodTQL3JcqhNP2LvsuH4TzWtZ7RECRDnC3ATS8W8wPZERjacNgu6fnwYuwNLKwmwDLiY5bdw1Sla3wch2yHKp1FnKUNSF53SlSUsFIWNliYVKdIiV6baIyaLG6icgBEaFrsCJrGiaorsxzCUja2NYhnFz+SbMtYCgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oyXsdRvU; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cJkZjKXmN2S52u+l7iY3dauuTHqH22kRuJcdDrTl9pE=;
	b=oyXsdRvUIs+WoOeYIOrN76mnBr8DgkttM7jx7sQUE53NokgqxeGpfMKV2L4o5d4q5CLOC8rgD
	tNPh/VUfh00FCzacg37OhLSeIEyuByVudFYGEq4uIa+qayVwGKGMhLr7VxpGatULMu5Hj05HoAU
	OuunuhBNPUShSHAVMKa3q0E=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZyzB2w2lznTV6;
	Tue, 23 Dec 2025 10:05:58 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 864ED40565;
	Tue, 23 Dec 2025 10:09:11 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:09:10 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 09/10] erofs: support compressed inodes for page cache share
Date: Tue, 23 Dec 2025 01:56:18 +0000
Message-ID: <20251223015618.485626-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch adds page cache sharing functionality for compressed inodes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/zdata.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 65da21504632..465918093984 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
 };
 
 struct z_erofs_frontend {
-	struct inode *const inode;
+	struct inode *inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
@@ -1883,10 +1883,18 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *const inode = folio->mapping->host, *realinode;
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));
 	int err;
 
+	if (erofs_is_ishare_inode(inode))
+		realinode = erofs_ishare_iget(inode);
+	else
+		realinode = inode;
+
+	if (!realinode)
+		return -EIO;
+	f.inode = realinode;
 	trace_erofs_read_folio(folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
@@ -1896,23 +1904,34 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	/* if some pclusters are ready, need submit them anyway */
 	err = z_erofs_runqueue(&f, 0) ?: err;
 	if (err && err != -EINTR)
-		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
-			  err, folio->index, EROFS_I(inode)->nid);
+		erofs_err(realinode->i_sb, "read error %d @ %lu of nid %llu",
+			  err, folio->index, EROFS_I(realinode)->nid);
 
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (erofs_is_ishare_inode(inode))
+		erofs_ishare_iput(realinode);
 	return err;
 }
 
 static void z_erofs_readahead(struct readahead_control *rac)
 {
-	struct inode *const inode = rac->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
+	struct inode *const inode = rac->mapping->host, *realinode;
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, readahead_pos(rac));
 	unsigned int nrpages = readahead_count(rac);
 	struct folio *head = NULL, *folio;
 	int err;
 
-	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
+	if (erofs_is_ishare_inode(inode))
+		realinode = erofs_ishare_iget(inode);
+	else
+		realinode = inode;
+
+	if (!realinode)
+		return;
+	f.inode = realinode;
+	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
@@ -1926,8 +1945,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
@@ -1935,6 +1954,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (erofs_is_ishare_inode(inode))
+		erofs_ishare_iput(realinode);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.22.0


