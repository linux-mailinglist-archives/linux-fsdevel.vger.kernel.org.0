Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FD588A42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 12:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiHCKSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiHCKSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:18:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E0B3C;
        Wed,  3 Aug 2022 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659521882; x=1691057882;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=wFam+LDcRbKILr0ubXYReeOGRVLmWUy4n8feDpXT4KY=;
  b=jixmJUcG97PKX5ZUa28+bVmJitLlvDDyE5XCz7Ngn6Sxs2fCCk346OQh
   /e7FPrzxv/OdN4siefyhkCmDrmkJFuKi1quptgBEu6/s5XmygcajKBJyS
   ZrsivssBk6Q7Shs30NldTHjA62ZsniOd/HXGIDXlrTKGtCc5gAS4ZwvNo
   qo42XvQaBejZVxpSQUtCDI1QrL1sCc3Xo8xti8W/but3T4lGXOid1a2+Z
   es7fB9RoKojXChzirRk7Rdgt+2K7OkYwaS65MVYx5fSlXPS65iNPv2qhQ
   +W/GCziMYhi4xBvRcr6NoRpWxw/cDdJjsMT1swi02fnY9YKHgpQp6glME
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351350449"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="351350449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="631095811"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2022 03:17:51 -0700
Date:   Wed, 3 Aug 2022 18:13:04 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
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
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
Message-ID: <20220803101304.GE607465@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <YuQutJAhKWcsrrYl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQutJAhKWcsrrYl@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 07:02:12PM +0000, Sean Christopherson wrote:
> On Wed, Jul 06, 2022, Chao Peng wrote:
> > The sync mechanism between mmu_notifier and page fault handler employs
> > fields mmu_notifier_seq/count and mmu_notifier_range_start/end. For the
> > to be added private memory, there is the same mechanism needed but not
> > rely on mmu_notifier (It uses new introduced memfile_notifier). This
> > patch renames the existing fields and related helper functions to a
> > neutral name mmu_updating_* so private memory can reuse.
> 
> mmu_updating_* is too broad of a term, e.g. page faults and many other operations
> also update the mmu.  Although the name most definitely came from the mmu_notifier,
> it's not completely inaccurate for other sources, e.g. KVM's MMU is still being
> notified of something, even if the source is not the actual mmu_notifier.
> 
> If we really want a different name, I'd vote for nomenclature that captures the
> invalidation aspect, which is really what the variables are all trackng, e.g.
> 
>   mmu_invalidate_seq
>   mmu_invalidate_in_progress
>   mmu_invalidate_range_start
>   mmu_invalidate_range_end

Looks good to me. Thanks.

Chao
