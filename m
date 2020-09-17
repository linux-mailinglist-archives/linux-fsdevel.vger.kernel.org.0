Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0AD26E92E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgIQW44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQW44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:56:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB43DC06174A;
        Thu, 17 Sep 2020 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ki4J0j4LsEH8EEUxeCSAtkIWXbKcXDf2us7RL9u7s+M=; b=G/yV1kSkUpJTYMU4fIb6pkGl2D
        vZdWB17kmM4DqW3GzvIfPgejLn12XqZf9RCr6n+zuq0CQiB8lRPhpKV6x6gLi4EWLGAky5W2n7izy
        XD2lIQwlzEp+bd457i2gNOa37kvdTiACS6dM78wPrPmlC5skFMCH0ABNoLA0vs12Rn6EKU9z/HCcI
        xE/ixh0EWjsL5rrM0ljtHi2fLGquXrimgwAkOCUw8DspW+2MBa/lXmSZxi+oSB1Vfz0EbArx6XJxU
        GVhWKWeWW6EBTAOc43dS77TAsiMd8klNwVMKXtzDRsaD62aAqSsfSK1TxpJ50xtSQtW6n81kRJ7md
        LmE6XgcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ2ph-0006tw-UJ; Thu, 17 Sep 2020 22:56:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 14/13] iomap: Inline iomap_iop_set_range_uptodate into its one caller
Date:   Thu, 17 Sep 2020 23:56:45 +0100
Message-Id: <20200917225647.26481-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917151050.5363-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_set_range_uptodate() is the only caller of
iomap_iop_set_range_uptodate() and it makes future patches easier to
have it inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 897ab9a26a74..2a6492b3c4db 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -135,8 +135,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
-static void
-iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+static
+void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 	struct inode *inode = page->mapping->host;
@@ -146,6 +146,14 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned long flags;
 	unsigned int i;
 
+	if (PageError(page))
+		return;
+
+	if (!iop) {
+		SetPageUptodate(page);
+		return;
+	}
+
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
 	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
 		if (i >= first && i <= last)
@@ -159,18 +167,6 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void
-iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
-{
-	if (PageError(page))
-		return;
-
-	if (page_has_private(page))
-		iomap_iop_set_range_uptodate(page, off, len);
-	else
-		SetPageUptodate(page);
-}
-
 static void
 iomap_read_finish(struct iomap_page *iop, struct page *page)
 {
-- 
2.28.0

