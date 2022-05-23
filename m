Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13111531453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 18:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiEWNZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiEWNZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 09:25:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0803586F;
        Mon, 23 May 2022 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653312332; x=1684848332;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=EW9q/Cvw2jkobQ73y88ztoczGNs8Sdg5pZ9/RmN9nZs=;
  b=DshTQ/kTyQv0uT1tcBo4W3SOvUTPKJ7nLWQUgJB8Cicb2qDIwsmBgIV6
   Ku0yn3jN6TZ2oO7bwFCOwwWddj31eJJnaJAMfPARPV40P4ym4/fPupuDw
   J5qZT0tZu8L8XndvyhIN2z0/UC6iFKtxc8t2wnmIi+JTJ5SXry1QlP1Zt
   SDJVuodSeSIUpYocgwOhdtiNr8Ny88toa7NVUywN8mBuKqmClOOYUPmDk
   BymNq9i0BZ6iTE18/s3yw+rIb32kIR/Y5NSZ44omKJdzSdDrbQL+fEbwl
   O3MnP5r7JxqE3fLFFYchJSXGwigWO8RmE2HeDzSX1hQq+DbpD1SqXke08
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="272940238"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272940238"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 06:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="608195288"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga001.jf.intel.com with ESMTP; 23 May 2022 06:25:20 -0700
Date:   Mon, 23 May 2022 21:21:54 +0800
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
Message-ID: <20220523132154.GA947536@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <20220519153713.819591-5-chao.p.peng@linux.intel.com>
 <8840b360-cdb2-244c-bfb6-9a0e7306c188@kernel.org>
 <YofeZps9YXgtP3f1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YofeZps9YXgtP3f1@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 06:31:02PM +0000, Sean Christopherson wrote:
> On Fri, May 20, 2022, Andy Lutomirski wrote:
> > The alternative would be to have some kind of separate table or bitmap (part
> > of the memslot?) that tells KVM whether a GPA should map to the fd.
> > 
> > What do you all think?
> 
> My original proposal was to have expolicit shared vs. private memslots, and punch
> holes in KVM's memslots on conversion, but due to the way KVM (and userspace)
> handle memslot updates, conversions would be painfully slow.  That's how we ended
> up with the current propsoal.
> 
> But a dedicated KVM ioctl() to add/remove shared ranges would be easy to implement
> and wouldn't necessarily even need to interact with the memslots.  It could be a
> consumer of memslots, e.g. if we wanted to disallow registering regions without an
> associated memslot, but I think we'd want to avoid even that because things will
> get messy during memslot updates, e.g. if dirty logging is toggled or a shared
> memory region is temporarily removed then we wouldn't want to destroy the tracking.

Even we don't tight that to memslots, that info can only be effective
for private memslot, right? Setting this ioctl to memory ranges defined
in a traditional non-private memslots just makes no sense, I guess we can
comment that in the API document.

> 
> I don't think we'd want to use a bitmap, e.g. for a well-behaved guest, XArray
> should be far more efficient.

What about the mis-behaved guest? I don't want to design for the worst
case, but people may raise concern on the attack from such guest.

> 
> One benefit to explicitly tracking this in KVM is that it might be useful for
> software-only protected VMs, e.g. KVM could mark a region in the XArray as "pending"
> based on guest hypercalls to share/unshare memory, and then complete the transaction
> when userspace invokes the ioctl() to complete the share/unshare.

OK, then this can be another field of states/flags/attributes. Let me
dig up certain level of details:

First, introduce below KVM ioctl

KVM_SET_MEMORY_ATTR

struct kvm_memory_attr {
	__u64 addr;	/* page aligned */
	__u64 size;	/* page aligned */
#define KVM_MEMORY_ATTR_SHARED		(1 << 0)
#define KVM_MEMORY_ATTR_PRIVATE		(1 << 1)
	__u64 flags;
}

Second, check the KVM maintained guest memory attributes in page fault
handler (instead of checking memory existence in private fd)

Third, the memfile_notifier_ops (populate/invalidate) will be removed
from current code, the old mapping zapping can be directly handled in
this new KVM ioctl().
 
Thought?

Since this info is stored in KVM, which I think is reasonable. But for
other potential memfile_notifier users like VFIO, some KVM-to-VFIO APIs
might be needed depends on the implementaion.

It is also possible to maintain this info purely in userspace. The only
trick bit is implicit conversion support that has to be checked in KVM
page fault handler and is in the fast path.

Thanks,
Chao
