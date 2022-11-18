Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF962EB1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 02:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbiKRBh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 20:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiKRBgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:36:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232C85EE8;
        Thu, 17 Nov 2022 17:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668735396; x=1700271396;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PGqeIE9D9mQ0SzWgaCrOjd5GhXHcGRQuoepeW+csvHw=;
  b=OvEsHXJp/IJA++hIQd40PAA+oJe8q1wn1c1psPicghdSzQDU123GgK0w
   4Tw9ZkUKhzDrKdfZZmFdsGGUHmuaz/e1GHxTN/UVrWyfZ0ObyuBUrJ33m
   UYQEfU3iez9Zqqb7eACxOpbFo544w1r/1FIlFMQXJlJimMsSpyUcQzWsy
   4a+ulVGdo3pkuK63g7SaW1lqZwKTZQuUdDdp63twoEapizd1p6552NK6x
   p4TXbaZHd7JHfj8s/B/w6t+ikPlWhBBdVp7+4oL3LzmFgoIP32Iyy+si6
   vj9W9irfyx0VpMrDCri6BHUIRYECg0c51QoeJy+6k/6oDmSlEm/l0bUt1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="399311566"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="399311566"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 17:36:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703558926"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="703558926"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2022 17:36:26 -0800
Date:   Fri, 18 Nov 2022 09:32:01 +0800
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
Message-ID: <20221118013201.GA456562@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <87cz9o9mr8.fsf@linaro.org>
 <20221116031441.GA364614@chaop.bj.intel.com>
 <87mt8q90rw.fsf@linaro.org>
 <20221117134520.GD422408@chaop.bj.intel.com>
 <87a64p8vof.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a64p8vof.fsf@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:08:17PM +0000, Alex Bennée wrote:
> 
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > On Wed, Nov 16, 2022 at 07:03:49PM +0000, Alex Bennée wrote:
> >> 
> >> Chao Peng <chao.p.peng@linux.intel.com> writes:
> >> 
> >> > On Tue, Nov 15, 2022 at 04:56:12PM +0000, Alex Bennée wrote:
> >> >> 
> >> >> Chao Peng <chao.p.peng@linux.intel.com> writes:
> >> >> 
> >> >> > This new KVM exit allows userspace to handle memory-related errors. It
> >> >> > indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> >> >> > The flags includes additional information for userspace to handle the
> >> >> > error. Currently bit 0 is defined as 'private memory' where '1'
> >> >> > indicates error happens due to private memory access and '0' indicates
> >> >> > error happens due to shared memory access.
> >> >> >
> >> >> > When private memory is enabled, this new exit will be used for KVM to
> >> >> > exit to userspace for shared <-> private memory conversion in memory
> >> >> > encryption usage. In such usage, typically there are two kind of memory
> >> >> > conversions:
> >> >> >   - explicit conversion: happens when guest explicitly calls into KVM
> >> >> >     to map a range (as private or shared), KVM then exits to userspace
> >> >> >     to perform the map/unmap operations.
> >> >> >   - implicit conversion: happens in KVM page fault handler where KVM
> >> >> >     exits to userspace for an implicit conversion when the page is in a
> >> >> >     different state than requested (private or shared).
> >> >> >
> >> >> > Suggested-by: Sean Christopherson <seanjc@google.com>
> >> >> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> >> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> >> >> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> >> >> > ---
> >> >> >  Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
> >> >> >  include/uapi/linux/kvm.h       |  9 +++++++++
> >> >> >  2 files changed, 32 insertions(+)
> >> >> >
> >> >> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> >> >> > index f3fa75649a78..975688912b8c 100644
> >> >> > --- a/Documentation/virt/kvm/api.rst
> >> >> > +++ b/Documentation/virt/kvm/api.rst
> >> >> > @@ -6537,6 +6537,29 @@ array field represents return values. The userspace should update the return
> >> >> >  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
> >> >> >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> >> >> >  
> >> >> > +::
> >> >> > +
> >> >> > +		/* KVM_EXIT_MEMORY_FAULT */
> >> >> > +		struct {
> >> >> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> >> >> > +			__u32 flags;
> >> >> > +			__u32 padding;
> >> >> > +			__u64 gpa;
> >> >> > +			__u64 size;
> >> >> > +		} memory;
> >> >> > +
> >> >> > +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
> >> >> > +encountered a memory error which is not handled by KVM kernel module and
> >> >> > +userspace may choose to handle it. The 'flags' field indicates the memory
> >> >> > +properties of the exit.
> >> >> > +
> >> >> > + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> >> >> > +   private memory access when the bit is set. Otherwise the memory error is
> >> >> > +   caused by shared memory access when the bit is clear.
> >> >> 
> >> >> What does a shared memory access failure entail?
> >> >
> >> > In the context of confidential computing usages, guest can issue a
> >> > shared memory access while the memory is actually private from the host
> >> > point of view. This exit with bit 0 cleared gives userspace a chance to
> >> > convert the private memory to shared memory on host.
> >> 
> >> I think this should be explicit rather than implied by the absence of
> >> another flag. Sean suggested you might want flags for RWX failures so
> >> maybe something like:
> >> 
> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_READ	(1 << 0)
> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_WRITE	(1 << 1)
> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_EXECUTE	(1 << 2)
> >>         KVM_MEMORY_EXIT_FLAG_PRIVATE            (1 << 3)
> >
> > Yes, but I would not add 'SHARED' to RWX, they are not share memory
> > specific, private memory can also set them once introduced.
> 
> OK so how about:
> 
>  	KVM_MEMORY_EXIT_FLAG_READ	(1 << 0)
>  	KVM_MEMORY_EXIT_FLAG_WRITE	(1 << 1)
>  	KVM_MEMORY_EXIT_FLAG_EXECUTE	(1 << 2)
>         KVM_MEMORY_EXIT_FLAG_SHARED     (1 << 3)
>         KVM_MEMORY_EXIT_FLAG_PRIVATE    (1 << 4)

