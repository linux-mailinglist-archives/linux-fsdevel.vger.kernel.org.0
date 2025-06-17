Return-Path: <linux-fsdevel+bounces-51976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D2ADDD2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603A217E7CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF524C692;
	Tue, 17 Jun 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INma0VXR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6E25485A;
	Tue, 17 Jun 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192004; cv=none; b=m4iWfzSJ28qjufP2jByYvHFz39dQ9cUcLqAWHSP0+onBWWUknoJkecQCmTAWm25eCCt9+22Vm8bPSZ5j/PFb5rvJO+HT3maDXz7gRMVRXjGxtkjgyBRAOrh3aqaOxhyqWkdbQSgQJavRF6dZy+Tg3Jdvx80j3k2znj6wtjN2rVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192004; c=relaxed/simple;
	bh=L/M5AMey3rWt6uh0U9hxrcBUsoopt3WARfBIv8SZ648=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac3DbXN/paEsE/riREmx5kkwF4FV7qAObAiNbukckq8vLjB81s4/J1n9lfkzl8NONORIkTdAHd6Uhps8bYdOTcmQP+fntl69kmL9A+BZlEyK1VHtVE1+oIBUoZ2H8aut+yLqrYuEenys03G4R1UfJZ3q4IuXwyM2LlRiYN5Kalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INma0VXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC6EC4CEE3;
	Tue, 17 Jun 2025 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750192004;
	bh=L/M5AMey3rWt6uh0U9hxrcBUsoopt3WARfBIv8SZ648=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INma0VXRbEj8pVySjIV/SNDQzuUXgfKK/uJ943iCb9u5iC9mxYASNfItvRk12mXuX
	 lX3t+DG5Nf00DST/Rg+n5YhOVHbL3YhzKC/OxHXrqRmm5jhQ71596geaP6qFfhJDTZ
	 1P7dt/YmxGBc1eqro9GtwXB9cWp0pGDgcccNva/W2l9lKABw5Hy8MLtr6L2U3Dcmgi
	 Hlvc1n/sm5LRmziXuhJUzhUm1n2A2FDymZkUGtF/a2mFsxvXz5h0yttxYcrJzgC2/U
	 EcacCq2sHE/Kbb1BtifW6T6gKVJOlUvbvdj7/+QXhxY7sRzw/nCb27ki41QjPGCTck
	 QT16rVfWUtj/w==
Date: Tue, 17 Jun 2025 16:26:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, david.flynn@hammerspace.com
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aFHPgrPM798wXdSG@kernel.org>
References: <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
 <aEvuJP7_xhVk5R4S@kernel.org>
 <aFAOLAOsWngZV_aL@infradead.org>
 <aFBBToft6H-r51TH@kernel.org>
 <aFDw7QTtvJOxEg-o@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFDw7QTtvJOxEg-o@infradead.org>

On Mon, Jun 16, 2025 at 09:37:01PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 12:07:42PM -0400, Mike Snitzer wrote:
> > But that's OK... my test bdev is a bad example (archaic VMware vSphere
> > provided SCSI device): it doesn't reflect expected modern hardware.
> > 
> > But I just slapped together a test pmem blockdevice (memory backed,
> > using memmap=6G!18G) and it too has dma_alignment=511
> 
> That's the block layer default when not overriden by the driver, I guess
> pmem folks didn't care enough.  I suspect it should not have any
> alignment requirements at all.

Yeah, I hacked it with this just to quickly simulate NVMe's dma_alignment:

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 210fb77f51ba..0ab2826073f9 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -457,6 +457,7 @@ static int pmem_attach_disk(struct device *dev,
                .max_hw_sectors         = UINT_MAX,
                .features               = BLK_FEAT_WRITE_CACHE |
                                          BLK_FEAT_SYNCHRONOUS,
+               .dma_alignment          = 3,
        };
        int nid = dev_to_node(dev), fua;
        struct resource *res = &nsio->res;

> > I'd like NFSD to be able to know if its bvec is dma-aligned, before
> > issuing DIO writes to underlying XFS.  AFAIK I can do that simply by
> > checking the STATX_DIOALIGN provided dio_mem_align...
> 
> Exactly.

I'm finding that even with dma_alignment=3 the bvec, that
nfsd_vfs_write()'s call to xdr_buf_to_bvec() produces from NFS's WRITE
payload, still causes iov_iter_aligned_bvec() to return false.

The reason is that iov_iter_aligned_bvec() inspects each member of the
bio_vec in isolation (in its while() loop). So even though NFS WRITE
payload's overall size is aligned on-disk (e.g. offset=0 len=512K) its
first and last bvec members are _not_ aligned (due to 512K NFS WRITE
payload being offset 148 bytes into the first page of the pages
allocated for it by SUNRPC). So iov_iter_aligned_bvec() fails at this
check:

  if (len & len_mask)
          return false;

with tracing I added:

  nfsd-14027   [001] .....  3734.668780: nfsd_vfs_write: iov_iter_aligned_bvec: addr_mask=3 len_mask=511
  nfsd-14027   [001] .....  3734.668781: nfsd_vfs_write: iov_iter_aligned_bvec: len=3948 & len_mask=511 failed

Is this another case of the checks being too strict?  The bvec does
describe a contiguous 512K extent of on-disk LBA, just not if
inspected piece-wise.

BTW, XFS's directio code _will_ also check with
iov_iter_aligned_bvec() via iov_iter_is_aligned().

Mike

