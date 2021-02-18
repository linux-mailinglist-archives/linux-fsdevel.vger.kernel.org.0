Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768A131E772
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 09:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhBRI2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 03:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231137AbhBRI0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613636675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/ZLB+LGzU8OCPH9fs/lC8xxc437w5UN3WLlRuc6l1s=;
        b=RcZjhCg2vBesepTcANxga0Gkj5wW0HkSHbEVlKSgrIDTNKiUF2Hcq2q2HAxvrAXXcy0bIb
        57tq9VuDy6iEyIMweEOvXWdRlAKq45I5NyCOZSTDXuvWRYCod+4jZ/HnFbFrd7ovairtn3
        aGEuTQc0RBor2iIXTCmHsU+sBqUyLKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-idMIFum9OKKWuzNa2wzPYA-1; Thu, 18 Feb 2021 03:24:32 -0500
X-MC-Unique: idMIFum9OKKWuzNa2wzPYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5034108C20A;
        Thu, 18 Feb 2021 08:24:30 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61CFF5C3E4;
        Thu, 18 Feb 2021 08:24:28 +0000 (UTC)
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
To:     Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz> <YC2Am34Fso5Y5SPC@google.com>
 <20210217211612.GO2858050@casper.infradead.org> <YC2LVXO6e2NVsBqz@google.com>
 <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0c9bc288-4713-f552-ce97-d050eb749e20@redhat.com>
Date:   Thu, 18 Feb 2021 09:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.02.21 09:17, Michal Hocko wrote:
> On Wed 17-02-21 13:32:05, Minchan Kim wrote:
>> On Wed, Feb 17, 2021 at 09:16:12PM +0000, Matthew Wilcox wrote:
>>> On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
>>>>> I suspect you do not want to add atomic_read inside hot paths, right? Is
>>>>> this really something that we have to microoptimize for? atomic_read is
>>>>> a simple READ_ONCE on many archs.
>>>>
>>>> It's also spin_lock_irq_save in some arch. If the new synchonization is
>>>> heavily compilcated, atomic would be better for simple start but I thought
>>>> this locking scheme is too simple so no need to add atomic operation in
>>>> readside.
>>>
>>> What arch uses a spinlock for atomic_read()?  I just had a quick grep and
>>> didn't see any.
>>
>> Ah, my bad. I was confused with update side.
>> Okay, let's use atomic op to make it simple.
> 
> Thanks. This should make the code much more simple. Before you send
> another version for the review I have another thing to consider. You are
> kind of wiring this into the migration code but control over lru pcp
> caches can be used in other paths as well. Memory offlining would be
> another user. We already disable page allocator pcp caches to prevent
> regular draining. We could do the same with lru pcp caches.
> 

Agreed. And dealing with PCP more reliably might also be of interest in 
context of more reliable alloc_contig_range().

-- 
Thanks,

David / dhildenb

