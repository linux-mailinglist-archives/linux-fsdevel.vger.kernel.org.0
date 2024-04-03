Return-Path: <linux-fsdevel+bounces-16060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C01897814
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 20:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE471B2A47A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F848156870;
	Wed,  3 Apr 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trJzTW73"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE8152175;
	Wed,  3 Apr 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165057; cv=none; b=Ihj9RuGkFZhyqmYuyaGEej8eYHtesyOuXb7PBhjFkYqfW4egj1TKE4mw9EJEV7cGouy3vIZMDDlsbOgnSGz4zvDDsYCulpEjOuDLfXYpT3z/VYj6SKdF6RCAMlsPMOph3m5MCdAGuE/LBcTYLm8EzCDMx60LXELzebplzBvYO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165057; c=relaxed/simple;
	bh=zSO/odJdFXXneJrbo8fSVlxTxnqWFL7oMb2O1sfY2Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtpxgaP6esPhs4m+odvo5QuF09l+bEI7j1h4vA62ya03ALH3iv3vtgl39CW7F8fWiAZNi8d8X927VgElH7ffstxgFnLU+HzmuXkd3lysKcBvt0YvHEtYOsglpGI7y7H2J47j2SIJ037IdQY354+n8oTnIKLyB+LittzqQnCd8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=trJzTW73; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FaXgaXmPWGmVs0XtUcYWboJGgaLa4yLdJXSlNBFL4J4=; b=trJzTW73Phj4Jpy/0FaC2mAuFp
	4jmsPWb1fxghkOvsYtT9dUrQ0jkGry6AK4cW09kbj+YjxFqMXwYwq4lyn/404XB0CgjgcdjzBgMt0
	V+zFm1FyNHabodkzkNs+ETApejQqhs/n9xv5Z0AAdkkah8ZWLGnynBdo9AGeNQb37nJbXiK/gdlIB
	VsHS/73rjhZPqmHyJwccuxDVag2jApsvpd0O5lXNNAeVNwLT4K0cmSTuRzHTNi2Y0bZBkGFm2i/Lf
	at0MYJMVYaHpD25WG2qLaSxN2SX2lu5w9DKrfLLF3hvetU1SeXARb3TowUTIqCgU99WV5lu+4MfVr
	Bblz2lPA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4LE-0000000651f-2901;
	Wed, 03 Apr 2024 17:24:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev
Subject: [PATCH 2/4] gfs2: Add a migrate_folio operation for journalled files
Date: Wed,  3 Apr 2024 18:23:49 +0100
Message-ID: <20240403172400.1449213-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403172400.1449213-1-willy@infradead.org>
References: <20240403172400.1449213-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For journalled data, folio migration currently works by writing the folio
back, freeing the folio and faulting the new folio back in.  We can
bypass that by telling the migration code to migrate the buffer_heads
attached to our folios.  That lets us delete gfs2_jdata_writepage()
as it has no more callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 974aca9c8ea8..68fc8af14700 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -116,8 +116,7 @@ static int gfs2_write_jdata_folio(struct folio *folio,
  * @folio: The folio to write
  * @wbc: The writeback control
  *
- * This is shared between writepage and writepages and implements the
- * core of the writepage operation. If a transaction is required then
+ * Implements the core of write back. If a transaction is required then
  * the checked flag will have been set and the transaction will have
  * already been started before this is called.
  */
@@ -139,35 +138,6 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 	return gfs2_write_jdata_folio(folio, wbc);
 }
 
-/**
- * gfs2_jdata_writepage - Write complete page
- * @page: Page to write
- * @wbc: The writeback control
- *
- * Returns: errno
- *
- */
-
-static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-
-	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
-		goto out;
-	if (folio_test_checked(folio) || current->journal_info)
-		goto out_ignore;
-	return __gfs2_jdata_write_folio(folio, wbc);
-
-out_ignore:
-	folio_redirty_for_writepage(wbc, folio);
-out:
-	folio_unlock(folio);
-	return 0;
-}
-
 /**
  * gfs2_writepages - Write a bunch of dirty pages back to disk
  * @mapping: The mapping to write
@@ -749,12 +719,12 @@ static const struct address_space_operations gfs2_aops = {
 };
 
 static const struct address_space_operations gfs2_jdata_aops = {
-	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
 	.dirty_folio = jdata_dirty_folio,
 	.bmap = gfs2_bmap,
+	.migrate_folio = buffer_migrate_folio,
 	.invalidate_folio = gfs2_invalidate_folio,
 	.release_folio = gfs2_release_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
-- 
2.43.0


