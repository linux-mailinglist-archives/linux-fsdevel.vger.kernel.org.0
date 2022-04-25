Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274B50E236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbiDYNrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 09:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbiDYNrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:47:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA174969E;
        Mon, 25 Apr 2022 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650894268; x=1682430268;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=11l8nWOAh8jVYp4pTM08c8ajsmoXROtLceTxJ8NiSMU=;
  b=JR8Ute/GJoN07izCCk5Zc7OxBCMey/J59svcRudy72t4VzM309/Aw6PH
   b/ZHjjIihKYyKpfM8+XOo1aiwT9+JD5evTwPYtHVbZpOMMUspu7dfP2Qz
   xHJ59bXkoWawJr77n/TAShrgT6z7DsIyDd0KRJeHGQD4YTHq79TEuEZWL
   cihD4uIu1nnZ2+tI0H3LJvH6botetkQ42mxukQY4FaloFsWV+E0wT32+3
   ZTGCGEmIk5hWwJIyqlTZEKzlC6M9ZaiiqAlW8gyBHs+2QuuOAjvlFDSQc
   5KWCAW+vAOHaTFNEpOTv9vwOpPmMR4efSl4tnzFzA+Z1BGA5psG2o5g/q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="325738297"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="325738297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704562650"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 06:44:19 -0700
Date:   Mon, 25 Apr 2022 21:40:51 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220425134051.GA175928@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <80aad2f9-9612-4e87-a27a-755d3fa97c92@www.fastmail.com>
 <YkcTTY4YjQs5BRhE@google.com>
 <83fd55f8-cd42-4588-9bf6-199cbce70f33@www.fastmail.com>
 <YksIQYdG41v3KWkr@google.com>
 <Ykslo2eo2eRXrpFR@google.com>
 <eefc3c74-acca-419c-8947-726ce2458446@www.fastmail.com>
 <Ykwbqv90C7+8K+Ao@google.com>
 <YkyEaYiL0BrDYcZv@google.com>
 <20220422105612.GB61987@chaop.bj.intel.com>
 <3b99f157-0f30-4b30-8399-dd659250ab8d@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b99f157-0f30-4b30-8399-dd659250ab8d@www.fastmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 09:59:37AM -0700, Andy Lutomirski wrote:
> 
> 
> On Fri, Apr 22, 2022, at 3:56 AM, Chao Peng wrote:
> > On Tue, Apr 05, 2022 at 06:03:21PM +0000, Sean Christopherson wrote:
> >> On Tue, Apr 05, 2022, Quentin Perret wrote:
> >> > On Monday 04 Apr 2022 at 15:04:17 (-0700), Andy Lutomirski wrote:
> >     Only when the register succeeds, the fd is
> >     converted into a private fd, before that, the fd is just a normal (shared)
> >     one. During this conversion, the previous data is preserved so you can put
> >     some initial data in guest pages (whether the architecture allows this is
> >     architecture-specific and out of the scope of this patch).
> 
> I think this can be made to work, but it will be awkward.  On TDX, for example, what exactly are the semantics supposed to be?  An error code if the memory isn't all zero?  An error code if it has ever been written?
> 
> Fundamentally, I think this is because your proposed lifecycle for these memfiles results in a lightweight API but is awkward for the intended use cases.  You're proposing, roughly:
> 
> 1. Create a memfile. 
> 
> Now it's in a shared state with an unknown virt technology.  It can be read and written.  Let's call this state BRAND_NEW.
> 
> 2. Bind to a VM.
> 
> Now it's an a bound state.  For TDX, for example, let's call the new state BOUND_TDX.  In this state, the TDX rules are followed (private memory can't be converted, etc).
> 
> The problem here is that the BOUND_NEW state allows things that are nonsensical in TDX, and the binding step needs to invent some kind of semantics for what happens when binding a nonempty memfile.
> 
> 
> So I would propose a somewhat different order:
> 
> 1. Create a memfile.  It's in the UNBOUND state and no operations whatsoever are allowed except binding or closing.

OK, so we need invent new user API to indicate UNBOUND state. For memfd
based, it can be a new feature-neutral flag at creation time.

> 
> 2. Bind the memfile to a VM (or at least to a VM technology).  Now it's in the initial state appropriate for that VM.
> 
> For TDX, this completely bypasses the cases where the data is prepopulated and TDX can't handle it cleanly.  For SEV, it bypasses a situation in which data might be written to the memory before we find out whether that data will be unreclaimable or unmovable.

This sounds a more strict rule to avoid semantics unclear.

So userspace needs to know what excatly happens for a 'bind' operation.
This is different when binds to different technologies. E.g. for SEV, it
may imply after this call, the memfile can be accessed (through mmap or
what ever) from userspace, while for current TDX this should be not allowed.

And I feel we still need a third flow/operation to indicate the
completion of the initialization on the memfile before the guest's 
first-time launch. SEV needs to check previous mmap-ed areas are munmap-ed
and prevent future userspace access. After this point, then the memfile
becomes truely private fd.

> 
> 
> ----------------------------------------------
> 
> Now I have a question, since I don't think anyone has really answered it: how does this all work with SEV- or pKVM-like technologies in which private and shared pages share the same address space?  I sounds like you're proposing to have a big memfile that contains private and shared pages and to use that same memfile as pages are converted back and forth.  IO and even real physical DMA could be done on that memfile.  Am I understanding correctly?

For TDX case, and probably SEV as well, this memfile contains private memory
only. But this design at least makes it possible for usage cases like
pKVM which wants both private/shared memory in the same memfile and rely
on other ways like mmap/munmap or mprotect to toggle private/shared instead
of fallocate/hole punching.

> 
> If so, I think this makes sense, but I'm wondering if the actual memslot setup should be different.  For TDX, private memory lives in a logically separate memslot space.  For SEV and pKVM, it doesn't.  I assume the API can reflect this straightforwardly.

I believe so. The flow should be similar but we do need pass different
flags during the 'bind' to the backing store for different usages. That
should be some new flags for pKVM but the callbacks (API here) between
memfile_notifile and its consumers can be reused.

> 
> And the corresponding TDX question: is the intent still that shared pages aren't allowed at all in a TDX memfile?  If so, that would be the most direct mapping to what the hardware actually does.

Exactly. TDX will still use fallocate/hole punching to turn on/off the
private page. Once off, the traditional shared page will become
effective in KVM.

Chao
> 
> --Andy
