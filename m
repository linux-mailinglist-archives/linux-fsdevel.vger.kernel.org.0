Return-Path: <linux-fsdevel+bounces-50584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EFAACD7DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 08:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36953A4943
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDC1DF258;
	Wed,  4 Jun 2025 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gey8bPVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778D70838;
	Wed,  4 Jun 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749018787; cv=none; b=bgHUS0H0337dzodAfbq3HyW4a1BxzgfO5XJajgt9Yt8t2ZWJSuUq/BDMIiNq5GXOBMzAid/l7UaPgG87YPaGD5rFQv5kRlOEWt5Op29SnplVPTz9+Xsxv0BITzINn9Qkfz8Rq5t7m99Lxl/ydY2jOC/fQoFz9V1cmDyZNCgSmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749018787; c=relaxed/simple;
	bh=TWkbaF+UZP8xXHeAtNtgjG41yHdBhuDPXGIN5tMi4Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzK3l5UTWh5cWgwxB6iNjZjDCzcuVJ198gtbYMPHLuXBlhQJt3twiMi3s/Nys8MDbKEOdjmYw692Lm4zn1AHOf5EcZXetZmQLMH0rvijSvycdrn0+t0FdTDMwp4nzVt89fahDevj1qV5FoQK2tLDZTlQr6QsDmDEpTE2tCCbd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gey8bPVk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=naaTaUQW6+RoDaKAgp6lS22xeYxfdxsoFtZFGw1lY9Q=; b=gey8bPVkk7ZaRXYOWTcO3PL/wY
	f73+B3Azk8XxJDn0xOYigGXY0T0sxkkwK9dkfvl8Bnn6YD/49QCy9miDn6EMYYxYM8DjlDAGSixFq
	32eaeDG3pswVv71m/c1BCjWJaEc/41kxFunXUdcKoreLwY+3untYWzdm8r+54vRLpDxB6emo/0zP4
	1QFq4hwZoAvVhmSy5YjAKk2m7ZE7dk/Z6DGqbdoOn0vAh+GtM2wzpCvgzGRV/zybKpDclC2dkxrrg
	FEg+6I6Z0s934MOIsmTPwcBnl9+qsfzh6X6Vc3qW01501kWI6ICz7Iv7fCDDaGlVOi6uCu0eUvzL4
	KUjSHOlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMhgP-0000000CgKi-0mot;
	Wed, 04 Jun 2025 06:33:05 +0000
Date: Tue, 3 Jun 2025 23:33:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD_oobAbOs7m8PFN@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
 <aD04v9dczhgGxS3K@infradead.org>
 <aD4xboH2mM1ONhB-@dread.disaster.area>
 <aD5-_OOsKyX0rDDO@infradead.org>
 <aD9xj8cwfY9ZmQ2B@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD9xj8cwfY9ZmQ2B@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 04, 2025 at 08:05:03AM +1000, Dave Chinner wrote:
> > 
> > Everything.  ENOSPC means there is no space.  There might be space in
> > the non-determinant future, but if the layer just needs to GC it must
> > not report the error.
> 
> GC of thin pools requires the filesystem to be mounted so fstrim can
> be run to tell the thinp device where all the free LBA regions it
> can reclaim are located. If we shut down the filesystem instantly
> when the pool goes ENOSPC on a metadata write, then *we can't run
> fstrim* to free up unused space and hence allow that metadata write
> to succeed in the future.
> 
> It should be obvious at this point that a filesystem shutdown on an
> ENOSPC error from the block device on anything other than journal IO
> is exactly the wrong thing to be doing.

How high are the chances that you hit exactly the rate metadata
writeback I/O and not journal or data I/O for this odd condition
that requires user interaction?  Where is this weird model where a
storage device returns an out of space error and manual user interaction
using manual and not online trim is going to fix even documented?

> > Normally it means your checksum was wrong.  If you have bit errors
> > in the cable they will show up again, maybe not on the next I/O
> > but soon.
> 
> But it's unlikely to be hit by another cosmic ray anytime soon, and
> so bit errors caused by completely random environmental events
> should -absolutely- be retried as the subsequent write retry will
> succeed.
>
> If there is a dodgy cable causing the problems, the error will
> re-occur on random IOs and we'll emit write errors to the log that
> monitoring software will pick up. If we are repeatedly isssuing write
> errors due to EILSEQ errors, then that's a sign the hardware needs
> replacing.

Umm, all the storage protocols do have pretty good checksums.  A cosmic
ray isn't going to fail them it is something more fundamental like
broken hardware or connections.  In other words you are going to see
this again and again pretty frequently.

> There is no risk to filesystem integrity if write retries
> succeed, and that gives the admin time to schedule downtime to
> replace the dodgy hardware. That's much better behaviour than
> unexpected production system failure in the middle of the night...
> 
> It is because we have robust and resilient error handling in the
> filesystem that the system is able to operate correctly in these
> marginal situations. Operating in marginal conditions or as hardware
> is beginning to fail is a necessary to keep production systems
> running until corrective action can be taken by the administrators.

I'd really like to see a format writeup of your theory of robust error
handling where that robustness is centered around the fairly rare
case of metadata writeback and applications dealing with I/O errors,
while journal write errors and read error lead to shutdown.  Maybe
I'm missing something important, but the theory does not sound valid,
and we don't have any testing framework that actually verifies it.

> Failing to recognise that transient and "maybe-transient" errors can
> generally be handled cleanly and successfully with future write
> retries leads to brittle, fragile systems that fall over at the
> first sign of anything going wrong. Filesystems that are targetted
> at high value production systems and/or running mission critical
> applications needs to have resilient and robust error handling.

What known transient errors do you think XFS (or any other file system)
actually handles properly?  Where is the contract that these errors
actually are transient.

> > And even applications that fsync won't see you fancy error code.  The
> > only thing stored in the address_space for fsync to catch is EIO and
> > ENOSPC.
> 
> The filesystem knows exactly what the IO error reported by the block
> layer is before we run folio completions, so we control exactly what
> we want to report as IO compeltion status.

Sure, you could invent a scheme to propagate the exaxct error.  For
direct I/O we even return the exact error to userspace.  But that
means we actually have a definition of what each error means, and how
it could be handled.  None of that exists right now.  We could do
all this, but that assumes you actually have:

 a) a clear definition of a problem
 b) a good way to fix that problem
 c) good testing infrastructure to actually test it, because without
    that all good intentions will probably cause more problems than
    they solve

> Hence the bogosities of error propagation to userspace via the
> mapping is completely irrelevant to this discussion/feature because
> it would be implemented below the layer that squashes the eventual
> IO errno into the address space...

How would implement and test all this?  And for what use case?


