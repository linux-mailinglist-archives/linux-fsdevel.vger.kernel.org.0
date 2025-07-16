Return-Path: <linux-fsdevel+bounces-55125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE2B070DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E1356573C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972C2EF65C;
	Wed, 16 Jul 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6uoj5Eh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDB2EE984
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655660; cv=none; b=CvqjqqeGKvsIp5r9gs0cPCQCAr6fxL84cDciJfI4tfXlQPvicm2FD0DJrhmn4A44nEIPV7hKFIEVoPfrWX/hDmvsvwN9jt/V0OKlSC6N9NOtscAYS3yDKLO/Zjv8Tg/l+bIQOv9zEBUwkdDtd2VfrXgrSBP4Z/om/uvdGXNYugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655660; c=relaxed/simple;
	bh=eEqNPgZl9F4OLJdJVQ1EQJfpGkdLK7rmOtl/4WdhmQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4oHzDWwMgxrSX3GOpfL+kMuqTsk6i5AnPxmCVXUsk3QAXqEx2G1yv5YCML7exiP3Q2uLDhAq845JkKmSwC6iU43qPpScPPn0NEVGoCLTCV7P+JGtFV8FeoXLP0tTqn5DNZGtTilFwazI2rSzKn5gvTfaWvIiXo//MinugbzrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6uoj5Eh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752655654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FAnAiFywHXAbLjWEigUI74gY76BGCYQbW5RfBp45JNU=;
	b=g6uoj5EhGFxHyas7GHC61czQCwBiUAHhsEpaE5l2lI8NYhmNrrJW5seLYDnjK7k6erUveg
	OGktmfSxRWCJ2HSGzAXsvJ/nSJAiInsoHCsekarodASmDCXIL/Z4XkFO2zaZRXpW8tJEM6
	LmNmLaXjzHjqeOFmQSu9q3k13QUr+3E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-GRHVZGWAMwCcm6VqaTI4gA-1; Wed, 16 Jul 2025 04:47:33 -0400
X-MC-Unique: GRHVZGWAMwCcm6VqaTI4gA-1
X-Mimecast-MFC-AGG-ID: GRHVZGWAMwCcm6VqaTI4gA_1752655652
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2880532f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 01:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655652; x=1753260452;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FAnAiFywHXAbLjWEigUI74gY76BGCYQbW5RfBp45JNU=;
        b=iP7lUH0aOTrsNK+jlis9zNUARBHOmQgoWgZ+lbkt+uJV46VX2cWzOyYJc7HVofx3x4
         FIX00fOJFqZK80KO8ydojwMrI3TSISbl0IEgx/55TuGJdDyEQS0CyaeKlpS93/wQ2q7b
         Uj9B6YsJ6LLtvvFq0BgtzBxkVE1cvh95yfF2S3zOLAtqZVfCEu2Y66Fd6uFbbIeS0Yh8
         0PuxNtN3IsivtdjlN1o4guIcyfwDOkjPLey/egWKZ0hmx7nw7sBo04JeFdp6xBmkUxY7
         jCIBHw9JyEyMtD0wn66XQwd+q+Vfu+m25tu4fo3yLO1eEYEvrI+k7fI5AaFyIerPXzng
         kNYA==
X-Forwarded-Encrypted: i=1; AJvYcCW/HpvPSydmwdCW++QHFl+alK27tgjY/fGmk1NjwsbbTk5LI8fywyzDBH4IN/WScF3hLRJzPEkpMAkowOU6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/S9V2lkK155jLQl9ANF9MOveFfHzwx/hXmHPjSALN23fnOVDQ
	45HhidUaApxjgI6LVjJVHRmLweSgMWT3bGccY6qgXOr+aTVCNmvXDMM/VuYnxKz2GrXXc+COEaZ
	b2NqxVg1p4JorHfuGsB/NZz9BDfL0kQd/Y1fO5nTVE+FmPYOC8ES+winnwpAwoYI0vDI=
