Return-Path: <linux-fsdevel+bounces-48426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9850AAAED70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7E63B9356
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069D28FFFB;
	Wed,  7 May 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qn+qzhC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EE28DF37
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651059; cv=none; b=KUZRQT7oNJMAnOVZb3+1GsJQ1j4y3N74v05FzgCVpk82tE/9aTf1ET31xau74rc23UfRMwFn7JuuFpw5XZJnPMu/xwsu7wH8ibPHBy5ClTYWZi1twpRSjFUYoHiXCtKa9RzOrT/OhKWnUWGDpPChtU4yRKLyMtY6xMRZPAO1gys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651059; c=relaxed/simple;
	bh=aK1tvNbc65kXi4eTJ4y1WbB1Yq7chC+uIx6eWtLwSdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcChvYFTVDF/0VWbArHqxVIKz7oO9ovCtFGas4Uwqw72+LUzsE/wz4Vwx4cxUJvkbyGxVrF4CavyQb+4e1QENRaipVJgEGqYr9aeI82iMY+w5UHH8m5YevAu4MX/m99vcrrI9pnjShClTvOtKVwJsDdTuEmbfXL7AeM3A+Aceao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qn+qzhC4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85dac9729c3so18117639f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746651055; x=1747255855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1i3VA5pX+AnNv8o3MlfdxwnFv3V4vTyMLMmTMdRyK8=;
        b=Qn+qzhC4kB08fRop1tL1Iw9IMdwEJAfD0hq8Ox0Hv6jGnIQyF0UH9FAvWsOriDQXX4
         6FAMtzPouqa55+FvAwhiBkAImQ9BQhM7X4j3ZVCXf6sDG8WgVh0DBlHSvI6nP3ppFnzY
         h40Zw77fSuU8H+dF0FMKaPFsZHo5iUhTgXuUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746651055; x=1747255855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1i3VA5pX+AnNv8o3MlfdxwnFv3V4vTyMLMmTMdRyK8=;
        b=R5hgNketj2YNkGbFpYZSgQiBSfBR5bOCPuSpUI79Ma4Bx7vfGOgtjcsR6nNU0b0gIO
         RDYC1zjyhsqtnwPldH86eA7Vfj6asFS3hHEf4CqsPUKFU22VQU+pB7e0xHWWfvwn4DjX
         FVRfRMBMAh9Ah+ZMI6tHyl5yeEBM9t8+U9o8BW//BJaB4if3e10HzztjcEBdNU/ScZaR
         NUtc/2HapQG6NVWvJI11SIpm7Lvp7/MUvk7Q+YVa4XQb1G0XA3lB1g7qRHiPUlnRw623
         M/6+cK5pytvYIdgJs/fC+D8tVq1ZJQwV43zS9zl9HVDtUnl0MOiyExWAnY/SkHqSSdAm
         1OYA==
X-Forwarded-Encrypted: i=1; AJvYcCUxnkx9OM4GeRHdz59AekngZX7S+d42x+wKuIyUu4kJ/D9z4JYL1j8qeIJ4s9SZbbi3AZI8IBTvTscsSk/S@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrI6hUjYcn8Htuz0DC46Hkg2gbQ/ZgFAGaGwfTHPoGEGffT3S
	0dFe2hf1K6vBNvPOhAQlE9PueXy+O05Mr4YDayuWb0WJ8OEWHce1ZJvtz/BLRD0=
X-Gm-Gg: ASbGncsQqiw8l0dzL4In6FqeY7Z3rKaePQFj1EBhKeGOXauIT/rJa/tGFXZeh+HMPqL
	Wr93aGdWeL7BKHMSobs90FUhlxvjRNkn/lWjpcARbDW+Dhqk3cbINIKJzJ7gXxK8p2TvL94NnCM
	sHf2xgmlLQaznDZ1TgYkrQigUTfmzY6YlX7ngy428z971EpAvZCD0hCRfTROLYdS467/QBRInQU
	gxFI7VwlYDrU/Mvi+4lPNTK2lE6SPIhWc0CTmGhq3ZcqPKQoDDzzu7QKXcBv36yt0Ieo7nvdNsh
	dvi4dZHrGHRGxp2S/Wy3t9c2R7Tpg5fnwZgawncxEKs+IKnIsJw=
