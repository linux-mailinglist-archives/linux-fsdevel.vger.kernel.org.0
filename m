Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC068ACB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 04:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHMCbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 22:31:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbfHMCbk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 22:31:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B872AA85E77373CDF1D0;
        Tue, 13 Aug 2019 10:31:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 10:31:26 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 3/3] staging: erofs: xattr.c: avoid BUG_ON
Date:   Tue, 13 Aug 2019 10:30:54 +0800
Message-ID: <20190813023054.73126-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813023054.73126-1-gaoxiang25@huawei.com>
References: <20190813023054.73126-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kill all the remaining BUG_ON in EROFS:
 - one BUG_ON was used to detect xattr on-disk corruption,
   proper error handling should be added for it instead;
 - the other BUG_ONs are used to detect potential issues,
   use DBG_BUGON only in (eng) debugging version.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/xattr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index b29177a17347..289c7850ec96 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -115,7 +115,7 @@ static int init_inode_xattrs(struct inode *inode)
 	for (i = 0; i < vi->xattr_shared_count; ++i) {
 		if (unlikely(it.ofs >= EROFS_BLKSIZ)) {
 			/* cannot be unaligned */
-			BUG_ON(it.ofs != EROFS_BLKSIZ);
+			DBG_BUGON(it.ofs != EROFS_BLKSIZ);
 			xattr_iter_end(&it, atomic_map);
 
 			it.page = erofs_get_meta_page(sb, ++it.blkaddr,
@@ -191,7 +191,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 
 	xattr_header_sz = inlinexattr_header_size(inode);
 	if (unlikely(xattr_header_sz >= vi->xattr_isize)) {
-		BUG_ON(xattr_header_sz > vi->xattr_isize);
+		DBG_BUGON(xattr_header_sz > vi->xattr_isize);
 		return -ENOATTR;
 	}
 
@@ -234,7 +234,11 @@ static int xattr_foreach(struct xattr_iter *it,
 	if (tlimit) {
 		unsigned int entry_sz = EROFS_XATTR_ENTRY_SIZE(&entry);
 
-		BUG_ON(*tlimit < entry_sz);
+		/* xattr on-disk corruption: xattr entry beyond xattr_isize */
+		if (unlikely(*tlimit < entry_sz)) {
+			DBG_BUGON(1);
+			return -EIO;
+		}
 		*tlimit -= entry_sz;
 	}
 
@@ -253,7 +257,7 @@ static int xattr_foreach(struct xattr_iter *it,
 
 	while (processed < entry.e_name_len) {
 		if (it->ofs >= EROFS_BLKSIZ) {
-			BUG_ON(it->ofs > EROFS_BLKSIZ);
+			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
 
 			err = xattr_iter_fixup(it);
 			if (err)
@@ -288,7 +292,7 @@ static int xattr_foreach(struct xattr_iter *it,
 
 	while (processed < value_sz) {
 		if (it->ofs >= EROFS_BLKSIZ) {
-			BUG_ON(it->ofs > EROFS_BLKSIZ);
+			DBG_BUGON(it->ofs > EROFS_BLKSIZ);
 
 			err = xattr_iter_fixup(it);
 			if (err)
-- 
2.17.1

