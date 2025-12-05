Return-Path: <linux-fsdevel+bounces-70756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B686DCA6346
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 07:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F5930F1F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E126D4DF;
	Fri,  5 Dec 2025 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J/rDLmCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8B2EBDDE
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764914743; cv=none; b=QeK56xCfavfPjOEAUGMynznF9IOcX3N38wjTk+P2FQbu3T2QZdNmBpbD+f2Bi672q8LKWWCr7Yjkgjvt1JpabQBIbzGTAUpLw2J1LKUbXyDFdGxupQ3/6ugPZNsUw354HMIO41crtT3JITtX0i1CC4hHwozMphQAZu9k/5GtvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764914743; c=relaxed/simple;
	bh=iQqT1YfnSF+PVAsarfa8K/sQRgiyZyp4zAU8AafzvxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=IRTgfek/t+FKgiafWrCZ2qC/bPPOebQnMrcWi+hollNCrwge+qaP9wftVFGrqg4kilUgDlKZzQ43hkDjVQpbwjdRN2eK6N4fCP17Ai98Pjx54ywj07eG3fc70ylvG5EIhv3Z8MOYjzQRkrItd/Tk2FH/u7+pZamRf7G7pQOfero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J/rDLmCS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251205060538epoutp0284fe18e7be5e90e295106e4e3ae59d50~_PJp132tS2839928399epoutp02x
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 06:05:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251205060538epoutp0284fe18e7be5e90e295106e4e3ae59d50~_PJp132tS2839928399epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764914738;
	bh=0HCYnBvoqZ92l1CX8dpzhYVCv+vR4hZNunzee5qrVzE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J/rDLmCS78+BAi9MzFSyVITHd+4zTX9dwg/3d5H5Ykn89SYn7cpmCoYzRwObCvGyF
	 yemgPsNt77yUhmf4zkEdvoUnbvHUEY6JrDEUeHUTQUgxoZv/kCMxcgGDASF1SzUl7x
	 PjtOq+S8PSg9Ax3M11eJsaqpbnFd5sSDu8RfgQdM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20251205060537epcas1p136e32aa3ea9a95e31812c4d47a8367b0~_PJpfqfOW1981719817epcas1p1-;
	Fri,  5 Dec 2025 06:05:37 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.114]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dN1814K7Dz6B9mR; Fri,  5 Dec
	2025 06:05:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251205060537epcas1p1b0ddc2ccd96071cbec445c34497c88ae~_PJo8Jn1U2451924519epcas1p1T;
	Fri,  5 Dec 2025 06:05:37 +0000 (GMT)
Received: from [172.25.92.0] (unknown [10.246.9.208]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251205060536epsmtip2722ec08310b04d04d2e887f10499b937~_PJo0CU3R0291202912epsmtip2M;
	Fri,  5 Dec 2025 06:05:36 +0000 (GMT)
Message-ID: <3f846d9a-72b7-49bf-922e-b75938ddbf8b@samsung.com>
Date: Fri, 5 Dec 2025 15:05:36 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: exfat: improve error code handling in
 exfat_find_empty_entry()
To: Haotian Zhang <vulab@iscas.ac.cn>, linkinjeon@kernel.org,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Sungjong Seo <sj1557.seo@samsung.com>
In-Reply-To: <20251205015904.1186-1-vulab@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251205060537epcas1p1b0ddc2ccd96071cbec445c34497c88ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251205015927epcas1p4b0d227e69d121ea76df6ac97a9754c5f
References: <20251203070813.1448-1-vulab@iscas.ac.cn>
	<CGME20251205015927epcas1p4b0d227e69d121ea76df6ac97a9754c5f@epcas1p4.samsung.com>
	<20251205015904.1186-1-vulab@iscas.ac.cn>



On 25. 12. 5. 10:59, Haotian Zhang wrote:
> Change the type of 'ret' from unsigned int to int in
> exfat_find_empty_entry(). Although the implicit type conversion
> (int -> unsigned int -> int) does not cause actual bugs in
> practice, using int directly is more appropriate for storing
> error codes returned by exfat_alloc_cluster().
> 
> This improves code clarity and consistency with standard error
> handling practices.
> 
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

The patch looks good to me:

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

>  	loff_t size = 0;
>  	struct exfat_chain clu;
>  	struct super_block *sb = inode->i_sb;


