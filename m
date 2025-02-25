Return-Path: <linux-fsdevel+bounces-42588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DFA4470A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DEF188D567
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E319DF7D;
	Tue, 25 Feb 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThED2jY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F9719CD0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502373; cv=none; b=rAZrvf3e1barnrlcfgWP21OUNDhm/LMgpVk37hK6I7MFGaIK9hiijlwQsLE2jnat4eRWvZqe1dcH9JeavOP4AFCe/rXJZYjiHISBitM15aX9ko5NN9BVWDgMwvnyeRwlLoEeBlPhTFTlg+klMSw9n/mArm6FAVugoo4wOhWPsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502373; c=relaxed/simple;
	bh=C+tFZN9mWiR7ZHbPkAa5+JvBoxMYFnFbyHOCCfPiQTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQw78gbOXQEZUvNZgbzujRsiGafxAKZS5i7GO51mRCBpzHG95MNO7la7nOpMZ0eYWGcCOVQvtQJQwaL8EwEqQrTAH3ITLDMT08oF5PaM2QMlx06yFOdVvjruWS801o6LblJpVdTsqkyLixEnDR2dp07ahTT06QoVOdPgqqu7d7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThED2jY7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740502371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ybxboWusnqyTjKvs03gdfQgRYiuSjJraiMkFJv9TEnw=;
	b=ThED2jY7JlBBfm2lTZmRHZoeUIAzn8xbMdgMLUyaGZLNUO1HaniGhUN3DFC9EAZzkYoeUW
	vvsdaU8mzkvl/urf++VV3pddEu3fRPkomSsoxumAjLyp5PJR6sxlV+DXgcmW8FHmVMWQoz
	xFpEMkpRGquLNoZFlfls4jNEpYu6aDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-GsTl7OoMOwC6LysIxdaHpw-1; Tue, 25 Feb 2025 11:52:49 -0500
X-MC-Unique: GsTl7OoMOwC6LysIxdaHpw-1
X-Mimecast-MFC-AGG-ID: GsTl7OoMOwC6LysIxdaHpw_1740502367
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f455a8e43so2238990f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 08:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502367; x=1741107167;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybxboWusnqyTjKvs03gdfQgRYiuSjJraiMkFJv9TEnw=;
        b=u+p3vP+s+xTemLXLbr3YRdgzw6CfrU1Sj4uMspDx3ktyVvyroSdUekNZsdzkiQEdvd
         4wjD6joqsvLSJIqqB3adszHt74lhbJsjadJQ8CvCgGXm72Qj8fAoXavak9lrGcgvAZGG
         pMdLk1/XkQ+TZIT7o+UXev/4gppXFZWSEd3xHOZ3vBzUp3dJbRcv3LEWb+up5dkJBVO5
         5JbR0p0FyAyjiXnDEkNXPMzZUsVGpd0uNAyiu3a54s8YxlVurotUy7HTvqajAFHGYR6p
         mM3jMyLFNN3CNm8no05dvDchbkPYmETdEf1JgTq4g8VPRqB26+efO2ktp6Ho+9pJ60mG
         r4NA==
X-Forwarded-Encrypted: i=1; AJvYcCX3iwSga47AIqDDP6N51P4qFWWncYuTwtDMKvrhONJUNL6uXoOkX9LuOIBhBLyeRPxm7AgdzewDkqLNjDrg@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6/6n94mxCoXDHBGMDKwrki9zEdRoZdu0BC3dAyPjvFqPLCF6
	oyPlgeE74iN2eYC0y7HkQdO16saPQAaZHAzsz/7GOVRbuZupm5iL+3A60DxT7uaELrxlLoxoT/q
	KAN5BfcHurbwlx67TBTLSWzMEH4mekkwb8F7XadMrXhD89GL357jYFZ2436t7Di0=
X-Gm-Gg: ASbGncvv3UC5ep6taaO4gCWIubAxefpilRbiYi6Dcon7EEf4BeJhUdOuLhjva6smrfP
	Xwl2X/bnADhyyd6ZN8f4YC2uO8XSqyteqT03jSp43A5mWOo6uKVT7eTu8akvArJLSw+yumh9b93
	iVOsp6UGrxx0QpLEIFGcUNZ/utSpbovxdWVBgWxAvkUqTbeRptf9Lf7y6Og0u6ILUElNqD6wsLg
	R99AwA7AlUUbfF+pE1+avi9ZpnDMAWZmTI4IqVXlaE3zwCqAwLyglpfvjchUlB2MtZbB/ek1y/C
	dNxbZy5R5ai/XMoOxpaYs8jICyiQ7lzr+PJEPplfBPUsBNMk7e018jo4hhP3VaaRNIdVr/XDqbw
	KqOYsfKh0zRu5ZbpIOlD1c05mMRlMrBNH5gta3JiM7qc=
X-Received: by 2002:a05:6000:1a8a:b0:38d:d0ca:fbd5 with SMTP id ffacd0b85a97d-390cc605518mr3098307f8f.22.1740502366849;
        Tue, 25 Feb 2025 08:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkp5nTxzC3mH+QfPQ2OcYNGz6wgylsGdXkNqE7sPvdo2LKF2uZNL9mmhTxt1LgwuC8gCNgdw==
X-Received: by 2002:a05:6000:1a8a:b0:38d:d0ca:fbd5 with SMTP id ffacd0b85a97d-390cc605518mr3098250f8f.22.1740502366450;
        Tue, 25 Feb 2025 08:52:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866ec7sm2868347f8f.3.2025.02.25.08.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:52:45 -0800 (PST)
Message-ID: <d686092d-bc86-4a65-b580-04f0e42e96dc@redhat.com>
Date: Tue, 25 Feb 2025 17:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] mm/secretmem: set AS_NO_DIRECT_MAP instead of
 special-casing
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
 <20250221160728.1584559-3-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250221160728.1584559-3-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 17:07, Patrick Roy wrote:
> Make secretmem set AS_NO_DIRECT_MAP on its struct address_space, to drop
> all the vma_is_secretmem()/secretmem_mapping() checks that are based on
> checking explicitly for the secretmem ops structures.
> 
> This drops a optimization in gup_fast_folio_allowed() where
> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
> by default"), so the secretmem check did not actually end up elided in
> most cases anymore anyway.
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---

Ah, there it is. Can both patches somehow be squashed?

-- 
Cheers,

David / dhildenb


