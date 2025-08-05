Return-Path: <linux-fsdevel+bounces-56773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E728AB1B72C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 17:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877E118A21C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E0279DCD;
	Tue,  5 Aug 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMTd3rYF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483D279DB1;
	Tue,  5 Aug 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406544; cv=none; b=CWMUu0n2PVUwotWMA1YTmlYdEOjZCQA3wIDHPJlZFfAwoxyOv+BcSLPH7tnWxMugFcyBc0C5/IWtkKPqjLX2QOZYCZe4aO/VJuuLyxb5dOl+6EE8Yk5XkR7kLUlGu43B92yCEpaY89M08DT88jhLdtG5SD78tRVLF2Eqk7q5MDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406544; c=relaxed/simple;
	bh=CloU7AwQ+4ed8BmT0f+moVCt+pXdA9kyuCa+TPRFKQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkG2vKrF5lMLgppjnOtg2JUc5TbOegDWxrHkHgfL3uQMT7kpoH17qPfNQMaEk6aXypvTh3DFVpk0Vv19S/kyeGgqByexT6B7EcxWeA4lthMKk8hmjIPB/GNeq29LnLh2EHw/P3MrSl3/EHhYKc7ZNwxMQCwCcYg1g1EKApKzVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMTd3rYF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4589968e001so36529895e9.0;
        Tue, 05 Aug 2025 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754406541; x=1755011341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clkjTg5nzbZkcjPnCyY4ICyTnv2rK6xqFAiXWelGD9U=;
        b=IMTd3rYFSvF219EphUpdhRaee2XcN9S1I2zvzjxTQPztIcMmdS50t204R3KYAH4Wdg
         scsEWOWUBwHh8jxO6jvWuFU3EtMXj2Ja92oCnn5y+QMi42aT22GVrn2SFkHgJgfwD1i7
         29lAG8XipK8DF98QqRHq4RRvI3YlZWd9oEdMCkYjYV/LzPkqUeiCmr9acAm9FT7O29oY
         YdJBScTXVEd4gl1LG2Pbcox64QUJzokCOAJ5uYaOrafaZr7bckdsg3SELQ3GyRZtW9Eq
         AdZrsaZHn+JNg+yjDL/QoEV9/H4G2NQjpkE+ZfIb9KQMyTb9eSWO2bNp+fPFCx29nYVR
         cJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754406541; x=1755011341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clkjTg5nzbZkcjPnCyY4ICyTnv2rK6xqFAiXWelGD9U=;
        b=nTOknL3MbJM3EsktL76BRfo01FhNdM5ZigikDe6Fk1vOGtbwXVb0B/m2p/jJwkxomV
         wLEKsiBgFHpbNueq3USeikyInvdTvILYX9ZMCxqQlGbG1rKV7P1NZ310+g5E8OTizx10
         +KZbzrp7j46JXihEsB81ntN9JG/2k5V6KNg/GaWZppH4fwJzLX0JVEvclRLg273qBzFf
         zJeOSV6+r65HmqD0mfFPCoAw5wiYw9T/YmCuY1/yse3Z/niICK/n0MrafabhWn6bbdrT
         Yr77An9MHAIupTLKdUWgw53FTPAoy1yabcS3tsBhWS43qB+0IzH+5xpyDcU6c1SvrVD8
         5t6w==
X-Forwarded-Encrypted: i=1; AJvYcCWElB3ycTn4o9ptVgoG+Vc/iMv+zN/17U787rpJ+NTn8cF0uuL+b4ost4vHH1K60CTa4FNHsaXTZfZ8Lwg0@vger.kernel.org, AJvYcCWhAKCj61tBqOnS3BBZe+u9R2EcUojdEnaFH4KuA9KnZVLy22GSIhY/qGiKRwF4p1OWgMxNEIaR9ayTs0qCsg==@vger.kernel.org, AJvYcCXPunKBZgzKOGm9K1AtzT7tQm1UXxw9QIhJEjqOlBrrbJA+0/cL+r1pdwJDvA6iXeRGWgAMuFm14iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5QJr5CiCW+oGj0PJBaKjpVGSuV1d2BFTWnZAlKB7/AimuCme
	n8g/yq7OAqsi5VPq44M0wwYc1z89SV2PwTlz2Cln7wrWrTT5yf3G691P
X-Gm-Gg: ASbGncseJqwg9dJaIEr7mgfZoKnTzUgW1Lf5bmK5vLrtN60z9q8c6FjVCtRJ2kStNOi
	MWZW0CZjVtlMBQVitF8hVEpnboCEMRLpkkHC+lbBe1Me433lWIEM73WTmaV43e4nmajZXnIYIzr
	YSsPlz6nEWWIwtgpBwFKpWG4sI2ZtY8jl0McV6VYYLSn0PfYaKDFr0YC6gTdPi1PgOBUvhx35Wb
	moTBL8lBYpTCJ9jnNjy4U/kjEKKfh6kPKUwl/UcGLbnlJcf3dfHTgc+WfecCelcJ0pSCN3uVyLi
	PeQcGjZRQOJ9SnbLRQOtYcHABYxFty8s81d3JRA1r9erQj35AWdy9KWFHQ17UPmDuzELO/HpQel
	RxL1FyjiOw7eGV2eUe31gSouhwxkauS3LRwwb896xO5ozw9+aWgVSTDG7Vx0y0KbiLgtLbe8=
X-Google-Smtp-Source: AGHT+IEJleTvyo7dw5ZGzLVioDY9Jwr93ljNYRwnTw/ri7vqTNIxJbrhwwu2JSLWJ5dOnaJY7nNELw==
X-Received: by 2002:a05:600c:3548:b0:459:db80:c2d0 with SMTP id 5b1f17b1804b1-459dbf8f654mr60706285e9.7.1754406540648;
        Tue, 05 Aug 2025 08:09:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm40017195e9.1.2025.08.05.08.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:08:59 -0700 (PDT)
Message-ID: <cd99f0f2-260d-4494-bbf6-99daec3e0683@gmail.com>
Date: Tue, 5 Aug 2025 16:08:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm/huge_memory: respect MADV_COLLAPSE with
 PR_THP_DISABLE_EXCEPT_ADVISED
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-4-usamaarif642@gmail.com>
 <8bfed1e2-ec44-473b-b006-8cb2505220d4@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <8bfed1e2-ec44-473b-b006-8cb2505220d4@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 9c1d6e49b8a9..cdda963a039a 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -185,7 +185,7 @@ struct prctl_mm_map {
>>  #define PR_SET_THP_DISABLE	41
>>  /*
>>   * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
>> - * VM_HUGEPAGE).
>> + * VM_HUGEPAGE, MADV_COLLAPSE).
>>   */
>>  # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>>  #define PR_GET_THP_DISABLE	42
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 85252b468f80..ef5ccb0ec5d5 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  {
>>  	const bool smaps = type == TVA_SMAPS;
>>  	const bool in_pf = type == TVA_PAGEFAULT;
>> -	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
>> +	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
>> +	const bool enforce_sysfs = !forced_collapse;
> 
> I guess as discussed we'll return to this.
> 

Thanks for the review!

Yes I have a follow up patch ready, will send that when things stabalize and this series
makes into mm-new.

