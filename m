Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E2617C4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKCMOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiKCMOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:14:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E9647D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 05:14:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gw22so1433500pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ykKkxzrVaENbuwNMnsDAkKb7vBCdpcfSASwQOTHYf5Y=;
        b=AHPIa6s8bgoeCdBzzeDdQ5gNw0eTrxD4uv0eiabE+6bUdZUsBZSphBK2pnp1T9iNGh
         ucAvqtZ9TE8HmnflVn2dCrnaSie5/XeYe4YLoo7WTDFkfMc5dpbI0+mTRyicVgIpdc0U
         X47b3t980ZiHx+DQ6QDrlNI5XftB9wivrJPYHspVki7Qvuv8R1MJlBmO06AKFy78undv
         /soPJJ0OE2THhqxBsaR73O1NnIgowDxvA8gY/F6HzsgmOXjSc7Xu8D7qNwgeY+s0O/Fx
         nRZzn5oDRfnMX0yVHuQcj6lrdqYgeWxfp/5NqczM0kfO8RkJ2TpgKmIc7Dc+JJb78Frs
         n2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykKkxzrVaENbuwNMnsDAkKb7vBCdpcfSASwQOTHYf5Y=;
        b=iEKAPPd0eTmwkPDeOCYOXMUVmcJ3gK2oJh2m++zYIDDzGNcG3AAEJWQQ9PrlRkFbsP
         UCOLlxCkaSCRj2mc9F5R89TEUYO5Blefu3wZIVI4D5kPRoteHSq1MD6OnOLXisFS+9fM
         rO6QHGp1tOG9V7kVeOkZt5Hvqx+oadkWsV/qX1kg3zAxV02riRxm+zuh8UHHh3jFZ8cJ
         nKdL2DGtTzjic6ww7q8n6rYUSfDBNVCHEz9U6Ee5rUkyEsm+9kemRunVKCW3448UFvqG
         a/lNUsxcj9FOiwM9qWDrutqjESFZ/hqVDXo8yMGPOqdCKA7waqT8av5SAmihmSeHbAZM
         XElQ==
X-Gm-Message-State: ACrzQf0XsoSAcJEOFauXW8ScRc1xW/xgoxfHVSeC5k2yl53RkFORRjVH
        3N72hTG8sf9KIEbe7yfN3deBYI1LU+nM7wF5pFQSowfJVGafgg==
X-Google-Smtp-Source: AMsMyM7MOsitCnFSBgl/ZnDBVruuaM7ihUaAsBPMHP2Hg7MlUfZnclYeHr7DuPtAXdWk7ISQPrhjiHeyEl1yBRgMxMM=
X-Received: by 2002:a17:90a:7bc4:b0:213:28e9:8a8a with SMTP id
 d4-20020a17090a7bc400b0021328e98a8amr31511762pjl.121.1667477643186; Thu, 03
 Nov 2022 05:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
