Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADA84C0247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiBVTsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiBVTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFDBB715C
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bENpvxJwnozlT3mf5B2Oo5BalwiHgcaYfiNA5/S5PGU=; b=ElmHKbvqnoXoBiicsqupBu0pI6
        sBzOaAEBRxT6nsCiVCXMOMt0dnIaNgu8RemsYNSEIzGRi4XPrOt1TmopYxIx20GEtrcUbURSLRW+0
        BnAUko2fuEtWdsjcT8sMCiREp9IHpEh5MURWIqAoFPcWfHPYKgPit5DRt2P3XnQRjVpE6Rolt+bxm
        S6gfRtcnFCKIgxEqrxDMlQ86Rc70MTaFcPUyLVBgIbRBGawwzrWnDy4dsSYPiTAhJluawEaJVegGG
        XAp3Ae4TnJ9S6MENfpdYB6CUzd/afJGGQl/J3kuMvGtoU+maBfetgdesQ+FALwwkH+C9D3Locd7lr
        6qR1aIqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zp-Jv; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/22] namei: Merge page_symlink() and __page_symlink()
Date:   Tue, 22 Feb 2022 19:48:04 +0000
Message-Id: <20220222194820.737755-7-willy@infradead.org>
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

There are no callers of __page_symlink() left, so we can remove that
entry point.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/porting.rst |  2 +-
 fs/namei.c                            | 13 ++-----------
 include/linux/fs.h                    |  2 --
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bf19fd6b86e7..0d847532f767 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -618,7 +618,7 @@ any symlink that might use page_follow_link_light/page_put_link() must
 have inode_nohighmem(inode) called before anything might start playing with
 its pagecache.  No highmem pages should end up in the pagecache of such
 symlinks.  That includes any preseeding that might be done during symlink
-creation.  __page_symlink() will honour the mapping gfp flags, so once
+creation.  page_symlink() will honour the mapping gfp flags, so once
 you've done inode_nohighmem() it's safe to use, but if you allocate and
 insert the page manually, make sure to use the right gfp flags.
 
diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..8335dad105b4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5003,12 +5003,10 @@ int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
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
@@ -5036,13 +5034,6 @@ int __page_symlink(struct inode *inode, const char *symname, int len, int nofs)
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
index 10ba90e22b4b..4db0893750aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3214,8 +3214,6 @@ extern int page_readlink(struct dentry *, char __user *, int);
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

