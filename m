Return-Path: <linux-fsdevel+bounces-70658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A7CA3837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 12:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EDF3047647
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFD2F1FF4;
	Thu,  4 Dec 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YjJ/oomv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA919334C0B
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849522; cv=none; b=CqriPtUw3NpYL+GeTLXx/u84Xa5eS5YZS1w0dvPfDMkTYbMkKJkBLQjSySiVWIuG8KVvkz84o8H61WstgmNFEjQNICkb1l3zzwa3MR8wVDdQl8Y30BVZ1X0VA2wSu9HowpCE2AR4LPu7xBYH6qYCSCd1+KAiuv5EeH9C0KJmsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849522; c=relaxed/simple;
	bh=JuANSFxh/VPKXqNFnxDApb13qGnzHZ/SFN9viaspbcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OLlocOggmWyCG/gD35t+A/3UKPOvKnmkAV8pdnN+yj7rmRqlLImWfZU9Qf+P9vyUa2+iVsvZNsfK2vdUJQlFTSRAjicqSqEvIABsSkiu/uZj913/O4104RcWT0TWZ610xjkBmgPfdKERYcBHBEqhJvx7ZR/niwELMZ2ABfskDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YjJ/oomv; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251204115835epoutp03085b906713c5ed979560c8b051ac91f5~_AUi_t_Zb1273012730epoutp03P
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 11:58:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251204115835epoutp03085b906713c5ed979560c8b051ac91f5~_AUi_t_Zb1273012730epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764849515;
	bh=3wWMy2I7L9W3gKbAO25UJJg2lWlRN6z4rpA14p0f+88=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YjJ/oomv4uD9PWq6jvjSQXjKbIs8MYMLZCrWBRQjWMCL3hDYARphNWSrX2hwuqI7s
	 HhBtfoXPmbFNQyGlhLhlzj2rw1QF6IZnSQLE+OGqIHzsU1rER33vabdJ/0W5fWnYRJ
	 TGjAzBbeaZvIskAbD2Fm7puCfmlG1S+zwNJaCw7g=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20251204115835epcas1p359682f63231cd07bf5fe4c8982386cda~_AUiwccCA1471414714epcas1p3S;
	Thu,  4 Dec 2025 11:58:35 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.120]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dMY1l3KdPz6B9m6; Thu,  4 Dec
	2025 11:58:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251204115834epcas1p2ff5123e0d43fe249ace1c71c81feada5~_AUiGP2Rm2315023150epcas1p2R;
	Thu,  4 Dec 2025 11:58:34 +0000 (GMT)
Received: from [172.25.92.0] (unknown [10.246.9.208]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251204115834epsmtip104577396810b1eaf592de68c2c16c99d~_AUiBWoWu1461814618epsmtip1a;
	Thu,  4 Dec 2025 11:58:34 +0000 (GMT)
Message-ID: <5fa3c9d2-e77b-4cf9-95d2-f1fc0eb7292e@samsung.com>
Date: Thu, 4 Dec 2025 20:58:34 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: exfat: Fix corrupted error code handling in
 exfat_find_empty_entry()
To: Haotian Zhang <vulab@iscas.ac.cn>, linkinjeon@kernel.org,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Sungjong Seo <sj1557.seo@samsung.com>
In-Reply-To: <20251203070813.1448-1-vulab@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251204115834epcas1p2ff5123e0d43fe249ace1c71c81feada5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251203070828epcas1p219623b1095d4f34a5af5adada269b14f
References: <CGME20251203070828epcas1p219623b1095d4f34a5af5adada269b14f@epcas1p2.samsung.com>
	<20251203070813.1448-1-vulab@iscas.ac.cn>

Hi, Haotian,

On 25. 12. 3. 16:08, Haotian Zhang wrote:
> exfat_find_empty_entry() stores the return value of
> exfat_alloc_cluster() in an unsigned int. When
> exfat_alloc_cluster() returns a negative errno, it is
> converted to a large positive value, which corrupts
> error propagation to the caller.
Have you ever encountered an actual error?
IMO, due to implicit type conversion, it should work as follows,
so, I don't think there will be any real issues.

int -> unsigned int -> int

Anyway, it makes sense to modify the type of ret from unsigned int to int.
What about changing the title and comment?

Thanks.
SJ

> 
> Change the type of ret to int so that negative errno
> values are preserved.
> 
> Fixes: 5f2aa075070c ("exfat: add inode operations")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  fs/exfat/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index f5f1c4e8a29f..f2a87ecd79f9 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -304,8 +304,8 @@ static int exfat_find_empty_entry(struct inode *inode,
>  		struct exfat_chain *p_dir, int num_entries,
>  		struct exfat_entry_set_cache *es)
>  {
> -	int dentry;
> -	unsigned int ret, last_clu;
> +	int dentry, ret;
> +	unsigned int last_clu;
>  	loff_t size = 0;
>  	struct exfat_chain clu;
>  	struct super_block *sb = inode->i_sb;


