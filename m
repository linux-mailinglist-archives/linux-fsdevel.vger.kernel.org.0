Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46B151C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBDOZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:49648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgBDOZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18B33AEE7;
        Tue,  4 Feb 2020 14:25:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 018E71E0D0B; Tue,  4 Feb 2020 15:25:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5/8] dax: Use xas_erase() in __dax_invalidate_entry()
Date:   Tue,  4 Feb 2020 15:25:11 +0100
Message-Id: <20200204142514.15826-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating DAX entry, we need to clear all the outstanding marks
for the entry. Use dax_erase() instead of dax_store().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..848215fcd1aa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -643,7 +643,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
 	dax_disassociate_entry(entry, mapping, trunc);
-	xas_store(&xas, NULL);
+	xas_erase(&xas);
 	mapping->nrexceptional--;
 	ret = 1;
 out:
-- 
2.16.4

