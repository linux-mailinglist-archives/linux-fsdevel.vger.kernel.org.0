Return-Path: <linux-fsdevel+bounces-2209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA367E3618
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 08:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55699280E69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A851CA6E;
	Tue,  7 Nov 2023 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mxbYnHUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBDCA59
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 07:49:49 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFABBC6;
	Mon,  6 Nov 2023 23:49:45 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231107074941euoutp01e70a20b80ae2093d42c289d3c6d6f9ec~VR81PlP9j3099230992euoutp01d;
	Tue,  7 Nov 2023 07:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231107074941euoutp01e70a20b80ae2093d42c289d3c6d6f9ec~VR81PlP9j3099230992euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699343381;
	bh=Lv7l3lGB0bDT66EqgjPYgsbj32RoqRNgxRol3KmSfMc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mxbYnHUQJJjzhCSP4f/4IDpOjKZLlvigjMTT5Fr3pCJSYKbDXpXITEWKrBm8wxmt+
	 +4qvrZ8uJkgKHp0ZH92x4pDvE7cgbp2L+wCwEwfW97zQ5YybB1qLw7XTqSf2jLWWHE
	 3MHP2X2cTV4eOgbQC0hYJvm7yQrZnZ7xx1uWWFX0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231107074941eucas1p1a89d2cad73c1c7d923c1df96f74080af~VR81EP5oZ0089800898eucas1p1k;
	Tue,  7 Nov 2023 07:49:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.EF.42423.51CE9456; Tue,  7
	Nov 2023 07:49:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231107074940eucas1p28a1aa7c1c98e72356babc5faba5df533~VR80uJLdo1464914649eucas1p2L;
	Tue,  7 Nov 2023 07:49:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231107074940eusmtrp1a34e9a20e3b9aa55ff5c922c85bc0e52~VR80tg_Gv1436514365eusmtrp1Z;
	Tue,  7 Nov 2023 07:49:40 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-7b-6549ec153a1d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.E9.10549.41CE9456; Tue,  7
	Nov 2023 07:49:40 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231107074940eusmtip1b1a2ee9e9c80fecbc7f16e1940f6e841~VR80gssDn2498024980eusmtip1E;
	Tue,  7 Nov 2023 07:49:40 +0000 (GMT)
Received: from localhost (106.210.248.176) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 7 Nov 2023 07:49:40 +0000
Date: Tue, 7 Nov 2023 08:49:39 +0100
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: <keescook@chromium.org>, <patches@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Joel Granados as co-maintainer for
 proc sysctl
Message-ID: <20231107074939.sy45jvdvyd7sr3w7@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="h5hdrq2a6gtomf25"
Content-Disposition: inline
In-Reply-To: <20231102203158.2443176-1-mcgrof@kernel.org>
X-Originating-IP: [106.210.248.176]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7qibzxTDVa95rM4051rsWfvSRaL
	y7vmsFncmPCU0eLyiUuMDqwesxsusnhsWtXJ5vFi80xGj8+b5AJYorhsUlJzMstSi/TtErgy
	Lm99y1Swm7/i6u1t7A2M63m7GDk5JARMJL5s2MHSxcjFISSwglGiZ9MOZgjnC6PE/Xlr2SCc
	z4wS/39tYIdpOXpkBVRiOaPEwSOT2eGqPh1rhHK2MErM6p0J1sIioCLR/GItE4jNJqAjcf7N
	HWYQW0RAQ2LfhF6gOAcHs0ClxKNJgSBhYYEwidftX1hAbF4Bc4nV5y+xQdiCEidnPgGLMwtU
	SLT0nWWDaJWWWP6PAyTMKWAp0fT1OCPEocoSzdsPQB1dK3Fqyy0mkNMkBL5wSDxvOcEKkXCR
	+DJ1NVSDsMSr41ugGmQkTk/uYYFomMwosf/fB3YIZzWjxLLGr0wQVdYSLVeesINcISHgKHGm
	wRLC5JO48VYQ4k4+iUnbpjNDhHklOtqEIBrVJFbfe8MygVF5FpLPZiH5bBbCZxBhHYkFuz9h
	CmtLLFv4mhnCtpVYt+49ywJG9lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBqer0v+Of
	djDOffVR7xAjEwfjIUYVoOZHG1ZfYJRiycvPS1US4f1r75EqxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwKR95uC6fe3Cdw2YJv23t7y17qaf4dq9LYxf
	4uvPXtucYdtYJs4t/W72vYy0o/cP206fv8JJKLClrZBBc2KM6K4T2sHXFhSnWKkm/ZzPc3TL
	U7aHF/VfzKu3dm4SfvvH6ddh54O3N+f+r5x28/9zS/vYP/nez0RUvZYvZj57WXj9jgY3ryvv
	vq2atLiUy5Px0lf7k1/i++0cf3xjDXy/aW762w8Rjkb881le7OJwuHSU92aHg8/E6S1m+Uqm
	Mz+8aJ7FWZSR0uMXwPszNvu49unY3/a5YdsdlkRP/6LAUKe8cvKZqfMYJp7ofnop+seuObk6
	1eKXBOYVp8vtU+D5WfnhRc+fC1ITnvAs3OOdI92txFKckWioxVxUnAgAkkTkLtADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7oibzxTDea1m1ic6c612LP3JIvF
	5V1z2CxuTHjKaHH5xCVGB1aP2Q0XWTw2repk83ixeSajx+dNcgEsUXo2RfmlJakKGfnFJbZK
	0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZkz97F+zkr+i68Zy9gXEtbxcj
	J4eEgInE0SMr2LoYuTiEBJYySvRs3cAMkZCR2PjlKiuELSzx51oXVNFHRon/B56wQzhbGCW2
	PjsGVsUioCLR/GItE4jNJqAjcf7NHbBJIgIaEvsm9ALFOTiYBSolHk0KBDGFBcIkZu2VBKng
	FTCXWH3+EtT8HkaJWa8ms0IkBCVOznzCAmIzC5RJbHo/AWqMtMTyfxwgYU4BS4mmr8cZIe5U
	lmjefoAdwq6V+Pz3GeMERuFZSCbNQjJpFsIkiLCWxI1/LzGFtSWWLXzNDGHbSqxb955lASP7
	KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBo3Xbs5+YdjPNefdQ7xMjEwXiIUQWo89GG1RcY
	pVjy8vNSlUR4/9p7pArxpiRWVqUW5ccXleakFh9iNAWG4URmKdHkfGAaySuJNzQzMDU0MbM0
	MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFKU6hd44xete2CZRJKo6U7BtK1cm46o
	9D9srM5O4F3wYI3vXcZj+yer/1AqW1m1b/9VjvzZdgeKCiu+iXxczHu655c3b35l9sq0WeVX
	ojYVCmzhFctbcZLf5k3xnrYDwdv8PqwUfFEptHJuwh/7Vdc2MTz/3MxzYXXhiWdblu08rH6m
	+o6fYkfy2uCWFzOdJS9oB56y8guQLtzzuoONVfmeXPfcwAgWh9dGqXrJPZyrraIkDHYU31wU
	4B6zKjk9OrKhcc1PocpKXtuQz8qXF/1J5JljeXHXCqtjV02qD4VOYBLpZV2RfnTtHR+hLvfP
	t9Zzv7i6IurThqzaEJlIvvjXq14euJslNscs4H0bsxJLcUaioRZzUXEiAJlfP/NrAwAA
