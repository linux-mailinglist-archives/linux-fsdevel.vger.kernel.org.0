Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C657F26E92F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 00:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIQW44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIQW44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:56:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11797C061756;
        Thu, 17 Sep 2020 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Pb8DaRm0QxpL8x2OJ+k9bsS89NV+Kq701kym4FVnax0=; b=cjb1xn5xSWMjcZ37QkDkRUiHLm
        IgxcowZfKiFZaBblhSTbE6dYcUkEXiwCQ7Fujtr2vULfZhnuihmTwCdFxSezTh5oVCNrmfjju/Rzc
        8jT198xH9jvZAu82RqMtbVBKfRwnBqzo7gYXSHx6O7uXmMOR6W66s/sf0vwNfAs3QPujCJwaHnull
        R3tP4gwbEqAEKgvt8XKt2uomgeaoJZdVojiNNo40G4HwXlUTStWrxIxt2ln6IPes2sStchsB2c8Cj
        Ww3wBMnh2fPGgkBRr3bAjlz0zfrQ2JS2waeA4fCazsBrtNSaZ2SDLyeZ2ka1dUQomrY6qh03nc66K
        Khv+YF7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ2pi-0006u3-7y; Thu, 17 Sep 2020 22:56:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 15/13] iomap: Inline iomap_read_finish into its one caller
Date:   Thu, 17 Sep 2020 23:56:46 +0100
Message-Id: <20200917225647.26481-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917225647.26481-1-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
 <20200917225647.26481-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_read_page_end_io() is the only caller of iomap_read_finish()
and it makes future patches easier to have it inline.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2a6492b3c4db..13b56d656337 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -167,13 +167,6 @@ void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
 
-static void
-iomap_read_finish(struct iomap_page *iop, struct page *page)
-{
-	if (!iop || atomic_dec_and_test(&iop->read_count))
-		unlock_page(page);
-}
-
 static void
 iomap_read_page_end_io(struct bio_vec *bvec, int error)
 {
@@ -187,7 +180,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
 	}
 
-	iomap_read_finish(iop, page);
+	if (!iop || atomic_dec_and_test(&iop->read_count))
+		unlock_page(page);
 }
 
 static void
-- 
2.28.0

