Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A33288B66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgJIObJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbgJIObI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40CC0613D2;
        Fri,  9 Oct 2020 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9pnCDQD7BT3wSOEmQ/ujAa+Hm2ir7A48RB79T7IxK0Q=; b=OpgwA4h4sqP1jU/IETGKZCdM+Q
        i2z3mUNTVaNMrPcKu/kIEUukM1dt974qFSZx4F1PJP3u9M1SgxVKgcIonjd/aNrK8oJYJJN4oHRk1
        obdU0/M9Ik9JMH/nzkWE8D3yho4lKnaBpftYWxPJpDwLQo52xiQnfV7kpYc8EtYGLGmDorJ9y8V5N
        CJcX+ugzQELTPBZdvOkJejfwb3L1y6UeR3FiWZL/sICMMOlGRRiA2qGYtu0wV9jkbIzwzA2oq/dOd
        H5aqicfp9nwOgncn7C7ET7kxAk5rWlkDprT8RSZwKu9U+B7N0o7spekfqopBUVo/2X+R5nO4vA99R
        nxNxhJxw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQI-0005uX-P8; Fri, 09 Oct 2020 14:31:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 02/16] mm: Inline wait_on_page_read into its one caller
Date:   Fri,  9 Oct 2020 15:30:50 +0100
Message-Id: <20201009143104.22673-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Having this code inline helps the function read more easily.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 95b68ec1f22c..0ef06d515532 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2834,18 +2834,6 @@ EXPORT_SYMBOL(filemap_page_mkwrite);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
-static struct page *wait_on_page_read(struct page *page)
-{
-	if (!IS_ERR(page)) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			put_page(page);
-			page = ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
 static struct page *do_read_cache_page(struct address_space *mapping,
 				pgoff_t index,
 				int (*filler)(void *, struct page *),
@@ -2876,7 +2864,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			err = mapping->a_ops->readpage(data, page);
 		if (err == AOP_UPDATED_PAGE) {
 			unlock_page(page);
-			goto out;
+		} else if (!err) {
+			wait_on_page_locked(page);
+			if (!PageUptodate(page))
+				err = -EIO;
 		}
 
 		if (err < 0) {
@@ -2884,9 +2875,6 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			return ERR_PTR(err);
 		}
 
-		page = wait_on_page_read(page);
-		if (IS_ERR(page))
-			return page;
 		goto out;
 	}
 	if (PageUptodate(page))
-- 
2.28.0

