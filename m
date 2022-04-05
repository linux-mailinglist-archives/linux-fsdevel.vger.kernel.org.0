Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F84F3991
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiDELfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 07:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356820AbiDELPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:15:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26FA66FD
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 03:36:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d10so9569078edj.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M+9t9GPp8kQkcOpf9/1bOVcjxUYWjperAKVBlci1EH0=;
        b=YoxHIZZ3G33PpP4KmdhCg75x+dpK6knIWVV8om3MTD9ItxOCrXniFFZ+EvxkQJ749N
         TZNSlhHf4yWYtlJeFdnSgzWzKhMprnLWCYXMXUTjbzKQ4/AX1ZqSMnT1SfxHkylpJTA7
         TcIjcf/eAxyNT9pvVGShATH+k7UpVvaxHcSaiQOwLh3eYOzlDTpuPyS5UNG1XNCwsFhM
         md0yH5dJ7w10QqUB206n1HWdLrv0jotHk49fIRHox0SvuqO4dIa/vG90Ckw+UKkNkWMc
         sq0j21T+LRsTluEbkq+UsOFNTncjQe37S6SdEaPevdA/gEDmNPTD2BCQT7M2E3fUdzaK
         aNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M+9t9GPp8kQkcOpf9/1bOVcjxUYWjperAKVBlci1EH0=;
        b=FralQome3c6TVMOhEhapFpzPE8j0s+vVGJBrzNjV9ejD8uAPpVjv0yIuySvQVTBgLJ
         P1nvtwZdmGf3OoeN1CWmaG0vbaV9mSf5YxCEyKob6cqbrCYTw1cOQMmD1Pk7S/fSRAy6
         9CZ/wpZOa+4+Gt9RRo4QIOP5OtPnh119/qADkC8vcJEnFCaO0UD5UrnQ/bMT9ZZmA7rO
         52N/dUD9QiQ7wuH4XhXmU5nQjZU4xHMyfmh6WNKg276uemEijbZTM5DJfIixeb3HQeNf
         pQ8YGdln7ojQ6HQZ+WNzV8TJ5QSdyQmaRn+D9myefrR4ml0RgcVEo5F0dBdci95ghgxw
         Uj7Q==
X-Gm-Message-State: AOAM533e12NvU8Vc+WyHuU+fQkDoehJ67Byehni+cx6u/KCaQrViX5mG
        Jb+54bJafY3tQdbhWZwTqozghA==
X-Google-Smtp-Source: ABdhPJzcpd3vW+XvDHpPAXOPJtyGzauj0UiVcmYc+CSIkw4TBey0PHa06nPTqe7WSTtid7CYCX8XcQ==
X-Received: by 2002:a05:6402:d4c:b0:410:a415:fd95 with SMTP id ec12-20020a0564020d4c00b00410a415fd95mr2848428edb.288.1649154990022;
        Tue, 05 Apr 2022 03:36:30 -0700 (PDT)
Received: from google.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm6428799edu.11.2022.04.05.03.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:36:29 -0700 (PDT)
Date:   Tue, 5 Apr 2022 10:36:26 +0000
From:   Quentin Perret <qperret@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Steven Price <steven.price@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
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
Message-ID: <Ykwbqv90C7+8K+Ao@google.com>
References: <YkM7eHCHEBe5NkNH@google.com>
 <88620519-029e-342b-0a85-ce2a20eaf41b@arm.com>
 <YkQzfjgTQaDd2E2T@google.com>
 <YkSaUQX89ZEojsQb@google.com>
 <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 04 Apr 2022 at 15:04:17 (-0700), Andy Lutomirski wrote:
> 
> 
> On Mon, Apr 4, 2022, at 10:06 AM, Sean Christopherson wrote:
> > On Mon, Apr 04, 2022, Quentin Perret wrote:
> >> On Friday 01 Apr 2022 at 12:56:50 (-0700), Andy Lutomirski wrote:
> >> FWIW, there are a couple of reasons why I'd like to have in-place
> >> conversions:
> >> 
> >>  - one goal of pKVM is to migrate some things away from the Arm
> >>    Trustzone environment (e.g. DRM and the likes) and into protected VMs
> >>    instead. This will give Linux a fighting chance to defend itself
> >>    against these things -- they currently have access to _all_ memory.
> >>    And transitioning pages between Linux and Trustzone (donations and
> >>    shares) is fast and non-destructive, so we really do not want pKVM to
> >>    regress by requiring the hypervisor to memcpy things;
> >
> > Is there actually a _need_ for the conversion to be non-destructive?  
> > E.g. I assume
> > the "trusted" side of things will need to be reworked to run as a pKVM 
> > guest, at
> > which point reworking its logic to understand that conversions are 
> > destructive and
> > slow-ish doesn't seem too onerous.
> >
> >>  - it can be very useful for protected VMs to do shared=>private
> >>    conversions. Think of a VM receiving some data from the host in a
> >>    shared buffer, and then it wants to operate on that buffer without
> >>    risking to leak confidential informations in a transient state. In
> >>    that case the most logical thing to do is to convert the buffer back
> >>    to private, do whatever needs to be done on that buffer (decrypting a
> >>    frame, ...), and then share it back with the host to consume it;
> >
> > If performance is a motivation, why would the guest want to do two 
> > conversions
> > instead of just doing internal memcpy() to/from a private page?  I 
> > would be quite
> > surprised if multiple exits and TLB shootdowns is actually faster, 
> > especially at
> > any kind of scale where zapping stage-2 PTEs will cause lock contention 
> > and IPIs.
> 
> I don't know the numbers or all the details, but this is arm64, which is a rather better architecture than x86 in this regard.  So maybe it's not so bad, at least in very simple cases, ignoring all implementation details.  (But see below.)  Also the systems in question tend to have fewer CPUs than some of the massive x86 systems out there.

