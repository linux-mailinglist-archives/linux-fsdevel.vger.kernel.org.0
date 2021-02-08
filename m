Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9021C312D50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 10:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBHJbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 04:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231555AbhBHJ3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612776454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgUd+2G1OxW5XPBZGlc3z4gNM80hK8Gpg3YPMpWSREs=;
        b=Vebru5xy/2UXcpW9IczNuZKU2yNkvfGBrNgpxf4EVfGsIS55/NKm3U6+B9xVVVPj0nggs5
        KMFMM8ihab4AytcJoQzcb+YdmqJ5fg9ynaJBeDbhGwMbsWRy58cqyli1ftPGygbyKO4yx/
        YYmFf0G2gu7ErZp2DzzmXcnCbHTcZ2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-wOalByIhNImBr91I-hxz5g-1; Mon, 08 Feb 2021 04:27:32 -0500
X-MC-Unique: wOalByIhNImBr91I-hxz5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EAF41934101;
        Mon,  8 Feb 2021 09:27:27 +0000 (UTC)
Received: from [10.36.113.240] (ovpn-113-240.ams2.redhat.com [10.36.113.240])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D2660C05;
        Mon,  8 Feb 2021 09:27:19 +0000 (UTC)
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
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
        x86@kernel.org
References: <20210208084920.2884-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4996348d-5710-d77d-bb14-d84e370b4a5c@redhat.com>
Date:   Mon, 8 Feb 2021 10:27:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210208084920.2884-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.02.21 09:49, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> @Andrew, this is based on v5.11-rc5-mmotm-2021-01-27-23-30, with secretmem
> and related patches dropped from there, I can rebase whatever way you
> prefer.
> 
> This is an implementation of "secret" mappings backed by a file descriptor.
> 
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will be present only in the page table of the owning mm.
> 
> Although normally Linux userspace mappings are protected from other users,
> such secret mappings are useful for environments where a hostile tenant is
> trying to trick the kernel into giving them access to other tenants
> mappings.
> 
> Additionally, in the future the secret mappings may be used as a mean to
> protect guest memory in a virtual machine host.
> 
> For demonstration of secret memory usage we've created a userspace library
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git
> 
> that does two things: the first is act as a preloader for openssl to
> redirect all the OPENSSL_malloc calls to secret memory meaning any secret
> keys get automatically protected this way and the other thing it does is
> expose the API to the user who needs it. We anticipate that a lot of the
> use cases would be like the openssl one: many toolkits that deal with
> secret keys already have special handling for the memory to try to give
> them greater protection, so this would simply be pluggable into the
> toolkits without any need for user application modification.
> 
> Hiding secret memory mappings behind an anonymous file allows usage of
> the page cache for tracking pages allocated for the "secret" mappings as
> well as using address_space_operations for e.g. page migration callbacks.
> 
> The anonymous file may be also used implicitly, like hugetlb files, to
> implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
> ABIs in the future.
> 
> Removing of the pages from the direct map may cause its fragmentation on
> architectures that use large pages to map the physical memory which affects
> the system performance. However, the original Kconfig text for
> CONFIG_DIRECT_GBPAGES said that gigabyte pages in the direct map "... can
> improve the kernel's performance a tiny bit ..." (commit 00d1c5e05736
> ("x86: add gbpages switches")) and the recent report [1] showed that "...
> although 1G mappings are a good default choice, there is no compelling
> evidence that it must be the only choice". Hence, it is sufficient to have
> secretmem disabled by default with the ability of a system administrator to
> enable it at boot time.
> 
> In addition, there is also a long term goal to improve management of the
> direct map.

Some questions (and request to document the answers) as we now allow to 
have unmovable allocations all over the place and I don't see a single 
comment regarding that in the cover letter:

1. How will the issue of plenty of unmovable allocations for user space 
be tackled in the future?

2. How has this issue been documented? E.g., interaction with 
ZONE_MOVABLE and CMA, alloc_conig_range()/alloc_contig_pages?.

3. How are the plans to support migration in the future and which 
interface changes will be required? (Michal mentioned some good points 
to make this configurable via the interface, we should plan ahead and 
document)

Thanks!

-- 
Thanks,

David / dhildenb

