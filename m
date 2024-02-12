Return-Path: <linux-fsdevel+bounces-11089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97484850DD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3847FB25052
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A560249E4;
	Mon, 12 Feb 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XbHX1mZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263E20DD2;
	Mon, 12 Feb 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722076; cv=none; b=Y0uQWi+DF2SCFfetYIQbO/1Jvpfzi7cMnHRs1aocqoEIDu743XNeSgMwsFdb2AL4rQnVptxlNl/9e1UFvmizAir/EqMtRfgzU31UyokGFgKH39p5YL3yw5eSJjSMvJ+RitjKg/ZcRPeL9tXhXsMR9ccfYzoxwb611wr3OIY0HIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722076; c=relaxed/simple;
	bh=R03670f0uJzq6tZ590Qnsjch+falD9+U0M7iGN8msuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naYJ6VG8Y/+K2t4GxmDTP+mp2+Cv5jv0mfwfSCudsPZXkK93MzH/QiffY0c/7ixGaHu3D+n7pXiPYPxAwg5NjeZVpyrZSoijLbvw4w/gDG+j/4efEXG/60Hq1DAYVr6OiroPV0cWKjhpIFa+LzQmm1+vnUg2/V9mGyBvVJdAxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XbHX1mZC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hDwf/sJTGlPIwBTRyPln6Zb1s+XpptYYA785c3w7vC4=; b=XbHX1mZCM5Mo7rShucMVsPQybi
	QYfeqa4nFaBzcM/DsAKy72s4D9gnZOQ+eZo15yg3xEHI7qigOLDFMavU0ZQlm8qdIdV8CBLgIYtNM
	gHhvHVUsTtsNGL+zE1jQLwkYVCj1Ruag3QbLwJ6Ta838iRkgnS1Lg6mE0P8nW/ZpIDmOytDpBIi4n
	yCMmI5JnIJvd0PcT1ZiaClUiaUlPN6MlYprQswFXIjkP/LX0Uli5B5o6UES3k6xUM87eJrAHtae9O
	FQP2lx8hKziZv9DQcZadgvj3xcrZEzcT3dQju6kWLLYmqNYz0W+KfaI8gVzCyx93dbRKa1wcqdpG3
	r9C4E0cQ==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQWN-00000004T3G-2raf;
	Mon, 12 Feb 2024 07:14:32 +0000
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
Subject: [PATCH 12/14] writeback: Move the folio_prepare_writeback loop out of write_cache_pages()
Date: Mon, 12 Feb 2024 08:13:46 +0100
Message-Id: <20240212071348.1369918-13-hch@lst.de>
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
index 62b663debe713b..01f076db4f2118 100644
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


