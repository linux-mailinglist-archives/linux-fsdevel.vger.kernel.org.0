Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98843520860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiEIXdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiEIXdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 19:33:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AC71DF666
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 16:29:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r192so9085714pgr.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 May 2022 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8KUgtn5nyg5jr7YjoVRw3h8Od+NzNpZfZuV38wd6b7A=;
        b=tkQ1FWK+ZYSJohYiLv6r8pjipgcqhKYVCAxGnBs1r6iZpdB9F39xx654LaJg5tmptb
         Jy8U9pynMDIQXaf4AtUJYP7d4xFU4ltiNtrelqnW3Qjfk7mImr0ovMm98oViuaXGykB4
         kFF+ePjSIkS93pR+akIC3Z/cndBfybHx1SIxUiQ9YcpAKddk5peEE97toonazUHSQK66
         Q/HnavaGhvRixAlkFuoK4aEfg8GYpwCI/jUzf6rLJkxf8hrzeymtNLip0+euFkPlLC7z
         vM1ije6M+DYPqNyhNcmNCOE9E+dKPD3JgZq8eMXCMxi7B4QizakABMEPx7TYbmCSRTV/
         3V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8KUgtn5nyg5jr7YjoVRw3h8Od+NzNpZfZuV38wd6b7A=;
        b=HqqKBaLWL/YNVPal4RhLVS2/5Ak5/HxEorIKRPK6snDP0w2eAkBl5pUibD6x1WizZn
         vCHcuLeCJPfA+RodWBJYXmexjxDWPyDyG29pPnGT9j9Z7Yi/aagWlM/K/nWlNIdrgiYb
         JY79jc8vrNR0MCJwZKJFvlwQZ49oPq89pTHP2VSc1qHDNHHwX0SQeCNTOPkaKpEjV3Q3
         JfnodDHJHvM+FezxRRmkZiGs9q8T92g4EqypRV3jQBsa2peU/o1naGYLbvSwF+CDWUj6
         M2GT+SmmpRU/sWpLNjyLUevB3aduW96ibBDuT0lDpKklSHjJauSWinOHVLC5TIQEl4Qv
         ulBw==
X-Gm-Message-State: AOAM530h1VholHTh49/q9TLO5dcFogkk2TcN0J+wO49vh2h57SfbgtiJ
        HYy0IAom+olOv78X20Dv2uA8+Q==
X-Google-Smtp-Source: ABdhPJzm8jQxDOg0Ffbg/fNP2Jh6oUDG+3VQUqDgUNfGtKSVGiBY2jEkIX2ibTy4qHuLsQmBBomGSA==
X-Received: by 2002:a63:5a09:0:b0:3c2:5dfa:285c with SMTP id o9-20020a635a09000000b003c25dfa285cmr15186422pgb.381.1652138945064;
        Mon, 09 May 2022 16:29:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79627000000b0050dc76281f8sm9327263pfg.210.2022.05.09.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:29:04 -0700 (PDT)
Date:   Mon, 9 May 2022 23:29:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        Quentin Perret <qperret@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        nikunj@amd.com, ashish.kalra@amd.com
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YnmjvX9ow4elYsY8@google.com>
References: <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <20220509223056.pyazfxjwjvipmytb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509223056.pyazfxjwjvipmytb@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022, Michael Roth wrote:
> On Fri, Apr 22, 2022 at 06:56:12PM +0800, Chao Peng wrote:
> > Requirements & Gaps
> > -------------------------------------
> >   - Confidential computing(CC): TDX/SEV/CCA
> >     * Need support both explicit/implicit conversions.
> >     * Need support only destructive conversion at runtime.
> >     * The current patch should just work, but prefer to have pre-boot guest
> >       payload/firmware population into private memory for performance.
> 
> Not just performance in the case of SEV, it's needed there because firmware
> only supports in-place encryption of guest memory, there's no mechanism to
> provide a separate buffer to load into guest memory at pre-boot time. I
> think you're aware of this but wanted to point that out just in case.

I view it as a performance problem because nothing stops KVM from copying from
userspace into the private fd during the SEV ioctl().  What's missing is the
ability for userspace to directly initialze the private fd, which may or may not
avoid an extra memcpy() depending on how clever userspace is.

