Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1130D601
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhBCJN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 04:13:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:42272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233208AbhBCJNM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:13:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612343545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zc3hq7uDsgQ0b+vRRJzp2lKKXI9473aJH0r0Js1Sba8=;
        b=HpVLWbDI2jrNX+ptbYXzVMjwEnvzT3tSDstsq31vn45eKVS7LJjYVzwqj1uQ2gr6lLmqUT
        bC8zchNPhAk8QJcRoCgvPjBBGQ1e/qoJChvnC3zjw9HWM74APhhMECX1FCKKYKCE1otg6M
        cOV8/W7XZopQR2+Wl4/NVeGMFzXcJ6g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDE7CB0EA;
        Wed,  3 Feb 2021 09:12:24 +0000 (UTC)
Date:   Wed, 3 Feb 2021 10:12:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <YBpo9mC5feVQ0mpG@dhcp22.suse.cz>
References: <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz>
 <20210202124857.GN242749@kernel.org>
 <YBlTMqjB06aqyGbT@dhcp22.suse.cz>
 <20210202191040.GP242749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202191040.GP242749@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-02-21 21:10:40, Mike Rapoport wrote:
> On Tue, Feb 02, 2021 at 02:27:14PM +0100, Michal Hocko wrote:
> > On Tue 02-02-21 14:48:57, Mike Rapoport wrote:
> > > On Tue, Feb 02, 2021 at 10:35:05AM +0100, Michal Hocko wrote:
> > > > On Mon 01-02-21 08:56:19, James Bottomley wrote:
> > > > 
> > > > I have also proposed potential ways out of this. Either the pool is not
> > > > fixed sized and you make it a regular unevictable memory (if direct map
> > > > fragmentation is not considered a major problem)
> > > 
> > > I think that the direct map fragmentation is not a major problem, and the
> > > data we have confirms it, so I'd be more than happy to entirely drop the
> > > pool, allocate memory page by page and remove each page from the direct
> > > map. 
> > > 
> > > Still, we cannot prove negative and it could happen that there is a
> > > workload that would suffer a lot from the direct map fragmentation, so
> > > having a pool of large pages upfront is better than trying to fix it
> > > afterwards. As we get more confidence that the direct map fragmentation is
> > > not an issue as it is common to believe we may remove the pool altogether.
> > 
> > I would drop the pool altogether and instantiate pages to the
> > unevictable LRU list and internally treat it as ramdisk/mlock so you
> > will get an accounting correctly. The feature should be still opt-in
> > (e.g. a kernel command line parameter) for now. The recent report by
> > Intel (http://lkml.kernel.org/r/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com)
> > there is no clear win to have huge mappings in _general_ but there are
> > still workloads which benefit. 
> >  
> > > I think that using PMD_ORDER allocations for the pool with a fallback to
> > > order 0 will do the job, but unfortunately I doubt we'll reach a consensus
> > > about this because dogmatic beliefs are hard to shake...
> > 
> > If this is opt-in then those beliefs can be relaxed somehow. Long term
> > it makes a lot of sense to optimize for a better direct map management
> > but I do not think this is a hard requirement for an initial
> > implementation if it is not imposed to everybody by default.
> >
> > > A more restrictive possibility is to still use plain PMD_ORDER allocations
> > > to fill the pool, without relying on CMA. In this case there will be no
> > > global secretmem specific pool to exhaust, but then it's possible to drain
> > > high order free blocks in a system, so CMA has an advantage of limiting
> > > secretmem pools to certain amount of memory with somewhat higher
> > > probability for high order allocation to succeed. 
> > > 
> > > > or you need a careful access control 
> > > 
> > > Do you mind elaborating what do you mean by "careful access control"?
> > 
> > As already mentioned, a mechanism to control who can use this feature -
> > e.g. make it a special device which you can access control by
> > permissions or higher level security policies. But that is really needed
> > only if the pool is fixed sized.
>   
> Let me reiterate to make sure I don't misread your suggestion.
> 
> If we make secretmem an opt-in feature with, e.g. kernel parameter, the
> pooling of large pages is unnecessary. In this case there is no limited
> resource we need to protect because secretmem will allocate page by page.

Yes.

> Since there is no limited resource, we don't need special permissions
> to access secretmem so we can move forward with a system call that creates
> a mmapable file descriptor and save the hassle of a chardev.

Yes, I assume you implicitly assume mlock rlimit here. Also memcg
accounting should be in place. Wrt to the specific syscall, please
document why existing interfaces are not a good fit as well. It would be
also great to describe interaction with mlock itself (I assume the two
to be incompatible - mlock will fail on and mlockall will ignore it).

> I cannot say I don't like this as it cuts roughly half of mm/secretmem.c :)
> 
> But I must say I am still a bit concerned about that we have no provisions
> here for dealing with the direct map fragmentation even with the set goal
> to improve the direct map management in the long run...

Yes that is something that will be needed long term. I do not think this
is strictly necessary for the initial submission, though. The
implementation should be as simple as possible now and complexity added
on top.
-- 
Michal Hocko
SUSE Labs