X-Google-Smtp-Source: AGHT+IGXfbY2TdlADjhrlZDdaegNr623acfnrkFbqKORg+uz4s4neNOrD9k8reaOICCdp3cse52JQw==
X-Received: by 2002:a05:6e02:1489:b0:3d9:5d50:e3b1 with SMTP id e9e14a558f8ab-3da739304a7mr62088825ab.18.1746651055223;
        Wed, 07 May 2025 13:50:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975eca7b6sm31478705ab.38.2025.05.07.13.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 13:50:54 -0700 (PDT)
Message-ID: <e87bbc68-0403-4d67-ae2d-64065e36a011@linuxfoundation.org>
Date: Wed, 7 May 2025 14:50:53 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The "make headers" requirement, revisited: [PATCH v3 3/3]
 selftests: pidfd: add tests for PIDFD_SELF_*
To: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
 Christian Brauner <christian@brauner.io>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com>
 <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
 <3687348f-7ee0-4fe1-a953-d5a2edd02ce8@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3687348f-7ee0-4fe1-a953-d5a2edd02ce8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/24 10:47, John Hubbard wrote:
> On 10/17/24 9:33 AM, Shuah Khan wrote:
>> On 10/16/24 20:01, John Hubbard wrote:
>>> On 10/16/24 1:00 PM, Shuah Khan wrote:
>>>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
> ...
>>> The requirement to do "make headers" is not a keeper. Really.
>>
>> The reason we added the requirement to avoid duplicate defines
>> such as this one added to kselftest source files. These are
>> error prone and hard to resolve.
>>
>> In some cases, these don't become uapi and don't make it into
>> system headers. selftests are in a category of depending on
>> kernel headers to be able to test some features.
>>
>> Getting rid of this dependency mean, tests will be full of local
>> defines such as this one which will become unmanageable overtime.
> 
> Not if we do it correctly...Please do look at the reference I provided
> for how that works. Here is is again: [1].
> 
> The basic idea, which has been discussed and reviewed, is to take
> very occasional snapshots and drop them into a static location where
> they are available for kselftests, without disurbing other things:
> $(top_srcdir)/tools/include/uapi
> 
> This has worked well so far.
> 
>>
>> The discussion should be: "How do we get rid of the dependency without
>> introducing local defines?" not just "Let's get rid of the dependency"
>>
> 
> Yes. Good. We are apparently in violent agreement, because a few lines above,
> I wrote:
> 
>      The requirement to do "make headers" is not a keeper.
> 
> The "make headers" is the problem, not the fact that we need to depend
> on various includes. And so the solution stops requiring "make headers".
> It gets the includes from a less volatile location.
> 
> Yes?
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e076eaca5906
> 
> thanks,

Posting this on this thread as well -

Peter, John,

There seems to be confusion regarding  KHDR_INCLUDES. Tests don't have
to use KHDR_INCLUDES if they don't want to.

There are 4623 test Makefiles (excluding the main Makefile) under selftests/.
Out of those 73 Makefiles reference KHDR_INCLUDES exported by lib.mk and
selftests/Makefile. The rest are happy with system headers.

The support for this KHDR_INCLUDES was added just for the case when a new
test depends on header change. This is the reason why only a few
test Makefiles use it. When test rings ran into issues related to
dependencies between header changes, we recommended installing headers
to solve the problem and introduced KHDR_INCLUDES so test Makefiles
can use it in their Makefiles overriding the framework defaults.

If your test doesn't need it, you can simply stop referencing it or
use the approach used in mm test.

It is a manual step. Works well for developers who know what they are doing.
This isn't ideal for test rings. This isn't an ideal solution really.
It works for the mm developers.

# In order to use newer items that haven't yet been added to the user's system
# header files, add $(TOOLS_INCLUDES) to the compiler invocation in each
# each selftest.
# You may need to add files to that location, or to refresh an existing file. In
# order to do that, run "make headers" from $(top_srcdir), then copy the
# header file that you want from $(top_srcdir)/usr/include/... , to the matching
# subdir in $(TOOLS_INCLUDE).
TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi

The issues Peter is seeing regarding KHDR_INCLUDES in the following
tests can be easily fixed by simply changing the test Makefile. These
aren't framework related.

kvm/Makefile.kvm:    -I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
x86/Makefile:CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
futex/functional/Makefile:INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
futex/functional/Makefile:CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)

You can make the change to remove the reference to KHDR_INCLUDES.
If don't have the time/bandwidth to do it, I will take care of it.

If test build fails, you can then figure out how to address that.
Hopefully build issues related to header changes are infrequent.

thanks,
-- Shuah

