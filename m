Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63554C0250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiBVTtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiBVTsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4CB8B51
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=63GPcG1ognT6mLTcI8vnieGD7xbbUwse4FtLKzRRc6Y=; b=RVnjaGh9lnYw81VnWTgwDACNqj
        X7YSvjTxTerGJItU+qOmPqLIiXCm1Who+3GuXUwAPfOOh6+UL0T7Fv3JbPTkyf75YlmnbgJbZv5xT
        CeO43f4WI5elWTXCmTkRpp/nn4MqbCae5pA/mwRRUhbjgsFeGzdZ0o8z+cj9FsUBI0EnRNMEFE6VQ
        e+rjws9dcO29LOqx0J6001sH1VrMbBc/GqudFtupu0NKVUBdUo8XmU6zSMAEgRYvTKQTUk0E2q/qe
        Sj02QEZScbWoDvTfbArnKgZG6Pvy6vLn45ySRQruxD3lH6T/YR3deNtr1sE9lNZavOt4jkNCfvGP2
        +pjQKFgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb96-00360F-6Y; Tue, 22 Feb 2022 19:48:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/22] ext4: Use scoped memory APIs in ext4_da_write_begin()
Date:   Tue, 22 Feb 2022 19:48:09 +0000
Message-Id: <20220222194820.737755-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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
---
 fs/ext4/ext4.h   |  1 -
 fs/ext4/inline.c | 16 ++++++++--------
 fs/ext4/inode.c  |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bcd3b9bf8069..d291a0d47993 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3597,7 +3597,6 @@ ext4_journalled_write_inline_data(struct inode *inode,
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
-					   unsigned flags,
 					   struct page **pagep,
 					   void **fsdata);
 extern int ext4_try_add_inline_entry(handle_t *handle,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 7865fe136b66..f9eeb36bc9f6 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -906,7 +906,6 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 int ext4_da_write_inline_data_begin(struct address_space *mapping,
 				    struct inode *inode,
 				    loff_t pos, unsigned len,
-				    unsigned flags,
 				    struct page **pagep,
 				    void **fsdata)
 {
@@ -915,6 +914,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	struct page *page;
 	struct ext4_iloc iloc;
 	int retries = 0;
+	unsigned int flags;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -931,12 +931,6 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	if (ret && ret != -ENOSPC)
 		goto out_journal;
 
-	/*
-	 * We cannot recurse into the filesystem as the transaction
-	 * is already started.
-	 */
-	flags |= AOP_FLAG_NOFS;
-
 	if (ret == -ENOSPC) {
 		ext4_journal_stop(handle);
 		ret = ext4_da_convert_inline_data_to_extent(mapping,
@@ -948,7 +942,13 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		goto out;
 	}
 
-	page = grab_cache_page_write_begin(mapping, 0, flags);
+	/*
+	 * We cannot recurse into the filesystem as the transaction
+	 * is already started.
+	 */
+	flags = memalloc_nofs_save();
+	page = grab_cache_page_write_begin(mapping, 0, 0);
+	memalloc_nofs_restore(flags);
 	if (!page) {
 		ret = -ENOMEM;
 		goto out_journal;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 436efd31cc27..bffcdefb0ffa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2929,8 +2929,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	trace_ext4_da_write_begin(inode, pos, len, flags);
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
-		ret = ext4_da_write_inline_data_begin(mapping, inode,
-						      pos, len, flags,
+		ret = ext4_da_write_inline_data_begin(mapping, inode, pos, len,
 						      pagep, fsdata);
 		if (ret < 0)
 			return ret;
-- 
2.34.1

