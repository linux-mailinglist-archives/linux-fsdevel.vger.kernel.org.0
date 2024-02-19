Return-Path: <linux-fsdevel+bounces-11988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46E859EED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 09:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687F71F234A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B4322334;
	Mon, 19 Feb 2024 08:57:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E02209E;
	Mon, 19 Feb 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333077; cv=none; b=GEPPqth59abAeewCfHrLPIQDT+vRhVAeH1ZLmZak64gF2aFw4L9QD9LicH8CCFdyvEG6Dh3KIx5D+FFHa7F74ClGKNFDzPg0lBAQw0ac7kGfm0913RBNv4cEBnvEF3DUKvFWQ7cPEusW5NCz677Evu4caZevvigO2ZKd6kGnx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333077; c=relaxed/simple;
	bh=AET0VbPi7tnBZVJicQf1CS/4zQwiOWTBxN2Xtilmy6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc3HE05CT3gcUeU3Xd0oyZJ8oLFkEXVZ9bKZtHkjzaveZ4PNaAqBfY/1+JfKN7geCtbmgoEl+6qRITsjXejq7wyIpG3i/IvhHFLnu3tm7gLgQ1ryPUMqzAj+7FU0uBXAXFRuyYA412clBkRqmvGf6TuQ+82zRaFSiVKxbL4Xvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a27d5500c6c44550a1d72c18dad94312-20240219
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e79eded5-457c-4673-8f77-adae0cb2019e,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:e79eded5-457c-4673-8f77-adae0cb2019e,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:01b7748f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240219165238P8MQKDBO,BulkQuantity:0,Recheck:0,SF:19|44|64|66|38|24|1
	7|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: a27d5500c6c44550a1d72c18dad94312-20240219
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 114299905; Mon, 19 Feb 2024 16:52:37 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D1297E000EBC;
	Mon, 19 Feb 2024 16:52:36 +0800 (CST)
X-ns-mid: postfix-65D316D4-787504167
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id DF1D7E000EBC;
	Mon, 19 Feb 2024 16:52:34 +0800 (CST)
Message-ID: <e6f06500-091e-4fc3-ac36-e434c11448d7@kylinos.cn>
Date: Mon, 19 Feb 2024 16:52:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Simplify the allocation of slab caches in
 zonefs_init_inodecache
To: Damien Le Moal <dlemoal@kernel.org>, naohiro.aota@wdc.com, jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240205081022.433945-1-chentao@kylinos.cn>
 <4af4be6e-2c58-4c14-ad2d-eb3f8101a0c1@kernel.org>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <4af4be6e-2c58-4c14-ad2d-eb3f8101a0c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the reply.

On 2024/2/9 12:06, Damien Le Moal wrote:
> On 2/5/24 17:10, Kunwu Chan wrote:
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   fs/zonefs/super.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index 93971742613a..9b578e7007e9 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -1387,10 +1387,8 @@ static struct file_system_type zonefs_type = {
>>   
>>   static int __init zonefs_init_inodecache(void)
>>   {
>> -	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
>> -			sizeof(struct zonefs_inode_info), 0,
>> -			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
>> -			NULL);
>> +	zonefs_inode_cachep = KMEM_CACHE(zonefs_inode_info,
>> +			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT);
>>   	if (zonefs_inode_cachep == NULL)
>>   		return -ENOMEM;
>>   	return 0;
> 
> I do not really see a meaningful simplification here. Using kmem_cache_create()
The main reason is 'it hides all the 0 or NULL parameters'.
> directly is not *that* complicated... Also, this changes the name of the cache
> from "zonefs_inode_cache" to "zonefs_inode_info".
Cache name is used in /proc/slabinfo to identify this cache.
>

Thank again for taking the time to review and reply.

-- 
Thanks,
   Kunwu


