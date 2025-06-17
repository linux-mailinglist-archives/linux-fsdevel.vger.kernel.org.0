Return-Path: <linux-fsdevel+bounces-51987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520FADDEA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE583BC454
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867D293C66;
	Tue, 17 Jun 2025 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i93m4Xw5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA52F5312;
	Tue, 17 Jun 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198987; cv=none; b=lZUbomSnXURwbTX2Up0T8A2LNBVAhzV4I9x5oAdAbtHFyNOnmkwchl18QtiQ31iwzziXaJxLlBuIxdr9GpTkikbLbbdDMO9LSv2qXuV3DAZmtDYFUoDJBjJ67JP613yHig5s8wSbrS3twcbItTVhuAINpY0tge3i/A4AoC/RBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198987; c=relaxed/simple;
	bh=WrkWEW3mAuaJ30zEB0S29nyuWw1+zGZV3L0tzl25bM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2d02jo45i7qRr+23+jGqc0ryHcUmyNVE+0MxnuTlLyIFTVFBE7pGz0Z5iUakK64AVjoaH/RrfRKOrjLycS7/hWpjlf1z0daiBIFGch3MAtjIJvdSAacA8WOPSa7/PgQnILS8UIrglzkeoG50fbgHOFPgf+NRHBj+0eG7US6lxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i93m4Xw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C79C4CEE3;
	Tue, 17 Jun 2025 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750198986;
	bh=WrkWEW3mAuaJ30zEB0S29nyuWw1+zGZV3L0tzl25bM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i93m4Xw5GvMaXfuuU4fc2ZxGWyYQ7R64XxT66H5nSFY00HpXjYHXPIQ7L5ft7PK2G
	 BxpX0iMwTizxvpxC5qtOO6mHkgspJJ7KVrWecwr2oHfMTmE83lRlPfqrqPfmu/+0xk
	 JHpxWnL7gRMidHekTjYkz7dNFm1F9ijhlYMDzgxq4UAi3RQLjgoFpeHh9CY0ao/dlG
	 NDJTXlGpjDiut4jBVemSou2fGXcSkTerUwyjRfuPCXwRZjWVx80rEJiPebQF/Kjpkf
	 2ZUUtMBNvzmzee9icOsk45mEYN+eIRD4ZVDqDNFLtEJd5B9jm7mcwYubNSf4G1rqw1
	 Et4dqy29zBWzg==
Date: Tue, 17 Jun 2025 18:23:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, david.flynn@hammerspace.com
Subject: [RFC PATCH] lib/iov_iter: remove piecewise bvec length checking in
 iov_iter_aligned_bvec [was: Re: need SUNRPC TCP to receive into aligned
 pages]
Message-ID: <aFHqyU4qO_W1enUT@kernel.org>
References: <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
 <aEvuJP7_xhVk5R4S@kernel.org>
 <aFAOLAOsWngZV_aL@infradead.org>
 <aFBBToft6H-r51TH@kernel.org>
 <aFDw7QTtvJOxEg-o@infradead.org>
 <aFHPgrPM798wXdSG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFHPgrPM798wXdSG@kernel.org>

[Cc'ing Al and Andrew]

On Tue, Jun 17, 2025 at 04:26:42PM -0400, Mike Snitzer wrote:
> On Mon, Jun 16, 2025 at 09:37:01PM -0700, Christoph Hellwig wrote:
> > On Mon, Jun 16, 2025 at 12:07:42PM -0400, Mike Snitzer wrote:
> > > But that's OK... my test bdev is a bad example (archaic VMware vSphere
> > > provided SCSI device): it doesn't reflect expected modern hardware.
> > > 
> > > But I just slapped together a test pmem blockdevice (memory backed,
> > > using memmap=6G!18G) and it too has dma_alignment=511
> > 
> > That's the block layer default when not overriden by the driver, I guess
> > pmem folks didn't care enough.  I suspect it should not have any
> > alignment requirements at all.
> 
> Yeah, I hacked it with this just to quickly simulate NVMe's dma_alignment:
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 210fb77f51ba..0ab2826073f9 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -457,6 +457,7 @@ static int pmem_attach_disk(struct device *dev,
>                 .max_hw_sectors         = UINT_MAX,
>                 .features               = BLK_FEAT_WRITE_CACHE |
>                                           BLK_FEAT_SYNCHRONOUS,
> +               .dma_alignment          = 3,
>         };
>         int nid = dev_to_node(dev), fua;
>         struct resource *res = &nsio->res;
> 
> > > I'd like NFSD to be able to know if its bvec is dma-aligned, before
> > > issuing DIO writes to underlying XFS.  AFAIK I can do that simply by
> > > checking the STATX_DIOALIGN provided dio_mem_align...
> > 
> > Exactly.
> 
> I'm finding that even with dma_alignment=3 the bvec, that
> nfsd_vfs_write()'s call to xdr_buf_to_bvec() produces from NFS's WRITE
> payload, still causes iov_iter_aligned_bvec() to return false.
> 
> The reason is that iov_iter_aligned_bvec() inspects each member of the
> bio_vec in isolation (in its while() loop). So even though NFS WRITE
> payload's overall size is aligned on-disk (e.g. offset=0 len=512K) its
> first and last bvec members are _not_ aligned (due to 512K NFS WRITE
> payload being offset 148 bytes into the first page of the pages
> allocated for it by SUNRPC). So iov_iter_aligned_bvec() fails at this
> check:
> 
>   if (len & len_mask)
>           return false;
> 
> with tracing I added:
> 
>   nfsd-14027   [001] .....  3734.668780: nfsd_vfs_write: iov_iter_aligned_bvec: addr_mask=3 len_mask=511
>   nfsd-14027   [001] .....  3734.668781: nfsd_vfs_write: iov_iter_aligned_bvec: len=3948 & len_mask=511 failed
> 
> Is this another case of the checks being too strict?  The bvec does
> describe a contiguous 512K extent of on-disk LBA, just not if
> inspected piece-wise.
> 
> BTW, XFS's directio code _will_ also check with
> iov_iter_aligned_bvec() via iov_iter_is_aligned().

This works, I just don't know what (if any) breakage it exposes us to:

Author: Mike Snitzer <snitzer@kernel.org>
Date:   Tue Jun 17 22:04:44 2025 +0000
Subject: lib/iov_iter: remove piecewise bvec length checking in iov_iter_aligned_bvec

iov_iter_aligned_bvec() is strictly checking alignment of each element
of the bvec to arrive at whether the bvec is aligned relative to
dma_alignment and on-disk alignment.  Checking each element
individually results in disallowing a bvec that in aggregate is
perfectly aligned relative to the provided @len_mask.

Relax the on-disk alignment checking such that it is done on the full
extent described by the bvec but still do piecewise checking of the
dma_alignment for each bvec's bv_offset.

This allows for NFS's WRITE payload to be issued using O_DIRECT as
long as the bvec created with xdr_buf_to_bvec() is composed of pages
that respect the underlying device's dma_alignment (@addr_mask) and
the overall contiguous on-disk extent is aligned relative to the
logical_block_size (@len_mask).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bdb37d572e97..b2ae482b8a1d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -819,13 +819,14 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
 	unsigned skip = i->iov_offset;
 	size_t size = i->count;
 
+	if (size & len_mask)
+		return false;
+
 	do {
 		size_t len = bvec->bv_len;
 
 		if (len > size)
 			len = size;
-		if (len & len_mask)
-			return false;
 		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
 			return false;
 

