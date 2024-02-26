Return-Path: <linux-fsdevel+bounces-12816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846086770F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D34B23A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD50129A61;
	Mon, 26 Feb 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bhzFUB1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3A1292C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955124; cv=none; b=itiIY6DrQchRdjSCOSgA9DxQ7YtkRVZ8Gt5i9OCkBcZDVCcH80pGcZwxtFWaPAI70V1RU/sJP+Bz0rl2ZS52yNbDW1O4gfIYZDV9yFIEr+zrgCWlqlQ7AUuIUP+WVRqerAYZazwVDgLQYwwwXwuEigJNuQDIwwBrRwRj5K5Xwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955124; c=relaxed/simple;
	bh=0q7cOXbmk/c9kVV6YXyYpfa2nWdbjm93exJsOTH2iPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gt6eNXbOMZ1Hua4nzWMEAW1kYL+ON+PRrnAfAqtlFICcpoDdr1D+sMKJ51dhnR9gJdudSrNVUXIrhAqXth6abxTsfAPJa/CqG9JSOMfGgfPntCkdwPS8SFTfM6fzmUH4zXseufGyeq/LsqFrqLS4Q3foUFkaNvQj5Po7XyIKgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bhzFUB1N; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <955791a3-5fa2-4473-b69d-a9a56ee6f98d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708955120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JRZHibxSDt1ouB+hnkMrR1x0/Y+/HJ8lBiREAu9qpg=;
	b=bhzFUB1N7OB0LR+pt65bzTbUYIDJd/n/2qnAT4GJ548qfpeWyNojUW+ccX3jyGK9tFgMpy
	sWsQ2PAQVNbF5ec3XYYAHI4OeAjZYZ18x31sfrX4rwPUOqicJ4YINSLgbLHKVP88MG3l30
	ukaKusi5Cd9CWBeBjyFM5LBTMlcPVzQ=
Date: Mon, 26 Feb 2024 21:44:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] zonefs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, naohiro.aota@wdc.com, jth@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com
References: <20240224135329.830543-1-chengming.zhou@linux.dev>
 <5cdbfed3-62cd-41fd-b71a-5c6b1940ceb6@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <5cdbfed3-62cd-41fd-b71a-5c6b1940ceb6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/26 21:33, Damien Le Moal wrote:
> On 2024/02/24 5:53, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  fs/zonefs/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>> index 236a6d88306f..c6a124e8d565 100644
>> --- a/fs/zonefs/super.c
>> +++ b/fs/zonefs/super.c
>> @@ -1422,7 +1422,7 @@ static int __init zonefs_init_inodecache(void)
>>  {
>>  	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
>>  			sizeof(struct zonefs_inode_info), 0,
>> -			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
>> +			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>>  			NULL);
>>  	if (zonefs_inode_cachep == NULL)
>>  		return -ENOMEM;
> 
> Looks good, but please rework the commit message as you suggested on the btrfs
> list to have more details about this change. Thanks.
> 

Ok, Christoph Hellwig suggested me to send these patches as a single patch after
6.9-rc1 release, only need slab maintainers ACK. So I stopped bothering you. :)

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

