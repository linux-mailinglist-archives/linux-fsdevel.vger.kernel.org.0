Return-Path: <linux-fsdevel+bounces-38919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B902A09D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0643A95C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017D208990;
	Fri, 10 Jan 2025 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbR4zfih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2741A23B0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544079; cv=none; b=noZDvACX5QDkh2w2SWwjwnFJ1hEVB1/n9Bq8nGVvzUJRKgE//SHzGyFpaRXEcLq3cdTgUsBYCpEy2xBv91m5v+yB/QEDCL4gLEaGeiAOIeONHbs8i/2EQr7Z8++Y0qWc4KdvkqORuBPywmQ0J5PNOue+cF7ZCcY9DBP3vWwSR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544079; c=relaxed/simple;
	bh=mgJ+UHSwzN5h0uRwRywpCvwDSE2g1mRG4Ft+OworMXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ll68nQ9e4aDbGogDftycUVey4vLXKPefQi3pwD6HhfPIGmOsIw//9xkE4SGxrhl8VGpGfsrRyqh2QLKvkfA9FwPbCLFkomTGItjD3eiQquVJJHdd6JT6uxwQtOS8HWYG3IBPXEUJuypPaAPIF+hSoZ/qKWN1ljg4JWGPk5xWsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbR4zfih; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736544077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sthEKVmb10XAo4rNGJPWmHpmDGbVRVERpD7LcYoTGpY=;
	b=CbR4zfihkvsrVgXkg1N7esTZfUtz3sUJhV/vBTMP8/Qmlc4C5OoA5p+GU/xF8HgNGwPVtO
	XQIalXPIrwaEzviPjomwbZ1hyTMr1hIKNXur93fIqq3jf9EqjCgA8mIIddI+uOqBiaLhW1
	srYsUtp+VXSNW9PQ3aO4KprpIcBB7gw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379--UU3sW1eMzmJm9r-bnFFJg-1; Fri, 10 Jan 2025 16:21:15 -0500
X-MC-Unique: -UU3sW1eMzmJm9r-bnFFJg-1
X-Mimecast-MFC-AGG-ID: -UU3sW1eMzmJm9r-bnFFJg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43626224274so13707045e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 13:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736544075; x=1737148875;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sthEKVmb10XAo4rNGJPWmHpmDGbVRVERpD7LcYoTGpY=;
        b=FLNvXzZ33h9x3Cz+EmzRFF3S6MLW62qkvUmRfDDs16ExOFOv05jH24VIt331xfANnA
         HmYynwkdTJz9IRhyRyrG9KHdGQ+QQ/kl4lOhT43l/OxgwbM9CBVYBzpLETROJOxHhkJj
         ktHPvCqe44/51NbJdrDg5GDL/eZlksytldjr8Ge/6uzlde6WsdqqxBYbnYCgoZjZx/TX
         mpz4dyPXB21MyD9gz5mz/jzSPn5JpUbkJk1cb6cyt8BmS8f0eLj8iwsu45Q1x/L2mNsc
         cgkg+epMVyviFPBRY6pnizXuIsXXf3cy7sL37jnRQN4r2n4+tjaM6r+dDdaiLQJyhoxc
         h8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCNu1/8dnbivNvBMsPEqKt9Z9fJqvuzMOQ2hkXRp9EzMxSkuvTtvHZzj2DM2mZ1nY+yn16rUP0kXTc5fNw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90gVpHcYCgPAFggaYfUaOcxTMqlDoC4iRU0HyHb2JbQEvjwdG
	zFuV8lvbQLdBW124WIlBtF90a86LJt7IZhU7oFd601tBgoFaS6nLaluIJolYW5aNW0ZtDmyewGO
	0TZxKmFPL819KYc4lQ7cpCrvechqlkzYDNrYq3TIGmcMzr3VcnMUtFWyuhkKlNXE=
X-Gm-Gg: ASbGncvxsEWITO3rNhTXHnoeoSH2hnqzOeEmifRKueqv9F22o+fy1nbIwmvj9g3r/DI
	6tbKs28RtLCXDZXatJztnuqR80ERz3ME6476HmOv3Yj1FDjQobcgAVcSIXrDLwpYXnrQlm+MQho
	hbCZuH2h45R1XqjG431EMfgWGc9vXZF7WyAsD9CXwmpeIpqKPMGUYaSYbVVGR6uGcAYRCzuGp1c
	Lu0pkjoUp642e/STQ7QTo40jxbrptl3n1ORE5GZfSOUjHEW7UtZdx58ARd/o6dmaKp8oNHFf91a
	3rk+UzGnyvnP0XQZBdDbGhCRIKz42QgNVYOctBofq9TaLmONry5RZvtGcbeednVFaHXtzXCBals
	Euh9uTyVg
X-Received: by 2002:a05:600c:5698:b0:434:a7f1:6545 with SMTP id 5b1f17b1804b1-436e2d91910mr101285025e9.27.1736544074656;
        Fri, 10 Jan 2025 13:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ8wFczgFhHwFzj/WleUwk7pix9NascQqOgaTNxpuzbcw4rPO0K0tR8E5rTCDbNHnYqRI57w==
X-Received: by 2002:a05:600c:5698:b0:434:a7f1:6545 with SMTP id 5b1f17b1804b1-436e2d91910mr101284755e9.27.1736544074165;
        Fri, 10 Jan 2025 13:21:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da66e6sm98625705e9.4.2025.01.10.13.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 13:21:12 -0800 (PST)
