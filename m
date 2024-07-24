Return-Path: <linux-fsdevel+bounces-24183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E137993AD6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A8B1C21F11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CA8287A;
	Wed, 24 Jul 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m64yFxTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129D4E1C8
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807414; cv=none; b=i+yNSb9xcvOZ27jit/eB+EzZN0vbFyhfv3gb5vp0TtKLcmnNArrVi0cKD4gAxHESoUQvAQV9V8j1fDzHinDM8LQj3Td76kerfpng0WRfOnoZcC52XNqr6LhyovR0fvawGxKzkBUC2o9edXCKyIddkJds8gWZBRvGT+b9LssL+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807414; c=relaxed/simple;
	bh=kin24R2k9ZgxIho8dcG1U4578OPws/twjPugur5tPMM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=QmyH2cmD3uE7CACYzvYFAUki3sdOAJjRtTqA1kB2oxpbnnk6ygMjZNCYKcqYx2HJFvxwBV7GrfqFfxG1YFc3HUHGDWMnR/SLWtyC7HZSESDo7vlCw1227478ULM4FWuWcnPFWe2xIsXHI7fFG8SXLOUcWkw6pUy2AjhhQF3DlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m64yFxTU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240724075008epoutp0387aba5844ee08ee6e24361fbf811367e~lFrctL9Mh0602306023epoutp036
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:50:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240724075008epoutp0387aba5844ee08ee6e24361fbf811367e~lFrctL9Mh0602306023epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721807408;
	bh=kin24R2k9ZgxIho8dcG1U4578OPws/twjPugur5tPMM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=m64yFxTUtf9ABgwSIXQV2gGQ2ilurUzRE392cIRWzyAZofxdWD9p9fSBEunV+S8d7
	 AZv6JUhQhzH/y5kASvUTbmZfQJ/nPzKo36KlNnOzME2NyAOhLEveN8V/pu8vACnleD
	 uHJsXa/UVyHRN6VvX+HKR+GW3RvmMBlswWo7WWp8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240724075007epcas1p3efe8d06fc668f0489d8304e91758a0ce~lFrcKH3gE0694306943epcas1p3i;
	Wed, 24 Jul 2024 07:50:07 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WTR4v3cGMz4x9Q8; Wed, 24 Jul
	2024 07:50:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.98.10258.F22B0A66; Wed, 24 Jul 2024 16:50:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724075007epcas1p23f983ef19a6bda074b87efae7018adc2~lFrbUKqK10049300493epcas1p2i;
	Wed, 24 Jul 2024 07:50:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240724075007epsmtrp1883a0f8a8fbdd9f979e16414920b9f11~lFrbTHTcr2949529495epsmtrp1V;
	Wed, 24 Jul 2024 07:50:07 +0000 (GMT)
X-AuditID: b6c32a38-22f19a8000002812-bc-66a0b22fc768
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.FD.07567.E22B0A66; Wed, 24 Jul 2024 16:50:06 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240724075006epsmtip1a137b05e555676df0f85130545fe158f~lFrbGhM390853408534epsmtip1y;
	Wed, 24 Jul 2024 07:50:06 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'dongliang cui'" <cuidongliang390@gmail.com>
Cc: "'Dongliang Cui'" <dongliang.cui@unisoc.com>, <linkinjeon@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>,
	"'Zhiguo	Niu'" <zhiguo.niu@unisoc.com>, <sj1557.seo@samsung.com>
