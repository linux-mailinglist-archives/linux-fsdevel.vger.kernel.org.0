Return-Path: <linux-fsdevel+bounces-57871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA8B26309
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 095717B4823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6D2F83C0;
	Thu, 14 Aug 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1CNG4Gb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2328C009;
	Thu, 14 Aug 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168204; cv=none; b=n17FN+5XGIaTJPzfdwFRYKZTNAroJQxkpLg5B65hqAD4JutduXu8N14BJ9bjFXg0125D1CXXuz5tVSfBX1zffNiz13QZAZkhjWvcN1DraPip5hI1oCBH7+uFDs4l48G+kQ8WyoBmt9zSB8hQOEhivOZHt8FUH9lwDSF4yxr0Xkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168204; c=relaxed/simple;
	bh=AJ/C4uyJeukio2kY3R3eYR4LVUJD08Pake2nTRq5oeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIAJIVxiMXZo45TFI1uaYYUpglichwqhdpbPAhKEiNu93Ur3R5Az7b914blC+x/E8EBXMg4TO72gePCutK/w3XGD7hrTqpkl4QR3G2YJ4k0JXd7xB5etuav/wP7g2fkct3vo6eVGLCY/8Rh4v/Ft2FVePfbNNAs2eKqK25hvo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1CNG4Gb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9ba300cb9so570713f8f.1;
        Thu, 14 Aug 2025 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755168201; x=1755773001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLtt5xMhmDFA2ShL0rr0DmKUZACD1c7sVV5qlbjjBKA=;
        b=C1CNG4Gbw2bKd8lw389LhavP0lre3TJJXGy++I8XGcCj9KGIeTQhKbHGf3YGnTeaHN
         xB5z77tWGawpXsZWtvvESPBcyxoscH1/nPL4PRI6RUonSMO7QP9/tUEvwqzNNpm3sOKM
         RPYAD8HMpxaxl8WsDnGm6qC9p5MOwZtXY+1ZdUXY4F/Iw9T5v+igNYYWNGTpYhZZQ9aD
         10i6iVTlBtQ0tF/NboRlfYdRl/kEIUHT1crC0mfidVaI86oaoSY2raPJZZXuZssP6FwU
         s4wELsmkT+r/yvWZ4vUyqK5jAdBCKYggWpz5HSvHYahquupfJ4pP96xAgy4jhRZAQkW6
         OKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168201; x=1755773001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLtt5xMhmDFA2ShL0rr0DmKUZACD1c7sVV5qlbjjBKA=;
        b=iIPCIqUFV2BF+19xtB9TWBpF4XlEmhLpcwqm/KiW88BIsPs47DOv0yXKb17lgYWA4s
         DxWbDJ3KKZ1CuH3Nqz0oar4MUdXUCzsSS3L3kmwUcp6tySnsdIHimkVTFTikAFYmYwyv
         6rh+zgw5QGcx4id4qvWZDCMaARHbc0AqERTqCKH16HNj8bmBjdpXbnKDe8hazCzGGbHq
         VeX2wIl0NTYjAfV5o2cpELFNRXxdlvkml2kYbpxGD3ECNkleDKS9ociAn796DuVKXPFs
         iAeYt9GIF5P+T/cxjvoeqZvkExTL5AVLfgZR21tTeEK5l8vqIFtqBxIXVt3unzMVcJE2
         RAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhTWAldsXevAaaExLWpQgmLHRUtuCefMtjQPKksf24WamEGekHH164PxKGYg6cVxCF6+L0LzRIsMoXdtlazQ==@vger.kernel.org, AJvYcCVNo9im1JETub/iHrKX5WXT8WdymMUF6emVC5KZQMnm1FO35srSEYYeAD6+63kJOjJ8saqtKMp0/lw=@vger.kernel.org, AJvYcCVeSstQ80xCqAbHR+cBdJ53Ph5/Lw2JLik93cx3o1Gtw5Z1D0ZlYku+I3kde+ZMtkiiRI6mH9N1yhbtw9lh@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKyrKyfU39oKrtQEAnM0xKHXVdBsRDxs6I5TFFgquQpSYkzoH
	0jd/yoC59+36G+3iZlenTyQpWchCVSMseQ5MmaMGtTuvi98z2vJj2BPF
