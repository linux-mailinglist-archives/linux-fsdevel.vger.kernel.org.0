Return-Path: <linux-fsdevel+bounces-55297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13029B09584
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F16D17829B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB4224B05;
	Thu, 17 Jul 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV+7GME6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA082248A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783167; cv=none; b=FQOt8YXwLSz6ezutNER04/+RZtIV1ghyWxtr8yFKeQaDkqde7Z2HO4u8fGWmifVIq/PPrE2XnoAO72pugdHNOJtjOyuvTlG5qApj02TCn7LpH+Ek35aFVB5pr0ypvSARUDAdv95kjmUmgyWsLHv8qfFMDGWLCiCwJX6Wr94v/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783167; c=relaxed/simple;
	bh=Y9BOWo1aGEIwbtA3tQmCs7treaSOmjwErr427SNsKV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNIJjWzuPj/UL5WKF6N+hHkJSNw6FQlnLN6b6SiAuod5DNxB44w5IrhUNqBqSElJ20v3RhcauGYoc2HFCaDl3HgDxeUHxWA2oeJqgWSIh1IM06YU+tgm+WQ16A6ukveV4rj2GoJ8DLrXZ1jkEtykObJ2dLYULFSIFlb4gOvYM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MV+7GME6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752783163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KwbrI84IedQLHDSyTV7Sjdel/mNA8veF7wrxE3TB6nI=;
	b=MV+7GME6rJOEQ0mJGtBM+PL0UR/4sQHRoz0/Oi51aZJQCDDC6HzZjj7dC/KUiOprvx3Am4
	3aPUDZcOoy6iSEaInK4qo7Ue+jmlJMF1mMlg77wVWvtM+wm8YIbQE9iE7wNKkgurihzJk9
	FO19+UiPnnKE2u+n47xNA72SrLCVN/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140--5q7rWUpP0uVEh2SqVpIaQ-1; Thu, 17 Jul 2025 16:12:42 -0400
X-MC-Unique: -5q7rWUpP0uVEh2SqVpIaQ-1
X-Mimecast-MFC-AGG-ID: -5q7rWUpP0uVEh2SqVpIaQ_1752783161
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45624f0be48so7181675e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 13:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752783161; x=1753387961;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KwbrI84IedQLHDSyTV7Sjdel/mNA8veF7wrxE3TB6nI=;
        b=QPzfugYVlgJNDxuuxrfGH51rgsDVb12Afv7NdH2MNxCeyTE61fz7qEoARF5163SMxq
         azZ0fnOury/pAPjhfUX6MQK5wccuo0HuKgaK61GZ1abmBM1KjM+3Kcd/HsK6dUp9IgEe
         YiNoJLjfC62TCbtLDXhI+sbIkNE6ajLa26eZhibgTuptjGT3WhKbWLfbfl3AuRrj4vvk
         2qhOaQDhSdK2BKEsbqIMQ2lCfM5Qm3P98DUb31q3fEC2MQxfhvFXnxxHreiqDFJBcqrA
         iuvhO5+a8BRMmsf3CtSMHINpTmNNrojEu1jjxmdSr+oWtXNPQJipIfjtr6YEm7jX4t26
         wg8g==
X-Forwarded-Encrypted: i=1; AJvYcCXGP/IwJUinUuSRxemWs+H5lXw7GE1THDmdMWVC2tXPbwXyqkpobnYLcYWFds2V7tBUlQkwCqez6QEGIY5R@vger.kernel.org
X-Gm-Message-State: AOJu0YzmVbbwPvdgdbuhLfp84lod7FQIZnFNUcLF5PK5FonV8j0K8/Ub
	bhwGkaFplJVVuiYff7lFABChbfyeN+li4LKNIm5i7Ke0Xzv5s9HhvCqrbm1F3KovidutF5rqFKu
	cZQIKGFoEkzLA6Qe6LhgJ4Cyrw2wAKxXzx7dTjNUp/WfpdFR7I+tZZHFjswvFH//c4l0=
X-Gm-Gg: ASbGncs8dx2xVQvsk+FX2NgnX+OYvnq1RymIO+NYO5QZECtM6KcmiVx95L/7uNr5Jar
	40T6GsWOg0k+pYOeU3n5NAWhk/aRrec9Ut6v4e/rJyLB9+Y3+ubtaeT9b9n6Wv/Ojq50Qd338hV
	gBpLq0nFS9a3dvaXCZI4LcqH3UTcWtfp872HG/BZTKQPdVqg0GktYEx0fYfw8g2zm1bb20eNrr6
	10hxodFND2BJCqYQOa2pbw6wS8ua4zO/P1gMY2ZBqNjHkSLw+PaNOYCI7JA4VRJQTIY6FQQbUaY
	58FGS2ELCPvHy6p4ioad2IX/3rHD2zfLMDmeBNhJcrR7a945WvSRdmbeTY7fX6c5hYIiygCTlSD
	DWPVZvPw9NYa6lSv1pakwSS324KblbqmeX/C2yxVERyAeyUMPTyBQzt/cl2VQTQH4
X-Received: by 2002:a05:600c:8209:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-4563253d35emr65010685e9.15.1752783160744;
        Thu, 17 Jul 2025 13:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHauEOdTi1gNn5e67j5pIyWoWtoQZGIdE1jxaf6Cv3U+77VZ32+s2gCNs4Xz5QMDsPlAlc41Q==
