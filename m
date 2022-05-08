Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05551F1A0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiEHUjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiEHUhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A31262D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CbZ/ZcqZUq4QXQSoqiaNoghdc4weAzXDNw0V8ap+TiM=; b=kjaN8UmSPoKTHIGID7zAXIJfQ1
        jPM7oljh2D5ARRMjh6eQElHIzOlzXPEakxw9xX8Jb/05IPmaG5KxMuOc8IJnA7bv7qkZ/O7UYaIed
        AvVl/Av6UvFFrBOQpl80FKMztcMCPdceoTMoQOk4I9kZAs041N0Bz9DNkDGCF7pusLOsW4R1va/a5
        +xq2xTSFau8TX8zH880ruo3COcBd8RBqtczqWhBfWU55lxLMeKW99UNjpxnJoPtJCoVjqxhei1DCj
        tlK8qxWqpSH5bZ1Dw7oWx8vxxmgEmnlHLBly+2P+HDykE0lYKokykUOFs8gto/GfLFJx5FwGcyXo8
        nm2C5zIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaT-002o6d-4X; Sun, 08 May 2022 20:33:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/5] nfs: Convert to free_folio
Date:   Sun,  8 May 2022 21:32:59 +0100
Message-Id: <20220508203301.669147-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203301.669147-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203301.669147-1-willy@infradead.org>
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

Add a wrapper that converts back from the folio to the page.  This
entire file needs to be converted to use folios, but that's a
task for a different set of patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nfs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c6b263b5faf1..a8ecdd527662 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -55,7 +55,7 @@ static int nfs_closedir(struct inode *, struct file *);
 static int nfs_readdir(struct file *, struct dir_context *);
 static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
 static loff_t nfs_llseek_dir(struct file *, loff_t, int);
-static void nfs_readdir_clear_array(struct page*);
+static void nfs_readdir_free_folio(struct folio *);
 
 const struct file_operations nfs_dir_operations = {
 	.llseek		= nfs_llseek_dir,
@@ -67,7 +67,7 @@ const struct file_operations nfs_dir_operations = {
 };
 
 const struct address_space_operations nfs_dir_aops = {
-	.freepage = nfs_readdir_clear_array,
+	.free_folio = nfs_readdir_free_folio,
 };
 
 #define NFS_INIT_DTSIZE PAGE_SIZE
@@ -228,6 +228,11 @@ static void nfs_readdir_clear_array(struct page *page)
 	kunmap_atomic(array);
 }
 
+static void nfs_readdir_free_folio(struct folio *folio)
+{
+	nfs_readdir_clear_array(&folio->page);
+}
+
 static void nfs_readdir_page_reinit_array(struct page *page, u64 last_cookie,
 					  u64 change_attr)
 {
-- 
2.34.1

