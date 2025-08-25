Return-Path: <linux-fsdevel+bounces-59025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B3B33F70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0843A6486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83EE38FB9;
	Mon, 25 Aug 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnynJcsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0240855
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125071; cv=none; b=eCLJ3WzcEJKl47ACMZxQaM3bLBpjANkBTIJwTzswO3KXYpZMSKZtDGpUivxfEh6dNdw1Lf7QNrveKUdm+MB+pn0iTFiAGoZt5XQDtQ5ripc2OBtpnHGocUs+apYdXJjaqhWi8LfnwNXHrW1j6oW8mJw6JT6UvgEeXJ6CTDSyaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125071; c=relaxed/simple;
	bh=OIyv02Fm+olT4ZMNRn432Jb7K+SH0i2UMj4mqEL0RdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaJZyJYWZUa4rBMPRWMgg85HdGmodjNd+cZpVKUyZj96z4xpyhxDFIPW7JQVmBITO4uUfgM60ZJqvUCRxu6ceSojlEw6UlUZZDts5rr1gRDEJvARSZn63LXRa4gQx5iTG08Crk/Q8SXWcN669jggkWz5Xd7mO1N3eN+kv76Wjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnynJcsI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756125066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=48cMTSslcB0ziBS4SAU+081Ps38xL0HjCpNxL+9nzl0=;
	b=bnynJcsIIlGvpV5g4BJqvnLuZVKNuU6i/DGv4o0HpTle+UI+1UnzSJtz2bSVzgTEEdmrgV
	ekEK7ZxGtvGDgTg+dPBUjkdJ5TYMPPq/lcIwmQkjq2d78QHLNCtEGcRFwdUcT9Pu116vE9
	JoNW2j3oEciIbqszydEYJYlSebIG/cA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-WotNOWM6MjujJ6pkFlJ5JA-1; Mon, 25 Aug 2025 08:31:05 -0400
X-MC-Unique: WotNOWM6MjujJ6pkFlJ5JA-1
X-Mimecast-MFC-AGG-ID: WotNOWM6MjujJ6pkFlJ5JA_1756125064
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c75de76caaso857717f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125064; x=1756729864;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48cMTSslcB0ziBS4SAU+081Ps38xL0HjCpNxL+9nzl0=;
        b=Dx92SlevQxffITbo3hTOHWQNT8INvi5mANw6O7NTLfdrxSSlP4EBep1iNAuO8cFzAW
         IspYTkG/kGJ6XdgwnBi8pJbZR7tSoOqgrky3KHiOCVP9u1AgtFNLOLLPuL0Wdo6U7a8S
         YyobcgQg0qKue7QSGhgjuUKnbFRjzDrpfBo4kj3eBMSqNE1vbe8HrOOYnoUAu+L/X5SN
         tFF85e7l2F9RwLjtlTv1RmOaFM6bAF7JR5xm8wBjulxlJLZ3YPVREQwhhsdLES+q9l50
         UHtTvyQS2ddGMaeTKREA7u72VFX2ZP9wJeJChG3bxxu6OWBZpB6KVGR9nxAJwDKiA5vq
         xIyw==
X-Forwarded-Encrypted: i=1; AJvYcCUTyZ+QUzXzyKuHqNVdhgtguJeU7FioyXMSDn5Yi20FwXxCJrcRV04ILCe6c0O6BSUpXTxgxUYsTdKtRXer@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDnki0vELmZPPzom226dSE/UMrdAyo9t0VTG2DrF+UpH1OM6P
	ow8ymV+HhzJSB30TLu6HdZ0p4fJ2PH58/i6Z4D0yt4o+jyavDuZStMTJQ3JW0EJmqIUlOOdNFBR
	CNETSzL4EPpc7cOpBJDCXrFiiJifcFIUv9xb+6UQFmE76tViKfBFiZ41Z6f2r1LmmRQ8=
X-Gm-Gg: ASbGnctYlzPLjcwytmwicGEOqRnIVcW9YEzmLMNOMXvx7oeGsRF++z9wXyO9DLV6/AQ
	fW+74LdZcZFYjEkYxAXzQ+lXyyIid8yxSvCj3Hom+NOVUCcLmowqRpCQtP6x9T79S8UMTO6YuzS
	uDqmr0MCdNrPbqA1cWhdgats23mz73k/4lRQHa91KDA2Dn6F6WYavxh6mnSuvkauYVZh75l9dHP
	yuVA59+tdWGTPZtkYEUT2fXYBhXseDztKcReVEhTLAdJQDR5/YmT3E/lBA4qbG9sy6NaGoHzXJA
	ExnBugY4pH5A97EXGgLgTCFFwcmmxkiGMp2F0Ju9YGC3KKXgFPCO9mCuFuZuqFdRVxHEiglzXwd
	zxvi+3+Yyd5FSYhoxQudNMbJ5LBJhpTgFKvseUhmYAwxjMTifCap8S7sy+hl1dJITcXI=
