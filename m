Return-Path: <linux-fsdevel+bounces-51164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF09AD3969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F469C1939
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7322D4CE;
	Tue, 10 Jun 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ongsMv7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CB246BD5;
	Tue, 10 Jun 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562047; cv=none; b=RcEA5qgtjul/jf8r5G0BdHAFID9N/jtbU7k+fxS+HHrE2UVAHDZi39odpgeGBFNNJ+EbCctg7O0nCulPxmLkZ5U6e2bwpff5Zp9zjpZAkryKa3KnPc1Av0lUQQPoKWyjqG0RyyEql/lPvNvEoFZJTxc1934WicBpWPO3bxmDXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562047; c=relaxed/simple;
	bh=mAEBjhf5sz3eJQRThKsw3lOatfwC6YVMGNNZ8VmfJNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoWntzTha86xGpqSMziwlZd6MTDLB9CfNfVe+H4I9KQN2UHk+kNiR9J60ZbpLgZKzvYXR5RWo2eTgGCQJ6YxxoLSreD5OJuu79ywc1j43DP36UKSU8nKVi9C2tgc/K5GaLX1yqEfi9hf+Eza/Msu/30J4vZlBQct+JhQQgSPG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ongsMv7a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1yslyToAhHyMWGQmEgeNjb2WvC56oR8gmYoziPmeSxQ=; b=ongsMv7abLR5mOkJbLnfWpI96J
	beBShPZ3SpDZQrh37tEKx5JQ6kqWyi+4iZ3GvTOs+7avgD34/4HvCBUWHBTRELSqMLNVoVfR7h6NV
	44OuAyQn0lds54UYtDiUWWqPW0Lbvge2DO2VCQ+mCc1DVLhtqjV5236CHYphpycQKjy/CSyR5M7gO
	wN/CT0900Oc85BWmLb8rYx7PMtcL7dHBg+WOGoubF/Z0d8mqEdeJH85fGHYiKWIZRZmVSBx4vWTiP
	36u0ByDSeQmecZTb00SY37y+JZCqEMTWVeNVVZgzsowHgQ063su6CLTAg6eE55m/vwS2rTs1jrasM
	WowxZawg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOz0d-00000006xpg-3Dot;
	Tue, 10 Jun 2025 13:27:23 +0000
Date: Tue, 10 Jun 2025 06:27:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <aEgyu86jWSz0Gpia@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
 <aEZm-tocHd4ITwvr@infradead.org>
 <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
 <aEeo7TbyczIILjml@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEeo7TbyczIILjml@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

So I looked into something else, what if we just use ->read_folio
despite it not seeming ideal initially?  After going through with
it I think it's actually less bad than I thought.  This passes
-g auto on xfs with 4k blocks, and has three regression with 1k
blocks, 2 look are the seek hole testers upset that we can't
easily create detectable sub-block holes now, and one because
generic/563 thinks the cgroup accounting is off, probably because
we read more data now or something like that.

---
From c5d3cf651c815d3327199c74eac43149fc958098 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 10 Jun 2025 09:39:57 +0200
Subject: iomap: use ->read_folio instead of iomap_read_folio_sync

iomap_file_buffered_write has it's own private read path for reading
in folios that are only partially overwritten, which not only adds
extra code, but also extra problem when e.g. we want reads to go
through a file system method to support checksums or RAID, or even
support non-block based file systems.

Switch to using ->read_folio instead, which has a few up- and downsides.

->read_folio always reads the entire folios and not just the start and
the tail that is not being overwritten.  Historically this was seen as a
downside as it reads more data than needed.  But with modern file systems
and modern storage devices this is probably a benefit.  If the folio is
stored contiguously on disk, the single read will be more efficient than
two small reads on almost all current hardware. If the folio is backed by
two blocks, at least we pipeline the two reads instead of doing two
synchronous ones.  And if the file system fragmented the folio so badly
that we'll now need to do more than two reads we're still at least
pipelining it, although that should basically never happen with modern
file systems.

->read_folio unlocks the folio on completion.  This adds extract atomics
to the write fast path, but the actual signaling by doing a lock_page
after ->read_folio is not any slower than the completion wakeup.  We
just have to recheck the mapping in this case do lock out truncates
and other mapping manipulations.

