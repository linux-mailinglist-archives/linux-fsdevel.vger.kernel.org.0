Return-Path: <linux-fsdevel+bounces-11088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FF850DD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8DE287B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC21EF0E;
	Mon, 12 Feb 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPFKGKFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51611CABF;
	Mon, 12 Feb 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722072; cv=none; b=TzTtmngfftpbWB7aWJ1WQjR7NGgpq4X7jqvJPafekSrVIeb2+csyiIaBmdd37QHLpGyZXImY9L3FJDp2RU1RUfLmx0ZU0zMUvueDJEiD2Z/ebFZUvRFpgrD82euhjZsVYmIJgtpkdq0iVpgxpgNgvriVogCQbsVE0bDG1bEWftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722072; c=relaxed/simple;
	bh=2FNgx33uieAGGD7HB2Qd3F2JZ17pdGt3GQ4I7EQhx2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdwM1aeL5eeA9Joj36faTAXUhVnAwdnf5CjOA3SlivoBWtqaVfta6SXzWZyBIrOrF8t+agOsYkKlNXET9W7SJhSurMRIowzlqJJkMsJ1pI2laJpLUETVpRwkQ4gfCxh+Kp3spmEBkF+6qv61G2NZWPf3VHca2aEtbNITY+vQrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PPFKGKFd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+Lom8uD40NGvlqisQyOK8nFLP+lWD9RUXEqKKIbGSn4=; b=PPFKGKFdog+pRhtnYVX3WRltrB
	ikV+4bwKtUpdsZ8JyPWOpR/eCx2IumzP/5BsTgIlB2axxAYRuMgIlbeJvtoS9crUEwioqaAVLIEy9
	qe68HPx2+QSYY3d4+4EaLCUNFTjf6H5EsJ+Pf6Aic0UDbxShZgMHL2WP23oVmHjAD1RQyq5rOpy8j
	f90sfKpTzUAuob0zsJ8hcHxrSwQIiE9b6alk7Q0pmRALR7/PqiH3FBss+f4aY6y6jZnvQs41cJoJv
	PVW8Uvg/YNsq8/zUd6e/H02sDTt5aQbaw1r/Wu4Y+ATBQVVma61LebMzf/d0G6ueSwnLc0neemdyr
	lgavjWNQ==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQWL-00000004T2h-0GbS;
	Mon, 12 Feb 2024 07:14:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 11/14] writeback: Use the folio_batch queue iterator
Date: Mon, 12 Feb 2024 08:13:45 +0100
Message-Id: <20240212071348.1369918-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212071348.1369918-1-hch@lst.de>
References: <20240212071348.1369918-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Instead of keeping our own local iterator variable, use the one just
added to folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a94a77b1805969..62b663debe713b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2406,13 +2406,21 @@ static pgoff_t wbc_end(struct writeback_control *wbc)
 	return wbc->range_end >> PAGE_SHIFT;
 }
 
-static void writeback_get_batch(struct address_space *mapping,
+static struct folio *writeback_get_folio(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
-	folio_batch_release(&wbc->fbatch);
-	cond_resched();
-	filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
-			wbc_to_tag(wbc), &wbc->fbatch);
+	struct folio *folio;
+
+	folio = folio_batch_next(&wbc->fbatch);
+	if (!folio) {
+		folio_batch_release(&wbc->fbatch);
+		cond_resched();
+		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
+				wbc_to_tag(wbc), &wbc->fbatch);
+		folio = folio_batch_next(&wbc->fbatch);
+	}
+
+	return folio;
 }
 
 /**
@@ -2454,7 +2462,6 @@ int write_cache_pages(struct address_space *mapping,
 	int error;
 	struct folio *folio;
 	pgoff_t end;		/* Inclusive */
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2469,15 +2476,10 @@ int write_cache_pages(struct address_space *mapping,
 	folio_batch_init(&wbc->fbatch);
 
 	for (;;) {
-		if (i == wbc->fbatch.nr) {
-			writeback_get_batch(mapping, wbc);
-			i = 0;
-		}
-		if (wbc->fbatch.nr == 0)
+		folio = writeback_get_folio(mapping, wbc);
+		if (!folio)
 			break;
 
-		folio = wbc->fbatch.folios[i++];
-
 		folio_lock(folio);
 		if (!folio_prepare_writeback(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


