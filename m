Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CE645D87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiLGPTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGPTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:19:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EDB1E3DC;
        Wed,  7 Dec 2022 07:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670426348; x=1701962348;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=jSuyaBC+CEdahrEMqj1EGdbe+9W/yLc3hrTCB1EDaSs=;
  b=Bd80++yc/u9Sg9fSdqD2reRXYGDX/dr1JBIJXODlt77ytFxYU7hE9LfB
   LS9x5t4esauEUdO+pspid+oZN4uTk4452zf8qG/ZIXz7/w5+CWKaCa/a6
   FJNEeIXNOc3pSTdjFEMaH8i7IQdJtDQR2zvVRaSKPi3QpBcFB7CG+uQeR
   Af7VFB0GGdq8j1qj7CfmYU9r73CGJMktD9Hdabaqkod2Tupx0ElPawjeG
   yOurzxfawV6drBDeGANKtUzxPOQsiEGsVN42qk3YxP1WUwMo50mDj8uPv
   j62KYmciTP4Cphsehjv4yMQKtisUwgTJF4IOE+yzvAQhCEhbZxjNIOC2u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343948387"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343948387"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="710096874"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="710096874"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2022 07:18:57 -0800
Date:   Wed, 7 Dec 2022 23:14:37 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <20221207151437.GF1275553@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-6-chao.p.peng@linux.intel.com>
 <CA+EHjTy5+Ke_7Uh72p--H9kGcE-PK4EVmp7ym6Q1-PO28u6CCQ@mail.gmail.com>
 <20221206115623.GB1216605@chaop.bj.intel.com>
 <20221207063411.GB3632095@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207063411.GB3632095@ls.amr.corp.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 06, 2022 at 10:34:11PM -0800, Isaku Yamahata wrote:
> On Tue, Dec 06, 2022 at 07:56:23PM +0800,
> Chao Peng <chao.p.peng@linux.intel.com> wrote:
> 
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
> 
> INVALID_GPA is defined as all bit 1.  Please notice "~" (tilde).
> 
> #define INVALID_GPA (~(gpa_t)0)

Thanks for mention. Still looks right moving it to include/linux/kvm_host.h. 
Chao
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
