Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361530BF2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhBBNST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 08:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232277AbhBBNSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612271669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzlZq29k5DxcO121v0em/werHdNKON5M2NKDPpBxCdU=;
        b=OPPtcnxIdyCjRncwVvFcJrUscPz1+YjBsw6PM/IUFVx/YBz5ThXDG5UOct6wdjrysLEsXQ
        Bfa7gDetJ4Vrn1wXtqoWchG1aztglNVsZIkxyX6xDkc0lbJAKONwGb4aXCGhScnrTCycgw
        /WWdPHb4CzGlPKN+Qhs29w736BeeTRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-YjtjDQfPMTG3ZZy6csP2bQ-1; Tue, 02 Feb 2021 08:14:25 -0500
X-MC-Unique: YjtjDQfPMTG3ZZy6csP2bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38FC69CDA0;
        Tue,  2 Feb 2021 13:14:20 +0000 (UTC)
Received: from [10.36.114.148] (ovpn-114-148.ams2.redhat.com [10.36.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463FE1F0;
        Tue,  2 Feb 2021 13:14:10 +0000 (UTC)
To:     Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz> <20210202124857.GN242749@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
Date:   Tue, 2 Feb 2021 14:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210202124857.GN242749@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.02.21 13:48, Mike Rapoport wrote:
> On Tue, Feb 02, 2021 at 10:35:05AM +0100, Michal Hocko wrote:
>> On Mon 01-02-21 08:56:19, James Bottomley wrote:
>>
>> I have also proposed potential ways out of this. Either the pool is not
>> fixed sized and you make it a regular unevictable memory (if direct map
>> fragmentation is not considered a major problem)
> 
> I think that the direct map fragmentation is not a major problem, and the
> data we have confirms it, so I'd be more than happy to entirely drop the
> pool, allocate memory page by page and remove each page from the direct
> map.
> 
> Still, we cannot prove negative and it could happen that there is a
> workload that would suffer a lot from the direct map fragmentation, so
> having a pool of large pages upfront is better than trying to fix it
> afterwards. As we get more confidence that the direct map fragmentation is
> not an issue as it is common to believe we may remove the pool altogether.
> 
> I think that using PMD_ORDER allocations for the pool with a fallback to
> order 0 will do the job, but unfortunately I doubt we'll reach a consensus
> about this because dogmatic beliefs are hard to shake...
> 
> A more restrictive possibility is to still use plain PMD_ORDER allocations
> to fill the pool, without relying on CMA. In this case there will be no
> global secretmem specific pool to exhaust, but then it's possible to drain
> high order free blocks in a system, so CMA has an advantage of limiting
> secretmem pools to certain amount of memory with somewhat higher
> probability for high order allocation to succeed.

I am not really concerned about fragmenting/breaking up the direct map 
as long as the feature has to be explicitly enabled (similar to 
fragmenting the vmemmap).

As already expressed, I dislike allowing user space to consume an 
unlimited number unmovable/unmigratable allocations. We already have 
that in some cases with huge pages (when the arch does not support 
migration) - but there we can at least manage the consumption using the 
whole max/reserved/free/... infrastructure. In addition, adding arch 
support for migration shouldn't be too complicated.

The idea of using CMA is quite good IMHO, because there we can locally 
limit the direct map fragmentation and don't have to bother about 
migration at all. We own the area, so we can place as many unmovable 
allocations on it as we can fit.

But it sounds like, we would also need some kind of reservation 
mechanism in either scenario (CMA vs. no CMA).

If we don't want to go full-circle on max/reserved/free/..., allowing 
for migration of secretmem pages would make sense. Then, these pages 
become "less special". Map source, copy, unmap destination. The security 
implementations are the ugly part. I wonder if we could temporarily map 
somewhere else, so avoiding to touch the direct map during migration.

-- 
Thanks,

David / dhildenb

