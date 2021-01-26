Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781A4303C97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbhAZMJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 07:09:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:34440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392429AbhAZMJM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:09:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611662905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rMlCz0R0+4hx1OA36aSmAlu8tlv8RUdQ0e7IJLpT36s=;
        b=SMhufNb2gWzhhrAZNHftCxKV09Z4ON1Nna331EeVwq6g5uadItVhhfYPwqZMwl7NrZHGoe
        sfrAnbEuROoHMCjd6kgLJlKlWNL6a2+tLn/JlOmK2zxwqEpUN438kLFMPBZjX2B+uErhsc
        6f7ZU3sY9xTAQHU0CIqtjHt0JXNni38=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5805AD26;
        Tue, 26 Jan 2021 12:08:24 +0000 (UTC)
Date:   Tue, 26 Jan 2021 13:08:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
        James Bottomley <jejb@linux.ibm.com>,
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
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210126120823.GM827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 12:56:48, David Hildenbrand wrote:
> On 26.01.21 12:46, Michal Hocko wrote:
> > On Thu 21-01-21 14:27:19, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Removing a PAGE_SIZE page from the direct map every time such page is
> > > allocated for a secret memory mapping will cause severe fragmentation of
> > > the direct map. This fragmentation can be reduced by using PMD-size pages
> > > as a pool for small pages for secret memory mappings.
> > > 
> > > Add a gen_pool per secretmem inode and lazily populate this pool with
> > > PMD-size pages.
> > > 
> > > As pages allocated by secretmem become unmovable, use CMA to back large
> > > page caches so that page allocator won't be surprised by failing attempt to
> > > migrate these pages.
> > > 
> > > The CMA area used by secretmem is controlled by the "secretmem=" kernel
> > > parameter. This allows explicit control over the memory available for
> > > secretmem and provides upper hard limit for secretmem consumption.
> > 
> > OK, so I have finally had a look at this closer and this is really not
> > acceptable. I have already mentioned that in a response to other patch
> > but any task is able to deprive access to secret memory to other tasks
> > and cause OOM killer which wouldn't really recover ever and potentially
> > panic the system. Now you could be less drastic and only make SIGBUS on
> > fault but that would be still quite terrible. There is a very good
> > reason why hugetlb implements is non-trivial reservation system to avoid
> > exactly these problems.
> > 
> > So unless I am really misreading the code
> > Nacked-by: Michal Hocko <mhocko@suse.com>
> > 
> > That doesn't mean I reject the whole idea. There are some details to
> > sort out as mentioned elsewhere but you cannot really depend on
> > pre-allocated pool which can fail at a fault time like that.
> 
> So, to do it similar to hugetlbfs (e.g., with CMA), there would have to be a
> mechanism to actually try pre-reserving (e.g., from the CMA area), at which
> point in time the pages would get moved to the secretmem pool, and a
> mechanism for mmap() etc. to "reserve" from these secretmem pool, such that
> there are guarantees at fault time?

yes, reserve at mmap time and use during the fault. But this all sounds
like a self inflicted problem to me. Sure you can have a pre-allocated
or more dynamic pool to reduce the direct mapping fragmentation but you
can always fall back to regular allocatios. In other ways have the pool
as an optimization rather than a hard requirement. With a careful access
control this sounds like a manageable solution to me.
-- 
Michal Hocko
SUSE Labs
