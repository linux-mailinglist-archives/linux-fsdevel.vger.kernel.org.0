Return-Path: <linux-fsdevel+bounces-74089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0D0D2F529
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC8D230FB13E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48E3612E6;
	Fri, 16 Jan 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="luzM9vjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428535BDDB;
	Fri, 16 Jan 2026 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558127; cv=none; b=aglGXuzKeTW/aFuEzJ/P8Xh+Kbq77A6zems6IrcBNW92ERFczGZcvQEgHdiL/c0irnt/2vUya2iXmLoPT6qdcl7OzrfrJqlxPBFVEN3Fc19mfIYBahr+TA1vDjsFsULVd/hRuASjFC4u1bF5c/GpuniHg3dii/XCjrumCqUhI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558127; c=relaxed/simple;
	bh=7bccBY+8R842a2lzvpO/VaUeCUOZ6hEejCOfP8ihjdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnxZLZnY3W/V9Gk5acLdeq2BaghFonIeGyolsoTRmNXiyxsOPIK/ZDh//bAWtbzhH4RmKbmObMDA4fnkOch3EkUqhWfSXNhFulM7W+dmXTOnbWPUCwzkKRtjPUxaFpSHbRESZ1EKHV3nyq5dOYt2GzvHkrAk4OLmYeXGA+tydGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=luzM9vjp; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=++qjl2jTgctpUWtnLLkUztenmX2mH2N2bI/tdJjFPnM=;
	b=luzM9vjpbiQ2l82xOg1MHxs97Y9kKRBlMtvngEUxODyzhxnZy8nqGRYZtwe+ijPSQQrreem9q
	2yp5mufGUNFzrlbVAlsUieBJpVFd2uYK7JoNzekqgJIlWap+koRXVUSXtpfdm/Pf42d3YZpB7bq
	s3Dk/8dcnS6UNKz8pLgNFOQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dswTh2ZNVz12Lrj;
	Fri, 16 Jan 2026 18:05:44 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 669F6405A2;
	Fri, 16 Jan 2026 18:08:43 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 18:08:42 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v15 8/9] erofs: support compressed inodes for page cache share
Date: Fri, 16 Jan 2026 09:55:49 +0000
Message-ID: <20260116095550.627082-9-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260116095550.627082-1-lihongbo22@huawei.com>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch adds page cache sharing functionality for compressed inodes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/ishare.c |  2 --
 fs/erofs/zdata.c  | 38 ++++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index affa34ac5b2e..96679286da95 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -44,8 +44,6 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 	struct inode *sharedinode;
 	unsigned long hash;
 
-	if (erofs_inode_is_data_compressed(vi->datalayout))
-		return false;
 	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
 		return false;
 	hash = xxh32(fp.opaque, fp.size, 0);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 93ab6a481b64..59ee9a36d9eb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -493,7 +493,7 @@ enum z_erofs_pclustermode {
 };
 
 struct z_erofs_frontend {
-	struct inode *const inode;
+	struct inode *inode, *sharedinode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
@@ -508,8 +508,8 @@ struct z_erofs_frontend {
 	unsigned int icur;
 };
 
-#define Z_EROFS_DEFINE_FRONTEND(fe, i, ho) struct z_erofs_frontend fe = { \
-	.inode = i, .head = Z_EROFS_PCLUSTER_TAIL, \
+#define Z_EROFS_DEFINE_FRONTEND(fe, i, si, ho) struct z_erofs_frontend fe = { \
+	.inode = i, .sharedinode = si, .head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .headoffset = ho }
 
 static bool z_erofs_should_alloc_cache(struct z_erofs_frontend *fe)
@@ -1866,7 +1866,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct folio *folio;
 
-		folio = erofs_grab_folio_nowait(inode->i_mapping, index);
+		folio = erofs_grab_folio_nowait(f->sharedinode->i_mapping, index);
 		if (!IS_ERR_OR_NULL(folio)) {
 			if (folio_test_uptodate(folio))
 				folio_unlock(folio);
@@ -1883,11 +1883,13 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *sharedinode = folio->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, folio_pos(folio));
 	int err;
 
-	trace_erofs_read_folio(inode, folio, false);
+	trace_erofs_read_folio(realinode, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
@@ -1896,23 +1898,28 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
+	if (need_iput)
+		iput(realinode);
 	return err;
 }
 
 static void z_erofs_readahead(struct readahead_control *rac)
 {
-	struct inode *const inode = rac->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, readahead_pos(rac));
+	struct inode *sharedinode = rac->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, readahead_pos(rac));
 	unsigned int nrpages = readahead_count(rac);
 	struct folio *head = NULL, *folio;
 	int err;
 
-	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
+	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
@@ -1926,8 +1933,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
@@ -1935,6 +1942,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (need_iput)
+		iput(realinode);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.22.0


