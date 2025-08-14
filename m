Return-Path: <linux-fsdevel+bounces-57868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E72B262EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5D13A4201
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACB22A4FE;
	Thu, 14 Aug 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P34o7jbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10219E81F;
	Thu, 14 Aug 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167820; cv=none; b=qe/C5cTjDLK3Cz/o+Skga9Xt6/Niw16D7IUBjlMfCumXv2ADWGX30mX5OgWVqbB7dQH9ejfHjp6hdi0wiuxHbi8kvsytLPYuE2KJ4+7H89neX10h7H5i3AVa23qhOXOZDW4jNBfV+/5jRnw0IrbsOtzT/YZQwfUCP7REVfXqQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167820; c=relaxed/simple;
	bh=xYJyqcO+Td0zxAage55a0CosNYRmN2fawTCHC5Ql6e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsOCBOOK/uhyiiVKTImBlXOdiEcsU6A/ivdrS2ZNroJQDPH1vN8ERnXOjojOfpyrhkr6X0gx8j0dAjuhKrpI6so5FJhd7eb5XJFXQnPx1H5btsi8hScYEivcNDZGLoZfhC9SjQckVSMMLgMiQiU07Xdx/23owR/M0E4JF6Zx3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P34o7jbB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so3712625e9.0;
        Thu, 14 Aug 2025 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167817; x=1755772617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZ6gQfT6325DrhCJg07rbAmAUq49pVA1Mr8s55Uj+I4=;
        b=P34o7jbBba+6PTBh3eewIqCytR6mqHP9REJKeAx4HzXqDC0slnQp6sydJQqzqFNIqI
         kAkV+Uh3YIMEWB4Rp0f/ci5Wa+YdbMD8Geblt8iPhazt0LY8cx4EUVnT05PaCJwmRAqd
         D4AUug7K5s3/vjGZy7opBdDd4Vt2eWbZ3lOIo5xrbaxZH/scwYv5fonobSVDjv6p6msl
         Bw8c5lsCmvegJiSc+sCgxGcWEVJ0d/7X/odP9Hij+IecYiWX3VdnkcMKJDRCPInw9O5I
         kO9Waz3q6RihUyih/dBqwxvyXsWueDGCo6/QU9tSShHJecdHPFt7COzLcxkTFH1FvXlK
         OG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167817; x=1755772617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ6gQfT6325DrhCJg07rbAmAUq49pVA1Mr8s55Uj+I4=;
        b=hGTqdofUpsWkD16tSc01FVT6S+ls4oQZ64rjKcWKZBjS+6ACLD+mt9G8o8gE6COL7K
         zUhmNvDUKVbNgCeYXNTNEyI7jH7dSan3GNy13LwgiWN4e+yjMcqxKxzROEYQh8DLuGFl
         O1L/o+16d0jzqrfL4KGOt2nnPcxWBzwK+MB3N74sUSywKhLhxQL0DZ5gjBK4mUou1Psf
         j1BXtU+rBvt+2gTT9/5gjmQlCRCUriFwR/6wVtbbkN2MoCjA4je9qwvIufqhNOqka5wg
         Yv8q0mL9xecQ5opeTW9r6qdHG81ny3Q6OxuB3puBVE5CQW6fbRbGlCaUoiQTsT/Uqjq2
         yU3g==
X-Forwarded-Encrypted: i=1; AJvYcCWLndl/4HYpgSHd/cFMIiKxtjdcNrVUEXXWl2zlvqSo9e3DY/0yZP7MG3PCGSHOLBhdP9a2xKczrQo4+cmy@vger.kernel.org, AJvYcCWiwav6/1CBr2ffi00X6v0bE+a6JkmQLbISJi35qvtYS396Buey+lN2cj4XEOz9ifPp1e2jy2vs/LFV6WGChA==@vger.kernel.org, AJvYcCXGRlpConEiP+YTWVp4+MCk8rp0kYoQcsFgFSL6jRNIUexXiVkvGsj/EFcYvQGPcGj9QM1MLvCjrr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bf9eeVxkEekJJ4grPdS9vgwPiEveoMSxB3rWMKZQm97QYdXI
	//e5vi9RAZs74P7P95BLqGz6YPgr3vZwv0xDC1DS7NPfrQWNimIApXuI
