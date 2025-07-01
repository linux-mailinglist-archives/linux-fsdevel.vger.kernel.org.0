Return-Path: <linux-fsdevel+bounces-53409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B63AEEDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD1B188F80D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C322FE0F;
	Tue,  1 Jul 2025 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGs+whJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5572191493;
	Tue,  1 Jul 2025 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348462; cv=none; b=taZwQwhY/B3BKjaFNTJKxn50cwygU/s9YUceiTY55P134AaHQ07AIWCYJ7zFCD4SlhBvFirTiyfsfTSSWcuNSshp4FyxPPDGZF3PWDzamIKAmJITL4s32thMdTbY7mOxgjaEuh8l+O1wPLwwVK7NT0GtDJ3z29kD1SpE/6cp0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348462; c=relaxed/simple;
	bh=UDsiqeD9Rx7beaI8/Y2+5mhKK/YEz8suJYDVh5wpleg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQjNuhZ5+/AtRvXp9uVoovunUhtU5evzqw3KqcPa+bpv7LWNwIRFp/I2ORq6WdKZl+TYEtc3BSFl56IW4Hnkll23H3qcwRTkdySFy4OOMBTxhVA2MM6zDbNsYEEVEjvk0kllwDK9hiAKnbfu+dzXpq0o0IgJRZBYtQXV6tLnkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGs+whJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2F0C4CEEB;
	Tue,  1 Jul 2025 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751348462;
	bh=UDsiqeD9Rx7beaI8/Y2+5mhKK/YEz8suJYDVh5wpleg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGs+whJAJv9u3TGXfbF3ek+G4CspgAar85NzNF2hzg13LSB7qr7Sx1ZRyGI8Bd+bV
	 KpYbTkVKW0RgugdZR7ALw7ATVVx2kgHv7uyWTbF1LzGkrBW2dyDkiq1qp9YkVO6In3
	 9riQBRXi88FCK/DsBxzbBIBWPs7HqzYXT+MldcJvby7tnR7wM2yxqBwtQ/03bKNCxN
	 TTcwx4YO9j1MG7PW16XM96od+XZ/jCwSbIgy0LgkvZGm7X7Bmt3LZSINsls5+VWoz5
	 NQgLfd2rurC+Uk1letQK5rZP6CAhBaSbBV3mFHkE5pOdU3NBj2x+GNYXKl6DVa1ueF
	 adjgbStbzlLGQ==
Date: Mon, 30 Jun 2025 22:41:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <20250701054101.GE10035@frogsfrogsfrogs>
References: <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
 <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org>
 <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org>
 <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
 <aFuWhnjsKqo6ftit@infradead.org>
 <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>

On Wed, Jun 25, 2025 at 09:44:31AM -0700, Joanne Koong wrote:
> On Tue, Jun 24, 2025 at 11:26 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jun 24, 2025 at 10:26:01PM -0700, Joanne Koong wrote:
> > > > The question is whether this is acceptable for all the filesystem
> > > > which implement ->launder_folio today.  Because we could just move the
> > > > folio_test_dirty() to after the folio_lock() and remove all the testing
> > > > of folio dirtiness from individual filesystems.
> > >
> > > Or could the filesystems that implement ->launder_folio (from what I
> > > see, there's only 4: fuse, nfs, btrfs, and orangefs) just move that
> > > logic into their .release_folio implementation? I don't see why not.
> > > In folio_unmap_invalidate(), we call:
> >
> > Without even looking into the details from the iomap POV that basically
> > doesn't matter.  You'd still need the write back a single locked folio
> > interface, which adds API surface, and because it only writes a single
> > folio at a time is rather inefficient.  Not a deal breaker because
> > the current version look ok, but it would still be preferable to not
> > have an extra magic interface for it.
> >
> 
> Yes but as I understand it, the focus right now is on getting rid of
> ->launder_folio as an API. The iomap pov imo is a separate issue with
> determining whether fuse in particular needs to write back the dirty
> page before releasing or should just fail.

This might not help for Joanne's case, but so far the lack of a
launder_folio in my fuse+iomap prototype hasn't hindered it at all.
From what I can tell it's ok to bounce EBUSY back to dio callers...

> btrfs uses ->launder_folio() to free some previously allocated
> reservation (added in commit 872617a "btrfs: implement launder_folio
> for clearing dirty page reserve") so at the very least, that logic
> would need to be moved to .release_folio() (if that suffices? Adding
> the btrfs group to cc). It's still vague to me whether
> fuse/nfs/orangefs need to write back the dirty page, but it seems fine

...but only because a retry will initiate another writeback so
eventually we can make some forward progress.  But it helps a lot that
fuse+iomap is handing the entire IO stack over to iomap.

> to me not to - as I understand it, the worst that can happen (and
> please correct me if I'm wrong here, Matthew) from just failing it
> with -EBUSY is that the folio lingers longer in the page cache until
> it eventually gets written back and cleared out, and that only happens
> if the file is mapped and written to in that window between
> filemap_write_and_wait_range() and unmap_mapping_folio(). afaics, if
> fuse/nfs/orangefs do need to write back the dirty folio instead of
> failing w/ -EBUSY, they could just do that logic in .release_folio.

What do you do in ->release_folio if writeback fails?  Redirty it and
return false?

--D

