Return-Path: <linux-fsdevel+bounces-37673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26A9F5991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E2B7A426F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC61D7986;
	Tue, 17 Dec 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UACIaBk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173C1D9A63
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734474694; cv=none; b=Pqo3F63aoWPrIRDYHEzHfIIoA1BKzu6YdrYdysXk/8mmrAmRUVhjXiGmOj6hp+bhgg9JNd1cICh1zfXYAwHoT3NBHO4m/MFwSCE4Guo05DbJxAyoLaATS5CSQ9ItfRtjl5soYndojJ9pfYwggE1DLrFEv/Ko1FwDQxYcoHGf3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734474694; c=relaxed/simple;
	bh=JZPV+Rdue6qaDY10NWyx4+0EHsb8/mQ53pzmV8r9o9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UedYlosjastLKquX+DNSkzRxnT2H6WVhOcoGRO7MJs+c8aijmtMK8hb6GJ9k4m5A1fgmoXVONIekfaa79AN0a7KjQa4Zp/zcpU+vfX6IZYR6Vfg25MFAalB4hsdwCJ8pczkQM86oFNEbrpMT5/iwZxSclW/cK+jwom1ZGn4L1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UACIaBk3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734474691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XiLljyALg1fM2VreFU+kaDTSYWKU4UrG1GGEjFwMl+I=;
	b=UACIaBk3OlQj7nEfEXJRjPQm3gsXG64lPOxSqMOIp+xWIecRZsHPti69McsgugfXGx/dOM
	L1q2p+JXmqJP6Mv+bgFaVIFhPmIGgVS18V8jfOrp0EGsBTSmb8il81qctMCNGpeSF9H1+h
	3f0s8EK8yEd9TpNjjevMICO9uRGawEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-3C7KTIWbPAKW_Q4gJg8QiA-1; Tue, 17 Dec 2024 17:31:30 -0500
X-MC-Unique: 3C7KTIWbPAKW_Q4gJg8QiA-1
X-Mimecast-MFC-AGG-ID: 3C7KTIWbPAKW_Q4gJg8QiA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43628594d34so27043985e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 14:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734474689; x=1735079489;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XiLljyALg1fM2VreFU+kaDTSYWKU4UrG1GGEjFwMl+I=;
        b=f1XM2E4wO5Kp89xsR4Cf7dlZF+d0m/7WH4bfSgxutZZDn7oDgmEkojl+JE8VATpgJo
         s9fjlml4TsDX7O1yGi4O03yjpanQn8xZAqnz84uu6HYLu5QyZ343Yix+QTCwlRQsqii1
         7FGL8NeM/UqIMNGr78SwOn7iJfrd2SYh05PYRcrEOdtcT2Q6xneb0rO3/bwySRFhJOvm
         +vB3HeA1w+RRC7Vw49LFvb75s/tr1mYR5vkPHJcPVNbN4O0ZqpB70pE/XCfNsAsHUA2t
         8wlHAfOYt4vBV5Uo5Nro7UtUKtr+1QPmKrjrs35K8tldICa4pRwBPomK+YzRXv77XPk8
         emMA==
X-Forwarded-Encrypted: i=1; AJvYcCVHlhho2iTvTT+B7v+bSUjgWKZJIGjKWEAjWYKJGxto7fbEPm60o8fdsnYhxVZTZPKoil98zgH+Ywb0zogd@vger.kernel.org
X-Gm-Message-State: AOJu0YwfY+0rVh6qVMMT5g/VknD5dcUDMavIA5olHDY1M1CVxQ+Exakt
	f91lBH8qAPuO3sEu4LHLwln8cUc1TuTXLyCLByVcR9slXYmG6qp+xG3HJPpllmYtk9ks9ZK+129
	dM6th3GAXUZ198mrDvHydxBS/ltXJRISMfgkPydqqe/0N8/fLpCyTCVWk5qiNYbg=
X-Gm-Gg: ASbGncvzIoTs3pnq4U+KGCX6mkQfUQ2crp6Fpg6nTIkDBW/HOy8K+OYtk6hR5AJpd3G
	n8KbpwOqG4TducqKMQY+yxCzJufvC6P+V9a0MpOP/O/n71cM+n+6yMcgEUaMI/SAxf3opt5cIBz
	lzWrMqjrBGJCnmaZMVN76/AErJXDAta0qwkV/Kd9OkgCkBmvpaRL2oiNyuyBO+P83d90go/ge2N
	fifrQ8j22M0rLjyIH5/+gPse/xjTEPuUadyKZGkor/bJDb8xcDXCe8vBNUang256TTnB6zmfTez
	/Nd9JqiRdp4GQXpnWsmeFZQ7JBVOh1l1DgKdeMLnf2/2VC+72vYH3J3kr7settdXbhJ1X6dglxr
	+GbwKnJ5R
X-Received: by 2002:a05:600c:5103:b0:434:ff9d:a3a1 with SMTP id 5b1f17b1804b1-436553445f5mr3532805e9.2.1734474689196;
        Tue, 17 Dec 2024 14:31:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMpkNWSDjSv+iIYkeduZssHVTB6HwkoYhZzex1R7it6KzpFTUsFNkIA9cgdJx8YijN/SwZMQ==
X-Received: by 2002:a05:600c:5103:b0:434:ff9d:a3a1 with SMTP id 5b1f17b1804b1-436553445f5mr3532555e9.2.1734474688806;
        Tue, 17 Dec 2024 14:31:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:5600:c716:d8e0:609d:ae92? (p200300cbc73b5600c716d8e0609dae92.dip0.t-ipconnect.de. [2003:cb:c73b:5600:c716:d8e0:609d:ae92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801208csm12474132f8f.1.2024.12.17.14.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:31:27 -0800 (PST)
Message-ID: <c7bd9b00-6920-4dc0-8e2e-36c16ef7ad5a@redhat.com>
Date: Tue, 17 Dec 2024 23:31:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/25] proc/task_mmu: Ignore ZONE_DEVICE pages
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
 <f3ebda542373feb70ed3e5d83b276a2e8347609f.1734407924.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f3ebda542373feb70ed3e5d83b276a2e8347609f.1734407924.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.12.24 06:13, Alistair Popple wrote:
> The procfs mmu files such as smaps currently ignore device dax and fs
> dax pages because these pages are considered special. To maintain
> existing behaviour once these pages are treated as normal pages and
> returned from vm_normal_page() add tests to explicitly skip them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   fs/proc/task_mmu.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 38a5a3e..c9b227a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -801,6 +801,8 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>   
>   	if (pte_present(ptent)) {
>   		page = vm_normal_page(vma, addr, ptent);
> +		if (page && (is_device_dax_page(page) || is_fsdax_page(page)))

This "is_device_dax_page(page) || is_fsdax_page(page)" is a common theme 
here, likely we should have a special helper?


But, don't we actually want to include them in the smaps output now? I 
think we want.

The rmap code will indicate these pages in /proc/meminfo, per-node info, 
in the memcg ... as "Mapped:" etc.

So likely we just want to also indicate them here, or is there any 
downsides we know of?

-- 
Cheers,

David / dhildenb


