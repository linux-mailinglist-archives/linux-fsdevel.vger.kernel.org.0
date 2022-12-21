Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE660653206
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiLUNrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 08:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLUNrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:47:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE36475;
        Wed, 21 Dec 2022 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671630434; x=1703166434;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Ey/uI44qPCpd4ueyxtxDLkQhSghq6Fbj8dB2OhBP0No=;
  b=Hta25vIZugyt08XE12XPlw8wi4ujV3wir82IZS9dfVva9Cgnwz9KC31f
   ei5ocTRN2lF9EQU/d8dqZW4jc7lrGKFNdwTw3RUQh+zuWkI/m63+AFwRW
   4I+TY2JNyVNzQB67IxQBnS8Kgl3CosleTrM4pUovIMXLKNxSCoP+3xrCA
   ERQBCx8OG6yd8z+WCpRRmVQJUi+hDzEzKQJqYUQsgvpWL8he8TtaAVtdj
   dfBM3PWzqKV6YbegjQ+TAdtKUZh3x4aO2yR0AQ9E6Qs9WGUh1PPnzdn1u
   fn9up1uI31MzP3z7GTFB/13ku2WvXwL/4NptD6RS4YYVXbkur1vUb7L4J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="318568460"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="318568460"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 05:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="651402272"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="651402272"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga002.jf.intel.com with ESMTP; 21 Dec 2022 05:47:03 -0800
Date:   Wed, 21 Dec 2022 21:42:46 +0800
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
Message-ID: <20221221134246.GB1766136@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com>
 <Y6B27MpZO8o1Asfe@zn.tnic>
 <20221220074318.GC1724933@chaop.bj.intel.com>
 <Y6GGoAVQGPyCaDnS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GGoAVQGPyCaDnS@zn.tnic>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:55:44AM +0100, Borislav Petkov wrote:
> On Tue, Dec 20, 2022 at 03:43:18PM +0800, Chao Peng wrote:
> > RESTRICTEDMEM is needed by TDX_HOST, not TDX_GUEST.
> 
> Which basically means that RESTRICTEDMEM should simply depend on KVM.
> Because you can't know upfront whether KVM will run a TDX guest or a SNP
> guest and so on.
> 
> Which then means that RESTRICTEDMEM will practically end up always
> enabled in KVM HV configs.

That's right, CONFIG_RESTRICTEDMEM is always selected for supported KVM
architectures (currently x86_64).

> 
> > The only reason to add another HAVE_KVM_RESTRICTED_MEM is some code only
> > works for 64bit[*] and CONFIG_RESTRICTEDMEM is not sufficient to enforce
> > that.
> 
> This is what I mean with "we have too many Kconfig items". :-\

Yes I agree. One way to remove this is probably additionally checking
CONFIG_64BIT instead.

Thanks,
Chao
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
