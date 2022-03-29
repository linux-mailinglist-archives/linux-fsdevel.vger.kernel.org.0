Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3BE4EB267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiC2RDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 13:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiC2RDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:03:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E04BB8D
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 10:01:50 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m30so25774364wrb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fDEbyTk5JLZwfzVmTiXkAAwM2SkhzM0CrjsBq6yV8uQ=;
        b=nFte+OoNNUDulAY71F/YaVEMwP4/fjEKZy3iAHaWKGtiq3jPM1hCXjv1oeE/PYW/Iu
         CaeCDlvm9ldzoOTxdf6mWH0kRtv0jXPkPuriZuGskn6zPN54Mtw8L5ZvIBbLXFPA9SEm
         FdEsg8IbYPk/oFSs1nqv1BhLVA3HEX43BHA3LQ+7hSkC44G2cnS9ziA+s/XAJ7fnhljy
         EpUuct+9uxfl3dFf+JF0V45IaRO1NzBz8J/iwEKvGZ0Dy3kJqKI6yvUlhtsCwTvQX7/4
         Qf7ABMTedmRqasdiJYqU+a+01g86eVnw4U2J2Y7iYT2ARpBS/p6MkLvOYf0754Xe/kip
         LlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fDEbyTk5JLZwfzVmTiXkAAwM2SkhzM0CrjsBq6yV8uQ=;
        b=mOpa1rduUeAf5Ipcbu0miDPObCLtPRmOICMYqkiex+0ThfcwEW/F1UI7YM2VbtCAiK
         NEeGe4qOIy+FHn6GQOsGtFEOkE5JFjuQ+apanhG/437NBOQNPeCs2KmFqmu/k2sa5cPM
         4aUMfHuuN3nAQPRex3zUtjpEVRTKGWU8LRbReHmOxLj0SLUSIJpt1J02DAA4C2R0seNt
         VDPEooCetHjJupVPdBW8NSklZE6ZRohPQdm9Wv28aqsA7zYngOzP+45erj7S+fPb/3rO
         aih5LXw77IG0TyeOBsX8e9n4kAIZjjoLqTk53603J2mGaSyevtkD6qPemLAiw+DpSTEK
         CZtw==
X-Gm-Message-State: AOAM532Z3x4Q1p0A6l9+s9gNZK411A0WDukIOqgoAMOAjItS71rOF9Le
        FIKQAsvwOL3DOJEGGKOovi4Mhg==
X-Google-Smtp-Source: ABdhPJxPse1UJFRu0iABOfDa+i1kx+YJuLeqO4wcBveYiTN5kWzxPsXAfC0C+zTPq81FovM+LAXOng==
X-Received: by 2002:adf:c54c:0:b0:203:ed16:2570 with SMTP id s12-20020adfc54c000000b00203ed162570mr32914595wrf.646.1648573308184;
        Tue, 29 Mar 2022 10:01:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:eb09:5f76:2b4a:9d88])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm3818702wms.26.2022.03.29.10.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 10:01:47 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:01:44 +0100
From:   Quentin Perret <qperret@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, maz@kernel.org,
        will@kernel.org
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YkM7eHCHEBe5NkNH@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com>
 <YkHspg+YzOsbUaCf@google.com>
 <YkH32nx+YsJuUbmZ@google.com>
 <YkIFW25WgV2WIQHb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkIFW25WgV2WIQHb@google.com>
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

On Monday 28 Mar 2022 at 18:58:35 (+0000), Sean Christopherson wrote:
> On Mon, Mar 28, 2022, Quentin Perret wrote:
> > Hi Sean,
> > 
> > Thanks for the reply, this helps a lot.
> > 
> > On Monday 28 Mar 2022 at 17:13:10 (+0000), Sean Christopherson wrote:
> > > On Thu, Mar 24, 2022, Quentin Perret wrote:
> > > > For Protected KVM (and I suspect most other confidential computing
> > > > solutions), guests have the ability to share some of their pages back
> > > > with the host kernel using a dedicated hypercall. This is necessary
> > > > for e.g. virtio communications, so these shared pages need to be mapped
> > > > back into the VMM's address space. I'm a bit confused about how that
> > > > would work with the approach proposed here. What is going to be the
> > > > approach for TDX?
> > > > 
> > > > It feels like the most 'natural' thing would be to have a KVM exit
> > > > reason describing which pages have been shared back by the guest, and to
> > > > then allow the VMM to mmap those specific pages in response in the
> > > > memfd. Is this something that has been discussed or considered?
> > > 
> > > The proposed solution is to exit to userspace with a new exit reason, KVM_EXIT_MEMORY_ERROR,
> > > when the guest makes the hypercall to request conversion[1].  The private fd itself
> > > will never allow mapping memory into userspace, instead userspace will need to punch
> > > a hole in the private fd backing store.  The absense of a valid mapping in the private
> > > fd is how KVM detects that a pfn is "shared" (memslots without a private fd are always
> > > shared)[2].
> > 
> > Right. I'm still a bit confused about how the VMM is going to get the
> > shared page mapped in its page-table. Once it has punched a hole into
> > the private fd, how is it supposed to access the actual physical page
> > that the guest shared?
> 
> The guest doesn't share a _host_ physical page, the guest shares a _guest_ physical
> page.  Until host userspace converts the gfn to shared and thus maps the gfn=>hva
> via mmap(), the guest is blocked and can't read/write/exec the memory.  AFAIK, no
> architecture allows in-place decryption of guest private memory.  s390 allows a
> page to be "made accessible" to the host for the purposes of swap, and other
> architectures will have similar behavior for migrating a protected VM, but those
> scenarios are not sharing the page (and they also make the page inaccessible to
> the guest).

