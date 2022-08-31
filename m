Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4E5A79CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiHaJMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiHaJMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:12:54 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4AB95A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 02:12:50 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11edd61a9edso16670354fac.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=2AurYSM1bnx6rUKp3T4fU2Ap+P4TodGdt/6QzDzwNPU=;
        b=Hxyt+/QtP6nwwzEIypsCXHSN2VBvFxzde5VXSMplI6ma4CNiOt87DkIWgFMZVyhJwh
         X6+9mGCV1xSAjJ9lff4r2GkeKHp0yIfbcxvVV+1MG3PNKnCOI/n7uJ5OVjtiUyAjxwHp
         qhIqLwF4rdAcMN9z2z45ruit5DsIMcwdlJEgwZieaSuB8P9d2/b+saUW8pzR+Ttof5KL
         Tbd991Tdudh1MHpMCVsll6t5oWllB/pgQCe10VGFRGd7BSWvVhKMRPMdlmUShpCL8DTH
         nqxFNSY0zHXp7FBEwAe33H1/cDkqdA33xUnsgWJdQ25EOpDYl7jIOcRp5X0qeQJyRU+F
         cqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=2AurYSM1bnx6rUKp3T4fU2Ap+P4TodGdt/6QzDzwNPU=;
        b=yNFy10HCDRHlr+our+LC7v99I2OMbxk3wnthIrPi31fRu/k7m4R4JQz16C6a0WgbTp
         2aww6CoxMxC/mXNK/icPGTA4eUYyvAdCpKHo7v4/DawT+5rJOICoSnfFzkTqnzeGugPB
         1yyyuDCtepcOSpS2IyQa7V7MfFhCGPwigmuaSBbS4OS4OMQr3raNwmMUtcE/EeP9ErHq
         cIwmcevWa97f0f4lCdhDFQhxcI2mYl8L9Ikh+IHeS9+CKW653qP1cAa1WdLNCBEGzg+u
         H0Prytk16G0glF44xW1u7oHuB/OdpsGSnLIWiWu08vXQvsUQTO0iTbXe6ZBmAP7YFfMN
         RTpg==
X-Gm-Message-State: ACgBeo3zyufXADikRipTyvdpaBCHYYUTaNhu/UMwixmVHQJUA6sjxBvr
        5ygRwnYaRdJ2MXPwsAbtqZmsEo/UMVeMqxbXKNsd1g==
X-Google-Smtp-Source: AA6agR7BaRI4klWWKRrsSz/BRDg1gBObZsSbpa6c6muZHtwvynBjweQjZin3DpAAGze9FncYXHkeRU1pTdeNBizgPo8=
X-Received: by 2002:a05:6870:4783:b0:118:81e3:27ec with SMTP id
 c3-20020a056870478300b0011881e327ecmr967419oaq.146.1661937169260; Wed, 31 Aug
 2022 02:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <CA+EHjTy6NF=BkCqK0vhXLdtKZMahp55JUMSfxN96-NT3YiMXYQ@mail.gmail.com> <20220829151756.GB1586678@chaop.bj.intel.com>
In-Reply-To: <20220829151756.GB1586678@chaop.bj.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 31 Aug 2022 10:12:12 +0100
Message-ID: <CA+EHjTxgKJ=9UP=DWtNsSgD2FtvBMYrUbcS=9h5j8Tmk57WqxQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Chao,

Thank you for your reply.

