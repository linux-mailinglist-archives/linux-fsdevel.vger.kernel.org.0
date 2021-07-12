Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDC3C42B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhGLENt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLENt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:13:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03789C0613DD;
        Sun, 11 Jul 2021 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9yhwgjtp0/wX0Hn1pGrvOzLxkSolV7oLUpxeTzzP2kI=; b=UW30sXKj7aHH30b6jbziSvy3P2
        vOcl6YTGy1a3AbP98rA40xIXpkkWqFjuiJUSrtM6oPHOtYsjmMiWh2w20LsgQ/Gc4Tt5hd38CKeNg
        RlokuaNpngG7gjUw3YFo+2p7tYOvel7mL9DpaIa8nqYKVZsrvt5zxJTjWTk9FnZuWS88K/e6YH/ni
        ht/hYAWU2UuYarhxCEc1cwCdWk2+gTyBqQH4RR7xdCUA+bBlXt9uiSRgt5kfpxrYNHOm8tbLjw4cq
        p2NtyOi7vCcCqroULkTFRa3fUJOWCb55mqpJ0lfP0fB75C1E4KNgPCcFEHMaFnkY1IOr9yKqc/6J3
        KmWfvI5w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nGU-00GrFT-AQ; Mon, 12 Jul 2021 04:10:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 120/137] mm/filemap: Remove PageHWPoison check from next_uptodate_page()
Date:   Mon, 12 Jul 2021 04:06:44 +0100
Message-Id: <20210712030701.4000097-121-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 9da9bac99ecd..9a6550c8b7c7 100644
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

