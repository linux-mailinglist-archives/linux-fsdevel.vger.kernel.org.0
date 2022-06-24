Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95565595E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiFXI6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFXI6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:58:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F3FFD8;
        Fri, 24 Jun 2022 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656061079; x=1687597079;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=yeQrZJrXMWBUMR9vCpqaTH5T9SUmL0CpG6XsQUx1ILY=;
  b=Ec7pN3E6z0BeCbX+jbsABfLzJGltvYgZtwkiCDCQtFVJ+uX+oCgoO5j/
   Js16RJORclzaMwYxsV7SKw54JGu8W0ek4lES7NGVUAyvWo5KvPja1nBUm
   xAVxnVDB1MeNJMPkazAkoPpeYfYoz7AHa6ZFmexdSbwmHtBOmC3qpAF3M
   sdKHbwL8dCHMK7ugmY6aqiYV3yZwgMl/UoCh/UwuUgfdw9oechtdjYU6G
   7lBrkBfFbLm+h/OV4AtmevdI8Oze8QPnKYj6IYpAvzJlcKq+BYsTDyK5J
   mFaL1Ej2RDsXOxk6WYZ5aNejg4ZnkdRAmE6Qmt1kUAAMIDndUg9ExuEKN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269688492"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="269688492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 01:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="586510529"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2022 01:57:46 -0700
Date:   Fri, 24 Jun 2022 16:54:26 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org,
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
        mhocko@suse.com, "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH v6 4/8] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20220624085426.GB2178308@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
 <20220623225949.kkdx6uwjlk2ec4iq@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623225949.kkdx6uwjlk2ec4iq@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:59:49PM -0500, Michael Roth wrote:
> On Fri, May 20, 2022 at 06:31:02PM +0000, Sean Christopherson wrote:
> > On Fri, May 20, 2022, Andy Lutomirski wrote:
> > > The alternative would be to have some kind of separate table or bitmap (part
> > > of the memslot?) that tells KVM whether a GPA should map to the fd.
> > > 
> > > What do you all think?
> > 
> > My original proposal was to have expolicit shared vs. private memslots, and punch
> > holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
> > handle memslot updates, conversions would be painfully slow.  That's how we ended
> > up with the current propsoal.
> > 
> > But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
> > and wouldn't necessarily even need to interact with the memslots.  It could be a
> > consumer of memslots, e.g. if we wanted to disallow registering regions without an
> > associated memslot, but I think we'd want to avoid even that because things will
> > get messy during memslot updates, e.g. if dirty logging is toggled or a shared
> > memory region is temporarily removed then we wouldn't want to destroy the tracking.
> > 
> > I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> > should be far more efficient.
> > 
> > One benefit to explicitly tracking this in KVM is that it might be useful for
> > software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
> > based on guest hypercalls to share/unshare memory, and then complete the transaction
> > when userspace invokes the ioctl() to complete the share/unshare.
> 
> Another upside to implementing a KVM ioctl is basically the reverse of the
> discussion around avoiding double-allocations: *supporting* double-allocations.
> 
> One thing I noticed while testing SNP+UPM support is a fairly dramatic
> slow-down with how it handles OVMF, which does some really nasty stuff
> with DMA where it takes 1 or 2 pages and flips them between
> shared/private on every transaction. Obviously that's not ideal and
> should be fixed directly at some point, but it's something that exists in the
> wild and might not be the only such instance where we need to deal with that
> sort of usage pattern. 
> 
> With the current implementation, one option I had to address this was to
> disable hole-punching in QEMU when doing shared->private conversions:
> 
> Boot time from 1GB guest:
>                                SNP:   32s
>                            SNP+UPM: 1m43s
>   SNP+UPM (disable shared discard): 1m08s
> 
> Of course, we don't have the option of disabling discard/hole-punching
> for private memory to see if we get similar gains there, since that also
> doubles as the interface for doing private->shared conversions.

Private should be the same, minus time consumed for private memory, the
data should be close to SNP case. You can't try that in current version
due to we rely on the existence of the private page to tell a page is
private.

> A separate
> KVM ioctl to decouple these 2 things would allow for that, and allow for a
> way for userspace to implement things like batched/lazy-discard of
> previously-converted pages to deal with cases like these.

The planned ioctl includes two responsibilities:
  - Mark the range as private/shared
  - Zap the existing SLPT mapping for the range

Whether doing the hole-punching or not on the fd is unrelated to this
ioctl, userspace has freedom to do that or not. Since we don't reply on
the fact that private memoy should have been allocated, we can support
lazy faulting and don't need explicit fallocate(). That means, whether
the memory is discarded or not in the memory backing store is not
required by KVM, but be a userspace option.

> 
> Another motivator for these separate ioctl is that, since we're considering
> 'out-of-band' interactions with private memfd where userspace might
> erroneously/inadvertently do things like double allocations, another thing it
> might do is pre-allocating pages in the private memfd prior to associating
> the memfd with a private memslot. Since the notifiers aren't registered until
> that point, any associated callbacks that would normally need to be done as
> part of those fallocate() notification would be missed unless we do something
> like 'replay' all the notifications once the private memslot is registered and
> associating with a memfile notifier. But that seems a bit ugly, and I'm not
> sure how well that would work. This also seems to hint at this additional
> 'conversion' state being something that should be owned and managed directly
> by KVM rather than hooking into the allocations.

Right, once we move the private/shared state into KVM then we don't rely
on those callbacks so the 'replay' thing is unneeded. fallocate()
notification is useless for sure, invalidate() is likely still needed,
just like the invalidate for mmu_notifier to bump the mmu_seq and do the
zap.

> 
> It would also nicely solve the question of how to handle in-place
> encryption, since unlike userspace, KVM is perfectly capable of copying
> data from shared->private prior to conversion / guest start, and
> disallowing such things afterward. Would just need an extra flag basically.

Agree it's possible to do additional copy during the conversion but I'm
not so confident this is urgent and the right API. Currently TDX does
not have this need. Maybe as the first step just add the conversion
itself. Adding additional feature like this can always be possible
whenever we are clear.

Thanks,
Chao
