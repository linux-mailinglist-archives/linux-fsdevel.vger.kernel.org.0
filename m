Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26F580030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiGYNvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGYNv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:51:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D815736;
        Mon, 25 Jul 2022 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658757088; x=1690293088;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=oTuDloTSJTh/mR+M/XiSHbTOyhEzShF3fA4W384Cvww=;
  b=ivLkHg85qkQ5t/atKgbyZ9VKg1uvgvgQczzgMsc/ElXWTv2upvBLzMN3
   PHhDcpCZQxAl8W+r0eQoHXExx5hHPXkNxxVNZQ1vVWocpnsEqtl17AFHs
   aoputNef/ssbpXvJ0vq7DR0MKI3SmAsje+XQgcrshZafGtiwChmFLCRsi
   brf5GGj6FscuKCij9QpuiGhVEUu2NlE2c7pu6iy3/sUkB2QiJ9PVue7Ie
   64ZtWLwTT28tpEQi3J8c+Jd8bRWjHvPkNdBAIIMKTTSqBKgxAOtnSPZqB
   dwdO3QKjVrRNFVZgiVBeBuoaHxNcsbVMPGD4tndAdHRN8ehM+wVovVYR3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="286459637"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="286459637"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 06:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627458071"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2022 06:51:16 -0700
Date:   Mon, 25 Jul 2022 21:46:28 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Message-ID: <20220725134628.GC304216@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <39067d09-b32b-23a6-ae0e-00ac2fe0466c@redhat.com>
 <YtlrJR3uP6940tjd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlrJR3uP6940tjd@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:05:09PM +0000, Sean Christopherson wrote:
> On Thu, Jul 21, 2022, David Hildenbrand wrote:
> > On 21.07.22 11:44, David Hildenbrand wrote:
> > > On 06.07.22 10:20, Chao Peng wrote:
> > >> Normally, a write to unallocated space of a file or the hole of a sparse
> > >> file automatically causes space allocation, for memfd, this equals to
> > >> memory allocation. This new seal prevents such automatically allocating,
> > >> either this is from a direct write() or a write on the previously
> > >> mmap-ed area. The seal does not prevent fallocate() so an explicit
> > >> fallocate() can still cause allocating and can be used to reserve
> > >> memory.
> > >>
> > >> This is used to prevent unintentional allocation from userspace on a
> > >> stray or careless write and any intentional allocation should use an
> > >> explicit fallocate(). One of the main usecases is to avoid memory double
> > >> allocation for confidential computing usage where we use two memfds to
> > >> back guest memory and at a single point only one memfd is alive and we
> > >> want to prevent memory allocation for the other memfd which may have
> > >> been mmap-ed previously. More discussion can be found at:
> > >>
> > >>   https://lkml.org/lkml/2022/6/14/1255
> > >>
> > >> Suggested-by: Sean Christopherson <seanjc@google.com>
> > >> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > >> ---
> > >>  include/uapi/linux/fcntl.h |  1 +
> > >>  mm/memfd.c                 |  3 ++-
> > >>  mm/shmem.c                 | 16 ++++++++++++++--
> > >>  3 files changed, 17 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > >> index 2f86b2ad6d7e..98bdabc8e309 100644
> > >> --- a/include/uapi/linux/fcntl.h
> > >> +++ b/include/uapi/linux/fcntl.h
> > >> @@ -43,6 +43,7 @@
> > >>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
> > >>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
> > >>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
> > >> +#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
> > > 
> > > Why only "on writes" and not "on reads". IIRC, shmem doesn't support the
> > > shared zeropage, so you'll simply allocate a new page via read() or on
> > > read faults.
> > 
> > Correction: on read() we don't allocate a fresh page. But on read faults
> > we would. So this comment here needs clarification.
> 
> Not just the comment, the code too.  The intent of F_SEAL_AUTO_ALLOCATE is very
> much to block _all_ implicit allocations (or maybe just fault-based allocations
> if "implicit" is too broad of a description).

So maybe still your initial suggestion F_SEAL_FAULT_ALLOCATIONS? One
reason I don't like it is the write() ioctl also cause allocation and we
want to prevent it.

Chao
