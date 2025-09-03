Return-Path: <linux-fsdevel+bounces-60200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C254BB42A62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF21C21913
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D532E7BD5;
	Wed,  3 Sep 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX63U8aU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E529D0E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929554; cv=none; b=dXUSpRUR4pkHhPMY0pwIXYiMyTrgZE7wJYeTzRqqxytsg6h7b6WpaudmJH04LV07KaPbG5XjAsBeqf03+pSAzux80j9GLNyJYdmFOZZud5LKQcDdekHDQpEYyaT/oLoIu3fq0yGCRUz3VWAKT8iaDn1u1Z070LIBFRcQrKnO3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929554; c=relaxed/simple;
	bh=2z9kS7xFX2YHHT9aFQOsDh2+yGO/NVq4empiwKxtveM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiBoJmQsV4VrZoZ79rmMgCLfDAGQvtJbC9VDGQozFiEpaABAZnTfgxR40D9Qx7TOQwKTtu3ULyT7diikTclY4L/NlYIDmGuJWMQ6LfrgApOprXkqc6j7zlKQwDQgg9AtuVc0bUfiEjK33tNkdk1IRlqcxgjDMkFA5BT2kJGa7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX63U8aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57F9C4CEE7;
	Wed,  3 Sep 2025 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929554;
	bh=2z9kS7xFX2YHHT9aFQOsDh2+yGO/NVq4empiwKxtveM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bX63U8aU7N0uHcqoesYm9ICut+eUMp10p2j2uLfFeXed7mIRBiENbsPMq1xhtchPj
	 AlX+c6OaQSbM8oE8GKksb38cdxmrvny9py6TyZIJCCKX8KOF5v6TEoYVS/PrPSxvkD
	 pXbidS31hWJQkiic7Y1q/1/NUIWSO64NEyHimCz906LOJuQ+tcxbKropQhp+tKdygz
	 oM5yHbr4xuiJg05hB2sjt1kQpcuytA5lEWDSYs0hs09Fvuw+ycB95Tu+rxJxjCgr46
	 Sbl5caqVzm5xWKOnv1sEqtLvfmNn9WFeMwN1c8kvvIsoyGm3EjHCIEPf3E8aTugQtR
	 NfTBF7fvzbzJg==
Date: Wed, 3 Sep 2025 12:59:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	brauner@kernel.org, willy@infradead.org, jack@suse.cz,
	hch@infradead.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 10/12] iomap: refactor dirty bitmap iteration
Message-ID: <20250903195913.GI1587915@frogsfrogsfrogs>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-11-joannelkoong@gmail.com>
 <aLiOrcetNAvjvjtk@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiOrcetNAvjvjtk@bfoster>

