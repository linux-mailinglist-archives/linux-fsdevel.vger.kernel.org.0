Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF2332C20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 17:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCIQbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 11:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231139AbhCIQbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615307478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eBwkywOASVp/kvePJk1+t/Z7TCkxbP6z5J3Zg1UZfU=;
        b=Ge8+zVDEXWNXV/03egFu3WgmyrjYFI4emu20ReeJYZj81c0Y5koRvFnfkUMEI4keoqUijJ
        Oafj0iOf+PPJwP3JpRR6Xp8f1YtS7pu4jLhQ8p3rYgOIzCVJHriAj+Zr2OajELs/EmuVs7
        4v/XGgGg/aGAguNr64DEdsBjOvHsX5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-Joo3Nc2JNo-0kmNL7ftE5w-1; Tue, 09 Mar 2021 11:31:14 -0500
X-MC-Unique: Joo3Nc2JNo-0kmNL7ftE5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AC45108BD06;
        Tue,  9 Mar 2021 16:31:13 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12255D6D7;
        Tue,  9 Mar 2021 16:31:10 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm: disable LRU pagevec during the migration
 temporarily
To:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org
References: <20210309051628.3105973-1-minchan@kernel.org>
 <YEdV7Leo7MC93PlK@dhcp22.suse.cz> <YEeiYbBjefM08h18@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0ae7c7de-f274-c2ec-1b3a-a006ea280f98@redhat.com>
Date:   Tue, 9 Mar 2021 17:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEeiYbBjefM08h18@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>>> ---
>>> * from v1 - https://lore.kernel.org/lkml/20210302210949.2440120-1-minchan@kernel.org/
>>>    * introduce __lru_add_drain_all to minimize changes - mhocko
>>>    * use lru_cache_disable for memory-hotplug
>>>    * schedule for every cpu at force_all_cpus
>>>
>>> * from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
>>>    * use atomic and lru_add_drain_all for strict ordering - mhocko
>>>    * lru_cache_disable/enable - mhocko
>>>
>>>   include/linux/migrate.h |  6 ++-
>>>   include/linux/swap.h    |  2 +
>>>   mm/memory_hotplug.c     |  3 +-
>>>   mm/mempolicy.c          |  6 +++
>>>   mm/migrate.c            | 13 ++++---
>>>   mm/page_alloc.c         |  3 ++
>>>   mm/swap.c               | 82 +++++++++++++++++++++++++++++++++--------
>>>   7 files changed, 91 insertions(+), 24 deletions(-)
>>
>> Sorry for nit picking but I think the additional abstraction for
>> migrate_prep is not really needed and we can remove some more code.
>> Maybe we should even get rid of migrate_prep_local which only has a
>> single caller and open coding lru draining with a comment would be
>> better from code reading POV IMO.
> 
> Thanks for the code. I agree with you.
> However, in this moment, let's go with this one until we conclude.
> The removal of migrate_prep could be easily done after that.
> I am happy to work on it.

Can you prepare + send along these cleanups so we can have a look at the 
end result?

(either cleanups before or after your changes - doing cleanups before 
might be cleaner as we are not dealing with a fix here that we want to 
backport)

-- 
Thanks,

David / dhildenb

