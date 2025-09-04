Return-Path: <linux-fsdevel+bounces-60298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2757B446FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819721C85BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D9C27B342;
	Thu,  4 Sep 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYRlrQGd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038A27AC5A
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016470; cv=none; b=Ejr5XrpI5KtNkhg3anbXVvlWdNyeGnWPBqoaRKS8CTZNEDh1Tza6tPIPtJTB7R4tItI5AlXGCfYJLXX2bLjA1xV4e0AWSMwW/eY6MmhzlQWrXxDL/7eGcdit2BD2iYQJXD4c+qVpkpF/TY9RMf3KmaEfRNEelVPxq+16UjEln7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016470; c=relaxed/simple;
	bh=fOPZA0KJEUrdKHOHSaA3Ttq41D7TM5+LUPSrZ7CX+Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBIwW770hDc43pKVspRlGhma3jHSEcELZ7AoymeNDTXfIxBNYP+oFKUqXvNga/9Ag1rKvR47bZEtvEMw1NiMzehRbFs4/GeB6zyL0/Nx4RA7rTfJ6ezwXlUakTAhQbM1qxtHHHqKSTLWY+Hu9Mlyhk/1jvVTAoc3MwCJRQgXl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYRlrQGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FEBC4CEF0;
	Thu,  4 Sep 2025 20:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757016470;
	bh=fOPZA0KJEUrdKHOHSaA3Ttq41D7TM5+LUPSrZ7CX+Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYRlrQGdBf96PW3sr0pFdl60HeD3/mo4Xuc/Uo0C5LnQdcJJTUFZhR4BSDxoBl/3V
	 PLL9i/79tqzPBsmceRQyhccFaojQX5rIYqXnjXbKOkPPbkXVPkSsHSxr+aRz4p34gl
	 6g0xpIxx7aGQV3sbl4XycnTeiGX8jP5clgmaUpFZu9KTCpRR46/+hHLA8lYT9Q8XMg
	 2uUro4EPrJtVRXN+ut60EtEpUM6yXyrtF9KLXzN7sARAfICAhYxlMkhOuQJ6mhgpIq
	 rBfHPx1WweyQMOYDgMEwt9+ZNfQAjJ5YS6ZBCF86pygN3pj+a8vRXZa0mwfKgDyvEc
	 9W0MoFl2rEvFA==
Date: Thu, 4 Sep 2025 13:07:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
	brauner@kernel.org, willy@infradead.org, jack@suse.cz,
	hch@infradead.org, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 12/12] iomap: add granular dirty and writeback
 accounting
Message-ID: <20250904200749.GZ1587915@frogsfrogsfrogs>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-13-joannelkoong@gmail.com>
 <20250902234604.GC1587915@frogsfrogsfrogs>
 <aLiNYdLaMIslxySo@bfoster>
 <CAJnrk1Z6qKqkOwHJwaBfE9FEGABGD4JKoEwNbRJTpOWL-VtPrg@mail.gmail.com>
 <aLl8P8Qzn1IDw_7j@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLl8P8Qzn1IDw_7j@bfoster>

