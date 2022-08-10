Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C958E87D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiHJIO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiHJIOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:14:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB08E82FB0;
        Wed, 10 Aug 2022 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660119264; x=1691655264;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=E0g83rEnLU+9yWmv16RmjNOqjZtTTbUeUZHLBrUwL7c=;
  b=guxSelHBZKvw3kWVu/PCc2t6nE6juFIi4qwHX13ikjX+U2vzSL7ehNwQ
   iZ56Y/JiluVIoCZKWlSCWZnABIj6gtD8q5GFLdon8AgWCQGkfkNKWp/lj
   X4vs1jdOWAOxegPhqdl/OEsi/Xdz5SgCxtn5zsS5iBUYE3fPop5mqUfIz
   Mnqtz4S07twlw8f3ssrOndCjTfvgXWJeiaiy9ih122V8GCkK1NIhVBD3H
   bpktsn2c/WxQJ9Yav+3JofMpabCVWWeVWGiApuA2Zay3EWr5u3HzzLh0D
   7/KXCJyil3cmpjv+fkcSDu6JKfPsdYXl8JwhYRlNx/z2IVqQC6I0wG8am
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291816766"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="291816766"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 01:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="601736291"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2022 01:14:11 -0700
Date:   Wed, 10 Aug 2022 16:09:25 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20220810080925.GA862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <YuQutJAhKWcsrrYl@google.com>
 <ec3fe997-37d8-22b5-65f1-72f08a16474f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3fe997-37d8-22b5-65f1-72f08a16474f@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 09:54:35PM +0200, Paolo Bonzini wrote:
> On 7/29/22 21:02, Sean Christopherson wrote:
> > If we really want a different name, I'd vote for nomenclature that captures the
> > invalidation aspect, which is really what the variables are all trackng, e.g.
> > 
> >    mmu_invalidate_seq
> >    mmu_invalidate_in_progress
> >    mmu_invalidate_range_start
> >    mmu_invalidate_range_end
> > 
> 
> Agreed, and this can of course be committed separately if Chao Peng sends it
> outside this series.

I will do that, probably also includes:
  06/14 KVM: Rename KVM_PRIVATE_MEM_SLOT

Chao
> 
> Paolo
