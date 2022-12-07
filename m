Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8BC645D74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLGPQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 10:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLGPQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:16:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68E61BBC;
        Wed,  7 Dec 2022 07:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670426184; x=1701962184;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=zcEUcKUODXd/C5+5w7MS4mpwFmKmZd9eZ5keOKWclik=;
  b=f+L3vRsi7SQwHdlJrFUFhHASaSEcraV7j3Hws2fjJLYwcXPqysRGlCTY
   b2VeXYpwcHt2EfQsB7ZgQorBuRHY0iFkaV7T0AIgnFDxRpZQXvJAUotzY
   u2s/FDSGmPIQXiyPpnIwyuRPYo/mVEkj1TXhMjv7pogiu10XTyuRyEL2A
   A5ZFSh/64A3ju6BkS7sjo8z7rRohafy5IMyyVXIAPmIFFg9DjAh4mSYIb
   1WRyennJE3QQHSUKbDVLe9l680R22EKzc9kwxkETZBshYYbQcw3oAesCK
   F374a11t2rNyVfOnXXTRCIoVgRhBxpb21Pa6nEtjiJCq2dstCvBI1wnqa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343947700"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343947700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:16:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="710095974"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="710095974"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2022 07:16:13 -0800
Date:   Wed, 7 Dec 2022 23:11:53 +0800
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
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 4/9] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <20221207151153.GE1275553@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-5-chao.p.peng@linux.intel.com>
 <CA+EHjTyzZ2n8kQxH_Qx72aRq1k+dETJXTsoOM3tggPZAZkYbCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTyzZ2n8kQxH_Qx72aRq1k+dETJXTsoOM3tggPZAZkYbCA@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:47:20PM +0000, Fuad Tabba wrote:
> Hi,
> 
> On Fri, Dec 2, 2022 at 6:19 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
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
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 22 ++++++++++++++++++++++
> >  include/uapi/linux/kvm.h       |  8 ++++++++
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 99352170c130..d9edb14ce30b 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6634,6 +6634,28 @@ array field represents return values. The userspace should update the return
> >  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
> >  spec refer, https://github.com/riscv/riscv-sbi-doc.
> >
> > +::
> > +
> > +               /* KVM_EXIT_MEMORY_FAULT */
> > +               struct {
> > +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE (1ULL << 0)
> > +                       __u64 flags;
> 
> I see you've removed the padding and increased the flag size.

Yes Sean suggested this and also looks good to me.

Chao
> 
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> 
> Cheers,
> /fuad
> 
> 
> 
> 
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
> > index 13bff963b8b0..c7e9d375a902 100644
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
> > @@ -541,6 +542,13 @@ struct kvm_run {
> >  #define KVM_NOTIFY_CONTEXT_INVALID     (1 << 0)
> >                         __u32 flags;
> >                 } notify;
> > +               /* KVM_EXIT_MEMORY_FAULT */
> > +               struct {
> > +#define KVM_MEMORY_EXIT_FLAG_PRIVATE   (1ULL << 0)
> > +                       __u64 flags;
> > +                       __u64 gpa;
> > +                       __u64 size;
> > +               } memory;
> >                 /* Fix the size of the union. */
> >                 char padding[256];
> >         };
> > --
> > 2.25.1
> >
