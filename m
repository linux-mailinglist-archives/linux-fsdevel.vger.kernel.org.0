Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159BF651BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 08:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiLTHrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 02:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLTHrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:47:49 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2A106;
        Mon, 19 Dec 2022 23:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671522468; x=1703058468;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=18JY1Rv+JmD8fqHB1Zwfy2CyVc6av0CO+XzWDU5pLU8=;
  b=cvT3hrCnlih0FOk9rqv+UWjL3sEjGz0Y7aaLsz37QwUFtTyPcNKqcYFE
   p4HFw9mVsrCDLGtvZFb65MKGgey0+vZ5rHKCU6Khc15qVY3oZp3HnvqTI
   RcPpA+cy9HNUSBNNWdo63xMW1LG3Iu5YtiuinDx0oJbXVeR/qn/k5+GHp
   Fx2Bt8MCL/zjLBAlv+6Y19rX0NPzDFLz+qpvt/9uj5rJ0CDvzOfxs827I
   s7bvoHeI1wcA5LJb5xYGllAOWxAFKIO958eWZEXm0unBG29D4aM2V3/Oe
   8kPqSp3/Yy7YbJfbHC3t1ie9PykQtP6HYnngfkP7IsuILxbCmk0BJpzMz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="317187844"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="317187844"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 23:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="896319288"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="896319288"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2022 23:47:34 -0800
Date:   Tue, 20 Dec 2022 15:43:18 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
Message-ID: <20221220074318.GC1724933@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y6B27MpZO8o1Asfe@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6B27MpZO8o1Asfe@zn.tnic>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 19, 2022 at 03:36:28PM +0100, Borislav Petkov wrote:
> On Fri, Dec 02, 2022 at 02:13:41PM +0800, Chao Peng wrote:
> > In memory encryption usage, guest memory may be encrypted with special
> > key and can be accessed only by the guest itself. We call such memory
> > private memory. It's valueless and sometimes can cause problem to allow
> 
> valueless?
> 
> I can't parse that.

It's unnecessary and ...

> 
> > userspace to access guest private memory. This new KVM memslot extension
> > allows guest private memory being provided through a restrictedmem
> > backed file descriptor(fd) and userspace is restricted to access the
> > bookmarked memory in the fd.
> 
> bookmarked?

userspace is restricted to access the memory content in the fd.

> 
> > This new extension, indicated by the new flag KVM_MEM_PRIVATE, adds two
> > additional KVM memslot fields restricted_fd/restricted_offset to allow
> > userspace to instruct KVM to provide guest memory through restricted_fd.
> > 'guest_phys_addr' is mapped at the restricted_offset of restricted_fd
> > and the size is 'memory_size'.
> > 
> > The extended memslot can still have the userspace_addr(hva). When use, a
> 
> "When un use, ..."

When both userspace_addr and restricted_fd/offset were used, ...

> 
> ...
> 
> > diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> > index a8e379a3afee..690cb21010e7 100644
> > --- a/arch/x86/kvm/Kconfig
> > +++ b/arch/x86/kvm/Kconfig
> > @@ -50,6 +50,8 @@ config KVM
> >  	select INTERVAL_TREE
> >  	select HAVE_KVM_PM_NOTIFIER if PM
> >  	select HAVE_KVM_MEMORY_ATTRIBUTES
> > +	select HAVE_KVM_RESTRICTED_MEM if X86_64
> > +	select RESTRICTEDMEM if HAVE_KVM_RESTRICTED_MEM
> 
> Those deps here look weird.
> 
> RESTRICTEDMEM should be selected by TDX_GUEST as it can't live without
> it.

RESTRICTEDMEM is needed by TDX_HOST, not TDX_GUEST.

> 
> Then you don't have to select HAVE_KVM_RESTRICTED_MEM simply because of
> X86_64 - you need that functionality when the respective guest support
> is enabled in KVM.

Letting the actual feature(e.g. TDX or pKVM) select it or add dependency
sounds a viable and clearer solution. Sean, let me know your opinion.

> 
> Then, looking forward into your patchset, I'm not sure you even
> need HAVE_KVM_RESTRICTED_MEM - you could make it all depend on
> CONFIG_RESTRICTEDMEM. But that's KVM folks call - I'd always aim for
> less Kconfig items because we have waay too many.

The only reason to add another HAVE_KVM_RESTRICTED_MEM is some code only
works for 64bit[*] and CONFIG_RESTRICTEDMEM is not sufficient to enforce
that.

[*] https://lore.kernel.org/all/YkJLFu98hZOvTSrL@google.com/

Thanks,
Chao
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
