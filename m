Return-Path: <linux-fsdevel+bounces-50704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14622ACE90D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 06:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D16D188F0AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 04:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B31C8612;
	Thu,  5 Jun 2025 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KBhE8Jif"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1223B0;
	Thu,  5 Jun 2025 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749099106; cv=none; b=t0UpCHqF35ujX/2oQOeuAhQ5e1XjiCd9hdwnXHn1R9oppVsQ4jc99z1jfE3mkoF84BMY2SaADYQga+ctybbuIc1weV86M6HxjfUHyVzLpotb8V+KA+8y3skxJ3PaHiNVPfIsYst2w4XyRWe/Gh68gTuFDxYTEz4Bk01Xn9CjeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749099106; c=relaxed/simple;
	bh=RykUuJ93r0Kef6Mm2E2EoC+dQYjCdQfEm5I8wh4arlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIjQxRqp55GSJ1tAw3xPKn849hAmrfpA8IMxoMf9ldl25hExno0HDXq6wttqRb42adjBdrLhh4UUokynmzyrNiT3BWR5rpM+4+XCILWKma8/qzyP5tgDrnI7Oa7heKqdU/489rmp3LestBGFr3U36fHK7GYS5WzVuNufssn+VhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KBhE8Jif; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P/JXocd+tusZUeiyp5UJ6S06Wyv+MHYU/Pbh+wIDk/0=; b=KBhE8JiffKiiD3UCUhZyOe0n1q
	rJV+/I1V8xsV+LKoijrTtAECCGVuUN1ySv4N+5tDwPQlFT+W/b01hLKvxEbIiE7/mqRFh/RdINyH/
	SadvnEsCxnevF0IKO31XhH0j8TvyDVMkyiNMH6V24lsMuna0HAw/wsvHvXjjCxpKhnkr3I19FpvZL
	Kqj7JuCU2xmXRf61PL20kmf/8RiiyhfaXKnyoEpdm5L8UOyr2+AREQzIgm8OxvP/18TeMB3PmlziK
	00S9bzA3q3lwDaaXfuAtfEChoPjZKIplBDkP78Dw2IgLrrmxI6k0YJqM14BQzvb5imNpYHaD5oWYb
	9xDBk9sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2Zn-0000000EjB0-3XkK;
	Thu, 05 Jun 2025 04:51:39 +0000
Date: Wed, 4 Jun 2025 21:51:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aEEiW0pDIjz1kaJg@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
 <aD04v9dczhgGxS3K@infradead.org>
 <aD4xboH2mM1ONhB-@dread.disaster.area>
 <aD5-_OOsKyX0rDDO@infradead.org>
 <aD9xj8cwfY9ZmQ2B@dread.disaster.area>
 <aD_oobAbOs7m8PFN@infradead.org>
 <aED-cKvPKMsDlS0T@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aED-cKvPKMsDlS0T@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 05, 2025 at 12:18:24PM +1000, Dave Chinner wrote:
> > How high are the chances that you hit exactly the rate metadata
> > writeback I/O and not journal or data I/O for this odd condition
> > that requires user interaction?
> 
> 100%.
> 
> We'll hit it with both data IO and metadata IO at the same time,
> but in the vast majority of cases we won't hit ENOSPC on journal IO.
> 
> Why? Because mkfs.xfs zeros the entire log via either
> FALLOC_FL_ZERO_RANGE or writing physical zeros. Hence a thin device
> always has a fully allocated log before the filesystem is first
> mounted and so ENOSPC to journal IO should never happen unless a
> device level snapshot is taken.
> 
> i.e. the only time the journal is not fully allocated in the block device
> is immediately after a block device snapshot is taken. The log needs
> to be written entirely once before it is fully allocated again, and
> this is the only point in time we will see ENOSPC on a thinp device
> for journal IO.

I guess that works for the very specific dm-thin case.  Not for anything
else that does actual out of place writes, though.