On Mon, Aug 29, 2022 at 4:23 PM Chao Peng <chao.p.peng@linux.intel.com> wro=
te:
>
> On Fri, Aug 26, 2022 at 04:19:25PM +0100, Fuad Tabba wrote:
> > Hi,
> >
> > On Wed, Jul 6, 2022 at 9:24 AM Chao Peng <chao.p.peng@linux.intel.com> =
wrote:
> > >
> > > This is the v7 of this series which tries to implement the fd-based K=
VM
> > > guest private memory. The patches are based on latest kvm/queue branc=
h
> > > commit:
> > >
> > >   b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> > > split_desc_cache only by default capacity
> > >
> > > Introduction
> > > ------------
> > > In general this patch series introduce fd-based memslot which provide=
s
> > > guest memory through memory file descriptor fd[offset,size] instead o=
f
> > > hva/size. The fd can be created from a supported memory filesystem
> > > like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> > > and the the memory backing store exchange callbacks when such memslot
> > > gets created. At runtime KVM will call into callbacks provided by the
> > > backing store to get the pfn with the fd+offset. Memory backing store
> > > will also call into KVM callbacks when userspace punch hole on the fd
> > > to notify KVM to unmap secondary MMU page table entries.
> > >
> > > Comparing to existing hva-based memslot, this new type of memslot all=
ows
> > > guest memory unmapped from host userspace like QEMU and even the kern=
el
> > > itself, therefore reduce attack surface and prevent bugs.
> > >
> > > Based on this fd-based memslot, we can build guest private memory tha=
t
> > > is going to be used in confidential computing environments such as In=
tel
> > > TDX and AMD SEV. When supported, the memory backing store can provide
> > > more enforcement on the fd and KVM can use a single memslot to hold b=
oth
> > > the private and shared part of the guest memory.
> > >
> > > mm extension
> > > ---------------------
> > > Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
> > > created with these flags cannot read(), write() or mmap() etc via nor=
mal
> > > MMU operations. The file content can only be used with the newly
> > > introduced memfile_notifier extension.
> > >
> > > The memfile_notifier extension provides two sets of callbacks for KVM=
 to
> > > interact with the memory backing store:
> > >   - memfile_notifier_ops: callbacks for memory backing store to notif=
y
> > >     KVM when memory gets invalidated.
> > >   - backing store callbacks: callbacks for KVM to call into memory
> > >     backing store to request memory pages for guest private memory.
> > >
> > > The memfile_notifier extension also provides APIs for memory backing
> > > store to register/unregister itself and to trigger the notifier when =
the
> > > bookmarked memory gets invalidated.
> > >
> > > The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
> > > prevent double allocation caused by unintentional guest when we only
> > > have a single side of the shared/private memfds effective.
> > >
> > > memslot extension
> > > -----------------
> > > Add the private fd and the fd offset to existing 'shared' memslot so
> > > that both private/shared guest memory can live in one single memslot.
> > > A page in the memslot is either private or shared. Whether a guest pa=
ge
> > > is private or shared is maintained through reusing existing SEV ioctl=
s
> > > KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
> > >
> >
> > I'm on the Android pKVM team at Google, and we've been looking into
> > how this approach fits with what we've been doing with pkvm/arm64.
> > I've had a go at porting your patches, along with some fixes and
> > additions so it would go on top of our latest pkvm patch series [1] to
> > see how well this proposal fits with what we=E2=80=99re doing. You can =
find
> > the ported code at this link [2].
> >
> > In general, an fd-based approach fits very well with pKVM for the
> > reasons you mention. It means that we don't necessarily need to map
> > the guest memory, and with the new extensions it allows the host
> > kernel to control whether to restrict migration and swapping.
>
> Good to hear that.
>
> >
> > For pKVM, we would also need the guest private memory not to be
> > GUP=E2=80=99able by the kernel so that userspace can=E2=80=99t trick th=
e kernel into
> > accessing guest private memory in a context where it isn=E2=80=99t prep=
ared to
> > handle the fault injected by the hypervisor. We=E2=80=99re looking at w=
hether
> > we could use memfd_secret to achieve this, or maybe whether extending
> > your work might solve the problem.
>
> This is interesting and can be a valuable addition to this series.

I'll keep you posted as it goes. I think with the work that you've
already put in, it wouldn't require that much more.

