Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0009151C21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBDOZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:49772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgBDOZY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4E16ACF0;
        Tue,  4 Feb 2020 14:25:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0F8351E0D1A; Tue,  4 Feb 2020 15:25:16 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Date:   Tue,  4 Feb 2020 15:25:14 +0100
Message-Id: <20200204142514.15826-9-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When storing NULL in xarray, xas_store() has been clearing all marks
because it could otherwise confuse xas_for_each_marked(). That is
however no longer true and no current user relies on this behavior.
Furthermore it seems as a cleaner API to not do clearing behind caller's
back in case we store NULL.

This provides a nice boost to truncate numbers due to saving unnecessary
tag initialization when clearing shadow entries. Sample benchmark
showing time to truncate 128 files 1GB each on machine with 64GB of RAM
(so about half of entries are shadow entries):

         AVG      STDDEV
Vanilla  4.825s   0.036
Patched  4.516s   0.014

So we can see about 6% reduction in overall truncate time.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 4e32497c51bd..f165e83652f1 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -799,17 +799,8 @@ void *xas_store(struct xa_state *xas, void *entry)
 		if (xas->xa_sibs)
 			xas_squash_marks(xas);
 	}
-	if (!entry)
-		xas_init_marks(xas);
 
 	for (;;) {
-		/*
-		 * Must clear the marks before setting the entry to NULL,
-		 * otherwise xas_for_each_marked may find a NULL entry and
-		 * stop early.  rcu_assign_pointer contains a release barrier
-		 * so the mark clearing will appear to happen before the
-		 * entry is set to NULL.
-		 */
 		rcu_assign_pointer(*slot, entry);
 		if (xa_is_node(next) && (!node || node->shift))
 			xas_free_nodes(xas, xa_to_node(next));
-- 
2.16.4