X-Gm-Gg: ASbGncu9RJ9tK/BreWCXlaOjE/j/7OV8DcSMYGUqQTanDSv2v5Lwn6ETAI4jE66ywxb
	3BfA3k4bzYjvvTLGLPcT36w9O72yZcWATA5GWEOEpLyvpo/rIM+ztAXEGs8UcvWbdFLm2OaCNPo
	VArGSYVySfcKjPtV5m12azfP2VsqzELcA35ie2nPJoOrzd+vWbS48zhBfoUZ1B3lQpGly4rzkEc
	WdcqfMUkoatR1OyHzhocged4SRZ/B1g1RGGWolJx++CofuWkkFk0wwjVEVDmpVjnylHuJ1jmZ3i
	23zbQhcqz7XsgSl51uQwHmF8NOj8Pe4RMpJk5Zxx0xq0XRv9490ebtw4dt0U8gnjq2NljiqvINs
	PKvTZLkjlsm4lLt1+8tF69of6rPyUk9Duqdi7q+6dXh1nf4yzKEcvxjiGDS8pr2f8i+k=
X-Received: by 2002:a5d:4d11:0:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3b60dd886b6mr1302798f8f.43.1752655651895;
        Wed, 16 Jul 2025 01:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3qZO19mLEElpOVH5DnIxTGGvgk4PeuiONXf8ykpwxTU+/wfVUL6om/vWTTuDWuKTydeak9w==
X-Received: by 2002:a5d:4d11:0:b0:3a4:dd02:f724 with SMTP id ffacd0b85a97d-3b60dd886b6mr1302770f8f.43.1752655651471;
        Wed, 16 Jul 2025 01:47:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8339d8sm14325085e9.30.2025.07.16.01.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:47:31 -0700 (PDT)
Message-ID: <17a539fa-977c-4f3f-bedf-badd1fc1287a@redhat.com>
Date: Wed, 16 Jul 2025 10:47:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] mm: vm_normal_page*() improvements
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250715132350.2448901-1-david@redhat.com>
 <20250715163126.7bcaca25364dd68835bd9c8b@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250715163126.7bcaca25364dd68835bd9c8b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 01:31, Andrew Morton wrote:
> On Tue, 15 Jul 2025 15:23:41 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Based on mm/mm-new. I dropped the CoW PFNMAP changes for now, still
>> working on a better way to sort all that out cleanly.
>>
>> Cleanup and unify vm_normal_page_*() handling, also marking the
>> huge zerofolio as special in the PMD. Add+use vm_normal_page_pud() and
>> cleanup that XEN vm_ops->find_special_page thingy.
>>
>> There are plans of using vm_normal_page_*() more widely soon.
>>
>> Briefly tested on UML (making sure vm_normal_page() still works as expected
>> without pte_special() support) and on x86-64 with a bunch of tests.
> 
> When I was but a wee little bairn, my mother would always tell me
> "never merge briefly tested patches when you're at -rc6".  But three
> weeks in -next should shake things out.

;) There is one arm oddity around pgdp_get() to figure out that a bot
reported on my github branch, so no need to rush.

Let's see how fast that can be resolved.

> 
> However the series rejects due to the is_huge_zero_pmd ->
> is_huge_zero_pfn changes in Luiz's "mm: introduce snapshot_page() v3"
> series, so could we please have a redo against present mm-new?

I'm confused: mm-new *still* contains the patch from Luiz series that
was originally part of the RFC here.

commit 791cb64cd7f8c2314c65d1dd5cb9e05e51c4cd70
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Jul 14 09:16:51 2025 -0400

     mm/memory: introduce is_huge_zero_pfn() and use it in vm_normal_page_pmd()

If you want to put this series here before Luiz', you'll have to move that
single patch as well.

But probably this series should be done on top of Luiz work, because Luiz
fixes something.

[that patch was part of the RFC series, but Luiz picked it up for his work, so I dropped it
from this series and based it on top of current mm-new]

-- 
Cheers,

David / dhildenb


