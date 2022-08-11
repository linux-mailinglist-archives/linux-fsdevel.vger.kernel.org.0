Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0BF58FD7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiHKNiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiHKNiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:38:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89F89CDD;
        Thu, 11 Aug 2022 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660225088; x=1691761088;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=3YSnNJEECrBHaKlYPHVfDKRlWH4sV/biWsKMZr6LyGA=;
  b=MWoLHKviM73gfIL2KJTHk8ig6DjGOjaBIjHcegsJukfHnWQuGmmFAt2B
   7cG9DWUuf4SWs42W6T4Dtrskj/uHCbDf9l0nKIu4n9EqfiLrukeZLw32n
   5+BnHIN7lPdwG2KLJvm7wEUEz7lYLP324fF4I+zAIy/f6m7t/YF7iivCh
   r/sakBT79yX2InpTW8l5QAff1BLcMpZXjRY9hHBy56b/VxzAl/3/akpYX
   vnB+Z/pyIgI0hHMMhNO175fI36ujBeq/+e7spOCLdfEnWKGh62V9bEXke
   tpfKcXToRSoLyHDE/J97Fzj2AOoTAj3J33dJUjmneTEE8roN2I+rFIoWF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271121805"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="271121805"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 06:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="665375567"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2022 06:37:40 -0700
Date:   Thu, 11 Aug 2022 21:32:55 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     "Nikunj A. Dadhania" <nikunj@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220811133255.GB916119@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 01:30:06PM +0200, Gupta, Pankaj wrote:
> 
> > > This is the v7 of this series which tries to implement the fd-based KVM
> > > guest private memory. The patches are based on latest kvm/queue branch
> > > commit:
> > > 
> > >    b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> > > split_desc_cache only by default capacity
> > > 
> > > Introduction
> > > ------------
> > > In general this patch series introduce fd-based memslot which provides
> > > guest memory through memory file descriptor fd[offset,size] instead of
> > > hva/size. The fd can be created from a supported memory filesystem
> > > like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> > > and the the memory backing store exchange callbacks when such memslot
> > > gets created. At runtime KVM will call into callbacks provided by the
> > > backing store to get the pfn with the fd+offset. Memory backing store
> > > will also call into KVM callbacks when userspace punch hole on the fd
> > > to notify KVM to unmap secondary MMU page table entries.
> > > 
> > > Comparing to existing hva-based memslot, this new type of memslot allows
> > > guest memory unmapped from host userspace like QEMU and even the kernel
> > > itself, therefore reduce attack surface and prevent bugs.
> > > 
> > > Based on this fd-based memslot, we can build guest private memory that
> > > is going to be used in confidential computing environments such as Intel
> > > TDX and AMD SEV. When supported, the memory backing store can provide
> > > more enforcement on the fd and KVM can use a single memslot to hold both
> > > the private and shared part of the guest memory.
> > > 
> > > mm extension
> > > ---------------------
> > > Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
> > > created with these flags cannot read(), write() or mmap() etc via normal
> > > MMU operations. The file content can only be used with the newly
> > > introduced memfile_notifier extension.
> > > 
> > > The memfile_notifier extension provides two sets of callbacks for KVM to
> > > interact with the memory backing store:
> > >    - memfile_notifier_ops: callbacks for memory backing store to notify
> > >      KVM when memory gets invalidated.
> > >    - backing store callbacks: callbacks for KVM to call into memory
> > >      backing store to request memory pages for guest private memory.
> > > 
> > > The memfile_notifier extension also provides APIs for memory backing
> > > store to register/unregister itself and to trigger the notifier when the
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
> > > A page in the memslot is either private or shared. Whether a guest page
> > > is private or shared is maintained through reusing existing SEV ioctls
> > > KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
> > > 
> > > Test
> > > ----
> > > To test the new functionalities of this patch TDX patchset is needed.
> > > Since TDX patchset has not been merged so I did two kinds of test:
> > > 
> > > -  Regresion test on kvm/queue (this patchset)
> > >     Most new code are not covered. Code also in below repo:
> > >     https://github.com/chao-p/linux/tree/privmem-v7
> > > 
> > > -  New Funational test on latest TDX code
> > >     The patch is rebased to latest TDX code and tested the new
> > >     funcationalities. See below repos:
> > >     Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
> > >     QEMU: https://github.com/chao-p/qemu/tree/privmem-v7
> > 
> > While debugging an issue with SEV+UPM, found that fallocate() returns
> > an error in QEMU which is not handled (EINTR). With the below handling
> > of EINTR subsequent fallocate() succeeds:

QEMU code has not well-tested so it's not strange you met problem. But
from the man page, there is signal was caught for EINTR, do you know
the signal number?

Thanks for you patch but before we change it in QEMU I want to make sure
it's indeed a QEMU issue (e.g. not a kernel isssue).

> > 
> > 
> > diff --git a/backends/hostmem-memfd-private.c b/backends/hostmem-memfd-private.c
> > index af8fb0c957..e8597ed28d 100644
> > --- a/backends/hostmem-memfd-private.c
> > +++ b/backends/hostmem-memfd-private.c
> > @@ -39,7 +39,7 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >       MachineState *machine = MACHINE(qdev_get_machine());
> >       uint32_t ram_flags;
> >       char *name;
> > -    int fd, priv_fd;
> > +    int fd, priv_fd, ret;
> >       if (!backend->size) {
> >           error_setg(errp, "can't create backend with size 0");
> > @@ -65,7 +65,15 @@ priv_memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >                                      backend->size, ram_flags, fd, 0, errp);
> >       g_free(name);
> > -    fallocate(priv_fd, 0, 0, backend->size);
> > +again:
> > +    ret = fallocate(priv_fd, 0, 0, backend->size);
> > +    if (ret) {
> > +           perror("Fallocate failed: \n");
> > +           if (errno == EINTR)
> > +                   goto again;
> > +           else
> > +                   exit(1);
> > +    }
> > 
> > However, fallocate() preallocates full guest memory before starting the guest.
> > With this behaviour guest memory is *not* demand pinned. Is there a way to
> > prevent fallocate() from reserving full guest memory?
> 
> Isn't the pinning being handled by the corresponding host memory backend
> with mmu notifier and architecture support while doing the memory operations
> e.g page migration and swapping/reclaim (not supported
> currently AFAIU). But yes, we need to allocate entire guest memory with the
> new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.

Right.

> 
> 
> Thanks,
> Pankaj
> 
> > 
> > > An example QEMU command line for TDX test:
> > > -object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
> > > -machine confidential-guest-support=tdx \
> > > -object memory-backend-memfd-private,id=ram1,size=${mem} \
> > > -machine memory-backend=ram1
> > > 
> > 
> > Regards,
> > Nikunj
> > 
> > 
