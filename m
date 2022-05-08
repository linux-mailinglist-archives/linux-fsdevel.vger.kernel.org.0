Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C89351F163
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiEHUgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiEHUfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C17138
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Zlrw23/9zsoNnmB/ZFg3rEXTUeeweSd78Bi4kp8O0ig=; b=r1Gama3jfn7d1szm9JUGZ15lbp
        TlGq/9op24UQc4ugyIgbxgjT5JxdEkweiiZvTJso7bDQndOupmjNZvpi/tHW/hUNJ/a5c8ZMjC8Xx
        4r+1B9MJZu+8zhhdW+GC6qHEJ05qHwukebbSWJNSdXPVWoaYUqzZgVy/MvIAmkE0Yf65DmdTzuFGD
        6+JmtA1HfqvTsmR4cghAJVhOf3r1DnPDzcXLwCeyOcWzf8r8HFqHx9ocHVzYNClLeZGpRS3aEMhsc
        nKf479LviHvQ5bSy675csDT3xRRaSyAupW6lgKzhdNoytUeVtvU7NWufa+1fZ0kzzGLX5ylzvJBYj
        bf9EY+tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ5-002nos-MS; Sun, 08 May 2022 20:31:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/37] hostfs: Convert hostfs to read_folio
Date:   Sun,  8 May 2022 21:31:16 +0100
Message-Id: <20220508203131.667959-23-willy@infradead.org>
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
 fs/hostfs/hostfs_kern.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index e658d8edde35..cc1bc6f93a01 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -434,8 +434,9 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int hostfs_readpage(struct file *file, struct page *page)
+static int hostfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	char *buffer;
 	loff_t start = page_offset(page);
 	int bytes_read, ret = 0;
@@ -504,7 +505,7 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 
 static const struct address_space_operations hostfs_aops = {
 	.writepage 	= hostfs_writepage,
-	.readpage	= hostfs_readpage,
+	.read_folio	= hostfs_read_folio,
 	.dirty_folio	= filemap_dirty_folio,
 	.write_begin	= hostfs_write_begin,
 	.write_end	= hostfs_write_end,
-- 
2.34.1

