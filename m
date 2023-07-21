Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1DA75C4F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 12:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGUKra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUKr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:47:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965AB1701;
        Fri, 21 Jul 2023 03:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689936448; x=1721472448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lqUeKJjFv2Sxri0zg/OC/DAKL78i5iZqhBI02xpLRko=;
  b=b1gQmxJK0t5qLXwInz2z1vsdJy6AAum1O7lL2lvyHs1DN9MMjcWJh3Ie
   XiQIolmGnSCp8dS7AHZSNibxy1hVJ/i0RigeqX+3TY4Dchg79d7tNOVZt
   1zI0mxUUEvbdid5OKYkKK/OjvF3ZXRsYUUBweuFEO96HogAYXug1jV1FM
   yXeHCATd/WIUfaKFRwUCN6MxORHdPgsDhMt0bhcAg+lXz7IRDf3PKuGMb
   /1av+6I8NpXxKDEkf4L4OUG5eZRRZANszRY6PuFLljdeBGha5N7Pqp/NZ
   HY/81IGWCW7Y7bnlpdITKo1unVMFC5S6MTvObMTBR5MjdcpzxEDN4ncJ0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="365884912"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="365884912"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724827627"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724827627"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2023 03:47:13 -0700
Date:   Fri, 21 Jul 2023 18:45:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a
 per-action union
Message-ID: <ZLphxpSTL9Fpn1ye@yilunxu-OptiPlex-7050>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-2-seanjc@google.com>
 <ZLolA2U83tP75Qdd@yzhao56-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLolA2U83tP75Qdd@yzhao56-desk.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-21 at 14:26:11 +0800, Yan Zhao wrote:
> On Tue, Jul 18, 2023 at 04:44:44PM -0700, Sean Christopherson wrote:
> 
> May I know why KVM now needs to register to callback .change_pte()?

I can see the original purpose is to "setting a pte in the shadow page
table directly, instead of flushing the shadow page table entry and then
getting vmexit to set it"[1].

IIUC, KVM is expected to directly make the new pte present for new
pages in this callback, like for COW.

> As also commented in kvm_mmu_notifier_change_pte(), .change_pte() must be
> surrounded by .invalidate_range_{start,end}().
> 
> While kvm_mmu_notifier_invalidate_range_start() has called kvm_unmap_gfn_range()
> to zap all leaf SPTEs, and page fault path will not install new SPTEs
> successfully before kvm_mmu_notifier_invalidate_range_end(),
> kvm_set_spte_gfn() should not be able to find any shadow present leaf entries to
> update PFN.

I also failed to figure out how the kvm_set_spte_gfn() could pass
several !is_shadow_present_pte(iter.old_spte) check then write the new
pte.


[1] https://lore.kernel.org/all/200909222039.n8MKd4TL002696@imap1.linux-foundation.org/

Thanks,
Yilun

> 
> Or could we just delete completely
> "kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);"
> from kvm_mmu_notifier_change_pte() ?
