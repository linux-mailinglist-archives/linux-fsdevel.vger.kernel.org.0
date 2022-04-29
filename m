Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF55151D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379527AbiD2R30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376937AbiD2R3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B259859C
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=trDP4gjjFpmqZvJ+JNrSlXV+L8vVqC1TdJmWMDKM3+I=; b=ruv00QPsH7xIftAVygZ6Uv0yqb
        2+o2EFUemLx20PxRuSrmsEHUywVJBm0ZX/utB2XGf1NR7pfBDO9E6zBDeTfxl3MCkYlx8+RsTmJPv
        y3lmjtYT7rmxhQfPnbJgoDgESZ9F6JBLNNnzZrisjl7cfLBYxjD9mnphJ4njCry7HFhfgGx0jHgWR
        rlDjepK1nTi/g3H455g0mjmafwaGNY6arr5S5MRSVPjEGJtFGabeWjxdzRDR/gOHH5vUXeSi7OakB
        NGC950mKkNphQc+rISuQ1aYcrmr6HHB5Gh8AKRHQ/LnlRboqYP7Bv7PfKUG6WhmFXsB0kQ3UxuVQv
        KVxGZwtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNW-00CdXS-QH; Fri, 29 Apr 2022 17:26:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 08/69] ext4: Use scoped memory APIs in ext4_da_write_begin()
Date:   Fri, 29 Apr 2022 18:24:55 +0100
Message-Id: <20220429172556.3011843-9-willy@infradead.org>
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

Instead of setting AOP_FLAG_NOFS, use memalloc_nofs_save() and
memalloc_nofs_restore() to prevent GFP_FS allocations recursing
into the filesystem with a journal already started.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   |  1 -
 fs/ext4/inline.c | 16 ++++++++--------
 fs/ext4/inode.c  |  3 +--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a743b1e3b89e..90677e30e52d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3604,7 +3604,6 @@ ext4_journalled_write_inline_data(struct inode *inode,
 extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
 					   struct inode *inode,
 					   loff_t pos, unsigned len,
-					   unsigned flags,
 					   struct page **pagep,
 					   void **fsdata);
 extern int ext4_try_add_inline_entry(handle_t *handle,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 93694ceb5a34..d965ba08f68f 100644
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
index 646ece9b3455..21ebcb3c59ba 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2954,8 +2954,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
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

