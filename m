Return-Path: <linux-fsdevel+bounces-17609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5638B0358
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135271F25091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C71581F5;
	Wed, 24 Apr 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H9R2Uiqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADE1534E0;
	Wed, 24 Apr 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944479; cv=none; b=rwtqNlGSS/M0+Q/GBE4K6DP5dZWqzllX1yRhhBKwwtwFPsCHdm9OkRtF2DX7JdTacKIAdMPPqFCqxfaikmu5YyUjt6LswKhecTj4UsuwY77+KZo13/7jEaDdONuOa8O2vvpd8d0SmJV1iQgoMsOYpcWnm/dv9POAEAggLM0enPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944479; c=relaxed/simple;
	bh=euFLyW2mUNGGgNiXwy0oljlRB8crL8I7b65VqKg3OEE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=EDO7O91hdmvfWenG4+uH9aHIGw6APOiLZOeL5dJUEE76MZofw+p90bougVtflkY8yAeO3RWe0d/7CHZabKvVevCVn6EQOftVtUMPzG/J9hXbwLfzk9mDQ7eL3/xpawla7FzJmBtfMkpSoYJHryKTFOKRWeB2900X27JlNN1JG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H9R2Uiqz; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240424074112euoutp028d29c7710f7c087eee559032f3e46581~JJ2rVDMWA1064410644euoutp02g;
	Wed, 24 Apr 2024 07:41:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240424074112euoutp028d29c7710f7c087eee559032f3e46581~JJ2rVDMWA1064410644euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713944473;
	bh=euFLyW2mUNGGgNiXwy0oljlRB8crL8I7b65VqKg3OEE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=H9R2Uiqzrt7iYZRpYqEZMkbiPnTuybjRTzu+swHRR1ZJ4BrcX0oY35veJwuuxeUbe
	 aQNHO5P1fZmCdsoUmq/bALd65Xw085eBa9TR0A393uOoRtf/89Do7uA+lBbj+qgbLT
	 EkZRQaeydvBr0L76NbpRUCNNIdiNInkF6mPfy4ok=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240424074112eucas1p1863d3d7b98e0dbe97dd21ee66730e62b~JJ2rICFNZ0760407604eucas1p1p;
	Wed, 24 Apr 2024 07:41:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.7D.09624.897B8266; Wed, 24
	Apr 2024 08:41:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240424074112eucas1p259a4acc486ca5f8c6cbb4f736f2f984b~JJ2qnrul33139631396eucas1p2L;
	Wed, 24 Apr 2024 07:41:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424074112eusmtrp12bcebea7847b59366df6dd19bb3a048e~JJ2qmXIIM2835628356eusmtrp1k;
	Wed, 24 Apr 2024 07:41:12 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-08-6628b798d2b4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.B0.08810.797B8266; Wed, 24
	Apr 2024 08:41:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240424074111eusmtip1681f98af2abf64a19d66d0e7ab3c9e0d~JJ2qThM-V2991229912eusmtip1-;
	Wed, 24 Apr 2024 07:41:11 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Apr 2024 08:41:11 +0100
Date: Wed, 24 Apr 2024 09:41:06 +0200
From: Joel Granados <j.granados@samsung.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, <josh@joshtriplett.org>, Kees Cook
	<keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
	Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
	Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas
	Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
	Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
	Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
	<john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
	KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <tools@kernel.org>
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel
 dir
