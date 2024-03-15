Return-Path: <linux-fsdevel+bounces-14484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A587D112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F0D1C228A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627B45970;
	Fri, 15 Mar 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Udwasl0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224748CD4;
	Fri, 15 Mar 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710519552; cv=none; b=aanXnzUVMvHlLvW3gLvXxgMoByUgq5O6ZTwwePXVrWChxKEajRSrRZPtnA83TBWupg+TSzKMhY9egZI6Wlrld5nae3VzRlhCx/9+UezZlAkVwtKtwfinODZUETHVjK6XlgsHv4XL5mgmCmzjEWMH7Ta1Ey4rZ5Z+hgVxfy11fsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710519552; c=relaxed/simple;
	bh=QQsAjR+kGMVFuyXjJSPmujbn0DBRwHcrvDMQXYEigb8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=vCehAtnaRZSns5ROVyE1lLpoxAYthbI5uPRC2bQ2EZv5M4OOuxRckLG7LdSYAI+r/ejscMR4cOaeI8da9mnOZwYdtgv0ASRHM8sDTSF1SxmmCKHWWHy8NqzruoElRXtzYgU7BVNKbN1IxM+LYcHo/PmV+hBVWnhbC4iEu3WeB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Udwasl0b; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240315161906euoutp023f51b8829ca9c0a161f04c8ee98e423e~8-Hb9e_AX2029320293euoutp02g;
	Fri, 15 Mar 2024 16:19:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240315161906euoutp023f51b8829ca9c0a161f04c8ee98e423e~8-Hb9e_AX2029320293euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710519546;
	bh=c/L7vmfRkaj9Artl8atZHp1ALKuj6yDCDcItezoA+SA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Udwasl0bR6s/7/RuUZ8YDtxFJewl+VHBclTOQTwpE+2pTPyFCSTfOYca4OJuecKYy
	 slIFO66m8Y3UpteONCLuNpwf1PSDg2U9YShtprpysZmBPkkZklUw/cVqG+mS+p1HA9
	 qvVe4eUUwIVFJ/aZnUju96ypopypkqWm1he89gyI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240315161906eucas1p12620b84af9ba258c26234be29066b5b8~8-HbvB76x0476704767eucas1p1B;
	Fri, 15 Mar 2024 16:19:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.8C.09539.AF474F56; Fri, 15
	Mar 2024 16:19:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240315161905eucas1p15f8ef9c2d676eb487db7ae13276d9e05~8-HbUZ6hT1838918389eucas1p1L;
	Fri, 15 Mar 2024 16:19:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240315161905eusmtrp231bda70af5987a11d39b01f4d5398045~8-HbTmv-Z0988009880eusmtrp2U;
	Fri, 15 Mar 2024 16:19:05 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-30-65f474faa253
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.4E.10702.9F474F56; Fri, 15
	Mar 2024 16:19:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240315161905eusmtip128d24675710f6d7055f6130ff148092e~8-HbETyh32377723777eusmtip1H;
	Fri, 15 Mar 2024 16:19:05 +0000 (GMT)
