Return-Path: <linux-fsdevel+bounces-51859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4DEADC639
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F50416ED52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C88293B5F;
	Tue, 17 Jun 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCv41XWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA828C5CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152334; cv=none; b=OedH46U66YFYIv38EBO+JC7LxQ2HFSZYTBbx7jA3ZpnFv8uNepg6Klu9nFcmIKOqt7L2ZUSgESyCbe0QRkCC3ciOGxjD4daWng6dnAbaMhObzOgr5Aym2N3Wd6BT5q3NCnFrND6I3aiyzKZ1iGvvbG9FR2f/7lTevjyOmb/0gyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152334; c=relaxed/simple;
	bh=wWhnXAyX2CPjsnfMuHGcrmqHfLEOeRFBGDWPGeExTLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkujJCAvGNq7yYB0BYYYwUhxxrQu4UiawgfyStKbA5npEE1DlGhHpW1Dzy21A6glCIrXLYrnKBO6fhbn5wyy8OdXpdmB2pebDVgMwpKjPuBQz3RrxtJAK4XcoAZyLBjY99+0/oAFkEkXIR1Q7OjkkzwGiUAXMkzfsb0wdF2coxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCv41XWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750152331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6zkQFw/Ch3T6ugLEDBuaz32yOTGmLuefrLkmwqJMJuQ=;
	b=iCv41XWNLK0us/aj5gQVyH8VN+bcGpnT4y6jyou3hWX00Pb8vrYuwEeaVCfVcXd8wgJFSA
	iOkbm+mP8qVQgz4pcdrcgf7vBj7o1YV828CpujecLotbd0WNPsiBLjbC5MPOTDr3B4jFLO
	YMv5ZXZEkUxKb5l5FrJ0qUiyWU19deA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-vEw1vOjFMsm67wH-s3LbnA-1; Tue, 17 Jun 2025 05:25:18 -0400
X-MC-Unique: vEw1vOjFMsm67wH-s3LbnA-1
X-Mimecast-MFC-AGG-ID: vEw1vOjFMsm67wH-s3LbnA_1750152317
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d244bfabso44470005e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 02:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152317; x=1750757117;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6zkQFw/Ch3T6ugLEDBuaz32yOTGmLuefrLkmwqJMJuQ=;
        b=sItHzQhBRx2EVUuKh+mgeqFUbxPl4JKr6Whqs02GLNSUip38PzvoLJ8ZXWNGAHnVAg
         iOQtCxF6oup/Fves8e8/sKWzg+CFGqGHASVwYoOwry9/87O7XV24ngm07ekvUk2w5iJ1
         t14qEBrAe/6oCMuYiaPdJMflDarCYOs/IBFf2RE0oPPoqz3tjUccCBZ5ha8RC37cyNE6
         4SPGH+81Dd/fWRB6fZMtQFYugTzXvat5fJ2iCgiYOD6GJx8rZKUt0vs07R3u8q2x4ERL
         EWY+j6TEDMWol1LK25gMfbiMmyc7JneL0yPUNkycSAYjsYDzoQj4V1URD6tjeQUDL25+
         NbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDgBQnrtpxC/RZsgrVQREkyjdQk/KRyZxz7sW35MIv9lQQ5ReMrLp7bem1zRgPA2JIrX7GTa2zq8m+hzCu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fT6oZRV2tNWvOwRFCZ2EOAxzWuaMOyKgQLDvqOazAlR0cjFh
	SiXkgVYekYIfD1czklgO3ZkXjWZLEFBhPTpSKkGc/NTlRGGeS9DCTotA7wEYVi8U/O2kGAX2ILs
	Sv2EGT93Bc+pda/Gwt37nLE1Up4OEk4wsTf3UOtsLKb3GG3lTP7xUYXOynYv/wzWmVTw=
X-Gm-Gg: ASbGncuUGnoKt4i5/mkQABBzPrGPxzoS4935o5lfMruyt7Yb3kyEP0ORqjCMD1P82IG
	qUJEhDvJfK6S4SZwj71EH5kBpWJPDmWDup10YPtTB2bj0qp7aGyOPzx7UCAPcpLvb0LPKS8VXet
	Wz2F/s5E8LCimbTilj/7jdI6DphHSxdRES/vXHoIdqZ7+hFFjqLxqd547DwxEDbQS7tM8RElG+n
	PgegFQDg40bpzGf0prqa8w5/kkBspGnMqMFRp+8Kd1g38wZoAGfOl7IFhKNzu7ZMbLOtW8Emgwf
	Q1Mxq2TI8T6/927ULWxYx9vAUtk74WQQ66zS3Ryrmtr4ajgW+F3mVwoX7HNV/g1YgKK1u/svsRa
	p7rTZ33EepCDZ64KR3BP3RiJUe1D2t6Nl7jLxkhU1Nf9TarA=
