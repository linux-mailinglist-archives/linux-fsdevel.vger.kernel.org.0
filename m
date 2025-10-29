Return-Path: <linux-fsdevel+bounces-66186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F07C18959
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD6188E5DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC45830C626;
	Wed, 29 Oct 2025 07:06:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A7309EF2;
	Wed, 29 Oct 2025 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721602; cv=none; b=m3C8yZjXCwcuLyAe1n0LScKLD5AFzJYsZ8Zb+ZJ1gx7FTGezu0x5QZc/PKCH5kzmts/zLAkVAm11cUSrZJE38UtVbWQXLnd6aG4khxQiUsU+wRM/bPNqM6Hlhwrj3/0VWEJAbnAcScmwUl6tPtFMDfoeHkX6rJFZAJ2ynsNR3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721602; c=relaxed/simple;
	bh=9/SnsoO/WS+8t0J3jBEAceX5RkSw9F4ltTtJY/0MQ+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5TiURF1id5XiXPT16lcIMOCaCj2pikmYCoLmVKojA6eAYWKRXGZftOiJqmWOCSYOHZ0T7ZuDjsNglkUOd8JGUOmIr8K+1uNLm6/7+/ybLVQY8CpGab4bqLWBMTEa/IPq+zUhqD8XHz//O0jtO5UHbZBBk61pOThfxFtbous9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D391C227AAC; Wed, 29 Oct 2025 08:06:21 +0100 (CET)
Date: Wed, 29 Oct 2025 08:06:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251029070618.GA29697@lst.de>
References: <20250827141258.63501-1-kbusch@meta.com> <20250827141258.63501-6-kbusch@meta.com> <aP-c5gPjrpsn0vJA@google.com> <aP-hByAKuQ7ycNwM@kbusch-mbp> <aQFIGaA5M4kDrTlw@google.com> <20251028225648.GA1639650@google.com> <20251028230350.GB1639650@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028230350.GB1639650@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I think we need to take a step back and talk about what alignment
we're talking about here, as there are two dimensions to it.

The first dimension is: disk alignment vs memory alignment.

Disk alignment:
  Direct I/O obviously needs to be aligned to on-disk sectors to have
  a chance to work, as that is the lowest possible granularity of access.

  For fіle systems that write out of place we also need to align writes
  to the logical block size of the file system.

  With blk-crypto we need to align to the DUN if it is larger than the
  disk-sector dize.

Memory alignment:

  This is the alignment of the buffer in-memory.  Hardware only really
  cares about this when DMA engines discard the lowest bits, so a typical
  hardware alignment requirement is to only require a dword (4 byte)
  alignment.   For drivers that process the payload in software such
  low alignment have a tendency to cause bugs as they're not written
  thinking about it.  Similarly for any additional processing like
  encryption, parity or checksums.

The second dimension is for the entire operation vs individual vectors,
this has implications both for the disk and memory alignment.  Keith
has done work there recently to relax the alignment of the vectors to
only require the memory alignment, so that preadv/pwritev-like calls
can have lots of unaligned segments.

I think it's the latter that's tripping up here now.  Hard coding these
checks in the file systems seem like a bad idea, we really need to
advertise them in the queue limits, which is complicated by the fact that
we only want to do that for bios using block layer encryption. i.e., we
probably need a separate queue limit that mirrors dma_alignment, but only
for encrypted bios, and which is taken into account in the block layer
splitting and communicated up by file systems only for encrypted bios.
For blk-crypto-fallback we'd need DUN alignment so that the algorithms
just work (assuming the crypto API can't scatter over misaligned
segments), but for hardware blk-crypto I suspect that the normal DMA
engine rules apply, and we don't need to restrict alignment.


