Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC906647DC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 07:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLIG3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 01:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLIG3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:29:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFBE31ECD;
        Thu,  8 Dec 2022 22:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670567343; x=1702103343;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Tlu8CMGwsT7F5T0zdAfMh3PoUym3LStYGuVUhIigsRU=;
  b=aQOG6/F969qELkXHXCbi41savMuReoe3Vy4uoM/gqnYAHPOvqG5xFs96
   A13SWnBP312KbpEudvbyNrHEri4IxukurScQm0H/nlvBsem0Nn/zvnER1
   bjtIYRaoJejDzMpRYzMmHzl4ksw1KKSeXigHYixB3s8+aL/Fbr6D9wX9T
   FrN20yJwTgOLhOndL++rNmYCkrnWf5U8WEKUm3A5HNQ2ymX3+ck+qFLw3
   2//5fFL0ItCLGokCmpacAylsOdeJNVqlkqVh9a4aujdrYjWbZdErl4a9s
   F4dM0HZ+/1OzV6U2Qza4SZcjiRdNnSnqy1WO4QjbMOzb9uEK5b+BfFeTQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="403646400"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="403646400"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 22:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="640921316"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="640921316"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 08 Dec 2022 22:28:50 -0800
Date:   Fri, 9 Dec 2022 14:24:31 +0800
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
Subject: Re: [PATCH v10 5/9] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <20221209062431.GA1342934@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-6-chao.p.peng@linux.intel.com>
 <CA+EHjTy5+Ke_7Uh72p--H9kGcE-PK4EVmp7ym6Q1-PO28u6CCQ@mail.gmail.com>
 <20221206115623.GB1216605@chaop.bj.intel.com>
 <CA+EHjTx3_Vkh9Jb_ZJNi5Xx=O24eM-jpF0gR+UGf9W0ORgNyhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTx3_Vkh9Jb_ZJNi5Xx=O24eM-jpF0gR+UGf9W0ORgNyhQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:48:50PM +0000, Fuad Tabba wrote:
...
 > >
> > > >          */
> > > > -       if (unlikely(kvm->mmu_invalidate_in_progress) &&
> > > > -           hva >= kvm->mmu_invalidate_range_start &&
> > > > -           hva < kvm->mmu_invalidate_range_end)
> > > > -               return 1;
> > > > +       if (unlikely(kvm->mmu_invalidate_in_progress)) {
> > > > +               /*
> > > > +                * Dropping mmu_lock after bumping mmu_invalidate_in_progress
> > > > +                * but before updating the range is a KVM bug.
> > > > +                */
> > > > +               if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
> > > > +                                kvm->mmu_invalidate_range_end == INVALID_GPA))
> > >
> > > INVALID_GPA is an x86-specific define in
> > > arch/x86/include/asm/kvm_host.h, so this doesn't build on other
> > > architectures. The obvious fix is to move it to
> > > include/linux/kvm_host.h.
> >
> > Hmm, INVALID_GPA is defined as ZERO for x86, not 100% confident this is
> > correct choice for other architectures, but after search it has not been
> > used for other architectures, so should be safe to make it common.

As Yu posted a patch:
https://lore.kernel.org/all/20221209023622.274715-1-yu.c.zhang@linux.intel.com/

There is a GPA_INVALID in include/linux/kvm_types.h and I see ARM has already
been using it so sounds that is exactly what I need.

Chao
> 
> With this fixed,
> 
> Reviewed-by: Fuad Tabba <tabba@google.com>
> And the necessary work to port to arm64 (on qemu/arm64):
> Tested-by: Fuad Tabba <tabba@google.com>
> 
> Cheers,
> /fuad
