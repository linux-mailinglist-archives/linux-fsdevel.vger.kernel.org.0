Return-Path: <linux-fsdevel+bounces-21448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1858A904029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925D4B24456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A42037703;
	Tue, 11 Jun 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OtagDBwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1A36AEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120170; cv=none; b=KncvF//I0Gkq36XBDmiu4NFBQ22NW6jkcubvHBh15RXjjKEuOuwrpceSjl8IgD7IwGt2myBXhhHj6Vf4dNa3zxk5VgXDLZOWAapHh2NdZqGuX/Xp2lXuVoTmz9zkHFidCWtUSC64/xPwSq4LzaoIxyXGnhVjG/AQM/LU5n3/4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120170; c=relaxed/simple;
	bh=EIADMxsc3rPY8TWWHBgUUD6nMZDwHqaZP4v3YvNTRFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+X5pTjucMiggcOgT1wIvAlbe+6EFW+Mo0KwveRtQi6CuFCOVHYZF672K9l+Nr5z30fXNp4t/9DgrYTGej54HZDHkd6OpyMIj6MEfFY8iZpCDRjM1c1v4C4n1vbl8Qe1CBPjY/uhR1KsW57jNVtEOwik14bs5NZBmstwWm3YwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OtagDBwj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso8615952a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1718120165; x=1718724965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc/3QUqnxjIbyyAKiubAuR220tR52KxQOglOLUUqVsc=;
        b=OtagDBwj6hncDoUhIQgj5R3CG0r7oXpnnNM85NrLiRy229uvRfDpHEDpgeCi2svF6i
         EmnM+mK/jJ6oMhL8mwYENc5zFhC3Y9s5fOfHdJ20MAqqgXuWqypsj1x3kMvUXiwIwsCG
         gSXyLkMx2vk3rMU77ZFBOCMVzOfaqMmTuIZRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718120165; x=1718724965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vc/3QUqnxjIbyyAKiubAuR220tR52KxQOglOLUUqVsc=;
        b=IWskpkamf5Y8P8cKtvlbjznV+P9JyG96D4//A6608GYHzlEm6fU+beHH4Jnf5mPLY1
         wCgqttAD/cpJhJYIQKO7rC5h5Xojykjgks2KWzz2pYjv5FCgdBxGyZYD1jY2w+vmf0Ks
         +Y1paBOZE3/FWaWw9wjC8wy/wwTtShHsfZjh95LLeZmtxVx3GTXc2QH3Hi6dGrDbPRiw
         Fi7308cUwCrIGlImwNpTCVCNTSJdPPfGwtjoxe0vKXOCFvwbq1Ac2OwVvv5Pqqdo69g9
         50uOMMcUlH5rSxKsoEaVdKhQO2vilMKtRfToBCOxshhv2EJed0e4eksEdyAbP57e2Pxy
         PCHA==
X-Forwarded-Encrypted: i=1; AJvYcCWkF0wgVE8103TGdAhWeGbrRGCQFgeDvQSnDAq6J+u8kmYdakAZdj3Ahrhhpb7hKG++XelJzPjNHv3to9Nb/MEtyx96Na4jBJKHe659dA==
X-Gm-Message-State: AOJu0Yya6KpavAmKSj2Xa4oI83vbZ2LA/J+ubkRvOh1C5yqwfug+koPe
	wZOWA8GJuw49gxKFjvrPwhFvbnAT67/yaZNb2glHoQelyy4sV0nqw032kIAwy/1bNW46HYIPSBN
	KGAV3DqbJ3aawj7N1mOXBtzkKa0KFnFPH0JnSpwrTeq20ezXS
X-Google-Smtp-Source: AGHT+IFuvJbrw2jgwLuM8EVMpy8kzs37p0ALf48H7ZqrE0VKr+amw2Sto0lBWNebVsryjGrRBtm4wrjHNeQO6Vx12UU=
X-Received: by 2002:a17:906:ae93:b0:a6f:e79:2127 with SMTP id
 a640c23a62f3a-a6f0e79217amr524371766b.65.1718120164828; Tue, 11 Jun 2024
 08:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <CAJfpegurSNV3Tw1oKWL1DgnR-tST-JxSAxvTuK2jirm+L-odeQ@mail.gmail.com> <99d13ae4-8250-4308-b86d-14abd1de2867@fastmail.fm>
In-Reply-To: <99d13ae4-8250-4308-b86d-14abd1de2867@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jun 2024 17:35:52 +0200
Message-ID: <CAJfpegu7VwDEBsUG_ERLsN58msXUC14jcxRT_FqL53xm8FKcdg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 12:26, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> Secondly, with IORING_OP_URING_CMD we already have only a single command
> to submit requests and fetch the next one - half of the system calls.
>
> Wouldn't IORING_OP_READV/IORING_OP_WRITEV be just this approach?
> https://github.com/uroni/fuseuring?
> I.e. it hook into the existing fuse and just changes from read()/write()
> of /dev/fuse to io-uring of /dev/fuse. With the disadvantage of zero
> control which ring/queue and which ring-entry handles the request.

Unlike system calls, io_uring ops should have very little overhead.
That's one of the main selling points of io_uring (as described in the
io_uring(7) man page).

So I don't think it matters to performance whether there's a combined
WRITEV + READV (or COMMIT + FETCH) op or separate ops.

The advantage of separate ops is more flexibility and less complexity
(do only one thing in an op).