X-Gm-Gg: ASbGncuHa6eUHzrIJ1rRNZqHCYU6DKHvii5SCRKU+RHucqntn6snbLVUWRkV4VwGGUO
	qjuLCm1oLWdK2qKJz2dLMNT3uSRjukpeHNjM0nwwWWD0uP6LY2JuaeGVoVzcPQkn1SzxB6cfr/G
	U7MRBXc/BNXnAhK0V+GuTJ2RTS53N/oW+FWjGvmjQVJSFsfMbavvjzNJBv2xHSJk2E6zCs26h8p
	ZR4pr4pHzdKOBxGWY3Uctm/N7ft5GEw2S3YrGYsLiBP5M1+pJaz85YzDVERF3PYRoU4YtXPRvcR
	vry1WvuUvUEcX54IqnRSGkaQzBE7YD0TqWR0z96SvtuupY6CAnj7/7O3WAaomNTIsdfGhrbjH7V
	pHwK57JlSWq1wFhhSSYkg4Lpsyr4YgSVDroSNcU/gYsyf+obU82xTlAm+UeQrsftc9IAA8SI=
X-Google-Smtp-Source: AGHT+IE9AwPEDaKR+KjejS9PbwUO3RCQq0PbGo95Hon+5KFFW2EiEVkrk/aM+Rydn7mH+KdWdrrzhQ==
X-Received: by 2002:a05:600c:46cb:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45a1b602f28mr21995305e9.4.1755167817082;
        Thu, 14 Aug 2025 03:36:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1ce9758asm14558735e9.15.2025.08.14.03.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 03:36:56 -0700 (PDT)
Message-ID: <1ff24f1b-7ba2-4595-b3f6-3eb93ea5a40d@gmail.com>
Date: Thu, 14 Aug 2025 11:36:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/08/2025 19:52, Lorenzo Stoakes wrote:
> On Wed, Aug 13, 2025 at 06:24:11PM +0200, David Hildenbrand wrote:
>>>> +
>>>> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
>>>> +{
>>>> +	if (!thp_available())
>>>> +		SKIP(return, "Transparent Hugepages not available\n");
>>>> +
>>>> +	self->pmdsize = read_pmd_pagesize();
>>>> +	if (!self->pmdsize)
>>>> +		SKIP(return, "Unable to read PMD size\n");
>>>> +
>>>> +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
>>>> +		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
>>>
>>> This should be a test fail I think, as the only ways this could fail are
>>> invalid flags, or failure to obtain an mmap write lock.
>>
>> Running a kernel that does not support it?
> 
> I can't see anything in the kernel to #ifdef it out so I suppose you mean
> running these tests on an older kernel?
> 

It was a fail in my previous revision
(https://lore.kernel.org/all/9bcb1dee-314e-4366-9bad-88a47d516c79@redhat.com/)

I do believe people (including me :)) get the latest kernel selftest and run it on
older kernels.
It might not be the right way to run selftests, but I do think its done.

> But this is an unsupported way of running self-tests, they are tied to the
> kernel version in which they reside, and test that specific version.
> 
> Unless I'm missing something here?
> 
>>
>> We could check the errno to distinguish I guess.
> 
> Which one? manpage says -EINVAL, but can also be due to incorrect invocation,
> which would mean a typo could mean tests pass but your tests do nothing :)
> 

Yeah I dont think we can distinguish between the prctl not being available (i.e. older kernel)
and the prctl not working as it should.

We just need to decide whether to fail or skip.

If the right way is to always run selftests from the same kernel version as the host
on which its being run on, we can just fail? I can go back to the older version of
doing things and move the failure from FIXTURE_SETUP to TEST_F?   

>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>


