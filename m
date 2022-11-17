Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2120762DDD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 15:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiKQOVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 09:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiKQOVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:21:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6EC77225;
        Thu, 17 Nov 2022 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668694890; x=1700230890;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QAS2h8V2dfght1SJU/Na0JcJSN/AEZSVl08JRBsGjdI=;
  b=NNK2xzoKjwI6qrmzmGmeKxLrNmv1MfC5ADjD6m8RHOc5qInpX8GUo6Kc
   DGxFqUcjxrFSxNgjlG6pAFy+WDmFjandV5TQM4N6SsjF0ito1788+EDl+
   H5+XYRvEc5yS8+cPIzx8zzTd3zL73kJ1dSrkXXa/Zs6DUma1Ls4bUAUH8
   7OPnFgL4uM5NiL++90N5G2kik3Z8LhOB4Ee65e3421zTIjyEi7ViQHN+V
   qUmBIlieRBS0vf/6d1u/PWIq6fQo/FdDSlVTcNrbhFh8rjJeNTtnJJ1ZW
   0vusI+e60KUZESmSxqDOLI5XdLgX6B/nwtsIM49grAuhoJJhuZ8f1gd25
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="312874347"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="312874347"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 06:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634066426"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="634066426"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 06:21:17 -0800
Date:   Thu, 17 Nov 2022 22:16:53 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
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
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 0/8] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20221117141653.GE422408@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <87k03xbvkt.fsf@linaro.org>
 <20221116050022.GC364614@chaop.bj.intel.com>
 <87v8nf8bte.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v8nf8bte.fsf@linaro.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 09:40:23AM +0000, Alex Bennée wrote:
> 
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > On Mon, Nov 14, 2022 at 11:43:37AM +0000, Alex Bennée wrote:
> >> 
> >> Chao Peng <chao.p.peng@linux.intel.com> writes:
> >> 
> >> <snip>
> >> > Introduction
> >> > ============
> >> > KVM userspace being able to crash the host is horrible. Under current
> >> > KVM architecture, all guest memory is inherently accessible from KVM
> >> > userspace and is exposed to the mentioned crash issue. The goal of this
> >> > series is to provide a solution to align mm and KVM, on a userspace
> >> > inaccessible approach of exposing guest memory. 
> >> >
> >> > Normally, KVM populates secondary page table (e.g. EPT) by using a host
> >> > virtual address (hva) from core mm page table (e.g. x86 userspace page
> >> > table). This requires guest memory being mmaped into KVM userspace, but
> >> > this is also the source where the mentioned crash issue can happen. In
> >> > theory, apart from those 'shared' memory for device emulation etc, guest
> >> > memory doesn't have to be mmaped into KVM userspace.
> >> >
> >> > This series introduces fd-based guest memory which will not be mmaped
> >> > into KVM userspace. KVM populates secondary page table by using a
> >> > fd/offset pair backed by a memory file system. The fd can be created
> >> > from a supported memory filesystem like tmpfs/hugetlbfs and KVM can
> >> > directly interact with them with newly introduced in-kernel interface,
> >> > therefore remove the KVM userspace from the path of accessing/mmaping
> >> > the guest memory. 
> >> >
> >> > Kirill had a patch [2] to address the same issue in a different way. It
> >> > tracks guest encrypted memory at the 'struct page' level and relies on
> >> > HWPOISON to reject the userspace access. The patch has been discussed in
> >> > several online and offline threads and resulted in a design document [3]
> >> > which is also the original proposal for this series. Later this patch
> >> > series evolved as more comments received in community but the major
> >> > concepts in [3] still hold true so recommend reading.
> >> >
> >> > The patch series may also be useful for other usages, for example, pure
> >> > software approach may use it to harden itself against unintentional
> >> > access to guest memory. This series is designed with these usages in
> >> > mind but doesn't have code directly support them and extension might be
> >> > needed.
> >> 
> >> There are a couple of additional use cases where having a consistent
> >> memory interface with the kernel would be useful.
> >
> > Thanks very much for the info. But I'm not so confident that the current
> > memfd_restricted() implementation can be useful for all these usages. 
> >
> >> 
> >>   - Xen DomU guests providing other domains with VirtIO backends
> >> 
> >>   Xen by default doesn't give other domains special access to a domains
> >>   memory. The guest can grant access to regions of its memory to other
> >>   domains for this purpose. 
> >
> > I'm trying to form my understanding on how this could work and what's
> > the benefit for a DomU guest to provide memory through memfd_restricted().
> > AFAICS, memfd_restricted() can help to hide the memory from DomU userspace,
> > but I assume VirtIO backends are still in DomU uerspace and need access
> > that memory, right?
> 
> They need access to parts of the memory. At the moment you run your
> VirtIO domains in the Dom0 and give them access to the whole of a DomU's
> address space - however the Xen model is by default the guests memory is
> inaccessible to other domains on the system. The DomU guest uses the Xen
> grant model to expose portions of its address space to other domains -
> namely for the VirtIO queues themselves and any pages containing buffers
> involved in the VirtIO transaction. My thought was that looks like a
> guest memory interface which is mostly inaccessible (private) with some
> holes in it where memory is being explicitly shared with other domains.

