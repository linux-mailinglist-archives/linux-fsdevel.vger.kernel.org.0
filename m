Return-Path: <linux-fsdevel+bounces-55888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89941B0F8A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2181AA77F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29FE211290;
	Wed, 23 Jul 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKKSDOf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E142F5B;
	Wed, 23 Jul 2025 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290476; cv=none; b=P8JXaYhIM4BorTzt9FLJdP3dsS82i2HwH6W2nngtp4MkdVYbpdKDRwi9SzD+xQLcS/dLwK04DPBu1JJNk2bsBeMxGAIc2olWHvrJecd9Gy+/GEwUIg+rVR8WYSUJl5W0yYT0sw9kIKi3WAEL8DWbRPlOKhQhhvBuRiwx7+c7BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290476; c=relaxed/simple;
	bh=g2R9pH8qwHCPvAl3xHV5HdWgV1ya5184ybwP2QEaD8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUIQUjLzT1etrlAIToy1cJsTAtfQ6Iq7motsELyoyisvbhs5x+NmrycBbPK6y49EK1GdfYD2BVKtjdSBZaTOnChyV5F5XbiQn5hOilQfQ5urRd73EtNnGxB7gjQnKcA8R3MihnzU31MBwTAuLcbnn0eZrVyWhDiw8As9/NtcwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKKSDOf2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3a604b43bso9870766b.0;
        Wed, 23 Jul 2025 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753290473; x=1753895273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJwGeL5vbr0CAZa06ENE24uApyyaPDnFcL5zBWsz7hw=;
        b=EKKSDOf2wvrA6YBo55iQnDbcg9xRsazAUmJb9oN3hKXlK3ekHJNSHpZQ31w1KEvRjj
         WTvT6Sk6jfsZEcsynnU3zIOjB/lhPkUqd66KP5U9OYGcweikGZYbSmQOzkJSnE82Qjzw
         HH0aGMT/D6qLxueyNk+U0PPWLdJj0xzV6TTP7eV4iz6D3+5Q2lfmb88OYJ6UDG3j/LP6
         Mnjav05UYP0E0G7BO74tYUwLj38io0/J20L6Zs3a+84x7MPKZ2nSdxwHuDjk+1cuOuL/
         B4twcpYMS3PmOHIOWxwsDXGhKfBQ8nWM7zBZKDUWfGbgvegYClq2xSf+Zt37zUIA5HIK
         QiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753290473; x=1753895273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJwGeL5vbr0CAZa06ENE24uApyyaPDnFcL5zBWsz7hw=;
        b=vNZ9VOZ4tDe4jCE5LofAQk4p5nnPPxzVTbLQc3maED/VE1sy+6TQkom9h9Vwpb/HH1
         ov0c29AaCC6hsXPlmcd1XzNnTEG1QucLS6Ory8/bI3UAvukIBgSvEGBl0v6BhgXnE+pM
         uzJCPvv1lKBeMPjabpynkTecMUrK2UcYIyeUHS99jrugRZAw2E/RRxi699Slc6d9wPAS
         OZD3ntKz1etouYvqGP1ZqkFi/2ZuLrzpM9E7GnvorEwgmzXGNhLGsS8udaDZJy2cOuBY
         hsTMZG0uoU6VhTwmehUzphRlzREthxEFHEQm2rziNoq6uu7yiPkiZOM5SUBt3ahbKCbU
         KLGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwz5N/P3aGxEKj2Q3qIOAm6DuQMHog9ge8BldSif6mGTYosTFdWjzOjdKY87QZlmsxKE8dww5rBEc=@vger.kernel.org, AJvYcCVeqCrRVzbD/oP3dZIf5OQZw0V2A/jPGbxANiQ+aeXZy1UKUai7RuJuBrvm1RvPOlinEBT5IXrMTG+l1Evu@vger.kernel.org, AJvYcCWUf70AblT7MOzE4eIEB/fOfm/SLerUqbOVpAwt4zzE9O7v9hDaTRYZT5l/YqeEKfYrQ/c+36PefT/hm8hX2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrYB+3K4zkJtREUUHIwspiMQ5XFO+5HnWcOA3MLE4BnKf6bQp
	9tKZVcrSD1SBgLFe9Gwv5Iwi7V885UDJTBTFcAhF1ccQScO3iusSkoJ8
