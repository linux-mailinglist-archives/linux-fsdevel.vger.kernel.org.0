Return-Path: <linux-fsdevel+bounces-56733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33FB1B21A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312237AC039
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233F23ABA7;
	Tue,  5 Aug 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3EQ0HsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D11F4612
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390198; cv=none; b=aKUjbZN9FshjglqUTI8UtWC0JkrHqto2aqXs0ZOkeNzsnAqJ+NMQXjCoE6GSvBGetIXyuPC687jeoNEGma9GB+R7fB1JwyatetfM2lJ7AeGr19QvuJvvyCakLGOyeZ2kAoSeLDPmDk425JKBISPK9OVCZaGminzvTtC4B98zT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390198; c=relaxed/simple;
	bh=Cnxh6DN3ni8Y+KmkTa/tBdiSQ9JUY6wzfuiufw/04MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8B4mIURzz5YywzcHvAOk0d4bKkXZr4EW7/vwzzRU00twUgRNJbusabpBFbxc2YisruBabFI5eZrLBLaVIxeTgVS7ut+tEk4kH3Jz1VzRTApaFfn3zNFMwXYR8XA62fJKRh91V1uTlvTnYg9FwP+b6D+ncsjXSjM/KINBkiFIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3EQ0HsV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754390195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Wl4ZijE/HHMB43Fi7BAYKpOKxsawoOhIpbaL37luJFI=;
	b=W3EQ0HsVdh5KXrjZgAEQowiq2XjJQjNHX62mSDlHRQUVCzOEyw8zFcRMwDqaWyL2P/XIkv
	pU7WM8SYIgE/D95ixNUU5qWV660FxPYPfhIOHvr2cLwJFJHHKlJ/MvTNaoEpaLnALdrSuQ
	hH8vPx98y2BBE83xA6whbfv/doD/l2Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-eOVWvENXOIeNVn56lWXEiA-1; Tue, 05 Aug 2025 06:36:33 -0400
X-MC-Unique: eOVWvENXOIeNVn56lWXEiA-1
X-Mimecast-MFC-AGG-ID: eOVWvENXOIeNVn56lWXEiA_1754390193
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b78329f007so4752114f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 03:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390192; x=1754994992;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wl4ZijE/HHMB43Fi7BAYKpOKxsawoOhIpbaL37luJFI=;
        b=HM4ARZuq2q5SyQirBE8BHieaAYUMfXhJy1vLYb64ST4CYyU9HMcdacUOuHUh5f75Hp
         5szb4a71ulhuuYu9YepXGc7PnBFZwlkZUXhk94Bs4MgI83H33oQuDBmFFt3wHtmz7E8r
         EHpyTFpG2jCiInb4np3DzcOe5LpR5hkfqoU6cvvfw5A4/2Y+bwuy28UosAHWQ1sBFlrG
         RR3KE4u7j9LdzqgV8yL7/KEpbuyng3DgebMDy7qj2Z0y08jUTrmxK4mhnmU9oIkQT4MH
         sH+gzH8wj32QaG2d2zihUfKWuLKjolAlIFiufYzORV0Z2aGC7tvo7JKQ69rt4TcOoZ8G
         afGg==
X-Gm-Message-State: AOJu0YytyAkUuhaBJn0CxZGIme/RenfwyIBdoeAplQ3xTkEra5SBKNiD
	jj5eiR7DZ15cnK65Az4JViVcSxbKgv/RznHWIsT5SG0Fg8xWd9FdpbZ7trmViyXFvQKXCHyNyWa
	tFSZDjSw1oYkItrs74AKDL9mbqJXeKzUAkQuKzm0rVA0j0qRFYhj1pOkKeDAOo4bniFYgssDG6D
	s=
X-Gm-Gg: ASbGncux/YFCJSm84NowAQs6LGl+2lTboRKzKrJyJBp6IGxZ0AY5pKgpEn3uAlpUO25
	PJk7wgLX4Ji0wE1RjPHRHh0hQk2L6XWJctSG6wzvf2dWqmzQ7UPUc3fBlkHBER+wDA27eVr/esh
	c1TJmbld+CyAzxsFVrXtIcYKyheHKN/p9GQPt6WBZPvlYqUk0EczgWBxpMzznpzINackrDIJzlS
	KBOUmsS40M4StPwI/6CqVSWgnS/L+DYBaBEiqZfoPELKxLHjyV9evtpJ89MLZcTAi2yN2GXRHHc
	VF3C2v+S7PMXHQfl7xih4gqzubpSdGMTCxdk3OVO3OJ9SQf2Ueqjs2CYPDPkj7CsTAPML0ad/hQ
	hozhLq4YpkNPlrvvJqrP6gzRatwsrHtC8dh5tk9NCg87EzC4b0DH6npkLUix8yP50i/4=
X-Received: by 2002:a05:6000:4305:b0:3b7:89a2:bb8c with SMTP id ffacd0b85a97d-3b8d9474e63mr8616388f8f.16.1754390192594;
        Tue, 05 Aug 2025 03:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAOnGMnGXyh1ND7MnUFCBNlWbq0W6kMApMwVAYJuatGTqk1QunVq1YA2SrRT1HUU1vGbKqVw==
X-Received: by 2002:a05:6000:4305:b0:3b7:89a2:bb8c with SMTP id ffacd0b85a97d-3b8d9474e63mr8616359f8f.16.1754390192127;
        Tue, 05 Aug 2025 03:36:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ad803sm18564762f8f.6.2025.08.05.03.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 03:36:31 -0700 (PDT)
Message-ID: <9bcb1dee-314e-4366-9bad-88a47d516c79@redhat.com>
Date: Tue, 5 Aug 2025 12:36:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-7-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804154317.1648084-7-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 17:40, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown)
> 
> This tests if the process can:
> - successfully set and get the policy to disable THPs expect for madvise.
> - get hugepages only on MADV_HUGE and MADV_COLLAPSE if the global policy
>    is madvise/always and only with MADV_COLLAPSE if the global policy is
>    never.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>    - MADV_COLLAPSE when policy is set to never.
>    - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>    - always when policy is set to "always".
> - repeat the above tests in a forked process to make sure  the policy is
>    carried across forks.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---

[...]

> +FIXTURE_VARIANT(prctl_thp_disable_except_madvise)
> +{
> +	enum thp_enabled thp_policy;
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, never)
> +{
> +	.thp_policy = THP_NEVER,
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, madvise)
> +{
> +	.thp_policy = THP_MADVISE,
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_except_madvise, always)
> +{
> +	.thp_policy = THP_ALWAYS,
> +};
> +
> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
> +{
> +	if (!thp_available())
> +		SKIP(return, "Transparent Hugepages not available\n");
> +
> +	self->pmdsize = read_pmd_pagesize();
> +	if (!self->pmdsize)
> +		SKIP(return, "Unable to read PMD size\n");

Should we test here if the kernel knows PR_THP_DISABLE_EXCEPT_ADVISED, 
and if not, skip?

Might be as simple as trying issuing two prctl, and making sure the 
first disabling attempt doesn't fail. If so, SKIP.

Nothing else jumped at me. Can you include a test run result in the 
patch description?

-- 
Cheers,

David / dhildenb


