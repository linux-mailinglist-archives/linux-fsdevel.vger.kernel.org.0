Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053652771AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIXM4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgIXM4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:56:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0CC0613CE;
        Thu, 24 Sep 2020 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KcaULLngGKYc43FW42wqAsfRajrBy4rZ/2aGJia67F0=; b=ZVoNKJMb8IEiCO/0cxGWmCo8jt
        Leax5D/eDKScQ7Hv/iUV4+K/im0UjklPC3Me3yfFh7fAEsI768yxYLhk2uriMqQhvS828oy27/S+A
        Y/PR+p31Nb3MZ3awTY3XEvVFkmqybwpYQ3k0GmScz48v+SgoZJazLC665CBbQfTzX1tdVZIeAXIWd
        DhzU09qL0CzUzLejqLwZJAQescnWxRLu0KAS77JmSEMGOCtOmO80StSbF8lMdAYT/e3IpME/Jumqi
        /3iOhJucQqVnFjJ3w5V+0Rm16EsfxgZ4FS7jm1UrvxvVtMNyjusbB7zPHwYIlaVi0RFGWaAqKbXdt
        xGk4o8ig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLQnB-00088T-Lu; Thu, 24 Sep 2020 12:56:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Subject: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Date:   Thu, 24 Sep 2020 13:56:08 +0100
Message-Id: <20200924125608.31231-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For filesystems with block size < page size, we need to set all the
per-block uptodate bits if the page was already uptodate at the time
we create the per-block metadata.  This can happen if the page is
invalidated (eg by a write to drop_caches) but ultimately not removed
from the page cache.

This is a data corruption issue as page writeback skips blocks which
are marked !uptodate.

Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Qian Cai <cai@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b6cca7e34e4..8180061b9e16 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -60,6 +60,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
 			GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
+	if (PageUptodate(page))
+		bitmap_fill(iop->uptodate, nr_blocks);
 	attach_page_private(page, iop);
 	return iop;
 }
-- 
2.28.0

