Return-Path: <linux-fsdevel+bounces-7388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A268C8244DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5151F227F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D13241FE;
	Thu,  4 Jan 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t8OW53/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CECD241E2;
	Thu,  4 Jan 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240104152317euoutp02af64ea5d44089fbf76814de916d80a0e~nLjblY91G0383403834euoutp02S;
	Thu,  4 Jan 2024 15:23:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240104152317euoutp02af64ea5d44089fbf76814de916d80a0e~nLjblY91G0383403834euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704381797;
	bh=JalEKYMkjsneZ1f8omw/O0M8dMeqvgrqvomUY87Fhfg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=t8OW53/bBoW8L9GkkTvvZs4nFJoit0t32xAeCuyCdhzm1xAwgLcS4i+QWCwdYR751
	 uKMHMPmL5vl+T13dMvzs0JbHPIPONUmbj2fR7/shSJjCihhOnUxf+2BsbU5u+eRnWB
	 tCGKFybp2cf3kUnCH+qV1xVYfB6EOQwcBXv3BBDg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240104152317eucas1p19950f0b8746d6f6c732a2653a49e0a67~nLjbVXSBN1357313573eucas1p1J;
	Thu,  4 Jan 2024 15:23:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.15.09539.46DC6956; Thu,  4
	Jan 2024 15:23:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240104152316eucas1p15614f44c3e210a165983df57e9014009~nLja2BBXo1074810748eucas1p17;
	Thu,  4 Jan 2024 15:23:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240104152316eusmtrp27b5ba330034b29d296ed9522af8c9794~nLja06KbN2376823768eusmtrp2M;
	Thu,  4 Jan 2024 15:23:16 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-5e-6596cd646407
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.E3.09146.46DC6956; Thu,  4
	Jan 2024 15:23:16 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240104152316eusmtip1a81f893d56955799d8aa2aa6593eae90~nLjaj-tQO0636206362eusmtip1-;
	Thu,  4 Jan 2024 15:23:16 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 4 Jan 2024 15:23:15 +0000
Date: Thu, 4 Jan 2024 16:23:11 +0100
From: Joel Granados <j.granados@samsung.com>
To: Matthew Wilcox <willy@infradead.org>
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
	<bpf@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] sysctl: Remove sentinel elements from kernel
 dir