Yes, similar in conception. For KVM, memfd_restricted() is used by host
OS, guest will issue conversion between private and shared for its
memory range. This is similar to Xen DomU guest grants its memory to
other domains. Similarly, I guess to make memfd_restricted() being really
useful for Xen, it should be run on the VirtIO backend domain (e.g.
equivalent to the host position for KVM).

> 
> What I want to achieve is a common userspace API with defined semantics
> for what happens when private and shared regions are accessed. Because
> having each hypervisor/confidential computing architecture define its
> own special API for accessing this memory is just a recipe for
> fragmentation and makes sharing common VirtIO backends impossible.

Yes, I agree. That's interesting to explore.

> 
> >
> >> 
> >>   - pKVM on ARM
> >> 
> >>   Similar to Xen, pKVM moves the management of the page tables into the
> >>   hypervisor and again doesn't allow those domains to share memory by
> >>   default.
> >
> > Right, we already had some discussions on this in the past versions.
> >
> >> 
> >>   - VirtIO loopback
> >> 
> >>   This allows for VirtIO devices for the host kernel to be serviced by
> >>   backends running in userspace. Obviously the memory userspace is
> >>   allowed to access is strictly limited to the buffers and queues
> >>   because giving userspace unrestricted access to the host kernel would
> >>   have consequences.
> >
> > Okay, but normal memfd_create() should work for it, right? And
> > memfd_restricted() instead may not work as it unmaps the memory from
> > userspace.
> >
> >> 
> >> All of these VirtIO backends work with vhost-user which uses memfds to
> >> pass references to guest memory from the VMM to the backend
> >> implementation.
> >
> > Sounds to me these are the places where normal memfd_create() can act on.
> > VirtIO backends work on the mmap-ed memory which currently is not the
> > case for memfd_restricted(). memfd_restricted() has different design
> > purpose that unmaps the memory from userspace and employs some kernel
> > callbacks so other kernel modules can make use of the memory with these
> > callbacks instead of userspace virtual address.
> 
> Maybe my understanding is backwards then. Are you saying a guest starts
> with all its memory exposed and then selectively unmaps the private
> regions? Is this driven by the VMM or the guest itself?

For confidential computing usages, normally guest starts with all guest
memory being private, e.g,  cannot be accessed by host. The memory will
be lived in memfd_restricted() memory and not exposed to host userspace
VMM like QEMU. Guest then can selectively map its private sub regions
(e.g. VirtIO queue in the guest VirtIO frontend driver) as shared so
host backend driver in QEMU can see it. When this happens, new shared
mapping will be established in KVM and the new memory will be provided
from normal mmap-able memory, then QEMU can do whatever it can do for
the device emulation.

Thanks,
Chao
> 
> -- 
> Alex Bennée
