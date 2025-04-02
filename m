Return-Path: <linux-fsdevel+bounces-45532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC24A791C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A64170780
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0723AE93;
	Wed,  2 Apr 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/MLFsPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AABC23C8B7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606022; cv=none; b=T1Wm3HP92GE+BY9qk702s7HbKpvp3kEZA4CbxwM0JktLLv9+avbcL0/zKrySJxBCu67OQhkcogVZk1Cjuat455DuWysIVj32hXESy5L/x/shx7F8SgytOc0BT9BTcnFs9wtAITnkezU9tUlQWH7JjWspofRjQi3vQPBKS7EeUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606022; c=relaxed/simple;
	bh=4B5J3DbErcd8b+TW7oApS/pINXzPINo20RAUwfkDtPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnx84/Ok3mpII9J8bbx4AeGKMIzHn5mt9rz4xkNH3y1a5hvifi/gPAGJjvEeTOtV/ysgQ6/tUhPewXcYyE09CaQ7shKLPXzX+JKYZtpkvPO39FOpM1bUXNS3g77LdeSvIGNt2y0SD9Y2h0/hE4M3W0bgG/9Fi9ge5sj9VhrMn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R/MLFsPv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5XW0b8o2GA0rXaRAcMoHAk0zi9Q3pqKKR/5ZrqK6isA=; b=R/MLFsPvz24ooXP3n2jFFdaQXS
	M3AdX4NhgWKE+Ldr9ttHKD8qgG5GZYrzl4HoldQmoxWhsTna7sbeqGeV85qzgdBMglKSZcZo/qhDL
	27mzrVxCjQJEvMLyNxePILgRc7e8EX9LjIZsx1RTe7+xFO4/WYXtZfFZp9QtaI2kspbnodfP3P44a
	fbnLduvq4PVvMS9Ka/aw11jUuI7aHj0yslB/pG7B/3rc6DfE161Izl44/4miE8Y+4cy2i60FQ4eM2
	SOmtlICqt4DAxV3OBU6XtQ/ljD0WkgGJMiiWXQ4KH10ZgdKRajR1ONKHvVArn/PYczuOaMxhaNYYz
	gU7zsJJA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gsB-18Xi;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/9] migrate: Remove call to ->writepage
Date: Wed,  2 Apr 2025 15:59:57 +0100
Message-ID: <20250402150005.2309458-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
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
 mm/migrate.c | 60 ++++++----------------------------------------------
 1 file changed, 7 insertions(+), 53 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..6e2488e5dbe4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -944,67 +944,21 @@ int filemap_migrate_folio(struct address_space *mapping,
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
+	WARN_ONCE(mapping->a_ops->writepages,
+			"%ps does not implement migrate_folio\n",
+			mapping->a_ops);
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


