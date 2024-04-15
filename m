Return-Path: <linux-fsdevel+bounces-16932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF78A512E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB2EB23B78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591C67FBC5;
	Mon, 15 Apr 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="viy8RF4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AE7319C;
	Mon, 15 Apr 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186762; cv=none; b=r+5T5AH/kOPBYnCfb5TqVBoFEYzY/7kqHfErO3YGyt/3zfpH2ye1IdV9Bl+sa0b3Xa9ZXi9JWnlfPa3aw6tygat/CpR4Im2Ye6rVuKiYOGrxCCc0cVFr9BEZQo/2h/t9zQ8UwfRMVhbVtC85G7TKUZSwk+bQdibV/5y/PAcIZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186762; c=relaxed/simple;
	bh=Qca6XvzlrUWEgjiYFgsicelqsoUPPwVfMv97Wpge0Zs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=nqHVS9iNdAVBSZOkf97YQGJsR+uHuJN0rrNyhFIXw6j3VspZDcf0V+E+TnYS/ojAPtCSlXpKTWsXJRKDeM1/0irni81ydOwoyuoeXXfFXQDhIQ9jA3RDvmpjpX23xz7dHSYYXtCnb+982EZ2e0h6fq8ea9+0T0BtZBMlipeDCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=viy8RF4h; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240415131237euoutp017a2f62749534a2b9acddd5159781d6bf~Gdkd-Lxw32930829308euoutp01G;
	Mon, 15 Apr 2024 13:12:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240415131237euoutp017a2f62749534a2b9acddd5159781d6bf~Gdkd-Lxw32930829308euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713186757;
	bh=Qca6XvzlrUWEgjiYFgsicelqsoUPPwVfMv97Wpge0Zs=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=viy8RF4hNXEqmJO09gbRkN1hplzL9qWjf30RFTI7FTwLhCoWneLeBXSDvbLsxpZ9j
	 GbRuWAVNqjoG/SbTkO+rwZqOp+dKHuUnBjQibXnQGX7hNb7NR1eDov++YJ/Jm+QrcE
	 cMJxQiOg6puH76trnIUgetFkYReZNRUwnD+KWLGw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240415131237eucas1p1356b3196b37e50355c04831542d6c242~Gdkds-9ke2775027750eucas1p1_;
	Mon, 15 Apr 2024 13:12:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.28.09624.5C72D166; Mon, 15
	Apr 2024 14:12:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240415131236eucas1p26e04b3c555dc61967b7e3095f73fc0bc~GdkdOBHxz1272012720eucas1p2x;
	Mon, 15 Apr 2024 13:12:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240415131236eusmtrp14bad41fdcb1d30a1a34d053288f52139~GdkdLWMCT1022510225eusmtrp1f;
	Mon, 15 Apr 2024 13:12:36 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-69-661d27c5eab3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.D0.09010.4C72D166; Mon, 15
	Apr 2024 14:12:36 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240415131236eusmtip23358818af7e1c8c6c8f052ff5acc6772~Gdkc2V-fH0603206032eusmtip2W;
	Mon, 15 Apr 2024 13:12:36 +0000 (GMT)
Received: from localhost (106.210.248.128) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 15 Apr 2024 14:12:35 +0100
Date: Mon, 15 Apr 2024 15:12:31 +0200
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, <josh@joshtriplett.org>, Kees Cook
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
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel
 dir
