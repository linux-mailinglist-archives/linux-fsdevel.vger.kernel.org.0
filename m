Return-Path: <linux-fsdevel+bounces-15073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1257886C24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B07283195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB544315A;
	Fri, 22 Mar 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CfMdGlK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85844DF4A;
	Fri, 22 Mar 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110780; cv=none; b=jXZQbngrZKOb8nfWFIDgLL+w+kyW+TEOGezB43NSmXrGYQlH8gPJQr9T1hi4fmU+9HTPXUNRTsAypZSmPqiJHVxnSzCNRLhxa38dBZ+eMCvC7RIPlUnwPR1pSLUsZgQpZgNPLO0+9ym6ttjjOjrE2Ij+rmACAPl4Hdnj8mN02zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110780; c=relaxed/simple;
	bh=PXuKlHhR0rmIvfh4GOdhC5xMukDBTJzH8gQ4WFtG6vE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=FPql8NYS8rLV3UYWxGsZJaY5IX2RJdKaWyoWyNJJAz2xr3bscKKu4dUplN3DArxCApwtyNIwmQpTMU07p6mHVlb7p3KFANlhokNCz2Y2NBm9Pn9SOuTkV4+1EThOUrTxHyImAP5heVKY6FxTOX/L7YdUxCInGnI3Xw2mzNT/oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CfMdGlK3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240322123250euoutp02081a57b24397ba21136c1b21f7f9e21f~-Fi38aX2A1168711687euoutp02O;
	Fri, 22 Mar 2024 12:32:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240322123250euoutp02081a57b24397ba21136c1b21f7f9e21f~-Fi38aX2A1168711687euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711110770;
	bh=MOUxdcjbFgurg/K2m4yHjaRurqkgz9QnPyQZuqj01dg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CfMdGlK3S3TOzua/sPBMidRB995/6Rs8LdqJD/T1EXknesCOxLNX8xcduQPBhNYjt
	 x4ouqssqZmnJ2hW118vlt7jjSfkH+lrjXZUYZPQcW9HTyi/bC5EEUKJxg5BVlUP7rx
	 268LdbfM0UI7cqW4BTOjsOneLnYWXU0EjDuM3idY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240322123249eucas1p1e9609d790d5749de34403cec87d0d1f4~-Fi3rVxyn2695626956eucas1p1h;
	Fri, 22 Mar 2024 12:32:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.CF.09814.17A7DF56; Fri, 22
	Mar 2024 12:32:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240322123249eucas1p2c0f47dbdf2e726d51676507c466a28a6~-Fi3NYOeg2864028640eucas1p25;
	Fri, 22 Mar 2024 12:32:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240322123249eusmtrp10a9a3c3c08395bb2edf90d934a448d97~-Fi3MiarW1391313913eusmtrp1U;
	Fri, 22 Mar 2024 12:32:49 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-b2-65fd7a71f329
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.43.10702.17A7DF56; Fri, 22
	Mar 2024 12:32:49 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240322123249eusmtip19f189b2e3fedcffa72acab8eef83d240~-Fi3Aqy3T1666116661eusmtip1p;
	Fri, 22 Mar 2024 12:32:49 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 22 Mar 2024 12:32:48 +0000
Date: Fri, 22 Mar 2024 13:32:46 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] sysctl: treewide: constify argument
 ctl_table_root::permissions(table)
