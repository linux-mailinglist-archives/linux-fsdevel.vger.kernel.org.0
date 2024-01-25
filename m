Return-Path: <linux-fsdevel+bounces-8855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9283BC9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7831F2916F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64520B24;
	Thu, 25 Jan 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsqWm1Ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156552030B;
	Thu, 25 Jan 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173137; cv=none; b=JCBkWg9yYoK9rfm/sUHGVXuHx8P5DHEgiW6fiAxpvIXJQ1g3MrWbWkPVBZWam23rfMVcsttG8Kvp96HsNaHOmGd/CdikgB7C8zJKinCOQ7TUhXfEcki9y/WmaMY94FPx7u1ockuW06rSKo8qcZOqRC8UJyTGilueO32h6cWWoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173137; c=relaxed/simple;
	bh=uGpduE64O2itYfQErOAsBg9JL2y9u+Xu+dfFoF1ZhrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWX14xpgvr/93yjnj9ZCoRwv4VvBMrxmfpc6PkbW/guUuqGPFZ1eMI/Z/SLWaBVrIVpzuP+lkhbjdNqJj8waKCULxYVnr1dYU9VPt8thM9KUwMhf/W6LkyNfYWMN3dWdfuoBoiVw9vaqvCsblJ2XPS+cXJu/+Ye69Fax12Yg/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YsqWm1Ve; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rQ/YR9r2MVXaLcMH7BH4MVX5/bfeEJP3+H7ANF9U6Gk=; b=YsqWm1VeZ/5woXx1pI6UQ82TBP
	jEo9O0uC5yGJGqt3juo+7kF4mK/ojbfOCnOR2XsQzaQJLlCKWT7zXgQwChqWQVMoR+KVflOoSaRP7
	WB1v6Ey5oqMI8hnNAL6t2AogyLtpByE7CzERscH+mKXtkULkp+e/lu+PFXcpjTSbEsSvoWB9NA27w
	DqyAEQS+XubKd67++tgTszn8Qzdx1vq/+tvzgi8MCg9x+i0doBASfAZ24YVnBQdvGOAqCRDiT5uDS
	LKjx14CAuf2dWanDl9/1HMpUHDgBzTBxeTmgpjLoQ1Ajc0T+IPmA78Cczi8TsIyZJAJNiJ9SkroZH
	vOyN5jMA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSvZM-007QOH-1U;
	Thu, 25 Jan 2024 08:58:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 11/19] writeback: Use the folio_batch queue iterator
Date: Thu, 25 Jan 2024 09:57:50 +0100
Message-Id: <20240125085758.2393327-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125085758.2393327-1-hch@lst.de>
References: <20240125085758.2393327-1-hch@lst.de>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d6ac414ddce9ca..432bb42d0829d1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2429,13 +2429,21 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	return true;
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
@@ -2475,7 +2483,6 @@ int write_cache_pages(struct address_space *mapping,
 {
 	int error;
 	pgoff_t end;		/* Inclusive */
-	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2491,18 +2498,12 @@ int write_cache_pages(struct address_space *mapping,
 	wbc->err = 0;
 
 	for (;;) {
-		struct folio *folio;
+		struct folio *folio = writeback_get_folio(mapping, wbc);
 		unsigned long nr;
 
-		if (i == wbc->fbatch.nr) {
-			writeback_get_batch(mapping, wbc);
-			i = 0;
-		}
-		if (wbc->fbatch.nr == 0)
+		if (!folio)
 			break;
 
-		folio = wbc->fbatch.folios[i++];
-
 		folio_lock(folio);
 		if (!folio_prepare_writeback(mapping, wbc, folio)) {
 			folio_unlock(folio);
-- 
2.39.2


