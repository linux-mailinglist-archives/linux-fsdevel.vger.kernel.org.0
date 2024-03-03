Return-Path: <linux-fsdevel+bounces-14076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4FA8775CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5205282531
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F71CD09;
	Sun, 10 Mar 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gI5Ost35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658410A1C;
	Sun, 10 Mar 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710059519; cv=none; b=qtRhq8h0rsGzrkcbBw2Q9rhXPF0osbt6Dh/vApdJvss4MB+8VwAFXGPAk297LyVcuRExdbN0EApXtihKSbi+7q1ERlACgw2rc5PRke4ceov/NpkVmg6DHrA6DjK38zDt+8UB+MIaqqjGYNghZxNisWzT9EXpvZCYjEVWx87PTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710059519; c=relaxed/simple;
	bh=GLXQcFukMZ/tWAFDK1k8T7exP/WHkxREN+6d+etClTQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=mXuQKUy/a70EfOQWt9zThWwFxtUOVTJLo2f5jde28y7rA0374mBjxdZDuaplOvv1M6aKzWNBWXTErdhuVlmRF8IIEzMYxcu8AcAu7khQWZ33nWTmUBznVfFujwyNfpW6jVykmhHlWeDXWHHfYhLZWFrg0A4J68fFv8tE6Ll3kCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gI5Ost35; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240310082504euoutp012f9b7f9435bbb0b5a3dd47e9343c3516~7WbHvV7tM1596715967euoutp01Z;
	Sun, 10 Mar 2024 08:25:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240310082504euoutp012f9b7f9435bbb0b5a3dd47e9343c3516~7WbHvV7tM1596715967euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710059104;
	bh=fSFfoLc3DfjlM0yn26NfvlNreAK+fQ3XZGtduReUWtk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gI5Ost35hpjzM80ww1b7UrxpiC119RgpVOvZDWZd1zYM408aJvEbE1XDwVS4eFNlh
	 6/G6bWNV9CuL+Y1bxSnXwA3gL9+hT5SIoIdExiXP/T7eAMaGQevE7Pe1N+aWdWJC3b
	 1yMv+8GkT4Edb/+zydK4NvLnxe3//roaJ2ibYgnY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240310082504eucas1p1221d3e1e1caed57c937b34d2c0c97709~7WbHipjHy1186111861eucas1p12;
	Sun, 10 Mar 2024 08:25:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8F.48.09552.F5E6DE56; Sun, 10
	Mar 2024 08:25:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240310082503eucas1p13e9255dee8b6b22269821815eae5c033~7WbG6Ww_O3114831148eucas1p1D;
	Sun, 10 Mar 2024 08:25:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240310082503eusmtrp13d00f5af6ad9b7cdb4599f73140b95ab~7WbG5bhav2181421814eusmtrp1x;
	Sun, 10 Mar 2024 08:25:03 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-5b-65ed6e5fe46d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.38.09146.F5E6DE56; Sun, 10
	Mar 2024 08:25:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240310082503eusmtip22544492af56202aeeb3ddb94d36f48b9~7WbGtcM560318103181eusmtip2R;
	Sun, 10 Mar 2024 08:25:03 +0000 (GMT)
Received: from localhost (106.210.248.173) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 10 Mar 2024 08:25:01 +0000
Date: Sun, 3 Mar 2024 15:34:08 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify
 ctl_table_root::permissions