Message-ID: <20240322123246.bxxgiiwb3hjbmvb2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="6v6kdadjlfixw7rp"
Content-Disposition: inline
In-Reply-To: <20240315-sysctl-const-ownership-v3-2-b86680eae02e@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qFVX9TDY6261nMOd/CYvH02CN2
	izPduRYXtvWxWuzZe5LF4vKuOWwWv388Y7K4MeEpo8WxBWIW306/YXTg8pjdcJHFY8vKm0we
	CzaVemxa1cnm8X7fVTaPz5vkPPq7j7EHsEdx2aSk5mSWpRbp2yVwZeybuo2pYKZexYIPn5ka
	GLvVuhg5OCQETCTWHy3vYuTiEBJYwSgx8fw+NgjnC6PE8tnHWSCcz4wSG5s+sncxcoJ19B+e
	D5VYziix89wUhKq5jZeYIZytjBIbuq4xgSxhEVCVuD2BC6SbTUBH4vybO8wgtoiAjcTKb5/Z
	QeqZBfYxSXy82Aa2QlggReLB4fVMIDavgIPEwa/T2SBsQYmTM5+wgNjMAhUSf57sBZvPLCAt
	sfwfB0iYU8BfYvPic4wQlypLXN+3mA3CrpU4teUWE8guCYHdnBJtW/qhEi4SG87sYoawhSVe
	Hd8C9aaMxOnJPSwQDZMZJfb/+8AO4axmlFjW+JUJospaouXKE6gOR4m+H5tYIMHKJ3HjrSDE
	oXwSk7ZNZ4YI80p0tAlBVKtJrL73hmUCo/IsJK/NQvLaLITXIMJ6EjemTmHDENaWWLbwNTOE
	bSuxbt17lgWM7KsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE9/pf8e/7GBc/uqj3iFG
	Jg7GQ4wqQM2PNqy+wCjFkpefl6okwrvj/59UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKp
	QgLpiSWp2ampBalFMFkmDk6pBqamx3GOD6IkTG/c/TvxQsi+hMt99ySe3zG6m5mzUMyZ9T3v
	VvPdIbWv924zLN92WoFthd1E+etqfJt3cbv+8u1rafkvv08jRZpjyw3XOqbrCqvUbf9mpOxz
	3uCUaxjOb3z5ls9ReYYOMw/5c6UMe/g9Xuxi1U1vWX7wyKTr+yW1OnhFf4c4uCRN82LT9i3Z
	uD/S0m0pv7Is953yP03pEi82373u17amZvLjL3d4tFbMu3czd9LfdZeMZ3Z/XHS7W+/uUn72
	6phpzCLrI+94bbQW6JpxWlI8yJM7eE/FhuYsu9dbVadP2pV8fpbeodzbmfsLDkYcq4iLPrhm
	20POrXc/bbyWNuWw8xzVNbOEbsQrsRRnJBpqMRcVJwIA3ksZoPcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd3Cqr+pBo+bhSzmnG9hsXh67BG7
	xZnuXIsL2/pYLfbsPclicXnXHDaL3z+eMVncmPCU0eLYAjGLb6ffMDpwecxuuMjisWXlTSaP
	BZtKPTat6mTzeL/vKpvH501yHv3dx9gD2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUM
	jc1jrYxMlfTtbFJSczLLUov07RL0Mh7P2sNSMF2vYseV60wNjJ1qXYycHBICJhL9h+ezdDFy
	cQgJLGWUWPX0PDNEQkZi45errBC2sMSfa11sEEUfGSX+ztgK5WxllDgycR17FyMHB4uAqsTt
	CVwgDWwCOhLn39wBGyQiYCOx8ttndpB6ZoF9TBIfL7axgySEBVIkHhxezwRi8wo4SBz8Oh1q
	6HNGiS07t7BDJAQlTs58wgJiMwuUSay4epgZZBmzgLTE8n8cIGFOAX+JzYvPMUJcqixxfd9i
	Ngi7VuLz32eMExiFZyGZNAvJpFkIkyDCOhI7t95hwxDWlli28DUzhG0rsW7de5YFjOyrGEVS
	S4tz03OLjfSKE3OLS/PS9ZLzczcxAuN/27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CUYsnL
	z0tVEuHd8f9PqhBvSmJlVWpRfnxRaU5q8SFGU2AoTmSWEk3OByamvJJ4QzMDU0MTM0sDU0sz
	YyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpgk8nx1yNy1lWeLTsir53zGOTtG0qzJb9FYI
	Ld62+YHJ4uvVCzn+PD6tsn3lM8PChZ93x3C/Z6zPSAziXv71s2Fp0zJN9dNZardeHrG59E1m
	23qhkpcTF2SJNhY6f/UOEp/YLHFtkfXubVYtZ4/nh+yW2eB/12XJYtZ/3M2rtjx2uRqybdIM
	s1OGm3iTT0283rote8GDR9EB3sw9Z0s0jLhaGteWRyhaP8pJuX/AWjZc9NpZ3UnBhbz366d0
	bwvVPVseIumRz+Fbz81225k7z2eL9Nk874duW989CH6W19BmcmhGscBNw5vHUxJmBN9KOiax
	QElwfVpz0v1l4rwH1vsYvPatleJdy/92t+WfaiWW4oxEQy3mouJEAAhTRpmUAwAA
X-CMS-MailID: 20240322123249eucas1p2c0f47dbdf2e726d51676507c466a28a6
X-Msg-Generator: CA
X-RootMTR: 20240315181140eucas1p229d306ff1d983bb302d24631e4381c5e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240315181140eucas1p229d306ff1d983bb302d24631e4381c5e
References: <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
	<CGME20240315181140eucas1p229d306ff1d983bb302d24631e4381c5e@eucas1p2.samsung.com>
	<20240315-sysctl-const-ownership-v3-2-b86680eae02e@weissschuh.net>

--6v6kdadjlfixw7rp
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 07:11:31PM +0100, Thomas Wei=DFschuh wrote:
> The permissions callback is not supposed to modify the ctl_table.
> Enforce this expectation via the typesystem.
>=20
> The patch was created with the following coccinelle script:
>=20
>   @@
>   identifier func, head, ctl;
>   @@
>=20
>   int func(
>     struct ctl_table_header *head,
>   - struct ctl_table *ctl)
>   + const struct ctl_table *ctl)
>   { ... }
>=20
> (insert_entry() from fs/proc/proc_sysctl.c is a false-positive)
>=20
> The three changed locations were validated through manually inspection
> and compilation.
Will remove this when I add it to constfy branch as it is unclear (for
me) what "manually inspection" is and also I do not know what config you
used to compile. IMO, we can just do without it.

>=20
> In addition a search for '.permissions =3D' was done over the full tree to
> look for places that were missed by coccinelle.
> None were found.
>=20
> This change also is a step to put "struct ctl_table" into .rodata
> throughout the kernel.

