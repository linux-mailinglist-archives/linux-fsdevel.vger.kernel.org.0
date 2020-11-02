Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281CB2A26B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 10:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKBJLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 04:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728226AbgKBJLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604308290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsx9rV62BpQWr7OrGkSf+6thseF+6yM3BDN31bmg5MQ=;
        b=TvonQJwkqVfxbePBPyLAhhMGFOHNK0//eDZUnuQKJ8KOQXRzG8xTZ+pEBJxVbtAxN5GtPB
        OjZI3UocJHbPnxJ/PPbeMuGYGOksHFF76aFnsqiFeUhXu9xEW0d6/xRDo8LHPsvt/Pwymb
        bMK222WaKSH0l4eJSWUTWM1gaEz10ZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-ghMbzMWdOp2vAAAUSLZQlg-1; Mon, 02 Nov 2020 04:11:26 -0500
X-MC-Unique: ghMbzMWdOp2vAAAUSLZQlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744641009E28;
        Mon,  2 Nov 2020 09:11:21 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02AF25D9D2;
        Mon,  2 Nov 2020 09:11:12 +0000 (UTC)
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20200924132904.1391-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9c38ac3b-c677-6a87-ce82-ec53b69eaf71@redhat.com>
Date:   Mon, 2 Nov 2020 10:11:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200924132904.1391-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.09.20 15:28, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is an implementation of "secret" mappings backed by a file descriptor.
> I've dropped the boot time reservation patch for now as it is not strictly
> required for the basic usage and can be easily added later either with or
> without CMA.

Hi Mike,

I'd like to stress again that I'd prefer *any* secretmem allocations 
going via CMA as long as these pages are unmovable. The user can 
allocate a non-significant amount of unmovable allocations only fenced 
by the mlock limit, which behave very different to mlocked pages - they 
are not movable for page compaction/migration.

Assume you have a system with quite some ZONE_MOVABLE memory (esp. in 
virtualized environments), eating up a significant amount of 
!ZONE_MOVABLE memory dynamically at runtime can lead to non-obvious 
issues. It looks like you have plenty of free memory, but the kernel 
might still OOM when trying to do kernel allocations e.g., for 
pagetables. With CMA we at least know what we're dealing with - it 
behaves like ZONE_MOVABLE except for the owner that can place unmovable 
pages there. We can use it to compute statically the amount of 
ZONE_MOVABLE memory we can have in the system without doing harm to the 
system.

Ideally, we would want to support page migration/compaction and allow 
for allocation from ZONE_MOVABLE as well. Would involve temporarily 
mapping, copying, unmapping. Sounds feasible, but not sure which 
roadblocks we would find on the way.

[...]

> 
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.
> 
> Although normally Linux userspace mappings are protected from other users,
> such secret mappings are useful for environments where a hostile tenant is
> trying to trick the kernel into giving them access to other tenants
> mappings.
> 
> Additionally, the secret mappings may be used as a mean to protect guest
> memory in a virtual machine host.
> 
> For demonstration of secret memory usage we've created a userspace library
> [1] that does two things: the first is act as a preloader for openssl to
> redirect all the OPENSSL_malloc calls to secret memory meaning any secret
> keys get automatically protected this way and the other thing it does is
> expose the API to the user who needs it. We anticipate that a lot of the
> use cases would be like the openssl one: many toolkits that deal with
> secret keys already have special handling for the memory to try to give
> them greater protection, so this would simply be pluggable into the
> toolkits without any need for user application modification.
> 
> I've hesitated whether to continue to use new flags to memfd_create() or to
> add a new system call and I've decided to use a new system call after I've
> started to look into man pages update. There would have been two completely
> independent descriptions and I think it would have been very confusing.

This was also raised on lwn.net by "dullfire" [1]. I do wonder if it 
would be the right place as well.

[1] https://lwn.net/Articles/835342/#Comments

> 
> Hiding secret memory mappings behind an anonymous file allows (ab)use of
> the page cache for tracking pages allocated for the "secret" mappings as
> well as using address_space_operations for e.g. page migration callbacks.
> 
> The anonymous file may be also used implicitly, like hugetlb files, to
> implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
> ABIs in the future.
> 
> As the fragmentation of the direct map was one of the major concerns raised
> during the previous postings, I've added an amortizing cache of PMD-size
> pages to each file descriptor that is used as an allocation pool for the
> secret memory areas.

-- 
Thanks,

David / dhildenb

