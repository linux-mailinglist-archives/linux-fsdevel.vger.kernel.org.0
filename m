Return-Path: <linux-fsdevel+bounces-13164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97B86C0B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651251F23176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C144376;
	Thu, 29 Feb 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u3UIvaI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A53DBB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188388; cv=none; b=eq4iuzXbphO9AD7v3bCtQbWt2DU7mv1/8Ynb9Cag80QWdraVFBlh/Ixp56I9G21lNTjGB5f19A4wfjhFsTbkGgrZohETObc7qMPNLMclNAkr0Zk0x7/yB3kc0pLGBXTP/Hgb9hSth1M1BgJDh1lvETwAs9OiH/AYIe741MwLogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188388; c=relaxed/simple;
	bh=24nXaVTiafwk5feujwzo97L3egHzOGzDDuYFYe6mrdE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=QDCDncLPF32DNJSbkJmaRrXVCXniz+rOo5lP/KyUl6fStsJGpl/56yqXzmQrYxoz1P2sRfpxRGu0ggC9Pi0EGd1MzvOUetGejw8zntzCZEEamVKKg2OSgRy8unDyuQ/uvGSlq+6w53cCVnb3GYBxJo+53A68otIWrgWGbpV89PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=u3UIvaI2; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240229063302epoutp0341a88a554bb26388cab03582c578b084~4Qcc2tjdT0602306023epoutp03c
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240229063302epoutp0341a88a554bb26388cab03582c578b084~4Qcc2tjdT0602306023epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709188382;
	bh=uQ4JZ6yNFn1HCEcvmNCvRd/iF82pqe9fHmoGFBPQqQQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=u3UIvaI2Q6tlc7w5vjcfx4304KvvWuMdk/vxNvf/041pAdTDqY6U8+gLIBOh0ski1
	 ftQvUh4u8BdxHod2V4WZTic1/r8p6fJYQwB2brgFPC5Mcgw1TFgh5j87/YLkpn5s39
	 rMVHK3fj6jqS4qwzbyzwIR4j4PkH8umSaenjI26Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240229063302epcas1p42e6d3d9c692c79155d8df8ba2869903e~4QcclDI0Z1828918289epcas1p4f;
	Thu, 29 Feb 2024 06:33:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp1.localdomain
	(Postfix) with ESMTP id 4TlhHL0xMpz4x9Q1; Thu, 29 Feb 2024 06:33:02 +0000
	(GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240229061851epcas1p322a63f7a3054c04d705d2477662fdd83~4QQEoS-Qj0446104461epcas1p3d;
	Thu, 29 Feb 2024 06:18:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240229061851epsmtrp14b59c1a1d03eeaf9768c459931438c0a~4QQEnmqWd2605026050epsmtrp1E;
	Thu, 29 Feb 2024 06:18:51 +0000 (GMT)
X-AuditID: b6c32a52-445fe700000049fb-c5-65e021cbc7a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.0B.18939.BC120E56; Thu, 29 Feb 2024 15:18:51 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240229061851epsmtip2aa0e0951c6aa3b11ece3026a4dd36cc7~4QQEcpnYX1344013440epsmtip2j;
	Thu, 29 Feb 2024 06:18:51 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>
In-Reply-To: <PUZPR04MB6316C5AC606AABE0E08AC2A6819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Date: Thu, 29 Feb 2024 15:18:51 +0900
Message-ID: <1296674576.21709188382123.JavaMail.epsvc@epcpadp4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIfxebMD6UYdPmI+M/4/SiS2NYnhQLVrQrasH9v2qA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSvO5pxQepBkdu6li0HtnHaPHykKbF
	xGlLmS327D3JYrHl3xFWi48PdjNaXH/zkNWB3WPTqk42j74tqxg92ifsZPb4vEkugCWKyyYl
	NSezLLVI3y6BK2Plp/mMBbd4K148vs3UwPiYq4uRk0NCwESi9+sj5i5GLg4hge2MEnMO/mTv
	YuQASkhJHNynCWEKSxw+XAxR8pxRonP5C0aQXjYBXYknN34yg9giAqYSXy6fYAOxmQVCJX7e
	2cUOYgsJrGOUaF3kBmJzCsRKHFy1lhFkprCAj8SZHf4gYRYBVYnldyaClfMKWEpMfbOLBcIW
	lDg58wkLxEhtiac3n8LZyxa+ZoY4X0Fi96ejrBAnWElcnfOZFaJGRGJ2ZxvzBEbhWUhGzUIy
	ahaSUbOQtCxgZFnFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJERw1WkE7GJet/6t3iJGJg/EQ
	owQHs5IIr4zg3VQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYO
	TqkGpqyztvuOHV+eOoFPIMX2/NW575jWJ4aIXL0dZKMxs3uf8Maoglk7DXbd4OFiVBO7KLVV
	TOJwXlx7VaLUHiNm1dxF/zfFdzdo9q17u+vQr615hbGvpITXs8x4qKEz+3/P64m/PiY+qzzJ
	6lv3t8T9bt8C/+8egVOYLrN+4jSRsgz8f0vsvPMcxaX/7UKf6tes8EuJ+LNvfeYdPa769DqZ
	4xLcKTv/WnzbrRx6NtgoT/do160bRbPdJ+7s8l2aMaHDvf/pBp+j118q3XS81Tpz4r3eLZ+C
	bl5P2KdWeqzyyhyNvsshC0+dX5x1V/u29obM+Ic6H70D5v7Vbqy46pt5ewa778+yZx6n9vMm
	HTvyZJ0SS3FGoqEWc1FxIgBo+6NACQMAAA==
X-CMS-MailID: 20240229061851epcas1p322a63f7a3054c04d705d2477662fdd83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20231228065938epcas1p3112d227f22639ca54849441146d9bdbf
References: <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcas1p3.samsung.com>
	<PUZPR04MB6316C5AC606AABE0E08AC2A6819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>

> This helper is used to lookup empty dentry set. If there are no enough
> empty dentries at the input location, this helper will return the number
> of dentries that need to be skipped for the next lookup.
>=20
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> ---
>  fs/exfat/dir.c      | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/exfat/exfat_fs.h |  3 ++
>  2 files changed, 80 insertions(+)
>=20
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c index
> cea9231d2fda..a5c8cd19aca6 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -950,6 +950,83 @@ int exfat_get_dentry_set(struct exfat_entry_set_cach=
e
> *es,
>  =09return -EIO;
>  }
>=20
> +static int exfat_validate_empty_dentry_set(struct exfat_entry_set_cache
> +*es) {
> +=09struct exfat_dentry *ep;
> +=09struct buffer_head *bh;
> +=09int i, off;
> +=09bool unused_hit =3D false;
> +
> +=09for (i =3D 0; i < es->num_entries; i++) {
> +=09=09ep =3D exfat_get_dentry_cached(es, i);
> +=09=09if (ep->type =3D=3D EXFAT_UNUSED)
> +=09=09=09unused_hit =3D true;
> +=09=09else if (IS_EXFAT_DELETED(ep->type)) {

Although it violates the specification for a deleted entry to follow an unu=
sed
entry, some exFAT implementations could work like this.

Therefore, to improve compatibility, why don't we allow this?
I believe there will be no functional problem even if this is allowed.

> +=09=09=09if (unused_hit)
> +=09=09=09=09goto out;
> +=09=09} else {
> +=09=09=09if (unused_hit)
> +=09=09=09=09goto out;
Label "out" does not look like an error situation.
Let's use "out_err" instead of "out".

> +
> +=09=09=09i++;
> +=09=09=09goto count_skip_entries;
> +=09=09}
> +=09}
> +
> +=09return 0;



