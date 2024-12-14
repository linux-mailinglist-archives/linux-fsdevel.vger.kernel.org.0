Return-Path: <linux-fsdevel+bounces-37424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6789F1FBA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 16:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D00188660D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57119A2B0;
	Sat, 14 Dec 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQdmOI29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117C19005F
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734190329; cv=none; b=GH6CP3kh68XVzelKPabgn2KalpFHzo8h1I5PTf559OV93SHbWp0hyLxjK4fUqUWbORWG7ibtSRCcFrfeLHLof5OWspmgckf5NaNXgYf8kXFtyWtDdWkXtC9t2xM3Tc+XMxeBzxGbWaPzJJkhuzKzldbJxufNNN2YFUgT3v54NKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734190329; c=relaxed/simple;
	bh=y6kTT7dJ0Cc65e8AFqV3nF0RvOwhxu5jTy0nO+NKfB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7HnQBO0pHyur2ULiML1MwCBwXualcQY5cqflrRGueiHACCWuMlvDvCXBzdWwc8hwUvV18IVdjxKrOphQtYuKDCPpZuulYDYM5pzVJMf4U2p7VrJnBfA+rlntlLeVtut0SaYEpgGyImoaW8fL71gwMql8ntDaND2vcz04ZkDWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQdmOI29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734190326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=03N6Z6LVTWl2BXm3uGhmS6liuy/PRc0F/lQH4ag9wfQ=;
	b=NQdmOI29k4VzgE6FvkFv9l5K23SWw4tcMoxTcElILiK4nS+1urVQItGv7u1WlMSfUv+8TK
	2o4ZIMD3Jq0sUdE9wOg3oTrdgbTQ5clC9l1dkASyLj2YLZ9rrWQE0jf8jxRlPX+kWyokZg
	Iv689c8xnbSpU4MEnuXjAwlZ2EgwTx8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-UHTP8ZrTNpqX86W0BPLrSA-1; Sat, 14 Dec 2024 10:32:05 -0500
X-MC-Unique: UHTP8ZrTNpqX86W0BPLrSA-1
X-Mimecast-MFC-AGG-ID: UHTP8ZrTNpqX86W0BPLrSA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso1546482f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734190324; x=1734795124;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=03N6Z6LVTWl2BXm3uGhmS6liuy/PRc0F/lQH4ag9wfQ=;
        b=I/+GNV0rbx3jPLAvs19i5NIkvgqcg+D2HiEhtakpKJiOZFNlwhGEZv8SHrjQY+MAqs
         ZELNtFcCyGBcNmuKWbpY+3SlL5UukJ/0wQGKpjuUbzT2GKjn6OW2N4CkYo/KV0DtZI/U
         fMnIX+MmfNemKGkYPZXRXs9OeWiZOmSW97yB9B0pBM61FzHlWyyVi/BbiZD5JO9ow2nD
         WhRAD5Z77qLsWCE3L1PEE/ci99BI9K1hxNoQq4Slcl1pXPP3ZnG9xXiNt33ny4OTPefG
         IGpE60PzavSbsVTs3Y7s7BQ/DDBweKgS3PPvXOBkCoSuudcHsglTmVXIjTWtXfnKxZuB
         Efcg==
X-Forwarded-Encrypted: i=1; AJvYcCUPcZd5rpnMNfc1h4FSeY2Emdfa2P+nsZMV3Jcn5U9+KrHsVOu0vt3qqzzYnq5Pmggwai5ohvctiHmanc03@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54UkzeZXjptp1a9nk+Cmg+TpvB20tpzdpkKkjw1inuC3C8B2s
	JMxY6iiLq3KQ/uu/Cxyjj4KLnaHaznIzZIc1LRmG23jrTWsBGMTVwBiyk7adM5O28filbMJjt7n
	RlFsvkJaY4UntGnWldjp/Im1NwQ2NtxVcHIBfmeaXcY/UJi9GpcrYJOb7je80r1Y=
