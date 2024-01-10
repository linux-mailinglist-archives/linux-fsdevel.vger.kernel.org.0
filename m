Return-Path: <linux-fsdevel+bounces-7715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F13829D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309F2284533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246734BA90;
	Wed, 10 Jan 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="WlBcJDH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9B4BA9F;
	Wed, 10 Jan 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1704899965;
	bh=N3nJ0C540bT8WS6Z8HcIxixzWR9wSwd0zry2yrndudg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlBcJDH1lCsMwgEDQmVenG7bwKkUoeVq9ziwcPEUO1dQ4Dk9PFxWKxbZ5DfMf8boQ
	 IjPj7vYwHwrj5s54nji76vncIMvpcWqhK5M97QoNYCpjiERoQwBfAJipT981yRTzT/
	 bt6SnphWZxSiqcbhLD+snre1MX7yQ4v4VZ+d+tZeYGlFuadZyubtHDtgfI/5vBDaoN
	 4jPj3esZVFedLw8BSHLZ9Mim51LQZO0O8rY9l3WpZiP9g4+sEf17pmOugqORiTbdC/
	 Lvvb8f4Z3MvR507czyVNUsDwGVsSR1LqYOFmy7bJ8342LsPryS+Rihoy6bgLEdyx4+
	 4bCYOY+WbDSLw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 111A614CD4;
	Wed, 10 Jan 2024 16:19:25 +0100 (CET)
Date: Wed, 10 Jan 2024 16:19:24 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 09/11] fuse: file: limit splice_read to virtiofs
Message-ID: <2wob4ovppjywxmpl5rvuzpktltdlyto5czpglb5il5cehkel6m@tarta.nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <9b5cd13bc9e9c570978ec25b25ba5e4081b3d56b.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isq32hemhww3wwiu"
Content-Disposition: inline
In-Reply-To: <CAJfpegugS1y4Lwznju+qD2K-kBEctxU5ABCnaE2eOGhtFFZUYg@mail.gmail.com>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--isq32hemhww3wwiu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 02:43:04PM +0100, Miklos Szeredi wrote:
> On Thu, 21 Dec 2023 at 04:09, Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > Potentially-blocking splice_reads are allowed for normal filesystems
> > like NFS because they're blessed by root.
> >
> > FUSE is commonly used suid-root, and allows anyone to trivially create
> > a file that, when spliced from, will just sleep forever with the pipe
> > lock held.
> >
> > The only way IPC to the fusing process could be avoided is if
> > !(ff->open_flags & FOPEN_DIRECT_IO) and the range was already cached
> > and we weren't past the end. Just refuse it.
> How is this not going to cause regressions out there?
In "[PATCH v2 14/11] fuse: allow splicing to trusted mounts only"
splicing is re-enabled for mounts made by the real root.

> We need to find an alternative to refusing splice, since this is not
> going to fly, IMO.
The alternative is to not hold the lock. See the references in the
cover letter for why this wasn't done. IMO a potential slight perf
hit flies more than a total exclusion on the pipe.

--isq32hemhww3wwiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWetXwACgkQvP0LAY0m
WPHIwQ//fiIyHHVfimlyIEoId+cH17Lz5J3ZKEGBCJPUG9SG6u8qdgPid/iNV3fm
DP+x8A/oMbyeqLKh6GB3NwvrL8VOReuutMyNfxj9VmjaaV8rKq+g0CstpBTgOYuj
lA1KQ6k99btF1+zGXynutHQXTjf1krcTqnZ9+HFn0ejWIMa49ECFFxwoQLZ8DUH6
8kOgxMwE0Ar3hcq+zLsAXrUe5OUEUAGXqmMwpdomnaAi132G3MzT3cTL0JbuRtO8
kWdCgHFYCjMxKc00COyq9fcEoOmCpOctN0Uae+lsO74Ukb8o4VPr5w6mYPKEDnH9
ZPiqKoIJ1ek36CBPLGt9Mtr8LZO3REnRqDIp1g62O5eqN6kqYgK4qE8tf0ifkOWg
U/LoA/00MUOf4zyx5JoGHCVUCYrY9AnXYS5+nK1vDrR0F3m5iNkBy3OsKcvIEXqG
KTLOa+Jvn+W4L7539uyEkqKOpZAJfd5IT0IRnsxH38zvx9Rv7sGykn8vsT/Md8uk
wP6kJH448KE3TVePPc6QOAaK9qpcC4bu2Y5MvJX1CJM6Co27miyrId6WIbkz7umg
nmE7h3E6IlfKBCCgFT5CNBEx6z7mvDmQf4q7SayFz/f9kLNbRuQb4D4caYWJ6QPK
luPGvzp/UtbfHs7IXFKwtCDH5+4POrlVprj31R6YPJfOC+gnBmk=
=lQIA
-----END PGP SIGNATURE-----

--isq32hemhww3wwiu--

