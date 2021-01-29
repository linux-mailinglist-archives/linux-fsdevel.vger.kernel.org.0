Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4499308632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhA2HE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 02:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhA2HEy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:04:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6692D60234;
        Fri, 29 Jan 2021 07:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611903853;
        bh=B8baj/kr8egXx07AKTfXmu2q+uVtPa7Wa10vxWLTyX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FU1gKzkR0Kkuw4BUPc2Ykvl/qSOzFXlBbHnlbTvI/BhKT7ahDUpGEZB46gpU40Y83
         MoHNwFp1wY6tLb5AUTCsnEfd/AMZYsjtoOTM/ubtkBakz4JEJpx2QSQ5qDWK5JBhpB
         4v3NJredQAUcuf0ikqua2sKTx8pGC/pdnTjma60/EtjBbJKLV0sBexjvYgwWm6cmAr
         6YkTn12NhzoZ5vWMbb1h+pYot7MLL4lAT5rK7YbxkDbSaKqIWEB24dlTSavj0W7G0i
         ikyrL756m9C6l5UyrhfShwTx10Viq23ua1S5t39e8a1T6A4j5m1JHtrkXMph6V4jLt
         ck06v8VwMSCEw==
Date:   Fri, 29 Jan 2021 09:03:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20210129070355.GC242749@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <2b6a5f22f0b062432186b89eeef58e2ba45e09c1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6a5f22f0b062432186b89eeef58e2ba45e09c1.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 07:28:57AM -0800, James Bottomley wrote:
> On Thu, 2021-01-28 at 14:01 +0100, Michal Hocko wrote:
> > On Thu 28-01-21 11:22:59, Mike Rapoport wrote:
> [...]
> > > One of the major pushbacks on the first RFC [1] of the concept was
> > > about the direct map fragmentation. I tried really hard to find
> > > data that shows what is the performance difference with different
> > > page sizes in the direct map and I didn't find anything.
> > > 
> > > So presuming that large pages do provide advantage the first
> > > implementation of secretmem used PMD_ORDER allocations to amortise
> > > the effect of the direct map fragmentation and then handed out 4k
> > > pages at each fault. In addition there was an option to reserve a
> > > finite pool at boot time and limit secretmem allocations only to
> > > that pool.
> > > 
> > > At some point David suggested to use CMA to improve overall
> > > flexibility [3], so I switched secretmem to use CMA.
> > > 
> > > Now, with the data we have at hand (my benchmarks and Intel's
> > > report David mentioned) I'm even not sure this whole pooling even
> > > required.
> > 
> > I would still like to understand whether that data is actually
> > representative. With some underlying reasoning rather than I have run
> > these XYZ benchmarks and numbers do not look terrible.
> 
> My theory, and the reason I made Mike run the benchmarks, is that our
> fear of TLB miss has been alleviated by CPU speculation advances over
> the years.  You can appreciate this if you think that both Intel and
> AMD have increased the number of levels in the page table to
> accommodate larger virtual memory size 5 instead of 3.  That increases
> the length of the page walk nearly 2x in a physical system and even
> more in a virtual system.  Unless this were massively optimized,
> systems would have slowed down significantly.  Using 2M pages only
> eliminates one level and 2G pages eliminates 2, so I theorized that
> actually fragmentation wouldn't be the significant problem we once
> thought it was and asked Mike to benchmark it.
> 
> The benchmarks show that indeed, it isn't a huge change in the data TLB
> miss time, I suspect because data is nicely continuous nowadays and the
> prediction that goes into the CPU optimizations quite easy.  ITLB
> fragmentation actually seems to be quite a bit worse, likely because we
> still don't have branch prediction down to an exact science.

Another thing is that normally useful work done by userspace so data
accesses are dominated by userspace and any change in dTLB miss rate for
kernel data accesses is only a small fraction of all misses.

> James
> 
> 

-- 
Sincerely yours,
Mike.