On Thu, Sep 04, 2025 at 07:47:11AM -0400, Brian Foster wrote:
> On Wed, Sep 03, 2025 at 05:35:51PM -0700, Joanne Koong wrote:
> > On Wed, Sep 3, 2025 at 11:44 AM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Tue, Sep 02, 2025 at 04:46:04PM -0700, Darrick J. Wong wrote:
> > > > On Fri, Aug 29, 2025 at 04:39:42PM -0700, Joanne Koong wrote:
> > > > > Add granular dirty and writeback accounting for large folios. These
> > > > > stats are used by the mm layer for dirty balancing and throttling.
> > > > > Having granular dirty and writeback accounting helps prevent
> > > > > over-aggressive balancing and throttling.
> > > > >
> > > > > There are 4 places in iomap this commit affects:
> > > > > a) filemap dirtying, which now calls filemap_dirty_folio_pages()
> > > > > b) writeback_iter with setting the wbc->no_stats_accounting bit and
> > > > > calling clear_dirty_for_io_stats()
> > > > > c) starting writeback, which now calls __folio_start_writeback()
> > > > > d) ending writeback, which now calls folio_end_writeback_pages()
> > > > >
> > > > > This relies on using the ifs->state dirty bitmap to track dirty pages in
> > > > > the folio. As such, this can only be utilized on filesystems where the
> > > > > block size >= PAGE_SIZE.
> > > >
> > > > Er... is this statement correct?  I thought that you wanted the granular
> > > > dirty page accounting when it's possible that individual sub-pages of a
> > > > folio could be dirty.
> > > >
> > > > If i_blocksize >= PAGE_SIZE, then we'll have set the min folio order and
> > > > there will be exactly one (large) folio for a single fsblock.  Writeback
> > 
> > Oh interesting, this is the part I'm confused about. With i_blocksize
> > >= PAGE_SIZE, isn't there still the situation where the folio itself
> > could be a lot larger, like 1MB? That's what I've been seeing on fuse
> > where "blocksize" == PAGE_SIZE == 4096. I see that xfs sets the min
> > folio order through mapping_set_folio_min_order() but I'm not seeing
> > how that ensures "there will be exactly one large folio for a single
> > fsblock"? My understanding is that that only ensures the folio is at
> > least the size of the fsblock but that the folio size can be larger
> > than that too. Am I understanding this incorrectly?
> > 
> > > > must happen in units of fsblocks, so there's no point in doing the extra
> > > > accounting calculations if there's only one fsblock.
> > > >
> > > > Waitaminute, I think the logic to decide if you're going to use the
> > > > granular accounting is:
> > > >
> > > >       (folio_size > PAGE_SIZE && folio_size > i_blocksize)
> > > >
> > 
> > Yeah, you're right about this - I had used "ifs && i_blocksize >=
> > PAGE_SIZE" as the check, which translates to "i_blocks_per_folio > 1
> > && i_block_size >= PAGE_SIZE", which in effect does the same thing as
> > what you wrote but has the additional (and now I'm realizing,
> > unnecessary) stipulation that block_size can't be less than PAGE_SIZE.
> > 
> > > > Hrm?
> > > >
> > >
> > > I'm also a little confused why this needs to be restricted to blocksize
> > > gte PAGE_SIZE. The lower level helpers all seem to be managing block
> > > ranges, and then apparently just want to be able to use that directly as
> > > a page count (for accounting purposes).
> > >
> > > Is there any reason the lower level functions couldn't return block
> > > units, then the higher level code can use a blocks_per_page or some such
> > > to translate that to a base page count..? As Darrick points out I assume
> > > you'd want to shortcut the folio_nr_pages() == 1 case to use a min page
> > > count of 1, but otherwise ISTM that would allow this to work with
> > > configs like 64k pagesize and 4k blocks as well. Am I missing something?
> > >
> > 
> > No, I don't think you're missing anything, it should have been done
> > like this in the first place.
> > 
> 
> Ok. Something that came to mind after thinking about this some more is
> whether there is risk for the accounting to get wonky.. For example,
> consider 4k blocks, 64k pages, and then a large folio on top of that. If
> a couple or so blocks are dirtied at one time, you'd presumably want to
> account that as the minimum of 1 dirty page. Then if a couple more
> blocks are dirtied in the same large folio, how do you determine whether
> those blocks are a newly dirtied page or part of the already accounted
> dirty page? I wonder if perhaps this is the value of the no sub-page
> sized blocks restriction, because you can imply that newly dirtied
> blocks means newly dirtied pages..?
> 
> I suppose if that is an issue it might still be manageable. Perhaps we'd
> have to scan the bitmap in blks per page windows and use that to
> determine how many base pages are accounted for at any time. So for
> example, 3 dirty 4k blocks all within the same 64k page size window
> still accounts as 1 dirty page, vs. dirty blocks in multiple page size
> windows might mean multiple dirty pages, etc. That way writeback
> accounting remains consistent with dirty accounting. Hm?

