Return-Path: <linux-fsdevel+bounces-10132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6742848446
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E41928A750
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38653399;
	Sat,  3 Feb 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZP6RRlB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836252F7A;
	Sat,  3 Feb 2024 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944360; cv=none; b=u2bVxp5Pk9OW/pScTl5/LFSmFvfQ7TWn2MpJPQxFqDupUuZ9qyrKStiz80alvHmGGfmu8sXGnJdt0s6fMj2faeT30pgWNLC7lL7FmoD5jwjyhbauhGJ2rzns6Plx1g1wyMGmEBEtXV9T/7bdHTkk8RQZRnCWcyAa1h+LVyg0U9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944360; c=relaxed/simple;
	bh=wQIP+N3XvRn+eYb7iTMjcVZ9jDHU0guNE2DI5QJg/zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fl7ABjXMutSr9Wuq8e7t6uDTIT2BK46P672SdZlGXuhI2le0mptmu6Veax7GtPk/k7EdiWWTgsvs+5tpGp0VgRk16kS+koDVjfhUpMONgRbPELM37mC2XElNnbWgAFctHbbKREcHQ6lO/arMQT28gxzsaxQXJD7ML1rR16aXqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BZP6RRlB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YJszH51EwdW2rUwhJ/fmC9DInqYvSSbYnjASxDZKqZ0=; b=BZP6RRlBDDpDvPXciqWZlZGJn5
	oC+v7sIzJvcs21tF8kJfjVZUxi+rlyNMkbXo9XyOmN+I4iFNmzmF8RE4x6Adbipm2iFwKH0YFjQdA
	9/nlcT5ORYA4i24NEohIRXfYMQHGG+tKQIlh8qPq1VUBvrwNdgJLkGI3T+hb+i9GBglSUhcAxX9Xq
	01aj7FFKMTuwF5eQBQl5BVoEFAIoOLYL7DjnFNlp/5NFpxywbU++nEGUH4m1TKZzgN5N+mKnfs/jO
	LXaUZ4bnnWLEsSjwcWKrbME/Fb2QcL2hF3E4KWQ0BaYNZfCcRv1Ee/5ZlvfFK9xbwIOfldgQwV1Gx
	JYbz3wYA==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWACZ-0000000FkAd-0VnK;
	Sat, 03 Feb 2024 07:12:35 +0000
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
Subject: [PATCH 08/13] writeback: Simplify the loops in write_cache_pages()
Date: Sat,  3 Feb 2024 08:11:42 +0100
Message-Id: <20240203071147.862076-9-hch@lst.de>
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

Collapse the two nested loops into one.  This is needed as a step
towards turning this into an iterator.

Note that this drops the "index <= end" check in the previous outer loop
and just relies on filemap_get_folios_tag() to return 0 entries when
index > end.  This actually has a subtle implication when end == -1
because then the returned index will be -1 as well and thus if there is
page present on index -1, we could be looping indefinitely. But as the
comment in filemap_get_folios_tag documents this as already broken anyway
we should not worry about it here either.  The fix for that would
probably a change to the filemap_get_folios_tag() calling convention.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
[hch: updated the commit log based on feedback from Jan Kara]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 75 ++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 23363ed712f646..d7ab42def43035 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2454,6 +2454,7 @@ int write_cache_pages(struct address_space *mapping,
 	int error;
 	struct folio *folio;
 	pgoff_t end;		/* Inclusive */
+	int i = 0;
 
 	if (wbc->range_cyclic) {
 		wbc->index = mapping->writeback_index; /* prev offset */
@@ -2467,53 +2468,49 @@ int write_cache_pages(struct address_space *mapping,
 
 	folio_batch_init(&wbc->fbatch);
 
-	while (wbc->index <= end) {
-		int i;
-
-		writeback_get_batch(mapping, wbc);
-
+	for (;;) {
+		if (i == wbc->fbatch.nr) {
+			writeback_get_batch(mapping, wbc);
+			i = 0;
+		}
 		if (wbc->fbatch.nr == 0)
 			break;
 
-		for (i = 0; i < wbc->fbatch.nr; i++) {
-			folio = wbc->fbatch.folios[i];
+		folio = wbc->fbatch.folios[i++];
 
-			folio_lock(folio);
-			if (!folio_prepare_writeback(mapping, wbc, folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		folio_lock(folio);
+		if (!folio_prepare_writeback(mapping, wbc, folio)) {
+			folio_unlock(folio);
+			continue;
+		}
 
-			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 
-			error = writepage(folio, wbc, data);
-			wbc->nr_to_write -= folio_nr_pages(folio);
+		error = writepage(folio, wbc, data);
+		wbc->nr_to_write -= folio_nr_pages(folio);
 
-			if (error == AOP_WRITEPAGE_ACTIVATE) {
-				folio_unlock(folio);
-				error = 0;
-			}
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		}
 
-			/*
-			 * For integrity writeback we have to keep going until
-			 * we have written all the folios we tagged for
-			 * writeback above, even if we run past wbc->nr_to_write
-			 * or encounter errors.
-			 * We stash away the first error we encounter in
-			 * wbc->saved_err so that it can be retrieved when we're
-			 * done.  This is because the file system may still have
-			 * state to clear for each folio.
-			 *
-			 * For background writeback we exit as soon as we run
-			 * past wbc->nr_to_write or encounter the first error.
-			 */
-			if (wbc->sync_mode == WB_SYNC_ALL) {
-				if (error && !ret)
-					ret = error;
-			} else {
-				if (error || wbc->nr_to_write <= 0)
-					goto done;
-			}
+		/*
+		 * For integrity writeback we have to keep going until we have
+		 * written all the folios we tagged for writeback above, even if
+		 * we run past wbc->nr_to_write or encounter errors.
+		 * We stash away the first error we encounter in wbc->saved_err
+		 * so that it can be retrieved when we're done.  This is because
+		 * the file system may still have state to clear for each folio.
+		 *
+		 * For background writeback we exit as soon as we run past
+		 * wbc->nr_to_write or encounter the first error.
+		 */
+		if (wbc->sync_mode == WB_SYNC_ALL) {
+			if (error && !ret)
+				ret = error;
+		} else {
+			if (error || wbc->nr_to_write <= 0)
+				goto done;
 		}
 	}
 
-- 
2.39.2


