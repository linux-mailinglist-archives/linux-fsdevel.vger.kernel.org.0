Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75B664D71D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLOHPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 02:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLOHOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:14:44 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969033134E;
        Wed, 14 Dec 2022 23:14:37 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXjzq0bNbzgZ2b;
        Thu, 15 Dec 2022 15:10:15 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 15:14:32 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <bvanassche@acm.org>, <slava@dubeyko.com>,
        <akpm@linux-foundation.org>, <gargaditya08@live.com>,
        <axboe@kernel.dk>, <chenxiaosong2@huawei.com>,
        <willy@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <jlayton@kernel.org>, <hannes@cmpxchg.org>, <tytso@mit.edu>,
        <muchun.song@linux.dev>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] hfsplus: introduce hfsplus_init_inode() helper
Date:   Thu, 15 Dec 2022 16:18:19 +0800
Message-ID: <20221215081820.948990-2-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221215081820.948990-1-chenxiaosong2@huawei.com>
References: <20221215081820.948990-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out hfsplus_init_inode(), No functional change.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/inode.c      | 35 ++++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 6aa919e59483..2aa719e00ae5 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -472,6 +472,7 @@ extern const struct dentry_operations hfsplus_dentry_operations;
 
 int hfsplus_write_begin(struct file *file, struct address_space *mapping,
 		loff_t pos, unsigned len, struct page **pagep, void **fsdata);
+void hfsplus_init_inode(struct hfsplus_inode_info *hip);
 struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 				umode_t mode);
 void hfsplus_delete_inode(struct inode *inode);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 840577a0c1e7..d921b32d292e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -379,22 +379,8 @@ static const struct file_operations hfsplus_file_operations = {
 	.unlocked_ioctl = hfsplus_ioctl,
 };
 
-struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
-				umode_t mode)
+void hfsplus_init_inode(struct hfsplus_inode_info *hip)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
-	struct inode *inode = new_inode(sb);
-	struct hfsplus_inode_info *hip;
-
-	if (!inode)
-		return NULL;
-
-	inode->i_ino = sbi->next_cnid++;
-	inode_init_owner(&init_user_ns, inode, dir, mode);
-	set_nlink(inode, 1);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-
-	hip = HFSPLUS_I(inode);
 	INIT_LIST_HEAD(&hip->open_dir_list);
 	spin_lock_init(&hip->open_dir_lock);
 	mutex_init(&hip->extents_lock);
@@ -412,6 +398,25 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 	hip->phys_size = 0;
 	hip->fs_blocks = 0;
 	hip->rsrc_inode = NULL;
+}
+
+struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
+				umode_t mode)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	struct inode *inode = new_inode(sb);
+	struct hfsplus_inode_info *hip;
+
+	if (!inode)
+		return NULL;
+
+	inode->i_ino = sbi->next_cnid++;
+	inode_init_owner(&init_user_ns, inode, dir, mode);
+	set_nlink(inode, 1);
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+
+	hip = HFSPLUS_I(inode);
+	hfsplus_init_inode(hip);
 	if (S_ISDIR(inode->i_mode)) {
 		inode->i_size = 2;
 		sbi->folder_count++;
-- 
2.31.1

