Return-Path: <linux-fsdevel+bounces-24428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A193F44D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246371F22AFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75779145B29;
	Mon, 29 Jul 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="I8cFu9nH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479413AA26;
	Mon, 29 Jul 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253280; cv=none; b=lzxFmHgaQrYqjDPKMqMMyMdA/rCAwp/tA/ut/lxaajwQ075KIYbuzPHmZqTDrTT3YHFl8raDNYwi9T9X8w8xtEPkj1q9Dgzr+xFjPqhMOM5iMeX+QJ+5Ag5TzREBzNTXISLK91/EVcsDcdUM4+P0j2EdtRLaD643l5yDECLnT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253280; c=relaxed/simple;
	bh=lrN+3+8EM2/uvYXz2S/UGe78pD4ubhoWkqvbpr3MdIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNsOyQSdLhldkoSM8XuwK98aqKHhei0uKY9qgyaLsweMigrRnFL6Wi4bynI5y9j6SDmc+Z0vfjkLfsGZdLnxEiJkZTPDNXz7TIqPpd48vht0soU8dPEWNZ8RO75pnZY75LqST3oGPCG/p/hQrpIqFFBhBH8qzUVwTiw1WQFP/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=I8cFu9nH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WXbz90Qvkz9sHC;
	Mon, 29 Jul 2024 13:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722253269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Im3qHJ0gOnmmObZRm5tkGI4O1Z1r39QJ32bo9RzgZ7E=;
	b=I8cFu9nH5wwnB4lyekJHdrIqriJOZggQm4+heXP7XWoLkWN4Ygrs1+BULV3kwpDyROHNmQ
	qw6SzauZwQtsZ+bxRwyNpeL0IsL7BusnZ0lHbMOysdaNk6U1j7hlcNgvKmrwp9UaH+Tf9U
	BS5Ocj4AOO/o5+wlup4CEtfuXrmGKd/dui5L06YjM51KGTF9Mt+fDJfaSLWBKIyBrFH49d
	ZyUJ7sk2FBbRc/PvKMUTfu3CqpeWnNzoaLpgTZmPP1/patMQ+bdyzeGJIAdfGTbgdcg5yZ
	GOnEDMmGMbKsonfmBN35UcADHGoggH0TMp+MawVo7S5JtsXFsdgdychKOach8g==
Date: Mon, 29 Jul 2024 21:40:57 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240729.113049-lax.waffle.foxy.nit-U1v9CY38xge@cyphar.com>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com>
 <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com>
 <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vuxpsz4skq525v7n"
Content-Disposition: inline
In-Reply-To: <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>


--vuxpsz4skq525v7n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-29, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On Mon, Jul 29, 2024 at 12:57=E2=80=AFPM Florian Weimer <fweimer@redhat.c=
om> wrote:
> > > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> > >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> > >> >> It was pointed out to me that inode numbers on Linux are no longer
> > >> >> expected to be unique per file system, even for local file system=
s.
> > >> >
> > >> > I don't know if I'm parsing this correctly.
> > >> >
> > >> > Are you claiming on-disk inode numbers are not guaranteed unique p=
er
> > >> > filesystem? It sounds like utter breakage, with capital 'f'.
> > >>
> > >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> > >> local file systems are different.
> > >
> > > Can you link me some threads about this?
> >
> > Sorry, it was an internal thread.  It's supposed to be common knowledge
> > among Linux file system developers.  Aleksa referenced LSF/MM
> > discussions.
>=20
> So much for open development :-P

To be clear, this wasn't _decided_ at LSF/MM, it was brought up as a
topic. There is an LWN article about the session that mentions the
issue[1].

My understanding is that the btrfs and bcachefs folks independently
determined they cannot provide this guarantee. As far as I understand,
the reason why is that inode number allocation on btree filesystems
stores information about location and some other bits (maybe subvolumes)
in the bits, making it harder to guarantee there will be no collisions.

Don't quote me on that though, I'm sure they'll tell me I'm wrong when
they wake up. :D

As the article mentions, Kent Overstreet suggested trying to see how
many things break if you build a kernel where all inode numbers are the
same (my guess would be "very badly" -- aside from the classic problem
of hardlink detection, a lot of programs key things by (dev, ino), and
some inode numbers are guaranteed by the kernel for pseudo-filesystems
like PROC_ROOT_INO).

[1]: https://lwn.net/Articles/975444/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vuxpsz4skq525v7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZqd/yQAKCRAol/rSt+lE
b0hIAPsFZ0w4fdaQwqLquyodT7vvjRvPth8GWduxQ4GEClOkCAD/Zp9nyGLPiiUD
K4miYsQ9szF08yp6uMwLxmv0CsdoOgE=
=G+k3
-----END PGP SIGNATURE-----

--vuxpsz4skq525v7n--