We don't actually need a new bit, the opposite side of private is
shared, i.e. flags with KVM_MEMORY_EXIT_FLAG_PRIVATE cleared expresses
'shared'.

Chao
> 
> >
> > Thanks,
> > Chao
> >> 
> >> which would allow you to signal the various failure modes of the shared
> >> region, or that you had accessed private memory.
> >> 
> >> >
> >> >> 
> >> >> If you envision any other failure modes it might be worth making it
> >> >> explicit with additional flags.
> >> >
> >> > Sean mentioned some more usages[1][]2] other than the memory conversion
> >> > for confidential usage. But I would leave those flags being added in the
> >> > future after those usages being well discussed.
> >> >
> >> > [1] https://lkml.kernel.org/r/20200617230052.GB27751@linux.intel.com
> >> > [2] https://lore.kernel.org/all/YKxJLcg%2FWomPE422@google.com
> >> >
> >> >> I also wonder if a bitmask makes sense if
> >> >> there can only be one reason for a failure? Maybe all that is needed is
> >> >> a reason enum?
> >> >
> >> > Tough we only have one reason right now but we still want to leave room
> >> > for future extension. Enum can express a single value at once well but
> >> > bitmask makes it possible to express multiple orthogonal flags.
> >> 
> >> I agree if multiple orthogonal failures can occur at once a bitmask is
> >> the right choice.
> >> 
> >> >
> >> > Chao
> >> >> 
> >> >> > +
> >> >> > +'gpa' and 'size' indicate the memory range the error occurs at. The userspace
> >> >> > +may handle the error and return to KVM to retry the previous memory access.
> >> >> > +
> >> >> >  ::
> >> >> >  
> >> >> >      /* KVM_EXIT_NOTIFY */
> >> >> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >> >> > index f1ae45c10c94..fa60b032a405 100644
> >> >> > --- a/include/uapi/linux/kvm.h
> >> >> > +++ b/include/uapi/linux/kvm.h
> >> >> > @@ -300,6 +300,7 @@ struct kvm_xen_exit {
> >> >> >  #define KVM_EXIT_RISCV_SBI        35
> >> >> >  #define KVM_EXIT_RISCV_CSR        36
> >> >> >  #define KVM_EXIT_NOTIFY           37
> >> >> > +#define KVM_EXIT_MEMORY_FAULT     38
> >> >> >  
> >> >> >  /* For KVM_EXIT_INTERNAL_ERROR */
> >> >> >  /* Emulate instruction failed. */
> >> >> > @@ -538,6 +539,14 @@ struct kvm_run {
> >> >> >  #define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
> >> >> >  			__u32 flags;
> >> >> >  		} notify;
> >> >> > +		/* KVM_EXIT_MEMORY_FAULT */
> >> >> > +		struct {
> >> >> > +#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
> >> >> > +			__u32 flags;
> >> >> > +			__u32 padding;
> >> >> > +			__u64 gpa;
> >> >> > +			__u64 size;
> >> >> > +		} memory;
> >> >> >  		/* Fix the size of the union. */
> >> >> >  		char padding[256];
> >> >> >  	};
> >> >> 
> >> >> 
> >> >> -- 
> >> >> Alex Bennée
> >> 
> >> 
> >> -- 
> >> Alex Bennée
> 
> 
> -- 
> Alex Bennée
