Return-Path: <linux-fsdevel+bounces-50215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36394AC8C5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734E09E255B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0E21FF2B;
	Fri, 30 May 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCbUgH8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154615E97
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601950; cv=none; b=S6Dia6cJYD7L3dI4Gcf/VI7+4gQsrSAnZ3fO+FHDAkjjWGDIdWNExooRuRArd/stk4XKg2k7Xr4+pfslsbiIXY32DN/eMTsqLjGuEM2kYFVNzDkQ0kNCqZ3417LHjZ4tpH1mhkCbs/eAPyYzpbPvDlmZQdF4XWspdUfuTn+4OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601950; c=relaxed/simple;
	bh=buMPpKyVK2v1HrI0a+oYjHtLHiMcKVBqzB0VCTcxFk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxeVil3CO/R/xGUAG3mLSMbytTB8d5DLwCVG7jBNYnQkSCgoAwAgYVCGPnvjeRKwUm+xu4qm6p54dde5xQwSuzdDarJlBxXdCJQcMpT/Qszj0j65ngLia8v/vdxQ/zBRJ9+9RBRrDe186bsSbg7oVja6iITuw82KicZeUwiHAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCbUgH8a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748601946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DwdYkxH5NWexRNTuYD3BgdlNehQBcazh9M5V2TAF1Ww=;
	b=eCbUgH8aMpTfXEfkj6ueU3KRUGR47QI1ceN5n29SFNK4tPGz+D5eeChyzyvWkdeR/aHeqQ
	l4OwcgXiZiZznKl2TCe67sA3l7Uci9U32x/mmlOsY6dh+T5ugIytf4tlnErjDkFse/1F6w
	WKMK62Y4D98Q2Vwv23nnumTQG08NN9w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-InY3mHc0PKuKhGTRQ7bqGg-1; Fri, 30 May 2025 06:45:45 -0400
X-MC-Unique: InY3mHc0PKuKhGTRQ7bqGg-1
X-Mimecast-MFC-AGG-ID: InY3mHc0PKuKhGTRQ7bqGg_1748601944
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442f4a3851fso16101745e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 03:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748601944; x=1749206744;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DwdYkxH5NWexRNTuYD3BgdlNehQBcazh9M5V2TAF1Ww=;
        b=bh8l3HgPyEazREJAzPO2QdDO4I9dqungBwQfzRDhuPGE3OpZXwRXMrwxlNEnaTLIXM
         LBbNITeIr4u1sWCFr+1bRZrROKXK6P6jaZ1MMFx+pM4CApsqgi4JuoNsJabP/8tCBXh2
         +AiyI5eWNHoTQclv4Wchz4BtXZKrlMnRnKL+qdT16sjAqSY+GlS1Y3ArfvbdmTamf+2L
         o0eSYATbgJodcFpVty5QpoFvKkP95Vu0UUgQi2zcSLzsVcdLed4rj/oyxwsJSIXl3p8c
         gHQz2yJfZUogXRCSC+QTUU/UIFCVnoyLWZo8QviOHAFWts6OaF2Qudba4/Ez8sw7WLb7
         sLGw==
X-Forwarded-Encrypted: i=1; AJvYcCVfpGGuLZGa1ScbtyrUfDnEgKpREOfdx9a9blPDbO4TKjjO7efQ2dnr4x3DLr9dkFHLR7rlxCgeYmgIjClp@vger.kernel.org
X-Gm-Message-State: AOJu0YyQTDP9ifKqmgFnSjpTvHnSquPlRP4JLf7/F9dub1ft2qgma6G0
	gC0GbjC+c+5ry5Hc5kbs+qoaMAVBSnp5msoPpA/QxuyDm9FAojZaAV/tmolbKgjija14eUSXYRA
	rcMn18C7/7hPLqo8tmAPKc0gItYNqzFb48HeqctzHTElPJ4CyVpCRGBqb57QcjVzgYEE=
X-Gm-Gg: ASbGncuFOXEZlEtmkMrmypQTNR0ZGMCvetPr0aUKRKTkHL0xh5lEjEu65eCoj2DgJfT
	Ph+FcTOyQsvUkfHj7nnCKt8TT2OHz1BFWdw46qEO8QXtixkxEMJmCidOW16+bp9Ld1uBfP2xZRh
	WuPZTdslz3eNXvRFuU3a+zEwpktRDI4pc/1EuDQQ6ooIT9bf0DrSB6w8J/24rbSXznzt+prPetN
	Nkbkr+xFLZj1oTn5cjbpVgBcrT+N4X2uF4KUzQzgjfPpJkrqHM768Ig1AATmmL9KZyYcXYnWBJ3
	avVPrQ+ILatqFCE0SfQUAyEwinirSHf3jfFc+7Qzj2IRIJ/C7H1NFLQM1LPpgzOAX1Tu24yTuDs
	uWWcIaOfgd6pIQXFOa2j9LKyltoGvvdihewBxXZY=
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-450d885e395mr13897825e9.20.1748601944286;
        Fri, 30 May 2025 03:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7p1KosJBoxSnA52uUHO8zNGeB7yLg2OEBif2rtf2efs00yVeVP3ublBcCm3+TNu4PeFchmg==
