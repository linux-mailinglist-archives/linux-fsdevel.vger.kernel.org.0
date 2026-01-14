Return-Path: <linux-fsdevel+bounces-73609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075ED1CA5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3D6530006C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFCC34846E;
	Wed, 14 Jan 2026 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZXDfK9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5202BE64A;
	Wed, 14 Jan 2026 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371337; cv=none; b=JFXk26q4EMCw8sqv+D4oucSVV7+Ky2Styp3YYY6DbxUH7ETMOcK8BGPbzJeoWBrLY0WEYKyQ+My+6fT4uBOalgruZ4xiNd6gMxeGYSF9cA4HSw4Wm0K0hNMVuwRX0ZqYK4plBxE3M0EHLiMHLKL4YbAvj+WQxsutmWrnM421jkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371337; c=relaxed/simple;
	bh=0iqekaHVK+2ijH4G+z+YGDBjBjZbUBYkebJj3HsANBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ognpf+L4Lf1qr0S3giKis8W3K/opKzeyip3Ya6D5l/1ZRmHIXasrVEQJTHymql45eRnJ/y6y5i0OPrya3GcDBHY5e/2zt6Eihl56vb7ohIIH1pJRpvRUHXFkbMeQo4Ws+hsLVDYv3qGiw0h2OVMxnjjmxefKOAMKpHVrAAxlvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZXDfK9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F25FC4CEF7;
	Wed, 14 Jan 2026 06:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768371336;
	bh=0iqekaHVK+2ijH4G+z+YGDBjBjZbUBYkebJj3HsANBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZXDfK9OhJal+gou4WtykyK2lJRuzraSDvdm1/gIN92Xe2Fb1FpyD5gUaRWkfYDFk
	 O02Hq6ncVcbjVdveAaHCBU1cjAJzs40kUzS92nwnLkV8qeubGuxmb5rNA1a7QLMheQ
	 vzEGrgdko2g+pF0l3VoQOTfMkIs7yhLuXiGydLwvd3UTp68EJG/9yFnsnDTlaaXz5r
	 +DQI1cHS5MLdAP2wK3hqUACap3Eebvz7DPnBT+Nq43MvQ6wwtJ6hdbf7ZKhtRMweiC
	 e+13174bE45LAYNggbDJfk+MaR3ciF3Z9nb9UCJbS4STg83ohEO+Hqykbr9TbEGrs8
	 5qnEb0nprjndQ==
Date: Tue, 13 Jan 2026 22:15:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <20260114061536.GG15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWci_1Uu5XndYNkG@casper.infradead.org>

On Wed, Jan 14, 2026 at 05:00:47AM +0000, Matthew Wilcox wrote:
> On Tue, Jan 13, 2026 at 07:45:47PM +0100, Andrey Albershteyn wrote:
> > On 2026-01-13 16:36:44, Matthew Wilcox wrote:
> > > On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> > > > The tree is read by iomap into page cache at offset 1 << 53. This is far
> > > > enough to handle any supported file size.
> > > 
> > > What happens on 32-bit systems?  (I presume you mean "offset" as
> > > "index", so this is 1 << 65 bytes on machines with a 4KiB page size)
> > > 
> > it's in bytes, yeah I missed 32-bit systems, I think I will try to
> > convert this offset to something lower on 32-bit in iomap, as
> > Darrick suggested.
> 
> Hm, we use all 32 bits of folio->index on 32-bit plaftorms.  That's
> MAX_LFS_FILESIZE.  Are you proposing reducing that?
> 
> There are some other (performance) penalties to using 1<<53 as the lowest
> index for metadata on 64-bit.  The radix tree is going to go quite high;
> we use 6 bits at each level, so if you have a folio at 0 and a folio at
> 1<<53, you'll have a tree of height 9 and use 17 nodes.
> 
> That's going to be a lot of extra cache misses when walking the XArray
> to find any given folio.  Allowing the filesystem to decide where the
> metadata starts for any given file really is an important optimisation.
> Even if it starts at index 1<<29, you'll almost halve the number of
> nodes needed.

1<<53 is only the location of the fsverity metadata in the ondisk
mapping.  For the incore mapping, in theory we could load the fsverity
anywhere in the post-EOF part of the pagecache to save some bits.

roundup(i_size_read(), 1<<folio_max_order)) would work, right?

> Adding this ability to support RW merkel trees is certainly coming at
> a cost.  Is it worth it?  I haven't seen a user need for that articulated,
> but I haven't been paying close attention.

I think the pagecache writes of fsverity metadata are only performed
once, while enabling fsverity for a file.

--D