X-Gm-Gg: ASbGncvnT4REz/DwqYSj/RQucC5ArSF/ZGR0s7oS5azVPjXZzWvH9oy/Qw6pFKljDG+
	AmVgXuXoK25gQ+SaiHNv7/71AVdhoxuxkeLnYsZLQ1KAgKOAETAQKLVz5dF1yA12dwD+w1GXkp+
	wqBL34P4+ybIfvzR84TIzsLIaOOeP78r4TzUsPgdg3f85peOFOPg6qGJGkSypDzsLkX5cuzw+qa
	7B+hORZJGiDO5jgrW3BOXF48UZGr6OTbPvN4jvzmsHMYJ5V9oEp1XsJKLvf5DDLa/xjKdu5f4UY
	fQzYQwxuLtX11jAJQrB9Lx9f6qcRYgDtbBs8PDrGHRPcj5r6KZhPV2ms6+OaVW6mH+1A/ZOtLkd
	x/K75CvZYOfO4tT/q1b2lAXK3e5mqzJH7k1uo0URQY6UYuoDTDKu2zH/GUsgTCgpkoTXbmUQUzM
	zHVGwlvg==
X-Google-Smtp-Source: AGHT+IHHxD/2V76qZjPAaomdu2zzYXxDs5OzsF/We/4FunFKZx8JdJGlm4zSbvh7T4zkS/IvSG5F2w==
X-Received: by 2002:a05:6000:2891:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3ba50d5c0fdmr1738678f8f.26.1755168200966;
        Thu, 14 Aug 2025 03:43:20 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8979])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9eddsm50514108f8f.22.2025.08.14.03.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 03:43:20 -0700 (PDT)
Message-ID: <c8a47a7d-3810-426f-a2cf-7c020ce25c7d@gmail.com>
Date: Thu, 14 Aug 2025 11:43:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] mm/huge_memory: convert "tva_flags" to "enum
 tva_type"
To: Yafang Shao <laoar.shao@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, david@redhat.com
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-3-usamaarif642@gmail.com>
 <CALOAHbAe9Rbb2iC3Vnw29jxHEQiWA83jw72fb_CQKGDFHv6+FQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALOAHbAe9Rbb2iC3Vnw29jxHEQiWA83jw72fb_CQKGDFHv6+FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14/08/2025 04:07, Yafang Shao wrote:
> On Wed, Aug 13, 2025 at 9:57 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> From: David Hildenbrand <david@redhat.com>
>>
>> When determining which THP orders are eligible for a VMA mapping,
>> we have previously specified tva_flags, however it turns out it is
>> really not necessary to treat these as flags.
>>
>> Rather, we distinguish between distinct modes.
>>
>> The only case where we previously combined flags was with
>> TVA_ENFORCE_SYSFS, but we can avoid this by observing that this
>> is the default, except for MADV_COLLAPSE or an edge cases in
>> collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and
>> adding a mode specifically for this case - TVA_FORCED_COLLAPSE.
>>
>> We have:
>> * smaps handling for showing "THPeligible"
>> * Pagefault handling
>> * khugepaged handling
>> * Forced collapse handling: primarily MADV_COLLAPSE, but also for
>>   an edge case in collapse_pte_mapped_thp()
>>
>> Disregarding the edge cases, we only want to ignore sysfs settings only
>> when we are forcing a collapse through MADV_COLLAPSE, otherwise we
>> want to enforce it, hence this patch does the following flag to enum
>> conversions:
>>
>> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
>> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
>> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
>> * 0                             -> TVA_FORCED_COLLAPSE
>>
>> With this change, we immediately know if we are in the forced collapse
>> case, which will be valuable next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> 
> Hello Usama,
> 
> This change is also required by my BPF-based THP order selection
> series [0]. Since this patch appears to be independent of the series,
> could we merge it first into mm-new or mm-everything if the series
> itself won't be merged shortly?
> 
> Link: https://lwn.net/Articles/1031829/ [0]
> 

Thanks for reviewing!

All of the patches in the series have several acks/reviews. Only a small change
might be required in selftest, so hopefully the next revision is the last one.

Andrew - would it be ok to start including this entire series in the mm-new now?

Thanks!


