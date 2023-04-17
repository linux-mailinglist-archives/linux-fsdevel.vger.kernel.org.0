Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18F6E4BC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjDQOpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDQOpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:45:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502D59F6;
        Mon, 17 Apr 2023 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681742731; x=1713278731;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Ujpr3tfLBQ0cnHPJjNO9yDhomrzTInArxSoyy0XPMmc=;
  b=RFxYA9mb3N958xjqlZWK7p5vwflz9NWJmTk/zFuMm2UlLd13ZRXVQtFd
   z0vzigqicm867zaD9XAfsoT5bNIXsc9NBJlAUmq9l7/sBQd/xEuWaJ3xu
   gEvJez25ZKJnyv7zcXtZYyp8dM5Ng8SFdfoqn1RHBSRhRH/qs+U22tTsL
   D/VWLNTPchgJhQy4sSm59lHUmCrZpO0yN3W1ONGCUhy5Z1/dn/N6jGTuW
   xJcH82CCuioRZ/Y+pWEY+cFYzlxpP+PLppDJ9GyAcP/kbmz5zC9kX0yew
   /++/tudcI1yaSzLJHU5fKl3X/JkHFTVyaqSvMPVBQXkCdVob06uGDSFAs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="329079961"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="329079961"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 07:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780101935"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="780101935"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 07:45:16 -0700
Date:   Mon, 17 Apr 2023 22:37:47 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230417143747.GA3639898@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <20230119111308.GC2976263@ls.amr.corp.intel.com>
 <Y8lg1G2lRIrI/hld@google.com>
 <20230119223704.GD2976263@ls.amr.corp.intel.com>
 <Y880FiYF7YCtsw/i@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y880FiYF7YCtsw/i@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:27:50AM +0000, Sean Christopherson wrote:
> On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> > On Thu, Jan 19, 2023 at 03:25:08PM +0000,
> > Sean Christopherson <seanjc@google.com> wrote:
> > 
> > > On Thu, Jan 19, 2023, Isaku Yamahata wrote:
> > > > On Sat, Jan 14, 2023 at 12:37:59AM +0000,
> > > > Sean Christopherson <seanjc@google.com> wrote:
> > > > 
> > > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > > This patch series implements KVM guest private memory for confidential
> > > > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > > > TDX-protected guest memory, machine check can happen which can further
> > > > > > crash the running host system, this is terrible for multi-tenant
> > > > > > configurations. The host accesses include those from KVM userspace like
> > > > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > > > via a fd-based approach, but it can never access the guest memory
> > > > > > content.
> > > > > > 
> > > > > > The patch series touches both core mm and KVM code. I appreciate
> > > > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > > > reviews are always welcome.
> > > > > >   - 01: mm change, target for mm tree
> > > > > >   - 02-09: KVM change, target for KVM tree
> > > > > 
> > > > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > > > is available here:
> > > > > 
> > > > >   git@github.com:sean-jc/linux.git x86/upm_base_support
> > > > > 
> > > > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > > > a WIP.
> > > > > 
> > > > > As for next steps, can you (handwaving all of the TDX folks) take a look at what
> > > > > I pushed and see if there's anything horrifically broken, and that it still works
> > > > > for TDX?
> > > > > 
> > > > > Fuad (and pKVM folks) same ask for you with respect to pKVM.  Absolutely no rush
> > > > > (and I mean that).
> > > > > 
> > > > > On my side, the two things on my mind are (a) tests and (b) downstream dependencies
> > > > > (SEV and TDX).  For tests, I want to build a lists of tests that are required for
> > > > > merging so that the criteria for merging are clear, and so that if the list is large
> > > > > (haven't thought much yet), the work of writing and running tests can be distributed.
> > > > > 
> > > > > Regarding downstream dependencies, before this lands, I want to pull in all the
> > > > > TDX and SNP series and see how everything fits together.  Specifically, I want to
> > > > > make sure that we don't end up with a uAPI that necessitates ugly code, and that we
> > > > > don't miss an opportunity to make things simpler.  The patches in the SNP series to
> > > > > add "legacy" SEV support for UPM in particular made me slightly rethink some minor
> > > > > details.  Nothing remotely major, but something that needs attention since it'll
> > > > > be uAPI.
> > > > 
> > > > Although I'm still debuging with TDX KVM, I needed the following.
> > > > kvm_faultin_pfn() is called without mmu_lock held.  the race to change
> > > > private/shared is handled by mmu_seq.  Maybe dedicated function only for
> > > > kvm_faultin_pfn().
> > > 
> > > Gah, you're not on the other thread where this was discussed[*].  Simply deleting
> > > the lockdep assertion is safe, for guest types that rely on the attributes to
> > > define shared vs. private, KVM rechecks the attributes under the protection of
> > > mmu_seq.
> > > 
> > > I'll get a fixed version pushed out today.
> > > 
> > > [*] https://lore.kernel.org/all/Y8gpl+LwSuSgBFks@google.com
> > 
> > Now I have tdx kvm working. I've uploaded at the followings.
> > It's rebased to v6.2-rc3.
> >         git@github.com:yamahata/linux.git tdx/upm
> >         git@github.com:yamahata/qemu.git tdx/upm
> 
> And I finally got a working, building version updated and pushed out (again to):
> 
>   git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> Took longer than expected to get the memslot restrictions sussed out.  I'm done
> working on the code for now, my plan is to come back to it+TDX+SNP in 2-3 weeks
> to resolves any remaining todos (that no one else tackles) and to do the whole
> "merge the world" excersise.

Hi Sean,

In case you started working on the code again, I have a branch [1]
originally planned as v11 candidate which I believe I addressed all the
discussions we had for v10 except the very latest one [2] and integrated
all the newly added selftests from Ackerley and myself. The branch was
based on your original upm_base_support and then rebased to your
kvm-x86/mmu head. Feel free to take anything you think useful( most of
them are trivial things but also some fixes for bugs).

[1] https://github.com/chao-p/linux/commits/privmem-v11.6
[2] https://lore.kernel.org/all/20230413160405.h6ov2yl6l3i7mvsj@box.shutemov.name/

Chao
> 
> > kvm_mmu_do_page_fault() needs the following change.
> > kvm_mem_is_private() queries mem_attr_array.  kvm_faultin_pfn() also uses
> > kvm_mem_is_private(). So the shared-private check in kvm_faultin_pfn() doesn't
> > make sense. This change would belong to TDX KVM patches, though.
> 
> Yeah, SNP needs similar treatment.  Sorting that out is high up on the todo list.
