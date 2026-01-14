Return-Path: <linux-fsdevel+bounces-73528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B8D1C351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 04:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90154301050E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 03:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA3322C99;
	Wed, 14 Jan 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LyGJPatM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15AB221F0C;
	Wed, 14 Jan 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360055; cv=none; b=Jlv9WQTeALBnYSilc7NuXD1NohMD9+56YaxiVNgtuoM9YtNjK5Fn9+E1JW+kmSl3woXJZD9KRA/89iPweMmJpu8Sd42AoEbtQRMT63/AZWV6Ej3f/0IrOSctCDJaCsfe+uCJYtJk7gjxMSJCjzJ/7fB7WjFbIXEO3OKaFzD8+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360055; c=relaxed/simple;
	bh=nBmT0PA8UDni32gw1L1thij2TMj+rzLjYjznXS5NdhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvyelIxUt8gEuVGoYMHPksVQ1cSjPhcbsddfceLH5tmOqe3nZuxBfRg4Oy7Htb/V/FYNTWrcFcfqif9ZFa0crypNGS4v1gqEeE3a+mGFrwuaI6Rf8m4SSZlQA/S+/K9sXOecGvsUpCdFFJ0CZPXoudN3Y+02hP/4AJqsxv+v2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LyGJPatM; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=T7BAHQl9jLCJSterP9GAKBUU6eFAIBjD95B7VFZ/xyc=;
	b=LyGJPatMLwQLk8PjFc3AEKky7Mn5Vr6P/AjSUODfV2FbEwyHJY9W1lisS5oyZo
	sIkvwiz93B294OWAkQNuKtS38z1SvnNh+cH1wnf1o7a2Gxh9JpCzFeOsBBVS/68w
	Q7DSwoATG2DNhyT/aRgLe8Q1lOknIhHtpz22NrQzXcQiA=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAnpPBbCGdp4s8tFg--.671S2;
	Wed, 14 Jan 2026 11:07:09 +0800 (CST)
Message-ID: <9ad217bd-c21d-49e5-af0a-9059a3bdf911@163.com>
Date: Wed, 14 Jan 2026 11:07:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] exfat: support multi-cluster for
 exfat_map_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20260108074929.356683-1-chizhiling@163.com>
 <20260108074929.356683-11-chizhiling@163.com>
 <PUZPR04MB631615D6191EF6FB711E63C3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <f7cc8f8a-81f0-4a31-9d75-983858daf985@163.com>
 <PUZPR04MB6316586A2FCEA0BAECA86CB3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB6316586A2FCEA0BAECA86CB3818EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAnpPBbCGdp4s8tFg--.671S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWkWFW3Zr17tFW3Gr43Awb_yoW8tFW3p3
	ykK3Z5Jr1fXa4DKa1fta1DWryFk3s5GFy5J3WxXry5GFyqqr4fJFWqyrnxu3ZrGas8ZrnF
	q3WFgw18uwn7G3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRaLvNUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3B5N6mlnCF6TGgAA30

On 1/13/26 18:26, Yuezhang.Mo@sony.com wrote:
>> On 1/13/26 14:37, Yuezhang.Mo@sony.com wrote:
>>>> @@ -281,7 +285,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>>>>          sec_offset = iblock & (sbi->sect_per_clus - 1);
>>>>
>>>>          phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>>>> -       mapped_blocks = sbi->sect_per_clus - sec_offset;
>>>> +       mapped_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
>>>
>>> This left shift will cause an overflow if the file is larger than 2TB
>>> and the clusters are contiguous.
>>
>> Thank you for pointing this out, I will change the type to blkcnt_t in
>> v3 to fix this bug.
> 
> I don't think it's necessary to change the type to blkcnt_t, because the type
> of bh_result->b_size is size_t (aka unsigned long int).
> 
> The overflow was caused by '*count' being increased in exfat_map_cluster().
> I think it should be fixed as below.
> 
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -153,7 +153,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>                  last_clu += num_clusters - 1;
>                  if (clu_offset < num_clusters) {
>                          *clu += clu_offset;
> -                       *count = num_clusters - clu_offset;
> +                       *count = min(num_clusters - clu_offset, *count);
>                  } else {
>                          *clu = EXFAT_EOF_CLUSTER;
>                          *count = 0;
> @@ -284,7 +284,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>          sec_offset = iblock & (sbi->sect_per_clus - 1);
>   
>          phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
> -       mapped_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
> +       mapped_blocks = ((unsigned long)count << sbi->sect_per_clus_bits) - sec_offset;
>          max_blocks = min(mapped_blocks, max_blocks);
>   
>          map_bh(bh_result, sb, phys);
> 

Okay, I got it, so the exfat_get_cluster should be updated as well.


diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 18d304d1d4cc..7c8b4182f5de 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -303,7 +303,7 @@ int exfat_get_cluster(struct inode *inode, unsigned 
int cluster,

         /* Return if the cache covers the entire range. */
         if (cid.fcluster + cid.nr_contig >= end) {
-               *count = cid.fcluster + cid.nr_contig - cluster + 1;
+               *count = end - cluster + 1;
                 return 0;
         }


Thanks,


