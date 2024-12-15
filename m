Return-Path: <linux-fsdevel+bounces-37446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C09F25E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 20:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ECA1887879
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03871BD519;
	Sun, 15 Dec 2024 19:37:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A550149C69
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291423; cv=none; b=UnYbs3H/XKp9zgjWfTcIbTwhmSX2J46syz3j1wVL+/Q/n1nwly2tdcd4fRHaqbKnM7Hh8ifpFGPzlFs+IUSG5EjCNGqYYDblvLQL+V3cnbB45jqW5SXW1uXAlPW83EzfGrcsM7ih03AYkPyo5CyNgPqvSGZhY+G5e8ZxDx2nHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291423; c=relaxed/simple;
	bh=7scpWpF3e22w7STxMY14fk094q7SxCDnPoV8LgkKYq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=bC6QUkgWa5Hcm769jslaxUerp8PrToLastKbQm4aJN40TgPwYcIdAFLinD8YH9V3YOj5C+f4FFbP/30YvsoTpe827QGq8xTl0mcbIb/0eXlJVWeQzUAKWmloyW3TSLall1V6Teh+oLL0hthXI35WfwKHo2sT9z35f4V2HicdCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-78-UIVQJ175NaeBrXPJaEsg5A-1; Sun, 15 Dec 2024 19:36:58 +0000
X-MC-Unique: UIVQJ175NaeBrXPJaEsg5A-1
X-Mimecast-MFC-AGG-ID: UIVQJ175NaeBrXPJaEsg5A
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 15 Dec
 2024 19:35:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 15 Dec 2024 19:35:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'cel@kernel.org'" <cel@kernel.org>, Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huaweicloud.com"
	<yangerkun@huaweicloud.com>, Chuck Lever <chuck.lever@oracle.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jeff Layton
	<jlayton@kernel.org>, Yang Erkun <yangerkun@huawei.com>
Subject: RE: [PATCH v5 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
Thread-Topic: [PATCH v5 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
Thread-Index: AQHbTyMyhyLVsk/YOU2ozqtU7VdGFrLnsn/g
Date: Sun, 15 Dec 2024 19:35:57 +0000
Message-ID: <95d0b9296e3f48ffb79a1de0b95f4726@AcuMS.aculab.com>
References: <20241215185816.1826975-1-cel@kernel.org>
 <20241215185816.1826975-2-cel@kernel.org>
In-Reply-To: <20241215185816.1826975-2-cel@kernel.org>
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
X-Mimecast-MFC-PROC-ID: jI0qtBEAyNE_8PUKYucdibGulZRO47wCP-MnJrS5Dmo_1734291418
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: cel@kernel.org
> Sent: 15 December 2024 18:58
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Testing shows that the EBUSY error return from mtree_alloc_cyclic()
> leaks into user space. The ERRORS section of "man creat(2)" says:
>=20
> >=09EBUSY=09O_EXCL was specified in flags and pathname refers
> >=09=09to a block device that is in use by the system
> >=09=09(e.g., it is mounted).
>=20
> ENOSPC is closer to what applications expect in this situation.
>=20
> Note that the normal range of simple directory offset values is
> 2..2^63, so hitting this error is going to be rare to impossible.
>=20
> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets"=
)
> Cc: <stable@vger.kernel.org> # v6.9+
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Yang Erkun <yangerkun@huawei.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/libfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 748ac5923154..f6d04c69f195 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -292,7 +292,9 @@ int simple_offset_add(struct offset_ctx *octx, struct=
 dentry *dentry)
>=20
>  =09ret =3D mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN=
,
>  =09=09=09=09 LONG_MAX, &octx->next_offset, GFP_KERNEL);
> -=09if (ret < 0)
> +=09if (unlikely(ret =3D=3D -EBUSY))
> +=09=09return -ENOSPC;
> +=09if (unlikely(ret < 0))
>  =09=09return ret;

You've just added an extra comparison to a hot path.
Doing:
=09if (ret < 0)
=09=09return ret =3D=3D -EBUSY ? -ENOSPC : ret;
would be better.

=09David

>=20
>  =09offset_set(dentry, offset);
> --
> 2.47.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


