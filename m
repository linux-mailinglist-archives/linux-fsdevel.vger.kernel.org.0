Return-Path: <linux-fsdevel+bounces-55141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD8DB073CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3891E4E55BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CC2F2C4C;
	Wed, 16 Jul 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cG4PqXW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7392BF017
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662671; cv=none; b=bc4D6ZyTJnWPo13nK6+mcbC6Myjqo1xJ/sP1g4CjPVjPCz6SOOYY3JMGNXqasIcZpUHSbnjA/YObrhsThSda8QeULibIMkfPlHrIXOo20INlhu6SaAAkvcimIg51AeYJOyswRflOB4bgFwO2YOWP+5lSCZfFFOv/jjo882LZods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662671; c=relaxed/simple;
	bh=BM2RWK92PKISCA1wSUFtzN01XGb8/Ifi8vvkpRHlV08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiHeMiaqTQ0/wLSmv7h/CYBoBQc+CYma7p7RrMuH7yCl94WrQFvi/L64P4J0u+0ZxQu+HvBQNP4bDX9EKnO4I+V5uaEyKEcnhFRiy+0Iw6g9FjG759HxDewOl1e7pNENoToVJoOSDCeJ1TkrgRkax6eXR3RgEtTChb17fA11f7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cG4PqXW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752662668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H0DrpHFYox10/T2b5Nsf8Ll/oRGOI12jubzByP7raXI=;
	b=cG4PqXW2SyF04gfzz0+6cbszuJZxchjTbE0+N0/oYTDB2LoKbtlFs0p0QzuSzNAXTGP56c
	ndcEDauNFaY6ZbDIaZhZIn7o0xW9jo8mbm95qDfeT5cVxCdmeXT8b4yzvDcPtDbgLnagR2
	qQf0YRTVK4ZbcSMkrT5WEwMLMhIsEng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-19yINuiiPBOc8cFhRRdlmA-1; Wed, 16 Jul 2025 06:44:27 -0400
X-MC-Unique: 19yINuiiPBOc8cFhRRdlmA-1
X-Mimecast-MFC-AGG-ID: 19yINuiiPBOc8cFhRRdlmA_1752662666
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso15499205e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662666; x=1753267466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H0DrpHFYox10/T2b5Nsf8Ll/oRGOI12jubzByP7raXI=;
        b=vg1ymtAAfaH+u03UjuE77r4pFMw5HGZLzGJFkd1rF0vH5YPKz6KXlKM30Jom8ZZdl/
         4x60T3kZ5wwtbcN3npPV0aqsKjpHwcchQELGQJAajFJR44JYCV7B9RoUws4MnRVjhhSH
         LtY6p58FUwtwOzxbpi7ZxO1hZwgl8BFcqOB5iNBFhSiq8b9yLsLbfFpePF/o9Q/OBTEr
         L22Kfk3LmAS8BMJv/rcMRPBokTzBtda3rCB9Fbc3ttnhO0QPsyr/4EDVFSWt6JIkzUZQ
         a3wi8noTu0YqqwYZy9Kja7Wmmfx1ce3c6VzLDRPc6qYacLV5ih6dXc0Y4hz06DDG9zJr
         Qzcw==
X-Forwarded-Encrypted: i=1; AJvYcCUUnDKbkQOiZiEFffvmbSG4+m3WR88vGwTMuFBluHq1yhbxKqMp7w7juYC57vvRO2z6OKvuubgxEf4btLRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwvacUiz/qJQcNN7yoGuJK/nhv7ccXc+zXeSbxwtEN5aiNI52vr
	EDbkvi1jvBPT3KwN6qSZL3NlQq/k72ZX0I1qy4Pvqw9HNeWB2hRnfwopC2HKRAGKWJyDsbQivoo
	+OPUsI3BvSrYirSXU8PCwqiSPkuxI37DgIPYMV6YBLpi3X74nK2/ntMe4eicsMvCeGvo=
X-Gm-Gg: ASbGncvJeL8S2yciggmPY/UGz5UtXcxOz7KIvDP39QDJe2X1P+FR21Vg/jHhXYlSK99
	d0Q472Sexd3U0Qgjzz0KX8Vir518MySIShuqtmmWsG0v1IlyAenBendNkxgjLLlt1l4E3lyHpwm
	XNdl0jpX5P+oARGDKbVrSBIrs09y++SuE+v8EAfQWoBBQxS48Ndg3RNeyB0N5hiudxmqhEO4UiW
	3NGPEP6bWS2jS/vw2mxoOnl5R2sVI/OyBVTu9JFgneesQWH7m0z/Abi+FlRd0pdzfePvc6osrHh
	crBXrs2FHlq5CYLBLPOsgoyHE8GOe5aMdlmzByKwpJSN67seaAvv7OyFNifrOk47ohFMtHRWmUf
	O3YEOTV2AL3Qu1AH/fk96H/hI3HXv/bK8hu7WBiUsxkwRA8QLlnfMf7X72lnQ0HIToVk=
X-Received: by 2002:a05:6000:3cb:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b60e5246a5mr1354318f8f.49.1752662666358;
        Wed, 16 Jul 2025 03:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWua8wVVW9bKulQ0ObMl//Eo2vwfpPgEkZ+TqYQycNsZHWW4bjQYPv7qQsGur2N+pi10FAMQ==
X-Received: by 2002:a05:6000:3cb:b0:3a4:e629:6504 with SMTP id ffacd0b85a97d-3b60e5246a5mr1354275f8f.49.1752662665920;
        Wed, 16 Jul 2025 03:44:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562eb63551sm16517585e9.24.2025.07.16.03.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:44:25 -0700 (PDT)
Message-ID: <f041e611-9d28-4a30-8515-97080f742360@redhat.com>
Date: Wed, 16 Jul 2025 12:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] selftests/proc: add /proc/pid/maps tearing from
 vma split test
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-2-surenb@google.com>
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
In-Reply-To: <20250716030557.1547501-2-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 05:05, Suren Baghdasaryan wrote:
> The /proc/pid/maps file is generated page by page, with the mmap_lock
> released between pages.  This can lead to inconsistent reads if the
> underlying vmas are concurrently modified. For instance, if a vma split
> or merge occurs at a page boundary while /proc/pid/maps is being read,
> the same vma might be seen twice: once before and once after the change.
> This duplication is considered acceptable for userspace handling.
> However, observing a "hole" where a vma should be (e.g., due to a vma
> being replaced and the space temporarily being empty) is unacceptable.
> 
> Implement a test that:
> 1. Forks a child process which continuously modifies its address space,
> specifically targeting a vma at the boundary between two pages.
> 2. The parent process repeatedly reads the child's /proc/pid/maps.
> 3. The parent process checks the last vma of the first page and
> the first vma of the second page for consistency, looking for the
> effects of vma splits or merges.
> 
> The test duration is configurable via the -d command-line parameter
> in seconds to increase the likelihood of catching the race condition.
> The default test duration is 5 seconds.
> 
> Example Command: proc-maps-race -d 10
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Why is this selftest not making use of any kselftest framework?

I'm sure there is a very good reason :)

Reading assert() feels very weird compared to other selftests.

-- 
Cheers,

David / dhildenb


