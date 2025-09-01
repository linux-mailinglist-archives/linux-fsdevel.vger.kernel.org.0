Return-Path: <linux-fsdevel+bounces-59860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE3B3E6AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D5A17A4ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01663340D91;
	Mon,  1 Sep 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB+FJE9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5A313E23
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735628; cv=none; b=DRTFjt1x+gwOSdgQ6f57WahilWnooQhkzrk1mxv/Uga8tNJgyni4S3/8srinCCRpBihGS4C4YacTiyeJqySoBYhCjAkaBsHcEj8v3YI1ysvGdNr1hHZB7qkRNHbGDZNfFBTquoKaZsQ1u4tPIoBH3AN9zPaIDRtmDBMIiMeO4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735628; c=relaxed/simple;
	bh=64mPdBUB1VnZC6F7vLaBcxY8HngxXhwwW47VJnp3RAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/fz3QJM6HnFQVFiskeRcqQyTAZYnhnJ8Gk8+8d5DhqvUdEKc7Oi5YT3e+8h/XKoFcYM9LEaX2Yvs4XYF8bdqqLv7JQ/0sY8Is+oVXVr250cxImXzFKCBNhSLY/6jPoBA6+YYwkv6yLPUDha9WgV+jsyliS/5YRXI8VSUDL2F/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UB+FJE9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756735624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b8phEHlSLnRxLufhaprOt2cjL5zUnMPeEi+VixSkVIU=;
	b=UB+FJE9xuXUh/Sfrtd1/cuEmuFuJHNd7OBbBOaCEZESmxIHqy5C7Er170s3ZDyMa5UnAHL
	WFaVFNPnYZMxlzvS8UBBhzNXO3rh+YW+9T8wSzXDLOxZUDR45O8Wtv/4aKUR+paOe+9w5d
	Tsr6MMBKA89NKhbGZ7u9LbEleH06XRs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0BnEt9k_MF-8t8X2YedYYw-1; Mon, 01 Sep 2025 10:07:03 -0400
X-MC-Unique: 0BnEt9k_MF-8t8X2YedYYw-1
X-Mimecast-MFC-AGG-ID: 0BnEt9k_MF-8t8X2YedYYw_1756735622
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b87bc6869so12682025e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 07:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735622; x=1757340422;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8phEHlSLnRxLufhaprOt2cjL5zUnMPeEi+VixSkVIU=;
        b=f0askQuT5v6Vjmh3h63GhI61JIJP8r/Gj2a+SABDEnWk8WME5pXp3iqEvgGJUvD5ig
         6wwZxDt2S0ZqTolwdGPgWi3Bn/dj40P+lROkxMToJSuSPT3z4JMuwJ75FNrY9knmgqt8
         PmCmvaw7DzdSNK+R7GC8i+fuy6qbpUz9HaTuM/c7Eu3XnK0xj5Lz464oEE7yTiN8YrrB
         Npj+GM+kjIMdk2zSGGok77oK5eB998mXffS0fhhenoQtVTTEqNX39sqwcuymWquDoM0w
         9SZ41xHecgXXCEBlIpJHWdW41ENfBzq4dMYhXY8S8yhmsFQQjwyukGXGdv2QSUe5E997
         yapw==
X-Forwarded-Encrypted: i=1; AJvYcCUB7/3Q7Zv1vUqbjPTBqJLWYKdGmkRzMocCp/p9rQnPMlcW4+On9Wny44VWEoFfyuY8tWRnnWk+O1BWJEto@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGWkkmKV7X57H6xJXySodipvcfnsRQE43spEWCQ3U8g6PDx3M
	ag/iipuTVDRFCSJDi8T8oWCeRpr0GOi+SZK+Rrl2S2k8SayNBQZ2vWXs5n7F0+nrX86GjuOHxXS
	I1gMdq/8oTalsclr0BpH92m9Gv+PR+VNrKPK3Z+8fb+iyWhJriBDe42tZJ1qT9uixguw=
X-Gm-Gg: ASbGncv4hOXAegCTFQQ27BBcaz2VSOCQA2eN45c5fTxoZ5FPaovqaseFDk9OmOzBBX+
	Ggbi4FYZmIRMhrmXlgsJgcWrPTS280otrAI7aISs3Tcc/IT2aTwZ8u5DPoCf3KGFDXBk+Gph+Oo
	qGLH7UczKRzP9Bt3uBlLGiJJ5c6YXmoXAn3+mx6ZVlT4Mk1d00e3m+PjcQa+/isrNEWtwgaNpaB
	B1hhEWkAPSAgVT6B+JNRIjAS/PTAqj5hVC/1Q8nb0zdWIPscsRYzU3Sbd7k54pHfY6jJhc9pNI0
	tINSHShSxkLhmlZptg8YUs3+H7hICYVeFv40dEmlT3Oe5ifn35a6+4C4dNNaRuFZvB82PaH3VaJ
	5DcfOfzD254xAb/IZGlvPfe8cx8KzwLJ4UMwIhv+qkhlZRawm3ivYGn1ayAUkdhFtwcw=
X-Received: by 2002:a05:600c:484a:b0:45b:85d0:9a0c with SMTP id 5b1f17b1804b1-45b85d09ccdmr50142865e9.15.1756735622236;
        Mon, 01 Sep 2025 07:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc/fzqFhcyBDKForO8lAi4OllS0y6HGtqOEpvIJOxrpYoc27SWP07i3IDs6oE/SD7LPI4+eg==
X-Received: by 2002:a05:600c:484a:b0:45b:85d0:9a0c with SMTP id 5b1f17b1804b1-45b85d09ccdmr50142575e9.15.1756735621736;
        Mon, 01 Sep 2025 07:07:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d92d51982bsm519348f8f.21.2025.09.01.07.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 07:07:01 -0700 (PDT)
Message-ID: <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
Date: Mon, 1 Sep 2025 16:06:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
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
 <20250901123028.3383461-12-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-12-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> For improved const-correctness.
> 
> We select certain assert and test functions which either invoke each
> other, functions that are already const-ified, or no further
> functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   include/linux/mm.h | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 23864c3519d6..4cca66ba8839 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -703,7 +703,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
>   		mmap_read_unlock(vmf->vma->vm_mm);
>   }
>   
> -static inline void assert_fault_locked(struct vm_fault *vmf)
> +static inline void assert_fault_locked(struct vm_fault *const vmf)
>   {
>   	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
>   		vma_assert_locked(vmf->vma);
> @@ -716,7 +716,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
>   	mmap_read_unlock(vmf->vma->vm_mm);
>   }
>   
> -static inline void assert_fault_locked(struct vm_fault *vmf)
> +static inline void assert_fault_locked(const struct vm_fault *vmf)
>   {

This confused me a bit: in the upper variant it's "*const" and here it's 
"const *".

There are multiple such cases here, which might imply that it is not 
"relatively trivial to const-ify them". :)

Did you miss to convert some of these cases properly, or is there a 
reason for this inconsistency?

-- 
Cheers

David / dhildenb


