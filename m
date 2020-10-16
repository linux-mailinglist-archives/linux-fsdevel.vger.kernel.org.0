Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE129092E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410558AbgJPQEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409186AbgJPQEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B93EC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SLkkZEVg2bXTvSR+l8GXD0xD/a/pq4p09uWc4mwKVwc=; b=BHe6AO+vza2Np4NUh6KPo5ot0F
        kLgV4JNwWZMZ+ayua4JSYUQcgRs1bFGO+nAvuH7i0uWcO3FeMCh1eXZtvV+0IvjkQpmHT9d2R+lL7
        I9A06AwCfemdpNbxQI44lLNClgazMJ9zlYq1XBIux6VAEkZoKc8H4xcnCyReGZT+9S9pw0A36BwM8
        gx6kaFKaUEwe6j/IT+RMGrcBuA44V2OO0yeMetwU3d0LmFDHbe0bPwLQ+BSx90wONKODVwhh66nC9
        ZwJy1V03eb0/j/q9TABYkLHU/QPN/RoWF2mi1J7SLY9Uv5DYxscV8X40fIbw4R8YIx+psul4kY6+l
        SGRnnaaA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDl-0004sG-ET; Fri, 16 Oct 2020 16:04:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH v3 02/18] swap: Call aops->readahead if appropriate
Date:   Fri, 16 Oct 2020 17:04:27 +0100
Message-Id: <20201016160443.18685-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystems have a synchronous readpage and an asynchronous
readahead.  Call the readahead operation if we're trying to do swap
readahead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_io.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index e485a6e8a6cd..faf5ccb42946 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -367,6 +367,24 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	return ret;
 }
 
+static int mapping_readpage(struct file *file, struct address_space *mapping,
+		struct page *page, bool synchronous)
+{
+	struct readahead_control ractl = {
+		.file = file,
+		.mapping = mapping,
+		._index = page->index,
+		._nr_pages = 1,
+	};
+
+	if (!synchronous && mapping->a_ops->readahead) {
+		mapping->a_ops->readahead(&ractl);
+		return 0;
+	}
+
+	return mapping->a_ops->readpage(file, page);
+}
+
 int swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -395,9 +413,9 @@ int swap_readpage(struct page *page, bool synchronous)
 
 	if (data_race(sis->flags & SWP_FS)) {
 		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
 
-		ret = mapping->a_ops->readpage(swap_file, page);
+		ret = mapping_readpage(swap_file, swap_file->f_mapping,
+				page, synchronous);
 		if (!ret)
 			count_vm_event(PSWPIN);
 		goto out;
-- 
2.28.0

