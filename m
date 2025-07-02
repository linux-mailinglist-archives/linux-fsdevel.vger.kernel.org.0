Return-Path: <linux-fsdevel+bounces-53671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B71AF5BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D5A1C43945
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E830AAB6;
	Wed,  2 Jul 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnIU5xeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A13093D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467982; cv=none; b=BEBWt2yqwToS+4QJMGzCNZTXyjipUyf+unO/pt52EngskvmdpJTOaICJbRTfFnakl4W81TIlgrCAUBQ77wqRINbS6miphgflB2gcqi9yYWB7YiQbHtLEP58lZECDxBXdvLGyuC7j6ibfWwPEZim4tBepGdiUwYUOgUVY2Qnos80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467982; c=relaxed/simple;
	bh=1WpcSP1JHaereL+EgjjueQUUIKUuA5rHNbUpItx789Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzT1E7AQNnp8NFzvAZJsFbBxvEk9tM6PtGUt51Dw5zsICM+97mqGknh1rsdY6GmZHm4qNvdg/YW2Md/23uEvGdhtdW6oT7Vw4XqPJvuwu+ZhqEtZ6y0+p7nb0I7JdaSfpBuk9/FyNDpnjfE5hRcqb0hxzAYpYkBAvdhEuKLPTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnIU5xeN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751467979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T5nj6T4+km6XBVJylVpc2FdMnDZamikSe9UfbX+MJzI=;
	b=DnIU5xeNIMQ4selEObSEd/Hxlph4YJOUzpm18at0fscW8wPe8sOhf5wzApI546onACF2xI
	tSieJfigna0g9DBI/Y5L+xGfCtf0sTJttnK6RbrHwofGbQeS7G/7eGBAZplJbr8ECmgPRa
	URCGpBZh/GC0IpUFe6kRzto+8e9qKmw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-vxsGdxxqOP6ZNikD9AOWrg-1; Wed, 02 Jul 2025 10:52:58 -0400
X-MC-Unique: vxsGdxxqOP6ZNikD9AOWrg-1
X-Mimecast-MFC-AGG-ID: vxsGdxxqOP6ZNikD9AOWrg_1751467977
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5780e8137so3900043f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 07:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467977; x=1752072777;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5nj6T4+km6XBVJylVpc2FdMnDZamikSe9UfbX+MJzI=;
        b=kRsoCpJoAVw/fXGGlA1ucqk2L9QeFGVYJR2ZDRgTFjR80kD3sUS9NOHe2D5ERjjj7q
         FgC3cL/x7kVVAiDgw0wMIaQ+GfCZGYrJBvsGYo+58G3mbYcOQu3g08q7CX2ozBinYoiQ
         cHCi+S6FSx3ZEvuTwI4/kw95WiTZNAHrjfSoa08Uei2u2d9lu5eY7e2OFNRoN5JUOj0f
         IV+s/jIW1Xzt4LpvWlkt3fNBJqK332ApFC0wRqeRWb3Qc06E9Ogqaig2qd/phjCaDcVH
         8A/bv1Zz1+6pT5pgmCkZLCitUH1GB4pcOfJutWfOtPOT4C7pFNqgeE0/NNyd3katnRmP
         8H5w==
X-Forwarded-Encrypted: i=1; AJvYcCXxNxoKucfe7LDCMN5ZfT9bJJu8+wS7ANvD0KT7fKaG+pY39EsRltb6b3FHMjjvL4XZGgHzCIB/Xj44QHqs@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1ZS33FeKini1vZEwbxdbLtYBhAUwmbmXrIoprbnfCEgBUCcE
	tSjSHX6bpZevOiK6xG0gNVV6J1qevRctNuKPvy1Yl//znjvCc3PQBYINJ75WoRfBjN1xmLUMrGv
	kKYPaeA7RIML/o5EyzMx7wQn6RGMWFrKu1rRW9XoA58P+Gy8j1hBPP7BtgT7q2oY+YLI=
X-Gm-Gg: ASbGncvWTzGe8rjYJWNJHwiAePbGtLQQQNKecIUeCKSMExvzYunekIIKNYHnYgoMipk
	aF7b0VcBepBZQdicPZR2CNnmcEU5JHUyo8PNnzmtNy8N1Ef4cX4iXhxhJRoqyqM3CaGJqFb307C
	Go2E5kKOvUdGGIS0mXj41nT6lBnqDcQ8Aqg+uouHspcnBf5YRgU9cAlZldwM6JsCXl+b2hPzcFY
	oIcG4W8J/cpEaRLTjTmmN1BwD0vMI/fGhM+5onA3jlJZMMJhNKEVyIdEOL2YzLtWp9NgnOUIFiD
	yncDAp96AXFTb1oOrtQa1GNtEbtsCyx7+d++k8Owt4K7R2k19V7zuTM=
X-Received: by 2002:a05:6000:2302:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b1f5813ebbmr2700871f8f.5.1751467977296;
        Wed, 02 Jul 2025 07:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6zmp9d2w2MJkn7HSBDnoWuF5cmgkYx/VRxm4DVngK4kJgBtnY9v5ljh4jmUYVqeNL+t+SYg==
X-Received: by 2002:a05:6000:2302:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b1f5813ebbmr2700827f8f.5.1751467976689;
        Wed, 02 Jul 2025 07:52:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e76e1sm16577247f8f.16.2025.07.02.07.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:52:56 -0700 (PDT)
Message-ID: <bd162903-6854-4b69-ad4b-89deb8e0d695@redhat.com>
Date: Wed, 2 Jul 2025 16:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 27/29] docs/mm: convert from "Non-LRU page migration"
 to "movable_ops page migration"
To: Harry Yoo <harry.yoo@oracle.com>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-28-david@redhat.com> <aGVA2p5mUWoBDVKJ@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGVA2p5mUWoBDVKJ@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 16:23, Harry Yoo wrote:
> On Mon, Jun 30, 2025 at 03:00:08PM +0200, David Hildenbrand wrote:
>> Let's bring the docs up-to-date.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> +movable_ops page migration
>> +==========================
>> +
>> +Selected typed, non-folio pages (e.g., pages inflated in a memory balloon,
>> +zsmalloc pages) can be migrated using the movable_ops migration framework.
>> +
>> +The "struct movable_operations" provide callbacks specific to a page type
>> +for isolating, migrating and un-isolating (putback) these pages.
>> +
>> +Once a page is indicated as having movable_ops, that condition must not
>> +change until the page was freed back to the buddy. This includes not
>> +changing/clearing the page type and not changing/clearing the
>> +PG_movable_ops page flag.
>> +
>> +Arbitrary drivers cannot currently make use of this framework, as it
>> +requires:
>> +
>> +(a) a page type
>> +(b) indicating them as possibly having movable_ops in page_has_movable_ops()
>> +    based on the page type
> 
>> +(c) returning the movable_ops from page_has_movable_ops() based on the page
>> +    type
> 
> I think you meant page_movable_ops()?

Very right, thanks!

-- 
Cheers,

David / dhildenb