Message-ID: <20240303143408.sxrbd7pykmyhwu5f@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qqan5da6s22ibigg"
Content-Disposition: inline
In-Reply-To: <20240223-sysctl-const-permissions-v2-1-0f988d0a6548@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87rxeW9TDdonmFvMOd/CYvH02CN2
	izPduRYXtvWxWuzZe5LF4vKuOWwWv388Y7K4MeEpo8WxBWIW306/YXTg8pjdcJHFY8vKm0we
	CzaVemxa1cnm8X7fVTaPz5vkPPq7j7EHsEdx2aSk5mSWpRbp2yVwZSy/epGxoEO3YuG720wN
	jMdUuxg5OSQETCSeLbjD3sXIxSEksIJR4v/9u8wgCSGBL4wSF5aGQyQ+M0osfLKBBabj3/tv
	rBCJ5YwSa8+cYISruj3/IpSzlVFix7f9jCAtLAIqEid69oLZbAI6Euff3AHbISJgI7Hy22ew
	5cwC+5gkPl5sYwdJCAsESMy78BTI5uDgFXCQOLdUDSTMKyAocXLmE7AzmAUqJHYuewJWwiwg
	LbH8HwdImFMgUGL+vmdQlypLfJ30kQ3CrpU4teUWE8gqCYH9nBL7bk5lhEi4SCyfOReqQVji
	1fEt7BC2jMTpyT0sEA2TGSX2//vADuGsZpRY1viVCaLKWqLlyhOoDkeJl7cnMYJcJCHAJ3Hj
	rSDEoXwSk7ZNZ4YI80p0tAlBVKtJrL73hmUCo/IsJK/NQvLaLITXIMJ6EjemTmHDENaWWLbw
	NTOEbSuxbt17lgWM7KsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECE9/pf8e/7mBc8eqj
	3iFGJg7GQ4wqQM2PNqy+wCjFkpefl6okwvta522qEG9KYmVValF+fFFpTmrxIUZpDhYlcV7V
	FPlUIYH0xJLU7NTUgtQimCwTB6dUA1O7IcPMxVnij89ZiR602i3wxM020vDf+eNpKjxHCh1W
	uyc1t3+/KS3yxGeGx9G339/cL9LXcBKJYn2j93A/m33jXBNjuwkMK3nVFIsdv2zf8iSofbmP
	Ytf/t9O4OEPO3JbtOR8ldvpjx8e3v3cwfr2ziVnKslapLo73/I4gBbGzWvKHC376q0f+4Dbt
	6c5ZlDtx+p/6q4yOe5g+FZ+6dbRhpv92jwXdgcdE8w+/2Sb98uO6rVtE7CZPEOVqUbT67Rap
	kTeji+9D/FrpxPqwc8uWFX07X7OnjelWcHjxojapo7PU8txvP9q+aKr1ZndNI76FEyf9srks
	wBg8w/1H6fy8Beq6ml1KrYyvs4JFriuxFGckGmoxFxUnAgAVidKg9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd34vLepBs3tghZzzrewWDw99ojd
	4kx3rsWFbX2sFnv2nmSxuLxrDpvF7x/PmCxuTHjKaHFsgZjFt9NvGB24PGY3XGTx2LLyJpPH
	gk2lHptWdbJ5vN93lc3j8yY5j/7uY+wB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqG
	xuaxVkamSvp2NimpOZllqUX6dgl6GV0v+lgK2nQrbu5dx9TAeES1i5GTQ0LAROLf+2+sXYxc
	HEICSxklGn7eYIFIyEhs/HKVFcIWlvhzrYsNougjo8S/T8eYQRJCAlsZJb694QexWQRUJE70
	7GUEsdkEdCTOv7kDViMiYCOx8ttndpBmZoF9TBIfL7axgySEBfwkXi2fALSBg4NXwEHi3FI1
	iAVLGCXufL0PtplXQFDi5MwnYBcxC5RJHN/4iwWknllAWmL5Pw6QMKdAoMT8fc+gjlaW+Drp
	IxuEXSvx+e8zxgmMwrOQTJqFZNIshEkQYR2JnVvvsGEIa0ssW/iaGcK2lVi37j3LAkb2VYwi
	qaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHRv+3Yz807GOe9+qh3iJGJg/EQowpQ56MNqy8wSrHk
	5eelKonwvtZ5myrEm5JYWZValB9fVJqTWnyI0RQYihOZpUST84FpKa8k3tDMwNTQxMzSwNTS
	zFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgannwX9e/nWrD+cvlj78Imj+p1uf/kxbEy0V
	uNPgzi3OgNfz2fx3Zs9eE7svKWTC2QmllVNfFL3UMyn63FG/pe3CHadNmmr1UnIzvkisUKjw
	sN7lnMxp8+ZyYSH7W34rh92/JNnkl55bavnxwDTmOZ1PWWY4Nu6VTK/l6zW7E//EIeflqaWr
	eM8/iTeZFJMZsoG/9u0zX/Y1u4vfBvPN6i4Q43saeLD2ibGHWXPtwr3FnELa+/pyD6y7k+P2
	pSOuScThxHYT12BX+ZwHV4oOzF3zY+0K3sb4nKfWl/7eVkj7cmRCrNO2qvz1YYmmYq+213Cm
	5GR2c17Xt3R9vJb/gunJsDnSGfZnPjO13amwZldiKc5INNRiLipOBAAypaXckwMAAA==
X-CMS-MailID: 20240310082503eucas1p13e9255dee8b6b22269821815eae5c033
X-Msg-Generator: CA
X-RootMTR: 20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba
References: <CGME20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba@eucas1p2.samsung.com>
	<20240223-sysctl-const-permissions-v2-1-0f988d0a6548@weissschuh.net>

