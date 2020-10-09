Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87E288AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbgJIObW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388878AbgJIObR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:31:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA12C0613DD;
        Fri,  9 Oct 2020 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nImj1bKEnn8BNhzAOdfSeoUsHCGKAl8C4xu8gKbAVdY=; b=RXSD4Y3y1VdFBy17Ol83ILo5j4
        PTO9WjHf1kj+i3LgA1mNy4EbjzfgjS0N6FQecje43EctVoSoenXTtkxEw+pdNlWwCm8BR6ADWrCIA
        mnFVDJIxU2XLT8heg/WUg+nqj4WmoscRl4jCU97HaGgie7XSB2RUPeAoMPImN/8SdJJjnzOhT4QNS
        xglIypw9zIWbJZ4mgZcnuJZtNl9fnUqLIwebZVq5ZINFMI2qXAUDw31r8pl1UhnILmhEGt/4+kham
        9g1ILW71SDudRyFDHNiDTnj4sun2z0xnV5Wfab1g/k50SJfjbhpHe0FCP3IIQ7UUYwtFbVv1fWRdK
        CNdeSAOA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQtQN-0005wL-DD; Fri, 09 Oct 2020 14:31:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-xfs@vger.kernel.org
Subject: [PATCH v2 15/16] iomap: Inline iomap_iop_set_range_uptodate into its one caller
Date:   Fri,  9 Oct 2020 15:31:03 +0100
Message-Id: <20201009143104.22673-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
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
index 8180061b9e16..e60f572e1590 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -141,8 +141,8 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
-static void
-iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
+static void iomap_set_range_uptodate(struct page *page, unsigned off,
+		unsigned len)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 	struct inode *inode = page->mapping->host;
@@ -150,6 +150,14 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
+	if (PageError(page))
+		return;
+
+	if (!iop) {
+		SetPageUptodate(page);
+		return;
+	}
+
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
 	bitmap_set(iop->uptodate, first, last - first + 1);
 	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
@@ -157,18 +165,6 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
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
 iomap_read_page_end_io(struct bio_vec *bvec, int error)
 {
-- 
2.28.0

