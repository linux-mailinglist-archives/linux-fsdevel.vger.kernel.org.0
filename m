Return-Path: <linux-fsdevel+bounces-72461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F0CF756B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ECC2302F6B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B32D8DDB;
	Tue,  6 Jan 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Efc3Mytd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113242D97B9;
	Tue,  6 Jan 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689201; cv=none; b=TnJH+ilg/x22KPe6T2+h/BktpCNdq5IGl9MQd0jTVliioLN/obdvFKkhPJ0VUmoNQWDxSjy6u3ByWuWcGf71stamzZA9KrGbJNQuqYnmWlagIqT5jGZ5GfmdmEJfeotnXc+boJY7QQ+u1bCgQuw7R2ofElqVUfBpq/4Tz3O1JP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689201; c=relaxed/simple;
	bh=+x/1R+xaOkU7EyHp/fR4FW8bbEjePy+BtRqhE+K6d3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1Rp2baEb46uKxmTNZ1lpuZ6FKeObD/g57uR0Bonxs0KPiMXaDHxoiHxRsC+KLXvV0fdoXn2AVOiviBM2g6A61iXS09DPmjxEF84XFhRQCYWEVOaPK5jVliGMe8wUv/sJHqYZMYQ1+B/UBdI2oku/z09okX2AIMu7D+/L4DHgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Efc3Mytd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=flfMrXAxsHQPijFF3kejjQTDjCfFIwcdG0wrrniS6eQ=;
	b=Efc3Mytdz2YfwIBf3D5Ey9MEec37zQtXSVSQLucVF6PRW4FoWnOO0fLTRhShxQ
	EiB+CIZqBsJx5/trNIY3dvjKFeuWAyCuDp0FMEybBfoT1UepGzvpnMzANE8DdTU9
	+xySCU3k2JqOP5BeIXW+fAoPoIvUGPhqAbJvOFFBXbicw=
Received: from [10.42.20.201] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnFnOyy1xpcC6IKQ--.136S2;
	Tue, 06 Jan 2026 16:45:42 +0800 (CST)
Message-ID: <7a2e0d35-3dff-408a-b8ad-8afef08e96d1@163.com>
Date: Tue, 6 Jan 2026 16:45:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] exfat: support multi-cluster for exfat_get_cluster
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "chizhiling@kylinos.cn" <chizhiling@kylinos.cn>, "jack@suse.cz"
 <jack@suse.cz>, "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "willy@infradead.org" <willy@infradead.org>
References: <PUZPR04MB6316194114D39A6505BA45A381BCA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <d832364d-02e6-458d-9eb2-442e1452a0f9@163.com>
 <PUZPR04MB631627BD83F409B370337E4D81B9A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <eb265ced-5694-4bf8-884c-b188a670d796@163.com>
 <PUZPR04MB63162C265F7C0CB87E6457988187A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <PUZPR04MB63162C265F7C0CB87E6457988187A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgAnFnOyy1xpcC6IKQ--.136S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr18Ww18Jw43WF43JF45Awb_yoW7KF45pr
	WxKa45tFs3X347Cw18tw1kZFyS9F97tF47Xw13Jw13C34qyrs5Krn8trn0kF1rCr48GanF
	vr1rKw17uFs8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEknYUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BaRL2lcy7ZyWAAA3y

On 1/6/26 15:32, Yuezhang.Mo@sony.com wrote:
>> On 1/4/26 15:56, Yuezhang.Mo@sony.com wrote:
>>>> On 12/30/25 17:06, Yuezhang.Mo@sony.com wrote:
>>>>>> +     /*
>>>>>> +      * Return on cache hit to keep the code simple.
>>>>>> +      */
>>>>>> +     if (fclus == cluster) {
>>>>>> +             *count = cid.fcluster + cid.nr_contig - fclus + 1;
>>>>>>                  return 0;
>>>>>
>>>>> If 'cid.fcluster + cid.nr_contig - fclus + 1 < *count', how about continuing to collect clusters?
>>>>> The following clusters may be continuous.
>>>>
>>>> I'm glad you noticed this detail. It is necessary to explain this and
>>>> update it in the code comments.
>>>>
>>>> The main reason why I didn't continue the collection was that the
>>>> subsequent clusters might also exist in the cache. This requires us to
>>>> search the cache again to confirm this, and this action might introduce
>>>> additional performance overhead.
>>>>
>>>> I think we can continue to collect, but we need to check the cache
>>>> before doing so.
>>>>
>>>
>>> So we also need to check the cache in the following, right?
>>
>> Uh, I don't think it's necessary in here, because these clusters won't
>> exist in the cache.
>>
>> In the cache_lru, all exfat_cache start from non-continuous clusters.
>> This is because exfat_get_cluster adds consecutive clusters to the cache
>> from left to right, which means that the left side of all caches is
>> non-continuous.
>>
>> For instance, if a file contains two extents,  [0,30] and [31,60], then
>> exfat_cache must start at either 0 or 31, right?
>>
>> When we have found a cache is [31, 45], then there won't be [41, 60] in
>> the cache_lru.
>>
>> So when we already get some head clusters of a continuous extent, the
>> tail cluster will definitely not be present in the cache.
>>
> 
> Your understanding is correct, so if the cache only includes a part of the
> requested clusters, we can continue to collect subsequent clusters.
> 
>>
>> ---
>>
>> Here are some modifications regarding this patch (which may be reflected
>> in the V2 version). Do you have any thoughts or suggestions on this?
>>
> 
> Although these modifications make exfat_cache_lookup check the entire
> cache every time, I think the modifications are reasonable since the cache
> (EXFAT_MAX_CACHE is 16) is small.

I have improved it in v2. :)

