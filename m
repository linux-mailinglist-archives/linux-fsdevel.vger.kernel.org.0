Return-Path: <linux-fsdevel+bounces-28451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D619B96A808
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 22:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90201286BC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB245191477;
	Tue,  3 Sep 2024 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MojC+PXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA71DC725
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394021; cv=none; b=kYiyDxN+koKxd+NoU6w+6NwglsOmjkfoJdfJI686UxG+eSrG6tzXXuOsQegI1YS1fyiUXIAJxl5oAWb46j6bTGciX/PonemcLWNW2C6LXFzSoncUYdqWt2MfOOC2kgA09CMikPu/5A2H6OpmpaH6j3D/IeRysYdj3xxEC0WPcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394021; c=relaxed/simple;
	bh=AyhpyMppaX/D3fbkezpJnI22s0NQHJ1fqqTEPhSj9Rk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=URW5DmE7mLo2njJVuOyf+OPKBW6tmrjILxeZ/0XnhrvyEMXKCt+zZuZnIydz6xqLHcdY2PEZrOnSZdb1vwPJK5PluA0jYLRZWDcOz+LJ8T6OL60kbW2oCJbEqTbVuVbdo8GLzD5yd5yjhN5827/DIXd9+Ka4DYa7XICHY4g7XOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MojC+PXl; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240903200656euoutp0217f521b676da11ea3887ed8b5f327cd5~x1LdsOrHT2117921179euoutp02P
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 20:06:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240903200656euoutp0217f521b676da11ea3887ed8b5f327cd5~x1LdsOrHT2117921179euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725394016;
	bh=bA6kcbLjHf01UFNtN8qJPiiSLCXffr+Zmg1Q2uwqTVE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MojC+PXlQGObK9xbKO7/f1S7+ND/CaQn+u0MRYBsoSkVC4n/pmyJCuqtCTrv7/ODt
	 00dr6/gxsEhLyDnqb6WgN88dCCqNXXGOxbYp1LuPZuOJw2jFSz2gZFCBbkKZ2CXMjo
	 GBMMcKXZGrO6WpQn2QETujoAVE1WOX5GFtB7YNG0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240903200656eucas1p1151258b80df8a39942b88584a168b067~x1Ldj3eMp1547015470eucas1p15;
	Tue,  3 Sep 2024 20:06:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 60.88.09620.06C67D66; Tue,  3
	Sep 2024 21:06:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240903200655eucas1p2c0c78da561718236c76154df4425d0e5~x1Lc48fiq0080900809eucas1p2b;
	Tue,  3 Sep 2024 20:06:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240903200655eusmtrp29ae9905a6cd09d9e9995192917d1ccab~x1Lc4dcj70771507715eusmtrp2K;
	Tue,  3 Sep 2024 20:06:55 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-6f-66d76c60b41a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D6.87.14621.F5C67D66; Tue,  3
	Sep 2024 21:06:55 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240903200655eusmtip249445a194f2226cbcafefdc48be7356d~x1Lcuq1ja1639316393eusmtip2N;
	Tue,  3 Sep 2024 20:06:55 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 3 Sep 2024 21:06:54 +0100
