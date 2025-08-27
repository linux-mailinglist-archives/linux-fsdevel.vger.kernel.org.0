Return-Path: <linux-fsdevel+bounces-59370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75021B3842A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DFD1BA017B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31EC356908;
	Wed, 27 Aug 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE9lGJMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0128F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303075; cv=none; b=gc43R3hQL1pI0rFOSWYn46X8ema9eAtoUGUzDbRWaBmsKr4UQpx2byuHF60gy8/4Cyfga6sdgNzJVBI9VcVmPsH/Plf0ZMr4VA0lHAGS9/ftExmyOipRcSA2a9I3m38M92k9K+xWyNx7kDHeB48j6kDTGQSWXr1smnr5n7A1pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303075; c=relaxed/simple;
	bh=w5C+OPoYn968BgQ6qtmZpUP/fh9P275kHpkQ556nKLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tim8sMbGfsE2X50ZYYRN1lubWkF5XrWtI4oefvPV/o5iifnu0BBnf4bk+0hMtnY82sJbXRQDvTnfvLskjGMgaQchFC6N3s6CvjsSI01Y/98cGu1udBzcwjsmHVy2qhg0BqygCCho7UKATsPurglPk8Icj2cKtyJ5m+GLABjI7WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RE9lGJMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756303072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0pMMKUGlgiVp4RUtrgX9pnDpZRGAoSX+x85uDyLNVMk=;
	b=RE9lGJMPCVRN5Kkgd7xs7bB8bBeBrXapVyXNuPYTJcDmVBDe+YkIHQ97TOHd7hqV93ReZD
	jziltvAZR2Oln+C6fDoluy8yjF5EiLuNeGNVKQz6Q8ifwd7dA8VcyKf7BACTmo1bO1HZ/I
	YrwROyHpr2nxpaE3hmPKquN4lLkB3eM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-yN3IDznrN5me667TT4MNjA-1; Wed, 27 Aug 2025 09:57:51 -0400
X-MC-Unique: yN3IDznrN5me667TT4MNjA-1
X-Mimecast-MFC-AGG-ID: yN3IDznrN5me667TT4MNjA_1756303070
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b10992cfedso136488341cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 06:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303070; x=1756907870;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pMMKUGlgiVp4RUtrgX9pnDpZRGAoSX+x85uDyLNVMk=;
        b=ucJtmtyXqoD+1l86b5Vvsm97ep41WAYc2xcwittP/04xoZg3DJNkRyB8Wcu8OelD04
         /p7EeCWHdIULu8qWsRYv+XHk5dAnD095usH7ugmVwbyI0F6tHblizXtp3pXMVVxGvqYB
         mX04/AMy++DCJ+pYXDW6H8d6OJEunjUs5RYdKiP8Jg8RIUa0CahR0ZRE7y3zH4V+96V0
         7h4W/kGW+IDHGfPDooGYVvR1Xa1UDDG3KLBIJ2dmWHHeVwt5N30tMQgF1N5RF5kdrNFn
         quEjkzRwcMrj20vXppuhN7QDjpomXAREam3YO2DRlmY7NFEkwMsi4BtOreA3X3mLhYSD
         T4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWNskAKGbWhnE7CkXDLoMhihpZcGwA2FgfwULroaDRj0Eo/Nfsi4OdAcCyOLzkC0h0ohEymQ6n2zzXViuEx@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4enUun+oZiKsTjJuOL9Jx+ahP+RYwWBpQ2zwTQ+0J5xHKN+O
	uuNlqQteY3j4ZIcEoXWihPYIEcFNc+qzo+0DlgPa6yr8hfzRE/O78pi4aYf4o3hZbSrescZ8j+2
	kBn72Pycg0PSAMMMPjR6+H4gI1kNTZgbmUoFW9mCKBNuyUZdUUzSSgu5DadugjE+qW30=
X-Gm-Gg: ASbGncv8lbdJEuj4pZQOUQOCRui/hHo6Xe0rd43vWjN7CzCZ2LHQ1hDZMBYZ6/L2hqq
	AoNkdEFzg2NUzTaRqxizk9uCdMIoy2S/qhNRl6PshTIIVC19ZcdnNjsMFiofLbEtcurBG07UOA/
	wUFnE0AqP31E4nSZwwJEuR2HOLYqvoNxbB11aZFIyfBiclpdEVNSLd5b5EuiAKiiMQB5Y0F31Po
	7rLEWIBpg8b20r/GkYHAhZ+VRenoy2qshcA7re4vMzh2rcadSH+QwMmwCN+3wrMjkeE204H2ABU
	6n1L+nu9ZfOcwNl6uQfk3QUrVhsMT7WEXPf4ASJ5q05C8fFdk9TfbzCQqE2bLQ==
X-Received: by 2002:ad4:5de9:0:b0:704:f7d8:7030 with SMTP id 6a1803df08f44-70d97358f0fmr265013146d6.50.1756303069785;
        Wed, 27 Aug 2025 06:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWXjl5tZ83UA1+ay+aJoeZJMgZd6GNpXCtIp6lIpLZV6EWrRjgPphDax1GYOjslh+fV0VbDw==
X-Received: by 2002:ad4:5de9:0:b0:704:f7d8:7030 with SMTP id 6a1803df08f44-70d97358f0fmr265012716d6.50.1756303069173;
        Wed, 27 Aug 2025 06:57:49 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dc949bcc6sm42209626d6.8.2025.08.27.06.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 06:57:48 -0700 (PDT)
Message-ID: <0a844460-d898-418c-92b8-671f6156a2db@redhat.com>
Date: Wed, 27 Aug 2025 15:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] powerpc/ptdump: rename "struct pgtable_level" to
 "struct ptdump_pglevel"
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-7-david@redhat.com> <87a53mqc86.fsf@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87a53mqc86.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 18:28, Ritesh Harjani (IBM) wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> We want to make use of "pgtable_level" for an enum in core-mm. Other
>> architectures seem to call "struct pgtable_level" either:
>> * "struct pg_level" when not exposed in a header (riscv, arm)
>> * "struct ptdump_pg_level" when expose in a header (arm64)
>>
>> So let's follow what arm64 does.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/powerpc/mm/ptdump/8xx.c      | 2 +-
>>   arch/powerpc/mm/ptdump/book3s64.c | 2 +-
>>   arch/powerpc/mm/ptdump/ptdump.h   | 4 ++--
>>   arch/powerpc/mm/ptdump/shared.c   | 2 +-
>>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> As mentioned in commit msg mostly a mechanical change to convert
> "struct pgtable_level" to "struct ptdump_pg_level" for aforementioned purpose..
> 
> The patch looks ok and compiles fine on my book3s64 and ppc32 platform.
> 
> I think we should fix the subject line.. s/ptdump_pglevel/ptdump_pg_level
> 

Ahh, yes thanks.

@Andrew, can you fix that up?

> Otherwise the changes looks good to me. So please feel free to add -
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks!

-- 
Cheers

David / dhildenb


