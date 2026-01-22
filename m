Return-Path: <linux-fsdevel+bounces-75121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIGQFuJdcmnbjAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:26:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2206B404
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1833A30215B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1552FDC5C;
	Thu, 22 Jan 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XfNCGydT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF226ED46
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100705; cv=none; b=gKo3esf9TEGg8nuDfI7sm2UnB4uKvpT/iXO+BfWZD58u9y/GChp2wH3PV+nZvXca9Vt5Y14yprXawO+5ekxpD60ZExPywNBbuM30DYDokiLaE4qLfHRunaJ8xMXcdvj+iZemPC/xXVM9ZxQzH4MGeELZULBmwikVUirMI18eSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100705; c=relaxed/simple;
	bh=BkNCKLcWQqVf5WeWboQ4+mG3qDSQZFn9jm4nXVA7ycw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMdvrw+FKfdU2rYqf8av/ScyGkivrs5QyQtNl4hXlftA9yXgeh+NLf+JlYkeCy8Lt4nhoIpl15KPy47g308lpK9pWZn0tLt7zYebNrjLapKLxzwNMEf2NkuF/LX3MPPS6TcQbIJC/SSypaOA9zZskKdlY2Cv19FophiJwbg1ntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XfNCGydT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Soblh2RNTRhcpwbx4AV60NMfshy1tQwFzK2qCbOWb9I=; b=XfNCGydTpJTuXv2YQ/SVSBpXZk
	dgEf83Y8MgYA+VzJAsxSW+tZ0Rj4fYcy9xifcVcnUDSF3caM8GA5JbArddaRtHPHAk25MA9xN6tCD
	PabZINcviMZptpcb6L1gYOXmgDxoXGKb/hrxcQFeBT5GCNL5gWGkmbT/Q5AQjVszXeOlSV7R4NxZZ
	TCqWW73ZmoKLThZm26Wvx7er5JyB9fxv3WdeHNtupboovJFXjrjFWxbW/qxSCtSRFx8Ilgt9KU34J
	025PDreizzWaC1aTi6OMyo1F/FExDY5pU7LxrAveEByPs61/Vf/PAxSaj9OJE9JoJjXgdvz965jLc
	uPGuieHg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vixu9-00000000aPm-1O4P;
	Thu, 22 Jan 2026 16:51:33 +0000
Date: Thu, 22 Jan 2026 16:51:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iomap: fix readahead folio access after
 folio_end_read()
Message-ID: <aXJVlYkGKaHFFH9T@casper.infradead.org>
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com>
 <aXCE7jZ5HdhOktEs@infradead.org>
 <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75121-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Queue-Id: DE2206B404
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 03:13:35PM -0800, Joanne Koong wrote:
> Thanks for taking a look at this. The problem I'm trying to fix is
> this readahead scenario:
> * folio with no ifs gets read in by the filesystem through the
> ->read_folio_range() call
> * the filesystem reads in the folio and calls
> iomap_finish_folio_read() which calls folio_end_read(), which unlocks
> the folio
> * then the page cache evicts the folio and drops the last refcount on
> the folio which frees the folio and the folio gets repurposed by
> another filesystem (eg btrfs) which uses folio->private
> * the iomap logic accesses ctx->cur_folio still, and in the call to
> iomap_read_end(), it'll detect a non-null folio->private and it'll
> assume that's the ifs and it'll try to do stuff like
> spin_lock_irq(&ifs->state_lock) which will crash the system.
> 
> This is not a problem for folios with an ifs because the +1 bias we
> add to ifs->read_bytes_pending makes it so that iomap is the one who
> invokes folio_end_read() when it's all done with the folio.

This is so complicated.  I think you made your life harder by adding the
bias to read_bytes_pending.  What if we just rip most of this out ...

(the key here is to call iomap_finish_folio_read() instead of
iomap_set_range_uptodate() when we zero parts of the folio)

I've thrown this at my test VM.  See how it ends up doing.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 154456e39fe5..c2ff4f561617 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -381,7 +381,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 		ifs_alloc(iter->inode, folio, iter->flags);
 
 	folio_fill_tail(folio, offset, iomap->inline_data, size);
-	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
+	iomap_finish_folio_read(folio, offset, folio_size(folio) - offset, 0);
 	return 0;
 }
 
