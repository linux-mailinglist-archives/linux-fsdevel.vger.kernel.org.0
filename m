Return-Path: <linux-fsdevel+bounces-66531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB05C22ACA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 00:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDB03ACBE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9133B969;
	Thu, 30 Oct 2025 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G54P4vzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047D33BBA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866023; cv=none; b=MeMEUwGDUPeOqRZstSzvdnBetRMdnDRWGH52o1weG4YPqdHiPwztcqApWeYmCDGwniemdijgBJATCuY6inKpmVWy1Lw1f6OO1KgRLWfgUyYwN8VSLpjst36IO+GcOU5OsF1/hz6mS/SkWdj97sg0udb8sX5G9wLE+43MLyXN/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866023; c=relaxed/simple;
	bh=yEtzt+ACQ2k5tiNLfM9NtdifAsHbSXHjIdMgIqj0kI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzqjX4jYmhXGkN9rDGo4HuXEf2qyXXnZVmeDhmUm354wQKQXBDn55ZNpaO+ArDFVnuIxwa8Gdtr7LG2SU1mtbIiyszkMIXYuOn5d7wvHWyIZnmh/hWNRmZKkYfXm0C5bJbTl+nzsGUR9cj4FIZDNf2BS/zrJuHduiCRBxVZFmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G54P4vzf; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89f54569415so164919885a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761866020; x=1762470820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEtzt+ACQ2k5tiNLfM9NtdifAsHbSXHjIdMgIqj0kI4=;
        b=G54P4vzfl7HkNssigNTAy4fAnK29+0qCnI2D6cVg6a3rEIr1F4E/IHgMSn/YvZbBT+
         BhrkaxX6vg4KgzwUG83DU8Glc8Zhg8MJSVCpzulRGvC3Wtgost8B1o+iF1SASxfLILE+
         jzrEabu7MsF/zo+/4cBGBeE2DHMSAtD/C3np0f+k7nJpmVGd8RHrZ6ZpPYMM8CWM6nXS
         hJsXf0o/A33CgeCriD/r1zllQk/kFfmjLU14pa3edThJfQjfdk6STiA/9wvKbVRAi0Zq
         229zLa7qA/q/qGJt5O5BhTc6TJsCIovewgkZaaDneM+RmijheoJK89eXyuj1TD6IUClp
         Ta0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761866020; x=1762470820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEtzt+ACQ2k5tiNLfM9NtdifAsHbSXHjIdMgIqj0kI4=;
        b=fIza6pYrJuLwHZjcaKFidDCSceEDSzTR6vuf+jgfsBn2XRBdIS4ybf35okr/y1tgIp
         K8JzKr6X5ibQaKwidLHoYWX5BDzCOM7uwqP/0Hb8SOuKFew2tpk5xoDS7woaqyR2dI1q
         RGpRmM3ysqsTJxXzyzsOPhjfXw6chWXbp3fgGeGbjcSImEQ6CIOnTkvEahldFmz3OKTw
         m3C4uywkUfJDnwkud6TMLlYd6VmdBY61iNfjrmDZ75mfJMv/pZ5217bucTbj9KY4zKXp
         uuOG7v2luG8GK3+G+Y80GyDjvWHEirx9A6l/qYIS/FPMKBWuaQDS+QH2XG0LEEup2Ky/
         GxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCURzjiU2ojYMgGEX2MXe6EIYfC+sGbc8M0bGQGE8YY8XygDpQAqCJjGgp9AatykmS/8xmzvgfXGcg++ayeR@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpfX6BFYPZ0+zl+QOUi6BOaubf9p7QBOAgU9Y7moeKQbGSqBm
	ufNRz74eDM/0/L/5OMDEjfO+JeW0QLEYm8H81N0PHMFPcrd6tOCEjfJuikqxI82bDaMG8aSNU9F
	p1F2bxY/55kodsdCad5YDAqwP0y2cvEA=
X-Gm-Gg: ASbGncusB354/x6x7yi3pK/dKuVDzUT8QQjhcCdF2pILLd8b7I5/gH+m+lKjPWKaoo6
	eXYlT9pzMVkWogwsDlgXBuLJRf9GhTInD3aAtdr/jPZOZ3OecZy5egOtmzbhkO/z8q0TDI6zOqu
	SJEoe/bXcHHcjPls4MHdXPDIM1yIakBvwILM2TXMCu3Pq1nt8l6Q/rsyFVlq4muWyVOheRadWc+
	HXYR56aZzC+H0qWKq+JRZwuUpfSeEY4oAjFBbU1MbmAhmuGDOQB4PEBCazD6KmqkUjyXC4dW5cw
	cYEPilR4scQmAlyPQXCWZ+Hz6w==
