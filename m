Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F33DF5BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbhHCTcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbhHCTct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:32:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61261C061757;
        Tue,  3 Aug 2021 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+wBJFC8oMvKDVA3sJoFvFUIFVvQ+URjZI/q5tk1JJLU=; b=l3a9KlTS0+mkoAyzS3qkRtlX7d
        t2wvMINLr9m3x3G5LI8ketWMXHNcampRKnv2syjHWugf5ddf3+vJLTRd7y7Dcviydb1eNDYsBeNk4
        IgppHsTe2eOFRBqLMKplz5+OX+zlSdkors3bmFMQZLONAQvOrncvqEThMnFaKN2dQQkmrDtBX+o4I
        ZiGZ7pHVu/Q6Cjjh9CqKkZoR2f9EXD+/aw1SATyo1/OmwxGdarQjS215YTZOLUkab5pIbZnyE6JlY
        qZlUVw0kYXGXVoNsxv8y2WBEffwP1lz/hLTd7OiRNRDWhfTbSvWLTWqVdmSuP5UiLJusnJnJp5Qsz
        2wHBMSog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB08w-0051sP-Tt; Tue, 03 Aug 2021 19:32:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] iomap: Add another assertion to inline data handling
Date:   Tue,  3 Aug 2021 20:31:34 +0100
Message-Id: <20210803193134.1198733-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803193134.1198733-1-willy@infradead.org>
References: <20210803193134.1198733-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check that the file tail does not cross a page boundary.  Requested by
Andreas.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8ee0211bea86..586d9d078ce1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -215,6 +215,8 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
 	if (PageUptodate(page))
 		return PAGE_SIZE - poff;
 
+	if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
+		return -EIO;
 	if (WARN_ON_ONCE(size > PAGE_SIZE -
 			 offset_in_page(iomap->inline_data)))
 		return -EIO;
-- 
2.30.2

