Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4562B5FDB0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJMNjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJMNjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:39:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4EF101F;
        Thu, 13 Oct 2022 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665668379; x=1697204379;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=86+QJDT/SSLvPd1nKHl/DgfgqghBBXSGaVbxPPteq8A=;
  b=nl+paNQtnQOu1uCprL/xkNrA8BjDcpByz1xonw51nA/KjzshSlEe9Di1
   /+Y8PmWtAEh2xQv1n7uVv9fcvRqe4JmZXCMM6yBes6q7RrsWHNniyb+Ci
   fFdl2Q7gAzfF05H5f46TTwMfdwfuGykt7OUMd9dZctF8vb7hPl60JwFmY
   q0toRcWZOId0dJLneSrPsAcUd3to0EetFKGqyvm1qTUmqKICoRLNbcOsY
   l4tIZ4k3pe0GiiiVrQQJsNEbhmW89WRdv2cm/dNmJoxpDpswr8b+5W4sQ
   tg796pDXyoQXPR4ahia7lZqYOEh05wtngWRd8EC6hl/BAFGXaJ3dRP5EG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="302694560"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="302694560"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 06:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="690114910"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="690114910"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2022 06:39:29 -0700
Date:   Thu, 13 Oct 2022 21:34:57 +0800
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
Message-ID: <20221013133457.GA3263142@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
 <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
 <20220926142330.GC2658254@chaop.bj.intel.com>
 <CA+EHjTz5yGhsxUug+wqa9hrBO60Be0dzWeWzX00YtNxin2eYHg@mail.gmail.com>
 <YzN9gYn1uwHopthW@google.com>
 <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 05:19:00PM +0100, Fuad Tabba wrote:
> Hi,
> 
> On Tue, Sep 27, 2022 at 11:47 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Sep 26, 2022, Fuad Tabba wrote:
> > > Hi,
> > >
> > > On Mon, Sep 26, 2022 at 3:28 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > >
> > > > On Fri, Sep 23, 2022 at 04:19:46PM +0100, Fuad Tabba wrote:
> > > > > > Then on the KVM side, its mmap_start() + mmap_end() sequence would:
> > > > > >
> > > > > >   1. Not be supported for TDX or SEV-SNP because they don't allow adding non-zero
> > > > > >      memory into the guest (after pre-boot phase).
> > > > > >
> > > > > >   2. Be mutually exclusive with shared<=>private conversions, and is allowed if
> > > > > >      and only if the entire gfn range of the associated memslot is shared.
> > > > >
> > > > > In general I think that this would work with pKVM. However, limiting
> > > > > private<->shared conversions to the granularity of a whole memslot
> > > > > might be difficult to handle in pKVM, since the guest doesn't have the
> > > > > concept of memslots. For example, in pKVM right now, when a guest
> > > > > shares back its restricted DMA pool with the host it does so at the
> > > > > page-level.
> >
> > Y'all are killing me :-)
> 
>  :D
> 
> > Isn't the guest enlightened?  E.g. can't you tell the guest "thou shalt share at
> > granularity X"?  With KVM's newfangled scalable memslots and per-vCPU MRU slot,
> > X doesn't even have to be that high to get reasonable performance, e.g. assuming
> > the DMA pool is at most 2GiB, that's "only" 1024 memslots, which is supposed to
> > work just fine in KVM.
> 
> The guest is potentially enlightened, but the host doesn't necessarily
> know which memslot the guest might want to share back, since it
> doesn't know where the guest might want to place the DMA pool. If I
> understand this correctly, for this to work, all memslots would need
> to be the same size and sharing would always need to happen at that
> granularity.
> 
> Moreover, for something like a small DMA pool this might scale, but
> I'm not sure about potential future workloads (e.g., multimedia
> in-place sharing).
> 
> >
> > > > > pKVM would also need a way to make an fd accessible again
> > > > > when shared back, which I think isn't possible with this patch.
> > > >
> > > > But does pKVM really want to mmap/munmap a new region at the page-level,
> > > > that can cause VMA fragmentation if the conversion is frequent as I see.
> > > > Even with a KVM ioctl for mapping as mentioned below, I think there will
> > > > be the same issue.
> > >
> > > pKVM doesn't really need to unmap the memory. What is really important
> > > is that the memory is not GUP'able.
> >
> > Well, not entirely unguppable, just unguppable without a magic FOLL_* flag,
> > otherwise KVM wouldn't be able to get the PFN to map into guest memory.
> >
> > The problem is that gup() and "mapped" are tied together.  So yes, pKVM doesn't
> > strictly need to unmap memory _in the untrusted host_, but since mapped==guppable,
> > the end result is the same.
> >
> > Emphasis above because pKVM still needs unmap the memory _somehwere_.  IIUC, the
> > current approach is to do that only in the stage-2 page tables, i.e. only in the
> > context of the hypervisor.  Which is also the source of the gup() problems; the
> > untrusted kernel is blissfully unaware that the memory is inaccessible.
> >
> > Any approach that moves some of that information into the untrusted kernel so that
> > the kernel can protect itself will incur fragmentation in the VMAs.  Well, unless
> > all of guest memory becomes unguppable, but that's likely not a viable option.
> 
> Actually, for pKVM, there is no need for the guest memory to be
> GUP'able at all if we use the new inaccessible_get_pfn().

If pKVM can use inaccessible_get_pfn() to get pfn and can avoid GUP (I
think that is the major concern?), do you see any other gap from
existing API? 

> This of
> course goes back to what I'd mentioned before in v7; it seems that
> representing the memslot memory as a file descriptor should be
> orthogonal to whether the memory is shared or private, rather than a
> private_fd for private memory and the userspace_addr for shared
> memory. The host can then map or unmap the shared/private memory using
> the fd, which allows it more freedom in even choosing to unmap shared
> memory when not needed, for example.

Using both private_fd and userspace_addr is only needed in TDX and other
confidential computing scenarios, pKVM may only use private_fd if the fd
can also be mmaped as a whole to userspace as Sean suggested.

Thanks,
Chao
> 
> Cheers,
> /fuad
