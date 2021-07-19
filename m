Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997943CEF23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359298AbhGSVbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382183AbhGSSCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:02:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C14C0613E1;
        Mon, 19 Jul 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DGdOungzrgHQI6fcBN2msBQ7P+kjo/OBfBcHoJ3oKjw=; b=nlXB9J7KU5ap1IncoGefJMYFQA
        yjRDnp0ngc4KU0len+Sv0hWLmLhtgFh92rgG+ltrweswLHUj8WcBb8GOD0MzqCq2WftuzN3js6qOk
        vvZj9E0IynUm7QSUWmyY7UCasxljQzt8Ec6x9kcDFKgQqq/RvFBnLIoQ8Lp+9eFhu1fVBsMDp3xCP
        Gtp9wyziE091sQPr8TK7QVNGjzkogYCt86E2Prs76gtgWUv31JHq2qlSbdSRvHj5FkLtmkGVD6Csy
        r1zZB+5zGwAF0rpPpBo4wupmYMbLVEI8V4qLgHvQ3GtPpY+HEhoPxgUKRhlxiDPat5H5WWr16i7YF
        l43k8rYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YBg-007LT3-DD; Mon, 19 Jul 2021 18:40:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH v15 01/17] block: Add bio_add_folio()
Date:   Mon, 19 Jul 2021 19:39:45 +0100
Message-Id: <20210719184001.1750630-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a thin wrapper around bio_add_page().  The main advantage here
is the documentation that the submitter can expect to see folios in the
completion handler, and that stupidly large folios are not supported.
It's not currently possible to allocate stupidly large folios, but if
it ever becomes possible, this function will fail gracefully instead of
doing I/O to the wrong bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c         | 21 +++++++++++++++++++++
 include/linux/bio.h |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 1fab762e079b..c64e35548fb2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -933,6 +933,27 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+/**
+ * bio_add_folio - Attempt to add part of a folio to a bio.
+ * @bio: Bio to add to.
+ * @folio: Folio to add.
+ * @len: How many bytes from the folio to add.
+ * @off: First byte in this folio to add.
+ *
+ * Always uses the head page of the folio in the bio.  If a submitter only
+ * uses bio_add_folio(), it can count on never seeing tail pages in the
+ * completion routine.  BIOs do not support folios that are 4GiB or larger.
+ *
+ * Return: The number of bytes from this folio added to the bio.
+ */
+size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		size_t off)
+{
+	if (len > UINT_MAX || off > UINT_MAX)
+		return 0;
+	return bio_add_page(bio, &folio->page, len, off);
+}
+
 void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2203b686e1f0..ade93e2de6a1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -462,7 +462,8 @@ extern void bio_uninit(struct bio *);
 extern void bio_reset(struct bio *);
 void bio_chain(struct bio *, struct bio *);
 
-extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
+int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
+size_t bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.30.2