Message-ID: <20240424074106.c3dojqvobepifrut@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="3ox4bgvwus4z6gtg"
Content-Disposition: inline
In-Reply-To: <36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe0xTVxzOuff23sJSdik4T3DBiKJMBWTO5CxOIhsxN3FjbmZLYFu2Ri7g
	gEJaq25mCTJAqLKhUNHyKhKe5SEtgvJeBxR5lFEYVt4KruMhiDwE5THqxc1k/32/73HyfX8c
	Pi5sphz4J8WnWIlYFOJEWhPlTUsG12sVLgH7Litc0LMXKTiq+ruPQHNLfRSabdCTyDjyJ4mS
	x84TKHWsjUJZmQs4Su2IItCjhFs4WiuPopBOX0ehyNt5GCrvzgCoIUm5LqjC0HJzKYkGflUQ
	qO1iKKpqncdQbGIFgcy18RiqrrlLoK7KVBI1lLQTSF0UwUPZ9zoxVBiXz0OmhEcAJU79BVBW
	7k5krFdhSJ20QiF9fD2G1kbmeag2dhhDqz2lBDIuThCoqvQGifS5KyTSahQ4MpQ+wFFsw3rX
	W43PKNQnX6PQsLqch3Lu+Bx2Z4YmVwimML0QMCkRnQRTln8fY+4oBygmqraXYlQaGaPN281k
	VY9hjNxkxJneiUOMpiCOZPp7qklmymCgmMwIBc4k3KgHx97ys/7Anw05eZqVuHt+Zx20ptGQ
	4UX02eYX02QESLSRAys+pN+D8pl0TA6s+UI6D8DkOiPJHXMATs0lE9wxC+Biiw68ijRl5+Oc
	kAtgz83r1L+u+ZKoDUULoLImjmeJELQzrI7Ixi2YpPfCjsn+dczn26/jOIXU4sfpRgHsSOog
	LB47+hhU9BgpCxbQh2F7SwbGYVt49/roSw9On4VdI1rK8g5Ob4G5q3wLbUV7wiVVN8E13Qbn
	swY38E+wpaz35VBIL7wBpysXME7whpd+NmyY7OC4vozi8NuwNfESwQUSAaxbfUJxhxrAnPPz
	G+mDMKp7dCPhBWMGpwlLI0jbQNNjW66oDbxSnoxztADGxgg5906oHpwkEsB25WvTlK9NU/43
	jaP3QlXVU/J/9B6YkzmBc/gQLC6eJlSAKgCbWZk0NJCVeojZM25SUahUJg50OxEWqgHrH6x1
	Vf/0Nkgbn3HTAYwPdGDHevjhTfUfwIEQh4lZJ3vB8+UdAUKBv+iHH1lJ2LcSWQgr1YEtfMJp
	s8DZfysrpANFp9hglg1nJa9UjG/lEIHZ1Q/7ms7ZbM++ag6TFadmRuZsPd72xKcy3LvnmtlH
	EUOvfEqdc3/zq6N+XgcuD+TrPrw6Mdq/z/hNipjnmuRY6Wagl02nJ/2HG1V+j6NN2xodH9iF
	jzSbJ++bQ+0lQ0JvW9GopyTJmq9zRMtMbFrtpgnF8Tyv1hmbCvsEh4NKk94GP+JVEx9Y2zJz
	r73YNZt34oLT+Ged8oCgdxxxSfSXwd06l5KLbZOJCqSl9tR+f/R5u7mrIDh8MYP9On1Xmr/s
	SPTRsc/Z0f3vhgwp85tDK4u+uKD/KDLFy/eXKwVMn2/8x86/eYwtag7Yn5n1GHl/U/L4J2RT
	1P6H6hVDl3bX7wNOhDRI5LEbl0hF/wACtOw12wQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTVxzHdx+992LsdlcQb8AsG8qC4ApFYAcGjMyEXJw4lrlk02xa4fLY
	oMU+BJdhCnQGSpyo4EZhUOh4WawWtIAwRAZWJiAgreW1gYisA0QnD5k81totM9l/n/P9fn/f
	/HJyDoFwJjAXIkEgYUQCfqIbtgG9tWYYfev7eo9Yn6eLEFh6VoiApt+HUTC/PIyDJ+0GDPRP
	GDHwnSUdBUWWLhyoSxcRUHRbjoLJ3CsIWNfLcdBmuIaDjIYqGOgHSiDQnqe0GiohWLmpw8Do
	qXwUdOUkgaZbCzDIOluPgqmWkzBo/qkTBXeuFmGg/WI3CjQXZCxQfrcPBjXZ1Sxgzp2EwNmH
	DyCgrnwT9LeqYKDJW8WB4WQrDNYnFligJWsMBmsmHQr6n06joElXhgFD5SoG6mrzEdCjG0dA
	Vrt11ysdSzgYVqzjYEyjZ4GKxr1h3vRvM6soXVNcA9GFsj6Uvlw9CNONylGclrcM4bSqVkrX
	VXnS6mYLTCvM/Qg9NB1C157PxugRUzNGP+zpwelSWT5C55a1QlHO+7nBIqFUwrweLxRLQtwO
	8IAvlxcIuL5+gVzezrc/C/L1d/MODY5hEhOOMiLv0EPc+GXdB8kaMvX+nXOIDDr9sgJyICjS
	j7pRXo0ooA0EhyyHqKLCLtxubKF080aWnR2pFZMCs4ceQ9TsvBq1H+ogSq/MfJ5CSXeqWVaO
	2Bgjd1C3Z0asTBBOVs7OF9vyCNnBpsxTJZgt40jupUbOtKI2ZpNhVPcvJbC9dAyiBmtPsezG
	q1Rnwf3nIYQ8SukX0lm2UoR0pSrXCJvsQIZSy6oB1L7pG9SC+td/OI16svoAyoUclS80KV9o
	Uv7XZJc9KfOaBf6f7EVVlE4jdg6htNo5VAXh5yEnRipOiksS87hifpJYKojjRguTaiHrC9ff
	WK5rgIr/eMxtg2ACaoO2WSfvXdL0Qi6oQChg3JzYf61si+WwY/jHvmJEwoMiaSIjboP8rbd4
	GnHZFC20fheB5CAvwMef5xcQ6OMfGLDTbTM7IjmLzyHj+BLmS4ZJZkT/zsGEg4sMThEvFTj7
	GfUNQ84drl5yzRx+Ziv9/sjx4YiV8Cl5sCLUHHmuryucXrpmzPn0Zspg/icbhxzKduX+aB42
	TqaPawP93bsnX6l/1ze16zXRoz1+u6pUf7704aETKY/G1YQ2fJrp/Tgh0aNC/nXI2Im5sN5n
	jdc528MlxjwTPx1eL/jWsLq7u3L2WDeRlhOdESnaav5hn/uAKT7ivR0VUn4kW1t6t1L7ec5H
	QccPz+atR7GL245s8VYsemVuzxgw44uj+zsXNqceCN74hUU6c5m4lOD68zs997wsIr1HX0co
	E4SUxHof3nT9m+C+tDBOpulIzFXdnn3OF8zi5DCDS91o1Ap50Q0Vx/N5nohIzP8b8evTHXYE
	AAA=
