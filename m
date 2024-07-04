Return-Path: <linux-fsdevel+bounces-23082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1052926CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C016A1C2153D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB18462;
	Thu,  4 Jul 2024 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuSVAJQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA594A31
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720055052; cv=none; b=twGTmbfIQFIPrqWjTXHYSHkPlMoB7gRgysh5FC8WaAknkCoGOjatNU4RTA1+gxfndATMiw4DltHGjZh8J6PBA2f62q+E5/RAwybFfzCADQdJ9cxbybT+wm03PedEgPGrfV6rhJfDqDiLPpELey4bDGeRqACNV00dvWfsvFjrxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720055052; c=relaxed/simple;
	bh=OwHkXu8Tdg+QcH0k7SdpkI90l//y2X83WtGBeUeLnss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh9m2Ix8u7eCq5uE2f+BUYJ/j9TaDmJpYKJEEEshy4yjc+K4txqL17MXvSYZR0uEpPaC5GP8zhx8PAtXcNXyKxdrGyDa/7wIWuFIaimDXcKTZFEHrvlYmov/PZtJ2nXQWAVayVbFQkJ1tQJ1cVQPGij+JwLIkSRb1uxyQaA44OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuSVAJQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720055049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/1UoAoUE38XfmtGte/DbdgJX2un8zCdfajv3hxrPb+Q=;
	b=OuSVAJQuRFJg7gVd6Ork0PxjfY4Z4vxssctt5j4cv/cGGaUvUz6pgjYvYKBXEmPsHmnXfP
	Te0an3O8qgmP0zLfUvC0B1Hvzr/k4HoklCqs+mfH+rINfxNw8IbWOdv069wufhfTipXzjL
	u5gyUcajhVCSJ91SrAr7TnsuU0IA22Q=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-CJdcrUDsNmic4G9pn18bFQ-1; Wed, 03 Jul 2024 21:04:08 -0400
X-MC-Unique: CJdcrUDsNmic4G9pn18bFQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70af5f8def2so149091b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 18:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720055046; x=1720659846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1UoAoUE38XfmtGte/DbdgJX2un8zCdfajv3hxrPb+Q=;
        b=GD/hKqu3MsKHMg3OhJA+H9sZHBTgs6VrIfTqV8nZLr/KRsa0qUpiz9H8altZ+UaakV
         A/pdazzaHUV/vfh67zX2XlKBhPzpkpGHv44ts1VsUui3cVACwi1tpmDpbj89ljkbjyzR
         DwkdK5nqtPWi+VroQPACptbQyDyG/x234uPSutZPbZR+/lEja5sUZse6t4BHFhDBHypV
         xNnFSSUrbIKqGQnHfwOiBaXUwUvPbQYwxJvOt6Vl/xxTfqQubKc2mDU3ybVxAySr4CV6
         Dg705W0Go5f+wf6eIB6+FHAoVgf7jKuBwE4nfvqedjZ9+jV+oRurks4vOvNwQ0HrYvO1
         lxqA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzgZehTOGohO5rwnYcw0PYTWEQA+FN0LD1cdqVsHfVZU+bjzAMzjwy4BDSxvlZm5Q7RlcteFLz5swvuKy7Ri8DzoM09rdJmW+dwiaBg==
X-Gm-Message-State: AOJu0Yx6zyruy1bo/GulrzA45Kcn716KcDgbgENyQLr+eIcYJiKV2NOv
	ec46R9JxcQ2CZzkMJi+dzqJXwqvF/R8SPaQBycAIzqg4xS2vMHY7IIEiDPuCkHGg2cDZNCwa91R
	fVX1IHaNeuVDdhwch0qUqfY+Hq8P4XEupXsT1a3sZ5hEMjwRdRCAXpVIlLVmBlraGdCdFcDo=
X-Received: by 2002:a05:6a00:1146:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-70b0094b3abmr180113b3a.13.1720055046136;
        Wed, 03 Jul 2024 18:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfIJ/5XnqU2+b+txtAVcJ5itbgOcH5WsQHwDhGMl3SRQ1HIB+g6wofHASN71XW74raXe0ekQ==
