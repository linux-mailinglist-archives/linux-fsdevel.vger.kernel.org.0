Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0825151DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379625AbiD2R3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359830AbiD2R3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F13A972F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dGvwuPP/1TGONgcNifsHiVFL7k2OtG7nG8HG9AaJDWo=; b=hxYGGnKsentpljxlHrI897bYGY
        MoSyIjj1pIc0hcpLBYjV7MIVqyTdvRVgu2O1+SNo178dQFhJOil2pIo3sDNVk4mNGHG7HdArm4RDh
        JM1u6I8jzjrDlNy3x18Afgw2lPEzK1eEPTtcItBtCD5S9GkUdUXRVtdco5iVO4WHZaAirhkHuDH2s
        Sm6RSUxHMazV3RHdZe1SdzcI0XVXsuKsOIhAZ7cFbl09d8HtGhno2fWGZHBQNWQxk/BL0JwYwReAP
        c5t4Kpmv6vGhndQIJSGzP1kdNVoNZVtEern3Uh16OQCUr+bDOeJlRWONWwO9OlsGQ6HhjmyHXxJgQ
        6e1T4+jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNY-00CdYb-H0; Fri, 29 Apr 2022 17:26:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 19/69] ntfs3: Call ntfs_write_begin() and ntfs_write_end() directly
Date:   Fri, 29 Apr 2022 18:25:06 +0100
Message-Id: <20220429172556.3011843-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is only one kind of write_begin/write_end aops, so we don't need to
look up which aop it is, just make ntfs_write_begin() and ntfs_write_end()
available to this file and call them directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/file.c    |  5 ++---
 fs/ntfs3/inode.c   | 12 +++++-------
 fs/ntfs3/ntfs_fs.h |  5 +++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 787b53b984ee..c2e7e561958a 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -157,15 +157,14 @@ static int ntfs_extend_initialized_size(struct file *file,
 		if (pos + len > new_valid)
 			len = new_valid - pos;
 
-		err = pagecache_write_begin(file, mapping, pos, len, 0, &page,
-					    &fsdata);
+		err = ntfs_write_begin(file, mapping, pos, len, &page, &fsdata);
 		if (err)
 			goto out;
 
 		zero_user_segment(page, zerofrom, PAGE_SIZE);
 
 		/* This function in any case puts page. */
-		err = pagecache_write_end(file, mapping, pos, len, len, page,
+		err = ntfs_write_end(file, mapping, pos, len, len, page,
 					  fsdata);
 		if (err < 0)
 			goto out;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1364174cc6c9..bfd71f384e21 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -861,9 +861,8 @@ static int ntfs_get_block_write_begin(struct inode *inode, sector_t vbn,
 				  bh_result, create, GET_BLOCK_WRITE_BEGIN);
 }
 
-static int ntfs_write_begin(struct file *file, struct address_space *mapping,
-			    loff_t pos, u32 len, struct page **pagep,
-			    void **fsdata)
+int ntfs_write_begin(struct file *file, struct address_space *mapping,
+		     loff_t pos, u32 len, struct page **pagep, void **fsdata)
 {
 	int err;
 	struct inode *inode = mapping->host;
@@ -904,10 +903,9 @@ static int ntfs_write_begin(struct file *file, struct address_space *mapping,
 /*
  * ntfs_write_end - Address_space_operations::write_end.
  */
-static int ntfs_write_end(struct file *file, struct address_space *mapping,
-			  loff_t pos, u32 len, u32 copied, struct page *page,
-			  void *fsdata)
-
+int ntfs_write_end(struct file *file, struct address_space *mapping,
+		   loff_t pos, u32 len, u32 copied, struct page *page,
+		   void *fsdata)
 {
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index fb825059d488..8de129a6419b 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -689,6 +689,11 @@ int ntfs_set_size(struct inode *inode, u64 new_size);
 int reset_log_file(struct inode *inode);
 int ntfs_get_block(struct inode *inode, sector_t vbn,
 		   struct buffer_head *bh_result, int create);
+int ntfs_write_begin(struct file *file, struct address_space *mapping,
+		     loff_t pos, u32 len, struct page **pagep, void **fsdata);
+int ntfs_write_end(struct file *file, struct address_space *mapping,
+		   loff_t pos, u32 len, u32 copied, struct page *page,
+		   void *fsdata);
 int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
-- 
2.34.1

