Return-Path: <linux-fsdevel+bounces-48258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C613AAC83D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA203B6C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620F2820CF;
	Tue,  6 May 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRxKH3Pk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15562145B3E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542311; cv=none; b=ULedVarN1GbKtHivv1GI8EX2DIEsFAa3CY5Tmg+bjlZYdlWMZgTtaBk7cyPpQI2I1NirPNv+egmNQPLLAXdEQPVFBDyUO7Jmons4CMbihvW8diwzv925jmikmcgFr34Xcl+EV9QKtvpVAvv1nh44LWEVcSPVBDyfraOWEWcoCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542311; c=relaxed/simple;
	bh=Ma83b15qnnbFaueFtEvSpUdw/TKvSFOJHfOZe78Fr4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMB01eC0MLSJSrLasrfUWG95CTakEvDTnNkkif8WdIRYSRdQeMLiitfgkZnFzviVYdKc94QwAdFZOL1BLtRKrHW2a+sM4OIwYpDVaSV2RStA2TPJz/wT01YQQj+xIuNpQmkfBPZuqVpBz3ojwc+ymEdg7FeYkOxhjqITY9efl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRxKH3Pk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso9380a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746542307; x=1747147107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS0cqO7mEX8JBUGkY5ZSym9XPagAwEGfVvGLKmJF5sY=;
        b=CRxKH3PkApshm30WZX8T9D4ebFVa2DK7zxt1/b5UuPL7Un040C1U04ni6pt6wn4EUz
         5jx1dasvgSqPUAApV3udF1A/6C+nUlyypZIjBlpCM0dEuoRq7fICJSpaB2UhsFtOvRan
         cgQZYs6G4UwwFepUYX64nBp1bhYcLI2CFkrti2s0X0fJmnym8e6wcNm1nbXBgHxxU4DO
         73DjIY+ZRiUL8YZ58MzUU1ACZJE2e8eq3/y6W2agirsIrZFZiItiW8MF9e73oHUvzxHh
         hKax1ddqHIzpONWeLztbYaFGdnyw3RTmNcKMUjTpBsKxrrazzPA+4XJ0EXcghTL4bPa9
         UEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542307; x=1747147107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS0cqO7mEX8JBUGkY5ZSym9XPagAwEGfVvGLKmJF5sY=;
        b=kMJFi3B8xFBshFJ95bjKB1Uz7m5xE2JEKxdab4Tgt3DsnTzl+BYs96kcz46qDgGyWJ
         XNWKGUm5j/d5Pgs9+eyfKdIdyQO6M8jDt6bfxLq89B9t3T53bHDUk5d/1UIc70JGdLb5
         sZaoIq5YjyFyFuzoVD2nLn3WbW38FcT3BA0mMFakG3AyBDcqJ2/KMcNId3QBxxXZXxNk
         CJbOPM+As2Tv74KqY9egpay5fqJ2ItXowwn3rowaM4So8EeeZzLbswmT2uPRjSq75Mdu
         bE6e2iGBLKDhqvzDFr1+/5aUSFkoCobTmVtjxDn1PxpVi0crQwLfSQANgo0xH5UprEh1
         xvKw==
X-Forwarded-Encrypted: i=1; AJvYcCUcGJ3oPlxDTXmS0kLU6P2k9lR1pjLVt0RrWNzrJ7ENrt9BbsnL1+tGRQ5e3UTCIRmE4yPcCRpKyf57bRaP@vger.kernel.org
X-Gm-Message-State: AOJu0Yykbe9ruqUBem4/gRCa4Tb9qxEdLM/70U/p4IUkwmJsVo7gkHPy
	VzVPR6Kyg+XKmRpT7l4TlS01OOsEMTfT7bw2msB1gt/gvS/uzrhUUgDRGI6Nxyx04fSF6mOWNXi
	NLOugJk+ZU3ueLFXP8RdF7O8q/uYlDaLhBvDX
X-Gm-Gg: ASbGncsku9vrpvZzUkHekpB9W9ya87W/bs965BW9MnFSHX1Sr0gC7bap6g4NjOxZu7z
	TQCxz1QPb7d7WyE6S2rE5ca873/OMu/W48C3aOG8rq2bvXVdsrPc4KvOGjIV1TEOqq9bp+/Dkwz
	uwJUqt5QIqquFkeDA08zVVmaVuC5bZaW4mHDIiVWLjQ3nlPDwGuQ==
X-Google-Smtp-Source: AGHT+IEKBtQbqHTSi7RTxOlTKbd2L3krdaRx+iHlrQhBUxrpFEHfioEBlUhMAatv2Ff4k8wWL2KQK5USpqhewEIPDcg=
X-Received: by 2002:aa7:d1d9:0:b0:5f8:d6b1:71ba with SMTP id
 4fb4d7f45d1cf-5fbe76ccb80mr239a12.4.1746542307024; Tue, 06 May 2025 07:38:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-dompteur-hinhalten-204b1e16bd02@brauner>
 <20250505184136.14852-1-kuniyu@amazon.com> <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>
 <20250506-zugabe-bezog-f688fbec72d3@brauner>
