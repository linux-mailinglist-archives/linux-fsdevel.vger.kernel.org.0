Return-Path: <linux-fsdevel+bounces-58142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5223B2A069
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23ECE7B1E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7631CA58;
	Mon, 18 Aug 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4v5ROuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF43331AF1E
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516511; cv=none; b=fPU/64qR2vVIFNUt/R3CiwzswAZmAgoxfnhzdAT4ZRWaMHub/+Qc8ogLMTjQGZAyf5kgn+2TlA6fRlKTOFRlMIM1D22nswkm3id8sG6QygZEn5vfubhR51O/LepkWW4doPURBYhNmbxVBKTdAn7gn0QkR1V+ePedkAzvD/KKgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516511; c=relaxed/simple;
	bh=VY8634xpHXk7cZiYCL2JpatoZSb7xQVGRxlqHFOaah0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqpqjooUl4bXBamv8eoDKHYjaVLlenORK3bnLl18vd0aYuzfuPvtHNzUzSXTE+4ZCnZY3OQ9UB4rkA0RsnIjpcvrikYKHxr+dr/yCBkT2oAgrkiDe1jAL+hp4+vtdj077laR+EFaWS0kYdYukYqpBnOXHhzMcCkb9jdRiae+ttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4v5ROuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755516508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J0poHkf7IJxzNGcjiPzQE+7iEkpA1901ZpOaMVbBkbk=;
	b=Z4v5ROuSMIsUYsQ550OSnBuw4T3qh5Np8rkOURSaWI8sre0uWbOX9G4i8z/H19ID6pWZTL
	IANTWBTJZQ6luFiclDuIY4F8OmsAVl5QdpWVntEJH2Y3nfucX7UW5KkYro8HS7yt93SAqw
	E7u2mCgpJWqsAlho5H/IO+9F0cSTX2w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-c-rBCoZMPB6OiWj4ijeClw-1; Mon, 18 Aug 2025 07:28:27 -0400
X-MC-Unique: c-rBCoZMPB6OiWj4ijeClw-1
X-Mimecast-MFC-AGG-ID: c-rBCoZMPB6OiWj4ijeClw_1755516506
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41c245fso3286649f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 04:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516506; x=1756121306;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0poHkf7IJxzNGcjiPzQE+7iEkpA1901ZpOaMVbBkbk=;
        b=puETaoi4YRv36yw2euA3StsDOsU7jVuMR0ow7/WS1F1WExebBrjcXJk5bo8WefkJ4F
         fPvLaEF5SrUgT3ON9FmYP4i1l9FVSv6iruvOEzSrUm920JdhFyCBHY7BH1+iE9pGe5nL
         XTkJRwaL6/X+st9Gjg3l06Zb/Lwll8MgriANDOvZS/ZgeRa+2QpRrLf9mckFnbtlsQrj
         Fcu5/3KYloTcHqxLxhGmSjc5JAKh6pd60P+kJZtZnjJ4R4Px9uWiVkgEqXgbkQMbrRJ9
         8Q6Wt0V40eermfOYjnK73bcVinEw9tH0SRvRpCti9I5DiarJzims/9oapHqmVUlaWu2N
         UNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTFQhzcejcwN6yQ5AFSaoDy4Amuiy0JrWuG0K0OtVH+RcqBXqf+Tt4sQi7TClQz5tFxzCs2evFnHW6Tizl@vger.kernel.org
X-Gm-Message-State: AOJu0YwySijfgJOps6w39dHFFzWzc9q5YH27Ws6+XJZ0OQ7XcEJL3CLd
	8ffwgGkq6EMgckUfQ1ecTHn9cC3psFN/pWd0Ae3EjvhT1khxo2BstV9I1AVp+5iPz442V240/44
	7PjAjwMWCXaEq0xHj4XkWPN+l2AtAWtjAGD4/q712HacXTVUdT5oI1I/ZV/wZn7gBTok=
X-Gm-Gg: ASbGncsfQwb4bTRWdF/wjEugpP5zO8Bw2ulkgad1l3JtioPdHhLw4q4hbPDwXkoTdXX
	yP619WMFmeY/AgTEkIGLrt16LhlwiYj+zNXqYBBmP3OTctV2t+U5qhA0psgC/bYBXMbcmjSAVMF
	hux6Oa7R1YykbcVsxEEldfyFdjHwu7fTRqfGa2a995+3qmKzcYZDNm88BMG/aYvq7Qsnt/Pjqrk
	UfM4uF0ltWcGfyc1ksuCxvDyHCKiK59E3OZEuTpn8kSG8+jyAQ7KweGDCY4BdZ3MIpuvRMHJS9x
	bZ3sGmBqj3CkZOaUYlSgodP/pJ+YrmuRDGvBsZ/R1OwgdzcERNohXL49bjL2Q8vMVSADmw==
