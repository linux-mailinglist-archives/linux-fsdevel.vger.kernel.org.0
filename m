Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372B223BDF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHDQSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgHDQSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:18:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF61C06179E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FP1uJLv/iUGGxCHzPq47tYJZ9XtyvZoBsMXwg0wUi4E=; b=rFRGehJj3pybPeMWt2c7DpXfhS
        2c5gWioEVFC4vbqL+nHIjlXm++/jLTEwG+QaU+LZkEFGYZQqtEYIJsj5heg36HAHMrz3cj9ptK4hg
        Sw23NSOAx/KZVZ00WlLnHIcmNjQrMO3I8v5UjCfjR3F5Vh7Q2gQlyymA7oEOKP9xfUExqHKx/zoMJ
        KEZYcyqjrz6e7WZ/VQahcr89YjCpeQNriZr79zFrnF5WkhtaR77Hag4XO7OgL+rJjhZn6LB2/qK/C
        VCWjJGFrZP1dvR46ID4ngyx8Za1CcPmIt4PBJJJXUny2/41rSeAC2/gIGbVNUuncI7oPWE5gk7kRT
        /LAAOQOA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2zdW-0002eF-3b; Tue, 04 Aug 2020 16:17:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 3/4] dax: Account DAX entries as nrpages
Date:   Tue,  4 Aug 2020 17:17:54 +0100
Message-Id: <20200804161755.10100-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804161755.10100-1-willy@infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify mapping_needs_writeback() by accounting DAX entries as
pages instead of exceptional entries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dax.c     | 6 +++---
 mm/filemap.c | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 2f75ee2cd41f..71ddab04d91d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -525,7 +525,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, true);
-		mapping->nrexceptional--;
+		mapping->nrpages -= PG_PMD_NR;
 		entry = NULL;
 		xas_set(xas, index);
 	}
@@ -541,7 +541,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
-		mapping->nrexceptional++;
+		mapping->nrpages += 1UL << order;
 	}
 
 out_unlock:
@@ -644,7 +644,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 		goto out;
 	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
-	mapping->nrexceptional--;
+	mapping->nrpages -= dax_entry_order(entry);
 	ret = 1;
 out:
 	put_unlocked_entry(&xas, entry);
diff --git a/mm/filemap.c b/mm/filemap.c
index 7c3f97bd6dcd..ef8ecfba7f9b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -615,9 +615,6 @@ EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 /* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-	if (dax_mapping(mapping))
-		return mapping->nrexceptional;
-
 	return mapping->nrpages;
 }
 
-- 
2.27.0

