Return-Path: <linux-fsdevel+bounces-5146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEF8087D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3EFB214AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28893D0AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BbOHq0vN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE110C4;
	Thu,  7 Dec 2023 03:31:13 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231207113112euoutp029900412f10484f3ca5a51062bbc5f7a6~eiUzPPxN11146011460euoutp02i;
	Thu,  7 Dec 2023 11:31:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231207113112euoutp029900412f10484f3ca5a51062bbc5f7a6~eiUzPPxN11146011460euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701948672;
	bh=LQbsCB2xkDlZrVSHuSbYgEXZy2Mk/5QJLXPD/YcUQ/I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BbOHq0vNAsLVh1rT9jh5jrbUFfNdw6mLl7M7nmCKpui8r92Nu/u2zviKPJ9g73OTf
	 8QGLvDuLLwVnlocFDE/Aq99jMXv3SDy3reT7pK+kAi0t/yhv7DOXVQmd4e4I5Cq4vG
	 DLk6/rWE7YMg8oj7A5qtGbmceDUCYNPpNR2EKhRo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231207113112eucas1p2262dec4c91d359055358e432181bc448~eiUzErjVq0649006490eucas1p29;
	Thu,  7 Dec 2023 11:31:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C9.4E.09539.FFCA1756; Thu,  7
	Dec 2023 11:31:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207113111eucas1p2d8a3b27e91bf4cf00c33d717cdd2bf9e~eiUypFNtt0649006490eucas1p28;
	Thu,  7 Dec 2023 11:31:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207113111eusmtrp170fae65246d78fbbaafb0bfdf99ee506~eiUyoex6E2693926939eusmtrp1A;
	Thu,  7 Dec 2023 11:31:11 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-63-6571acffbd08
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.77.09274.FFCA1756; Thu,  7
	Dec 2023 11:31:11 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231207113111eusmtip2d4e87ab44d7318d3da608777a9f1fcc5~eiUycspVC1212812128eusmtip2X;
	Thu,  7 Dec 2023 11:31:11 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 11:31:10 +0000
