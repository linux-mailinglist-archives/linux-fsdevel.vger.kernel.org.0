Return-Path: <linux-fsdevel+bounces-52021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A04ADE625
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEEE3A391A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745227F736;
	Wed, 18 Jun 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6FZ7JQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D90202965
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236987; cv=none; b=GN7LzXX0jLYbea8Qg6wvBInNcQryqr4RIp5NmEGDZYKcqc/eNoGkXCxQek+AAH35hWQkgdv7YD/Cevs+VLNPIJzIbB3Bju4LeKzFVy658xOI44rXNzCMsCcUJiUv8+1NyB25e6MALQJM4mHnvET8mbIO9FAz+U8b57es60+e5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236987; c=relaxed/simple;
	bh=al6tAGSwn4yBJ+cKJbU86+Y2IYPl7NgYgonR4ZtPF9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD2gFOlAhHfUYI/7g8GypVqwflegZHmhWUsdhGzFIKxq0zoNm2uJu6vmshMJHKN5mkt0IqB6g7sKdqco1z+3EAqUm+X82UByuJDrvDbnkxBUednrSoJ3ty319I51tty3JOyokaGh0K2QFhi7hCM5jdKwFUmO3gs1wRJFqWzAHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6FZ7JQN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750236983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j/M24CJGobquRHcUhHND5Tn9aL/nU45nc9Ymeq3tsS4=;
	b=O6FZ7JQNP1SkhyGq7s/d02/FtprhohpD4hxvtWiuYdmlH6qSN7flc9IaYl1fQgpjQnrRqR
	zOlau8NkyUZUTCxRnz+b0rfCeWGELb6MIWxI84YVdbl0AqDDOHFfG7kib0vKCwAmDzxrw2
	AHSwMVQM1NVxXpPA6/byL19GyngMAmw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-YLiAzyW5PKqPJkuztw6fXQ-1; Wed, 18 Jun 2025 04:56:22 -0400
X-MC-Unique: YLiAzyW5PKqPJkuztw6fXQ-1
X-Mimecast-MFC-AGG-ID: YLiAzyW5PKqPJkuztw6fXQ_1750236981
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450eaae2934so55118155e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750236981; x=1750841781;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j/M24CJGobquRHcUhHND5Tn9aL/nU45nc9Ymeq3tsS4=;
        b=uA2+0QDDaswAnoqpff6UWZO8+EGeEzkjt70yRNtSXEYrd+0rdbFlTBq1ZdNow8QSYI
         RyNsjmg/trKj2u7y9YyKjP9hcbLd9MKVuttYpFn1JVfwA5naDG5pgt4T2IfQhIsJmLln
         jRy1y3etP+LV/kurG41Hx1Z0lvuZQvjoUkmmzcJtBgJk/ITGNg1DCGYwDExPGtN73ZDN
         Lumds1FunCpLggnsnqmwE6tNrPhJurUnGkG+WrDH5StwnfxYRU2IzOQC9SRPKR59EUK6
         1s9Qk8kcc4MfQoiu0lpBpYzjZohsBNfWFKx2Uow66ub9y491stCicmV7l+P5/noyePOe
         Idwg==
X-Forwarded-Encrypted: i=1; AJvYcCVxb7Vrz/kqt1LfidTsTLeusnL74tXxFFglw/n/SUZQ80fHDWOGDCVLb83LkeZmUrmILyUMfnWh7grsIlyz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95hoW4ZsEfH6UDdd7QudzuvJVMFhpKpLv5Xpcg/vqSWcJZax0
	qo/8T2Jii1+xmVuZ8hytyqYfNpwyYtOslzs3mKC8gm9ww6juhbpJ7hHTSmsE/MVzBTIEPJLh/wp
	6UJbyw02ocsA0aRZLVGhh+UZ9EQZ3lQ7cnU/F0xX8YltxnfajRI2rUaaEOX6yxOGJPhg=
X-Gm-Gg: ASbGncvRo6n3ecHC5o+J2RXRkDiseaR9MhrdQ9LTYxNMltM3jgzYeLmZA6L2bDVz579
	kj89/ru7Kpckmc5uCWNSk1uGr8EwD1zi1+cySAEhYTYd8ETpxdN5yVNDRz51a8tqWvFshYVq3e5
	uNORQTvwPsiOPzmlB74pn9H1KQ0LYsihEU9/PygJ71s2GGq+upkGsDdQh1j8WdlcL45fwN/+YIf
	7ykEJNyjHpt1gufgqisUhjCCF6gdH05fq4y3OSlZKLgax2NJo7eXE7TQIfaTomnAi/oqUp2W/CN
	y23OOCAEKwPIEpGSLSoSny3qZi2zsCsGvjZcngQX3y1zUe/kUxUm4iHgaFiiT19XAIBvGLsEaWo
	R6QaNlWLMIKvJ1pnL/ujppwrlwIkLEYXLYudG2Wqk3kgIpLA=
X-Received: by 2002:a05:600c:3513:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-4533ca7443cmr204491665e9.10.1750236980855;
        Wed, 18 Jun 2025 01:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZw6B2L/e3yrj0FP4v+sSNgoSUGDRbHqRlotNYU5gIJKYsFDW3FuXCiJ5+/HMn0j7ArHdMQ==
X-Received: by 2002:a05:600c:3513:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-4533ca7443cmr204491445e9.10.1750236980494;
        Wed, 18 Jun 2025 01:56:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:2400:4052:3b5:fff9:4ed0? (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b47198sm16035067f8f.81.2025.06.18.01.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 01:56:20 -0700 (PDT)
Message-ID: <e341d554-073c-4aa2-ab01-f9bdcd51c0f3@redhat.com>
Date: Wed, 18 Jun 2025 10:56:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for
 the huge zero folio
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20250617143532.2375383-1-david@redhat.com>
 <20250617163458.a414a62e49f029a41710c7ae@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250617163458.a414a62e49f029a41710c7ae@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 01:34, Andrew Morton wrote:
> On Tue, 17 Jun 2025 16:35:32 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> is_zero_pfn() does not work for the huge zero folio. Fix it by using
>> is_huge_zero_pmd().
>>
>> Found by code inspection.
>>
>> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> Probably we should Cc stable, thoughts?
> 
> Depends on the userspace effects.  I'm thinking these are "This can
> cause the PAGEMAP_SCAN ioctl against /proc/pid/pagemap to omit pages"
> so yup, cc:stable.

I think it will be included as PAGE_IS_PRESENT, but not as 
PAGE_IS_PFNZERO. That makes it a bit harder to judge the impact.

In any case, it's a simple patch and backporting should not really be 
hard (automatic).

-- 
Cheers,

David / dhildenb


