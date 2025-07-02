Return-Path: <linux-fsdevel+bounces-53606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1667AF0EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4594D4442D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E13923C8AA;
	Wed,  2 Jul 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/LJ6t3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F419D8A7
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446949; cv=none; b=cRqslAZ6ZTyeGCRR5gwzqqIX1jiZCoXpALA8ooC14q/Yv/Wu4EOIpQbOqVNJHj8mL41Nz1F3k9Usot4nRqzcoBMbuM2OjtKELhvHeK65YlmcGRjm8qajoj6fKdnzgqj6RKDCsqGkzoWK5lR72bl7V0/Ptv9eL7q85rNKzEiv7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446949; c=relaxed/simple;
	bh=1yrUTlqL9BYfRoXQosVHizjKQq+if21lX8DUEBkS+FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuWHtxVA1RoBDEcNCdQxVkno4ZbOcx5fzoVI6/le6iefbxhIchWYYr9/7Qdv8Evgj53yhIL4bEkS3i2pAMmpNnpbAmNLjS9u8kEd97+GPknU81u0O7lcKeI++R3Mp7n611SY2QCmMY3uGtF6RpzcVpLnQmWy+Wk+4stDQ2DfYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/LJ6t3S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=boAaIYoMY3PoB+UV5kPDMx3wMNUIYKiXfBN5feJckdw=;
	b=W/LJ6t3S04DkcqykqSZqtONKY12VwSlVVpKCyChlx2RuotT9nkbcrSCtE4M5Z1tm0b31Tx
	nN0d2UW1ypHFjGcOzihEmX+y3n2K/JOYzG5JVUSd21aIbDPfqqf8CLH60sAU+vDmF4xBCC
	LgWe/sEtzVbQmSJqZCys/I/lW3uUgtI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-SKAAKsctPRStPbMgqEupaQ-1; Wed, 02 Jul 2025 05:02:26 -0400
X-MC-Unique: SKAAKsctPRStPbMgqEupaQ-1
X-Mimecast-MFC-AGG-ID: SKAAKsctPRStPbMgqEupaQ_1751446945
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5780e8137so3682902f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 02:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446945; x=1752051745;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=boAaIYoMY3PoB+UV5kPDMx3wMNUIYKiXfBN5feJckdw=;
        b=DVP8TpBjMAf4uzVtFLGKCKzYhmnsTzWp1kvbKgH6dY/La2e+vJcJGIMivtEpHmZJ+J
         R3Ui8R9ZlDRrKv5BZIB+QZbyytg+cYNFGHw5K/EviBFe4uBfwzaLjjUAUnRz/VWcwkAp
         JPVbdWDbooEUBo9FbEnp4sDQmziSV/aQ6owYl6XkR09YFsYw+Q3bvwnysuRz2N+nn29B
         3tfGa+2brjS7FcNA1H4QGz14n8pWyF0WHOu7iisU5Ym0a55zmbrrwlvrHYiKFZn3pOHw
         IySItfOXZYT8zPEWyHeT8q5z7VhM7yXnPHeqeZIIIkuN8vHrTLbPaRD8jxKnPVGiQaXq
         XwQA==
X-Forwarded-Encrypted: i=1; AJvYcCX+G8NJqFU3Y/6FYzUNEpzUmReaWIwnpKfA5/4nUzRGUOOsvrmbWKhNQfbnG2SiyG0VyO84xfkkE8K3kstC@vger.kernel.org
X-Gm-Message-State: AOJu0YyYbCy+uOtkBfUlKZ2NxOP6zEAKlQbAHADjsGuK8dVYWbr5oINa
	WKUpof0hetaTuRZUcVqI7lLHJ0PJMZbs0RHRXI433Ae/cM2/q0yZKBaTEeWac8IIW9VZ9BRGe9F
	rUX8mCQAzC3ow+2xNcohGyaqBhI8RKiVwsLPPkoR3DNU4+UL8AMscN6M0tiY9pwwziAw=
X-Gm-Gg: ASbGnctQYBdA95dvy4EPAH8jE+RbiHOruWU3VsyAK/UISmcR/x0wetkvSTmwyka8/s2
	IvwTKEGwEcSbQlNQiZZxj5hJFwhZiXHsELPyJb6Y7KeM+1v5skvvY4fx11hnzBl8vWsJVpW6dn7
	pLOEzejYmEpEhT4bIFjqQ+t3+wFd/sBOX2rtzQNdkFq8D7+z7mQPU1S3WvRwebHHqXEybMfw901
	40QUKFVNsR7VENCPYhJ4R8HIjPdxPMBPfJ26/AbhxtYGer7JXkZW3Ft6Ngm0xg5OMoeBXhkmt5t
	RjC2Z7o41+9BGYfBdMTyTUgEVL8iZITTm4Ca0wuTwOUpCc4NCUttQiQ=
X-Received: by 2002:a05:6000:4a10:b0:3a6:d95e:f39d with SMTP id ffacd0b85a97d-3b1f5de32cdmr1298341f8f.4.1751446944992;
        Wed, 02 Jul 2025 02:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiOYXY3w17HGytPrmt/c2dKtPFnAg0d2EGsHFzi5ze2SIJjD0kNsNr+fZES4VE0BbBq1yUg==
X-Received: by 2002:a05:6000:4a10:b0:3a6:d95e:f39d with SMTP id ffacd0b85a97d-3b1f5de32cdmr1298264f8f.4.1751446944476;
        Wed, 02 Jul 2025 02:02:24 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c99sm15308587f8f.49.2025.07.02.02.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:02:23 -0700 (PDT)
Message-ID: <a6326fca-3263-418a-be3a-f60376ed5be0@redhat.com>
Date: Wed, 2 Jul 2025 11:02:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-24-david@redhat.com>
 <8ff24777-988a-4d1d-be97-e7184abfa998@lucifer.local>
 <ac8f80bb-3aec-491c-a39c-3aecb6e219b2@redhat.com>
 <d7e29c51-6826-49da-ab63-5d71a3db414f@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d7e29c51-6826-49da-ab63-5d71a3db414f@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 10:49, Lorenzo Stoakes wrote:
> On Tue, Jul 01, 2025 at 09:34:41PM +0200, David Hildenbrand wrote:
>> On 01.07.25 15:02, Lorenzo Stoakes wrote:
>>> On Mon, Jun 30, 2025 at 03:00:04PM +0200, David Hildenbrand wrote:
>>>> We can now simply check for PageAnon() and remove PageMappingFlags().
>>>>
>>>> ... and while at it, use the folio instead and operate on
>>>> folio->mapping.
>>>
>>> Probably worth mentioning to be super crystal clear that this is because
>>> now it's either an anon folio or a KSM folio, both of which set the
>>> FOLIO_MAPPING_ANON flag.
>>
>> "As PageMappingFlags() now only indicates anon (incl. ksm) folios, we can
>> now simply check for PageAnon() and remove PageMappingFlags()."
> 
> Sounds good! Though the extremely nitty part of me says 'capitalise KSM' :P

Like we do so consistently with vma, pte and all the other acronyms ;)

Can do!

-- 
Cheers,

David / dhildenb


