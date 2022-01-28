Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BBF49FE4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 17:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350027AbiA1Qrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 11:47:31 -0500
Received: from foss.arm.com ([217.140.110.172]:53660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349936AbiA1Qra (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:47:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EB6F113E;
        Fri, 28 Jan 2022 08:47:30 -0800 (PST)
Received: from [10.57.13.224] (unknown [10.57.13.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0C573F793;
        Fri, 28 Jan 2022 08:47:25 -0800 (PST)
Message-ID: <3326f57a-169d-8eb8-2b8b-0379c33ba7a5@arm.com>
Date:   Fri, 28 Jan 2022 16:47:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 00/12] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-GB
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/01/2022 13:21, Chao Peng wrote:
> This is the v4 of this series which try to implement the fd-based KVM
> guest private memory. The patches are based on latest kvm/queue branch
> commit:
> 
>   fea31d169094 KVM: x86/pmu: Fix available_event_types check for
>                REF_CPU_CYCLES event
> 
> Introduction
> ------------
> In general this patch series introduce fd-based memslot which provides
> guest memory through memory file descriptor fd[offset,size] instead of
> hva/size. The fd can be created from a supported memory filesystem
> like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> and the the memory backing store exchange callbacks when such memslot
> gets created. At runtime KVM will call into callbacks provided by the
> backing store to get the pfn with the fd+offset. Memory backing store
> will also call into KVM callbacks when userspace fallocate/punch hole
> on the fd to notify KVM to map/unmap secondary MMU page tables.
> 
> Comparing to existing hva-based memslot, this new type of memslot allows
> guest memory unmapped from host userspace like QEMU and even the kernel
> itself, therefore reduce attack surface and prevent bugs.
> 
> Based on this fd-based memslot, we can build guest private memory that
> is going to be used in confidential computing environments such as Intel
> TDX and AMD SEV. When supported, the memory backing store can provide
> more enforcement on the fd and KVM can use a single memslot to hold both
> the private and shared part of the guest memory. 

This looks like it will be useful for Arm's Confidential Compute
Architecture (CCA) too - in particular we need a way of ensuring that
user space cannot 'trick' the kernel into accessing memory which has
been delegated to a realm (i.e. protected guest), and a memfd seems like
a good match.

Some comments below.

> mm extension
> ---------------------
> Introduces new F_SEAL_INACCESSIBLE for shmem and new MFD_INACCESSIBLE
> flag for memfd_create(), the file created with these flags cannot read(),
> write() or mmap() etc via normal MMU operations. The file content can
> only be used with the newly introduced memfile_notifier extension.

For Arm CCA we are expecting to seed the realm with an initial memory
contents (e.g. kernel and initrd) which will then be measured before
execution starts. The 'obvious' way of doing this with a memfd would be
to populate parts of the memfd then seal it with F_SEAL_INACCESSIBLE.

However as things stand it's not possible to set the INACCESSIBLE seal
after creating a memfd (F_ALL_SEALS hasn't been updated to include it).

One potential workaround would be for arm64 to provide a custom KVM
ioctl to effectively memcpy() into the guest's protected memory which
would only be accessible before the guest has started. The drawback is
that it requires two copies of the data during guest setup.

Do you think things could be relaxed so the F_SEAL_INACCESSIBLE flag
could be set after a memfd has been created (and partially populated)?

Thanks,

Steve

> The memfile_notifier extension provides two sets of callbacks for KVM to
> interact with the memory backing store:
>   - memfile_notifier_ops: callbacks for memory backing store to notify
>     KVM when memory gets allocated/invalidated.
>   - memfile_pfn_ops: callbacks for KVM to call into memory backing store
>     to request memory pages for guest private memory.
> 
> memslot extension
> -----------------
> Add the private fd and the fd offset to existing 'shared' memslot so that
> both private/shared guest memory can live in one single memslot. A page in
> the memslot is either private or shared. A page is private only when it's
> already allocated in the backing store fd, all the other cases it's treated
> as shared, this includes those already mapped as shared as well as those
> having not been mapped. This means the memory backing store is the place
> which tells the truth of which page is private.
> 
> Private memory map/unmap and conversion
> ---------------------------------------
> Userspace's map/unmap operations are done by fallocate() ioctl on the
> backing store fd.
>   - map: default fallocate() with mode=0.
>   - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.
> The map/unmap will trigger above memfile_notifier_ops to let KVM map/unmap
> secondary MMU page tables.
> 
> Test
> ----
> To test the new functionalities of this patch TDX patchset is needed.
> Since TDX patchset has not been merged so I did two kinds of test:
> 
> -  Regresion test on kvm/queue (this patch)
>    Most new code are not covered. I only tested building and booting.
> 
> -  New Funational test on latest TDX code
>    The patch is rebased to latest TDX code and tested the new
>    funcationalities.
> 
> For TDX test please see below repos:
> Linux: https://github.com/chao-p/linux/tree/privmem-v4.3
> QEMU: https://github.com/chao-p/qemu/tree/privmem-v4
> 
> And an example QEMU command line:
> -object tdx-guest,id=tdx \
> -object memory-backend-memfd-private,id=ram1,size=2G \
> -machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1
> 
> Changelog
> ----------
> v4:
>   - Decoupled the callbacks between KVM/mm from memfd and use new
>     name 'memfile_notifier'.
>   - Supported register multiple memslots to the same backing store.
>   - Added per-memslot pfn_ops instead of per-system.
>   - Reworked the invalidation part.
>   - Improved new KVM uAPIs (private memslot extension and memory
>     error) per Sean's suggestions.
>   - Addressed many other minor fixes for comments from v3.
> v3:
>   - Added locking protection when calling
>     invalidate_page_range/fallocate callbacks.
>   - Changed memslot structure to keep use useraddr for shared memory.
>   - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
>   - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
>   - Commit message improvement.
>   - Many small fixes for comments from the last version.
> 
> Links of previous discussions
> -----------------------------
> [1] Original design proposal:
> https://lkml.kernel.org/kvm/20210824005248.200037-1-seanjc@google.com/
> [2] Updated proposal and RFC patch v1:
> https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.peng@linux.intel.com/
> [3] Patch v3: https://lkml.org/lkml/2021/12/23/283
> 
> Chao Peng (11):
>   mm/memfd: Introduce MFD_INACCESSIBLE flag
>   mm: Introduce memfile_notifier
>   mm/shmem: Support memfile_notifier
>   KVM: Extend the memslot to support fd-based private memory
>   KVM: Use kvm_userspace_memory_region_ext
>   KVM: Add KVM_EXIT_MEMORY_ERROR exit
>   KVM: Use memfile_pfn_ops to obtain pfn for private pages
>   KVM: Handle page fault for private memory
>   KVM: Register private memslot to memory backing store
>   KVM: Zap existing KVM mappings when pages changed in the private fd
>   KVM: Expose KVM_MEM_PRIVATE
> 
> Kirill A. Shutemov (1):
>   mm/shmem: Introduce F_SEAL_INACCESSIBLE
> 
>  arch/x86/kvm/Kconfig             |   1 +
>  arch/x86/kvm/mmu/mmu.c           |  73 +++++++++++-
>  arch/x86/kvm/mmu/paging_tmpl.h   |  11 +-
>  arch/x86/kvm/x86.c               |  12 +-
>  include/linux/kvm_host.h         |  49 +++++++-
>  include/linux/memfile_notifier.h |  53 +++++++++
>  include/linux/shmem_fs.h         |   4 +
>  include/uapi/linux/fcntl.h       |   1 +
>  include/uapi/linux/kvm.h         |  17 +++
>  include/uapi/linux/memfd.h       |   1 +
>  mm/Kconfig                       |   4 +
>  mm/Makefile                      |   1 +
>  mm/memfd.c                       |  20 +++-
>  mm/memfile_notifier.c            |  99 ++++++++++++++++
>  mm/shmem.c                       | 121 +++++++++++++++++++-
>  virt/kvm/kvm_main.c              | 188 +++++++++++++++++++++++++++----
>  16 files changed, 614 insertions(+), 41 deletions(-)
>  create mode 100644 include/linux/memfile_notifier.h
>  create mode 100644 mm/memfile_notifier.c
> 

