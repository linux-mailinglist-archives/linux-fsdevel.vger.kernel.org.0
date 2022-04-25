Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A350EA8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiDYUeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiDYUeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:34:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B592DAB5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 13:31:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s14so28229631plk.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PsaBjMYML1023D8/4JD8bY2eiV+rm0b5YNMBVGX+9ac=;
        b=W9EEFrpqDbP5K7T2M89kwc5VijgBvLR9xu/SFAX6MmS6EbuAvukDwCTL8RjSs9LFDc
         7DIXQ92NL7hcT2TdQZphsKqUq0S9lFttgqPUIJlJlmYYcaBmxnKQN2yRksnjcM35qQXQ
         6eK8d1F9UAvSuofKNBJproSeSnulD0UMta2JauyqZcOqgU4D/A2ISU3JPOmaeZFu+atU
         iRtI1bHu4P4YPf7VDdMSRTJdXItlCxtaLZ4oTRMOGSdDN6hUXL9UbjuKYGdcXgm1yl5E
         bZ46oDiKhrpb+QjGQIXuw2C+6Kc776/4xXUcniAWAml+hdT71SDQAJ/r18+Js6AeeCwl
         ZKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PsaBjMYML1023D8/4JD8bY2eiV+rm0b5YNMBVGX+9ac=;
        b=tMPc1MczNtlHaE1uuHuebEeeNl0c0dn1r+cYQfCaTW4l92wJo/b8QnS83kgjiedJQv
         xVb6GCAEsDeRpb9NKUUl2/McUUIbMvbud1y1PSIeD8S6wBE2Aw2OYPupSUa3E9kCS9cS
         A4YjtBT0Nia5xjqn9e9Ye5Ldw/qsJMYqJdRncODsCr91IGEypbASx3r0BKwneLYB7kIc
         DztF0Tqbfs3kfFZ1K5JoYmP8jun9bWm8BPAvkt++PJOmV3Ck3iBU967TLTcQXyxv7LYU
         o0CvR8XnwTG0Fh2+rW01peyUw0V/n5dNNlDOc3RkLrzGmrUgwizFjO3WW2hpSRrcu2uW
         Ie3Q==
X-Gm-Message-State: AOAM531cydY1LJA9NU5BLGLi16vr1LlvX+TEWoMNkwG+38sQK3znh2ao
        VFdIyexp3mIO9IyxUZE5soaeEQ==
X-Google-Smtp-Source: ABdhPJwor5d6ibi2AgdFiFHQGhGsostR437Q/Y5WjT0lBvTnaVMftYLa6G75JiDj0ZWMHfoUjJBQ9g==
X-Received: by 2002:a17:90a:cc6:b0:1d2:9a04:d29e with SMTP id 6-20020a17090a0cc600b001d29a04d29emr22712562pjt.136.1650918660848;
        Mon, 25 Apr 2022 13:31:00 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id fh20-20020a17090b035400b001cb978f906esm222025pjb.0.2022.04.25.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:31:00 -0700 (PDT)
Date:   Mon, 25 Apr 2022 20:30:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YmcFAJEJmmtYa+82@google.com>
References: <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <3b99f157-0f30-4b30-8399-dd659250ab8d@www.fastmail.com>
 <20220425134051.GA175928@chaop.bj.intel.com>
 <27616b2f-1eff-42ff-91e0-047f531639ea@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27616b2f-1eff-42ff-91e0-047f531639ea@www.fastmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022, Andy Lutomirski wrote:
> 
> 
> On Mon, Apr 25, 2022, at 6:40 AM, Chao Peng wrote:
> > On Sun, Apr 24, 2022 at 09:59:37AM -0700, Andy Lutomirski wrote:
> >> 
> 
> >> 
> >> 2. Bind the memfile to a VM (or at least to a VM technology).  Now it's in
> >> the initial state appropriate for that VM.
> >> 
> >> For TDX, this completely bypasses the cases where the data is prepopulated
> >> and TDX can't handle it cleanly.

I believe TDX can handle this cleanly, TDH.MEM.PAGE.ADD doesn't require that the
source and destination have different HPAs.  There's just no pressing need to
support such behavior because userspace is highly motivated to keep the initial
image small for performance reasons, i.e. burning a few extra pages while building
the guest is a non-issue.

> >> For SEV, it bypasses a situation in which data might be written to the
> >> memory before we find out whether that data will be unreclaimable or
> >> unmovable.
> >
> > This sounds a more strict rule to avoid semantics unclear.
> >
> > So userspace needs to know what excatly happens for a 'bind' operation.
> > This is different when binds to different technologies. E.g. for SEV, it
> > may imply after this call, the memfile can be accessed (through mmap or
> > what ever) from userspace, while for current TDX this should be not allowed.
> 
> I think this is actually a good thing.  While SEV, TDX, pKVM, etc achieve
> similar goals and have broadly similar ways of achieving them, they really
> are different, and having userspace be aware of the differences seems okay to
> me.

I agree, _if_ the properties of the memory are enumerated in a technology-agnostic
way.  The underlying mechanisms are different, but conceptually the set of sane
operations that userspace can perform/initiate are the same.  E.g. TDX and SNP can
support swap, they just don't because no one has requested Intel/AMD to provide
that support (no use cases for oversubscribing confidential VMs).  SNP does support
page migration, and TDX can add that support without too much fuss.

SEV "allows" the host to access guest private memory, but that doesn't mean it
should be deliberately supported by the kernel.  It's a bit of a moot point for
SEV/SEV-ES, as the host doesn't get any kind of notification that the guest has
"converted" a page, but the kernel shouldn't allow userspace to map memory that
is _known_ to be private.

