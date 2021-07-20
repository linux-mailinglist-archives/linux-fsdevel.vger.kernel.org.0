Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345F03CF656
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhGTIMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhGTIF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:05:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A837C061574;
        Tue, 20 Jul 2021 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0dYGDVY2JB7ti9Ncuy52QnlE4rdjiptmasEfVI80if0=; b=r2i6ADHMQDU76EvTeAFOz7Lzfo
        gkEgxPGEXDhQ0c1Br6TdK3Mci2u8L+8jRpSKIwgB9vtMJSGkNvbMx3hFK8L3F1wfkUTrAng1JP2gI
        /RgV8fg2tcPMeMJAdu2vc2xE7IoUGtyLeO98IQmOO3vFc7WHLufH1pi+mrfqUTrSmy0KxEE4yg3rk
        gxmaoTk6sTfn0O6QOBMSixowowbU+84g+emzHweK7VHsog5px79z/J31tvOhJ1AOf3q3qD2LgYCKK
        tH5pKrxAmWbhOibAdwv30iAIpxxEg/GojpRxBZbpVUj9vFn4U2y7pfGFhx2Rs0Xnk1UjKZmgqz4Yu
        U0FB0kRw==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5lM4-007vNH-F1; Tue, 20 Jul 2021 08:44:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, willy@infradead.org
Subject: [PATCH 2/2] iomap: simplify iomap_add_to_ioend
Date:   Tue, 20 Jul 2021 10:43:20 +0200
Message-Id: <20210720084320.184877-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720084320.184877-1-hch@lst.de>
References: <20210720084320.184877-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the outstanding writes are counted in bytes, there is no need
to use the low-level __bio_try_merge_page API, we can switch back to
always using bio_add_page and simply iomap_add_to_ioend again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4eaadbd265fcfa..b5f355f3f8ee51 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1252,7 +1252,6 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 	sector_t sector = iomap_sector(&wpc->iomap, offset);
 	unsigned len = i_blocksize(inode);
 	unsigned poff = offset & (PAGE_SIZE - 1);
-	bool merged, same_page = false;
 
 	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
 		if (wpc->ioend)
@@ -1260,19 +1259,13 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
 	}
 
-	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
-			&same_page);
-	if (iop)
-		atomic_add(len, &iop->write_bytes_pending);
-
-	if (!merged) {
-		if (bio_full(wpc->ioend->io_bio, len)) {
-			wpc->ioend->io_bio =
-				iomap_chain_bio(wpc->ioend->io_bio);
-		}
-		bio_add_page(wpc->ioend->io_bio, page, len, poff);
+	if (bio_add_page(wpc->ioend->io_bio, page, len, poff) != len) {
+		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
+		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
 	}
 
+	if (iop)
+		atomic_add(len, &iop->write_bytes_pending);
 	wpc->ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, page, len);
 }
-- 
2.30.2

