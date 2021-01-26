Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05D83038EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbhAZJYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 04:24:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389361AbhAZJTr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:19:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611652532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8+K0oyxRY1+vhNkSeXzm8M4Y2R64gVVtCdOHelIF+V8=;
        b=kShKTVasjKcQgyk49obmmqJEv3Z3d6D+KjtCoEjGXxzkEZlE9pddLwPnfiYIY421ESnwFk
        s121ANy6h6Uf22zm4fCv1pqav6eTOcya5rAIE9EhMH1YsS7w7Ixp5ITIzE4PQfYNNMffQz
        Deb5a3d+IUk2PpGiCwbgFZJfGrBkuvI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36ABFB293;
        Tue, 26 Jan 2021 09:15:32 +0000 (UTC)
Date:   Tue, 26 Jan 2021 10:15:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
Message-ID: <20210126091527.GG827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
 <20210126073142.GY827@dhcp22.suse.cz>
 <20210126085654.GO6332@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126085654.GO6332@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 10:56:54, Mike Rapoport wrote:
> On Tue, Jan 26, 2021 at 08:31:42AM +0100, Michal Hocko wrote:
> > On Mon 25-01-21 23:38:17, Mike Rapoport wrote:
> > > On Mon, Jan 25, 2021 at 05:54:51PM +0100, Michal Hocko wrote:
> > > > On Thu 21-01-21 14:27:20, Mike Rapoport wrote:
> > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > 
> > > > > Account memory consumed by secretmem to memcg. The accounting is updated
> > > > > when the memory is actually allocated and freed.
> > > > 
> > > > What does this mean?
> > > 
> > > That means that the accounting is updated when secretmem does cma_alloc()
> > > and cma_relase().
> > > 
> > > > What are the lifetime rules?
> > > 
> > > Hmm, what do you mean by lifetime rules?
> > 
> > OK, so let's start by reservation time (mmap time right?) then the
> > instantiation time (faulting in memory). What if the calling process of
> > the former has a different memcg context than the later. E.g. when you
> > send your fd or inherited fd over fork will move to a different memcg.
> > 
> > What about freeing path? E.g. when you punch a hole in the middle of
> > a mapping?
> > 
> > Please make sure to document all this.
>  
> So, does something like this answer your question:
> 
> ---
> The memory cgroup is charged when secremem allocates pages from CMA to
> increase large pages pool during ->fault() processing.

OK so that is when the memory is faulted in. Good that is a standard
model we have. The memcg context of the creator of the secret memory is
not really important. So whoever has created is not charged.

> The pages are uncharged from memory cgroup when they are released back to
> CMA at the time secretme inode is evicted.
> ---

so effectivelly when they are unmapped, right? This is similar to
anonymous memory.

As I've said it would be really great to have this life cycle documented
properly.

> > Please note that this all is a user visible stuff that will become PITA
> > (if possible) to change later on. You should really have strong
> > arguments in your justification here.
> 
> I think that adding a dedicated counter for few 2M areas per container is
> not worth the churn. 

What kind of churn you have in mind? What is the downside?

> When we'll get to the point that secretmem can be used to back the entire
> guest memory we can add a new counter and it does not seem to PITA to me.

What does really prevent a larger use with this implementation?

-- 
Michal Hocko
SUSE Labs
