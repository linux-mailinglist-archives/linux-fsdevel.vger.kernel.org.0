Return-Path: <linux-fsdevel+bounces-16063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D78977B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D073C1F24E9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EAE1534F2;
	Wed,  3 Apr 2024 18:02:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32389152513;
	Wed,  3 Apr 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167344; cv=none; b=SEXtTkACKWkYJ3C+yr9it6HEZpiwaYraqcRxNty5W19YbDHQhLEKvsmjf942KO9qbtPi86mi1n6+1dRp6DkeKgWLCSBOTrdXFFVNyZycyV3EwxIwxm+efw86jGJ5GKRC0pn83sd6nCT1+5dCZaJAAsFWSnNfVJDIkwI0qYHs07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167344; c=relaxed/simple;
	bh=wohhLCNkof1vY1W1Dwlmkq643wtKNO9tiiqXimh9pKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+cmCEygnzc2hUXXfPCmrf8/IBOt13fk2iQqAbCdI0lMYpErgqo5cl4R0uHJb9SQ/DAn8LUbLycecRicElw0oJluQ0icrEJXmTpxUD0pjfAaGFoqSX/1p4SWk7PQF3JgVyg5UUQSE06jWRJo18bEmrOePB5uq58WsY/tWjf+jKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D441007;
	Wed,  3 Apr 2024 11:02:52 -0700 (PDT)
Received: from [10.57.18.20] (unknown [10.57.18.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9333F766;
	Wed,  3 Apr 2024 11:02:17 -0700 (PDT)
Message-ID: <2143378c-0d5b-4e68-9da4-cabc149cb84f@arm.com>
Date: Wed, 3 Apr 2024 19:02:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm, slab: move memcg charging to post-alloc hook
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mark Brown <broonie@kernel.org>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
 <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
 <30df7730-1b37-420d-b661-e5316679246f@arm.com>
 <4af50be2-4109-45e5-8a36-2136252a635e@suse.cz>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <4af50be2-4109-45e5-8a36-2136252a635e@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/04/2024 16:48, Vlastimil Babka wrote:
> On 4/3/24 1:39 PM, Aishwarya TCV wrote:
>>
>>
>> On 25/03/2024 08:20, Vlastimil Babka wrote:
>>> The MEMCG_KMEM integration with slab currently relies on two hooks
>>> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
>>> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
>>> to the allocated object(s).
>>>
>>> As Linus pointed out, this is unnecessarily complex. Failing to charge
>>> due to memcg limits should be rare, so we can optimistically allocate
>>> the object(s) and do the charging together with assigning the objcg
>>> pointer in a single post_alloc hook. In the rare case the charging
>>> fails, we can free the object(s) back.
>>>
>>> This simplifies the code (no need to pass around the objcg pointer) and
>>> potentially allows to separate charging from allocation in cases where
>>> it's common that the allocation would be immediately freed, and the
>>> memcg handling overhead could be saved.
>>>
>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
>>> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>>  mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
>>>  1 file changed, 77 insertions(+), 103 deletions(-)
>>
>> Hi Vlastimil,
>>
>> When running the LTP test "memcg_limit_in_bytes" against next-master
>> (next-20240402) kernel with Arm64 on JUNO, oops is observed in our CI. I
>> can send the full logs if required. It is observed to work fine on
>> softiron-overdrive-3000.
>>
>> A bisect identified 11bb2d9d91627935c63ea3e6a031fd238c846e1 as the first
>> bad commit. Bisected it on the tag "next-20240402" at repo
>> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
>>
>> This works fine on  Linux version v6.9-rc2
> 
> Oops, sorry, can you verify that this fixes it?
> Thanks.
> 
> ----8<----
> From b0597c220624fef4f10e26079a3ff1c86f02a12b Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 3 Apr 2024 17:45:15 +0200
> Subject: [PATCH] fixup! mm, slab: move memcg charging to post-alloc hook
> 
> The call to memcg_alloc_abort_single() is wrong, it expects a pointer to
> single object, not an array.
> 
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f5b151a58b7d..b32e79629ae7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2100,7 +2100,7 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  		return true;
>  
>  	if (likely(size == 1)) {
> -		memcg_alloc_abort_single(s, p);
> +		memcg_alloc_abort_single(s, *p);
>  		*p = NULL;
>  	} else {
>  	
	kmem_cache_free_bulk(s, size, p);

Tested the attached patch on next-20240302. Confirming that the test is
running fine. Test run log is attached below.

Test run log:
--------------
memcg_limit_in_bytes 8 TPASS: process 614 is killed
memcg_limit_in_bytes 9 TINFO: Test limit_in_bytes will be aligned to
PAGESIZE
memcg_limit_in_bytes 9 TPASS: echo 4095 > memory.limit_in_bytes passed
as expected
memcg_limit_in_bytes 9 TPASS: input=4095, limit_in_bytes=0
memcg_limit_in_bytes 10 TPASS: echo 4097 > memory.limit_in_bytes passed
as expected
memcg_limit_in_bytes 10 TPASS: input=4097, limit_in_bytes=4096
memcg_limit_in_bytes 11 TPASS: echo 1 > memory.limit_in_bytes passed as
expected
memcg_limit_in_bytes 11 TPASS: input=1, limit_in_bytes=0
memcg_limit_in_bytes 12 TINFO: Test invalid memory.limit_in_bytes
memcg_limit_in_bytes 12 TPASS: echo -1 > memory.limit_in_bytes passed as
expected
memcg_limit_in_bytes 13 TPASS: echo 1.0 > memory.limit_in_bytes failed
as expected
memcg_limit_in_bytes 14 TPASS: echo 1xx > memory.limit_in_bytes failed
as expected
memcg_limit_in_bytes 15 TPASS: echo xx > memory.limit_in_bytes failed as
expected
Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0

Thanks,
Aishwarya