In-Reply-To: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 3 Nov 2022 17:43:52 +0530
Message-ID: <CAGtprH-av3K6YxUbz1cAsQp4w2ce35UrfBF-u7Q_qCuTNMdvzQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] KVM: mm: fd-based approach for supporting KVM
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 25, 2022 at 8:48 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> This patch series implements KVM guest private memory for confidential
> computing scenarios like Intel TDX[1]. If a TDX host accesses
> TDX-protected guest memory, machine check can happen which can further
> crash the running host system, this is terrible for multi-tenant
> configurations. The host accesses include those from KVM userspace like
> QEMU. This series addresses KVM userspace induced crash by introducing
> new mm and KVM interfaces so KVM userspace can still manage guest memory
> via a fd-based approach, but it can never access the guest memory
> content.
>
> The patch series touches both core mm and KVM code. I appreciate
> Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> reviews are always welcome.
>   - 01: mm change, target for mm tree
>   - 02-08: KVM change, target for KVM tree
>
> Given KVM is the only current user for the mm part, I have chatted with
> Paolo and he is OK to merge the mm change through KVM tree, but
> reviewed-by/acked-by is still expected from the mm people.
>
> The patches have been verified in Intel TDX environment, but Vishal has
> done an excellent work on the selftests[4] which are dedicated for this
> series, making it possible to test this series without innovative
> hardware and fancy steps of building a VM environment. See Test section
> below for more info.
>
>
> Introduction
> ============
> KVM userspace being able to crash the host is horrible. Under current
> KVM architecture, all guest memory is inherently accessible from KVM
> userspace and is exposed to the mentioned crash issue. The goal of this
> series is to provide a solution to align mm and KVM, on a userspace
> inaccessible approach of exposing guest memory.
>
> Normally, KVM populates secondary page table (e.g. EPT) by using a host
> virtual address (hva) from core mm page table (e.g. x86 userspace page
> table). This requires guest memory being mmaped into KVM userspace, but
> this is also the source where the mentioned crash issue can happen. In
> theory, apart from those 'shared' memory for device emulation etc, guest
> memory doesn't have to be mmaped into KVM userspace.
>
> This series introduces fd-based guest memory which will not be mmaped
> into KVM userspace. KVM populates secondary page table by using a

With no mappings in place for userspace VMM, IIUC, looks like the host
kernel will not be able to find the culprit userspace process in case
of Machine check error on guest private memory. As implemented in
hwpoison_user_mappings, host kernel tries to look at the processes
which have mapped the pfns with hardware error.

Is there a modification needed in mce handling logic of the host
kernel to immediately send a signal to the vcpu thread accessing
faulting pfn backing guest private memory?