->read_folio starts another, nested, iomap iteration, with an extra
lookup of the extent at the current file position.  For in-place update
file systems this is extra work, although if they use a good data
structure like the xfs iext btree there is very little overhead in
another lookup.  For file system that write out of place this actually
implements the desired semantics as they don't care about the existing
data for the write iteration at all, although untangling this and
removing the srcmap member in the iomap_iter will require additional
work to turn the block zeroing and unshare helpers upside down.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 116 ++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 71 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..52b4040208dd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -667,30 +667,34 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
-		size_t poff, size_t plen, const struct iomap *iomap)
+/*
+ * Now that we have a locked folio, check that the iomap we have cached is not
+ * stale before we do anything.
+ *
+ * The extent mapping can change due to concurrent IO in flight, e.g. the
+ * IOMAP_UNWRITTEN state can change and memory reclaim could have reclaimed a
+ * previously partially written page at this index after IO completion before
+ * this write reaches this file offset, and hence we could do the wrong thing
+ * here (zero a page range incorrectly or fail to zero) and corrupt data.
+ */
+static bool iomap_validate(struct iomap_iter *iter)
 {
-	struct bio_vec bvec;
-	struct bio bio;
+	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio_nofail(&bio, folio, plen, poff);
-	return submit_bio_wait(&bio);
+	if (folio_ops && folio_ops->iomap_valid &&
+	    !folio_ops->iomap_valid(iter->inode, &iter->iomap)) {
+		iter->iomap.flags |= IOMAP_F_STALE;
+		return false;
+	}
+
+	return true;
 }
 
-static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
+static int __iomap_write_begin(struct iomap_iter *iter, size_t len,
 		struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct inode *inode = iter->inode;
 	struct iomap_folio_state *ifs;
-	loff_t pos = iter->pos;
-	loff_t block_size = i_blocksize(iter->inode);
-	loff_t block_start = round_down(pos, block_size);
-	loff_t block_end = round_up(pos + len, block_size);
-	unsigned int nr_blocks = i_blocks_per_folio(iter->inode, folio);
-	size_t from = offset_in_folio(folio, pos), to = from + len;
-	size_t poff, plen;
 
 	/*
 	 * If the write or zeroing completely overlaps the current folio, then
@@ -699,45 +703,29 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 	 * For the unshare case, we must read in the ondisk contents because we
 	 * are not changing pagecache contents.
 	 */
-	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
-	    pos + len >= folio_pos(folio) + folio_size(folio))
+	if (!(iter->flags & IOMAP_UNSHARE) &&
+	    iter->pos <= folio_pos(folio) &&
+	    iter->pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;
 
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
+	ifs = ifs_alloc(inode, folio, iter->flags);
+	if ((iter->flags & IOMAP_NOWAIT) && !ifs &&
+	    i_blocks_per_folio(inode, folio) > 1)
 		return -EAGAIN;
 
-	if (folio_test_uptodate(folio))
-		return 0;
-
-	do {
-		iomap_adjust_read_range(iter->inode, folio, &block_start,
-				block_end - block_start, &poff, &plen);
-		if (plen == 0)
-			break;
+	if (!folio_test_uptodate(folio)) {
+		inode->i_mapping->a_ops->read_folio(NULL, folio);
 
-		if (!(iter->flags & IOMAP_UNSHARE) &&
-		    (from <= poff || from >= poff + plen) &&
-		    (to <= poff || to >= poff + plen))
-			continue;
-
-		if (iomap_block_needs_zeroing(iter, block_start)) {
-			if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
-				return -EIO;
-			folio_zero_segments(folio, poff, from, to, poff + plen);
-		} else {
-			int status;
-
-			if (iter->flags & IOMAP_NOWAIT)
-				return -EAGAIN;
-
-			status = iomap_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
-			if (status)
-				return status;
-		}
-		iomap_set_range_uptodate(folio, poff, plen);
-	} while ((block_start += plen) < block_end);
+		/*
+		 * ->read_folio unlocks the folio.  Relock and revalidate the
+		 * folio.
+		 */
+		folio_lock(folio);
+		if (unlikely(folio->mapping != inode->i_mapping))
+			return 1;
+		if (unlikely(!iomap_validate(iter)))
+			return 1;
+	}
 
 	return 0;
 }
@@ -803,7 +791,6 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 		size_t *poffset, u64 *plen)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
@@ -818,28 +805,14 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+lookup_again:
 	folio = __iomap_get_folio(iter, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	/*
-	 * Now we have a locked folio, before we do anything with it we need to
-	 * check that the iomap we have cached is not stale. The inode extent
-	 * mapping can change due to concurrent IO in flight (e.g.
-	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
-	 * reclaimed a previously partially written page at this index after IO
-	 * completion before this write reaches this file offset) and hence we
-	 * could do the wrong thing here (zero a page range incorrectly or fail
-	 * to zero) and corrupt data.
-	 */
-	if (folio_ops && folio_ops->iomap_valid) {
-		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
-							 &iter->iomap);
-		if (!iomap_valid) {
-			iter->iomap.flags |= IOMAP_F_STALE;
-			status = 0;
-			goto out_unlock;
-		}
+	if (unlikely(!iomap_validate(iter))) {
+		status = 0;
+		goto out_unlock;
 	}
 
 	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
@@ -860,7 +833,8 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 
 out_unlock:
 	__iomap_put_folio(iter, 0, folio);
-
+	if (status == 1)
+		goto lookup_again;
 	return status;
 }
 
-- 
2.47.2


