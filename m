Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5547E6600A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 13:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjAFMx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 07:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjAFMxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:53:40 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E7D66981;
        Fri,  6 Jan 2023 04:53:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-Jgw5_1673009614;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-Jgw5_1673009614)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:35 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 4/6] erofs: implement .read_iter for page cache sharing
Date:   Fri,  6 Jan 2023 20:53:28 +0800
Message-Id: <20230106125330.55529-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
References: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
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

When page cache sharing enabled, page caches are managed in the address
space of blobs rather than erofs inodes.  All erofs inodes sharing one
chunk will refer to and share the page cache in the blob's address
space.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ea276884f043..1f2a42dd1590 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -320,6 +320,70 @@ const struct address_space_operations erofs_fscache_access_aops = {
 
 static const struct file_operations erofs_fscache_meta_fops = {};
 
+static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
+						  struct iov_iter *to)
+{
+	struct file *filp = iocb->ki_filp;
+	struct inode *inode = file_inode(filp);
+	/* since page cache sharing is enabled only when i_size <= chunk_size */
+	struct erofs_map_blocks map = {}; /* .m_la = 0 */
+	struct erofs_map_dev mdev;
+	struct folio *folio;
+	ssize_t already_read = 0;
+	int ret = 0;
+
+	/* no need taking (shared) inode lock since it's a ro filesystem */
+	if (!iov_iter_count(to))
+		return 0;
+
+	if (IS_DAX(inode) || iocb->ki_flags & IOCB_DIRECT)
+		return -EOPNOTSUPP;
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
+	do {
+		size_t bytes, copied, offset, fsize;
+		pgoff_t index = (mdev.m_pa >> PAGE_SHIFT) + (iocb->ki_pos >> PAGE_SHIFT);
+
+		folio = read_cache_folio(mdev.m_fscache->inode->i_mapping, index, NULL, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			break;
+		}
+
+		fsize = folio_size(folio);
+		offset = iocb->ki_pos & (fsize - 1);
+		bytes = min_t(size_t, inode->i_size - iocb->ki_pos, iov_iter_count(to));
+		bytes = min_t(size_t, bytes, fsize - offset);
+		copied = copy_folio_to_iter(folio, offset, bytes, to);
+		folio_put(folio);
+		iocb->ki_pos += copied;
+		already_read += copied;
+		if (copied < bytes) {
+			ret = -EFAULT;
+			break;
+		}
+	} while (iov_iter_count(to) && iocb->ki_pos < inode->i_size);
+
+	file_accessed(filp);
+	return already_read ? already_read : ret;
+}
+
+const struct file_operations erofs_fscache_share_file_fops = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_fscache_share_file_read_iter,
+};
+
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
 {
 	mutex_lock(&erofs_domain_list_lock);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 24d471fe2fa4..386e2fd4c025 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -617,6 +617,7 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
+extern const struct file_operations erofs_fscache_share_file_fops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-- 
2.19.1.6.gb485710b