> 
>>
>> diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
>> index 1ec531859944..8ff416beea3c 100644
>> --- a/fs/exfat/cache.c
>> +++ b/fs/exfat/cache.c
>> @@ -80,6 +80,10 @@ static inline void exfat_cache_update_lru(struct
>> inode *inode,
>>                   list_move(&cache->cache_list, &ei->cache_lru);
>>    }
>>
>> +/*
>> + * Return fcluster of the cache which behind fclus, or
>> + * EXFAT_EOF_CLUSTER if no cache in there.
>> + */
>>    static bool exfat_cache_lookup(struct inode *inode,
>>                   unsigned int fclus, struct exfat_cache_id *cid,
>>                   unsigned int *cached_fclus, unsigned int *cached_dclus)
>> @@ -87,6 +91,7 @@ static bool exfat_cache_lookup(struct inode *inode,
>>           struct exfat_inode_info *ei = EXFAT_I(inode);
>>           static struct exfat_cache nohit = { .fcluster = 0, };
>>           struct exfat_cache *hit = &nohit, *p;
>> +       unsigned int next = EXFAT_EOF_CLUSTER;
>>           unsigned int offset;
>>
>>           spin_lock(&ei->cache_lru_lock);
>> @@ -98,8 +103,9 @@ static bool exfat_cache_lookup(struct inode *inode,
>>                                   offset = hit->nr_contig;
>>                           } else {
>>                                   offset = fclus - hit->fcluster;
>> -                               break;
>>                           }
>> +               } else if (p->fcluster > fclus && p->fcluster < next) {
>> +                       next = p->fcluster;
>>                   }
>>           }
>>           if (hit != &nohit) {
>> @@ -114,7 +120,7 @@ static bool exfat_cache_lookup(struct inode *inode,
>>           }
>>           spin_unlock(&ei->cache_lru_lock);
>>
>> -       return hit != &nohit;
>> +       return next;
>>    }
>>
>>    static struct exfat_cache *exfat_cache_merge(struct inode *inode,
>> @@ -243,7 +249,7 @@ int exfat_get_cluster(struct inode *inode, unsigned
>> int cluster,
>>           struct exfat_inode_info *ei = EXFAT_I(inode);
>>           struct buffer_head *bh = NULL;
>>           struct exfat_cache_id cid;
>> -       unsigned int content, fclus;
>> +       unsigned int content, fclus, next;
>>           unsigned int end = cluster + *count - 1;
>>
>>           if (ei->start_clu == EXFAT_FREE_CLUSTER) {
>> @@ -272,14 +278,15 @@ int exfat_get_cluster(struct inode *inode,
>> unsigned int cluster,
>>                   return 0;
>>
>>           cache_init(&cid, fclus, *dclus);
>> -       exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
>> +       next = exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
>>
>> -       /*
>> -        * Return on cache hit to keep the code simple.
>> -        */
>>           if (fclus == cluster) {
>> -               *count = cid.fcluster + cid.nr_contig - fclus + 1;
> 
> If the cache only includes a part of the requested clusters and subsequent
> clusters are not contiguous. '*count' is needed to set like above.

You are right, I will fix it in v2.

Thanks,

> 
>> -               return 0;
>> +               /* The cache includes all cluster requested */
>> +               if (cid.fcluster + cid.nr_contig >= end)
>> +                       return 0;
>> +               /* No cache hole behind this cache */
>> +               if (next == cid.fcluster + cid.nr_contig + 1)
>> +                       return 0;
>>           }
>>
>>           /*
>>
>>
>> Thanks,
>>
>>>
>>> ```
>>>           /*
>>>            * Collect the remaining clusters of this contiguous extent.
>>>            */
>>>           if (*dclus != EXFAT_EOF_CLUSTER) {
>>>                   unsigned int clu = *dclus;
>>>
>>>                   /*
>>>                    * Now the cid cache contains the first cluster requested,
>>>                    * Advance the fclus to the last cluster of contiguous
>>>                    * extent, then update the count and cid cache accordingly.
>>>                    */
>>>                   while (fclus < end) {
>>>                           if (exfat_ent_get(sb, clu, &content, &bh))
>>>                                   goto err;
>>>                           if (++clu != content) {
>>>                                   /* TODO: read ahead if content valid */
>>>                                   break;
>>>                           }
>>>                           fclus++;
>>>                   }
>>>                   cid.nr_contig = fclus - cid.fcluster;
>>>                   *count = fclus - cluster + 1;
>>> ```
>>>
>>>>>>
>>>>>> +             while (fclus < end) {
>>>>>> +                     if (exfat_ent_get(sb, clu, &content, &bh))
>>>>>> +                             goto err;
>>>>>> +                     if (++clu != content) {
>>>>>> +                             /* TODO: read ahead if content valid */
>>>>>> +                             break;
>>>>>
>>>>> The next cluster index has been read and will definitely be used.
>>>>> How about add it to the cache?
>>>>
>>>> Good idea!
>>>> will add it in v2,


