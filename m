Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31B5290932
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410567AbgJPQEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410463AbgJPQEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4CEC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wff0t85oZfmMq4nKnDr8r5OGugvLiUKKANRhHeeeqKg=; b=f2rbbINq9tY88lmCCq22Af5TDd
        cZ1nNN2c4BNtegmbq99WKwx3DoUMGcgXfJB+SF/e3h0QNdFJv/cbocPC/PBYOk5gHA9z5Nk9icUJ3
        H5r8iJuUzEgWoyfdTQg0vC9+cS3Drw4YI5cBOXFkQt/SII5efLywEZmhEeYxCws31Ib11rBaWxyYr
        GKrnjpRTZ3gf+OtG2l5RoLjhxGtgP+Dd0SOxiGjihhV1kjkux6p3nXPcgR4ulOAGnm6Zzv8vrn0a6
        91oiCUcIEpY7GcWk+IHxR063VfHvUMHVmI9bf1xUHZPogeCqyZv6HuWB0DqTl6tY7d7hWx1dE0XEZ
        me65MjqA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDm-0004se-BW; Fri, 16 Oct 2020 16:04:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v3 06/18] afs: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:31 +0100
Message-Id: <20201016160443.18685-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 371d1488cc54..4aa2ad3bea6a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -367,7 +367,8 @@ int afs_page_filler(void *data, struct page *page)
 			BUG_ON(PageFsCache(page));
 		}
 #endif
-		unlock_page(page);
+		_leave(" = AOP_UPDATED_PAGE");
+		return AOP_UPDATED_PAGE;
 	}
 
 	_leave(" = 0");
-- 
2.28.0

