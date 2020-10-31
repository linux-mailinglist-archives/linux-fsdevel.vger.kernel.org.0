Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB22A14B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJaJYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgJaJYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:24:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E815C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yKVVOMTwCnImkW5ZZzkJxy/4XZLiDS6CW2ha1meBT74=; b=pNCl8HMFl/ZfMB7x4SkgTn9wPM
        b/1K3v6VX0FxvwftNVE/87c5gYnkPUpHOhpFncnPfNTIfv9eU41QpNupj0BDEzVCiCGDOBo0j8NkK
        znV3xIYAkyPJu/yhML7/MvCYSdXeAkKufL2jD9QtsH07PI65W9g/ms9FfAs+7oej8hKgoH/cyZ4qc
        HtzB4XMge9GoGhuq88m3xe6WW/t407qJiNkVIZG1VrBrPOa1DY3026JVeUJX1kNYnuyzy2PF4a+Hr
        HHP9sANIklu0jN4aG8cCk8Xnub9wXI7qxvI2a5/4FLV+prll2MyzGabQKOnMO6GVPidE77Al2gLLB
        BSEFTyvg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn7H-0008Ma-Fx; Sat, 31 Oct 2020 09:24:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/13] mm: open code readahead in filemap_new_page
Date:   Sat, 31 Oct 2020 10:00:01 +0100
Message-Id: <20201031090004.452516-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Calling filemap_make_page_uptodate right after filemap_readpage in
filemap_new_page is rather counterintuitive.  The call is in fact
only needed to issue async readahead, and is guaranteed to return
just after that because the page is uptodate.  Just open code the
readahead related parts of filemap_make_page_uptodate instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5f4937715689e7..000f75cd359d1c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2309,9 +2309,14 @@ static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
 	error = filemap_readpage(iocb, *page);
 	if (error)
 		goto put_page;
-	error = filemap_make_page_uptodate(iocb, iter, *page, index, true);
-	if (error)
-		goto put_page;
+	if (PageReadahead(*page)) {
+		error = -EAGAIN;
+		if (iocb->ki_flags & IOCB_NOIO)
+			goto put_page;
+		page_cache_async_readahead(mapping, &iocb->ki_filp->f_ra,
+				iocb->ki_filp, *page, index,
+				(iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT);
+	}
 	return 0;
 put_page:
 	put_page(*page);
-- 
2.28.0

