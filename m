Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD4515203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379605AbiD2Rah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379613AbiD2R3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76B8A6E06
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rfqqXMeB9rJaPeF1zuhJSPvJieW4idxHLaMUnr+URVs=; b=sFfWVN5iJYI5mQdbFqxagd0EeD
        iNCezQP+ZK7eo3uysp6v6aWgazDcZ6wwWuUZX//WcnkAVvVoNYfyXG6NCo9kfQGvGzUOTEWyp4IhN
        I4TX78h9+cWSRV3sRHTChyTilddduABV3MTya37fK0YMBXNsF1N89P0DXaGryP+xj6e5jxUGuskQp
        bjSp/+yH3X9A2QXuPRsc9TAr2wseV4qN/z+wB0+osqjkA9vUfxVN4Hfw19wpEsmgz2PBmHOPO112a
        XowCEO4/ufO6FZPBeOU9g6TAkbwmcbxrP9meb/DdgavMt6Q9HbFBteBNsdrBLMXbj1cz9MAkqAKKd
        kw2+TL7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNd-00Cdck-K1; Fri, 29 Apr 2022 17:26:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 58/69] jfs: Convert metadata pages to read_folio
Date:   Fri, 29 Apr 2022 18:25:45 +0100
Message-Id: <20220429172556.3011843-59-willy@infradead.org>
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
 fs/jfs/jfs_metapage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index c4220ccdedef..2fc78405b3f2 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -467,8 +467,9 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	return -EIO;
 }
 
-static int metapage_readpage(struct file *fp, struct page *page)
+static int metapage_read_folio(struct file *fp, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page->mapping->host;
 	struct bio *bio = NULL;
 	int block_offset;
@@ -563,7 +564,7 @@ static void metapage_invalidate_folio(struct folio *folio, size_t offset,
 }
 
 const struct address_space_operations jfs_metapage_aops = {
-	.readpage	= metapage_readpage,
+	.read_folio	= metapage_read_folio,
 	.writepage	= metapage_writepage,
 	.releasepage	= metapage_releasepage,
 	.invalidate_folio = metapage_invalidate_folio,
-- 
2.34.1

