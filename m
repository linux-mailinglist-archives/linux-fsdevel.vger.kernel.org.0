Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C708A598412
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbiHRNYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245047AbiHRNYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:24:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00D5722E;
        Thu, 18 Aug 2022 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660829074; x=1692365074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5TUL0pMN1Ch62fh0N5bHXldv3b4lhkGVjVf4Q20K7N8=;
  b=af/BoiSPNPjYdKoxzwvWQjR04f450FFqdvSqTtbYlKSF+bXLbM7dBxul
   8PnI3RY2FleRWHpdaa3hTAJMMBHjSDf7/9peNbvrJGfy4K98ikKV2nqhY
   W1IXett9S+pL5UysC8cCbVRgd5YTJnUTn9RxH6B1a+GuhB6LPqEZZZDkU
   +mAA9ZIKN37uYxkTmO0Ckumj2itTgIfFAQGQ5UBlmPVkgJaMypGNwVk14
   5oWbjszXN5VwxNqm6fiWWLJmEX2pbW+QtfEH0D0+yQLAITSCaTjQmx42E
   tU8kRPN80gMfuHYVsH/A2TRkgUGO+jS4S4P+Od9qsl7CJDmvhk4oVqqk6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279720468"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="279720468"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 06:24:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="604253471"
Received: from geigerri-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.215.246])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 06:24:24 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 68132104AA0; Thu, 18 Aug 2022 16:24:21 +0300 (+03)
Date:   Thu, 18 Aug 2022 16:24:21 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Message-ID: <20220818132421.6xmjqduempmxnnu2@box>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> On Wed, 6 Jul 2022, Chao Peng wrote:
> > This is the v7 of this series which tries to implement the fd-based KVM
> > guest private memory.
> 
> Here at last are my reluctant thoughts on this patchset.
> 
> fd-based approach for supporting KVM guest private memory: fine.
> 
> Use or abuse of memfd and shmem.c: mistaken.
> 
> memfd_create() was an excellent way to put together the initial prototype.
> 
> But since then, TDX in particular has forced an effort into preventing
> (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
> 
> Are any of the shmem.c mods useful to existing users of shmem.c? No.
> Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
> 
> What use do you have for a filesystem here?  Almost none.
> IIUC, what you want is an fd through which QEMU can allocate kernel
> memory, selectively free that memory, and communicate fd+offset+length
> to KVM.  And perhaps an interface to initialize a little of that memory
> from a template (presumably copied from a real file on disk somewhere).
> 
> You don't need shmem.c or a filesystem for that!
> 
> If your memory could be swapped, that would be enough of a good reason
> to make use of shmem.c: but it cannot be swapped; and although there
> are some references in the mailthreads to it perhaps being swappable
> in future, I get the impression that will not happen soon if ever.
> 
> If your memory could be migrated, that would be some reason to use
> filesystem page cache (because page migration happens to understand
> that type of memory): but it cannot be migrated.

Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
theoretically possible, but I'm not aware of any plans as of now.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html

> Some of these impressions may come from earlier iterations of the
> patchset (v7 looks better in several ways than v5).  I am probably
> underestimating the extent to which you have taken on board other
> usages beyond TDX and SEV private memory, and rightly want to serve
> them all with similar interfaces: perhaps there is enough justification
> for shmem there, but I don't see it.  There was mention of userfaultfd
> in one link: does that provide the justification for using shmem?
> 
> I'm afraid of the special demands you may make of memory allocation
> later on - surprised that huge pages are not mentioned already;
> gigantic contiguous extents? secretmem removed from direct map?

The design allows for extension to hugetlbfs if needed. Combination of
MFD_INACCESSIBLE | MFD_HUGETLB should route this way. There should be zero
implications for shmem. It is going to be separate struct memfile_backing_store.

I'm not sure secretmem is a fit here as we want to extend MFD_INACCESSIBLE
to be movable if platform supports it and secretmem is not migratable by
design (without direct mapping fragmentations).

> Here's what I would prefer, and imagine much easier for you to maintain;
> but I'm no system designer, and may be misunderstanding throughout.
> 
> QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
> the fallocate syscall interface itself) to allocate and free the memory,
> ioctl for initializing some of it too.  KVM in control of whether that
> fd can be read or written or mmap'ed or whatever, no need to prevent it
> in shmem.c, no need for flags, seals, notifications to and fro because
> KVM is already in control and knows the history.  If shmem actually has
> value, call into it underneath - somewhat like SysV SHM, and /dev/zero
> mmap, and i915/gem make use of it underneath.  If shmem has nothing to
> add, just allocate and free kernel memory directly, recorded in your
> own xarray.

I guess shim layer on top of shmem *can* work. I don't see immediately why
it would not. But I'm not sure it is right direction. We risk creating yet
another parallel VM with own rules/locking/accounting that opaque to
core-mm.

Note that on machines that run TDX guests such memory would likely be the
bulk of memory use. Treating it as a fringe case may bite us one day.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
