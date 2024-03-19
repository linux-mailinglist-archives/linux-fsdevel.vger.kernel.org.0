Return-Path: <linux-fsdevel+bounces-14819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC788800E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDC61F218CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DB657CC;
	Tue, 19 Mar 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="csn78fzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61081AC2;
	Tue, 19 Mar 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863007; cv=none; b=JrpyF6gMvIf43fFRdhnUJuMibXS64df21Ws7V5RZb2P0nikV6CNizOAkkjRLq9uBbWc2BC84WZ92whQFs3b/qzYpMWXCS0m+g8xMtsV88i9ojm9iZVajSk1Q7gfSVPTfQiTJargLS3rjkEb/dpkduNmKDJdw2yQ2I/HIcztNqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863007; c=relaxed/simple;
	bh=mKl+KknZfH00zqLtAK5vBmrNkwKBmkUtDal8f4RF87E=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=mGVYTPv383IHQRju+4FzvrZu8wrCP+vFHf0RIo9MCNALmMEaSlJBC0HiKrmHg6GW6x5SK3xWYeH90zcTXyrSn3VlJNBxuhAZkANEsWHpXl7AO1OCPJiujQgzn7wN2/Pg97w8YkM3bT0FrRYAgv1nN0ebABeg1Mti4NAS+poiObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=csn78fzB; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240319154316euoutp01038718aeea66d1ecbabb2a604adb9afd~_NNS3hRSf1009310093euoutp015;
	Tue, 19 Mar 2024 15:43:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240319154316euoutp01038718aeea66d1ecbabb2a604adb9afd~_NNS3hRSf1009310093euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710862996;
	bh=AS6iYt5Z3OUVSOXuK7Jk0QEzzPsK1Am2oZk5Lkk21io=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=csn78fzBk6InC2XSHK1DisaRp80+luW2GYs7C3K9UhSIeQH1gKDGTV7Hz8VeI2giv
	 cy0TZl78mvv6ZgEnd+9pfDO/0EZJgA6ztr8Rkj/R5wE8oCoIOotssXCFj2YuFp5Ghk
	 98d8jF5bUh6djxphySp9V7Yx2hOot7BpYHujE+MQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240319154316eucas1p280faeada383fcdd6678ac05a30eef6d0~_NNSrI9gL0631106311eucas1p2B;
	Tue, 19 Mar 2024 15:43:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C9.0A.09814.492B9F56; Tue, 19
	Mar 2024 15:43:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240319154316eucas1p1e84e6f0657516d620f2b50ff06d1b8c4~_NNSR86HQ1679816798eucas1p1T;
	Tue, 19 Mar 2024 15:43:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240319154316eusmtrp247465fb0aa3b2d17317cbdd288b8ed6b~_NNSRXutL1693316933eusmtrp27;
	Tue, 19 Mar 2024 15:43:16 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-1e-65f9b294f2ad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.1F.10702.392B9F56; Tue, 19
	Mar 2024 15:43:15 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240319154315eusmtip1a931f69e6cfa9556f8c8fe870acda115~_NNSHOvM12723827238eusmtip1V;
	Tue, 19 Mar 2024 15:43:15 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 15:43:14 +0000
