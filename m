Return-Path: <linux-fsdevel+bounces-53461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C1AEF43C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7A44A3E8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD82701A4;
	Tue,  1 Jul 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNrPdZ+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605DC26FDBF
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363969; cv=none; b=YxVKtriRe12rSjYrIcfJduPn4bAWqDOZdJYlwlFoW19qzo6ZbjpzmclaiqPlf28w1TCeYIXJoiWONLTPqDF2+s8AjlhrAI/AKbeIVnprZ43Hkgtd+RZmT8JWBKvcwtWj3vjX1JkJDDTQXHBnw+sGHOfmp97/iZASrT7iQR7PHoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363969; c=relaxed/simple;
	bh=CZbTsPgBVdn4bO8eTvEKO98v/qxoHiPrOp0BaetB2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiNbVzlyLfJ8uBgpvoJFKn0MFc83tkZHMU45bp+W0UuUcsSbvhxf4ZmqQyAzhWqEK/FG9lqar3InhV4wZMMt+Cig32d7c2ZO2m2IcjMZ+BNansdXNJpcrqrjVI3/O/nydRrBEMLuOqarjy4O6Ewrd+ep10t3nHqjdkBJKJfc7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNrPdZ+a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751363966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s5FbtO3errtBpeKUR76CZ44Npcbx4IGE5AODLlZshxc=;
	b=TNrPdZ+aqb4HUXhTy/y3106+mdRR13Tg23ilSSkVim8/P1tnKxDK68bwIAizGuakGUG09+
	CriVJRgYTfbiBrMkFkuh/tSNBnMN8i2I5yelrHQl4FBPglk2SlqVq2FeM9NdxrY2j9QGzE
	mTz7LnDfG6Q9SiPoy4nhn5/e5RwmFfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-KX85CKpePRa_IJKHx6uM8Q-1; Tue, 01 Jul 2025 05:59:24 -0400
X-MC-Unique: KX85CKpePRa_IJKHx6uM8Q-1
X-Mimecast-MFC-AGG-ID: KX85CKpePRa_IJKHx6uM8Q_1751363964
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso27235055e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751363963; x=1751968763;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5FbtO3errtBpeKUR76CZ44Npcbx4IGE5AODLlZshxc=;
        b=uxgNlHtI4VrlDVO6WBXX8Zzle/rZhyo8N33iGsgXwPTGh8fuJ6ZyQzkY8nUIPpSQfr
         ZhxFmmtHTeMehuZoE1IgWz3aN+uvuO0j9brsmX6nSwMGZ/zEWD5AnDt8LCFjObdQSj9S
         G63JW5vCrAKWSozCwOcdhwM7oqb7FKc+dJfzDfsbPyUiAJ9x0uM+Ol60qiBwrMPIZVQw
         VqweawR9hUAy+OkG9eIq86uIFYwr+6BkHJxikXvPI7v+lkw1Xuy2MRb4tb2QSRwtzlXo
         ZxYLehGJO8ThBxmWlm9QGkCvfswxtwdxM7fU4NyfCR1W4+fexZfHWaGujpcu5XoPC8/o
         PvNw==
X-Forwarded-Encrypted: i=1; AJvYcCVOB7tsYYgdhOHzFMKwQcivHW5Hvb4lNENvFjsfMHMws9C8ts/KXAIC6gk0Fgy7NjFcU8GOeEvkvgWUk61v@vger.kernel.org
X-Gm-Message-State: AOJu0YyieGEeBuoOcaamuxv2cVuXZ2jbUSly3IPhFp8SUBqQww5Mi8xE
	Ixz5XqWKVGissh+dYKOiczXem/thSRJeG1zqBceUL/VmLn8Zr5WdfaAmA8tFJdVToyHcUeSjVNE
	VQB+aBrcVDMxB3hjX+p+Awgf6p5iTufzlhgO2dNWRzELknDuStKu/DuKhKJ1UGiar/QI=
X-Gm-Gg: ASbGncswFzz+gKCdrJXxZgZ+Z5k2lm9ZIxdJyUSwzAF5/LhDt5UFbVZY8K959/NvfCQ
	z0qAOzktCFehZIOgYI2Q7/9JsNDhE+Y3IqpkgfIQAMt+sppXJxrY8SG5KvWsGE2RCKa2nyYtlCO
	w7FIrZEgA3WB2z1hGNCHMMjn05ZyA2yCv3GBlEmO5hhTVFjhcF/U+RGQPek8DKEvUPvRLLQFavj
	OUObmOklctxzphY8KbIpOyI6TpZ0UhmtfWhyYChlDs/BVXXdPJ4QRKVvnwXFC5zD8BNLxUKteyu
	b82W4d+ntneX70lIEK/r7sTGjCJLC5PWPtdyqfO2JGft0n3hIlU4qvNfDp/C/OzgQ+YLfXgW+6W
	uK+9w3jwv647Qducy4HS4eGHmM8uRETmoGKfxS4dICE9T93zB+Q==
X-Received: by 2002:a05:600c:46d1:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-453a78b99f6mr28499285e9.1.1751363963538;
        Tue, 01 Jul 2025 02:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjLr31Z+2oCDlzuGbqPqujQfl0PqoJx+I5knwb0T0k9x67wj+nE45Xj7xMzEAJ3P+tl4wHBg==
X-Received: by 2002:a05:600c:46d1:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-453a78b99f6mr28498875e9.1.1751363963053;
        Tue, 01 Jul 2025 02:59:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7481sm12965847f8f.14.2025.07.01.02.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:59:22 -0700 (PDT)
Message-ID: <8652503b-f00e-46af-b4c0-bec60ebb15ac@redhat.com>
Date: Tue, 1 Jul 2025 11:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/29] mm/balloon_compaction: convert
 balloon_page_delete() to balloon_page_finalize()
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
 <20250630130011.330477-3-david@redhat.com>
 <f9cb1865-aa9d-409f-bce5-7051480c1a71@lucifer.local>
 <277e094d-b159-411f-940d-13b62493f6c5@redhat.com>
 <7b8a62f1-3e81-4012-8b44-219498f37152@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7b8a62f1-3e81-4012-8b44-219498f37152@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

>>>> -{
>>>> -	__ClearPageOffline(page);
>>>> -	__ClearPageMovable(page);
>>>> -	set_page_private(page, 0);
>>>> -	/*
>>>> -	 * No touch page.lru field once @page has been isolated
>>>> -	 * because VM is using the field.
>>>> -	 */
>>>> -	if (!PageIsolated(page))
>>>> -		list_del(&page->lru);
>>>
>>> I don't see this check elsewhere, is it because, as per the 1/xx of this series,
>>> because by the time we do the finalize
>>
>> balloon_page_delete() was used on two paths
>>
>> 1) Removing a page from the balloon for deflation through
>> balloon_page_list_dequeue()
>>
>> 2) Removing an isolated page from the balloon for migration in the
>> per-driver migration handlers. Isolated pages were already removed from the
>> balloon list during ... isolation.
>>
>> With this change, 1) does the list_del(&page->lru) manually and 2) only
>> calls balloon_page_finalize().
>>
>> During 1) the same reasoning as in 1/xx applies: isolated pages cannot be in
>> the balloon list.
> 
> Right yeah this is what I thought, thanks!

I'll add some of that to the patch description!

-- 
Cheers,

David / dhildenb


