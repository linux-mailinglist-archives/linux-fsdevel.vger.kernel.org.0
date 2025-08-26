Return-Path: <linux-fsdevel+bounces-59160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5980BB353FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E731B64F89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 06:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877102D660E;
	Tue, 26 Aug 2025 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H08jhOiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3119309C
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189044; cv=none; b=GOEYyk8+Q58pdCGP8Q6sqDH+a0vLhRDTkgZRzzuU3W1SpAkDwGpdBddNWB2qk2PNtzO23efUEVijzUdSqZcM2SjqN90BkY2S5/ECVs9TSSMGHcFSVbuceBkql+oFi39d4ABOkMsbnRmCQSXRboN2jVGVdoeeoJPzNs0Eu9biKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189044; c=relaxed/simple;
	bh=1PbkjVHdW2fZRMcq6rjrlyuBH+np9L5OxT64eRt41gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN8F8IoNNLiHeO6XyjeIurX/afNtcyBJOpo89783zDQfgELdzSy1qdDLfX2zouYPFkM+H1ctzO6Zyz7+Xd9BxK8wHtrBITXyhPxJ4+IYM0mrsGCMpUVtmS1EGy6vbGquaoRiczb5OqNQidY3EV2S4lIq+rJpEx5kLTzyjqI67vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H08jhOiH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756189041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xk7Km5HTVMpJ1b1NXcCsWrU5BXZBqRoDajCCwh1oGmE=;
	b=H08jhOiHFRGCgjoo1xdQfNI+RxvcYDp/+s64yJ2j6OxZQGbLVm9VEyW3qdNKo24F9rXZfD
	CnAhb1icRzXc1cHcE0QO3uatvAi2Cl20zIQlPRCm0LEy/tg8iyfYGaFNS18qscYnACL+3B
	Y8ZzqX0VuIToVLarrJe6UxATJMh9abY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-hq_lrprFO4qe-JA1pM3vJg-1; Tue, 26 Aug 2025 02:17:18 -0400
X-MC-Unique: hq_lrprFO4qe-JA1pM3vJg-1
X-Mimecast-MFC-AGG-ID: hq_lrprFO4qe-JA1pM3vJg_1756189038
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a256a20fcso28784995e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 23:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189037; x=1756793837;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xk7Km5HTVMpJ1b1NXcCsWrU5BXZBqRoDajCCwh1oGmE=;
        b=Juo/Rj3MUgGHVFWa9uURBTC4mir/VIG7XO4p90zb8uYqHYjsKgBwlNYzik5PsqbH2v
         DpYtrTfJHyKRAXXJEAO83yS/YUE+udlHLmlzXKgeXhrOWEnCdWn74xi9XsqQ3mtzLHf+
         SdBHleuneFDBrts99AMIk+qLy0Pw7qXZeUcQyNVdmixMjo2gji6hKbuGWtrDFNM2cQB+
         CPut0fjuIHRwk8nnPtWjQZWfR4q6g0HIkiNasv+TPkFtK/8BLGyMer/osdzmEFJ2VJ1b
         bkkHSa8a5ojTQOhEhRGRXfWWpp2Rcm2H9uEITbNjq8n9vl+Q+BjN5klVAo/kn9k5y7T0
         6+cw==
X-Forwarded-Encrypted: i=1; AJvYcCXA6OL/TWhATsw7BARfDMpCKVC/+lhdLItCqIyvRwvSQyYdpKtICRCsOhT02pVUTH/lPEVdBVOUf2gI5CK3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sazCOgiZgeENaj/wn4fiUB2aZCPPpeWyziAm6mVSP1Pm3r2z
	u7Ci67nLddFsK7qTd36DEcyI4VsF+e2ecah5pnHaX/DxtPNmY9F8i2+7zCSc5Iqe8Q+jeVe+o6/
	NNbnuW+cTh0d3NzoVa404GnVG2ftjVUZQ8Mjdq5E4HipXDTYh5G1EbQ2zxbqVNnietAo=
X-Gm-Gg: ASbGncsrP8C2teDs9Dz3CnxnYCC38nyjog470l8i4eZoAdx52+U1XvIFQPUkOu4Srt+
	wB7RSni3JWzfg2budYhgmy4lr+ahPS+p9JsikxDPfLNzz1qd3XfAbLqOatVBv4p/FjqYcIhGhn6
	0vthQXefHbJyBf06TpD0iILXom5CAy85XXzWmoHHOZ9JiXwAbS/V05E1Xs693gaR+J4Xb/ic3Gu
	1dYEpDHsBh9iyKVGtfQult9oielub3Qq/KvFxJvc7rZj7zAKRi5uJvjlgQF/bYlNGLdO3eZBBYq
	HxJag6aeOCEpTwYsMuuDOL8pcghjy3DtYLRM2uWPI3udiLGEUwxOP7hcvgZ3ASzorxxhIPIAdA=
	=
