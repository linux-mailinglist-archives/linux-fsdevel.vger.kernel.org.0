Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA1151C18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBDOZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbgBDOZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94BA5AE52;
        Tue,  4 Feb 2020 14:25:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F0B9D1E0D09; Tue,  4 Feb 2020 15:25:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4/8] mm: Use xas_erase() in page_cache_delete_batch()
Date:   Tue,  4 Feb 2020 15:25:10 +0100
Message-Id: <20200204142514.15826-5-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to clear marks when removing a page from xarray since there
could be DIRTY or TOWRITE tags left for the page. Use xas_erase() to
explicitely request mark clearing.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..ca7eeb067a23 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -333,7 +333,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 		 */
 		if (page->index + compound_nr(page) - 1 == xas.xa_index)
 			i++;
-		xas_store(&xas, NULL);
+		xas_erase(&xas);
 		total_pages++;
 	}
 	mapping->nrpages -= total_pages;
-- 
2.16.4

