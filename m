Return-Path: <linux-fsdevel+bounces-55461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12220B0AA40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FC7188E2B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BC2E889F;
	Fri, 18 Jul 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9bAVPEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853C2E88A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863892; cv=none; b=LAJQyi7Y7+ym9LQYgS1wigTi3C3K3joIWRj4deT5ZDXMylbEqh7GPPmBzQbZRg/70Ztp+Fmm04t/4sxeFN6oIzZ/2KUsPngoGp/NmTQUE6mDiESXN5J1qu4oJYXBGdwnMorLEsrT1UJyIU0zJuxeYrKSbAAtju2Ol+hOuBY4o4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863892; c=relaxed/simple;
	bh=coS+n58TgN44vl+AefLr+SbcHHZReYNOXxZh3VwZQg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtcfLXLaSAp1DYK9Zn+TljHHLIOX3yXkGtKsqK8WJiga0nQcUzcRWIuL0MBTgnakP43VDOzZP7sZe69mouHwJpeEvkKgyzfynjjQ6TAWmfnSfupVCrcAMQOWk9yLyQYFuncjzlCBmTlS01jtw38CgiSl+QUrabp4F3GabPngnZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9bAVPEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68BC4CEF1;
	Fri, 18 Jul 2025 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752863891;
	bh=coS+n58TgN44vl+AefLr+SbcHHZReYNOXxZh3VwZQg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9bAVPEYv2SCOwvZtsuTL8uoMfA3v4h4Bux6pIJ3/+WJf0zCjROiT1gvxvIwTkfsb
	 QBaJNk3aFdJK3f2S6MELwYdNP9lmSqIwQc5/2xOKILrFDqQtX+Eh0duW4AC3IX6bpN
	 S0ziq2RzmMav+6MhUBch1rwf53lUY3noafM89+OX1Mt53ktJo5kpTlsIGYHnMOIMEV
	 QEU6apCwr05sUxrx5xUrWON4XlL6IaNf3gwqJGvICZVrPci3D4uztO9QE9BnBr0PQd
	 x5D3etILmt/0OyIAPDeDJ3VhWAzkZBcokb191l4IKIUQ3dworh4SDQl2zdbu4hI4zR
	 EUxVOkAXOGorQ==
Date: Fri, 18 Jul 2025 11:38:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	neal@gompa.dev, John@groves.net, miklos@szeredi.hu
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250718183811.GY2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
 <CAJnrk1bvt=tr-87WLRx=KtGUsES09=hhpM=mspsaEezVORVLnQ@mail.gmail.com>
 <6183725a-d3fd-473c-a5a8-52e384e579bd@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6183725a-d3fd-473c-a5a8-52e384e579bd@bsbernd.com>

On Fri, Jul 18, 2025 at 07:57:15PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/18/25 19:50, Joanne Koong wrote:
> > On Fri, Jul 18, 2025 at 9:37 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> >>
> >> On 7/18/25 01:26, Darrick J. Wong wrote:
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> +/*
> >>> + * Flush all pending requests and wait for them.  Only call this function when
> >>> + * it is no longer possible for other threads to add requests.
> >>> + */
> >>> +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
> >>
> >> I wonder if this should have "abort" in its name. Because it is not a
> >> simple flush attempt, but also sets fc->blocked and fc->max_background.

I don't want to abort the connection here, because later I'll use this
same function to flush pending commands before sending a syncfs to the
fuse server and waiting for that as well:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fuse-iomap-attrs&id=d4936bb06a81886de844f089ded85f1461b41e59

The server is still alive and accepting requests, so this what I want is
to push all the FUSE_RELEASE requests to the server so that it will
delete all the "unlinked" open files (aka the .fusehiddenXXXX files) in
the filesystem and wait for that to complete.

> >>> +{
> >>> +     unsigned long deadline;
> >>> +
> >>> +     spin_lock(&fc->lock);
> >>> +     if (!fc->connected) {
> >>> +             spin_unlock(&fc->lock);
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     /* Push all the background requests to the queue. */
> >>> +     spin_lock(&fc->bg_lock);
> >>> +     fc->blocked = 0;
> >>> +     fc->max_background = UINT_MAX;

Yeah, I was a little confused about this -- it looked like these two
lines will push all the pending background commands into the queue and
turn off max_background throttling.  That might not be optimal for
what's otherwise still a live fuse server.

All I need here is for fc->bg_queue to be empty when flush_bg_queue
returns.  I suppose I could wait in a loop, too:

	while (!list_empty(&fc->bg_queue)) {
		flush_bg_queue(fc);
		wait_event_timeout(..., fc->active_background > 0, HZ);
	}

But that's more complicated. ;)

> >>> +     flush_bg_queue(fc);
> >>> +     spin_unlock(&fc->bg_lock);
> >>> +     spin_unlock(&fc->lock);
> >>> +
> >>> +     /*
> >>> +      * Wait 30s for all the events to complete or abort.  Touch the
> >>> +      * watchdog once per second so that we don't trip the hangcheck timer
> >>> +      * while waiting for the fuse server.
> >>> +      */
> >>> +     deadline = jiffies + timeout;
> >>> +     smp_mb();
> >>> +     while (fc->connected &&
> >>> +            (!timeout || time_before(jiffies, deadline)) &&
> >>> +            wait_event_timeout(fc->blocked_waitq,
> >>> +                     !fc->connected || atomic_read(&fc->num_waiting) == 0,
> >>> +                     HZ) == 0)
> >>> +             touch_softlockup_watchdog();
> >>> +}
> >>> +
> >>>  /*
> >>>   * Abort all requests.
> >>>   *
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index 9572bdef49eecc..1734c263da3a77 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -2047,6 +2047,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> >>>  {
> >>>       struct fuse_conn *fc = fm->fc;
> >>>
> >>> +     fuse_flush_requests(fc, 30 * HZ);
> >>
> >> I think fc->connected should be set to 0, to avoid that new requests can
> >> be allocated.
> > 
> > fuse_abort_conn() logic is gated on "if (fc->connected)" so I think
> > fc->connected can only get set to 0 within fuse_abort_conn()

Keep in mind that the function says that it should not be used when
other threads can add new requests.  All current callers are in the
unmount call stack so the only thread that could add a new request is
the current one.

> Hmm yeah, I wonder if we should allow multiple values in there. Like
> fuse_abort_conn sets UINT64_MAX and checks that and other functions
> could set values in between? We could add another variable, but given
> that it is used on every request allocation might be better to avoid too
> many conditions.

<shrug> It /would/ be nifty if fuse requests were associated with an
epoch and one could wait for an epoch to complete.  But for something
that only gets called during unmount I didn't think it was worth the
extra surgery and object bloat.

--D

> 
> 
> Thanks,
> Bernd
> 
> 