> Thirdly, initially I had even removed the allocation of 'struct
> fuse_req' and directly allocated these on available ring entries. I.e.
> the application thread was writing to the mmap ring buffer. I just
> removed that code for now, as it introduced additional complexity with
> an unknown performance outcome. If it should be helpful we could add
> that later. I don't think we have that flexibility with
> IORING_OP_READV/IORING_OP_WRITEV.

I think I understand what you'd like to see in the end: basically a
reverse io_uring, where requests are placed on a "submission queue" by
the kernel and completed requests are placed on a completion queue by
the userspace.  Exactly the opposite of current io_uring.

The major difference between your idea of a fuse_uring and the
io_uring seems to be that you place not only the request on the shared
buffer, but the data as well.   I don't think this is a good idea,
since it will often incur one more memory copy.  Otherwise the idea
itself seems sound.

The implementation twisted due to having to integrate it with
io_uring.  Unfortunately placing fuse requests directly into the
io_uring queue doesn't work, due to the reversal of roles and the size
difference between sqe and cqe entries.  Also the shared buffer seems
to lose its ring aspect due to the fact that fuse doesn't get notified
when a request is taken off the queue (io_uring_cqe_seen(3)).

So I think either better integration with io_uring is needed with
support for "reverse submission" or a new interface.

> >
> > Maybe there's an advantage in using an atomic op for WRITEV + READV,
> > but I'm not quite seeing it yet, since there's no syscall overhead for
> > separate ops.
>
> Here I get confused, could please explain?
> Current fuse has a read + write operation - a read() system call to
> process a fuse request and a write() call to submit the result and then
> read() to fetch the next request.
> If userspace has to send IORING_OP_READV to fetch a request and complete
> with IORING_OP_IORING_OP_WRITEV it would go through existing code path
> with operations? Well, maybe userspace could submit with IOSQE_IO_LINK,
> but that sounds like it would need to send two ring entries? I.e. memory
> and processing overhead?

Overhead should be minimal.

> And then, no way to further optimize and do fuse_req allocation on the
> ring (if there are free entries). And probably also no way that we ever
> let the application work in the SQPOLL way, because the application
> thread does not have the right to read from the fuse-server buffer? I.e.
> what I mean is that IORING_OP_URING_CMD gives a better flexibility.

There should be no difference between IORING_OP_URING_CMD and
IORING_OP_WRITEV +  IORING_OP_READV in this respect.  At least I don't
see why polling would work differently: the writev should complete
immediately and then the readv is queued.  Same as what effectively
happens with IORING_OP_URING_CMD, no?

> Btw, another issue that is avoided with the new ring-request layout is
> compatibility and alignment. The fuse header is always in a 4K section
> of the request data follow then. I.e. extending request sizes does not
> impose compatibility issues any more and also for passthrough and
> similar - O_DIRECT can be passed through to the backend file system.
> Although these issues probably need to be solved into the current fuse
> protocol.

Yes.

> Last but not least, with separation there is no global async queue
> anymore - no global lock and cache issues.

The global async code should be moved into the /dev/fuse specific
"legacy" queuing so it doesn't affect either uring or virtiofs
queuing.

> >> https://lore.kernel.org/linux-fsdevel/CAJfpegtL3NXPNgK1kuJR8kLu3WkVC_ErBPRfToLEiA_0=w3=hA@mail.gmail.com/
> >>
> >> This cache line bouncing should be addressed by these patches
> >> as well.
> >
> > Why do you think this is solved?
>
>
> I _guess_ that writing to the mmaped buffer and processing requests on
> the same cpu core should make it possible to keep things in cpu cache. I
> did not verify that with perf, though.

Well, the issue is with any context switch that happens in the
multithreaded fuse server process.  Shared address spaces will have a
common "which CPU this is currently running on" bitmap
(mm->cpu_bitmap), which is updated whenever one of the threads using
this address space gets scheduled or descheduled.

Now imagine a fuse server running on a big numa system, which has
threads bound to each CPU.  The server tries to avoid using sharing
data structures between threads, so that cache remains local.  But it
can't avoid updating this bitmap on schedule.  The bitmap can pack 512
CPUs into a single cacheline, which means that thread locality is
compromised.

I'm somewhat surprised that this doesn't turn up in profiles in real
life, but I guess it's not a big deal in most cases.  I only observed
it with a special "no-op" fuse server running on big numa and with
per-thread queuing, etc. enabled (fuse2).

> For sync requests getting the scheduler involved is what is responsible
> for making really fuse slow. It schedules on random cores, that are in
> sleep states and additionally frequency scaling does not go up. We
> really need to stay on the same core here, as that is submitting the
> result, the core is already running (i.e. not sleeping) and has data in
> its cache. All benchmark results with sync requests point that out.

No arguments about that.

> For async requests, the above still applies, but basically one thread is
> writing/reading and the other thread handles/provides the data. Random
> switching of cores is then still not good. At best and to be tested,
> submitting rather large chunks to other cores.
> What is indeed to be discussed (and think annotated in the corresponding
> patch description), if there is a way to figure out if the other core is
> already busy. But then the scheduler does not know what it is busy with
> - are these existing fuse requests or something else. That part is
> really hard and I don't think it makes sense to discuss this right now
> before the main part is merged. IMHO, better to add a config flag for
> the current cpu+1 scheduling with an annotation that this setting might
> go away in the future.

The cpu + 1 seems pretty arbitrary, and could be a very bad decision
if there are independent tasks bound to certain CPUs or if the target
turns out to be on a very distant CPU.

I'm not sure what the right answer is.   It's probably something like:
try to schedule this on a CPU which is not busy but is not very
distant from this one.  The scheduler can probably answer this
question, but there's no current API for this.

Thanks,
Miklos

