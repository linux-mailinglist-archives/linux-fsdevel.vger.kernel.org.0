Return-Path: <linux-fsdevel+bounces-15075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF095886C55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A38288244
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5300446BF;
	Fri, 22 Mar 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ica1Oo0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99B3FE28;
	Fri, 22 Mar 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111541; cv=none; b=jOqquJU2MQ1AD2ji1AqKjbGVLvX73PJJNM8CRHLdD5hfeUbX6HX+pOuvgMxhlBuOePW9gqt1MMh6OvL3t7DhMEeoHyGQ70D7NtwsQ9KypoQZeYS5H4oZHLcGQ5CjJL4i7rjbncZjDQf+rVZr9vFS9q78w31dKjuq//PJQeuUpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111541; c=relaxed/simple;
	bh=WRlQ5r4aUpj8Z+ex8QWCjyzTNRh/i/zc222wQC5NU28=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ZGAlKI0mOUcEhbpw4OwrlkVsmfyrAlTb6dOwUo5EF/U8PF3037vrnnpoLU3+U0lSBWWr1WQhrccfo571L6q7lvb6M3ro7JYkYXy5Wv7urvtliXRcDeHRFnoFFSqTczpEIzYDiEzRrMFXxpEBKUABYGv0NKfjXnZ6XWAUyP51IaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ica1Oo0M; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240322124536euoutp01ea75a0d90882f62ae16c881d4c19cab0~-FuBQ7Ehx2357423574euoutp01e;
	Fri, 22 Mar 2024 12:45:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240322124536euoutp01ea75a0d90882f62ae16c881d4c19cab0~-FuBQ7Ehx2357423574euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711111536;
	bh=DzUZJ0qqgrBRzdAUPIuslFQNY05ag29FcLY9RL07qGU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ica1Oo0MOvfYpOJde3WLej3Qh9PIQWalOglas81a11N38lEiIHUAfqzYTez23bZg5
	 eR3kLmDWNO/S6jiOlUIcTEwWsPo8H8TfdGLBa+0mnpyG6D+IVhYQsRApqooo4wCQAK
	 +VnP5Iht5eUCBFYYVQxw78YZlNsihNO3Ktk+PEcU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240322124535eucas1p13f306eb0af2e632d9d2ac6e3b93ecff1~-FuBB_6CS1574415744eucas1p1j;
	Fri, 22 Mar 2024 12:45:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.61.09552.F6D7DF56; Fri, 22
	Mar 2024 12:45:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240322124535eucas1p2765570a7687da9deb740e27a8f8949b8~-FuAmKsUb0598605986eucas1p2O;
	Fri, 22 Mar 2024 12:45:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240322124535eusmtrp1bc1e2a695e7edb2c5fe18bb967fcc922~-FuAlfWQT2174421744eusmtrp17;
	Fri, 22 Mar 2024 12:45:35 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-f9-65fd7d6fe70c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.85.10702.F6D7DF56; Fri, 22
	Mar 2024 12:45:35 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240322124535eusmtip252bd8472d4bebe917728e8c67c7fb829~-FuAWovEy3252232522eusmtip2B;
	Fri, 22 Mar 2024 12:45:35 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 22 Mar 2024 12:45:34 +0000
Date: Fri, 22 Mar 2024 13:45:32 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] sysctl: treewide: drop unused argument
 ctl_table_root::set_ownership(table)