On Wed, Sep 03, 2025 at 02:53:33PM -0400, Brian Foster wrote:
> On Fri, Aug 29, 2025 at 04:39:40PM -0700, Joanne Koong wrote:
> > Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
> > iteration. This uses __ffs() internally and is more efficient for
> > finding the next dirty or clean bit than manually iterating through the
> > bitmap range testing every bit.
> > 
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > ---
> >  fs/iomap/buffered-io.c | 67 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 48 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index fd827398afd2..dc1a1f371412 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -75,13 +75,42 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> >  		folio_mark_uptodate(folio);
> >  }
> >  
> > -static inline bool ifs_block_is_dirty(struct folio *folio,
> > -		struct iomap_folio_state *ifs, int block)
> > +/**
> > + * ifs_next_dirty_block - find the next dirty block in the folio
> > + * @folio: The folio
> > + * @start_blk: Block number to begin searching at
> > + * @end_blk: Last block number (inclusive) to search
> > + *
> > + * If no dirty block is found, this will return end_blk + 1.
> > + */
> > +static unsigned ifs_next_dirty_block(struct folio *folio,
> > +		unsigned start_blk, unsigned end_blk)
> >  {
> > +	struct iomap_folio_state *ifs = folio->private;
> >  	struct inode *inode = folio->mapping->host;
> > -	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> > +	unsigned int blks = i_blocks_per_folio(inode, folio);
> > +
> > +	return find_next_bit(ifs->state, blks + end_blk + 1,
> > +		blks + start_blk) - blks;
> > +}
> > +
> > +/**
> > + * ifs_next_clean_block - find the next clean block in the folio
> > + * @folio: The folio
> > + * @start_blk: Block number to begin searching at
> > + * @end_blk: Last block number (inclusive) to search
> > + *
> > + * If no clean block is found, this will return end_blk + 1.
> > + */
> > +static unsigned ifs_next_clean_block(struct folio *folio,
> > +		unsigned start_blk, unsigned end_blk)
> > +{
> > +	struct iomap_folio_state *ifs = folio->private;
> > +	struct inode *inode = folio->mapping->host;
> > +	unsigned int blks = i_blocks_per_folio(inode, folio);
> >  
> > -	return test_bit(block + blks_per_folio, ifs->state);
> > +	return find_next_zero_bit(ifs->state, blks + end_blk + 1,
> > +		blks + start_blk) - blks;
> >  }
> >  
> >  static unsigned ifs_find_dirty_range(struct folio *folio,
> > @@ -92,18 +121,15 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
> >  		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
> >  	unsigned end_blk = min_not_zero(
> >  		offset_in_folio(folio, range_end) >> inode->i_blkbits,
> > -		i_blocks_per_folio(inode, folio));
> > -	unsigned nblks = 1;
> > +		i_blocks_per_folio(inode, folio)) - 1;
> > +	unsigned nblks;
> >  
> > -	while (!ifs_block_is_dirty(folio, ifs, start_blk))
> > -		if (++start_blk == end_blk)
> > -			return 0;
> > +	start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
> > +	if (start_blk > end_blk)
> > +		return 0;
> >  
> > -	while (start_blk + nblks < end_blk) {
> > -		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
> > -			break;
> > -		nblks++;
> > -	}
> > +	nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk)
> > +		- start_blk;
> 
> Not a critical problem since it looks like the helper bumps end_blk, but
> something that stands out to me here as mildly annoying is that we check
> for (start > end) just above, clearly implying that start == end is
> possible, then go and pass start + 1 and end to the next call. It's not
> clear to me if that's worth changing to make end exclusive, but may be
> worth thinking about if you haven't already..

<nod> I was also wondering if there were overflow possibilities here.

> Brian
> 
> >  
> >  	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
> >  	return nblks << inode->i_blkbits;
> > @@ -1077,7 +1103,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
> >  		struct folio *folio, loff_t start_byte, loff_t end_byte,
> >  		struct iomap *iomap, iomap_punch_t punch)
> >  {
> > -	unsigned int first_blk, last_blk, i;
> > +	unsigned int first_blk, last_blk;
> >  	loff_t last_byte;
> >  	u8 blkbits = inode->i_blkbits;
> >  	struct iomap_folio_state *ifs;
> > @@ -1096,10 +1122,13 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
> >  			folio_pos(folio) + folio_size(folio) - 1);
> >  	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
> >  	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> > -	for (i = first_blk; i <= last_blk; i++) {
> > -		if (!ifs_block_is_dirty(folio, ifs, i))
> > -			punch(inode, folio_pos(folio) + (i << blkbits),
> > -				    1 << blkbits, iomap);
> > +	while (first_blk <= last_blk) {
> > +		first_blk = ifs_next_clean_block(folio, first_blk, last_blk);
> > +		if (first_blk > last_blk)
> > +			break;

I was wondering if the loop control logic would be cleaner done as a for
loop and came up with this monstrosity:

	for (first_blk = ifs_next_clean_block(folio, first_blk, last_blk);
	     first_blk <= last_blk;
	     first_blk = ifs_next_clean_block(folio, first_blk + 1, last_blk)) {
		punch(inode, folio_pos(folio) + (first_blk << blkbits),
		      1 << blkbits, iomap);
	}

Yeah.... better living through macros?

#define for_each_clean_block(folio, blk, last_blk) \
	for ((blk) = ifs_next_clean_block((folio), (blk), (last_blk));
	     (blk) <= (last_blk);
	     (blk) = ifs_next_clean_block((folio), (blk) + 1, (last_blk)))

Somewhat cleaner:

	for_each_clean_block(folio, first_blk, last_blk)
		punch(inode, folio_pos(folio) + (first_blk << blkbits),
		      1 << blkbits, iomap);

<shrug>

--D

> > +		punch(inode, folio_pos(folio) + (first_blk << blkbits),
> > +			1 << blkbits, iomap);
> > +		first_blk++;
> >  	}
> >  }
> >  
> > -- 
> > 2.47.3
> > 
> > 
> 
> 