--qqan5da6s22ibigg
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

Just to be sure I'm following. This is V2 of "[PATCH] sysctl: treewide:
constify ctl_table_root::set_ownership". Right? I ask, because the
subject changes slightly.

Best

On Fri, Feb 23, 2024 at 04:52:16PM +0100, Thomas Wei=DFschuh wrote:
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
>=20
> In addition a search for '.permissions =3D' was done over the full tree to
> look for places that were missed by coccinelle.
> None were found.
>=20
> This change also is a step to put "struct ctl_table" into .rodata
> throughout the kernel.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> To: Luis Chamberlain <mcgrof@kernel.org>
> To: Kees Cook <keescook@chromium.org>
> To: Joel Granados <j.granados@samsung.com>
> To: David S. Miller <davem@davemloft.net>
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
>=20
> Changes in v2:
> - flesh out commit messages
> - Integrate changes to set_ownership and ctl_table_args into a single
>   series
> - Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-permissions=
-v1-1-5cd3c91f6299@weissschuh.net
> ---
> The patch is meant to be merged via the sysctl tree.
>=20
> There is an upcoming series that will introduce a new implementation of
> .permission which would need to be adapted [0].
> The adaption would be trivial as the 'table' parameter also not modified
> there.
>=20
> This change was originally part of the sysctl-const series [1].
> To slim down that series and reduce the message load on other
> maintainers to a minimumble, submit this patch on its own.
>=20
> [0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhal=
itsyn@canonical.com/
> [1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@=
weissschuh.net/
> ---
>  include/linux/sysctl.h | 2 +-
>  ipc/ipc_sysctl.c       | 2 +-
>  kernel/ucount.c        | 2 +-
>  net/sysctl_net.c       | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index ee7d33b89e9e..0a55b5aade16 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -207,7 +207,7 @@ struct ctl_table_root {
>  	void (*set_ownership)(struct ctl_table_header *head,
>  			      struct ctl_table *table,
>  			      kuid_t *uid, kgid_t *gid);
> -	int (*permissions)(struct ctl_table_header *head, struct ctl_table *tab=
le);
> +	int (*permissions)(struct ctl_table_header *head, const struct ctl_tabl=
e *table);
>  };
> =20
>  #define register_sysctl(path, table)	\
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 8c62e443f78b..b087787f608f 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -190,7 +190,7 @@ static int set_is_seen(struct ctl_table_set *set)
>  	return &current->nsproxy->ipc_ns->ipc_set =3D=3D set;
>  }
> =20
> -static int ipc_permissions(struct ctl_table_header *head, struct ctl_tab=
le *table)
> +static int ipc_permissions(struct ctl_table_header *head, const struct c=
tl_table *table)
>  {
>  	int mode =3D table->mode;
> =20
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
> index 051ed5f6fc93..ba9a49de9600 100644
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
> ---
> base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
> change-id: 20231226-sysctl-const-permissions-d7cfd02a7637
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--qqan5da6s22ibigg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXkik0ACgkQupfNUreW
QU9rSwv7B1/Znla2Bxl973JJ28LEIA+WnUyU2NKROljS41pBxiSjMK8lNqbhRRZR
Uu4a1VkqIeIH6OHWdFUnaVA8XaiHZkwxzba+Ub7U6eHznH0ysjSAQE9PsTagFHrf
gsaiE7kA9rzpw5DYWHwvplF1qcezr1b3eO5dMMaSfr4xUb4BxvCX7+HJPO6x1bLj
DHhbbQNnaQCie3L2yl2V4VOxafV8sWR4Vnbmp8we9GKkWJ1vvztKNisYFwefMt7h
10ITailxrVPvbJeQIajnxRFZe/tVwXU19IKWw8R32ghlELLuHgnQMMt1q6MHjZ4s
Jmiqhg+75YEFgOHi3fmRR0BBcC7DuL2gb4xzb9k2fTHWjmj22hudDChXH9Zehck6
LsCbP2YfcbN9rEYa6WxxBPprEfQEYMt3VxL2qYTJR4qGCykBJVavrp7ozV6L9ifR
ymKnJAhphprGBx5VmEWFby90DueGoiEuh61hhFdTBPDbuOFLD47YplHNIi3SH5DJ
306eCaf1
=oGDK
-----END PGP SIGNATURE-----

--qqan5da6s22ibigg--