Message-ID: <20240415131231.gqsmiafwqxefxuuy@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="b5ducwyxpvyw5o7f"
Content-Disposition: inline
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa0xTZxjed85pT8GVHQrqN8DoYOBkiCJm+5LhZYvbjstiCCRbcNm0wuEm
	FNPCYJrFAkXuWEEwXAVRChQZ1yJSEDuw3IQBDhnIJHIZCGPlLuM26sHNZP+e97kkz/Pj5eGC
	OtKM5yMKZMQioZ8l15BQPVhq39u4e4fn/tocY7S4nI6jmrF+As0t9ZNotkHLRV1Dv3LRtfFQ
	AmWMt5EoN2cBRxkdMgKNyCtxtK6SkUijvUeisDv5GFI9ug5Qw9W0DSE7AK00lXLRwOVkArXF
	+qOa1nkM/VEXjyF1bTOBuu9mcFHDTw8JpLwt5aBbjzsxVBRdwEG98hGAkqZGAcpV2KCu+mwM
	Ka+ukkgbX4+h9aF5DqqLGsTQWk8pgbpeTBCopvQGF2kVq1xUXpaMo6iGjYaVjYsk6o9ZJ9Gg
	UsVBedUnju6ln06uEnRRVhGg06WdBF1R8BtGV6cNkLSsro+ks8uC6PJ8WzpXPY7RMb1dON03
	cYguK4zm0k961Fx6qr2dpHOkyTgtv1EPnLedNHTyYPx8vmfE+w6fNvT+efoucU5nFKIoiiSk
	IJQfAwx4kDoIJ4tSsRhgyBNQ+QC2XUrZPOYA/DsucvOYBbBJo+a8iqSrRwhWUACYNNIJ/nUp
	bnZz2KMSwJa4LFwfIShrGF2QR+oxl7KDHZNPcL3JlCrlw5TpTKAXTChnmNzT9dLEp47CwaZh
	DouNYXPqMKHHOBUCa+X6MG8Dm0PFGk9PG1BusCazmWTrWcGwZzc3q/4IWyr6Xm6AVP8W2JI4
	QbDCMZgaEbYZMIHPtRWb2AK2JsURbCAJwHtrOpI9lADmhc5jrOsjKHs0vJn4GLaG1mH6RpAy
	gr1/GrNFjWCi6hrO0nwYdUnAum2g8vdJgqUtYPuMkRxYpr22Mu21lWn/rWRpO5hdM8P9H/0+
	zMuZwFl8CBYX/0VkA7IQbGeCJP5ejMRBxATbS4T+kiCRl717gH8Z2Hir1jXtzB2Q+XzaXgMw
	HtCAdzfCz0qUvwAzQhQgYixN+TKTHZ4Cvofwh/OMOOCUOMiPkWiAOY+w3M639tjJCCgvYSBz
	lmHOMeJXKsYzMJNiZxeHx4TvCAJDfNaXd+nGwi2O+D+ufK+xOtDXtmKtWZZRbrr14RsJVhe0
	J4YWJo64e+suf1IZ7//i2+AMR5cZuC/Xol8Vu3NW5CL88P5Cz60H8+Li1sb49kLKcXD4sJvA
	jnP8vGOmic7Lia+8330x4eScJjfMfLQqRfmVcUl01SkHp5XTFU5drqO7tqy+3bJ7fv6Ac/ix
	+sjgWam75qkqsOLr9vDrt89IVt/8vMNVVmj8RYku4rjcwqZsec70wIDL1JXYsj3J02G2QYkH
	Uy2rP/Bcqnor1WzwQoM0a49bzuLiZxetfTtnrVZ6tvZ/92WarCXvU6dvEnpcfdWZIdvU4v1c
	5BpxxpKQeAsdbHGxRPgPgmt1V9EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTVxjGd+69vbc4cbUg3LG5YCfTgVQKpZ4iGLa4eHXI+GeJuhHWwQV0
	tCX9MJOpVIMOMGxFYW4FlPKNIALSjkpljIAV6XB0wjr5sONrMAibgiIIZYW6zGT/Ped5nveX
	NyfnMFF2F+7FPCxR0DKJKImDr8E67aZB/7YtG+MDmgzb4NyzPBQ2jfdhcHa+j4AzbSYcWoZ7
	cHhx4hQG8yfMBCzWPkFh/t00DI6qdShc1qcRsNX0AwFPN1YgUH/vMoBtORpHUCiFi7frcDjw
	dS4GzefEsKnzMQL/aM5CoPFmBwZ/uZGPw7ZrP2Gw6qqKAUt/7UZgdUYlA1rVowBemB4DsLj8
	LWhpKURgVc4SAU1ZLQhcHn7MgM3pNgTae+swaHk6icGmuiIcmsqXcHi9PheF6W2ODXXtcwTs
	y1wmoK1Kz4Blhshwf+rB1BJGVV+qBlSeqhujGip/QyiDZoCg0prvE1RhvZK6XuFLFRsnECrT
	akGp+5NhVP2VDJzq7zXi1HRXF0FpVbkopS5qAVEeh7ihMqlSQXsnSuWKMM5HPBjI5QkhN5Av
	5PKCdkSHBAZztu8KjaOTDh+lZdt3fcJNXMh/I3l63ecliyNABZbXZgIXJsnik3nGUSwTrGGy
	WaWANBVaMWfwOlk328NwajdysTcTd5YeArLv6RxwHnSATMv+Cl1pYSwfMqOyjFjROGsbeXeq
	H10pubPqXElVaf0q1o0VSfafb1nVrqxw0nZ7hOEkVQPy7ODQ82A92fHdyKpGWUdJbe6Ag8R0
	6NfIcjtzxXZhHSSbCjoI53pvkqeHSp6veoKcWRoDasDWvEDSvEDS/Edy2r6k1T6B/M/2I8u0
	k6hTh5E1NX9hhYC4AtxppVycIJYHcuUisVwpSeDGSsX1wPGY9bfmGxpB5Z8Pua0AYYJWsNkx
	OVRb9TPwwiRSCc1xd01z2xjPdo0THUuhZdIYmTKJlreCYMfVZaNeG2Kljp8hUcTwBAHBPL5A
	GBAsFARxPF33JqeL2KwEkYL+jKaTadm/cwjTxUuF7NyTPBUQfuHj5aum40WV93S6cP21cyML
	/ekeb+dsLhkveHXT/g8N01si1Kr58ZBLvws/OBh3s+LbiOjhL7fSkfaOWp+T+h/zqzedDEop
	PWWVbR2N/0K+3wxDfZJjUo01439rhS+/t3vxU2uDt/iEX6x67/nOJ83e7xekSA5FzPccmNGX
	2/fwHvn674y+0e2Z6iL1/CZ6g679JUUwnG68WHVAn+tjvWMeAmuN/MCUmjMWWaQgdt9Ue/a7
	O0LMgwJNlMSyu4B/h/3MbYnPfmU9f51NqfU7khVVa3lnX8nlOMHcYlBqhEd8+/fHFMcfGB4Z
	PG2ajqQxm4d5Qn7kVh65oOvsneVg8kQRzxeVyUX/AGLpL+5hBAAA