This LGTM. Will add this to the constfy testing branch with these
changes in the commit message:
"""
sysctl: treewide: constify argument ctl_table_root::permissions(table)

The permissions callback should not modify the ctl_table. Enforce this
expectation via the typesystem. This is a step to put "struct ctl_table"
into .rodata throughout the kernel.

The patch was created with the following coccinelle script:

  @@
  identifier func, head, ctl;
  @@

  int func(
    struct ctl_table_header *head,
  - struct ctl_table *ctl)
  + const struct ctl_table *ctl)
  { ... }

(insert_entry() from fs/proc/proc_sysctl.c is a false-positive)

No additional occurances of '.permissions =3D' were found after a
tree-wide search for places missed by the conccinelle script.

"""

Reviewed-by: Joel Granados <j.granados@samsung.com>
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  include/linux/sysctl.h | 2 +-
>  ipc/ipc_sysctl.c       | 2 +-
>  ipc/mq_sysctl.c        | 2 +-
>  kernel/ucount.c        | 2 +-
>  net/sysctl_net.c       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 60333a6b9370..f9214de0490c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -206,7 +206,7 @@ struct ctl_table_root {
>  	struct ctl_table_set *(*lookup)(struct ctl_table_root *root);
>  	void (*set_ownership)(struct ctl_table_header *head,
>  			      kuid_t *uid, kgid_t *gid);
> -	int (*permissions)(struct ctl_table_header *head, struct ctl_table *tab=
le);
> +	int (*permissions)(struct ctl_table_header *head, const struct ctl_tabl=
e *table);
>  };
> =20
>  #define register_sysctl(path, table)	\
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 1a5085e5b178..19b2a67aef40 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -204,7 +204,7 @@ static void ipc_set_ownership(struct ctl_table_header=
 *head,
>  	*gid =3D gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
>  }
> =20
> -static int ipc_permissions(struct ctl_table_header *head, struct ctl_tab=
le *table)
> +static int ipc_permissions(struct ctl_table_header *head, const struct c=
tl_table *table)
>  {
>  	int mode =3D table->mode;
> =20
> diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
> index 6bb1c5397c69..43c0825da9e8 100644
> --- a/ipc/mq_sysctl.c
> +++ b/ipc/mq_sysctl.c
> @@ -90,7 +90,7 @@ static void mq_set_ownership(struct ctl_table_header *h=
ead,
>  	*gid =3D gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
>  }
> =20
> -static int mq_permissions(struct ctl_table_header *head, struct ctl_tabl=
e *table)
> +static int mq_permissions(struct ctl_table_header *head, const struct ct=
l_table *table)
>  {
>  	int mode =3D table->mode;
>  	kuid_t ns_root_uid;
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 4aa6166cb856..90300840256b 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -38,7 +38,7 @@ static int set_is_seen(struct ctl_table_set *set)
>  }
> =20
>  static int set_permissions(struct ctl_table_header *head,
> -				  struct ctl_table *table)
> +			   const struct ctl_table *table)
>  {
>  	struct user_namespace *user_ns =3D
>  		container_of(head->set, struct user_namespace, set);
> diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> index a0a7a79991f9..f5017012a049 100644
> --- a/net/sysctl_net.c
> +++ b/net/sysctl_net.c
> @@ -40,7 +40,7 @@ static int is_seen(struct ctl_table_set *set)
> =20
>  /* Return standard mode bits for table entry. */
>  static int net_ctl_permissions(struct ctl_table_header *head,
> -			       struct ctl_table *table)
> +			       const struct ctl_table *table)
>  {
>  	struct net *net =3D container_of(head->set, struct net, sysctls);
> =20
>=20
> --=20
> 2.44.0
>=20

--=20

Joel Granados

--6v6kdadjlfixw7rp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX9em0ACgkQupfNUreW
QU+JRQv/R0MDqGXzC3NYKMv+wIm47Ltk3eMtQmkY12yK0OcF47dm6WzpobwWXL+f
4n5LwquGatNednUTNHw8HOhGxtfHvqJo34aNgfGKQXF9wsKVBVPNUrCA9R1exdb6
+M9Q0NrLC2cOMR19BxLjQPH2AABzcHzR3Q48d6vtFbAw3URWGPO387tmQFbvr3g4
26dmdaTKhmtzBRLWTdQp6sqQhDt1b2GCr1CL9bvlUTEJf7b7FD6F7/t29Of5O3YZ
8XJbhlzGvh8kcvAdGokSURjInmZjp2aSpeyCJjY7e6VqghFTi975qc5Tnf286Nw8
iZBavNVO21hioGmYu/7ZvlZIv2/zuPKKCQpmqZPu6E2XR9AtNzFT3NODvhYV1Gsh
/QvkKYFRHsMWIPtmaXBRG29Br/BDQkZG43OoT6KATZ9piTP8G50OrbWNLZZmouy+
P/sRR2UXvnOHTYUXX4pFUnV7LUDbUJU2aIsY0Bsr0ChyS+pUEQwo4NUCEYptJKXM
aGTz0BJL
=QTWi
-----END PGP SIGNATURE-----

--6v6kdadjlfixw7rp--

