Return-Path: <linux-fsdevel+bounces-60237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F4B4300B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 04:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5695C7B3262
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6B1F1527;
	Thu,  4 Sep 2025 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxkkfcvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFB78F51
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 02:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954332; cv=none; b=BTxR3vVd3WlVSKRCijBUgIJh45AW6VHkLLPwsai6j1WXhKCQKaYtaReaiOaSJb5uVz69pfmc8Ogi6Uqw92ABaVlP9jw+HPBB4+p8pWgVq81ZTLPUanNyVjQ/4vETyRmMldU2nr8p4j6x3knr9lSzm1xRISezAly6ovGxFOcRLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954332; c=relaxed/simple;
	bh=0i5DJbuZmuI9Lfzk2IUVqKWbuk8qk3AIewdepbN4OQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRUNi74Yz+Kiiho8moWh4ADWjTVpLB6Ck1+h7qI+anfPpxQhVlYxZ5eIUIbYMOfR+N7IwBzZktxr+wgjb+/NG7YjDSfS/vtzY/KdVn2l2holD7l3d+/a2UIooorWiZaEhlT9YH1dylcEkVWUSdjVR+wglokR55cUNViDA16e4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxkkfcvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200EEC4CEE7;
	Thu,  4 Sep 2025 02:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756954331;
	bh=0i5DJbuZmuI9Lfzk2IUVqKWbuk8qk3AIewdepbN4OQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zxkkfcvk+tOhmVcWR5704KzmEJJAw2+QiJdUGDQ0qOTc/Ok3zL8ufJJpxoXJw+wkN
	 ylAbLjmwmdPOtKaTnNRx670rpJSeg9F1UCF4Q5veef5CvOQD1panwvLubGD+5mKbOF
	 8x5/Btpxxs1AFmRFRd6Am8FbwEKGTOh8E1yx8YittKk22VQFZia+1/3pz10YtBJPo7
	 yyfjuDDRDlymAbsQfSnUtbCNxH1b+GGRp1JnPcGlXrWfEY3oqmBmloiwkk07K7TRxq
	 jorh4ovJ7RK0EGwdUKmlf5dRu/PPiHiRsmTV00kE9t51bdtsZa7++LDANmt/adK8UH
	 V5Z9Dg9wATfBQ==
Date: Wed, 3 Sep 2025 19:52:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org,
	brauner@kernel.org, willy@infradead.org, jack@suse.cz,
	hch@infradead.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 12/12] iomap: add granular dirty and writeback
 accounting
Message-ID: <20250904025210.GO8117@frogsfrogsfrogs>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-13-joannelkoong@gmail.com>
 <20250902234604.GC1587915@frogsfrogsfrogs>
 <aLiNYdLaMIslxySo@bfoster>
 <CAJnrk1Z6qKqkOwHJwaBfE9FEGABGD4JKoEwNbRJTpOWL-VtPrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z6qKqkOwHJwaBfE9FEGABGD4JKoEwNbRJTpOWL-VtPrg@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:35:51PM -0700, Joanne Koong wrote:
> On Wed, Sep 3, 2025 at 11:44 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Tue, Sep 02, 2025 at 04:46:04PM -0700, Darrick J. Wong wrote:
> > > On Fri, Aug 29, 2025 at 04:39:42PM -0700, Joanne Koong wrote:
> > > > Add granular dirty and writeback accounting for large folios. These
> > > > stats are used by the mm layer for dirty balancing and throttling.
> > > > Having granular dirty and writeback accounting helps prevent
> > > > over-aggressive balancing and throttling.
> > > >
> > > > There are 4 places in iomap this commit affects:
> > > > a) filemap dirtying, which now calls filemap_dirty_folio_pages()
> > > > b) writeback_iter with setting the wbc->no_stats_accounting bit and
> > > > calling clear_dirty_for_io_stats()
> > > > c) starting writeback, which now calls __folio_start_writeback()
> > > > d) ending writeback, which now calls folio_end_writeback_pages()
> > > >
> > > > This relies on using the ifs->state dirty bitmap to track dirty pages in
> > > > the folio. As such, this can only be utilized on filesystems where the
> > > > block size >= PAGE_SIZE.
> > >
> > > Er... is this statement correct?  I thought that you wanted the granular
> > > dirty page accounting when it's possible that individual sub-pages of a
> > > folio could be dirty.
> > >
> > > If i_blocksize >= PAGE_SIZE, then we'll have set the min folio order and
> > > there will be exactly one (large) folio for a single fsblock.  Writeback
> 
> Oh interesting, this is the part I'm confused about. With i_blocksize
> >= PAGE_SIZE, isn't there still the situation where the folio itself
> could be a lot larger, like 1MB?

Yes, that's quite possible.  IIRC you can get 2MB folios for 8k
fsblocks.

