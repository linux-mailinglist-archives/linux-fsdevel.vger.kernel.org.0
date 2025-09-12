Return-Path: <linux-fsdevel+bounces-61012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79809B5460B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993497A8748
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7F263F28;
	Fri, 12 Sep 2025 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMx3Nc6b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBB267B7F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667268; cv=none; b=U/dsn/XrmrMa2stllCVYiDVzHjKlKcdeZZtXIz+QyDpvsK879BJd0vVMN0ZmfSK9ahArOOWmH72M77M/jvuQGryIRtCHDHNEuuwXpjb8gsTHqu8Q0DCVvwmwhULJAhiMqrtTu5IWYHK/vxKXtMK6rVSmDcUQi3CGe6L/eFfbYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667268; c=relaxed/simple;
	bh=8PbhAdsnDNE8wVEk5dE0k09LJKtm/1XBtQQa41DMYFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR7XF2mSSLBanG/liankr9M92n7qAGdh2/jhSrk6RxjlEmxWHYq63wMFWocilrzE6/dlj0idBQuAfwwLHWu5nP6AIutDVlbD7tQWWavJIhKweeAfOqgQnpQ2suQbrnAIAvzbBXZVAjP9IsNKH+7YzNc5NkD2A20bqOPvaumnOc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMx3Nc6b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a24yalJ9UBENITTj+pl79Bqmf3DrH7vWpN1mkZyCn+k=;
	b=fMx3Nc6bMxZU7CYGva8QjtAx4/MaCgfkjaRAigRKN9fzSs9W2ETqPDwHjaCt8NmdVW4WYn
	4IS4zF+qqRzC0Yu22hfBr6Gf4x/vpqBPgd7Rb/AOPrKNHWHv6eGH6EtIhWVWNlJKvI1fqL
	3ShpKvlu3YAwzL7DitfE7IXErSlaszM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-qxG2ESAkMwKUnE78qOuDow-1; Fri, 12 Sep 2025 04:54:23 -0400
X-MC-Unique: qxG2ESAkMwKUnE78qOuDow-1
X-Mimecast-MFC-AGG-ID: qxG2ESAkMwKUnE78qOuDow_1757667262
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45ddbdb92dfso9773835e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 01:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667262; x=1758272062;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a24yalJ9UBENITTj+pl79Bqmf3DrH7vWpN1mkZyCn+k=;
        b=dgb9cz5Pg+kpLC3YUypNylpe8dRHLzn04nf5huQdnpF65ErpQJDiFyWYSSkTN2kN0T
         eJfOGILPdoxsfy6KtyoaPUbNTkdirDWSb3vAckG5UukXbJ1VaR2ejdhPUnzVZrVaCfHl
         P0kX8bwOX5VRMbs5y/4ASvDit/TU9uuN4RGLGHoZebngTIhJ5pW3J8TK0sOBLc3sjUK6
         EpPWp68B10UAKNn9Rrne9Rx/KiVs1v2bTTgGKILobpibfrW34NW615HUCcc/wFFHWNBr
         TBUywBWlKddM2oTDDZNCGNe4RzHtKZnp5TOIhgwlMxxOQ4NH3uK2zwB2ujQ3qoRK0Jky
         LXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyI3wuufuSUJbEq8glZK1W2kfcg/B5zyBXZ9OVzFc7uoJ3Fl02fxbB/Wbb8M04SFWtC4Qq0ADkIhCioXoc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpwr3TKetMZLg/VtknVha7cTtOorJrWoXOCr/4GPwj4hU50hIR
	O6x1pbRA92JI6Xlv9usunu4E9jZIuut7KWNIPtkUk1GTa2/2e2NIsXHYLMSpl53ePlIZNlD27fv
	iy9bVL+9Sdqa9mWEKrLkBWxChCA+1lPKxWm+RttfRvpt4OViBaWwjvlTV+UOypyCW9L8=
