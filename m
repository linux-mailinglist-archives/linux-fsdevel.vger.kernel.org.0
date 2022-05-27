Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3F5364F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiE0PvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352746AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB70134E22
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gf5p2e+qdxhVcf8PVIs5vyx8mN40hpMkTkem7ExcQzs=; b=lhiGc57FtMXrLSprJ/6hdRf3UW
        /QO1rjDpI/C4ozMk+kJ5STb81l/0bkIhTZQcA61j2aKYjcRwzk/5YJiTsco8qhqfespCd9Ir8UuC3
        yfkvBGaoPMqbRD66WRMs0rBh12+Ed9qtiLYnW48tZQJaGV8Zd0Ia7TqA64I0hkR9ys4B9YuBvOYLf
        Wne+gRuJY61q/a1JjdEq/9h4JmjPrFe8pW53fgwzFSEYnyvBZGbBo0p9kyLLiT2cRhdV+8vr3uUcf
        cnjF3BEbq1XdY5Vv96wUcsW9LTnSmEWeekBg8qZdHoOllnZ1FNj8CKua5Jjf/G8H7Ml6E82icQiEc
        d+H4PLjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CXL-Mx; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 17/24] orangefs: Remove test for folio error
Date:   Fri, 27 May 2022 16:50:29 +0100
Message-Id: <20220527155036.524743-18-willy@infradead.org>
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

The page cache clears the error bit before calling ->read_folio(),
so this condition could never have been true.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 5ce27dde3c79..7a8c0c6e698d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -307,7 +307,7 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
 			folio_size(folio), inode->i_size, NULL, NULL, file);
-	/* this will only zero remaining unread portions of the page data */
+	/* this will only zero remaining unread portions of the folio data */
 	iov_iter_zero(~0U, &iter);
 	/* takes care of potential aliasing */
 	flush_dcache_folio(folio);
@@ -315,8 +315,6 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 		folio_set_error(folio);
 	} else {
 		folio_mark_uptodate(folio);
-		if (folio_test_error(folio))
-			folio_clear_error(folio);
 		ret = 0;
 	}
 	/* unlock the folio after the ->read_folio() routine completes */
-- 
2.34.1

