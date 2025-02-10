Return-Path: <linux-fsdevel+bounces-41372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B158A2E630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6821418841F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3321B87F1;
	Mon, 10 Feb 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UEAzNKeY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDF1B87F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175540; cv=none; b=IxfLQwIKTTXsPswWfPQ7qanXMWbY0Z+jXMZ97ODIHjGzMntwI4lUwsYAFUqtvHBmCzoqZ51E10UM9RbWRa0PtJijFaqCeJbaN2ZsbovQGFg7WZuJjy913p65lePuhTVBZcO59+Cn95aoijt3YdlH3x0Y631RfFUivgTf3+pig1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175540; c=relaxed/simple;
	bh=xjDv1UUzXLOKq832TK3V+MVR9jLqacIFqE39KvWITxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sO9xcBhm2Za2nvQ0anp4xxKe0s7o2i5AW6WFPR2V7+K2KVUUol/fveAFFopBKPR8WbhfhFH8o23+C7ffpL3GwQ4qh/9mKqeccP9ksrmPDnHZqDpIHa9rQ0DWhV5NNe/9taYS2r08bORdaQ66l7SNQsJpI4gpjD3Iuu7+MRIEZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UEAzNKeY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21c2f1b610dso100032625ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739175538; x=1739780338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlSIxA3x+/euQkQ5cMVnr4CskFs/HEnUsf/M1/H81gc=;
        b=UEAzNKeYkK+Y9pP37iNUWfbft4fxbDXdmZydVJu9L/SMfcNtDaL/doFxU3JI/UZ6tb
         KPtu0LsWXZ0+Qqa+/s3Nupdb4hO2M75Dk5rl/i9960RKOxu9N+uy5V+uo4AD1lFGOH2c
         yGovwjWgXPsYsrZMRYajYeCecrLUFiIc+kuuhVIzIaIUOoueNV8S+LwBmDDeB9QAkRng
         i78KBhB3fdxcOejaPLyyi3HLv0GFZr49Q7fzDFRYs4XNVvgUoNGwiXPVwNKLi+cajtgX
         NTRqVxN6kGiJK/cgV0WHmvDsuzVPct827oekHkMOpJb0KdYGF1tWqZ7OG3bYf/cSG13a
         3/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739175538; x=1739780338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlSIxA3x+/euQkQ5cMVnr4CskFs/HEnUsf/M1/H81gc=;
        b=njAY7Tx9pnRpaTozaBJlhwrtBmr7gx8UdlM3BkTbpJBkw8E3dSKAcaievYITg53Grr
         1b6mHicZ5yys//a4NrQ0B3YPKsvXtMTPZpKfWUPqOLtF2vp4I3zDhJ1zopnmOjVtTeBW
         bh67t1u/YAPrXraer5XTrtbW2t79ZaOLcJmYHxfHkltuq2SsSB2EH8lelqeGRMeYudSa
         rGyuUoMu2A0lwrgQqqegNGUwIfYnwLQBIaSzT00cRnRAqG0UwzsCFZzInr3RAItvev8O
         fnJ7428WtMirdghHYro5uD99097O9W++5qFj8Kyh18MxxivebMV/eNN1Ilv18O5/DZgF
         mKWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW83hoXj15kUHAP2hR85m+IlNdYHsY38idQtD6HmmN0i5NYSeo+T5eom8CM/QV4i05N9gv9Zwm1IVZCrLlw@vger.kernel.org
X-Gm-Message-State: AOJu0YwjY2EOlvUPnWULSPwPx6+B6NVsjE//2ce2+skRMLOWbqqcoO29
	7+s7UJ0LJxZfFdliDIcfSJDeE7QzzaGl29+J2lifpNJkhQ8MjpyfgwjS1RHYsBk=
