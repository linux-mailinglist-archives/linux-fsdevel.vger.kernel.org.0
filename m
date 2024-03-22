Return-Path: <linux-fsdevel+bounces-15076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5600C886C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 13:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D70B24FCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAB5446B6;
	Fri, 22 Mar 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="unuOFEuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AC1EB31;
	Fri, 22 Mar 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111637; cv=none; b=WlLf6Fyagc+YJCyKqBU9beDruMihedDDFIcTU1QPYTzlfTSBvohHaTB+2QNrIuW9fJVJjYCRsfleqaNSoFyQRv+sYBTGFNaNXMYu5TU+EZAuy98mezBMRMLQtEdWnRIV6MNFGNv65tDyRuTszca7I0DzcmIn7ZLzBKEfI1UeFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111637; c=relaxed/simple;
	bh=0jfKZv5KL4RBBl2/igH9zhoZv/XzieYaoshZnN+1CVg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=tapNDNATFbiVs76TM/IMfXTbqktK8GJtv/mlpYYj9uF8II6o7FfpsLv2BF+0+BV4ueqqQWusA6DBL0q6Z9JaQ3JPlF7/HNZls3eaSzrXEywPRRo9z9OYQZovKxyHdeFo/zL6QFT15Jov+tDguGV1pj9fW/x7mJiBx6sMhmnb4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=unuOFEuU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240322124713euoutp027f4dd0c8071064476319b54123013645~-FvbhBa5t2654626546euoutp023;
	Fri, 22 Mar 2024 12:47:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240322124713euoutp027f4dd0c8071064476319b54123013645~-FvbhBa5t2654626546euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711111633;
	bh=6Cqf1rQeKRg7RNM4i7sbKmaMDFDJDK6zLin6A8mDMXA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=unuOFEuUTY81g/tfpjXhRIJxRHk3HaH0drnp9Di0OzN2kL8AeuULtlJwsLqm3Vbd1
	 QsSMD6KiGFqHxrGAlsYb1/8yaVStM6Tj+XLTKx3Fliqedss4wVDFiXsWbOXo9iLYeP
	 KPbIUb7g1/irI824dasDbiG//w6lB39pQKl4A7eA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240322124712eucas1p17a3667f23b57d166600989d2b2320a92~-FvbTFnZ00844708447eucas1p1Z;
	Fri, 22 Mar 2024 12:47:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 56.53.09539.0DD7DF56; Fri, 22
	Mar 2024 12:47:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240322124712eucas1p2dfdea1ba2265647e01642ec2b54a60f0~-FvauktHD1616816168eucas1p2f;
	Fri, 22 Mar 2024 12:47:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240322124712eusmtrp1ab054cc556f9a0fbd0489ceb85edcfcc~-FvatQ0N42291322913eusmtrp1E;
	Fri, 22 Mar 2024 12:47:12 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-f8-65fd7dd0a022
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.7C.09146.0DD7DF56; Fri, 22
	Mar 2024 12:47:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240322124711eusmtip1616bdbd57c112ae38ea928798d76b128~-FvaiAmGs2391323913eusmtip1E;
	Fri, 22 Mar 2024 12:47:11 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 22 Mar 2024 12:47:11 +0000
Date: Fri, 22 Mar 2024 13:47:09 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] sysctl: treewide: prepare ctl_table_root for
 ctl_table constification
