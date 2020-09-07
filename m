Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1F2605B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIGUhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgIGUhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:37:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CDC061575;
        Mon,  7 Sep 2020 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/Q+KDxFmJ8kENzdxoq4aNK25y+6WSS4+srMvBAkO44Q=; b=aLqR1UN3EAnDm7gBHsto+PmiVr
        r7/dI55AVUsoGp5ICxLG1791PtouAD688tZ6ATGYVCKVxZ0Fts2OYphZfbZw3e9Fal9H8x8498PhG
        zNkq2hd4OK1W8NRgf8UsepPhQuzxhoPPttPpH031APgLXChNe9mV1a6Y1YP38E2OoyBv6+5WJjKza
        upay1DaTkbk1HU/PKY8ZYR9zl8za6HDcZFJwVHKiDUJCFbMYsKuGDlZsFke3GU2yrBE5cGprOCynf
        /XvRZUkug1jANTkthTZNVgMA7tUCmPOWUNZwo5OKP0ZGLSz2cVbJ1rRuKp65PF2QyF0p2J+eDyj8k
        bRKQCldg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFNsy-00013E-PS; Mon, 07 Sep 2020 20:37:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] iomap: Clear page error before beginning a write
Date:   Mon,  7 Sep 2020 21:37:06 +0100
Message-Id: <20200907203707.3964-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200907203707.3964-1-willy@infradead.org>
References: <20200907203707.3964-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we find a page in write_begin which is !Uptodate, we need
to clear any error on the page before starting to read data
into it.  This matches how filemap_fault(), do_read_cache_page()
and generic_file_buffered_read() handle PageError on !Uptodate pages.
When calling iomap_set_range_uptodate() in __iomap_write_begin(), blocks
were not being marked as uptodate.

This was found with generic/127 and a specially modified kernel which
would fail (some) readahead I/Os.  The test read some bytes in a prior
page which caused readahead to extend into page 0x34.  There was
a subsequent write to page 0x34, followed by a read to page 0x34.
Because the blocks were still marked as !Uptodate, the read caused all
blocks to be re-read, overwriting the write.  With this change, and the
next one, the bytes which were written are marked as being Uptodate, so
even though the page is still marked as !Uptodate, the blocks containing
the written data are not re-read from storage.

Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..c95454784df4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -578,6 +578,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 
 	if (PageUptodate(page))
 		return 0;
+	ClearPageError(page);
 
 	do {
 		iomap_adjust_read_range(inode, iop, &block_start,
-- 
2.28.0