Message-ID: <20240322124532.6ouo5cgwrp3zb3fv@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ocm5o5kuc2yzovjr"
Content-Disposition: inline
In-Reply-To: <20240315-sysctl-const-ownership-v3-1-b86680eae02e@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87r5tX9TDT6v07WYc76FxeLpsUfs
	Fme6cy0ubOtjtdiz9ySLxeVdc9gsfv94xmRxY8JTRotjC8Qsvp1+w+jA5TG74SKLx5aVN5k8
	Fmwq9di0qpPN4/2+q2wenzfJefR3H2MPYI/isklJzcksSy3St0vgyth0by1LwR+9ijNN+xkb
	GPepdTFyckgImEjc2NjD0sXIxSEksIJRYvKZ+WwQzhdGiX97lkI5nxklPmy+zAzTMnHlVKiW
	5YwSe191I1QdOn4aytnKKPH6QBMTSAuLgKrE0zNfGUFsNgEdifNv7oCNEhGwkVj57TM7SAOz
	wD4miY8X29hBEsICmRInL/4EmsTBwSvgILGoQR4kzCsgKHFy5hMWEJtZoEKi981BVpASZgFp
	ieX/OEDCnAL+EhvvTIG6VFni+r7FbBB2rcSpLbeYQFZJCOznlFg36SFUkYvEntvTWSBsYYlX
	x7ewQ9gyEqcnQ0JGQmAyo8T+fx/YIZzVjBLLGr8yQVRZS7RceQLV4SixunUKI8hFEgJ8Ejfe
	CkIcyicxadt0Zogwr0RHmxBEtZrE6ntvWCYwKs9C8tosJK/NQngNIqwncWPqFDYMYW2JZQtf
	M0PYthLr1r1nWcDIvopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw9Z3+d/zrDsYVrz7q
	HWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivDv+/0kV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqua
	Ip8qJJCeWJKanZpakFoEk2Xi4JRqYGI6dfg5n7JobfCGOsb7hcdrlx8w8IzSmbJP9L4Qy0nj
	9Kquyj0f1HitMnrnzX2q2xY9f+m5Vs95599J1Z3+N+HRoZ+Ca3XffV/SJmWVlO+/Jmqfz1Jj
	ge6s89KNVfcK4o7c479rMG2+wBWR5ykfXkddXK1083ilakZoluv5lnlxO2VVZ2p0nL6UN712
	2eMr2WWtv297Mku8u1vK6+Ms9XZrTO0uu5ymEAbNroJJRqeDvlcu5A+wYerXf1jwbbfqQudj
	Xz9dWM3xzFu5IuzvbVWHWAe9DT0vj7d57I6T37XM9st7VQe+z63uGYY3pV8cVuz1TzDl4V1u
	sK8sr656YeajB5cMLpec1bvJkvboixJLcUaioRZzUXEiAJ4Y8xD4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd382r+pBpMb+C3mnG9hsXh67BG7
	xZnuXIsL2/pYLfbsPclicXnXHDaL3z+eMVncmPCU0eLYAjGLb6ffMDpwecxuuMjisWXlTSaP
	BZtKPTat6mTzeL/vKpvH501yHv3dx9gD2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUM
	jc1jrYxMlfTtbFJSczLLUov07RL0Mla39jMV/NKrePs9tYFxj1oXIyeHhICJxMSVU1m6GLk4
	hASWMkqcnDqdFSIhI7Hxy1UoW1jiz7UuNoiij4wS5/qWMEE4WxklXt7azAhSxSKgKvH0zFcw
	m01AR+L8mzvMILaIgI3Eym+f2UEamAX2MUl8vNjGDpIQFsiUOHnxJ9BYDg5eAQeJRQ3yEEOf
	M0p82bWJCaSGV0BQ4uTMJywgNrNAmcTNL41MIPXMAtISy/9xgIQ5BfwlNt6ZwgxxqbLE9X2L
	2SDsWonPf58xTmAUnoVk0iwkk2YhTIII60js3HqHDUNYW2LZwtfMELatxLp171kWMLKvYhRJ
	LS3OTc8tNtIrTswtLs1L10vOz93ECIz+bcd+btnBuPLVR71DjEwcjIcYVYA6H21YfYFRiiUv
	Py9VSYR3x/8/qUK8KYmVValF+fFFpTmpxYcYTYGhOJFZSjQ5H5iW8kriDc0MTA1NzCwNTC3N
	jJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamOTKPWc9CtV69MXG8NDm6Zd3fJMMYS06WD/x
	h+eyEM+zz9XP1u+43uwZo/J691kee+3b67+dYsl+GrjF6vqTeS4ncixjWFPYPdrmPDerX+C6
	s1l9b9LKDR9u+fK4nPnzzCun7lRfNPdJjtSjH1+5CbVq+l1Ya81/4viRhMR/B9j8pGNUp5k9
	WrF+c/CvLUXH44L+Nkv+773dnGP2j0fFds3d3lU9quxr/srL9TcLrLy/2O294peiqyemr+/x
	9dHw7dFRDfnjvIl/q9GpS+ZTvBLvSlzbNrX88MzzC2Z/mHK/+OQ+83Vpjh9L04IMz6wxfhFV
	p9YTfiM49JqG4bT19uIf/rqZ7eTnOWMxxeNDcqwSS3FGoqEWc1FxIgCSYB2rkwMAAA==
