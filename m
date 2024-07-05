Return-Path: <linux-fsdevel+bounces-23196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CE928859
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718E8282FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEA14A0B5;
	Fri,  5 Jul 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Sth1Ui7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4B1442FD;
	Fri,  5 Jul 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180832; cv=none; b=cNuyNcobGnLZVLLm/lH5xiCC9xX8yUjoEWC2HebBflCzHN5Szt3a76QpZzEec5Q6Q8xHBr9xoyWMZJxmM2/0iz1ZjUIyAjgpqCRaMTKtToCIG+LhoAerZ3XjkZ43sGGO5MaQpvPb4QYKqUwuEXQEyU56TkmN+lqgPyDfLTUL5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180832; c=relaxed/simple;
	bh=CVFg5X9EXqnP9AJWRpjFhGPauCxxNPTikt+1w08m7Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwTqydkHKUZZY/J9rpbkCWOQC7Nyy4QjVIpTZkyfEnTaceoGj++G5ETIWADYhddEBWnbfWQMXBWii7/dfOY+YtI3L2DWDfLLJsObp8POp/AV6/2bVgZRxC3JNDoSgFnxTjma38H9c9bT4c+T1EcBuHrOIXIIwGwTQ3HKiD9IzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Sth1Ui7M; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720180820; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5rg0Y502I9+aLU86xiPr0PTCmuta+XOqNeRc2RNmxuI=;
	b=Sth1Ui7MdwLgYNY+KGPAvUpABZz+Qmh0/rM9qQSrqIHsGSme93JTTAgMe0pqwXE9W0jBazWMgnz6PwbU4U9QKcLutuLUbHG1dQc5hVTI2vjw9k7m+iHsCCNQdKndEtC85I3rDNbewg+sAvQiIQLcpFLlC06YGYkeX4xiA38ShZk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W9uv6rw_1720180803;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W9uv6rw_1720180803)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 20:00:20 +0800
Message-ID: <8fd07d19-b7eb-4ae6-becc-08e6e1502fc8@linux.alibaba.com>
Date: Fri, 5 Jul 2024 20:00:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: make foffset alignment opt-in for optimum backend
 performance
To: Bernd Schubert <bernd.schubert@fastmail.fm>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
 <ca86fc29-b0fe-4e23-94b3-76015a95b64f@fastmail.fm>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ca86fc29-b0fe-4e23-94b3-76015a95b64f@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bernd,

Thanks for the comment.


On 7/5/24 7:50 PM, Bernd Schubert wrote:
> 
> 
> On 7/5/24 12:04, Jingbo Xu wrote:
>> Sometimes the file offset alignment needs to be opt-in to achieve the
>> optimum performance at the backend store.
>>
>> For example when ErasureCode [1] is used at the backend store, the
>> optimum write performance is achieved when the WRITE request is aligned
>> with the stripe size of ErasureCode.  Otherwise a non-aligned WRITE
>> request needs to be split at the stripe size boundary.  It is quite
>> costly to handle these split partial requests, as firstly the whole
>> stripe to which the split partial request belongs needs to be read out,
>> then overwrite the read stripe buffer with the request, and finally write
>> the whole stripe back to the persistent storage.
>>
>> Thus the backend store can suffer severe performance degradation when
>> WRITE requests can not fit into one stripe exactly.  The write performance
>> can be 10x slower when the request is 256KB in size given 4MB stripe size.
>> Also there can be 50% performance degradation in theory if the request
>> is not stripe boundary aligned.
>>
>> Besides, the conveyed test indicates that, the non-alignment issue
>> becomes more severe when decreasing fuse's max_ratio, maybe partly
>> because the background writeback now is more likely to run parallelly
>> with the dirtier.
>>
>> fuse's max_ratio	ratio of aligned WRITE requests
>> ----------------	-------------------------------
>> 70			99.9%
>> 40			74%
>> 20			45%
>> 10			20%
>>
>> With the patched version, which makes the alignment constraint opt-in
>> when constructing WRITE requests, the ratio of aligned WRITE requests
>> increases to 98% (previously 20%) when fuse's max_ratio is 10.
>>
>> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#m9bce469998ea6e4f911555c6f7be1e077ce3d8b4
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/file.c            | 4 ++++
>>  fs/fuse/fuse_i.h          | 6 ++++++
>>  fs/fuse/inode.c           | 9 +++++++++
>>  include/uapi/linux/fuse.h | 9 ++++++++-
>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index f39456c65ed7..f9b477016c2e 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -2246,6 +2246,10 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
>>  	if (ap->num_pages == data->max_pages && !fuse_pages_realloc(data))
>>  		return true;
>>  
>> +	/* Reached alignment */
>> +	if (fc->opt_alignment && !(page->index % fc->opt_alignment_pages))
>> +		return true;
> 
> I link the idea, but couldn't it just do that with 
> fc->max_pages? I'm asking because fc->opt_alignment_pages
> takes another uint32_t in fuse_init_out and there is not so much
> space left anymore.

I'm okay with resuing max_pages as the alignment constraint.  They are
the same in our internal scenarios.  But I'm not sure if it is the case
in other scenarios.



>>  /*
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 99e44ea7d875..9266b22cce8e 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -1331,6 +1331,15 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>  			}
>>  			if (flags & FUSE_NO_EXPORT_SUPPORT)
>>  				fm->sb->s_export_op = &fuse_export_fid_operations;
>> +
>> +			/* fallback to default if opt_alignment <= PAGE_SHIFT */
>> +			if (flags & FUSE_OPT_ALIGNMENT) {
>> +				if (arg->opt_alignment > PAGE_SHIFT) {
>> +					fc->opt_alignment = 1;
>> +					fc->opt_alignment_pages = 1 <<
>> +						(arg->opt_alignment - PAGE_SHIFT);
> 
> opt_alignment is the number of bits required for alignment? Not 
> very user friendly, from my point of view would be better to have
> this in a byte or kb unit.
> 

Actually I referred to fuse_init_out.map_alignment, which is also
log2(byte alignment).  Anyway I'm okay making it a more understandable name.

-- 
Thanks,
Jingbo

