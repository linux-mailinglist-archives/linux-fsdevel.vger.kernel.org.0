Return-Path: <linux-fsdevel+bounces-61414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80390B57E40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808B93A813C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35231B81D;
	Mon, 15 Sep 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLkCQhhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433331A05B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944582; cv=none; b=lqKfws39ZpNP5ScWnPA57vffGrRRSKL8ZaeSAxN6+9TH46oiyc7DkUYZTapHdE1i2pfzO1olYrjbbj9BHmZPWsPFr3KY76rDEW5oagi/QcN5X39LC8Opzh8JC46IDybhAoKgYXEGMW1dKI5pRpi/orKXTo/glEfFqGyqtljCMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944582; c=relaxed/simple;
	bh=m4vxR7Y03yH/06RsrUBBQhQGn4XLtdFMxMh/FvA39wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHnNb9iNuvpLMsJ5O5NfNI68UJwwmfPczQIBbmOW8QXM5ub1WSKKkw3ozJxW8WXj1rU3RTFL1K0xtxn0Gv3rBA/m8sxcg3hP891BY/jlJqmWqkZcS2uL0c0+l/xQ/9uFHSsgpc2vGeOpBuvBcAyB64SwZ8ZKXz28iP9LdOg9hTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLkCQhhk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757944579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xhOG/fvp4vP62Eb6XPp5XNsran7BwQlb2XSK8gOzU1U=;
	b=aLkCQhhkguhckibGzIugPnFpq6lZfpU4M0OCITj402qRmZSvUUI+mKvULGh6kf2Nk/r4i1
	RU1ZZFPPbtyueE/+gfJokJIhC7LLwlgmq/kkDIzLjIkWH0GCQa93iJvXggvdKT0BiDGPIc
	A4SRTiE5M4tCLJS0w1ZdlirOYLC6LcE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-2OS2UHEQOvqV-Wj3ASSozQ-1; Mon, 15 Sep 2025 09:56:17 -0400
X-MC-Unique: 2OS2UHEQOvqV-Wj3ASSozQ-1
X-Mimecast-MFC-AGG-ID: 2OS2UHEQOvqV-Wj3ASSozQ_1757944576
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f28552927so1762605e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 06:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757944576; x=1758549376;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhOG/fvp4vP62Eb6XPp5XNsran7BwQlb2XSK8gOzU1U=;
        b=oxuA5KEsWShh3s0bviq/V6QhKDykru4q1WHI3cvlLTEN0OswViXs9nkU0Hvz8APDJD
         EsNSkQmScKOxOqTQ3//QyLjARSEhXfXDyBRUTSXGjoU4F94I/e8hngwr0P3x5qF3CAEJ
         F/gVjX/5MU5M8/owLehnzQ2nCk2LY7MVNor7y7DC/4GTlgnML8YXD9TnzNcDVpDLaUjA
         AcJ54m8IuhYOMcSHATw8/zQUI77lqjfsH/7w8SX/AnJohk2sJchwM9xw0v/sRxP1wJLc
         einoIDy04LdpWIIWldFPuJX0gVPKeT0W4GnQ/HBqEghGrdd2rY7vM4PZ9F4l0ANkFklN
         +jfA==
X-Forwarded-Encrypted: i=1; AJvYcCUNdDUXiBjK6VgUwL52k1IRsmuRBT94LhUMUBy4FT/VseaKv1dmBx5p3H0yixGcLofiNbf4R7BXf4YD7kbL@vger.kernel.org
X-Gm-Message-State: AOJu0YzQrzVMbarJZdhMce0bvPLtnL7+Rav8B9/vxSm1+8fSaRiaE8Lc
	cp7Z8Z6bL9I4JYItX8SQHTgbH25uLh3G295Uyw9j/N1e+RqV0DEPEEKmBLLFhnVXo3S0O7FFAp2
	yUPqm/wXTfwRBrPYOKdItskZ93wZOFGP+7LW1rnMmSVoJjnc9ySafRqQ4GmfaEuWbzOz2VKgj8G
	w=
