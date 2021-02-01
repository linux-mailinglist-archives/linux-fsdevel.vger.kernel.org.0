Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA630AC5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBAQM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 11:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229883AbhBAQMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612195844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTkTHTZtrG7r7H93f6RfvQ2RYuYcKcR+efM5cQJVmzE=;
        b=ViWsUaMszsIFDcxj6WIOlEChcUzwwPwiryEctaIxoVOW0CN56KfdR/SkDTpTGsKFLs98Ea
        MK/dXII9bP5PiToMjUzmmk0hP15rCLgsYA31L6weLsup4vYS+r23Y/KGT87AEmRx/jax/F
        uQ4+PED0y6xyw+DEgviZdHQQqoZOtKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Nv06uFrmOrOjzL9zhKXSug-1; Mon, 01 Feb 2021 11:10:39 -0500
X-MC-Unique: Nv06uFrmOrOjzL9zhKXSug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E0E107ACE8;
        Mon,  1 Feb 2021 16:10:35 +0000 (UTC)
Received: from [10.36.115.24] (ovpn-115-24.ams2.redhat.com [10.36.115.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C679B60C66;
        Mon,  1 Feb 2021 16:10:28 +0000 (UTC)
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
 <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com>
 <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com>
 <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
 <CAMZfGtWCu95Qve8p9mH7C7rm=F+znsc8+VL_6Z-_k4e5hAHzhA@mail.gmail.com>
 <e200c17e-5c95-025e-37a7-af7cfbb05b18@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [External] Re: [PATCH v13 05/12] mm: hugetlb: allocate the
 vmemmap pages associated with each HugeTLB page
Message-ID: <41160c2e-817d-3ef2-0475-4db58827c1c3@redhat.com>
Date:   Mon, 1 Feb 2021 17:10:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e200c17e-5c95-025e-37a7-af7cfbb05b18@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> What's your opinion about this? Should we take this approach?
> 
> I think trying to solve all the issues that could happen as the result of
> not being able to dissolve a hugetlb page has made this extremely complex.
> I know this is something we need to address/solve.  We do not want to add
> more unexpected behavior in corner cases.  However, I can not help but think
> about similar issues today.  For example, if a huge page is in use in
> ZONE_MOVABLE or CMA there is no guarantee that it can be migrated today.

Yes, hugetlbfs is broken with alloc_contig_range() as e.g., used by CMA 
and needs fixing. Then, similar problems as with hugetlbfs pages on 
ZONE_MOVABLE apply.


hugetlbfs pages on ZONE_MOVABLE for memory unplug are problematic in 
corner cases only I think:

1. Not sufficient memory to allocate a destination page. Well, nothing 
we can really do about that - just like trying to migrate any other 
memory but running into -ENOMEM.

2. Trying to dissolve a free huge page but running into reservation 
limits. I think we should at least try allocating a new free huge page 
before failing. To be tackled in the future.

> Correct?  We may need to allocate another huge page for the target of the
> migration, and there is no guarantee we can do that.
> 

I agree that 1. is similar to "cannot migrate because OOM".


So thinking about it again, we don't actually seem to lose that much when

a) Rejecting migration of a huge page when not being able to allocate 
the vmemmap for our source page. Our system seems to be under quite some 
memory pressure already. Migration could just fail because we fail to 
allocate a migration target already.

b) Rejecting to dissolve a huge page when not able to allocate the 
vmemmap. Dissolving can fail already. And, again, our system seems to be 
under quite some memory pressure already.

c) Rejecting freeing huge pages when not able to allocate the vmemmap. I 
guess the "only" surprise is that the user might now no longer get what 
he asked for. This seems to be the "real change".


So maybe little actually speaks against allowing for migration of such 
huge pages and optimizing any huge page, besides rejecting freeing of 
huge pages and surprising the user/admin.

I guess while our system is under memory pressure CMA and ZONE_MOVABLE 
are already no longer able to always keep their guarantees - until there 
is no more memory pressure.

-- 
Thanks,

David / dhildenb

