Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0830C978
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhBBSTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 13:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238384AbhBBSQ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:16:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9084864F92;
        Tue,  2 Feb 2021 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612289771;
        bh=jExAi6+S0KhwmLELocI6wMJuzz/tLWY8R7yvg8v3kSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDgDXp2MRosyELVG93hsa2FWpra6U+O1s/wok5z4I/qOXv7rdUmjG2axPtMIvq+YN
         yBgA8wcWgNGCYn0pW2zVsZsv3wcPZETui3XjKumHzFywKHgYsDnq+d0PEjUY80BQCe
         IzesvjbDuB+UAqmSCfbvnjKvS7w0UCcntNSHwnveAp/98Y5aklQbVLZ5aIeTMaBtIb
         Y2S9E4/e0RHCm573D5HvZcykwBcZPsiKWKBYdn9Gm25wRz155OpIc0oI5MY1vEx2Z5
         y6k9c5Z7N9NTPpMQGOvaiK4lasHyvoskCgCDKMvmuqHqWSSfiiKO+c0UX4uuveVSEz
         Bmm6b/PXs32Ig==
Date:   Tue, 2 Feb 2021 20:15:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        James Bottomley <jejb@linux.ibm.com>,
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
Message-ID: <20210202181546.GO242749@kernel.org>
References: <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz>
 <20210202124857.GN242749@kernel.org>
 <6653288a-dd02-f9de-ef6a-e8d567d71d53@redhat.com>
 <YBlUXdwV93xMIff6@dhcp22.suse.cz>
 <211f0214-1868-a5be-9428-7acfc3b73993@redhat.com>
 <YBlgCl8MQuuII22w@dhcp22.suse.cz>
 <d4fe580a-ef0e-e13f-9ee4-16fb8b6d65dd@redhat.com>
 <YBlicIupOyPF9f3D@dhcp22.suse.cz>
 <95625b83-f7e2-b27a-2b99-d231338047fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95625b83-f7e2-b27a-2b99-d231338047fb@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 03:34:29PM +0100, David Hildenbrand wrote:
> On 02.02.21 15:32, Michal Hocko wrote:
> > On Tue 02-02-21 15:26:20, David Hildenbrand wrote:
> > > On 02.02.21 15:22, Michal Hocko wrote:
> > > > On Tue 02-02-21 15:12:21, David Hildenbrand wrote:
> > > > [...]
> > > > > I think secretmem behaves much more like longterm GUP right now
> > > > > ("unmigratable", "lifetime controlled by user space", "cannot go on
> > > > > CMA/ZONE_MOVABLE"). I'd either want to reasonably well control/limit it or
> > > > > make it behave more like mlocked pages.
> > > > 
> > > > I thought I have already asked but I must have forgotten. Is there any
> > > > actual reason why the memory is not movable? Timing attacks?
> > > 
> > > I think the reason is simple: no direct map, no copying of memory.
> > 
> > This is an implementation detail though and not something terribly hard
> > to add on top later on. I was more worried there would be really
> > fundamental reason why this is not possible. E.g. security implications.
> 
> I don't remember all the details. Let's see what Mike thinks regarding
> migration (e.g., security concerns).

Thanks for considering me a security expert :-)

Yet, I cannot estimate how dangerous is the temporal exposure of
this data to the kernel via the direct map in the simple map/copy/unmap
sequence.

More secure way would be to map source and destination in a different page table
rather than in the direct map, similarly to the way text_poke() on x86
does.

I've left the migration callback empty for now because it can be added on
top and its implementation would depend on the way we do (or do not do)
pooling.

-- 
Sincerely yours,
Mike.