Message-ID: <20240322124709.w5ntjwb5tbumltoy@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="72nq2u4tvhj4hanv"
Content-Disposition: inline
In-Reply-To: <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87oXav+mGuxfoW0x53wLi8XTY4/Y
	Lc5051pc2NbHarFn70kWi8u75rBZ/P7xjMnixoSnjBbHFohZfDv9htGBy2N2w0UWjy0rbzJ5
	LNhU6rFpVSebx/t9V9k8Pm+S8+jvPsYewB7FZZOSmpNZllqkb5fAlbG3+Sl7wQLpijvTljA1
	MM4X72Lk5JAQMJH4cnMDexcjF4eQwApGiXsflzNDOF8YJWZ/ewLlfGaUeHT8GwtMy8LGs0wg
	tpDAckaJ7n3ccEUTjjaxQThbGSUOb38A1sEioCrxeV8XO4jNJqAjcf7NHWYQW0TARmLlt89g
	y5kF9jFJfLzYBlYkLJAssaJ/DlgRr4CDxO9TBxkhbEGJkzOfgA1lFqiQuNh+DGgbB5AtLbH8
	HwdImFPAX2LBlttsEJcqS1zftxjKrpU4teUWE8guCYHNnBJtZ1YyQSRcJH6d7maEsIUlXh3f
	wg5hy0icntzDAtEwmVFi/78P7BDOakaJZY1fobqtJVquPIHqcJR4PvcLI8hFEgJ8EjfeCkIc
	yicxadt0Zogwr0RHmxBEtZrE6ntvWCYwKs9C8tosJK/NQngNIqwncWPqFExhbYllC18zQ9i2
	EuvWvWdZwMi+ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzD1nf53/NMOxrmvPuodYmTi
	YDzEqALU/GjD6guMUix5+XmpSiK8O/7/SRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyok
	kJ5YkpqdmlqQWgSTZeLglGpgmtR9ZHbTr7Ql+7Z4KGW0G4QrNfucu/J70gS3Hg5bDb2Cd49O
	5YlLqfg8+lLpavu/O1j+orTQ2TuhL/f7Pzxjv+rw2vqfPSy3lzreTvD2uHVCt9LYoWWi69me
	NfHhubxf1dZ/iIyfunC/V652w4zjOTvS5fdl8zw8cCSgbKvivV+r+qX55t5SyvLpsMgqENHw
	WOKy/3ZTek75hP93XBnffdf6HiIaeXu5w8dNuy5MufN2t0zZec9JVoc1z7VvSRM4oX1K5VWV
	6y3RBctitiha7E/efUtcQtDq8fN9EX8WHeCbNyv7YBB77PWG9zHHV75YYt41U8r22HzmOrkv
	mvoKHxrmMDxb7f4y2+5N8pLASCWW4oxEQy3mouJEAGo6tWv4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd0LtX9TDR5/ZbaYc76FxeLpsUfs
	Fme6cy0ubOtjtdiz9ySLxeVdc9gsfv94xmRxY8JTRotjC8Qsvp1+w+jA5TG74SKLx5aVN5k8
	Fmwq9di0qpPN4/2+q2wenzfJefR3H2MPYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
	NDaPtTIyVdK3s0lJzcksSy3St0vQy7h7by97wTzpivPzjjM1MM4V72Lk5JAQMJFY2HiWqYuR
	i0NIYCmjxMmPd1kgEjISG79cZYWwhSX+XOtigyj6yCjRceUXlLOVUWJD23dmkCoWAVWJz/u6
	2EFsNgEdifNv7oDFRQRsJFZ++8wO0sAssI9J4uPFNrAiYYFkiRX9c8CKeAUcJH6fOsgIMXUR
	o8TcDVuhEoISJ2c+AbuJWaBMYuayHUCrOYBsaYnl/zhAwpwC/hILttxmgzhVWeL6vsVQdq3E
	57/PGCcwCs9CMmkWkkmzECZBhHUkdm69gymsLbFs4WtmCNtWYt269ywLGNlXMYqklhbnpucW
	G+oVJ+YWl+al6yXn525iBCaAbcd+bt7BOO/VR71DjEwcjIcYVYA6H21YfYFRiiUvPy9VSYR3
	x/8/qUK8KYmVValF+fFFpTmpxYcYTYHBOJFZSjQ5H5ia8kriDc0MTA1NzCwNTC3NjJXEeT0L
	OhKFBNITS1KzU1MLUotg+pg4OKUamMyd8gxSEvSjI2x4b3SW3HTkO3jf58xS/s6Si1xGr5V1
	j+0vObq0oobzl+zy1oQforsCvJZEr5TIPKY+TWPC+7VZ0a53l22b9N5Yhn1W/eQFJwTb4z3E
	WIx4f1kq8U02bHz+3OLB3xPu3srnWYPOxWVOcDov1/JydeRBA4m/p28/fyno6qAQuOH66SKu
	4j0Vt19VC7yYxxYcri3Tn8lTJV/g6NzSml/67JDmwgilS9NLZWY3uO070Bixwd4yWnfbv/l7
	7XyvSzrt+vIx9oFRjavVEts3zE1H7i/xLHFJa4zPS3b6k3GkVEBaZWqz8P6/c/hOFgmFi/AK
	//r903yVwoq772caHF9wtPU2y88MJZbijERDLeai4kQAO1PlpJUDAAA=
