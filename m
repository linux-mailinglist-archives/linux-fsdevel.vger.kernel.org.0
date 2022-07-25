Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3C57FF92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiGYNJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiGYNJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:09:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171ACB8;
        Mon, 25 Jul 2022 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658754559; x=1690290559;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=kbrDRU2puFG5f+Mqs3+ZqIenWq5YsbTsKEgDrLUQZtA=;
  b=aNsUOPFzTjNO7lI/MeIWk3ak5zYhME+Wfll1hPnMPzKR1YqSx9StnG4i
   YbFJq/erc/bM4bokdWeo0GDvnBFfCSCCGpxPtPz+Xcv5mmpkeFwUkuIl5
   lRF72qQljDGE21dMzdNvREu7YPQarq9vc8giR1YV+zzRyV+cOwSqfSQiz
   3IQdq/GKa5Q+IwNcpTNKgNiHd/0gl+/tK5HUAo3HoqaIqIWGJXKcl3Itu
   Vr617j8tb7RfwwLZRaM8HtKiyYrotdtmbl9IlLseOq8RXIQgVpsbyPTxg
   wt+SYH0I6i7S3RwHuKqRKNoC0WjAud0Zg4jEZrDzwwiHM+XBKTB7Om7Xc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="268085232"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="268085232"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 06:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="596668753"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2022 06:09:06 -0700
Date:   Mon, 25 Jul 2022 21:04:17 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wei Wang <wei.w.wang@linux.intel.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
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
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <20220725130417.GA304216@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <f02baa37-8d34-5d07-a0ae-300ffefc7fee@amd.com>
 <20220719140843.GA84779@chaop.bj.intel.com>
 <36e671d2-6b95-8e4f-c2ac-fee4b2670c6e@amd.com>
 <20220720150706.GB124133@chaop.bj.intel.com>
 <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
 <YtgrkXqP/GIi9ujZ@google.com>
 <45ae9f57-d595-f202-abb5-26a03a2ca131@linux.intel.com>
 <20220721092906.GA153288@chaop.bj.intel.com>
 <YtmT2irvgInX1kPp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtmT2irvgInX1kPp@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 05:58:50PM +0000, Sean Christopherson wrote:
> On Thu, Jul 21, 2022, Chao Peng wrote:
> > On Thu, Jul 21, 2022 at 03:34:59PM +0800, Wei Wang wrote:
> > > 
> > > 
> > > On 7/21/22 00:21, Sean Christopherson wrote:
> > > Maybe you could tag it with cgs for all the confidential guest support
> > > related stuff: e.g. kvm_vm_ioctl_set_cgs_mem()
> > > 
> > > bool is_private = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION;
> > > ...
> > > kvm_vm_ioctl_set_cgs_mem(, is_private)
> > 
> > If we plan to widely use such abbr. through KVM (e.g. it's well known),
> > I'm fine.
> 
> I'd prefer to stay away from "confidential guest", and away from any VM-scoped
> name for that matter.  User-unmappable memmory has use cases beyond hiding guest
> state from the host, e.g. userspace could use inaccessible/unmappable memory to
> harden itself against unintentional access to guest memory.
> 
> > I actually use mem_attr in patch: https://lkml.org/lkml/2022/7/20/610
> > But I also don't quite like it, it's so generic and sounds say nothing.
> > 
> > But I do want a name can cover future usages other than just 
> > private/shared (pKVM for example may have a third state).
> 
> I don't think there can be a third top-level state.  Memory is either private to
> the guest or it's not.  There can be sub-states, e.g. memory could be selectively
> shared or encrypted with a different key, in which case we'd need metadata to
> track that state.
> 
> Though that begs the question of whether or not private_fd is the correct
> terminology.  E.g. if guest memory is backed by a memfd that can't be mapped by
> userspace (currently F_SEAL_INACCESSIBLE), but something else in the kernel plugs
> that memory into a device or another VM, then arguably that memory is shared,
> especially the multi-VM scenario.
> 
> For TDX and SNP "private vs. shared" is likely the correct terminology given the
> current specs, but for generic KVM it's probably better to align with whatever
> terminology is used for memfd.  "inaccessible_fd" and "user_inaccessible_fd" are
> a bit odd since the fd itself is accesible.
> 
> What about "user_unmappable"?  E.g.
> 
>   F_SEAL_USER_UNMAPPABLE, MFD_USER_UNMAPPABLE, KVM_HAS_USER_UNMAPPABLE_MEMORY,
>   MEMFILE_F_USER_INACCESSIBLE, user_unmappable_fd, etc...

For KVM I also think user_unmappable looks better than 'private', e.g.
user_unmappable_fd/KVM_HAS_USER_UNMAPPABLE_MEMORY sounds more
appropriate names. For memfd however, I don't feel that strong to change
it from current 'inaccessible' to 'user_unmappable', one of the reason
is it's not just about unmappable, but actually also inaccessible
through direct ioctls like read()/write().

> 
> that gives us flexibility to map the memory from within the kernel, e.g. into
> other VMs or devices.
> 
> Hmm, and then keep your original "mem_attr_array" name?  And probably 
> 
>  int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
>  			       bool is_user_mappable)
> 
> Then the x86/mmu code for TDX/SNP private faults could be:
> 
> 	is_private = !kvm_is_gpa_user_mappable();
> 
> 	if (fault->is_private != is_private) {
> 
> or if we want to avoid mixing up "user_mappable" and "user_unmappable":
> 
> 	is_private = kvm_is_gpa_user_unmappable();
> 
> 	if (fault->is_private != is_private) {
> 
> though a helper that returns a negative (not mappable) feels kludgy.  And I like
> kvm_is_gpa_user_mappable() because then when there's not "special" memory, it
> defaults to true, which is more intuitive IMO.

yes.

> 
> And then if the future needs more precision, e.g. user-unmappable memory isn't
> necessarily guest-exclusive, the uAPI names still work even though KVM internals
> will need to be reworked, but that's unavoidable.  E.g. piggybacking
> KVM_MEMORY_ENCRYPT_(UN)REG_REGION doesn't allow for further differentiation,
> so we'd need to _extend_ the uAPI, but the _existing_ uAPI would still be sane.

Right, that has to be extended.

Chao
