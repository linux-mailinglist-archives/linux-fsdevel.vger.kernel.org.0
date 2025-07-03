Return-Path: <linux-fsdevel+bounces-53772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809EAF6BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E04A1C24F29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6A298CC0;
	Thu,  3 Jul 2025 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcRpdVog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8AEED7
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528738; cv=none; b=J+X0hb2YKAbmHZ0xxYjngB/QIiHE2K4DpP+m0d9mnXXJdyzeuB/TQE9HHZDbl8+v904tHT4uAaLojgjp9kKMJdmwfaqjpSDItsB7IRB+slGoh7nOROp/+yLCyhmJ6LTiTi4HK1mobehgVqKFPX1fFtxkB1Ka3ueK/jaRuq6gMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528738; c=relaxed/simple;
	bh=/WEvDghZh/eBp6pZbpWMhAbauOIfrWBiYWBD7URA+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pq+O1kcaEYxgzoIFxGWeIO1FsRiVWEroo1/c/ylHk62GQyOO7zqW5pTV6bo+51OamxrOqrnH2MMu/68EOhiqrlDIHhGgZgeohHY4jzFhqf3VG40VwlOHuyf/TFwSTXIWoWh8jE7+2gJjFrbKWsoeH7B3WWI2oF9N2eB0S8c2UX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcRpdVog; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751528735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WPP1PRWhtmPHNfolpuSgWHE9hj7dLgaAzKr9Pb92+J8=;
	b=EcRpdVoguRsQwKMFGk6pwCpNPftTXh4JzNJzGSSTZmDuLBFn++VY6LkyjizluGNE8lumEm
	EMgg4qGcKIxZKYV0aiozaVNCZtOAYccsiwDxFUxH/5F0KhRtKZrYAVaOcUoRSqfZkyWWWh
	bjrj6l2J/OG/zdo+Uyp2pSJ/Tqc+Kx8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-VauAWw6oOFySHS0XjpJkQg-1; Thu, 03 Jul 2025 03:45:34 -0400
X-MC-Unique: VauAWw6oOFySHS0XjpJkQg-1
X-Mimecast-MFC-AGG-ID: VauAWw6oOFySHS0XjpJkQg_1751528733
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb94dbd01fso416684166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 00:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528733; x=1752133533;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WPP1PRWhtmPHNfolpuSgWHE9hj7dLgaAzKr9Pb92+J8=;
        b=oC5UAsvaBVswL6rx680dpeN/MjI6ek2CpABaTNauQ1aj0rR/E27oLZQkMKEbVGy/Ns
         RWH/7esTTzdHvDGpZhS8VOURYeoZApmsMRA158kNddM5/JYFfLGvgQru50nxPp4SWElw
         heXdKrWNnpC8/ZGR0xom083iJ9QrCYzYyyMtIfATxPyyp8dWye887d/sSL1kWqYNHsvV
         fcYISAf81eSJnrl1qY3n5ivTdcq4ra4WYWw1zI1n3gFf1FhLvygFkoB5PZh1V+BG3oTS
         yOyvPbX+dxmPJcgJsODCn61e/Bx0EWMNU09FMoKavvgNdf/5MflDldwIcB7N1Uoer4NZ
         7VjA==
X-Forwarded-Encrypted: i=1; AJvYcCX+aNedg6zio0KbG6ETcxFo5dia1/m96BUQG4DqSW7j3+ytVNtWSlP/4bG5C+fGjJUo47+AQZMi8yiwqsXf@vger.kernel.org
X-Gm-Message-State: AOJu0YwYiBBO6LYUr4vHLmOb7Q4eTjTDecNj9nfEnfPcXFTaBWmbWe+1
	ZiZ2LYODwGOwoO6RwysGXzLX3owIT+iJu2XJYI+ZyPR+LTZCYV966TfntrfHyiQ4pWQ9bdOzGGb
	mr39cvoSDcnVNrNiiuRUKNk0DaXQvxOyP4p5ZGpzPxJzWFk6vlDlgO7kTbtOg/m8zN/M=
