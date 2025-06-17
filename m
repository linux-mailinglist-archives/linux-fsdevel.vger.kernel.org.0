Return-Path: <linux-fsdevel+bounces-51867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E021CADC6E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F125F174A4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343992C08C2;
	Tue, 17 Jun 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhZnPZvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE42951A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153479; cv=none; b=PhvT5LArNtgTFsUVDlexFMlA/LgrrfeFkPcfiGQacaB18EpNj7m8jGDU3EHBiGucfhtIcbyZNu4dC+bkDta/TCNUAKn9VzsG/DdjVIU6pSIq0X2bd6vtAbp04FahmjIHCQnYFILxJftFS5L17tTZnifAd4tOj047mCBwBFaqoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153479; c=relaxed/simple;
	bh=SEIeerzS0thI+z5d6kA6cGgH8szp0nPEZ+WNtrQjWT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSVpafd8int8zutvGz4oua8p/iQvBsNpSCxqaVk+Vvmf9oLSu28jyqf3dB+PGuDRfY/PpuMtrSqI6P7j7gTxYEkDpuHb710DXY2Zw8WTwcXTk293ZGBe7r8GcgtIkv80P58sLr5+0gjJEa7Qe2LFWHZ3vqk0AgGpbn7OnBg1dGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhZnPZvV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sdEh9cEys/eVA2SD9wfMRib1+LZeWMxS5mffwDFqNgM=;
	b=PhZnPZvVgXYI9sDuBv5rhbBeuDZwc0VZbf1U2pE0Uf9QIjnXQMp3SSSJoyJHtzWX9ce//Q
	SpVMnfSim05APgbchlApkNkRhiJcU6wCq24N6urLB5mDc/gsFM3xCSm8FFjWbIkPL1MEx4
	OxxPsBngcK6yULgL3cr7qaJmyZH6pNk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-xlKraobsOT-ySScnV-zG3g-1; Tue, 17 Jun 2025 05:44:34 -0400
X-MC-Unique: xlKraobsOT-ySScnV-zG3g-1
X-Mimecast-MFC-AGG-ID: xlKraobsOT-ySScnV-zG3g_1750153473
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a58939191eso193190f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 02:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153473; x=1750758273;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sdEh9cEys/eVA2SD9wfMRib1+LZeWMxS5mffwDFqNgM=;
        b=Mu05uQ5IFCRYLhtqNIFhaDoYNuFWD3mSW2vAjJ93fQRXeaNGEyMhFenZ/O7ohjuZIt
         /9QK1P09mW5vsOeFxJ7etWrFU5v7vb9xujyvxEExcuHqcZo8O9NeGArlNeWtm7hcZk+Z
         q4e3f3BkUhwQFK52k1hXuXXT04dtPEGKj3fhJAldFyTAaqHLHaVdI982EEfNx8BPcOrU
         kY47FY0jvCEo1HVHIFfnYT/u/qSyL4xNlphfAEAo8TucHY5uoQpBgtNSFPXXmhzrYhH3
         62S1H1QUs4S9+KappStEajNB8oWR6ZxXoEKu6Sb3WZ6QIAnewPjhA2SDMYcA9fGVkf/U
         d0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUriGdSOciRMq/pEvHb4/pvg4GFgSnvr9Y70DHvi4nFtuXHNyO12I1xH+mQkQoRLm/crsnVVqDfv2kdYYio@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9mApi8wJXHY3VTnwemhqxKTjBFSFC8kNp9QXfn8sdpyoA+mPH
	/TkYnnaSZFuSuKqKT2/BY+MM6XMluLOJgf4hSKf1g6lc6mUPeFZe+3Mzw6X9w1LD6D/mp//9AR0
	sxs3iScRB4w0RomLUOSej5DI0Rl4UeDUzFnZ9KGCf2BySuk9VkBLqbGN8LtvAYU/EjNY=
X-Gm-Gg: ASbGncshnjtQF3XwxBIjZtj3gLMza+BKG0FyUg8VFvbBzL2iyizOtRpwhBExsNgXukS
	q8oPWWgUll7g+nlggen3jnROkAZJae0Qy0LIqSpxfQc0oiorXV6KgXET1DIM9Hl5o0cnFDDfaEQ
	DvY1RR9K5vsPttbDL8wCKFKWjRh6AurUcN40SKpcPTDsAOEoIDf/KfcHz/UPWYMqJuDf2bPUAHr
	D61GnU9UU1l8Qk+A/JZeBLTtn89NA96/msEVGTyk20Igq/Uh/WWoGWLXdbOMk66lcRiP/pYjvha
	l5DfYplOaS4yt1nPkdQY7ef0YauB3gyFxfIA2kUw4WytFK/KiwY5yHrrl2pMUZrzAo/PdPwufja
	Twfa63RTKIhypJ+hf+VuNBRckLO0RGB6PWOhNL5txUoL/iIw=
X-Received: by 2002:a05:6000:65a:b0:3a5:88e9:a54f with SMTP id ffacd0b85a97d-3a588e9a99bmr1291327f8f.1.1750153473105;
        Tue, 17 Jun 2025 02:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHQpVd3mwZ+TEDjCXC20DL1F3MMRYh4Y/yZHPnb93a/Bf/b7RyUJmn1/nXnnPCK9NELoBd4w==
X-Received: by 2002:a05:6000:65a:b0:3a5:88e9:a54f with SMTP id ffacd0b85a97d-3a588e9a99bmr1291288f8f.1.1750153472667;
        Tue, 17 Jun 2025 02:44:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4b67bsm13257644f8f.83.2025.06.17.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:44:31 -0700 (PDT)
Message-ID: <31bdbfcf-bbfa-46b7-a427-806d42d88cec@redhat.com>
Date: Tue, 17 Jun 2025 11:44:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] mm/khugepaged: Remove redundant pmd_devmap()
 check
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
 <d4aa84277015fe21978232ed4ac91bd7270e9ee0.1750075065.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d4aa84277015fe21978232ed4ac91bd7270e9ee0.1750075065.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 13:58, Alistair Popple wrote:
> The only users of pmd_devmap were device dax and fs dax. The check for
> pmd_devmap() in check_pmd_state() is therefore redundant as callers
> explicitly check for is_zone_device_page(), so this check can be dropped.
> 

Looking again, is this true?

If we return "SCAN_SUCCEED", we assume there is a page table there that 
we can map and walk.

But I assume we can drop that check because nobody will ever set 
pmd_devmap() anymore?

So likely just the description+sibject of this patch should be adjusted.

FWIW, I think check_pmd_state() should be changed to work on pmd_leaf() 
etc, but that's something for another day.

-- 
Cheers,

David / dhildenb


