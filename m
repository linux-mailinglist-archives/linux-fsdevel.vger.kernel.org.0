Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CD0290939
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410580AbgJPQE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410570AbgJPQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B9C0613DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qnANyeE8BGUfs9EI0mAgvyYgGmWNNC+tzF64JAGclAM=; b=csJYYLIOVEwkliWcozQ7ogs4sh
        QSuac3y4vHb9JfYTBZAhW7/NBRvNtRrIY8Emvd7BBAfCIzPkhlmKFPqPMTVyo5g5qLVvhUIgxZiec
        D5WZBiSDHiml2zCO6YmlZ8CkegmEQKw53mkR2Yfmk6x0M2ivvIXql5O5CeUB8OFrq+OFa5UAeklIW
        34ys1wfwJ++GzNVkHMSmBh5LkvNZrhgtE5N6cp5D5IDfNf+EPxxBdY+cuWzUxbAgOCuav4u4oRqLZ
        NAEuf/Pui96KlNHIrYE51mNLygl92xYSXZh019zNmgflaOuei7W2UHTfup3ga3AJssqgjUdgyLzsF
        kMdBjuPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDq-0004uD-RY; Fri, 16 Oct 2020 16:04:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v3 16/18] ubifs: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:41 +0100
Message-Id: <20201016160443.18685-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ubifs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index b77d1637bbbc..82633509c45e 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -772,7 +772,6 @@ static int ubifs_do_bulk_read(struct ubifs_info *c, struct bu_info *bu,
 	if (err)
 		goto out_warn;
 
-	unlock_page(page1);
 	ret = 1;
 
 	isize = i_size_read(inode);
@@ -892,11 +891,16 @@ static int ubifs_bulk_read(struct page *page)
 
 static int ubifs_readpage(struct file *file, struct page *page)
 {
-	if (ubifs_bulk_read(page))
-		return 0;
-	do_readpage(page);
-	unlock_page(page);
-	return 0;
+	int err;
+
+	err = ubifs_bulk_read(page);
+	if (err == 0)
+		err = do_readpage(page);
+	if (err < 0) {
+		unlock_page(page);
+		return err;
+	}
+	return AOP_UPDATED_PAGE;
 }
 
 static int do_writepage(struct page *page, int len)
-- 
2.28.0

