Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975E66562F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 09:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjAKIcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 03:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAKIcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:32:15 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E804EBC9F;
        Wed, 11 Jan 2023 00:32:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMek6i_1673425922;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMek6i_1673425922)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:32:03 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/7] erofs: implement .read_iter for page cache sharing
Date:   Wed, 11 Jan 2023 16:31:55 +0800
Message-Id: <20230111083158.23462-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
References: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/erofs/fscache.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index f715b3efcc77..4075d9519a7d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -384,8 +384,56 @@ static int erofs_fscache_share_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
+						  struct iov_iter *to)
+{
+	struct file *filp = iocb->ki_filp;
+	struct inode *inode = file_inode(filp);
+	struct file *realfile = filp->private_data;
+	struct inode *realinode = file_inode(realfile);
+	struct erofs_fscache_share_file_info *finfo = realfile->private_data;
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
+	do {
+		struct folio *folio;
+		size_t bytes, copied, offset, fsize;
+		pgoff_t index = (finfo->pa + iocb->ki_pos) >> PAGE_SHIFT;
+
+		folio = read_cache_folio(realinode->i_mapping, index, NULL, NULL);
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
 const struct file_operations erofs_fscache_share_file_fops = {
 	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_fscache_share_file_read_iter,
 	.open		= erofs_fscache_share_file_open,
 	.release	= erofs_fscache_share_file_release,
 };
-- 
2.19.1.6.gb485710b

