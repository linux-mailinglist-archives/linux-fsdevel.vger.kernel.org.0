Return-Path: <linux-fsdevel+bounces-53433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7FAEF0E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FB03AAADE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013FD26A1B4;
	Tue,  1 Jul 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFRQ+Hd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2B264625
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358105; cv=none; b=b8dQof2D6uzv2eaGcWV6d91YSzO3rKKA6LzJxCmPL6dWw+I9S8UxkAjHZutQLJUkp6WfaGSBx/EWaxr9LRQksWuAAKSJmRQgov5elaBpVyjmSbmynP/vXA1xpiovOo6Li5u8GZNSeJhCoFbNr7Pf0CwS3seUMs6jQK815Xy/fQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358105; c=relaxed/simple;
	bh=+SuyiktXR37G2R9b40YH3OZ+pae2R3cOKlsq8oWBsaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAcXxPVHLpc68OcqM1dijMBgi063Jr8XHZrSrh5A4Iiy/HG1nTOtLtTlKuWQaiBoNC+mRO67Ys+yDYcV/LozowS74X49KPQx4olQjTno1iAxBrXAAYsbGqdZ7WE4+YIxt4CvMmRFERL8KmX8crZw4iBSAPGz1S/fnTWQjgVlppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFRQ+Hd7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751358102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cxU0Ib3KCq9mplKVbTFzx/9NyzfjMRXnNip2tiGw51Q=;
	b=WFRQ+Hd7vMd7Whc2tkPhw+UcdrnRfqgIeOWSNkiDSQxPjx1fNmhwKCbKlAzybb47rAUa08
	eOlDK2gBVPopSi5CVEVmzQ3JIfrFosoa5KVw1BRZYDa49cnNZJdV6o6dhWs7I+US25B5dz
	hOrejrH0uTounQz6lhH6Za8V8ACyL50=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-XokkxpZNNXSliuZ11mo6cg-1; Tue, 01 Jul 2025 04:21:40 -0400
X-MC-Unique: XokkxpZNNXSliuZ11mo6cg-1
X-Mimecast-MFC-AGG-ID: XokkxpZNNXSliuZ11mo6cg_1751358099
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-addcea380fcso214066866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 01:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751358099; x=1751962899;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cxU0Ib3KCq9mplKVbTFzx/9NyzfjMRXnNip2tiGw51Q=;
        b=FMhjnR+suas5mI3+5dcFjpSkWZcojj/sQo66Z/0u+1Xq+bxA5/T2oxASJmYI5K19NT
         eoGDhaomqW0sNdbsQEg86/row4iUg0yVoAHEIrBvdej/rKGh1vKMHD7zaE5aPGiGNS5p
         jbFvKRN3SeNcL5IQ6BhM5lllsQx/3uTqfBwFr00pzlj7h2Y5f27jQ6XDZbFq+r9b1zRb
         FPRmNf8cEWmHGuj3BfaGE8zDUafvBI2BRVuHN6m03TLFA0+F6ghwHl8lBS5H8wf6pbTI
         qSZxL9MpTztnxyfUerOzHLlVZaCOrt/nmFEQMSVNQB2x425w8ciYy9w+/4l3oyf2gmAr
         OIfg==
X-Forwarded-Encrypted: i=1; AJvYcCXPvy0PrnOdCXAq3TlblWbu+l61D4QTnkK3XdTcWybvUEQCOxh6LILx3HfKcg74q0/fjQO2EhqIyHt9XqRc@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrpHYlZhsK7618sE9zwbWDQrDT+ebAM0mI0oZMZMV8aSmmKDl
	5ybzFSN8n8+0d6reU/0DppLG3Lm2Om618Ksecjh6rqhfUQ+LmcQsuXiNHPpA0+QmLdVccpn9+z/
	olmW7CO8xnzpXAMn5yRS9hOiSB1xbO3AnOsVs8+m8rm1A8iWcChukOPA1Xinjz+hKagM=
X-Gm-Gg: ASbGncs3DrL9xJ+J56SfbjNf2QjKZIyj0IvByi+mmo3+bbINbFrQGJljlEAWS7sz9h4
	YqpRNg6m6TEHfVaNFnWMCX6TGHEyAfman9rB/5s8c8FKTvcGwVuKcdK4WRwQrFqIHXbkG00xwUI
	wdvkY/2Bql6VJcD92t5pLBtm8OEL6y5Q9jBPuJjW2tnMN4p0eYJjhgY7l9OG1Ib4s4PtlB2hI/R
	RS7h6B4rnd5GczCVGkaqJ21J2F3yvrjdOH7RMwO++bIkV1N8vYn/kfk29NFq78Ry73rQnJC/NRw
	WX+35Kb50mpU/sCB6VColg1TDeS7gYirfGwPVN3WUs7UTtlFupWSpKB2Qyuo+fzrQNS7d1B3ayu
	HU6HsoWqxh5Huap530NcrmW0Nf10A5VNvVyVpyM1cAbx5rXVEWQ==
X-Received: by 2002:a17:907:78a:b0:ad9:85d3:e141 with SMTP id a640c23a62f3a-ae35016b6d8mr1560669866b.53.1751358098835;
        Tue, 01 Jul 2025 01:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQkcTzHwrlDjllUz0WAed9m3pQuwaJybhBgPe9TiWCmEVaIWiUlRTDH+dtrhI3ojD+spG9Mg==
X-Received: by 2002:a17:907:78a:b0:ad9:85d3:e141 with SMTP id a640c23a62f3a-ae35016b6d8mr1560664266b.53.1751358098284;
        Tue, 01 Jul 2025 01:21:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b42asm816876766b.25.2025.07.01.01.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:21:37 -0700 (PDT)
Message-ID: <00d8e03d-c36f-47b6-919f-00a411ea6fd8@redhat.com>
Date: Tue, 1 Jul 2025 10:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky
 until the page is freed
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
 <20250630130011.330477-6-david@redhat.com>
 <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 18:01, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
>> Let the page freeing code handle clearing the page type.
> 
> Why is this advantageous? We want to keep the page marked offline for longer?

Less code? ;)

I will add:

"Being able to identify balloon pages until actually freed is a 
requirement for upcoming movable_ops migration changes."

Note that the documentation is extended in patch #27 to mention that.

> 
>>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> On assumption this UINT_MAX stuff is sane :)) I mean this is straightforward I
> guess:
 > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>>   include/linux/balloon_compaction.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
>> index b9f19da37b089..bfc6e50bd004b 100644
>> --- a/include/linux/balloon_compaction.h
>> +++ b/include/linux/balloon_compaction.h
>> @@ -140,7 +140,7 @@ static inline void balloon_page_finalize(struct page *page)
>>   		__ClearPageMovable(page);
>>   		set_page_private(page, 0);
>>   	}
>> -	__ClearPageOffline(page);
>> +	/* PageOffline is sticky until the page is freed to the buddy. */
> 
> OK so we are relying on this UINT_MAX thing in free_pages_prepare() to handle this.

Yes. Resetting the page_type -> _mapcount to the initial value -1.

-- 
Cheers,

David / dhildenb


