Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8160762DD2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 14:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiKQNt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 08:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiKQNt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:49:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791165FE;
        Thu, 17 Nov 2022 05:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668692995; x=1700228995;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ATWbZUoO3rElYdzopyRvM0E2TkDOWFkdmG1eTQn7t9g=;
  b=iSJAODUdL6giDMpE8v9HIwofGhhKp+jykFDgl5iXGWU2VN4BF5WGsczl
   mgArMalz6zkD0xwmP5TLohylWosLgBD8mF/k8A3TRwMZuC3aY9rc7ITSn
   CFYVky8D8B9oeYAgx9ZrOXdJkVdpg3XXZ7Jt9N4RsjZ42VUZjsV+mSVfZ
   M7x6uIZbO9mNKFuhEOJaR4VA4bie1ReUHwus/ojVgqUOSsVLRFxBXIj1v
   UL1uUw7JOTDgqypPSxNwegs4SZaNBIx8OcnYKWn0id1DG9mWI3Ym3giAO
   CP84yzrV13FsSit34d4JYU2fJfRFES5WrX62+qQeVWxqEKY0MgauF47Ho
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="293247160"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="293247160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="670927648"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="670927648"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2022 05:49:44 -0800
Date:   Thu, 17 Nov 2022 21:45:20 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <20221117134520.GD422408@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <87cz9o9mr8.fsf@linaro.org>
 <20221116031441.GA364614@chaop.bj.intel.com>
 <87mt8q90rw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mt8q90rw.fsf@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 07:03:49PM +0000, Alex Bennée wrote:
> 
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > On Tue, Nov 15, 2022 at 04:56:12PM +0000, Alex Bennée wrote:
> >> 
> >> Chao Peng <chao.p.peng@linux.intel.com> writes:
> >> 
> >> > This new KVM exit allows userspace to handle memory-related errors. It
> >> > indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> >> > The flags includes additional information for userspace to handle the
> >> > error. Currently bit 0 is defined as 'private memory' where '1'
> >> > indicates error happens due to private memory access and '0' indicates
> >> > error happens due to shared memory access.
> >> >
> >> > When private memory is enabled, this new exit will be used for KVM to
> >> > exit to userspace for shared <-> private memory conversion in memory
> >> > encryption usage. In such usage, typically there are two kind of memory
> >> > conversions:
> >> >   - explicit conversion: happens when guest explicitly calls into KVM
> >> >     to map a range (as private or shared), KVM then exits to userspace
> >> >     to perform the map/unmap operations.
> >> >   - implicit conversion: happens in KVM page fault handler where KVM
> >> >     exits to userspace for an implicit conversion when the page is in a
> >> >     different state than requested (private or shared).
> >> >
> >> > Suggested-by: Sean Christopherson <seanjc@google.com>
> >> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> >> > ---
> >> >  Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
> >> >  include/uapi/linux/kvm.h       |  9 +++++++++
> >> >  2 files changed, 32 insertions(+)
> >> >
> >> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> >> > index f3fa75649a78..975688912b8c 100644
> >> > --- a/Documentation/virt/kvm/api.rst
> >> > +++ b/Documentation/virt/kvm/api.rst
> >> > @@ -6537,6 +6537,29 @@ array field represents return values. The userspace should update the return
> >> >  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
> >> >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> >> >  
> >> > +::
> >> > +
> >> > +		/* KVM_EXIT_MEMORY_FAULT */
> >> > +		struct {
> >> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> >> > +			__u32 flags;
> >> > +			__u32 padding;
> >> > +			__u64 gpa;
> >> > +			__u64 size;
> >> > +		} memory;
> >> > +
> >> > +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
> >> > +encountered a memory error which is not handled by KVM kernel module and
> >> > +userspace may choose to handle it. The 'flags' field indicates the memory
> >> > +properties of the exit.
> >> > +
> >> > + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> >> > +   private memory access when the bit is set. Otherwise the memory error is
> >> > +   caused by shared memory access when the bit is clear.
> >> 
> >> What does a shared memory access failure entail?
> >
> > In the context of confidential computing usages, guest can issue a
> > shared memory access while the memory is actually private from the host
> > point of view. This exit with bit 0 cleared gives userspace a chance to
> > convert the private memory to shared memory on host.
> 
> I think this should be explicit rather than implied by the absence of
> another flag. Sean suggested you might want flags for RWX failures so
> maybe something like:
> 
> 	KVM_MEMORY_EXIT_SHARED_FLAG_READ	(1 << 0)
> 	KVM_MEMORY_EXIT_SHARED_FLAG_WRITE	(1 << 1)
> 	KVM_MEMORY_EXIT_SHARED_FLAG_EXECUTE	(1 << 2)
>         KVM_MEMORY_EXIT_FLAG_PRIVATE            (1 << 3)

Yes, but I would not add 'SHARED' to RWX, they are not share memory
specific, private memory can also set them once introduced.

Thanks,
Chao
> 
> which would allow you to signal the various failure modes of the shared
> region, or that you had accessed private memory.
> 
> >
> >> 
> >> If you envision any other failure modes it might be worth making it
> >> explicit with additional flags.
> >
> > Sean mentioned some more usages[1][]2] other than the memory conversion
> > for confidential usage. But I would leave those flags being added in the
> > future after those usages being well discussed.
> >
> > [1] https://lkml.kernel.org/r/20200617230052.GB27751@linux.intel.com
> > [2] https://lore.kernel.org/all/YKxJLcg%2FWomPE422@google.com
> >
> >> I also wonder if a bitmask makes sense if
> >> there can only be one reason for a failure? Maybe all that is needed is
> >> a reason enum?
> >
> > Tough we only have one reason right now but we still want to leave room
> > for future extension. Enum can express a single value at once well but
> > bitmask makes it possible to express multiple orthogonal flags.
> 
> I agree if multiple orthogonal failures can occur at once a bitmask is
> the right choice.
> 
> >
> > Chao
> >> 
> >> > +
> >> > +'gpa' and 'size' indicate the memory range the error occurs at. The userspace
> >> > +may handle the error and return to KVM to retry the previous memory access.
> >> > +
> >> >  ::
> >> >  
> >> >      /* KVM_EXIT_NOTIFY */
> >> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> > index f1ae45c10c94..fa60b032a405 100644
> >> > --- a/include/uapi/linux/kvm.h
> >> > +++ b/include/uapi/linux/kvm.h
> >> > @@ -300,6 +300,7 @@ struct kvm_xen_exit {
> >> >  #define KVM_EXIT_RISCV_SBI        35
> >> >  #define KVM_EXIT_RISCV_CSR        36
> >> >  #define KVM_EXIT_NOTIFY           37
> >> > +#define KVM_EXIT_MEMORY_FAULT     38
> >> >  
> >> >  /* For KVM_EXIT_INTERNAL_ERROR */
> >> >  /* Emulate instruction failed. */
> >> > @@ -538,6 +539,14 @@ struct kvm_run {
> >> >  #define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
> >> >  			__u32 flags;
> >> >  		} notify;
> >> > +		/* KVM_EXIT_MEMORY_FAULT */
> >> > +		struct {
> >> > +#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> >> > +			__u32 flags;
> >> > +			__u32 padding;
> >> > +			__u64 gpa;
> >> > +			__u64 size;
> >> > +		} memory;
> >> >  		/* Fix the size of the union. */
> >> >  		char padding[256];
> >> >  	};
> >> 
> >> 
> >> -- 
> >> Alex Bennée
> 
> 
> -- 
> Alex Bennée
