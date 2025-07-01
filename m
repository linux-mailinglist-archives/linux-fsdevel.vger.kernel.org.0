Return-Path: <linux-fsdevel+bounces-53457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3A6AEF335
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1707A489A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC626B0A7;
	Tue,  1 Jul 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw/bk6GZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230C33EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361906; cv=none; b=fKXz0hrh8F0UfeXOORP7hSSr5lam3Y+bURRuVKFQTLcuf2WhBAOZgT7sR0A5pxkLnRAi2916oKn4cFBKmpjHk6kuY2SlJN6bRx3pFYf1YmwOo14ouq5gJIKD8FeX86HeV0eCv5RTcWKa52xosgj7IOx0TaNysqNvsRgFL9K/fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361906; c=relaxed/simple;
	bh=eKtvOF/O6DVWFqGwmxy3yJHBDdURCCo5VIuglIv21Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ax+SLjiKfbH1xBAyUwqQ9Jhapr1Pas1LzIP/1WRdfx8QT1BCyxeU5URXVThKSPumJnhrJqrN/8uBW8wkfGD6ZKe6rp+5fzy1iVN/5ntnzKhAf4ib832T2R+i5PKNvgcZ/AUJjTOgUX7m6bc4qqwXzES9FGOGkisBzVpPZERib8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pw/bk6GZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751361904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ynjR0kQ0fShmUa4WToi2Rue41qtJI6unNyjCyC0vuW0=;
	b=Pw/bk6GZ/MgUcKzrjQ9SmQ+hi8P1UBBIa+F9BdGoEVosvCegJMVUeZnSYpOnx62cY5POSL
	x9z12FmFJBYgHxn2RSyY2tjAwEmX60WKOKpqH9ff6xHBhCPfWFO8yaVQqzVszooO4DAQJZ
	0fCTBjB59NVyJHL8Zd25UfMRnPAI9Fg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-2MFVV7DoPpysz33fqkrlMw-1; Tue, 01 Jul 2025 05:25:03 -0400
X-MC-Unique: 2MFVV7DoPpysz33fqkrlMw-1
X-Mimecast-MFC-AGG-ID: 2MFVV7DoPpysz33fqkrlMw_1751361902
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so24626955e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361902; x=1751966702;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ynjR0kQ0fShmUa4WToi2Rue41qtJI6unNyjCyC0vuW0=;
        b=dhQtIIeO9SmSWnQ/OpImqpXf0WOIHe66OufSWTtc3rS9mDy22xh2KwXTFx2czRJNbm
         KdzRGrzfhPGIU/9ZpeI57jW8APQKykt4tAGRKSNI63mm3+B7eLqCpAdCD3LXrTjfoGNB
         azWVw8x1rkhjL+NFrzjUOJjX0Ta2p1vYJjQ8BpWhccEeCEN4OOHxAXjnWeeDBfoZ21AB
         +VtZGOe18/wbi6UjD2cUJbOJ2WvcFRwznbVR3g8Zclu0t+C+kbkPKcNmPpiabMF6rMq7
         Y8RWV8yU0JtnEitGwCEY2rUJgCWij2xv25jERPPMyDa5DVOpPETqcMnXhKep8po3Lifx
         xT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIVScsA91vQC4f4/ikBnDj64tPunqTy9fr64VLrCrah+zD3c3Et83j736M1MaRES4TDVf3nanaLtukAj+v@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqdoOu92DNJm6eHWull7VB2RJ9d/qSC9f/nATmMuxaAd42g7s
	re1lxxMI6e1CsRi60nxGcdTVRgE2hm7I/pdwsFsQ8viQhQHeO2aCmmjVCZKH6QzgXlO0WruDPa2
	X/WYx4vlBjzm/K3Fq/5EI+d5POv1Mw4pjC/Cd9iIk3w9d9Z/7DgRZgge7u0DXlCDhoow=
X-Gm-Gg: ASbGncu0gFCi4InjA9N8C/RcfOXCyWRn4/lDBiMUPNAbsixFdCH9ZPqIxGg09Ojdvqm
	YNH8NC8QleKdOkONfqptkL0IszPv3w7/dtlY7FCLJYa2Bq7Aulqq7fj/tfB4/LI3fRuQ1Zi1bQK
	V410Z/TxJCku4HQscMaKP1UCVR6Gs56nqnTbtEHwwEKRULRP+mNWk65Qvos9cIN3bpAH1k6A+r1
	D5SOcqODRd0DTJ/nqPdhUxgmaOROKukg8GPgysPdflS5Vlll+BIHdzlvxnoe4+6skbN9v3kLWtr
	atjzkxsOKaJYWxOR30ioqxts7WE6MycZ9kEe3VeIqg00pSqJZgwiwjtQtNvDI9blkYNHnJZO2nX
	GYtP1sWzGiTgiQ+Pw19/7pJI5UAz2b9O4/2FuJvmRf4TywIJujw==
