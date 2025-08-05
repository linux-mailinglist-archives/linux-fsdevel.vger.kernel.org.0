Return-Path: <linux-fsdevel+bounces-56741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643CB1B31D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B907A5DB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FBA26E16A;
	Tue,  5 Aug 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP0AIIQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B625DCF0
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395848; cv=none; b=E1GUeddgvt54K3zj7kQs684Lr8QTr73faMKmS+2Gc+6cT0lIZZKQ+7fVh9fPWTIhYJFr9xcS5kU0RZ31tzJQP7Fbm8c+1VZdQoX1B5qQZPm/8U7cbhB1kUBx+anrIZkrVt+OU+fMTWZKaV2zY632UDoKnacKpTkI6gnTWAvN7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395848; c=relaxed/simple;
	bh=dsbomZ2TJrqJxB3vb/LYF0ouD+kHHvZ3VGqy8aWySIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgD+r6Lhegz85a7tW91HjhKccctLpEBKZ50FLpTJJ8DSFgoNQ2SNxHMrX2AVxmMUPKUU2/v5kXHvywmKekCVch0l0FOE0H6eDoruUNGYd1u2ZqPrPcxYCIQxQ3T5ItCYB2BLJ3xGje+q51j6b+fGRgOOiUf25t2Lxi4iv5Wgfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP0AIIQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754395844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mxPZ9mV2VGEDs+TcyLyleA5F2IOZRlRZriZVa56GH68=;
	b=bP0AIIQV1Je0WcEnkmGqaJGd0nAyN5xTZwMLhbKrsxlL9kqpVkk8w0zG5ICW/kIBB1EqWu
	C6W9O5LsFnO3pdzgGRvQPG7GhD+eFKC8URRR1qLHdDRSceLhhm4/fVyCtHc6gj3C3i2992
	4T2/LY9iB6dguH/Rb+0/OxdNHksXr/U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-5WeZyYuBPTaQe9qbxJAmeA-1; Tue, 05 Aug 2025 08:10:43 -0400
X-MC-Unique: 5WeZyYuBPTaQe9qbxJAmeA-1
X-Mimecast-MFC-AGG-ID: 5WeZyYuBPTaQe9qbxJAmeA_1754395842
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459de0d5fb1so14132925e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 05:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395842; x=1755000642;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxPZ9mV2VGEDs+TcyLyleA5F2IOZRlRZriZVa56GH68=;
        b=GgjUC60xjRSGMgebA57B5lie+HWPUn2JK+JllpMyJeCk6jwYZGVyfSYT9liIxeIf8f
         pb3g53+PFPAkVYAEt7qLNAli9gW1nogt8iWt1oxQtCASjPqS1dgzZKapxehPY3L0upYv
         ioJlK6A1SXywSkux6pciV1xP1P6tmaW3D0yvu+/E82b5hyjF3lOHZxtFWm/ZJ4uOQa0p
         v/qZlXV0/3FFgprDlJbL68+n2wYkvlkAq45aj7N6IiYh0VWWFFZCrhuRArr4KJ0Xvf9t
         CetRRESQEoUIIvxYhmH3tN9TA6b/XCgtUSx9Vn4JYaSHc5WdsmwSydSaTxsEQCNqhoWh
         feBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZc1FTQm53bpmzhrde5kXJ2etyhdyPwn5XTrL9TCgd3S9JAGG/HycAiEczsjasrtVjWW8mtDdfisyzYXR3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fPVfrMUfnHXU97vTtCnX3K/qOI/upryQ5JlymQQJ8tIJJn+5
	PqF3p+SOdQc10BV0TqnDUdcKZi+4PCn4ymhR0wgzWUw3jJ3mZESHTVdXY8DDlsK4o9Jkd3vGuGf
	zprKEE/HcMven0pdz1E51fibTKuP+4Uc24h5Gz53lE8r/h3q8s66BUKwehNMW+RGgqq0=
X-Gm-Gg: ASbGncvdOxjfSE4dCpz1MzV3TPRCfOAkLmMtMcJhCxzomI5Ik67zfEUNKeLvJ5WFmCE
	WLGBBxfIQz7mLlP1/HS/DAS27BbBGY9p3Q8uARk2LHm5tWkfAP99ebpWUknZnNRuSOYFo9SjN2a
	i+xkj9Q0lAFq9jG5a2rKu2XZkt+UPgx3vjd1of6AXeTLoTBU8w9dX5giXNOI5ACZl9ROHldorTk
	Euy5/ew/NWqmZWaHoOo3Pn2cCmj6BHImvigxtaPxuJi8uMJT2CYvJhtpxGeQb/3GSc9AxlM1TKT
	waqSowVybG/8t+aDqtxK3HAnXCG6eXl5KLv2vr+/jGo355edCsu3cYbRoqDyltk+CvtuMN71BVz
	Hun3Kt+rlS6WmC4N2NlPm00SOGDsZgGyRo/wD/83czXPtkMLzkRpdsgQyvcXWBirD3cc=
X-Received: by 2002:a05:600c:1391:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-458b69ca295mr96547425e9.4.1754395841898;
        Tue, 05 Aug 2025 05:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRVCbz9qSTE0QSs8VJxnp/4QbJ3PPlhM2p3GCusUFNug/XIQgjZ+Xc7sBO+ds4FESyakyM7A==
X-Received: by 2002:a05:600c:1391:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-458b69ca295mr96546975e9.4.1754395841451;
        Tue, 05 Aug 2025 05:10:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm98317775e9.22.2025.08.05.05.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:10:40 -0700 (PDT)
Message-ID: <ca35da97-13d1-49f1-95b0-b8b9c8a7f540@redhat.com>
Date: Tue, 5 Aug 2025 14:10:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
 <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 13:40, Pankaj Raghav (Samsung) wrote:
> Thanks a lot Lorenzo and David for the feedback and quick iteration on
> the patchset. I really like the number of lines of code has been
> steadily reducing since the first version :)
> 
> I will fold the changes in the next series.
> 
> <snip>
>>>> @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
>>>>    	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>>>>    	shrinker_register(huge_zero_folio_shrinker);
>>>> -	deferred_split_shrinker->count_objects = deferred_split_count;
>>>> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
>>>> -	shrinker_register(deferred_split_shrinker);
>>>> +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
>>>> +		if (!get_huge_zero_folio())
>>>> +			pr_warn("Allocating static huge zero folio failed\n");
>>>> +	} else {
>>>> +		deferred_split_shrinker->count_objects = deferred_split_count;
>>>> +		deferred_split_shrinker->scan_objects = deferred_split_scan;
>>>> +		shrinker_register(deferred_split_shrinker);
>>>> +	}
>>>>    	return 0;
>>>>    }
>>>> --
>>>> 2.50.1
>>>>
>>>>
>>>> Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
>>>> then have a user-selectable option.
>>>>
>>>> Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?
>>>
> 
> One of the early feedbacks from Lorenzo was that there might be some
> architectures that has PMD size > 2M might enable this by mistake. So
> the ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO was introduced as an extra
> precaution apart from user selectable CONFIG_STATIC_HUGE_ZERO_FOLIO.

People will find creative ways to mis-configure their system no matter 
what you try :)

So I think best we can do is document it carefully.

-- 
Cheers,

David / dhildenb