> 
> > 
> >   - pKVM
> >     * Support explicit conversion only. Hard to achieve implicit conversion,
> >       does not record the guest access info (private/shared) in page fault,
> >       also makes little sense.
> >     * Expect to support non-destructive conversion at runtime. Additionally
> >       in-place conversion (the underlying physical page is unchanged) is
> >       desirable since copy is not disirable. The current destructive conversion
> >       does not fit well.
> >     * The current callbacks between mm/KVM is useful and reusable for pKVM.
> >     * Pre-boot guest payload population is nice to have.
> > 
> > 
> > Change Proposal
> > ---------------
> > Since there are some divergences for pKVM from CC usages and at this time looks
> > whether we will and how we will support pKVM with this private memory patchset
> > is still not quite clear, so this proposal does not imply certain detailed pKVM
> > implementation. But from the API level, we want this can be possible to be future
> > extended for pKVM or other potential usages.
> > 
> >   - No new user APIs introduced for memory backing store, e.g. remove the
> >     current MFD_INACCESSIBLE. This info will be communicated from memfile_notifier
> >     consumers to backing store via the new 'flag' field in memfile_notifier
> >     described below. At creation time, the fd is normal shared fd. At rumtime CC
> >     usages will keep using current fallocate/FALLOC_FL_PUNCH_HOLE to do the
> >     conversion, but pKVM may also possible use a different way (e.g. rely on
> >     mmap/munmap or mprotect as discussed). These are all not new APIs anyway.
> 
> For SNP most of the explicit conversions are via GHCB page-state change
> requests. Each of these PSC requests can request shared/private
> conversions for up to 252 individual pages, along with whether or not
> they should be treated as 4K or 2M pages. Currently, like with
> KVM_EXIT_MEMORY_ERROR, these requests get handled in userspace and call
> back into the kernel via fallocate/PUNCH_HOLE calls.
> 
> For each fallocate(), we need to update the RMP table to mark a page as
> private, and for PUNCH_HOLE we need to mark it as shared (otherwise it
> would be freed back to the host as guest-owned/private and cause a crash if
> the host tries to re-use it for something). I needed to add some callbacks
> to the memfile_notifier to handle these RMP table updates. There might be
> some other bits of book-keeping like clflush's, and adding/removing guest
> pages from the kernel's direct map.
> 
> Not currently implemented, but the guest can also issue requests to
> "smash"/"unsmash" a 2M private range into individual 4K private ranges
> (generally in advance of flipping one of the pages to shared, or
> vice-versa) in the RMP table. Hypervisor code tries to handle this
> automatically, by determining when to smash/unsmash on it's own, but...
> 
> I'm wondering how all these things can be properly conveyed through this
> fallocate/PUNCH_HOLE interface if we ever needed to add support for all
> of this, as it seems a bit restrictive as-is. For instance, with the
> current approach, one possible scheme is:
> 
>   - explicit conversion of shared->private for 252 4K pages:
>     - we could do 252 individual fallocate()'s of 4K each, and make sure the
>       kernel code will do notifier callbacks / RMP updates for each individual
>       4K page
> 
>   - shared->private for 252 2M pages:
>     - we could do 252 individual fallocate()'s of 2M each, and make sure the
>       kernel code will do notifier callbacks / RMP updates for each individual
>       2M page
> 
> But for SNP most of these bulk PSC changes are when the guest switches
> *all* of it's pages from shared->private during early boot when it
> validates all of it's memory. So these pages tend to be contiguous
> ranges, and a nice optimization would be to coalesce these 252
> fallocate() calls into a single fallocate() that spans the whole range.
> But there's no good way to do that without losing information like
> whether these should be treated as individual 4K vs. 2M ranges.

Eh, the smash/unsmash hint from the guest is just that, a hint.  If the guest
hints at 4kb pages and then bulk converts a contiguous 2mb chunk (or 242 2mb chunks),
then the guest is being dumb because it either (a) doesn't realize it can/should use
2mb pages, or (b) is doing an unnecessary shared->private (assuming the hint was sane
and intented to hint that a private->shared split+conversion is coming).

> So I wonder, since there's talk of the "binding" of this memfd to KVM
> being what actually enabled all the private/shared operations, if we
> should introduce some sort of new KVM ioctl, like
> KVM_UPM_SET_PRIVATE/SHARED, that could handle all the
> fallocate/hole-punching on the kernel side for larger GFN ranges to reduce
> the kernel<->userspace transitions, and allow for 4K/2M granularity to be
> specified as arguments, and maybe provide for better
> backward-compatibility vs. future changes to memfd backend interface.

At this point, I don't think we need anything new.  When SNP is merged, KVM can
coalesce contiguous pages into a single KVM_HC_MAP_GPA_RANGE so that userspace can
batch those into a single fallocate().  That does leave a gap in that KVM_HC_MAP_GPA_RANGE
will require multiple roundtrips for discontiguous ranges, but I would be very surprised
if that ends up being the long pole for boot performance.

