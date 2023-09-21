Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D97A90FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 04:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjIUCkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 22:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIUCkB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:40:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BDE4;
        Wed, 20 Sep 2023 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695263995; x=1726799995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iSkpE1N9Jcp84HPqnZ+sK/v5B9D3q8Q2ZGh6iASUxTU=;
  b=QMxYLfRcxVjlt2JELGOu9PCSyMNr1ixLCAbfbUpWOLVunrJeyQ80UA7s
   8H12ILDLy45wWwrEjygDsrV8PeeBlEp6OIQaSq6E8/BhsiXRN28Yz2oPh
   /ksj9i6pXn6H3V97kDFf+VjAiBf7LyV3l+BBlWmtguiTAwba6i7o6S85o
   01rxP/GrIT1aUy9f+/JcEXtpygpQ/yfFzX3bhe1yB7Z29/gj4Y7BLkD9b
   OYX0UKHHt9oNM5HndiEbdeM11Jzm4f9ePwaU3fPpHDEC9Xk0xuyJAVvbw
   tb9vqu5Kr48uJwsC+p4uz8ZML7jzrGxCgBfmddbQn9fOLHscV1OeiW2nH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360653924"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="360653924"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 19:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077731075"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="1077731075"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 19:39:45 -0700
Date:   Thu, 21 Sep 2023 10:39:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v12 02/33] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <ZQus1v3AvEZjuat9@yilunxu-OptiPlex-7050>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-3-seanjc@google.com>
 <ZQqMBEL61p739dpF@yilunxu-OptiPlex-7050>
 <ZQr5uXhV6Cnx4DYT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQr5uXhV6Cnx4DYT@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-20 at 06:55:05 -0700, Sean Christopherson wrote:
> On Wed, Sep 20, 2023, Xu Yilun wrote:
> > On 2023-09-13 at 18:55:00 -0700, Sean Christopherson wrote:
> > > +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
> > > +{
> > > +	lockdep_assert_held_write(&kvm->mmu_lock);
> > > +
> > > +	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
> > > +
> > >  	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
> > >  		kvm->mmu_invalidate_range_start = start;
> > >  		kvm->mmu_invalidate_range_end = end;
> > 
> > IIUC, Now we only add or override a part of the invalidate range in
> > these fields, IOW only the range in last slot is stored when we unlock.
> 
> Ouch.  Good catch!
> 
> > That may break mmu_invalidate_retry_gfn() cause it can never know the
> > whole invalidate range.
> > 
> > How about we extend the mmu_invalidate_range_start/end everytime so that
> > it records the whole invalidate range:
> > 
> > if (kvm->mmu_invalidate_range_start == INVALID_GPA) {
> > 	kvm->mmu_invalidate_range_start = start;
> > 	kvm->mmu_invalidate_range_end = end;
> > } else {
> > 	kvm->mmu_invalidate_range_start =
> > 		min(kvm->mmu_invalidate_range_start, start);
> > 	kvm->mmu_invalidate_range_end =
> > 		max(kvm->mmu_invalidate_range_end, end);
> > }
> 
> Yeah, that does seem to be the easiest solution.
> 
> I'll post a fixup patch, unless you want the honors.

Please go ahead, cause at a second thought I'm wondering if this simple
range extension is reasonable.

When the invalidation acrosses multiple slots, I'm not sure if the
contiguous HVA range must correspond to contiguous GFN range. If not,
are we producing a larger range than required?

And when the invalidation acrosses multiple address space, I'm almost
sure it is wrong to merge GFN ranges from different address spaces. But
I have no clear solution yet.

Thanks,
Yilun
