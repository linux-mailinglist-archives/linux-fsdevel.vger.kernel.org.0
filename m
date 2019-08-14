Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FD8D0CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfHNKht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 06:37:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfHNKht (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:37:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BFBBF8CE2F7EE151AD9;
        Wed, 14 Aug 2019 18:37:47 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 18:37:39 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, Pavel Machek <pavel@denx.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 2/3] staging: erofs: differentiate unsupported on-disk format
Date:   Wed, 14 Aug 2019 18:37:04 +0800
Message-ID: <20190814103705.60698-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814103705.60698-1-gaoxiang25@huawei.com>
References: <20190814103705.60698-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For some specific fields, use EOPNOTSUPP instead of EIO
for values which look sane but aren't supported right now.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log from v1:
 - use EOPNOTSUPP rather than ENOTSUPP pointed by Chao;

 drivers/staging/erofs/inode.c | 4 ++--
 drivers/staging/erofs/zmap.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 461fd4213ce7..c8f3ded17583 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -24,7 +24,7 @@ static int read_inode(struct inode *inode, void *data)
 		errln("unsupported data mapping %u of nid %llu",
 		      vi->datamode, vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -EOPNOTSUPP;
 	}
 
 	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
@@ -95,7 +95,7 @@ static int read_inode(struct inode *inode, void *data)
 		errln("unsupported on-disk inode version %u of nid %llu",
 		      __inode_version(advise), vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -EOPNOTSUPP;
 	}
 
 	if (!nblks)
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index 16b3625604f4..5551e615e8ea 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -178,7 +178,7 @@ static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		break;
 	default:
 		DBG_BUGON(1);
-		return -EIO;
+		return -EOPNOTSUPP;
 	}
 	m->type = type;
 	return 0;
@@ -362,7 +362,7 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 		errln("unknown type %u at lcn %lu of nid %llu",
 		      m->type, lcn, vi->nid);
 		DBG_BUGON(1);
-		return -EIO;
+		return -EOPNOTSUPP;
 	}
 	return 0;
 }
@@ -436,7 +436,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	default:
 		errln("unknown type %u at offset %llu of nid %llu",
 		      m.type, ofs, vi->nid);
-		err = -EIO;
+		err = -EOPNOTSUPP;
 		goto unmap_out;
 	}
 
-- 
2.17.1