Yes, I think that's correct -- one has to track which basepages /were/
dirty, and then which ones become dirty after updating the ifs dirty
bitmap.

For example, if you have a 1k fsblock filesystem, 4k base pages, and a
64k folio, you could write a single byte at offset 0, then come back and
write to a byte at offset 1024.  The first write will result in a charge
of one basepage, but so will the second, I think.  That results
incharges for two dirty pages, when you've really only dirtied a single
basepage.

Also, does (block_size >> PAGE_SHIFT) evaluate to ... zero?

--D

> Brian
> 
> > > Brian
> > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  fs/iomap/buffered-io.c | 140 ++++++++++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 132 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > > index 4f021dcaaffe..bf33a5361a39 100644
> > > > > --- a/fs/iomap/buffered-io.c
> > > > > +++ b/fs/iomap/buffered-io.c
> > > > > @@ -20,6 +20,8 @@ struct iomap_folio_state {
> > > > >     spinlock_t              state_lock;
> > > > >     unsigned int            read_bytes_pending;
> > > > >     atomic_t                write_bytes_pending;
> > > > > +   /* number of pages being currently written back */
> > > > > +   unsigned                nr_pages_writeback;
> > > > >
> > > > >     /*
> > > > >      * Each block has two bits in this bitmap:
> > > > > @@ -139,6 +141,29 @@ static unsigned ifs_next_clean_block(struct folio *folio,
> > > > >             blks + start_blk) - blks;
> > > > >  }
> > > > >
> > > > > +static unsigned ifs_count_dirty_pages(struct folio *folio)
> > > > > +{
> > > > > +   struct inode *inode = folio->mapping->host;
> > > > > +   unsigned block_size = i_blocksize(inode);
> > > > > +   unsigned start_blk, end_blk;
> > > > > +   unsigned blks, nblks = 0;
> > > > > +
> > > > > +   start_blk = 0;
> > > > > +   blks = i_blocks_per_folio(inode, folio);
> > > > > +   end_blk = (i_size_read(inode) - 1) >> inode->i_blkbits;
> > > > > +   end_blk = min(end_blk, i_blocks_per_folio(inode, folio) - 1);
> > > > > +
> > > > > +   while (start_blk <= end_blk) {
> > > > > +           start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
> > > > > +           if (start_blk > end_blk)
> > > > > +                   break;
> > > >
> > > > Use your new helper?
> > > >
> > > >               nblks = ifs_next_clean_block(folio, start_blk + 1,
> > > >                               end_blk) - start_blk?
> > > > > +           nblks++;
> > > > > +           start_blk++;
> > > > > +   }
> > > > > +
> > > > > +   return nblks * (block_size >> PAGE_SHIFT);
> > > >
> > > > I think this returns the number of dirty basepages in a given large
> > > > folio?  If that's the case then shouldn't this return long, like
> > > > folio_nr_pages does?
> > > >
> > > > > +}
> > > > > +
> > > > >  static unsigned ifs_find_dirty_range(struct folio *folio,
> > > > >             struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
> > > > >  {
> > > > > @@ -220,6 +245,58 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
> > > > >             ifs_set_range_dirty(folio, ifs, off, len);
> > > > >  }
> > > > >
> > > > > +static long iomap_get_range_newly_dirtied(struct folio *folio, loff_t pos,
> > > > > +           unsigned len)
> > > >
> > > > iomap_count_clean_pages() ?
> > 
> > Nice, a much clearer name.
> > 
> > I'll make the suggestions you listed above too, thanks for the pointers.
> > 
> > Thanks for taking a look at this, Darrick and Brian!
> > > >
> > > > --D
> > > >
> > 
> 
> 

