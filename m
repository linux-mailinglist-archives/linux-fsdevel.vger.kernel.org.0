Return-Path: <linux-fsdevel+bounces-38628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB577A051A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 04:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3811680AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459B1A23AC;
	Wed,  8 Jan 2025 03:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fv9nrL8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1C2594BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307335; cv=none; b=Xq9Omk6hbNTF+wApiWREu1z9sK/0eXVnPIkorS4RVV9WNtkAlLMiRrwm3AGQFrquTFwMFyk5o0J20s7aFdIHAKm4YY4R6F/cJDEpvuWscFsCm+qM3Bz7mvfSrnrVY7ovK5yFGa0zM9iZvUFmSHQ+MMiUWt4W6eYvrQ+YD8x1Zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307335; c=relaxed/simple;
	bh=qkFpxC+x9vKo5vydv11gWwsFzajt3hwmgiqouxvRn9o=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=HKls3l5xdCuf8Gr2cTV0ZxwyK7ADSzxT6KOcGShPvic7nl8p4vHxHVIdwQBvJTJu2PFmB5oYoQ6hSOj96c6VCGsekmU4B3DnzTzgpXcHFv/XejhMrsAamzd3Mf0W/h8njpVy/DUSGHdw561mRP95uStdRo2AdtHozmJaISEW6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Fv9nrL8L; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250108033524epoutp01c9df6f0788fe6224c9f1797c012a8051~Ymk-1P4Xi0190801908epoutp01C
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 03:35:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250108033524epoutp01c9df6f0788fe6224c9f1797c012a8051~Ymk-1P4Xi0190801908epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736307324;
	bh=qkFpxC+x9vKo5vydv11gWwsFzajt3hwmgiqouxvRn9o=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=Fv9nrL8LyRe+dv0xIiucNPmGKgaVXr9VJCthPJMb3fx0PlRPLqQ0mk5p2W2OHh5pp
	 p65qInU+r5BbmHq/jF3YY0wDRIrjzbWMRrOBYAHfNWdmddXh++63Q+TnkhPTy3WzBV
	 J63uOySI3n/YvrmthwUN+3c18+ZjWVWyIlK2dCoU=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250108033523epcas5p13d0adba12618a57962aa7623b11784b5~Ymk-RMtAt1235912359epcas5p1A;
	Wed,  8 Jan 2025 03:35:23 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-fb-677df27b0912
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.A5.19933.B72FD776; Wed,  8 Jan 2025 12:35:23 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] lib/list_debug.c: add object information in case of
 invalid object
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: Christian Brauner <brauner@kernel.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "elver@google.com"
	<elver@google.com>, "jack@suse.cz" <jack@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Rohit Thapliyal
	<r.thapliyal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250107-grade-entgiften-74e459edf9ce@brauner>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250108031723epcms5p6903c4e62f2e8ca63f18724cdfbfa492d@epcms5p6>
Date: Wed, 08 Jan 2025 08:47:23 +0530
X-CMS-MailID: 20250108031723epcms5p6903c4e62f2e8ca63f18724cdfbfa492d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7bCmpm71p9p0g4N9JhZz1q9hs3h9+BOj
	RduZ7awWs6c3M1ns2XuSxeLyrjlsFvfW/Ge12Hgv2+L83+OsDpweCzaVemxa1cnmsenTJHaP
	EzN+s3j0bVnF6HFmwRF2j8+b5Dw2PXnLFMARxWWTkpqTWZZapG+XwJVx5EUnS0GTYMWdW8fZ
	GxgPCnQxcnJICJhInF7cytTFyMUhJLCbUWLN5N+MXYwcHLwCghJ/dwiD1AgLxEo8vryKCcQW
	ElCUuDBjDViJsICBxK+tGiBhNgE9iVW79rCA2CICWhJNiz6CjWQWmMEs0dd8iB1iF6/EjPan
	LBC2tMT25VvB5nAK2EhMv2wLERaVuLn6LTuM/f7YfEYIW0Si9d5ZZghbUOLBz91QcRmJ1Zt7
	oUZWSzx9fY4NZK+EQAujxL7dMEXmEuuXrAIbyivgK7G04QjYIBYBVYmzja+YQW6QEHCR2LDa
	CSTMLKAtsWzha7Aws4CmxPpd+hBTZCWmnlrHBFHCJ9H7+wkTzFc75sHYqhItNzewwnz4+eNH
	qNM8JM6sW8oCCeVtjBK7F05knMCoMAsR0LOQbJ6FsHkBI/MqRsnUguLc9NRi0wKjvNRyveLE
	3OLSvHS95PzcTYzglKTltYPx4YMPeocYmTgYDzFKcDArifBaytamC/GmJFZWpRblxxeV5qQW
	H2KU5mBREud93To3RUggPbEkNTs1tSC1CCbLxMEp1cAkx/3dNH2Bt+dG700Pax8vMYo4uu98
	SvE+4UtrfC5/+a6uztbL0SNyIDvlybKwKPHle7paDp5VT+abL3nQIM3BQ8S2dOIL5yKeFfoC
	l45NVtO+M4U/yyExxl9v2bPvihGCGxiPHNToYFVj8K1+uTnVpC8pmd1PWnmtm4JQ/r1XQTL1
	fTuF98/nWvFP01oqv2dqdY6j0/uIAvmU2O3H5xdPsMjy8dr4OT1GX2RroQBfxqO6V+fbE2vX
	zWS4Xr1Fc+vtpwKv5qcavJI60utVcehd9H31R91qaS819vv9fCf2Vm75WymZ7TxbT3Dob/nj
	758WEXs2/GXGhAOvmvsPh56SPHX/TBxz5DL9mYfCfJVYijMSDbWYi4oTATQCra64AwAA
