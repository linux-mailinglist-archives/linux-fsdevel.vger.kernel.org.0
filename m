Return-Path: <linux-fsdevel+bounces-56411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C45B171CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DB94E6C75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6942C3245;
	Thu, 31 Jul 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aolaepm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255273A8C1;
	Thu, 31 Jul 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967572; cv=none; b=gqO59FHyaEnCIVdU0iC+Mcq0qM0vXSTnmmg5bRs94I/nS3gKcjdM6LRhpnsk5dI5IuH8UdeQyQhiSIyDv7754eycI8hxk28CZpJJD19DMYZBVuk2FPtAW/MhTnZi7zQswn349aNvIFooO86PyX9RiHNXLVl1J9FUWei6cQ4ZLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967572; c=relaxed/simple;
	bh=2ZmX7sn6WqXiiCv2ozkaiBMaJRWIoJBKVEEHm5DW9eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fh9IwxsTVTegz2+RflAwRbELS4gvLrWbh3+RjDz2p5+kI0CoUfYKd25YzqpafYoM6kaICwhZXXNNuKarPHIwqt+W8T3/LinMOus8yPqRV3moE6/9rM1rE/JeY3PbLbJSul1LDcgtnCwpzqMwBY/DH4aVJhNZz/sNhVxOMssbtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aolaepm/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b79bddd604so314310f8f.0;
        Thu, 31 Jul 2025 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753967569; x=1754572369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqqlX6H3NPp9rTTwA7tpGQOcaxAxM3NcsBHKv6NCffQ=;
        b=aolaepm/SbDWKiGBfHLoyW4O3kH1XGLZ5KuBwRAT/kWeM3X0xlFY9acmaYAqeiurZm
         aVGa3Zw7PxKOL+Wfhb33MMFSFPTmCcYLCBNiL+7dzNO6xDEroTbHL6ZND0l9rhd1lYzB
         GK3tyiV9q74NazTIbaWA+wAx5sSeHYsUZyiz9wJChvakgbkW98PuzXneGKHGXPb9PhPL
         ovdcnr57xbtsFvkOURribFnK+uRWyXQttyWiSv7hYdq5GKMVdx3CVRe9aiO8y+BTz+C/
         s5eWa2+wLudRmt5Lpf41r6zMAbR90IKlY9TpzbFaT5qBputU7wrNOa9x8ezWdfkCYWKU
         oPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753967569; x=1754572369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqqlX6H3NPp9rTTwA7tpGQOcaxAxM3NcsBHKv6NCffQ=;
        b=moOPRbU59FQ2TQE7GGk9kQcytjmr32dZJnPMoaciYoX4DclV6Xu605VFQpK+wjzF7I
         5ocEQuy+hlxdj25GoGuioXxrKlmt9MHFld+P9JP3U1S6NurHhdU2V0kJKkHnwwmDKYxI
         JbBcbaPdp9Zhxr5W1m1gasgOCS1NetuSAMjSM29J5xPIqjThe8TFoWQoy5QUBfgtJ9I8
         cmY9ygj2f8E2hLdhuxUUegUFK+LpBpo76Iollj+siVLVnpHGBDaS4tqybkNu0Q+wFQmT
         NTbdULPkWsPfN75Z9ZDZnMGzBw3ogs2k7W/WWjzAImOx9dssWRZv6oxyT+zvuZr0Jm4s
         PRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOb8zuICL5dR/PN3q8zl2Ws30L8Ka0JyGLaZIv8fwoRnyOpngb1XotuvmRIcuWGAyTiRRPPQuxlE=@vger.kernel.org, AJvYcCVr1iUs8QV/Md+YuUAXjantQFd03r4huinbAptyqUBxNQI5Vgdw9xqHnW/g0L+A9kwkZrsnFWHY1mMcgX+EFg==@vger.kernel.org, AJvYcCX9pr57O5YuItJpEWljgu1V9nBQFAdocLsuLJJ7tYbUvbkvCeQlvBOdlsQlExK4w3HMkilMMtws8p2W7eG9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2CBDtTADZ6TK6a+9L0E8SdxrTO5B+vJdR3eAX0guDc0Asgw2u
	hW0KFajiXsBX5b1jHqQOxKhqAisYyZIxOoRj+6iydh4aBFO3BmfYOa8H
