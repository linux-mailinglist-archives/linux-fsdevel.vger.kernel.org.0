Return-Path: <linux-fsdevel+bounces-14480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731487D078
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ACA1F216ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683463F8D1;
	Fri, 15 Mar 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rfWnHbjy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D04085A;
	Fri, 15 Mar 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517302; cv=none; b=S7EbzHIldU4D8rzC3tdFVqpf0PUOpDkt2KtIh7r17ylNIMGu4nhds/eSR7jWoM+AKXDM9iYxPx0+nDAY/6JbsFa1L19M0AXUfAIMVauHicTzG9e4Ed1jtMV9kfdZZ1G6Aiv57GFK9Ub6cfa+6q6uTlsL4che11ktsLlNNBGI3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517302; c=relaxed/simple;
	bh=qbKlDLD5p57eMz4miHPcI8jA45+vGnw/HumsjBknQUA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qZZ9txx0L+MjK7l+H8LW5/aLwE5B/s4ThaJJ8Si2Y+i3I8p5120Mli2VJdBlQ8GoN9Zm5nKfZIk2y6RMoRz79kOz/Rpp+tbSo3m2CNDsCvYUiyM7N/Pu4GsreAXo9d9Ae86knvDHAOaY4lSDMNJFoVF2Ym3DtkRtW1QVZw+KWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rfWnHbjy; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240315154138euoutp01332b2d486483476a8f3937e5fbf016a1~8_muIeOLJ2189121891euoutp01o;
	Fri, 15 Mar 2024 15:41:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240315154138euoutp01332b2d486483476a8f3937e5fbf016a1~8_muIeOLJ2189121891euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710517298;
	bh=gXQm1m8fwCdP24cp9RRqrvBU3He89AdWykUC5nLJslQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rfWnHbjyBg6GMb44QE/T9m2OQIty1nvoT2F+hPrYsTBI9V9/ZgqzWIKjxGUjnghsm
	 kiaXGowF8qgrsKfJ2G4k5Va0RDqBOVWp0dxKV/ZfQ8/LGoq2qVsC0nVjxSUvhs33Kr
	 +O6U41FTp+HFo8wAAACc7IbwyM/X/CjH9HqHU6Gk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240315154137eucas1p13128efb4469de5fe0530d14466fe9fd7~8_mty5wXh0199101991eucas1p1v;
	Fri, 15 Mar 2024 15:41:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E9.67.09539.13C64F56; Fri, 15
	Mar 2024 15:41:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240315154137eucas1p1708aca7d71cfc40ee02c2b736f2956f2~8_mtPd7Nf1770717707eucas1p1T;
	Fri, 15 Mar 2024 15:41:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240315154137eusmtrp1c9a9126e1a7a41e98cd9d5623df61c4d~8_mtO1mQe2477124771eusmtrp1D;
	Fri, 15 Mar 2024 15:41:37 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-2c-65f46c31c8f0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 85.C2.09146.13C64F56; Fri, 15
	Mar 2024 15:41:37 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240315154137eusmtip20d0f28ddb7826d964bde13e52446aa09~8_mtChVQ72394023940eusmtip2V;
	Fri, 15 Mar 2024 15:41:37 +0000 (GMT)