X-CMS-MailID: 20240415131236eucas1p26e04b3c555dc61967b7e3095f73fc0bc
X-Msg-Generator: CA
X-RootMTR: 20240328154421eucas1p14e2a43b2894dd706aa4e2affc54f3143
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240328154421eucas1p14e2a43b2894dd706aa4e2affc54f3143
References: <CGME20240328154421eucas1p14e2a43b2894dd706aa4e2affc54f3143@eucas1p1.samsung.com>
	<20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>

--b5ducwyxpvyw5o7f
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just a heads up: will add this to the sysctl-next tree
https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=3D=
sysctl-next
so it has time to soak there for next merge window. If you are a
maintainer and are thinking of including any of these patches in your
tree, let me know and I'll remove when upstreaming

On Thu, Mar 28, 2024 at 04:44:01PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
>=20
> What?
> These commits remove the sentinel element (last empty element) from the
> sysctl arrays of all the files under the "kernel/" directory that use a
> sysctl array for registration. The merging of the preparation patches
> [1] to mainline allows us to remove sentinel elements without changing
> behavior. This is safe because the sysctl registration code
> (register_sysctl() and friends) use the array size in addition to
> checking for a sentinel [2].
=2E..

Best
--=20

Joel Granados

--b5ducwyxpvyw5o7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYdJ74ACgkQupfNUreW
QU8ybAv+Or5Tl4So4uWHapLPqMyxsHPDQXiHfVb00sVzzrsRYvg20WiOaWSRbLTT
ss7ysfiWX5M59/hUyyiuO7JKEziQOHjmowkxiz4XS2N+8alLAwEmKIDQlFIzBNnx
5ZDjbinS9zcVXG3yxKpdMPe/EHZfG80Zf5BW0Tgb+JDCQida4njEZp0J7T7MA8Ti
6GjelQYR/deOeddD/TAyZxkaEfxe/zZ0K3BeXVpAX5IZnym1jnivrrcEiDowcpvD
PypDC2xCq1Uyt8jc5FFpud261wJiWW16an4fdiPix45OoMB5r9LOpY+kon4x63Zq
JZ35JtDNL0DA1tCMNKr4yoOg22ddnDOqxjMWepulYPNY2i5v2mg+Hn7tNbtnjN38
mTBbkkzcXtS7HbGsQhzEErEGe8+GcEKCwKw8Y+5o5fvi09V7NYLu+CI+s0/mvdlb
5b72Y4QbUsVdFr/aeiy41GrQBKtH8UzXdTfVQLA5YHNRCUTeCBasYEvHr8jK9oGI
HlbukVaB
=iNEu
-----END PGP SIGNATURE-----

--b5ducwyxpvyw5o7f--