Yep. I can try and do some measurements if that's really necessary, but
I'm really convinced the cost of the TLBI for the shared->private
conversion is going to be significantly smaller than the cost of memcpy
the buffer twice in the guest for us. To be fair, although the cost for
the CPU update is going to be low, the cost for IOMMU updates _might_ be
higher, but that very much depends on the hardware. On systems that use
e.g. the Arm SMMU, the IOMMUs can use the CPU page-tables directly, and
the iotlb invalidation is done on the back of the CPU invalidation. So,
on systems with sane hardware the overhead is *really* quite small.

Also, memcpy requires double the memory, it is pretty bad for power, and
it causes memory traffic which can't be a good thing for things running
concurrently.

> If we actually wanted to support transitioning the same page between shared and private, though, we have a bit of an awkward situation.  Private to shared is conceptually easy -- do some bookkeeping, reconstitute the direct map entry, and it's done.  The other direction is a mess: all existing uses of the page need to be torn down.  If the page has been recently used for DMA, this includes IOMMU entries.
>
> Quentin: let's ignore any API issues for now.  Do you have a concept of how a nondestructive shared -> private transition could work well, even in principle?

I had a high level idea for the workflow, but I haven't looked into the
implementation details.

The idea would be to allow KVM *or* userspace to take a reference
to a page in the fd in an exclusive manner. KVM could take a reference
on a page (which would be necessary before to donating it to a guest)
using some kind of memfile_notifier as proposed in this series, and
userspace could do the same some other way (mmap presumably?). In both
cases, the operation might fail.

I would imagine the boot and private->shared flow as follow:

 - the VMM uses fallocate on the private fd, and associates the <fd,
   offset, size> with a memslot;

 - the guest boots, and as part of that KVM takes references to all the
   pages that are donated to the guest. If userspace happens to have a
   mapping to a page, KVM will fail to take the reference, which would
   be fatal for the guest.

 - once the guest has booted, it issues a hypercall to share a page back
   with the host;

 - KVM is notified, and at that point it drops its reference to the
   page. It then exits to userspace to notify it of the share;

 - host userspace receives the share, and mmaps the shared page with
   MAP_FIXED to access it, which takes a reference on the fd-backed
   page.

There are variations of that idea: e.g. allow userspace to mmap the
entire private fd but w/o taking a reference on pages mapped with
PROT_NONE. And then the VMM can use mprotect() in response to
share/unshare requests. I think Marc liked that idea as it keeps the
userspace API closer to normal KVM -- there actually is a
straightforward gpa->hva relation. Not sure how much that would impact
the implementation at this point.

For the shared=>private conversion, this would be something like so:

 - the guest issues a hypercall to unshare a page;

 - the hypervisor forwards the request to the host;

 - the host kernel forwards the request to userspace;

 - userspace then munmap()s the shared page;

 - KVM then tries to take a reference to the page. If it succeeds, it
   re-enters the guest with a flag of some sort saying that the share
   succeeded, and the hypervisor will adjust pgtables accordingly. If
   KVM failed to take a reference, it flags this and the hypervisor will
   be responsible for communicating that back to the guest. This means
   the guest must handle failures (possibly fatal).

(There are probably many ways in which we can optimize this, e.g. by
having the host proactively munmap() pages it no longer needs so that
the unshare hypercall from the guest doesn't need to exit all the way
back to host userspace.)

A nice side-effect of the above is that it allows userspace to dump a
payload in the private fd before booting the guest. It just needs to
mmap the fd, copy what it wants in there, munmap, and only then pass the
fd to KVM which will be happy enough as long as there are no current
references to the pages. Note: in a previous email I've said that
Android doesn't need this (which is correct as our guest bootloader
currently receives the payload over virtio) but this might change some
day, and there might be other implementations as well, so it's a nice
bonus if we can make this work.

> The best I can come up with is a special type of shared page that is not GUP-able and maybe not even mmappable, having a clear option for transitions to fail, and generally preventing the nasty cases from happening in the first place.

Right, that sounds reasonable to me.

> Maybe there could be a special mode for the private memory fds in which specific pages are marked as "managed by this fd but actually shared".  pread() and pwrite() would work on those pages, but not mmap().  (Or maybe mmap() but the resulting mappings would not permit GUP.)  And transitioning them would be a special operation on the fd that is specific to pKVM and wouldn't work on TDX or SEV.

Aha, didn't think of pread()/pwrite(). Very interesting.

I'd need to check what our VMM actually does, but as an initial
reaction it feels like this might require a pretty significant rework in
userspace. Maybe it's a good thing? Dunno. Maybe more important, those
shared pages are used for virtio communications, so the cost of issuing
syscalls every time the VMM needs to access the shared page will need to
be considered...

Thanks,
Quentin
