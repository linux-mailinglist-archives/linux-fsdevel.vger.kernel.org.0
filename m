Return-Path: <linux-fsdevel+bounces-9628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3284377C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 08:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC83C28AF8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101A54F87;
	Wed, 31 Jan 2024 07:14:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797254F9C;
	Wed, 31 Jan 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685286; cv=none; b=RhYLjBpCakMHRMGw1/BGwFUDP/vAWbPpTiGb/mGbtXc9zRHo3CzwemV1YxmBvMpOBStxSkWC6k3BwSuJq2aDa9jJGjOdYGaafrhcH6wSF7P5EnpDzcqstUiyO1EWBB7QOeSri8fSkrEaeLKsJJLp0T/EygHwaiGrU5UkhatdEDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685286; c=relaxed/simple;
	bh=k2j8M59dz7qrBXCGQk58C4vwMDSZcDZTheCLukNm0r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvDn3I8Uy8FqK+pmdLQYZDjkUchCg0kj5vDWsBzXBVDIAu+oFOie2jJqh66mue0KZm4g1qCTLR5l34mp59DJHcOdVwSmf/Tsk5uWqdAe/HIWJG8Ff04zV6cW25JEg8Ccn7HfYdbZuQDvCvwOolIv2aKNjV9buZSJkMx/GJh/DQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9C0E68B05; Wed, 31 Jan 2024 08:14:37 +0100 (CET)
Date: Wed, 31 Jan 2024 08:14:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240131071437.GA17336@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-20-hch@lst.de> <20240130104605.2i6mmdncuhwwwfin@quack3> <20240130141601.GA31330@lst.de> <20240130215016.npofgza5nmoxuw6m@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130215016.npofgza5nmoxuw6m@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 10:50:16PM +0100, Jan Kara wrote:
> Well, batch release needs to be only here because if writeback_get_folio()
> returns NULL, the batch has been already released by it.

Indeed.

> So what would be
> duplicated is only the error assignment. But I'm fine with the version in
> the following email and actually somewhat prefer it compared the yet
> another variant you've sent.

So how about another variant, this is closer to your original suggestion.
But I've switched around the ordered of the folio or not branches
from my original patch, and completely reworked and (IMHO) improved the
comments.  it replaces patch 19 instead of being incremental to be
readable:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 58b3661f5eac9e..1593a783176ca2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1985,12 +1985,13 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops)
 {
-	struct folio *folio;
-	int ret;
+	struct folio *folio = NULL;
+	int ret = 0;
 
 	wpc->ops = ops;
-	for_each_writeback_folio(mapping, wbc, folio, ret)
+	while ((folio = writeback_iter(mapping, wbc, folio, &ret)))
 		ret = iomap_do_writepage(folio, wbc, wpc);
+
 	if (!wpc->ioend)
 		return ret;
 	return iomap_submit_ioend(wpc, wpc->ioend, ret);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 2416da933440e2..fc4605627496fc 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -367,15 +367,8 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 
 bool wb_over_bg_thresh(struct bdi_writeback *wb);
 
-struct folio *writeback_iter_init(struct address_space *mapping,
-		struct writeback_control *wbc);
-struct folio *writeback_iter_next(struct address_space *mapping,
-		struct writeback_control *wbc, struct folio *folio, int error);
-
-#define for_each_writeback_folio(mapping, wbc, folio, error)		\
-	for (folio = writeback_iter_init(mapping, wbc);			\
-	     folio || ((error = wbc->err), false);			\
-	     folio = writeback_iter_next(mapping, wbc, folio, error))
+struct folio *writeback_iter(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int *error);
 
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0763c4353a676a..eefcb00cb7b227 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,29 +2360,6 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static void writeback_finish(struct address_space *mapping,
-		struct writeback_control *wbc, pgoff_t done_index)
-{
-	folio_batch_release(&wbc->fbatch);
-
-	/*
-	 * For range cyclic writeback we need to remember where we stopped so
-	 * that we can continue there next time we are called.  If  we hit the
-	 * last page and there is more work to be done, wrap back to the start
-	 * of the file.
-	 *
-	 * For non-cyclic writeback we always start looking up at the beginning
-	 * of the file if we are called again, which can only happen due to
-	 * -ENOMEM from the file system.
-	 */
-	if (wbc->range_cyclic) {
-		if (wbc->err || wbc->nr_to_write <= 0)
-			mapping->writeback_index = done_index;
-		else
-			mapping->writeback_index = 0;
-	}
-}
-
 static xa_mark_t wbc_to_tag(struct writeback_control *wbc)
 {
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
@@ -2442,10 +2419,8 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 		filemap_get_folios_tag(mapping, &wbc->index, wbc_end(wbc),
 				wbc_to_tag(wbc), &wbc->fbatch);
 		folio = folio_batch_next(&wbc->fbatch);
-		if (!folio) {
-			writeback_finish(mapping, wbc, 0);
+		if (!folio)
 			return NULL;
-		}
 	}
 
 	folio_lock(folio);
@@ -2458,60 +2433,107 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 	return folio;
 }
 
