Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16AB650840
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 08:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiLSH5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 02:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLSH5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:57:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0305EBC2E;
        Sun, 18 Dec 2022 23:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671436663; x=1702972663;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=1plgwk37hmjdXcKtmCG/KoF8dtK3gUMs5OEN6hcYczw=;
  b=Ff8kmsBK0HUhY0iDM6CyHCXVu9qex1TMwhdgBKgW4vjc1pWJrzRpZs0z
   9kq1aqZ0M1GW1TIgFDSnHIaQwfqDftDSZyscSggouKnYlrujxpXNWJHeT
   SZaOJBDslixe4HDIJ5m27JQOUq57X1sOX+7cgQASpOumlMLm39V8eru0g
   0g53UoH5sYgbdpVYOwHKDFbH9yafFoK9NpyNam95NKm4oePjsjpWQse6C
   wSVuzKdN2t/4bIhNQfOskJzEGA2lT0EXDgeqAss40Pyx4VE+kRQVOi9HX
   h2L+c++Xu5cvbKDF3G0kEiimAdY1DAnFcYmGvpZnc9csCz0EFizA7pf5L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="381520271"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="381520271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 23:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="650470073"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="650470073"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga002.jf.intel.com with ESMTP; 18 Dec 2022 23:57:29 -0800
Date:   Mon, 19 Dec 2022 15:53:13 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "tabba@google.com" <tabba@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "qperret@google.com" <qperret@google.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221219075313.GB1691829@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:49:13PM +0000, Huang, Kai wrote:
> > 
> > memfd_restricted() itself is implemented as a shim layer on top of real
> > memory file systems (currently tmpfs). Pages in restrictedmem are marked
> > as unmovable and unevictable, this is required for current confidential
> > usage. But in future this might be changed.
> > 
> > 
> I didn't dig full histroy, but I interpret this as we don't support page
> migration and swapping for restricted memfd for now.  IMHO "page marked as
> unmovable" can be confused with PageMovable(), which is a different thing from
> this series.  It's better to just say something like "those pages cannot be
> migrated and swapped".

Yes, if that helps some clarification.

> 
> [...]
> 
> > +
> > +	/*
> > +	 * These pages are currently unmovable so don't place them into movable
> > +	 * pageblocks (e.g. CMA and ZONE_MOVABLE).
> > +	 */
> > +	mapping = memfd->f_mapping;
> > +	mapping_set_unevictable(mapping);
> > +	mapping_set_gfp_mask(mapping,
> > +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> 
> But, IIUC removing __GFP_MOVABLE flag here only makes page allocation from non-
> movable zones, but doesn't necessarily prevent page from being migrated.  My
> first glance is you need to implement either a_ops->migrate_folio() or just
> get_page() after faulting in the page to prevent.

The current api restrictedmem_get_page() already does this, after the
caller calling it, it holds a reference to the page. The caller then
decides when to call put_page() appropriately.

> 
> So I think the comment also needs improvement -- IMHO we can just call out
> currently those pages cannot be migrated and swapped, which is clearer (and the
> latter justifies mapping_set_unevictable() clearly).

Good to me.

Thanks,
Chao
> 
> 
