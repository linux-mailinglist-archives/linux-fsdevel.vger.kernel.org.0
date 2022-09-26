Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9E5EAB76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiIZPpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiIZPoa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:44:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541246DBB;
        Mon, 26 Sep 2022 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664202499; x=1695738499;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=popbE19nKyEVwEGLpuPjkB9hubnGI4/mt3D2DsIdq20=;
  b=VOmjQDpgUtNfhGsIapa2JrKADo8DGSf8o+87QWFZqxYIayeqKaSIjsdc
   kwhZw9p77kN/eRTmUMe8r/5V3+87RR/hWYj3x/JNyaterjVfszFTb0ip3
   1DGNoxUcd+Xyw7zgtecWlYLgtcaJOjsABAJY6VMBS/yZNUSjZzfh2ocVw
   NmX7dr7XavoJLwazr/uuPlAXeb1f3+XXKdgwzEvKs/YFsBwmf5gKTD8qS
   lbpkNubtbXU/Z4UQfwcx2uu7A4/dD/qDTSA92e2yVHEfEEpxK7N+c+yrD
   5lxzwJCpnAsmKFoQMZN8QAWuc8+Zsi9v4t2mwbaRGrPy5cBKC+U0WLfsq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="301023549"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="301023549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 07:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="598755672"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="598755672"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2022 07:28:07 -0700
Date:   Mon, 26 Sep 2022 22:23:30 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20220926142330.GC2658254@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
 <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 04:19:46PM +0100, Fuad Tabba wrote:
> > Regarding pKVM's use case, with the shim approach I believe this can be done by
> > allowing userspace mmap() the "hidden" memfd, but with a ton of restrictions
> > piled on top.
> >
> > My first thought was to make the uAPI a set of KVM ioctls so that KVM could tightly
> > tightly control usage without taking on too much complexity in the kernel, but
> > working through things, routing the behavior through the shim itself might not be
> > all that horrific.
> >
> > IIRC, we discarded the idea of allowing userspace to map the "private" fd because
> > things got too complex, but with the shim it doesn't seem _that_ bad.
> >
> > E.g. on the memfd side:
> >
> >   1. The entire memfd must be mapped, and at most one mapping is allowed, i.e.
> >      mapping is all or nothing.
> >
> >   2. Acquiring a reference via get_pfn() is disallowed if there's a mapping for
> >      the restricted memfd.
> >
> >   3. Add notifier hooks to allow downstream users to further restrict things.
> >
> >   4. Disallow splitting VMAs, e.g. to force userspace to munmap() everything in
> >      one shot.
> >
> >   5. Require that there are no outstanding references at munmap().  Or if this
> >      can't be guaranteed by userspace, maybe add some way for userspace to wait
> >      until it's ok to convert to private?  E.g. so that get_pfn() doesn't need
> >      to do an expensive check every time.
> >
> >   static int memfd_restricted_mmap(struct file *file, struct vm_area_struct *vma)
> >   {
> >         if (vma->vm_pgoff)
> >                 return -EINVAL;
> >
> >         if ((vma->vm_end - vma->vm_start) != <file size>)
> >                 return -EINVAL;
> >
> >         mutex_lock(&data->lock);
> >
> >         if (data->has_mapping) {
> >                 r = -EINVAL;
> >                 goto err;
> >         }
> >         list_for_each_entry(notifier, &data->notifiers, list) {
> >                 r = notifier->ops->mmap_start(notifier, ...);
> >                 if (r)
> >                         goto abort;
> >         }
> >
> >         notifier->ops->mmap_end(notifier, ...);
> >         mutex_unlock(&data->lock);
> >         return 0;
> >
> >   abort:
> >         list_for_each_entry_continue_reverse(notifier &data->notifiers, list)
> >                 notifier->ops->mmap_abort(notifier, ...);
> >   err:
> >         mutex_unlock(&data->lock);
> >         return r;
> >   }
> >
> >   static void memfd_restricted_close(struct vm_area_struct *vma)
> >   {
> >         mutex_lock(...);
> >
> >         /*
> >          * Destroy the memfd and disable all future accesses if there are
> >          * outstanding refcounts (or other unsatisfied restrictions?).
> >          */
> >         if (<outstanding references> || ???)
> >                 memfd_restricted_destroy(...);
> >         else
> >                 data->has_mapping = false;
> >
> >         mutex_unlock(...);
> >   }
> >
> >   static int memfd_restricted_may_split(struct vm_area_struct *area, unsigned long addr)
> >   {
> >         return -EINVAL;
> >   }
> >
> >   static int memfd_restricted_mapping_mremap(struct vm_area_struct *new_vma)
> >   {
> >         return -EINVAL;
> >   }
> >
> > Then on the KVM side, its mmap_start() + mmap_end() sequence would:
> >
> >   1. Not be supported for TDX or SEV-SNP because they don't allow adding non-zero
> >      memory into the guest (after pre-boot phase).
> >
> >   2. Be mutually exclusive with shared<=>private conversions, and is allowed if
> >      and only if the entire gfn range of the associated memslot is shared.
> 
> In general I think that this would work with pKVM. However, limiting
> private<->shared conversions to the granularity of a whole memslot
> might be difficult to handle in pKVM, since the guest doesn't have the
> concept of memslots. For example, in pKVM right now, when a guest
> shares back its restricted DMA pool with the host it does so at the
> page-level. pKVM would also need a way to make an fd accessible again
> when shared back, which I think isn't possible with this patch.

But does pKVM really want to mmap/munmap a new region at the page-level,
that can cause VMA fragmentation if the conversion is frequent as I see.
Even with a KVM ioctl for mapping as mentioned below, I think there will
be the same issue.

> 
> You were initially considering a KVM ioctl for mapping, which might be
> better suited for this since KVM knows which pages are shared and
> which ones are private. So routing things through KVM might simplify
> things and allow it to enforce all the necessary restrictions (e.g.,
> private memory cannot be mapped). What do you think?
> 
> Thanks,
> /fuad