Received: from localhost (106.210.248.173) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Mar 2024 16:19:04 +0000
Date: Fri, 15 Mar 2024 17:19:03 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: drop unused argument set_ownership()::table
Message-ID: <20240315161903.cbz4jv5w23zh6yfx@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="dcq2itrqq6m5yonn"
Content-Disposition: inline
In-Reply-To: <838812fc-d1ee-4088-a704-8b8f15caab13@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7q/Sr6kGqzbymkx53wLi8XTY4/Y
	Lc5051pc2NbHarFn70kWi8u75rBZ/P7xjMnixoSnjBbHFohZfDv9htGBy2N2w0UWjy0rbzJ5
	LNhU6rFpVSebx/t9V9k8Pm+S8+jvPsYewB7FZZOSmpNZllqkb5fAlbHg9BeWgsnSFTvebGFr
	YNwq0sXIySEhYCKx/uA1ti5GLg4hgRWMEsvftzFCOF8YJeZP62SGcD4zSvT2XGPpYuQAa9l/
	KRQivpxRomXDeoSiDXsPsEA4Wxkllh1aygyyhEVAVeL7lGYWEJtNQEfi/Js7YHERARuJld8+
	s4M0MAvsY5L4eLGNHSQhLOAt8XxjDyuIzSvgIPFhWguULShxcuYTsEHMAhUSJ860MIKcxCwg
	LbH8HwdImBNo5pWnz1kgnlOW+DrpIxuEXStxasstJgh7N6fEgRZ5CNtF4uj8W+wQtrDEq+Nb
	oGwZif875zOB3CYhMJlRYv+/D+wQzmqgzxq/Qk2ylmi58gSqw1Fi16sb7JAw4pO48VYQ4k4+
	iUnbpjNDhHklOtqEIKrVJFbfe8MygVF5FpLPZiH5bBbCZxCmpsT6XfoooiDF2hLLFr5mhrBt
	Jdate8+ygJF9FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmDaO/3v+KcdjHNffdQ7xMjE
	wXiIUQWo+dGG1RcYpVjy8vNSlUR46xQ/pgrxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUS
	SE8sSc1OTS1ILYLJMnFwSjUwze09qHlKeEZ9dK7J09cfvOQXnOB8tkTrrcDuaHEZvhalqkiH
	khVPmG6Fa2dvv/zjYsw9zrmKG9+keVY/eSjz7k9X0NkdeTsPr3u/l+3Xfa0VRRt41m+ZOPeH
	wEt/dVPf3XO+XtdPfLf61D6lPIOSJ8uNPOrm/rtdbOs+e/OR16afMt4rWp47+796MXPRSslF
	N453zwo7y3/1bffVFSVGjwT7Lq27muTnnefqdX8bR9CM5fmVVcGrGB7qsZvOufQu3erWxJNv
	zxx6npI2c5XqpdSpprryLYIdnkJyrxass9zyhsfhQX8lf/aKihnBoRU/HC+k3FY1rGJPs2XI
	7WO/Lu8pcX6m/0WtOV/7dhoy3FViKc5INNRiLipOBAC6ohrC9gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Xd2fJV9SDV4+UrOYc76FxeLpsUfs
	Fme6cy0ubOtjtdiz9ySLxeVdc9gsfv94xmRxY8JTRotjC8Qsvp1+w+jA5TG74SKLx5aVN5k8
	Fmwq9di0qpPN4/2+q2wenzfJefR3H2MPYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
	NDaPtTIyVdK3s0lJzcksSy3St0vQyzi+bA1rwUTpiiuHH7A0MG4W6WLk4JAQMJHYfym0i5GL
	Q0hgKaPEhM4n7F2MnEBxGYmNX66yQtjCEn+udbFBFH1klFi+DiIhJLCVUWLDPRUQm0VAVeL7
	lGYWEJtNQEfi/Js7zCC2iICNxMpvn9lBmpkF9jFJfLzYBrZBWMBb4vnGHrBBvAIOEh+mtbBC
	bOhmktj+7AczREJQ4uTMJ2BTmQXKJK6dmcgOcjazgLTE8n8cIGFOoAVXnj5ngbhUWeLrpI9s
	EHatxOe/zxgnMArPQjJpFpJJsxAmQYTVJf7Mu8SMIawtsWzha2YI21Zi3br3LAsY2VcxiqSW
	Fuem5xYb6RUn5haX5qXrJefnbmIERv+2Yz+37GBc+eqj3iFGJg7GQ4wqQJ2PNqy+wCjFkpef
	l6okwlun+DFViDclsbIqtSg/vqg0J7X4EKMpMBgnMkuJJucD01JeSbyhmYGpoYmZpYGppZmx
	kjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTnMj18pN71rUmXUgLc/w6Z1P/XkuhTmlxrs3K
	1RZJKs8/eSow53zeseZM8Lx/FXNrKzTmb5/WKXCpIuh2dMdNb8dCo7Ifhulvwrc9aNWbfuCq
	S/SZqbvOrzyYY6a4gE1i8v8e/p6NJyebtFlML+g29o1wipVtV7Y829B7tGDL4UTurg8Mcrb+
	B8PvfJj3dG/R89OzrfTTtiw9evPdkYf59vHvHy55MkeO6Ua+gmme0g3NXw+yeYOvreR3v+Dm
	t1MxxXZd5rqHtedXyzWvN90c8rRk7R3O5S47Tpqctr8qZ61v3ST7wiZUsl7u+qkDi1gnuFdz
	/zzy4UDf/rN//J/+2KE0v/5P3vIPYecmZuwIV2Ipzkg01GIuKk4EAIzAD8+TAwAA
X-CMS-MailID: 20240315161905eucas1p15f8ef9c2d676eb487db7ae13276d9e05
X-Msg-Generator: CA
X-RootMTR: 20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf
References: <CGME20240223155011eucas1p245e00a3dfd23f72997dac4952ebaeebf@eucas1p2.samsung.com>
	<20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net>
	<20240315154134.5qfq6wucxid5kfmc@joelS2.panther.com>
	<838812fc-d1ee-4088-a704-8b8f15caab13@t-8ch.de>

