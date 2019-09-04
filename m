Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFBE6A7871
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfIDCKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727992AbfIDCKk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 060AAA4F430BAAEEEBB4;
        Wed,  4 Sep 2019 10:10:39 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:28 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 21/25] erofs: save one level of indentation
Date:   Wed, 4 Sep 2019 10:09:08 +0800
Message-ID: <20190904020912.63925-22-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christoph said [1], ".. and save one
level of indentation."

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8e53765a532c..5a6d3282fefb 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -193,41 +193,42 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	data = page_address(page);
 
 	err = erofs_read_inode(inode, data + ofs);
-	if (!err) {
-		/* setup the new inode */
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFREG:
-			inode->i_op = &erofs_generic_iops;
-			inode->i_fop = &generic_ro_fops;
-			break;
-		case S_IFDIR:
-			inode->i_op = &erofs_dir_iops;
-			inode->i_fop = &erofs_dir_fops;
-			break;
-		case S_IFLNK:
-			err = erofs_fill_symlink(inode, data, ofs);
-			if (err)
-				goto out_unlock;
-			inode_nohighmem(inode);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-		case S_IFIFO:
-		case S_IFSOCK:
-			inode->i_op = &erofs_generic_iops;
-			init_special_inode(inode, inode->i_mode, inode->i_rdev);
-			goto out_unlock;
-		default:
-			err = -EFSCORRUPTED;
+	if (err)
+		goto out_unlock;
+
+	/* setup the new inode */
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_op = &erofs_generic_iops;
+		inode->i_fop = &generic_ro_fops;
+		break;
+	case S_IFDIR:
+		inode->i_op = &erofs_dir_iops;
+		inode->i_fop = &erofs_dir_fops;
+		break;
+	case S_IFLNK:
+		err = erofs_fill_symlink(inode, data, ofs);
+		if (err)
 			goto out_unlock;
-		}
+		inode_nohighmem(inode);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_op = &erofs_generic_iops;
+		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+		goto out_unlock;
+	default:
+		err = -EFSCORRUPTED;
+		goto out_unlock;
+	}
 
-		if (erofs_inode_is_data_compressed(vi->datalayout)) {
-			err = z_erofs_fill_inode(inode);
-			goto out_unlock;
-		}
-		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		err = z_erofs_fill_inode(inode);
+		goto out_unlock;
 	}
+	inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 out_unlock:
 	unlock_page(page);
-- 
2.17.1