Date: Tue, 19 Mar 2024 16:43:12 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/4] sysctl: move sysctl type to ctl_table_header
Message-ID: <20240319154312.amfmomddvjyqh5yc@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="6v64fw4r57zc557r"
Content-Disposition: inline
In-Reply-To: <20240222-sysctl-empty-dir-v1-2-45ba9a6352e8@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87pTNv1MNfj2RMTi/7YWdosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMrowOYxu+Eii8emVZ1sHp83yXn0dx9j95hyqJ0lgDWKyyYl
	NSezLLVI3y6BK6Nl4zLGgoWaFVc+zWJuYHyq2MXIySEhYCKx6eUMti5GLg4hgRWMErc7njGC
	JIQEvjBKLHkhCpH4zChx9k47K0zH5LvdrBCJ5YwSJx5/ZYarunV/BhOEs5VRomvGLTaQFhYB
	VYlVzbuYQGw2AR2J82/uMIPYIgI2Eiu/fWYHaWAW2MsoMevFfCCHg0NYwFVi/eJ6kBpeAQeJ
	q1v+sUPYghInZz5hAbGZBSokjr/bzAxSziwgLbH8HweIySngKdH4hhfiUGWJ6/sWs0HYtRKn
	ttwCO01CYDKnxJSbW5ggEi4SvbP/MkLYwhKvjm9hh7BlJP7vnA/TwCix/98HdghnNaPEssav
	UN3WEi1XnkB1OEpc/biJCeQKCQE+iRtvBSHu5JOYtG06M0SYV6KjTQiiWk1i9b03LBMYlWch
	+WwWks9mIXwGEdaTuDF1ChuGsLbEsoWvmSFsW4l1696zLGBkX8UonlpanJueWmyUl1quV5yY
	W1yal66XnJ+7iRGYvk7/O/5lB+PyVx/1DjEycTAeYlQBan60YfUFRimWvPy8VCURXnbun6lC
	vCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTKVfgzgEVjH9
	sErbGznp5IUZ71Y6cT7M3/Zix+bVN14bOOc5f4i1OD8ll+3fVce5XXa87tyvUsT2/Gk4ZLAs
	JPtUwJrcp/UuRedzryRYL9O7//Wn9sxjKxv1v2j+3dmYp52ziuH68VUbDM5wy90uufhmzxFZ
	Y47EizFrNQwL9iosmmoRxJrUn3CJi1M2e64cT3pWQAH/3aVBr3dmL7v8bmNgT0N2xfOiKypC
	vcvl/P8ZrulaJ9TjXeSsGGCUXPt1Imfj9t1qvYfqfS1K/u99x7N08/wHl2rvMMezWF1wnTrz
	7yb75MmKW5z3qWlNe/0o7Mnm1te35qTPn/M0XqZS/lBckn7Ie47WFdybZf4rcSmxFGckGmox
	FxUnAgDwI79W2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7qTN/1MNZi9z8ri/7YWdosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMrowOYxu+Eii8emVZ1sHp83yXn0dx9j95hyqJ0lgDVKz6Yo
	v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P+gyWMBfM1
	K37MWs/awPhYsYuRk0NCwERi8t1u1i5GLg4hgaWMEqtmvGSESMhIbPxylRXCFpb4c62LDcQW
	EvjIKHF0VxFEw1ZGiVm/PjOBJFgEVCVWNe8Cs9kEdCTOv7nDDGKLCNhIrPz2mR2kgVlgL1DD
	i/lADgeHsICrxPrF9SA1vAIOEle3/GOHGHqbUWLdu2YmiISgxMmZT1hAbGaBMontB9cxgfQy
	C0hLLP/HAWJyCnhKNL7hhbhTWeL6vsVsEHatxOe/zxgnMArPQjJoFpJBsxAGQYR1JHZuvcOG
	IawtsWzha2YI21Zi3br3LAsY2VcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExvC2Yz+37GBc
	+eqj3iFGJg7GQ4wqQJ2PNqy+wCjFkpefl6okwsvO/TNViDclsbIqtSg/vqg0J7X4EKMpMBAn
	MkuJJucDk0teSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAMT59ec
	i+4nJ63zCtiUEP1UM+4l45OOndLZyv0b+5gWZOwRuVXXyhHTwCz/T7SvaOe97813kh7Yiy2y
	tRFS/f+wyDFM39VlUh/L358Ldp2JjPvuJKmudnLndXdN1yKOgkq3+DyOlw/LAxq2c3sK31A/
	sqFpcsXPdNtLQc8t2+0/zvZ+GWi/+u/tu7NTwwWOJGlmfFj0M/bte4v0Ch7xJ6ls7C/ehhzw
	l/lqvls6w4Vxhrai5K2U4vjUGQcnKYmemuy3TuflfutrZaXu/rfU9Zd1Z/cVHT6+ZMHHj1lz
	Hj9yF1XPf/tKYNq3kq0PVsRytaQ35t/5a7T5eMe2zDbxhk9MZUfmFvfv7lEISJAJP6/EUpyR
	aKjFXFScCABrDvn9dgMAAA==
