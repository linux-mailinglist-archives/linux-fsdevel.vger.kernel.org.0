Return-Path: <linux-fsdevel+bounces-36466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368BA9E3CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E953C28489C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BE208990;
	Wed,  4 Dec 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC7MJMou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF81F7087;
	Wed,  4 Dec 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322663; cv=none; b=diMJ3Pf2UYGgo2xtXJxhUS/9kNfPWnhh8x4fBQu6V3X/8Kb/BWF7eFZWGwHIcUssji8L4aEImpmYP88Hf11iWOMNOvgnaHZkvp336ZpbL3X+qZJBq1oK8iJNlfDASgAJKlhc2Ujp/uRKh6nKAMuT5vWkYMBILRq4Ic2VR26toVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322663; c=relaxed/simple;
	bh=R5MN8g0CaS3TnV3erlyQxPVD9qEwThWGCIBM4lsctiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fy0a76Om0gsjWUh72xnPDpw56tga2LjjjnLBwtjiaE8XfNUxGi9cfnqhf5YxobB6GPn08c1mIsqqcKca2I917NzVxxSMDW4JYQdsM/T1DLk/hHQ++12qtmup42BnXD0K/NaJqgsNU2RfUMkwNPSPuQ6J+nXbqtKCcEAn95LLnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC7MJMou; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7252fba4de1so6061551b3a.0;
        Wed, 04 Dec 2024 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322662; x=1733927462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yERF6VCtTz7SIEjSl38TjVuiwNFWoV8cA+qmoqUvTRo=;
        b=WC7MJMouYInkA5s6iwLfdnBTLT/Y+PEiZYoHTdCxv51okd91PjBgkSt2CVcEK8xKHv
         F4Ri1IB0GZlSh22ahkDuPfEXRLrFVaMWtZcCDoBoJisJjIe76cO4E4POTL+UL1UHRwYX
         ctD1vtYZdLY/Ae56WOUAtzQ2ku9p2nZP2AW0TmzymUtSsjITllgZLExD2tX3ihq75Jf6
         oIZe/wDvzsIpXBuZmNLCHbM2Tt9cg2Imf9DxM94IfWCNoahQpa4BfbgQ4pNRh48im2o6
         7i0036sdGtV+cGH0dHGZbLyd+ivjkDdh9Vjb+Y6vQJNhFwxhF1QMhHJVOH8zrv1d7jnh
         ffew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322662; x=1733927462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yERF6VCtTz7SIEjSl38TjVuiwNFWoV8cA+qmoqUvTRo=;
        b=pzwl/vxhrW0+tI+JkbH2GXJuhNRE0FZ/EPFc5AF/3Coa+Ay33DtCwfvFtz8hzCFg5l
         j8bORIoN1hnd8ao1JjsWI24lG9IwvguBUX3v4ibSvUXNEV/QVLmk0MrlvTXJTtFUtrbR
         lhl2DqdThTK8cegL24XH+G4OeB8PiZBGJ137IZL78O1Qg+7n8/Ah93nYPy3pdH5f4/g8
         8C5DzmBajz08Y8LclexpXwnX6p7Zs+jB2VKZ4eUl/lXLbhrHdFv+MoMw8qrb8ESNlpAU
         SOkvCeo1Ar/yccTVDLBWWMLNek8rimsIuxXnFqC/1kUizxSYwQtBfx+6CnrhSoOr4B1U
         LUiw==
X-Forwarded-Encrypted: i=1; AJvYcCUHr8vqUwKZJcXtpJbcdsxj3I3lh2FSODzj4+OtgeoKyl1hyO3WQnGjo22Cp/Fd4cTdOpsLfKzxXxzXhOem@vger.kernel.org, AJvYcCVBmM6sZ9xg+93PKed0AsR5bV86aFcEdYDOgDqp2CWtCYF1QL/m8fWjFZBNORtpdZzT5TD8wOB7OS8s4hWj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2XASr91meLGwb9RGH+QlrjRM4rf8T6JzGyGrugIB6qAcpxm5
	N0MzVEYjRwtyfgtz2WTCWojh2QWLp0u1nPLTAVK/X+wEdObgStZ1
X-Gm-Gg: ASbGnct2yNbMlIM+xeaT6Spy4feOAdOymO7e2obChSvqvB92AhzxgxlATtNmEtEmSaR
	3do8KYst8KURcTYqKSGGswU8awZjdjDOeKw608fU7aQci4fV/VYuatAqYLo0cvKL2B6CyghzIOh
	07kiQdna+NCtanfNI0OhsEfyxiLMWcpaBqWfUEpKMngYHIGW5LmxxcBHr+SqykyWKlZ8v6ox6Hr
	NbuxNQlC44AcTaCMf4tuTtITEXplZ2WXf28qyNcTDXAXy23t2+Q/NOWWuQ=
X-Google-Smtp-Source: AGHT+IHCmj9MQosZNtKH1r+fGojOSp3mgTUytzHtuPCGtR6ojxpPgcwmykPfmMare5C92TgoL5IELg==
X-Received: by 2002:aa7:88d3:0:b0:725:4615:a778 with SMTP id d2e1a72fcca58-7257fa5f065mr9772323b3a.7.1733322661032;
        Wed, 04 Dec 2024 06:31:01 -0800 (PST)
Received: from [10.239.15.156] ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417612c0sm12464807b3a.17.2024.12.04.06.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:31:00 -0800 (PST)
Message-ID: <e6199ca4-1f87-4ec5-b886-11482b082931@gmail.com>
Date: Wed, 4 Dec 2024 22:30:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/12/3 22:17, David Hildenbrand wrote:
> On 03.12.24 14:49, Wenchao Hao wrote:
>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>> each VMA, but it does not include large pages smaller than PMD size.
>>
>> This patch adds the statistics of anonymous huge pages allocated by
>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>
>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>> ---
>>   fs/proc/task_mmu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 38a5a3e9cba2..b655011627d8 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>           if (!folio_test_swapbacked(folio) && !dirty &&
>>               !folio_test_dirty(folio))
>>               mss->lazyfree += size;
>> +
>> +        /*
>> +         * Count large pages smaller than PMD size to anonymous_thp
>> +         */
>> +        if (!compound && PageHead(page) && folio_order(folio))
>> +            mss->anonymous_thp += folio_size(folio);
>>       }
>>         if (folio_test_ksm(folio))
> 
> 
> I think we decided to leave this (and /proc/meminfo) be one of the last
> interfaces where this is only concerned with PMD-sized ones:
> 

Could you explain why?

When analyzing the impact of mTHP on performance, we need to understand
how many pages in the process are actually present as large pages.
By comparing this value with the actual memory usage of the process,
we can analyze the large page allocation success rate of the process,
and further investigate the situation of khugepaged. If the actual
proportion of large pages is low, the performance of the process may
be affected, which could be directly reflected in the high number of
TLB misses and page faults.

However, currently, only PMD-sized large pages are being counted, 
which is insufficient.

> Documentation/admin-guide/mm/transhuge.rst:
> 
> The number of PMD-sized anonymous transparent huge pages currently used by the
> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
> To identify what applications are using PMD-sized anonymous transparent huge
> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
> fields for each mapping. (Note that AnonHugePages only applies to traditional
> PMD-sized THP for historical reasons and should have been called
> AnonHugePmdMapped).
> 

Maybe rename this field, then AnonHugePages contains huge page of mTHP?

Thanks,
wenchao

> 
> 


