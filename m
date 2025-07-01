Return-Path: <linux-fsdevel+bounces-53464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17307AEF499
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AA17AF084
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEB1E570D;
	Tue,  1 Jul 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHQdbGbu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E418DB35
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364659; cv=none; b=Ek86nQ+zsAu/Ze9F0eAx0yiKoZFDAcnkyWFiVZC+idCeBL/OK1eL/TlrFFGM4xMzB4AiMkbepwDnYDVXGBdbp5zMWXNhu3yVwAUB391V6OxFAPnu92q36ctiUKPTL5KzvNd9ATcz3tgk3qtW9GSxGOfLO69m8FFD1w9YKbMATRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364659; c=relaxed/simple;
	bh=tIPwwXrQaFWvUEypmObVW3/S/EC2362JZW6tq7fT+6c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HmOUIGsn0kO0E5DAHNIuYAuOI2OD3WSijXfTPJ2s6D5Z63QEeyUaz3M931KjjzzVCvM3hzJacFxZ4YsMniyRtfc/S9QKaZHAeHDbH4FN5Qyv8Ys1Y07+swUvxWAoQ7ntiHZhBzcauI7Syg9kcHsrrI0ybBCvT5UKIpMOeUv0zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHQdbGbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751364657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c0jD2hSpE7gKZ4WlSst4Xt3GrhqpzXYpDNooeYwdm00=;
	b=KHQdbGbu/NWIv3yhUTarpBksdz7d126B63jX09cNSn0uhMrH2wdOlkp7EpGWmBbV38RhL0
	ojur8OUn8cj4jM377Jc5iFIQIuOJLMH6up+n3pEX1Z4inY4rYpaiBPXogspBsZX9hapEr4
	ieTRPlt2KQSDqOpM5tfXIKE5jTEOqcU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-AmaanI8jO-quP8sCUDK-Fw-1; Tue, 01 Jul 2025 06:10:56 -0400
X-MC-Unique: AmaanI8jO-quP8sCUDK-Fw-1
X-Mimecast-MFC-AGG-ID: AmaanI8jO-quP8sCUDK-Fw_1751364655
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so2335708f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 03:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364655; x=1751969455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c0jD2hSpE7gKZ4WlSst4Xt3GrhqpzXYpDNooeYwdm00=;
        b=O+80b8s0PtVnWg395IoyEq50hso6otNyRKuSU+K6PZj6KMXAYm7UQCH78647e7tysL
         SMRVctI+krAivNBTQdUsAlQfJfK6dUd1sHbXO5kZ+KXuZhw2bO3dMqyNFBMmrFh1smpk
         fmPAmwAg9VDESTcvAey3eAZC7f7VnFqp79dGKWBnnp8Jj2PqKZH9vHgLoNrnT2KoJxeh
         cvlJeh0zNrxn6QNjaof75cbvg7o4DSjFCoSoNPGY2j1ldwsm09/xuPNtVP0ezc9vkDe9
         3DeP0Km0kBjBh1OR3157ed7vlyVlcU05HWRC/SoqHStcG+/OvPV23iYppsdxhUgD2U78
         cSFA==
X-Forwarded-Encrypted: i=1; AJvYcCXz1+SBbtUIUmL7P0Ikrr4l56E8+axWAhR9M6JAy7ZhUmo7QcHXdWf6KaBTN//rsw75m6LIzlJIL7Pbk6b1@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZfdJjQSaPCpIo6ewjogfNj69d3TbVQXkd/ag6i1LtmstjrIH
	Zf2poNqhhwXu2e276eilEJzQl704yiV8RJL87J1oPVxToWCkeD0tTKAgbL9x0xg1rxJTlZctefY
	ha6w1WEPhk2WxGmWO5nWAUpnDqRM+wYOhu4LAwvuMaUMH4LMnf442RAinUAhXezeZ+LA=
