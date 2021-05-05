Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6537463D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhEERNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhEEQ7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:59:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF5C06138D;
        Wed,  5 May 2021 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UdKLAv9tD4IGgGm2E+DtgLcmHg6ZIlBUn72zqqp8p8Y=; b=mN9tRfYc42+ctPCPH7j2z1N2AR
        fMnuaC/JLZcM2VKRlu8R1lHO2k+TBdqiEFsqOiw1gZ9CgG5JiQq68+Clws+E7ynITwcJGEbQj4zlB
        1ruDX2D9xy/f2RYE0TSS6lOwb2U8unS7XvvAleK/nRzfO7xE3DX6BEtkoF/UyAYCU6W0kgvIzwCOs
        HqVJcA1prRwu04Qgpx63mhJpUYhGlRNAwjqjMtFdIefLIBLvDPFkINP25mKABQwqIaQ9P3OeZFt5K
        P2cVv/rus1WmtgLR4VHZYIVXyNbyOexQg6hhk0dkJXW1w6i0WHKH1oRXWwmtzZxiuiUjfL5IJglqZ
        wFefjiyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKQr-000ar5-R5; Wed, 05 May 2021 16:32:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 71/96] block: Add bio_add_folio
Date:   Wed,  5 May 2021 16:06:03 +0100
Message-Id: <20210505150628.111735-72-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 221dc56ba22f..f84defe8d84a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -940,6 +940,27 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+/**
+ * bio_add_folio - Attempt to add part of a folio to a bio.
+ * @bio: Bio to add to.
+ * @folio: Folio to add.
+ * @len: How many bytes from the folio to add.
+ * @off: First byte in this folio to add.
+ *
+ * Always uses the head page of the folio in the bio.  If a submitter
+ * only uses bio_add_folio(), it can count on never seeing tail pages
+ * in the completion routine.  BIOs do not support folios larger than 2GiB.
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
index f1a99f0a240c..f41f20ebc2c6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -468,7 +468,8 @@ extern void bio_uninit(struct bio *);
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

