Return-Path: <linux-fsdevel+bounces-4754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92E8030A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AEF1F2106B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF86224C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H5q2Dmz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD09FD;
	Mon,  4 Dec 2023 00:56:33 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231204085631euoutp016a240434f45d9e7636d711aefd006cc2~dlR5hufzV1564315643euoutp01a;
	Mon,  4 Dec 2023 08:56:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231204085631euoutp016a240434f45d9e7636d711aefd006cc2~dlR5hufzV1564315643euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701680192;
	bh=u5ANKrFOExU1KsjAsnD9uwlOV/7Kro3AtqZhq74Bz2E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=H5q2Dmz8YbYW6HDuVxHJFTBQ750+njvkBd+kNR/cQIRXJCoP3s9LE17vWc0expRGf
	 zkLEfnyEsJLvTppqN4ePO9ILunthWdlyfBuilsHn6Nc8vkzc5pCSEwjZTyBvRyIRbX
	 MNlAQC1rB/12jRnNU4fZrP78QFg78wskifY9eZ6Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231204085631eucas1p2162e2397cad033945a4f9963fd768b57~dlR5U3MvS2294222942eucas1p2E;
	Mon,  4 Dec 2023 08:56:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 3B.2D.09814.F349D656; Mon,  4
	Dec 2023 08:56:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231204085631eucas1p1df3dd15338e0357dedfcc0b8aa64c2c8~dlR4zmVq01870318703eucas1p1Y;
	Mon,  4 Dec 2023 08:56:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231204085631eusmtrp223eb7e06b481cedd1f0e528a502c34c1~dlR4wvyTd0289802898eusmtrp2C;
	Mon,  4 Dec 2023 08:56:31 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-d9-656d943f2436
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.4E.09274.E349D656; Mon,  4
	Dec 2023 08:56:30 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231204085630eusmtip21962b3da8cd158ad7892bdaee280e817~dlR4etFaf2690626906eusmtip2b;
	Mon,  4 Dec 2023 08:56:30 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 4 Dec 2023 08:56:30 +0000
Date: Mon, 4 Dec 2023 09:56:28 +0100
From: Joel Granados <j.granados@samsung.com>
To: Petr Mladek <pmladek@suse.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, <willy@infradead.org>,
	<josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>, Eric Biederman
	<ebiederm@xmission.com>, Iurii Zaikin <yzaikin@google.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, John Stultz
	<jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski
	<luto@amacapital.net>, Will Drewry <wad@chromium.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de
	Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Balbir Singh <bsingharora@gmail.com>, Alexei
	Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
	Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH 07/10] printk: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20231204085628.pf7yxppacf4pm2cv@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="m334zefgib4niiyw"
