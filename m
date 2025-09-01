Return-Path: <linux-fsdevel+bounces-59880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6628AB3EA06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4A94429F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5204A37C0FD;
	Mon,  1 Sep 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHBYzpJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984D33EB01
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739468; cv=none; b=SfJLNYlrnyGV8Gzql+yAleOktkYWBTbHLlcmYhTlcZ5W444VRneSx1078LNjnjbNCs67ff6mxb3xo9udoPC+WzPBiRVx9JDFpvHApO1Ue/MRv6cZXSb6EEyF0CE+mLvrhHHWqAVohoxj5AukuBCDLak64a8MHldwR1aTXCJULPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739468; c=relaxed/simple;
	bh=Ma/UP1lSiVqJNi8TyJQVaTJF/dk/rmw8jKKc9OcTuvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmYY9c8X6ctZubqUGWzmBku8oATf+isKCuJ21UML3dCncc2sTJ2kmu28tD4FeJwYWBiwPyktWpaEZNMT6NQFsjnkB5z92SJYPGlRmxLzQcEbU4lNWXIOEFz6mUt5U+j8xsM0uisv2Jd/osntLfm1HpNFtyGwl4ydDHovbUHoe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHBYzpJh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756739465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VMxdRy5rmNFmudF6fK3kGDCxNJBEq1WURzElFRewt34=;
	b=hHBYzpJhe/5Fy5xlEm2qhQyaFY7U7LZZsL8wzV7k7F7FplZEbBfCXEzf//RX+jzRug9IGz
	46PvB8XQmGmfNd/2ZdsszYrK9vqwrdgzsELR4Ak7kFVAreCcWfkGziiA/JQPYOZspIuggE
	hzmEuNGsd9BE9ub5+j27Im5TZmUmJeQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-qxlYsJjTOHaIuNpSff0Itw-1; Mon, 01 Sep 2025 11:11:04 -0400
X-MC-Unique: qxlYsJjTOHaIuNpSff0Itw-1
X-Mimecast-MFC-AGG-ID: qxlYsJjTOHaIuNpSff0Itw_1756739464
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so36996395e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739464; x=1757344264;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMxdRy5rmNFmudF6fK3kGDCxNJBEq1WURzElFRewt34=;
        b=WXIfVACf214pEfnqaMomjPbOixaGsMfeDGEd6gQe1syLkKpuOH+Fibqj15uAXyVra8
         98JcJXfo+p7+LFVE/HU3JO16+HVABZ0QF2Fa1Q+zcBCl9qSoiUWGowec7CBEAAz2j43z
         WWG4BgE7keS7wTbaR5l7B3/kpfgg8fLbuYAHQVtiYugalJkfnBNRqhD86U3NjlMj5CK/
         3MTrsCDRvA7Xcoq6ohQPsRpcR1i76Z5gdvA3zsoOQzYEEodus1oFCenJeGzyKgQGOaeK
         GkQwsdTi+5tPYfZvfY4R4h/Mwa+xSOyfT5bs65qB7OFFGGRGOUCWLRs2zzPywSavT03b
         /9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNXXOFCXK7B5z9ME0z8x0E0AFf6EJc0hlrmYn65HQCPKu/KPeI0WdYAEMFvUNJONRSbPk07IecSBerHRz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+6j5fE0PNxgjqQWeC/4JPuOydUbahVrjwvGFXo9CSr4WY4F3
	+bXIy65wNZvpchRrDw5chpldTy/yGyTBt6yPbDOdJzu6NC/2CkiJOTy6fZ0TRxr5kBtM/azYBvY
	U9+zFEg0vT+Gonsa+ncWRiPpK8yqKSlFDDsM/4xcIwEz8G2fYDqHnkzp4rqf7k0l6dOQ=
X-Gm-Gg: ASbGnct0DYq1Z7jWNOsWHDKKLh/0UhyaUd8WafXclaJDnT1WhLbSwIZT/X2vS9xx+ja
	tjjQbl2JSXJ1XeClJYfEqyxLpFSvtgxin/3EwjGGwkMM0qaflEo08gy4X7c46aY/PMmB8lwVUeQ
	alkjcHbhu34/pWTLxdn72KJ/UgtRiEYueKdpkov86mqj09fMdgtDs0cZZ7wCa7NX4f+/kgp6yWY
	0xQQV8+Tn2spCvC650xKE6+KLEb1sla9cVO3367UDL7WyyCK80WHvPAd4/+Kgzpmd+pH7L8MAEa
	sA2iZbieHnY2ze+ARZ5YIZKUfCwW4qbJ9mUs326Us0VDTBw6ZhTBtfRJOUsEzNnP7aptCXy3RWe
	eBJhEALjfjYRqBsnOd8ypk8zCzBsxZMcMcXFMu0tKP6bVuBnud9/sMEmdN1QyJn5eLEo=
X-Received: by 2002:a05:600c:3b99:b0:45b:88b1:373f with SMTP id 5b1f17b1804b1-45b88b138cfmr49843555e9.19.1756739463511;
        Mon, 01 Sep 2025 08:11:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf6Rd6PfORW/LyvT41zVzRuA2itBBI/jcr5+K/tI5o0lZ645Xd5UGGPJrfen/4NaJ0FQpwRw==
X-Received: by 2002:a05:600c:3b99:b0:45b:88b1:373f with SMTP id 5b1f17b1804b1-45b88b138cfmr49842935e9.19.1756739462931;
        Mon, 01 Sep 2025 08:11:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab832sm159807805e9.23.2025.09.01.08.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:11:02 -0700 (PDT)
Message-ID: <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
Date: Mon, 1 Sep 2025 17:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com>
 <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 17:02, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 3:54 PM David Hildenbrand <david@redhat.com> wrote:
>>> -int vma_is_stack_for_current(struct vm_area_struct *vma);
>>> +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>>
>> Should this also be *const ?
> 
> No. These are function protoypes. A "const" on a parameter value
> (pointer address, not pointed-to memory) makes no sense on a
> prototype.

But couldn't you argue the same about variable names? In most (not all 
:) ) we keep declaration + definition in sync. So thus my confusion.

-- 
Cheers

David / dhildenb


