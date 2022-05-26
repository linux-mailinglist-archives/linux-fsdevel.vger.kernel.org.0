Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D85353F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbiEZT3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347746AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF3C4DF52
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m5kSAorTKHqAiImG8w+f7lMP3eiW2gQkHIrZBORqjjE=; b=eHVXSz5/mts7NdVRxF/PgQdQ5P
        7QVIMMKWtWkesGFGC2f5CnFSv75Px4EFICivOxRDSAiE4VQdSda6AclZ0n9qZxgmXuBrZr7v9l0Il
        pFcJx2S7ctmTBobKEROx4vecFbtEa17mWzjT+QkI3baPlHFvTXs3irTvBdCEz3N2gu0mfyOoNWooT
        Jj1WHQss5T60+XIrO+fe1k89zSyKadrBiKB4bNdJq3QX5xeoH+Yo8h8Vhz9766yo/+ovlXaOdQoWX
        lLxzEV/yJIWqYox8/T5w4xehOgBGEdf/Vhd2Z2BmWX+wFE2nCoxM2XQTK/IfsS+AA8OLxOEazne+C
        JbmGCgmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAa-001UuT-RA; Thu, 26 May 2022 19:29:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 4/9] jfs: Convert direct_IO write support to use iomap
Date:   Thu, 26 May 2022 20:29:05 +0100
Message-Id: <20220526192910.357055-5-willy@infradead.org>
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

Use the new iomap support to handle direct IO writes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/file.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 0d074a9e0f77..bf9d4475ddb5 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -4,6 +4,7 @@
  *   Portions Copyright (C) Christoph Hellwig, 2001-2002
  */
 
+#include <linux/backing-dev.h>
 #include <linux/fs.h>
 #include <linux/iomap.h>
 #include <linux/mm.h>
@@ -86,6 +87,39 @@ static ssize_t jfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return generic_file_read_iter(iocb, to);
 }
 
+static ssize_t jfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+
+	inode_lock(inode);
+	current->backing_dev_info = inode_to_bdi(inode);
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto err;
+	ret = file_remove_privs(file);
+	if (ret < 0)
+		goto err;
+	ret = file_update_time(file);
+	if (ret < 0)
+		goto err;
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = iomap_dio_rw(iocb, from, &jfs_iomap_ops, NULL,
+				IOMAP_DIO_NOSYNC, NULL, 0);
+	else
+		ret = __generic_file_write_iter(iocb, from);
+
+err:
+	current->backing_dev_info = NULL;
+	inode_unlock(inode);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
 static int jfs_release(struct inode *inode, struct file *file)
 {
 	struct jfs_inode_info *ji = JFS_IP(inode);
@@ -158,7 +192,7 @@ const struct file_operations jfs_file_operations = {
 	.open		= jfs_open,
 	.llseek		= generic_file_llseek,
 	.read_iter	= jfs_read_iter,
-	.write_iter	= generic_file_write_iter,
+	.write_iter	= jfs_write_iter,
 	.mmap		= generic_file_mmap,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
-- 
2.34.1