Content-Disposition: inline
In-Reply-To: <ZWX0L4lV8TWOgcpv@alley>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa0xTZxzG955z2lNwuENx+ApGl4osY8DELPAuG+IiiScxsi2azfBBh+sR
	HFAclQ1Z3IrigDIccqcyrkqhRe4UWREYYxQERK4iBQYKIlCZCJUaLl3Lwblk337/y/O8z//D
	y8P5DaQd77ToLBMq8gsScC0JVcuLLhev5GBmT4HWAS0tX8WR+rGWQIsvtCRaaNZwUc/Dfi5K
	m44kUOZ0B4nyc5/jKLMrikCTCdU4MqqiSNSkaSDRhZuFGFL1ZQPUnCwzDXJC0EprOReN/JJC
	oI64YKRu12Noqj4eQ3W32gjU+1smFzWXdhJIeUPCQdfvdWOoOLaIgwYTJgFKmnsEUL7cEfU0
	5mBImbxKIk18I4aMD/UcVB8zhqG1gXIC9RhmCaQuz+MijXyViyorUnAU02xKWP3nEom0UiOJ
	lg2md8aUKg4qqPXZ70r/pVsl6OKsYkBflXQTdFXRfYyulY2QdFT9EEnnVITRlYVOdH7dNEZL
	B3twemjWk65QxHLp4YE6Lj135w5J50pScDohrxF8autr+ZGQCTr9LRP63r4vLQMeKUrJMzes
	w42GMkwCpjdLgQUPUu/D0pJajpn5VCGAWXFuUmBp4kUAr5WscNhiAcCL90vwl4pKtRxnB3IA
	G7OmyX+3oh4bAFtUApi28JQ0SwjKAda2PgBm5lLOsEs3vG61hRLAmeyRdSucKrSCxoSC9SQ2
	1CmYnaFeF1hRHrAl/9IGW8O2jAlCCngmQTjMG/Zi0R7K13jmDQtqNxxMatlIKoB6XTyH5fPw
	dtUQxvLUJlhz94BZCilvqBrfz7Zt4IymimR5OzTWZmPmZJBKArBh7SnJFkoACyL1G0Yfwqi+
	iQ3Fx/Da8CTJmm6Gg0+szW3chImqNJxtW8GYn/jstiNUjuqIBLBL9p+7ZK/ukr26S7bu4wxz
	1M+4/2u/CwtyZ3GWPWFJyd9EDiAVYCsTJg72Z8R7Rcx3rmK/YHGYyN/1q5DgCmD6V+1rmsWb
	QD4z79oEMB5oAg4m8YMy5V1gR4hCRIxgi1XWUCDDtxL6nYtgQkNOhIYFMeImYM8jBFutdgt3
	MnzK3+8sE8gwZ5jQl1OMZ2EnwSQ2O3JGrRUi78/jL/ePf6/udb+yPeabwXdupffrEoYdPNP7
	4nZoAw5lyBeOJOoPpwmPOS51EkWxVJpBSu58ezpVYC+8ODtX6TufeMTtcEdGoNPRMosfRdGa
	CM96jYrv07+vjjn4+nH76E2yQcmvsb4rv2e6nNROXFZsq3YZz2p11R8aBScbrngvH3jTvzA1
	reqDT54c9VAeO26Y74Q/6K//XHywXiDXR0qKLj372te9zsc25ISn9J7ijeWWauVYdKrXF8/b
	pyz8ubV2e7S7+FWfbetknC+cUupuM+Fv1eydqTZWnbc45/tHjHt6d02brUoz5e0h7x1QDPDF
	2RHPVijha2UCQhzg5+aEh4r9/gGs7rVC0gQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe0xTVxzeuff2tnXpVh7OOzRqihCDs1Cehw3IXnGXjWwY4Y+NKXZyBwba
	krbgNCOpDBPowqgRdBRGi4hQCkhbJGB5dIiAAwRB3o9VGCCPSYwg77JCWWay/77zfb/v+305
	OYeB2ptxJ8Z5oZQSC/lxHHwP1mZpGTselCmgPJJHAuDyeg4Kjc+GMbi4OkyHL5tacNg90YvD
	GzOXMZg7006HBfmvUJjbmYLBScVdFG5VpdBhY0sDHSZXFyOw6okKwKZMpVVQi+BGqw6HoxlZ
	GGz/WQCNbUsInK5PR2Bt3UMM9tzLxWHTnQ4MastkNFjY/xiBpWkaGhxQTAJ47fkUgAVFrrDb
	pEagNnOTDlvSTQjcmliiwfpUMwItfToMdq/MYdCou4nDlqJNHBr0WShMbbI2vPtgmQ6H5Vt0
	uL5i3WPWVtHg7ZovP+SSf85vYmRpXikgc2SPMbJSM4iQNcpROplSP0Qn1foE0lDsRhbUziCk
	fKAbJYfmAkl9SRpOjvTV4uTzR4/oZL4sCyUVN00g9J1vuAFiUYKUOhwjkkgDORE86Mnl+UOu
	p7c/l+fld/p9Tx+Oe1BAFBV3PpESuwed5cbMJ/fT47V2P/ySt0CTgem35IDJINjehMFYhMrB
	HoY9uxAQg/OvaDbhAKFb7N3FDsRGnxy3Db0ARMV0J7AdDIAwrtWh21MY+whR0zoOtjHOfo/o
	nB/Z4R3ZHGJWNbqzAmUXs4gK9dWdWAf294Qq27hjYLH9iOaCK7up1xFi7PICZhPsiIfZf+1g
	lJ1I9Go1VjPDivcTRRbGNs1kuxAD15pRW1UOsTSfvls7iXi5OQUUwEH5WpLytSTlf0k22o0Y
	sMwg/6OPEbfz51AbDiTKyxcwNaCXAEcqQSKIFkg8uRK+QJIgjOaeEwn0wPq8q5pXK6uBZvYF
	txEgDNAIjlid4xXaLuCECUVCiuPIyhuKpexZUfyLlyixKFKcEEdJGoGP9Rqvok57z4msf0Uo
	jeT5evjwvH39PXz8fb04+1jB8al8e3Y0X0rFUlQ8Jf7XhzCYTjLkHi5N05TN/FhS1l349QXp
	qXKD3Up+p/fnzxRffZut+cjFXa+eilT9NBBSfD+F2Q5PyEz3R5x5q4fMycODJPdogPwO+XHw
	d8379/kd//3gk8lTISdrNe9KHfIzTjuHn5SGtY05Rzh+4pURUZaunO5v+OKzX5PWXHMOCPCD
	PHYW0zB7bPypncteAQhgdq09CF8R1kVcMi9Pxwf3qGLbLqZ+amo9m3wrJTZ3Yi7cYglKr4ks
	XwsLSbx1FFW8nXhmw/GNQ+FS9+scVivhXH0l7Y/WhiTxYVXliVBOqGnU883oLtehmqceHTfO
	cGv/jvugB/ntgmkjTJu6uN5h9tDrCqJ0geIiDiaJ4fPcULGE/w/p9W0ycwQAAA==
