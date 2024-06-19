Return-Path: <linux-fsdevel+bounces-21918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB590E86F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F87A285077
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF012FB37;
	Wed, 19 Jun 2024 10:37:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057712F5B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793453; cv=none; b=tQ6dxHbdb3uEDlmsKYCu5HFWsKxzZLOsZO8fA5x2HPrsNAEiOsE3ayq/4Af2tzrBvDeFW7QSIT6tRMf/qRM5v/YuMA99v9zonSolh9ZYOWA4Lr9EHHAlJUu+C/9tGl+9RT/7Wkb0oDcYrg2fm027h36JrqGyn/MV53FwfyftWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793453; c=relaxed/simple;
	bh=kmFVtHxCbleRMg0X45QgC4I/XGM1q4Zua3nvzV1l484=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YEsnM9iJUKljuPIADuzKGF8R6HiFkJYuAJTIGQuccMB6XbXJOeeq0v/hcY4o3BF94ji9OdFEG2+LZvNpNkI3vSZlDQuUrV+yEBv7bNluBrzUZRTvMgCfsj7BQ0VvU1zcePm39WXSXTkDHG394T4+5x07IEV/NnFryMQ+0CcwjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-166-rn-eowsVOI6XUZV4F8yriw-1; Wed, 19 Jun 2024 11:37:22 +0100
X-MC-Unique: rn-eowsVOI6XUZV4F8yriw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jun
 2024 11:36:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jun 2024 11:36:47 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yu Ma' <yu.ma@intel.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"tim.c.chen@intel.com" <tim.c.chen@intel.com>, "pan.deng@intel.com"
	<pan.deng@intel.com>, "tianyou.li@intel.com" <tianyou.li@intel.com>
Subject: RE: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
Thread-Topic: [PATCH 1/3] fs/file.c: add fast path in alloc_fd()
Thread-Index: AQHavnVDuhejvw+BWkmfgba3ixog57HO6lAA
Date: Wed, 19 Jun 2024 10:36:47 +0000
Message-ID: <218ccf06e7104eb580023fb69c395d3e@AcuMS.aculab.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-2-yu.ma@intel.com>
In-Reply-To: <20240614163416.728752-2-yu.ma@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Yu Ma <yu.ma@intel.com>
> Sent: 14 June 2024 17:34
>
> There is available fd in the lower 64 bits of open_fds bitmap for most ca=
ses
> when we look for an available fd slot. Skip 2-levels searching via
> find_next_zero_bit() for this common fast path.
>=20
> Look directly for an open bit in the lower 64 bits of open_fds bitmap whe=
n a
> free slot is available there, as:
> (1) The fd allocation algorithm would always allocate fd from small to la=
rge.
> Lower bits in open_fds bitmap would be used much more frequently than hig=
her
> bits.
> (2) After fdt is expanded (the bitmap size doubled for each time of expan=
sion),
> it would never be shrunk. The search size increases but there are few ope=
n fds
> available here.
> (3) There is fast path inside of find_next_zero_bit() when size<=3D64 to =
speed up
> searching.
>=20
> With the fast path added in alloc_fd() through one-time bitmap searching,
> pts/blogbench-1.1.0 read is improved by 20% and write by 10% on Intel ICX=
 160
> cores configuration with v6.8-rc6.
>=20
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/file.c b/fs/file.c
> index 3b683b9101d8..e8d2f9ef7fd1 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -510,8 +510,13 @@ static int alloc_fd(unsigned start, unsigned end, un=
signed flags)
>  =09if (fd < files->next_fd)
>  =09=09fd =3D files->next_fd;
>=20
> -=09if (fd < fdt->max_fds)
> +=09if (fd < fdt->max_fds) {
> +=09=09if (~fdt->open_fds[0]) {
> +=09=09=09fd =3D find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
> +=09=09=09goto success;
> +=09=09}
>  =09=09fd =3D find_next_fd(fdt, fd);
> +=09}

Hmm...
How well does that work when the initial fd is > 64?

Since there is exactly one call to find_next_fd() and it is static and shou=
ld
be inlined doesn't this optimisation belong inside find_next_fd().

Plausibly find_next_fd() just needs rewriting.

Or, possibly. even inside an inlinable copy of find_next_zero-bit()
(although a lot of callers won't be 'hot' enough for the inlined bloat
being worth while).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