X-CMS-MailID: 20240322124712eucas1p2dfdea1ba2265647e01642ec2b54a60f0
X-Msg-Generator: CA
X-RootMTR: 20240315181141eucas1p267385cd08f77d720e58b038be06d292e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240315181141eucas1p267385cd08f77d720e58b038be06d292e
References: <CGME20240315181141eucas1p267385cd08f77d720e58b038be06d292e@eucas1p2.samsung.com>
	<20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>

--72nq2u4tvhj4hanv
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 07:11:29PM +0100, Thomas Wei=DFschuh wrote:
> The two patches were previously submitted on their own.
> In commit f9436a5d0497
> ("sysctl: allow to change limits for posix messages queues")
> a code dependency was introduced between the two callbacks.
> This code dependency results in a dependency between the two patches, so
> now they are submitted as a series.
>=20
> The series is meant to be merged via the sysctl tree.
>=20
> There is an upcoming series that will introduce a new implementation of
> .set_ownership and .permissions which would need to be adapted [0].
>=20
> These changes ere originally part of the sysctl-const series [1].
> To slim down that series and reduce the message load on other
> maintainers to a minimum, the patches are split out.
>=20
> [0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhal=
itsyn@canonical.com/
> [1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@=
weissschuh.net/
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - Drop now spurious argument in fs/proc/proc_sysctl.c
> - Rebase on next-20240315
> - Incorporate permissions patch.
> - Link to v2 (ownership): https://lore.kernel.org/r/20240223-sysctl-const=
-ownership-v2-1-f9ba1795aaf2@weissschuh.net
> - Link to v1 (permissions): https://lore.kernel.org/r/20231226-sysctl-con=
st-permissions-v1-1-5cd3c91f6299@weissschuh.net
>=20
> Changes in v2:
> - Rework commit message
> - Mention potential conflict with upcoming per-namespace kernel.pid_max
>   sysctl
> - Delete unused parameter table
> - Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-ownership-v=
1-1-d78fdd744ba1@weissschuh.net
>=20
> ---
> Thomas Wei=DFschuh (2):
>       sysctl: treewide: drop unused argument ctl_table_root::set_ownershi=
p(table)
>       sysctl: treewide: constify argument ctl_table_root::permissions(tab=
le)
>=20
>  fs/proc/proc_sysctl.c  | 2 +-
>  include/linux/sysctl.h | 3 +--
>  ipc/ipc_sysctl.c       | 5 ++---
>  ipc/mq_sysctl.c        | 5 ++---
>  kernel/ucount.c        | 2 +-
>  net/sysctl_net.c       | 3 +--
>  6 files changed, 8 insertions(+), 12 deletions(-)
> ---
> base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
> change-id: 20231226-sysctl-const-ownership-ff75e67b4eea
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

Will put this to test and then try to rebase it to 6.9-rc1 once it comes
out.

Thx.

--=20

Joel Granados

--72nq2u4tvhj4hanv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX9fc0ACgkQupfNUreW
QU8PfAv/au7WdV/9HQRSvVtVlGjOSmbvLvSn0f+bY4/MViHS3YgB60G+MbmKVYXT
C1nzEhRwKEl2lY/kNQVsgDWHN5svPisXDck/1OWyg581FG7/gIlJSeARfhYSsdaB
6iovOAWkLN3+Anfr2qKUMLdKfCrHH2CuCAw8ddf4JO9yIEoKmxe406gVwiEkgEER
sAdYpwB13u85JLyMwcOYPHKSOb81x0yl+XtFlt31FWBiyqh98QQ47tbgfb0Mskva
0uIeX/oGse+NPRLD6Ppbq9DPobERX4zSenTvwxU7iX4jdK7P1QYPbgw8cTGvPPhd
/u2B0BGu8dGXKZbslSNxNllWBXJH0W9cQLRku1LlQaG2YIpIBZIo2PjMORRc8nRD
0H9UC4Uu+45sSKrQqwZZ4wcjHLSmKqgVjy3BVy2/iIMFKG3SQ/gcVy8fpl35VmTl
IHfkDeZbzOPhvgapP8akweK8dNW+9n3TXHDZff9GRQyHm4My54PWH5mVHj8kmJmj
VTUO529V
=1Plv
-----END PGP SIGNATURE-----

--72nq2u4tvhj4hanv--

