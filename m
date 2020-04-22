Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36B11B4809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgDVPDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbgDVPDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F0F1AE5A;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 855E91E0E97; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 11/23] mm: Use xas_erase() in page_cache_delete_batch()
Date:   Wed, 22 Apr 2020 17:02:44 +0200
Message-Id: <20200422150256.23473-12-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
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
index 23a051a7ef0f..48c488b505ad 100644
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