--dcq2itrqq6m5yonn
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 04:56:54PM +0100, Thomas Wei=C3=9Fschuh wrote:
> On 2024-03-15 16:41:34+0100, Joel Granados wrote:
> > Hey Thomas
> >=20
> > Did you forget to compile? I'm seeing the following error when I
> > compile:
>=20
> Welp...
>=20
> >   ...
> >   ../fs/proc/proc_sysctl.c: In function =E2=80=98proc_sys_make_inode=E2=
=80=99:
> >   ../fs/proc/proc_sysctl.c:483:43: error: passing argument 2 of =E2=80=
=98root->set_ownership=E2=80=99 from incompatible pointer type [-Werror=3Di=
ncompatible-pointer-types]
> >     483 |                 root->set_ownership(head, table, &inode->i_ui=
d, &inode->i_gid);
> >         |                                           ^~~~~
> >         |                                           |
> >         |                                           struct ctl_table *
> >   ../fs/proc/proc_sysctl.c:483:43: note: expected =E2=80=98kuid_t *=E2=
=80=99 but argument is of type =E2=80=98struct ctl_table *=E2=80=99
> >   ../fs/proc/proc_sysctl.c:483:50: error: passing argument 3 of =E2=80=
=98root->set_ownership=E2=80=99 from incompatible pointer type [-Werror=3Di=
ncompatible-pointer-types]
> >     483 |                 root->set_ownership(head, table, &inode->i_ui=
d, &inode->i_gid);
> >         |                                                  ^~~~~~~~~~~~~
> >         |                                                  |
> >         |                                                  kuid_t *
> >   ../fs/proc/proc_sysctl.c:483:50: note: expected =E2=80=98kgid_t *=E2=
=80=99 but argument is of type =E2=80=98kuid_t *=E2=80=99
> >   ../fs/proc/proc_sysctl.c:483:17: error: too many arguments to functio=
n =E2=80=98root->set_ownership=E2=80=99
> >     483 |                 root->set_ownership(head, table, &inode->i_ui=
d, &inode->i_gid);
> >         |                 ^~~~
> >   cc1: some warnings being treated as errors
> >   make[5]: *** [../scripts/Makefile.build:243: fs/proc/proc_sysctl.o] E=
rror 1
> >     CC      fs/xfs/libxfs/xfs_dir2_node.o
> >   make[5]: *** Waiting for unfinished jobs....
> >   ...
> >=20
> > I'm guessing its just a matter of removing the table arg from
> > proc_sys_make_inode?
>=20
> Yes, for this error it's correct.
>=20
> There are also new implementors of the set_ownership callback in ipc/
> which need to be adapted.
>=20
> I'll send a new revision.
Thx. Not sure what your using as a base, but I suggest you use
linux-next so you get al the stuff going into the rc.

best

--=20

Joel Granados

--dcq2itrqq6m5yonn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX0dPcACgkQupfNUreW
QU81eQv/YATUMB0JjIPW8J4XRb/OFdpstOc0Yeqi/vJfhdfer0NWXpE86Bgfd4N6
O2g7pfT829Uulvxa1eJM4kV1nxGxwverjTnM51+MhLsm4dgEkr7eKNQLQmqujiSD
0fNWaKP2bApuYGS+KZxhU+cEJm7V40ytX3d+wFsAha4r7Ri2nqQZyAg4/7n7YLaK
9mq7d49wJrBZD8mzccRRJ8nmzWgpILaSJz/wjh6afYY9d1saU6F4I7oyxYgZJIrE
FCdliJTbAunj/EU32i3HHgEUFeIaGe3PQnnoFgXgbD2yRLhqwY0acLlo2gONDeVX
RxfNxb2Im8S5XaWjZzD/slaXjYi/zifoLlDxkGKrEX72aIbkkaQcFLvcI5yi/Dod
3mys2Ha1DWi9sjdpb5lmGILPKfG9hKW0ec381Ad1N6hXC9E/Jh8KfnQFJ9Z/v/qM
+dnaahqgcDcR49MLl1QK0o/5ECoP6iineFLOtxlm2Dijag58PQ21x7i6HP7RAjyW
bsR78PtN
=IudT
-----END PGP SIGNATURE-----

--dcq2itrqq6m5yonn--