Message-ID: <def423f4-fecd-4017-9bcb-74a5dbf0e9f5@redhat.com>
Date: Fri, 10 Jan 2025 22:21:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <153c5a4f08daf60e1bbbdde02975392dc608cfdf.camel@kernel.org>
 <e4150b98-99ed-45fc-8485-5ad044f10d84@redhat.com>
 <47fff939fc1fb3153af5b129be600a018c8485e9.camel@kernel.org>
 <c9e4017a-9883-4052-9ca0-774b3745f439@redhat.com>
 <956ae3eba9ef549d4f1ab3dff9e0bb09a39101b2.camel@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <956ae3eba9ef549d4f1ab3dff9e0bb09a39101b2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 22:07, Jeff Layton wrote:
> On Fri, 2025-01-10 at 22:00 +0100, David Hildenbrand wrote:
>> On 10.01.25 21:43, Jeff Layton wrote:
>>> On Fri, 2025-01-10 at 21:20 +0100, David Hildenbrand wrote:
>>>> On 10.01.25 21:16, Jeff Layton wrote:
>>>>> On Tue, 2025-01-07 at 09:34 +0100, David Hildenbrand wrote:
>>>>>> On 06.01.25 19:17, Shakeel Butt wrote:
>>>>>>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>>>>>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>>>>>>> In any case, having movable pages be turned unmovable due to persistent
>>>>>>>>> writaback is something that must be fixed, not worked around. Likely a
>>>>>>>>> good topic for LSF/MM.
>>>>>>>>
>>>>>>>> Yes, this seems a good cross fs-mm topic.
>>>>>>>>
>>>>>>>> So the issue discussed here is that movable pages used for fuse
>>>>>>>> page-cache cause a problems when memory needs to be compacted. The
>>>>>>>> problem is either that
>>>>>>>>
>>>>>>>>      - the page is skipped, leaving the physical memory block unmovable
>>>>>>>>
>>>>>>>>      - the compaction is blocked for an unbounded time
>>>>>>>>
>>>>>>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>>>>>>> worse, the same thing happens on readahead, since the new page can be
>>>>>>>> locked for an indeterminate amount of time, which can also block
>>>>>>>> compaction, right?
>>>>>>
>>>>>> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is
>>>>>> these pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there
>>>>>> *must not be unmovable pages ever*. Not triggered by an untrusted
>>>>>> source, not triggered by an trusted source.
>>>>>>
>>>>>> It's a violation of core-mm principles.
>>>>>>
>>>>>> Even if we have a timeout of 60s, making things like alloc_contig_page()
>>>>>> wait for that long on writeback is broken and needs to be fixed.
>>>>>>
>>>>>> And the fix is not to skip these pages, that's a workaround.
>>>>>>
>>>>>> I'm hoping I can find an easy way to trigger this also with NFS.
>>>>>>
>>>>>
>>>>> I imagine that you can just open a file and start writing to it, pull
>>>>> the plug on the NFS server, and then issue a fsync or something to
>>>>> ensure some writeback occurs.
>>>>
>>>> Yes, that's the plan, thanks!
>>>>
>>>>>
>>>>> Any dirty pagecache folios should be stuck in writeback at that point.
>>>>> The NFS client is also very patient about waiting for the server to
>>>>> come back, so it should stay that way indefinitely.
>>>>
>>>> Yes, however the default timeout for UDP is fairly small (for TCP
>>>> certainly much longer). So one thing I'd like to understand what that
>>>> "cancel writeback -> redirty folio" on timeout does, and when it
>>>> actually triggers with TCP vs UDP timeouts.
>>>>
>>>
>>>
>>> The lifetime of the pagecache pages is not at all related to the socket
>>> lifetimes. IOW, the client can completely lose the connection to the
>>> server and the page will just stay dirty until the connection can be
>>> reestablished and the server responds.
>>
>> Right. It cannot get reclaimed while that is the case.
>>
>>>
>>> The exception here is if you mount with "-o soft" in which case, an RPC
>>> request will time out with an error after a major RPC timeout (usually
>>> after a minute or so). See nfs(5) for the gory details of timeouts and
>>> retransmission. The default is "-o hard" since that's necessary for
>>> data-integrity in the face of spotty network connections.
>>>
>>> Once a soft mount has a writeback RPC time out, the folio is marked
>>> clean and a writeback error is set on the mapping, so that fsync() will
>>> return an error.
>>
>> I assume that's the code I stumbled over in nfs_page_async_flush(),
>> where we end up calling folio_redirty_for_writepage() +
>> nfs_redirty_request(), unless we run into a fatal error; in that case,
>> we end up in nfs_write_error() where we set the mapping error and stop
>> writeback using nfs_page_end_writeback().
>>
> 
> Exactly.
> 
> The upshot is that you can dirty NFS pages that will sit in the
> pagecache indefinitely, if you can disrupt the connection to the server
> indefinitely. This is substantially the same in other netfs's too --
> CIFS, Ceph, etc.
> 
> The big difference vs FUSE is that they don't allow unprivileged users
> to mount arbitrary filesystems, so it's a harder for an attacker to do
> this with only a local unprivileged account to work with.

Exactly my point/concern. With most netfs's I would assume that reliable 
connections are mandatory, otherwise you might be in bigger trouble, 
maybe one of the reasons being stuck forever waiting for writeback on 
folios was not identified as a problem so far. Maybe :)

-- 
Cheers,

David / dhildenb


