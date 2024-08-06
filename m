Return-Path: <linux-fsdevel+bounces-25086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B30948C73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E311F21693
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16F1BE22B;
	Tue,  6 Aug 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad9qQIof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A041BDAA3
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938187; cv=none; b=r5xnZhzo0ffyGmUxu4usqYff/6YTpNGjdDicv5aYKFKQNB04y40ARW1hGjm2IJbzVlx2WVLHdeRi82Zmgqzbv2RxjGzE5Jm8+rinviWHwCehPGobQjGnsaIJiBZpaKmFLMZesVmnrgDM99LkypA3UeTfO6LiHAxRU1inptjtF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938187; c=relaxed/simple;
	bh=Ti7LxTdMM/GAdTYAF9fxDmku8ji0u+DIP+EbRV6ON8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEC560gskid2Vq0nNrJl3AR0gUMpjlp24LzlDPPEGpBsMaz9DpzL4I5OfWUHZjpWxlgAfHHaJGVSuczrpRl7bMA+Je90QjVgdbXBl0XdcJBHF15e/h1A75jN4pOjixZy2qDDDR3ivuZoBM45tFqjsUjqaTVjfFDHU3VOzRjw974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ad9qQIof; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722938184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vBQbeHUtRbShTjPALCR2c7k0HkoMBZRNLSHpsLdcSmo=;
	b=Ad9qQIofW2pyjT7v8NfDmLYj3GmsAZVALw8qEh9QVskolRfs8JoHRA21Moe68/+oSyG65v
	Ii1Y0wmiMM4tYr3RV5xsap+razHgseSGOGPYsC8NiOOql0DVzn4xMQFJkY3YE6m59GJCzJ
	hNluA7qjHiojGUb3Ex8XaOzqczwmc1g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-LrqKW8YKMbqh96Mzkv0ISQ-1; Tue, 06 Aug 2024 05:56:22 -0400
X-MC-Unique: LrqKW8YKMbqh96Mzkv0ISQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42820af1106so3624245e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 02:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938181; x=1723542981;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBQbeHUtRbShTjPALCR2c7k0HkoMBZRNLSHpsLdcSmo=;
        b=SZaCkdwXqsi2n7LqvunwQTKZPv9DKHY/4wnpjwg5hQlFwMtrC6KGfWn94mPvmSc79d
         NSFzrFTazQ1mnb4hKLEPiq3dqSzpDQFUngoedfPHJBEh4ZO9TFZ8w6MJhTG4Khd7x/Bq
         CRoDOwT6ue6zAH5EqbF0RVWCcD/JagQ/0fAU245Bitu0ma9YvRKCWPDD1Jrg20Rw/+go
         RxnVB5nSSXSSOylHTJqyrbU5k8FuOVj7UkEB8UXD3xZjiTU+DQi5Zj+OOUa1b3NKtk1a
         w1YNzc2l7GYmUhN3djgB1EDtrWB3OCT9KNFEQ2jt27z1vN3pMhj+y1xckjniG9nlpAFx
         vQnA==
X-Forwarded-Encrypted: i=1; AJvYcCV9BRAOfpATJwQzc7GDjeKOOp4HUPsKcPXt+ugJreHt7alNHl3+dWQj54UCIpx9sYJ5RMpjeoCZBjTKlkqmPdVakNA3gaRW8SWTMxxWYw==
X-Gm-Message-State: AOJu0YyIlC85QP3xNtiZSeeRX5ibSOfdc3JDCWXAAYzb+p9uSv+2p5ck
	e8ExXz5Wi/LeKnh0c3Y79eCaERHaL91T89LlorIwp52MInbNd8fzm5H1sIc/YtLDgsJC99EeJVi
	+Iu5GLGSDz5ekxmX2NrHUhZiVGAvV3IFX2SFvpXK0eN8hWoRVWJ1N6w7UHzn9xlw=
X-Received: by 2002:a05:600c:4451:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-428e6b090eamr97972345e9.15.1722938181432;
        Tue, 06 Aug 2024 02:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfP5KCXnsTh/UB7wgpJpEYZk3HSm4U8XqukDLtT1XwMJtEIW1gpaFv2fU6boTUbNdjaKb94w==
X-Received: by 2002:a05:600c:4451:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-428e6b090eamr97971975e9.15.1722938180840;
        Tue, 06 Aug 2024 02:56:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0ccc5sm12576894f8f.23.2024.08.06.02.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 02:56:20 -0700 (PDT)
Message-ID: <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
Date: Tue, 6 Aug 2024 11:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
 <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 11:46, Ryan Roberts wrote:
> On 02/08/2024 16:55, David Hildenbrand wrote:
>> Let's remove yet another follow_page() user. Note that we have to do the
>> split without holding the PTL, after folio_walk_end(). We don't care
>> about losing the secretmem check in follow_page().
> 
> Hi David,
> 
> Our (arm64) CI is showing a regression in split_huge_page_test from mm selftests from next-20240805 onwards. Navigating around a couple of other lurking bugs, I was able to bisect to this change (which smells about right).
> 
> Newly failing test:
> 
> # # ------------------------------
> # # running ./split_huge_page_test
> # # ------------------------------
> # # TAP version 13
> # # 1..12
> # # Bail out! Still AnonHugePages not split
> # # # Planned tests != run tests (12 != 0)
> # # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> # # [FAIL]
> # not ok 52 split_huge_page_test # exit=1
> 
> It's trying to split some pmd-mapped THPs then checking and finding that they are not split. The split is requested via /sys/kernel/debug/split_huge_pages, which I believe ends up in this function you are modifying here. Although I'll admit that looking at the change, there is nothing obviously wrong! Any ideas?

Nothing jumps at me as well. Let me fire up the debugger :)

-- 
Cheers,

David / dhildenb


