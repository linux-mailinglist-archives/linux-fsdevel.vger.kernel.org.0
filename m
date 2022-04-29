Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD54515201
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiD2Rae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379532AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A9A66D7
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UOrF5uwFh36CRfSuCcl6334HdyNVUD9aDYbL7xJahM8=; b=XS+4aaOjo33V2lGkFhGPYj0yzN
        hPPdXBEayeacPBHLU+Z7P/0m1MIFGBNOm+aLTynUhPEUGKzax/rPg/GxOcvxJ5ONvGvwD9tdE1Zfe
        ngNf17A88J10hvLwd+nxAK8WLhkv7Uy25z1rxkv/bGAZaG1OIxr0zZYVLmmUiCTOO+N7kuACqbWaC
        qzmyvq4liGi90A8xPYFpaG8K3nFZpQZ5wB0X1HntPbJo8Sug1AJ6zvQZwA5yl7T6R/sw8sg4I/wmz
        Yx3L9Z5AfnP5uDd9U6zK6G0vP4Ko0whFablkhLox51F5hzNhoMJZgi0hZsbdmA0DDiKmVproFVqKO
        5GEQVVpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNd-00CdcS-1x; Fri, 29 Apr 2022 17:26:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 55/69] hpfs: Convert symlinks to read_folio
Date:   Fri, 29 Apr 2022 18:25:42 +0100
Message-Id: <20220429172556.3011843-56-willy@infradead.org>
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
 fs/hpfs/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index d73f8a67168e..15fc63276caa 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -479,8 +479,9 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int hpfs_symlink_readpage(struct file *file, struct page *page)
+static int hpfs_symlink_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	char *link = page_address(page);
 	struct inode *i = page->mapping->host;
 	struct fnode *fnode;
@@ -508,7 +509,7 @@ static int hpfs_symlink_readpage(struct file *file, struct page *page)
 }
 
 const struct address_space_operations hpfs_symlink_aops = {
-	.readpage	= hpfs_symlink_readpage
+	.read_folio	= hpfs_symlink_read_folio
 };
 
 static int hpfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
-- 
2.34.1

