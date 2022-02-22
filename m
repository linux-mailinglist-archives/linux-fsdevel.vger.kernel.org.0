Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28F4C025A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiBVTtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322EABABA4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UOfujoOr91K5T4ha03m+36vZPBztPqbdRzbWrrfPkpA=; b=ZIiiY155lWkPcUev3dKhFLxFTy
        0RryweG0Perrrjj5n7ROcSCm8GKhTHcK5DmPMjT7Y6jWufCZG/JeHjXrJOXoUXlbu/BZPpcAHUh9b
        NB9/iq87C943LfNHYj8p+HWImWVl/VPYdLpQt+GFuo9ikR2je4tJPjNWyhfWFluhEb1vNqz+u1OAu
        iWMuGhqL15pHxyCoxkSDmiLEfE6bbCKXgv4XKGCJba7yYzGc9X7kr+8B3SqLHP+tbZkYjS53taB2v
        LrNVK+Ca1dBAGjHGriKT9HovvgGJIKtEMeOm5Q25w1WPJGnxijVzVzJRbIuFPmXMOBw7hrSeqY64G
        GG1wFJVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb97-003613-EW; Tue, 22 Feb 2022 19:48:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 21/22] fs: Remove aop flags parameter from nobh_write_begin()
Date:   Tue, 22 Feb 2022 19:48:19 +0000
Message-Id: <20220222194820.737755-22-willy@infradead.org>
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

There are no more aop flags left, so remove the parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 3 +--
 fs/ext2/inode.c             | 2 +-
 fs/jfs/inode.c              | 3 +--
 include/linux/buffer_head.h | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2b3518d57bcc..cd4fd4bed561 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2568,8 +2568,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
  * On exit the page is fully uptodate in the areas outside (from,to)
  * The filesystem needs to handle block truncation upon failure.
  */
-int nobh_write_begin(struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
+int nobh_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata,
 			get_block_t *get_block)
 {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 97192932ea56..bfa69c52ce2c 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -917,7 +917,7 @@ ext2_nobh_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = nobh_write_begin(mapping, pos, len, flags, pagep, fsdata,
+	ret = nobh_write_begin(mapping, pos, len, pagep, fsdata,
 			       ext2_get_block);
 	if (ret < 0)
 		ext2_write_failed(mapping, pos + len);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 27be2e8ba237..7e433ecfc9e9 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -318,8 +318,7 @@ static int jfs_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
-	ret = nobh_write_begin(mapping, pos, len, flags, pagep, fsdata,
-				jfs_get_block);
+	ret = nobh_write_begin(mapping, pos, len, pagep, fsdata, jfs_get_block);
 	if (unlikely(ret))
 		jfs_write_failed(mapping, pos + len);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 127b60fad77e..6e5a64005fef 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -258,7 +258,7 @@ static inline vm_fault_t block_page_mkwrite_return(int err)
 }
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
-int nobh_write_begin(struct address_space *, loff_t, unsigned, unsigned,
+int nobh_write_begin(struct address_space *, loff_t, unsigned len,
 				struct page **, void **, get_block_t*);
 int nobh_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
-- 
2.34.1

