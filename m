Return-Path: <linux-fsdevel+bounces-9538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AA8426CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DC1C25BDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166606DD12;
	Tue, 30 Jan 2024 14:22:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91206DCFE;
	Tue, 30 Jan 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624531; cv=none; b=ivJ0ztuhfqvb7BoRqdxsxgQJwZa4LsnpD2mReMnRRhr+qJGG+TFMZiZpLErKNi4O6+qjMhMR31P+Jg7y7EvOjhdX6SvN/X+YJImYmbV6UFaYlk08ar2NTsCbgGsuNMpvAz+i784ZJyWKx8X25jGFuGlHzdg1ZOFtrbxqo3A2Ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624531; c=relaxed/simple;
	bh=svlUzzJXch0DUB2Fhku2Pk2AcMUlUWwCYXfJ+OVC8F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hskSTCtrgMUBRLxjl8hu8TDR3Gg+cYQhNMPnp/ywp3NnA1dUOlOmkP0tc7MFcWXpuJnEu2y4IR46dOLiB3ZHuYcYOkc73TxIJdYrlQe2p7pZwVijQUa4h18RhEjxHQ81PfpOlV4ILh+gFyaCtIUTCwr0mOXR156iQ/ewEiZPKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A33B227A87; Tue, 30 Jan 2024 15:22:05 +0100 (CET)
Date: Tue, 30 Jan 2024 15:22:05 +0100
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
Message-ID: <20240130142205.GB31330@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-20-hch@lst.de> <20240130104605.2i6mmdncuhwwwfin@quack3> <20240130141601.GA31330@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130141601.GA31330@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 03:16:01PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 30, 2024 at 11:46:05AM +0100, Jan Kara wrote:
> > Looking at it now I'm thinking whether we would not be better off to
> > completely dump the 'error' argument of writeback_iter() /
> > writeback_iter_next() and just make all .writepage implementations set
> > wbc->err directly. But that means touching all the ~20 writepage
> > implementations we still have...
> 
> Heh.  I actually had an earlier version that looked at wbc->err in
> the ->writepages callers.  But it felt a bit too ugly.
> 
> > > +		 */
> > > +		if (wbc->sync_mode == WB_SYNC_NONE &&
> > > +		    (wbc->err || wbc->nr_to_write <= 0))
> > > +			goto finish;
> > 
> > I think it would be a bit more comprehensible if we replace the goto with:
> > 			folio_batch_release(&wbc->fbatch);
> > 			if (wbc->range_cyclic)
> > 				mapping->writeback_index =
> > 					folio->index + folio_nr_pages(folio);
> > 			*error = wbc->err;
> > 			return NULL;
> 
> I agree that keeping the logic on when to break and when to set the
> writeback_index is good, but duplicating the batch release and error
> assignment seems a bit suboptimal.  Let me know what you think of the
> alternatіve variant below.

And now for real:


diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d8fcbac2d72310..3e4aa5bfe75819 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2475,10 +2475,23 @@ struct folio *writeback_iter(struct address_space *mapping,
 		 * For background writeback just push done_index past this folio
 		 * so that we can just restart where we left off and media
 		 * errors won't choke writeout for the entire file.
+		 *
+		 * For range cyclic writeback we need to remember where we
+		 * stopped so that we can continue there next time we are
+		 * called.  If we hit the last page and there is more work
+		 * to be done, wrap back to the start of the file.
+		 *
+		 * For non-cyclic writeback we always start looking up at the
+		 * beginning of the file if we are called again, which can only
+		 * happen due to -ENOMEM from the file system.
 		 */
 		if (wbc->sync_mode == WB_SYNC_NONE &&
-		    (wbc->err || wbc->nr_to_write <= 0))
+		    (wbc->err || wbc->nr_to_write <= 0)) {
+			if (wbc->range_cyclic)
+				mapping->writeback_index =
+					folio->index + folio_nr_pages(folio);
 			goto finish;
+		}
 	} else {
 		if (wbc->range_cyclic)
 			wbc->index = mapping->writeback_index; /* prev offset */
@@ -2492,31 +2505,15 @@ struct folio *writeback_iter(struct address_space *mapping,
 	}
 
 	folio = writeback_get_folio(mapping, wbc);
-	if (!folio)
+	if (!folio) {
+		if (wbc->range_cyclic)
+			mapping->writeback_index = 0;
 		goto finish;
+	}
 	return folio;
 
 finish:
 	folio_batch_release(&wbc->fbatch);
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
-		WARN_ON_ONCE(wbc->sync_mode != WB_SYNC_NONE);
-		if (wbc->err || wbc->nr_to_write <= 0)
-			mapping->writeback_index =
-				folio->index + folio_nr_pages(folio);
-		else
-			mapping->writeback_index = 0;
-	}
 	*error = wbc->err;
 	return NULL;
 }

