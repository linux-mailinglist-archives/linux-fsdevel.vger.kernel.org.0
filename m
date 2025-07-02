Return-Path: <linux-fsdevel+bounces-53718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A1AF61E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715CE4E3027
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49F2E49AF;
	Wed,  2 Jul 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM0ZzfxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22E2BE637;
	Wed,  2 Jul 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482334; cv=none; b=Ry1OHr/FHjJAhnuc14Ex7zeyLmDstYCzNwI1JC/Tv657k9UnqmMjvLOQ+49GmcrvwgL5KCxKRcjUhYZ4R9s0+IkAbbb0H/gRjq8HcgBYAdMbvqmGSOMbYeueU7x3tCmemsUQDrPJJ4wIStwX3fHw7SW6lfGV4Vqk7U1eQYyIGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482334; c=relaxed/simple;
	bh=OHk7XwglHJcDWN72KQjJUAxP0PTjfem32WqdpZA4khw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrVl8fHwmUW/pAlCL1tOPelG2s6E2aDcWwvACJ6ch5vUNbrN+9+MWxKaSxvkzsWwMxvzrCLN/4XRubaiL8xRb4GPRMwwQ1ylpa2YyqB3vQBy4C1GnN5dBFWFXok8vHl0LRaV1QT5LgXoX5Js4Sk3e1ce9xFjgrvFKm15+TqXfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM0ZzfxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45663C4CEE7;
	Wed,  2 Jul 2025 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482334;
	bh=OHk7XwglHJcDWN72KQjJUAxP0PTjfem32WqdpZA4khw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iM0ZzfxT+xq4GpA8fIVxugSeI1LBwGsjeitUjYcIA3//vGtGY55runcEoY+NiyKTy
	 mxyi4kjHC+c7Tfgn2FJPDORAOzvmdpD53Za2drdZPFidSFt4h4roFGhyBVmoA2HEmo
	 wSja+nZwAH0djf2ev2tfvFTvHFemJFVVGQnkoeWLJ+39aYOt6VxB3IcGpUl5Ay5TfA
	 uFWP9Fya+UYH8gBqoZTvxzX1E7luxDgqnCh9ZPOmMJD8eOcppnI4U8liL5K3Xvizfl
	 ieMrUgCf9gIXRBhBLPMqz37iHtde2UPEXO6o+iU7zo7Kv/GExbXDfEJ4fUwMCIIRuD
	 ng+Cf3ERhd2fA==
Date: Wed, 2 Jul 2025 11:52:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: alexjlzheng@tencent.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid unnecessary ifs_set_range_uptodate() with
 locks
Message-ID: <20250702185213.GY10009@frogsfrogsfrogs>
References: <20250701184737.GA9991@frogsfrogsfrogs>
 <20250702120912.36380-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702120912.36380-1-alexjlzheng@tencent.com>

On Wed, Jul 02, 2025 at 08:09:12PM +0800, Jinliang Zheng wrote:
> On Tue, 1 Jul 2025 11:47:37 -0700, djwong@kernel.org wrote:
> > On Tue, Jul 03, 2025 at 10:48:47PM +0800, alexjlzheng@gmail.com wrote:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > In the buffer write path, iomap_set_range_uptodate() is called every
> > > time iomap_end_write() is called. But if folio_test_uptodate() holds, we
> > > know that all blocks in this folio are already in the uptodate state, so
> > > there is no need to go deep into the critical section of state_lock to
> > > execute bitmap_set().
> > > 
> > > Although state_lock may not have significant lock contention due to
> > > folio lock, this patch at least reduces the number of instructions.
> > > 
> > > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 3729391a18f3..fb4519158f3a 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -71,6 +71,9 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
> > >  	unsigned long flags;
> > >  	bool uptodate = true;
> > >  
> > > +	if (folio_test_uptodate(folio))
> > > +		return;
> > 
> > Looks fine, but how exhaustively have you tested this with heavy IO
> > workloads?  I /think/ it's the case that folios always creep towards
> > ifs_is_fully_uptodate() == true state and once they've gotten there
> > never go back.  But folio state bugs are tricky to detect once they've
> > crept in.
> 
> I tested fio, ltp and xfstests combined for about 30 hours. The command
> used for fio test is:
> 
>   fio --name=4k-rw \
>     --filename=/data2/testfile \
>     --size=1G \
>     --bs=4096 \
>     --ioengine=libaio \
>     --iodepth=32 \
>     --rw=randrw \
>     --direct=0 \
>     --buffered=1 \
>     --numjobs=16 \
>     --runtime=60 \
>     --time_based \
>     --group_reporting
> 
> ltp and xfstests showed no noticeable errors caused by this patch.

<nod> I think this fine then...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> thanks,
> Jinliang Zheng. :)
> 
> > 
> > --D
> > 
> > > +
> > >  	if (ifs) {
> > >  		spin_lock_irqsave(&ifs->state_lock, flags);
> > >  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 