@@ -418,92 +418,19 @@ static void iomap_read_init(struct folio *folio)
 	struct iomap_folio_state *ifs = folio->private;
 
 	if (ifs) {
-		size_t len = folio_size(folio);
-
 		/*
-		 * ifs->read_bytes_pending is used to track how many bytes are
-		 * read in asynchronously by the IO helper. We need to track
-		 * this so that we can know when the IO helper has finished
-		 * reading in all the necessary ranges of the folio and can end
-		 * the read.
-		 *
-		 * Increase ->read_bytes_pending by the folio size to start, and
-		 * add a +1 bias. We'll subtract the bias and any uptodate /
-		 * zeroed ranges that did not require IO in iomap_read_end()
-		 * after we're done processing the folio.
-		 *
-		 * We do this because otherwise, we would have to increment
-		 * ifs->read_bytes_pending every time a range in the folio needs
-		 * to be read in, which can get expensive since the spinlock
-		 * needs to be held whenever modifying ifs->read_bytes_pending.
-		 *
-		 * We add the bias to ensure the read has not been ended on the
-		 * folio when iomap_read_end() is called, even if the IO helper
-		 * has already finished reading in the entire folio.
+		 * Initially all bytes in the folio are pending.
+		 * We subtract as either reads complete or we decide
+		 * to memset().  Once the count reaches zero, the read
+		 * is complete.
 		 */
 		spin_lock_irq(&ifs->state_lock);
 		WARN_ON_ONCE(ifs->read_bytes_pending != 0);
-		ifs->read_bytes_pending = len + 1;
+		ifs->read_bytes_pending = folio_size(folio);
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
 
-/*
- * This ends IO if no bytes were submitted to an IO helper.
- *
- * Otherwise, this calibrates ifs->read_bytes_pending to represent only the
- * submitted bytes (see comment in iomap_read_init()). If all bytes submitted
- * have already been completed by the IO helper, then this will end the read.
- * Else the IO helper will end the read after all submitted ranges have been
- * read.
- */
-static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
-{
-	struct iomap_folio_state *ifs = folio->private;
-
-	if (ifs) {
-		bool end_read, uptodate;
-
-		spin_lock_irq(&ifs->state_lock);
-		if (!ifs->read_bytes_pending) {
-			WARN_ON_ONCE(bytes_submitted);
-			spin_unlock_irq(&ifs->state_lock);
-			folio_unlock(folio);
-			return;
-		}
-
-		/*
-		 * Subtract any bytes that were initially accounted to
-		 * read_bytes_pending but skipped for IO. The +1 accounts for
-		 * the bias we added in iomap_read_init().
-		 */
-		ifs->read_bytes_pending -=
-			(folio_size(folio) + 1 - bytes_submitted);
-
-		/*
-		 * If !ifs->read_bytes_pending, this means all pending reads by
-		 * the IO helper have already completed, which means we need to
-		 * end the folio read here. If ifs->read_bytes_pending != 0,
-		 * the IO helper will end the folio read.
-		 */
-		end_read = !ifs->read_bytes_pending;
-		if (end_read)
-			uptodate = ifs_is_fully_uptodate(folio, ifs);
-		spin_unlock_irq(&ifs->state_lock);
-		if (end_read)
-			folio_end_read(folio, uptodate);
-	} else if (!bytes_submitted) {
-		/*
-		 * If there were no bytes submitted, this means we are
-		 * responsible for unlocking the folio here, since no IO helper
-		 * has taken ownership of it. If there were bytes submitted,
-		 * then the IO helper will end the read via
-		 * iomap_finish_folio_read().
-		 */
-		folio_unlock(folio);
-	}
-}
-
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
 {
@@ -544,7 +471,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		/* zero post-eof blocks as the page may be mapped */
 		if (iomap_block_needs_zeroing(iter, pos)) {
 			folio_zero_range(folio, poff, plen);
-			iomap_set_range_uptodate(folio, poff, plen);
+			iomap_finish_folio_read(folio, poff, plen, 0);
 		} else {
 			if (!*bytes_submitted)
 				iomap_read_init(folio);
@@ -588,8 +515,6 @@ void iomap_read_folio(const struct iomap_ops *ops,
 
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
-
-	iomap_read_end(folio, bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
@@ -601,7 +526,6 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			iomap_read_end(ctx->cur_folio, *cur_bytes_submitted);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
@@ -653,9 +577,6 @@ void iomap_readahead(const struct iomap_ops *ops,
 
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
-
-	if (ctx->cur_folio)
-		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 

