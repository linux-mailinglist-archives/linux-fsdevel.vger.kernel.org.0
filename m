Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C040F580049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jul 2022 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiGYN7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiGYN7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:59:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462DA12D32;
        Mon, 25 Jul 2022 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658757557; x=1690293557;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=SebOtSYgmnmuVPxznPkmfUK1/G0u2P5tlySsXcB/PUU=;
  b=bGcXY2/4z6O36tgR4Qp4AkcncqVM9WjWWKP13Jtdprf3Rv04RZr6IG27
   908goCVErrot272ELiKmXSprrPGadPOPb9RZnBkO74LNVHsN+LDPPsjnw
   Ep496qkywxaXVhCPIg2rV5asi+cLp+QC0kCEvEZnAdvqw5T3/dkVF3qt/
   TNQ227GbNqoK8+GZqheBQmxDQYnCwwd+vygVXqEA30dtbdHXgnX4s/qDk
   aVpWiDgVyj2Lo2OOhCZ9OhJb4sv4uQAYEd5C7b+YWtza6UoQ+ThWZdD4C
   U6w9Hd3WmrfMezHSdFXXc0BRg6nk+6m0E4AEvyT36UF9D6WC3CEVkPmmG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274567920"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274567920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 06:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627460234"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2022 06:59:04 -0700
Date:   Mon, 25 Jul 2022 21:54:16 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Message-ID: <20220725135416.GD304216@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <c59fca89-cd0c-1724-210e-d9b01b375103@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59fca89-cd0c-1724-210e-d9b01b375103@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:27:03PM +0200, Gupta, Pankaj wrote:
> 
> > > Normally, a write to unallocated space of a file or the hole of a sparse
> > > file automatically causes space allocation, for memfd, this equals to
> > > memory allocation. This new seal prevents such automatically allocating,
> > > either this is from a direct write() or a write on the previously
> > > mmap-ed area. The seal does not prevent fallocate() so an explicit
> > > fallocate() can still cause allocating and can be used to reserve
> > > memory.
> > > 
> > > This is used to prevent unintentional allocation from userspace on a
> > > stray or careless write and any intentional allocation should use an
> > > explicit fallocate(). One of the main usecases is to avoid memory double
> > > allocation for confidential computing usage where we use two memfds to
> > > back guest memory and at a single point only one memfd is alive and we
> > > want to prevent memory allocation for the other memfd which may have
> > > been mmap-ed previously. More discussion can be found at:
> > > 
> > >    https://lkml.org/lkml/2022/6/14/1255
> > > 
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > ---
> > >   include/uapi/linux/fcntl.h |  1 +
> > >   mm/memfd.c                 |  3 ++-
> > >   mm/shmem.c                 | 16 ++++++++++++++--
> > >   3 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > > index 2f86b2ad6d7e..98bdabc8e309 100644
> > > --- a/include/uapi/linux/fcntl.h
> > > +++ b/include/uapi/linux/fcntl.h
> > > @@ -43,6 +43,7 @@
> > >   #define F_SEAL_GROW	0x0004	/* prevent file from growing */
> > >   #define F_SEAL_WRITE	0x0008	/* prevent writes */
> > >   #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
> > > +#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
> > 
> > Why only "on writes" and not "on reads". IIRC, shmem doesn't support the
> > shared zeropage, so you'll simply allocate a new page via read() or on
> > read faults.
> > 
> > 
> > Also, I *think* you can place pages via userfaultfd into shmem. Not sure
> > if that would count "auto alloc", but it would certainly bypass fallocate().
> 
> I was also thinking this at the same time, but for different reason:
> 
> "Want to populate private preboot memory with firmware payload", so was
> thinking userfaulftd could be an option as direct writes are restricted?

If that can be a side effect, I definitely glad to see it, though I'm
still not clear how userfaultfd can be particularly helpful for that.

Chao
> 
> Thanks,
> Pankaj
> 
> 
> 
> 
