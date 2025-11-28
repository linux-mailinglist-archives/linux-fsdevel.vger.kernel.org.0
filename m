Return-Path: <linux-fsdevel+bounces-70113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A795C90EEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 07:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46293ACC84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B62D0C82;
	Fri, 28 Nov 2025 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U4W2fn0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18822C0286;
	Fri, 28 Nov 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764310771; cv=none; b=flKf/FQUUIPyCPJ5qoBDVZJV4NbTLGNLh1jK3Hk0JCZ8If2OtFEoT/SZFJSWAh1SpA8yS/PZNs3AwSSgEpAl6gUEleLFCqNOiUPl6laOIeGVvKaeLcRPlIzZjUe864DrL0ZVO4iG8XVA9qUrUfPL7QENLKBq4vsHxbvgTXt2TwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764310771; c=relaxed/simple;
	bh=gwQyc+Lp2vv6mOcePpZoJSTmeUWqGv2M8YBQBNoBf4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buzI+2GN9ybfeypdfxSV7qucliZpfQYaQDi7EJUK80NPu3rqsth00uOs8hJg1t1lleolza7Bkn2SQDkYe+DME8K/5b4zLPvYyLqKk2NYPcmCGlcFUSO9A+kzsGTmrVUJv6GK82Kbq96PjsvW/pqv72rN0W9SsrSkeTWYQ7e1gL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U4W2fn0N; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VGprdopHWRZcUM2ZlrMzMH1rL1JiSro7G4KoqLl2NPM=;
	b=U4W2fn0NBwmBq1w28naxx0n9U5FA2HaffejdpahkFDTxDIdFiWGj66vlOXNTd3
	hU+m9SbRec55NZO3Z8NUrTgrpz9sgIFGjThfvjnAtRHEMhafBX2F82FkCzAjxtOH
	gqNel9zQnev3IT72qFGRkhnSI+G70YBwVKmTtPMWI7q7g=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXjZu2Pilp2o5tDA--.3906S2;
	Fri, 28 Nov 2025 14:18:31 +0800 (CST)
Message-ID: <96f9d95b-c93f-4637-9c3b-a186d967beee@163.com>
Date: Fri, 28 Nov 2025 14:18:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] exfat: get mutil-clusters in exfat_get_block
To: Sungjong Seo <sj1557.seo@samsung.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20251118082208.1034186-1-chizhiling@163.com>
 <CGME20251118082625epcas1p44374f21201c10f1bb9084d2280e64e6d@epcas1p4.samsung.com>
 <20251118082208.1034186-8-chizhiling@163.com>
 <5db1b061-56ef-4013-9d1e-aac04175aa8d@samsung.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <5db1b061-56ef-4013-9d1e-aac04175aa8d@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAXjZu2Pilp2o5tDA--.3906S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4xZrWUuw47Ary3Cr18Grg_yoW5ZrW8p3
	y8K3WrKr4UX347GF4Iqr4kZFyF9w1kGF1UJr4xXFy7Kr90qrnayFWvyr9xuFykK3Z8Xr1q
	qF15Kw13uwnrua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0D7-UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBcxIUnWkpOjBpmAAAsT

On 11/28/25 10:48, Sungjong Seo wrote:
> 
> Hi, Chi,
> On 25. 11. 18. 17:22, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> mpage uses the get_block of the file system to obtain the mapping of a
>> file or allocate blocks for writes. Currently exfat only supports
>> obtaining one cluster in each get_block call.
>>
>> Since exfat_count_contig_clusters can obtain multiple consecutive clusters,
>> it can be used to improve exfat_get_block when page size is larger than
>> cluster size.
> 
> I think reusing buffer_head is a good approach!
> However, for obtaining multiple clusters, it would be better to handle
> them in exfat_map_cluster.

Hi, Sungjong

I agree.

My original plan was to support multiple clusters for exfat_map_cluster 
and exfat_get_cluster. since the changes required were quite extensive, 
I put that plan on hold. This would likely involve refactoring 
exfat_map_clusterand introducing iterators to reduce the number of 
parameters it needs

I will take some time to consider the signature of the new 
exfat_map_clusters. Do you have any thoughts about this?

> 
>>
>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>> ---
>>   fs/exfat/inode.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
>> index f9501c3a3666..256ba2af34eb 100644
>> --- a/fs/exfat/inode.c
>> +++ b/fs/exfat/inode.c
>> @@ -264,13 +264,14 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>   static int exfat_get_block(struct inode *inode, sector_t iblock,
>>   		struct buffer_head *bh_result, int create)
>>   {
>> +	struct exfat_chain chain;
>>   	struct exfat_inode_info *ei = EXFAT_I(inode);
>>   	struct super_block *sb = inode->i_sb;
>>   	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>>   	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
>>   	int err = 0;
>>   	unsigned long mapped_blocks = 0;
>> -	unsigned int cluster, sec_offset;
>> +	unsigned int cluster, sec_offset, count;
>>   	sector_t last_block;
>>   	sector_t phys = 0;
>>   	sector_t valid_blks;
>> @@ -301,6 +302,17 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>>   
>>   	phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>>   	mapped_blocks = sbi->sect_per_clus - sec_offset;
>> +
>> +	if (max_blocks > mapped_blocks && !create) {
>> +		chain.dir = cluster;
>> +		chain.size = (max_blocks >> sbi->sect_per_clus_bits) + 1;
> 
> There seems to be an issue where the code sets chain.size to be one greater than the actual cluster count.
> 
> For example, assuming a 16KiB page, 512B sector, and 4KiB cluster,
> for a 16KiB file, chain.size becomes 5 instead of 4.
> Is this the intended behavior?

This is not the expected behavior. It's a serious bug. Thank you very 
much for pointing this out.

> 
>> +		chain.flags = ei->flags;
>> +
>> +		err = exfat_count_contig_clusters(sb, &chain, &count);
>> +		if (err)
>> +			return err;
>> +		max_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
> 
> You already said mapped_blocks is correct.
> 
>> +	}
>>   	max_blocks = min(mapped_blocks, max_blocks);
>>   
>>   	map_bh(bh_result, sb, phys);


