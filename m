Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAC574053
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiGNACw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNACv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:02:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD820B;
        Wed, 13 Jul 2022 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657756970; x=1689292970;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=26iuG2PU8gROzu7IcUO0TLcA9lykFGbxNWG8zTRrDpg=;
  b=BHZkgySkaM4voPeSvG7NNKOtqgxUbYRJrXr1AfnhgExX9mFsLr+7Pr2/
   3b7vvnxQjaDYvWM9dWtWTNRuv2QsuvCQZ3BOFUu/SLAFeHuy8EHRW9zZC
   aKY3WPVoppxeZ11ysASXWMxpOU7+GlRWbnTqZc8apzW2uxdicC+84K7b0
   VPys08r5MXjmCLjEjzyZlRZDS100H+m3thriEpbrLDIDhSlvdEV6779fW
   5ry6ImhEJgYT+J14h+GBOWEcPilenNiQ/exgNNw1Fco7cVixq05kjWd7T
   pUxLpqDpKZg4Za9vhSIHADmsO1KsUMk0PMQBhufqMSP9kDZcVPCqii9N4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="311021375"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="311021375"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 17:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="593178497"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2022 17:02:39 -0700
Date:   Thu, 14 Jul 2022 07:59:22 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220713235922.GB2881285@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
 <20220713075738.GC2831541@chaop.bj.intel.com>
 <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d25d2e-ff79-5762-ddb8-87df56f5cbcf@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:35:56PM +0200, Gupta, Pankaj wrote:
> 
> > > > This is the v7 of this series which tries to implement the fd-based KVM
> > > > guest private memory. The patches are based on latest kvm/queue branch
> > > > commit:
> > > > 
> > > >     b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> > > > split_desc_cache only by default capacity
> > > > 
> > > > Introduction
> > > > ------------
> > > > In general this patch series introduce fd-based memslot which provides
> > > > guest memory through memory file descriptor fd[offset,size] instead of
> > > > hva/size. The fd can be created from a supported memory filesystem
> > > > like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> > > 
> > > Thinking a bit, As host side fd on tmpfs or shmem will store memory on host
> > > page cache instead of mapping pages into userspace address space. Can we hit
> > > double (un-coordinated) page cache problem with this when guest page cache
> > > is also used?
> > 
> > This is my understanding: in host it will be indeed in page cache (in
> > current shmem implementation) but that's just the way it allocates and
> > provides the physical memory for the guest. In guest, guest OS will not
> > see this fd (absolutely), it only sees guest memory, on top of which it
> > can build its own page cache system for its own file-mapped content but
> > that is unrelated to host page cache.
> 
> yes. If guest fills its page cache with file backed memory, this at host
> side(on shmem fd backend) will also fill the host page cache fast. This can
> have an impact on performance of guest VM's if host goes to memory pressure
> situation sooner. Or else we end up utilizing way less System RAM.

(Currently), the file backed guest private memory is long-term pinned
and not reclaimable, it's in page cache anyway once we allocated it for
guest. This does not depend on how guest use it (e.g. use it for guest
page cache or not). 

Chao
> 
> Thanks,
> Pankaj
> 
