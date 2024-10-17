Return-Path: <linux-fsdevel+bounces-32178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321099A1E12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDB6284E9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5CA1D89FE;
	Thu, 17 Oct 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHQA2ouc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489F5CB8
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156723; cv=none; b=BbMy1jfW6rPqA7NgxlPjYvezOyPQ1vBgjBlWVaE+5WmjUjv5INTedPEhaoHpsX2TBjTRfHlBJP5+PFO8VM68/SLLo4bxExkk1kBzZ6Og2P8jM3K442x2yimeDTSpbdEPw2Mf1NEaRJDbUo3SiaBw5drE8oLrCnp7EUNZDG+G9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156723; c=relaxed/simple;
	bh=2qF1ldFWsqVFSPNYs5VBBdhYqwIvTUw95INW5GBXTYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8PBhon9PJRq9B+l8YzmchecHnhQzfKLoCLKh8mhgOkgS3mUiy3D7//CfJ0W5kA14K0h9TJfueggYqaNM6ZevgrDQUUxzCUxXFgYWaWSFYOSd0Yxu/iUrfpcsGvKjWneIr9/KkLO7fOEx/3qrlo3IBAq5/7OfCWRZ1reP72CQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHQA2ouc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729156718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1cq4VAwbJYsp5619a/bS6cywsteQlYzK3685TSvl+Ec=;
	b=RHQA2oucrIn5LHctRQj3BqyZGtQI9WFsyam3ypT9bqDqJK7SXaZJMuWEmigD677dP+zwD5
	fwWBg35fNfrLhP380Of824MlQArwLFUpWjOxDCYv169eOsnzRYQwLGwD3E7BGNStNSLxAd
	+ssV6OYnCgzJ2Kib8eT6HPwFsJJsXXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-yzaaNNtfOACQ6hKTls_jXg-1; Thu, 17 Oct 2024 05:18:37 -0400
X-MC-Unique: yzaaNNtfOACQ6hKTls_jXg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43152cd2843so5543605e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 02:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156716; x=1729761516;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1cq4VAwbJYsp5619a/bS6cywsteQlYzK3685TSvl+Ec=;
        b=ucctVczDtPkZr0uAie1H82JZa/DxgKjHMdhFqRV0wFxB+BEyBDkwlJMiRTB8LikVmJ
         ivnjFivxLACxsSSyih0LIodksjP8ecg2UYwgxY2EOHzYvhj0+o7Pb6sibHxNu+TrO5nd
         6UMNKMA/Ncw/dsRf4KHvy4e/27zL8HpfKJyt+y2LCZDmwVQsx6qAyn7VqnTxi9daZnzB
         r1aRCXFR9bMC1HhQ+v/P/MSW5l4PdA/1aFwePEdCXOpDrXs648RZuA1mEzmvGJ4yMfo2
         MLp7Tth7CA6Wg77pkKeWvWmNzRr85T6mMG8EDQDoi2NnGjRy5Edl/maCctNZy4JIBQLC
         ZFug==
X-Forwarded-Encrypted: i=1; AJvYcCVtVB5AWdWZehp8z7Xb1FWjfj9NexbzLsmwJ9mpPLWbU65gilCArRy+HjHJ7g7NG4UXVy4EeMBJ3x/Yukm6@vger.kernel.org
X-Gm-Message-State: AOJu0YxTm0zkMrn59V1fsQRTq2KEOkyEI2PRGnffMyky2YAMsijeNOuX
	6Gmoxw+tzjV8Hqu1/knoWGpj7e0mnfc/TiiG3t/BRRvF7PMRqhAQFELTQ4yGZFnRfFZtJI3V0/a
	JX067zPJsKs+sME+1mjB4XZfUR7zCeSZgOY8kj3oi+O1yDAOeeKpz3p0NKq+0efk=
X-Received: by 2002:a05:600c:1ca4:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-4311df42ce5mr207075035e9.24.1729156716273;
        Thu, 17 Oct 2024 02:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyvskbYB3iLHdqhTBMWr6OcacaJ+LM+/c1icuN9n7aep9ir4TKAlvTHBqa3EZchJOUTDfyFw==
X-Received: by 2002:a05:600c:1ca4:b0:42c:b63e:fe91 with SMTP id 5b1f17b1804b1-4311df42ce5mr207074835e9.24.1729156715832;
        Thu, 17 Oct 2024 02:18:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c406a8sm19604475e9.28.2024.10.17.02.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 02:18:35 -0700 (PDT)
Message-ID: <a1501f7a-80b3-4623-ab7b-5f5e0c3f7008@redhat.com>
Date: Thu, 17 Oct 2024 11:18:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rppt@kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev, Yi Lai <yi1.lai@intel.com>
References: <20241016221629.1043883-1-andrii@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241016221629.1043883-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.24 00:16, Andrii Nakryiko wrote:
>  From memfd_secret(2) manpage:
> 
>    The memory areas backing the file created with memfd_secret(2) are
>    visible only to the processes that have access to the file descriptor.
>    The memory region is removed from the kernel page tables and only the
>    page tables of the processes holding the file descriptor map the
>    corresponding physical memory. (Thus, the pages in the region can't be
>    accessed by the kernel itself, so that, for example, pointers to the
>    region can't be passed to system calls.)
> 
> So folios backed by such secretmem files are not mapped into kernel
> address space and shouldn't be accessed, in general.
> 
> To make this a bit more generic of a fix and prevent regression in the
> future for similar special mappings, do a generic check of whether the
> folio we got is mapped with kernel_page_present(), as suggested in [1].
> This will handle secretmem, and any future special cases that use
> a similar approach.
> 
> Original report and repro can be found in [0].
> 
>    [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
>    [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com/
> 
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   lib/buildid.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 290641d92ac1..90df64fd64c1 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -5,6 +5,7 @@
>   #include <linux/elf.h>
>   #include <linux/kernel.h>
>   #include <linux/pagemap.h>
> +#include <linux/set_memory.h>
>   
>   #define BUILD_ID 3
>   
> @@ -74,7 +75,9 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
>   		filemap_invalidate_unlock_shared(r->file->f_mapping);
>   	}
>   
> -	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
> +	if (IS_ERR(r->folio) ||
> +	    !kernel_page_present(&r->folio->page) ||
> +	    !folio_test_uptodate(r->folio)) {
>   		if (!IS_ERR(r->folio))
>   			folio_put(r->folio);
>   		r->folio = NULL;

As replied elsewhere, can't we take a look at the mapping?

We do the same thing in gup_fast_folio_allowed() where we check 
secretmem_mapping().


-- 
Cheers,

David / dhildenb


