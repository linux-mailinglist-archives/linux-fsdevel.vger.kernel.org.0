Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72357A14E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jul 2022 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiGSOXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiGSOXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:23:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B884A827;
        Tue, 19 Jul 2022 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658239668; x=1689775668;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=s/ctDqIUvL1W3W833+ijczZqODZpeij+xtTHe7CbsGA=;
  b=Qpc41EnI47Md+JYEFKBoFHgDbLChp4ozVQ+o3b28x/R7LRwMvjwsTDgZ
   o74z8HXPr2/s27TivsTDCcekUZeFDotpNsrCovlkjf/OJGBCRBMj/d/J3
   JIa1O3jl7FPctWGdzzLAS4M0QgxqmUdseESaRadp3vXN+1WWxu39wpD7O
   Z6Gn4Okss77FqJXdggECtt68zCek1+BB+eB1G4/XkKswq1KDI+5aNUiY0
   Tmi0pPwomgOcV8c2Ns3+b0QMukQOLUWaigT8p4BQimYEWlZvPYwGLmlSa
   r35SH76eDgxkmPPliVOPQeYInyziY35rNKAYCiX1ACCpgTF7PgWssIGbH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="372801075"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="372801075"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="655774698"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2022 07:07:38 -0700
Date:   Tue, 19 Jul 2022 22:02:48 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, kvm@vger.kernel.org,
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
Subject: Re: [PATCH v7 07/14] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <20220719140248.GA84005@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
 <d480a850-601b-cda2-b671-04d839c98429@amd.com>
 <20220718132950.GA38104@chaop.bj.intel.com>
 <YtV7qpYZoT6jIKHQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtV7qpYZoT6jIKHQ@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:26:34PM +0000, Sean Christopherson wrote:
> On Mon, Jul 18, 2022, Chao Peng wrote:
> > On Fri, Jul 15, 2022 at 01:36:15PM +0200, Gupta, Pankaj wrote:
> > > > Currently in mmu_notifier validate path, hva range is recorded and then
> > > > checked in the mmu_notifier_retry_hva() from page fault path. However
> > > > for the to be introduced private memory, a page fault may not have a hva
> > > 
> > > As this patch appeared in v7, just wondering did you see an actual bug
> > > because of it? And not having corresponding 'hva' occurs only with private
> > > memory because its not mapped to host userspace?
> > 
> > The addressed problem is not new in this version, previous versions I
> > also had code to handle it (just in different way). But the problem is:
> > mmu_notifier/memfile_notifier may be in the progress of invalidating a
> > pfn that obtained earlier in the page fault handler, when happens, we
> > should retry the fault. In v6 I used global mmu_notifier_retry() for
> > memfile_notifier but that can block unrelated mmu_notifer invalidation
> > which has hva range specified.
> > 
> > Sean gave a comment at https://lkml.org/lkml/2022/6/17/1001 to separate
> > memfile_notifier from mmu_notifier but during the implementation I
> > realized we actually can reuse the same code for shared and private
> > memory if both using gpa range and that can simplify the code handling
> > in kvm_zap_gfn_range and some other code (e.g. we don't need two
> > versions for memfile_notifier/mmu_notifier).
> 
> This should work, though I'm undecided as to whether or not it's a good idea.  KVM
> allows aliasing multiple gfns to a single hva, and so using the gfn could result
> in a much larger range being rejected given the simplistic algorithm for handling
> multiple ranges in kvm_inc_notifier_count().  But I assume such aliasing is uncommon,
> so I'm not sure it's worth optimizing for.

That can be a real problem for current v7 code, __kvm_handle_hva_range()
loops all possible gfn_range for a given hva_range but the
on_lock/on_unlock is invoked only once, this should work for hva_range,
but not gfn_range since we can have multiple of them.

> 
> > Adding gpa range for private memory invalidation also relieves the
> > above blocking issue between private memory page fault and mmu_notifier.
