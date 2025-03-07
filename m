Return-Path: <linux-fsdevel+bounces-43437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF1A56998
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087DC1887D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0821CA1B;
	Fri,  7 Mar 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NXceUjf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904921ADBA
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355661; cv=none; b=dRfHET+TvVoZRest/dQBp32N40RIt71nmJQxpAD5oJicxViCW65vTndgEVAQAbXBvsVR5M/ObzPSeIHee1NTBVDlQopLjQK2O4cTQkd8AuAjUtjqKIIFtcd0AeVsgHl8qcf0MyTLdiYDza5CVJoIQDJW83em2yOL6RQg5OxDiP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355661; c=relaxed/simple;
	bh=yv9KDY11w60y2th+hEZuhoMlihA50bxeq6BI5TEy2nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMJlZ4Op2H/8Hrt7uMyKN8cAYfmO4CCPOg2mkkIs2BdgsbVWJIlAASOcq6VJnvqKbXQBkhjMjokviRCYsHvNWMU2plE/rJXSglO8m7nkdNxuwCzqig4EBbvRucF0Y7Yc9/8KXFKA1LwpYayRdaNMDm57gR28stkjWHq0ftM0KN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NXceUjf/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mvaOn1iNfnHJjc4gSgVD8D2wLxi5A95q8CNsEb5mKOk=; b=NXceUjf/rN/nE14KGNhSPpVAVh
	KHf0pdp8XBGLyZVSxh21bmLjKks7mhrikiMkVY1Slftde2kxARF1sJEHTLzOrFGSlukw5i9KQ704K
	HpJO7LPaZK2IlUHtYN/tQhAJgrAyzc+WxQUajwcgShyq/1aIaCEAJfTAuV7yD4h+h7z+78IzYmkts
	iIs9QJxhHbfpeAiB7XWLbzfH09Dci81NPYhBAXhqSO0epSfc6DyK+OEyVmuTyMkQAG9MIm2+gXgfC
	tVBM5KM5M5hTdxnpnhCqQe7XILBlgcx5L1oqVTA5k1Lytpp0twq+bYWonIYYS3fA09Dv730/UJId5
	QK1+O/Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGM-1NhP;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 06/11] migrate: Remove call to ->writepage
Date: Fri,  7 Mar 2025 13:54:06 +0000
Message-ID: <20250307135414.2987755-7-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The writepage callback is going away; filesystems must implement
migrate_folio or else dirty folios will not be migratable.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/migrate.c | 57 ++++------------------------------------------------
 1 file changed, 4 insertions(+), 53 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c0adea67cd62..3d1d9d49fb8e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -944,67 +944,18 @@ int filemap_migrate_folio(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(filemap_migrate_folio);
 
-/*
- * Writeback a folio to clean the dirty state
- */
-static int writeout(struct address_space *mapping, struct folio *folio)
-{
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_NONE,
-		.nr_to_write = 1,
-		.range_start = 0,
-		.range_end = LLONG_MAX,
-		.for_reclaim = 1
-	};
-	int rc;
-
-	if (!mapping->a_ops->writepage)
-		/* No write method for the address space */
-		return -EINVAL;
-
-	if (!folio_clear_dirty_for_io(folio))
-		/* Someone else already triggered a write */
-		return -EAGAIN;
-
-	/*
-	 * A dirty folio may imply that the underlying filesystem has
-	 * the folio on some queue. So the folio must be clean for
-	 * migration. Writeout may mean we lose the lock and the
-	 * folio state is no longer what we checked for earlier.
-	 * At this point we know that the migration attempt cannot
-	 * be successful.
-	 */
-	remove_migration_ptes(folio, folio, 0);
-
-	rc = mapping->a_ops->writepage(&folio->page, &wbc);
-
-	if (rc != AOP_WRITEPAGE_ACTIVATE)
-		/* unlocked. Relock */
-		folio_lock(folio);
-
-	return (rc < 0) ? -EIO : -EAGAIN;
-}
-
 /*
  * Default handling if a filesystem does not provide a migration function.
  */
 static int fallback_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	if (folio_test_dirty(src)) {
-		/* Only writeback folios in full synchronous migration */
-		switch (mode) {
-		case MIGRATE_SYNC:
-			break;
-		default:
-			return -EBUSY;
-		}
-		return writeout(mapping, src);
-	}
+	if (folio_test_dirty(src))
+		return -EBUSY;
 
 	/*
-	 * Buffers may be managed in a filesystem specific way.
-	 * We must have no buffers or drop them.
+	 * Filesystem may have private data at folio->private that we
+	 * can't migrate automatically.
 	 */
 	if (!filemap_release_folio(src, GFP_KERNEL))
 		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
-- 
2.47.2


