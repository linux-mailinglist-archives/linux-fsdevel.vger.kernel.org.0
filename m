Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8D130E55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 09:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAFIFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 03:05:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgAFIFJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:05:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A87FC39B56C3B4CF6703;
        Mon,  6 Jan 2020 16:05:06 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 Jan 2020
 16:04:57 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <yi.zhang@huawei.com>,
        <yihuaijie@huawei.com>, <zhongguohua1@huawei.com>,
        <chenjie6@huawei.com>
Subject: [PATCH] jffs2: move jffs2_init_inode_info() just after allocating inode
Date:   Mon, 6 Jan 2020 16:04:11 +0800
Message-ID: <20200106080411.41394-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After commit 4fdcfab5b553 ("jffs2: fix use-after-free on symlink
traversal"), it expose a freeing uninitialized memory problem due to
this commit move the operaion of freeing f->target to
jffs2_i_callback(), which may not be initialized in some error path of
allocating jffs2 inode (eg: jffs2_iget()->iget_locked()->
destroy_inode()->..->jffs2_i_callback()->kfree(f->target)).

Fix this by initialize the jffs2_inode_info just after allocating it.

Reported-by: Guohua Zhong <zhongguohua1@huawei.com>
Reported-by: Huaijie Yi <yihuaijie@huawei.com>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: stable@vger.kernel.org
---
 fs/jffs2/fs.c    | 2 --
 fs/jffs2/super.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index ab8cdd9e9325..50a9df7d43a5 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -270,7 +270,6 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	f = JFFS2_INODE_INFO(inode);
 	c = JFFS2_SB_INFO(inode->i_sb);
 
-	jffs2_init_inode_info(f);
 	mutex_lock(&f->sem);
 
 	ret = jffs2_do_read_inode(c, f, inode->i_ino, &latest_node);
@@ -438,7 +437,6 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 		return ERR_PTR(-ENOMEM);
 
 	f = JFFS2_INODE_INFO(inode);
-	jffs2_init_inode_info(f);
 	mutex_lock(&f->sem);
 
 	memset(ri, 0, sizeof(*ri));
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 0e6406c4f362..90373898587f 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -42,6 +42,8 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
 	if (!f)
 		return NULL;
+
+	jffs2_init_inode_info(f);
 	return &f->vfs_inode;
 }
 
-- 
2.17.2