Date: Thu, 7 Dec 2023 12:31:09 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <20231207113109.dc4fpaaenk7z7hmu@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ce6zcdvlndypsxv7"
Content-Disposition: inline
In-Reply-To: <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7r/1xSmGvS8MbNoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfGtc/fWQr2qVdMOTyJrYFxrkIXIweHhICJ
	xKEfal2MXBxCAisYJV6umskG4XxhlJg17TIThPOZUWLt63ZGmI7126og4ssZJeYd/80GV3R5
	/wagIk4gZzOjxJclniA2i4CKxJU3J8DibAI6Euff3GEGsUUEbCRWfvvMDtLMLLCLSeLxw7lM
	IAlhAS+JG9OWgzXwCphLvFr9jwnCFpQ4OfMJC8gVzAIVEhOmOEGY0hLL/3GAVHAKuElMPNvH
	DmJLCChJHJ78mRnCrpU4teUW2DMSAus5JR686WGESLhIXJ34kQXCFpZ4dXwLVLOMxOnJPSwQ
	DZMZJfb/+8AO4axmlFjW+JUJospaouXKE6gOR4nuTY3skCDik7jxVhAkzAxkTto2nRkizCvR
	0SYEUa0msfreG5YJjMqzkHw2C+GzWQifzQKboydxY+oUNgxhbYllC18zQ9i2EuvWvWdZwMi+
	ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzC9nf53/NMOxrmvPuodYmTiYDzEqALU/GjD
	6guMUix5+XmpSiK8OefzU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeWpGanphak
	FsFkmTg4pRqYWq34q2SqxQUuuqk1xGj2nnTt3azFxX//qVuHmXbPN1VP61uyfkxzT6dk7pzn
	O8H1aZgn35umC6+3MWya+sZiaqT+JuONKhJP3ixbyb5s8nMxm/Ubty7v/zrt1JbMYzIbXog5
	N93f6P6i9PSMliI/zV3rNe7/PfjLntN2KvPlS7rvd85KLmUM/1ObZ5V5MvD0iqqEOZGl/E+z
	mWaV5DI27rpyLbwjo/yW2lO7NjvR+FUOBWtUbZ7yfdUU226654hQVYQHg9O+71ccLq01dK+v
	nXWhTcZQYJvVTl2PibvWrUxqD/jcz/vEdO1pdS72FY4m1otnTkwQDVQXu32N+7S8hJnefZ7H
	fnNrl80/98tCiaU4I9FQi7moOBEAJxpvq+oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7r/1xSmGnzpl7ZoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7GyqXX2Qr2qFfM3TmZtYFxtkIXIweHhICJxPptVV2MXBxCAksZJT6/3Mja
	xcgJFJeR2PjlKpQtLPHnWhcbRNFHRonNj3ayQzibGSVuv//GDlLFIqAiceXNCUYQm01AR+L8
	mzvMILaIgI3Eym+fwRqYBXYxSTx+OJcJJCEs4CVxY9pysAZeAXOJV6v/gcWFBK4wSpy/LwcR
	F5Q4OfMJC4jNLFAmcffJJHaQs5kFpCWW/+MACXMKuElMPNvHDnGpksThyZ+ZIexaic9/nzFO
	YBSehWTSLCSTZiFMggjrSOzceocNQ1hbYtnC18wQtq3EunXvWRYwsq9iFEktLc5Nzy020itO
	zC0uzUvXS87P3cQIjPRtx35u2cG48tVHvUOMTByMhxhVgDofbVh9gVGKJS8/L1VJhDfnfH6q
	EG9KYmVValF+fFFpTmrxIUZTYChOZJYSTc4HpqC8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB
	9MSS1OzU1ILUIpg+Jg5OqQYmL6frarlhbYVLmzpZXCeeCdZIztY3MmwI5tYpq+H7Jx/Fd9iE
	wfmtkJzarJa9i6S0o4uUn998vnXmE27D5Rt3rL8z+feW2LPL59jtDrwdwueyU0JI6+ONmJJ3
	W6Nz55TyVpye387+nn+v89wlOr9TJn4WNJ00+VlTz/T6uWc0HKIjthqtK5x/S7Cv99oOWe0Q
	zR6dyOi9M3kn7FO5tyPsyDz7rSmHuVMzK3be/BjMbXadN3rV3ovMJz9EiGaf3OPplG1wSbFV
	9Jod35a/O38uObkwqn3BfI2TF6Wk2YJMivfrr+CUvX8tKqi+eOsGWWnZrfOUJ3VE1nwvLDtj
	0uWv+r7H6XSW+7HkL/ueV6YosRRnJBpqMRcVJwIAFw0JiIkDAAA=
X-CMS-MailID: 20231207113111eucas1p2d8a3b27e91bf4cf00c33d717cdd2bf9e
X-Msg-Generator: CA
X-RootMTR: 20231204075921eucas1p1ba1617c3d261249f38c78c8e3d96239c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075921eucas1p1ba1617c3d261249f38c78c8e3d96239c
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<CGME20231204075921eucas1p1ba1617c3d261249f38c78c8e3d96239c@eucas1p1.samsung.com>
	<20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>

--ce6zcdvlndypsxv7
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is the patch that I said could be on its own to facilitate review

