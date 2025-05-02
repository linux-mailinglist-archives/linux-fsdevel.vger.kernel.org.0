Return-Path: <linux-fsdevel+bounces-47953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DFAA7AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3927A7FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826A1FAC4D;
	Fri,  2 May 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qijDsJ4u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118F19049A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746217464; cv=none; b=PeUsFQDDKbaNNkHT4CaLiF/rxO7on80T9FpnwJ939Kdpd75eSuxFmVME0/KM5l/eaVeRbHrJeGPEeHKDD4+/ZUMolh1PAN+zpL2j1XDPeBQOWDmQuSwBgn96zSc25QW9LrcNLzAT+4uX+90ZNDIHwfsMwm1aWGjav0HM8vPPi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746217464; c=relaxed/simple;
	bh=dZuVMFmp0Inh0pJRa9kV5vxGYfgwhCDsb1znOpLRUuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGfjEFEQIBfpPgvBJWJlfLuoV1xU5YrBicvJI0SQ2+kDKi8NZpn2Moo+qRdDXdLJR783uAmxkbfey4PqLjvgSZVgv9mU6Bm/Q1aVbT3fhx7oTfme+CabMZs6ws7iw87knut55eWX31sfuD3ZzekThUnpCDLrfH+rssFL4tRKLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qijDsJ4u; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso566a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746217461; x=1746822261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL/oGMV1bkBsob4mtK0KVB/s8CsmE7l1Y9u7qBwJ374=;
        b=qijDsJ4uM7RQU03hpObBC5RwJQ+UnXe2v95/sNQ62K6Tu6XGDyV6exQZqCLu7iq4uU
         /+PUvbo4fdwiVt7eVlzt8NAAWLpnotqbHz9czdmQt7WTJAubIrwCdJ6UhEoLWgDxlgZM
         VVr7YAN+27ItumPgbt1WR8B6hQBMKNeZ0f5E4c+yjtNizgRE/FYJMAh+hVxQ/gXV1JBV
         /I1RNcImiNfF5smL2yVgwuVFBiT6p2aPU0gjrt0oGEMkPsfrFK8OfwJfOQyW3GA2FoXL
         0nxbmkXs9sfzPQ0y6nUiaoh9sfMt9VM0p+HX8nRfrFCXc6n+GTL8Q52FCymiMw6Y5noZ
         K7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746217461; x=1746822261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL/oGMV1bkBsob4mtK0KVB/s8CsmE7l1Y9u7qBwJ374=;
        b=gUy1NfxEaWLnsCI9+O8z2qILZw/rdU1GpGRWNUlM4F+eT/BGbueNDmLJFAtUBt4Y2z
         fcmGKeF2DHip1qLY/q/41SlCXxVs/jKsOXsAf0nyj50zNWpxe7wrVydWtLcORkCPMNf7
         738fJ3cyb/2lrfY56GgcahtLBAndTzqsgRgRIryKg4Iaxv1Gu2NXQcnsaBWKTiNFeCJg
         NMGsrVjf6sX1+ICV+XSry5WNhViJr/JUkYerolR2LE5oWD4BHpeoC00C2m478rnvGgRC
         kN58vW9C37NGtftFEbOunxvxd99zIdUEr1wO08IBkUy8OkBa/d8+SKGQm9+CpKen/KHP
         s4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWEjCIpRsHD/ZkmsbRP/l/XXPlTBhEhW8CrkFfqPOFOzJ+viWN3Vb9PSQvOqNOEzkBCNlPANneME7DvtxDK@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVUmpp78iDdXhM5abITFZr6BRCGllNRMg7AXHKw9GB2ME2v9Y
	rcIgan7I3VCnt26BEWWY28ya4iAE7A3XXPcr9sBn0SicR6icAzQEDEa6z4lTfWSebQdHFJvE8GS
	RDxwfBHo/xS0pAHGd3ujBOSaYwGhfYABtV2Y9
