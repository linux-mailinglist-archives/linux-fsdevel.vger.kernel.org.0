Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7D551F6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiFTOzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbiFTOzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:55:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F35714F;
        Mon, 20 Jun 2022 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655734403; x=1687270403;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Bp9Mlz7Na3xaUAMgzpqbQL8va7PMos3P8wYwM1/XQFY=;
  b=eF153AK9kS14i+4Zu84vlJjtYyqS2ARd/dKgo7tiDVySWaEvORe9ZBcq
   Rw/6CFmwc28vneuwtbBml2YbYlBvUP4xUlMjrmjWozLdX2/4Cfe+1ZrUZ
   arrEmtiBhu5KDrpd3twuDbF267y+nK8uUWYZocBpP3/g6Vtet31PwrALc
   uGPLSF9N67JVEgYaWu7l6GGMqnBn08juNMMb+5CY8ic45MrsugoIfqCnd
   ZoOSpjVnwUYCQjtUxB5C/ZcGW3/KOp0H7g6hdnU8e5/G7dck0Iv7dDjzz
   U+V0wtDMpz4JgvhKhyi9ZbFDS0iuuSLJ530EiyZbbHtibcAb3xGOeO9iy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278677891"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278677891"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 07:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584912288"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 07:13:02 -0700
Date:   Mon, 20 Jun 2022 22:09:41 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220620140941.GB2016793@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <Yqzpf3AEYabFWjnW@google.com>
 <YqzxvYU7EtHab6U7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqzxvYU7EtHab6U7@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:27:25PM +0000, Sean Christopherson wrote:
> On Fri, Jun 17, 2022, Sean Christopherson wrote:
> > > @@ -110,6 +133,7 @@ struct kvm_userspace_memory_region {
> > >   */
> > >  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
> > >  #define KVM_MEM_READONLY	(1UL << 1)
> > > +#define KVM_MEM_PRIVATE		(1UL << 2)
> > 
> > Hmm, KVM_MEM_PRIVATE is technically wrong now that a "private" memslot maps private
> > and/or shared memory.  Strictly speaking, we don't actually need a new flag.  Valid
> > file descriptors must be >=0, so the logic for specifying a memslot that can be
> > converted between private and shared could be that "(int)private_fd < 0" means
> > "not convertible", i.e. derive the flag from private_fd.
> > 
> > And looking at the two KVM consumers of the flag, via kvm_slot_is_private(), they're
> > both wrong.  Both kvm_faultin_pfn() and kvm_mmu_max_mapping_level() should operate
> > on the _fault_, not the slot.  So it would actually be a positive to not have an easy
> > way to query if a slot supports conversion.
> 
> I take that back, the usage in kvm_faultin_pfn() is correct, but the names ends
> up being confusing because it suggests that it always faults in a private pfn.

Make sense, will change the naming, thanks.

> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b6d75016e48c..e1008f00609d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4045,7 +4045,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>                         return RET_PF_EMULATE;
>         }
> 
> -       if (fault->is_private) {
> +       if (kvm_slot_can_be_private(slot)) {
>                 r = kvm_faultin_pfn_private(vcpu, fault);
>                 if (r != RET_PF_CONTINUE)
>                         return r == RET_PF_FIXED ? RET_PF_CONTINUE : r;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 31f704c83099..c5126190fb71 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -583,9 +583,9 @@ struct kvm_memory_slot {
>         struct kvm *kvm;
>  };
> 
> -static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> +static inline bool kvm_slot_can_be_private(const struct kvm_memory_slot *slot)
>  {
> -       return slot && (slot->flags & KVM_MEM_PRIVATE);
> +       return slot && !!slot->private_file;
>  }
> 
>  static inline bool kvm_slot_dirty_track_enabled(const struct kvm_memory_slot *slot)
