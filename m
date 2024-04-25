Return-Path: <linux-fsdevel+bounces-17736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E38B1FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23741C219B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C33611E;
	Thu, 25 Apr 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K7Z+HkQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563742263A;
	Thu, 25 Apr 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043066; cv=none; b=F3kOXL7bN5kcrX1rNUae2/y+4BKC3o9LK1R00Y+62SwZ076XDzpjrMoY2PbdwLKR1IrQfBW37xKi4WKkpTXlD/BWfiPaa9qfyKUaMq5f9ndgDcK2DGUULCPerI/iSM2JpE7JrO84/FwdHInZKEy1oJu84HXDAeWBietgtuJpnvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043066; c=relaxed/simple;
	bh=qUU2lUGW3Jw2ERh97QVSnIfGyRZcJGPJNkeSkF4EtUE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=LFm5s7uR1ehwPIshHoN4X5M0dNGhLU3zKGgW2t5StKcqtAZDU8xGRMRT/HCvs9f53mkrX+KHkPJLUSMkbkr2d+XgG2jMLHdE4KdIwzpyfXfvg4R0ReY61MeTPvVMyo/2SUblLQcnwU5vaDHBzz2qthe1dIl8qEBjsxmjE8RT5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K7Z+HkQv; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240425110419euoutp025ea9a2841083d4c23a7df7e27a21bb82~JgRTDaocl0424104241euoutp029;
	Thu, 25 Apr 2024 11:04:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240425110419euoutp025ea9a2841083d4c23a7df7e27a21bb82~JgRTDaocl0424104241euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714043059;
	bh=rJ3fxdBvszImOr8fc5O60xKwxenFrsdLX83dTzHbe8Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=K7Z+HkQvdxwe9WFNQxmAMJDclz/KZS4YxtJGasrhxAeQ70lSettVglHGn0yJGPz3K
	 p1fq/JR2M/xPa5rbmMGJBMP63C58KwhDkVG5b5ocDC1SbJNeF2gSqVgeu65dAKtHzB
	 OZfWdxyyfwSYhVTdlAp7p+La5gY9TN8PKRN42bME=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240425110419eucas1p10f68e079a0837554528c5f55ffd1f236~JgRS0lHPt1477414774eucas1p1p;
	Thu, 25 Apr 2024 11:04:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.70.09624.2B83A266; Thu, 25
	Apr 2024 12:04:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240425110418eucas1p1ef427715fe08d9cc9eedd6e2a8798a7c~JgRSPTcDR1975319753eucas1p1n;
	Thu, 25 Apr 2024 11:04:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240425110418eusmtrp2ee95972f1c88644dd0c5b54b1b42412d~JgRSM0DUY2814728147eusmtrp2m;
	Thu, 25 Apr 2024 11:04:18 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-66-662a38b20906
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.5E.08810.2B83A266; Thu, 25
	Apr 2024 12:04:18 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240425110418eusmtip11b7f7e68f5cef9ee392ee4064342b8af~JgRR8FNcJ0822208222eusmtip1J;
	Thu, 25 Apr 2024 11:04:18 +0000 (GMT)
