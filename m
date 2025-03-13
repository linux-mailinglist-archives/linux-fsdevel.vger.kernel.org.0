Return-Path: <linux-fsdevel+bounces-43896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39542A5F4AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 13:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A71E3BD6D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA622673A4;
	Thu, 13 Mar 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XLo6AByh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97826659C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869592; cv=none; b=dxrmdO4d0kQmCFfqhILfyBs00M77Mp51ixrsoVPIExb/CPguFpsu5cehfv9SokkrygDz/1d7bSRJ6dF5k8nAQ2vD9rWepdeh8mIxLt7ZOX26AHqadhDP6rSZctYMNBDqv6mBLSeazKT0/IwsE6WK7/C1UaEeWGlDzKyTVZXRitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869592; c=relaxed/simple;
	bh=S1EhTwfy10Lh/XVOjXYcyVsHudpwVwn56kmoykbz/3w=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=gt+WN2aky3CDNyQ+JHHe34HE/S68BtJl7NWjUOHCuTMoW8Rf6hTi/48XYjWeKwEqi6rN431g5aeyY7cXlwQ4/Yb3Az2Bf6tAJHXLYD0yL2pWHnhR5eGtEUBVpMV71nd/yL1c592BGjxmfCCqyYXw1vxbtkvWaUfc/9VJI02ZVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XLo6AByh; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250313123941epoutp03e99ff0a527c7cd32481c0150c494ef15~sXSfjFNRz2200622006epoutp03Z
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 12:39:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250313123941epoutp03e99ff0a527c7cd32481c0150c494ef15~sXSfjFNRz2200622006epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741869581;
	bh=S1EhTwfy10Lh/XVOjXYcyVsHudpwVwn56kmoykbz/3w=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=XLo6AByhXxP5gUfUfXLAEOUz1ixXdqsnRc7nItBLk1e6q7J/0SPtbmetpomjkVvKr
	 lqZFHVy6WiiGf0gXWkIqO3j1XyL4XwNHJu3715BRdXafko2Ip26zqgfzWGMIs0rDC8
	 NsJ4wv4Fbl8V0KGNlc11K+PgbbrHCmePiUjgBOLg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20250313123941epcas1p4d7f7e2cfd5e1493061934db16f97da50~sXSfNk4Du0367303673epcas1p4b;
	Thu, 13 Mar 2025 12:39:41 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.248]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4ZD6Wx03xTz4x9Ps; Thu, 13 Mar
	2025 12:39:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.4B.31735.C02D2D76; Thu, 13 Mar 2025 21:39:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250313123939epcas1p232630aab02b5f69ff98085c856e64112~sXSdsyjPy0897008970epcas1p2R;
	Thu, 13 Mar 2025 12:39:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250313123939epsmtrp27e5b6f91ac7c556c8f8fbedbc7816484~sXSdsHSzH0876408764epsmtrp2e;
	Thu, 13 Mar 2025 12:39:39 +0000 (GMT)
X-AuditID: b6c32a4c-ac3ff70000007bf7-06-67d2d20c8de1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.37.18729.B02D2D76; Thu, 13 Mar 2025 21:39:39 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250313123939epsmtip258cf02203851b1e6dd9163e8710777b7~sXSdgIm3w0155801558epsmtip2Y;
	Thu, 13 Mar 2025 12:39:39 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Namjae Jeon'" <linkinjeon@kernel.org>, "'Al Viro'"
	<viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>, <sj1557.seo@samsung.com>,
	<sjdev.seo@gmail.com>