X-CMS-MailID: 20240322124535eucas1p2765570a7687da9deb740e27a8f8949b8
X-Msg-Generator: CA
X-RootMTR: 20240315181141eucas1p29251cc3cb34abb7ff3cb33ef860a39c9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240315181141eucas1p29251cc3cb34abb7ff3cb33ef860a39c9
References: <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
	<CGME20240315181141eucas1p29251cc3cb34abb7ff3cb33ef860a39c9@eucas1p2.samsung.com>
	<20240315-sysctl-const-ownership-v3-1-b86680eae02e@weissschuh.net>

--ocm5o5kuc2yzovjr
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 07:11:30PM +0100, Thomas Wei=DFschuh wrote:
> The argument is never used and can be removed.
>=20
> In a future commit the sysctl core will only use
> "const struct ctl_table". Removing it here is a preparation for this
> consitifcation.
>=20
> The patch was created with the following coccinelle script:
>=20
>   @@
>   identifier func, head, table, uid, gid;
>   @@
>=20
>   void func(
>     struct ctl_table_header *head,
>   - struct ctl_table *table,
>     kuid_t *uid, kgid_t *gid)
>   { ... }
>=20
> The single changed location was validate through manual inspection and
> compilation.
Will drop this from the commit message when I add it to constfy branch.
For the same reasons as before.

here is the commit message that I'll use
"""
sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)

Remove the 'table' argument from set_ownership as it is never used. This
change is a step towards putting "struct ctl_table" into .rodata and
eventually having sysctl core only use "const struct ctl_table".

The patch was created with the following coccinelle script:

  @@
  identifier func, head, table, uid, gid;
  @@

  void func(
    struct ctl_table_header *head,
  - struct ctl_table *table,
    kuid_t *uid, kgid_t *gid)
  { ... }

No additional occurrences of 'set_ownership' were found after doing a
tree-wide search.

"""

Reviewed-by: Joel Granados <j.granados@samsung.com>

