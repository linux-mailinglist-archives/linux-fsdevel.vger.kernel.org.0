Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40A14DCB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgA3OUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 09:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA3OUE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:20:04 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D5652051A;
        Thu, 30 Jan 2020 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580394003;
        bh=OuzcS9U3Z7Q2MSalfgVge9XFhH403dKCk6Lo1zpZlBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuIP/zKTYdnBOjV9tPf1iwhfezP365etl1v7+FGGLduMcQdce7EioGyMoOxYy05fT
         1IFC41yoCUs8zOMAHOl0FxY6dofB2fcyUdHbWvQepqG3qSPcXf+xYfYWDSmwzpLzPx
         +g3lfca5o76Fncnrj7zJcOMRphYggLpaSHu4nUvo=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: fix test for blockdev inode in wb error handling tracepoints
Date:   Thu, 30 Jan 2020 09:20:02 -0500
Message-Id: <20200130142002.894960-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130124825.476361-1-jlayton@kernel.org>
References: <20200130124825.476361-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al pointed out that the test for whether a mapping refers to a blockdev
inode in these tracepoints is garbage, as the superblock is always
non-NULL.

Add a new mapping_to_dev helper function that determines this the
correct way, and change the tracepoints to use it. Also, fix up the
indentation in this file.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h             | 16 ++++++
 include/trace/events/filemap.h | 99 +++++++++++++++-------------------
 2 files changed, 60 insertions(+), 55 deletions(-)

Al, sorry.

I had based the original on an older tree. This one should merge more
cleanly, and also just adds a single, non-conditionally compiled helper.

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 40be2ccb87f3..264ac7d602a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2616,6 +2616,22 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 	return false;
 }
 #endif
+
+/*
+ * Return the device associated with this mapping.
+ *
+ * For normal inodes, return the sb of the backing filesystem, for blockdev
+ * inodes, return the block device number associated with the inode.
+ */
+static inline dev_t mapping_to_dev(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+
+	if (sb_is_blkdev_sb(inode->i_sb))
+		return inode->i_rdev;
+	return inode->i_sb->s_dev;
+}
+
 extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 796053e162d2..bddcc7d0bdfd 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -30,10 +30,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
 		__entry->pfn = page_to_pfn(page);
 		__entry->i_ino = page->mapping->host->i_ino;
 		__entry->index = page->index;
-		if (page->mapping->host->i_sb)
-			__entry->s_dev = page->mapping->host->i_sb->s_dev;
-		else
-			__entry->s_dev = page->mapping->host->i_rdev;
+		__entry->s_dev = mapping_to_dev(page->mapping);
 	),
 
 	TP_printk("dev %d:%d ino %lx page=%p pfn=%lu ofs=%lu",
@@ -55,60 +52,52 @@ DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_add_to_page_cache,
 	);
 
 TRACE_EVENT(filemap_set_wb_err,
-		TP_PROTO(struct address_space *mapping, errseq_t eseq),
-
-		TP_ARGS(mapping, eseq),
-
-		TP_STRUCT__entry(
-			__field(unsigned long, i_ino)
-			__field(dev_t, s_dev)
-			__field(errseq_t, errseq)
-		),
-
-		TP_fast_assign(
-			__entry->i_ino = mapping->host->i_ino;
-			__entry->errseq = eseq;
-			if (mapping->host->i_sb)
-				__entry->s_dev = mapping->host->i_sb->s_dev;
-			else
-				__entry->s_dev = mapping->host->i_rdev;
-		),
-
-		TP_printk("dev=%d:%d ino=0x%lx errseq=0x%x",
-			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
-			__entry->i_ino, __entry->errseq)
+	TP_PROTO(struct address_space *mapping, errseq_t eseq),
+
+	TP_ARGS(mapping, eseq),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(errseq_t, errseq)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		__entry->errseq = eseq;
+		__entry->s_dev = mapping_to_dev(mapping);
+	),
+
+	TP_printk("dev=%d:%d ino=0x%lx errseq=0x%x",
+		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+		__entry->i_ino, __entry->errseq)
 );
 
 TRACE_EVENT(file_check_and_advance_wb_err,
-		TP_PROTO(struct file *file, errseq_t old),
-
-		TP_ARGS(file, old),
-
-		TP_STRUCT__entry(
-			__field(struct file *, file)
-			__field(unsigned long, i_ino)
-			__field(dev_t, s_dev)
-			__field(errseq_t, old)
-			__field(errseq_t, new)
-		),
-
-		TP_fast_assign(
-			__entry->file = file;
-			__entry->i_ino = file->f_mapping->host->i_ino;
-			if (file->f_mapping->host->i_sb)
-				__entry->s_dev =
-					file->f_mapping->host->i_sb->s_dev;
-			else
-				__entry->s_dev =
-					file->f_mapping->host->i_rdev;
-			__entry->old = old;
-			__entry->new = file->f_wb_err;
-		),
-
-		TP_printk("file=%p dev=%d:%d ino=0x%lx old=0x%x new=0x%x",
-			__entry->file, MAJOR(__entry->s_dev),
-			MINOR(__entry->s_dev), __entry->i_ino, __entry->old,
-			__entry->new)
+	TP_PROTO(struct file *file, errseq_t old),
+
+	TP_ARGS(file, old),
+
+	TP_STRUCT__entry(
+		__field(struct file *, file)
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(errseq_t, old)
+		__field(errseq_t, new)
+	),
+
+	TP_fast_assign(
+		__entry->file = file;
+		__entry->i_ino = file->f_mapping->host->i_ino;
+		__entry->s_dev = mapping_to_dev(file->f_mapping);
+		__entry->old = old;
+		__entry->new = file->f_wb_err;
+	),
+
+	TP_printk("file=%p dev=%d:%d ino=0x%lx old=0x%x new=0x%x",
+		__entry->file, MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino, __entry->old,
+		__entry->new)
 );
 #endif /* _TRACE_FILEMAP_H */
 
-- 
2.24.1

