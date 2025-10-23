Return-Path: <linux-fsdevel+bounces-65299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C38CC00A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB14FAEE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814D30C359;
	Thu, 23 Oct 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0jg3bgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF324254AF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217861; cv=none; b=sWk3XBlRYLIeTi9XKEAh2fHO8moVLIE2TuIZRqTZRs38LkippZjBM+0LXhkr4vnxpQVujaZeFJuVHQWeuMrQvO0xbXHCPuVslSv5ysGHEUyl1X/UMp3rrwMVtNEZAosxIeZuK6x/el86ESqEtwCzD+xKH/awCQ+GkrifThP4wRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217861; c=relaxed/simple;
	bh=/O5xOsJInia0hkjcp0azPNTwJpWoqt9stgzQDjYXcI4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDRh+i+FBQw3UmmSNobgrD7+WXee+Krf99zq4ZInwwt7t0evsQcvJYloGxZZ1IQjjELd5tw6Vfg2zptiKywnYZEO5KTUaZggAzl3+ge4C2Am80zzJF/Vlw+CMGpYw1RxOmyM50SxDuyJAHB9VAMY88wOV1+Cm5PRdeIkkNl6DgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0jg3bgH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l2IWmYgTn+axyHlrNGOBe1eg6QF+Mro5+LjrFCWT2pI=;
	b=A0jg3bgHs7yAdsKJ8TDbhWrWMyiWm6kMao8xvtlKp2B+AWILkE4ud2Ky+Jhi2KBcy3LLbA
	4ued469gO2TNPvDoydG9UEKgCiY0g1G0P8hE8OMtyDnGI+8h8j2clGczy89JpQi5nJKWnf
	LcinJoiJxsbubnDUZlB0afKrzuprFIk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-cZxfrhaRNJSQYPBWh25bbg-1; Thu, 23 Oct 2025 07:10:56 -0400
X-MC-Unique: cZxfrhaRNJSQYPBWh25bbg-1
X-Mimecast-MFC-AGG-ID: cZxfrhaRNJSQYPBWh25bbg_1761217856
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471144baa7eso4457655e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 04:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217855; x=1761822655;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2IWmYgTn+axyHlrNGOBe1eg6QF+Mro5+LjrFCWT2pI=;
        b=WM6RRRbHdwHdh+IRFL3ouxmDBe75B91tMh1phJdgrke5gniqGC57uKPOaMXUefJXGA
         7AdObW0zV08AfnI+S2/EXOjpOYw7cPST9Mzn5Efc+Wzuwh3CD/0y9AsCGUNPSXVbjxRV
         DsEXpRFGSlK4n4cIhSb3P4q0cYcCCMY6Ih75DF5fFvendyBnmCl9YGrJUhn673RmuNz8
         IQdIfR4AdLoyj5JdTeRMIZ4i8ZeKDY+97/XCJuyrUlLtOPi+yJzPyg8C7xeXFpcvG8rm
         HpQWGSFBRQqWhPDpuuZb/nr/pcg4EwXF3ILVMmeTJ9h+g0HaZalTehO38uGLPWMf3+2V
         dvbA==
X-Forwarded-Encrypted: i=1; AJvYcCUFHa0sGiSUZ+RqGV8M6ux2zWCLyQxWjvavc7B6tw2xUdxMxewdeXu0SuiUTEUMZsNQiq83NpIJNEE3VB08@vger.kernel.org
X-Gm-Message-State: AOJu0YwCka7heAoXK+6vICXE/dr1gCWosBCoAHEHgQFbj+hLyER1QWXt
	weYukpazlStNFCxKm7zPM0IAhB06kypF1Iio6r+c8378AhtcKVyCev+ZR5qd1TK3oKh09uElcco
	RDM1I0F7Ptkit9octF7Rk2OuwOukBCFb/ll5ambJ+g+XV+Cgj2KKatSavqsszUtqZmOve8Dh+cr
	U=
X-Gm-Gg: ASbGncsYTsylBeGgO6bvnM64vjIEZlFrHxLDONLXUcauZWrWZnuMqY3aaook/RInuyd
	avkJp/rbWR42MDzeLMJfly1/5Rdz1dpcpP2UIGa6uJUdPfFJSjWtPiw12q+xHm3bSbNghsBAljl
	RLYkdcyEvDt3NA4l5S/ugS+6Mrrw654/LgTvWKkgXbCIOromDA3JFsqHosK6EQLmLYOGFCHBgHf
	LDww+DtOsqE91ZRkYm/fN+HMhrh1dN5D0ZfXNKuJ5gn5mYxAfMP59Y+b3br5d/dkcAYhGSGn5M0
	/yMogKaYHBd4JPDgTadXd+cOY+1M+cGbmSjwLTmEBN5qfJDoXCECl2y+ikDMeU4pe7hAGT20Jaa
	gaqyeLtGtRUZxH6mKmOwrnhjtnIrrynHrLyMsaLgRVefUBT+YiN9/1s/vhGmy+EgJ7p8gtADKq7
	+3R0+myt5IWFMvxjF1LmDhlnv+MAk=
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr180135085e9.27.1761217855571;
        Thu, 23 Oct 2025 04:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV7ydI7xyOszLDErCC9LpAr/vyTCsbXL1MuG3tRXSBfXfhqfoS0SRo1a/LWhqon2FVwTNCGA==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr180134835e9.27.1761217855132;
        Thu, 23 Oct 2025 04:10:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm106702345e9.17.2025.10.23.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:10:54 -0700 (PDT)
Message-ID: <56d9f1d9-fc20-4be8-b64a-07beac3c64d0@redhat.com>
Date: Thu, 23 Oct 2025 13:10:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
From: David Hildenbrand <david@redhat.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 12:54, David Hildenbrand wrote:
> On 23.10.25 12:31, Kiryl Shutsemau wrote:
>> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
>>> "garbage" as in pointing at something without a direct map, something that's
>>> protected differently (MTE? weird CoCo protection?) or even worse MMIO with
>>> undesired read-effects.
>>
>> Pedro already points to the problem with missing direct mapping.
>> _nofault() copy should help with this.
> 
> Yeah, we do something similar when reading the kcore for that reason.
> 
>>
>> Can direct mapping ever be converted to MMIO? It can be converted to DMA
>> buffer (which is fine), but MMIO? I have not seen it even in virtualized
>> environments.
> 
> I recall discussions in the context of PAT and the adjustment of caching
> attributes of the direct map for MMIO purposes: so I suspect there are
> ways that can happen, but I am not 100% sure.
> 
> 
> Thinking about it, in VMs we have the direct map set on balloon inflated
> pages that should not be touched, not even read, otherwise your
> hypervisor might get very angry. That case we could likely handle by
> checking whether the source page actually exists and doesn't have
> PageOffline() set, before accessing it. A bit nasty.
> 
> A more obscure cases would probably be reading a page that was poisoned
> by hardware and is not expected to be used anymore. Could also be
> checked by checking the page.
> 
> Essentially all cases where we try to avoid reading ordinary memory
> already when creating memory dumps that might have a direct map.
> 
> 
> Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.

Looking into this, I'd assume the exception handler will take care of it.

load_unaligned_zeropad() is interesting if there is a direct map but the 
memory should not be touched (especially regarding PageOffline and 
memory errors).

I read drivers/firmware/efi/unaccepted_memory.c where we there is a 
lengthy discussion about guard pages and how that works for unaccepted 
memory.

While it works for unaccepted memory, it wouldn't work for other random 
accesses as I suspect we could produce in this patch.

-- 
Cheers

David / dhildenb


