Return-Path: <linux-fsdevel+bounces-55701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573DB0E05F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A39EAA2EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E6E268FF1;
	Tue, 22 Jul 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnVz8bC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0F267AF2
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197722; cv=none; b=LJVjQu06e35LvI9gnRGXsTn9bm5ZWKDpafj7THajjpPtu/26G6WFNkhClXiLMPbynoa4QVdkVVMqpKN6M7Y8lIsEHe1+t9xvk4+UM/SHR+fSRJi100wiBl4ijsYlPcB7SHqsbKOxFXpSA5lrCb+XN4SfFSboiQjWits7xAdjn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197722; c=relaxed/simple;
	bh=Bz0qVqHYmaFGLr0K3Aste3DeRRvF4uZB3IkjMQ1SJXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDY0BqBat5Lwv9Ix96L9LyLWWSwHwR+UQHJLKXtH4RqGwrAwtQ8E8vt5Y1t3hGPFCZYObXs3OyzYaPtR3rNdQntzt5D08YqR6gIsdJteeuScpDxjPzKcC9ybkwxDnuCjdeFA5HqjKtJiPXUiCQbHofVHrNNks2MlnnB6lq8tcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnVz8bC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753197719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3lGVCvSvU+dwTTyQ/1aMBu54ELfXmjnvHtRzgY3JvgA=;
	b=AnVz8bC3INVyTTk2pc545NpCFBfbEOi2OGDfv2YH2l+KKRezV4llgHQShfxnl206IV6V50
	cYcyyWQDsYXCfC+MZZR4IrJ6j7uW2fX6rKzVIa0dB2izA78dZ1AYk561REv4a8ulZF6NVt
	1zLl2LwUNv4z1CqSav04O310CBVZjA0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-2-XOykp7PGWcwUjYM2wvBA-1; Tue, 22 Jul 2025 11:21:58 -0400
X-MC-Unique: 2-XOykp7PGWcwUjYM2wvBA-1
X-Mimecast-MFC-AGG-ID: 2-XOykp7PGWcwUjYM2wvBA_1753197717
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so35282735e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197717; x=1753802517;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lGVCvSvU+dwTTyQ/1aMBu54ELfXmjnvHtRzgY3JvgA=;
        b=ewHkW6iDfvgDYQcu968VtHP1SDCBg1X9eMcYlG34zXPbnMcf5AFnKxp/rPD7QXfErG
         7pGnED14ptRrDNmrV1ZLfRjFBHzjE/5yT2128Ex5j3xoRDMdolhoIPkO92LqP2i3/K5T
         RUhLApRc3CEAl7zKz1YK7fg/eSzI2IZpyqMTE9RSY/Utg6Clx7eKOQSHQzt1pJpr4aqO
         BvbT7Ri3yR7Qqh9PDoqbx+0f1+5afrDs1hTkMDye3hdw1PXtEfY98G7DY6Cl1KCBr+zj
         Ck8AjGZcYLlV5A3+DcNNrfxu3QsBzHP+IbXMFZHPG739m1Ezx9UvyegnOB/IJirQRRZX
         hETQ==
X-Forwarded-Encrypted: i=1; AJvYcCUevtZ5Nwu6ejs3NK6OGEQwHVQo7LnuYUBTufvTlPgAeB7klQnc036mNPrdCd2JcXvDBInwh8XXP5IjyS15@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqGzdCUETu7eOq7LT8mnnryV9md2+l3X0o9kl++L+zel75K9l
	Q8XRrVbjKcNmNVVMOxS+SPEhOI6gocEQFoxowuugRAj7OWoCCEszg/kI4f+oc6nqaCR8r+33aDj
	aErx2dh/yyiWBCu4K8GJdVv434ouH67CyO/Z7ZiLF86EhoM1IwWnOewLlLqXmKjDY7dQ=
X-Gm-Gg: ASbGncvOTbfld1+hYC7nMBqhO3qUuzs4mWCBheOiU9dx09B5AqJw6FvYgucsx7aXMTB
	70LbZSFr9erPspYgUVvNq3XwAe33CpMgl2vzO8cNJFUjrcjBNEiTYkq3rIxlJyF96EdoNhNrk9P
	AhhIs6oFi3+usaMWSJVvhIhBKHIE6V00xs2KyaTdtz8rBOq7W68Y9wTMknUZOcRYkvwZxaIVHLa
	ng1/0f+XH7rGqfvHLVSRBPqej4CCCpYaeF2N/lvUw7wA2YJzuaArYe+Mb14PDoJyBItKN2pm/Gg
	FsjwoLZ9Nhoe72e6+eeaZEnrlnZu4OzgiE9MIYRWLojt2d89v7O/KCW0jq3ZwaLAlL9A+I2Vrf5
	mAYdh6cjRdBXjlESSrNrxqinNDohZqXR4t5Z1/iFmOi8acd2fImqN+GQkdik/oKRQm1U=
X-Received: by 2002:a05:600c:1389:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-456437a59efmr137996775e9.17.1753197716926;
        Tue, 22 Jul 2025 08:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5enLdCYgzjySAx4ybbYU0jMVafZgCttcr6BLFjBoC3XlTsR3XaXP1SUNWMbt7hDHDm6g3EA==
X-Received: by 2002:a05:600c:1389:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-456437a59efmr137995965e9.17.1753197716277;
        Tue, 22 Jul 2025 08:21:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802ae4sm192273375e9.13.2025.07.22.08.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:21:55 -0700 (PDT)
Message-ID: <33da1127-f00e-446f-891f-01ccbd53efd6@redhat.com>
Date: Tue, 22 Jul 2025 17:21:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 3/7] mm/filemap: Extend __filemap_get_folio() to
 support NUMA memory policies
To: Shivank Garg <shivankg@amd.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, rppt@kernel.org, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 kent.overstreet@linux.dev, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250713174339.13981-2-shivankg@amd.com>
 <20250713174339.13981-6-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250713174339.13981-6-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.07.25 19:43, Shivank Garg wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Extend __filemap_get_folio() to support NUMA memory policies by
> renaming the implementation to __filemap_get_folio_mpol() and adding
> a mempolicy parameter. The original function becomes a static inline
> wrapper that passes NULL for the mempolicy.
> 
> This infrastructure will enable future support for NUMA-aware page cache
> allocations in guest_memfd memory backend KVM guests.
> 
> Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


