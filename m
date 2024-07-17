Return-Path: <linux-fsdevel+bounces-23870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37309342D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 21:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAB81F2330E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090F1849E7;
	Wed, 17 Jul 2024 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D4OQbpZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB2183065
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245597; cv=none; b=OUPHe/KWlR/zYTevz73NDEG3Ie0JY3hiiiJTIBBek4ifEk3Ge0NWuA7+pMXLE0E+BIbQ1pDKcWjJrTNwE4WAs2n1WN/InLa6kU9+7CywmoVQvGQBrLtDhH26h9BJzkzCsERAA/KFrR222qmxIdhzJjd6kUIycyW8ttXqe+j8wh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245597; c=relaxed/simple;
	bh=JLUxooAVyczKnjAl4l4+mvBTLVK3cRY5cPWG8si1xk8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=NXOL6uvusX9C6SxclWO8M7Aa8GEbVpVqsjp1r7s4cTuwUP3hVraIuLMvdwtJ+605B+In1Q+QxXyZpe7t8FBwADh+2UgoOhyaG16i0AEoB84rwM5WOOvsmaGCRF3Gy+/eeJd3i3r1WK+tgCNEcizcbfqLCGJO3yGtWIkgCtGfRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=D4OQbpZJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240717194626euoutp01cc17e25995eb24ea315779765f8c1d16~jF73hWpke1762117621euoutp015
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 19:46:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240717194626euoutp01cc17e25995eb24ea315779765f8c1d16~jF73hWpke1762117621euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721245586;
	bh=TyWmmear4ELBh0zGnK/duEOPsPXuw4ydvJWqJGZZ4lc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=D4OQbpZJZMN0r/qLKItU52L/4sTwmp29nKTRnnFidLx7PAZEB5mn1rnXw1G1GsNJo
	 iM/3qfO+Yg9f835nTtqYzvirkSEEK1NiToah/rx3gJYWEo8xElEus3HgD+XUmZzsVx
	 dXfsMoabvMWbWqyuz+MO05uk5FmnmYwJZypmIYDg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240717194626eucas1p223f64e6bace4717c599904ba8b3c5d51~jF73BUoTR1140211402eucas1p2x;
	Wed, 17 Jul 2024 19:46:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A7.74.09624.29F18966; Wed, 17
	Jul 2024 20:46:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240717194625eucas1p2f5000d5eb7bd371189251f8fb4d0fbaa~jF72m5XDh1141811418eucas1p20;
	Wed, 17 Jul 2024 19:46:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240717194625eusmtrp2f0c1e59651cb9034baad71ab037b9643~jF72mXMN91823118231eusmtrp2Z;
	Wed, 17 Jul 2024 19:46:25 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-10-66981f925b58
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.1B.09010.19F18966; Wed, 17
	Jul 2024 20:46:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240717194625eusmtip2b8ee898e38b72cd75bc0b3f89f20fc43~jF72ZXvlo1241212412eusmtip2W;
	Wed, 17 Jul 2024 19:46:25 +0000 (GMT)
Received: from localhost (106.210.248.174) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Jul 2024 20:46:25 +0100
Date: Wed, 17 Jul 2024 21:46:20 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <kees@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Thomas
	=?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Wen Yang
	<wen.yang@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] sysctl changes for v6.11-rc1
