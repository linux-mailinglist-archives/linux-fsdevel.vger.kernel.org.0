Return-Path: <linux-fsdevel+bounces-42587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE91A4474D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FC57AF030
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3719A28D;
	Tue, 25 Feb 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPCW5Cqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8581991CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502330; cv=none; b=GFsRMUQ8z6Q2Y7+xrOMbAlKX3QviDGVKIMrpy8QB/snRhgPMjGJXO1Q6Irn8v89s9JigHnFsaHBw0JgpSsa6ZWmrN3JIwdN27J8HsfO4rYjNcHqNljohNXvMUu4jgrFM76PiVRazXnhPSymTDpBPomj/1Lent+IZ5Om8TXzwXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502330; c=relaxed/simple;
	bh=WaOTSX/dac2eYQwFP2L+z/TxJ6Ld6Ufuk4bJoVQCwhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw48ZZmQl04qJi8RO4Ej/nT1PJl7hVdrxwSqaKJEEhJnjmI42RqcjdxS6dQKOsDvY8z0h7Kxk75GxxNGv17z5VypXvtb79g3pmll/cp+qhZNx4HMMBBKqMwqv+XOEx0Pdn9mD7sAzB6Ao20OqWA91w+Pjok+nrBKmXnFNQtXguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPCW5Cqq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740502328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bKG3lJ6XGxJL0ANA6UtDs0mGh93vIobyGu7CLp3uIcI=;
	b=WPCW5CqqC/UPlG45J+OwuUrAbXsBqZT+qRKt8cGXMiDO4rTkochfzMj5GIkimNAjpFZ7PY
	l19nl/Nd/vQjXY+GJpzi1M/NL5cJYYXmOaFaUBE7Wb6xJSRzT7Bcqk9wB9H0QJ4RwQG3Sj
	hZqWhpZf4btyOJKrTFxgs7H7fOrABHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-F5HfghoqM-2l0dp1n93gzw-1; Tue, 25 Feb 2025 11:52:06 -0500
X-MC-Unique: F5HfghoqM-2l0dp1n93gzw-1
X-Mimecast-MFC-AGG-ID: F5HfghoqM-2l0dp1n93gzw_1740502325
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399c5ba9e4so32326835e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 08:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502325; x=1741107125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bKG3lJ6XGxJL0ANA6UtDs0mGh93vIobyGu7CLp3uIcI=;
        b=V9zqeE3z7mIeqBl9D+SeHph4rzffI3SxLOp3QgPAcYq9ptt6EpwcKaWeSukBvsrXec
         KCMJ+BDURxYIihIUaSlyb3WdStKy0RuYBpcod98nmikflmCOzDjz5Io8t7RrpgdnDsee
         u+cT6qMzFYwv/0EDI5m2gvw4KOsHZCAPvq9ph6kSD8R8uJN0B1FwfnwmvnhhimKkgMeq
         OegX0ymAKOOdH6fv5IFjskM2wER4Rzc0H1OtLycH8iFx0+9jKnt7dha3M3cXwAWq6a2A
         BDD9D28jgXb4IJBlv9PpOSQZIvGV/jzfiFU2RwHUzzICRxN74BwVa3VrR3/DVGoZBHJN
         jvgA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eiLPS3jCA+uTKELRW9VB5PzX6lNpid4PyLdFwhZ0fjQnbzZNKm2MXjaGCS9mdNoiZr9QhG3YIN/u9OW3@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYLCm7E+2nVxze6HYu535g2bQKwibf6A8XGJeug5M7jZ+xTmg
	Cvqp/K0cOZZUqYHz7fbtz763NSG3s8izDBEM4BLwPzDjDaoHXNC3J/+h5QIiZH4g0ALbxRwg/HT
	58cpskIn6547UScKPJRVCTqaylQE7myHmNA6ZGeeuMcBt4xz0zmQvOoX8PParEqM=
