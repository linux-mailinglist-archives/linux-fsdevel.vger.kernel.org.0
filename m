Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13951F153
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiEHUf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiEHUff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808D55A8
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i6g5f+22tHBDTbtx3SYZWrTrLEq/pguWRferaojoIv4=; b=j2p6QOSe554fwC0GtKrTDLew+a
        CkLe2C98s/DLsnFIRRTZlJ0BKwwbZMdFlTUXzWsw0cM8pp4rv9YsLw79o2kHRQrPU5yZMLgD5zDV4
        GMDs0sBzuIvoS2WI0+/caCmkZa3wyERBnitmbriRolZwiCkvXHWuMUrtKr9RIYikfnAaboWK2uEzl
        m3TXwUenhqTfcenrB6t2dQnPR8N6OASizTjvbTzN5PlLoa03G1/Ws1/w3Rp8YS/ZKYal4n9HWuocr
        8fzeCHiVvbsO6qJp+fXsxI/KHPEK9f2ayRiRHgy0h6q5oTRCCxRY1qHOZe7srNe+5nOqaAmRLcCWA
        DBooAcHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ6-002npK-Ao; Sun, 08 May 2022 20:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 27/37] nfs: Convert nfs to read_folio
Date:   Sun,  8 May 2022 21:31:21 +0100
Message-Id: <20220508203131.667959-28-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/file.c          | 4 ++--
 fs/nfs/read.c          | 3 ++-
 include/linux/nfs_fs.h | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f05c4b18b681..4f6d1f90b87f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -337,7 +337,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, page, pos, len)) {
 		once_thru = 1;
-		ret = nfs_readpage(file, page);
+		ret = nfs_read_folio(file, page_folio(page));
 		put_page(page);
 		if (!ret)
 			goto start;
@@ -514,7 +514,7 @@ static void nfs_swap_deactivate(struct file *file)
 }
 
 const struct address_space_operations nfs_file_aops = {
-	.readpage = nfs_readpage,
+	.read_folio = nfs_read_folio,
 	.readahead = nfs_readahead,
 	.dirty_folio = filemap_dirty_folio,
 	.writepage = nfs_writepage,
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 5e7657374bc3..5a9b043662e9 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -333,8 +333,9 @@ readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
  *  -	The error flag is set for this page. This happens only when a
  *	previous async read operation failed.
  */
-int nfs_readpage(struct file *file, struct page *page)
+int nfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct nfs_readdesc desc;
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b48b9259e02c..1bba71757d62 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -594,7 +594,7 @@ static inline bool nfs_have_writebacks(const struct inode *inode)
 /*
  * linux/fs/nfs/read.c
  */
-extern int  nfs_readpage(struct file *, struct page *);
+int  nfs_read_folio(struct file *, struct folio *);
 void nfs_readahead(struct readahead_control *);
 
 /*
-- 
2.34.1

