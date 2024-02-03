Return-Path: <linux-fsdevel+bounces-10135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C622984844F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0056D1C25FF7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A856767;
	Sat,  3 Feb 2024 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vH0hdIAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C345674D;
	Sat,  3 Feb 2024 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944375; cv=none; b=WgDO1cNXuU0mWvLO2zjZ7Y2Nc2abdsCUgXs61hCE0AQBcbSxaSMXOyUnt1G8asDqpSSiZDfJCOLkL6z+ZvXSokbvFc4hJ3EynG1PCiWST9hQnkT3cgkzbPb9rSUzYyCRIe0OwolJy0MXqdlphyRc1EzuC6phxnUXpdoM9FvzacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944375; c=relaxed/simple;
	bh=BEzYiGhNCPidNvLvQLhLK2U2cZcI03nhea82PoTH56s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwTrdoNCgKMGcfy+qax7TpF0QaTvX8IW9Mm+MuGyEd1oNJAhUJwzyi6UaDOwiMqRYBjr0JZoNBe9QougMhh4v7NJSTGNoW8uLRh0CYDXN5HwOSG3OBzJsERNAJzMsbihP4/oaaVPsZVxZWyBDY4RlSU74ioZzQxFIkaoo0VGTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vH0hdIAp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AnG5GvoJfhWPvqWiitfZqai2sD2FuEVxQzhAIrm6KaA=; b=vH0hdIAp6gB22asQhHw8fV4fL7
	t7SMPnQ6UOZ06eB6iUc6QRiRN2CHY9Hoa3/Qt6lKZZW+1cVc05CzNKKIfNtKfWXE9n/0DIqp9pM41
	tUdkoZyp1A/VSO+XZuNI8/iD1snj2iILh49fiFClyMMSrDYvZwMScjIzwLgLCAtb95yYimLLC6kZs
	3uYxfZ9w1waMc6giSV8N33kIOCeAyPZBqp55YBUwZiocSMqmbEkiaPrGEeU7UtVNwsyGwiGTQe5eA
	t3RXkIGbnjSxOrBklgbZ7FsjwDnYiDV06ODpVc/+M3iEChRzlwXXkIMS44L9k65uCSyfj+bQtgnTP
	OJ4GTRbA==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACn-0000000FkIF-1VWY;
	Sat, 03 Feb 2024 07:12:50 +0000
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
Subject: [PATCH 11/13] writeback: Move the folio_prepare_writeback loop out of write_cache_pages()
Date: Sat,  3 Feb 2024 08:11:45 +0100
Message-Id: <20240203071147.862076-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240203071147.862076-1-hch@lst.de>
References: <20240203071147.862076-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Move the loop for should-we-write-this-folio to writeback_get_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: folded the loop into the existing helper instead of a separate one
      as suggested by Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 095ba4db9dcc17..3abb053e70580e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2411,6 +2411,7 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 
+retry:
 	folio = folio_batch_next(&wbc->fbatch);
 	if (!folio) {
 		folio_batch_release(&wbc->fbatch);
@@ -2418,8 +2419,17 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
+		if (!folio)
+			return NULL;
+	}
+
+	folio_lock(folio);
+	if (unlikely(!folio_prepare_writeback(mapping, wbc, folio))) {
+		folio_unlock(folio);
+		goto retry;
 	}
 
+	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 	return folio;
 }
 
@@ -2480,14 +2490,6 @@ int write_cache_pages(struct address_space *mapping,
 		if (!folio)
 			break;
 
-		folio_lock(folio);
-		if (!folio_prepare_writeback(mapping, wbc, folio)) {
-			folio_unlock(folio);
-			continue;
-		}
-
-		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-
 		error = writepage(folio, wbc, data);
 		wbc->nr_to_write -= folio_nr_pages(folio);
 
-- 
2.39.2


