Return-Path: <linux-fsdevel+bounces-60231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0357B42E23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078C71893C35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 00:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C29190664;
	Thu,  4 Sep 2025 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5Z0SxG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BCE1A23A0
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945389; cv=none; b=oob5mpAqGxmrtB5FfTLI1Vm/hwJPHN+JEIr/U+KoY9ChVG+vvwxczuGBBm0oZ5R2ZJiKhY18k6YcVwwdcyh+b8Zhxea6knJFo+cYy6bnoElDWsQKliRemQGf1MpviCXwFmQJ3O5IZZMuIWL9+1IF5o/MbVzS0+0eWvEKXtLKByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945389; c=relaxed/simple;
	bh=18sl02mjEtYlYtgJb9zz5dSLYy+Ccct/w8yNap/8RKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drGHPuWG58vbd5hhpy1KYraR55auebqFt54BFezLrZEA0Uyxt4wDysM5XjaZxQf8xpp6M8KcuUBjSZ6kigFck6lxolcRYcGADPMeFKUkyG5y6u+0pUEbB295lmSOILJcw3wXme8V13Vpa0MsnQNpVs3mZ2JO5aHAjqfTOfmc3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5Z0SxG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98905C4CEE7;
	Thu,  4 Sep 2025 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756945388;
	bh=18sl02mjEtYlYtgJb9zz5dSLYy+Ccct/w8yNap/8RKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5Z0SxG8jzOJUjtueHNI3EDHMnMKa6blJddV5dKxGKZy5hrjmc3iRaQwsRSf+VYa3
	 vonmOQKplDuFuoZmCz2u4j6N2LvKiwyYYY6mm1IGuWg2II+NUCngIVoPAxNoxDTWJs
	 KyPwiXm0zIkfObHBRov2AVucdmptHKHSXG6qA9WueMAnuvGhftHcn3dcfduCjbw3H2
	 i1Xiz1AaGjt8/aLJkJxwQF2k6UmoChZYbFDnPspfFn4Irm31pPzux7WOjPtWDfY19/
	 dx34ophQ0HR/9qtJZtQHjAyfy7I9boeNGTi6nViNRgSH0Rcg9ihf0kXeBvf+ViM6CC
	 5dXnbD1mVzMXQ==
Date: Wed, 3 Sep 2025 17:23:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bernd@bsbernd.com, neal@gompa.dev,
	John@groves.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
Message-ID: <20250904002307.GX1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
 <20250826185201.GA19809@frogsfrogsfrogs>
 <CAJfpegs-89B2_Y-=+i=E7iSJ38AgGUM2-9mCfeQ9UKA2gYEzxQ@mail.gmail.com>
 <20250903155405.GE1587915@frogsfrogsfrogs>
 <20250903184722.GH1587915@frogsfrogsfrogs>
 <CAJnrk1aUN32CcXyXN_K4r1hOkTHptM5bmwmL2avP+j2sx5bFhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aUN32CcXyXN_K4r1hOkTHptM5bmwmL2avP+j2sx5bFhA@mail.gmail.com>

On Wed, Sep 03, 2025 at 04:05:06PM -0700, Joanne Koong wrote:
> On Wed, Sep 3, 2025 at 11:47 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 08:54:05AM -0700, Darrick J. Wong wrote:
> > > On Wed, Sep 03, 2025 at 05:48:46PM +0200, Miklos Szeredi wrote:
> > > > On Tue, 26 Aug 2025 at 20:52, Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> 
> Sorry for the late reply on this.
> 
> > > > > Hrmm.  I was thinking that it would be very nice to have
> > > > > fuse_request_{send,end} bracket the start and end of a fuse request,
> > > > > even if we kill it immediately.
> 
> Oh interesting, I didn't realize there was a trace_fuse_request_end().
> I get now why you wanted the trace_fuse_request_send() for the
> !fiq->connected case, for symmetry. I was thinking of it from the
> client userspace side (one idea I have, which idk if it is actually
> that useful or not, is building some sort of observability "wireshark
> for fuse" tool that gives more visibility into the requests being sent
> to/from the server like their associated kernel vs libfuse timestamps
> to know where the latency is happening. this issue has come up in prod
> a few times when debugging slow requests); from this perspective, it
> seemed confusing to see requests show up that were never in good faith
> attempted to be sent to the server.

Well at first I was all "Ehhh, why are all the request ids zero??".

Later when I started debugging corruption problems in fuse2fs I realized
that it would be really helpful to be able to match the start and end of
a particular fuse request to all the stuff that happened in between.

*So far* I can mostly just watch the raw ftrace feed to see what's going
on without going crazy, but yes, a wireshark plugin would be nice.  Or
someone writing fuseslow. ;)

> If you want to preserve the symmetry, maybe one idea is only doing the
> trace_fuse_request_end() if the req.in.h.unique code is valid? That
> would skip doing the trace for the !fiq->connected case.

That will actually cause some loss of trace data --
trace_fuse_request_end also captures the error code of the aborted
commands, so you can tell from the -103 error code that something really
bad happened.

--D

> Thanks,
> Joanne
> > > >
> > > > I'm fine with that, and would possibly simplify some code that checks
> > > > for an error and calls ->end manually.  But that makes it a
> > > > non-trivial change unfortunately.
> > >
> > > Yes, and then you have to poke the idr structure for a request id even
> > > if that caller already knows that the connection's dead.  That seems
> > > like a waste of cycles, but OTOH maybe we just don't care?
> > >
> > > (Though I suppose seeing more than one request id of zero in the trace
> > > output implies very strongly that the connection is really dead)
> >
> > Well.... given the fuse_iqueue::reqctr usage, the first request gets a
> > unique id of 2 and increments by two thereafter.  So it's a pretty safe
> > bet that unique==0 means the request isn't actually being sent, or that
> > your very lucky in that your fuse server has been running for a /very/
> > long time.
> >
> > I think I just won't call trace_fuse_request_send for requests that are
> > immediately ended; and I'll refactor the req->in.h.unique assignment
> > into a helper so that virtiofs and friends can call the helper and get
> > the tracepoint automatically.
> >
> > For example, fuse_dev_queue_req now becomes:
> >
> >
> > static inline void fuse_request_assign_unique_locked(struct fuse_iqueue *fiq,
> >                                                      struct fuse_req *req)
> > {
> >         if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
> >                 req->in.h.unique = fuse_get_unique_locked(fiq);
> >
> >         /* tracepoint captures in.h.unique and in.h.len */
> >         trace_fuse_request_send(req);
> > }
> >
> > static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
> > {
> >         spin_lock(&fiq->lock);
> >         if (fiq->connected) {
> >                 fuse_request_assign_unique_locked(fiq, req);
> >                 list_add_tail(&req->list, &fiq->pending);
> >                 fuse_dev_wake_and_unlock(fiq);
> >         } else {
> >                 spin_unlock(&fiq->lock);
> >                 req->out.h.error = -ENOTCONN;
> >                 clear_bit(FR_PENDING, &req->flags);
> >                 fuse_request_end(req);
> >         }
> > }
> >
> > --D
> 

