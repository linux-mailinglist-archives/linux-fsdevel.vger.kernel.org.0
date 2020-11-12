Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360032B1056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgKLV1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgKLV05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B14C0613D1;
        Thu, 12 Nov 2020 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w06ZP8J1L1sNnrL6d7bu/K2RwiChw8umB6NkZXCjOJM=; b=a9Dldi9iEA7FsD03s2jU9jo1jw
        DCu12xlb5XFWmxWtgbqZO4LCcIUcnPn2cAeWN/YBHpH4yuWcCl3xgOxosVLAev/3+F+Oj2gZBcC2J
        +yWjYaqWuopWkvwOP7IPzWAznGyc1hWUmCXD1cIyIQ0plBCNNy3Mk1Rcj6F9GF0yQH+wiNOZTaFKE
        N2oR/gMEzTOCXt80wJZ1HPQyWkHSO1BrpcvUXkSGwHSQvsSUwXulC72JphaN3rocSWx3TGiT8UZlm
        3gIQITyu4v+ifFvLr06G9cgYZ6Nrui1twyBnSOEFKIFiBHLqiELYE06q6lzb3KIJVPzCybJYqrWo3
        Wv0E/QQA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7A-0007GF-Qj; Thu, 12 Nov 2020 21:26:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/16] mm/swap: Optimise get_shadow_from_swap_cache
Date:   Thu, 12 Nov 2020 21:26:28 +0000
Message-Id: <20201112212641.27837-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's no need to get a reference to the page, just load the entry and
see if it's a shadow entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap_state.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index cf7b322a9abc..d2161154d873 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -113,11 +113,9 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
 	pgoff_t idx = swp_offset(entry);
 	struct page *page;
 
-	page = find_get_entry(address_space, idx);
+	page = xa_load(&address_space->i_pages, idx);
 	if (xa_is_value(page))
 		return page;
-	if (page)
-		put_page(page);
 	return NULL;
 }
 
-- 
2.28.0