On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Wei=DFschuh wrote:
> In a future commit the sysctl core will only use
> "const struct ctl_table". As a preparation for that move this mutable
> field from "struct ctl_table" to "struct ctl_table_header".
>=20
> This is also more correct in general as this is in fact a property of
> the header and not the table itself.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c  | 11 ++++++-----
>  include/linux/sysctl.h | 22 +++++++++++-----------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 689a30196d0c..a398cc77637f 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -31,7 +31,7 @@ static const struct inode_operations proc_sys_dir_opera=
tions;
> =20
>  /* Support for permanently empty directories */
>  static struct ctl_table sysctl_mount_point[] =3D {
> -	{.type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY }
> +	{ }
>  };
> =20
>  /**
> @@ -49,11 +49,11 @@ struct ctl_table_header *register_sysctl_mount_point(=
const char *path)
>  EXPORT_SYMBOL(register_sysctl_mount_point);
> =20
>  #define sysctl_is_perm_empty_ctl_header(hptr)		\
> -	(hptr->ctl_table[0].type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> +	(hptr->type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_set_perm_empty_ctl_header(hptr)		\
> -	(hptr->ctl_table[0].type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> +	(hptr->type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_clear_perm_empty_ctl_header(hptr)	\
> -	(hptr->ctl_table[0].type =3D SYSCTL_TABLE_TYPE_DEFAULT)
> +	(hptr->type =3D SYSCTL_TABLE_TYPE_DEFAULT)
> =20
>  void proc_sys_poll_notify(struct ctl_table_poll *poll)
>  {
> @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct =
ctl_table_header *header)
>  		return -EROFS;
> =20
>  	/* Am I creating a permanently empty directory? */
> -	if (sysctl_is_perm_empty_ctl_header(header)) {
> +	if (header->ctl_table =3D=3D sysctl_mount_point ||
> +	    sysctl_is_perm_empty_ctl_header(header)) {
Why do you have to check that it is equal to sysctl_mount_point? It
should be enough to make sure that the type of PERMANENTLY_EMPTY. no?

>  		if (!RB_EMPTY_ROOT(&dir->root))
>  			return -EINVAL;
>  		sysctl_set_perm_empty_ctl_header(dir_h);
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index ada36ef8cecb..061ea65104be 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -137,17 +137,6 @@ struct ctl_table {
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> -	/**
> -	 * enum type - Enumeration to differentiate between ctl target types
> -	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
> -	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
> -	 *                                       empty directory target to serve
> -	 *                                       as mount point.
> -	 */
> -	enum {
> -		SYSCTL_TABLE_TYPE_DEFAULT,
> -		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
> -	} type;
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
>  	void *extra1;
> @@ -188,6 +177,17 @@ struct ctl_table_header {
>  	struct ctl_dir *parent;
>  	struct ctl_node *node;
>  	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
> +	/**
> +	 * enum type - Enumeration to differentiate between ctl target types
> +	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
> +	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
> +	 *                                       empty directory target to serve
> +	 *                                       as mount point.
> +	 */
> +	enum {
> +		SYSCTL_TABLE_TYPE_DEFAULT,
> +		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
> +	} type;
>  };
> =20
>  struct ctl_dir {
>=20
> --=20
> 2.43.0
>=20

--=20

Joel Granados

--ce6zcdvlndypsxv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxrP0ACgkQupfNUreW
QU/4CAv9G2jBKR2NiolqAwAvYHcTmNPtwVxq2ZOsMh0bFWdGtUxskZkfYiMnjdc/
2SwCtBUjyweEacRbhiJdqYjWzjH8APKp0lpEze1CrHEZQ7Ug3Cq9UiK8+PFkD1Va
bdFZJaVx2jXbeYf47ZE4rWClgrSW9E/8KqgnimtkVIw4aidcI4Ixjw8Ral0DC38I
22ZeqJALOtg/ayF9Uy1waCayVj6rupZoVR3sePIVZm4CtYCzO9eL/STgK8ONRzol
A2beO02uZ6akJG9I0tzR2tZ6gvjTy1sTkTWBXKSGbKIVq2j2irRr16ek3i8Mr2PU
QLgkumQZQiC3/HzRxO9rf9bfSvRcr42LexCNfcZOi1rLhme/YKgF702c1aWn6kv1
QI5GSBn1Q0HU884O/+X9glIAG9vf7bb2DAd4Jo7rsJNsoSei4pLFYD65qj/lM9Jr
5xTZGcx6/JtW3eo8ToGvRDnbyZjvppoeXTmHNRH3PYIu37RnLKjQgUz3fvSd67C5
Kk+zmfLi
=rMjb
-----END PGP SIGNATURE-----

--ce6zcdvlndypsxv7--

