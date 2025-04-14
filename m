Return-Path: <linux-fsdevel+bounces-46363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E521A87EFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8D0174136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3128151F;
	Mon, 14 Apr 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lSbII1GB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041117A2FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630050; cv=none; b=Igz2Lbf68sEYwuLCJI9aPrzlXhalJYJIGcC0jgg9WFHloVdh/sPj/8/9Di8QNiX4nELR8iyr/0jt5OeE6U3GWmegAc0McNpgVx9uC1E4gNR9hHvUFb6l644mLPgs9TnmUavl2yjPrEeoz53jl9G1q7Ow7xQaP9FZTzEqLnaP58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630050; c=relaxed/simple;
	bh=xbQWf/VkhNGAWA/mZvmec+MOO1vOqL2vWg93FRDcIjM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=pyRJWjZcserUtpGz8HjoYPLyaYDRNod0UKEiiuDbMLlq6owdrKiZu+bUiZfsVk978cQKYe6WkC8ReX1fxkCXo4nKcbbSCRM/YVD6Lou9PGx7+XaC6vUHQAHNdG0UMmYJg3qvBIecKHIY7o0yEpJBAt0tdJ2iTODjDv66VrJogxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lSbII1GB; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250414112725epoutp02085e9c6b0ff4c7b4850c7c08ea0bac47~2K8huvhqY1181211812epoutp02d
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 11:27:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250414112725epoutp02085e9c6b0ff4c7b4850c7c08ea0bac47~2K8huvhqY1181211812epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744630045;
	bh=HbJQcRy1JO3zDC6elNb0OvSbt2iGYkDLbKWsY5Yp6y8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lSbII1GBS7YzaFJ50nTmGnIp5DvoY/j61E0rGXHLOUXpouPqGOb9vLptYi3wg1mRr
	 GlG9THs05r2bKvEanms3ob/PI1LDvS0i8QOTjoYc73FTSYSnyQ614o33fOmsUFp+LE
	 GjlRjo4BI1cwVsbEvE9Kdrqe86GKBwmfO1J+9Uuo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20250414112724epcas1p1b2c2db1a8416503774d98de80dcd33f4~2K8gqUZrV0704707047epcas1p1J;
	Mon, 14 Apr 2025 11:27:24 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.226]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZblPm03L8z3hhT9; Mon, 14 Apr
	2025 11:27:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.DB.10191.B11FCF76; Mon, 14 Apr 2025 20:27:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250414112723epcas1p17c52e01acd6b618a192e1371fb8eb710~2K8fmQvhk2158521585epcas1p1l;
	Mon, 14 Apr 2025 11:27:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250414112723epsmtrp21e128e416233932dcd81eb7ceec4d555~2K8flpuOy2154021540epsmtrp2D;
	Mon, 14 Apr 2025 11:27:23 +0000 (GMT)
X-AuditID: b6c32a39-42cce700000027cf-36-67fcf11be742
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.8A.07818.B11FCF76; Mon, 14 Apr 2025 20:27:23 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250414112723epsmtip290c921ee026c0c04cbcf1bde58a03ed1~2K8faIzhy0612806128epsmtip2J;
	Mon, 14 Apr 2025 11:27:23 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <sjdev.seo@gmail.com>,
	<cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB631655CE7BEB6B2E4F6E7AC681B32@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] exfat: do not clear volume dirty flag during sync
