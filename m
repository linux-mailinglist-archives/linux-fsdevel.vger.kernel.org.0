Return-Path: <linux-fsdevel+bounces-55209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B556AB086F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C51F7BAD46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7526A0E7;
	Thu, 17 Jul 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOMU5Oga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C8267F4C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737711; cv=none; b=Kmlbko6AGctzMQVcrhMZrOHcjDk76Ifi1YzK6WfBwKkgnV1jlyWQhNZ2kwQ6YhlMZjAD/C7kI6Bw+rMzridGyyf0JCnqgIOYc9NzOQfVZRpMls3Mhi5+NfDk5WqSxajotdOlLfu3DXekodU2XmtI/EiH9MhNzXM+SOsbNkLBVmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737711; c=relaxed/simple;
	bh=+PQqRj/+APqDPfJKyjrfclx/vTYwfsNsxaUV9DAeknA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leFjolD5OIZTo6TxylTheIEBoy0aW+StbQ2HjgEiYASSPzGSZjYUrDIzBHB04UeNIaNk/r2PnyykrAasdHd+DhWx3G6/+BPF+hY16DT8/05tIW9f42ecEaX/motSXMQ1yLKhboE7dx8JgJzLmCiW+YmLnv5JE/MAjyYaXQZpdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOMU5Oga; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752737707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dujvEOHGoGkKIbh2VcvWWUHTqJBgDW3Vgo4cGXVPWNY=;
	b=bOMU5OgaFnY42c76qy5GEZ68gkxdaWgFbkfrNt0sDA0Og4rnjzXv6pqkrUGOll4z5jODSK
	R5WgTB3m5glo6tvFE4d6hXsdRP4SZZExofIeNxx6ZU3YnHO4SfRkGLceNNaMgM2BJ0Qwqq
	aDRtmqRoQEOoWzuLD26yQzl2R3yrKO8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-P58-niP_MgiIyWh_pdIbtw-1; Thu, 17 Jul 2025 03:35:05 -0400
X-MC-Unique: P58-niP_MgiIyWh_pdIbtw-1
X-Mimecast-MFC-AGG-ID: P58-niP_MgiIyWh_pdIbtw_1752737704
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so6110275e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 00:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737704; x=1753342504;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dujvEOHGoGkKIbh2VcvWWUHTqJBgDW3Vgo4cGXVPWNY=;
        b=H0sHn/XbH8vETpR2B9LE8Mt3vf4+uHrNlHXBUfYJV46tVMGAKPaNURTqavbv40cJhA
         BoX07z+3f/9FU91FgIQRkFlo4Lr3TphgwxoPEIIhdLtzibgpU/UVPb4VyaV88cAyVnDe
         uv/lHaJOWm9WMSV/bIDWMp8Qcje2RdgNAKGUhRGm4e+8hSXcbfhqeOOcHFnKGD80gJ8v
         qtEJd7aP+Zg4PcWGROaKlFCzUxD4jhhwSRJFaRC1nQl6Jke52MbHfEv0QgkZykkvOogR
         qTwXfDAO2vD0Q1sXRkQhR3tRKJojJGe6g13yuM42fI7K4lG5pQIm8tNah55Qki7xX+SS
         6vtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK91r0INyv81sMqMu/bSI/Do6penO5ffRW0URBDlWHuHyBG33GF8nIyG/HUkCASagzuFeRVpj69oQ3XtNw@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbLVRIsqJN9tP9KITb+BjSCzvZo118bqKz/iM5B/OAJUjjrkx
	Gobv+XE4GFjpI6YFv/H1hTU//j28Jbagq5rKOjwJOO+iN0gVXHw9hpOmcBhnp1q1PByWzSyhAii
	VCHyiI75tgRg8wzazrWbTP0wH4znapFg7F9+lDeXtI6i/M7dH381LhRLsbUJ3l+dOUSs=
X-Gm-Gg: ASbGncuu7YFChanpmgvqaT8jHSIMC9nIQctd5xN1qatVsfAOaKOS+JSCFR9vf9bqO4a
	G8wUzqRNjR5VKtgxLaWj93L+1NL44S11Q3kTaUy5waD0xYHW3njIbWlVqUhc6Elf8LoLGt3MYnq
	6AhGYPhXNdNjcLEhdtFYjKEgeqeInvaxOPAgUMWWHiUFcyy30SO3dbz+hC34nCBuCWbnHLXgmwi
	Upn8AYZSMZkqk7G7oEqC3mVr1qKL2NzZadsyJ2/AMXnRcvoieI6fA/wW3YtPNkDP51OFzp2dvvL
	Or2LyMfEsVLuJfDXO4vNRtnl+86r8rLW/DnacYRAXDaeIGZ00dDXZu9AtpoNgUNomvvX0wvPTT3
	r4FpuyyHr5uha5oB8Bugkd8aq6Fd6MB0eKSdRQRmEe0yXHo8w963Isw/1QpFMED2F