X-Received: by 2002:a05:6000:2301:b0:3bb:2fb3:9c7e with SMTP id ffacd0b85a97d-3bb674db9eemr9706766f8f.21.1755516505954;
        Mon, 18 Aug 2025 04:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJ2j4tybVSbT2mQ2UN8mZP25LV2c4F54aus7k4qiE296Q/C3YEoCeE99f3tiBsFkHDADQDg==
X-Received: by 2002:a05:6000:2301:b0:3bb:2fb3:9c7e with SMTP id ffacd0b85a97d-3bb674db9eemr9706715f8f.21.1755516505387;
        Mon, 18 Aug 2025 04:28:25 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a246.dip0.t-ipconnect.de. [87.161.162.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22211395sm129258685e9.4.2025.08.18.04.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:28:24 -0700 (PDT)
Message-ID: <3bb725f8-28d7-4aa2-b75f-af40d5cab280@redhat.com>
Date: Mon, 18 Aug 2025 13:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/migrate: remove MIGRATEPAGE_UNMAP
To: Lance Yang <lance.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-2-david@redhat.com>
 <CABzRoyYU2yOuGQskCAG_gzKiQwR6uM9eAYqOOCoQj+Xv=r163A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CABzRoyYU2yOuGQskCAG_gzKiQwR6uM9eAYqOOCoQj+Xv=r163A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.08.25 07:05, Lance Yang wrote:
> On Mon, Aug 11, 2025 at 10:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
> [...]
>> +++ b/mm/migrate.c
>> @@ -1176,16 +1176,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>          bool locked = false;
>>          bool dst_locked = false;
>>
>> -       if (folio_ref_count(src) == 1) {
>> -               /* Folio was freed from under us. So we are done. */
>> -               folio_clear_active(src);
>> -               folio_clear_unevictable(src);
>> -               /* free_pages_prepare() will clear PG_isolated. */
>> -               list_del(&src->lru);
>> -               migrate_folio_done(src, reason);
>> -               return MIGRATEPAGE_SUCCESS;
>> -       }
>> -
>>          dst = get_new_folio(src, private);
>>          if (!dst)
>>                  return -ENOMEM;
>> @@ -1275,7 +1265,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>
>>          if (unlikely(page_has_movable_ops(&src->page))) {
>>                  __migrate_folio_record(dst, old_page_state, anon_vma);
>> -               return MIGRATEPAGE_UNMAP;
>> +               return 0;
>>          }
>>
>>          /*
>> @@ -1305,7 +1295,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>
>>          if (!folio_mapped(src)) {
>>                  __migrate_folio_record(dst, old_page_state, anon_vma);
>> -               return MIGRATEPAGE_UNMAP;
>> +               return 0;
>>          }
>>
>>   out:
>> @@ -1848,14 +1838,28 @@ static int migrate_pages_batch(struct list_head *from,
>>                                  continue;
>>                          }
>>
>> +                       /*
>> +                        * If we are holding the last folio reference, the folio
>> +                        * was freed from under us, so just drop our reference.
>> +                        */
>> +                       if (likely(!page_has_movable_ops(&folio->page)) &&
>> +                           folio_ref_count(folio) == 1) {
>> +                               folio_clear_active(folio);
>> +                               folio_clear_unevictable(folio);
>> +                               list_del(&folio->lru);
>> +                               migrate_folio_done(folio, reason);
>> +                               stats->nr_succeeded += nr_pages;
>> +                               stats->nr_thp_succeeded += is_thp;
>> +                               continue;
>> +                       }
>> +
> 
> It seems the reason parameter is no longer used within migrate_folio_unmap()
> after this patch.
> 
> Perhaps it could be removed from the function's signature ;)

Thanks, well spotted, @Andrew can you squash the following?


 From 40938bb0de20e03250c813d5abc7286aea69d835 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Aug 2025 13:26:05 +0200
Subject: [PATCH] fixup: mm/migrate: remove MIGRATEPAGE_UNMAP

No need to pass "reason" to migrate_folio_unmap().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/migrate.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2db4974178e6a..aabc736eec022 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1166,7 +1166,7 @@ static void migrate_folio_done(struct folio *src,
  static int migrate_folio_unmap(new_folio_t get_new_folio,
  		free_folio_t put_new_folio, unsigned long private,
  		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		enum migrate_reason reason, struct list_head *ret)
+		struct list_head *ret)
  {
  	struct folio *dst;
  	int rc = -EAGAIN;
@@ -1852,8 +1852,7 @@ static int migrate_pages_batch(struct list_head *from,
  			}
  
  			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
-					private, folio, &dst, mode, reason,
-					ret_folios);
+					private, folio, &dst, mode, ret_folios);
  			/*
  			 * The rules are:
  			 *	0: folio will be put on unmap_folios list,
-- 
2.50.1


-- 
Cheers

David / dhildenb