X-Gm-Gg: ASbGncvSsP2lemnmHBxTAAruOEqOAYx3erhe4Kyq7YBGPaCQNw1CJMNRx2YxaFgULMb
	r86AoI39t1Xy4wVLI28fxgbUrsbyBufKb6h1On4vwV0+yy048yiJ/+tQtDo7URuhbvyjtC+WV2u
	S21BZb966SGVZkVqcyqCwD2Kfcqk1yfSjWjwdfl1t/iu1a2JWkjUpNNQbsMmACUGEBHPNhmyEm3
	5fyOGxWj7lEie5eu6mey2s9KIjIPlqCNwOxs6TMezNoE+PwUW0ufka92XlIEzauHSAPNfGXoBS8
	cxAXO9eNK+3Jf6Vu8KP88KH1QAMHEthmMJWREWRENlgFppwZ+/yBs3wlCn2oFIfpuz+PRKL4EW6
	JY4srT8Yp0AKkkw6A0PjiyMNRGCXhiqkHE/XnOixy/Wk=
X-Received: by 2002:a05:600c:35cb:b0:439:942c:c1cd with SMTP id 5b1f17b1804b1-43ab0f41698mr37867595e9.15.1740502325392;
        Tue, 25 Feb 2025 08:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHljYM5LDB+6z8VmxkY/Ka0ybiTSVXRSDwfAnYs6o4Obsa+n4MgVzk0kq9a5L9+j1Zaxe0fDA==
X-Received: by 2002:a05:600c:35cb:b0:439:942c:c1cd with SMTP id 5b1f17b1804b1-43ab0f41698mr37867195e9.15.1740502324957;
        Tue, 25 Feb 2025 08:52:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab153a3f9sm31936415e9.11.2025.02.25.08.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:52:04 -0800 (PST)
Message-ID: <3dc4bb80-0beb-4bbb-bfd8-47fc096f70e9@redhat.com>
Date: Tue, 25 Feb 2025 17:52:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] mm: introduce AS_NO_DIRECT_MAP
To: Patrick Roy <roypat@amazon.co.uk>, rppt@kernel.org, seanjc@google.com
Cc: pbonzini@redhat.com, corbet@lwn.net, willy@infradead.org,
 akpm@linux-foundation.org, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tabba@google.com, jgowans@amazon.com,
 graf@amazon.com, kalyazin@amazon.com, xmarcalx@amazon.com,
 derekmn@amazon.com, jthoughton@google.com
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-2-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250221160728.1584559-2-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 17:07, Patrick Roy wrote:
> Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
> set to not present . Currently, mappings that match this description are
> secretmem mappings (memfd_secret()). Later, some guest_memfd
> configurations will also fall into this category.
> 
> Reject this new type of mappings in all locations that currently reject
> secretmem mappings, on the assumption that if secretmem mappings are
> rejected somewhere, it is precisely because of an inability to deal with
> folios without direct map entries.
> 
> Use a new flag instead of overloading AS_INACCESSIBLE (which is already
> set by guest_memfd) because not all guest_memfd mappings will end up
> being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
> can be mapped to userspace should also be GUP-able, and generally not
> have restrictions on who can access it).
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---

...

>   static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
>   {
>   	return mapping->gfp_mask;
> diff --git a/lib/buildid.c b/lib/buildid.c
> index c4b0f376fb34..80b5d805067f 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -65,8 +65,8 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
>   
>   	freader_put_folio(r);
>   
> -	/* reject secretmem folios created with memfd_secret() */
> -	if (secretmem_mapping(r->file->f_mapping))
> +	/* reject secretmem folios created with memfd_secret() or guest_memfd() */
> +	if (secretmem_mapping(r->file->f_mapping) || mapping_no_direct_map(r->file->f_mapping))
>   		return -EFAULT;

Maybe I'm missing it, but why do we have to special-case secretmem with 
that at all anymore?

Couldn't we just let secretmem set AS_NO_DIRECT_MAP as well, and convert 
all/most secretmem specific stuff to check AS_NO_DIRECT_MAP as well?

-- 
Cheers,

David / dhildenb


