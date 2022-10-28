Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C6610A31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 08:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ1GS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ1GSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:18:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B31B7F2B;
        Thu, 27 Oct 2022 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666937934; x=1698473934;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=+Xc37e1S+pXkub/JJrhuVoXoAzIONIWOhKRDpZ+Jp3Q=;
  b=lYjO5awxAeslreeXQqzv/dMqBwejJB7EPTpyeUwWtahbTIDkTvSyjiqj
   MDqOdPHCeA+B5W1qcU2fJZPLmqtuHd5N6PIzSXAf0kbC5jov200/OoMwv
   Uck7RplBzq0elLHxPgiDD23xuH4lxirsauSPKxwaF0BJ0T9UoOXED8PRc
   V9BqmWjzZ4wIzyw9/lkjzCpyK99L5jyEC12u10dQyMDRNFJUKvpQtTcks
   eusT5nQO3k2PsGIC8VUZghNkUQxiF9IZ3O3V6hzSoVIGIL2IDm1y7QYo/
   RVuva+0hpkmwXwbV5cFciESZKaetuWYWt4gpglRQurQIGhquzBwuX/XPQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="291720435"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="291720435"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 23:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627428346"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="627428346"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2022 23:18:42 -0700
Date:   Fri, 28 Oct 2022 14:14:13 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Fuad Tabba <tabba@google.com>
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <20221028061413.GB3885130@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <CA+EHjTxzLDAW=MyfKFcL2cGQimw3bdVYePUgRw+=1+AbCQouUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxzLDAW=MyfKFcL2cGQimw3bdVYePUgRw+=1+AbCQouUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:27:05AM +0100, Fuad Tabba wrote:
> Hi,
> 
> On Tue, Oct 25, 2022 at 4:19 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > This new KVM exit allows userspace to handle memory-related errors. It
> > indicates an error happens in KVM at guest memory range [gpa, gpa+size).
> > The flags includes additional information for userspace to handle the
> > error. Currently bit 0 is defined as 'private memory' where '1'
> > indicates error happens due to private memory access and '0' indicates
> > error happens due to shared memory access.
> >
> > When private memory is enabled, this new exit will be used for KVM to
> > exit to userspace for shared <-> private memory conversion in memory
> > encryption usage. In such usage, typically there are two kind of memory
> > conversions:
> >   - explicit conversion: happens when guest explicitly calls into KVM
> >     to map a range (as private or shared), KVM then exits to userspace
> >     to perform the map/unmap operations.
> >   - implicit conversion: happens in KVM page fault handler where KVM
> >     exits to userspace for an implicit conversion when the page is in a
> >     different state than requested (private or shared).
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Co-developed-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > ---
> 
> Reviewed-by: Fuad Tabba <tabba@google.com>
> 
> I have tested the V8 version of this patch on arm64/qemu, and
> considering this hasn't changed:
> Tested-by: Fuad Tabba <tabba@google.com>

Appreciate your review and testing!

Chao
> 
> Cheers,
> /fuad
> 
> 
> 
> >  Documentation/virt/kvm/api.rst | 23 +++++++++++++++++++++++
> >  include/uapi/linux/kvm.h       |  9 +++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index f3fa75649a78..975688912b8c 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6537,6 +6537,29 @@ array field represents return values. The userspace should update the return
> >  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
> >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> >
> > +::
> > +
> > +               /* KVM_EXIT_MEMORY_FAULT */
> > +               struct {
> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1 << 0)
> > +                       __u32 flags;
> > +                       __u32 padding;
> > +                       __u64 gpa;
> > +                       __u64 size;
> > +               } memory;
> > +
> > +If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
> > +encountered a memory error which is not handled by KVM kernel module and
> > +userspace may choose to handle it. The 'flags' field indicates the memory
> > +properties of the exit.
> > +
> > + - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
> > +   private memory access when the bit is set. Otherwise the memory error is
> > +   caused by shared memory access when the bit is clear.
> > +
> > +'gpa' and 'size' indicate the memory range the error occurs at. The userspace
> > +may handle the error and return to KVM to retry the previous memory access.
> > +
> >  ::
> >
> >      /* KVM_EXIT_NOTIFY */
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index f1ae45c10c94..fa60b032a405 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -300,6 +300,7 @@ struct kvm_xen_exit {
> >  #define KVM_EXIT_RISCV_SBI        35
> >  #define KVM_EXIT_RISCV_CSR        36
> >  #define KVM_EXIT_NOTIFY           37
> > +#define KVM_EXIT_MEMORY_FAULT     38
> >
> >  /* For KVM_EXIT_INTERNAL_ERROR */
> >  /* Emulate instruction failed. */
> > @@ -538,6 +539,14 @@ struct kvm_run {
> >  #define KVM_NOTIFY_CONTEXT_INVALID     (1 << 0)
> >                         __u32 flags;
> >                 } notify;
> > +               /* KVM_EXIT_MEMORY_FAULT */
> > +               struct {
> > +#define KVM_MEMORY_EXIT_FLAG_PRIVATE   (1 << 0)
> > +                       __u32 flags;
> > +                       __u32 padding;
> > +                       __u64 gpa;
> > +                       __u64 size;
> > +               } memory;
> >                 /* Fix the size of the union. */
> >                 char padding[256];
> >         };
> > --
> > 2.25.1
> >
