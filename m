Return-Path: <linux-fsdevel+bounces-56742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C28B1B327
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A353A9F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9F26CE30;
	Tue,  5 Aug 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKP9VE4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD32F30;
	Tue,  5 Aug 2025 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396038; cv=none; b=sFBU2XYfpu4GyRI6oAt2a7eahVOCY163rcTF8hQ2YEXb0XtxQABcXrKyU0Wd8fiARhbepMgNWOcACD+AqUNI+FzA6d1mIdqvW+w8C9x2V3zNA2O+IHB6dcGjfyjjE3lmDuvvRlFFV1zDnRayA0z9seyO33egX5i3OAhusuDfbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396038; c=relaxed/simple;
	bh=dx+w+PWC8dN+bRqgmmkr1t8wrpUe+dWzeDNdxXYKd7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfbLqb4cNNd3PqsPGO/69i7bPTrvvbfsyGOqBv2ZKJYBHV5Y68/Spf4hHvnIpRTKwEuhEXw/D6RwH9Ez7ZoIjHav3UVEXpaxKtLyTnc98CPAgRXgg7t28YPqr5vqJUCM05OkN8UTgHRcv3UN3zJPq8ac9j/s2pr7/lvzwQqjurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKP9VE4p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7848df30cso3927165f8f.0;
        Tue, 05 Aug 2025 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754396035; x=1755000835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQRMFhKZNRLRVXrqn1NUSMh/FhCDWMwTV0xGjqW0gQ0=;
        b=mKP9VE4p1htIiQ3ruqTuCpR31Q8VP+wj0S0YmatklltEMAFuLUzbO1pBIzCoh75C+3
         AdqNxZORqaElNOkxZ8DYXc15yCDdnu5QOBKOXGXAPog2O02OyD0uRB3rhrji0SHYHADO
         78uVRGWK/uExaWg1R7DwqG8bEgodCyYOwibbY053I9AS70u5BzxRf6nmTMmAuyRKIV8e
         VBu8dbubZ6PYon11a31f0MLLowr30dOyGtjbK0eJqvV/EZgCPByeWPaNUqzfdUP5Hrwa
         6O7N7bawG6bHsovAXaYFW5qoYW0AkDwDYYz+0PYGq5xHPHNkZ1RG2t6asMGaHo+d+kHS
         pFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396035; x=1755000835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQRMFhKZNRLRVXrqn1NUSMh/FhCDWMwTV0xGjqW0gQ0=;
        b=v7FfM+tktzjOw6rgzzNJ867S4eh+V5/BS9zKITe7ItByObMgo2qzw3g5c/m5+K18Fi
         0csjMJoWtvwpAI62dcAzu8KSARuN24ebqNgX/0rHNMmMPxHHvVxc2+0kvFvQMfbigj79
         MFf6OkVwjmBizCMGzv1L1AlJPF5ggUgZ3BzNd2zODf9R/ZRrGktMckQtDMm8RBJs1hXo
         ErrfjFBdvKft2x4S9AtLb9vwX1xTBdHAY3WyGOxHjjaWJ1ASC8Nqy4nMPb1Fk2iu27wh
         txUuEEgpbfZWa56ih8UG4tErtnhbRAFJx5mQbHTXd4ZFFkdne1BHcx0tfnOuICWzJbBQ
         7HzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYNjcqExn6RuZI1Qg7LyBNJaow4q7BiSvMY5Ujy6bdGSOh3eSeY50iDsa1RmERHPfB39sJeXfxbtFbdnFQ@vger.kernel.org, AJvYcCWj8+A8cPX3Neaaf0lal7M2KBg+tbYKpo04v/Qo/kQRdwBmfPOPzohQqwlm07GoGnI9382RGWDf0xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9UeuaLRgYNaqufkOG1qTbmiCPiFx2wiG7EhPNFjP3ZkyDo65
	1JOIh55Zd/7e+1WwS5lzNGPzKQHLNIBQzEacoX6q1bAGnbTxN/40C6ET
X-Gm-Gg: ASbGncs948v82Eqq3MoDB6budv5ROBPGeMPpKh8YmH1o+7Syq/Zfal2uVr8G8nRWtXe
	ud0ipbAJ73gb5AL34F2Y18ilAkE7s6vVh/EzsuAEbxYRwiQRfkIVyOrSVsut/QSiWwl4qnTC1Ul
	qdsNZJAGyr7aklPmiKKO+Lj1xq4SZZHon10ky6xcBTQffLmVzKSkoJn3rKB/lAn1CnqewP4pbZn
	YiTV7dOzZ7fuxrf2rA1qIe71plpiRC52AwlJtuJYeDKCQUyOqELRtGIhL8NXKV2b+1sOF3l5Ctq
	Mm3wlROSbEoPUC1XsvRUSA3CenOmkBOH4KKXqhtXciMh6hMBPc98Re9yiiRDRnI5Nxa+5F7p4XO
	C5cyxaTVVsVw621/R3ee/whJvb+8Xir8+o0tFWOBIH6XDa064blVMAEjSGpF17r6H3bf4nn64ZJ
	J/rEbtjg==
