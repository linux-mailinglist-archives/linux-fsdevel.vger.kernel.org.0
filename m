Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572E930BEB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 13:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhBBMuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 07:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231945AbhBBMuJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EEB964F45;
        Tue,  2 Feb 2021 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612270167;
        bh=l1mxEt58DDcLUIYn/PeqqKhgepc/YzCCfJbWYo9gF+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6OTQfqwmfzsDSuhaE02irM8RXZ+6I61yxWerp81AbIHaAEqJgnUU1Tago6YYG+PZ
         lr/J7OliC0mrwyFm+Yl+JHzEuSXK/3VdkUmPzprvLqNXJeT7c7s/R/J9ZCl2+IeFtF
         rRdT17MK63P20HXBjgkEetlpW86oX2ThKpxrHLgmDgGybcXOIhr5G1LeWie80VfNKg
         QlMcZq+bz+M1S4kZa3QSlb+JQ6x7L2zxJR92gCQJ28nKgn5G8407CWFGfDfkqlEtqc
         0FuByC2cyuzV9p6QWIQuYAV6UBnFm4EyXxopzOj5OqjOkGbbBSYsX5rFiF13qam/3d
         9vHDje5GpJPpg==
Date:   Tue, 2 Feb 2021 14:48:57 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20210202124857.GN242749@kernel.org>
References: <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBkcyQsky2scjEcP@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 10:35:05AM +0100, Michal Hocko wrote:
> On Mon 01-02-21 08:56:19, James Bottomley wrote:
> 
> I have also proposed potential ways out of this. Either the pool is not
> fixed sized and you make it a regular unevictable memory (if direct map
> fragmentation is not considered a major problem)

I think that the direct map fragmentation is not a major problem, and the
data we have confirms it, so I'd be more than happy to entirely drop the
pool, allocate memory page by page and remove each page from the direct
map. 

Still, we cannot prove negative and it could happen that there is a
workload that would suffer a lot from the direct map fragmentation, so
having a pool of large pages upfront is better than trying to fix it
afterwards. As we get more confidence that the direct map fragmentation is
not an issue as it is common to believe we may remove the pool altogether.

I think that using PMD_ORDER allocations for the pool with a fallback to
order 0 will do the job, but unfortunately I doubt we'll reach a consensus
about this because dogmatic beliefs are hard to shake...

A more restrictive possibility is to still use plain PMD_ORDER allocations
to fill the pool, without relying on CMA. In this case there will be no
global secretmem specific pool to exhaust, but then it's possible to drain
high order free blocks in a system, so CMA has an advantage of limiting
secretmem pools to certain amount of memory with somewhat higher
probability for high order allocation to succeed. 

> or you need a careful access control 

Do you mind elaborating what do you mean by "careful access control"?

> or you need SIGBUS on the mmap failure (to allow at least some fallback
> mode to caller).

As I've already said, I agree that SIGBUS is way better than OOM at #PF
time.
And we can add some means to fail at mmap() time if the pools are running
low.

-- 
Sincerely yours,
Mike.
