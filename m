Return-Path: <linux-fsdevel+bounces-20849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450F8D860B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5541F23520
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF061304B1;
	Mon,  3 Jun 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIZOMLMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7381877
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428492; cv=none; b=aYCrQ2nNpBESly6Ac4+a4u9dd2HG9R3XV4GDpm6cDxyAalg3/yls6Skqm0arnIDDTDDNZn+iujOiCoqS+y3gGIHqUIaHM4PlMsLkdS0dzLtqxPHMWGa5A0T9cb2U1K8gylpTDAUB+i4n/Icpg72G5slg45PXfl9NH4o6Rb4p2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428492; c=relaxed/simple;
	bh=89od9SnDeSWF+94He1BV4bQuiuySEj1xwkFpyddqDsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2c8PO51kNvOv29ehOJnPE2tY8hJIgGV9oSfiiAvBdzBc09DrTwqFYXW5FzHG96l804Y0POETTBkui1+S+hg54fXQEELwNvOwH40B2+NUbyKJMddcIoox5vFi2kRCuWdgTcYzIEqaqCqwHW+zUaFv1oJOs2u5LMYDxXOW3T8dU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIZOMLMv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717428489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B03sJEhk3aFXv26vMkfjM7/bnnaUicOhiuicfHShBQ=;
	b=CIZOMLMv+QRt1TtN18s3+LK2aO/aRUcsd9aIxgFhbIFuQ94CX2Vh56htKTmZsQq8ulQDm5
	kMzSsAUR+zYsEqcRAjTGZBCCiOiRVUqdC/fu5Btqi1XOx+Zr5GwqPqA1mmshGsWfgle5DX
	NbHQdB1tRs/WSbqa09cLLOCp2IdTm28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-0j--M71eNPuxffrQTqkc4w-1; Mon, 03 Jun 2024 11:28:04 -0400
X-MC-Unique: 0j--M71eNPuxffrQTqkc4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93623184868B;
	Mon,  3 Jun 2024 15:28:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7351C0654B;
	Mon,  3 Jun 2024 15:28:02 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:28:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Peter-Jan Gootzen <pgootzen@nvidia.com>,
	Idan Zach <izach@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Parav Pandit <parav@nvidia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Eliav Bar-Ilan <eliavb@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>,
	Oren Duer <oren@nvidia.com>,
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Message-ID: <20240603152801.GA1688749@fedora.redhat.com>
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com>
 <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HtVCb/uFpz/spwuP"
Content-Disposition: inline
In-Reply-To: <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


--HtVCb/uFpz/spwuP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 04:56:14PM +0200, Miklos Szeredi wrote:
> On Mon, Jun 3, 2024 at 3:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> >
> > On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> =
wrote:
> > >
> > > > We also considered this idea, it would kind of be like locking FUSE=
 into
> > > > being x86. However I think this is not backwards compatible. Curren=
tly
> > > > an ARM64 client and ARM64 server work just fine. But making such a
> > > > change would break if the client has the new driver version and the
> > > > server is not updated to know that it should interpret x86 specific=
ally.
> > >
> > > This would need to be negotiated, of course.
> > >
> > > But it's certainly simpler to just indicate the client arch in the
> > > INIT request.   Let's go with that for now.
> >
> > In the long term it would be cleanest to choose a single canonical
> > format instead of requiring drivers and devices to implement many
> > arch-specific formats. I liked the single canonical format idea you
> > suggested.
> >
> > My only concern is whether there are more commands/fields in FUSE that
> > operate in an arch-specific way (e.g. ioctl)? If there really are parts
> > that need to be arch-specific, then it might be necessary to negotiate
> > an architecture after all.
>=20
> How about something like this:
>=20
>  - by default fall back to no translation for backward compatibility
>  - server may request matching by sending its own arch identifier in
> fuse_init_in
>  - client sends back its arch identifier in fuse_init_out
>  - client also sends back a flag indicating whether it will transform
> to canonical or not
>=20
> This means the client does not have to implement translation for every
> architecture, only ones which are frequently used as guest.  The
> server may opt to implement its own translation if it's lacking in the
> client, or it can just fail.

=46rom the client perspective:

1. Do not negotiate arch in fuse_init_out - hopefully client and server
   know what they are doing :). This is the current behavior.
2. Reply to fuse_init_in with server's arch in fuse_init_out - client
   translates according to server's arch.
3. Reply to fuse_init_in with canonical flag set in fuse_init_out -
   client and server use canonical format.

=46rom the server perspective:

1. Client does not negotiate arch - the current behavior (good luck!).
2. Arch received in fuse_init_out from client - must be equal to
   server's arch since there is no way for the server to reject the
   arch.
3. Canonical flag received in fuse_init_out from client - client and
   server use canonical format.

Is this what you had in mind?

Stefan

--HtVCb/uFpz/spwuP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZd4QAACgkQnKSrs4Gr
c8hF9AgAwhST9vh33+Eq0iUWXFdnHAPVhvrm0lixxa2N7BGRyVeM1L2TCUfkj6wv
Z4zs1myqS7GQIjQuASCbMI2P3WlEeecaosBdz/ydWRYVyQaQy0eQikdo2HNxZSiY
rkRMPK6R7ePgEvYNVyavOuWvaOCJLoGGbdhqmtibDtRHr+4A4UT/nyALz5yJa7nv
/hRg538LubMLT73huw/6wGnYgMwHIcUNfx+8b+1MUGnSxTQHBocFZzkGT524iF/A
mhANGs8/vd3/Ao4WRJrgBeiyWapwDJehDo4ncleVuraZ6aDfzZvmsPKq9HEcXR+Q
PAgm6yxNkHB2sNrMsS5bSN8tamHayQ==
=Fztw
-----END PGP SIGNATURE-----

--HtVCb/uFpz/spwuP--


