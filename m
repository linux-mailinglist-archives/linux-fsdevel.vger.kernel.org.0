Return-Path: <linux-fsdevel+bounces-39827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF1A19072
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C9E3AE638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA3211495;
	Wed, 22 Jan 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/skAJZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30123A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544523; cv=none; b=bMh8OQIH+Vj2AOobu9gByzvB/E//gHjKqaR71mNO6dekQUw09r5I9NUWVODP14f64UsDh3NMfkduVYqisuU40fv1q3ZXw9Q+s6aEMXhEyz1aN4Zli6KppVmj8F7aSU8NLZdne1owAaew9Xd2byAatZ5vPKk8hoL6ZeIGJNUqURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544523; c=relaxed/simple;
	bh=dQvvr3Mn1hy3Fqbj6e0p36LjlxNBEW9lLKYr1czilpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgNWdw6Nv5BJb8tp2el0zVYbUH8wRHlpIY26mGjN6ZSKJYDlgInIps0MKs2P6ToBaN8SuGSn9BtjYnZTRHhWG+o39BQO+ZjV7Dt1sIzc2iEQ3mlRHJwRO8/TpddoZJ8wlU32MaFAAHh80D9wWWKbmetcCfSZnhFDvZL2pZSjnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/skAJZC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737544520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8qU9Op2nDJzIbBg5fiZm7FqRsbMABf3AontA67l8mXo=;
	b=g/skAJZCo9/XbB6KxYmzDzqUTHp2A3s8F2XiDtWyhUModXnJU5VSM9NXRijpntY3s/KcKe
	jNJaRSMGgFt6LLFWy7XnTUHEmNFzFp6acKEHOmUFjQdzC84NsWGClmF3xZXMM51CGFQz+4
	y0d9zkX7WKdBE48bbDYJgBN2duv+Hwk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-8Z_O4-hwPKO9RpyI0OPJlQ-1; Wed, 22 Jan 2025 06:15:19 -0500
X-MC-Unique: 8Z_O4-hwPKO9RpyI0OPJlQ-1
X-Mimecast-MFC-AGG-ID: 8Z_O4-hwPKO9RpyI0OPJlQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so36648185e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 03:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737544518; x=1738149318;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qU9Op2nDJzIbBg5fiZm7FqRsbMABf3AontA67l8mXo=;
        b=o9mDKRtNUWT+9sxAld6vPMHxszLu/XTeRXvp9F95mrMzfY+C6qmuC5ug/hbng8ax7X
         jAtXKWaMzB9jp/PwhK0T9WpexO7BahejQ42SXCJorYH4S9d72hES+R7FwL0DaJAkkUmP
         74SVX7Kpm6/wvZqOdS4FPYI18UNx6NT334mYlL2zg0BvZSopjUaIVQJp/iPC/JPp76vA
         Yiqqd/Gsma4guZP/3mo5kBSHDpZgXRin408lvvxIS6r/SR7/z2IVK7450oIB1l3CS64e
         6aMXEJ6bG3MQdUkydr3NwnDDSMTkCjAPzo4qYw23ohao6jXKFzs4PFhNT07fcLq5K0m4
         j9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt9rTyzTZZnsNKXpmrLeUlD89J0Dqj6NFabrzp4iAem4qzwlcgkWorhr6vtl0wttfJ6Bhq9FFZsb6rRfS5@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1+zDuMT7o+EZCrhWyzev8W39lZD5/K6TsfZWBtlKhVkeinnU
	Sh7c493A7DS2WPXxtZVVBMrt++NJcuFy5eoD9r1CtwprJ/mtvSiyJ510DPELH8ZAdfWdCNys0gt
	5oqpSXi9kRPTQJgBNo9hE24/674lDtmNXRpWZKkGOq6F8GIZqtgpxS0ssbLcYZYY=
X-Gm-Gg: ASbGncvdaAsSrnG01qktkBMOlV0YlqAAhGnHMtX8eb7Hk1hDC/wW6/dbXDHMh73etTf
	MK8Qt/G8/i6rYkfNhEo5HPDrY2lsBABneg4of79B5v68Q3Awvd4S/75hYgydvnt4rZxLusWAdmY
	PIRE6PrKD/X0VGvnrpaBg0QIV6S1Kz1tLS6x306wYKVVnqa6LO25XwfAs7BKdJDDIGo2l9p+UE3
	Gq3wWQJoMueD6JVCULUyzqxMr5eCEIeWJVgOX2LJ/zvi7J1QQqYPEyKZC7Y6k0l9lAri7/EYuDv
	gH9stm5Eidk99RUQWswo2te8JUkcB+SbumcWyzSMN3dYp2MntMG/m6kyD/5R/g7iZnc24KXflls
	J297b1sSBEexx/zAjRfdksQ==
X-Received: by 2002:a05:600c:6a93:b0:438:a913:a99 with SMTP id 5b1f17b1804b1-438a9130aa4mr119535955e9.31.1737544518239;
        Wed, 22 Jan 2025 03:15:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtDn5T6PQQkvDUWe1RxO09UsEA8J/YoJtXqUyPaFnCZofeZmgq88E6UbbFmB5um/DyZxqB6A==
X-Received: by 2002:a05:600c:6a93:b0:438:a913:a99 with SMTP id 5b1f17b1804b1-438a9130aa4mr119535565e9.31.1737544517815;
        Wed, 22 Jan 2025 03:15:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:db00:724d:8b0c:110e:3713? (p200300cbc70bdb00724d8b0c110e3713.dip0.t-ipconnect.de. [2003:cb:c70b:db00:724d:8b0c:110e:3713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318a38bsm21613495e9.6.2025.01.22.03.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 03:15:16 -0800 (PST)
Message-ID: <d72edb71-20ee-4a7a-87a9-7d62fb31cf48@redhat.com>
Date: Wed, 22 Jan 2025 12:15:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
To: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>, Joanne Koong <joannelkoong@gmail.com>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <73eb82d2-1a43-4e88-a5e3-6083a04318c1@suse.cz>
 <t3zhbv6mui56wehxydtzr5mjb5wxqaapy7ndit7gigwrx5v4xf@jvl6jsxtohwd>
 <Z4pmlmnXuf4mBLqk@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z4pmlmnXuf4mBLqk@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.01.25 15:17, Matthew Wilcox wrote:
> On Fri, Jan 17, 2025 at 12:56:52PM +0100, Jan Kara wrote:
>> On Fri 17-01-25 12:40:15, Vlastimil Babka wrote:
>>> I think this might be tricky in some cases? I.e. with 2 MB and pmd-mapped
>>> folio, it's possible to write-protect only the whole pmd, not individual 32k
>>> chunks in order to catch the first write to a chunk to mark it dirty.
>>
>> Definitely. Once you map a folio through PMD entry, you have no other
>> option than consider whole 2MB dirty. But with PTE mappings or
>> modifications through syscalls you can do more fine-grained dirtiness
>> tracking and there're enough cases like that that it pays off.
> 
> Almost no applications use shared mmap writes to write to files.  The
> error handling story is crap and there's only limited control about when
> writeback actually happens.  Almost every application uses write(), even
> if they have the file mmaped.  This isn't a scenario worth worrying about.

Right, for example while ordinary files can be used for backing VMs, VMs 
permanently dirty a lot of memory, resulting in a constant writeback 
stream and nasty storage wear (so I've been told). There are some use 
cases for it, but we primarily use shmem/memfd/anon instead.

-- 
Cheers,

David / dhildenb


