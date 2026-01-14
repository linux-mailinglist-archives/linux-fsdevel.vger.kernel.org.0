Return-Path: <linux-fsdevel+bounces-73782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF623D2045F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F4F30A1A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A573A35D3;
	Wed, 14 Jan 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awpRpTcV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338353A4F22;
	Wed, 14 Jan 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408931; cv=none; b=RZZmJBdHpiuLOrT4EryNHQGbO/YVxBnIuhHjXFMD8ASa3Z4k9PSHrIQuyBMfar/a4W1LsDguEQzbbLXQPcDjTUz1GToonaRz4hvMrumj43BIj9DLZJRTThz8Lp8HLyu0P+hf+eF43pf8zugMYLkm+lWuunTn/BeyKhgiclFetLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408931; c=relaxed/simple;
	bh=mATTOKn2eKI5HKvpWB+zkKmVsKCZDv0Crh2vGDIZFiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRE+xSQDiKwyl7fRkss3oobwPF6xzRKHRH7h1iu7VYym1C3Jg0uHFRDBT3PkhC/ZE/ZkAfXw0CO8U4W5WihBqXJCWUZgmi+A4wjgcYqGX8Vy8SuRlx+o8axybxCf59o3tRlWrpaqfPrONs5+hYR8Isy5v+GNg3rv0sMk08/b844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awpRpTcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD85C4CEF7;
	Wed, 14 Jan 2026 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408930;
	bh=mATTOKn2eKI5HKvpWB+zkKmVsKCZDv0Crh2vGDIZFiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awpRpTcV4Q+c8LQTftDuN3hjufzArGPbogFnX2qR3DX6pe5llGI9jSaJM/q+npt7V
	 rUYD1upRhBloNiX9hhV/WTOf3O19ze+dIGvyqAmd0u8W67lfWPRmM+FzuhdgP9FAP5
	 CqzJ6XTooSBlJOJykahgcZBgSOmcikNjRXOid4tkFKB5rPmpzx66yEkat7AviFzdrP
	 bth8GPH2eIqzCTbVxrg/IdlLGA3n1He38VuAbcE0KEEtp3dfz/IpjFYtGDgM6McIH3
	 bZsie0PC8+o8d7PSRN74EnOspqPxK/wyzw3seULaUXe0MDk8luYp9gW3XjOQ9AaFKC
	 YvVKcZC2hNc9A==
Date: Wed, 14 Jan 2026 08:42:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <20260114164210.GO15583@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
 <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>

On Wed, Jan 14, 2026 at 10:53:00AM +0100, Andrey Albershteyn wrote:
> On 2026-01-14 09:20:34, Andrey Albershteyn wrote:
> > On 2026-01-13 22:15:36, Darrick J. Wong wrote:
> > > On Wed, Jan 14, 2026 at 05:00:47AM +0000, Matthew Wilcox wrote:
> > > > On Tue, Jan 13, 2026 at 07:45:47PM +0100, Andrey Albershteyn wrote:
> > > > > On 2026-01-13 16:36:44, Matthew Wilcox wrote:
> > > > > > On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> > > > > > > The tree is read by iomap into page cache at offset 1 << 53. This is far
> > > > > > > enough to handle any supported file size.
> > > > > > 
> > > > > > What happens on 32-bit systems?  (I presume you mean "offset" as
> > > > > > "index", so this is 1 << 65 bytes on machines with a 4KiB page size)
> > > > > > 
> > > > > it's in bytes, yeah I missed 32-bit systems, I think I will try to
> > > > > convert this offset to something lower on 32-bit in iomap, as
> > > > > Darrick suggested.
> > > > 
> > > > Hm, we use all 32 bits of folio->index on 32-bit plaftorms.  That's
> > > > MAX_LFS_FILESIZE.  Are you proposing reducing that?
> > > > 
> > > > There are some other (performance) penalties to using 1<<53 as the lowest
> > > > index for metadata on 64-bit.  The radix tree is going to go quite high;
> > > > we use 6 bits at each level, so if you have a folio at 0 and a folio at
> > > > 1<<53, you'll have a tree of height 9 and use 17 nodes.
> > > > 
> > > > That's going to be a lot of extra cache misses when walking the XArray
> > > > to find any given folio.  Allowing the filesystem to decide where the
> > > > metadata starts for any given file really is an important optimisation.
> > > > Even if it starts at index 1<<29, you'll almost halve the number of
> > > > nodes needed.
> > 
> > Thanks for this overview!
> > 
> > > 
> > > 1<<53 is only the location of the fsverity metadata in the ondisk
> > > mapping.  For the incore mapping, in theory we could load the fsverity
> > > anywhere in the post-EOF part of the pagecache to save some bits.
> > > 
> > > roundup(i_size_read(), 1<<folio_max_order)) would work, right?
> > 
> > Then, there's probably no benefits to have ondisk mapping differ,
> > no?
> 
> oh, the fixed ondisk offset will help to not break if filesystem
> would be mounted by machine with different page size.

Yeah.  The i(ncore)ext(ent) tree won't have excessive nodes if you pick
a high file offset, so 1<<53 is ok for the ondisk file offset.

--D

> -- 
> - Andrey
> 

