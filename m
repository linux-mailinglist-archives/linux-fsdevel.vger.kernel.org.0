Return-Path: <linux-fsdevel+bounces-70812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC2CA76EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 12:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980213091CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CC324700;
	Fri,  5 Dec 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VvwgPsbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5F31B110;
	Fri,  5 Dec 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764934659; cv=none; b=IdtOlUyF9qnHEd7ojV798W7Qd5+CrPr6+ILZEpznDXCU3cWtoeoGO0RNXpIYPwGb6dcPhdb6CZZoJOeUYtT3VZlLEQdu1w86tBbuJPKSWrYJCfY5eO814N3MF6iSrNTc68pMvbi6alxEI7yyjYXXZhAVP5u3SRm5DnvfOJE1nK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764934659; c=relaxed/simple;
	bh=bszxkIM0Y2bpV2uB8D8d+ARs6gG/53a41Mat3khk3ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpVmgwfCaiQmHehIf3Q9kcA+UKFsGvWRK1aw4Lwbms1YsI9opwBcaiX5vR0eQWB62Mu3Ij7wBR9iKGv4qJQk3o4fzfFpA0X+qSazRcfV9NcTU/ZeJy5HQBdJHzUQoleDfO4CiPLgCcw4fgCIjeu64incRUubpXHFGyUCW8sr6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VvwgPsbL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=4LlKaFzbXsCdvMw4znE9eDALeS29H81GByWEY1fjI0M=;
	b=VvwgPsbLIw0KHZpEZpMnmOzwKxw3AU3SdYi8lZs0hYKK9/1F8VrI3AZWXyM4Xz
	TvX0vRpzT9oiFS66CY4aQzZzeVkNKIk1f66XoEbhWh0l1PzBF1fzhCHtJ+1uZ0cT
	OIqsJ20LOMm0ER+cmup563AzmjUt7aA3piG7BNwed6vYc=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD336DAwzJpS+0BAA--.1034S2;
	Fri, 05 Dec 2025 19:36:34 +0800 (CST)
Message-ID: <a19281dc-4b8a-4a86-a2e4-64da2a499015@163.com>
Date: Fri, 5 Dec 2025 19:36:32 +0800
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
 <96f9d95b-c93f-4637-9c3b-a186d967beee@163.com>
 <9c47afea-a211-4848-bde7-b29f27466e43@samsung.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <9c47afea-a211-4848-bde7-b29f27466e43@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD336DAwzJpS+0BAA--.1034S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw18uryfCr1DZryUCw45ZFb_yoW5KFWkpr
	W8t3WrKr4UXr9rGr4Iqr1vqF1S9348GF1UXr1xJa47KryqvFn3tFWqyr98uFy8K3Z8XF1q
	qF15Ka43urnxua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRjLvNUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wIIpWkyw8KCkwAA3-

On 12/4/25 20:18, Sungjong Seo wrote:
> 
> 
> On 25. 11. 28. 15:18, Chi Zhiling wrote:
>> On 11/28/25 10:48, Sungjong Seo wrote:
>>>
>>> Hi, Chi,
>>> On 25. 11. 18. 17:22, Chi Zhiling wrote:
>>>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>>>
>>>> mpage uses the get_block of the file system to obtain the mapping of a
>>>> file or allocate blocks for writes. Currently exfat only supports
>>>> obtaining one cluster in each get_block call.
>>>>
>>>> Since exfat_count_contig_clusters can obtain multiple consecutive clusters,
>>>> it can be used to improve exfat_get_block when page size is larger than
>>>> cluster size.
>>>
>>> I think reusing buffer_head is a good approach!
>>> However, for obtaining multiple clusters, it would be better to handle
>>> them in exfat_map_cluster.
>>
>> Hi, Sungjong
>>
>> I agree.
>>
>> My original plan was to support multiple clusters for exfat_map_cluster and exfat_get_cluster. since the changes required were quite extensive, I put that plan on hold. This would likely involve refactoring exfat_map_clusterand introducing iterators to reduce the number of parameters it needs
>>
>> I will take some time to consider the signature of the new exfat_map_clusters. Do you have any thoughts about this?
> Apologies, I missed your email.
> IMO, we don't need to rush, so I think expanding exfat_map_cluster(s) would be better.

Okay.

> 
> Thanks.
>>
>>>
>>>>
>>>> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
>>>> ---
>>>>    fs/exfat/inode.c | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
>>>> index f9501c3a3666..256ba2af34eb 100644
>>>> --- a/fs/exfat/inode.c
>>>> +++ b/fs/exfat/inode.c
>>>> @@ -264,13 +264,14 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
>>>>    static int exfat_get_block(struct inode *inode, sector_t iblock,
>>>>            struct buffer_head *bh_result, int create)
>>>>    {
>>>> +    struct exfat_chain chain;
>>>>        struct exfat_inode_info *ei = EXFAT_I(inode);
>>>>        struct super_block *sb = inode->i_sb;
>>>>        struct exfat_sb_info *sbi = EXFAT_SB(sb);
>>>>        unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
>>>>        int err = 0;
>>>>        unsigned long mapped_blocks = 0;
>>>> -    unsigned int cluster, sec_offset;
>>>> +    unsigned int cluster, sec_offset, count;
>>>>        sector_t last_block;
>>>>        sector_t phys = 0;
>>>>        sector_t valid_blks;
>>>> @@ -301,6 +302,17 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>>>>          phys = exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>>>>        mapped_blocks = sbi->sect_per_clus - sec_offset;
>>>> +
>>>> +    if (max_blocks > mapped_blocks && !create) {
>>>> +        chain.dir = cluster;
>>>> +        chain.size = (max_blocks >> sbi->sect_per_clus_bits) + 1;
>>>
>>> There seems to be an issue where the code sets chain.size to be one greater than the actual cluster count.
>>>
>>> For example, assuming a 16KiB page, 512B sector, and 4KiB cluster,
>>> for a 16KiB file, chain.size becomes 5 instead of 4.
>>> Is this the intended behavior?
>>
>> This is not the expected behavior. It's a serious bug. Thank you very much for pointing this out.
>>
>>>
>>>> +        chain.flags = ei->flags;
>>>> +
>>>> +        err = exfat_count_contig_clusters(sb, &chain, &count);
>>>> +        if (err)
>>>> +            return err;
>>>> +        max_blocks = (count << sbi->sect_per_clus_bits) - sec_offset;
>>>
>>> You already said mapped_blocks is correct.
>>>
>>>> +    }
>>>>        max_blocks = min(mapped_blocks, max_blocks);
>>>>          map_bh(bh_result, sb, phys);
>>
>>


