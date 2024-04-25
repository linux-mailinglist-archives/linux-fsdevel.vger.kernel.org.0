Return-Path: <linux-fsdevel+bounces-17717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F78B1AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415EA1F2397E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976440848;
	Thu, 25 Apr 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MmLBPRqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BB249F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 06:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026187; cv=none; b=Fm9UPDAKkz5TKk5cA3bXPYAqbFN5mYSt7sKXlPiB39NEztXT5GYPVshVKXiz/Hj8Pdngyp52n3v4UrPglV34OLIpu8y7TJ+XkGFQ1vLx15H35l4dyj5jOkNCS2HDWOecJtgFqVjuENWtVo2HK07vTKh16opwEDQ5SD6IKFjN3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026187; c=relaxed/simple;
	bh=8Uk58k4XvNVSStaZNK4LeoIHwoTM64TWPMn8TT3Pe98=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=dB+bPenZUti0AEfseFhS4FtXuh2oWfB9+dIH3q1nQWpyC2yjXdesUgDYveq3exoACxVAw/G+bd5ArHwbatbNzQMCvvhgTrarjNA9ilfb8Y4IiCBunknCuwq6pZQD2g1yfNzd/T5pn4Kd9ZPpjpGl9NGxeZi19U6dynRG8GuIg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MmLBPRqo; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240425062302epoutp04656bc63aa586b800663248884aa99588~JcbtWuWEe2415724157epoutp04E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 06:23:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240425062302epoutp04656bc63aa586b800663248884aa99588~JcbtWuWEe2415724157epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714026182;
	bh=ClhoynmTf50L+cNZlKq+JtURB5Xf7y1weX/+eGo/eUk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=MmLBPRqoFw5GUNGFs8clWM1o5IFwE09OAxlNziZ6cAqlk71tJx0P0e3cTocQzDuwC
	 TL90+c8QpyCroL5U0CMZMU1yDQvD28M9HG+hxAXwlBp7EtOXO3PZPbKkE1e2sV0GKb
	 6NfkBGGBGrrQYxzqW0EUcYhwUE+Q8Mo5VXbJRjWU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240425062301epcas1p234eb8b34778c4fb99679abdf5429610c~Jcbsrt4OK1990819908epcas1p27;
	Thu, 25 Apr 2024 06:23:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
	(Postfix) with ESMTP id 4VQ5Px66hpz4x9QQ; Thu, 25 Apr 2024 06:23:01 +0000
	(GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240425061510epcas1p17017c6888b9757c0045c4c43dd73aa24~JcU12SO2N1872618726epcas1p1-;
	Thu, 25 Apr 2024 06:15:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240425061510epsmtrp13a882c3cc969d29c05d1c78d38d4887f~JcU11XMC02771627716epsmtrp1n;
	Thu, 25 Apr 2024 06:15:10 +0000 (GMT)
X-AuditID: b6c32a29-659ff700000022dc-e5-6629f4eec4a2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.07.08924.EE4F9266; Thu, 25 Apr 2024 15:15:10 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240425061510epsmtip2d2855f1b5bc39b3b458f41b7dc010cfb~JcU1rc8SD0986209862epsmtip2F;
	Thu, 25 Apr 2024 06:15:10 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Andy.Wu@sony.com>,
	<Wataru.Aoyama@sony.com>, <cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB6316FDC76BB5D2818276D39581172@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2] exfat: zero the reserved fields of file and stream
 extension dentries
Date: Thu, 25 Apr 2024 15:15:09 +0900
Message-ID: <664457955.21714026181854.JavaMail.epsvc@epcpadp4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK7TIjjNDsraPzDzt/AjWPV+NLN4gIxZg2mr6WK9TA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvO67L5ppBt92qlq0HtnHaPHykKbF
	xGlLmS327D3JYrHl3xFWi48PdjNaXH/zkNWB3WPTqk42j74tqxg92ifsZPb4vEkugCWKyyYl
	NSezLLVI3y6BK+PHvUVMBfv5K9b1/2BsYDzF08XIySEhYCKx7MQhti5GLg4hgd2MEt/3XWLv
	YuQASkhJHNynCWEKSxw+XAxR8pxRYvLOc2wgvWwCuhJPbvxkBrFFBEwlvlw+ARZnFmhnlHj3
	LRaiYR2jxNtZq8BmcgrESkyaow1SIwxkHpm4jR3EZhFQldj+9j1YL6+ApcTvi41MELagxMmZ
	T1hAWpkF9CTaNjJCjJcHKp/DDHG+gsTuT0dZIU6wkrjc1Q5VIyIxu7ONeQKj8Cwkk2YhTJqF
	ZNIsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx46W5g7G7as+6B1iZOJg
	PMQowcGsJMJ786NGmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZ
	Jg5OqQYmm8/b/dkcY2fx+O7SEHjdc17z+KWy3rcHl0svSDt1VOi4wD3nt6+e8c+fOcdyufjx
	9v/t+QK/kt5NZMh+Knj8/pupCW8aqwvuNnR+eZh2MkhCT7e0Woan/rtH6IKzs35rTTKNF1ty
	XPn1tGqHd60rLOImZuQ0tmaX71h4s/sEf1Vcc/aF/YeLn/9O++GffTVOMPnD1NLlWrUXb5tY
	Lpv966Dy7KXdhzK9r+zmuagxfW2IX7X5hilqDxQFlTZe36jH/1PavWIDm2Mpp4ShzuplfAeV
	zVee814j5BW9+MLXAEnLY7Xfv7g21v7dz6nQsNNPP9HAqbFQY9/zHkVOX3vTqrKQuAKdrP1P
	5Gb8sWtRYinOSDTUYi4qTgQAYYIDAQwDAAA=
X-CMS-MailID: 20240425061510epcas1p17017c6888b9757c0045c4c43dd73aa24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20240425045525epcas1p1052d7d89d9ced86a34dbe5f6a7dcad39
References: <CGME20240425045525epcas1p1052d7d89d9ced86a34dbe5f6a7dcad39@epcas1p1.samsung.com>
	<PUZPR04MB6316FDC76BB5D2818276D39581172@PUZPR04MB6316.apcprd04.prod.outlook.com>

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
> So this commit initializes the dentry to 0 before createing file
> dentry and stream extension dentry.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>

Looks good. Thanks for your patch.
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 077944d3c2c0..84572e11cc05 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -420,6 +420,7 @@ static void exfat_set_entry_type(struct exfat_dentry
> *ep, unsigned int type)
>  static void exfat_init_stream_entry(struct exfat_dentry *ep,
>  		unsigned int start_clu, unsigned long long size)
>  {
> +	memset(ep, 0, sizeof(*ep));
>  	exfat_set_entry_type(ep, TYPE_STREAM);
>  	if (size == 0)
>  		ep->dentry.stream.flags = ALLOC_FAT_CHAIN;
> @@ -457,6 +458,7 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache
> *es,
>  	struct exfat_dentry *ep;
> 
>  	ep = exfat_get_dentry_cached(es, ES_IDX_FILE);
> +	memset(ep, 0, sizeof(*ep));
>  	exfat_set_entry_type(ep, type);
>  	exfat_set_entry_time(sbi, ts,
>  			&ep->dentry.file.create_tz,
> --
> 2.34.1



