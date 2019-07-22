Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF46F791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfGVCwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 22:52:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbfGVCvK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:51:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91C78888231FD268BA03;
        Mon, 22 Jul 2019 10:51:08 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 10:51:00 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 06/24] erofs: support special inode
Date:   Mon, 22 Jul 2019 10:50:25 +0800
Message-ID: <20190722025043.166344-7-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722025043.166344-1-gaoxiang25@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds to support special inode, such as
block dev, char, socket, pipe inode.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 79ef5b38dfa3..5a95cd076fcc 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -34,7 +34,16 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
-		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		    S_ISLNK(inode->i_mode))
+			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			inode->i_rdev = 0;
+		else
+			return -EIO;
 
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
@@ -58,7 +67,16 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
-		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		    S_ISLNK(inode->i_mode))
+			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			inode->i_rdev = 0;
+		else
+			return -EIO;
 
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
@@ -176,6 +194,11 @@ static int fill_inode(struct inode *inode, int isdir)
 			/* by default, page_get_link is used for symlink */
 			inode->i_op = &erofs_symlink_iops;
 			inode_nohighmem(inode);
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			inode->i_op = &erofs_generic_iops;
+			init_special_inode(inode, inode->i_mode, inode->i_rdev);
+			goto out_unlock;
 		} else {
 			err = -EIO;
 			goto out_unlock;
-- 
2.17.1

