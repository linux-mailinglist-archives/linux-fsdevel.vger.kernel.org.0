Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFD3D1DBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 07:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhGVFF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 01:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhGVFF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:05:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795ABC0613D3;
        Wed, 21 Jul 2021 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8OS9hJDhEgFPapGc5vq7VW2JySETKhcWW0o+i9nkCw4=; b=N9jyhS+hcGvIRwLliW9nh3IMly
        ScniiaEpPFe0M47CWPB0EBXoZFWxcB5JgYVc+O7Ym6blIAo9TR8Ltn0NTBrV3JAM8W96mNowjebsF
        3Aop4Rb+bqZixVrwqSGlhb6hPKSf8AptmbegpP/RMfTUaIn+4a2BHvkdeknjstp6Hu+jD/o1Ev9eH
        ebCEIV0c9KtW3r4kFc3CrqQOIXB+PAZ9tIdgAFH2YY5Ekh74leTHgmydsPhXATzO5toV0KtaVdcsZ
        SqynBqgFrKLc8dLeXy8c/vALnfJ7FMYOC3q5xc80TOXFwWWG+7/2qVjJAfwpIaO96m4tfbERJfl9s
        wJL65rrA==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6RWI-009vXO-69; Thu, 22 Jul 2021 05:45:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/2] iomap: simplify iomap_add_to_ioend
Date:   Thu, 22 Jul 2021 07:42:56 +0200
Message-Id: <20210722054256.932965-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722054256.932965-1-hch@lst.de>
References: <20210722054256.932965-1-hch@lst.de>
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
index 7898c1c47370e6..d31e0d3b50c683 100644
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