> >   - Add a flag to memfile_notifier so its consumers can state the requirements.
> > 
> >         struct memfile_notifier {
> >                 struct list_head list;
> >                 unsigned long flags;     /* consumer states its requirements here */
> >                 struct memfile_notifier_ops *ops; /* future function may also extend ops when necessary */
> >         };
> > 
> >     For current CC usage, we can define and set below flags from KVM.
> > 
> >         /* memfile notifier flags */
> >         #define MFN_F_USER_INACCESSIBLE   0x0001  /* memory allocated in the file is inaccessible from userspace (e.g. read/write/mmap) */
> >         #define MFN_F_UNMOVABLE           0x0002  /* memory allocated in the file is unmovable */
> >         #define MFN_F_UNRECLAIMABLE       0x0003  /* memory allocated in the file is unreclaimable (e.g. via kswapd or any other pathes) */
> > 
> >     When memfile_notifier is being registered, memfile_register_notifier will
> >     need check these flags. E.g. for MFN_F_USER_INACCESSIBLE, it fails when
> >     previous mmap-ed mapping exists on the fd (I'm still unclear on how to do
> >     this). When multiple consumers are supported it also need check all
> >     registered consumers to see if any conflict (e.g. all consumers should have
> >     MFN_F_USER_INACCESSIBLE set). Only when the register succeeds, the fd is
> >     converted into a private fd, before that, the fd is just a normal (shared)
> >     one. During this conversion, the previous data is preserved so you can put
> >     some initial data in guest pages (whether the architecture allows this is
> >     architecture-specific and out of the scope of this patch).
> > 
> >   - Pre-boot guest payload populating is done by normal mmap/munmap on the fd
> >     before it's converted into private fd when KVM registers itself to the
> >     backing store.
> 
> Is that registration still intended to be triggered by
> KVM_SET_USER_MEMORY_REGION, or is there a new ioctl you're considering?
> 
> I ask because in the case of SNP (and QEMU in general, maybe other VMMs),
> the regions are generally registered before the guest contents are
> initialized. So if KVM_SET_USER_MEMORY_REGION kicks of the conversion then
> it's too late for the SNP code in QEMU to populate the pre-conversion data.
> 
> Maybe, building on the above approach, we could have something like:
> 
> KVM_SET_USER_MEMORY_REGION
> KVM_UPM_BIND(TYPE_TDX|SEV|SNP, gfn_start, gfn_end)
> <populate guest memory>
> KVM_UPM_INIT(gfn_start, gfn_end) //not sure if needed
> KVM_UPM_SET_PRIVATE(gfn_start, gfn_end, granularity)
> <launch guest>
> ...
> KVM_UPM_SET_PRIVATE(gfn_start, gfn_end, granularity)
> ...
> KVM_UPM_SET_SHARED(gfn_start, gfn_end, granularity)
> etc.
> 
> Just some rough ideas, but I think addressing these in some form would help
> a lot with getting SNP covered with reasonable performance.

TDX also needs to populate some amount of guest memory with non-zero data, and to
do so must set up TDP page table in KVM.  So for starters, I think a single ioctl
to copy data into a private fd is the way to go.  That does leave a performance
gap (the extra memcpy() I mentioned earlier), but it at least ensures KVM can boot
an SNP guest.

I'm certainly not opposed to directly pre-populating private fd memory from
userspace, I just want to point out that this can be handled in KVM without too
much fuss and without any additional support in the private fd implementation. 

> >   - Implicit conversion: maybe it's worthy to discuss again: how about totally
> >     remove implicit converion support? TDX should be OK, unsure SEV/CCA. pKVM
> >     should be happy to see. Removing also makes the work much easier and prevents
> >     guest bugs/unitended behaviors early. If it turns out that there is reason to
> >     keep it, then for pKVM we can make it an optional feature (e.g. via a new
> >     module param). But that can be added when pKVM really gets supported.
> 
> SEV sort of relies on implicit conversion since the guest is free to turn
> on/off the encryption bit during run-time. But in the context of UPM that
> wouldn't be supported anyway since, IIUC, the idea is that SEV/SEV-ES would
> only be supported for guests that do explicit conversions via MAP_GPA_RANGE
> hypercall. And for SNP these would similarly be done via explicit page-state
> change requests via GHCB requests issued by the guest.
> 
> But if possible, it would be nice if we could leave implicit conversion
> as an optional feature/flag, as it's something that we considered
> harmless for the guest SNP support (now upstream), and planned to allow
> in the hypervisor implementation. I don't think we intentionally relied on
> it in the guest kernel/uefi support, but I need to audit that code to be
> sure that dropping it wouldn't cause a regression in the guest support.
> I'll try to confirm this soon one I get things running under UPM a bit more
> reliably.

The plan is to support implicit conversions, albeit with a lot of whining :-)
Both SNP's GHCB and TDX's GHCI specs allow for implicit conversion, so barring a
spec change KVM needs to support it.
