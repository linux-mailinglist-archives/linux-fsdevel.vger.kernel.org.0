Return-Path: <linux-fsdevel+bounces-70660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7BCA394C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2A6F306339A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DD82F12AB;
	Thu,  4 Dec 2025 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZauhYr9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1E27B32B
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850719; cv=none; b=Qlh6hwZ1F/VgWarZBjvEJ4hj2TO59UeLnrir7ZV8HjxoeU5vkF7fGq7Kp+JJSc7cTpzviQzvJ3ntpPw4w5zWWnoq0V5dbJcZ650UyWskwM08PG/sJ6+vPFrrc8WWzwVOkBquVDOSCuc00XSV/xLc7SXALsefL/nMji5lRrCcpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850719; c=relaxed/simple;
	bh=X6NkRCYuPlEgaurqBuWpioJvm8iNmRVkz7rA3UKY4dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Nipe/93f/wFBQPiMTa2gyUljC861apffVm/3y8VEWVdQ/dx46j50kzQuKTiDG7TvGY+aey6y4t331YC9+nDHlpsNmIFXfY3Fu8KcYcMx6Sc1j8AvNMZZfEgWLS16Til70X6Dwcc0FDLCgKirS8SNNaHnm6yv8ND2xx1EqDCbqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZauhYr9U; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251204121834epoutp04ae17438ccbd591b37dc560e935311d0f~_Al-jl8wT2612026120epoutp04T
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 12:18:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251204121834epoutp04ae17438ccbd591b37dc560e935311d0f~_Al-jl8wT2612026120epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764850714;
	bh=wLQlf7kMtVvhVNHC1xaXCm/knIH++I7i8v84t0OV4rc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZauhYr9U083T9z237tN2BrA8wvBpNjJQtDoZO42Ey0aqCrpbk4Pl7ikN1Af2kKJIb
	 Z4E006x8ozy6/i5oKvx7LfMmolrC9xsNpNpVmKIiju/1DAyTbhj6mf7UvrQWQrd190
	 2tvWoRq5njbEhcmBqstnY3cTEbkINdwiRRx8u+6w=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20251204121834epcas1p1fa56316e66777bbb4dda3a5bf135dc7f~_Al-DwuwY2856028560epcas1p1b;
	Thu,  4 Dec 2025 12:18:34 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.116]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dMYSp0ZtKz6B9m7; Thu,  4 Dec
	2025 12:18:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20251204121833epcas1p4837d224f5b139ab900d8412799572997~_Al_BSlgj3273132731epcas1p4E;
	Thu,  4 Dec 2025 12:18:33 +0000 (GMT)
Received: from [172.25.92.0] (unknown [10.246.9.208]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251204121833epsmtip1f672a673b07710521830b04a26056dd6~_Al95UqpZ0357503575epsmtip1g;
	Thu,  4 Dec 2025 12:18:33 +0000 (GMT)
Message-ID: <9c47afea-a211-4848-bde7-b29f27466e43@samsung.com>
Date: Thu, 4 Dec 2025 21:18:32 +0900
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
	<yuezhang.mo@sony.com>, Chi Zhiling <chizhiling@kylinos.cn>
Content-Language: en-US
From: Sungjong Seo <sj1557.seo@samsung.com>
In-Reply-To: <96f9d95b-c93f-4637-9c3b-a186d967beee@163.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251204121833epcas1p4837d224f5b139ab900d8412799572997
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
	<5db1b061-56ef-4013-9d1e-aac04175aa8d@samsung.com>
	<96f9d95b-c93f-4637-9c3b-a186d967beee@163.com>



On 25. 11. 28. 15:18, Chi Zhiling wrote:
> On 11/28/25 10:48, Sungjong Seo wrote:
>>
>> Hi, Chi,
>> On 25. 11. 18. 17:22, Chi Zhiling wrote:
>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>
>>> mpage uses the get_block of the file system to obtain the mapping of a
>>> file or allocate blocks for writes. Currently exfat only supports
>>> obtaining one cluster in each get_block call.
>>>
>>> Since exfat_count_contig_clusters can obtain multiple consecutive clusters,
>>> it can be used to improve exfat_get_block when page size is larger than
>>> cluster size.
>>
>> I think reusing buffer_head is a good approach!
>> However, for obtaining multiple clusters, it would be better to handle
>> them in exfat_map_cluster.
> 
> Hi, Sungjong
> 
> I agree.
> 
> My original plan was to support multiple clusters for exfat_map_cluster and exfat_get_cluster. since the changes required were quite extensive, I put that plan on hold. This would likely involve refactoring exfat_map_clusterand introducing iterators to reduce the number of parameters it needs
> 
> I will take some time to consider the signature of the new exfat_map_clusters. Do you have any thoughts about this?
Apologies, I missed your email.
IMO, we don't need to rush, so I think expanding exfat_map_cluster(s) would be better.

Thanks.
> 
>>
>>>
>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>> ---
>>>   fs/exfat/inode.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
>>> index f9501c3a3666..256ba2af34eb 100644
>>> --- a/fs/exfat/inode.c
>>> +++ b/fs/exfat/inode.c
>>> @@ -264,13 +264,14 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>>   static int exfat_get_block(struct inode *inode, sector_t iblock,
>>>           struct buffer_head *bh_result, int create)
>>>   {
>>> +    struct exfat_chain chain;
>>>       struct exfat_inode_info *ei = EXFAT_I(inode);
>>>       struct super_block *sb = inode->i_sb;
>>>       struct exfat_sb_info *sbi = EXFAT_SB(sb);
>>>       unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
>>>       int err = 0;
>>>       unsigned long mapped_blocks = 0;
>>> -    unsigned int cluster, sec_offset;
>>> +    unsigned int cluster, sec_offset, count;
>>>       sector_t last_block;
>>>       sector_t phys = 0;
>>>       sector_t valid_blks;
>>> @@ -301,6 +302,17 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>>>         phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>>>       mapped_blocks = sbi->sect_per_clus - sec_offset;
>>> +
>>> +    if (max_blocks > mapped_blocks && !create) {
>>> +        chain.dir = cluster;
>>> +        chain.size = (max_blocks >> sbi->sect_per_clus_bits) + 1;
>>
>> There seems to be an issue where the code sets chain.size to be one greater than the actual cluster count.
>>
>> For example, assuming a 16KiB page, 512B sector, and 4KiB cluster,
>> for a 16KiB file, chain.size becomes 5 instead of 4.
>> Is this the intended behavior?
> 
> This is not the expected behavior. It's a serious bug. Thank you very much for pointing this out.
> 
>>
>>> +        chain.flags = ei->flags;
>>> +
>>> +        err = exfat_count_contig_clusters(sb, &chain, &count);
>>> +        if (err)
>>> +            return err;
>>> +        max_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
>>
>> You already said mapped_blocks is correct.
>>
>>> +    }
>>>       max_blocks = min(mapped_blocks, max_blocks);
>>>         map_bh(bh_result, sb, phys);
> 
> 