X-Gm-Gg: ASbGncu/xsUEnKVqqhxPE8FVgHqNvokLFqzbismsYEX7NYrikGm8YFP8z6MHbHjnWMy
	yQXaoQ8d8IyL/W9uPVqA7suzPM7x4ZrdDVdwSUfJzMDejzlg14HjZ+jffyinI7v6kbBtXUYTpJ3
	cwDPoQ62YAWun/RvinIsE8gpqfq1uVpV2mVB68TIo6PS4kTQJhKLAq0FMoGwmCxclRRmN08xzcV
	syezrsmpfGzmQOuozMnp1x46yP4EYT2z8vgPHIOMBLalyJKtEB5kQIbOhJMAEugdcA1YnhoA5K/
	Pekoz0hRJF4Ij+t0zz74xQ3KQpUSmVpM6/2sAHzsNTQZA+UJQm4gCqLtcuxebo5NLQmOVMb9LAb
	6S1CzMjLa22IgesRmn6y7MZK5ZLwHv2oBXcIErFsGS1BCxZKOBov2UoXi0X4Ln+exa5KpVg8=
X-Google-Smtp-Source: AGHT+IEhIAINLFGBCVIL5RbbqN7hXbRXTMoAEW2u3tmGCS6C7nD30TNkiWqZ+FZwuJUNa1U4NY7GhQ==
X-Received: by 2002:a17:907:7e84:b0:af2:844e:a72f with SMTP id a640c23a62f3a-af2f8d4ece7mr344718766b.47.1753290472394;
        Wed, 23 Jul 2025 10:07:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::4:45e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caef924sm1075303366b.156.2025.07.23.10.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:07:51 -0700 (PDT)
Message-ID: <003c12a7-cb3b-4bbd-86ac-4caaddcabf26@gmail.com>
Date: Wed, 23 Jul 2025 18:07:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
 Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250721090942.274650-1-david@redhat.com>
 <4a8b70b1-7ba0-4d60-a3a0-04ac896a672d@gmail.com>
 <5968efc3-50ac-465a-a51b-df91fc1a930a@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <5968efc3-50ac-465a-a51b-df91fc1a930a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> Thanks for the patch David!
>>
>> As discussed in the other thread, with the below diff
>>
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 2a34b2f70890..3912f5b6a02d 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2447,7 +2447,7 @@ static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
>>                  return -EINVAL;
>>            /* Flags are only allowed when disabling. */
>> -       if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
>> +       if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
>>                  return -EINVAL;
>>          if (mmap_write_lock_killable(current->mm))
>>                  return -EINTR;
>>
>>
>> I tested with the below selftest, and it works. It hopefully covers
>> majority of the cases including fork and re-enabling THPs.
>> Let me know if it looks ok and please feel free to add this in the
>> next revision you send.
>>
>>
>> Once the above diff is included, please feel free to add
>>
>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>> Tested-by: Usama Arif <usamaarif642@gmail.com>
> 
> Thanks!
> 
> The latest version lives at
> 
>   https://github.com/davidhildenbrand/linux/tree/PR_SET_THP_DISABLE
> 
> With all current review feedback addressed (primarily around description+comments) + that one fix.
> 
> 

Hi David,

Just wanted to check if the above branch is up to date?

I didn't check the description/comments, but it still has [1]:

if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))

and not 

if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))

in prctl_set_thp_disable, which is causing the reset to system policy case in my selftest to fail.

[1] https://github.com/davidhildenbrand/linux/commit/5711cdf5dfe65ca28dac2a57d62e18f1475dac57#diff-dc9985831020a20a54baf023fec641593d0d4e75a78988c3b35a176aff1c0321R2450


Thanks,
Usama