X-Gm-Gg: ASbGncvrTcnfudJAIl5baviNWWJ9MOY41/kNm1pzYy/vctKcPsU2V5Y+f9ZDCkMF8U1
	EK6IiahBS8m9QshYy+51GoH4sN2PlZ5WQW8kyaAURzRexkSW9I9I96A4BOe0HE0UtE1m7V93CAt
	VzUfgM9EKr+d8WYJZlFyxh/4Fg8bcbWAtSe0dKZlotM12dmp2aHOa5g1nyDfDT9/RToi9gTEwuO
	Zi5Ayq9r7nYJeElaORSEAOJPEIKXc/T8fYd9xPF+18dPuvlHOHI9GCxp83OA/MK9aPsX4yQu/yo
	sgl6rG2CTDuBX7rdRIYUQTcBQxFOu7DOIoJU56E9WQ4IpMWR57R/+2CjZn+qj39LF7K6KVD6L3K
	uaXcD5bubQzWDgnrVZO2e6nYBo+d92UgyYhTLY3QxBLQ00EWcd8tK8yMWKGUJJlVpxi0=
X-Received: by 2002:a05:600c:6288:b0:45b:8adf:cf2b with SMTP id 5b1f17b1804b1-45f211f881dmr115966265e9.21.1757944576050;
        Mon, 15 Sep 2025 06:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtjLb9Ul6kS9hK8OGR9Dc+mdLSV5OClg6Pwy+q+DWumlQ5T+nt0OyxALBeSTSBr2gbzsMVcA==
X-Received: by 2002:a05:600c:6288:b0:45b:8adf:cf2b with SMTP id 5b1f17b1804b1-45f211f881dmr115965935e9.21.1757944575556;
        Mon, 15 Sep 2025 06:56:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e032a0522sm178750375e9.0.2025.09.15.06.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:56:15 -0700 (PDT)
Message-ID: <37c8dd09-e0b1-4f76-a03b-4548c1fe4796@redhat.com>
Date: Mon, 15 Sep 2025 15:56:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 2/5] mm: userfaultfd: Add pgtable_supports_uffd_wp()
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
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-3-zhangchunyan@iscas.ac.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915101343.1449546-3-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:13, Chunyan Zhang wrote:
> Some platforms can customize the PTE/PMD entry uffd-wp bit making
> it unavailable even if the architecture provides the resource.
> This patch adds a macro API that allows architectures to define their
> specific implementations to check if the uffd-wp bit is available
> on which device the kernel is running.
> 

Similar to my reply to #1, you should probably summarize what you do 
regarding ifdef and "No functional change expected".

> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---

[...]

LGTM, one not below, thanks!

Acked-by: David Hildenbrand <david@redhat.com>

> +/*
> + * Some platforms can customize the uffd-wp bit, making it unavailable
> + * even if the architecture provides the resource.
> + * Adding this API allows architectures to add their own checks for the
> + * devices on which the kernel is running.
> + * Note: When overriding it, please make sure the
> + * CONFIG_HAVE_ARCH_USERFAULTFD_WP is part of this macro.
> + */
> +#ifndef pgtable_supports_uffd_wp
> +#define pgtable_supports_uffd_wp()	IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP)
> +#endif
> +
> +static __always_inline bool uffd_supports_wp_marker(void)
> +{
> +	return pgtable_supports_uffd_wp() && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP);
> +}

Likely a simple "inline" should do the trick?

> +
>   #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   static __always_inline int pte_uffd_wp(pte_t pte)
>   {
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 89b518ff097e..d6526a7f034b 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -570,9 +570,15 @@ static inline bool
>   pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
>   			      pte_t *pte, pte_t pteval)
>   {


-- 
Cheers

David / dhildenb


