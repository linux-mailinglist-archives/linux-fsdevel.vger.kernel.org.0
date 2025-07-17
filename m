Return-Path: <linux-fsdevel+bounces-55202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B214B0831E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 04:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473893B2177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 02:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85F1E5215;
	Thu, 17 Jul 2025 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxj0Av8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23910A1E;
	Thu, 17 Jul 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720591; cv=none; b=iDECtfJzvI7iSrGw+4IJfxLBkKA5CzQjRvJlHK6eAKkNb+OMz/IgGrFzwKSBwS1gA6kMHdyu0rYuJ5FJoVBFMXXSsrGcERb/n6Ewr1iZUbrHs3rWIabzY2nZzl/NrP9Zd4QIHiQk2eYWQ8DpuMSEmemL0fbWDfjucvt745yZwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720591; c=relaxed/simple;
	bh=+3M7g91K1wbKWaHCHWCVlTkf6dVFqoCHka6+sKX8uc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLnJIQ5PMD19fz0H99uyTsQbvNpKqDF6SPfki1+oq0LC4e42axUzVxmu7rm9S249rSKaeAuNVFhNZFdNWYPrAzl7hy7HZ53OAlFDryvA3WQR5BSdTVLn1W3fxxjxVszTNpUq14/k80xYY0qH1x/HvqFVqJY6iAIDiMQsByhP7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxj0Av8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1B0C4CEE7;
	Thu, 17 Jul 2025 02:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752720591;
	bh=+3M7g91K1wbKWaHCHWCVlTkf6dVFqoCHka6+sKX8uc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dxj0Av8D5AZtIisXh2L9yJig4uXBQuxbS9ixY/JMlxvl70bIPu8iWlVqGEzCoOgUi
	 +5jU7iXSPRY863B1eVwqkKI4XyGU8N1oiPiSPYP3NlYWjMsCzjY3/zNUSeI4PfvJj0
	 n7GfspSMnUer51mMfjRjFN8s+TltBz1xAqzFf/4SamHGdauI6kCAc8//1mfU95Af06
	 zzmzEaGEDSNSTgcJHuXYUJGBMCRzfTCgpsxnK/GcWE+60f/gZxYXyl9b+IaN0vufU4
	 oIMmh0U1QCuDEp6Cvy24xlk5jGum/YFcnprJ1x7H5mudjZboZP0UCU72iFYOMe7L+u
	 czU/b0esZtW6Q==
Date: Wed, 16 Jul 2025 19:49:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
	linux-cifs@vger.kernel.org
Subject: Re: Compressed files & the page cache
Message-ID: <20250717024903.GA1288@sol>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b9faf9-8efd-4396-b080-e712025825ab@squashfs.org.uk>

On Wed, Jul 16, 2025 at 11:37:28PM +0100, Phillip Lougher wrote:
> > There also seems to be some discrepancy between filesystems whether the
> > decompression involves vmap() of all the memory allocated or whether the
> > decompression routines can handle doing kmap_local() on individual pages.
> > 
> 
> Squashfs does both, and this depends on whether the decompression
> algorithm implementation in the kernel is multi-shot or single-shot.
> 
> The zlib/xz/zstd decompressors are multi-shot, in that you can call them
> multiply, giving them an extra input or output buffer when it runs out.
> This means you can get them to output into a 4K page at a time, without
> requiring the pages to be contiguous.  kmap_local() can be called on each
> page before passing it to the decompressor.

While those compression libraries do provide streaming APIs, it's sort
of an illusion.  They still need the uncompressed data in a virtually
contiguous buffer for the LZ77 match finding and copying to work.  So,
internally they copy the uncompressed data into a virtually contiguous
buffer.  I suspect that vmap() (or vm_map_ram() which is what f2fs uses)
is actually more efficient than these streaming APIs, since it avoids
the internal copy.  But it would need to be measured.

> > So, my proposal is that filesystems tell the page cache that their minimum
> > folio size is the compression block size.  That seems to be around 64k,
> > so not an unreasonable minimum allocation size.  That removes all the
> > extra code in filesystems to allocate extra memory in the page cache.
> > It means we don't attempt to track dirtiness at a sub-folio granularity
> > (there's no point, we have to write back the entire compressed bock
> > at once).  We also get a single virtually contiguous block ... if you're
> > willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> > vmap_file() which would give us a virtually contiguous chunk of memory
> > (and could be trivially turned into a noop for the case of trying to
> > vmap a single large folio).

... but of course, if we could get a virtually contiguous buffer
"for free" (at least in the !HIGHMEM case) as in the above proposal,
that would clearly be the best option.

- Eric