X-Gm-Gg: ASbGnctxatJK+D/8jyyeRzeFz2vTChGmyoGs1h5xgp0N22M/MaUsju/kG+7wihz6BY0
	57a1tlIt1gthzsKbD3ZGbhd7hCP2qE8/SCozil5FpWSEGd+fJWfsGlFiOrNMTs6vBWV5bPa5x2n
	gr3JOEF9gOyeMaq8KWM23/DVg4ZDhHZ6Kgn5cbyC1EN5HlLJO8OwjQwEGQHZa/sh2hvNrafkZTX
	y3daxnXlySf0Tv8ZFmFb6NgXzNf4pknvrBKWpVjIGza4FTmgd5RB48s+C3JoqOgNgnOUL1VYvAY
	JUVHuNxBN8CaPX2VZnJTfd7DJeg6juN2VaBNgO27UUS5Se8Vsh9IAgw1MqYyoira2CB93l93ea7
	rVkv1ZJke
X-Received: by 2002:a5d:64a7:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-38880ac23d0mr5273143f8f.1.1734190323882;
        Sat, 14 Dec 2024 07:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCAoXGEeWaw7IcCbVrauVtoSu57S5/3Q7OA9u+ckTPTWUXqMKHzSJmCciXfEjs+C07Qo9JLg==
X-Received: by 2002:a5d:64a7:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-38880ac23d0mr5273103f8f.1.1734190323507;
        Sat, 14 Dec 2024 07:32:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:6400:d1b9:21c5:b517:5f4e? (p200300cbc7116400d1b921c5b5175f4e.dip0.t-ipconnect.de. [2003:cb:c711:6400:d1b9:21c5:b517:5f4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801211dsm2844150f8f.17.2024.12.14.07.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 07:32:03 -0800 (PST)
Message-ID: <fc83a855-bb3f-4374-8896-579420732b25@redhat.com>
Date: Sat, 14 Dec 2024 16:32:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] huge_memory: Allow mappings of PUD sized pages
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
 linux-mm@kvack.org
Cc: lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <dd86249dee026991b1a996a8ab551b1b1fdd32a4.1732239628.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dd86249dee026991b1a996a8ab551b1b1fdd32a4.1732239628.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 02:40, Alistair Popple wrote:
> Currently DAX folio/page reference counts are managed differently to
> normal pages. To allow these to be managed the same as normal pages
> introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
> and take references as it would for a normally mapped page.
> 
> This is distinct from the current mechanism, vmf_insert_pfn_pud, which
> simply inserts a special devmap PUD entry into the page table without
> holding a reference to the page for the mapping.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---

Hi,

The patch subject of this (and especially the next patch) is misleading. 
Likely you meant to have it as:

"mm/huge_memory: add vmf_insert_folio_pud() for mapping PUD sized pages"

>   	for (i = 0; i < nr_pages; i++) {
> @@ -1523,6 +1531,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>   #endif
>   }
>   
> +/**
> + * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
> + * @folio:	The folio to add the mapping to
> + * @page:	The first page to add
> + * @vma:	The vm area in which the mapping is added
> + *
> + * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
> + *
> + * The caller needs to hold the page table lock.
> + */
> +void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
> +		struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
> +#else
> +	WARN_ON_ONCE(true);
> +#endif
> +}
> +
>   static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		struct page *page, int nr_pages, struct vm_area_struct *vma,
>   		enum rmap_level level)
> @@ -1552,6 +1580,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		partially_mapped = nr && atomic_read(mapped);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		atomic_dec(&folio->_large_mapcount);
>   		last = atomic_add_negative(-1, &folio->_entire_mapcount);
>   		if (last) {

If you simply reuse that code (here and on the adding path), you will 
end up effectively setting nr_pmdmapped to a very large value and 
passing that into __folio_mod_stat().

There, we will adjust NR_SHMEM_PMDMAPPED/NR_FILE_PMDMAPPED, which is 
wrong (it's PUD mapped ;) ).

It's probably best to split out the rmap changes from the other things 
in this patch.


-- 
Cheers,

David / dhildenb


