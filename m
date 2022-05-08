Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5451F145
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiEHUeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiEHUd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FDABE3B
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ukNbbRbZxH56Po3ysYnQL8YLpC4stX4G0l+kdkGV3Og=; b=PlW4yQAKfcAwHnL8/K8YTpCF1Z
        Afmh/ZCI7bpXkXR3eaP1GM0sMexvYuB6QcKT3zqjYSlp5w2Jrfk9HjDIyHopbWaTcRzQALJIRz7UK
        U2qjKUX/x/pJUDp3i9Ndi6mQs4n4qlqzE4LcWL2xJ7incXCt65DamNLJ9lsMzXUbsCZKKyCCs+pv2
        0gI9oHMA27ts1CY3MM4Zb2xJEgKGV3kNJtdQ7Ij05qHyzRwOhPT8dTwX1gP0gC/M9B6pRLlz71tw+
        nNdalG0elk6L+LeXVPtNTe5VdAIwJpjgreSjnhIMljHyl3DnEGX9hKsLg9aN5nG0ACdE+XRFeqRNL
        pHZuNgJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXR-002nXv-VZ; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 02/25] namei: Merge page_symlink() and __page_symlink()
Date:   Sun,  8 May 2022 21:29:18 +0100
Message-Id: <20220508202941.667024-3-willy@infradead.org>
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

There are no callers of __page_symlink() left, so we can remove that
entry point.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst |  2 +-
 fs/namei.c                            | 13 ++-----------
 include/linux/fs.h                    |  2 --
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 7c1583dbeb59..2e0e4f0e0c6f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -624,7 +624,7 @@ any symlink that might use page_follow_link_light/page_put_link() must
 have inode_nohighmem(inode) called before anything might start playing with
 its pagecache.  No highmem pages should end up in the pagecache of such
 symlinks.  That includes any preseeding that might be done during symlink
-creation.  __page_symlink() will honour the mapping gfp flags, so once
+creation.  page_symlink() will honour the mapping gfp flags, so once
 you've done inode_nohighmem() it's safe to use, but if you allocate and
 insert the page manually, make sure to use the right gfp flags.
 
diff --git a/fs/namei.c b/fs/namei.c
index 509657fdf4f5..6153581073b1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5001,12 +5001,10 @@ int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 }
 EXPORT_SYMBOL(page_readlink);
 
-/*
- * The nofs argument instructs pagecache_write_begin to pass AOP_FLAG_NOFS
- */
-int __page_symlink(struct inode *inode, const char *symname, int len, int nofs)
+int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
+	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
 	struct page *page;
 	void *fsdata;
 	int err;
@@ -5034,13 +5032,6 @@ int __page_symlink(struct inode *inode, const char *symname, int len, int nofs)
 fail:
 	return err;
 }
-EXPORT_SYMBOL(__page_symlink);
-
-int page_symlink(struct inode *inode, const char *symname, int len)
-{
-	return __page_symlink(inode, symname, len,
-			!mapping_gfp_constraint(inode->i_mapping, __GFP_FS));
-}
 EXPORT_SYMBOL(page_symlink);
 
 const struct inode_operations page_symlink_inode_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..e108aff23a28 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3109,8 +3109,6 @@ extern int page_readlink(struct dentry *, char __user *, int);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
 extern void page_put_link(void *);
-extern int __page_symlink(struct inode *inode, const char *symname, int len,
-		int nofs);
 extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
-- 
2.34.1