X-Received: by 2002:a05:6000:1447:b0:3a5:2fad:17af with SMTP id ffacd0b85a97d-3a572e58cbemr8127098f8f.57.1750152316866;
        Tue, 17 Jun 2025 02:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNVa+RJrykc/8Xieu2BbPmReEGJ3iCm4JfplZNxZv4/8Vep/Wlu6kppgIaFWfNuw/GXp3OKw==
X-Received: by 2002:a05:6000:1447:b0:3a5:2fad:17af with SMTP id ffacd0b85a97d-3a572e58cbemr8127063f8f.57.1750152316374;
        Tue, 17 Jun 2025 02:25:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b087f8sm13629833f8f.53.2025.06.17.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:25:15 -0700 (PDT)
Message-ID: <6afc2e67-3ecb-41a5-9c8f-00ecd64f035a@redhat.com>
Date: Tue, 17 Jun 2025 11:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] mm: Filter zone device pages returned from
 folio_walk_start()
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net,
 m.szyprowski@samsung.com
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <11dd5b70546ec67593a4bf79f087b113f15d6bb1.1750075065.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <11dd5b70546ec67593a4bf79f087b113f15d6bb1.1750075065.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 13:58, Alistair Popple wrote:
> Previously dax pages were skipped by the pagewalk code as pud_special() or
> vm_normal_page{_pmd}() would be false for DAX pages. Now that dax pages are
> refcounted normally that is no longer the case, so the pagewalk code will
> start returning them.
> 
> Most callers already explicitly filter for DAX or zone device pages so
> don't need updating. However some don't, so add checks to those callers.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes since v1:
> 
>   - Dropped "mm/pagewalk: Skip dax pages in pagewalk" and replaced it
>     with this new patch for v2
> 
>   - As suggested by David and Jason we can filter the folios in the
>     callers instead of doing it in folio_start_walk(). Most callers
>     already do this (see below).
> 
> I audited all callers of folio_walk_start() and found the following:
> 
> mm/ksm.c:
> 
> break_ksm() - doesn't need to filter zone_device pages because the can
> never be KSM pages.
> 
> get_mergeable_page() - already filters out zone_device pages.
> scan_get_next_rmap_iterm() - already filters out zone_device_pages.
> 
> mm/huge_memory.c:
> 
> split_huge_pages_pid() - already checks for DAX with
> vma_not_suitable_for_thp_split()
> 
> mm/rmap.c:
> 
> make_device_exclusive() - only works on anonymous pages, although
> there'd be no issue with finding a DAX page even if support was extended
> to file-backed pages.
> 
> mm/migrate.c:
> 
> add_folio_for_migration() - already checks the vma with vma_migratable()
> do_pages_stat_array() - explicitly checks for zone_device folios
> 
> kernel/event/uprobes.c:
> 
> uprobe_write_opcode() - only works on anonymous pages, not sure if
> zone_device could ever work so add an explicit check
> 
> arch/s390/mm/fault.c:
> 
> do_secure_storage_access() - not sure so be conservative and add a check
> 
> arch/s390/kernel/uv.c:
> 
> make_hva_secure() - not sure so be conservative and add a check
> ---
>   arch/s390/kernel/uv.c   | 2 +-
>   arch/s390/mm/fault.c    | 2 +-
>   kernel/events/uprobes.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
> index b99478e..55aa280 100644
> --- a/arch/s390/kernel/uv.c
> +++ b/arch/s390/kernel/uv.c
> @@ -424,7 +424,7 @@ int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header
>   		return -EFAULT;
>   	}
>   	folio = folio_walk_start(&fw, vma, hva, 0);
> -	if (!folio) {
> +	if (!folio || folio_is_zone_device(folio)) {
>   		mmap_read_unlock(mm);
>   		return -ENXIO;
>   	}
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index e1ad05b..df1a067 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -449,7 +449,7 @@ void do_secure_storage_access(struct pt_regs *regs)
>   		if (!vma)
>   			return handle_fault_error(regs, SEGV_MAPERR);
>   		folio = folio_walk_start(&fw, vma, addr, 0);
> -		if (!folio) {
> +		if (!folio || folio_is_zone_device(folio)) {
>   			mmap_read_unlock(mm);
>   			return;
>   		}

Curious, does s390 even support ZONE_DEVICE and could trigger this?

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 8a601df..f774367 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -539,7 +539,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>   	}
>   
>   	ret = 0;
> -	if (unlikely(!folio_test_anon(folio))) {
> +	if (unlikely(!folio_test_anon(folio) || folio_is_zone_device(folio))) {
>   		VM_WARN_ON_ONCE(is_register);
>   		folio_put(folio);
>   		goto out;

I wonder if __uprobe_write_opcode() would just work with anon device folios?

We only modify page content, and conditionally zap the page. Would there 
be a problem with anon device folios?

-- 
Cheers,

David / dhildenb


