Return-Path: <linux-fsdevel+bounces-52347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D63AE21F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ADF188ECC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81682E9EDE;
	Fri, 20 Jun 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UB3oUedi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFE21516E;
	Fri, 20 Jun 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443360; cv=none; b=i1hCTa8aLNdN5BkXbr5cdTqpm3TVN6tPBFJk0+mM0xrY2rYGJq68rg+B7qEqRVV2YQfyXmQxJXZkGtjPKuWUsH4CNMEMLP9f9DiiSWQbWOhqhkYlK2XmrXSJZIV/Ai3gNhkBSNJuD8YwjclsqUjdQ9Fh1R1v4YCQ/XtWlFRq+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443360; c=relaxed/simple;
	bh=Tj2hRKWD2fXcMN2LW9yhosMBR01oYLnQsHKHD5f0Xs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skhtoIJkUGQtI2c9Tde4zMlNwHjPKP/zrYZdKzPdmjK9SDpMr66tux2aWe0veeX/Zh2MlJL2imgtW+n3WZYbCX/wDyDn41LBv9Ww1MK3JYQTSgVXQ5jnxKEITNKdCXwV9xLBuRfP8mauxUxYg4/DFFdx27qIdZTSWmxZ7uxXR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UB3oUedi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UlFa8X9SJBeFgiRIm/NRtTllcGke3BNlF+LGXrYDlOk=; b=UB3oUedi3IHkRD0ogkPm/iFMhe
	ynOsf+94Mia5ZGyWgs95OvhaK63zn7h2fGWkCcYw7DdZYpnscuB3FlGCd1VHvX+DtbvqgXb1jwgvU
	mkXMU1TvqRGg/d+Ija/G8p6BXow0QtexTCZ4bXYCZnJY61TmQ73f+bMvSGrFvPpchqyb4TsViMWEo
	58JOxTt57aRkRDuJraIVLOL5Wu2YD3bDHobla5k2u1NS/L/DecSj4jBD+vNYVxFDNPC2uQPe8i7Fn
	50vsg97jVJQ5h8//ku2JGx1rsPVxfQomFM6wuxuWX4n0llgFYMdRTNehun/XWurgKIAjpQq/6UWFB
	mptk47NA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSgHL-0000000DIjQ-0y4d;
	Fri, 20 Jun 2025 18:15:55 +0000
Date: Fri, 20 Jun 2025 19:15:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com, linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <aFWlW6SUI6t-i0dN@casper.infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org>
 <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>

On Wed, Jun 18, 2025 at 08:17:03AM -0400, Jeff Layton wrote:
> On Wed, 2025-06-11 at 05:34 +0100, Matthew Wilcox wrote:
> > On Mon, Jun 09, 2025 at 08:59:53PM -0700, Christoph Hellwig wrote:
> > > On Mon, Jun 09, 2025 at 10:14:44AM -0700, Darrick J. Wong wrote:
> > > > > Where "folio laundering" means calling ->launder_folio, right?
> > > > 
> > > > What does fuse use folio laundering for, anyway?  It looks to me like
> > > > the primary users are invalidate_inode_pages*.  Either the caller cares
> > > > about flushing dirty data and has called filemap_write_and_wait_range;
> > > > or it doesn't and wants to tear down the pagecache ahead of some other
> > > > operation that's going to change the file contents and doesn't care.
> > > > 
> > > > I suppose it could be useful as a last-chance operation on a dirty folio
> > > > that was dirtied after a filemap_write_and_wait_range but before
> > > > invalidate_inode_pages*?  Though for xfs we just return EBUSY and let
> > > > the caller try again (or not).  Is there a subtlety to fuse here that I
> > > > don't know about?
> > > 
> > > My memory might be betraying me, but I think willy once launched an
> > > attempt to see if we can kill launder_folio.  Adding him, and the
> > > mm and nfs lists to check if I have a point :)
> > 
> > I ... got distracted with everything else.
> > 
> > Looking at the original addition of ->launder_page (e3db7691e9f3), I
> > don't understand why we need it.  invalidate_inode_pages2() isn't
> > supposed to invalidate dirty pages, so I don't understand why nfs
> > found it necessary to do writeback from ->releasepage() instead
> > of just returning false like iomap does.
> > 
> > There's now a new question of what the hell btrfs is up to with
> > ->launder_folio, which they just added recently.
> 
> IIRC...
> 
> The problem was a race where a task could could dirty a page in a
> mmap'ed file after it had been written back but before it was unmapped
> from the pagecache.
> 
> Bear in mind that the NFS client may need write back and then
> invalidate the pagecache for a file that is still in use if it
> discovers that the inode's attributes have changed on the server.
> 
> Trond's solution was to write the page out while holding the page lock
> in this situation. I think we'd all welcome a way to avoid this race
> that didn't require launder_folio().

I think the problem is that we've left it up to the filesystem to handle
"what do we do if we've dirtied a page^W folio between, say, calling
filemap_write_and_wait_range() and calling filemap_release_folio()".
Just to make sure we're all on the same page here, this is the sample
path I'm looking at:

__iomap_dio_rw
  kiocb_invalidate_pages
    filemap_invalidate_pages
      filemap_write_and_wait_range
      invalidate_inode_pages2_range
        unmap_mapping_pages
	folio_lock
	folio_wait_writeback
	folio_unmap_invalidate
	  unmap_mapping_folio
	folio_launder
	filemap_release_folio
	if (folio_test_dirty(folio))
	  return -EBUSY;

So some filesystems opt to write back the folio which has been dirtied
(by implementing ->launder_folio) and others opt to fail (and fall back to
buffered I/O when the user has requested direct I/O).  iomap filesystems
all just "return false" for dirty folios, so it's clearly an acceptable
outcome as far as xfstests go.

The question is whether this is acceptable for all the filesystem
which implement ->launder_folio today.  Because we could just move the
folio_test_dirty() to after the folio_lock() and remove all the testing
of folio dirtiness from individual filesystems.

Or have I missed something and picked the wrong sample path for
analysing why we do/don't need to writeback folios in
invalidate_inode_pages2_range()?

