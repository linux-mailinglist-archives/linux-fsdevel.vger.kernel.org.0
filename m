Return-Path: <linux-fsdevel+bounces-39726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A8A172F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030C93AA4F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC11F152A;
	Mon, 20 Jan 2025 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfcSwzD9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFA1F03CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399604; cv=none; b=SwWoKw/9JDK+OeA38rOTK0EZgBjO/f7gYkpRufjErQ2l2WjWrGGN164zRIB/geVijNiLJ4Tfvm4kzV3kHKv/tdsIuLP03GhXyC72NoB0+aeE845vtlFBUpHrG8NhQGDk5teI8hWr8hXlCtkA9WnK9kmN3l+CHuNYK0MXHr/HPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399604; c=relaxed/simple;
	bh=1SBWSBKCXS9fBSErX8/nKVMcvFxCIGDZ2mQxTl7qVJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnjTS2+jr68UwS7xrIf9mfjB7EZQuD8c5bsSI2XxlP4WCO5o8hH4FpLvx0WImVEZIf4cHkGj+RhHKj6JImVJ7m9WwEnNNlXqm/jsRQDjEDCYuvZ3fJZnP/t7DhewP1JtkTbKHIMLF2yi+MAmwuxlkwWbMSClytoxIkRiVIIXw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfcSwzD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737399601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pf/+pmtSEcW2J86C8PhnSXcNEKOxqEuzriHaKO+xXPk=;
	b=RfcSwzD9/CjzqKLSwCS+ZKZP/lbHE983EYUPDLT9DPFTYZqtNBkCckwPFRjRtG/vpS6hIa
	spmy9H+3HQT+rD46MQE3dbWAEYLRlCal8W1URPlFnGjwqLfHfW5h63fk0ev+7IkKGIr5xx
	MhYWxs6HEOrWMtTvaqI+jpiTSJvULiQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-4EjQZoQ4NY-S6WkyvzVDkg-1; Mon, 20 Jan 2025 13:59:57 -0500
X-MC-Unique: 4EjQZoQ4NY-S6WkyvzVDkg-1
X-Mimecast-MFC-AGG-ID: 4EjQZoQ4NY-S6WkyvzVDkg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso24900375e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 10:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737399596; x=1738004396;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pf/+pmtSEcW2J86C8PhnSXcNEKOxqEuzriHaKO+xXPk=;
        b=q/hF6744A8P54LON27LgFFjWjND3g0THm66BG6F2uT4GJTCcwvQsXw7fV2JoSq3xzs
         VH4QLz3vvUiALLsnT9lkuBdPkj/7rXUP9KpBeiLpVsO42VqPaY4FRSp8q6kv6Wt0qKRD
         4lxj61yo+o89U3EM8Xf/PhBS/lxKzoUJf8+hYYGUm0CAVTg/Vr5Jnl7R7mdJf1C4Ltwx
         1Xpcn6da66iFIEPWf4QLbNAyIP2uaoXJAOK5AkMgGxeVcuJjCmWkwcmH3+jrhdRl9I4N
         lu72sNTwFn7OycY219Ce2y2h0Me9mSRfewKsjg7te1qtYfu5vNPUMOSxYam3xJ8tevQR
         HPvw==
X-Forwarded-Encrypted: i=1; AJvYcCUjkRDYjw4Sh8yEKR8X7htR++dVN1n5P2UGVVZ88wpNmRoBCwQGDyOkoJ9PVLkV3jh4YxAw1BVWMdSEOfah@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BUxmgWomDVAeeuUN4kKkwikRUd5WIcNfxsVd4ZZwfgQvzKkc
	QT3KK2L1jMBBGpvABu9JqeQ3Bh/vifBoLmfulY6tOaNwfYz17wwD36MdWSGohXGRZt9oRYnVxQZ
	F0AwWxxc4BHrKHFpzVWF8Hullcpsk7kGt6oS8994Li/pyS9EDw5MrI+mRm/lMopA=
