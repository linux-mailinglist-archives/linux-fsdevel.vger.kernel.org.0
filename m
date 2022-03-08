Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A134D0DA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 02:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbiCHBrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 20:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbiCHBrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:47:06 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D373B2AB;
        Mon,  7 Mar 2022 17:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646703970; x=1678239970;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=mHBCi6qAEBh/nnklYLjjX0eLK1S8y5VX77Z1SPbc3yQ=;
  b=ULmH3UEBLdccUYzQgIXK0dw+/n2E3nyWqtarEdlbrhI/qPGrgDozMej3
   XODS3M2TAfukAkmK28C/7WUE0m1FhZjKGwWOTFcwYncWUriBNuf861Ulf
   iUyHGFEzYSzu3RuSaZoVHJPydGtvyptuDeqiiJV/dHXEEM8dXiCigeN4k
   21t2qgVVI4kp+GcymcBYFJOgQVmLRTk204HJtYUamYpzzVCivVu+UDlse
   GCL/Uk+aGnFehCVIXjUnXei17+5UOF35VCeP4KvKm+F61+qcCCQHVj5Lb
   o4tcvZwbTSsawDGzU0RQ7xla5jUUDx8PeI7/GkFpW4lAUfXrDClF5GKrs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="252132725"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="252132725"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 17:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="495276231"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2022 17:46:02 -0800
Date:   Tue, 8 Mar 2022 09:45:45 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v4 03/12] mm: Introduce memfile_notifier
Message-ID: <20220308014545.GA43625@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-4-chao.p.peng@linux.intel.com>
 <9ac9a88f-54b4-a49f-0857-c3094d3e0d2b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac9a88f-54b4-a49f-0857-c3094d3e0d2b@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 04:42:08PM +0100, Vlastimil Babka wrote:
> On 1/18/22 14:21, Chao Peng wrote:
> > This patch introduces memfile_notifier facility so existing memory file
> > subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
> > third kernel component to make use of memory bookmarked in the memory
> > file and gets notified when the pages in the memory file become
> > allocated/invalidated.
> > 
> > It will be used for KVM to use a file descriptor as the guest memory
> > backing store and KVM will use this memfile_notifier interface to
> > interact with memory file subsystems. In the future there might be other
> > consumers (e.g. VFIO with encrypted device memory).
> > 
> > It consists two sets of callbacks:
> >   - memfile_notifier_ops: callbacks for memory backing store to notify
> >     KVM when memory gets allocated/invalidated.
> >   - memfile_pfn_ops: callbacks for KVM to call into memory backing store
> >     to request memory pages for guest private memory.
> > 
> > Userspace is in charge of guest memory lifecycle: it first allocates
> > pages in memory backing store and then passes the fd to KVM and lets KVM
> > register each memory slot to memory backing store via
> > memfile_register_notifier.
> > 
> > The supported memory backing store should maintain a memfile_notifier list
> > and provide routine for memfile_notifier to get the list head address and
> > memfile_pfn_ops callbacks for memfile_register_notifier. It also should call
> > memfile_notifier_fallocate/memfile_notifier_invalidate when the bookmarked
> > memory gets allocated/invalidated.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Process nitpick:
> Here and in patch 4/12 you have Kirill's S-o-b so there should probably be
> also "From: Kirill ..." as was in v3? Or in case you modified the original
> patches so much to become the primary author, you should add
> "Co-developed-by: Kirill ..." here before his S-o-b.

Thanks. 3/12 is vastly rewritten so the latter case can be applied.
4/12 should keep Kirill as the primary author.

Chao
