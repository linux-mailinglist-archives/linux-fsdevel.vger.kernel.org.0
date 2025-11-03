Return-Path: <linux-fsdevel+bounces-66852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBDDC2D9CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 19:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A1D189AF37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1531B130;
	Mon,  3 Nov 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5i2sSiX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540D1E8337;
	Mon,  3 Nov 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193535; cv=none; b=pMpDM5EaPda+CH7svYEx9TXpE9JVdhiKakT0UAcFN2lmxItHgww2Meb1MdXxdl27focrrXCpbex2FY55PAR730PKWYNPEj+WgUK6UUIb/bp0VIUiYqvCE9zND9fvaTqjF1cExYqonpIKvD31EWv1IdOOq1E3NI4D+qR125BMOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193535; c=relaxed/simple;
	bh=M1pVPbRrjLhkDe0zx6OgJARfBzbrof9TSwxA4ZDCYSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXorIM6X/RQSzUkO0iMDd+wg9RNMl/cxKKQ14L2IZ6wphmNL1QiRMrySPK960wY99tFr0R8be/SqQswccS/ANRAvYsZdSFSHCqBmyamy6jVsU2T0mgVHlgILNX0JkK0V/BZIwXfHxcGSZrKbzOGjEYJRf4RtLSQdDanUJUg+27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5i2sSiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20316C4CEE7;
	Mon,  3 Nov 2025 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193532;
	bh=M1pVPbRrjLhkDe0zx6OgJARfBzbrof9TSwxA4ZDCYSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5i2sSiXK4ldRk4Vx+n5en9XmNQ06OkwANTsaof8hwtGQYz+3rBY/V22TGL7IDmdx
	 4+FHfr1/PgYmr0eRJt01MwpV3IVDUbzRcpm4MJPT761OJcifWiuX+RQLKGnaYo9N7T
	 eY1vAwAM9svkD2H68zFcevSFWN2+Enb3ponAR5ujfGjozQ+4ecY9X6TZsofoJ/xnAK
	 us01tk5Di1KrnTQODjXB2CLqB7HNzeGgTZnIpMx5kNu06xvDkrXioGKnXvEXYvP3Hh
	 +IHYKTmYiyMW/OL3ZH7wCxeLyyR1k1gegmfTlpeA4TGh14T+Bjk9VYki4Jvo+QlQcT
	 yuNQ02cCZa8uA==
Date: Mon, 3 Nov 2025 10:10:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Llamas <cmllamas@google.com>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251103181031.GI1735@sol>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
 <aQFIGaA5M4kDrTlw@google.com>
 <20251028225648.GA1639650@google.com>
 <20251028230350.GB1639650@google.com>
 <20251029070618.GA29697@lst.de>
 <20251030174015.GC1624@sol>
 <20251031091820.GA9508@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031091820.GA9508@lst.de>

On Fri, Oct 31, 2025 at 10:18:20AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 30, 2025 at 10:40:15AM -0700, Eric Biggers wrote:
> > Allowing DIO segments to be aligned (in memory address and/or length) to
> > less than crypto_data_unit_size on encrypted files has been attempted
> > and discussed before.  Read the cover letter of
> > https://lore.kernel.org/linux-fscrypt/20220128233940.79464-1-ebiggers@kernel.org/
> 
> Hmm, where does "First, it
> necessarily causes it to be possible that crypto data units span bvecs.
> Splits cannot occur at such locations; however the block layer currently
> assumes that bios can be split at any bvec boundary.? come from?  The
> block layer splits at arbitrary boundaries that don't need any kind of
> bvec alignment.

While splits in general can occur on any logical_block_size boundary,
the last I checked if things are set up properly the splitting is much
better behaved than that in practice.

For example, if max_segment_size is a multiple of logical_block_size
size but not the crypto_data_unit_size being used, then that would of
course cause incorrect splits.  However, that's not an issue if the
driver sets max_segment_size to be a multiple of its largest supported
crypto_data_unit_size.  For example, the UFS driver defaults to
max_segment_size=SZ_256K, which is nicely aligned.

I'm sure there are other examples, related to dm devices,
virt_boundary_mask, and so on.  But the point is that they don't seem to
have been applicable to anyone actually using
crypto_data_unit_size > logical_block_size yet.

In contrast, allowing DIO with memory alignment < crypto_data_unit_size
makes the current code trivially start generating incorrect splits due
to the max_segments based splitting.

I'm not sure the current situation of the block layer not really paying
attention to crypto_data_unit_size is sustainable.  But when someone
looked into making the "only split on crypto_data_unit_size" boundaries
guarantee explicit
(https://lkml.kernel.org/linux-block/20210707052943.3960-1-satyaprateek2357@gmail.com/),
it turned out to be a lot of work.  And no one could find a real-world
example where it actually mattered, besides DIO with memory alignment <
crypto_data_unit_size which didn't seem that useful in the first place.
So that's why we're still in the current situation.

> > We eventually decided to proceed with DIO support without it, since it
> > would have added a lot of complexity.  It would have made the bio
> > splitting code in the block layer split bios at boundaries where the
> > length isn't aligned to crypto_data_unit_size, it would have caused a
> > lot of trouble for blk-crypto-fallback, and it even would have been
> > incompatible with some of the hardware drivers (e.g. ufs-exynos.c).
> 
> Ok, if hardware drivers can't handle it that's a good argument.  I can
> see why handling it in the software case is very annoying, but non-stupid
> hardware should not be affected.  Stupid me assuming UFS might not be
> dead stupid of course.
> 
> > It also didn't seem to be all that useful, and it would have introduced
> > edge cases that don't get tested much.  All reachable to unprivileged
> > userspace code too, of course.
> 
> xfstests just started exercising this and we're getting lots of interesting
> reports (for the non-fscrypt case).

Great to hear that it's starting to be tested.  But it's concerning that
it's just happening now, 3 years after the patches went in, and is also
still finding lots of bugs.  It's hard for me to understand how it was
ready, or even useful, in the first place.

- Eric