X-Gm-Gg: ASbGnctxYMys0Q+f5HARYNRDG4JLBS8mkBaHyoSjtCYWIV/bo/A+NY8Kh0Hw1st5RYa
	f0QzbvGjl9myeyTi35QYInzuIcAqDM+0uG79offgX6AtSEc2eNAXXwgTEYyVazkLY6eb3Gzu/tP
	51MlvHc46u7Qb5S6BN7kKMPpI6BVr5QnJiJejIHN1bBaodrkZaLA==
X-Google-Smtp-Source: AGHT+IFBU11EVpVVrPBWAa64nkvdz6L6ofQR3kObgZnTcGWuajyGenWOEyDvBPb9FIURCMHMiUL8h1vtr1nfhcj1alo=
X-Received: by 2002:a05:6402:3199:b0:5fa:82a1:b99c with SMTP id
 4fb4d7f45d1cf-5faa69618bamr24415a12.0.1746217460265; Fri, 02 May 2025
 13:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
 <20250502-work-coredump-socket-v2-3-43259042ffc7@kernel.org>
 <CAG48ez1w+25tbSPPU6=z1rWRm3ZXuGq0ypq4jffhzUva9Bwazw@mail.gmail.com> <20250502-fanden-unbeschadet-89973225255f@brauner>
In-Reply-To: <20250502-fanden-unbeschadet-89973225255f@brauner>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 22:23:44 +0200
X-Gm-Features: ATxdqUHXcPgw7KB5LjgFO4gcINlAup0zI_DygTIVLbII3rAu_F1SAY-m1syr1Ko
Message-ID: <CAG48ez3xYzzazbxcHKEFzj9DDMOrnVf1cfjNpwE_FAY-YhtHmw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/6] coredump: support AF_UNIX sockets
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 10:11=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, May 02, 2025 at 04:04:32PM +0200, Jann Horn wrote:
> > On Fri, May 2, 2025 at 2:42=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> > > diff --git a/fs/coredump.c b/fs/coredump.c
> > [...]
> > > @@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo=
)
> > >                 }
> > >                 break;
> > >         }
> > > +       case COREDUMP_SOCK: {
> > > +               struct file *file __free(fput) =3D NULL;
> > > +#ifdef CONFIG_UNIX
> > > +               ssize_t addr_size;
> > > +               struct sockaddr_un unix_addr =3D {
> > > +                       .sun_family =3D AF_UNIX,
> > > +               };
> > > +               struct sockaddr_storage *addr;
> > > +
> > > +               /*
> > > +                * TODO: We need to really support core_pipe_limit to
> > > +                * prevent the task from being reaped before userspac=
e
> > > +                * had a chance to look at /proc/<pid>.
> > > +                *
> > > +                * I need help from the networking people (or maybe O=
leg
> > > +                * also knows?) how to do this.
> > > +                *
> > > +                * IOW, we need to wait for the other side to shutdow=
n
> > > +                * the socket/terminate the connection.
> > > +                *
> > > +                * We could just read but then userspace could sent u=
s
> > > +                * SCM_RIGHTS and we just shouldn't need to deal with
> > > +                * any of that.
> > > +                */
> >
> > I don't think userspace can send you SCM_RIGHTS if you don't do a
> > recvmsg() with a control data buffer?
>
> Oh hm, then maybe just a regular read at the end would work. As soon as
> userspace send us anything or we get a close event we just disconnect.
>
> But btw, I think we really need a recvmsg() flag that allows a receiver
> to refuse SCM_RIGHTS/file descriptors from being sent to it. IIRC, right
> now this is a real issue that systemd works around by always calling its
> cmsg_close_all() helper after each recvmsg() to ensure that no one sent
> it file descriptors it didn't want. The problem there is that someone
> could have sent it an fd to a hanging NFS server or something and then
> it would hang in close() even though it never even wanted any file
> descriptors in the first place.

Would a recvmsg() flag really solve that aspect of NFS hangs? By the
time you read from the socket, the file is already attached to an SKB
queued up on the socket, and cleaning up the file is your task's
responsibility either way (which will either be done by the kernel for
you if you don't read it into a control message, or by userspace if it
was handed off through a control message). The process that sent the
file to you might already be gone, it can't be on the hook for
cleaning up the file anymore.

I think the thorough fix would probably be to introduce a socket
option (controlled via setsockopt()) that already blocks the peer's
sendmsg().

> > > +                * In general though, userspace should just mark itse=
lf
> > > +                * non dumpable and not do any of this nonsense. We
> > > +                * shouldn't work around this.
> > > +                */
> > > +               addr =3D (struct sockaddr_storage *)(&unix_addr);
> > > +               retval =3D __sys_connect_file(file, addr, addr_size, =
O_CLOEXEC);
> >
> > Have you made an intentional decision on whether you want to connect
> > to a unix domain socket with a path relative to current->fs->root (so
> > that containers can do their own core dump handling) or relative to
> > the root namespace root (so that core dumps always reach the init
> > namespace's core dumping even if a process sandboxes itself with
> > namespaces or such)? Also, I think this connection attempt will be
>
> Fsck no. :) I just jotted this down as an RFC. Details below.
>
> > subject to restrictions imposed by (for example) Landlock or AppArmor,
> > I'm not sure if that is desired here (since this is not actually a
> > connection that the process in whose context the call happens decided
> > to make, it's something the system administrator decided to do, and
> > especially with Landlock, policies are controlled by individual
> > applications that may not know how core dumps work on the system).
> >
> > I guess if we keep the current behavior where the socket path is
> > namespaced, then we also need to keep the security checks, since an
> > unprivileged user could probably set up a namespace and chroot() to a
> > place where the socket path (indirectly, through a symlink) refers to
> > an arbitrary socket...
> >
> > An alternative design might be to directly register the server socket
> > on the userns/mountns/netns or such in some magic way, and then have
> > the core dumping walk up the namespace hierarchy until it finds a
> > namespace that has opted in to using its own core dumping socket, and
> > connect to that socket bypassing security checks. (A bit like how
> > namespaced binfmt_misc works.) Like, maybe userspace with namespaced
>
> Yeah, I namespaced that thing. :)

