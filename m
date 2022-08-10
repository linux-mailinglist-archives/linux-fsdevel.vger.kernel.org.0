Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339758EA00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiHJJps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiHJJpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:45:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D951EAC3;
        Wed, 10 Aug 2022 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660124736; x=1691660736;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=sBavDjNKIFmd2M6Jg3bF8kVDIymkWHMnSEIr5WIN7a0=;
  b=O61/zh9nP1a3NA1MGvroQMtaoN5BFj12Ro1Ly3C9SI+LvvDmhryVaJP2
   CarjfMhP3S2UW8pzfkIzHQX/EkG31FdTc3R+Z8xx694dCplk3YqpOQW4J
   4WWBMeqVCVSOCG3IamVhM36kB761utc/Eer6Jp+NQnCZQQgSmJjmdq2tE
   iGeMt5wqLmDfQmRA9jFKLpQWvtmhDKxRUQ3ccKTlRnEtmlKtecqbp02H0
   SMKVZ70THXKKgFwj59jC7+QeIllAUc1U5rVeufdEZF4WAN9e2j7WGo8k7
   T/jngFph2gS8+E4vFHrqNbjcS6s1SxTCjT7ssgLMSPRW1UlzIpUY8TH5n
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="277983040"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="277983040"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="601757857"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2022 02:45:24 -0700
Date:   Wed, 10 Aug 2022 17:40:39 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20220810094039.GG862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
 <a2b8fa73-4efd-426f-abcd-7975ff9a7101@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b8fa73-4efd-426f-abcd-7975ff9a7101@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 08:06:03PM +0200, David Hildenbrand wrote:
> On 05.08.22 19:55, Paolo Bonzini wrote:
> > On 7/21/22 11:44, David Hildenbrand wrote:
> >>
> >> Also, I*think*  you can place pages via userfaultfd into shmem. Not
> >> sure if that would count "auto alloc", but it would certainly bypass
> >> fallocate().
> > 
> > Yeah, userfaultfd_register would probably have to forbid this for 
> > F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for 
> > this, adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then 
> > userfault_register would do something like 
> > memfile_node_get_flags(vma->vm_file) and check the result.
> 
> An alternative is to simply have the shmem allocation fail in a similar
> way. Maybe it does already, I haven't checked (don't think so).

This sounds a better option. We don't need uAPI changes for
userfault_register uAPI but I guess we will still need a KVM uAPI,
either on the memslot or on the whole VM since Roth said this feature
should be optional because some usages may want to disable it for
performance reason. For details please see discussion:
  https://lkml.org/lkml/2022/6/23/1905

Chao
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
