Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6651F13A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiEHUeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiEHUdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7035AE007
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dYZKrf5pdSYug9lsibPHpic0LKqrclyIK/b7UwBqBrU=; b=YeFIXUhIBYoc5Ki2SXcr4/i/gV
        tE0cufZaxqGnqlwHxC3piePatBl7DR3Vz4Tt0ucHWCq5z1qBmc6mea84L9Le9l1yQ99qNuiG5OcbE
        H7fzEcav6Ad2xCl78C5G+i2JpVXFXgrEh3Tg7uAFXn4ngO/XJecsq/mfyUQqgEN4lpzFCbQos2f0D
        ZKAk2Pyj+HlAcu0tacJSWRXMfFzDuqk3i6lAxT8Yy2e9mS8DZNplj5oDM+BEOmrEpwN+8PcMdlwTw
        XnKXMm877HjFnyhxFlUpNFISSB/qbsHCwRFXWgEtUvt4hQtsnDkf1qmQCYDgoXrmXGskaMbbeTx7G
        EL5yN+Pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nYI-FZ; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 08/25] ext4: Use scoped memory APIs in ext4_write_begin()
Date:   Sun,  8 May 2022 21:29:24 +0100
Message-Id: <20220508202941.667024-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
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

Instead of setting AOP_FLAG_NOFS, use memalloc_nofs_save() and
memalloc_nofs_restore() to prevent GFP_FS allocations recursing
into the filesystem with a journal already started.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   |  1 -
 fs/ext4/inline.c | 21 ++++++++++-----------
 fs/ext4/inode.c  |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 90677e30e52d..0c3308bac6c1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3591,7 +3591,6 @@ extern int ext4_readpage_inline(struct inode *inode, struct page *page);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
 					 loff_t pos, unsigned len,
-					 unsigned flags,
 					 struct page **pagep);
 extern int ext4_write_inline_data_end(struct inode *inode,
 				      loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d965ba08f68f..b2ef5ba568bc 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -527,13 +527,13 @@ int ext4_readpage_inline(struct inode *inode, struct page *page)
 }
 
 static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
-					      struct inode *inode,
-					      unsigned flags)
+					      struct inode *inode)
 {
 	int ret, needed_blocks, no_expand;
 	handle_t *handle = NULL;
 	int retries = 0, sem_held = 0;
 	struct page *page = NULL;
+	unsigned int flags;
 	unsigned from, to;
 	struct ext4_iloc iloc;
 
@@ -562,9 +562,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 
 	/* We cannot recurse into the filesystem as the transaction is already
 	 * started */
-	flags |= AOP_FLAG_NOFS;
-
-	page = grab_cache_page_write_begin(mapping, 0, flags);
+	flags = memalloc_nofs_save();
+	page = grab_cache_page_write_begin(mapping, 0, 0);
+	memalloc_nofs_restore(flags);
 	if (!page) {
 		ret = -ENOMEM;
 		goto out;
@@ -649,11 +649,11 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 int ext4_try_to_write_inline_data(struct address_space *mapping,
 				  struct inode *inode,
 				  loff_t pos, unsigned len,
-				  unsigned flags,
 				  struct page **pagep)
 {
 	int ret;
 	handle_t *handle;
+	unsigned int flags;
 	struct page *page;
 	struct ext4_iloc iloc;
 
@@ -691,9 +691,9 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	if (ret)
 		goto out;
 
-	flags |= AOP_FLAG_NOFS;
-
-	page = grab_cache_page_write_begin(mapping, 0, flags);
+	flags = memalloc_nofs_save();
+	page = grab_cache_page_write_begin(mapping, 0, 0);
+	memalloc_nofs_restore(flags);
 	if (!page) {
 		ret = -ENOMEM;
 		goto out;
@@ -727,8 +727,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	brelse(iloc.bh);
 	return ret;
 convert:
-	return ext4_convert_inline_data_to_extent(mapping,
-						  inode, flags);
+	return ext4_convert_inline_data_to_extent(mapping, inode);
 }
 
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 21ebcb3c59ba..01a55647c959 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1156,7 +1156,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_try_to_write_inline_data(mapping, inode, pos, len,
-						    flags, pagep);
+						    pagep);
 		if (ret < 0)
 			return ret;
 		if (ret == 1)
-- 
2.34.1

