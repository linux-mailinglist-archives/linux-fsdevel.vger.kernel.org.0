Return-Path: <linux-fsdevel+bounces-6138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C1813B73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B131F22565
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9606AB8C;
	Thu, 14 Dec 2023 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="ljLir48Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91C6A327;
	Thu, 14 Dec 2023 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702584852;
	bh=meBGsnMOzECjyH83S0TIoYo1VQ8lyxr11KCwZtgZu4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljLir48QxIlhO3e+igkAxAZMr/kSNsUrkSu17U1BVlbL1wmy8SCMVmKZBM56NQAX+
	 lJBh4vokm9xllnPFrVxsFBEL652fE1Vet4Nv0ZFSigl73pM7Jbt+BqwtEEZeW+HjUi
	 LHEISWX7JW0611MTRtIyYdF+wUZmbQvajTj1XJKPbG/y+GSvggHgg3k7yh/H8gRAar
	 11AXY8a4AxZH8XG1VBWyP8u7xjH7QXgLlGiT29ib+GgYpS2HIvHLgHjRThbYgB/Wo4
	 iHtrQgxIzTcQAeVySqSFw7fxzn1AoMOwOVIUWftVrmi2OE9ma10qU5St5WlrZgfq7h
	 aanPxQWECP62g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 7B3A313912;
	Thu, 14 Dec 2023 21:14:12 +0100 (CET)
Date: Thu, 14 Dec 2023 21:14:12 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Boris Pismenny <borisp@nvidia.com>, 
	Cong Wang <cong.wang@bytedance.com>, David Ahern <dsahern@kernel.org>, 
	David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>, 
	John Fastabend <john.fastabend@gmail.com>, Karsten Graul <kgraul@linux.ibm.com>, Kirill Tkhai <tkhai@ya.ru>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Li kunyu <kunyu@nfschina.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Paolo Abeni <pabeni@redhat.com>, Pengcheng Yang <yangpc@wangsu.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Xu Panda <xu.panda@zte.com.cn>, Zhang Zhengming <zhang.zhengming@h3c.com>
Subject: Re: [PATCH RERESEND 00/11] splice(file<>pipe) I/O on file as-if
 O_NONBLOCK
Message-ID: <6rimhkkijpaiick465lvwafgd6ttzhyqq2st6gjobxdyvqhz3p@tarta.nabijaczleweli.xyz>
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <500557ed-3967-455e-8a79-d64711045b70@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfpi4lavvicqmx4h"
Content-Disposition: inline
In-Reply-To: <500557ed-3967-455e-8a79-d64711045b70@kernel.dk>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--yfpi4lavvicqmx4h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:06:57PM -0700, Jens Axboe wrote:
> On 12/14/23 11:44 AM, Ahelenia Ziemia=C5=84ska wrote:
> > This does that, effectively making splice(file -> pipe)
> > request (and require) O_NONBLOCK on reads fron the file:
> > this doesn't affect splicing from regular files and blockdevs,
> > since they're always non-blocking
> > (and requesting the stronger "no kernel sleep" IOCB_NOWAIT is non-sensi=
cal),
> Not sure how you got the idea that regular files or block devices is
> always non-blocking, this is certainly not true without IOCB_NOWAIT.
> Without IOCB_NOWAIT, you can certainly be waiting for previous IO to
> complete.
Maybe "always non-blocking" is an abuse of the term, but the terminology
is lost on me. By this I mean that O_NONBLOCK files/blockdevs have the
same semantics as non-O_NONBLOCK files/blockdevs =E2=80=92 they may block f=
or a
bit while the I/O queue drains, but are guaranteed to complete within
a relatively narrow bounded time; any contending writer/opener
will be blocked for a short bit but will always wake up.

This is in contrast to pipes/sockets/ttys/&c., which wait for a peer to
send some data, and block until there is some; any contending writer/opener
will be blocked potentially ad infinitum.

Or, the way I see it, splice(socket -> pipe) can trivially be used to
lock the pipe forever, whereas I don't think splice(regfile -> pipe) can,
regardless of IOCB_NOWAIT, so the specific semantic IOCB_NOWAIT provides
is immaterial here, so not specifying IOCB_NOWAIT in filemap_splice_read()
provides semantics consistent to "file is read as-if it had O_NONBLOCK set".