X-CMS-MailID: 20240424074112eucas1p259a4acc486ca5f8c6cbb4f736f2f984b
X-Msg-Generator: CA
X-RootMTR: 20240422142758eucas1p26e94cf6fbbbc99b27e941a172e8a4e41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240422142758eucas1p26e94cf6fbbbc99b27e941a172e8a4e41
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
	<CGME20240422142758eucas1p26e94cf6fbbbc99b27e941a172e8a4e41@eucas1p2.samsung.com>
	<36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>

--3ox4bgvwus4z6gtg
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 04:27:47PM +0200, Konrad Dybcio wrote:
>=20
>=20
> On 3/28/24 16:44, Joel Granados wrote:
> > What?
> > These commits remove the sentinel element (last empty element) from the
> > sysctl arrays of all the files under the "kernel/" directory that use a
> > sysctl array for registration. The merging of the preparation patches
> > [1] to mainline allows us to remove sentinel elements without changing
> > behavior. This is safe because the sysctl registration code
> > (register_sysctl() and friends) use the array size in addition to
> > checking for a sentinel [2].
>=20
> Hi,
>=20
> looks like *this* "patch" made it to the sysctl tree [1], breaking b4
> for everyone else (as there's a "--- b4-submit-tracking ---" magic in
> the tree history now) on next-20240422
>=20
> Please drop it (again, I'm only talking about this empty cover letter).
I see it. Will remove it from sysctl-next

Thx for pointing it out.

Best

>=20
> Konrad
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/com=
mit/?h=3Dsysctl-next&id=3Dec04a7fa09ddedc1d6c8b86ae281897256c7fdf0

--=20

Joel Granados

--3ox4bgvwus4z6gtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYot5IACgkQupfNUreW
QU9JLgv/Xk/varStEW5HfSJDViPIf/SWclVUTpImKj1IK/P76DyvjPdXaekBKiYf
iwRRN/qqbvDCYp9Hu3nOT5Pp6+kRDKIsMAhz0S+74V6N6kmYo+zuomJ6B5xYE5v/
lBK2Pecvdic/IhnaYYJrr0kfNFfDpFNnZLEkI+Ao+u9Qho5sXoQqMzB0gdhGNBsA
sg3tHBk72GQoBtnXD0vAgLe1a3nMIX58N5U8If5nMIY24dk5WDqk4uF+VeKuWoql
bgEeNHnxrgX+7o65CXUKl3Y5P2r35p4lZ26nSKxUcy9rxCVluyqvcjOWKegC2RHc
BsPdxqlq+sCS+Jl8GvV9RodvW+TseL8sYbm78PuhrBLmME46zyw8hMOIe9KTQGKz
PL13bLzLyQ3kHjVyngfEnrobUBJWTO0wSEroqttx/GoKMeFBBubPV9DFnlYmt8qN
+q1wOQc7/yuDYZHNo272pNOPnLogsjiXUihpXna2l3vN3L8QPb7v52yQHToJeDiK
RZTL83Ww
=o7gc
-----END PGP SIGNATURE-----

--3ox4bgvwus4z6gtg--

