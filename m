Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5415F59F7D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 12:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiHXKco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXKcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:32:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD47E814;
        Wed, 24 Aug 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661337162; x=1692873162;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=UArt2EM4pE0fPWswCENdaTr2KP04kl+6xHjnd6dPVIs=;
  b=bDfsMatcpT388oU11xyWAASlre+w97FZBiFfg51ZzsSv6cC0/ToF/AHP
   OoZok09KnuFtaKo0TyexRNMW6/agwVevHpesQftxLvx+Dk0TfvdqpJu8T
   QBTqYP8SOiyqr6KLW7iSjyyZIQyR8q5k9ajFYyibiJpVOLFLvmgOr4Y9G
   T+86G6sNp71SLPb35k8kQ7lAu33U+6KTf9zAGyiobZfghiSvQHCj/6j/C
   6Y+lIkiqt/JiR+hme32jJ4iDiveGjQreUxh3RFxdPABnFKflDoqPJSpgN
   VY92WzUcq8w6vIIVyM+8Y+dBEYXTmFzkFXHYXMWDsuPw9ffdeFeCWwnH4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355658596"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="355658596"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 03:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605987428"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 03:32:31 -0700
Date:   Wed, 24 Aug 2022 18:27:48 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220824102748.GB1385482@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <YwIIoFJrKPBXaRDW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwIIoFJrKPBXaRDW@casper.infradead.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 21, 2022 at 11:27:44AM +0100, Matthew Wilcox wrote:
> On Thu, Aug 18, 2022 at 08:00:41PM -0700, Hugh Dickins wrote:
> > tmpfs and hugetlbfs and page cache are designed around sharing memory:
> > TDX is designed around absolutely not sharing memory; and the further
> > uses which Sean foresees appear not to need it as page cache either.
> > 
> > Except perhaps for page migration reasons.  It's somewhat incidental,  
> > but of course page migration knows how to migrate page cache, so
> > masquerading as page cache will give a short cut to page migration,
> > when page migration becomes at all possible.
> 
> I haven't read the patch series, and I'm not taking a position one way
> or the other on whether this is better implemented as a shmem addition
> or a shim that asks shmem for memory.  Page migration can be done for
> driver memory by using PageMovable.  I just rewrote how it works, so
> the details are top of my mind at the moment if anyone wants something
> explained.  Commit 68f2736a8583 is the key one to look at.

Thanks Matthew. That is helpful to understand the current code.

Chao
