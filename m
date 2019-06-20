Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502974D2CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfFTQId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 12:08:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbfFTQId (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:08:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3EB8D1D75DB50C23311B;
        Fri, 21 Jun 2019 00:08:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 00:08:19 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 8/8] staging: erofs: integrate decompression inplace
Date:   Fri, 21 Jun 2019 00:07:19 +0800
Message-ID: <20190620160719.240682-9-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620160719.240682-1-gaoxiang25@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Decompressor needs to know whether it's a partial
or full decompression since only full decompression
can be decompressed in-place.

On kirin980 platform, sequential read is finally
increased to 812MiB/s after decompression inplace
is enabled.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h  |  3 +++
 drivers/staging/erofs/unzip_vle.c | 15 +++++++++++----
 drivers/staging/erofs/unzip_vle.h |  1 +
 drivers/staging/erofs/zmap.c      |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 6c8767d4a1d5..963cc1b8b896 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -441,6 +441,7 @@ extern const struct address_space_operations z_erofs_vle_normalaccess_aops;
  */
 enum {
 	BH_Zipped = BH_PrivateStart,
+	BH_FullMapped,
 };
 
 /* Has a disk mapping */
@@ -449,6 +450,8 @@ enum {
 #define EROFS_MAP_META		(1 << BH_Meta)
 /* The extent has been compressed */
 #define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 
 struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index cb870b83f3c8..316382d33783 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -469,6 +469,9 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 				    Z_EROFS_VLE_WORKGRP_FMT_LZ4 :
 				    Z_EROFS_VLE_WORKGRP_FMT_PLAIN);
 
+	if (map->m_flags & EROFS_MAP_FULL_MAPPED)
+		grp->flags |= Z_EROFS_VLE_WORKGRP_FULL_LENGTH;
+
 	/* new workgrps have been claimed as type 1 */
 	WRITE_ONCE(grp->next, *f->owned_head);
 	/* primary and followed work for all new workgrps */
@@ -901,7 +904,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	unsigned int i, outputsize;
 
 	enum z_erofs_page_type page_type;
-	bool overlapped;
+	bool overlapped, partial;
 	struct z_erofs_vle_work *work;
 	int err;
 
@@ -1009,10 +1012,13 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	if (unlikely(err))
 		goto out;
 
-	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen)
+	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen) {
 		outputsize = grp->llen;
-	else
+		partial = !(grp->flags & Z_EROFS_VLE_WORKGRP_FULL_LENGTH);
+	} else {
 		outputsize = (nr_pages << PAGE_SHIFT) - work->pageofs;
+		partial = true;
+	}
 
 	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN)
 		algorithm = Z_EROFS_COMPRESSION_SHIFTED;
@@ -1028,7 +1034,8 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 					.outputsize = outputsize,
 					.alg = algorithm,
 					.inplace_io = overlapped,
-					.partial_decoding = true }, page_pool);
+					.partial_decoding = partial
+				 }, page_pool);
 
 out:
 	/* must handle all compressed pages before endding pages */
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index a2d9b60beebd..ab509d75aefd 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -46,6 +46,7 @@ struct z_erofs_vle_work {
 #define Z_EROFS_VLE_WORKGRP_FMT_PLAIN        0
 #define Z_EROFS_VLE_WORKGRP_FMT_LZ4          1
 #define Z_EROFS_VLE_WORKGRP_FMT_MASK         1
+#define Z_EROFS_VLE_WORKGRP_FULL_LENGTH      2
 
 typedef void *z_erofs_vle_owned_workgrp_t;
 
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index 77bc49c07846..ce6d955f0112 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -424,6 +424,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			goto unmap_out;
 		}
 		end = (m.lcn << lclusterbits) | m.clusterofs;
+		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-- 
2.17.1

