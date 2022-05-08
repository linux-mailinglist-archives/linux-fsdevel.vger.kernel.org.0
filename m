Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939F651F14A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiEHUfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiEHUfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D52628
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TAxcWC6FMiXuwr7R63PsgyvedCcLMofVrsLaAeQ1AwY=; b=D/rxHmi88FF+ATXFemsELoJjYn
        71H2swh6UyyWnRAvjOYWbm+OaQhTVVMCbLJIS7TfmwVzVjTp8m5/8artT1NIPGdc8vvh5qovcfeTf
        dYFNEOgDt41fKEzAaDUopgWIrVyyOTSBb724bP/wwKvZzlsvbfX+CDuuIJRSc90CW5g6sQ+eooCPF
        tNeUa1ZRz1FyT5FAEbop6wYRH8p0Hhx4y6mALHsArJKOBT+zJm5A81tkZSoGENWo1khxEd98zeN0s
        poUkPFdMk9NiYMfsUmO0CV9G7rlMVyjgEBLi8/qMi5V42OH8W9hPB4p+GhZwvXjhGM5xiTAkl6jLY
        CJIyGmcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ4-002nny-DC; Sun, 08 May 2022 20:31:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/37] coda: Convert coda to read_folio
Date:   Sun,  8 May 2022 21:31:07 +0100
Message-Id: <20220508203131.667959-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
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

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/coda/symlink.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 8907d0508198..8adf81042498 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -20,9 +20,10 @@
 #include "coda_psdev.h"
 #include "coda_linux.h"
 
-static int coda_symlink_filler(struct file *file, struct page *page)
+static int coda_symlink_filler(struct file *file, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct page *page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	int error;
 	struct coda_inode_info *cii;
 	unsigned int len = PAGE_SIZE;
@@ -44,5 +45,5 @@ static int coda_symlink_filler(struct file *file, struct page *page)
 }
 
 const struct address_space_operations coda_symlink_aops = {
-	.readpage	= coda_symlink_filler,
+	.read_folio	= coda_symlink_filler,
 };
-- 
2.34.1

