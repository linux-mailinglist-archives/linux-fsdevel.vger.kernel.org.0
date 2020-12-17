Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1302DD31E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgLQOi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 09:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728461AbgLQOi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608215849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Brv5hAOrdVZM/2cjFYVrZbbhXdXhMs1UP02DsNy6U=;
        b=hG/J/T2W3klji1kugXoDVMO0CxwQMuGeeHJbmIJmX5SFReOHnErxrlNNpvvuhecN3Bc4FO
        XHutN+4Zch03IK52TunyDkCo68D/R1fyrXXAQrO9Ml4kCN9VskmoL+oj2Awjt4FhBUTUN1
        FSeC2BXEudrlxLp82IQVkA8en3jKxUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-ORagCgB5Oiik_vLQkzKqHA-1; Thu, 17 Dec 2020 09:37:24 -0500
X-MC-Unique: ORagCgB5Oiik_vLQkzKqHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11C4310B4529;
        Thu, 17 Dec 2020 14:36:01 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E93E75D71D;
        Thu, 17 Dec 2020 14:35:59 +0000 (UTC)
Subject: Re: [PATCH 00/25] Page folios
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201216182335.27227-1-willy@infradead.org>
 <9e764222-a274-0a99-5e41-7cfa9ea15b86@redhat.com>
 <20201217135517.GF15600@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2afc35eb-4f32-4376-9c2d-b4c411f4cb76@redhat.com>
Date:   Thu, 17 Dec 2020 15:35:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217135517.GF15600@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.20 14:55, Matthew Wilcox wrote:
> On Thu, Dec 17, 2020 at 01:47:57PM +0100, David Hildenbrand wrote:
>> On 16.12.20 19:23, Matthew Wilcox (Oracle) wrote:
>>> One of the great things about compound pages is that when you try to
>>> do various operations on a tail page, it redirects to the head page and
>>> everything Just Works.  One of the awful things is how much we pay for
>>> that simplicity.  Here's an example, end_page_writeback():
>>>
>>>         if (PageReclaim(page)) {
>>>                 ClearPageReclaim(page);
>>>                 rotate_reclaimable_page(page);
>>>         }
>>>         get_page(page);
>>>         if (!test_clear_page_writeback(page))
>>>                 BUG();
>>>
>>>         smp_mb__after_atomic();
>>>         wake_up_page(page, PG_writeback);
>>>         put_page(page);
>>>
>>> That all looks very straightforward, but if you dive into the disassembly,
>>> you see that there are four calls to compound_head() in this function
>>> (PageReclaim(), ClearPageReclaim(), get_page() and put_page()).  It's
>>> all for nothing, because if anyone does call this routine with a tail
>>> page, wake_up_page() will VM_BUG_ON_PGFLAGS(PageTail(page), page).
>>>
>>> I'm not really a CPU person, but I imagine there's some kind of dependency
>>> here that sucks too:
>>>
>>>     1fd7:       48 8b 57 08             mov    0x8(%rdi),%rdx
>>>     1fdb:       48 8d 42 ff             lea    -0x1(%rdx),%rax
>>>     1fdf:       83 e2 01                and    $0x1,%edx
>>>     1fe2:       48 0f 44 c7             cmove  %rdi,%rax
>>>     1fe6:       f0 80 60 02 fb          lock andb $0xfb,0x2(%rax)
>>>
>>> Sure, it's going to be cache hot, but that cmove has to execute before
>>> the lock andb.
>>>
>>> I would like to introduce a new concept that I call a Page Folio.
>>> Or just struct folio to its friends.  Here it is,
>>> struct folio {
>>>         struct page page;
>>> };
>>>
>>> A folio is a struct page which is guaranteed not to be a tail page.
>>> So it's either a head page or a base (order-0) page.  That means
>>> we don't have to call compound_head() on it and we save massively.
>>> end_page_writeback() reduces from four calls to compound_head() to just
>>> one (at the beginning of the function) and it shrinks from 213 bytes
>>> to 126 bytes (using distro kernel config options).  I think even that one
>>> can be eliminated, but I'm going slowly at this point and taking the
>>> safe route of transforming a random struct page pointer into a struct
>>> folio pointer by calling page_folio().  By the end of this exercise,
>>> end_page_writeback() will become end_folio_writeback().
>>>
>>> This is going to be a ton of work, and massively disruptive.  It'll touch
>>> every filesystem, and a good few device drivers!  But I think it's worth
>>> it.  Not every routine benefits as much as end_page_writeback(), but it
>>> makes everything a little better.  At 29 bytes per call to lock_page(),
>>> unlock_page(), put_page() and get_page(), that's on the order of 60kB of
>>> text for allyesconfig.  More when you add on all the PageFoo() calls.
>>> With the small amount of work I've done here, mm/filemap.o shrinks its
>>> text segment by over a kilobyte from 33687 to 32318 bytes (and also 192
>>> bytes of data).
>>
>> Just wondering, as the primary motivation here is "minimizing CPU work",
>> did you run any benchmarks that revealed a visible performance improvement?
>>
>> Otherwise, we're left with a concept that's hard to grasp first (folio -
>> what?!) and "a ton of work, and massively disruptive", saving some kb of
>> code - which does not sound too appealing to me.
>>
>> (I like the idea of abstracting which pages are actually worth looking
>> at directly instead of going via a tail page - tail pages act somewhat
>> like a proxy for the head page when accessing flags)
> 
> My primary motivation here isn't minimising CPU work at all.  It's trying

Ah, okay, reading about disassembly gave me that impression.

> to document which interfaces are expected to operate on an entire
> compound page and which are expected to operate on a PAGE_SIZE page.
> Today, we have a horrible mishmash of
> 
>  - This is a head page, I shall operate on 2MB of data
>  - This is a tail page, I shall operate on 2MB of data
>  - This is not a head page, I shall operate on 4kB of data
>  - This is a head page, I shall operate on 4kB of data
>  - This is a head|tail page, I shall operate on the size of the compound page.
> 
> You might say "Well, why not lead with that?", but I don't know which
> advantages people are going to find most compelling.  Even if someone
> doesn't believe in the advantages of using folios in the page cache,
> looking at the assembler output is, I think, compelling.

Personally, I think the implicit documentation of which type of pages
functions expect is a clear advantage. Having less code is a nice cherry
on top.

-- 
Thanks,

David / dhildenb