In-Reply-To: <CAPqOJe3mdz_heMQe09uZTf-E40ZBTMDuf49jE+hd10qYOjURmg@mail.gmail.com>
Subject: RE: [PATCH v2] exfat: check disk status during buffer write
Date: Wed, 24 Jul 2024 16:50:06 +0900
Message-ID: <162ee01dadd9e$19cbaa40$4d62fec0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGzaQBfv4s+oykJFwGd5ZaoFrNFNAItpdPUAbBOzm0BJQcI97IsTUzQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmga7+pgVpBjemiVpM/HGF1eLl5rfM
	FvM/P2GzeLTnHpPFxGlLmS327D3JYnF51xw2i9cHHjJbbPl3hNVi6tNjrA5cHjtn3WX32LSq
	k82jb8sqRo/D7WfZPT5vkgtgjWpgtEksSs7ILEtVSM1Lzk/JzEu3VQoNcdO1UFLIyC8usVWK
	NjQ00jM0MNczMjLSMzWKtTIyVVLIS8xNtVWq0IXqVVIoSi4Aqs2tLAYakJOqBxXXK07NS3HI
	yi8FeUWvODG3uDQvXS85P1dJoSwxpxRohJJ+wjfGjCmNp5gLZktUzNj8kL2B8ZB4FyMnh4SA
	icTaaQfYuhi5OIQEdjBKzP/7lhHC+cQosfXCXVYI5xujxL7XS5lgWk58fQnVspdR4u2PfnYI
	5yWjRNvJZrAqNgFdiSc3fjKD2CIChhLnZv1hAiliFpjDJPHn5E5WkASnQKDEjR8/gWwODmEB
	F4l/H81BwiwCqhINh/eBzeEVsJL4Nvc+M4QtKHFy5hMWEJtZQFti2cLXzBAXKUjs/nSUFWKX
	m0T7v0WsEDUiErM726Bq1nJIHJ2hD2G7SPR1/WWFsIUlXh3fwg5hS0m87G8De0ZCoJtR4vjH
	dywQiRmMEks6HCBse4nm1mY2kJuZBTQl1u/Sh9jFJ/Huaw/UTEGJ09e6mUFKJAR4JTrahCDC
	KhLfP+xkgVl15cdVpgmMSrOQfDYLyWezkHwwC2HZAkaWVYxiqQXFuempxYYFJsgRvokRnJC1
	LHYwzn37Qe8QIxMH4yFGCQ5mJRHeJ6/mpgnxpiRWVqUW5ccXleakFh9iTAaG9URmKdHkfGBO
	yCuJNzQzs7SwNDIxNDYzNCQsbGJpYGJmZGJhbGlspiTOe+ZKWaqQQHpiSWp2ampBahHMFiYO
	TqkGpmkpk7aGTHhgcsX4z9Gfs2WFQl1FHzjP9vZ1KfryqKHut/vhomtqqxrMJGdF++5dnr/K
	6uTbXqbPszJlOJcemaYh+vDQGcEyn6cr3r4/NkXKzFmEX+KyhxWXzKNJu2w5F+2smCUQ5+Bh
	/SPfSZT7XoM/d7q+yROVvgVZ/wzS9TsX1bvd3s7KzuJj8sJXppCpP73LzfLizu9VkR2fhRzE
	Gma/PtXkkSnk3Xj93Rz+7qkeQbu/PzvL875KY1/lwjX/lVb82XLdafnOIz3HT/Fv9HH+U57g
	2v/Np9z7covvnaPbdr6Zdfl60o6vp8yKNi5i2POmV0ftWVjhtZrX+5SD0kIO/3ZkrGHvPPND
	21ooTomlOCPRUIu5qDgRANFV2ax/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnK7epgVpBifaLCwm/rjCavFy81tm
	i/mfn7BZPNpzj8li4rSlzBZ79p5ksbi8aw6bxesDD5kttvw7wmox9ekxVgcuj52z7rJ7bFrV
	yebRt2UVo8fh9rPsHp83yQWwRnHZpKTmZJalFunbJXBlHD72kb3gPX/Fj1sX2RsYO3m6GDk5
	JARMJE58fcnWxcjFISSwm1Hi+dw5rF2MHEAJKYmD+zQhTGGJw4eLIUqeM0os+T6XDaSXTUBX
	4smNn8wgtoiAocS5WX+YQIqYBZYxSVxp280O0dHKJHG1/zo7SBWnQKDEjR8/wRYIC7hI/Pto
	DhJmEVCVaDi8jwnE5hWwkvg29z4zhC0ocXLmExYQm1lAW6L3YSsjjL1s4WtmiAcUJHZ/OsoK
	cYSbRPu/RawQNSISszvbmCcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcZMMCw7zUcr3i
	xNzi0rx0veT83E2M4FjT0tjBeG/+P71DjEwcjIcYJTiYlUR4n7yamybEm5JYWZValB9fVJqT
	WnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QDU8feZTlMa0/o7Jy0Sl1N4rXBk0N7
	J06cNy/sbu+xg/+is9mtarc3enSEKmhlvc266HVvWwuj+fxmp1XTJ/5u+Fm1McdKcfHtuFU3
	d/40sNQx4Lh0JsC8jcepsIW3Zcem8wfm901MZ31/UeVXF3+VzIGlRyMmqU4qCy32SVKZbvPQ
	eorIjMrnk+OYThuxJMco7ZBSNw5+HLah0JRBpVe95UiC7vKfvK4Vkz9H7VneXGTx5ctL468m
	PEcvXJmd4hUgOtWEy1JHXGA2/xKDiXkvHrS4ap/fYi1VYr5+9hZn5/otB60MbN/FBRrt2aBg
	uYM1ITSg5+yUU79ndYvWC7fv6+D9W36+4qhnkfHWhe+rlViKMxINtZiLihMBvxlMiyQDAAA=
X-CMS-MailID: 20240724075007epcas1p23f983ef19a6bda074b87efae7018adc2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240723105423epcas1p4d4ee53975fbc4644e969b5c9b7514c9b
References: <CGME20240723105423epcas1p4d4ee53975fbc4644e969b5c9b7514c9b@epcas1p4.samsung.com>
	<20240723105412.3615926-1-dongliang.cui@unisoc.com>
	<1625601dadd97$88eca020$9ac5e060$@samsung.com>
	<CAPqOJe3mdz_heMQe09uZTf-E40ZBTMDuf49jE+hd10qYOjURmg@mail.gmail.com>

