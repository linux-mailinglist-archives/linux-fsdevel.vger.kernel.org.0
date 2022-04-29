Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C7515217
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379698AbiD2RbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379582AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD4A5E87
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7i+rQsprs4PBXqaChHELvwK4DblnGhyte9L47UaC7aI=; b=b86J6gzV8jBL+LZuTBUfCQ+PCX
        MnzX9au4CTbYolXUJhOef5+dP9k3aZmErNtcVXfLOBKIpxnGwi4ty4SjrbzUHNNugj2KUs+kfqPCp
        RkqM35nOxGtw350eXVQQpfFoIDckQlQPq/9RVsF4erTsJUesiPTOak7kfebEX0sD1VKGVccsLdoBE
        cxIGybB1t+WOk3bUz9h+BJx6KncySlHviV1hhpALRHVM2cGR2+rFDXF9YgcO6d/A0A+r2eoUH1WjO
        R0pi1j0RpcRcTn+S/yEkN1B8mz1zKZ/7nY2OXsa9g7ihdoWskmka6hZKdt47qbJSrh5/7aRnb2KQa
        7K1CNb/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNb-00Cdaj-9a; Fri, 29 Apr 2022 17:26:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 42/69] befs: Convert befs to read_folio
Date:   Fri, 29 Apr 2022 18:25:29 +0100
Message-Id: <20220429172556.3011843-43-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/befs/linuxvfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 25350dd22cda..be383fa46b12 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -48,7 +48,7 @@ static struct inode *befs_iget(struct super_block *, unsigned long);
 static struct inode *befs_alloc_inode(struct super_block *sb);
 static void befs_free_inode(struct inode *inode);
 static void befs_destroy_inodecache(void);
-static int befs_symlink_readpage(struct file *, struct page *);
+static int befs_symlink_read_folio(struct file *, struct folio *);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
@@ -92,7 +92,7 @@ static const struct address_space_operations befs_aops = {
 };
 
 static const struct address_space_operations befs_symlink_aops = {
-	.readpage	= befs_symlink_readpage,
+	.read_folio	= befs_symlink_read_folio,
 };
 
 static const struct export_operations befs_export_operations = {
@@ -468,8 +468,9 @@ befs_destroy_inodecache(void)
  * The data stream become link name. Unless the LONG_SYMLINK
  * flag is set.
  */
-static int befs_symlink_readpage(struct file *unused, struct page *page)
+static int befs_symlink_read_folio(struct file *unused, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct befs_inode_info *befs_ino = BEFS_I(inode);
-- 
2.34.1