-struct folio *writeback_iter_init(struct address_space *mapping,
-		struct writeback_control *wbc)
+/**
+ * writepage_iter - iterate folio of a mapping for writeback
+ * @mapping: address space structure to write
+ * @wbc: writeback context
+ * @folio: previously iterated folio (%NULL to start)
+ * @error: in-out pointer for writeback errors (see below)
+ *
+ * This function should be called in a while loop in the ->writepages
+ * implementation and returns the next folio for the writeback operation
+ * described by @wbc on @mapping.
+ *
+ * To start writeback @folio should be passed as NULL, for every following
+ * iteration the folio returned by this function previously should be passed.
+ * @error should contain the error from the previous writeback iteration when
+ * calling writeback_iter.
+ *
+ * Once the writeback described in @wbc has finished, this function will return
+ * %NULL and if there was an error in any iteration restore it to @error.
+ *
+ * Note: callers should not manually break out of the loop using break or goto.
+ */
+struct folio *writeback_iter(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio, int *error)
 {
-	if (wbc->range_cyclic)
-		wbc->index = mapping->writeback_index; /* prev offset */
-	else
-		wbc->index = wbc->range_start >> PAGE_SHIFT;
-
-	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, wbc->index, wbc_end(wbc));
-
-	wbc->err = 0;
-	folio_batch_init(&wbc->fbatch);
-	return writeback_get_folio(mapping, wbc);
-}
+	if (!folio) {
+		folio_batch_init(&wbc->fbatch);
+		wbc->err = 0;
 
-struct folio *writeback_iter_next(struct address_space *mapping,
-		struct writeback_control *wbc, struct folio *folio, int error)
-{
-	unsigned long nr = folio_nr_pages(folio);
+		/*
+		 * For range cyclic writeback we remember where we stopped so
+		 * that we can continue where we stopped.
+		 *
+		 * For non-cyclic writeback we always start at the beginning of
+		 * the passed in range.
+		 */
+		if (wbc->range_cyclic)
+			wbc->index = mapping->writeback_index;
+		else
+			wbc->index = wbc->range_start >> PAGE_SHIFT;
 
-	wbc->nr_to_write -= nr;
+		/*
+		 * To avoid livelocks when other processes dirty new pages, we
+		 * first tag pages which should be written back and only then
+		 * start writing them.
+		 *
+		 * For data-integrity sync we have to be careful so that we do
+		 * not miss some pages (e.g., because some other process has
+		 * cleared the TOWRITE tag we set).  The rule we follow is that
+		 * TOWRITE tag can be cleared only by the process clearing the
+		 * DIRTY tag (and submitting the page for I/O).
+		 */
+		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+			tag_pages_for_writeback(mapping, wbc->index,
+					wbc_end(wbc));
+	} else {
+		wbc->nr_to_write -= folio_nr_pages(folio);
 
-	/*
-	 * Handle the legacy AOP_WRITEPAGE_ACTIVATE magic return value.
-	 * Eventually all instances should just unlock the folio themselves and
-	 * return 0;
-	 */
-	if (error == AOP_WRITEPAGE_ACTIVATE) {
-		folio_unlock(folio);
-		error = 0;
+		/*
+		 * For integrity writeback  we have to keep going until we have
+		 * written all the folios we tagged for writeback prior to
+		 * entering the writeback loop, even if we run past
+		 * wbc->nr_to_write or encounter errors, and just stash away
+		 * the first error we encounter in wbc->err so that it can
+		 * be retrieved on return.
+		 *
+		 * This is because the file system may still have state to clear
+		 * for each folio.  We'll eventually return the first error
+		 * encountered.
+		 */
+		if (wbc->sync_mode == WB_SYNC_ALL) {
+			if (*error && !wbc->err)
+				wbc->err = *error;
+		} else {
+			if (*error || wbc->nr_to_write <= 0)
+				goto done;
+		}
 	}
 
-	if (error && !wbc->err)
-		wbc->err = error;
+	folio = writeback_get_folio(mapping, wbc);
+	if (!folio) {
+		/*
+		 * For range cyclic writeback not finding another folios means
+		 * that we are at the end of the file.  In that case go back
+		 * to the start of the file for the next call.
+		 */
+		if (wbc->range_cyclic)
+			mapping->writeback_index = 0;
 
-	/*
-	 * For integrity sync  we have to keep going until we have written all
-	 * the folios we tagged for writeback prior to entering the writeback
-	 * loop, even if we run past wbc->nr_to_write or encounter errors.
-	 * This is because the file system may still have state to clear for
-	 * each folio.   We'll eventually return the first error encountered.
-	 *
-	 * For background writeback just push done_index past this folio so that
-	 * we can just restart where we left off and media errors won't choke
-	 * writeout for the entire file.
-	 */
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    (wbc->err || wbc->nr_to_write <= 0)) {
-		writeback_finish(mapping, wbc, folio->index + nr);
-		return NULL;
+		/*
+		 * Return the first error we encountered (if there was any) to
+		 * the caller now that we are done.
+		 */
+		*error = wbc->err;
 	}
+	return folio;
 
-	return writeback_get_folio(mapping, wbc);
+done:
+	if (wbc->range_cyclic)
+		mapping->writeback_index = folio->index + folio_nr_pages(folio);
+	folio_batch_release(&wbc->fbatch);
+	return NULL;
 }
 
 /**
@@ -2549,13 +2571,18 @@ int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data)
 {
-	struct folio *folio;
-	int error;
+	struct folio *folio = NULL;
+	int error = 0;
 
-	for_each_writeback_folio(mapping, wbc, folio, error)
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
 		error = writepage(folio, wbc, data);
+		if (error == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			error = 0;
+		}
+	}
 
-	return wbc->err;
+	return error;
 }
 EXPORT_SYMBOL(write_cache_pages);
 
@@ -2563,13 +2590,17 @@ static int writeback_use_writepage(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
 	struct blk_plug plug;
-	struct folio *folio;
-	int err;
+	struct folio *folio = NULL;
+	int err = 0;
 
 	blk_start_plug(&plug);
-	for_each_writeback_folio(mapping, wbc, folio, err) {
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
 		err = mapping->a_ops->writepage(&folio->page, wbc);
 		mapping_set_error(mapping, err);
+		if (err == AOP_WRITEPAGE_ACTIVATE) {
+			folio_unlock(folio);
+			err = 0;
+		}
 	}
 	blk_finish_plug(&plug);
 

