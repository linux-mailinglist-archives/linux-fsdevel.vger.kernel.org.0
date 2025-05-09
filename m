Return-Path: <linux-fsdevel+bounces-48575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C91AB115C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88E37B16DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939BD28FA92;
	Fri,  9 May 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7FqJpug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1728F930
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788365; cv=none; b=SuTvxxPRpQZbESbdJrXGXqKYZCAY2dwh+Bwj3ZQHWWLPEE4+R5mOZgBS+q6yEMcGVoWg3qw6gPTwO0g6eCENETc0PD4bTYJrHPtmPd9DrGw1Fl9LHVJPYpSW1DM58CEUne4jOl+2tVHS0MhpysLSGiooZxq3WdZVJq50pL4cClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788365; c=relaxed/simple;
	bh=QMnylHRb8gVaUhyCPdjCYA4w3j7YIJu3CW/RKmqnP5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLSQi48vtfkuJ6rjn/hFgh2u4ueh71bTAmIKLEjZWbwQFmDU2OP/C5OSHUSiKYU9LwiIKcggOTRRXOsakZ8mV8ztbM+GrlrPuUWvYKRDbXp8ZJ4OR7EaN8nVbmiIBo+ZV0UzJdoxz0em+H5X5H7xRVLlHgDa568Rn2Av/R8RvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7FqJpug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746788362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y10xkQY/yB4xBwq93/OQLm1G4yJYnmq+zMsTVySDiHU=;
	b=d7FqJpugFS0T/qYJgTSn6izG00AKIidHPYoA7JtfpZfvD88HIdDFTgwDpu0XMPPsP3EutY
	vzdLfAaVNud1cDOgtHyL0YQ7tjkJVg5QEcddHi7+/lSo98pYKRdyTWysSWCQrf0v7TtPI2
	YrK5GqQbxJ+x6QMBRuphL7CiCMpL9ic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VbNkbvRHNUyO5ZwW5tejSA-1; Fri, 09 May 2025 06:59:21 -0400
X-MC-Unique: VbNkbvRHNUyO5ZwW5tejSA-1
X-Mimecast-MFC-AGG-ID: VbNkbvRHNUyO5ZwW5tejSA_1746788360
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so9872645e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 03:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788360; x=1747393160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y10xkQY/yB4xBwq93/OQLm1G4yJYnmq+zMsTVySDiHU=;
        b=p+QO7A2rRmZ3beLzM64E/MbOJZGLGNEmzZUhHsUBo/ZbXTEbhO6lWhYERIEJica6rO
         +E1fS2RJxrRKkI8FtjPNc/dAqr5pSLqPmPrhlxcpVZQ+8Jn/lYRJPtTNklRwwaTwhW1s
         Fa+2+7lSo6kl99umbvsIFOQrydF93ScelOcSFYI+W5fQgx0xUXSY+0QfK8HKyRp/4y7g
         KLdj0/PZ7wo9Yws8AzTDyxOAaMjjkhdQJ2U7oJt9+WTMi/i4CQsF2xFfdqjV+khzMxzt
         NxfkjMI08SiBMg33WsWpboX7F1dinOzyl/1SGmcFGsg6Kmb+6sNCypC6YrXsD+KsLsMc
         4J5w==
X-Forwarded-Encrypted: i=1; AJvYcCUQrfN4zCTSzuqd/Pu0mhvnayebWzZ3el3vS0fg7M2xW8JQHxT+sJS+1CMUJzqqlgcuWYJM5cZ/G519oPqT@vger.kernel.org
X-Gm-Message-State: AOJu0YysOYn2eM3BCrdSX2aaotXDCYweeKqUo0+FH7LzZvywQbVWKp3D
	TzAKo64Ge7MDu6PsqSaEH7cK8wNpRsz71PEi3+Q3kl/6uPzMKH6nbYC/QwFzgIA498DeZwcav8y
	WI1iZuw0+rFWtA/1ro3QNTsPE2+ITrZ5suRbViSQ+a0uo7qD57Q+SdLduJHsYHHZJ81x+K+A=