X-Gm-Gg: ASbGnctCmENVvJfOXkpj8tgLHqYl8mFisKod/eTeRMq/Ek6dsiX+j10ooc1h1CIGaBC
	jknGqIXLHWRWeK7kF2bp3WgMaoDq+AVoFol9jy3FC2gpNOxai4n3RpWEjtaBDxF3QvGRJANNcEm
	hAtV6Ht+koE9ls31WfN25bduuluS4MIDnZSiRdtHKMf5XpipDsqdlkIioIFEfbF3b0O1kuiYFgZ
	/Svix1v9ZRvH0E3lSeOlvUixpqN5FDh9fL5UoRnbZ2mpkdJfkSuVNusrlWhIYaszEQu76dl8gMS
	grV6pmUvVvjRuY29vLtz3GiGCvCSd4IlvbaiyWAarz/q
X-Received: by 2002:a17:907:3cd3:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-ae3d84f7f66mr193260466b.35.1751528732658;
        Thu, 03 Jul 2025 00:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9dut9O3e981QeFm7ijgo302R9iI7Vl24WdUyqyOYprtZmMn909rbBKXFTDk2fblCy/fN7iA==
X-Received: by 2002:a17:907:3cd3:b0:ae3:6651:58ba with SMTP id a640c23a62f3a-ae3d84f7f66mr193254666b.35.1751528732009;
        Thu, 03 Jul 2025 00:45:32 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c015b8sm1214932266b.78.2025.07.03.00.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 00:45:31 -0700 (PDT)
Message-ID: <6a83e3e1-ab1d-409b-8395-df363321cade@redhat.com>
Date: Thu, 3 Jul 2025 09:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
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
 Minchan Kim <minchan@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-13-david@redhat.com>
 <zmsay3nrpmjec5n7v44svfa7iwl6vklqan4dgjn4wpvsr5hqt7@cqfwdvhncgrg>
 <757cf6b9-730b-4b12-9a3d-27699e20e3ac@redhat.com>
 <ugm7j66msq2w2hd3jg3thsxd2mv7vudozal3nblnfemclvut64@yp7d6vgesath>
 <11de6ae0-d4ec-43d5-a82e-146d82f17fff@redhat.com>
 <5thkl2h5qan5gm7putqd4o6yn5ht2c5zeei5qbjoni677xr7po@kbfokuekiubj>
 <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <vscedd6m3cq73c5ggjjz6ndordivgeh4dmvzeok222bnderr5c@dujm4ndthtxb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 05:22, Sergey Senozhatsky wrote:
> On (25/07/03 11:28), Sergey Senozhatsky wrote:
>>>>>>>     static int zs_page_migrate(struct page *newpage, struct page *page,
>>>>>>> @@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>>>>>>>     	unsigned long old_obj, new_obj;
>>>>>>>     	unsigned int obj_idx;
>>>>>>> +	/*
>>>>>>> +	 * TODO: nothing prevents a zspage from getting destroyed while
>>>>>>> +	 * isolated: we should disallow that and defer it.
>>>>>>> +	 */
>>>>>>
>>>>>> Can you elaborate?
>>>>>
>>>>> We can only free a zspage in free_zspage() while the page is locked.
>>>>>
>>>>> After we isolated a zspage page for migration (under page lock!), we drop
>>>>                         ^^ a physical page? (IOW zspage chain page?)
>>>>
>>>>> the lock again, to retake the lock when trying to migrate it.
>>>>>
>>>>> That means, there is a window where a zspage can be freed although the page
>>>>> is isolated for migration.
>>>>
>>>> I see, thanks.  Looks somewhat fragile.  Is this a new thing?
>>>
>>> No, it's been like that forever. And I was surprised that only zsmalloc
>>> behaves that way
>>
>> Oh, that makes two of us.
> 
> I sort of wonder if zs_page_migrate() VM_BUG_ON_PAGE() removal and
> zspage check addition need to be landed outside of this series, as
> a zsmalloc fixup.

Not sure if there is real value for that; given the review status, I 
assume this series won't take too long to be ready for upstream. Of 
course, if that is not the case we could try pulling them out.

-- 
Cheers,

David / dhildenb