X-Received: by 2002:a05:6a00:1146:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-70b0094b3abmr180090b3a.13.1720055045668;
        Wed, 03 Jul 2024 18:04:05 -0700 (PDT)
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53ae0sm11080447b3a.23.2024.07.03.18.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 18:04:05 -0700 (PDT)
Message-ID: <9f455425-2a82-4a8f-aeaa-71ebe6a7acc6@redhat.com>
Date: Thu, 4 Jul 2024 09:04:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfs: don't mod negative dentry count when on shrinker
 list
To: Christian Brauner <brauner@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20240702170757.232130-1-bfoster@redhat.com>
 <e2a34e4d-b529-4ee6-b921-f54c3935f253@redhat.com>
 <20240703-nachwachsen-funkt-23b2e942dd87@brauner>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240703-nachwachsen-funkt-23b2e942dd87@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/24 16:22, Christian Brauner wrote:
> On Wed, Jul 03, 2024 at 09:48:52AM GMT, Ian Kent wrote:
>> On 3/7/24 01:07, Brian Foster wrote:
>>> The nr_dentry_negative counter is intended to only account negative
>>> dentries that are present on the superblock LRU. Therefore, the LRU
>>> add, remove and isolate helpers modify the counter based on whether
>>> the dentry is negative, but the shrinker list related helpers do not
>>> modify the counter, and the paths that change a dentry between
>>> positive and negative only do so if DCACHE_LRU_LIST is set.
>>>
>>> The problem with this is that a dentry on a shrinker list still has
>>> DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
>>> DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
>>> shrink related list. Therefore if a relevant operation (i.e. unlink)
>>> occurs while a dentry is present on a shrinker list, and the
>>> associated codepath only checks for DCACHE_LRU_LIST, then it is
>>> technically possible to modify the negative dentry count for a
>>> dentry that is off the LRU. Since the shrinker list related helpers
>>> do not modify the negative dentry count (because non-LRU dentries
>>> should not be included in the count) when the dentry is ultimately
>>> removed from the shrinker list, this can cause the negative dentry
>>> count to become permanently inaccurate.
>>>
>>> This problem can be reproduced via a heavy file create/unlink vs.
>>> drop_caches workload. On an 80xcpu system, I start 80 tasks each
>>> running a 1k file create/delete loop, and one task spinning on
>>> drop_caches. After 10 minutes or so of runtime, the idle/clean cache
>>> negative dentry count increases from somewhere in the range of 5-10
>>> entries to several hundred (and increasingly grows beyond
>>> nr_dentry_unused).
>>>
>>> Tweak the logic in the paths that turn a dentry negative or positive
>>> to filter out the case where the dentry is present on a shrink
>>> related list. This allows the above workload to maintain an accurate
>>> negative dentry count.
>>>
>>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>>> ---
>>>    fs/dcache.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/dcache.c b/fs/dcache.c
>>> index 407095188f83..5305b95b3030 100644
>>> --- a/fs/dcache.c
>>> +++ b/fs/dcache.c
>>> @@ -355,7 +355,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>>>    	flags &= ~DCACHE_ENTRY_TYPE;
>>>    	WRITE_ONCE(dentry->d_flags, flags);
>>>    	dentry->d_inode = NULL;
>>> -	if (flags & DCACHE_LRU_LIST)
>>> +	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
>>>    		this_cpu_inc(nr_dentry_negative);
>>>    }
>>> @@ -1846,7 +1846,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
>>>    	/*
>>>    	 * Decrement negative dentry count if it was in the LRU list.
>>>    	 */
>>> -	if (dentry->d_flags & DCACHE_LRU_LIST)
>>> +	if ((dentry->d_flags &
>>> +	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
>>>    		this_cpu_dec(nr_dentry_negative);
>>>    	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
>>>    	raw_write_seqcount_begin(&dentry->d_seq);
>>
>> Acked-by: Ian Kent <ikent@redhat.com>
>>
>>
>> Christian, just thought I'd call your attention to this since it's a bit
>> urgent for us to get reviews
>>
>> and hopefully merged into the VFS tree.
> I'm about to pick it up.

Thanks much, sounds like there's a v2 on the way (which could have done 
by now).


Ian


