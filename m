Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02B63C9828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhGOFT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhGOFTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:19:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD61C061760;
        Wed, 14 Jul 2021 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E4o291CiEkirXhlNU9qhgU1unG2pTpkpRkPYhVT13Jw=; b=hMx7mTzBw8NvkBPVXiIoTms9Np
        Qcbuveu5Ui3/uJEgMl4C+IRrRd67cr8V6ditJNZYTAOqUujZvcxpXVXdVAdxePjvHr26aIw4zpRii
        IYN5LwhWPvr//u/j3SxRVl3QKX08bhslxEspnQay0FmtMHwzth3Nk/LQ8j21yrY5jooR0/mmE0UoG
        lFQvxptbMLAI/wlzy6LZ/zrzVueYVz862OpRj0e7Iz1CRfBIoJKr+ciR4SYWE4oRcDb7Jk9Pj4jgP
        zSAKaQhC3SVtizLdl9vWsDwRyvrHR3f0kYlvI/mrxrzhGE6RBK9BTtsVPIM8ToPFD6faCzIVGpBKA
        KQ34HDkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3thq-0030QK-2N; Thu, 15 Jul 2021 05:14:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 121/138] mm/filemap: Remove PageHWPoison check from next_uptodate_page()
Date:   Thu, 15 Jul 2021 04:36:47 +0100
Message-Id: <20210715033704.692967-122-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pages are individually marked as suffering from hardware poisoning.
Checking that the head page is not hardware poisoned doesn't make
sense; we might be after a subpage.  We check each page individually
before we use it, so this was an optimisation gone wrong.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8510f67dc749..717b0d262306 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3127,8 +3127,6 @@ static struct page *next_uptodate_page(struct page *page,
 			goto skip;
 		if (!PageUptodate(page) || PageReadahead(page))
 			goto skip;
-		if (PageHWPoison(page))
-			goto skip;
 		if (!trylock_page(page))
 			goto skip;
 		if (page->mapping != mapping)
-- 
2.30.2

