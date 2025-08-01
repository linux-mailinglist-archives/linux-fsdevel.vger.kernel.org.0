Return-Path: <linux-fsdevel+bounces-56516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2CB183AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 16:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99ADC7B73AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A726D4DA;
	Fri,  1 Aug 2025 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5cODo63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32926B756
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058220; cv=none; b=jBlpslIvsHcwLam5crtaAbtNfWhnw61w5EyutrLXl6E9CXYyEuHtqgRC4YguO60d375GtqHZmwH/aCgqCLeFd2OzVzhs3xeU4sxe0/3WJYARERRD3m95Wlx6igM+PAGFhKO7VmATuq48ThADT7a/4Z0XZP+wVXf6kArJDgRKbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058220; c=relaxed/simple;
	bh=C7cJpsqAcZbPIqebFjorj5snQ/rXbFL+rmscPZt3CkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxZFv6myRwm0FVG46R4SX15fJ5F9JMD8/vVkcZKH4xs5/UB4+HmWNLT0fBs6Xh+b5lWC93MdXWSJsJL3Zzu+yXzy/etDTg2Fia+7R7EyP8i0h1Ux7IPmFWlxPBEoBp3t/vV/tQqvZz6qCi+FsYHspOtsu210qXeWFDnoe4bPT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5cODo63; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754058218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h7mKFgNhjQHVPpLADK17HpuzYY9CFufwiy/n3xns4nY=;
	b=J5cODo63RSXbRlELfvFpWI78RtxlVG6HtTma3PYzGcLTgBug1kMTZC9PISDFHcRlbt2lEz
	kRvxAhBZjFyXphnlyq6amTFifeul1n4Nr7ZAz7L6amWC+o7c0Io49NquScDwlQ9iUkl+dM
	NEgOsZF6+KbpvAgJsnQ/XlmO3P/CEDQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-_zDMWApsM2SM4zCbxQtghg-1; Fri, 01 Aug 2025 10:23:37 -0400
X-MC-Unique: _zDMWApsM2SM4zCbxQtghg-1
X-Mimecast-MFC-AGG-ID: _zDMWApsM2SM4zCbxQtghg_1754058216
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458b301d9ccso1204045e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 07:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754058216; x=1754663016;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h7mKFgNhjQHVPpLADK17HpuzYY9CFufwiy/n3xns4nY=;
        b=ifvS9ap4bp+uFQySVu0XnJQ2rmxz5KRiDGkjrWG7HgA7UBfeb9P71r8UrAmB3t5t1i
         FjSGVtm5Y3OUagr7Xfdk+WfGGho5eODSoG+941sIvvMAL2fEw+mR1PZc44a7gc2JHm+P
         wxTIqitgYwxGXmjQhwhtgnOUi2yo8brnqQiB2YZn9l7Q/2AA2s1BKrtXsG1XWpR1MsDJ
         SOXl6ZaVr8KFxp9YIHEwYJUKpyVBg7KtLjPYracj35f9QqlynccKyfd+ht3VgZFp0wam
         DLVSdGzJOy9iHfGCHm2IWMFzlkgCuY+0bK3Pj0+m2L5X0UAHhlwomOtK0OJC75V9gDlp
         Ss6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe0XGEFGdDgmRIhPtPr2rd0aFmK7Wmid5s2IApxmG0ozSrSB98zzMGaX99VuoM+mMsZc4D9Nb20snTtTUz@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrRIcliWE76drmxV7c4LD34MAGWnvig/I6x2An3NrQC3JIFj1
	AZdxo3PgmUtllGVmYVjKo3w7UM+L8tduKxmimPnir2PvHDPAX/oOKwRYhjS6qPoBo16A70/RoNy
	NYTm6HDBR11KwZT4KWvmr+ORTXDw8k/+Fdm5xLeokVhJH4IUfJYIPFCOFxKBsUEFYB1o=
X-Gm-Gg: ASbGncsNj2Bt0gdnunVfhb+x5u4vo2ooVSF2t2ern3a63uCp0Ckm4edlaRSCQxHEv1C
	HVKvP8UoOF9kXvbLARrjTnfDRyiXJo/qIXLBJOt3Yf9ug/liWRYB4w+9eOw4LIMfRl3iO1FMtXL
	eMxY+ZYbjR+/nnxF9Cjz/kelxSJGEP/jxi4JooJuamoeJxPps3y9EiXQb3BfM+UjUfptI2CwlCu
	P0SMyMN0llPqA9rFywQhsfKEGcVt0NPK/MCgsFUj8hnPXqvqAMjIJdol0NhMcUVIjIUCF6ofOMo
	gmxt8Lj9V3uXZ6u9S2Hu9ZWB/3qCSg6I+9LuGTHHBVP2JWlQLq6SutVRbKbn53ohRew0DJhlszH
	ni+lKhlPkfDU1cYZ8SCGVcIKvvBSun1sH+H9Qtc73dNj9rC0ONL6IfWbm7pk6SpHD
X-Received: by 2002:a05:6000:2906:b0:3b7:8984:5134 with SMTP id ffacd0b85a97d-3b8d34458bamr2706366f8f.16.1754058214239;
        Fri, 01 Aug 2025 07:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ov4+m3bhMWt6XWUmjAi1j/30ofm7xshGyBWCHDYs1YtYTD1WrZVVUYTZQL6gcOxOSI1+uQ==
X-Received: by 2002:a05:6000:2906:b0:3b7:8984:5134 with SMTP id ffacd0b85a97d-3b8d34458bamr2706284f8f.16.1754058212333;
        Fri, 01 Aug 2025 07:23:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af8c5a87sm13192285e9.2.2025.08.01.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 07:23:31 -0700 (PDT)
Message-ID: <85a22428-24b5-4a85-9d75-bd2f742ab471@redhat.com>
Date: Fri, 1 Aug 2025 16:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <20250801140057.GA245321@nvidia.com>
 <3cf76128-390a-4ef2-85a7-e3ee21ba04b5@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <3cf76128-390a-4ef2-85a7-e3ee21ba04b5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> I would like to suggest we add a vma->prepopulate() callback which is
>> where the remap_pfn should go. Once the VMA is finalized and fully
>> operational the vma_ops have the opportunity to prepopulate any PTEs.
> 
> I assume you mean vma->vm_ops->prepopulate ?
> 
> We also have to think about other places where we prepopulate also, for
> instance the perf mmap call now prepopulates (ahem that was me).
> 
> So I do like this as a generalisation.

Sounds interesting to me.

-- 
Cheers,

David / dhildenb


