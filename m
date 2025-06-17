Return-Path: <linux-fsdevel+bounces-51863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA46ADC6C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1CF3A9881
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE7295519;
	Tue, 17 Jun 2025 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbRqQpV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56656293C72
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153016; cv=none; b=OTM2hUFcQ4N078NoCM5Xd3/OOPtTtyfSX6wkUBn61U59lZ9rx6x9Zo47OXF3FAZMrG63sODdUlGuy6F7FWHkRDwfFQvRwW1oKO5Vcggq/6gi0mWZnjjy6OjcuYref8p9YCnvwayngV5gVuSWdFl3ZjbGa1+JTEFa2Ij6aEk/wZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153016; c=relaxed/simple;
	bh=HH6V1fnf+nZI2Ty8BdLKCLuFpYcl0XP6dXI6GJxS+MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/8SgOhdzRF8ccNm/HBW9xvKsH9gH2F7hXoJJYJjWpW/CbD1PdANQd2Kclm00zxx5gHIl2Yy1BLggTSe82Ar2Gc2daKNBrdJCNuNf4O3jrvVHmNCfQZ0bzW04bGPjZIqkwpyeyhRCkkTVXj0ZR+KYXZmTAmE/+aJzF2uXWVCt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbRqQpV4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QeaQyg08N2bK9CSAL6amctKGL4o8t+/yBMjOyZjIdjM=;
	b=CbRqQpV4Fx5t04CurVSaHnFBr5RacYOHA06wRouAp1lnDAjdq7eecOifVRzmGgEhTM1Aku
	rPm07YUiwTnwocdUtEkv744dFD9XcDadtf8NoYuoySKpSx8BWT1KO3VfNmEIxRCiXwCu/+
	vR414MBteliWe0yRG5OjUNQYuQ85tqk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-PanYiMQ2MF2qOsM_Q2Te6Q-1; Tue, 17 Jun 2025 05:36:50 -0400
X-MC-Unique: PanYiMQ2MF2qOsM_Q2Te6Q-1
X-Mimecast-MFC-AGG-ID: PanYiMQ2MF2qOsM_Q2Te6Q_1750153009
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532514dee8so45961415e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 02:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153009; x=1750757809;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QeaQyg08N2bK9CSAL6amctKGL4o8t+/yBMjOyZjIdjM=;
        b=OLJUZxjTYVSEljSaI0mUrmOfdjvW9R6ZNfcxZ83Y6EGB3TpC8FGLFsEnmrgq1Cl/ld
         Wdmw8G9lt8WN4i++uof5spfwqdZYpG7qzCMpQACjpF7+QpVDiQ6HcIkoS7/WETPcwIyu
         wPyraJgjQrKzMV71cCTb7RyQj5E+6cOXKueBCGLlvDXXSLbqYIvleqLieuFBoNl8rvlS
         D1Lmw8LUHK1JCXTvFmdn8L2gwqai9gvej0+zyYYBrcYibsXN4mjIpPPtDgxEaRFglE+3
         +zSTefCqr+mJrk1W7u/kZW3ZX5Rm8jcEIvnVcLZsr7F3m54DDVdukUb6QJ4G+q/zX6BB
         kWlw==
X-Forwarded-Encrypted: i=1; AJvYcCWCedsFwfyYKgItWCuGduh7yFom5H1FGNZUoQgQgUUIr1O5xYYUNfKjTLApyvSANDuHSuqsv4guf0Ia2xsN@vger.kernel.org
X-Gm-Message-State: AOJu0YylpwTWSKP/RQqI1WEvu3qpNZbypVPz0ENduiIczKCNGRtSlmgg
	QnPJDVS5Q5MNr7lkWA7AD5f+QbiPm7p9HhXYQU18JnUfIBIMLwKZA8HYxXHt4M95iK23Kor1i6L
	plbl+/ASdfWGOoH5lZV4TEPa5hwa1il2zfY60aZeDcLpv0AEyr4n1/o+LfPgY58633Tw=
X-Gm-Gg: ASbGncuIBArcyZOLCjOkZ57QSfoi32knkBXhJah7NdL71mE8SELAEtI0iT+OPO9Z5ul
	Zes+qap3Tpxwn6Ar6/3TuAmb8oMeIolnY0O6NGUdzQbA3f+5uzMeE2TXu8qTs7hBJ8LgI9qMWAH
	BriEDS17jkr5pxNGZ+PiTEQnvsgNvICdu9zHlVkfn8TBghv+TrSxdJaS+phcMU1clhwGUx5bylr
	CR9HdtJkoT38xJPskfikVWAiZ8KGpHrm9nV5xueSXHg9/uygqbY3qNcKSDuGDNrzHS8yntS6IiF
	EygTYr+q9PPTHTD9fedLrrObiTyM1MRSC07hbJf37UoI89nl/UOEcIDTNO8gafAQfKSMNKwd6eb
	I57yK3cXCGirfCvEPJ3LJgpyV3xjGv5nv+YhpEpvz5qRkpmM=
X-Received: by 2002:a05:600c:6205:b0:441:a715:664a with SMTP id 5b1f17b1804b1-4533caa628fmr107487285e9.20.1750153008760;
        Tue, 17 Jun 2025 02:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiGU6rdJOxze5zntN178WfWP080iOaFrEHA392zHARPkcDs+AZMCwZ9uBzuwzj+r+ddywNSA==
X-Received: by 2002:a05:600c:6205:b0:441:a715:664a with SMTP id 5b1f17b1804b1-4533caa628fmr107486885e9.20.1750153008407;
        Tue, 17 Jun 2025 02:36:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a36sm13644198f8f.15.2025.06.17.02.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:36:47 -0700 (PDT)
Message-ID: <911e7b40-e30e-477f-a4e5-df34df1d0e14@redhat.com>
Date: Tue, 17 Jun 2025 11:36:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] mm: Remove devmap related functions and page
 table bits
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
 m.szyprowski@samsung.com, Will Deacon <will@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <bf6221bf1e3a290845417a60c27cf301203fd99c.1750075065.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bf6221bf1e3a290845417a60c27cf301203fd99c.1750075065.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.06.25 13:58, Alistair Popple wrote:
> Now that DAX and all other reference counts to ZONE_DEVICE pages are
> managed normally there is no need for the special devmap PTE/PMD/PUD
> page table bits. So drop all references to these, freeing up a
> software defined page table bit on architectures supporting it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org> # arm64
> Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