Date: Tue, 3 Sep 2024 22:06:51 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: Convert locking comments to lockdep assertions
Message-ID: <20240903200651.nahx55h5yap5xhxx@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240629-sysctl-lockdep-v1-1-69196ce85225@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned2EnOtpBvsfCVise3ue1WLP3pMs
	Fpd3zWGz+P3jGZPFjQlPGR1YPTat6mTz+LxJzqO/+xh7AHMUl01Kak5mWWqRvl0CV8ar1ztZ
	Ck4zV/w9M4etgfEZUxcjJ4eEgInE5Xe7mbsYuTiEBFYwSixZupkJwvnCKLFn0nJ2COczo8Te
	SSdZYVqeLZzIApFYzihxbcpcNriqde0nofq3MEocm/KAHaSFRUBFYsbhOWDtbAI6Euff3GEG
	sUUEbCRWfvsMVsMs0MEoseBOOIgtLOAtsX7VRrA4r4CDxP5DbxghbEGJkzOfsEDU60ncmDoF
	aDMHkC0tsfwfB0RYXqJ562yw8ZwC7hLLGj+xQFytLHFw2SF2CLtW4tSWW9AAuMIh0fhKFsJ2
	kXi0fAkzhC0s8er4Fqh6GYn/O+eD/SUhMJlRYv+/D+wQzmpGoA1foSZZS7RceQLV4Sgx7/0V
	VpDjJAT4JG68FYQ4jk9i0rbpzBBhXomONqEJjCqzkHw2C8lnsxA+m4XkswWMLKsYxVNLi3PT
	U4uN81LL9YoTc4tL89L1kvNzNzEC08vpf8e/7mBc8eqj3iFGJg7GQ4wSHMxKIryxG6+mCfGm
	JFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTAtux3dEf65eOfZ
	f/ypf65P1t4zk1mmMWraRze3OYIOWTebp2+YyvF59p8Ztz/qGkiqXI1X7+RdoJaWuPDtm4dz
	C9if7Txt550nl3o9raP+urXVqm9JM9nsdi9y91+z8gCrmpjwu5IPzeVP3FdnPJvN8uHP7blr
	phmePFstFfVs/1dXxtuLr5/ZJMHv9NL/R92MI01LOvd7eqtOtVwV3sXSwV92PKSi5pjUwq0v
	l5zNveZodSJYlrv3m0T2Hd5z8yJ3iK3b1jRl8iJz5d1Ty/7qTPBkrf2z8VGKEcuCusUnbY30
	w8MMfLe9/CNlFrGy/oucWbRe9TPlY/c5tct+1k2fy/exItpo847Vste2LVCeoMRSnJFoqMVc
	VJwIAAPesMeeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7rxOdfTDPpbVCzWvT3ParFn70kW
	i8u75rBZ/P7xjMnixoSnjA6sHptWdbJ5fN4k59HffYw9gDlKz6Yov7QkVSEjv7jEVina0MJI
	z9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PV650sBaeZK/6emcPWwPiMqYuRk0NC
	wETi2cKJLF2MXBxCAksZJY5t+cIIkZCR2PjlKiuELSzx51oXG0TRR0aJGX/3QjlbGCX6r+wF
	G8UioCIx4/AcsA42AR2J82/uMIPYIgI2Eiu/fWYHsZkFOhglFtwJB7GFBbwl1q/aCBbnFXCQ
	2H/oDdhmIYFZjBL7lxhAxAUlTs58wgLRqydxY+oUoMUcQLa0xPJ/HBBheYnmrbPBVnEKuEss
	a/zEAnG0ssTBZYfYIexaic9/nzFOYBSZhWTqLCRTZyFMnYVk6gJGllWMIqmlxbnpucWGesWJ
	ucWleel6yfm5mxiBsbft2M/NOxjnvfqod4iRiYPxEKMEB7OSCG/sxqtpQrwpiZVVqUX58UWl
	OanFhxhNgSE0kVlKNDkfGP15JfGGZgamhiZmlgamlmbGSuK8bpfPpwkJpCeWpGanphakFsH0
	MXFwSjUwZe+O4GJNOOKc2SM09an88RLvP1M56lVUOwXz5/0zTFtb+0rpdOzHicX/+lWfiP/t
	jQqTCX2ycXPaifmebu/Uz570+rR/ucLOwwLCd9J/Jm3JDNdyXLKRP6XHmi2MwWb7kavMD5ZM
	OcvWHSpobr6AZ/7W2UyiKzZ77HU+kXl6J2OARq7groxDUo0/HWxzl698auBy5fi3m0lLulh2
	rz8dLe4/adeshDSlTFd/54jf9mVfI/Y8uaL9bfe5az8XHb36bKPO0RXuEqZ3kpo/W30X1ji/
	YmeEBpOmeL36ZQ3PZYtNNHuetS2QKlP+sLpNZDHzgSjpm7WNXzYcXVy1+I8Hv8LkDqW+s2Eb
	jPRPhu8NVWIpzkg01GIuKk4EAEX6XgRGAwAA
X-CMS-MailID: 20240903200655eucas1p2c0c78da561718236c76154df4425d0e5
X-Msg-Generator: CA
X-RootMTR: 20240629172448eucas1p2aa467bb71c25e118cada0adf9e43aa96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240629172448eucas1p2aa467bb71c25e118cada0adf9e43aa96
References: <CGME20240629172448eucas1p2aa467bb71c25e118cada0adf9e43aa96@eucas1p2.samsung.com>
	<20240629-sysctl-lockdep-v1-1-69196ce85225@weissschuh.net>

On Sat, Jun 29, 2024 at 07:24:31PM +0200, Thomas Weißschuh wrote:
> The assertions work as well as the comment to inform developers about
> locking expectations.
> Additionally they are validated by lockdep at runtime, making sure the
> expectations are met.

Sorry for the late reply (was in PTO). Will put this to sysctl-testing
so I can queue it for 6.13. It is a bit late to put it into 6.12.

Best and thx for the patch

-- 

Joel Granados