X-Gm-Gg: ASbGncuoloGYtgiQeO0mAoI8sXZMz2Sj3eZ73LmqgAMXqp3u1DGBVKHpySP+4yRuos4
	tewBw1dwLfb5FSZ915vE9xABk3Yd0C1tReXmanq6+aHXVOGALk/nMQtyhildJRLGXoCkeheFJPm
	bJYjKKF9llDo7ttGTQR3RIxmDo7bTbTOCxx+zuP6qT2jyz7Sgw+Z3oVBB1rfrfwUSJLNps0E1w2
	ucnRGSbbO1YWc7AZYOsnQ3djl4Rzjej4CUTwF+RpuIQij90sKplc1IyqodVBTfPexLFprSeAcQ+
	/LTgOzjXTIOXKq4IYeDqqM+mh4S8il6JVPUJjRfP1bs6qAF6dCMf4YywtmqxwV57pBYAgXA3Bap
	i3fSFDWADvXSYRAPS6uKtw0KTJpWHgeeWhXpmHmJGGHKOEQwQZKH4GBFu/+ZNhfQ1fUI=
X-Received: by 2002:a05:600c:294c:b0:45d:d5df:ab39 with SMTP id 5b1f17b1804b1-45f211fec30mr15922415e9.26.1757667261779;
        Fri, 12 Sep 2025 01:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzxHEWOj7/CJM7yM+dKgUjsT4XMxGQOVxPLPXDQMosBvdpTxq/L3oW66UT/5ZgoJvXp3UhZA==
X-Received: by 2002:a05:600c:294c:b0:45d:d5df:ab39 with SMTP id 5b1f17b1804b1-45f211fec30mr15922155e9.26.1757667261329;
        Fri, 12 Sep 2025 01:54:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7bb1sm5739157f8f.50.2025.09.12.01.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:54:20 -0700 (PDT)
Message-ID: <009f31e4-aba8-4ab4-b6f3-09244ca03e1c@redhat.com>
Date: Fri, 12 Sep 2025 10:54:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/5] mm: userfaultfd: Add pgtable_uffd_wp_supported()
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
 <20250911095602.1130290-3-zhangchunyan@iscas.ac.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250911095602.1130290-3-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.09.25 11:55, Chunyan Zhang wrote:
> Some platforms can customize the PTE/PMD entry uffd-wp bit making
> it unavailable even if the architecture provides the resource.
> This patch adds a macro API that allows architectures to define their
> specific implementations to check if the uffd-wp bit is available
> on which device the kernel is running.

If you change the name of the sofdirty thingy, adjust that one here as well.

> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   fs/userfaultfd.c                   | 23 ++++++++--------
>   include/asm-generic/pgtable_uffd.h | 11 ++++++++
>   include/linux/mm_inline.h          |  7 +++++
>   include/linux/userfaultfd_k.h      | 44 +++++++++++++++++++-----------
>   mm/memory.c                        |  6 ++--
>   5 files changed, 62 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 54c6cc7fe9c6..b549c327d7ad 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1270,9 +1270,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>   	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
>   		vm_flags |= VM_UFFD_MISSING;
>   	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
> -#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> -		goto out;
> -#endif
> +		if (!pgtable_uffd_wp_supported())
> +			goto out;
> +
>   		vm_flags |= VM_UFFD_WP;

I like that, similar to the softdirty thing we will simply not set the flag.

>   	}
>   	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
> @@ -1980,14 +1980,15 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
>   	uffdio_api.features &=
>   		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
>   #endif
> -#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> -	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> -#endif
> -#ifndef CONFIG_PTE_MARKER_UFFD_WP
> -	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
> -	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
> -	uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> -#endif
> +	if (!pgtable_uffd_wp_supported())
> +		uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> +
> +	if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) ||
> +	    !pgtable_uffd_wp_supported()) {

I wonder if we would want to have a helper for that like

static inline bool uffd_supports_wp_marker(void)
{
	return pgtable_uffd_wp_supported() && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP);
}

That should clean all of this futher up.

