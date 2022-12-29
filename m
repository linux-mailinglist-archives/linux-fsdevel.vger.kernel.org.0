Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05239658EC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiL2QLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2QKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:10:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62139FF0;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wAGRF3f2s+7CXmKUNt5mcDbE20Oprr4M4XP/Y6UM90M=; b=MMpycC1KT21omSKtBmc7e4cD91
        Iur3yD3HgzJ5iMdxiVKkR1ZdnMKaHYh0D1Nuka8SBPXLYXNDFOPUPjutKy047FuX/hr9iOVGjIu9G
        vu3jWyTLYTkn/q4qayrFVqWDQ2qLCxTbqGz5nuJK5RFkoxrMb3jAWruQSKfi5SiDLwNsh91m401s5
        +s+QGTNiigo0NptVFmx9P5DRo4sVO5VktSXZkS2NhcU0aJuEjy0pM6MAIkyfURfefHDrd7Z2txVZo
        W9YfXAgZI90nQqdDcVsuZpNNtkWPWnZ6Ntxlpx6YlHstNPYDMflBh8RUxWsqi/L9Tx/1r9azMHKHQ
        JUeQZujQ==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUN-00HKNb-OQ; Thu, 29 Dec 2022 16:10:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: [PATCH 4/6] jbd2,ocfs2: move jbd2_journal_submit_inode_data_buffers to ocfs2
Date:   Thu, 29 Dec 2022 06:10:29 -1000
Message-Id: <20221229161031.391878-5-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229161031.391878-1-hch@lst.de>
References: <20221229161031.391878-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

jbd2_journal_submit_inode_data_buffers is only used by ocfs2, so move
it there to prepare for removing generic_writepages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jbd2/commit.c     | 25 -------------------------
 fs/jbd2/journal.c    |  1 -
 fs/ocfs2/journal.c   | 16 +++++++++++++++-
 include/linux/jbd2.h |  2 --
 4 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 4810438b7856aa..aeee6b8a6da218 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -181,31 +181,6 @@ static int journal_wait_on_commit_record(journal_t *journal,
 	return ret;
 }
 
-/*
- * write the filemap data using writepage() address_space_operations.
- * We don't do block allocation here even for delalloc. We don't
- * use writepages() because with delayed allocation we may be doing
- * block allocation in writepages().
- */
-int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
-{
-	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
-	struct writeback_control wbc = {
-		.sync_mode =  WB_SYNC_ALL,
-		.nr_to_write = mapping->nrpages * 2,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
-	};
-
-	/*
-	 * submit the inode data buffers. We use writepage
-	 * instead of writepages. Because writepages can do
-	 * block allocation with delalloc. We need to write
-	 * only allocated blocks here.
-	 */
-	return generic_writepages(mapping, &wbc);
-}
-
 /* Send all the data buffers related to an inode */
 int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2696f43e7239f8..d331f6ece20a28 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -89,7 +89,6 @@ EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
 EXPORT_SYMBOL(jbd2_journal_force_commit);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_write);
 EXPORT_SYMBOL(jbd2_journal_inode_ranged_wait);
-EXPORT_SYMBOL(jbd2_journal_submit_inode_data_buffers);
 EXPORT_SYMBOL(jbd2_journal_finish_inode_data_buffers);
 EXPORT_SYMBOL(jbd2_journal_init_jbd_inode);
 EXPORT_SYMBOL(jbd2_journal_release_jbd_inode);
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 3fb98b4569a28b..59f612684c5178 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -15,6 +15,7 @@
 #include <linux/time.h>
 #include <linux/random.h>
 #include <linux/delay.h>
+#include <linux/writeback.h>
 
 #include <cluster/masklog.h>
 
@@ -841,6 +842,19 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
 	return status;
 }
 
+static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
+{
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	struct writeback_control wbc = {
+		.sync_mode =  WB_SYNC_ALL,
+		.nr_to_write = mapping->nrpages * 2,
+		.range_start = jinode->i_dirty_start,
+		.range_end = jinode->i_dirty_end,
+	};
+
+	return generic_writepages(mapping, &wbc);
+}
+
 int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
 {
 	int status = -1;
@@ -910,7 +924,7 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
 
 	journal->j_journal = j_journal;
 	journal->j_journal->j_submit_inode_data_buffers =
-		jbd2_journal_submit_inode_data_buffers;
+		ocfs2_journal_submit_inode_data_buffers;
 	journal->j_journal->j_finish_inode_data_buffers =
 		jbd2_journal_finish_inode_data_buffers;
 	journal->j_inode = inode;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 2170e0cc279d5c..5962072a4b19e6 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1570,8 +1570,6 @@ extern int	   jbd2_journal_inode_ranged_write(handle_t *handle,
 extern int	   jbd2_journal_inode_ranged_wait(handle_t *handle,
 			struct jbd2_inode *inode, loff_t start_byte,
 			loff_t length);
-extern int	   jbd2_journal_submit_inode_data_buffers(
-			struct jbd2_inode *jinode);
 extern int	   jbd2_journal_finish_inode_data_buffers(
 			struct jbd2_inode *jinode);
 extern int	   jbd2_journal_begin_ordered_truncate(journal_t *journal,
-- 
2.35.1

