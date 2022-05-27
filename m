Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E955364F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353663AbiE0PvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E5134E38
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KV0SikI/SB3SrY5NZJBM8ckFOFL47m5xu8gYB9A0uRI=; b=Ryhf9qgRsU18ms7Z3Y2KaPP/G0
        EzjTVlWi2W75I0bkOTZNUBNa3pbGQct+dYX8WETHXDYk7Oc5LeprpWHA1yA6daibjFLKR2wVhyXpF
        /KsZNtHVqm2R6VbQ/Q1N4xSy5J1PXra7/X6RSB0ycQ1jh3mR80zYGLqQVV7XkbOzjmG2dyi1Xa5qZ
        UryhUbsXuXaUjzp90azxszyW0PJOvt5TiTLygclohU3cPBRaamav6Qe/5+2+NZah+mg8wMkJA5OpP
        9M0CPXaK7BiCI+Pg3FA9wgy7KcG1gJOo8K6pO/Wu8WN17RIGEKT74/+S9RPZSWVnmKhpHkdhll90O
        kUHDAnVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEc-002CXp-6h; Fri, 27 May 2022 15:50:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 22/24] squashfs: Return the actual error from squashfs_read_folio()
Date:   Fri, 27 May 2022 16:50:34 +0100
Message-Id: <20220527155036.524743-23-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

Since we actually know what error happened, we can report it instead
of having the generic code return -EIO for pages that were unlocked
without being marked uptodate.  Also remove a test of PageError since
we have the return value at this point.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index a8e495d8eb86..7f0904b20329 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -454,7 +454,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	int expected = index == file_end ?
 			(i_size_read(inode) & (msblk->block_size - 1)) :
 			 msblk->block_size;
-	int res;
+	int res = 0;
 	void *pageaddr;
 
 	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
@@ -467,14 +467,15 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	if (index < file_end || squashfs_i(inode)->fragment_block ==
 					SQUASHFS_INVALID_BLK) {
 		u64 block = 0;
-		int bsize = read_blocklist(inode, index, &block);
-		if (bsize < 0)
+
+		res = read_blocklist(inode, index, &block);
+		if (res < 0)
 			goto error_out;
 
-		if (bsize == 0)
+		if (res == 0)
 			res = squashfs_readpage_sparse(page, expected);
 		else
-			res = squashfs_readpage_block(page, block, bsize, expected);
+			res = squashfs_readpage_block(page, block, res, expected);
 	} else
 		res = squashfs_readpage_fragment(page, expected);
 
@@ -488,11 +489,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 	memset(pageaddr, 0, PAGE_SIZE);
 	kunmap_atomic(pageaddr);
 	flush_dcache_page(page);
-	if (!PageError(page))
+	if (res == 0)
 		SetPageUptodate(page);
 	unlock_page(page);
 
-	return 0;
+	return res;
 }
 
 
-- 
2.34.1

