Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50023058A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhA0Kkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 05:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235098AbhA0Kh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611743793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCPzZ58zrnooW9g+/emDghb7lm/E/AgOMGI9bAy3zYE=;
        b=e5GJqwMa9axlJcsX5B1CCDT5Q4Q5YFdeXL9vBLMBTDgpx5oHIIKxd7RZsOn5z4qcIuqKad
        Xcr/RUCBIlAhhGLBWsMgRUsLd+/dEABCACPio6kO5T0QdQPsgRDuSNgLWax+NndopR4p7j
        py/Hf4buG8m6l5AU47tjRU4Ime/lHQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-lIVf9Fe2Nnu587VehfUqmw-1; Wed, 27 Jan 2021 05:36:29 -0500
X-MC-Unique: lIVf9Fe2Nnu587VehfUqmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 769BE190B2A2;
        Wed, 27 Jan 2021 10:36:25 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 504195C5FD;
        Wed, 27 Jan 2021 10:36:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
 <20210126092942.GA10602@linux>
 <6fe52a7e-ebd8-f5ce-1fcd-5ed6896d3797@redhat.com>
 <20210126145819.GB16870@linux>
 <259b9669-0515-01a2-d714-617011f87194@redhat.com>
 <20210126153448.GA17455@linux>
 <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <e28399e1-3a24-0f22-b057-76e7c7e70017@redhat.com>
Date:   Wed, 27 Jan 2021 11:36:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <9475b139-1b33-76c7-ef5c-d43d2ea1dba5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.01.21 16:56, David Hildenbrand wrote:
> On 26.01.21 16:34, Oscar Salvador wrote:
>> On Tue, Jan 26, 2021 at 04:10:53PM +0100, David Hildenbrand wrote:
>>> The real issue seems to be discarding the vmemmap on any memory that has
>>> movability constraints - CMA and ZONE_MOVABLE; otherwise, as discussed, we
>>> can reuse parts of the thingy we're freeing for the vmemmap. Not that it
>>> would be ideal: that once-a-huge-page thing will never ever be a huge page
>>> again - but if it helps with OOM in corner cases, sure.
>>
>> Yes, that is one way, but I am not sure how hard would it be to implement.
>> Plus the fact that as you pointed out, once that memory is used for vmemmap
>> array, we cannot use it again.
>> Actually, we would fragment the memory eventually?
>>
>>> Possible simplification: don't perform the optimization for now with free
>>> huge pages residing on ZONE_MOVABLE or CMA. Certainly not perfect: what
>>> happens when migrating a huge page from ZONE_NORMAL to (ZONE_MOVABLE|CMA)?
>>
>> But if we do not allow theose pages to be in ZONE_MOVABLE or CMA, there is no
>> point in migrate them, right?
> 
> Well, memory unplug "could" still work and migrate them and
> alloc_contig_range() "could in the future" still want to migrate them
> (virtio-mem, gigantic pages, powernv memtrace). Especially, the latter
> two don't work with ZONE_MOVABLE/CMA. But, I mean, it would be fair
> enough to say "there are no guarantees for
> alloc_contig_range()/offline_pages() with ZONE_NORMAL, so we can break
> these use cases when a magic switch is flipped and make these pages
> non-migratable anymore".
> 
> I assume compaction doesn't care about huge pages either way, not sure
> about numa balancing etc.
> 
> 
> However, note that there is a fundamental issue with any approach that
> allocates a significant amount of unmovable memory for user-space
> purposes (excluding CMA allocations for unmovable stuff, CMA is
> special): pairing it with ZONE_MOVABLE becomes very tricky as your user
> space might just end up eating all kernel memory, although the system
> still looks like there is plenty of free memory residing in
> ZONE_MOVABLE. I mentioned that in the context of secretmem in a reduced
> form as well.
> 
> We theoretically have that issue with dynamic allocation of gigantic
> pages, but it's something a user explicitly/rarely triggers and it can
> be documented to cause problems well enough. We'll have the same issue
> with GUP+ZONE_MOVABLE that Pavel is fixing right now - but GUP is
> already known to be broken in various ways and that it has to be treated
> in a special way. I'd like to limit the nasty corner cases.
> 
> Of course, we could have smart rules like "don't online memory to
> ZONE_MOVABLE automatically when the magic switch is active". That's just
> ugly, but could work.
> 

Extending on that, I just discovered that only x86-64, ppc64, and arm64 
really support hugepage migration.

Maybe one approach with the "magic switch" really would be to disable 
hugepage migration completely in hugepage_migration_supported(), and 
consequently making hugepage_movable_supported() always return false.

Huge pages would never get placed onto ZONE_MOVABLE/CMA and cannot be 
migrated. The problem I describe would apply (careful with using 
ZONE_MOVABLE), but well, it can at least be documented.

-- 
Thanks,

David / dhildenb

