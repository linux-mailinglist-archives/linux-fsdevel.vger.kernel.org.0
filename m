Return-Path: <linux-fsdevel+bounces-70104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE0C90A75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1B2A34FF3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C48258CE7;
	Fri, 28 Nov 2025 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dmvdno8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BC8287E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298144; cv=none; b=fqw0VIAfOznsJH5ciOo6vUFGkqedxfLajkSCmfhfDRdaAfiLwGEy3g95yZQKYS/TdFhRXGSl/EwL9pgwzN6ZLpea0GDFrk3EmAr6+vrRqouhRu8+QM5KhBggEuhBOEtOHdVqI9JjFC5v3O+4Rw9czcVwT4mmrLx99p4RMQxW+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298144; c=relaxed/simple;
	bh=lNRTHU/Ua4C1NfgWsJfYOVAwl/ZkkIHkLBtxF+smni4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZnXY29//ENi5vNYJTwPKM3GYSYunmafsGNywkHZXcTTALa9NT+S5gplIbrtg48kzx/KZV08bTHXcVLlmx4JdT+LQFae4kW2f3eOSBJtOoyShigv60PyIM/ll3E0SR9UJB3gplozqtGfcvosB7OlLfmtn/mFBOCPo1vLC/JVZvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dmvdno8j; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251128024859epoutp013cc8200e01567dc5f1e975a592b1f537~8C8998jCi0884008840epoutp01Q
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 02:48:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251128024859epoutp013cc8200e01567dc5f1e975a592b1f537~8C8998jCi0884008840epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764298139;
	bh=eXe2ZqNy29W14N4F67ywIdgm6iniQKQRV2GI2taZ0pY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dmvdno8j6uQxFedm/ExtO18ZC8iM08bToiD/n90qTFnITnc4ADkJkZnXncx0/yT/k
	 bTM2KVsCihMS362/GpswzYBNZKTBCWpXuj+/KhM8IbFXM3l3uSIb87csJwEuCKuhoR
	 o6YV6NVeeT0F66d3K82nF2zYrsdrZwlMOnQeV3nk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20251128024859epcas1p2043f61cf7a67be5130c3c7c4d95ed135~8C89TAx4k0953109531epcas1p2c;
	Fri, 28 Nov 2025 02:48:59 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.194]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dHd6L6C5qz2SSKd; Fri, 28 Nov
	2025 02:48:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251128024858epcas1p1568808e628dde834aa5c3281bebc87ce~8C88puJY12239722397epcas1p16;
	Fri, 28 Nov 2025 02:48:58 +0000 (GMT)
Received: from [172.25.92.0] (unknown [10.246.9.208]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251128024858epsmtip1b5e289814346a020f255a74a531c0987~8C88hdN541617716177epsmtip1V;
	Fri, 28 Nov 2025 02:48:58 +0000 (GMT)
Message-ID: <5db1b061-56ef-4013-9d1e-aac04175aa8d@samsung.com>
Date: Fri, 28 Nov 2025 11:48:58 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] exfat: get mutil-clusters in exfat_get_block
To: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox
	<willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>, Yuezhang Mo
	<yuezhang.mo@sony.com>, Chi Zhiling <chizhiling@kylinos.cn>, Sungjong Seo
	<sj1557.seo@samsung.com>
Content-Language: en-US
From: Sungjong Seo <sj1557.seo@samsung.com>
In-Reply-To: <20251118082208.1034186-8-chizhiling@163.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251128024858epcas1p1568808e628dde834aa5c3281bebc87ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251118082625epcas1p44374f21201c10f1bb9084d2280e64e6d
References: <20251118082208.1034186-1-chizhiling@163.com>
	<CGME20251118082625epcas1p44374f21201c10f1bb9084d2280e64e6d@epcas1p4.samsung.com>
	<20251118082208.1034186-8-chizhiling@163.com>


Hi, Chi,
On 25. 11. 18. 17:22, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> mpage uses the get_block of the file system to obtain the mapping of a
> file or allocate blocks for writes. Currently exfat only supports
> obtaining one cluster in each get_block call.
> 
> Since exfat_count_contig_clusters can obtain multiple consecutive clusters,
> it can be used to improve exfat_get_block when page size is larger than
> cluster size.

I think reusing buffer_head is a good approach!
However, for obtaining multiple clusters, it would be better to handle
them in exfat_map_cluster.

> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>  fs/exfat/inode.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index f9501c3a3666..256ba2af34eb 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -264,13 +264,14 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>  static int exfat_get_block(struct inode *inode, sector_t iblock,
>  		struct buffer_head *bh_result, int create)
>  {
> +	struct exfat_chain chain;
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
>  	struct super_block *sb = inode->i_sb;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
>  	int err = 0;
>  	unsigned long mapped_blocks = 0;
> -	unsigned int cluster, sec_offset;
> +	unsigned int cluster, sec_offset, count;
>  	sector_t last_block;
>  	sector_t phys = 0;
>  	sector_t valid_blks;
> @@ -301,6 +302,17 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>  
>  	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>  	mapped_blocks = sbi->sect_per_clus - sec_offset;
> +
> +	if (max_blocks > mapped_blocks && !create) {
> +		chain.dir = cluster;
> +		chain.size = (max_blocks >> sbi->sect_per_clus_bits) + 1;

There seems to be an issue where the code sets chain.size to be one greater than the actual cluster count.

For example, assuming a 16KiB page, 512B sector, and 4KiB cluster,
for a 16KiB file, chain.size becomes 5 instead of 4.
Is this the intended behavior?

> +		chain.flags = ei->flags;
> +
> +		err = exfat_count_contig_clusters(sb, &chain, &count);
> +		if (err)
> +			return err;
> +		max_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;

You already said mapped_blocks is correct.

> +	}
>  	max_blocks = min(mapped_blocks, max_blocks);
>  
>  	map_bh(bh_result, sb, phys);