X-Received: by 2002:a05:600c:3b26:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-45b517caa99mr120121525e9.19.1756189037408;
        Mon, 25 Aug 2025 23:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5JT88KMbfYqdABB2ZNx/5fJ3ePuTbJHoO0rv18+tnNMdWIHHT7WWjXjYCyLy3ILR8WgCBpw==
X-Received: by 2002:a05:600c:3b26:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-45b517caa99mr120121265e9.19.1756189036964;
        Mon, 25 Aug 2025 23:17:16 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6619b53asm9727285e9.1.2025.08.25.23.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:17:16 -0700 (PDT)
Message-ID: <f3e626ab-9bf9-4a08-b626-e739515727eb@redhat.com>
Date: Tue, 26 Aug 2025 08:17:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
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
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-9-david@redhat.com>
 <923b279c-de33-44dd-a923-2959afad8626@redhat.com>
 <9ad69d4f-69b7-4998-9639-4e8f679a2d9d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9ad69d4f-69b7-4998-9639-4e8f679a2d9d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 07:25, Lorenzo Stoakes wrote:
> On Mon, Aug 25, 2025 at 02:31:00PM +0200, David Hildenbrand wrote:
>> On 11.08.25 13:26, David Hildenbrand wrote:
>>> print_bad_pte() looks like something that should actually be a WARN
>>> or similar, but historically it apparently has proven to be useful to
>>> detect corruption of page tables even on production systems -- report
>>> the issue and keep the system running to make it easier to actually detect
>>> what is going wrong (e.g., multiple such messages might shed a light).
>>>
>>> As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
>>> to take care of print_bad_pte() as well.
>>>
>>> Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
>>> implementation and renaming the function to print_bad_page_map().
>>> Provide print_bad_pte() as a simple wrapper.
>>>
>>> Document the implicit locking requirements for the page table re-walk.
>>>
>>> To make the function a bit more readable, factor out the ratelimit check
>>> into is_bad_page_map_ratelimited() and place the printing of page
>>> table content into __print_bad_page_map_pgtable(). We'll now dump
>>> information from each level in a single line, and just stop the table
>>> walk once we hit something that is not a present page table.
>>>
>>> The report will now look something like (dumping pgd to pmd values):
>>>
>>> [   77.943408] BUG: Bad page map in process XXX  pte:80000001233f5867
>>> [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
>>> [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
>>>
>>> Not using pgdp_get(), because that does not work properly on some arm
>>> configs where pgd_t is an array. Note that we are dumping all levels
>>> even when levels are folded for simplicity.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>    include/linux/pgtable.h |  19 ++++++++
>>>    mm/memory.c             | 104 ++++++++++++++++++++++++++++++++--------
>>>    2 files changed, 103 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index bff5c4241bf2e..33c84b38b7ec6 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -1966,6 +1966,25 @@ enum pgtable_level {
>>>    	PGTABLE_LEVEL_PGD,
>>>    };
>>> +static inline const char *pgtable_level_to_str(enum pgtable_level level)
>>> +{
>>> +	switch (level) {
>>> +	case PGTABLE_LEVEL_PTE:
>>> +		return "pte";
>>> +	case PGTABLE_LEVEL_PMD:
>>> +		return "pmd";
>>> +	case PGTABLE_LEVEL_PUD:
>>> +		return "pud";
>>> +	case PGTABLE_LEVEL_P4D:
>>> +		return "p4d";
>>> +	case PGTABLE_LEVEL_PGD:
>>> +		return "pgd";
>>> +	default:
>>> +		VM_WARN_ON_ONCE(1);
>>> +		return "unknown";
>>> +	}
>>> +}
>>
>> One kernel config doesn't like the VM_WARN_ON_ONCE here, and I don't think we
>> really need it. @Andrew can you squash:
> 
> Out of interest do you know why this is happening? xtensa right? Does
> xtensa not like CONFIG_DEBUG_VM?

We don't happen to include mmdebug.h in a xtensa configuration.

Briefly thought about using a BUILD_BUG_ON_INVALID(), but decided to 
just drop it completely.

-- 
Cheers

David / dhildenb