In-Reply-To: <394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com>
Subject: RE: [RFC] weird stuff in exfat_lookup()
Date: Thu, 13 Mar 2025 21:39:39 +0900
Message-ID: <29a2901db9414$fcacee50$f606caf0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHvIU014N/xpMzfEtxh/QSbUZFfYAGOig5MAmhErlICcjrXq7MWnMSA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmni7PpUvpBs9XWlpMnLaU2WLP3pMs
	Flv+HWG1ePFhA5vF+b/HWR1YPXbOusvusWlVJ5tH35ZVjB6fN8l5bHrylimANaqB0SaxKDkj
	syxVITUvOT8lMy/dVik0xE3XQkkhI7+4xFYp2tDQSM/QwFzPyMhIz9Qo1srIVEkhLzE31Vap
	QheqV0mhKLkAqDa3shhoQE6qHlRcrzg1L8UhK78U5GK94sTc4tK8dL3k/FwlhbLEnFKgEUr6
	Cd8YM25NmclW8MW8YvG/02wNjP1mXYycHBICJhI/ds9j7mLk4hAS2MMoseX9FDYI5xOjxLwj
	S6Ccb4wSW39vYIRpaXzbzwJiCwnsZZT4uV0aouglo8Slw5fZQRJsAroST278ZAaxRQRCJJ7M
	WQ/UzMHBLBAmcWS/HkiYU8BeYsvud2AzhQUMJC7P7mAFsVkEVCUe/trMBFLOK2AlcfuND0iY
	V0BQ4uTMJ2BrmQW0JZYtfM0McY6CxO5PR1khNrlJrN7SyAhRIyIxu7MN7DMJgVYOietf97JD
	NLhI3D3zG8oWlnh1fAuULSXx+d1eNoiGbkaJ4x/fsUAkZjBKLOlwgLDtJZpbm9kgftGUWL9L
	H2IZn8S7rz2sECWCEqevdTODlEgI8Ep0tAlBhFUkvn/YyQKz6sqPq0wTGJVmIXltFpLXZiF5
	YRbCsgWMLKsYpVILinPTU5MNCwx181LLkaN8EyM4xWr57GD8vv6v3iFGJg7GQ4wSHMxKIryr
	bS+kC/GmJFZWpRblxxeV5qQWH2JMBob3RGYp0eR8YJLPK4k3NDOztLA0MjE0NjM0JCxsYmlg
	YmZkYmFsaWymJM57YVtLupBAemJJanZqakFqEcwWJg5OqQamjRstz6Uy76zjlD2vtdfWM2hy
	RGXYjifrd5TfnCf+clps/Gk1x99h97Lr9s5V3j8haUN/T1T4lLqy3aoyb9tV0vmmcd9PmLlz
	oZfipe1OsVPmsLTJixzNMTev+yG65qZM3PqFu+JLLa0kf0gVMy4pazs5mbn2GBdD61I7tf/9
	x2z0Tp0r/MOz/i7X/MQ3cjcqezrudS6Sf/hmx/O/VR8kK+KPnMhR9RQueLU/X+nqytyG2E9S
	v66fMC1a/W/F1o7fbbprPjz/F7B7zZWA0KhVvBXKk65pfw67/sc4vyf0lse78PU83+ueSxy2
	vRn3IoNH8f2TbOvKq9OkuO9+yM4+GXXO7UzdjAdX7Wz3/Y5bp8RSnJFoqMVcVJwIAIOL5pto
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvC73pUvpBqu7tSwmTlvKbLFn70kW
	iy3/jrBavPiwgc3i/N/jrA6sHjtn3WX32LSqk82jb8sqRo/Pm+Q8Nj15yxTAGsVlk5Kak1mW
	WqRvl8CVcffkPbaCbrmKe3+PsjQwnhDsYuTkkBAwkWh8288CYgsJ7GaUOPg4oIuRAyguJXFw
	nyaEKSxx+HBxFyMXUMVzRok7Z/8xgpSzCehKPLnxkxnEFhEIkWibuBbMZhaIkNjXMYMNYuQ3
	Ronm92D1nAL2Elt2vwOzhQUMJC7P7mAFsVkEVCUe/trMBLKLV8BK4vYbH5Awr4CgxMmZT1gg
	RmpL9D5sZYSxly18zQxxvYLE7k9HWSFOcJNYvaURqkZEYnZnG/MERuFZSEbNQjJqFpJRs5C0
	LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwzWpo7GLev+qB3iJGJg/EQowQH
	s5II72rbC+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUa
	mLacUpj5+sifq6F3ihpP3iy9dIXt+x4N18UJlj3iKp3XOxV+qfSKf0/94pFV8caGp/2I/Ifz
	P47Wh2Yf0jN/2Xn2wG2H/7dM9SZL3neKm1KXZ/5auD7kht6h4JXKq/p/2ajNfPTr15XspZuW
	GK9635b8NWnvVYss3c9T/XsDLV7tLlRySJn7TNeXfcHBvbMcIk+xiwkU/dvx8td3M66jBxYE
	OS8TFzFatzb5gPF3/akX3h+MzWKwPzTt6esurrY97p/eRv6QVVXXX72iUXrFJtZyoV0sKXlX
	37s/bI3lNg3dpV6tdHHerNYrU09qa9zYIJB551z0OkvDj/kaK1zehLHOOdrLtzz7008b3pmf
	93crsRRnJBpqMRcVJwIAvLTNKAgDAAA=
