Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13D2990E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 16:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783640AbgJZPTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 11:19:05 -0400
Received: from casper.infradead.org ([90.155.50.34]:43590 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783638AbgJZPTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l8eCDk2firTz0w0YHGNH9yZTukM9hhkaynyp0Z0Fr5Q=; b=RdNpb2ofnqEQYli7iiyAR7snql
        nI1qAJzygAsPyp9whDhrRoJqzbsCVGSqGr55s9ro/Mbmh+C6j3CX7M3QgCUCS2rCHbHCVYh2HA4aH
        QRGC+/Xle28dXU87GEvAYgVdd89Vsg6KgtcCdFIwV//r9EyFaR7a6ZZrJLUhCPc8Den0VzBg++QQF
        rwNR+PCgBFpK2X517VvCODxl/58Kp4LXzDiVnPZVcubslaGei6XNkaPPOp1ZLeSwarg89cweV0AMH
        1ehzqcEFaSJn1N8r9dw236lSFzgj0i6EsNFtQNPMKqkaBGhrTOVC8cEuif/IJp7HFeZreu8KA3PiY
        CePYkWgA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX4Gp-0006K4-Ol; Mon, 26 Oct 2020 15:18:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 3/4] dax: Account DAX entries as nrpages
Date:   Mon, 26 Oct 2020 15:18:48 +0000
Message-Id: <20201026151849.24232-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify mapping_needs_writeback() by accounting DAX entries as
pages instead of exceptional entries.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
---
 fs/dax.c     | 6 +++---
 mm/filemap.c | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 53ed0ab8c958..a20f2342a9e4 100644
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
@@ -661,7 +661,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 		goto out;
 	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
-	mapping->nrexceptional--;
+	mapping->nrpages -= 1UL << dax_entry_order(entry);
 	ret = 1;
 out:
 	put_unlocked_entry(&xas, entry);
diff --git a/mm/filemap.c b/mm/filemap.c
index 2e68116be4b0..2214a2c48dd1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -616,9 +616,6 @@ EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 /* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-	if (dax_mapping(mapping))
-		return mapping->nrexceptional;
-
 	return mapping->nrpages;
 }
 
-- 
2.28.0

