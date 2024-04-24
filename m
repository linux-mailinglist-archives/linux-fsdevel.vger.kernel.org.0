Return-Path: <linux-fsdevel+bounces-17604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B869B8B009E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 06:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A063B21CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 04:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4247152DE3;
	Wed, 24 Apr 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LYy9NT/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E7028EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933313; cv=none; b=pXRItlEKc4CkPfT7SEqw3MZIqPunxb/2CnbSuS7z9tueug/QM2EupGCJakWHZ2jSsEubNPsYQ11O/vNKpFvpj3NPK9dOJTeM1wIE1yKPzZ7Lz/McJLa3z17Wm6vd09wmwgQ05nx+0f6gmJbFYffXjmUNTukXD1ZR4ZULeFogcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933313; c=relaxed/simple;
	bh=nRIlR3YY0/EXo2YWJ7vYwJVLixWDLqgHflBXoYuhvpI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=pt/eflWoWgROTwCHG5V9H99+sdT5vNQeiSb8G+D/DV5Z4GojsGHUi+kP5E3dSdKRFX7yo9Al7Ir2YRXAIba4dols/2zzRI9KlSQT8KjRPa+TWSdfaB4wsLa/HSDJBTsvN2T/8rbiInPTCx6HJz0wCCHYh3jXqgYUP2OS1yaEKm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LYy9NT/n; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240424043502epoutp01f0e28cb7baeb540c4897551a532d9cd1~JHUIDYVHy2463324633epoutp01q
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 04:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240424043502epoutp01f0e28cb7baeb540c4897551a532d9cd1~JHUIDYVHy2463324633epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713933302;
	bh=GRx4dAvvfNXS0Tb8wvoOFG2WOcplrAX0F1UjzsY8W0k=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=LYy9NT/nRGpEnV8WYMo/ZWn0bFOruSohaPdJvhKqjaRksHRhjv+xZtId4IPr50MHg
	 jwrIV8AC6nIPv5zuJriqhkR4N2OxKGmyv64lVR1YoTynXitKIC8EL9EkAqEW6xFM28
	 GKA7age+4RUVceRvC1T0le4S3tucVeG70aYv8dic=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240424043502epcas1p11a7590c18f190d9c63a92441291cfa2b~JHUHml5zr3007430074epcas1p1P;
	Wed, 24 Apr 2024 04:35:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4VPR3p0F1Xz4x9Qc; Wed, 24 Apr 2024 04:35:02 +0000
	(GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240424022323epcas1p35a4abc34ca3f84d48557310c60326c0e~JFhLzq8CX0678506785epcas1p3C;
	Wed, 24 Apr 2024 02:23:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424022323epsmtrp1bd153e3e18c9dc6729aa6427cc478d4f~JFhLy-YBR1710617106epsmtrp1K;
	Wed, 24 Apr 2024 02:23:23 +0000 (GMT)
X-AuditID: b6c32a28-0ebf970000001d75-36-66286d1b4a7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.68.07541.B1D68266; Wed, 24 Apr 2024 11:23:23 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240424022323epsmtip258e8e42c68c661beff283c7ae1fbfcbf~JFhLlhb412386623866epsmtip2E;
	Wed, 24 Apr 2024 02:23:23 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB63168EFB1C670A913C42E80981112@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] exfat: zero the reserved fields of file and stream
 extension dentries