X-Google-Smtp-Source: AGHT+IHCDMgKUMiTMGJsi4GifMtivCpfB8uu8c8prul7f0VaIBLqZ/8E4J4mWouM+Pk1Ujqz0kIO1egGZMKkolkvBZM=
X-Received: by 2002:a05:620a:471f:b0:858:f56:a6f4 with SMTP id
 af79cd13be357-8ab996879dfmr163824685a.31.1761866020507; Thu, 30 Oct 2025
 16:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
 <20251027222808.2332692-2-joannelkoong@gmail.com> <455fe1cb-bff1-4716-add7-cc4edecc98d2@gmail.com>
 <CAJnrk1ZaGkEdWwhR=4nQe4kQOp6KqQQHRoS7GbTRcwnKrR5A3g@mail.gmail.com> <9f0debb1-ce0e-4085-a3fe-0da7a8fd76a6@gmail.com>
In-Reply-To: <9f0debb1-ce0e-4085-a3fe-0da7a8fd76a6@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Oct 2025 16:13:29 -0700
X-Gm-Features: AWmQ_bmn68jujD5w185WEpQFER72YPWNqpKNDNy9TS9pwDWhAeFvDroekIqXiO8
Message-ID: <CAJnrk1Yng2MrAGHkMiSQfu8hDeVgGknCiyfejD1fY83yG+x6eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] io_uring/uring_cmd: add io_uring_cmd_import_fixed_full()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	csander@purestorage.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 11:06=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 10/29/25 18:37, Joanne Koong wrote:
> > On Wed, Oct 29, 2025 at 7:01=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 10/27/25 22:28, Joanne Koong wrote:
> >>> Add an API for fetching the registered buffer associated with a
> >>> io_uring cmd. This is useful for callers who need access to the buffe=
r
> >>> but do not have prior knowledge of the buffer's user address or lengt=
h.
> >>
> >> Joanne, is it needed because you don't want to pass {offset,size}
> >> via fuse uapi? It's often more convenient to allocate and register
> >> one large buffer and let requests to use subchunks. Shouldn't be
> >> different for performance, but e.g. if you try to overlay it onto
> >> huge pages it'll be severely overaccounted.
> >>
> >
> > Hi Pavel,
> >
> > Yes, I was thinking this would be a simpler interface than the
> > userspace caller having to pass in the uaddr and size on every
> > request. Right now the way it is structured is that userspace
> > allocates a buffer per request, then registers all those buffers. On
> > the kernel side when it fetches the buffer, it'll always fetch the
> > whole buffer (eg offset is 0 and size is the full size).
> >
> > Do you think it is better to allocate one large buffer and have the
> > requests use subchunks?
>
> I think so, but that's general advice, I don't know the fuse
> implementation details, and it's not a strong opinion. It'll be great
> if you take a look at what other server implementations might want and
> do, and if whether this approach is flexible enough, and how amendable
> it is if you change it later on. E.g. how many registered buffers it
> might need? io_uring caps it at some 1000s. How large buffers are?
> Each separate buffer has memory footprint. And because of the same
> footprint there might be cache misses as well if there are too many.
> Can you always predict the max number of buffers to avoid resizing
> the table? Do you ever want to use huge pages while being
> restricted by mlock limits? And so on.

Thanks for your thoughts, I'll think about this some more.
>
> In either case, I don't have a problem with this patch, just
> found it a bit off.
>
> > My worry with this is that it would lead to
> > suboptimal cache locality when servers offload handling requests to
> > separate thread workers. From a code perspective it seems a bit
>
> It wouldn't affect locality of the user buffers, that depends on
> the user space implementation. Are you sharing an io_uring instance
> between threads?

For request offloading, the different threads would share the io uring
instance. When the main thread that does the io_uring_wait_cqe()
receives a cqe, it'll dispatch the cqe to a worker thread to fulfill
while it then looks at the next cqe to send off to the next worker
thread and so on.

If there's one registered buffer that maps to the one big buffer
allocated by the server for the ring, then each worker thread might be
executing on different cpus when it accesses that buffer, which seems
like that could lead to cache line bouncing. Or at least that's the
scenario I was thinking of for suboptimal cache locality with the one
big buffer. But I do like how a big buffer would save on the memory
overhead that would be internally incurred in iouring for tracking
every registered buffer.

>
> > simpler to have each request have its own buffer, but it wouldn't be
> > much more complicated to have it all be part of one large buffer.
> >
> > Right now, we are fetching the bvec iter every time there's a request
> > because of the possibility that the buffer might have been
> > unregistered (libfuse will not do this, but some other rogue userspace
> > program could). If we added a flag to tell io uring that attempts at
> > unregistration should return -EBUSY, then we could just fetch the bvec
> > iter once and use that for the lifetime of the server connection
> > instead of having to fetch it every request, and then when the
> > connection is aborted, we could unset the flag so that userspace can
> > then successfully unregister their buffers. Do you think this is a
> > good idea to have in io-uring? If this is fine to add then I'll add
> > this to v3.
> The devil is in details, i.e. synchronisation. Taking a long term
> node reference might be fine. Does this change the uapi for this
> patchset? If not, I'd do it as a follow up. It also sounds like
> you can apply this optimisation regardless of whether you take
> a full registered buffer or go with sub ranges.

Thanks, this is helpful.
>
> --
> Pavel Begunkov
>