> fd/offset pair backed by a memory file system. The fd can be created
> from a supported memory filesystem like tmpfs/hugetlbfs and KVM can
> directly interact with them with newly introduced in-kernel interface,
> therefore remove the KVM userspace from the path of accessing/mmaping
> the guest memory.
>
> Kirill had a patch [2] to address the same issue in a different way. It
> tracks guest encrypted memory at the 'struct page' level and relies on
> HWPOISON to reject the userspace access. The patch has been discussed in
> several online and offline threads and resulted in a design document [3]
> which is also the original proposal for this series. Later this patch
> series evolved as more comments received in community but the major
> concepts in [3] still hold true so recommend reading.
>
> The patch series may also be useful for other usages, for example, pure
> software approach may use it to harden itself against unintentional
> access to guest memory. This series is designed with these usages in
> mind but doesn't have code directly support them and extension might be
> needed.
>
>
> mm change
> =========
> Introduces a new memfd_restricted system call which can create memory
> file that is restricted from userspace access via normal MMU operations
> like read(), write() or mmap() etc and the only way to use it is
> passing it to a third kernel module like KVM and relying on it to
> access the fd through the newly added restrictedmem kernel interface.
> The restrictedmem interface bridges the memory file subsystems
> (tmpfs/hugetlbfs etc) and their users (KVM in this case) and provides
> bi-directional communication between them.
>
>
> KVM change
> ==========
> Extends the KVM memslot to provide guest private (encrypted) memory from
> a fd. With this extension, a single memslot can maintain both private
> memory through private fd (restricted_fd/restricted_offset) and shared
> (unencrypted) memory through userspace mmaped host virtual address
> (userspace_addr). For a particular guest page, the corresponding page in
> KVM memslot can be only either private or shared and only one of the
> shared/private parts of the memslot is visible to guest. For how this
> new extension is used in QEMU, please refer to kvm_set_phys_mem() in
> below TDX-enabled QEMU repo.
>
> Introduces new KVM_EXIT_MEMORY_FAULT exit to allow userspace to get the
> chance on decision-making for shared <-> private memory conversion. The
> exit can be an implicit conversion in KVM page fault handler or an
> explicit conversion from guest OS.
>
> Extends existing SEV ioctls KVM_MEMORY_ENCRYPT_{UN,}REG_REGION to
> convert a guest page between private <-> shared. The data maintained in
> these ioctls tells the truth whether a guest page is private or shared
> and this information will be used in KVM page fault handler to decide
> whether the private or the shared part of the memslot is visible to
> guest.
>
>
> Test
> ====
> Ran two kinds of tests:
>   - Selftests [4] from Vishal and VM boot tests in non-TDX environment
>     Code also in below repo: https://github.com/chao-p/linux/tree/privmem-v9
>
>   - Functional tests in TDX capable environment
>     Tested the new functionalities in TDX environment. Code repos:
>     Linux: https://github.com/chao-p/linux/tree/privmem-v9-tdx
>     QEMU: https://github.com/chao-p/qemu/tree/privmem-v9
>
>     An example QEMU command line for TDX test:
>     -object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
>     -machine confidential-guest-support=tdx \
>     -object memory-backend-memfd-private,id=ram1,size=${mem} \
>     -machine memory-backend=ram1
>
>
> TODO
> ====
>   - Page accounting and limiting for encrypted memory
>   - hugetlbfs support
>
>
> Changelog
> =========
> v9:
>   - mm: move inaccessible memfd into separated syscall.
>   - mm: return page instead of pfn_t for inaccessible_get_pfn and remove
>     inaccessible_put_pfn.
>   - KVM: rename inaccessible/private to restricted and CONFIG change to
>     make the code friendly to pKVM.
>   - KVM: add invalidate_begin/end pair to fix race contention and revise
>     the lock protection for invalidation path.
>   - KVM: optimize setting lpage_info for > 2M level by direct accessing
>     lower level's result.
>   - KVM: avoid load xarray in kvm_mmu_max_mapping_level() and instead let
>     the caller to pass in is_private.
>   - KVM: API doc improvement.
> v8:
>   - mm: redesign mm part by introducing a shim layer(inaccessible_memfd)
>     in memfd to avoid touch the memory file systems directly.
>   - mm: exclude F_SEAL_AUTO_ALLOCATE as it is for shared memory and
>     cause confusion in this series, will send out separately.
>   - doc: exclude the man page change, it's not kernel patch and will
>     send out separately.
>   - KVM: adapt to use the new mm inaccessible_memfd interface.
>   - KVM: update lpage_info when setting mem_attr_array to support
>     large page.
>   - KVM: change from xa_store_range to xa_store for mem_attr_array due
>     to xa_store_range overrides all entries which is not intended
>     behavior for us.
>   - KVM: refine the mmu_invalidate_retry_gfn mechanism for private page.
>   - KVM: reorganize KVM_MEMORY_ENCRYPT_{UN,}REG_REGION and private page
>     handling code suggested by Sean.
> v7:
>   - mm: introduce F_SEAL_AUTO_ALLOCATE to avoid double allocation.
>   - KVM: use KVM_MEMORY_ENCRYPT_{UN,}REG_REGION to record
>     private/shared info.
>   - KVM: use similar sync mechanism between zap/page fault paths as
>     mmu_notifier for memfile_notifier based invalidation.
> v6:
>   - mm: introduce MEMFILE_F_* flags into memfile_node to allow checking
>     feature consistence among all memfile_notifier users and get rid of
>     internal flags like SHM_F_INACCESSIBLE.
>   - mm: make pfn_ops callbacks being members of memfile_backing_store
>     and then refer to it directly in memfile_notifier.
>   - mm: remove backing store unregister.
>   - mm: remove RLIMIT_MEMLOCK based memory accounting and limiting.
>   - KVM: reorganize patch sequence for page fault handling and private
>     memory enabling.
> v5:
>   - Add man page for MFD_INACCESSIBLE flag and improve KVM API do for
>     the new memslot extensions.
>   - mm: introduce memfile_{un}register_backing_store to allow memory
>     backing store to register/unregister it from memfile_notifier.
>   - mm: remove F_SEAL_INACCESSIBLE, use in-kernel flag
>     (SHM_F_INACCESSIBLE for shmem) instead.
>   - mm: add memory accounting and limiting (RLIMIT_MEMLOCK based) for
>     MFD_INACCESSIBLE memory.
>   - KVM: remove the overlap check for mapping the same file+offset into
>     multiple gfns due to perf consideration, warned in document.
> v4:
>   - mm: rename memfd_ops to memfile_notifier and separate it from
>     memfd.c to standalone memfile-notifier.c.
>   - KVM: move pfn_ops to per-memslot scope from per-vm scope and allow
>     registering multiple memslots to the same memory backing store.
>   - KVM: add a 'kvm' reference in memslot so that we can recover kvm in
>     memfile_notifier handlers.
>   - KVM: add 'private_' prefix for the new fields in memslot.
>   - KVM: reshape the 'type' to 'flag' for kvm_memory_exit
> v3:
>   - Remove 'RFC' prefix.
>   - Fix race condition between memfile_notifier handlers and kvm destroy.
>   - mm: introduce MFD_INACCESSIBLE flag for memfd_create() to force
>     setting F_SEAL_INACCESSIBLE when the fd is created.
>   - KVM: add the shared part of the memslot back to make private/shared
>     pages live in one memslot.
>
> Reference
> =========
> [1] Intel TDX:
> https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
> [2] Kirill's implementation:
> https://lore.kernel.org/all/20210416154106.23721-1-kirill.shutemov@linux.intel.com/T/
> [3] Original design proposal:
> https://lore.kernel.org/all/20210824005248.200037-1-seanjc@google.com/
> [4] Selftest:
> https://lore.kernel.org/all/20220819174659.2427983-1-vannapurve@google.com/
>
>
> Chao Peng (7):
>   KVM: Extend the memslot to support fd-based private memory
>   KVM: Add KVM_EXIT_MEMORY_FAULT exit
>   KVM: Use gfn instead of hva for mmu_notifier_retry
>   KVM: Register/unregister the guest private memory regions
>   KVM: Update lpage info when private/shared memory are mixed
>   KVM: Handle page fault for private memory
>   KVM: Enable and expose KVM_MEM_PRIVATE
>
> Kirill A. Shutemov (1):
>   mm: Introduce memfd_restricted system call to create restricted user
>     memory
>
>  Documentation/virt/kvm/api.rst         |  88 ++++-
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/include/asm/kvm_host.h        |   8 +
>  arch/x86/kvm/Kconfig                   |   3 +
>  arch/x86/kvm/mmu/mmu.c                 | 170 +++++++++-
>  arch/x86/kvm/mmu/mmu_internal.h        |  14 +-
>  arch/x86/kvm/mmu/mmutrace.h            |   1 +
>  arch/x86/kvm/mmu/spte.h                |   6 +
>  arch/x86/kvm/mmu/tdp_mmu.c             |   3 +-
>  arch/x86/kvm/x86.c                     |   4 +-
>  include/linux/kvm_host.h               |  89 ++++-
>  include/linux/restrictedmem.h          |  62 ++++
>  include/linux/syscalls.h               |   1 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/kvm.h               |  38 +++
>  include/uapi/linux/magic.h             |   1 +
>  kernel/sys_ni.c                        |   3 +
>  mm/Kconfig                             |   4 +
>  mm/Makefile                            |   1 +
>  mm/restrictedmem.c                     | 250 ++++++++++++++
>  virt/kvm/Kconfig                       |   7 +
>  virt/kvm/kvm_main.c                    | 453 +++++++++++++++++++++----
>  23 files changed, 1121 insertions(+), 92 deletions(-)
>  create mode 100644 include/linux/restrictedmem.h
>  create mode 100644 mm/restrictedmem.c
>
>
> base-commit: e18d6152ff0f41b7f01f9817372022df04e0d354
> --
> 2.25.1
>