In-Reply-To: <20250506-zugabe-bezog-f688fbec72d3@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 May 2025 16:37:49 +0200
X-Gm-Features: ATxdqUG1RLsm5I44mZFoXDEOhGLmKo0PIMKTKhu327qv26lJZYIhQ2B6edAN2po
Message-ID: <CAG48ez0Pc+QzxgAnT25KqyvjC8n0=diL6DnxBe7CcdQ32u9GcA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alexander@mihalicyn.com, bluca@debian.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:06=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, May 05, 2025 at 09:10:28PM +0200, Jann Horn wrote:
> > On Mon, May 5, 2025 at 8:41=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Mon, 5 May 2025 16:06:40 +0200
> > > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > > On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner=
@kernel.org> wrote:
> > > > > > Make sure that only tasks that actually coredumped may connect =
to the
> > > > > > coredump socket. This restriction may be loosened later in case
> > > > > > userspace processes would like to use it to generate their own
> > > > > > coredumps. Though it'd be wiser if userspace just exposed a sep=
arate
> > > > > > socket for that.
> > > > >
> > > > > This implementation kinda feels a bit fragile to me... I wonder i=
f we
> > > > > could instead have a flag inside the af_unix client socket that s=
ays
> > > > > "this is a special client socket for coredumping".
> > > >
> > > > Should be easily doable with a sock_flag().
> > >
> > > This restriction should be applied by BPF LSM.
> >
> > I think we shouldn't allow random userspace processes to connect to
> > the core dump handling service and provide bogus inputs; that
> > unnecessarily increases the risk that a crafted coredump can be used
> > to exploit a bug in the service. So I think it makes sense to enforce
> > this restriction in the kernel.
> >
> > My understanding is that BPF LSM creates fairly tight coupling between
> > userspace and the kernel implementation, and it is kind of unwieldy
> > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > longer and describe more kernel implementation detail if you tried to
> > show how to write a BPF LSM that is capable of detecting unix domain
> > socket connections to a specific address that are not initiated by
> > core dumping.) I would like to keep it possible to implement core
> > userspace functionality in a best-practice way without needing eBPF.
> >
> > > It's hard to loosen such a default restriction as someone might
> > > argue that's unexpected and regression.
> >
> > If userspace wants to allow other processes to connect to the core
> > dumping service, that's easy to implement - userspace can listen on a
> > separate address that is not subject to these restrictions.
>
> I think Kuniyuki's point is defensible. And I did discuss this with
> Lennart when I wrote the patch and he didn't see a point in preventing
> other processes from connecting to the core dump socket. He actually
> would like this to be possible because there's some userspace programs
> out there that generate their own coredumps (Python?) and he wanted them
> to use the general coredump socket to send them to.
>
> I just found it more elegant to simply guarantee that only connections
> are made to that socket come from coredumping tasks.
>
> But I should note there are two ways to cleanly handle this in
> userspace. I had already mentioned the bpf LSM in the contect of
> rate-limiting in an earlier posting:
>
> (1) complex:
>
>     Use a bpf LSM to intercept the connection request via
>     security_unix_stream_connect() in unix_stream_connect().
>
>     The bpf program can simply check:
>
>     current->signal->core_state
>
>     and reject any connection if it isn't set to NULL.

I think that would be racy, since zap_threads sets that pointer before
ensuring that the other threads under the signal_struct are killed.

>     The big downside is that bpf (and security) need to be enabled.
>     Neither is guaranteed and there's quite a few users out there that
>     don't enable bpf.
>
> (2) simple (and supported in this series):
>
>     Userspace accepts a connection. It has to get SO_PEERPIDFD anyway.
>     It then needs to verify:
>
>     struct pidfd_info info =3D {
>             info.mask =3D PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
>     };
>
>     ioctl(pidfd, PIDFD_GET_INFO, &info);
>     if (!(info.mask & PIDFD_INFO_COREDUMP)) {
>             // Can't be from a coredumping task so we can close the
>             // connection without reading.
>             close(coredump_client_fd);
>             return;
>     }
>
>     /* This has to be set and is only settable by do_coredump(). */
>     if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
>             // Can't be from a coredumping task so we can close the
>             // connection without reading.
>             close(coredump_client_fd);
>             return;
>     }
>
>     // Ok, this is a connection from a task that has coredumped, let's
>     // handle it.
>
>     The crux is that the series guarantees that by the time the
>     connection is made the info whether the task/thread-group did
>     coredump is guaranteed to be available via the pidfd.
>
> I think if we document that most coredump servers have to do (2) then
> this is fine. But I wouldn't mind a nod from Jann on this.

I wouldn't recommend either of these as a way to verify that the data
coming over the socket is a core dump generated by the kernel, since
they both look racy in that regard.

But given that you're saying the initial userspace user wouldn't
actually want such a restriction, and that we could later provide a
separate way for userspace to check what initiated the connection, I
guess this is fine for now.

