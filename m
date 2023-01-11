Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078566562B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 09:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjAKIcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 03:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjAKIcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:32:11 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE248A1A7;
        Wed, 11 Jan 2023 00:32:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMQWl9_1673425921;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMQWl9_1673425921)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:32:02 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/7] erofs: allocate anonymous file of blob for page cache sharing
Date:   Wed, 11 Jan 2023 16:31:54 +0800
Message-Id: <20230111083158.23462-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
References: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In prep for the following support for page cache sharing based mmap,
allocate an anonymous file of corresponding blob, so that we can link
associated vma to the blob later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 74 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  1 +
 2 files changed, 75 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 81f96c910277..f715b3efcc77 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2022, Bytedance Inc. All rights reserved.
  */
 #include <linux/fscache.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
@@ -22,6 +24,11 @@ struct erofs_fscache_request {
 	refcount_t		ref;
 };
 
+struct erofs_fscache_share_file_info {
+	erofs_off_t pa;
+	pgoff_t max_idx;
+};
+
 static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
 					     loff_t start, size_t len)
 {
@@ -316,6 +323,73 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
+static int erofs_fscache_share_meta_release(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations erofs_fscache_share_meta_fops = {
+	.release	= erofs_fscache_share_meta_release,
+};
+
+static int erofs_fscache_share_file_release(struct inode *inode, struct file *filp)
+{
+	fput(filp->private_data);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
+{
+	/* since page cache sharing is enabled only when i_size <= chunk_size */
+	struct erofs_map_blocks map = {}; /* .m_la = 0 */
+	struct erofs_map_dev mdev;
+	struct inode *realinode;
+	struct file *realfile;
+	struct erofs_fscache_share_file_info *finfo;
+	int ret;
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		return ret;
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+	ret = erofs_map_dev(inode->i_sb, &mdev);
+	if (ret)
+		return ret;
+
+	finfo = kzalloc(sizeof(struct erofs_fscache_share_file_info), GFP_KERNEL);
+	if (!finfo)
+		return -ENOMEM;
+	finfo->pa = mdev.m_pa;
+	finfo->max_idx = DIV_ROUND_UP(mdev.m_pa + inode->i_size, PAGE_SIZE);
+
+	realinode = mdev.m_fscache->inode;
+	ihold(realinode);
+	realfile = alloc_file_pseudo(realinode, filp->f_path.mnt, "[erofs]",
+				     O_RDONLY, &erofs_fscache_share_meta_fops);
+	if (IS_ERR(realfile)) {
+		iput(realinode);
+		kfree(finfo);
+		return PTR_ERR(realfile);
+	}
+
+	realfile->private_data = finfo;
+	filp->private_data = realfile;
+	return 0;
+}
+
+const struct file_operations erofs_fscache_share_file_fops = {
+	.llseek		= generic_file_llseek,
+	.open		= erofs_fscache_share_file_open,
+	.release	= erofs_fscache_share_file_release,
+};
+
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
 	mutex_lock(&erofs_domain_list_lock);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b3d04bc2d279..7c6a7a2d9acf 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -616,6 +616,7 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
+extern const struct file_operations erofs_fscache_share_file_fops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-- 
2.19.1.6.gb485710b