Message-ID: <20240717194620.mx7hbefl2pxd34rv@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202407161108.48DCFCD7B7@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87qT5GekGRx4xWux7u15Vos9e0+y
	WFzeNYfN4vePZ0wWNyY8ZbRo3HKX1eJR31t2i/dr7rM6cHhsWtXJ5nFixm8Wj4UNU5k9Ju6p
	8/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfGtamT2Auuc1R0bGlibGB8z9bFyMkhIWAi8W/m
	M/YuRi4OIYEVjBKtu04xQjhfGCUm7tjFCuF8ZpTYMPsaO0xL2+75LBCJ5YwS/7ZMYYOrOty4
	HqplK6PEheXbwbawCKhKfLzXDdbOJqAjcf7NHWYQW0RAXmLHvC/MIA3MAkuYJLrf7QQrEgba
	sWvORBYQm1fAQaJv+T42CFtQ4uTMJ2BxZgFNidbtv4HqOYBsaYnl/zggwvISzVtng83nFNCX
	OLD4HNTZyhLvH+xjgbBrJdYeOwP2tYRAM6dE3+znTBAJF4kp29ZAFQlLvDq+BapZRuL/zvlM
	EA2TGSX2//sA1b2aUWJZ41eobmuJlitPoDocJVo6frKCXCchwCdx460gxHV8EpO2TWeGCPNK
	dLQJTWBUmYXktVlIXpuF8NosJK8tYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZic
	Tv87/mkH49xXH/UOMTJxMB5ilOBgVhLhncA4LU2INyWxsiq1KD++qDQntfgQozQHi5I4r2qK
	fKqQQHpiSWp2ampBahFMlomDU6qBSeroCXOGd52amy6xhrhlBV30ma0/wTXiZdvaM2uiki/t
	Zok6MVtxecqPzap73bcG7r0YLOPh/8K2/WvRk38b5cL0X1wR+9qnrLg1PHDW4uCHIub5Uxp/
	bpVOSojg5Jc/NP/RXqYzNYvUde/7Hev4+yzXsvxb36LmWalXtv69b7Flgk0xR7NYYt/V+ztM
	2BtvMpx8N+N1x3avT0fPZNi9eP97pV/9qiW5IVGphxfLznt5eNHaug+LnBKajjRbH1vR/+fq
	tbOBZzQUTA7YS1V/UTp3+d2sC7K20RsW9zK1ts2ss018eezEkyu6omKHNH8kTfTp9fm78+b8
	7BOyV6X3rs85eZ9L/uNKU44O9cwe9jQlluKMREMt5qLiRABpv5c8vQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7oT5WekGVz8r2+x7u15Vos9e0+y
	WFzeNYfN4vePZ0wWNyY8ZbRo3HKX1eJR31t2i/dr7rM6cHhsWtXJ5nFixm8Wj4UNU5k9Ju6p
	8/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
	Zllqkb5dgl7GtamT2Auuc1R0bGlibGB8z9bFyMkhIWAi0bZ7PksXIxeHkMBSRokLLSeZIRIy
	Ehu/XGWFsIUl/lzrYoMo+sgocf1SExOEs5VR4sOO52BVLAKqEh/vdbOD2GwCOhLn39wBmyQi
	IC+xY94XZpAGZoElTBIrFp8FKxIG2r1rzkQWEJtXwEGib/k+qBU7GSXeT3nKCJEQlDg58wlY
	EbOApkTr9t9AzRxAtrTE8n8cEGF5ieats8GWcQroSxxYfI4d4mxlifcP9rFA2LUSr+7vZpzA
	KDILydRZSKbOQpg6C8nUBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjd9uxn1t2MK58
	9VHvECMTB+MhRgkOZiUR3gmM09KEeFMSK6tSi/Lji0pzUosPMZoCw2gis5Rocj4wdeSVxBua
	GZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTClN2916dvDPi3ce9FyBX7u
	0+4L9+4qrfnaJf2zvPfbF9Hrhnc41Yzms19S04rdnJnbFDpV4/1Cq3LV8ItuMb9OT+zbddXy
	T1Pw7XMHdO8c8r6+Z0fBp1iW6hYbHZ1nflMqFyVWsbTOLI9Zv4pRzXLtEvc1v/oXCiueTrzw
	K1z/THi+olRCTynHGs9y89LYqEdxygLeDP43Nzz4wJR7787CFwEF2Wdmltr0v38+Z+bCRdoV
	ovMvJ20oc41dxarGwJ/6srfy34mXfp2rfri67wvbKqevVMMqqtA97+uToO0lGY5tzzLZVTVm
	rGxv+bvzZej0MxXPCk8+6GotfsNwr2iPO/+PHV/VLKxNPn2asEWJpTgj0VCLuag4EQCtxZMO
	ZQMAAA==
X-CMS-MailID: 20240717194625eucas1p2f5000d5eb7bd371189251f8fb4d0fbaa
X-Msg-Generator: CA
X-RootMTR: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6
References: <CGME20240716141703eucas1p2f6ddaf91b7363dd893d37b9aa8987dc6@eucas1p2.samsung.com>
	<20240716141656.pvlrrnxziok2jwxt@joelS2.panther.com>
	<202407161108.48DCFCD7B7@keescook>

On Tue, Jul 16, 2024 at 11:13:24AM -0700, Kees Cook wrote:
> On Tue, Jul 16, 2024 at 04:16:56PM +0200, Joel Granados wrote:
> > * Preparation patches for sysctl constification
> > 
> >     Constifying ctl_table structs prevents the modification of proc_handler
> >     function pointers as they would reside in .rodata. The ctl_table arguments
> >     in sysctl utility functions are const qualified in preparation for a future
> >     treewide proc_handler argument constification commit.
> 
> And to add some additional context and expectation setting, the mechanical
> treewide constification pull request is planned to be sent during this
> merge window once the sysctl and net trees land. Thomas Weißschuh has
> it at the ready. :)

Big fan of setting expectations :). thx for the comment.
Do you (@kees/ @thomas) have any preference on how to send the treewide
const patch? I have prepared wording for the pull request for when the
time comes next week, but if any of you prefer to send it through
another path different than sysctl, please let me know.

Best

-- 

Joel Granados

