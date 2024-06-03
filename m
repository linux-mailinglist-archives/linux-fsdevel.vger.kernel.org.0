Return-Path: <linux-fsdevel+bounces-20825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D86608D8443
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57055B2539F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73D12DD8F;
	Mon,  3 Jun 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ef9v5jKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972012D1F1
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422277; cv=none; b=dvC7GWhSlzsfXgyuMSPj335kJuqVzkiInv1Os4tn8jRxLvabpsJy/rc+zKyezPbg41rJhcLJ9MBBscGmZDW29Z8KsJU6oXFxh3ap9kUl/aJcpHSgrd/oSKg5d/6iWHG1WoPuHUpMu0308iGuZZChosXHBZCNuTeDHCYNOq+YIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422277; c=relaxed/simple;
	bh=OGYYT4aVNYM2tWfVMoDcUtFwbRfNH7eAQrhxgzdp1qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMOH3/KSXO26g5rWrrFz7n/d+VJDSiEoIXOeu0Q6EQwyQ0eVyW3h1zq2Y7o5oLx/mXueMJaxSGjiIZ78ZjPCegRoYGhB7trthIaccM9fjR+kNpjtfQzW6H7OCet58/Zd3zqfo+U8MoL9lSw3hwnXD8IXLhKlR/ejHrY8RkK7T9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ef9v5jKb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717422275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jdv+ECwxRJxFhTMGmQ1KqQnmmX5QOjTHqbjqi1D+WM=;
	b=ef9v5jKbAMZXuNbBofNvSkLVxbyg7OCj4WRcYLgjJE3Twbr400RVM+SxmfzjsDNECNZInJ
	ZRBpzk3v0BqMAHcbhrmdqMEQPaypEhvC/H+ZN52KyRICFjAAST5fPdhDDcUnU5AqVwSDYV
	WH6Dgjr330qnVjqJH6g7vVsrR0bZg0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-4Ch3gP0XM12UZRKLutKkfA-1; Mon,
 03 Jun 2024 09:44:31 -0400
X-MC-Unique: 4Ch3gP0XM12UZRKLutKkfA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD7343C025AD;
	Mon,  3 Jun 2024 13:44:30 +0000 (UTC)
Received: from localhost (unknown [10.39.193.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB9FC15C04;
	Mon,  3 Jun 2024 13:44:28 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:44:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>,
	Yoray Zack <yorayz@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Parav Pandit <parav@nvidia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"mszeredi@redhat.com" <mszeredi@redhat.com>,
	Eliav Bar-Ilan <eliavb@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>,
	Oren Duer <oren@nvidia.com>,
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Message-ID: <20240603134427.GA1680150@fedora.redhat.com>
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y8uNWZsMC5ooxXDF"
Content-Disposition: inline
In-Reply-To: <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8


--Y8uNWZsMC5ooxXDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wrot=
e:
>=20
> > We also considered this idea, it would kind of be like locking FUSE into
> > being x86. However I think this is not backwards compatible. Currently
> > an ARM64 client and ARM64 server work just fine. But making such a
> > change would break if the client has the new driver version and the
> > server is not updated to know that it should interpret x86 specifically.
>=20
> This would need to be negotiated, of course.
>=20
> But it's certainly simpler to just indicate the client arch in the
> INIT request.   Let's go with that for now.

In the long term it would be cleanest to choose a single canonical
format instead of requiring drivers and devices to implement many
arch-specific formats. I liked the single canonical format idea you
suggested.

My only concern is whether there are more commands/fields in FUSE that
operate in an arch-specific way (e.g. ioctl)? If there really are parts
that need to be arch-specific, then it might be necessary to negotiate
an architecture after all.

Stefan

>=20
> Thanks,
> Miklos
>=20

--Y8uNWZsMC5ooxXDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZdyLsACgkQnKSrs4Gr
c8g4Tgf8COEJi4kzlMDChTuLm+fsLcHV41ng+vGBfzzxoJKQjIotpIKxRKkPkm11
nEDf2EO1SomgzkQCDuVymDviTC8C+Dzd4xKsBqaVMWjV0RkGMYhZY+oe21ckRz97
yz31bftIz+STEi3FQ3a/U3Swgy04XZ2GwCJkNxUpdVLHb37yZOCA6N9K/PSu9ZVs
SdmesUwl7p2joB/zQJJt+42Q+VE+MEF0TXzrNe1CG+XWCugN29dbW9FghUZ97zJb
0t/x4N4uoFKnTUuPFkLw2RUxfyaeSxbzKdGiX2KF9DL7dTZjgno/NCnjohQfb2LL
akcutpV3LucF5xmkwOH1ACZoNCV6CA==
=cv8W
-----END PGP SIGNATURE-----

--Y8uNWZsMC5ooxXDF--