Message-ID: <20240104152311.f62uxcnimol5qwxx@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="jzrq2uleinvzsb23"
Content-Disposition: inline
In-Reply-To: <ZZbJRiN8ENV/FoTV@casper.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTazBcZxjud87ZcxZds5bwRTpjZkOmFTSRhK8XnaTVyZlp0shM+yP5kdrG
	GTTsiqWk1RmbirpUY8LSIKxL3NYlNkuo6yg2CEoIJYmUsF0rS12KitXdHG0z03/P+zzv873P
	8+Pj4oJmypEbLI5gwsWiECFpSdR1bfS7B/RlMAdqdV5obTMbR42/TxBoZWOCQssdGhINTY+Q
	KFMnI1CO7h6FCvP/xFHOQByBZlJrcbRdF0ehdk0rhS7Xl2KobjgPoI70LJOgkKDnd2tI9Oiq
	nED3kkNRY+8qhrQtKRhqau4m0P2fckjUUd1HIGVlLAfdHB3EUEViGQeNpc4AlGaYBaiwZB8a
	alNgSJm+RSFNShuGtqdXOagl4QmGjA9qCDS0ridQY00BiTQlWyS6rZLjKKHDlLC2c41CE0nb
	FNpcN915oqzjoOKGj4960JPzWwRdkVsB6OzYQYJWl/2K0Q1Zjyg6rmWcohWqSPp2qStd2KTD
	6KSxIZwe1/vQqvJEkn74oImkDf39FJ0fK8fp1II24Gd/1vLdACYk+Esm/M33/C2DRlpWQJjB
	KlqxsMyJBVWWScCCC/mHoXawhpMELLkCfimAldX9O8MKgD/f2CTZYRnAyRSdaeC+sMxNO5nd
	An4JgPoch393rhdMk6ygBnBTv9uMCb4zHPnx1gue5LvBgfmHuPkdO/7rcF7taaZxfg0PXqv/
	3Ixt+X5w+E4zYcY8vjdUFxkBi21g9/WnBLsfDct0JcD8DM7fA0uMXDNtYUrW1P39Tsq9cEnr
	z3b8BvaoxzFzSshfsIIVRUrACr6wdqZ1B9vCOY2aYvFrcLshb8eQBmCrcZFiByWAxbJVjN16
	B8YNP6XYa8fg8x+iWGgNx57ZsDGt4bW6TJyleTAhXsAa90Hl43kiFezNeqlY1kvFsv4rxtJu
	UNG4RP6P3g+L8/U4i31gVdUCoQBUOXBgIqWhgYz0oJiJ8pCKQqWR4kCP85JQFTD9ql6jZqke
	3Jj7w6MdYFzQDpxN5qlbyl+AIyGWiBmhHa+6Ko0R8AJEl75iwiWfhUeGMNJ2sIdLCB14LgFO
	jIAfKIpgLjBMGBP+j4pxLRxjsSh1srvTB13D23M96QNMsFeS59XkA187+oY807r49TRtvjJ7
	3jXurxP7XeSqXK2xJ/7OqNdxv3apQrKr1Cj3HA+8uy60mu2ydr45ZRt9atHakusq4/jFjJZ7
	vJVxQt2ZGmJf/UXRR7LVCzZ9HKvEcq3LzOHxty2Go0NqrW1PxvtPFTQHGdw6E1Xnags6Hfo+
	FZ7SZ2EL7u2jdssXA0YCj6zu+s7rVbfTl+y7f6uXZeMx4yMjYWcMst7MyeDsy55HWk4vGjbu
	43m7F4nqCApFOE58kluZcebKgkjtHXPl4qH+tW993pCMtZ07+tj3QzcoD9QeEvUvvQ8WDKEn
	vcUJwcfOpgoJaZDooCseLhX9DXoa/GDQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe0xTVxz23Ht7b0FIKuC8dHNulTiHrrbldTqK2UbirpKBWcyW6DatcANk
	lJI+jDzUwpgpBTeUxyaCFhBRW3mDMhiyrsAYD6EdyFMRBCyvBXwAQ2DtmmUm++873+/7vt/v
	d3IOE3UZwtnMyGgFLYsWR3FwR6xtrWX4vbCObJrXNe4GF1cuobDuySAGny0PEvCpsQWHprEe
	HP5gScRgrqWdgIX5L1CYey8Zg+Pp1Shcr0kmoKHlLgGT7lxHYM0fVwA0ZuZYC1opfPlbOQ6H
	v8/CYHuqBNa1PUfgZMM5BNb/3IpB80+5ODSWdmBQd0vFgEX3uxGoT7nBgH3p4wBmzE0AWFi8
	A5oatQjUZa4SsOVcIwLXx54zYIN6BIFrveUYNC1NY7CuvACHLcWrOKysyEKh2midsLppkYCD
	mnUCrixZ+4zoahjwWm3wB1zq4cwqRukv6wF1SdWNUVU3+hGqNmeYoJIbBghKW6GkKq97UoX1
	FoTS9JlQamA6gKq4mYJTQ731ODXX2UlQ+aoslEovaAQHXzvMFcmkSgX9VoRUrgjgHOFDAZcv
	hFyBt5DL9/L78n2BD2fPXlEYHRV5gpbt2XuMG3F1fQmLmdl4cvbsNwwV0DtqAJNJsrzJqbFt
	GuDIdGEVATL1vhnVAAcr/wZZ/qyHYceu5MteDW4XzQPS0DyK2g9VgHz0YPYfFcbyIHt+LMNt
	GGftJu/NDKG2Dm6sneRMlcCmR1nlzuTy+SbExruygsnKWcomd2b5kVVX14A9sxeQy81NhL2w
	iWy9+BizYZR1gpxYSGXYvCjrdbJ4jWmjHawL1Lem4fZltpMLk8fsM58in65OgHTgmvNKUM4r
	QTn/BdlpT7JvzYL8j95FXsufRu04gCwp+RPTAuImcKOVckm4RM7nysUSuTI6nBsqlVQA69Ou
	aV6uvAMuT81zDQBhAgPwsDpHy3RdgI1FS6NpjptzaUkG7eIcJo6No2XSozJlFC03AB/rHZ5H
	2ZtDpdZ/Eq04yvfl+fC9fYU8H6GvF2eL8/4YtdiFFS5W0F/TdAwt+9eHMB3YKkTfGPgicKF6
	5vZJk+jt4n1bk4qkXvFTO7a+8yT+I4fY2aCAd5PIWPzjTdWfhVtOTbVppJOb42I+SVAf6jpn
	qV3MYgcyhZ5NrR1a+PluP2OeB9tJ43TAkPkX3z8v+9HwhtSzvHjjdp7guI/yixSRQ58AnS84
	Ejkqdqv+zl2btNJSOpC2JeiQkHTqzB574H885HZDyPyBDRn9v5i/DakZjavifppWh48pLrgT
	A/2u2cG0MESvzjzofua0Z79upD7PXNv81c6gh6FDjzlzF1R3NfDim7uutA63ByTeEpgWOs2j
	OlGCaGPCfkk8MIuWeB/2eKyAicPbuk8nninzV1f8PvGrOweTR4j5nqhMLv4bnkmcD28EAAA=
