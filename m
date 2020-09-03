Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB825C3BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgICO5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgICOJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB9C0619C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kHj2RN10MLCA+ByH4nC1EoFYnrC6ZhmtON9tQxUs7Hs=; b=b1QyzfCXJDcyCQX3PxWVutkVmd
        KfitQjqw8gekKGAcE00XNQcepq8fnlYmHpfIO2s7jbd9nxYbO6YTPAeWg/cs1tCChA+cjjir+Mpd0
        xSeMtrb7L/xgdfkVyIlZgkHenXGys8apqJhScHGcPYy5PXZdb/HQ3rHVVk2sLRpmbvRpErznteCBA
        zTqhTpw1um/RIrgndohkDEeghF+gSYluc9zDErBzHWL6zapy1OIbXs5u9wSZCiyEC4QmxKfhISElV
        ELQpd3tdZM9rjM/czXDnz17pVBhfqonJ8O/e2R7yHJS1CygKUbrwny0J7ZoF7JRqqk6NQfYGDrnMG
        S4GcGDZw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv1-0003hv-Av; Thu, 03 Sep 2020 14:08:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH 1/9] Fix khugepaged's request size in collapse_file
Date:   Thu,  3 Sep 2020 15:08:36 +0100
Message-Id: <20200903140844.14194-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

collapse_file() in khugepaged passes PAGE_SIZE as the number of pages
to be read to page_cache_sync_readahead().  The intent was probably to
read a single page.  Fix it to use the number of pages to the end of
the window instead.

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Yang Shi <shy828301@gmail.com>
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e749e568e1ea..cfa0dba5fd3b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1709,7 +1709,7 @@ static void collapse_file(struct mm_struct *mm,
 				xas_unlock_irq(&xas);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
-							  PAGE_SIZE);
+							  end - index);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);
-- 
2.28.0

