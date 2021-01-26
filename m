Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C293041A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406137AbhAZPIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:08:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406091AbhAZPGp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:06:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611673558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXc9QyfjbzYkr/9E7kWbWAYLlI4FbRmuEeT8rg+wTwU=;
        b=RcjpwZyxbSnL27+xPbzI8DyQUePSR4WX2wnQ97UeZMl/oXbeJLspplWQnjrpGmeZ7f77M8
        pp/AUp1dBACy/R4ZeJn8VoibDW4Ammk83FYCwymuY2mppYsbTam98rNT5itWkQIDggqXZG
        gLCeXQM4w8C09vqYIx/Yft3mlmE8rVM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4094AF2F;
        Tue, 26 Jan 2021 15:05:57 +0000 (UTC)
Date:   Tue, 26 Jan 2021 16:05:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210126150555.GU827@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-9-rppt@kernel.org>
 <20210125165451.GT827@dhcp22.suse.cz>
 <20210125213817.GM6332@kernel.org>
 <20210126144838.GL308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126144838.GL308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 14:48:38, Matthew Wilcox wrote:
> On Mon, Jan 25, 2021 at 11:38:17PM +0200, Mike Rapoport wrote:
> > I cannot use __GFP_ACCOUNT because cma_alloc() does not use gfp.
> > Besides, kmem accounting with __GFP_ACCOUNT does not seem
> > to update stats and there was an explicit request for statistics:
> >  
> > https://lore.kernel.org/lkml/CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com/
> > 
> > As for (ab)using NR_SLAB_UNRECLAIMABLE_B, as it was already discussed here:
> > 
> > https://lore.kernel.org/lkml/20201129172625.GD557259@kernel.org/
> > 
> > I think that a dedicated stats counter would be too much at the moment and
> > NR_SLAB_UNRECLAIMABLE_B is the only explicit stat for unreclaimable memory.
> 
> That's not true -- Mlocked is also unreclaimable.  And doesn't this
> feel more like mlocked memory than unreclaimable slab?  It's also
> Unevictable, so could be counted there instead.

yes, that is indeed true, except the unreclaimable counter is tracking
the unevictable LRUs. These pages are not on any LRU and that can cause
some confusion. Maybe they shouldn't be so special and they should live
on unevistable LRU and get their stats automagically.

I definitely do agree that this would be a better fit than NR_SLAB
abuse. But considering that this is somehow even more special than mlock
then a dedicated counter sounds as even better fit.
-- 
Michal Hocko
SUSE Labs