> > Where is this weird model where a
> > storage device returns an out of space error and manual user interaction
> > using manual and not online trim is going to fix even documented?
> 
> I explicitly said that the filesystem needs to remain online when
> the thin pool goes ENOSPC so that fstrim (the online filesystem trim
> utility) can be run to inform the thin pool exactly where all the
> free LBA address space is so it can efficiently free up pool space.
> 
> This is a standard procedure that people automate through things
> like udev scripts that capture the dm-thin pool low/no space
> events.
> 
> You seem to be trying to create a strawman here....

I'm not.  But you seem to be very focussed on the undocument and
in general a bit unusual dm-thin semantics.  If that's all you care
about fine, but state that.

> But what causes them is irrelevant - the fact is that they do occur,
> and we cannot know if it transient or persistent from a single IO
> context. Hence the only decision that can be made from IO completion
> context is "retry or fail this IO". We default to "retry" for
> metadata writeback because that automatically handles transient
> errors correctly.
> 
> IOWs, if it is actually broken hardware, then the fact we may retry
> individual failed IOs in a non-critical path is irrelevant. If the
> errors persistent and/or are widespread, then we will get an error
> in a critical path and shut down at that point. 

In general continuing when you have known errors is a bad idea
unless you specifically know retrying makes them better.  When you
are on PI-enabled hardware retrying that PI error (and that's what
we are talking about here) is very unlikely to just make things
better.

> > > It is because we have robust and resilient error handling in the
> > > filesystem that the system is able to operate correctly in these
> > > marginal situations. Operating in marginal conditions or as hardware
> > > is beginning to fail is a necessary to keep production systems
> > > running until corrective action can be taken by the administrators.
> > 
> > I'd really like to see a format writeup of your theory of robust error
> > handling where that robustness is centered around the fairly rare
> > case of metadata writeback and applications dealing with I/O errors,
> > while journal write errors and read error lead to shutdown.
> 
> .... and there's the strawman argument, and a demand for formal
> proofs as the only way to defend against your argument.

No.  You claim that "we have robust and resilient error handling in the
filesystem".  It's pretty clear from the code and the discussion that
we do not.  If you insist that we do I'd rather see a good proof of
that.

> I think you are being intentionally obtuse, Christoph. I wrote this
> for XFS back in *2008*:

Which as you later state yourself is irrelevant to this discussion.

> The point I am making that is that the entire architecture of the
> current V5 on-disk format, the verification architecture and the
> scrub/online repair infrastructure was very much based on the
> storage device model that *IO errors may be transient*.

Except that as we've clearly seen in this thread in practice it
does not.  We have a way to retry the asynchronous metadata writeback,
apparently designed to deal with an undocumented dm-thin use case,
but everything else is handwaiving.

> > What known transient errors do you think XFS (or any other file system)
> > actually handles properly?  Where is the contract that these errors
> > actually are transient.
> 
> Nope, I'm not going to play the "I demand that you prove the
> behaviour that has existed in XFS for over 30 years is correct",
> Christoph.
> 
> If you want to change the underlying IO error handling model that
> XFS has been based on since it was first designed back in the 1990s,
> then it's on you to prove to every filesystem developer that IO
> errors reported from the block layer can *never be transient*.

I'm not changing anything.  I'm just challenging your opinion that
all this has been handled forver.  And it's pretty clear that it
is not.  So I really object to you spreading this untrue claims
without anything top back them up.

Maybe you want to handle transient errors, and that's fine.  But
that aspirational.

> Really, though, I don't know why you think that transient errors
> don't exist anymore, nor why you are demanding that I prove that
> they do when it is abundantly clear that ENOSPC from dm-thin can
> definitely be a transient error.
> 
> Perhaps you can provide some background on why you are asserting
> that there is no such thing as a transient IO error so we can all
> start from a common understanding?

Oh, there absolutely are transient I/O errors.  But in the Linux I/O
stack they are handled in general below the file system.  Look at SCSI
error handling, the NVMe retry mechanisms, or the multipath drivers.  All
of them do handle transient errors in a usually more or less well
understood and well tested fashion.  But except for the retries of
asynchronous metadata buffer writeback in XFS basically nothing in the
commonly used file systems handles transient errors, exactly because that
is not the layering works.  If we want to change that we'd better
understand what the use case for that is and how we properly test it.

