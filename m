Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7041F387723
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbhERLJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 07:09:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348295AbhERLJs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 07:09:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621336109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YrC8sXmTYcRXRqQEW1PHcV/1KnSvWM0S1bOpAI2CJA=;
        b=IeXTGF9s14zk1xMYwqe63UzwmexLD0t5w2/lmVlgBw7GL+9Q9WNp2iapvjbdnvXH0892B0
        1vztSfmB1vN+rsIDTC2mrkkDvcaU/PrlXK+za1yXSEDxf3T+eBJpwkZkg54uwDGDEWVXGh
        cLuYNls00SwLIDJ2DsL6MtGb3g25t6M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0DBDB00E;
        Tue, 18 May 2021 11:08:28 +0000 (UTC)
Date:   Tue, 18 May 2021 13:08:27 +0200
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKOgK9eQSfgoz6eE@dhcp22.suse.cz>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org>
 <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
 <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
 <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
 <00644dd8-edac-d3fd-a080-0a175fa9bf13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00644dd8-edac-d3fd-a080-0a175fa9bf13@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-05-21 12:35:36, David Hildenbrand wrote:
> On 18.05.21 12:31, Michal Hocko wrote:
> > On Tue 18-05-21 12:06:42, David Hildenbrand wrote:
> > > On 18.05.21 11:59, Michal Hocko wrote:
> > > > On Sun 16-05-21 10:29:24, Mike Rapoport wrote:
> > > > > On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
> > > > [...]
> > > > > > > +		if (!page)
> > > > > > > +			return VM_FAULT_OOM;
> > > > > > > +
> > > > > > > +		err = set_direct_map_invalid_noflush(page, 1);
> > > > > > > +		if (err) {
> > > > > > > +			put_page(page);
> > > > > > > +			return vmf_error(err);
> > > > > > 
> > > > > > Would we want to translate that to a proper VM_FAULT_..., which would most
> > > > > > probably be VM_FAULT_OOM when we fail to allocate a pagetable?
> > > > > 
> > > > > That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.
> > > > 
> > > > I haven't read through the rest but this has just caught my attention.
> > > > Is it really reasonable to trigger the oom killer when you cannot
> > > > invalidate the direct mapping. From a quick look at the code it is quite
> > > > unlikely to se ENOMEM from that path (it allocates small pages) but this
> > > > can become quite sublte over time. Shouldn't this simply SIGBUS if it
> > > > cannot manipulate the direct mapping regardless of the underlying reason
> > > > for that?
> > > > 
> > > 
> > > OTOH, it means our kernel zones are depleted, so we'd better reclaim somehow
> > > ...
> > 
> > Killing a userspace seems to be just a bad way around that.
> > 
> > Although I have to say openly that I am not a great fan of VM_FAULT_OOM
> > in general. It is usually a a wrong way to tell the handle the failure
> > because it happens outside of the allocation context so you lose all the
> > details (e.g. allocation constrains, numa policy etc.). Also whenever
> > there is ENOMEM then the allocation itself has already made sure that
> > all the reclaim attempts have been already depleted. Just consider an
> > allocation with GFP_NOWAIT/NO_RETRY or similar to fail and propagate
> > ENOMEM up the call stack. Turning that into the OOM killer sounds like a
> > bad idea to me.  But that is a more general topic. I have tried to bring
> > this up in the past but there was not much of an interest to fix it as
> > it was not a pressing problem...
> > 
> 
> I'm certainly interested; it would mean that we actually want to try
> recovering from VM_FAULT_OOM in various cases, and as you state, we might
> have to supply more information to make that work reliably.

Or maybe we want to get rid of VM_FAULT_OOM altogether... But this is
really tangent to this discussion. The only relation is that this would
be another place to check when somebody wants to go that direction.

> Having that said, I guess what we have here is just the same as when our
> process fails to allocate a generic page table in __handle_mm_fault(), when
> we fail p4d_alloc() and friends ...

From a quick look it is really similar in a sense that it effectively never
happens and if it does then it certainly does the wrong thing. The point
I was trying to make is that there is likely no need to go that way.
Fundamentally, not being able to handle direct map for the page fault
sounds like what SIGBUS should be used for. From my POV it is similar to
ENOSPC when FS cannot allocate metadata on the storage.
-- 
Michal Hocko
SUSE Labs