X-Received: by 2002:a05:600c:1547:b0:453:cd0:903c with SMTP id 5b1f17b1804b1-453a8fc441emr17175255e9.2.1751361901668;
        Tue, 01 Jul 2025 02:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlI/8QcsDScEYDDG6CGN+xpXCz1imHCjrckMLG1KJbTRfOfaLTvU+UPbg5H3zNV4uNR6I7DA==
X-Received: by 2002:a05:600c:1547:b0:453:cd0:903c with SMTP id 5b1f17b1804b1-453a8fc441emr17174585e9.2.1751361901043;
        Tue, 01 Jul 2025 02:25:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6c21sm189841875e9.29.2025.07.01.02.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:25:00 -0700 (PDT)
Message-ID: <315c5e9a-8fbf-4b9c-98b2-1ea69065af85@redhat.com>
Date: Tue, 1 Jul 2025 11:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/29] mm/migrate: factor out movable_ops page handling
 into migrate_movable_ops_page()
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6aba66e6-0bc5-4afb-a42c-a85756716e1c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 19:05, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:50PM +0200, David Hildenbrand wrote:
>> Let's factor it out, simplifying the calling code.
>>
>> The assumption is that flush_dcache_page() is not required for
>> movable_ops pages: as documented for flush_dcache_folio(), it really
>> only applies when the kernel wrote to pagecache pages / pages in
>> highmem. movable_ops callbacks should be handling flushing
>> caches if ever required.
> 
> But we've enot changed this have we? The flush_dcache_folio() invocation seems
> to happen the same way now as before? Did I miss something?

I think, before this change we would have called it also for movable_ops 
pages


if (rc == MIGRATEPAGE_SUCCESS) {
	if (__folio_test_movable(src)) {
		...
	}

	...

	if (likely(!folio_is_zone_device(dst)))
		flush_dcache_folio(dst);
}

Now, we no longer do that for movable_ops pages.

For balloon pages, we're not copying anything, so we never possibly have 
to flush the dcache.

For zsmalloc, we do the copy in zs_object_copy() through kmap_local.

I think we could have HIGHMEM, so I wonder if we should just do a 
flush_dcache_page() in zs_object_copy().

At least, staring at highmem.h with memcpy_to_page(), it looks like that 
might be the right thing to do.


So likely I'll add a patch before this one that will do the 
flush_dcache_page() in there.

> 
>>
>> Note that we can now change folio_mapping_flags() to folio_test_anon()
>> to make it clearer, because movable_ops pages will never take that path.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Have scrutinised this a lot and it seems correct to me, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>>   mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
>>   1 file changed, 45 insertions(+), 37 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index d97f7cd137e63..0898ddd2f661f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -159,6 +159,45 @@ static void putback_movable_ops_page(struct page *page)
>>   	folio_put(folio);
>>   }
>>
>> +/**
>> + * migrate_movable_ops_page - migrate an isolated movable_ops page
>> + * @page: The isolated page.
>> + *
>> + * Migrate an isolated movable_ops page.
>> + *
>> + * If the src page was already released by its owner, the src page is
>> + * un-isolated (putback) and migration succeeds; the migration core will be the
>> + * owner of both pages.
>> + *
>> + * If the src page was not released by its owner and the migration was
>> + * successful, the owner of the src page and the dst page are swapped and
>> + * the src page is un-isolated.
>> + *
>> + * If migration fails, the ownership stays unmodified and the src page
>> + * remains isolated: migration may be retried later or the page can be putback.
>> + *
>> + * TODO: migration core will treat both pages as folios and lock them before
>> + * this call to unlock them after this call. Further, the folio refcounts on
>> + * src and dst are also released by migration core. These pages will not be
>> + * folios in the future, so that must be reworked.
>> + *
>> + * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
>> + * code.
>> + */
> 
> Love these comments you're adding!!
> 
>> +static int migrate_movable_ops_page(struct page *dst, struct page *src,
>> +		enum migrate_mode mode)
>> +{
>> +	int rc = MIGRATEPAGE_SUCCESS;
> 
> Maybe worth asserting src, dst locking?

We do have these sanity checks right now in move_to_new_folio() already. 
(next patch moves it further out)

Not sure how reasonable these sanity checks are in these internal 
helpers: E.g., after we called move_to_new_folio() we will unlock both 
folios, which should blow up if the folios wouldn't be locked.

-- 
Cheers,

David / dhildenb


