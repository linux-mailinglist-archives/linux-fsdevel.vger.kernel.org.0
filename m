Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01057C7DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiGUJmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGUJmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:42:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969A1C112;
        Thu, 21 Jul 2022 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658396535; x=1689932535;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=6iF6C2k7uRS+q7Yo8OaJrnqIl0kJvizDvEKWhi3avTo=;
  b=Pe9rfO8vat0nGOs77YG91Bvo6eWdIDHb8dU0nNMCHozKvugdAoPYpiqN
   snYEZEOKRayHadPpjPS4gsshfLXzFJGvCxRePS15aTSLPiHIIaw9mLyOr
   gLuWW1LMxCWszVsygo045ZkFQ3Bo8mFz8qQFUwv+s2mnB2vuSgHBteGir
   smCKEHbAoS2n51xktKfL/xHWHEOJvPuIA2teMfSWlO2EyUBaM1rptmpvY
   smTLxrtqMoHG0EUrsKByX8NSDG1OGCTUKP9+8dhLzrdkSUPgHN5ChBSMT
   AhcgQz7n56uH/56Dt47MM68IJ7zRXUdI36tXSp8qulo9u/vc025jYpKGK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285764611"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="285764611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 02:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="656669811"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2022 02:42:05 -0700
Date:   Thu, 21 Jul 2022 17:37:15 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <20220721093715.GB153288@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-12-chao.p.peng@linux.intel.com>
 <Ytgw8HAsKTmZaubv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytgw8HAsKTmZaubv@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 04:44:32PM +0000, Sean Christopherson wrote:
> On Wed, Jul 06, 2022, Chao Peng wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 230c8ff9659c..bb714c2a4b06 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -914,6 +914,35 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
> >  
> >  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
> >  
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > +#define KVM_MEM_ATTR_PRIVATE	0x0001
> > +static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
> > +					     struct kvm_enc_region *region)
> > +{
> > +	unsigned long start, end;
> 
> As alluded to in a different reply, because this will track GPAs instead of HVAs,
> the type needs to be "gpa_t", not "unsigned long".  Oh, actually, they need to
> be gfn_t, since those are what gets shoved into the xarray.

It's gfn_t actually. My original purpose for this is 32bit architectures
(if any) can also work with it since index of xarrary is 32bit on those
architectures.  But kvm_enc_region is u64 so itr's even not possible.

> 
> > +	void *entry;
> > +	int r;
> > +
> > +	if (region->size == 0 || region->addr + region->size < region->addr)
> > +		return -EINVAL;
> > +	if (region->addr & (PAGE_SIZE - 1) || region->size & (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	start = region->addr >> PAGE_SHIFT;
> > +	end = (region->addr + region->size - 1) >> PAGE_SHIFT;
> > +
> > +	entry = ioctl == KVM_MEMORY_ENCRYPT_REG_REGION ?
> > +				xa_mk_value(KVM_MEM_ATTR_PRIVATE) : NULL;
> > +
> > +	r = xa_err(xa_store_range(&kvm->mem_attr_array, start, end,
> > +					entry, GFP_KERNEL_ACCOUNT));
> 
> IIUC, this series treats memory as shared by default.  I think we should invert
> that and have KVM's ABI be that all guest memory as private by default, i.e.
> require the guest to opt into sharing memory instead of opt out of sharing memory.
> 
> And then the xarray would track which regions are shared.

Maybe I missed some information discussed elsewhere? I followed
https://lkml.org/lkml/2022/5/23/772. KVM is shared by default but
userspace should set all guest memory to private before the guest
launch, guest then sees all memory as private.  While default it to
private sounds also good, if we only talk about the private/shared in
private memory context (I think so), then there is no ambiguity.

> 
> Regarding mem_attr_array, it probably makes sense to explicitly include what it's
> tracking in the name, i.e. name it {private,shared}_mem_array depending on whether
> it's used to track private vs. shared memory.  If we ever need to track metadata
> beyond shared/private then we can tweak the name as needed, e.g. if hardware ever
> supports secondary non-ephemeral encryption keys.

As I think that there may be other state beyond that. Fine with me to
just take consideration of private/shared, and it also sounds
reasonable for people who want to support that to change.

Chao