> >
> > However, during the porting effort, the main issue we've encountered
> > is that many of the details of this approach seem to be targeted at
> > TDX/SEV and don=E2=80=99t readily align with the design of pKVM. My kno=
wledge
> > on TDX is very rudimentary, so please bear with me if I get things
> > wrong.
>
> No doubt this series is initially designed for confidential computing
> usages, but pKVM can definitely extend it if it finds useful.
>
> >
> > The idea of the memslot having two references to the backing memory,
> > the (new) private_fd (a file descriptor) as well as the userspace_addr
> > (a memory address), with the meaning changing depending on whether the
> > memory is private or shared. Both can potentially be live at the same
> > time, but only one is used by the guest depending on whether the
> > memory is shared or private. For pKVM, the memory region is the same,
> > and whether the underlying physical page is shared or private is
> > determined by the hypervisor based on the initial configuration of the
> > VM and also in response to hypercalls from the guest.
>
> For confidential computing usages, this is actually the same. The shared
> or private is determined by initial configuration or guest hypercalls.
>
> > So at least from
> > our side, having a private_fd isn't the best fit, but rather just
> > having an fd instead of a userspace_addr.
>
> Let me understand this a bit: pKVM basically wants to maintain the
> shared and private memory in only one fd, and not use userspace_addr at
> all, right? Any blocking for pKVM to use private_fd + userspace_addr
> instead?
> >
> > Moreover, something which was discussed here before [3], is the
> > ability to share in-place. For pKVM/arm64, the conversion between
> > shared and private involves only changes to the stage-2 page tables,
> > which are controlled by the hypervisor. Android supports this in-place
> > conversion already, and I think that the cost of copying for many
> > use-cases that would involve large amounts of data would be big. We
> > will measure the relative costs in due course, but in the meantime
> > we=E2=80=99re nervous about adopting a new user ABI which doesn=E2=80=
=99t appear to
> > cater for in-place conversion; having just the fd would simplify that
> > somewhat
>
> I understand there is difficulty to achieve that with the current
> private_fd + userspace_addr (they basically in two separate fds), but is
> it possible for pKVM to extend this? Brainstorming for example, pKVM can
> ignore userspace_addr and only use private_fd to cover both shared and
> private memory, or pKVM introduce new KVM memslot flag?

It's not that there's anything blocking pKVM from doing that. It's
that the disconnect of using a memory address for the shared memory,
and a file descriptor for the private memory doesn't really make sense
for pKVM. I see how it makes sense for TDX and the Intel-specific
implementation. It just seems that this is baking in an
implementation-specific aspect as a part of the KVM general api, and
the worry is that this might have some unintended consequences in the
future.

> >
> > In the memfd approach, what is the plan for being able to initialize
> > guest private memory from the host? In my port of this patch series,
> > I've added an fcntl() command that allows setting INACCESSIBLE after
> > the memfd has been created. So the memory can be mapped, initialized,
> > then unmapped. Of course there is no way to enforce that the memory is
> > unmapped from userspace before being used as private memory, but the
> > hypervisor will take care of the stage-2 mapping and so a user access
> > to the private memory would result in a SEGV regardless of the flag
>
> There is discussion on removing MFD_INACCESSIBLE and delaying the
> alignment of the flag to the KVM/backing store binding time
> (https://lkml.kernel.org/lkml/20220824094149.GA1383966@chaop.bj.intel.com=
/).
>
> Creating new API like what you are playing with fcntl() also works if it
> turns out the MFD_INACCESSIBLE has to be set at the memfd_create time.

That makes sense.

> >
> > Now, moving on to implementation-specific issues in this patch series
> > that I have encountered:
> >
> > - There are a couple of small issues in porting the patches, some of
> > which have been mentioned already by others. I will point out the rest
> > in direct replies to these patches.
>
> Thanks.
>
> >
> > - MEMFILE_F_UNRECLAIMABLE and MEMFILE_F_UNMOVABLE are never set in
> > this patch series. MFD_INACCESSIBLE only sets
> > MEMFILE_F_USER_INACCESSIBLE. Is this intentional?
>
> It gets set in kvm_private_mem_register() of patch 13, basically those
> flags are expected to be set by architecture code.
>
> >
> > - Nothing in this patch series enforces that MFD_INACCESSIBLE or that
> > any of the MEMFILE_F_* flags are set for the file descriptor to be
> > used as a private_fd. Is this also intentional?
>
> With KVM_MEM_PRIVATE memslot flag, the MEMFILE_F_* are enforced by the
> architecture code.

Right. I was expecting them to be in the mem_fd, but I see now how
they are being set and enforced in patch 13. This makes a lot of sense
now. Thanks!

