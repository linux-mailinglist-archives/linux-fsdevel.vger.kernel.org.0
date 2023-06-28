Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED8741255
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjF1NYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:24:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:44130 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjF1NYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:24:22 -0400
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qrhzm3pmnzMpbx;
        Wed, 28 Jun 2023 21:21:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 21:24:19 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 6/7] quota: simplify drop_dquot_ref()
Date:   Wed, 28 Jun 2023 21:21:54 +0800
Message-ID: <20230628132155.1560425-7-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628132155.1560425-1-libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now when dqput() drops the last reference count, it will call
synchronize_srcu(&dquot_srcu) in quota_release_workfn() to ensure that
no other user will use the dquot after the last reference count is dropped,
so we don't need to call synchronize_srcu(&dquot_srcu) in drop_dquot_ref()
and remove the corresponding logic directly to simplify the code.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/quota/dquot.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e8e702ac64e5..df028fb2ce72 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1090,8 +1090,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
  * Remove references to dquots from inode and add dquot to list for freeing
  * if we have the last reference to dquot
  */
-static void remove_inode_dquot_ref(struct inode *inode, int type,
-				   struct list_head *tofree_head)
+static void remove_inode_dquot_ref(struct inode *inode, int type)
 {
 	struct dquot **dquots = i_dquot(inode);
 	struct dquot *dquot = dquots[type];
@@ -1100,21 +1099,7 @@ static void remove_inode_dquot_ref(struct inode *inode, int type,
 		return;
 
 	dquots[type] = NULL;
-	if (list_empty(&dquot->dq_free)) {
-		/*
-		 * The inode still has reference to dquot so it can't be in the
-		 * free list
-		 */
-		spin_lock(&dq_list_lock);
-		list_add(&dquot->dq_free, tofree_head);
-		spin_unlock(&dq_list_lock);
-	} else {
-		/*
-		 * Dquot is already in a list to put so we won't drop the last
-		 * reference here.
-		 */
-		dqput(dquot);
-	}
+	dqput(dquot);
 }
 
 /*
@@ -1137,8 +1122,7 @@ static void put_dquot_list(struct list_head *tofree_head)
 	}
 }
 
-static void remove_dquot_ref(struct super_block *sb, int type,
-		struct list_head *tofree_head)
+static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
 #ifdef CONFIG_QUOTA_DEBUG
@@ -1159,7 +1143,7 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
 #endif
-			remove_inode_dquot_ref(inode, type, tofree_head);
+			remove_inode_dquot_ref(inode, type);
 		}
 		spin_unlock(&dq_data_lock);
 	}
@@ -1176,13 +1160,8 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 /* Gather all references from inodes and drop them */
 static void drop_dquot_ref(struct super_block *sb, int type)
 {
-	LIST_HEAD(tofree_head);
-
-	if (sb->dq_op) {
-		remove_dquot_ref(sb, type, &tofree_head);
-		synchronize_srcu(&dquot_srcu);
-		put_dquot_list(&tofree_head);
-	}
+	if (sb->dq_op)
+		remove_dquot_ref(sb, type);
 }
 
 static inline
-- 
2.31.1