X-CMS-MailID: 20231204085631eucas1p1df3dd15338e0357dedfcc0b8aa64c2c8
X-Msg-Generator: CA
X-RootMTR: 20231128140754eucas1p2cf2c17554954e94d0dc14967e1f5e750
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231128140754eucas1p2cf2c17554954e94d0dc14967e1f5e750
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_kernel-v1-7-e4ce1388dfa0@samsung.com>
	<CGME20231128140754eucas1p2cf2c17554954e94d0dc14967e1f5e750@eucas1p2.samsung.com>
	<ZWX0L4lV8TWOgcpv@alley>

--m334zefgib4niiyw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Petr

I missed this message somehow....

On Tue, Nov 28, 2023 at 03:07:43PM +0100, Petr Mladek wrote:
> On Tue 2023-11-07 14:45:07, Joel Granados via B4 Relay wrote:
> > From: Joel Granados <j.granados@samsung.com>
> >=20
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which
> > will reduce the overall build time size of the kernel and run time
> > memory bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >=20
> > rm sentinel element from printk_sysctls
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
>=20
> I am a bit sceptical if the size and time reduction is worth the
> effort. I feel that this change makes the access a bit less secure.
In what way "less secure"? Can you expand on that?

Notice that if you pass a pointer to the register functions, you will
get a warning/error on compilation.

>=20
> Well, almost all arrays are static so that it should just work.
> The patch does what it says. Feel free to use:
Thx for the review. will do.

>=20
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>=20
> Best Regards,
> Petr

--=20

Joel Granados

--m334zefgib4niiyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVtlDwACgkQupfNUreW
QU/0vwv4mRGhlKpI+9BXVTufcXHymQXIplwD2Pt0XmXATxwELEZSDrAhkOMuZnOE
w+JGFka7O9MPuE5kHhtxfBDqZd2olH0zzMSxkXsHAd6nNXCdAXLpkPojlYwSfSNC
xDaXiEtaHhAaW/U0WpLEBHL539sYYukjf5P9qha6XORNvA5y1B1g1pUWMrBUXiyF
S5+txanFQmwulj1Kre/SFy95147+/UPo4SPAYl+9GIyN9KLKQ0++EKLLIRRRV09v
I2zJYqkDyyZpbIPq7jj9XIceNk7MDhNdMIUP1pN4djlrt3IKWYnuJXBuiRWFIJ28
LbpVTzIGfnH5IzaRU0547P/5U7QlIVSuUnh7l1cSdarm+sk3k4uRTogeaDtWKgho
wBL9rnHITIlj7ZhLtFlm4CMWbed0rTeph4Vq1p/vvE9HFnaNQMtmM5GYBV7C5L5P
cCpdN9/VZ9i32K8zh9jLFAk7xDBwqTd1yM07kFfUE1CZ/kk2LUrxLLgw8LbipU/z
lmG1tIc=
=c3TB
-----END PGP SIGNATURE-----

--m334zefgib4niiyw--