> +		uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
> +		uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
> +		uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> +	}
>   
>   	ret = -EINVAL;
>   	if (features & ~uffdio_api.features)
> diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
> index 828966d4c281..895d68ece0e7 100644
> --- a/include/asm-generic/pgtable_uffd.h
> +++ b/include/asm-generic/pgtable_uffd.h
> @@ -1,6 +1,17 @@
>   #ifndef _ASM_GENERIC_PGTABLE_UFFD_H
>   #define _ASM_GENERIC_PGTABLE_UFFD_H
>   
> +/*
> + * Some platforms can customize the uffd-wp bit, making it unavailable
> + * even if the architecture provides the resource.
> + * Adding this API allows architectures to add their own checks for the
> + * devices on which the kernel is running.
> + * Note: When overiding it, please make sure the

s/overiding/overriding/

> + * CONFIG_HAVE_ARCH_USERFAULTFD_WP is part of this macro.
> + */
> +#ifndef pgtable_uffd_wp_supported
> +#define pgtable_uffd_wp_supported()	IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP)
> +#endif
>   #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   static __always_inline int pte_uffd_wp(pte_t pte)
>   {
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 89b518ff097e..38845b8b79ff 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -571,6 +571,13 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
>   			      pte_t *pte, pte_t pteval)
>   {
>   #ifdef CONFIG_PTE_MARKER_UFFD_WP
> +	/*
> +	 * Some platforms can customize the PTE uffd-wp bit, making it unavailable
> +	 * even if the architecture allows providing the PTE resource.
> +	 */
> +	if (!pgtable_uffd_wp_supported())
> +		return false;
> +

Likely we could use the uffd_supports_wp_marker() wrapper here isntead and
remove the #ifdef.

>   	bool arm_uffd_pte = false;
>   
>   	/* The current status of the pte should be "cleared" before calling */
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c0e716aec26a..6264b56ae961 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -228,15 +228,15 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>   	if (wp_async && (vm_flags == VM_UFFD_WP))
>   		return true;
>   
> -#ifndef CONFIG_PTE_MARKER_UFFD_WP
>   	/*
>   	 * If user requested uffd-wp but not enabled pte markers for
>   	 * uffd-wp, then shmem & hugetlbfs are not supported but only
>   	 * anonymous.
>   	 */
> -	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
> +	if ((!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) ||
> +	     !pgtable_uffd_wp_supported()) &&

This would also use the helper.

> +	    (vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
>   		return false;
> -#endif
>   
>   	/* By default, allow any of anon|shmem|hugetlb */
>   	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
> @@ -437,8 +437,11 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
>   static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
>   {
>   #ifdef CONFIG_PTE_MARKER_UFFD_WP
> -	return is_pte_marker_entry(entry) &&
> -	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
> +	if (pgtable_uffd_wp_supported())
> +		return is_pte_marker_entry(entry) &&
> +			(pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
> +	else
> +		return false;

if (!uffd_supports_wp_marker())
	return false;
return is_pte_marker_entry(entry) &&
	(pte_marker_get(entry) & PTE_MARKER_UFFD_WP);

>   #else
>   	return false;
>   #endif
> @@ -447,14 +450,19 @@ static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
>   static inline bool pte_marker_uffd_wp(pte_t pte)
>   {
>   #ifdef CONFIG_PTE_MARKER_UFFD_WP


Simialrly here, just do a

if (!uffd_supports_wp_marker())
	return false;

and remove the ifdef

>   #endif
> @@ -467,14 +475,18 @@ static inline bool pte_marker_uffd_wp(pte_t pte)
>   static inline bool pte_swp_uffd_wp_any(pte_t pte)
>   {
>   #ifdef CONFIG_PTE_MARKER_UFFD_WP

Same here.

> -	if (!is_swap_pte(pte))
> -		return false;
> +	if (pgtable_uffd_wp_supported()) {
> +		if (!is_swap_pte(pte))
> +			return false;
>   
> -	if (pte_swp_uffd_wp(pte))
> -		return true;
> +		if (pte_swp_uffd_wp(pte))
> +			return true;
>   
> -	if (pte_marker_uffd_wp(pte))
> -		return true;
> +		if (pte_marker_uffd_wp(pte))
> +			return true;
> +	} else {
> +		return false;
> +	}
>   #endif
>   	return false;
>   }
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..4eb05c5f487b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1465,7 +1465,9 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>   {
>   	bool was_installed = false;
>   
> -#ifdef CONFIG_PTE_MARKER_UFFD_WP
> +	if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) || !pgtable_uffd_wp_supported())
> +		return false;
> +


Same here.


-- 
Cheers

David / dhildenb


