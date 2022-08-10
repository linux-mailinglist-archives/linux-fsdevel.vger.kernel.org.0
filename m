Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249C58E997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiHJJ1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiHJJ13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:27:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D146B648;
        Wed, 10 Aug 2022 02:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660123648; x=1691659648;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=tUwaauJkG9H9jpzDjix3eFFhcAHzm8fbdGUPBBoncrI=;
  b=MM/P6jH6MliPsW0XXGQm0jiy++NWrykY/WTFdl9Jc01IEBqiretP+fpQ
   hGaRBEoOnUMsSrlpa429LIp4kagMjmbHkXqdNP0P84rpcs/wph62NHWD9
   bktQIKk8sgWerQVShl45PjvqXGSr/oqob9WglaqCXg4c98TufQXDLATBo
   x9C0jCWj+ez5wC/+mTvfm5XWwbwwlY5nrbjPIW2DeB6iTBzaz3rWjEV6c
   7jig7dUo/O+dreymwVjaqrLVay40KDxh9ROFzZ1p0xycaL7hcD8dFjyz1
   5v/vxjgMEMc3AL7I6FurcDlLHgdgSe2Y/D2lJfcOQAO6uTX8/xx/6KS+j
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="355042407"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="355042407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="664820289"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2022 02:27:17 -0700
Date:   Wed, 10 Aug 2022 17:22:32 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
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
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 03/14] mm: Introduce memfile_notifier
Message-ID: <20220810092232.GC862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
 <13394075-fca0-6f2b-92a2-f1291fcec9a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13394075-fca0-6f2b-92a2-f1291fcec9a3@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:22:58PM +0200, David Hildenbrand wrote:
> On 06.07.22 10:20, Chao Peng wrote:
> > This patch introduces memfile_notifier facility so existing memory file
> > subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
> > third kernel component to make use of memory bookmarked in the memory
> > file and gets notified when the pages in the memory file become
> > invalidated.
> 
> Stupid question, but why is this called "memfile_notifier" and not
> "memfd_notifier". We're only dealing with memfd's after all ... which
> are anonymous files essentially. Or what am I missing? Are there any
> other plans for fs than plain memfd support that I am not aware of?

There were some discussions on this in v3.
  https://lkml.org/lkml/2021/12/28/484
Sean commented it's OK to abstract it from memfd but he also wants the
kAPI (name) should not bind to memfd to make room for future non-memfd
usages.

> 
> > 
> > It will be used for KVM to use a file descriptor as the guest memory
> > backing store and KVM will use this memfile_notifier interface to
> > interact with memory file subsystems. In the future there might be other
> > consumers (e.g. VFIO with encrypted device memory).
> > 
> > It consists below components:
> >  - memfile_backing_store: Each supported memory file subsystem can be
> >    implemented as a memory backing store which bookmarks memory and
> >    provides callbacks for other kernel systems (memfile_notifier
> >    consumers) to interact with.
> >  - memfile_notifier: memfile_notifier consumers defines callbacks and
> >    associate them to a file using memfile_register_notifier().
> >  - memfile_node: A memfile_node is associated with the file (inode) from
> >    the backing store and includes feature flags and a list of registered
> >    memfile_notifier for notifying.
> > 
> > In KVM usages, userspace is in charge of guest memory lifecycle: it first
> > allocates pages in memory backing store and then passes the fd to KVM and
> > lets KVM register memory slot to memory backing store via
> > memfile_register_notifier.
> 
> Can we add documentation/description in any form how the different
> functions exposed in linux/memfile_notifier.h are supposed to be used?

Yeah, code comments can be added.

> 
> Staring at memfile_node_set_flags() and memfile_notifier_invalidate()
> it's not immediately clear to me who's supposed to call that and under
> which conditions.

I will also amend the commit message.

Chao
> 
> -- 
> Thanks,
> 
> David / dhildenb
