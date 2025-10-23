Return-Path: <linux-fsdevel+bounces-65388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA3C03764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575CA505853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 20:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D6273D9A;
	Thu, 23 Oct 2025 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6M5HgBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A31F63F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252897; cv=none; b=YngSS1shvzo4h70ybj/26SaywkrW6LcSThQBbAzhRVhWAUjqbzjgi0CanJCqlxooqD680fovU+ZrBB8XBT9Y1XX446hr9chjSY6Q6JXs07Eti9uOQOuFoMC0/p89O7O0UJTmfPvkFsF8OjtM9DJCI8te4kvO3YVPrNXA495p0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252897; c=relaxed/simple;
	bh=3zcWNMysNlD++tky2PpacIUVZRP34xDTCqHXuVWOnNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9zp9IixrTXQh7xR4l6wpV9iLztTdUwui3+wMOHtknN2yNQrYQjI0cBrl7dlR0vzNhoPRwenpKLVD73zLyZ0lkSHYOGk1TOYdge2zaQGgxtBBORVQT9xQsudBp39afVtzuauRhKJ4MUSeuLK2SoQeH3COOpSPnH+zncxLF4+5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6M5HgBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761252894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=msiKVYWHSQdItrL939R34SZBheamSPWIMDRxwGKcY7Y=;
	b=K6M5HgBC8HxPH6ygqt9bS70FcXHB2r7xyVuC6AuHsnXqpRrmNGk4T7ms+UtRCDpPB5FjM6
	b2AHM5EbwVFyBG45rJ+SjU4su/UF8VhRPn5/rZw2/rOpcpSrnD4VGBo189/G3lHHAAGDRs
	W9pptwZTfvfOK4+xW9YHKPaIyIhZ138=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-x5J7Jbk1OBmDWuu7UfgX4Q-1; Thu, 23 Oct 2025 16:54:53 -0400
X-MC-Unique: x5J7Jbk1OBmDWuu7UfgX4Q-1
X-Mimecast-MFC-AGG-ID: x5J7Jbk1OBmDWuu7UfgX4Q_1761252892
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42705afbf19so887183f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 13:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252892; x=1761857692;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msiKVYWHSQdItrL939R34SZBheamSPWIMDRxwGKcY7Y=;
        b=ZudaAH8HQJhiTrlFIE10vXNqeUimfmo80smEMRSD7Lm5Bx9MO+WeF6Hmn32yR/NU38
         mJ8CBgGUTbYjGBYjSpZoQKN46WQqfIQWBXRgXdYi2/nbdwCiBhcs37dJel4wHQ2O4bwd
         iwTvQ8dB1/QNCQ6p5WdAQqwTFMvr8L+EoiMF9bCJdAevlM/Fzp/klIlhfKtJ2hXEudc4
         Q5muowoOCZKLJNmd6GPp4IswbApjeWMoV3AZ+ZvnMT64Js613xGhZhbRPfe1lzNBnfPc
         RYfFx0QUA8L/ToQ42RXHP7r4aiKp+tQyMI8Tcbopi1HFdhwBBas11EUs1Einfb7ny1Xl
         tSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZU5hyxIVERTfRabInoGHZOSybvL5KEwFFpXs3exRAKezBXuqCCpSXed7ZcEL3jCjAVQkVPYMRzZGVPo7@vger.kernel.org
X-Gm-Message-State: AOJu0YxMD3q7Nxr7FdKFq7U4veYm+E4WqUGBkUom8Cu5FeE66qzsTvg4
	XJbJ79ANWsGRKffC/H56vj/KCJnWKh1QcS8AoIv8oR81hJYLefgrJ7iamsaJNHMGlrZPAi/pJ9Z
	5Y0u4OdxMa/d5AJZr3vjEWmGic1kICz2EMtI2yZWqHqON3l5YKtYnw6F3OU9pzgzhmBA=
X-Gm-Gg: ASbGncs55G1Gc3mye7GPMBaMU6bnJkD1BThUMaJt8xMGhdfshLRLFqmV7Zhc7mIchyX
	rWEVbpTBib7R7K0YhhSw0alel7gXJMC8ptD2M4lZANJRiYl8a7dNxe5gNyqnPwPuHATSEwghR57
	/zVt6BH6+4SIQOKL9Dbur/gBkxOVf2Vrk2mG8n3OQcpDhFNlLAsP8qJIToLvdGF1AyjV8VleOg0
	in+QGpyxQpG/0bUl02r6JVb3WbYnUVlc3U+XYmI0yG/FFUov3IDrQsKXoaiVct0+VlPJVDB3LX1
	PYjmRFBF5h320NyawBrf4uJD82Nqn2zVRQenhAEt+UkQS/htX0YkmDA/2AV+Yk2X3VRerxMm1zN
	bS/jB9ego8zH6zY1hM3DBgFBJKw/9/CjSxz8VrsKzLmgjszZxBEQv/MP3raTNDSTILfjwRq5tPW
	LqvsFBOu19fvnGTTJ3GnprxwJTGig=
X-Received: by 2002:a05:6000:1ac9:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-4298f5768b9mr202870f8f.23.1761252892166;
        Thu, 23 Oct 2025 13:54:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6P6cDPePEsuTJGDLHUKhovQrQ2mHJ56yA+geqOPGhrDw50Ig/1srvbHRTrnAUVormPLFpaQ==
X-Received: by 2002:a05:6000:1ac9:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-4298f5768b9mr202848f8f.23.1761252891707;
        Thu, 23 Oct 2025 13:54:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298b9963ccsm4026621f8f.7.2025.10.23.13.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:54:51 -0700 (PDT)
Message-ID: <3ad31422-81c7-47f2-ae3e-e6bc1df402ee@redhat.com>
Date: Thu, 23 Oct 2025 22:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
To: Andrew Morton <akpm@linux-foundation.org>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <20251023134929.b72ab75a8c132a17ae68a582@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023134929.b72ab75a8c132a17ae68a582@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 22:49, Andrew Morton wrote:
> On Thu, 23 Oct 2025 10:32:50 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
>> From: Kiryl Shutsemau <kas@kernel.org>
>>
>> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
>> supposed to generate SIGBUS.
>>
>> Recent changes attempted to fault in full folio where possible. They did
>> not respect i_size, which led to populating PTEs beyond i_size and
>> breaking SIGBUS semantics.
>>
>> Darrick reported generic/749 breakage because of this.
>>
>> However, the problem existed before the recent changes. With huge=always
>> tmpfs, any write to a file leads to PMD-size allocation. Following the
>> fault-in of the folio will install PMD mapping regardless of i_size.
>>
>> Fix filemap_map_pages() and finish_fault() to not install:
>>    - PTEs beyond i_size;
>>    - PMD mappings across i_size;
>>
>> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
>> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> 
> Sep 28 2025
> 
>> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> 
> Sep 28 2025
> 
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> 
> Jul 26 2016
> 
> eek, what's this one doing here?  Are we asking -stable maintainers
> to backport this patch into nine years worth of kernels?
> 
> I'll remove this Fixes: line for now...

Ehm, why? It sure is a fix for that. We can indicate to which stable 
versions we want to have ti backported.

And yes, it might be all stable kernels.

-- 
Cheers

David / dhildenb