> On Wed, Jul 24, 2024 at 3:03=E2=80=AFPM=20Sungjong=20Seo=20<sj1557.seo=40=
samsung.com>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A=5Bsnip=5D=0D=0A>=20>=20>=0D=
=0A>=20>=20>=20+static=20int=20exfat_block_device_ejected(struct=20super_bl=
ock=20*sb)=0D=0A>=20>=20>=20+=7B=0D=0A>=20>=20>=20+=20=20=20=20=20struct=20=
backing_dev_info=20*bdi=20=3D=20sb->s_bdi;=0D=0A>=20>=20>=20+=0D=0A>=20>=20=
>=20+=20=20=20=20=20return=20bdi->dev=20=3D=3D=20NULL;=0D=0A>=20>=20>=20+=
=7D=0D=0A>=20>=20Have=20you=20tested=20with=20this=20again?=0D=0A>=20Yes,=
=20I=20tested=20it=20in=20this=20way.=20The=20user=20side=20can=20receive=
=20the=20-ENODEV=20error=0D=0A>=20after=20the=20device=20is=20ejected.=0D=
=0A>=20dongliang.cui=40deivice:/data/tmp=20=23=20dd=20if=3D/dev/zero=20of=
=3Dtest.img=20bs=3D1M=0D=0A>=20count=3D10240=0D=0A>=20dd:=20test.img:=20wri=
te=20error:=20No=20such=20device=0D=0A>=201274+0=20records=20in=0D=0A>=2012=
73+1=20records=20out=0D=0A>=201335635968=20bytes=20(1.2=20G)=20copied,=208.=
060=20s,=20158=20M/s=0D=0AOops=21,=20write()=20seems=20to=20return=20ENODEV=
=20that=20man=20page=20does=20not=20have.=0D=0AIn=20exfat_map_cluster,=20it=
=20was=20necessary=20to=20distinguish=20and=20return=20error=0D=0Avalues,=
=20but=20now=20that=20explicitly=20differentiated=20error=20messages=20will=
=20be=0D=0Aprinted.=20So,=20why=20not=20return=20EIO=20again?=20It=20seem=
=20appropriate=20to=20return=20EIO=0D=0Ainstead=20of=20ENODEV=20from=20the=
=20read/write=20syscall.=0D=0A=0D=0A>=20=0D=0A>=20>=0D=0A>=20>=20>=20+=0D=
=0A>=20>=20>=20=20static=20int=20exfat_get_block(struct=20inode=20*inode,=
=20sector_t=20iblock,=0D=0A>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20struct=20buffer_head=20*bh_result,=20int=20create)=0D=0A>=20>=20>=20=
=20=7B=0D=0A>=20>=20>=20=40=40=20-290,6=20+298,9=20=40=40=20static=20int=20=
exfat_get_block(struct=20inode=20*inode,=0D=0A>=20>=20>=20sector_t=20iblock=
,=0D=0A>=20>=20>=20=20=20=20=20=20=20sector_t=20valid_blks;=0D=0A>=20>=20>=
=20=20=20=20=20=20=20loff_t=20pos;=0D=0A>=20>=20>=0D=0A>=20>=20>=20+=20=20=
=20=20=20if=20(exfat_block_device_ejected(sb))=0D=0A>=20>=20This=20looks=20=
better=20than=20the=20modified=20location=20in=20the=20last=20patch.=0D=0A>=
=20>=20However,=20the=20caller=20of=20this=20function=20may=20not=20be=20in=
terested=20in=20exfat=0D=0A>=20>=20error=20handling,=20so=20here=20we=20sho=
uld=20call=20exfat_fs_error_ratelimit()=0D=0A>=20>=20with=20an=20appropriat=
e=20error=20message.=0D=0A>=20Thank=20you=20for=20the=20reminder.=20I=20wil=
l=20make=20the=20changes=20in=20the=20next=20version.=0D=0ASounds=20good=21=
=0D=0A=0D=0A>=20=0D=0A>=20>=0D=0A>=20>=20>=20+=20=20=20=20=20=20=20=20=20=
=20=20=20=20return=20-ENODEV;=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20=20=20=20=
=20=20=20mutex_lock(&sbi->s_lock);=0D=0A>=20>=20>=20=20=20=20=20=20=20last_=
block=20=3D=20EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode),=20sb);=0D=0A>=20>=
=20>=20=20=20=20=20=20=20if=20(iblock=20>=3D=20last_block=20&&=20=21create)=
=0D=0A>=20>=20>=20--=0D=0A>=20>=20>=202.25.1=0D=0A>=20>=0D=0A>=20>=0D=0A=0D=
=0A

