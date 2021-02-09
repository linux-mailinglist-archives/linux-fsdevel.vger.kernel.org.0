Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E270314B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhBIJCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 04:02:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:36146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhBIJAT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:00:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612861172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKmPZ6awqg5hjlBR0sI2r8zXB8YBdpf3Fstd9lWw2l4=;
        b=p4niOOYBVsAxuZvLvSyfuqafhhIwTbqalQ0XUlb0o+XPLT9GQJWEuScror9bMiRAM/VDNR
        Gg1qoKrVPkiLaebs0ekDczrIK91xZLqc+rSpU+PO8Uxxh1llnmK79t7ldLJZVcdfnC2J7E
        dBwPdj8xY5v0EllSgVlDCcSTDxSJc8Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14A0BAB71;
        Tue,  9 Feb 2021 08:59:32 +0000 (UTC)
Date:   Tue, 9 Feb 2021 09:59:31 +0100
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
        x86@kernel.org
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-02-21 22:38:03, David Hildenbrand wrote:
> 
> > Am 08.02.2021 um 22:13 schrieb Mike Rapoport <rppt@kernel.org>:
> > 
> > ﻿On Mon, Feb 08, 2021 at 10:27:18AM +0100, David Hildenbrand wrote:
> >> On 08.02.21 09:49, Mike Rapoport wrote:
> >> 
> >> Some questions (and request to document the answers) as we now allow to have
> >> unmovable allocations all over the place and I don't see a single comment
> >> regarding that in the cover letter:
> >> 
> >> 1. How will the issue of plenty of unmovable allocations for user space be
> >> tackled in the future?
> >> 
> >> 2. How has this issue been documented? E.g., interaction with ZONE_MOVABLE
> >> and CMA, alloc_conig_range()/alloc_contig_pages?.
> > 
> > Secretmem sets the mappings gfp mask to GFP_HIGHUSER, so it does not
> > allocate movable pages at the first place.
> 
> That is not the point. Secretmem cannot go on CMA / ZONE_MOVABLE
> memory and behaves like long-term pinnings in that sense. This is a
> real issue when using a lot of sectremem.

A lot of unevictable memory is a concern regardless of CMA/ZONE_MOVABLE.
As I've said it is quite easy to land at the similar situation even with
tmpfs/MAP_ANON|MAP_SHARED on swapless system. Neither of the two is
really uncommon. It would be even worse that those would be allowed to
consume both CMA/ZONE_MOVABLE.

One has to be very careful when relying on CMA or movable zones. This is
definitely worth a comment in the kernel command line parameter
documentation. But this is not a new problem.

-- 
Michal Hocko
SUSE Labs