Received: from localhost (106.210.248.68) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 25 Apr 2024 12:04:17 +0100
Date: Thu, 25 Apr 2024 13:04:12 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Luis
	Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Eric
	Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-xfs@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <kexec@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>, <bridge@lists.linux.dev>,
	<lvs-devel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-sctp@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <apparmor@lists.ubuntu.com>
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240425110412.2n5d27smecfncsfa@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="q23ui2gu4xgkiues"
Content-Disposition: inline
In-Reply-To: <20240424201234.3cc2b509@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSbUyTVxTHvc9bC0nNQ0G4gkiGwKabMJJ9uA4EZ1zy8GGMJWwu+gErPLxs
	0JpWJtvChIAoLawdzEGrSBFExktrSqkIU0hHioBraUBXGWOOgZG3Dak4oYCjPLiZ7Nvv/M//
	3HP+yeXjwgnKn58hPslKxaLMYMqTMFmWrHsNaE/qm0XKKJRv0ZLI2dNLIVOtAkOrN87iyGgZ
	A2jSMs5DdxRZqHNgEUODpq9JZPjjHol+uNlHoEv6JYCGOi5SaKz5OYkGuwdINNymI9BDcymB
	TM5CCqlqCnA0qZ0h0XzJOIV69D8RqGOlnYdczx5iyPX3GokKqhdw5FBNAmTR+iKVrp9A1lYn
	eWAncyHPTjD9lyGjNWQzhsZiijEslPGY1rrTzKNWNWBslTWAuef4jWDmXLcxZrB+lmKchp2M
	UmHhJQiOeEansJkZn7HSiJhjnukXHDPYiQ7/HFXbIyIPXPOVAw8+pN+C57sLgRx48oV0A4Bn
	jXaCK54AOPXrA5wrnAA2WW3Ei5F85xDGNa4CePcbI/WvS72Sh7ldQtoI4LwduZmgQ2FDi5Jy
	M0W/AW2zo7ibfegQWNiq3tiH03YefLJqJ90Nb/oYNF4pB24W0AfgnfYfCY69YJ96YoNxOgdW
	LPWv+/nrHACvrvHdsgcdCTvaR0nu0mBYWlmFcZwL+40jmzzvCVsu7eD4EGyou8jj2BtO9xo3
	eQd8fqN6IyWkywHsWpvncUUTgPX5i5svRcHC4YnNiXegTW/bOAjSW6Fjzou7cyssM1XgnCyA
	54qEnDsMNo3NEiqwS/NSMs1LyTT/JePkcOg4/y31P/l1WF8zg3O8H+p0fxFawGsEfmy2LCuN
	lUWK2VPhMlGWLFucFp4syTKA9c8/sNa70A6qph+HmwHGB2YQsj48fq1pEPgTYomYDfYR3H/8
	WqpQkCL6/AtWKkmSZmeyMjMI4BPBfoLQlCBWSKeJTrKfsuwJVvqii/E9/POw6OXup7x8mzSw
	sLOmWe4hTzhNLu73KFbsdoWxu4K6vOKPZoj1S9tnW7AtatWhnM645k/yj+cmz2VGx277ZVFz
	vILeEpfceBdP3Jdb02WmYxqWyo72qLrjRyISg4bOte2+fep3v5jpTL/S93M+fDf2/ojxgbUp
	paItSlPpFy9VDseO67dFWAtmq1vWPgh5zzsjkHrFd/vN69TTg8rwZ2m3imoRvyfBuLd+uHFK
	Xnc9sTwy3lCkPrxSOpqUlP7n97Yzip6I6KpJ7eRHhsC4rDnJ8lfmWz9/7BKeefXt76pKYiSu
	oGVDSJ/2ssi0Klb5VOmmavcd5B2RA2mqoqQ4NCzgS2UwIUsXRe7BpTLRPzckkEB3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf1DTdRjH++z7Y4Pa3beN6afFed6Cs2ROhgw/65Dzus6+7TrjzuyushtL
	v4LGNtrAUzsNbiDEJGb6ByzSEWgTY9Y2aQzLWjaEKcwTCAOxo0Ye6AlsCLuN1cbq8q7/Xvd+
	nvf7ee65h4PxqkghZ5+mnNFpVKUiMhX3xXrvbLCj9Xuzh4Z5qMprIVDwai+JutqMLLTcXYsh
	p3cCoIB3ko2uG9Wox7fAQv6uTwhk/32EQJe/68PR6YthgG65W0g08dVfBPL/4CPQ0CUbjqY8
	DTjqClaTyNRqwFDAMkOg2eOTJLp68QaO3FEXG0WWplgoshgjkOHMPIZGTQGAvJZVyGTrx9GA
	I0hsXUN/VnkTp/u/gLTFXkHbOz4mafv8p2za0f4Rfc/RDOjBplZAj4zexekHkWss2n/uPkkH
	7WvoRqOXXch9W5Kv01aUM2tLtPryLaJ3pChHIpUjSU6uXCLdtPndF3Nkoo0F+XuY0n0HGN3G
	giJJyYJtgF3mEh6cDg2ASmBbVQ9SOJDKhVXBW6x6kMrhUWcBtD60sJOFdPhNaJhIMh9GR+rJ
	BPOoOQDdM1lJgxPAwfMTK004lQmtnY0rTSQlhoP3x7EEp1EZsNrRjCcMGHWTDaM1npUJfKoI
	Os+eBAnmUlvhdddPeDK1F8D6tpNEsvA07Gv+A08wRh2AodGeOHPi/Cz8MsZJyCmUFLpd4/9s
	KoINTZ+zknwEBpengAnwzY8lmR9LMv+XlJTFsPvSOPk/OQuea53BkrwF2mwPcQtgd4A0pkKv
	LlbrpRK9Sq2v0BRLdmvVdhD/vy5v2OECp6fnJB7A4gAPyIg7J7++4AdCXKPVMKI07u255/fy
	uHtUhw4zOq1SV1HK6D1AFj/jCUwo2K2NP7OmXCnNy5ZJc/Pk2TJ53ibRau6rZXUqHlWsKmfe
	Z5gyRvevj8VJEVayWqqf9A07ozWvHY99H/ArcAFbIrsb1owpDQv4dIbbn/ZewNlYE67acKPB
	+mOH+QNNZMjzRHR2zPHhUlT9VlHglGRiyBXZWXfUeyd2RVbJEfTlGRU/7z/2yG9QjqtbjIfN
	XF4qVvjnmOCaboLvlm+ff5l3sFb8ZnTttvP9hpewLOv8zsyhQFtqRzro2SxQiS4UrAs9xxIr
	fqtd111YufqInTxlFR/dtcP8iwkpiF9PfLvIezDrLTb6d9UZOqvbD11Rhk3Zz2xz8DpvLw4+
	ivIdxL3LO5a4bwhCTem+5WNt20PAkUllk/vVyvb8KqPiBXQmT/7UqC2n7ZXRMHxdhOtLVNL1
	mE6v+hu4sk0VFAQAAA==