I see. FWIW, since pKVM is entirely MMU-based, we are in fact capable of
doing in-place sharing, which also means it can retain the content of
the page as part of the conversion.

Also, I'll ask the Arm CCA developers to correct me if this is wrong, but
I _believe_ it should be technically possible to do in-place sharing for
them too.

> > Is there an assumption somewhere that the VMM should have this page mapped in
> > via an alias that it can legally access only once it has punched a hole at
> > the corresponding offset in the private fd or something along those lines?
> 
> Yes, the VMM must have a completely separate VMA.  The VMM doesn't haven't to
> wait until the conversion to mmap() the shared variant, though obviously it will
> potentially consume double the memory if the VMM actually populates both the
> private and shared backing stores.

Gotcha. This is what confused me I think -- in this approach private and
shared pages are in fact entirely different.

In which scenario could you end up with both the private and shared
pages live at the same time? Would this be something like follows?

 - userspace creates a private fd, fallocates into it, and associates
   the <fd, offset, size> tuple with a private memslot;

 - userspace then mmaps anonymous memory (for ex.), and associates it
   with a standard memslot, which happens to be positioned at exactly
   the right offset w.r.t to the private memslot (with this offset
   defined by the bit that is set for the private addresses in the gpa
   space);

 - the guest runs, and accesses both 'aliases' of the page without doing
   an explicit share hypercall.

Is there another option?

Is implicit sharing a thing? E.g., if a guest makes a memory access in
the shared gpa range at an address that doesn't have a backing memslot,
will KVM check whether there is a corresponding private memslot at the
right offset with a hole punched and report a KVM_EXIT_MEMORY_ERROR? Or
would that just generate an MMIO exit as usual?

> > > The key point is that KVM never decides to convert between shared and private, it's
> > > always a userspace decision.  Like normal memslots, where userspace has full control
> > > over what gfns are a valid, this gives userspace full control over whether a gfn is
> > > shared or private at any given time.
> > 
> > I'm understanding this as 'the VMM is allowed to punch holes in the
> > private fd whenever it wants'. Is this correct?
> 
> From the kernel's perspective, yes, the VMM can punch holes at any time.  From a
> "do I want to DoS my guest" perspective, the VMM must honor its contract with the
> guest and not spuriously unmap private memory.
> 
> > What happens if it does so for a page that a guest hasn't shared back?
> 
> When the hole is punched, KVM will unmap the corresponding private SPTEs.  If the
> guest is still accessing the page as private, the next access will fault and KVM
> will exit to userspace with KVM_EXIT_MEMORY_ERROR.  Of course the guest is probably
> hosed if the hole punch was truly spurious, as at least hardware-based protected VMs
> effectively destroy data when a private page is unmapped from the guest private SPTEs.
>
> E.g. Linux guests for TDX and SNP will panic/terminate in such a scenario as they
> will get a fault (injected by trusted hardware/firmware) saying that the guest is
> trying to access an unaccepted/unvalidated page (TDX and SNP require the guest to
> explicit accept all private pages that aren't part of the guest's initial pre-boot
> image).

I suppose this is necessary is to prevent the VMM from re-fallocating
in a hole it previously punched and re-entering the guest without
notifying it?

> > > Another important detail is that this approach means the kernel and KVM treat the
> > > shared backing store and private backing store as independent, albeit related,
> > > entities.  This is very deliberate as it makes it easier to reason about what is
> > > and isn't allowed/required.  E.g. the kernel only needs to handle freeing private
> > > memory, there is no special handling for conversion to shared because no such path
> > > exists as far as host pfns are concerned.  And userspace doesn't need any new "rules"
> > > for protecting itself against a malicious guest, e.g. userspace already needs to
> > > ensure that it has a valid mapping prior to accessing guest memory (or be able to
> > > handle any resulting signals).  A malicious guest can DoS itself by instructing
> > > userspace to communicate over memory that is currently mapped private, but there
> > > are no new novel attack vectors from the host's perspective as coercing the host
> > > into accessing an invalid mapping after shared=>private conversion is just a variant
> > > of a use-after-free.
> > 
> > Interesting. I was (maybe incorrectly) assuming that it would be
> > difficult to handle illegal host accesses w/ TDX. IOW, this would
> > essentially crash the host. Is this remotely correct or did I get that
> > wrong?
> 
> Handling illegal host kernel accesses for both TDX and SEV-SNP is extremely
> difficult, bordering on impossible.  That's one of the biggest, if not _the_
> biggest, motivations for the private fd approach.  On "conversion", the page that is
> used to back the shared variant is a completely different, unrelated host physical
> page.  Whether or not the private/shared backing page is freed is orthogonal to
> what version is mapped into the guest.  E.g. if the guest converts a 4kb chunk of
> a 2mb hugepage, the private backing store could keep the physical page on hole
> punch (example only, I don't know if this is the actual proposed implementation).
> 
> The idea is that it'll be much, much more difficult for the host to perform an
> illegal access if the actual private memory is not mapped anywhere (modulo the
> kernel's direct map, which we may or may not leave intact).  The private backing
> store just needs to ensure it properly sanitizing pages before freeing them.

Understood.

I'm overall inclined to think that while this abstraction works nicely
for TDX and the likes, it might not suit pKVM all that well in the
current form, but it's close.

What do you think of extending the model proposed here to also address
the needs of implementations that support in-place sharing? One option
would be to have KVM notify the private-fd backing store when a page is
shared back by a guest, which would then allow host userspace to mmap
that particular page in the private fd instead of punching a hole.

This should retain the main property you're after: private pages that
are actually mapped in the guest SPTE aren't mmap-able, but all the
others are fair game.

Thoughts?
