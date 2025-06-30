Return-Path: <linux-fsdevel+bounces-53308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86EAED642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0882618991F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB21239E98;
	Mon, 30 Jun 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxho2LsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB3238D49
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270125; cv=none; b=P0jBFU0Hl8br2sJE3dIo5Kc9EEPLQ7BJfeMx6FLRZChhY0iKPTkDCj5AcWtu/g7d6tNsdtFDEUuXPZBPWCMT/H857f/EsP9CZSE8jNmK66JowMCLCcd9L6CVdnnc4xi5xDHccMpiEn/TqLrvk0ahx5Nnetb6msMykr/4x/wQ59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270125; c=relaxed/simple;
	bh=LzNv2BvRGjURAKfZb0y/U3sfNjK3dSR/PcGkU/riH2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EteKru1tsFStu1saXMm4Qht/MfXjNll6NtyDRgPPoWxe3DpbIaej48sG+8YLklBR7CP/FfRinBr+aj3YiYE0A79yodJsLbqe/UblIZBnSanKwRKHRfwAO6nHjSjtzyQyFNZhGf+wzCdm57G5rXpAhcm+miEskyewnzmIpRn9+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xxho2LsM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751270121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7a9or9//L8s2LhuJ6xqmesus6OKnaoS7sHbZZSebooc=;
	b=Xxho2LsMZ4q3M7ptp9h5kk6K2/dR1nt5vr8OXWtn7WjZsm1Qmxb4p+5wTQQJiKOrStvw4R
	F5CjC/hkNDhiBiUhqxnvCMZhzriFFGfuVNPWfZkgb5nQBh3iyxmUh6Jkn8oVTf34mJ1hPv
	SIxaoIKBFlRLyssX0PUSoeBnsVMPgWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-IWv1660jO32BoXly9SaAPA-1; Mon, 30 Jun 2025 03:55:19 -0400
X-MC-Unique: IWv1660jO32BoXly9SaAPA-1
X-Mimecast-MFC-AGG-ID: IWv1660jO32BoXly9SaAPA_1751270118
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d5600a54so28840635e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 00:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270118; x=1751874918;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a9or9//L8s2LhuJ6xqmesus6OKnaoS7sHbZZSebooc=;
        b=fmKJCIuOJT+X/UxsU+IqA/7iXZnJk0Kz2INAV1FckSElJX0TcvICs1ot0HfBzngTUq
         SNB+wJ8za2X8lCNjXOF61ZUTLJTv/5bJNWpTaU8tXeZPOsiJZJD07yfDbLsYEE/Sf7iw
         ANIbBBsiRuenPQZb10AMA5UfELntD9oSBZ+7TB5ERf1r7MPc083tEaS0CKVVpnPw9siO
         DoljUaZKnrHwjG/jX3clX1ZruUJwwWWxX4TzwBEtrCtzBRvCQRV4iR/a+XshvE86VxJe
         7B28+eDzRwtVCaX6uHBLrt5odAflBvo4WX85pxYmfKlp4zRCOhB9p7Z+qNTJTwe7nPcy
         sQ9Q==
X-Gm-Message-State: AOJu0YxFyzGXiZ6AvSFQPbAhWDP90uoQIg7CXZ+NPoOJKeAIfFlc+k2I
	IkKWPgDhGAQ+TtWlp7+U4CJ042U8NrdfcTELJhgewYYOFeNVGVwGdTDZ8VfIHP+hzlmZ2tSmuTi
	cs2cKlQDkcZztixh6v6NrCFK5vUcPK8YRyrqfkvxEnpo4hW3nNEtL/0W2NIrsFsPnpmcgRsIXFz
	s=
X-Gm-Gg: ASbGncuZcm/bKDaKM9N7iaXp4xQg3+MEe8vrk7k5vYlu4xad93S5caBOrxmfcXMVDZj
	V1pSvROGuxe+lPtQ3QWxVjpecgLEVmBP/fe4m56nlyEcsb1XeUqmo0Rpi1gBqfQj2SkTGPokosp
	WAL7Dne3xfoPLa5u8Ak1pKwW2yV3k0tW5aTMmTMUGIPNNWdy27sZrtkrjsVXwpi7rwlvsf033za
	fwJOjs0ny5XkxGnEAt1WhEZTaffQS7j2lPK2BoBtRhKx40KsEe8uKZqOY1GL2ihDR3VoR1wWmG8
	zgmAnVbDQJ2MTH7Zxuhiq/HNAgScDBmIM47WnJMpI2BM1qt0mnKBIVLOxsJauWyByJFEwq8mO46
	Nwjlh+p0jP/kjzNfzi41uOHs+0rPt4ahIfD0JUwcqqO3L0cMrSA==
X-Received: by 2002:a05:600c:8709:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-4538ee2786dmr118455725e9.12.1751270117642;
        Mon, 30 Jun 2025 00:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWnv4XneJF4l3eD0X37whdACrcuTrwOArn291zYIRtD4BGnx1lqdzV0g3BMxMAGOMzm4CBBQ==
X-Received: by 2002:a05:600c:8709:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-4538ee2786dmr118455425e9.12.1751270117206;
        Mon, 30 Jun 2025 00:55:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm159541955e9.28.2025.06.30.00.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 00:55:16 -0700 (PDT)
Message-ID: <2409b6e5-ee02-4cb6-abc8-5b821f58f540@redhat.com>
Date: Mon, 30 Jun 2025 09:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for
 the huge zero folio
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617143532.2375383-1-david@redhat.com>
 <416514a7-0e0d-4cc8-912e-bcdd2bac5c2e@collabora.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <416514a7-0e0d-4cc8-912e-bcdd2bac5c2e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 07:18, Muhammad Usama Anjum wrote:
> On 6/17/25 7:35 PM, David Hildenbrand wrote:
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
>>
>> We should also extend the pagemap_ioctl selftest to cover this case, but I
>> don't have time for that right now. @Muhammad ?
> Currently, we don't have any test case covering zero pfn. I'm trying to write
> a few test cases. But I'm not able to get ZERO PFN. I've tried to allocate a
> read only memory and then read it. Is there a trick to how to create ZERO PFN
> memory from userspace?

You need a MAP_ANON | MAP_PRIVATE mapping and have to make sure that the 
compiler does not optimize out the read.

E.g.,

char *mem =  mmap(...);
char tmp = *mem;

asm volatile("" : "+r" (tmp))

or

char *mem =  mmap(...);

*(volatile char *)mem;


To get the shared huge zero folio, you need a suitably aligned VMA. See 
run_with_huge_zeropage() in in tools/testing/selftests/mm/cow.c as one 
example.

-- 
Cheers,

David / dhildenb