X-Gm-Gg: ASbGncsbpsqhSBYiIxYCywyOmjqDKSwefoGisI2dfRxG2k4AOeDa0xNcmLb6oJKJcZU
	iDKhMj0TS5NN0QYiy89k+3ujhjI/DI3kSr+wRotkzRi/TaDEYIaHSTw8W/OheTGG6iJr73yDx2y
	ul4Q21mM7oNWZ8YtwMlFcw9duaXLVnTOca+OyqbbfkmYG0TNAx9iUVYgCzty66EGlaR3F2Qek0x
	TPTKiWKxWynyfKQaGUo6SAvlI2yF3yMOU/qkp8CLVGtH+VBL8uXb7z1mcsAfzaLFTz6GkIZ1yhD
	Dd21QNwlYEWED3ifTiyDjNMGcyf6g6sO/0HpJypJrilmyM9uErfa05+xwyFIi1smgBD24c7ydFF
	7NeRFp2Wjki42cDgr6IwViDdIKEGYIqPV7cupSWdKyBPYSTS/wQ==
X-Received: by 2002:a05:6000:25ca:b0:3a4:f744:e00e with SMTP id ffacd0b85a97d-3a8f4548f84mr14531946f8f.4.1751364654587;
        Tue, 01 Jul 2025 03:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2EPAydBFQPvolNYN1EmggMxJTgK1+GLCQ1XLXRXKbAVGL3PuDAhYqnMDlTu+BQBsY4f0XaA==
X-Received: by 2002:a05:6000:25ca:b0:3a4:f744:e00e with SMTP id ffacd0b85a97d-3a8f4548f84mr14531865f8f.4.1751364653933;
        Tue, 01 Jul 2025 03:10:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e74fbsm12977368f8f.10.2025.07.01.03.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:10:53 -0700 (PDT)
Message-ID: <0482f13b-c922-4f54-b32e-bb1dc27b44c3@redhat.com>
Date: Tue, 1 Jul 2025 12:10:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/29] mm/migrate: factor out movable_ops page handling
 into migrate_movable_ops_page()
From: David Hildenbrand <david@redhat.com>
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
 <20250630130011.330477-10-david@redhat.com>
 <6aba66e6-0bc5-4afb-a42c-a85756716e1c@lucifer.local>
 <315c5e9a-8fbf-4b9c-98b2-1ea69065af85@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <315c5e9a-8fbf-4b9c-98b2-1ea69065af85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 11:24, David Hildenbrand wrote:
> On 30.06.25 19:05, Lorenzo Stoakes wrote:
>> On Mon, Jun 30, 2025 at 02:59:50PM +0200, David Hildenbrand wrote:
>>> Let's factor it out, simplifying the calling code.
>>>
>>> The assumption is that flush_dcache_page() is not required for
>>> movable_ops pages: as documented for flush_dcache_folio(), it really
>>> only applies when the kernel wrote to pagecache pages / pages in
>>> highmem. movable_ops callbacks should be handling flushing
>>> caches if ever required.
>>
>> But we've enot changed this have we? The flush_dcache_folio() invocation seems
>> to happen the same way now as before? Did I miss something?
> 
> I think, before this change we would have called it also for movable_ops
> pages
> 
> 
> if (rc == MIGRATEPAGE_SUCCESS) {
> 	if (__folio_test_movable(src)) {
> 		...
> 	}
> 
> 	...
> 
> 	if (likely(!folio_is_zone_device(dst)))
> 		flush_dcache_folio(dst);
> }
> 
> Now, we no longer do that for movable_ops pages.
> 
> For balloon pages, we're not copying anything, so we never possibly have
> to flush the dcache.
> 
> For zsmalloc, we do the copy in zs_object_copy() through kmap_local.
> 
> I think we could have HIGHMEM, so I wonder if we should just do a
> flush_dcache_page() in zs_object_copy().
> 
> At least, staring at highmem.h with memcpy_to_page(), it looks like that
> might be the right thing to do.
> 
> 
> So likely I'll add a patch before this one that will do the
> flush_dcache_page() in there.

But reading the docs again:

"This routine need only be called for page cache pages which can 
potentially ever be mapped into the address space of a user process."

So, not required IIUC. I'll clarify in the patch description.

-- 
Cheers,

David / dhildenb


