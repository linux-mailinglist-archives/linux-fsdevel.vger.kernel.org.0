Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62670515202
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379607AbiD2Raf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379605AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A6A66CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+XuT2UNZ8tyOhatktPLdCXVQdkBow5gH+ALSLhjgNso=; b=WkS+nmcjDuYlLRrI9nLQ1v3VCW
        WOGm6lH9KvEasVGKMz1PYuPmHZtZFsFryCTKmfVl1SA1vmsnzxYxNyXPqUISMo6cJm94LDUb9zUhV
        MlNjgnXImvMap57HhjWrxBQz2NSFvgyUeU5SiVqNpanqnSb0FO1vGu1xZPwZN2f5b1v/tRegOGQbL
        kRwjih/opZTJW51D3NrZudTguvyxQlDDMrZWzXPsBIYPZMjHnZxZfq5mnl0/FjCGYicWVCqFK8Ck4
        QIAtEE3vAM8M0vppIkcPpNYN/ddrI3gGcXD0zv9EwYTmBuZOSs1Ffg4cUWrcP0N7bWsTpROp0Cxu8
        fFlMDZAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNc-00Cdc2-Fj; Fri, 29 Apr 2022 17:26:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 51/69] f2fs: Convert f2fs to read_folio
Date:   Fri, 29 Apr 2022 18:25:38 +0100
Message-Id: <20220429172556.3011843-52-willy@infradead.org>
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
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b3cf49136b9f..f894267f0722 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2372,8 +2372,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	return ret;
 }
 
-static int f2fs_read_data_page(struct file *file, struct page *page)
+static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret = -EAGAIN;
 
@@ -3935,7 +3936,7 @@ static void f2fs_swap_deactivate(struct file *file)
 #endif
 
 const struct address_space_operations f2fs_dblock_aops = {
-	.readpage	= f2fs_read_data_page,
+	.read_folio	= f2fs_read_data_folio,
 	.readahead	= f2fs_readahead,
 	.writepage	= f2fs_write_data_page,
 	.writepages	= f2fs_write_data_pages,
-- 
2.34.1

