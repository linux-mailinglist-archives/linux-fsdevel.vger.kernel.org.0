Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00600537DA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiE3Njy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiE3NgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 09:36:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74894985AF;
        Mon, 30 May 2022 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653917391; x=1685453391;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=I21a6ClKGB+lq1NfhYRQ0tz6+Os23OEzwGczNY+MKwY=;
  b=HpvNlcVINhWSmF2Khe79cHcXMHlqq8MD2pq5h//KORGzneoTvxjrwGOC
   lUFqvSjakeEsFY4cAqT5ep1vHYaIhzrACuH9QR96Wdzi74dG2pH9neXJJ
   1EPbdyEkxENjnVyAtmRK1ruUw1XeLGarOY1IgXCkVoEYe6HgjbKQ+JRPU
   HxL/PtL7Kb8/ckE1FPkj7mmMHx5BUNKbGGYAfrPI1wjQRDKvGxs2DStk2
   niuShl40ewrDrlfLvWcZMus1mGjAgSmYHUAlA+3IIhnFcklnQEyH17o2f
   ZAc2tldND5vrR2yrGUFOwiHujWmUsLDqS6GT4Jrjc+JyP0GmKqQmEWixg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="273813992"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="273813992"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 06:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="529175229"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2022 06:29:39 -0700
Date:   Mon, 30 May 2022 21:26:13 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220530132613.GA1200843@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
 <20220523132154.GA947536@chaop.bj.intel.com>
 <YoumuHUmgM6TH20S@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoumuHUmgM6TH20S@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 03:22:32PM +0000, Sean Christopherson wrote:
> On Mon, May 23, 2022, Chao Peng wrote:
> > On Fri, May 20, 2022 at 06:31:02PM +0000, Sean Christopherson wrote:
> > > On Fri, May 20, 2022, Andy Lutomirski wrote:
> > > > The alternative would be to have some kind of separate table or bitmap (part
> > > > of the memslot?) that tells KVM whether a GPA should map to the fd.
> > > > 
> > > > What do you all think?
> > > 
> > > My original proposal was to have expolicit shared vs. private memslots, and punch
> > > holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
> > > handle memslot updates, conversions would be painfully slow.  That's how we ended
> > > up with the current propsoal.
> > > 
> > > But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
> > > and wouldn't necessarily even need to interact with the memslots.  It could be a
> > > consumer of memslots, e.g. if we wanted to disallow registering regions without an
> > > associated memslot, but I think we'd want to avoid even that because things will
> > > get messy during memslot updates, e.g. if dirty logging is toggled or a shared
> > > memory region is temporarily removed then we wouldn't want to destroy the tracking.
> > 
> > Even we don't tight that to memslots, that info can only be effective
> > for private memslot, right? Setting this ioctl to memory ranges defined
> > in a traditional non-private memslots just makes no sense, I guess we can
> > comment that in the API document.
> 
> Hrm, applying it universally would be funky, e.g. emulated MMIO would need to be
> declared "shared".  But, applying it selectively would arguably be worse, e.g.
> letting userspace map memory into the guest as shared for a region that's registered
> as private...
> 
> On option to that mess would be to make memory shared by default, and so userspace
> must declare regions that are private.  Then there's no weirdness with emulated MMIO
> or "legacy" memslots.
> 
> On page fault, KVM does a lookup to see if the GPA is shared or private.  If the
> GPA is private, but there is no memslot or the memslot doesn't have a private fd,
> KVM exits to userspace.  If there's a memslot with a private fd, the shared/private
> flag is used to resolve the 
> 
> And to handle the ioctl(), KVM can use kvm_zap_gfn_range(), which will bump the
> notifier sequence, i.e. force the page fault to retry if the GPA may have been
> (un)registered between checking the type and acquiring mmu_lock.

Yeah, that makes sense.

> 
> > > I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> > > should be far more efficient.
> > 
> > What about the mis-behaved guest? I don't want to design for the worst
> > case, but people may raise concern on the attack from such guest.
> 
> That's why cgroups exist.  E.g. a malicious/broken L1 can similarly abuse nested
> EPT/NPT to generate a large number of shadow page tables.

I havn't seen we had that in KVM. Is there any plan/discussion to add that?

> 
> > > One benefit to explicitly tracking this in KVM is that it might be useful for
> > > software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
> > > based on guest hypercalls to share/unshare memory, and then complete the transaction
> > > when userspace invokes the ioctl() to complete the share/unshare.
> > 
> > OK, then this can be another field of states/flags/attributes. Let me
> > dig up certain level of details:
> > 
> > First, introduce below KVM ioctl
> > 
> > KVM_SET_MEMORY_ATTR
> 
> Actually, if the semantics are that userspace declares memory as private, then we
> can reuse KVM_MEMORY_ENCRYPT_REG_REGION and KVM_MEMORY_ENCRYPT_UNREG_REGION.  It'd
> be a little gross because we'd need to slightly redefine the semantics for TDX, SNP,
> and software-protected VM types, e.g. the ioctls() currently require a pre-exisitng
> memslot.  But I think it'd work...

These existing ioctls looks good for TDX and probably SNP as well. For
softrware-protected VM types, it may not be enough. Maybe for the first
step we can reuse this for all hardware based solutions and invent new
interface when software-protected solution gets really supported.

There is semantics difference for fd-based private memory. Current above
two ioctls() use userspace addreess(hva) while for fd-based it should be
fd+offset, and probably it's better to use gpa in this case. Then we
will need change existing semantics and break backward-compatibility.

Chao

> 
> I'll think more on this...
