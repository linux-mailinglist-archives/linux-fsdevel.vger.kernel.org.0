Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A35889EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 11:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiHCJyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiHCJxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:53:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC81F62F;
        Wed,  3 Aug 2022 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659520405; x=1691056405;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=+aPcfNfpscocEOQ9jmuyTbo+RfEvHrVOwXoeE1Ifd/w=;
  b=j0N3CPDfs4Hl5SCNF8eDyc5hqJe0BCeYqvjbJc19KzrSbKCp6uIuuPF9
   r83PtLqpqkef+mVD+pG/l3bNMkBvYLbc5l5y0mrko/7AeLN5W6nlxZWRP
   MizYNmmjbhuphOt06/7XsZpGdZBKL0XFOdOh1qSfwyyioiw26iEhh0dL/
   yAhwhaG31uz8Xbw+K7t395p+t7Q3and99QW7zYy1CijNkdp0OD0TvYESO
   dMKTxRZ7GyEoik9yvfQj5rAbp6xpqXNN4FXo8z/yvznY88vuFeJhqjm0E
   +aX4soEHDtZY/Ss+cLIMCEBzvRVf2iPu4JQUumjdblrBJODZftY27BH4e
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272679939"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="272679939"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="599588924"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2022 02:53:14 -0700
Date:   Wed, 3 Aug 2022 17:48:27 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wei Wang <wei.w.wang@linux.intel.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 11/14] KVM: Register/unregister the guest private
 memory regions
Message-ID: <20220803094827.GA607465@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220720150706.GB124133@chaop.bj.intel.com>
 <d0fd229d-afa6-c66d-3e55-09ac5877453e@amd.com>
 <YtgrkXqP/GIi9ujZ@google.com>
 <45ae9f57-d595-f202-abb5-26a03a2ca131@linux.intel.com>
 <20220721092906.GA153288@chaop.bj.intel.com>
 <YtmT2irvgInX1kPp@google.com>
 <20220725130417.GA304216@chaop.bj.intel.com>
 <YuQ64RgWqdoAAGdY@google.com>
 <Yuh0ikhoh+tCK6VW@google.com>
 <YulTH7bL4MwT5v5K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YulTH7bL4MwT5v5K@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 02, 2022 at 04:38:55PM +0000, Sean Christopherson wrote:
> On Tue, Aug 02, 2022, Sean Christopherson wrote:
> > I think we should avoid UNMAPPABLE even on the KVM side of things for the core
> > memslots functionality and instead be very literal, e.g.
> > 
> > 	KVM_HAS_FD_BASED_MEMSLOTS
> > 	KVM_MEM_FD_VALID
> > 
> > We'll still need KVM_HAS_USER_UNMAPPABLE_MEMORY, but it won't be tied directly to
> > the memslot.  Decoupling the two thingis will require a bit of extra work, but the
> > code impact should be quite small, e.g. explicitly query and propagate
> > MEMFILE_F_USER_INACCESSIBLE to kvm_memory_slot to track if a memslot can be private.
> > And unless I'm missing something, it won't require an additional memslot flag.
> > The biggest oddity (if we don't also add KVM_MEM_PRIVATE) is that KVM would
> > effectively ignore the hva for fd-based memslots for VM types that don't support
> > private memory, i.e. userspace can't opt out of using the fd-based backing, but that
> > doesn't seem like a deal breaker.

I actually love this idea. I don't mind adding extra code for potential
usage other than confidential VMs if we can have a workable solution for
it.

> 
> Hrm, but basing private memory on top of a generic FD_VALID would effectively require
> shared memory to use hva-based memslots for confidential VMs.  That'd yield a very
> weird API, e.g. non-confidential VMs could be backed entirely by fd-based memslots,
> but confidential VMs would be forced to use hva-based memslots.

It would work if we can treat userspace_addr as optional for
KVM_MEM_FD_VALID, e.g. userspace can opt in to decide whether needing
the mappable part or not for a regular VM and we can enforce KVM for
confidential VMs. But the u64 type of userspace_addr doesn't allow us to
express a 'null' value so sounds like we will end up needing another
flag anyway.

In concept, we could have three cofigurations here:
  1. hva-only: without any flag and use userspace_addr;
  2. fd-only:  another new flag is needed and use fd/offset;
  3. hva/fd mixed: both userspace_addr and fd/offset is effective.
     KVM_MEM_PRIVATE is a subset of it for confidential VMs. Not sure
     regular VM also wants this.

There is no direct relationship between unmappable and fd-based since
even fd-based can also be mappable for regular VM?

> 
> Ignore this idea for now.  If there's an actual use case for generic fd-based memory
> then we'll want a separate flag, fd, and offset, i.e. that support could be added
> independent of KVM_MEM_PRIVATE.

If we ignore this idea now (which I'm also fine), do you still think we
need change KVM_MEM_PRIVATE to KVM_MEM_USER_UNMAPPBLE?

Thanks,
Chao
