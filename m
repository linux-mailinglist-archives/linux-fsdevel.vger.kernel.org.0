Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F165FAA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 05:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjAFESQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 23:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjAFESN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:18:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D38192A3;
        Thu,  5 Jan 2023 20:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672978690; x=1704514690;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=EJ99zGke5SZh6gZ65kHYJO251QjbQMEaDGPaMs8wAzE=;
  b=CbyG3GC4YLer1neUAZaMNGD4HLhevcUQpVGMfx/4qZ+7m0Ss4TPfVan4
   8CdnjIgoeUDebp9BWWG9PZ50eFi4rS/DFKffhsF846AMO1XalTrKQqfjl
   XYEGTef7mSY8R1vWKvKrlWILixPI2U7Z6+BRfLTleJM7bMDGpZ3fKz8TY
   XypYjTs2zuL3CLCX2h+bG3lIoF7G5dOPYyWfCXht/+0grr0l5y9b0YlVG
   G+ZtnkKvHOu3OjvlR7Bo/Yv0ruUWPiJYjaiWg04f2FSlMEEDL7ZyGXjkt
   HDHTbD28MsdolLD1f7hoGMfgDNY6TeyisTmCC8iIN9VDKasBQM6JIjTp1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323651270"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="323651270"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 20:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="744504828"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="744504828"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2023 20:17:58 -0800
Date:   Fri, 6 Jan 2023 12:13:46 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20230106041346.GA2288017@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
 <CAGtprH_pbSo1HeEFUEB6ZZxm-=NEw+nLZ6ZVvr76=9BeX=AHPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH_pbSo1HeEFUEB6ZZxm-=NEw+nLZ6ZVvr76=9BeX=AHPA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 05, 2023 at 12:38:30PM -0800, Vishal Annapurve wrote:
> On Thu, Dec 1, 2022 at 10:20 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > +#ifdef CONFIG_HAVE_KVM_RESTRICTED_MEM
> > +static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
> > +                                        pgoff_t start, pgoff_t end,
> > +                                        gfn_t *gfn_start, gfn_t *gfn_end)
> > +{
> > +       unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;
> > +
> > +       if (start > base_pgoff)
> > +               *gfn_start = slot->base_gfn + start - base_pgoff;
> 
> There should be a check for overflow here in case start is a very big
> value. Additional check can look like:
> if (start >= base_pgoff + slot->npages)
>        return false;
> 
> > +       else
> > +               *gfn_start = slot->base_gfn;
> > +
> > +       if (end < base_pgoff + slot->npages)
> > +               *gfn_end = slot->base_gfn + end - base_pgoff;
> 
> If "end" is smaller than base_pgoff, this can cause overflow and
> return the range as valid. There should be additional check:
> if (end < base_pgoff)
>          return false;

Thanks! Both are good catches. The improved code:

static bool restrictedmem_range_is_valid(struct kvm_memory_slot *slot,
					 pgoff_t start, pgoff_t end,
					 gfn_t *gfn_start, gfn_t *gfn_end)
{
	unsigned long base_pgoff = slot->restricted_offset >> PAGE_SHIFT;

	if (start >= base_pgoff + slot->npages)
		return false;
	else if (start <= base_pgoff)
		*gfn_start = slot->base_gfn;
	else
		*gfn_start = start - base_pgoff + slot->base_gfn;

	if (end <= base_pgoff)
		return false;
	else if (end >= base_pgoff + slot->npages)
		*gfn_end = slot->base_gfn + slot->npages;
	else
		*gfn_end = end - base_pgoff + slot->base_gfn;

	if (*gfn_start >= *gfn_end)
		return false;

	return true;
}

Thanks,
Chao
> 
> 
> > +       else
> > +               *gfn_end = slot->base_gfn + slot->npages;
> > +
> > +       if (*gfn_start >= *gfn_end)
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
