Return-Path: <linux-fsdevel+bounces-50307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EDFACAB76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649F27AA0CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23CB1E1DEB;
	Mon,  2 Jun 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqZN5gCf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEF1DED5E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856796; cv=none; b=e9SsTWD/2vLKfPjnvQLIFQBKrzBbuKTyeoSUxYFhlUdBKOwyfk768EeTW6UOA6FK51Y59V2F3YDP0xZz+QYMRs7SPJ4N/7QSjXOhNAYJeWgtvPp2g1OVRPDMrXfUYFvoX6SjKU0+xp8UQlryJwvB66/NdJY1XW34/+UkiOkvW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856796; c=relaxed/simple;
	bh=kr8ir0FlQZkNNUQWtY9nCCtXCkYhvIjW8kc5hvNIuKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPZbqYxswduoi1+9yJnB9wRsAk9k7n8uZlZDa8lgXpTQ4Ga/9MYRKZA/JUeGp3T2MCH7gfNvgTRa0B3CZ78s/b65Ocf0AF225CYHiPmDMdnYYTuFNpYE6ixFqg8sr+2ndLMxjlXzGm677jyzDzyvmyi0YCE2okriHlL38pTZNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqZN5gCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748856793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AGFrAeg+YrLg6JnrL0SvX9pGyMf+6/YBqcb6y1L9Yas=;
	b=QqZN5gCfUJO+auOj5igrAZqqjFAdrHwOU3EBmfNI6mJxB5f7/u5kq/AyMBO8L3dH2zmEW0
	x6zgexSRWa/Aqp7+8Vls9pZ8L6V9cgqWwv/cGBThOEr7fo8/00h+AT54ZY+txi3G5FafZM
	Wmy9gPboPUCIqAduvDlNWYgzAqheA0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-P5rE7O6eNTOSe5_3KdQA4Q-1; Mon, 02 Jun 2025 05:33:11 -0400
X-MC-Unique: P5rE7O6eNTOSe5_3KdQA4Q-1
X-Mimecast-MFC-AGG-ID: P5rE7O6eNTOSe5_3KdQA4Q_1748856791
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so8236445e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 02:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748856791; x=1749461591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AGFrAeg+YrLg6JnrL0SvX9pGyMf+6/YBqcb6y1L9Yas=;
        b=gYtnaiGJ6haZ+VCJ/duKiaRK62+RfYSJpnJdKZ7dWIc12F63hOkHyT8AbDD2dZKa78
         WSaVZ8kIDew4Iw8Xt1iaCi93dXUk7HSn7c36byVytZzo0GGRqLr+b62qpPVHuWFvhzFW
         jl8SJGJHq+S51Y70W4acy3x837bRL4HY84nmV65t9VkBD2UsPpHor1n5dauEawRCpSyv
         EpdV3P7muE5Vey/GP9NUtt9RqIPfeTMH4rKyaFuOoj/pLeeEfVeUKBk3TLyeWpCWqQrB
         Qa/j2TqXU03dRdz+OfqOygB/IA2orxnpVsmmVRRE2yqUBvC5ohyEnHldvxcdfapexvSE
         ck0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6e2rzbi9j8qb90OvjKyuyG/gR/NCn8IpsePTL0cW3fKnrJjBXhRPBEriIFsXnRHag+vcf9F4S1ZfVAXXH@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVMq7NaRB82JqilBzYIr1CZKZZDPmPupeZAST4UHBYQsf+HEh
	FF6a2TMQn80dO5UyvjTvF4rM/TZtjy58WxSf1k5xTA1WqSzV0pEnSQi1AJiyMLVemWGkwwmOZoK
	y40NSbQCt8Dnd4W/bB9yt3e9PcpLzz/489J52doBGvEv3YTJG+fkJPw5MwV6xqFyFPBg=
X-Gm-Gg: ASbGncvmQ+M9faB7xut/iOTfzqsnBvI0TeAoN4nw6Q7TrM4WSo9llArIKML1rVhia/+
	FHY+b85B/jmMSAEi/U5UkOm4zI3uy352ySKBJZHTHuoQ46KIuJmcsP9KgM949jgUBUOnGPRhTDX
	nCrqHZ2uvPjjBf5EJ+vxK4qZpJ14uzlq8iDqfFeXbYU6iUPnj2KBeZYLk5Wl47kSonodmw+eo9t
	/cAbqcf0QqagEyQb56Qp6RDhCyZJeP/UZKfMZMv55Upd+QePOi12X8p+AZGAubJABG42L52f+zE
	UosI8gD/86oDwpD8XsrjdJZzl7aYlEakV18qAhIhVVQ7ev9kYCXbXDKmySorGGW9HaB50iB82fX
	LOUchX9fmFMrScaco+ACJLPPJTPEIoqf+qe9GsdRO1BE+co23Mw==
X-Received: by 2002:a7b:c008:0:b0:451:dee4:cd08 with SMTP id 5b1f17b1804b1-451dee4d1b6mr8272035e9.23.1748856790641;
        Mon, 02 Jun 2025 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkU7ZRpR1NEtSY/JfKM4+YPIoKTdq1NhU5Keu1p6sA2PS3/gG8eXtp9j/HneCiN7kQj1M6xw==
X-Received: by 2002:a7b:c008:0:b0:451:dee4:cd08 with SMTP id 5b1f17b1804b1-451dee4d1b6mr8271525e9.23.1748856789835;
        Mon, 02 Jun 2025 02:33:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc1b60sm117663315e9.34.2025.06.02.02.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 02:33:09 -0700 (PDT)
Message-ID: <9c465b24-8775-4852-9618-0873cbf2aaf7@redhat.com>
Date: Mon, 2 Jun 2025 11:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: gerald.schaefer@linux.ibm.com, dan.j.williams@intel.com, jgg@ziepe.ca,
 willy@infradead.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1398,10 +1398,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	}
>   
>   	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
> -	if (pfn_t_devmap(pfn))
> -		entry = pmd_mkdevmap(entry);
> -	else
> -		entry = pmd_mkspecial(entry);
> +	entry = pmd_mkspecial(entry);
>   	if (write) {


I just stumbled over this, and I think there is something off here in 
the PMD/PUD case.

vmf_insert_folio_pmd() does a folio_get() + folio_add_file_rmap_pmd().

But then, we go ahead and turn this into a special mapping by setting it 
pmd_mkdevmap()/pmd_mkspecial().

Consequently, vm_normal_page_pmd() would ignore them, not following the 
rules documented for vm_normal_page() and behaving differently than 
vmf_insert_page_mkwrite()->insert_page().


folio_add_file_rmap_pmd() should never set these things special/devmap 
in the first place :/

What am I missing?

Note that fs/dax.c calls vmf_insert_folio_pmd() for PMDs and 
vmf_insert_page_mkwrite() for PTEs.

Consequently, PTEs will never be marked special (corner case, shared 
zeropage), but PMDs would always.

Hm?

-- 
Cheers,

David / dhildenb