Date: Mon, 14 Apr 2025 20:27:23 +0900
Message-ID: <14d6a01dbad30$311951e0$934bf5a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMttRtk+TDXeSz+m0TFvc+bKFlw/QIyCKQCAXpUAfACjG4R27DNLRug
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmga70xz/pBp9mWFq8PKRpMXHaUmaL
	PXtPslhs+XeE1eLFhw1sFtffPGR1YPPYOesuu8emVZ1sHn1bVjF6tE/YyezxeZNcAGtUA6NN
	YlFyRmZZqkJqXnJ+SmZeuq1SaIibroWSQkZ+cYmtUrShoZGeoYG5npGRkZ6pUayVkamSQl5i
	bqqtUoUuVK+SQlFyAVBtbmUx0ICcVD2ouF5xal6KQ1Z+KcjVesWJucWleel6yfm5SgpliTml
	QCOU9BO+MWZMfn+KqeAPS8WC57/YGxg/MncxcnJICJhIrH78mamLkYtDSGAHo8STN2egnE+M
	EsueHWKFcL4xShzraQJyOMBapt8Xg4jvZZT4u+oiG4TzklFi7pQr7CBz2QR0JZ7c+Am2Q0TA
	WKJ/6yxWEJtZIEti2c+/bCA2p0CsxItpP5hAbGEBT4nD05+AxVkEVCX+XdsEFucVsJJo2vGY
	EcIWlDg58wkLxBx5ie1v50D9oCCx+9NRVohdbhJn1n1mgqgRkZjd2QZV08shceqxFYTtInFi
	TRMbhC0s8er4FnYIW0ri87u9YM9ICHQzShz/+I4FIjGDUWJJhwOEbS/R3NrMBgoJZgFNifW7
	9CF28Um8+9rDClHCK9Gw8TfUTEGJ09e6mSEBxyvR0SYEEVaR+P5hJ8sERuVZSD6bheSzWUg+
	mIWwbAEjyypGsdSC4tz01GLDAlPk+N7ECE6yWpY7GKe//aB3iJGJg/EQowQHs5IIL5fzr3Qh
	3pTEyqrUovz4otKc1OJDjMnAsJ7ILCWanA9M83kl8YZmZpYWlkYmhsZmhoaEhU0sDUzMjEws
	jC2NzZTEefd8fJouJJCeWJKanZpakFoEs4WJg1OqgelQ2Lc1GhK7M9g8eFZvmX4l+fzMORIs
	tTePftp3fOJzwYqboSv0Tft6XI7Jq/gtX1/rbSf1ZNcKrg+8J6eIzmzf9bbrzmP5K6LlR83c
	ixxu93Bd2S8jtCNx1ebW7HsPC3r9X/JLd73+af4mqOZ+0SFJM53MHSYvnphf/fCjUsxuq0mx
	9cLKnCgmfZNbS94sFzh+SSXzpes8ptJarfIsm7MHSu/Mb3JwnPE/LVRkXinPt/zyNI+vl5ao
	8ER8zpHPnhntvfznlY1TPohkJbxWdXP0cy/dfl/L1skpgKV8e82E7ru6lpmMXPs6LjJwPi5z
	XZnUy+fF0/hdnu3mboWGoNSC+68trpVcbexTzzxbqsRSnJFoqMVcVJwIABHtOlFpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvK70xz/pBv/XsFu8PKRpMXHaUmaL
	PXtPslhs+XeE1eLFhw1sFtffPGR1YPPYOesuu8emVZ1sHn1bVjF6tE/YyezxeZNcAGsUl01K
	ak5mWWqRvl0CV8bk96eYCv6wVCx4/ou9gfEjcxcjB4eEgInE9PtiXYxcHEICuxkl1p/8wQQR
	l5I4uE8TwhSWOHy4GKLkOVDJ+8mMXYycHGwCuhJPbvxkBrFFBEwlvlw+wQZiMwvkSWy/t5AN
	omEdk8STM/2sIAlOgViJF9NA5nNyCAt4Shye/gSsgUVAVeLftU1gcV4BK4mmHY8ZIWxBiZMz
	n7BADNWTWL9+DiOELS+x/e0csMUSAgoSuz8dZYU4wk3izLrPTBA1IhKzO9uYJzAKz0IyahaS
	UbOQjJqFpGUBI8sqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzg+NHS2MH47luT/iFG
	Jg7GQ4wSHMxKIrxczr/ShXhTEiurUovy44tKc1KLDzFKc7AoifOuNIxIFxJITyxJzU5NLUgt
	gskycXBKNTCZRmV/yLNLKa23U9vu8y5R/spirgkbz+fq8vtJutU/Xbo1waDz6j6Fjk/1fclm
	fce3HVuyW0o1MCV350rLAzWh60JT3PwyjDyk97Gf9NohNGnSukXvGh4Xtx6ZZf6RsdU9Ylr0
	k8KVs50dZv93P/LG8W5Qhv+BNDFt3pWPr9rtzr+gJDM3T0rk0dNjTRLLdk/5pnem9fTJTcfF
	bh772BnVWL6yu8pJPmfDk2NmwPSzZsLGqvevH1SctWNpubZ6Netfu5/K5tq//jy7uDLiy7KO
	rTumLJU/e2fa9+27k6f+rqp2EHixplGj5cWfkKvll1iUAhNVX4Ssrz/Ws/7MTl/GVXHr/3G1
	Xkxa5fqsKfObEktxRqKhFnNRcSIAtadaew4DAAA=
X-CMS-MailID: 20250414112723epcas1p17c52e01acd6b618a192e1371fb8eb710
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250410094112epcas1p42245e765dbdc61c0c9da40884386bbf9
References: <CGME20250410094112epcas1p42245e765dbdc61c0c9da40884386bbf9@epcas1p4.samsung.com>
	<PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>
	<12bf001dbac33$7b378fb0$71a6af10$@samsung.com>
	<PUZPR04MB631655CE7BEB6B2E4F6E7AC681B32@PUZPR04MB6316.apcprd04.prod.outlook.com>

> Hi Sungjong,
> 
> > However, it seems that a modification is also needed to keep the state
> > dirty if it is already dirty at the time of mount, as in the FAT-fs
> below.
> > commit b88a105802e9 ("fat: mark fs as dirty on mount and clean on
> umount")
> >
> > Could you send additional patches along with this patch as a series?
> 
> This is already supported by the commit.
Oh, sorry about that. I must have misread the code.
If so, your patch moving to put_super is enough.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> 
> 7018ec68f082 (tag: exfat-for-5.9-rc1) exfat: retain 'VolumeFlags'
properly.



