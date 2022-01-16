Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0B48FC97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiAPMS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 07:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiAPMS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:18:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D959C061574;
        Sun, 16 Jan 2022 04:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3MIQy1Z2cREUy+AYirD8/hbvJvQAYl4W5xf1lrR8/fc=; b=Z4YcmDRUqYP1PmRMV4Cq/T/YCL
        44F6kIQbZPnImDlMxhiRXRfXke9wm9hnu+ycUToDuWrmdiSzq6DrycKO9fRyKn23vfwRPie7hKmFT
        t8G5pmM1qEGBc6n4yYjxnyEKwjKDLSHpegALqtoNUVdK5pkCQ44E+ynfeBm2El5JuqmJBLHATpwfv
        HOxCuIHnwdqiqlmHlWZpxi0c8XjlhXMvvaztXsb9FuPOTGBU2HA1ABEV+mQv2vARDRj37RSDE/dLL
        rIwMojoZJ22p76EGYNRn2w9ts+hFFa0LgSsr3i/aXjS4a7g2g7aMP0TLL3ju09B7URdCnvX/aGM2G
        jx0e5u7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n94UM-007FUD-8P; Sun, 16 Jan 2022 12:18:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/12] filemap: Use folio_put_refs() in filemap_free_folio()
Date:   Sun, 16 Jan 2022 12:18:12 +0000
Message-Id: <20220116121822.1727633-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220116121822.1727633-1-willy@infradead.org>
References: <20220116121822.1727633-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This shrinks filemap_free_folio() by 55 bytes in my .config; 24 bytes
from removing the VM_BUG_ON_FOLIO() and 31 bytes from unifying the
small/large folio paths.

We could just use folio_ref_sub() here since the caller should hold a
reference (as the VM_BUG_ON_FOLIO() was asserting), but that's fragile.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2fd9b2f24025..afc8f5ca85ac 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -231,17 +231,15 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 {
 	void (*freepage)(struct page *);
+	int refs = 1;
 
 	freepage = mapping->a_ops->freepage;
 	if (freepage)
 		freepage(&folio->page);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
-		folio_ref_sub(folio, folio_nr_pages(folio));
-		VM_BUG_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
-	} else {
-		folio_put(folio);
-	}
+	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+		refs = folio_nr_pages(folio);
+	folio_put_refs(folio, refs);
 }
 
 /**
-- 
2.34.1