X-CMS-MailID: 20240319154316eucas1p1e84e6f0657516d620f2b50ff06d1b8c4
X-Msg-Generator: CA
X-RootMTR: 20240222070824eucas1p1e0a6b38607370cf7b1cca4d07de474f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240222070824eucas1p1e0a6b38607370cf7b1cca4d07de474f2
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
	<CGME20240222070824eucas1p1e0a6b38607370cf7b1cca4d07de474f2@eucas1p1.samsung.com>
	<20240222-sysctl-empty-dir-v1-2-45ba9a6352e8@weissschuh.net>

--6v64fw4r57zc557r
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 08:07:37AM +0100, Thomas Wei=DFschuh wrote:
> As static initialization of the is not possible anymore move it into
> init_header() where all the other header fields are also initialized.
Please say what was done. Something like: "Moved the
SYSCTL_TABLE_TYPE_{DEFAULT,PERMANENTLY_EMPTY} enumerations from
ctl_table to ctl_table_header."

And the then you can mention the why: "Removing the mutable memeber from
ctl_table opens the ...."

>=20
> Reduce memory consumption as there are less instances of
> ctl_table_header than ctl_table.
This is indeed true, but the main reasoning behind this is
constification. Right? If you want to leave this comment, I would
suggest you add something that talks about the amount of bytes saved.
Something like : "Reduce memory consumption by sizeof(int) for every
ctl_table entry in ctl_table_header". Or something similar.

>=20
> Removing this mutable member also opens the way to constify static
> instances of ctl_table.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c  | 10 ++++++----
>  include/linux/sysctl.h | 22 +++++++++++-----------
>  2 files changed, 17 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 2f4d4329d83d..fde7a2f773f0 100644
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
> @@ -208,6 +208,8 @@ static void init_header(struct ctl_table_header *head,
>  			node++;
>  		}
>  	}
> +	if (table =3D=3D sysctl_mount_point)
> +		sysctl_set_perm_empty_ctl_header(head);
>  }
> =20
>  static void erase_header(struct ctl_table_header *head)
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index ee7d33b89e9e..c87f73c06cb9 100644
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
> +		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY,
> +	} type;
>  };
> =20
>  struct ctl_dir {
>=20
> --=20
> 2.43.2
>=20

--=20

Joel Granados

--6v64fw4r57zc557r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5so8ACgkQupfNUreW
QU8aYAv/UprU+nc9BoDYqe8bRl+/aiJFFJI4z9YvG8q+qmQxbxNrAvEq8cn0Qo76
qpjwbEvuYO+HbisUuzX7F6I/fu6zH3djnbNP6Q+NhZRRVxFWskzfH9IOCoemJfxD
a47KEf3HbUy5sLVHsNmucJBgXRtH/mIx2Da8UFRn1BhW3TQgoguO0ZzgsyO7JQbL
8ar2SKzCY8YzS5IgiuEOEBvEDM0bMaFq8R3Af9TizlXh95lOsncgq383khl4dNjg
9xJUXW0Dv9gxrQVMb+Z2F7qLVSLEJIgVjI/m0dbY0mbWL/U8bY1mlggjrZ2RTja9
CHTVQsrpuHmie4m3bWKDxs704qJcvKxR84jUE8ZakiwQYOJFjYKd+tyfC09k8ehm
DJ1NCih93QK/ZWjuAF4l7hAiiUvB7+678F3Eufee3aZeHHHc+kRiiZ5wk4GnlBWY
oNeYTPMH6LVI0bUJBly5d6l8tZ+SCYyUgwly7ZeGfD8B3Onve2PgcdqkKIHH7Bbk
giNcBVa9
=WYc3
-----END PGP SIGNATURE-----

--6v64fw4r57zc557r--