Date: Wed, 24 Apr 2024 11:23:22 +0900
Message-ID: <1891546521.01713933302009.JavaMail.epsvc@epcpadp3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIYb7jVRJLYLEtRTVxvT7Lp6UXOnAHATqsHsOz1DqA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvK50rkaawZxmbYvWI/sYLV4e0rSY
	OG0ps8WevSdZLLb8O8Jq8fHBbkaL628esjqwe2xa1cnm0bdlFaNH+4SdzB6fN8kFsERx2aSk
	5mSWpRbp2yVwZbRufcNScEyoYtfE9awNjD38XYycHBICJhLts18wdTFycQgJ7GaU6DndxN7F
	yAGUkJI4uE8TwhSWOHy4GKLkOaPEn08bWUF62QR0JZ7c+MkMYosImEp8uXyCDcRmFmhnlHj3
	LRaiYR2jxL0V98ESnAKxEj9evGYHsYWB7GM9t5hBFrAIqEosvZoMYvIKWEr8n10LUsErIChx
	cuYTFpAws4CeRNtGRojp8hLb385hhrheQWL3p6OsEBdYSTRsu88MUSMiMbuzjXkCo/AsJJNm
	IUyahWTSLCQdCxhZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBEeOlsYOxnvz/+kd
	YmTiYDzEKMHBrCTC++uPSpoQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1ML
	UotgskwcnFINTBOuHvj+93foxnWzeWy/nI8KePti6U/1mP3HXIVLMpTVhaS2b/3VyitxyF05
	5rWdi3mQrVLg2YcPeK+FVkgeSTjO3Z77aILS1wzRNef38u+vOeZ638I0JDp83h/pzbvMSsIn
	79JneOo4bceaL8v+quwWsV/7JKFSIKujuF13+rGUH7e3W/9bJBoV4ndhUXfjuu8hYR3LMw43
	arhdamN5odF0fuoqtjdpwkH9c+yMpn4SmMm93/hNgv9BwY0+C+SCJGdu/dkpPl1DTGzGkrOi
	vFsNlI849hh8PVT8U/b3wknJmU1V65dnXjy26eh2/8ofnibc4kcNZvh7eHlc/ZDSphwSXfN4
	neEryYgdb2v0piixFGckGmoxFxUnAgD7W5uoCwMAAA==
X-CMS-MailID: 20240424022323epcas1p35a4abc34ca3f84d48557310c60326c0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20240423022908epcas1p2e3f94bde4decfd8dca233031f0177f58
References: <CGME20240423022908epcas1p2e3f94bde4decfd8dca233031f0177f58@epcas1p2.samsung.com>
	<PUZPR04MB63168EFB1C670A913C42E80981112@PUZPR04MB6316.apcprd04.prod.outlook.com>

> From exFAT specification, the reserved fields should initialize
> to zero and should not use for any purpose.
> 
> If create a new dentry set in the UNUSED dentries, all fields
> had been zeroed when allocating cluster to parent directory.
> 
> But if create a new dentry set in the DELETED dentries, the
> reserved fields in file and stream extension dentries may be
> non-zero. Because only the valid bit of the type field of the
> dentry is cleared in exfat_remove_entries(), if the type of
> dentry is different from the original(For example, a dentry that
> was originally a file name dentry, then set to deleted dentry,
> and then set as a file dentry), the reserved fields is non-zero.
> 
> So this commit zeroes the reserved fields when createing file
> dentry and stream extension dentry.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> ---
>  fs/exfat/dir.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 077944d3c2c0..cbdd9b59053d 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -428,6 +428,10 @@ static void exfat_init_stream_entry(struct
> exfat_dentry *ep,
>  	ep->dentry.stream.start_clu = cpu_to_le32(start_clu);
>  	ep->dentry.stream.valid_size = cpu_to_le64(size);
>  	ep->dentry.stream.size = cpu_to_le64(size);
> +
> +	ep->dentry.stream.reserved1 = 0;
> +	ep->dentry.stream.reserved2 = 0;
> +	ep->dentry.stream.reserved3 = 0;

The comment explains the problem well! And the patch you just sent
seems to solve the mentioned problem.

BTW, what about initializing the entire ep (fixed size of 32 bytes)
to 0 before setting the value of ep in each init function? This is the
simplest way to ensure that all other values are zero except for the
intentionally set value.

>  }
> 
>  static void exfat_init_name_entry(struct exfat_dentry *ep,
> @@ -474,6 +478,9 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache
> *es,
>  			&ep->dentry.file.access_date,
>  			NULL);
> 
> +	ep->dentry.file.reserved1 = 0;
> +	memset(ep->dentry.file.reserved2, 0, sizeof(ep-
> >dentry.file.reserved2));
> +
>  	ep = exfat_get_dentry_cached(es, ES_IDX_STREAM);
>  	exfat_init_stream_entry(ep, start_clu, size);
>  }
> --
> 2.34.1