X-Gm-Gg: ASbGnctvs2vn0fQBDeErn8In1KYUiDPRfcrDk7srbxZvWp8/XY8ieK09y4ZH++bQTs/
	MLqaau9ZTOZn/K0rFvIj6OsPcG8gd3Iwvnz9iOMc4mRvJ7moZqxymZtggi6NCsLTQoPtoCYIWp/
	LCp4+VcOYA5vVWGuENqtceQFzlwMhoK5bwALrkFA/tGhg+cHXoL+bHoDLnozfOo5lpWB1fdiA+H
	M6Fvth1U9QlqjYAuXrOKODMtG033SjlUJopncfPfJUPoQXUhHrxWJqx3eI4pdqFNCyR+siDRvK+
	u2sxkaRJaeCJBRHYFH1/D+55py+IpTrbvN5/INmd0sNLeD5cQMFPhQioLR3xftqXXvEPA69bddE
	o6TUfrTY/UR7ZnTsbjX4VQeg75S6RBFiZDXvEV0kQj64Xk/VDdxsXIgwnWTmeIEVQTjqz3UsU0k
	PtTGH3KQ==
X-Google-Smtp-Source: AGHT+IGD13KMKtVRmBQPVTq0wp4e/PMVr1M8WgWSZYRxA7tPP99Spg6G2qe4tDRrHVIXUfkLlzE9cA==
X-Received: by 2002:a05:6000:188f:b0:3a5:2465:c0c8 with SMTP id ffacd0b85a97d-3b794fbe44emr5778988f8f.7.1753967569066;
        Thu, 31 Jul 2025 06:12:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::4:3f35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee621adsm27160265e9.30.2025.07.31.06.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 06:12:48 -0700 (PDT)
Message-ID: <c9896875-fb86-4b6c-8091-27c8152ba6d0@gmail.com>
Date: Thu, 31 Jul 2025 14:12:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-2-usamaarif642@gmail.com>
 <dda2e42f-7c20-4530-93f9-d3a73bb1368b@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <dda2e42f-7c20-4530-93f9-d3a73bb1368b@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/07/2025 13:40, Lorenzo Stoakes wrote:
> On Thu, Jul 31, 2025 at 01:27:18PM +0100, Usama Arif wrote:
> [snip]
>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>> Tested-by: Usama Arif <usamaarif642@gmail.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
> 
> You don't need to include these Cc's, Andrew will add them for you.
> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Shouldn't this also be signed off by you? 2/5 and 3/5 has S-o-b for both
> David and yourself?
> 
> This is inconsistent at the very least.
> 

Signed-off-by: Usama Arif <usamaarif642@gmail.com>

The Ccs were added by David, and I didn't want to remove them.

>>
>> ---
>>
> 
> Nothing below the --- will be included in the patch, so we can drop the
> below, it's just noise that people can find easily if needed.
> 
>> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
>> think there might be real use cases where we want to disable any THPs --
>> in particular also around debugging THP-related problems, and
>> "never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE.
>> PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
>> helpful for debugging purposes. Of course, I thought of having a
>> system-wide config option to modify PR_SET_THP_DISABLE behavior, but
>> I just don't like the semantics.
> 
> [snip]
> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> This S-o-b is weird, it's in a comment essentially. Let's drop that too
> please.


Everything below --- was added by David I believe to provide further explanation that
doesn't need to be included in the commit message, and I didn't want to remove it
or his 2nd sign-off, as its discarded anyways. Its useful info that can just be
ignored.

> 
>> ---
>>  Documentation/filesystems/proc.rst |  5 ++-
>>  fs/proc/array.c                    |  2 +-
>>  include/linux/huge_mm.h            | 20 +++++++---
>>  include/linux/mm_types.h           | 13 +++----
>>  include/uapi/linux/prctl.h         | 10 +++++
>>  kernel/sys.c                       | 59 ++++++++++++++++++++++++------
>>  mm/khugepaged.c                    |  2 +-
>>  7 files changed, 82 insertions(+), 29 deletions(-)
>>
> 
> [snip]
> 
>> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
>> +				 unsigned long arg4, unsigned long arg5)
>> +{
>> +	unsigned long *mm_flags = &current->mm->flags;
>> +
>> +	if (arg2 || arg3 || arg4 || arg5)
>> +		return -EINVAL;
>> +
>> +	/* If disabled, we return "1 | flags", otherwise 0. */
> 
> Thanks! LGTM.
> 
>> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
>> +		return 1;
>> +	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
>> +		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
>> +	return 0;
>> +}
>> +
> 
> [snip]