X-Received: by 2002:a05:600c:820f:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4562ed57638mr48600745e9.6.1752737703926;
        Thu, 17 Jul 2025 00:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtTyLPcaxAHqteD7RhIpkLjY6DinVSnPGFlCTrTsNMCpipiqNTjkckjgG4pKMNN42D/qwMTg==
X-Received: by 2002:a05:600c:820f:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4562ed57638mr48600205e9.6.1752737703460;
        Thu, 17 Jul 2025 00:35:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2d4fsm43469055e9.4.2025.07.17.00.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 00:35:02 -0700 (PDT)
Message-ID: <336b1801-869d-47ff-a942-c100e0d07d75@redhat.com>
Date: Thu, 17 Jul 2025 09:35:01 +0200
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
 <17a539fa-977c-4f3f-bedf-badd1fc1287a@redhat.com>
 <20250716152710.59e09fe5056010322de2a1a3@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716152710.59e09fe5056010322de2a1a3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.07.25 00:27, Andrew Morton wrote:
> On Wed, 16 Jul 2025 10:47:29 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>>
>>> However the series rejects due to the is_huge_zero_pmd ->
>>> is_huge_zero_pfn changes in Luiz's "mm: introduce snapshot_page() v3"
>>> series, so could we please have a redo against present mm-new?
>>
>> I'm confused: mm-new *still* contains the patch from Luiz series that
>> was originally part of the RFC here.
>>
>> commit 791cb64cd7f8c2314c65d1dd5cb9e05e51c4cd70
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Mon Jul 14 09:16:51 2025 -0400
>>
>>       mm/memory: introduce is_huge_zero_pfn() and use it in vm_normal_page_pmd()
>>
>> If you want to put this series here before Luiz', you'll have to move that
>> single patch as well.
>>
>> But probably this series should be done on top of Luiz work, because Luiz
>> fixes something.
> 
> I'm confused at your confused.  mm-new presently contains Luiz's latest
> v3 series "mm: introduce snapshot_page()" which includes a copy of your
> "mm/memory: introduce is_huge_zero_pfn() and use it in
> vm_normal_page_pmd()".

Let's recap: you said "the series rejects due to the is_huge_zero_pmd ->
is_huge_zero_pfn changes in Luiz's "mm: introduce snapshot_page() v3"
series"

$ git checkout mm/mm-new -b tmp
branch 'tmp' set up to track 'mm/mm-new'.
Switched to a new branch 'tmp'
$ b4 shazam 20250715132350.2448901-1-david@redhat.com
Grabbing thread from lore.kernel.org/all/20250715132350.2448901-1-david@redhat.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 17 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 65 code-review messages
Checking attestation on all messages, may take a moment...
---
   ✓ [PATCH v1 1/9] mm/huge_memory: move more common code into insert_pmd()
   ✓ [PATCH v1 2/9] mm/huge_memory: move more common code into insert_pud()
   ✓ [PATCH v1 3/9] mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
   ✓ [PATCH v1 4/9] fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
   ✓ [PATCH v1 5/9] mm/huge_memory: mark PMD mappings of the huge zero folio special
   ✓ [PATCH v1 6/9] mm/memory: convert print_bad_pte() to print_bad_page_map()
   ✓ [PATCH v1 7/9] mm/memory: factor out common code from vm_normal_page_*()
     + Reviewed-by: Oscar Salvador <osalvador@suse.de> (✓ DKIM/suse.de)
   ✓ [PATCH v1 8/9] mm: introduce and use vm_normal_page_pud()
     + Reviewed-by: Oscar Salvador <osalvador@suse.de> (✓ DKIM/suse.de)
   ✓ [PATCH v1 9/9] mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()
     + Reviewed-by: Oscar Salvador <osalvador@suse.de> (✓ DKIM/suse.de)
   ---
   ✓ Signed: DKIM/redhat.com
---
Total patches: 9
---
  Base: using specified base-commit 64d19a2cdb7b62bcea83d9309d83e06d7aff4722
Applying: mm/huge_memory: move more common code into insert_pmd()
Applying: mm/huge_memory: move more common code into insert_pud()
Applying: mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
Applying: fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
Applying: mm/huge_memory: mark PMD mappings of the huge zero folio special
Applying: mm/memory: convert print_bad_pte() to print_bad_page_map()
Applying: mm/memory: factor out common code from vm_normal_page_*()
Applying: mm: introduce and use vm_normal_page_pud()
Applying: mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()
$ make mm/memory.o
...
   CC      mm/memory.o

I know that a tree from yesterday temporarily didn't have Luiz patches, so
maybe that's what you ran into.

*anyhow*, I will resend to work around that arm pgdp_get() issue.


-- 
Cheers,

David / dhildenb


