Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA5754AAAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354610AbiFNHbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354512AbiFNHbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:31:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585273E5D7;
        Tue, 14 Jun 2022 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655191893; x=1686727893;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=BwfIVHuEaK8z+QZZOZqmlU4SXCS0pKVU8k7FqNhuJ+Y=;
  b=nPDtOROeeJYCkJ9Gto/aTf7q28luIOhBq7Q4CrikfFK/Gn34lmPmYcuS
   er00auX4GEcl0W5+k2+1YdQkgK+7qKi08yUskedjoM6L8U1vp+NT1nh1b
   9oKWF8eZbuIAmEYFRu4O/aJ1/vI+T0KREddvV6B3mhxTX4w00A0reTcPx
   RL5IrTGErBFWfv45Ftv9w8i2oKJIy7yxZ8y1IgsGx4g6qtf7TsaH2Ae+F
   kqU0BhxzqWnglMSXz8HGMUqvDE9I5fRIm63x6PTGb80lztLdJ7N3cUSam
   8/xzXqWh0AOu8uJjlsoaKD08UodYQQVIhcAxCoFzXJcVNxyd6dGOPgBUk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258370173"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258370173"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="582581789"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2022 00:31:23 -0700
Date:   Tue, 14 Jun 2022 15:28:00 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vishal Annapurve <vannapurve@google.com>,
        Marc Orr <marcorr@google.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
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
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220614072800.GB1783435@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
 <20220607065749.GA1513445@chaop.bj.intel.com>
 <CAA03e5H_vOQS-qdZgacnmqP5T5jJLnEfm44yfRzJQ2KVu0Br+Q@mail.gmail.com>
 <20220608021820.GA1548172@chaop.bj.intel.com>
 <CAGtprH8xyf07jMN7ubTC__BvDj+z41uVGRiCJ7Rc5cv3KWg03w@mail.gmail.com>
 <YqJYEheLiGI4KqXF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqJYEheLiGI4KqXF@google.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:29:06PM +0000, Sean Christopherson wrote:
> On Wed, Jun 08, 2022, Vishal Annapurve wrote:
> > ...
> > > With this patch series, it's actually even not possible for userspace VMM
> > > to allocate private page by a direct write, it's basically unmapped from
> > > there. If it really wants to, it should so something special, by intention,
> > > that's basically the conversion, which we should allow.
> > >
> > 
> > A VM can pass GPA backed by private pages to userspace VMM and when
> > Userspace VMM accesses the backing hva there will be pages allocated
> > to back the shared fd causing 2 sets of pages backing the same guest
> > memory range.
> > 
> > > Thanks for bringing this up. But in my mind I still think userspace VMM
> > > can do and it's its responsibility to guarantee that, if that is hard
> > > required.
> 
> That was my initial reaction too, but there are unfortunate side effects to punting
> this to userspace. 
> 
> > By design, userspace VMM is the decision-maker for page
> > > conversion and has all the necessary information to know which page is
> > > shared/private. It also has the necessary knobs to allocate/free the
> > > physical pages for guest memory. Definitely, we should make userspace
> > > VMM more robust.
> > 
> > Making Userspace VMM more robust to avoid double allocation can get
> > complex, it will have to keep track of all in-use (by Userspace VMM)
> > shared fd memory to disallow conversion from shared to private and
> > will have to ensure that all guest supplied addresses belong to shared
> > GPA ranges.
> 
> IMO, the complexity argument isn't sufficient justfication for introducing new
> kernel functionality.  If multiple processes are accessing guest memory then there
> already needs to be some amount of coordination, i.e. it can't be _that_ complex.
> 
> My concern with forcing userspace to fully handle unmapping shared memory is that
> it may lead to additional performance overhead and/or noisy neighbor issues, even
> if all guests are well-behaved.
> 
> Unnmapping arbitrary ranges will fragment the virtual address space and consume
> more memory for all the result VMAs.  The extra memory consumption isn't that big
> of a deal, and it will be self-healing to some extent as VMAs will get merged when
> the holes are filled back in (if the guest converts back to shared), but it's still
> less than desirable.
> 
> More concerning is having to take mmap_lock for write for every conversion, which
> is very problematic for configurations where a single userspace process maps memory
> belong to multiple VMs.  Unmapping and remapping on every conversion will create a
> bottleneck, especially if a VM has sub-optimal behavior and is converting pages at
> a high rate.
> 
> One argument is that userspace can simply rely on cgroups to detect misbehaving
> guests, but (a) those types of OOMs will be a nightmare to debug and (b) an OOM
> kill from the host is typically considered a _host_ issue and will be treated as
> a missed SLO.
> 
> An idea for handling this in the kernel without too much complexity would be to
> add F_SEAL_FAULT_ALLOCATIONS (terrible name) that would prevent page faults from
> allocating pages, i.e. holes can only be filled by an explicit fallocate().  Minor
> faults, e.g. due to NUMA balancing stupidity, and major faults due to swap would
> still work, but writes to previously unreserved/unallocated memory would get a
> SIGSEGV on something it has mapped.  That would allow the userspace VMM to prevent
> unintentional allocations without having to coordinate unmapping/remapping across
> multiple processes.

Since this is mainly for shared memory and the motivation is catching
misbehaved access, can we use mprotect(PROT_NONE) for this? We can mark
those range backed by private fd as PROT_NONE during the conversion so
subsequence misbehaved accesses will be blocked instead of causing double
allocation silently.

Chao
