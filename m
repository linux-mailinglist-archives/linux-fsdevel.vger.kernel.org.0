Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309A95353EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbiEZT3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E35C856
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wSd+lbnlA77fblK457Iy6DahZ3A7HH6ZJjKfKRHg/4w=; b=IMklrt3JsXu5P8PYMJ2VHj6iow
        2KCDqmdQX6lM7B64t6uefOpxbY40sh00H/XfxWj9ogi2Buh0umpyO8SZgftp8IPprO1hh8d1WtNEK
        vWuX6IVQVpbnWHYVoQ2le2F4baEn3XXgCJ5+/AY/NpMOUm1r0w0QsuZCUqeT65tQz1leeYbSNOY4l
        8BUWeTydaJsOnxGugC7jAcipHfMtx03CON/0xDwWXiYHHjbPC3DZoOB3Eqse34uWFmUJhY1ybKdxg
        GXO5JiCmXYpcCjNzcDyDSixYDWeqI+w37Rr6/OTCJHLBM15HhG+7KCBx041/dqn5PmuQyLgVjzrPF
        lF1HAJEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAa-001UuN-Mt; Thu, 26 May 2022 19:29:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 3/9] jfs: Convert direct_IO read support to use iomap
Date:   Thu, 26 May 2022 20:29:04 +0100
Message-Id: <20220526192910.357055-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new iomap support to handle direct IO reads.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/file.c      | 20 ++++++++++++++++++--
 fs/jfs/inode.c     |  4 ++++
 fs/jfs/jfs_inode.h |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 1d732fd223d4..0d074a9e0f77 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -4,10 +4,12 @@
  *   Portions Copyright (C) Christoph Hellwig, 2001-2002
  */
 
-#include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/mm.h>
 #include <linux/posix_acl.h>
 #include <linux/quotaops.h>
+#include <linux/uio.h>
 #include "jfs_incore.h"
 #include "jfs_inode.h"
 #include "jfs_dmap.h"
@@ -70,6 +72,20 @@ static int jfs_open(struct inode *inode, struct file *file)
 
 	return 0;
 }
+
+static ssize_t jfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if (!iov_iter_count(to))
+		return 0; /* skip atime */
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		file_accessed(iocb->ki_filp);
+		return iomap_dio_rw(iocb, to, &jfs_iomap_ops, NULL, 0, NULL, 0);
+	}
+
+	return generic_file_read_iter(iocb, to);
+}
+
 static int jfs_release(struct inode *inode, struct file *file)
 {
 	struct jfs_inode_info *ji = JFS_IP(inode);
@@ -141,7 +157,7 @@ const struct inode_operations jfs_file_inode_operations = {
 const struct file_operations jfs_file_operations = {
 	.open		= jfs_open,
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
+	.read_iter	= jfs_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.splice_read	= generic_file_splice_read,
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 1a5bdaf35e9b..22e8a5612fdc 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -294,6 +294,10 @@ int jfs_iomap_begin(struct inode *ip, loff_t pos, loff_t length,
 	return rc;
 }
 
+const struct iomap_ops jfs_iomap_ops = {
+	.iomap_begin =  jfs_iomap_begin,
+};
+
 int jfs_get_block(struct inode *ip, sector_t lblock,
 		  struct buffer_head *bh_result, int create)
 {
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index 7de961a81862..afd12de3c341 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -30,6 +30,7 @@ extern void jfs_set_inode_flags(struct inode *);
 extern int jfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern int jfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
+extern const struct iomap_ops jfs_iomap_ops;
 extern const struct address_space_operations jfs_aops;
 extern const struct inode_operations jfs_dir_inode_operations;
 extern const struct file_operations jfs_dir_operations;
-- 
2.34.1