> > but always returns -EINVAL for ttys.
> > Sockets behave as expected from O_NONBLOCK reads:
> > splice if there's data available else -EAGAIN.
> >=20
> > This should all pretty much behave as-expected.
> Should it? Seems like there's a very high risk of breaking existing use
> cases here.
If something wants to splice from a socket to a pipe and doesn't
degrade to read/write if it gets EAGAIN then it will either retry and
hotloop in the splice or error out, yeah.

I don't think this is surmountable.

> Have you at all looked into the approach of enabling splice to/from
> _without_ holding the pipe lock? That, to me, would seem like a much
> saner approach, with the caveat that I have not looked into that at all
> so there may indeed be reasons why this is not feasible.
IIUC Linus prepared a patch on security@ in
  <CAHk-=3DwhPmrWvXBqcK6ey_mnd-0fz_HNUHEfz3NX97mqoCCcwtA@mail.gmail.com>
(you're in To:) and an evolution of this is in
  https://lore.kernel.org/lkml/CAHk-=3DwgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA=
-d8_S0zRg@mail.gmail.com/t/#u
(you're in Cc:) that does this.

He summarises it below as=20
> So while fixing your NULL pointer check should be trivial, I think
> that first patch is actually fundamentally broken wrt pipe resizing,
> and I see no really sane way to fix it. We could add a new lock just
> for that, but I don't think it's worth it.
and
> But it is possible that we need to just bite the bullet and say
> "copy_splice_read() needs to use a non-blocking kiocb for the IO".
so that's what I did.

If Linus, who drew up and maintained this code for ~30 years,
didn't arrive at a satisfactory approach, I, after ~30 minutes,
won't either.

It would be very sane to both not change the semantic and fix the lock
by just not locking but at the top of that thread Christian said
> Splice would have to be
> refactored to not rely on pipe_lock(). That's likely major work with a
> good portion of regressions if the past is any indication.
and clearly this is true, so lacking the ability and capability
to do that and any reasonable other ideas
(You could either limit splices to a proportion of the pipe size,
 but then just doing five splices gets you where we are rn
 (or, as Linus construed it, into "write() returns -EBUSY" territory,
  which is just as bad but at least the writers aren't unkillable),
 and it reduces the I/O per splice significantly.

 You could limit each pipe to one outstanding splice and always leave
 Some space for normal I/O. This falls into "another lock just for this"
 territory I think, and it also sucks for the 99% of normal users.)
I did this because Linus vaguely sanxioned it.

It's probably feasible, but alas it isn't feasible for me.

--yfpi4lavvicqmx4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV7Yg0ACgkQvP0LAY0m
WPGl2xAAmYgbJ/w5E0nZQfpnb6zGUB4AQqRWeWIssHgDm3oH2jKgIhk0PDPt+ttb
wYRRdROTVWH/k7RlPa7+L4hClNRakuyDxATbna1XuIpk8qfNTrgXg138J2pB+jqY
IzX3N0Z7NC1HlbA34ELgm8lPphOyNmkVp333i9LaLcDyZ/4//Oi17Kr/mfke8iSp
1/Mh7R/tzdllH6DjgizgBTjTBGqQ9Blc2MiLdQJ2Fvpjz+jr9x7L1BMIrvZHtCGm
7/n4Fm/9zxuWxWyUd2WuT6HtqdxUfJ8dNbAssexD44H0iCwA0bKIurBAZIzluLvi
weB+WynfgNcR4HiTXFt7DwnTUPxF74HSaX9kwWMRGe6cHlIcbsJ2dePfuX+afi4H
IrdpPaBoOA8gnpY2Dh4dDwIDw0cqwtVEuxYclsYoTgnomfI7YYac6Yo0bIaLxjw8
/lB1eyTzdC1pltQKdlXzVSP8av9L891QNNZDYmyQ3kx3GqkPpfkbj8J94ZU4HgaA
PMldWaocWklGCCgHsXS6yG52oD0R3+Ky2kTx291/BQFMgVfuO2Wu9PAeTPNothZK
kY2YdnZrEwJ2tlLTFKjf+d29o1dhC/qpHjKO41PqOwZ3IOdGDuIqV4Mx7jvObDJ/
0H4uofNhOQLYlD88TlBUxQG4tFsQmFTtqg/1aTmH4lBtYeVfNlk=
=rGg4
-----END PGP SIGNATURE-----

--yfpi4lavvicqmx4h--

