Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0603F4F9783
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiDHOCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiDHOCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:02:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222C1066C6;
        Fri,  8 Apr 2022 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649426419; x=1680962419;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=vzRh1a2g1teZIO284W8xK+WsiWROyR/t9wQMFIz6/+E=;
  b=QOzLlZGujWLt30xDoiZCQjIiNQYcmUitOuwquovOequamxxufeQOC/6B
   llpW2A60Pt+Cs3AyhTQkT6D1FCRU+goYw+Lswu4IE/sYZNBBP9f4mIskM
   rkuXlbKr7mbzvAEOzyn2kigniaCFKnCse0/GobFsH4/e2HCDjaF5s8Kl8
   pxOmsOYizsZ6tgFu+QdipCBtGrR1K87xEUwyQy4CGNb/N/kJ0Q5REgjdL
   7cGKClkmvnmmoN31NunJdSwvW6xidjfCS+gBSiXOwoCsmTw1xvy6T2+wV
   PCQyU2vMvo9m7tMSzWs0FIOc6BmA9EZTtb2RH8BXs/OVNhniwerY6U7YR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286586632"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="286586632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698190261"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 06:59:52 -0700
Date:   Fri, 8 Apr 2022 21:59:41 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
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
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 07/13] KVM: Add KVM_EXIT_MEMORY_ERROR exit
Message-ID: <20220408135941.GF57095@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-8-chao.p.peng@linux.intel.com>
 <YkI3wa3rmWTOrpmw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkI3wa3rmWTOrpmw@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:33:37PM +0000, Sean Christopherson wrote:
> On Thu, Mar 10, 2022, Chao Peng wrote:
> > This new KVM exit allows userspace to handle memory-related errors. It
> > indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> > The flags includes additional information for userspace to handle the
> > error. Currently bit 0 is defined as 'private memory' where '1'
> > indicates error happens due to private memory access and '0' indicates
> > error happens due to shared memory access.
> > 
> > After private memory is enabled, this new exit will be used for KVM to
> > exit to userspace for shared memory <-> private memory conversion in
> > memory encryption usage.
> > 
> > In such usage, typically there are two kind of memory conversions:
> >   - explicit conversion: happens when guest explicitly calls into KVM to
> >     map a range (as private or shared), KVM then exits to userspace to
> >     do the map/unmap operations.
> >   - implicit conversion: happens in KVM page fault handler.
> >     * if the fault is due to a private memory access then causes a
> >       userspace exit for a shared->private conversion request when the
> >       page has not been allocated in the private memory backend.
> >     * If the fault is due to a shared memory access then causes a
> >       userspace exit for a private->shared conversion request when the
> >       page has already been allocated in the private memory backend.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 22 ++++++++++++++++++++++
> >  include/uapi/linux/kvm.h       |  9 +++++++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index f76ac598606c..bad550c2212b 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6216,6 +6216,28 @@ array field represents return values. The userspace should update the return
> >  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
> >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> >  
> > +::
> > +
> > +		/* KVM_EXIT_MEMORY_ERROR */
> > +		struct {
> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> > +			__u32 flags;
> > +			__u32 padding;
> > +			__u64 gpa;
> > +			__u64 size;
> > +		} memory;
> > +If exit reason is KVM_EXIT_MEMORY_ERROR then it indicates that the VCPU has
> 
> Doh, I'm pretty sure I suggested KVM_EXIT_MEMORY_ERROR.  Any objection to using
> KVM_EXIT_MEMORY_FAULT instead of KVM_EXIT_MEMORY_ERROR?  "ERROR" makes me think
> of ECC errors, i.e. uncorrected #MC in x86 land, not more generic "faults".  That
> would align nicely with -EFAULT.

Sure.

> 
> > +encountered a memory error which is not handled by KVM kernel module and
> > +userspace may choose to handle it. The 'flags' field indicates the memory
> > +properties of the exit.