>                                  That's what I've been seeing on fuse
> where "blocksize" == PAGE_SIZE == 4096. I see that xfs sets the min
> folio order through mapping_set_folio_min_order() but I'm not seeing
> how that ensures "there will be exactly one large folio for a single
> fsblock"?

I misspoke -- should have said "there will be no more than one (large)
folio for a single fsblock".  Sorry about the confusion; my old brain is
still stuck in 2015 sometimes.

>           My understanding is that that only ensures the folio is at
> least the size of the fsblock but that the folio size can be larger
> than that too. Am I understanding this incorrectly?

Nope, your understanding is correct. :)

> > > must happen in units of fsblocks, so there's no point in doing the extra
> > > accounting calculations if there's only one fsblock.
> > >
> > > Waitaminute, I think the logic to decide if you're going to use the
> > > granular accounting is:
> > >
> > >       (folio_size > PAGE_SIZE && folio_size > i_blocksize)
> > >
> 
> Yeah, you're right about this - I had used "ifs && i_blocksize >=
> PAGE_SIZE" as the check, which translates to "i_blocks_per_folio > 1
> && i_block_size >= PAGE_SIZE", which in effect does the same thing as
> what you wrote but has the additional (and now I'm realizing,
> unnecessary) stipulation that block_size can't be less than PAGE_SIZE.

Oh!  Yes, that's right, they /are/ equivalent!

> > > Hrm?
> > >
> >
> > I'm also a little confused why this needs to be restricted to blocksize
> > gte PAGE_SIZE. The lower level helpers all seem to be managing block
> > ranges, and then apparently just want to be able to use that directly as
> > a page count (for accounting purposes).
> >
> > Is there any reason the lower level functions couldn't return block
> > units, then the higher level code can use a blocks_per_page or some such
> > to translate that to a base page count..? As Darrick points out I assume
> > you'd want to shortcut the folio_nr_pages() == 1 case to use a min page
> > count of 1, but otherwise ISTM that would allow this to work with
> > configs like 64k pagesize and 4k blocks as well. Am I missing something?
> >
> 
> No, I don't think you're missing anything, it should have been done
> like this in the first place.
> 
> > Brian
> >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  fs/iomap/buffered-io.c | 140 ++++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 132 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 4f021dcaaffe..bf33a5361a39 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -20,6 +20,8 @@ struct iomap_folio_state {
> > > >     spinlock_t              state_lock;
> > > >     unsigned int            read_bytes_pending;
> > > >     atomic_t                write_bytes_pending;
> > > > +   /* number of pages being currently written back */
> > > > +   unsigned                nr_pages_writeback;
> > > >
> > > >     /*
> > > >      * Each block has two bits in this bitmap:
> > > > @@ -139,6 +141,29 @@ static unsigned ifs_next_clean_block(struct folio *folio,
> > > >             blks + start_blk) - blks;
> > > >  }
> > > >
> > > > +static unsigned ifs_count_dirty_pages(struct folio *folio)
> > > > +{
> > > > +   struct inode *inode = folio->mapping->host;
> > > > +   unsigned block_size = i_blocksize(inode);
> > > > +   unsigned start_blk, end_blk;
> > > > +   unsigned blks, nblks = 0;
> > > > +
> > > > +   start_blk = 0;
> > > > +   blks = i_blocks_per_folio(inode, folio);
> > > > +   end_blk = (i_size_read(inode) - 1) >> inode->i_blkbits;
> > > > +   end_blk = min(end_blk, i_blocks_per_folio(inode, folio) - 1);
> > > > +
> > > > +   while (start_blk <= end_blk) {
> > > > +           start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
> > > > +           if (start_blk > end_blk)
> > > > +                   break;
> > >
> > > Use your new helper?
> > >
> > >               nblks = ifs_next_clean_block(folio, start_blk + 1,
> > >                               end_blk) - start_blk?
> > > > +           nblks++;
> > > > +           start_blk++;
> > > > +   }
> > > > +
> > > > +   return nblks * (block_size >> PAGE_SHIFT);
> > >
> > > I think this returns the number of dirty basepages in a given large
> > > folio?  If that's the case then shouldn't this return long, like
> > > folio_nr_pages does?
> > >
> > > > +}
> > > > +
> > > >  static unsigned ifs_find_dirty_range(struct folio *folio,
> > > >             struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
> > > >  {
> > > > @@ -220,6 +245,58 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
> > > >             ifs_set_range_dirty(folio, ifs, off, len);
> > > >  }
> > > >
> > > > +static long iomap_get_range_newly_dirtied(struct folio *folio, loff_t pos,
> > > > +           unsigned len)
> > >
> > > iomap_count_clean_pages() ?
> 
> Nice, a much clearer name.
> 
> I'll make the suggestions you listed above too, thanks for the pointers.
> 
> Thanks for taking a look at this, Darrick and Brian!
> > >
> > > --D
> > >