X-Gm-Gg: ASbGncu0TfNnHLHOF0kAVMQqEu6QDlOr5ze45tn0EEmpm2Ub6czXWS6IXU79++q5I46
	1g4tdu/VDVvBAe9rQ4/bo0EFkCWQrY3rZr5esFZv6pK7mf1n5LrKRlASTL71/eRyXuYw1N8uTI0
	RCpyH5+DcrQVSyzKm4kxR+k3Y/TLBL+ey+izzj9OY7hNf+7lJCvAWkUkbYzuXInvMALCeioDbDI
	hWesZq3hEqWFKvgWHexsyANZq0sNZPj/Tq395RJUeIR4Dykz3wAhRyp9eV1wWTpHJ+xz/r+u94t
	mCYwIO4aZtnLhoNOJzI9TpSA8J5jPthdlB44K52g+A==
X-Google-Smtp-Source: AGHT+IFaNzeBUa5ZixxrEObq3W7T+7+9t1pZmG28SJnli2MJ7RMleh58aXR8J2XSsJ2EMGhM3ttALw==
X-Received: by 2002:a17:902:db0b:b0:21b:bc95:e8d4 with SMTP id d9443c01a7336-21f4e7989e1mr257615955ad.35.1739175537911;
        Mon, 10 Feb 2025 00:18:57 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f74ff1d45sm33072575ad.227.2025.02.10.00.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 00:18:57 -0800 (PST)
Message-ID: <dda6b378-c344-4de6-9a55-8571df3149a7@bytedance.com>
Date: Mon, 10 Feb 2025 16:18:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: xfs/folio splat with v6.14-rc1
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Jann Horn <jannh@google.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner
 <david@fromorbit.com>, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 2025/2/10 12:02, Qi Zheng wrote:
> Hi Zi,
> 
> On 2025/2/10 11:35, Zi Yan wrote:
>> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
>>
>>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>>> while true; do ./xfs.run.sh "generic/437"; done
>>>>
>>>> allows me to reproduce this fairly quickly.
>>>
>>> on holiday, back monday
>>
>> git bisect points to commit
>> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
>> Qi is cc'd.
>>
>> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
>> At least, no splat after running for more than 300s,
>> whereas the splat is usually triggered after ~20s with
>> PT_RECLAIM set.
> 
> The PT_RECLAIM mainly made the following two changes:
> 
> 1) try to reclaim page table pages during madvise(MADV_DONTNEED)
> 2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE
> 
> Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?
> 
> Anyway, I will try to reproduce it locally and troubleshoot it.

I reproduced it locally and it was indeed caused by PT_RECLAIM.

The root cause is that the pte lock may be released midway in
zap_pte_range() and then retried. In this case, the originally none pte
entry may be refilled with physical pages.

So we should recheck all pte entries in this case:

diff --git a/mm/memory.c b/mm/memory.c
index a8196ae72e9ae..ca1b133a288b5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1721,7 +1721,7 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
         pmd_t pmdval;
         unsigned long start = addr;
         bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
-       bool direct_reclaim = false;
+       bool direct_reclaim = true;
         int nr;

  retry:
@@ -1736,8 +1736,10 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
         do {
                 bool any_skipped = false;

-               if (need_resched())
+               if (need_resched()) {
+                       direct_reclaim = false;
                         break;
+               }

                 nr = do_zap_pte_range(tlb, vma, pte, addr, end, 
details, rss,
                                       &force_flush, &force_break, 
&any_skipped);
@@ -1745,11 +1747,12 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
                         can_reclaim_pt = false;
                 if (unlikely(force_break)) {
                         addr += nr * PAGE_SIZE;
+                       direct_reclaim = false;
                         break;
                 }
         } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);

-       if (can_reclaim_pt && addr == end)
+       if (can_reclaim_pt && direct_reclaim && addr == end)
                 direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);

         add_mm_rss_vec(mm, rss);

I tested the above code and no bugs were reported for a while. Does it
work for you?

Thanks,
Qi

> 
> Thanks!
> 
>>
>> -- 
>> Best Regards,
>> Yan, Zi

