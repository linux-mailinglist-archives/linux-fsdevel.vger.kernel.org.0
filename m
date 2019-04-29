Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1461DBEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfD2GQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 02:16:44 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51636 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727535AbfD2GQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:16:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TQTuosP_1556518593;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TQTuosP_1556518593)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Apr 2019 14:16:41 +0800
From:   zhangliguang <zhangliguang@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: clean up fuse_alloc_inode
Date:   Mon, 29 Apr 2019 14:16:33 +0800
Message-Id: <1556518593-20957-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch cleans up fuse_alloc_inode function, just simply the code, no
logic change.

Signed-off-by: zhangliguang <zhangliguang@linux.alibaba.com>
---
 fs/fuse/inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ec5d995..22abed8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -81,14 +81,12 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
-	struct inode *inode;
 	struct fuse_inode *fi;
 
-	inode = kmem_cache_alloc(fuse_inode_cachep, GFP_KERNEL);
-	if (!inode)
+	fi = kmem_cache_alloc(fuse_inode_cachep, GFP_KERNEL);
+	if (!fi)
 		return NULL;
 
-	fi = get_fuse_inode(inode);
 	fi->i_time = 0;
 	fi->inval_mask = 0;
 	fi->nodeid = 0;
@@ -100,11 +98,11 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
-		kmem_cache_free(fuse_inode_cachep, inode);
+		kmem_cache_free(fuse_inode_cachep, fi);
 		return NULL;
 	}
 
-	return inode;
+	return &fi->inode;
 }
 
 static void fuse_i_callback(struct rcu_head *head)
-- 
1.8.3.1

