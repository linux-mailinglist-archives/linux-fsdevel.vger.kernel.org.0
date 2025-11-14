Return-Path: <linux-fsdevel+bounces-68452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3DC5C840
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DD8E4EAE1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BD30F813;
	Fri, 14 Nov 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zn+ICcYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD530C612;
	Fri, 14 Nov 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114823; cv=none; b=JiwH/j5fKBpeH2y6dcj8rAdhyDu2uUUhemr0Wqito35R1zS68o7BFpfp7+IXGvtHLzE+jWO2cRAMAWCqao6knkVOhD5J5LPmVQX3UhgzLJuLl27AUTmAvro3Canj65b4vOrvRkTLpnXcVkYyxTZ9tg0GLH0DzR38MR0UE1l4YmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114823; c=relaxed/simple;
	bh=xve2+kGFZTHOkYxgH0jMxSX7r2TIOgzhdqgWX8GsFUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj1BJUdql/KUc4qs7S+iZb8issNSDiBoCWVNit7ttZGs/X1GsBcSFl+4mWdK0BwDhhHiJwbvNpQu7O/EdUJBgrcs16cAVuaezO5L0jZ8tcshZ9j0yFgVpnmW539ZZTcxD9QdqL7yTohkdfDLr9O1P6vJ2CEmeqluWLfmb1t/L/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zn+ICcYV; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RShWmYYNSN4Yj3X7d1YRg7N32NEFA8HDJI2iwIW57nI=;
	b=zn+ICcYVW4epIJeGzk2AYE4IOT+gunL5IDen0QO4WHmfA4EMIzusgd/lPJbmuEwX/FbrJppR1
	F5dC19t/erFefncoDe/oqD496VViYr8Eq/UjIRpXN+RGgtY5/BjCwOMvQPv3FXNTV5/tLPW7C1S
	u6j0JjyzU31qIR1hQiX4gpI=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d7CS13sLTzcb1n;
	Fri, 14 Nov 2025 18:05:05 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id B0ABA140136;
	Fri, 14 Nov 2025 18:06:58 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 8/9] erofs: support compressed inodes for page cache share
Date: Fri, 14 Nov 2025 09:55:15 +0000
Message-ID: <20251114095516.207555-9-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch adds page cache sharing functionality for compressed inodes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/zdata.c | 56 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bc80cfe482f7..e76421de86cb 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 Alibaba Cloud
  */
 #include "compress.h"
+#include "ishare.h"
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
@@ -493,7 +494,7 @@ enum z_erofs_pclustermode {
 };
 
 struct z_erofs_frontend {
-	struct inode *const inode;
+	struct inode *inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
 
@@ -1870,10 +1871,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
-	struct inode *const inode = folio->mapping->host;
-	Z_EROFS_DEFINE_FRONTEND(f, inode, folio_pos(folio));
+	struct inode *const inode = folio->mapping->host, *realinode;
+	Z_EROFS_DEFINE_FRONTEND(f, NULL, folio_pos(folio));
+	struct erofs_read_ctx rdctx = {
+		.file = file,
+		.inode = inode,
+	};
 	int err;
 
+	trace_erofs_read_folio(folio, false);
+
+	erofs_read_begin(&rdctx);
+
+	if (erofs_is_ishare_inode(inode))
+		realinode = erofs_ishare_iget(inode);
+	else
+		realinode = inode;
+
+	f.inode = realinode;
 	trace_erofs_read_folio(folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
@@ -1883,23 +1898,39 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
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
+
+	erofs_read_end(&rdctx);
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
+	struct erofs_read_ctx rdctx = {
+		.file = rac->file,
+		.inode = inode,
+	};
 	int err;
 
-	trace_erofs_readahead(inode, readahead_index(rac), nrpages, false);
+	erofs_read_begin(&rdctx);
+	if (erofs_is_ishare_inode(inode))
+		realinode = erofs_ishare_iget(inode);
+	else
+		realinode = inode;
+
+	f.inode = realinode;
+	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
 	z_erofs_pcluster_readmore(&f, rac, true);
 	while ((folio = readahead_folio(rac))) {
 		folio->private = head;
@@ -1913,8 +1944,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 		err = z_erofs_scan_folio(&f, folio, true);
 		if (err && err != -EINTR)
-			erofs_err(inode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(inode)->nid);
+			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
+				  folio->index, EROFS_I(realinode)->nid);
 	}
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
@@ -1922,6 +1953,11 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_runqueue(&f, nrpages);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
+
+	if (erofs_is_ishare_inode(inode))
+		erofs_ishare_iput(realinode);
+
+	erofs_read_end(&rdctx);
 }
 
 const struct address_space_operations z_erofs_aops = {
-- 
2.22.0