thx.
>=20
> In addition, a search for 'set_ownership' was done over the full tree to
> look for places that were missed by coccinelle.
> None were found.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c  | 2 +-
>  include/linux/sysctl.h | 1 -
>  ipc/ipc_sysctl.c       | 3 +--
>  ipc/mq_sysctl.c        | 3 +--
>  net/sysctl_net.c       | 1 -
>  5 files changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 37cde0efee57..ed3a41ed9705 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -480,7 +480,7 @@ static struct inode *proc_sys_make_inode(struct super=
_block *sb,
>  	}
> =20
>  	if (root->set_ownership)
> -		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
> +		root->set_ownership(head, &inode->i_uid, &inode->i_gid);
>  	else {
>  		inode->i_uid =3D GLOBAL_ROOT_UID;
>  		inode->i_gid =3D GLOBAL_ROOT_GID;
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index ee7d33b89e9e..60333a6b9370 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -205,7 +205,6 @@ struct ctl_table_root {
>  	struct ctl_table_set default_set;
>  	struct ctl_table_set *(*lookup)(struct ctl_table_root *root);
>  	void (*set_ownership)(struct ctl_table_header *head,
> -			      struct ctl_table *table,
>  			      kuid_t *uid, kgid_t *gid);
>  	int (*permissions)(struct ctl_table_header *head, struct ctl_table *tab=
le);
>  };
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 45cb1dabce29..1a5085e5b178 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -192,7 +192,6 @@ static int set_is_seen(struct ctl_table_set *set)
>  }
> =20
>  static void ipc_set_ownership(struct ctl_table_header *head,
> -			      struct ctl_table *table,
>  			      kuid_t *uid, kgid_t *gid)
>  {
>  	struct ipc_namespace *ns =3D
> @@ -224,7 +223,7 @@ static int ipc_permissions(struct ctl_table_header *h=
ead, struct ctl_table *tabl
>  		kuid_t ns_root_uid;
>  		kgid_t ns_root_gid;
> =20
> -		ipc_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
> +		ipc_set_ownership(head, &ns_root_uid, &ns_root_gid);
> =20
>  		if (uid_eq(current_euid(), ns_root_uid))
>  			mode >>=3D 6;
> diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
> index 21fba3a6edaf..6bb1c5397c69 100644
> --- a/ipc/mq_sysctl.c
> +++ b/ipc/mq_sysctl.c
> @@ -78,7 +78,6 @@ static int set_is_seen(struct ctl_table_set *set)
>  }
> =20
>  static void mq_set_ownership(struct ctl_table_header *head,
> -			     struct ctl_table *table,
>  			     kuid_t *uid, kgid_t *gid)
>  {
>  	struct ipc_namespace *ns =3D
> @@ -97,7 +96,7 @@ static int mq_permissions(struct ctl_table_header *head=
, struct ctl_table *table
>  	kuid_t ns_root_uid;
>  	kgid_t ns_root_gid;
> =20
> -	mq_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
> +	mq_set_ownership(head, &ns_root_uid, &ns_root_gid);
> =20
>  	if (uid_eq(current_euid(), ns_root_uid))
>  		mode >>=3D 6;
> diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> index 051ed5f6fc93..a0a7a79991f9 100644
> --- a/net/sysctl_net.c
> +++ b/net/sysctl_net.c
> @@ -54,7 +54,6 @@ static int net_ctl_permissions(struct ctl_table_header =
*head,
>  }
> =20
>  static void net_ctl_set_ownership(struct ctl_table_header *head,
> -				  struct ctl_table *table,
>  				  kuid_t *uid, kgid_t *gid)
>  {
>  	struct net *net =3D container_of(head->set, struct net, sysctls);
>=20
> --=20
> 2.44.0
>=20

--=20

Joel Granados

--ocm5o5kuc2yzovjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX9fWwACgkQupfNUreW
QU+9nwv/VPfUKwe96f/1IjtYBOEYJC4KSZS0jlPNLEY7jI3pzcwn4R0iRR0FuuoN
xjvMo0hm5RknZnijWVbEjYDyfhco1De9zS/2WokOHofnGZz3YknXbXCzPWbH5p0l
4BpznOSut113gLJ8ClTQRnnNbhsQLHrzpYPvKpT7AhmNwJAP4YcBuw9+hnUTqNaa
cow6+ueb0FzwjxJTXb9n4sF92SPqiiPL/HniKNb3j5gZZbGKRgm+9YO5kZ/18Yhd
lj1QgMZXPCxzlvgpdygAt5zI9KsjvzZ2F2O3M7Iz0o1Kmep1OSqGll2FEa5tc7JW
J1x7GY6zzBNF3zp1wWToE1MMHLTWRMioDJd3dHyvh+9MXDE7n7hXy+ZaByiHCKDT
pcVujl1UykkC1n4nbfLyxgXeBbMmr+l0wARHROPC8BCFWpVHIbkymtoIENLmZbLZ
pyu6p3zQynkf3ZklvRp4Sh2PKr+AbgVDz8RtDEEtLytYByliXBSL1gioehAZxNor
1qLLvEoj
=2GYL
-----END PGP SIGNATURE-----

--ocm5o5kuc2yzovjr--

