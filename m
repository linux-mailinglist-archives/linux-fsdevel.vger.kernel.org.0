Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130BF29F55E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJ2TeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgJ2TeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1101BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i8c7CZBKt8Ob5/OYaiIUyfJTleCuj0emLFJGvRTncuU=; b=uWdBNNjAXs1rCJYYTItaVeSM3U
        K1J/DzxuCFj1zw6tNJfm7VjwBaTj3OtYg4GL/Mrb3ufFvBjbzQqtwdjMU3PBuieBIGRo84PkFy2Qc
        f96K75ZsLZsflCQiw8eC+3IpYyiMJa9GZ3DnhjawTbntVRHZ0IuUOcRaJKE670DvTd6/zgkJTT1p5
        L0qTFx3v2A7c0BtDAA7urISjaH8w7iyYAOdDFZUOx5/C6wk1NRu0OG1IQhjXzQhYfW2jbQEa2ERNK
        GTRs8aCcvCdY/PqCekNMqbr6nsoQ3c/tI8WH+Ocsi43H6fHdK0Jy9V9kIdIcvrKb8bRELH8gouo3L
        FyOqlz9w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgY-0007cG-FY; Thu, 29 Oct 2020 19:34:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/19] mm/filemap: Allow PageReadahead to be set on head pages
Date:   Thu, 29 Oct 2020 19:33:57 +0000
Message-Id: <20201029193405.29125-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust the callers to only call PageReadahead on the head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 4 ++--
 mm/filemap.c               | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 00d8efd72496..8b523d25fccf 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -380,8 +380,8 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+PAGEFLAG(Readahead, reclaim, PF_ONLY_HEAD)
+	TESTCLEARFLAG(Readahead, reclaim, PF_ONLY_HEAD)
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index dabc26cf0067..91145e33635d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2892,10 +2892,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	mmap_miss = READ_ONCE(ra->mmap_miss);
 	if (mmap_miss)
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
-	if (PageReadahead(page)) {
+	if (PageReadahead(thp_head(page))) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
-					   page, offset, ra->ra_pages);
+				thp_head(page), offset, ra->ra_pages);
 	}
 	return fpin;
 }
-- 
2.28.0