X-CMS-MailID: 20231107074940eucas1p28a1aa7c1c98e72356babc5faba5df533
X-Msg-Generator: CA
X-RootMTR: 20231102203208eucas1p14cd9089da85eb9f7932b6fb04cfc41a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231102203208eucas1p14cd9089da85eb9f7932b6fb04cfc41a8
References: <CGME20231102203208eucas1p14cd9089da85eb9f7932b6fb04cfc41a8@eucas1p1.samsung.com>
	<20231102203158.2443176-1-mcgrof@kernel.org>

--h5hdrq2a6gtomf25
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 01:31:58PM -0700, Luis Chamberlain wrote:
> Joel Granados has been doing quite a bit of the work to help us move
> forward with the proc sysctl cleanups, and is keen on helping and
> so has agreed to help with maintenance of proc sysctl. Add him as
> a maintainer.
Thx @Luis. Currently preparing the next batch of the "remove sentinel
patches". Will push them out as soon as I clean them up and test them

Best

>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66c2e2814867..c9b077e779d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17224,6 +17224,7 @@ F:	tools/testing/selftests/proc/
>  PROC SYSCTL
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  M:	Kees Cook <keescook@chromium.org>
> +M:	Joel Granados <j.granados@samsung.com>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
> --=20
> 2.42.0
>=20

--=20

Joel Granados

--h5hdrq2a6gtomf25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVJ7BIACgkQupfNUreW
QU86dgv+PQ72kqzGG51MJZgTdDLzljQIMequr1TCbfH+ZuyVsf6N1r/rGMQAEA08
gQwp4OoI3vmMTJGlgDtkvvPN/RiQbfEuFrJgiIPLbI7WAD7E4aKw9CrZiX4qty74
ehowC85A8hVByAFRJu1Pe5aRbXNJRv1KIHQJDJagMsiB1FG4P8bo82aW3ZoRRTAR
1jWqfm8K6AY+6IvcZN1lF49t8k8h4O38O6CV8vjEQRiRhW0Gv6P4BUfY80NDin9h
rlGKDTnB8OZxgcnbacVRHgACtZSfWlxa9xAeLOc4qCTnP7l5Geq3JwbOv8/s+hdE
ySqXpOFvsiz98CEK/Oi9O4u6FMiItY+RQFjWh6oIZjHNSBvHGfobMF1nVT3qx+zB
BZAE67/kV5ahWaHOqYelCsEKPnU0s2SxhX4aGesEPu4a9rpSDbMgE2xZw6WsfQCz
QzajY6SMGNHN4pLv/PZD55SPIoeL5m7bZNw9LuCuTzOLHszjjMBrx9+2jfVMDmE6
VkwQ8bAM
=EYqh
-----END PGP SIGNATURE-----

--h5hdrq2a6gtomf25--