X-CMS-MailID: 20240425110418eucas1p1ef427715fe08d9cc9eedd6e2a8798a7c
X-Msg-Generator: CA
X-RootMTR: 20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<CGME20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db@eucas1p1.samsung.com>
	<20240424201234.3cc2b509@kernel.org>

--q23ui2gu4xgkiues
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei=DFschuh wrote:
> > The series was split from my larger series sysctl-const series [0].
> > It only focusses on the proc_handlers but is an important step to be
> > able to move all static definitions of ctl_table into .rodata.
>=20
> Split this per subsystem, please.
It is tricky to do that because it changes the first argument (ctl*) to
const in the proc_handler function type defined in sysclt.h:
"
-typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
+typedef int proc_handler(const struct ctl_table *ctl, int write, void *buf=
fer,
                size_t *lenp, loff_t *ppos);
"
This means that all the proc_handlers need to change at the same time.

However, there is an alternative way to do this that allows chunking. We
first define the proc_handler as a void pointer (casting it where it is
being used) [1]. Then we could do the constification by subsystem (like
Jakub proposes). Finally we can "revert the void pointer change so we
don't have one size fit all pointer as our proc_handler [2].

Here are some comments about the alternative:
1. We would need to make the first argument const in all the derived
   proc_handlers [3]=20
2. There would be no undefined behavior for two reasons:
   2.1. There is no case where we change the first argument. We know
        this because there are no compile errors after we make it const.
   2.2. We would always go from non-const to const. This is the case
        because all the stuff that is unchanged in non-const.
3. If the idea sticks, it should go into mainline as one patchset. I
   would not like to have a void* proc_handler in a kernel release.
4. I think this is a "win/win" solution were the constification goes
   through and it is divided in such a way that it is reviewable.

I would really like to hear what ppl think about this "heretic"
alternative. @Thomas, @Luis, @Kees @Jakub?

Best

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git=
/commit/?h=3Djag/constfy_treewide_alternative&id=3D4a383503b1ea650d4e12c1f5=
838974e879f5aa6f
[2] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git=
/commit/?h=3Djag/constfy_treewide_alternative&id=3Da3be65973d27ec2933b9e81e=
1bec60be3a9b460d
[3] proc_dostring, proc_dobool, proc_dointvec....

--

Joel Granados

--q23ui2gu4xgkiues
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYqOKsACgkQupfNUreW
QU/lvAv/UMzbQzEuf2B53UY+EsWY1fAFwgTvC3thgwkdPKHKmQPe29eut0B+tDCl
ap0WjtDKSGfPOt/B1vZsxRAwLbtqQSX37nUsrtDtalsL3pFou2puYoIjP4gz2EHw
gIOwPG9y1kNEVips8pa+3xCLw7PkyFGjLWe1JDKZK68IRfE71kbNPOBY5UW52VMm
BEpao/WdI70J5QU0HgrmPJiT60I/kd64RWlbdnsT9LM/F1jGYQoyPelwD5LExTJJ
jvIK1/D3CxVCymEpga7rOczo7KyCpllfAEPDI79B5rQpdC2Z4Rk4QG1I9C21mEEt
cCQQEPqYdbCMjhg3/bnobMujv5m+HWZRan9lJJdu32JDVlNqLXMfdDc7IEdU0SrI
zMHYaLGQ2CxS8WP6jOWib26TuJSWVJp+FbjeMnBisKScXti/6UuH5NH8GBNYHlP+
YGS6/xkrsDyU7LJRmF26m8xqNX0KaYdKZYh5oxmZMPDraKi/W7xEgmu3h0/EMF7q
1i0OThmt
=dvhR
-----END PGP SIGNATURE-----

--q23ui2gu4xgkiues--

