Return-Path: <linux-fsdevel+bounces-72985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C8D06F73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 04:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB287308791D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256833D6EC;
	Fri,  9 Jan 2026 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hUIhslzj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4F2ECE98;
	Fri,  9 Jan 2026 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928500; cv=none; b=uAUTTqBCpXZuaec47yQaeGoXwTTRX0l2O/xvPRAq65mM7XGnbDKO/mj6naWWjUJrbnS9SvKwuc580Q0YN+iLIryeWS/czo5ImvxNtNRHv4wV+TSf1ZOwoA8IyBpKHXsGx9m6621dCVS5CPN+XXJudzrNwXEQtXi7zZQrwHP674Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928500; c=relaxed/simple;
	bh=shYAQ3lGozBsYbgoOmCKLJomtqqhFwD0YN3X53tnIG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWf+OdO1Z9vzUsp7dOLWidVy2HbxYaTYoiQQuELJnDXudodzJjEUDRVzSGFLAlDSkuW+UGusrSSKR1TzHppeTe0XBhxK6e8t/A2WUwGeRSAIBR+Wyxj4O7xXK1ozHA86AZ3Ox60uTnzUR3A2wYavRqPurqr1R5yPXfk4B6AfOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hUIhslzj; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hQ8B+kTJ87A5bJZYLMwSH+1zUPwX+xL11pHpPAvyQBc=;
	b=hUIhslzjt+3TiLa4Crz2+1YnA91y/cGKGQTyech0JJnAPNHvsHF+2TckCPxjmEZl/eywQaxv1
	LY/cPzAWdwuceaZe2HTeYECY0LdqlqdpyOL5mkxbNWs0RFlF/gDYq+Gv6FcAF8TWMHxW4MOjvUY
	euvz90ggx++3rtD+NGzdA9c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dnRcz4wpjzpSyw;
	Fri,  9 Jan 2026 11:11:31 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EC6894036C;
	Fri,  9 Jan 2026 11:14:55 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 11:14:55 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v13 09/10] erofs: support compressed inodes for page cache share
Date: Fri, 9 Jan 2026 03:01:39 +0000
Message-ID: <20260109030140.594936-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109030140.594936-1-lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch adds page cache sharing functionality for compressed inodes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/zdata.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca0..62d9dca90822 100644
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
@@ -1883,8 +1883,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *sharedinode = folio->mapping->host;
+	bool need_iput;
+	struct inode *realinode = erofs_real_inode(sharedinode, &need_iput);
+	Z_EROFS_DEFINE_FRONTEND(f, realinode, sharedinode, folio_pos(folio));
 	int err;
 
 	trace_erofs_read_folio(folio, false);
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