X-Google-Smtp-Source: AGHT+IGwRKtI0tVNRZIj++4L7ABQYvhpdiJwXLcYY2IEL2oHCw8906db2fHyLCpfcG5BZzaLfo/kpQ==
X-Received: by 2002:a5d:5f90:0:b0:3b7:90c7:325d with SMTP id ffacd0b85a97d-3b8ebc9e883mr2324975f8f.6.1754396034932;
        Tue, 05 Aug 2025 05:13:54 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac036sm18872226f8f.15.2025.08.05.05.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:13:54 -0700 (PDT)
Message-ID: <2c795230-5885-4a1a-a0f9-c8352b9e7738@gmail.com>
Date: Tue, 5 Aug 2025 13:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Donet Tom <donettom@linux.ibm.com>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <eec7e868-a61f-41ed-a8ef-7ff80548089f@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <eec7e868-a61f-41ed-a8ef-7ff80548089f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2025 11:30, David Hildenbrand wrote:
> On 04.08.25 17:40, Usama Arif wrote:
>> The test will set the global system THP setting to never, madvise
>> or always depending on the fixture variant and the 2M setting to
>> inherit before it starts (and reset to original at teardown).
>>
>> This tests if the process can:
>> - successfully set and get the policy to disable THPs completely.
>> - never get a hugepage when the THPs are completely disabled
>>    with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
>> - successfully reset the policy of the process.
>> - after reset, only get hugepages with:
>>    - MADV_COLLAPSE when policy is set to never.
>>    - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>>    - always when policy is set to "always".
>> - repeat the above tests in a forked process to make sure
>>    the policy is carried across forks.
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   tools/testing/selftests/mm/.gitignore         |   1 +
>>   tools/testing/selftests/mm/Makefile           |   1 +
>>   .../testing/selftests/mm/prctl_thp_disable.c  | 173 ++++++++++++++++++
>>   tools/testing/selftests/mm/thp_settings.c     |   9 +-
>>   tools/testing/selftests/mm/thp_settings.h     |   1 +
>>   5 files changed, 184 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c
>>
>> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
>> index e7b23a8a05fe..eb023ea857b3 100644
>> --- a/tools/testing/selftests/mm/.gitignore
>> +++ b/tools/testing/selftests/mm/.gitignore
>> @@ -58,3 +58,4 @@ pkey_sighandler_tests_32
>>   pkey_sighandler_tests_64
>>   guard-regions
>>   merge
>> +prctl_thp_disable
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index d13b3cef2a2b..2bb8d3ebc17c 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -86,6 +86,7 @@ TEST_GEN_FILES += on-fault-limit
>>   TEST_GEN_FILES += pagemap_ioctl
>>   TEST_GEN_FILES += pfnmap
>>   TEST_GEN_FILES += process_madv
>> +TEST_GEN_FILES += prctl_thp_disable
>>   TEST_GEN_FILES += thuge-gen
>>   TEST_GEN_FILES += transhuge-stress
>>   TEST_GEN_FILES += uffd-stress
>> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
>> new file mode 100644
>> index 000000000000..ef150180daf4
>> --- /dev/null
>> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
>> @@ -0,0 +1,173 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Basic tests for PR_GET/SET_THP_DISABLE prctl calls
>> + *
>> + * Author(s): Usama Arif <usamaarif642@gmail.com>
>> + */
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +#include <sys/prctl.h>
>> +#include <sys/wait.h>
>> +
>> +#include "../kselftest_harness.h"
>> +#include "thp_settings.h"
>> +#include "vm_util.h"
>> +
>> +static int sz2ord(size_t size, size_t pagesize)
>> +{
>> +    return __builtin_ctzll(size / pagesize);
>> +}
> 
> Note: We have this helper duplicated elsewhere (e.g., cow.c).
> 
> See [1] how we're going to clean it up.
> 
> Not sure how to resolve this. Probably, which series lands first in mm-unstable should clean it up.
> 
> I would assume that Donet's series would go in first, such that you can just reuse the helper from vm_utils.h
> 
> [1] https://lkml.kernel.org/r/20250804090410.of5xwrlker665bdp@master
> 
> 
> Nothing else jumped at me
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

Thanks!

I will wait a few days and see if it has made it into mm-new and rebase and send the next revision.