Received: from localhost (106.210.248.173) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Mar 2024 15:41:36 +0000
Date: Fri, 15 Mar 2024 16:41:34 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: drop unused argument set_ownership()::table
Message-ID: <20240315154134.5qfq6wucxid5kfmc@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="r746sdyatcsm2m4p"
Content-Disposition: inline
In-Reply-To: <20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djPc7qGOV9SDZa+NLCYc76FxeLpsUfs
	Fme6cy0ubOtjtdiz9ySLxeVdc9gsfv94xmRxY8JTRotjC8Qsvp1+w+jA5TG74SKLx5aVN5k8
	Fmwq9di0qpPN4/2+q2wenzfJefR3H2MPYI/isklJzcksSy3St0vgyvi08ARrwV79iqY7W1ga
	GBepdjFyckgImEh0HdzF1MXIxSEksIJR4v+Lm2wQzhcgZ+dzVgjnM6PEu+YLLDAtC6/dhWpZ
	zihx5997FriqK6dus0M4Wxklvt24DNbCIqAq0TajA8xmE9CROP/mDjOILSJgI7Hy22ewBmaB
	fUwSHy+2sYMkhAW8JZ5v7GEFsXkFHCRO7u1kg7AFJU7OfAI2iFmgQmLdxV9AgziAbGmJ5f84
	QMKcAv4SE2YfZYc4VVni66SPbBB2rcSpLbfAzpYQ2M0psbFrAlTCRWL6uu9QvwlLvDq+BapZ
	RuL05B4WiIbJjBL7/31gh3BWM0osa/zKBFFlLdFy5QlUh6PErlc32EEukhDgk7jxVhDiUD6J
	SdumM0OEeSU62oQgqtUkVt97wzKBUXkWktdmIXltFsJrEKamxPpd+iiiIMXaEssWvmaGsG0l
	1q17z7KAkX0Vo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOo7/e/4px2Mc1991DvEyMTB
	eIhRBaj50YbVFxilWPLy81KVRHjrFD+mCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJI
	TyxJzU5NLUgtgskycXBKNTBx/Jtia+4c57rhyI7lc+Osltu7bgxy0NoqIezGMn3xtU3H/yxm
	VF/n4XjOrPy/9M2vByOahYV2iYca8Ut6vwlxOft02lmB/9UPZK9v8pzSbMzBHXDmoFpts/D0
	OXPtW5k3/D4vKAFM8x8XPth2rnXXmxJpofp2lV3TWCaceHxF4UAd48a0nTPuvbb/ejF7zs+U
	uTOEK13qmiYJZKd2NU4VfZ/Uu67mzpMJ27jOu/F4bzJZsOMZb5LvgpwbCnflKr8lFT84ZNO1
	NeFM3L5Z3BZh6vmzZ2woPmQQmrg16tl3SX/n8LddgRMungrYZtLv+X35k22fwsRPKaVsufN9
	nt2pP48/vJ/b7/9U8fVWv1oJJZbijERDLeai4kQA9yvGbvgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4PV3DnC+pBi+/cFvMOd/CYvH02CN2
	izPduRYXtvWxWuzZe5LF4vKuOWwWv388Y7K4MeEpo8WxBWIW306/YXTg8pjdcJHFY8vKm0we
	CzaVemxa1cnm8X7fVTaPz5vkPPq7j7EHsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZ
	GpvHWhmZKunb2aSk5mSWpRbp2yXoZWw8tJ69YLd+xcF7k1gbGBeodjFyckgImEgsvHaXqYuR
	i0NIYCmjxKaPl5ghEjISG79cZYWwhSX+XOtigyj6yCix7M83KGcro8SqG8+ZQKpYBFQl2mZ0
	sIDYbAI6Euff3AGbJCJgI7Hy22d2kAZmgX1MEh8vtrGDJIQFvCWeb+wBW8Er4CBxcm8n1NRF
	jBIttx+wQSQEJU7OfAI2lVmgTGLDm5NADRxAtrTE8n8cIGFOAX+JCbOPskOcqizxddJHNgi7
	VuLz32eMExiFZyGZNAvJpFkIkyDC6hJ/5l1ixhDWlli28DUzhG0rsW7de5YFjOyrGEVSS4tz
	03OLDfWKE3OLS/PS9ZLzczcxAhPAtmM/N+9gnPfqo94hRiYOxkOMKkCdjzasvsAoxZKXn5eq
	JMJbp/gxVYg3JbGyKrUoP76oNCe1+BCjKTAYJzJLiSbnA1NTXkm8oZmBqaGJmaWBqaWZsZI4
	r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU9cylb1fu9h3dSmcaeLm9vG5N6fwodKqEIXV3jM1
	kzIMZwU83GV26vCN3f39J6zqIwr230wSKjmy2PdClP769TUv9FZYv014emYBf8yqS6edFy+r
	d1O42y0SseXM1eOHVtjde9rENFvo5Yyn+yqjHIKuHc3r0ylO7w99btv+4PGvJbvLZXN9n107
	uYvniVNLvcWOPabVeUvyJrSsbXmzzWX5fA2JUy8DrJ+LzKusuPh2Y6Zq2pGctevr/90v/LWm
	OW3hsSccXDIn7q59MGuqnYZZyfTtXa7nVx/fk1bmc666Rkpt/8aSfefv/A1Z0qh6lTFoytzZ
	bP8abqX5RW/7+NKhyzRLz+FLt9j5tW8dF0QpsRRnJBpqMRcVJwIAxeevPZUDAAA=
X-CMS-MailID: 20240315154137eucas1p1708aca7d71cfc40ee02c2b736f2956f2
X-Msg-Generator: CA
X-RootMTR: 20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf
References: <CGME20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf@eucas1p2.samsung.com>
	<20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net>

--r746sdyatcsm2m4p
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