> >
> > Most of us working on pKVM will be at KVM forum Dublin in September,
> > so it would be great if we could have a chat (and/or beer!) face to
> > face sometime during the conference to help us figure out an
> > upstreamable solution for Android
>
> I would like to, but currently I have no travel plan due to COVID-19 :(
> We can have more online discussions anyway.

Of course! We'll continue this online, and hopefully we will get a
chance to meet in person soon.

Cheers,
/fuad


> Thanks,
> Chao
> >
> > Cheers,
> > /fuad
> >
> > [1] https://lore.kernel.org/all/20220630135747.26983-1-will@kernel.org/
> > [2] https://android-kvm.googlesource.com/linux/+/refs/heads/tabba/fdmem
> > [3] https://lore.kernel.org/all/YkcTTY4YjQs5BRhE@google.com/
> >
> >
> > > Test
> > > ----
> > > To test the new functionalities of this patch TDX patchset is needed.
> > > Since TDX patchset has not been merged so I did two kinds of test:
> > >
> > > -  Regresion test on kvm/queue (this patchset)
> > >    Most new code are not covered. Code also in below repo:
> > >    https://github.com/chao-p/linux/tree/privmem-v7
> > >
> > > -  New Funational test on latest TDX code
> > >    The patch is rebased to latest TDX code and tested the new
> > >    funcationalities. See below repos:
> > >    Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
> > >    QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
> > >
> > > An example QEMU command line for TDX test:
> > > -object tdx-guest,id=3Dtdx,debug=3Doff,sept-ve-disable=3Doff \
> > > -machine confidential-guest-support=3Dtdx \
> > > -object memory-backend-memfd-private,id=3Dram1,size=3D${mem} \
> > > -machine memory-backend=3Dram1
> > >
> > > Changelog
> > > ----------
> > > v7:
> > >   - Move the private/shared info from backing store to KVM.
> > >   - Introduce F_SEAL_AUTO_ALLOCATE to avoid double allocation.
> > >   - Rework on the sync mechanism between zap/page fault paths.
> > >   - Addressed other comments in v6.
> > > v6:
> > >   - Re-organzied patch for both mm/KVM parts.
> > >   - Added flags for memfile_notifier so its consumers can state their
> > >     features and memory backing store can check against these flags.
> > >   - Put a backing store reference in the memfile_notifier and move pf=
n_ops
> > >     into backing store.
> > >   - Only support boot time backing store register.
> > >   - Overall KVM part improvement suggested by Sean and some others.
> > > v5:
> > >   - Removed userspace visible F_SEAL_INACCESSIBLE, instead using an
> > >     in-kernel flag (SHM_F_INACCESSIBLE for shmem). Private fd can onl=
y
> > >     be created by MFD_INACCESSIBLE.
> > >   - Introduced new APIs for backing store to register itself to
> > >     memfile_notifier instead of direct function call.
> > >   - Added the accounting and restriction for MFD_INACCESSIBLE memory.
> > >   - Added KVM API doc for new memslot extensions and man page for the=
 new
> > >     MFD_INACCESSIBLE flag.
> > >   - Removed the overlap check for mapping the same file+offset into
> > >     multiple gfns due to perf consideration, warned in document.
> > >   - Addressed other comments in v4.
> > > v4:
> > >   - Decoupled the callbacks between KVM/mm from memfd and use new
> > >     name 'memfile_notifier'.
> > >   - Supported register multiple memslots to the same backing store.
> > >   - Added per-memslot pfn_ops instead of per-system.
> > >   - Reworked the invalidation part.
> > >   - Improved new KVM uAPIs (private memslot extension and memory
> > >     error) per Sean's suggestions.
> > >   - Addressed many other minor fixes for comments from v3.
> > > v3:
> > >   - Added locking protection when calling
> > >     invalidate_page_range/fallocate callbacks.
> > >   - Changed memslot structure to keep use useraddr for shared memory.
> > >   - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
> > >   - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
> > >   - Commit message improvement.
> > >   - Many small fixes for comments from the last version.
> > >
> > > Links to previous discussions
> > > -----------------------------
> > > [1] Original design proposal:
> > > https://lkml.kernel.org/kvm/20210824005248.200037-1-seanjc@google.com=
/
> > > [2] Updated proposal and RFC patch v1:
> > > https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.p=
eng@linux.intel.com/
> > > [3] Patch v5: https://lkml.org/lkml/2022/5/19/861
> > >
> > > Chao Peng (12):
> > >   mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
> > >   selftests/memfd: Add tests for F_SEAL_AUTO_ALLOCATE
> > >   mm: Introduce memfile_notifier
> > >   mm/memfd: Introduce MFD_INACCESSIBLE flag
> > >   KVM: Rename KVM_PRIVATE_MEM_SLOTS to KVM_INTERNAL_MEM_SLOTS
> > >   KVM: Use gfn instead of hva for mmu_notifier_retry
> > >   KVM: Rename mmu_notifier_*
> > >   KVM: Extend the memslot to support fd-based private memory
> > >   KVM: Add KVM_EXIT_MEMORY_FAULT exit
> > >   KVM: Register/unregister the guest private memory regions
> > >   KVM: Handle page fault for private memory
> > >   KVM: Enable and expose KVM_MEM_PRIVATE
> > >
> > > Kirill A. Shutemov (1):
> > >   mm/shmem: Support memfile_notifier
> > >
> > >  Documentation/virt/kvm/api.rst             |  77 +++++-
> > >  arch/arm64/kvm/mmu.c                       |   8 +-
> > >  arch/mips/include/asm/kvm_host.h           |   2 +-
> > >  arch/mips/kvm/mmu.c                        |  10 +-
> > >  arch/powerpc/include/asm/kvm_book3s_64.h   |   2 +-
> > >  arch/powerpc/kvm/book3s_64_mmu_host.c      |   4 +-
> > >  arch/powerpc/kvm/book3s_64_mmu_hv.c        |   4 +-
> > >  arch/powerpc/kvm/book3s_64_mmu_radix.c     |   6 +-
> > >  arch/powerpc/kvm/book3s_hv_nested.c        |   2 +-
> > >  arch/powerpc/kvm/book3s_hv_rm_mmu.c        |   8 +-
> > >  arch/powerpc/kvm/e500_mmu_host.c           |   4 +-
> > >  arch/riscv/kvm/mmu.c                       |   4 +-
> > >  arch/x86/include/asm/kvm_host.h            |   3 +-
> > >  arch/x86/kvm/Kconfig                       |   3 +
> > >  arch/x86/kvm/mmu.h                         |   2 -
> > >  arch/x86/kvm/mmu/mmu.c                     |  74 +++++-
> > >  arch/x86/kvm/mmu/mmu_internal.h            |  18 ++
> > >  arch/x86/kvm/mmu/mmutrace.h                |   1 +
> > >  arch/x86/kvm/mmu/paging_tmpl.h             |   4 +-
> > >  arch/x86/kvm/x86.c                         |   2 +-
> > >  include/linux/kvm_host.h                   | 105 +++++---
> > >  include/linux/memfile_notifier.h           |  91 +++++++
> > >  include/linux/shmem_fs.h                   |   2 +
> > >  include/uapi/linux/fcntl.h                 |   1 +
> > >  include/uapi/linux/kvm.h                   |  37 +++
> > >  include/uapi/linux/memfd.h                 |   1 +
> > >  mm/Kconfig                                 |   4 +
> > >  mm/Makefile                                |   1 +
> > >  mm/memfd.c                                 |  18 +-
> > >  mm/memfile_notifier.c                      | 123 ++++++++++
> > >  mm/shmem.c                                 | 125 +++++++++-
> > >  tools/testing/selftests/memfd/memfd_test.c | 166 +++++++++++++
> > >  virt/kvm/Kconfig                           |   3 +
> > >  virt/kvm/kvm_main.c                        | 272 ++++++++++++++++++-=
--
> > >  virt/kvm/pfncache.c                        |  14 +-
> > >  35 files changed, 1074 insertions(+), 127 deletions(-)
> > >  create mode 100644 include/linux/memfile_notifier.h
> > >  create mode 100644 mm/memfile_notifier.c
> > >
> > > --
> > > 2.25.1
> > >