X-CMS-RootMailID: 20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39
References: <20250107-grade-entgiften-74e459edf9ce@brauner>
	<20241230101043.53773-1-maninder1.s@samsung.com>
	<CGME20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39@epcms5p6>

Hi,


>>=20
>> =5B=C2=A0=20=2014.243055=5D=C2=A0=20slab=20kmalloc-32=20start=20ffff0000=
cda19320=20data=20offset=2032=20pointer=20offset=208=20size=2032=20allocate=
d=20at=20add_to_list+0x28/0xb0=0D=0A>>=20=5B=C2=A0=20=2014.245259=5D=C2=A0=
=20=C2=A0=20=20__kmalloc_cache_noprof+0x1c4/0x358=0D=0A>>=20=5B=C2=A0=20=20=
14.245572=5D=C2=A0=20=C2=A0=20=20add_to_list+0x28/0xb0=0D=0A>>=20...=0D=0A>=
>=20=5B=C2=A0=20=2014.248632=5D=C2=A0=20=C2=A0=20=20do_el0_svc_compat+0x1c/=
0x34=0D=0A>>=20=5B=C2=A0=20=2014.249018=5D=C2=A0=20=C2=A0=20=20el0_svc_comp=
at+0x2c/0x80=0D=0A>>=20=5B=C2=A0=20=2014.249244=5D=C2=A0=20Free=20path:=0D=
=0A>>=20=5B=C2=A0=20=2014.249410=5D=C2=A0=20=C2=A0=20=20kfree+0x24c/0x2f0=
=0D=0A>>=20=5B=C2=A0=20=2014.249724=5D=C2=A0=20=C2=A0=20=20do_force_corrupt=
ion+0xbc/0x100=0D=0A>>=20...=0D=0A>>=20=5B=C2=A0=20=2014.252266=5D=C2=A0=20=
=C2=A0=20=20el0_svc_common.constprop.0+0x40/0xe0=0D=0A>>=20=5B=C2=A0=20=201=
4.252540=5D=C2=A0=20=C2=A0=20=20do_el0_svc_compat+0x1c/0x34=0D=0A>>=20=5B=
=C2=A0=20=2014.252763=5D=C2=A0=20=C2=A0=20=20el0_svc_compat+0x2c/0x80=0D=0A=
>>=20=5B=C2=A0=20=2014.253071=5D=20------------=5B=20cut=20here=20=5D------=
------=0D=0A>>=20=5B=C2=A0=20=2014.253303=5D=20list_del=20corruption.=20nex=
t->prev=20should=20be=20ffff0000cda192a8,=20but=20was=206b6b6b6b6b6b6b6b.=
=20(next=3Dffff0000cda19348)=0D=0A>>=20=5B=C2=A0=20=2014.254255=5D=20WARNIN=
G:=20CPU:=203=20PID:=2084=20at=20lib/list_debug.c:65=20__list_del_entry_val=
id_or_report+0x158/0x164=0D=0A>>=20=0D=0A>>=20moved=20prototype=20of=20mem_=
dump_obj()=20to=20bug.h,=20as=20mm.h=20can=20not=20be=20included=0D=0A>>=20=
in=20bug.h.=0D=0A>>=20=0D=0A>>=20Signed-off-by:=20Maninder=20Singh=20<manin=
der1.s=40samsung.com>=0D=0A>>=20---=0D=0A>=0D=0A>=20Can=20you=20please=20ba=
se=20this=20on=20either=20the=20latest=20mainline=20tag=20or=0D=0A>=20vfs-6=
.14.misc=20and=20resend,=20please?=0D=0A=0D=0AIt=20is=20already=20applied=
=20to=20latest=20mainline=20(linux-next)=0D=0Ahttps://git.kernel.org/pub/sc=
m/linux/kernel/git/next/linux-next.git/commit/?id=3D6fffae498b254b20cbaa9e7=
54d793df9c4effc4d=0D=0A=0D=0AThanks,=0D=0AManinder=20Singh=0D=0A