Did you forget to compile? I'm seeing the following error when I
compile:

  ...
  ../fs/proc/proc_sysctl.c: In function =E2=80=98proc_sys_make_inode=E2=80=
=99:
  ../fs/proc/proc_sysctl.c:483:43: error: passing argument 2 of =E2=80=98ro=
ot->set_ownership=E2=80=99 from incompatible pointer type [-Werror=3Dincomp=
atible-pointer-types]
    483 |                 root->set_ownership(head, table, &inode->i_uid, &=
inode->i_gid);
        |                                           ^~~~~
        |                                           |
        |                                           struct ctl_table *
  ../fs/proc/proc_sysctl.c:483:43: note: expected =E2=80=98kuid_t *=E2=80=
=99 but argument is of type =E2=80=98struct ctl_table *=E2=80=99
  ../fs/proc/proc_sysctl.c:483:50: error: passing argument 3 of =E2=80=98ro=
ot->set_ownership=E2=80=99 from incompatible pointer type [-Werror=3Dincomp=
atible-pointer-types]
    483 |                 root->set_ownership(head, table, &inode->i_uid, &=
inode->i_gid);
        |                                                  ^~~~~~~~~~~~~
        |                                                  |
        |                                                  kuid_t *
  ../fs/proc/proc_sysctl.c:483:50: note: expected =E2=80=98kgid_t *=E2=80=
=99 but argument is of type =E2=80=98kuid_t *=E2=80=99
  ../fs/proc/proc_sysctl.c:483:17: error: too many arguments to function =
=E2=80=98root->set_ownership=E2=80=99
    483 |                 root->set_ownership(head, table, &inode->i_uid, &=
inode->i_gid);
        |                 ^~~~
  cc1: some warnings being treated as errors
  make[5]: *** [../scripts/Makefile.build:243: fs/proc/proc_sysctl.o] Error=
 1
    CC      fs/xfs/libxfs/xfs_dir2_node.o
  make[5]: *** Waiting for unfinished jobs....
  ...

I'm guessing its just a matter of removing the table arg from
proc_sys_make_inode?

Best

On Fri, Feb 23, 2024 at 04:50:00PM +0100, Thomas Wei=C3=9Fschuh wrote:
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
>=20
> In addition, a search for 'set_ownership' was done over the full tree to
> look for places that were missed by coccinelle.
> None were found.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Rework commit message
> - Mention potential conflict with upcoming per-namespace kernel.pid_max
>   sysctl
> - Delete unused parameter table
> - Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-ownership-v=
1-1-d78fdd744ba1@weissschuh.net
> ---
> The patch is meant to be merged via the sysctl tree.
>=20
> There is an upcoming series that will introduce a new implementation of
> .set_ownership which would need to be adapted [0].
> The adaption would be trivial as the 'table' parameter also unused
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
>  include/linux/sysctl.h | 1 -
>  net/sysctl_net.c       | 1 -
>  2 files changed, 2 deletions(-)
>=20
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
> ---
> base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
> change-id: 20231226-sysctl-const-ownership-ff75e67b4eea
>=20
> Best regards,
> --=20
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--r746sdyatcsm2m4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX0bC0ACgkQupfNUreW
QU+whgv9En2sQX6VDbbF159wAFTNCqsVvsC8JU4vm6qZpr7kgyMgo9VxTd0P1HQ8
viituPEfsRbqPRQGKBUjfH3McRbMxpOw0KnuJIywAzbboecotskpVz9t4joaBugq
DmGBum1bCR/AQwPJlrjYb7FHq61alizsn+IclXAQFLPiHy6I5nJlr1fhIJOBzMOw
XzzeFQ4AOvuqJeazzcW92JDZ6PyRaRpXRBD0+S1TcdP+GgL5UyLyGyIKXSj7lYus
DEgQIinxF16/061BU+80O1XKG7s0gjwh/f5rflEMg7zwxwnOfJaqMKVmS+TR+mSl
IUlR09jEfASsCXDmqEFhlSFA1Bi5RSsJsAfBTkSn0DhzlrLD08rDqCa7Kqq6zfL4
/83ma83KSCPSpsApON5xA1hmDjT7gOhLSHtPo3IhgHmlJOwZWILdCf2CWHm4tX6s
p5d8MLqq10U+fu5XZ/zxOgnlYD186IwOiVMI2B5ixbA4pT6UOH6tLjG/VRB0Nr1A
J6DlNz1L
=RCo6
-----END PGP SIGNATURE-----

--r746sdyatcsm2m4p--

