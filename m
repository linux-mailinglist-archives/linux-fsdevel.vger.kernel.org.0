Return-Path: <linux-fsdevel+bounces-17935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADCB8B3F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500351F234FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D816EC0B;
	Fri, 26 Apr 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWYkJ2mN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3616C86A;
	Fri, 26 Apr 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155222; cv=none; b=ZardeBRnl1xEslapxodzOIU5dOmdDNqjNA4+0KaFEam4goY4HjttyVAoILj5iWhNYD9SNpfIDFHtNPK7giiwLUwEwaJih/HZQLCdd1WrPTYPd/Lg5kMlduebDi52BsNrK/Fyl0kSiv9JD1wodZjZSSXbs9eHTw9hWaZEUrU5aNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155222; c=relaxed/simple;
	bh=l1r/lYxpPzPn/HAudEoymODrCp4PmtA86iSl458bsfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brnzIYqqYgjvbOnA4PZ0DwfwtLcngeoVz5iQAlYXisK1Mtmf/0R9Qra3EAuShUzLzl3Pit8lHDSmqVzJBnKxSjeTEWBjIPRq6Uold7Pg0By9JxH1elIHx1OWWm+MPVzmSo6bMx4JVVTLkRd6vYCbgOStKqsDEWvlTkCBIPjOw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RWYkJ2mN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jIW3CriVTfoH1UMfUvTh3PH9I5Jcg8Sj5wlkPjF7+Ds=; b=RWYkJ2mNoX+MCBp1zy0CVqUQxN
	Qx6os4j5Y2tLgleULdEgOY5Jk9hUDPrigGSP9XcLO9kx/vV3K/uX/1wd9ra4xp4kXEr3QgCUOjUk1
	WSImOORLEQhI9msZ78ylfeviDtsWoPMzLM7AntQchyAMPGMRB+LPDDQidfyM12u4QdKghYdd7gwTK
	WGq9fpnguxxS6xMhuPZecadj/uUAAy21vQD4U7iJ8NxNq1WcWZAzpgshQNByt8GWB89Ou7LBp04yC
	CvwgCq0JFHnM5vu79+GyyHM93kW8LhG8PNFfAyj22RXTTwu//ckoWQK0Vxlrw5bl7Inn765JlNGLR
	9y9OZXxg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Q4o-00000005kdx-1Mbm;
	Fri, 26 Apr 2024 18:13:38 +0000
Date: Fri, 26 Apr 2024 19:13:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems
 with indirect mappings
Message-ID: <Zivu0gzb4aiazSNu@casper.infradead.org>
References: <ZivmaVAvnyQ8kKHi@casper.infradead.org>
 <874jboypo2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jboypo2.fsf@gmail.com>

On Fri, Apr 26, 2024 at 11:25:25PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > The approach I suggested was to initialise read_bytes_pending to
> > folio_size() at the start.  Then subtract off blocksize for each
> > uptodate block, whether you find it already uptodate, or as the
> > completion handler runs.
> >
> > Is there a reason that doesn't work?
> 
> That is what this patch series does right. The current patch does work
> as far as my testing goes.
> 
> For e.g. This is what initializes the r_b_p for the first time when
> ifs->r_b_p is 0.
> 
> +		loff_t to_read = min_t(loff_t, iter->len - offset,
> +			folio_size(folio) - offset_in_folio(folio, orig_pos));
> <..>
> +		if (!ifs->read_bytes_pending)
> +			ifs->read_bytes_pending = to_read;
> 
> 
> Then this is where we subtract r_b_p for blocks which are uptodate.
> +		padjust = pos - orig_pos;
> +		ifs->read_bytes_pending -= padjust;
> 
> 
> This is when we adjust r_b_p when we directly zero the folio.
>  	if (iomap_block_needs_zeroing(iter, pos)) {
> +		if (ifs) {
> +			spin_lock_irq(&ifs->state_lock);
> +			ifs->read_bytes_pending -= plen;
> +			if (!ifs->read_bytes_pending)
> +				rbp_finished = true;
> +			spin_unlock_irq(&ifs->state_lock);
> +		}
> 
> But as you see this requires surgery throughout read paths. What if
> we add a state flag to ifs only for BH_BOUNDARY. Maybe that could
> result in a more simplified approach?
> Because all we require is to know whether the folio should be unlocked
> or not at the time of completion. 
> 
> Do you think we should try that part or you think the current approach
> looks ok?

You've really made life hard for yourself.  I had something more like
this in mind.  I may have missed a few places that need to be changed,
but this should update read_bytes_pending everwhere that we set bits
in the uptodate bitmap, so it should be right?

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 41c8f0c68ef5..f87ca8ee4d19 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -79,6 +79,7 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
 		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		ifs->read_bytes_pending -= len;
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
@@ -208,6 +209,8 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 	spin_lock_init(&ifs->state_lock);
 	if (folio_test_uptodate(folio))
 		bitmap_set(ifs->state, 0, nr_blocks);
+	else
+		ifs->read_bytes_pending = folio_size(folio);
 	if (folio_test_dirty(folio))
 		bitmap_set(ifs->state, nr_blocks, nr_blocks);
 	folio_attach_private(folio, ifs);
@@ -396,12 +399,6 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	}
 
 	ctx->cur_folio_in_bio = true;
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
-
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
 	    bio_end_sector(ctx->bio) != sector ||