Oh, hah, sorry, I forgot that was you.

> > CAP_SYS_ADMIN could bind() to some magic UNIX socket address, or use
> > some new setsockopt() on the socket or such, to become the handler of
> > core dumps? This would also have the advantage that malicious
> > userspace wouldn't be able to send fake bogus core dumps to the
> > server, and the server would provide clear consent to being connected
> > to without security checks at connection time.
>
> I think that's policy that I absolute don't want the kernel to get
> involved in unless absolutely necessary. A few days ago I just discussed
> this at length with Lennart and the issue is that systemd would want to
> see all coredumps on the system independent of the namespace they're
> created in. To have a per-namespace (userns/mountns/netns) coredump
> socket would invalidate that one way or the other and end up hiding
> coredumps from the administrator unless there's some elaborate scheme
> where it doesn't.
>
> systemd-coredump (and Apport fwiw) has infrastructure to forward
> coredumps to individual services and containers and it's already based
> on AF_UNIX afaict. And I really like that it's the job of userspace to
> deal with this instead of the kernel having to get involved in that
> mess.
>
> So all of this should be relative to the initial namespace. I want a

Ah, sounds good.

> separate security hook though so an LSMs can be used to prevent
> processes from connecting to the coredump socket.
>
> My idea has been that systemd-coredump could use a bpf lsm program that
> would allow to abort a coredump before the crashing process connects to
> the socket and again make this a userspace policy issue.

I don't understand this part. Why would you need an LSM to prevent a
crashing process from connecting, can't the coredumping server process
apply whatever filtering it wants in userspace?

