Return-Path: <linux-fsdevel+bounces-66509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B2C21885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CBAD350371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAC036CA85;
	Thu, 30 Oct 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyIRM5Q/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7436CA70;
	Thu, 30 Oct 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846113; cv=none; b=CHo+qE0ZyqWX65Zmgum2HZU+qloFXQEMTq3qot2yJ1dLwygVSlgBc3Qe6vT78jxWXPibu2y4oJx92+edSU5rMsajGkO73AdVpq7B6BMyZAlcLehrro5x2zVvNdlLJYWSUckWHdunfHlU9erdRhLvfLMcdh57G6UAMg00ihED1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846113; c=relaxed/simple;
	bh=XpcDxbobWuhXBAKt4h2GGHNX8CNan4v+jW1nwx/LFX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObtTNxJoS6MreFEDc4QZn5wlpUNuPZlt7/F5Y/Qw2Ii+3N/bbW/zS4mkcbW9dEeQ2HDf8FLSObj/O/4y3S7cZcWuEhF7duScdZ9SJBCUhKhnQOt30R2YTN+3AFdnw4zYIlGNm7gR7/hOKhy30PAK2gZ/+b/J/d88DWilTGq1AC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyIRM5Q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9C9C4CEF8;
	Thu, 30 Oct 2025 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761846113;
	bh=XpcDxbobWuhXBAKt4h2GGHNX8CNan4v+jW1nwx/LFX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyIRM5Q/rSUlJQi6J3yO4pAfO52uSoksNK1uIYJ4sHRlob7L1PL8N+X7/0ttC5B/B
	 +U+BtrMRn8vIfPEmW9O9w3d73nUWR92vyVDgqA2UaA+0ao6hIuz3c4yXkRu3PvHX6v
	 AoE75G0nZLr0utg3hTpXZ1MX/lsdEcr1dPN5SmuJvTAoxZWCy2OB59pZZ85Y12OJRk
	 WiNB5nWgSjo2aoxT+21LJMcAW0n6HlEAACcs9/hFcpm6vwUQQBkeez6qKF2r2UjprS
	 MQ5BkibVZ0t2oqvWGITt75UtO8xuXXJHZHRJnq7AsZo+A8NVBSvH08gl/fhRpQTRS+
	 NlqrPfxi+z6Vg==
Date: Thu, 30 Oct 2025 10:40:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Llamas <cmllamas@google.com>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251030174015.GC1624@sol>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
 <aQFIGaA5M4kDrTlw@google.com>
 <20251028225648.GA1639650@google.com>
 <20251028230350.GB1639650@google.com>
 <20251029070618.GA29697@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029070618.GA29697@lst.de>

On Wed, Oct 29, 2025 at 08:06:18AM +0100, Christoph Hellwig wrote:
> I think we need to take a step back and talk about what alignment
> we're talking about here, as there are two dimensions to it.
> 
> The first dimension is: disk alignment vs memory alignment.
> 
> Disk alignment:
>   Direct I/O obviously needs to be aligned to on-disk sectors to have
>   a chance to work, as that is the lowest possible granularity of access.
> 
>   For fіle systems that write out of place we also need to align writes
>   to the logical block size of the file system.
> 
>   With blk-crypto we need to align to the DUN if it is larger than the
>   disk-sector dize.
> 
> Memory alignment:
> 
>   This is the alignment of the buffer in-memory.  Hardware only really
>   cares about this when DMA engines discard the lowest bits, so a typical
>   hardware alignment requirement is to only require a dword (4 byte)
>   alignment.   For drivers that process the payload in software such
>   low alignment have a tendency to cause bugs as they're not written
>   thinking about it.  Similarly for any additional processing like
>   encryption, parity or checksums.
> 
> The second dimension is for the entire operation vs individual vectors,
> this has implications both for the disk and memory alignment.  Keith
> has done work there recently to relax the alignment of the vectors to
> only require the memory alignment, so that preadv/pwritev-like calls
> can have lots of unaligned segments.
> 
> I think it's the latter that's tripping up here now.  Hard coding these
> checks in the file systems seem like a bad idea, we really need to
> advertise them in the queue limits, which is complicated by the fact that
> we only want to do that for bios using block layer encryption. i.e., we
> probably need a separate queue limit that mirrors dma_alignment, but only
> for encrypted bios, and which is taken into account in the block layer
> splitting and communicated up by file systems only for encrypted bios.
> For blk-crypto-fallback we'd need DUN alignment so that the algorithms
> just work (assuming the crypto API can't scatter over misaligned
> segments), but for hardware blk-crypto I suspect that the normal DMA
> engine rules apply, and we don't need to restrict alignment.

Allowing DIO segments to be aligned (in memory address and/or length) to
less than crypto_data_unit_size on encrypted files has been attempted
and discussed before.  Read the cover letter of
https://lore.kernel.org/linux-fscrypt/20220128233940.79464-1-ebiggers@kernel.org/

We eventually decided to proceed with DIO support without it, since it
would have added a lot of complexity.  It would have made the bio
splitting code in the block layer split bios at boundaries where the
length isn't aligned to crypto_data_unit_size, it would have caused a
lot of trouble for blk-crypto-fallback, and it even would have been
incompatible with some of the hardware drivers (e.g. ufs-exynos.c).

It also didn't seem to be all that useful, and it would have introduced
edge cases that don't get tested much.  All reachable to unprivileged
userspace code too, of course.

I can't say that the idea seems all that great to me.

We can always reconsider and still add support for this.  But it's not
clear to me what's changed.

- Eric