> (Although I don't think that allowing userspace to mmap SEV shared pages is

s/shared/private?

> particularly wise -- it will result in faults or cache incoherence depending
> on the variant of SEV in use.)
>
> > And I feel we still need a third flow/operation to indicate the
> > completion of the initialization on the memfile before the guest's 
> > first-time launch. SEV needs to check previous mmap-ed areas are munmap-ed
> > and prevent future userspace access. After this point, then the memfile
> > becomes truely private fd.
> 
> Even that is technology-dependent.  For TDX, this operation doesn't really
> exist.

As above, I believe this is TDH.MEM.PAGE.ADD.

> For SEV, I'm not sure (I haven't read the specs in nearly enough detail).

QEMU+KVM does in-place conversion for SEV/SEV-ES via SNP_LAUNCH_UPDATE, AFAICT
that's still allowed for SNP.

> For pKVM, I guess it does exist and isn't quite the same as a
> shared->private conversion.
> 
> Maybe this could be generalized a bit as an operation "measure and make
> private" that would be supported by the technologies for which it's useful.
> 
> 
> >> Now I have a question, since I don't think anyone has really answered it:
> >> how does this all work with SEV- or pKVM-like technologies in which
> >> private and shared pages share the same address space?

The current proposal is to have both a private fd and a shared hva for memslot
that can be mapped private.  A GPA is considered private by KVM if the memslot
has a private fd and that corresponding page in the private fd is populated.  KVM
will always and only map the current flavor of shared/private based on that
definition.  If userspace punches a hole in the private fd, KVM will unmap any
relevant private GPAs.  If userspace populates a range in the private fd, KVM will
unmap any relevant shared GPAs.

> >> I sounds like you're proposing to have a big memfile that contains private
> >> and shared pages and to use that same memfile as pages are converted back
> >> and forth.  IO and even real physical DMA could be done on that memfile.
> >> Am I understanding correctly?
> >
> > For TDX case, and probably SEV as well, this memfile contains private memory
> > only. But this design at least makes it possible for usage cases like
> > pKVM which wants both private/shared memory in the same memfile and rely
> > on other ways like mmap/munmap or mprotect to toggle private/shared instead
> > of fallocate/hole punching.
> 
> Hmm.  Then we still need some way to get KVM to generate the correct SEV
> pagetables.  For TDX, there are private memslots and shared memslots, and
> they can overlap.  If they overlap and both contain valid pages at the same
> address, then the results may not be what the guest-side ABI expects, but
> everything will work.

Absolutely not, KVM is not concurrently mapping both private and shared variants
of a single GPA into the guest.  The Shared bit is a glorified attribute/permission
bit, that it's carved out of the GPA space is a hack to minimize Intel's hardware
development cost.

> So, when a single logical guest page transitions between shared and private,
> no change to the memslots is needed.

Hard no, KVM is not supporting different memslot semantics for TDX versus everything
else.

> For SEV, this is not the case: everything is in one set of pagetables, and
> there isn't a natural way to resolve overlaps.
> 
> If the memslot code becomes efficient enough, then the memslots could be
> fragmented.

No, because the only way to not artificially limit the amount of fragmentation is
to turn the memslots into a tree structure, i.e. to make them effectively multi-level
page tables as opposed to the single-level "tables" that they are today.

> Or the memfile could support private and shared data in the same memslot.
> And if pKVM does this, I don't see why SEV couldn't also do it and hopefully
> reuse the same code.
> 
> >
> >> 
> >> If so, I think this makes sense, but I'm wondering if the actual memslot
> >> setup should be different.  For TDX, private memory lives in a logically
> >> separate memslot space.  For SEV and pKVM, it doesn't.  I assume the API
> >> can reflect this straightforwardly.

Again, no.  KVM is not going to give special treatment to TDX.

> > I believe so. The flow should be similar but we do need pass different
> > flags during the 'bind' to the backing store for different usages. That
> > should be some new flags for pKVM but the callbacks (API here) between
> > memfile_notifile and its consumers can be reused.
> 
> And also some different flag in the operation that installs the fd as a memslot?

No, memslots updates need to come directly from userspace.

> >> And the corresponding TDX question: is the intent still that shared pages
> >> aren't allowed at all in a TDX memfile?  If so, that would be the most
> >> direct mapping to what the hardware actually does.
> >
> > Exactly. TDX will still use fallocate/hole punching to turn on/off the
> > private page. Once off, the traditional shared page will become
> > effective in KVM.
> 
> Works for me.
> 
> For what it's worth, I still think it should be fine to land all the TDX
> memfile bits upstream as long as we're confident that SEV, pKVM, etc can be
> added on without issues.
> 
> I think we can increase confidence in this by either getting one other
> technology's maintainers to get far enough along in the design to be
> confident and/or by having a pure-kernel-software implementation that serves
> as a testbed.  For the latter, maybe it could support two different models
> with little overhead:
> 
> Pure software "interleaved" model: pages are shared or private and a
> hypercall converts them.  The access mode is entirely determined by the state
> programmed by hypercall.  I think this is essentially what Vishal
> implemented, but with the "HACK" replaced by something permanent and (if
> they're not already in the series) appropriate access checks implemented to
> actually protect the private memory.
> 
> Pure software "separate" mode: one GPA bit is set aside as the shared vs
> private bit.  The normal memslots are restricted to the shared half of GPA
> space.  Private memslots use the private half.  This works a lot like TDX.
> This would be new code.  We don't *really* need this for testing, since TDX
> itself exercises the same programming model, but it would let people without
> TDX hardware exercise the interesting bits of the memory management.

No, KVM is not bifurcating the memslots into shared and private.  Except for TDX,
hardware can't support mapping both variants.  That means KVM has to define some
semantic for which memslot "wins", and that puts userspace/KVM back to square one
in having punch a hole into a memslot in order to allow mapping the "loser" into
the guest.
