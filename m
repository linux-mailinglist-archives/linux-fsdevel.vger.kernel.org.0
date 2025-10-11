Return-Path: <linux-fsdevel+bounces-63827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A57BBCEDFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 03:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009DD3E1583
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232153AC1C;
	Sat, 11 Oct 2025 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NuwnfwSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459A175A5
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 01:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146526; cv=none; b=OeYLwoBjg7UTzEwlwMzTvVT3r9aZjbT7sf0bZmCCL7A/EtWIC3l3/daCmTk+JpmmRyieP0HJ5tMbKfM6tDiAfr8D5qJ/GTjNGyE15+qPIhR2VmaUaShRvpyChkRhERLlRzhNx2XYy5RSyjMzVBy/BPv6zdHIWOLD9iFZKOXyqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146526; c=relaxed/simple;
	bh=xR0IE0cavrFuHS+sWvEAb/mnV0iT2JipQXIDw9PxCmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beLJLiGSafp4Q/2p7ZlpTcPoTbEAiSCievcPJ9ta3r3m/8s+c5NmzqQ22/TzzLx1kIttGk6IkaOyPW1kGnLDVYR3H6KxE4VANeEGuvTjHRQnZG7OLJUGmkQwCYMEn69zAeHnSTGUrNZXPuZFNzbdnl/OFs5Uwi+V+esd0oOnQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NuwnfwSi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so2515864b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 18:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1760146524; x=1760751324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XvBfLEx++WE1Un1u5T1nsAJnVIwWMs7QzpD2aMmgPU8=;
        b=NuwnfwSior1Z8jfrkAegV7FJKah7cY6lTZlyqFY057aw/K3HK+X+TK4NPPNYQAdGbS
         xQBM+Sq+LK4hMS2GKxmKc4X07PPlRprITGaThcvUhsmiou7eqL52ip9ciBx3W2h3GHy5
         5VC1Ug284Y3yHE7ehfHS+UfODeXb4wPjl4MjD+M6iEU8rlpYjJtm3dYmAGKEFtp+f+mP
         +HJ6qS1rRaDSRArxm6Vo3Cog7DrWm+dUpPefXsYBuEskw+KKAw7esFh6DOHAdDbIeCcn
         ebx8P9VwLU/SU1Qik5ZRjl7p3HYcSwYMpw82tFitsKjHgYG7PNYyy0OPKOh+zjxEoho0
         GSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760146524; x=1760751324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvBfLEx++WE1Un1u5T1nsAJnVIwWMs7QzpD2aMmgPU8=;
        b=GtHC/jALkkOtY2GLv17gEAYx/wxOaJJovHAbSA/H7xjUtzIztdyLC+u4KYCBxVrTbT
         8jHcteWgEgmO1TixKoDP4Q7NMCUAvYe7fBeMJ8w8DEdV86qtIQR0tkAMDSaa4cpMdo3R
         9obHJWoeLyAlxO2lUDzg665WQxfaps29caojVM2OrRDpTrbl+p3B3ZTIUfYSlF9bqh+Q
         cdY0iz/whTgyCjSYSmUXwjbQ6La36xbiRlAnZN6+C8fDliBo9bPu1/VOUYShL4YUUuse
         fMX1p6ClAzFHN0DHIAUOMSQ18fboFrVgFu7h6yC5Aa+eNBzn6Nx9cm2Ou+ICvps081+K
         352g==
X-Forwarded-Encrypted: i=1; AJvYcCW4MVtRk4MWDHB6dlGh63/a13g5cvnj2N4zle7RqjtjzKOUQc64sXhXsY9XvmZ4vFiB3T5ECc1irSM31Jij@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8HKSfOt0XRl/uPh9YUYTipBtC+2cWxuDZ1B2m0hOic88hrnQ
	1JTP6nQUph0uEfI801rMCTueYgxVNIklpoZlrX9FZipynwrV9uEsXwCoaeFWzk86r+I=
X-Gm-Gg: ASbGncu/epvtoVdsMJ7ZNhP4WP+T0bs0eF90cEU4YNKSXceNQpeuMPNWdiB+u5pCCqM
	25HKydmiOhoMwHcZGPk/VCtOB9lyPwUKuI1efQqOxnsCFDBYk9lrhFTa358eYNnIQ0lv087RxiL
	PfEJbXeVRQGCU2gIM2JyamMQFyUlg1HacVPL2GxcTqDarHZ2gFV89XFCTjnoARJpn6AkrtWux4D
	jyTEPmzbYyKYq+dUIEqYi+Bqnnv30MAwunqGsYAx5vgJMz64kF4iI4aF0m0Ngc7qGX/bPrR0Xwk
	vhfXGzIUQrV8YQc4U8bSNIPA7CKGLxfA+PDvjw/UovCzM8oSG40/hlNAvi4IiW4O2y65daq66uY
	0aBnLFKTR4wdJH8Dperkln4ULgoVfovTlSichAFq1EVb/P9I+S0iv0+hRNko/wqlVtVA4QBvdHn
	CnlEAHrh4lGMQkS0UT
