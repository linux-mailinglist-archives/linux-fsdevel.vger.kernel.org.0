Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91422DD87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGZJLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZJLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:11:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD1C0619D2;
        Sun, 26 Jul 2020 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sEtihcpcEBRDfrflBBXQKHWbhX05b4az17G9xIFJB1o=; b=cZ5x/4zlRzZa6KKK0NHhQWP4Kb
        Ud26d7W4jWmin2U+u9Igf6eEO624I6b31eV5DBTUrieE30uvbSDBLulBapx+0vKB8liBlkO/y+/D6
        +zQWIrvnjuBAbx3/kZ6Nks+XOqxslayz7Zh8KqNxHFIJlgQ6ded0WbBMar4sneR/d2LFW8dMJC3WZ
        H5/0pMV4w75EBknMO8raJZmFnxri9LRlch/2LysVE5u56LPS8JKSvhzoUffo1KofrqwJKswFk5hgB
        ASXD+z4eu1wfSZXLxsNMrNWAu3e4o+IS63c6S3mig/gm5Y7t33URbYr2foXLSfN165dmIKBQl+q3u
        /c6ZduyA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzcgQ-0007y1-BV; Sun, 26 Jul 2020 09:11:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] iomap: Ensure iop->uptodate matches PageUptodate
Date:   Sun, 26 Jul 2020 10:10:52 +0100
Message-Id: <20200726091052.30576-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the filesystem has block size < page size and we end up calling
iomap_page_create() in iomap_page_mkwrite_actor(), the uptodate bits
would be zero, which causes us to skip writeback of blocks which are
!uptodate in iomap_writepage_map().  This can lead to user data loss.

Found using generic/127 with the THP patches.  I don't think this can be
reproduced on mainline using that test (the THP code causes iomap_pages
to be discarded more frequently), but inspection shows it can happen
with an appropriate series of operations.

Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a2b3b5455219..f0c5027bf33f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -53,7 +53,10 @@ iomap_page_create(struct inode *inode, struct page *page)
 	atomic_set(&iop->read_count, 0);
 	atomic_set(&iop->write_count, 0);
 	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	if (PageUptodate(page))
+		bitmap_fill(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+	else
+		bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
 
 	/*
 	 * migrate_page_move_mapping() assumes that pages with private data have
@@ -72,6 +75,8 @@ iomap_page_release(struct page *page)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
+	WARN_ON_ONCE(bitmap_full(iop->uptodate, PAGE_SIZE / SECTOR_SIZE) !=
+			PageUptodate(page));
 	kfree(iop);
 }
 
-- 
2.27.0