X-Received: by 2002:a05:6000:40dc:b0:3c9:469d:c087 with SMTP id ffacd0b85a97d-3c9469dc445mr3271495f8f.25.1756125063886;
        Mon, 25 Aug 2025 05:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvPKmvGXwFDJWJm849Yt5wXoDEn2seO+ZEF1/8AbV43w5FimZ47X7SqR0IFDLk15EedM+8Mg==
X-Received: by 2002:a05:6000:40dc:b0:3c9:469d:c087 with SMTP id ffacd0b85a97d-3c9469dc445mr3271446f8f.25.1756125063406;
        Mon, 25 Aug 2025 05:31:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b575929a0sm106632785e9.25.2025.08.25.05.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:31:02 -0700 (PDT)
Message-ID: <923b279c-de33-44dd-a923-2959afad8626@redhat.com>
Date: Mon, 25 Aug 2025 14:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
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
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-9-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250811112631.759341-9-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 13:26, David Hildenbrand wrote:
> print_bad_pte() looks like something that should actually be a WARN
> or similar, but historically it apparently has proven to be useful to
> detect corruption of page tables even on production systems -- report
> the issue and keep the system running to make it easier to actually detect
> what is going wrong (e.g., multiple such messages might shed a light).
> 
> As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
> to take care of print_bad_pte() as well.
> 
> Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
> implementation and renaming the function to print_bad_page_map().
> Provide print_bad_pte() as a simple wrapper.
> 
> Document the implicit locking requirements for the page table re-walk.
> 
> To make the function a bit more readable, factor out the ratelimit check
> into is_bad_page_map_ratelimited() and place the printing of page
> table content into __print_bad_page_map_pgtable(). We'll now dump
> information from each level in a single line, and just stop the table
> walk once we hit something that is not a present page table.
> 
> The report will now look something like (dumping pgd to pmd values):
> 
> [   77.943408] BUG: Bad page map in process XXX  pte:80000001233f5867
> [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
> [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
> 
> Not using pgdp_get(), because that does not work properly on some arm
> configs where pgd_t is an array. Note that we are dumping all levels
> even when levels are folded for simplicity.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/pgtable.h |  19 ++++++++
>   mm/memory.c             | 104 ++++++++++++++++++++++++++++++++--------
>   2 files changed, 103 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index bff5c4241bf2e..33c84b38b7ec6 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1966,6 +1966,25 @@ enum pgtable_level {
>   	PGTABLE_LEVEL_PGD,
>   };
>   
> +static inline const char *pgtable_level_to_str(enum pgtable_level level)
> +{
> +	switch (level) {
> +	case PGTABLE_LEVEL_PTE:
> +		return "pte";
> +	case PGTABLE_LEVEL_PMD:
> +		return "pmd";
> +	case PGTABLE_LEVEL_PUD:
> +		return "pud";
> +	case PGTABLE_LEVEL_P4D:
> +		return "p4d";
> +	case PGTABLE_LEVEL_PGD:
> +		return "pgd";
> +	default:
> +		VM_WARN_ON_ONCE(1);
> +		return "unknown";
> +	}
> +}

One kernel config doesn't like the VM_WARN_ON_ONCE here, and I don't think we
really need it. @Andrew can you squash:

 From 0b8f6cdfe2c9d96393e7da1772e82048e096a903 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Aug 2025 14:25:59 +0200
Subject: [PATCH] fixup: mm/memory: convert print_bad_pte() to
  print_bad_page_map()

Let's just drop the warning, it's highly unlikely that we ever run into
this, and if so, there is serious stuff going wrong elsewhere.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/pgtable.h | 1 -
  1 file changed, 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9f0329d45b1e1..94249e671a7e8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1997,7 +1997,6 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
  	case PGTABLE_LEVEL_PGD:
  		return "pgd";
  	default:
-		VM_WARN_ON_ONCE(1);
  		return "unknown";
  	}
  }
-- 
2.50.1


-- 
Cheers

David / dhildenb