X-CMS-MailID: 20250313123939epcas1p232630aab02b5f69ff98085c856e64112
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a
References: <20250227224826.GG2023217@ZenIV>
	<CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
	<CGME20250228160332epcas1p2b177def4195cedc4c122a5f09bb29d2a@epcas1p2.samsung.com>
	<394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com>

Hello,
> Hello? This is Sungjong. Currently, I am unable to reply using my
> samsung.com email, so I am responding with my other Gmail account.
>=20
> On 2/28/25 14:44, Namjae Jeon wrote:
> > On Fri, Feb 28, 2025 at 7:48=E2=80=AFAM=20Al=20Viro=20<viro=40zeniv.lin=
ux.org.uk>=20wrote:=0D=0A>=20>>=0D=0A>=20>>=20=20=20=20=20=20=20=20=20There=
's=20a=20really=20odd=20comment=20in=20that=20thing:=0D=0A>=20>>=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20/*=0D=0A>=20>>=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20*=20Unhashed=20alias=20is=20able=20to=
=20exist=20because=20of=20revalidate()=0D=0A>=20>>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20*=20called=20by=20lookup_fast.=20You=20can=20=
easily=20make=20this=20status=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20*=20by=20calling=20create=20and=20lookup=20concurrentl=
y=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*=20In=
=20such=20case,=20we=20reuse=20an=20alias=20instead=20of=20new=20dentry=0D=
=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*/=0D=0A>=20=
>>=20and=20AFAICS=20it=20had=20been=20there=20since=20the=20original=20merg=
e.=20=20What=20I=20don't=0D=0A>=20>>=20understand=20is=20how=20the=20hell=
=20could=20revalidate=20result=20in=20that=20-=0D=0A>=20>>=20exfat_d_revali=
date()=20always=20returns=201=20on=20any=20positive=20dentry=20and=20alias=
=0D=0A>=20is=0D=0A>=20>>=20obviously=20positive=20(it=20has=20the=20same=20=
inode=20as=20the=20one=20we=20are=20about=20to=0D=0A>=20use).=0D=0A>=20>>=
=0D=0A>=20>>=20It=20mentions=20a=20way=20to=20reproduce=20that,=20but=20I=
=20don't=20understand=20what=20does=0D=0A>=20>>=20that=20refer=20to;=20coul=
d=20you=20give=20details?=0D=0A=0D=0AI=20tested=20it=20on=20an=20arm64=20de=
vice=20running=20on=20Android=20with=20kernel=20v5.15,=20v6.6.=0D=0AAnd=20I=
=20can=20see=20unhashed-positive=20dentry=20with=20the=20following=20simple=
=20TC,=0D=0Aeven=20if=20it=20is=20not=20an=20Android=20stacked=20fs=20envir=
onment.=0D=0A=0D=0A*=20TestCase=0D=0A-=20thread1:=20while(1)=20=7B=20mkdir(=
A)=20and=20rmdir(A)=20=7D=0D=0A-=20thread2:=20while(1)=20=7B=20stat(A)=20=
=7D=0D=0A=0D=0AThis=20is=20due=20to=20the=20characteristics=20of=20exfat=20=
allowing=20negative=20dentry=20and=0D=0Aconsidering=20CI=20in=20d_revalidat=
e.=20As=20mentioned=20in=20the=20comment,=0D=0Aunhashed-positive=20dentry=
=20can=20exist=20in=20a=20situation=20where=20mkdir=0D=0Aand=20stat=20are=
=20competing,=20and=20it=20can=20be=20dropped,=20but=20exfat_lookup=20has=
=0D=0Abeen=20implemented=20to=20reuse(rehash)=20this=20dentry.=0D=0A=0D=0AI=
=20hope=20the=20following=20callstack=20will=20help=20you=20understand.=0D=
=0AThank=20you.=0D=0A=0D=0A=20=20=20=20=20<CPU=200>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20<CPU=201>=0D=0Ado_mkdirat=0D=0A=
=20=20user_path_create=0D=0A=20=20=20*filename_create=0D=0A=20=20=20=20=20=
=20inode_lock(I_MUTEX_PARENT)=0D=0A=20=20=20=20=20=20__lookup_hash(LOOKUP_C=
REATE=20=7C=20LOOKUP_EXCL)=0D=0A=20=20=20=20=20=20=20=20dentry=20=3D=20d_al=
loc=0D=0A=20=20=20=20=20=20=20=20exfat_lookup=0D=0A=20=20=20=20=20=20=20=20=
=20=20lock(sbi->s_lock)=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20no_exist_f=
ile=0D=0A=20=20=20=20=20=20=20=20=20=20unlock(sbi->s_lock)=0D=0A=20=20=20=
=20=20=20=20=20=20=20d_version_set=0D=0A=20=20=20=20=20=20=20=20=20=20d_spl=
ice_alias=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20__d_add()=20=20=20//hash=
ed-negative=20dentry=20here=0D=0A=20=20=20*vfs_mkdir=0D=0A=20=20=20=20=20=
=20exfat_mkdir=0D=0A=20=20=20=20=20=20=20=20lock(sbi->s_lock)=0D=0A=20=20=
=20=20=20=20=20=20inc_iversion(dir)//iversion=20diff=20occured=0D=0A=09=09=
=09=20=20=20=20=20=20vfs_statx=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20filename_loo=
kup=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20path_lookupat=0D=0A=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20lookup_last=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20work_component=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20lookup_fast=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20dentry=20=3D=20__d_lookup=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20d_revalidate(dentry)=20//because=20of=20iversion=
=20diff=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20d_i=
nvalidate(dentry)=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20__d_drop(dentry)=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20lookup_slow=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20inode_lock_shared(dir)=0D=0A=20=20=20=20=20=20=20=20inc_nlink(d=
ir)=0D=0A=20=20=20=20=20=20=20=20inode=20=3D=20build_inode=0D=0A=20=20=20=
=20=20=20=20=20inc_iversion(inode)=0D=0A=20=20=20=20=20=20=20=20d_instantia=
te(dentry,=20inode)=20//*=20unhashed-positive=20dentry=20here=0D=0A=20=20=
=20=20=20=20=20=20unlock(sbi->s_lock)=0D=0A=20=20=20*done_path_create=0D=0A=
=20=20=20=20=20=20=20inode_unlock(I_MUTEX_PARENT)=0D=0A=09=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20__lookup_slow=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20exfat_lookup=0D=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20lock(sbi->s_lock)=0D=0A=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20inode=20=3D=20exfat_b=
uild_inode=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20alias=20=3D=20d_find_alias(inode)=0D=0A=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20d_unhashed(alias)?=20//=20*=20=
found=20unhashed=20positive=20dentry=20*=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20d_rehash(alias)=0D=0A...=0D=0A=0D=
=0A

