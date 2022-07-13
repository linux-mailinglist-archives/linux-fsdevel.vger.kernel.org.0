Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7222F572FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGMIB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiGMIBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:01:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED1FE024B;
        Wed, 13 Jul 2022 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657699284; x=1689235284;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=7ENYqPqKTk0ESIJ/QoNgf3KZMY16w1kA6fyDKtIJ5rs=;
  b=kNCjkJ85qfjLYK9qXQSQByNS+v9xJRKUpuzu8lH80gStYi9Iozs7Rl0h
   0HWCpUEP5oZSEvmpeWEXVAV+YKETkCaOUeZ3C7XOuk59dNVJkhoQKYaEI
   GiPmRlpQ8wZQPNJDZokx6u0l3H9jYr7KtOsoh0Dwl96MjgUuJBz++qjsh
   kqkF32AcVYSyINx5VEzI0vbCScmCr08tsJaZJ4tMhc+b6DZ6c8Rp6xi4C
   /RCaXDMVFL9tbZ+xIJdK2hij6L3q9l23+m8Kt8u3D76xOALO4b1TytUNh
   VIeD9HjgOzaIS2Tf8JHtjjtaePuqrlqN41IOwCDb860KmKZJPxx2d0s75
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286277206"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286277206"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 01:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685071104"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2022 01:00:56 -0700
Date:   Wed, 13 Jul 2022 15:57:38 +0800
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
Message-ID: <20220713075738.GC2831541@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c12a4b-46f7-081b-242f-005a8824aad1@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:58:32AM +0200, Gupta, Pankaj wrote:
> 
> > This is the v7 of this series which tries to implement the fd-based KVM
> > guest private memory. The patches are based on latest kvm/queue branch
> > commit:
> > 
> >    b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
> > split_desc_cache only by default capacity
> > 
> > Introduction
> > ------------
> > In general this patch series introduce fd-based memslot which provides
> > guest memory through memory file descriptor fd[offset,size] instead of
> > hva/size. The fd can be created from a supported memory filesystem
> > like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
> 
> Thinking a bit, As host side fd on tmpfs or shmem will store memory on host
> page cache instead of mapping pages into userspace address space. Can we hit
> double (un-coordinated) page cache problem with this when guest page cache
> is also used?

This is my understanding: in host it will be indeed in page cache (in
current shmem implementation) but that's just the way it allocates and
provides the physical memory for the guest. In guest, guest OS will not
see this fd (absolutely), it only sees guest memory, on top of which it
can build its own page cache system for its own file-mapped content but
that is unrelated to host page cache.

Chao
> 
> Thanks,
> Pankaj
> 