X-Received: by 2002:a05:600c:8209:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-4563253d35emr65010405e9.15.1752783160218;
        Thu, 17 Jul 2025 13:12:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:2b00:b1a5:704a:6a0c:9ae? (p200300d82f352b00b1a5704a6a0c09ae.dip0.t-ipconnect.de. [2003:d8:2f35:2b00:b1a5:704a:6a0c:9ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600a39281sm13907105f8f.73.2025.07.17.13.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:12:39 -0700 (PDT)
Message-ID: <d62fd5c9-6ee1-466f-850b-97046b14ebff@redhat.com>
Date: Thu, 17 Jul 2025 22:12:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] mm/memory: factor out common code from
 vm_normal_page_*()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-8-david@redhat.com>
 <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> -/*
>> - * vm_normal_page -- This function gets the "struct page" associated with a pte.
>> +/**
>> + * vm_normal_page_pfn() - Get the "struct page" associated with a PFN in a
>> + *			  non-special page table entry.
> 
> This is a bit nebulous/confusing, I mean you'll get PTE entries with PTE special
> bit that'll have a PFN but just no struct page/folio to look at, or should not
> be touched.
> 
> So the _pfn() bit doesn't really properly describe what it does.
> 
> I wonder if it'd be better to just separate out the special handler, have
> that return a boolean indicating special of either form, and then separate
> other shared code separately from that?

Let me think about that; I played with various approaches and this was 
the best I was come up with before running in circles.

> 
>> + * @vma: The VMA mapping the @pfn.
>> + * @addr: The address where the @pfn is mapped.
>> + * @pfn: The PFN.
>> + * @entry: The page table entry value for error reporting purposes.
>>    *
>>    * "Special" mappings do not wish to be associated with a "struct page" (either
>>    * it doesn't exist, or it exists but they don't want to touch it). In this
>> @@ -603,10 +608,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>>    * (such as GUP) can still identify these mappings and work with the
>>    * underlying "struct page".
>>    *
>> - * There are 2 broad cases. Firstly, an architecture may define a pte_special()
>> - * pte bit, in which case this function is trivial. Secondly, an architecture
>> - * may not have a spare pte bit, which requires a more complicated scheme,
>> - * described below.
>> + * There are 2 broad cases. Firstly, an architecture may define a "special"
>> + * page table entry bit (e.g., pte_special()), in which case this function is
>> + * trivial. Secondly, an architecture may not have a spare page table
>> + * entry bit, which requires a more complicated scheme, described below.
> 
> Strikes me this bit of the comment should be with vm_normal_page(). As this
> implies the 2 broad cases are handled here and this isn't the case.

Well, pragmatism. Splitting up the doc doesn't make sense. Having it at 
vm_normal_page() doesn't make sense.

I'm sure the educated reader will be able to make sense of it :P

But I'm happy to hear suggestions on how to do it differently :)

> 
>>    *
>>    * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
>>    * special mapping (even if there are underlying and valid "struct pages").
>> @@ -639,15 +644,72 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>>    * don't have to follow the strict linearity rule of PFNMAP mappings in
>>    * order to support COWable mappings.
>>    *
>> + * This function is not expected to be called for obviously special mappings:
>> + * when the page table entry has the "special" bit set.
> 
> Hmm this is is a bit weird though, saying "obviously" special, because you're
> handling "special" mappings here, but only for architectures that don't specify
> the PTE special bit.
> 
> So it makes it quite nebulous what constitutes 'obviously' here, really you mean
> pte_special().

Yes, I can clarify that.

> 
>> + *
>> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
>> + *	   NULL if this is a "special" mapping.
>> + */
>> +static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
>> +		unsigned long addr, unsigned long pfn, unsigned long long entry)
>> +{
>> +	/*
>> +	 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table mappings
>> +	 * (incl. shared zero folios) are marked accordingly and are handled
>> +	 * by the caller.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
>> +		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
>> +			if (vma->vm_flags & VM_MIXEDMAP) {
>> +				/* If it has a "struct page", it's "normal". */
>> +				if (!pfn_valid(pfn))
>> +					return NULL;
>> +			} else {
>> +				unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +				/* Only CoW'ed anon folios are "normal". */
>> +				if (pfn == vma->vm_pgoff + off)
>> +					return NULL;
>> +				if (!is_cow_mapping(vma->vm_flags))
>> +					return NULL;
>> +			}
>> +		}
>> +
>> +		if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
> 
> This handles zero/zero huge page handling for non-pte_special() case
> only. I wonder if we even need to bother having these marked special
> generally since you can just check the PFN every time anyway.

Well, that makes (a) pte_special() a bit weird -- not set for some 
special pages and (b) requires additional runtime checks for the case we 
all really care about -- pte_special().

So I don't think we should change that.

[...]

>>
>> +/**
>> + * vm_normal_folio() - Get the "struct folio" associated with a PTE
>> + * @vma: The VMA mapping the @pte.
>> + * @addr: The address where the @pte is mapped.
>> + * @pte: The PTE.
>> + *
>> + * Get the "struct folio" associated with a PTE. See vm_normal_page_pfn()
>> + * for details.
>> + *
>> + * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
>> + *	   NULL if this is a "special" mapping.
>> + */
> 
> Nice to add a comment, but again feels weird to have the whole explanation in
> vm_normal_page_pfn() but then to invoke vm_normal_page()..

You want people to do pointer chasing to find what they are looking for? :)

-- 
Cheers,

David / dhildenb


