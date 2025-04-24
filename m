Return-Path: <linux-fsdevel+bounces-47303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53B9A9B9E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC76446025
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D01F8BA6;
	Thu, 24 Apr 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUFDzfnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3D2701AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530243; cv=none; b=G5Ft2EkEY/8TUIsuYMcbiL7W87WE3S5SrFtgKTcWdoVZBWGiSWaVKvcECPcvZBkcAiLITL4SRea+MIyHESvHE/qm+4HvTzE2xQUNJMgddvcD98MZ81dEd0SaVui06GTp1b0OY4iaWQ1B/DAYgX/WDqdyFu2cPQMc5/sVp+C7I3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530243; c=relaxed/simple;
	bh=w32nwEDCkygY3ZfKWVxe6EUsop97yeA9rvgWBEdbpYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1tlXlIWqm882jKemP2ZjuDtb0Kcu2QFW4NJ+Um8VFzeCOlnxqqYCpj3XFnb3AXoPxgVSMRFJs7+hcMf1Fc7aDvAsFISvT+bzbno95fPTA72HiimR50djD5N7Ab9oJsFqVkUfd+1SgH3CP1rEY4zX5UM4MPsbUud8JWynfBuHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUFDzfnq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745530240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=En/U4xCVC8IUrkhb8YvvUXRlBXUdP84iSGUw9FOJF+0=;
	b=SUFDzfnqZpqudeO4TZYxaQq4pT0HLRmmblTf7vcLQvyhrDjuZ3/vierxd7raKNuiBYsuZ0
	TE2vEQ8GDntacwxMUCaUrEOwyU4yMLwDwSJi5oLIO5JQLZXBTj+Xc7JE09tfUXrRGFt2Sy
	YvptfSySHg5eNmkblbSFQYZVU4IJSDQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-e2iw0pZLOqKmvgA_HVvKUg-1; Thu, 24 Apr 2025 17:30:39 -0400
X-MC-Unique: e2iw0pZLOqKmvgA_HVvKUg-1
X-Mimecast-MFC-AGG-ID: e2iw0pZLOqKmvgA_HVvKUg_1745530238
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so7836855e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 14:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745530238; x=1746135038;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=En/U4xCVC8IUrkhb8YvvUXRlBXUdP84iSGUw9FOJF+0=;
        b=k5Ufj2iePODeqIgv04XJfHUXv9k+Q5UJHnxN76brpkgNCavUTijpKVlUIy7mHb8ovw
         NS3v3RHCMNouJ+AwiO2hl5yk+okSr+ivaMfe0JE3FwYC6ja0bgGqhytjB+gRVmOSSViD
         uOGlGdI5M6WziZV3Hhs6xhigcyxd5SmajZPshSReGNZReIA2LbpPvoCOH4PcQ2Yws310
         jVsss/dJ4tk9TwLSN58DhU7JXEZN2hZQ8ag1kZ5cGrWn2j5SqfUElOYC6Rg5kRO6G+pS
         BFsfRkTQn3C19CVTGXMpt44kL6hU7fk2lG7cjdtSDwNT1/KRHrT5KpUCA8RTBywiPnhC
         yz3g==
X-Forwarded-Encrypted: i=1; AJvYcCVIXFwHWjcdFwwZ6bpEuD7shyXmd9GYearHAU1amj434Up/+6tN008Qg6Z+0p+RohD53Fe+RXqA3qD4UZ6m@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFmhsDxaZkndPg5Rj2m+HDobX1ByRx3673UHwIIYaLshy732h
	uiZKM2UPvxlyqbCUrlutytsfeTFLVaz5fy0MbQXN29/SnSuO9JMIzUMl8kgjmanMJ7d0a+mAxbG
	e8bIKIrXc8Di1r93v2qeJ6Y71SyNNdgxkK6n2J73h0CnkTOk0nirw8QlQ4wrzt2g=
X-Gm-Gg: ASbGncuGNc5ztT22q40wUtT6Oytmrfs97CCYh8/I0BFAaLa0VwNpaqm0KpYD6RMjY1B
	meb1iqahjFEzc6xpoQLQZUZGNw43svlHeTPH29i6L+bPK+uUwhnlwH6IRfo97uptXH+YWU+Ji7H
	nuCMIAykLT4W0Slfl/O60SQI+p6JOP9v7pq7qWiCRjStTMIxtdXcvXwnOPyRUycbBiRr/axFDNn
	cldLZVhj9CDWYNibBFwaUkNmxn18D1QluFozpERcOXCPkUKoV1BDeYjJgtLmI09EcCT7wUC3cZA
	aceA0HfV2PaLK0ihNmxdaoznbw/Flg0U+P3mbqKzxltAyE1TuPDLd7ofuZXeODNZjry2LzUu/Ij
	xtRMDyT3QhnfKjrbzDda9lCYa8Ln8IS4F7C0X
X-Received: by 2002:a05:600c:1e26:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-440a31c1ae2mr9178285e9.31.1745530237993;
        Thu, 24 Apr 2025 14:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuXN9ITnOPJC6jMWD4dUoy8kuFZLZbLSas71gn7Ljm6pHV/cKMAY4dZqvUxw+u3Iw/i44OrA==
X-Received: by 2002:a05:600c:1e26:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-440a31c1ae2mr9178125e9.31.1745530237641;
        Thu, 24 Apr 2025 14:30:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:ff00:f734:227:6936:cdab? (p200300cbc74eff00f73402276936cdab.dip0.t-ipconnect.de. [2003:cb:c74e:ff00:f734:227:6936:cdab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5394bfasm2013205e9.40.2025.04.24.14.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 14:30:36 -0700 (PDT)
Message-ID: <57e543a2-4c5a-445e-a3ab-affbea337d93@redhat.com>
Date: Thu, 24 Apr 2025 23:30:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: abstract initial stack setup to mm subsystem
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <e7b4c979ec056ddc3a8ef909d41cc45148d1056f.1745528282.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e7b4c979ec056ddc3a8ef909d41cc45148d1056f.1745528282.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.25 23:15, Lorenzo Stoakes wrote:
> There are peculiarities within the kernel where what is very clearly mm
> code is performed elsewhere arbitrarily.
> 
> This violates separation of concerns and makes it harder to refactor code
> to make changes to how fundamental initialisation and operation of mm logic
> is performed.
> 
> One such case is the creation of the VMA containing the initial stack upon
> execve()'ing a new process. This is currently performed in __bprm_mm_init()
> in fs/exec.c.
> 
> Abstract this operation to create_init_stack_vma(). This allows us to limit
> use of vma allocation and free code to fork and mm only.
> 
> We previously did the same for the step at which we relocate the initial
> stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> establishment too.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
...

> +/*
> + * Establish the stack VMA in an execve'd process, located temporarily at the
> + * maximum stack address provided by the architecture.
> + *
> + * We later relocate this downwards in relocate_vma_down().
> + *
> + * This function is almost certainly NOT what you want for anything other than
> + * early executable initialisation.
> + *
> + * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
> + * maximum addressable location in the stack (that is capable of storing a
> + * system word of data).
> + *
> + * on failure, returns an error code.
> + */

I was about to say, if you already write that much documentation, why 
not turn it into kerneldoc? :) But this function is clearly not intended 
to have more than one caller, so ... :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