X-Google-Smtp-Source: AGHT+IEniEi9MIGgRunuUrN+JFg+dx6vAM1Vi/J7MDf0PCiszN+aXqLXt9e6v1B48WCt7nSz67SjpA==
X-Received: by 2002:a05:6a00:3c8e:b0:781:17fb:d3d0 with SMTP id d2e1a72fcca58-79385ce7d83mr17895097b3a.8.1760146523720;
        Fri, 10 Oct 2025 18:35:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733abdsm4353443b3a.25.2025.10.10.18.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 18:35:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v7OW0-0000000DEDr-1EsT;
	Sat, 11 Oct 2025 12:35:20 +1100
Date: Sat, 11 Oct 2025 12:35:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOm0WCB_woFgnv0v@dread.disaster.area>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
 <aOSgXXzvuq5YDj7q@infradead.org>
 <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
 <aObXUBCtp4p83QzS@dread.disaster.area>
 <CALCETrX-cs5MH3k369q2Fk5Q-pYQfEV6CW3va-4E9vD1CoCaGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrX-cs5MH3k369q2Fk5Q-pYQfEV6CW3va-4E9vD1CoCaGA@mail.gmail.com>

On Wed, Oct 08, 2025 at 02:51:14PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 8, 2025 at 2:27 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 08:22:35AM -0700, Andy Lutomirski wrote:
> > > On Mon, Oct 6, 2025 at 10:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> 
> >
> > You are conflating "synchronous update" with "blocking".
> >
> > Avoiding the need for synchronous timestamp updates is exactly what
> > the lazytime mount option provides. i.e. lazytime degrades immediate
> > consistency requirements to eventual consistency similar to how the
> > default relatime behaviour defers atime updates for eventual
> > writeback.
> >
> > IOWs, we've already largely addressed the synchronous c/mtime update
> > problem but what we haven't done is made timestamp updates
> > fully support non-blocking caller semantics. That's a separate
> > problem...
> 
> I'm probably missing something, but is this really different?

Yes, and yes.

> Either the mtime update can block or it can't block.

Sure, but that's not the issue we have to deal with.

In many filesystems and fs operations, we have to know if an
operation is going to block -before- we start the operation. e.g.
transactional changes cannot be rolled back once we've started the
modification if they need to block to make progress (e.g. read in
on-disk metadata).

This foresight, in many cases, is -unknowable-. Even though the
operation /likely/ won't block, we cannot *guarantee* ahead of time
that any given instance of the operation will /not/ block.  Hence
the reliable non-blocking operation that users are asking for is not
possible with unknowable implementation characteristics like this.

IOWs, a timestamp update implementation can be synchronous and
reliably non-blocking if it always knows when blocking will occur
and can return -EAGAIN instead of blocking to complete the
operation.

If it can't know when/if blocking will occur, then lazytime allows
us to defer the (potentially) blocking update operation to another
context that can block. Queuing for async processing can easily be
made non-blocking, and __mark_inode_dirty(I_DIRTY_TIME) does this
for us.

So, yeah, it should be pretty obvious at this point that non-blocking
implementation is completely independent of whether the operation is
performed synchronously or asynchronously. It's easier to make async
operations non-blocking, but that doesn't mean "non_blocking" and
"asynchronous execution" are interchangable terms or behaviours.

> I haven't dug all the
> way into exactly what happens in __mark_inode_dirty(), but there is a
> lot going on in there even in the I_DIRTY_TIME path.

It's pretty simple, really.  __mark_inode_dirty(I_DIRTY_TIME) is
non-blocking and queues the inode on the wb->i_dirty_time queue
for later processing.

> And Pavel is
> saying that AIO and mtime updates don't play along well.

Again: this is exactly why lazytime was added to XFS *ten years
ago*. From 2015 (issue #3):

https://lore.kernel.org/linux-xfs/CAD-J=zZh1dtJsfrW_Gwxjg+qvkZMu7ED-QOXrMMO6B-G0HY2-A@mail.gmail.com/

(Oh, look, a discussion that starts from a user suggestion of
exposing FMODE_NOCMTIME to userspace apps! Sound familiar?)

> > IOWs, with lazytime, writeback already persists timestamp updates
> > when appropriate for best performance.
> 
> I'm probably doing a bad job explaining myself.

No, I think both Christoph and I both understand exactly what you
are trying to describe.

It seems to me that haven't yet understood that lazytime already
does exactly what you are asking for. Hence you think we don't
understand the "lazytime" concept you are proposing and keep trying
to reinvent lazytime to convince us that we need "lazytime"
functionalitying in the kernel...

> > > Thinking out loud, to handle both write_iter and mmap, there might
> > > need to be two bits: one saying "the timestamp needs to be updated"
> > > and another saying "the timestamp has been updated in the in-memory
> > > inode, but the inode hasn't been dirtied yet".
> >
> > The flag that implements the latter is called I_DIRTY_TIME. We have
> > not implemented the former as that's a userspace visible change of
> > behaviour.
> 
> Maybe that change should be done?  Or not -- it wouldn't be terribly
> hard to have a pair of atomic timestamps in struct inode indicating
> what timestamps we want to write the next time we get around to it.

See, you just reinvented the lazytime mechanism. Again. :/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

