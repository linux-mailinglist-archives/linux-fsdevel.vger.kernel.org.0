Return-Path: <linux-fsdevel+bounces-37671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E749F5980
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9184E169F0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2D1F9F6D;
	Tue, 17 Dec 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIt9gr5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701261D5AAC
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734474443; cv=none; b=oFyYuFD2ayLSCang6hMRn7AzdGX3P5EvfpVRZyLGD/ypCtaNSRTouK74hpTdGJcBryBuk8gRFpVMUM+38tYUQqj+CQiprnqD1j1kvjqMMxAsBmsbemzWgNVnNdsaCUV86G1wmsStlF33QHyQxNXRZ8GpEiMUksY+cdO4NWqZVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734474443; c=relaxed/simple;
	bh=06H2slDRygKzCmfmRsSPr7vcLYgfuymJUB01BSzf1yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHmuoIkc+vchhlnPI9af3eN4DbxFjRCIcio+RfnnreS4t41lQK1BOMdiLaqUl51aNriz5lIjaxy7IH3k2U3gbemg4oplzxbHpyBZQDLEzNfXqYO9qulzRrY65EW8huvZQ5GARM78pSaETHBpOMOdtPrTb7METTSvmZNbVc+q3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIt9gr5v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734474440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4/O76bQ9DP7a5739+a84uc4ET8V42KerklZL0T+JTZM=;
	b=AIt9gr5vCwXoB+yFGFqtQPZo4jsLV0RKFfV6eG22j3nVMSMpaIiQ+zjCPtXM8ytOe/bV9X
	wK5MysxToXluTOLQyZGUhIn3T6vc+gXuaagqk8UXyimSgcs8X7dfudWgMsg6pW+dVS7APu
	52yi+l8lVQDwu8SqGS6Z6jZJ8OsfBVU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-2nkzR9AxNfqeEqxeigj-zw-1; Tue, 17 Dec 2024 17:27:19 -0500
X-MC-Unique: 2nkzR9AxNfqeEqxeigj-zw-1
X-Mimecast-MFC-AGG-ID: 2nkzR9AxNfqeEqxeigj-zw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso3985685e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 14:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734474438; x=1735079238;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4/O76bQ9DP7a5739+a84uc4ET8V42KerklZL0T+JTZM=;
        b=ak+uMaKGmQoZjsbyDaW3/brZHwlca+vF/US/q8L/8w7LYMw13pftbXmD3nCWIDdpmW
         Dg4309gWJqAtZIfjJpN5aSw272wEtnszHqO6n00hupncAAA+tQnN3K1zz7y/IZpbMf0Y
         5/4bEc5sDsIiWQQvK+ZGUVf2xAYHN1BJLKyrWu8nZx9e+Z8Zf3Dkx6Xd52fFHoRMwHIs
         My0XQKz8sb7dGJPP2dkXrpoWEneA4pX6bTOSZ9UQkxMJoxuo1oAxNZ5f+kzC0A8Klr1D
         ejmaOkFhwKhL468KTVRohN7wV7q7rAcxcIsLjhmbd1D3LKD6wL2cS6nxf9BsKdYCjm2y
         zcfw==
X-Forwarded-Encrypted: i=1; AJvYcCWEKpSNso5NeLQDmT1yl10OdqWnRJ8bFsZE7JIb8ArrvKwB3CpRfCdQ3yolbAcn4drEj5R9xZcrziWNZsb9@vger.kernel.org
X-Gm-Message-State: AOJu0YxVn2NXQE3VpLk4prShR+qVGocjlp0OYJ/4vUkdohk84P5g1Q93
	ncWa83ptIplZNYUeb5Jhs7JKrU7eW7jjRMR/aoJWx6u3CrIhfoy5usbzBSRBWU+ODDzZnLeaQNQ
	5CVSbUowsfu0EAiid6ZBxtcL/2aYKaXfcVkU0bd8yI7kd7SG4IbN7XJxRaLia1PE=
X-Gm-Gg: ASbGnctJGFAxH9QPzADfQPN0mD5FLTf0kOJDhvw6AWevVJcwJ60HHkjHmwUAOtBObFI
	Zub2JBtJ/RBZlk/BvhTuGsPc7nNnfWPNXbmNECbHkc4iv/bzU9l042KVh4d7Xa4eNbls8k0vIlR
	r1aIzb64ajMGBmLBKQx7iLsuoikVOu8t9Q904hJncUOP24SxBMxAwf41W6VHCjFOpSbJkwzA4Ad
	PexocOAWXQR/Rdwo47juNfkTaaVkbUkHpTaJykw6xNhA7lbAv8WE4gCf7MndELGBqF4Cd/b2H1S
	suMcgqRuWeOyXwv52xPnuqqkYMCqJ4Yv4JBTtevg1Z6VCjwE1ijr5WopJAJsIdjJmdBV+5UsvR1
	AI7eCw0wY
X-Received: by 2002:a05:6000:1867:b0:385:fd07:85f4 with SMTP id ffacd0b85a97d-388e4d64711mr382494f8f.31.1734474437978;
        Tue, 17 Dec 2024 14:27:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXkMWceKB4Pft4A5vtCS2fSCh+immbhibtyL2+AscRjp+IT+w8chlwsiKadTxAFDThwCk24Q==
