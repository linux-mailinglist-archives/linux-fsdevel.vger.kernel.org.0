Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E42774FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgIXPPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgIXPPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:15:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD8C0613CE;
        Thu, 24 Sep 2020 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2cGEpRqYEmNw9L3ozG0ZmmNSgfWeZpBwU1suaBmTKCE=; b=WgacE4Mk0f3oruk8/vxRoCqx4+
        i5gSnYMUcuPJ02beGVnNs1RDO/ZgFpGe++PQgoiVF+VCYqbZQsNF6JZahgb2sOfvtGwcU2VZnbqUw
        l7OlOzyj0Y+e2m85YaSYjavto04hu4lh6JMb1sSU5xKL9fodWG4XMkE885N7VLP4Nz+LfqjXPwZJD
        U8dPd4WCboRlK125jO5/ZDwG3VuHFiBcFutGb/7TjKsl7Qnllgsh9SjHMQOGndY0WKDh7jZ+YtSHP
        L3GNgNkKhGhMPVmfdJElB3J4vvtXUt8hv9/B+8ywXZ+OGTU7aZZBUGdjid8Cu2KeiPOO8lVhbSpM3
        37RBObXA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLSyA-0000Y5-W3; Thu, 24 Sep 2020 15:15:39 +0000
Date:   Thu, 24 Sep 2020 16:15:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924151538.GW32101@casper.infradead.org>
References: <20200924125608.31231-1-willy@infradead.org>
 <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:08:03PM +0200, Sedat Dilek wrote:
> On Thu, Sep 24, 2020 at 2:58 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > For filesystems with block size < page size, we need to set all the
> > per-block uptodate bits if the page was already uptodate at the time
> > we create the per-block metadata.  This can happen if the page is
> > invalidated (eg by a write to drop_caches) but ultimately not removed
> > from the page cache.
> >
> > This is a data corruption issue as page writeback skips blocks which
> > are marked !uptodate.
> >
> > Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
> 
> This commit is also in Linux v5.9-rc6+ but does not cleanly apply.
> Against which Git tree is this patch?
> When Linux v5.9-rc6+ is affected, do you have a backport?

This applies to v5.8.  I'll happily backport this for any other kernel
versions.

From 51f85a97ccdd7071e5f95b2ac4e41c12bf4d4176 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Thu, 24 Sep 2020 08:44:56 -0400
Subject: [PATCH] iomap: Set all uptodate bits for an Uptodate page

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
 fs/iomap/buffered-io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..810f7dae11d9 100644
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
-- 
2.28.0