X-CMS-MailID: 20240104152316eucas1p15614f44c3e210a165983df57e9014009
X-Msg-Generator: CA
X-RootMTR: 20240104150558eucas1p2cfaa2a4ea3933e8dfbf1bc94fb9e6ff5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240104150558eucas1p2cfaa2a4ea3933e8dfbf1bc94fb9e6ff5
References: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
	<CGME20240104150558eucas1p2cfaa2a4ea3933e8dfbf1bc94fb9e6ff5@eucas1p2.samsung.com>
	<ZZbJRiN8ENV/FoTV@casper.infradead.org>

--jzrq2uleinvzsb23
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 03:05:42PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 04, 2024 at 04:02:21PM +0100, Joel Granados via B4 Relay wrot=
e:
> > From: Joel Granados <j.granados@samsung.com>
> >=20
> > What?
>=20
> The reason I wanted you to do the sentinel removal before the split was
> so that there weren't two rounds of patches.  Ironically, because you
> refused to do it that way, not only are there two rounds of patches, but
> I'm being cc'd on all of them, so I get all the $%*^ emails twice.
>=20
> Please at least stop cc'ing me.
Will do

--=20

Joel Granados

--jzrq2uleinvzsb23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWWzV4ACgkQupfNUreW
QU8FhwwAiNDNSaoaB/pGcA4KJtPoMdEJm9tL4XsYkZf24rQJXWitgrDdtcgoZo65
VMARclf+GYvEvKwbnBJTK3mvcW4sHq0QoAGQy8AtQuo8dFk2K+n4XvvyKuWRlPRF
hgE2MsdpbWNSFaKPYw5o6MYcjDmxkusvPifKASX/NANB16gjAWtjHqLfhRN+uXA7
Hsxg3zQwr0sN+/7apAHCWO5X1A4RLpBoT9tjPnqPCKWCeya9HMpQfIwfRs9qIiM3
NQsVAtLT8f5e969fRNEzDvPF2m/bV3ecyxTL/mEOd7TP2H0pL/8FkPw55aWMSt0q
XxavHxTdl1Qo7oPVQMUckL9j58Nc5oDzPevLjGi0wZEpFcuQWRskWSZf7nTh0wEj
cGU7UYjwF9ZRvp4axwPkIMQ1aanxXZ+KOh6GwORsCpHpnjzDKdBG273k5Lo7GB7j
KpdO+fxc94k33h0uCV46v8YhAKy3WGnioX0EMwmOjhQiMnGU3cpVLedXpBJUmxFk
57Osrz7P
=hr38
-----END PGP SIGNATURE-----

--jzrq2uleinvzsb23--

