Return-Path: <linux-fsdevel+bounces-52027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72CFADE718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405AA40449C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075B25228E;
	Wed, 18 Jun 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfRK2f6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E67188CCA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239070; cv=none; b=bXNTqzRZoV/4hWhyVx5w34strlzuxSdRt06MNjMevlags7Iz25T2nqoudXW08dOQkWYCKVCY09eUMrHlSYLiW0AKoOgw+aai2Bvr+1Qd6Vywvi/UN1AAo+dK0EhdxLt6mcNu5ctJuz90hNCGpuSLr4AB5gNN23llTdHZjsP2Ym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239070; c=relaxed/simple;
	bh=4DUmQNuK4KTUlCUIkhvb5/nFonNtmaZleGEiMulYcdg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KAQwiiWrqslBrQLM8uFGyPLFzYZvO5YAVz/0GSKd1WiJHozrCgw3XHv27rm5WGT9elxKJPzUnyHH2tOBML2gTBNz2DvA/mNp86+rD+F3HhMig9eXX899+y53HnwKbVp+l5UTHVE9t00LA3RdK8Re7FY5yuw215llrDApHZ+PMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfRK2f6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750239067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DAAxpkDR64hsnaI9Udos0W7mCWFzGT/DUlyAtDcPHQM=;
	b=XfRK2f6Xk0iT8cmMZXk815s0t3tgxz+oyOZWSVz+uW4+p+qa8jmYy4l02WoJfkmXsOZmMc
	VfXqBLUNi2O+68Kz2Kw9vK+lybCs/GkbBmwoKXuCyXpzBstruW6ad8lfns1w/mgLG1Hd2K
	Dy6GbhyvB+smAKK56F/oOL1WdRs77+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-s2MrJV7aMHC4bR7MPZCBGQ-1; Wed, 18 Jun 2025 05:31:06 -0400
X-MC-Unique: s2MrJV7aMHC4bR7MPZCBGQ-1
X-Mimecast-MFC-AGG-ID: s2MrJV7aMHC4bR7MPZCBGQ_1750239065
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so3230395e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 02:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239065; x=1750843865;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DAAxpkDR64hsnaI9Udos0W7mCWFzGT/DUlyAtDcPHQM=;
        b=LXjpIo6S7UKhm1nR2846sa98Lh5fZb3/01A+dJHvkqhcXcbgt4/9fGo8M4OKi5Vthq
         VtF/DDEu/JxIUe4VoS9j9EsNmqbhZneqvUwr2KGcJVXZsmbEe4rERbUDGzNf3aPjm9BA
         oXPw4ApkfYeVNcUayPbhIgIyYn4+JU46+Ao49UQ0f+0aCudBNFU5L5EUWbRkdyMiWnQg
         Fs9iPcAgXQ9bSaVqgCp3i9pSANnWE5wjla9+Ft+1jKNQiI/kC1GhGL35LhwtIeH9MtWw
         y6mqr0B5/MQAJ3yUdq5U703IJgAHwRv62hwBh6FVj1TTmC5yFp4UIWvc559EO1OcqGzz
         D8tw==
X-Forwarded-Encrypted: i=1; AJvYcCWKzb2crAltWGvS+S30S3W2wvJOqC0C+BPBSEp+gZ+fq5EM/Ae+IRr0CyBVUtQx8Vv1ugQuf7KY3QbME3v/@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1oxSI4k00kOt6Z56KdTQueQRpenZfF/gUhvudEKhrj2IOMRM
	ygWj8kArHRK9uLpHnkCnJ1vRW4ic2LNzKn/oK13vMRaCCt6PoeGq+fj0mUfIgDdq2suFy/FSJkU
	iIygcNKxu2D6GTMxUYDtlg3dv2EvnLDXa5j1FU0JSVOEEJHyXVIehojtSmXORB9x5MfQ=
X-Gm-Gg: ASbGncsooWBKwhwQNke07PaNB2mrdNCtjRNTz5+1ll+rA8VT89VJAEmu+WDs/a8LJGl
	QwLi8sMKzRCWnZ+VqP62+GbhEITdQa/B3tBg5wcNKQKGIAMpEcuGr3zFK7NfbJ34xzujJAY6MM9
	GwMrLynYTQU8FhEp0TB8jgSVyEOEa3JsqEQ2KbWZNddkRSpuPtrzCAB87Wmqy0SWblzqSY2wEpb
	qFxVMVrkYOYOeWjVPGEk/gVRaOP0uH1uBk9XlHHRHB4u4uIT7/1ax5jP02Y2yzq2evE2w5iIPdu
	JOBu1JN3R998BnKp/J8REAloCt04wH3G6ewjVMX8BTC7XLhtA/eIi3gf1g2kzs5FYbwd3yTId8T
	y2u6HNPbQbJ9e8wRpq4OAmbCQIsZBWaR6NxMzcYTs9te0xp8=
X-Received: by 2002:a05:600c:5396:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-4533cac8fdbmr151178305e9.29.1750239064914;
        Wed, 18 Jun 2025 02:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFE2lmgl3UBomQIO41tOZKwEtVJWCPsqqDyTr4SmltEOYbKotteA+xAeGqRpDK/3zaPP374g==
X-Received: by 2002:a05:600c:5396:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-4533cac8fdbmr151178015e9.29.1750239064488;
        Wed, 18 Jun 2025 02:31:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:2400:4052:3b5:fff9:4ed0? (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a73845sm16606417f8f.35.2025.06.18.02.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 02:31:04 -0700 (PDT)
Message-ID: <051f769d-3a0e-409e-bd40-22000f10b986@redhat.com>
Date: Wed, 18 Jun 2025 11:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] mm: Convert vmf_insert_mixed() from using
 pte_devmap to pte_special
From: David Hildenbrand <david@redhat.com>
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
 m.szyprowski@samsung.com, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <5c03174d2ea76f579e4675f5fab6277f5dd91be2.1750075065.git-series.apopple@nvidia.com>
 <1709a271-273b-4668-b813-648e5785e4e8@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1709a271-273b-4668-b813-648e5785e4e8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 11:49, David Hildenbrand wrote:
> On 16.06.25 13:58, Alistair Popple wrote:
>> DAX no longer requires device PTEs as it always has a ZONE_DEVICE page
>> associated with the PTE that can be reference counted normally. Other users
>> of pte_devmap are drivers that set PFN_DEV when calling vmf_insert_mixed()
>> which ensures vm_normal_page() returns NULL for these entries.
>>
>> There is no reason to distinguish these pte_devmap users so in order to
>> free up a PTE bit use pte_special instead for entries created with
>> vmf_insert_mixed(). This will ensure vm_normal_page() will continue to
>> return NULL for these pages.
>>
>> Architectures that don't support pte_special also don't support pte_devmap
>> so those will continue to rely on pfn_valid() to determine if the page can
>> be mapped.
>>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---

As Andrew notes offlined, there is no content here. I sent this by mistake
after replying to patch#6 instead.

-- 
Cheers,

David / dhildenb