X-Received: by 2002:a05:600c:198e:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-450d885e395mr13897625e9.20.1748601943913;
        Fri, 30 May 2025 03:45:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc281csm14756015e9.40.2025.05.30.03.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 03:45:43 -0700 (PDT)
Message-ID: <290b753a-47be-4c3a-b775-f2c10a0bc536@redhat.com>
Date: Fri, 30 May 2025 12:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix MADV_COLLAPSE issue if THP settings are disabled
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 dev.jain@arm.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <05d60e72-3113-41f0-b81f-225397f06c81@arm.com>
 <f3dad5b5-143d-4896-b315-38e1d7bb1248@redhat.com>
 <9b1bac6c-fd9f-4dc1-8c94-c4da0cbb9e7f@arm.com>
 <abe284a4-db5c-4a5f-b2fd-e28e1ab93ed1@redhat.com>
 <6caefe0b-c909-4692-a006-7f8b9c0299a6@redhat.com>
 <19faab84-dd8e-4dfd-bf91-80bcb4a34fe8@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <19faab84-dd8e-4dfd-bf91-80bcb4a34fe8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.05.25 11:52, Baolin Wang wrote:
> 
> 
> On 2025/5/30 17:16, David Hildenbrand wrote:
>> On 30.05.25 11:10, David Hildenbrand wrote:
>>> On 30.05.25 10:59, Ryan Roberts wrote:
>>>> On 30/05/2025 09:44, David Hildenbrand wrote:
>>>>> On 30.05.25 10:04, Ryan Roberts wrote:
>>>>>> On 29/05/2025 09:23, Baolin Wang wrote:
>>>>>>> As we discussed in the previous thread [1], the MADV_COLLAPSE will
>>>>>>> ignore
>>>>>>> the system-wide anon/shmem THP sysfs settings, which means that
>>>>>>> even though
>>>>>>> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE
>>>>>>> will still
>>>>>>> attempt to collapse into a anon/shmem THP. This violates the rule
>>>>>>> we have
>>>>>>> agreed upon: never means never. This patch set will address this
>>>>>>> issue.
>>>>>>
>>>>>> This is a drive-by comment from me without having the previous
>>>>>> context, but...
>>>>>>
>>>>>> Surely MADV_COLLAPSE *should* ignore the THP sysfs settings? It's a
>>>>>> deliberate
>>>>>> user-initiated, synchonous request to use huge pages for a range of
>>>>>> memory.
>>>>>> There is nothing *transparent* about it, it just happens to be
>>>>>> implemented using
>>>>>> the same logic that THP uses.
>>>>>>
>>>>>> I always thought this was a deliberate design decision.
>>>>>
>>>>> If the admin said "never", then why should a user be able to
>>>>> overwrite that?
>>>>
>>>> Well my interpretation would be that the admin is saying never
>>>> *transparently*
>>>> give anyone any hugepages; on balance it does more harm than good for my
>>>> workloads. The toggle is called transparent_hugepage/enabled, after all.
>>>
>>> I'd say it's "enabling transparent huge pages" not "transparently
>>> enabling huge pages". After all, these things are ... transparent huge
>>> pages.
>>>
>>> But yeah, it's confusing.
>>>
>>>>
>>>> Whereas MADV_COLLAPSE is deliberately applied to a specific region at an
>>>> opportune moment in time, presumably because the user knows that the
>>>> region
>>>> *will* benefit and because that point in the execution is not
>>>> sensitive to latency.
>>>
>>> Not sure if MADV_HUGEPAGE is really *that* different.
>>>
>>>>
>>>> I see them as logically separate.
>>>>
>>>>>
>>>>> The design decision I recall is that if VM_NOHUGEPAGE is set, we'll
>>>>> ignore that.
>>>>> Because that was set by the app itself (MADV_NOHUEPAGE).
> 
> IIUC, MADV_COLLAPSE does not ignore the VM_NOHUGEPAGE setting, if we set
> VM_NOHUGEPAGE, then MADV_COLLAPSE will not be allowed to collapse a THP.
> See:
> __thp_vma_allowable_orders() ---> vma_thp_disabled()

Interesting, maybe I misremember things.

Maybe because process_madvise() could try MADV_COLLAPSE on a different 
process. And if that process as VM_NOHUGEPAGE set, it could be problematic.

-- 
Cheers,

David / dhildenb