X-Gm-Gg: ASbGncvGTfbFXsCwJh0rdmqDZBwIyjwIHxaXGxYSbFNUKhhacXWrVqICkEUbgPrXIcC
	XGnW1cMcMvtWV/N1d9jm2ad5Oy0UJu3Uf9TM3yQSUcQX1+o6sEa9CoJqqDMM5Q3DziRyvDE8ZLd
	QsLhsCFm8shXsa0zmZFiU+fWBjQmVO7GuMH1478qQhXor4XBS+haAgoqjGseW701PiaojKdayjy
	r5m+WvvWjtYWWXyDTAd3LLxw4aWXd+vthFR11HboIZ2fsoVn0iiclk3mhpTVZOxrdMbsFuZApHt
	K1QZTeKAVN8eDFWrd4CSZRHb7D2h3bykc7fOJkll3WYFxYWW0E7Vno1asM066aRTC0eMcII9bv/
	SrWjhzBsj+7JjilMEfh5irw==
X-Received: by 2002:a05:600c:510c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-438913ccd4amr166011725e9.11.1737399595734;
        Mon, 20 Jan 2025 10:59:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+TPy54/lS3UFFrnmG1O7DZZp3fmFAErUo+YtByu8LHirZNl4hbvPpqLOD+qxS2Tc6vW5HSw==
X-Received: by 2002:a05:600c:510c:b0:434:a1e7:27b0 with SMTP id 5b1f17b1804b1-438913ccd4amr166011455e9.11.1737399595303;
        Mon, 20 Jan 2025 10:59:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c? (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de. [2003:cb:c72e:e400:431d:9c08:5611:693c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327decbsm11436866f8f.90.2025.01.20.10.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 10:59:54 -0800 (PST)
Message-ID: <b8751af1-6c11-48d4-b446-05916010a723@redhat.com>
Date: Mon, 20 Jan 2025 19:59:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] fs: avoid mmap sem relocks when coredumping with
 many missing pages
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tavianator@tavianator.com,
 linux-mm@kvack.org, akpm@linux-foundation.org
References: <20250119103205.2172432-1-mjguzik@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250119103205.2172432-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.01.25 11:32, Mateusz Guzik wrote:
> Dumping processes with large allocated and mostly not-faulted areas is
> very slow.
> 
> Borrowing a test case from Tavian Barnes:
> 
> int main(void) {
>      char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
>              MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
>      printf("%p %m\n", mem);
>      if (mem != MAP_FAILED) {
>              mem[0] = 1;
>      }
>      abort();
> }
> 
> That's 1TB of almost completely not-populated area.
> 
> On my test box it takes 13-14 seconds to dump.
> 
> The profile shows:
> -   99.89%     0.00%  a.out
>       entry_SYSCALL_64_after_hwframe
>       do_syscall_64
>       syscall_exit_to_user_mode
>       arch_do_signal_or_restart
>     - get_signal
>        - 99.89% do_coredump
>           - 99.88% elf_core_dump
>              - dump_user_range
>                 - 98.12% get_dump_page
>                    - 64.19% __get_user_pages
>                       - 40.92% gup_vma_lookup
>                          - find_vma
>                             - mt_find
>                                  4.21% __rcu_read_lock
>                                  1.33% __rcu_read_unlock
>                       - 3.14% check_vma_flags
>                            0.68% vma_is_secretmem
>                         0.61% __cond_resched
>                         0.60% vma_pgtable_walk_end
>                         0.59% vma_pgtable_walk_begin
>                         0.58% no_page_table
>                    - 15.13% down_read_killable
>                         0.69% __cond_resched
>                      13.84% up_read
>                   0.58% __cond_resched
> 
> Almost 29% of the time is spent relocking the mmap semaphore between
> calls to get_dump_page() which find nothing.
> 
> Whacking that results in times of 10 seconds (down from 13-14).
> 
> While here make the thing killable.
> 
> The real problem is the page-sized iteration and the real fix would
> patch it up instead. It is left as an exercise for the mm-familiar
> reader.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> Minimally tested, very plausible I missed something.
> 
> sent again because the previous thing has myself in To -- i failed to
> fix up the oneliner suggested by lore.kernel.org. it seem the original
> got lost.
> 
>   arch/arm64/kernel/elfcore.c |  3 ++-
>   fs/coredump.c               | 38 +++++++++++++++++++++++++++++++------
>   include/linux/mm.h          |  2 +-
>   mm/gup.c                    |  5 ++---
>   4 files changed, 37 insertions(+), 11 deletions(-)
> 

MM side LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