X-Received: by 2002:a05:6000:1867:b0:385:fd07:85f4 with SMTP id ffacd0b85a97d-388e4d64711mr382442f8f.31.1734474437093;
        Tue, 17 Dec 2024 14:27:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:5600:c716:d8e0:609d:ae92? (p200300cbc73b5600c716d8e0609dae92.dip0.t-ipconnect.de. [2003:cb:c73b:5600:c716:d8e0:609d:ae92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060905sm12357212f8f.99.2024.12.17.14.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:27:15 -0800 (PST)
Message-ID: <4b5768b7-96e0-4864-9dbe-88fd1f0e87b8@redhat.com>
Date: Tue, 17 Dec 2024 23:27:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/25] rmap: Add support for PUD sized mappings to rmap
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
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
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
 <7f739c9e9f0a25cafb76a482e31e632c8f72102e.1734407924.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7f739c9e9f0a25cafb76a482e31e632c8f72102e.1734407924.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.12.24 06:12, Alistair Popple wrote:
> The rmap doesn't currently support adding a PUD mapping of a
> folio. This patch adds support for entire PUD mappings of folios,
> primarily to allow for more standard refcounting of device DAX
> folios. Currently DAX is the only user of this and it doesn't require
> support for partially mapped PUD-sized folios so we don't support for
> that for now.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> David - Thanks for your previous comments, I'm less familiar with the
> rmap code so I would appreciate you taking another look. In particular
> I haven't added a stat for PUD mapped folios as it seemed like
> overkill for just the device DAX case but let me know if you think
> otherwise.
> 
> Changes for v4:
> 
>   - New for v4, split out rmap changes as suggested by David.
> ---
>   include/linux/rmap.h | 15 ++++++++++++-
>   mm/rmap.c            | 56 +++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 71 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 683a040..7043914 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
>   enum rmap_level {
>   	RMAP_LEVEL_PTE = 0,
>   	RMAP_LEVEL_PMD,
> +	RMAP_LEVEL_PUD,
>   };
>   
>   static inline void __folio_rmap_sanity_checks(const struct folio *folio,
> @@ -228,6 +229,14 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
>   		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
>   		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
>   		break;
> +	case RMAP_LEVEL_PUD:
> +		/*
> +		 * Assume that we are creating * a single "entire" mapping of the
> +		 * folio.
> +		 */
> +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
> +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
> +		break;
>   	default:
>   		VM_WARN_ON_ONCE(true);
>   	}
> @@ -251,12 +260,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
>   	folio_add_file_rmap_ptes(folio, page, 1, vma)
>   void folio_add_file_rmap_pmd(struct folio *, struct page *,
>   		struct vm_area_struct *);
> +void folio_add_file_rmap_pud(struct folio *, struct page *,
> +		struct vm_area_struct *);
>   void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>   		struct vm_area_struct *);
>   #define folio_remove_rmap_pte(folio, page, vma) \
>   	folio_remove_rmap_ptes(folio, page, 1, vma)
>   void folio_remove_rmap_pmd(struct folio *, struct page *,
>   		struct vm_area_struct *);
> +void folio_remove_rmap_pud(struct folio *, struct page *,
> +		struct vm_area_struct *);
>   
>   void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>   		unsigned long address, rmap_t flags);
> @@ -341,6 +354,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		atomic_inc(&folio->_entire_mapcount);
>   		atomic_inc(&folio->_large_mapcount);
>   		break;
> @@ -437,6 +451,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>   		break;
>   	case RMAP_LEVEL_PMD:
> +	case RMAP_LEVEL_PUD:
>   		if (PageAnonExclusive(page)) {
>   			if (unlikely(maybe_pinned))
>   				return -EBUSY;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c6c4d4e..39d0439 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1203,6 +1203,11 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>   		}
>   		atomic_inc(&folio->_large_mapcount);
>   		break;
> +	case RMAP_LEVEL_PUD:
> +		/* We only support entire mappings of PUD sized folios in rmap */
> +		atomic_inc(&folio->_entire_mapcount);
> +		atomic_inc(&folio->_large_mapcount);
> +		break;


This way you don't account the pages at all as mapped, whereby PTE-mapping it
would? And IIRC, these PUD-sized pages can be either mapped using PTEs or
using a single PUD.

I suspect what you want is to

diff --git a/mm/rmap.c b/mm/rmap.c
index c6c4d4ea29a7e..1477028d3a176 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1187,12 +1187,19 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
                 atomic_add(orig_nr_pages, &folio->_large_mapcount);
                 break;
         case RMAP_LEVEL_PMD:
+       case RMAP_LEVEL_PUD:
                 first = atomic_inc_and_test(&folio->_entire_mapcount);
                 if (first) {
                         nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
                         if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-                               *nr_pmdmapped = folio_nr_pages(folio);
-                               nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
+                               nr_pages = folio_nr_pages(folio);
+                               /*
+                                * We only track PMD mappings of PMD-sized
+                                * folios separately.
+                                */
+                               if (level == RMAP_LEVEL_PMD)
+                                       *nr_pmdmapped = nr_pages;
+                               nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
                                 /* Raced ahead of a remove and another add? */
                                 if (unlikely(nr < 0))
                                         nr = 0;

Similar on the removal path.


-- 
Cheers,

David / dhildenb


