Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226D160478E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiJSNlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiJSNlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:41:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE6155DA9;
        Wed, 19 Oct 2022 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186147; x=1697722147;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=maPvHabENdJbu0SifYloWSh+XeE9JeazxOD/pHHB/rU=;
  b=ePpJqt9a4rYoKf3f12FBETQeEqSJKEclKShJ3msgjKvjAPf7WfCLI1pf
   v/r7NAhjqY+sXAHXt5vodSFw96vWkPNKLGRhe0pahKlQlXpL++/LXbVpr
   kNF5fTwmx4O6rTERYAPEXWBuIeLmNoYU6Tlpzm1LBIOP0KgEb9AtLbeRg
   lXM3vlo4Mpb1lJJLLQrQOUqcZ58JEi7L+HUI+yhK30BgKRuvvCNoUeqa6
   5FLxBsKLf7t2mkQ0630JT7P1FhtIjFThhPj7EVrXK7QHE0WXRcnU+wSfV
   ZPYEcaJ0VotbFFJVd34yECs4DH8tU9SCPoxaizR7DvaQXGAc9rZe7bvqv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="293803646"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="293803646"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="624134706"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="624134706"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2022 06:27:39 -0700
Date:   Wed, 19 Oct 2022 21:23:08 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 5/8] KVM: Register/unregister the guest private memory
 regions
Message-ID: <20221019132308.GA3496045@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-6-chao.p.peng@linux.intel.com>
 <CA+EHjTxukqBfaN6D+rPOiX83zkGknHEQ16J0k6GQSdL_-e9C6g@mail.gmail.com>
 <20221012023516.GA3218049@chaop.bj.intel.com>
 <CA+EHjTyGyGL+ox81=jdtoHERtHPV=P7wJub=3j7chdijyq-AgA@mail.gmail.com>
 <Y03UiYYioV+FQIpx@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y03UiYYioV+FQIpx@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:17:45PM +0000, Sean Christopherson wrote:
> On Mon, Oct 17, 2022, Fuad Tabba wrote:
> > Hi,
> > 
> > > > > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
> > > > > +#define KVM_MEM_ATTR_SHARED    0x0001
> > > > > +static int kvm_vm_ioctl_set_mem_attr(struct kvm *kvm, gpa_t gpa, gpa_t size,
> > > > > +                                    bool is_private)
> > > > > +{
> > > >
> > > > I wonder if this ioctl should be implemented as an arch-specific
> > > > ioctl. In this patch it performs some actions that pKVM might not need
> > > > or might want to do differently.
> > >
> > > I think it's doable. We can provide the mem_attr_array kind thing in
> > > common code and let arch code decide to use it or not. Currently
> > > mem_attr_array is defined in the struct kvm, if those bytes are
> > > unnecessary for pKVM it can even be moved to arch definition, but that
> > > also loses the potential code sharing for confidential usages in other
> > > non-architectures, e.g. if ARM also supports such usage. Or it can be
> > > provided through a different CONFIG_ instead of
> > > CONFIG_HAVE_KVM_PRIVATE_MEM.
> > 
> > This sounds good. Thank you.
> 
> I like the idea of a separate Kconfig, e.g. CONFIG_KVM_GENERIC_PRIVATE_MEM or
> something.  I highly doubt there will be any non-x86 users for multiple years,
> if ever, but it would allow testing the private memory stuff on ARM (and any other
> non-x86 arch) without needing full pKVM support and with only minor KVM
> modifications, e.g. the x86 support[*] to test UPM without TDX is shaping up to be
> trivial.

CONFIG_KVM_GENERIC_PRIVATE_MEM looks good to me.

Thanks,
Chao
> 
> [*] https://lore.kernel.org/all/Y0mu1FKugNQG5T8K@google.com