X-Gm-Gg: ASbGncuFz6DWvMOenJB/y6umfYq/A44EVsfkGQqlVN/apqnVNObE8NodRC4vV3h+6k4
	7vsgo/G4/GpGlzkApfN5kEe5gQsRvHFUMqu27nqxL65tFvihX1xozdlLF5IxwkJNSUxvG/4Wwfu
	5G0ljgLIoUxW99xphxu/s8kC5a8jJBZGJUyjOOgRxtwaWsLh8KuiS+d8fGy8fGa02GVAnz5CBmx
	8+Gp+DPpPl8zZmq3HVn4sMpTW60jcTSr8gU+cFz0+EBn/mm8iU9eav4p8b0pShTzOBx9VUp+bpi
	qGYLC8nsuG1SnqvBG6dGwTaGMLjDS/gahLi1o2w6SW7qAoQMD28xw0XBFCG5vIOYy3TFcL/GweM
	PdrssXjZM7Hri5tbQZgzV3SJ3pjOk6Xcs8DUneqs=
X-Received: by 2002:a05:600c:1550:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-442d6d6abfdmr26010835e9.17.1746788359923;
        Fri, 09 May 2025 03:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa9C6hfO9VHsveOSNGjMF0/uVuCXCExS9GUXXbncTi6ENUgjE4uCm4Jc8Z0rbOqKoSCcqvlg==
X-Received: by 2002:a05:600c:1550:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-442d6d6abfdmr26010595e9.17.1746788359474;
        Fri, 09 May 2025 03:59:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d5c09sm26141235e9.7.2025.05.09.03.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 03:59:19 -0700 (PDT)
Message-ID: <ac65e657-bfd5-4e6a-a909-79107d23cd1c@redhat.com>
Date: Fri, 9 May 2025 12:59:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: introduce new .mmap_prepare() file callback
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <c958ac6932eb8dd9ddbd2363bc2d242ff244341b.1746615512.git.lorenzo.stoakes@oracle.com>
 <2204037e-f0bd-4059-b32a-d0970d96cea3@redhat.com>
 <9f479d46-cf06-4dfe-ac26-21fce0aafa06@lucifer.local>
 <5a489fa9-b2c0-4a7d-aa0e-5a97381e6b33@redhat.com>
 <9b9fd5ce-c303-46c4-acc7-40db1201f70a@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9b9fd5ce-c303-46c4-acc7-40db1201f70a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.05.25 12:57, Lorenzo Stoakes wrote:
> On Fri, May 09, 2025 at 12:51:14PM +0200, David Hildenbrand wrote:
>>
>>>>> +
>>>>> +static inline int __call_mmap_prepare(struct file *file,
>>>>> +		struct vm_area_desc *desc)
>>>>> +{
>>>>> +	return file->f_op->mmap_prepare(desc);
>>>>> +}
>>>>
>>>> Hm, is there a way avoid a copy of the exact same code from fs.h, and
>>>> essentially test the implementation in fs.h (-> more coverage by using less
>>>> duplciated stubs?).
>>>
>>> Not really, this kind of copying is sadly part of it because we're
>>> intentionally isolating vma.c from everything else, and if we try to bring
>>> in other headers they import yet others and etc. etc. it becomes a
>>> combinatorial explosion potentially.
>>
>> I guess what would work is inlining __call_mmap_prepare() -- again, rather
>> simple wrapper ... and having file_has_valid_mmap_hooks() + call_mmap()
>> reside in vma.c. Hm.
>>
>> As an alternative, we'd really need some separate header that does not allow
>> for any other includes, and is essentially only included in the other header
>> files.
>>
>> Duplicating functions in such a way that they can easily go out of sync and
>> are not getting tested is really suboptimal. :(
> 
> This is a problem that already exists, if minimised. Perfect is the enemy of
> good - if we had make these tests existence depend on being able to isolate
> _everything_ they'd never happen :)
> 
> But I will definitely try to improve the situation, as I couldn't agree more
> about de-syncing and it's a concern I share with you.
> 
> I think we have a bit of a mess of header files anyway like this, random helpers
> put in random places etc.
> 
> It doesn't help that a random driver/shm reference call_mmap()...

Yes ...

> 
> Anyway, this is somehwat out of scope for this series, as we already have a
> number of instances like this and this is just symptomatic of an existing
> problem rather than introducing it.
> 
> I think one thing to do might be to have a separate header which is explicitly
> for functions like these to at least absolutely highlight this case.

Yes, and then just include it in the relevant header files.

> 
> The VMA tests need restructuring anyway, so it can be part of a bigger project
> to do some work cleaning up there.

Cool!

-- 
Cheers,

David / dhildenb


