Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D77651BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 08:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiLTH2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 02:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiLTH17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:27:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61042120B6;
        Mon, 19 Dec 2022 23:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671521220; x=1703057220;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=c7MFanM5OsQxf4mfVMxJdtJD6xfrjMgUk4/0Zk73muk=;
  b=diQ/TTC4A/f0m3ip6hLGojkoKtLi1yb+0prGnGDiqcK0tG3ov2K3kDcX
   jDVl1uj0ZpchIffz/L8jjz8ZWqs11AW66NO3YuEZ/8gI9Z0aIzgKbHD7R
   hn+zzznAoF7u6IPp8uaC9ejjRz+ohaBy+PHB9fToL6oNo/7ywztCd2Bjf
   scTJgKSLdnrI5QQul4tv/Hu/EL1zV/rfJch0LZq+FIIxKXiSeEBXHJ9YT
   dPApISjd4ejTcZibrseEFNAyr6bhP8Id+lOdw2jBLQbtg5Kd0lMMG4jyj
   yTjzNTVUdmUW/MxNKza3/GkRbh/V4MEK9zejFlGcAUXN+Cp+BbobD+3im
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="317184648"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="317184648"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 23:26:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="714332739"
X-IronPort-AV: E=Sophos;i="5.96,258,1665471600"; 
   d="scan'208";a="714332739"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 19 Dec 2022 23:26:44 -0800
Date:   Tue, 20 Dec 2022 15:22:28 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "tabba@google.com" <tabba@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221220072228.GA1724933@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 19, 2022 at 08:48:10AM +0000, Huang, Kai wrote:
> On Mon, 2022-12-19 at 15:53 +0800, Chao Peng wrote:
> > > 
> > > [...]
> > > 
> > > > +
> > > > +	/*
> > > > +	 * These pages are currently unmovable so don't place them into
> > > > movable
> > > > +	 * pageblocks (e.g. CMA and ZONE_MOVABLE).
> > > > +	 */
> > > > +	mapping = memfd->f_mapping;
> > > > +	mapping_set_unevictable(mapping);
> > > > +	mapping_set_gfp_mask(mapping,
> > > > +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> > > 
> > > But, IIUC removing __GFP_MOVABLE flag here only makes page allocation from
> > > non-
> > > movable zones, but doesn't necessarily prevent page from being migrated.  My
> > > first glance is you need to implement either a_ops->migrate_folio() or just
> > > get_page() after faulting in the page to prevent.
> > 
> > The current api restrictedmem_get_page() already does this, after the
> > caller calling it, it holds a reference to the page. The caller then
> > decides when to call put_page() appropriately.
> 
> I tried to dig some history. Perhaps I am missing something, but it seems Kirill
> said in v9 that this code doesn't prevent page migration, and we need to
> increase page refcount in restrictedmem_get_page():
> 
> https://lore.kernel.org/linux-mm/20221129112139.usp6dqhbih47qpjl@box.shutemov.name/
> 
> But looking at this series it seems restrictedmem_get_page() in this v10 is
> identical to the one in v9 (except v10 uses 'folio' instead of 'page')?

restrictedmem_get_page() increases page refcount several versions ago so
no change in v10 is needed. You probably missed my reply:

https://lore.kernel.org/linux-mm/20221129135844.GA902164@chaop.bj.intel.com/

The current solution is clear: unless we have better approach, we will
let restrictedmem user (KVM in this case) to hold the refcount to
prevent page migration.

Thanks,
Chao
> 
> Anyway if this is not fixed, then it should be fixed.  Otherwise, a comment at
> the place where page refcount is increased will be helpful to help people
> understand page migration is actually prevented.
> 
