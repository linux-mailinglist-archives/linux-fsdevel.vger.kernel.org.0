Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0A58E9F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiHJJoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiHJJn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:43:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAA15142E;
        Wed, 10 Aug 2022 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660124636; x=1691660636;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=+g1tHa8U1L0ibLkauTiBh/SeADRVoqwRkL+l6I4l0TE=;
  b=KD5tS2QCDwJMQI8UA4rat5QwIhjZFuhAU3fkbBz2Qopqm39IPmlDXEB7
   kpnEH+pswkbTBg2eWgNhNr6YiMxN3Hp+Qn5rpbdfqH9MMEcci/t6lGxQT
   xBEaXZ4cYPW9Ix3n6fwjfDzTtBt5AuIsy2VULSwPwadzrJN9L4ktKrDPD
   vLlT9hRei/ZdO2r5MvenMBohZmEJH/Jb9YhUNlby2H9SBCNtuhQa6IBPp
   4Q/PUZt5bs+lbyWdpk/MKS33FWmY6c8WmBPO0nsShYhN6LaNW9Dbi/Qbd
   Gs5zBQQ641dkV1su7JsUxg9Wp/F6lsCDV1m8gmeB4VC3Pz9mTXK4/qJG+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289798229"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="289798229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="601757538"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2022 02:43:45 -0700
Date:   Wed, 10 Aug 2022 17:38:59 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
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
Message-ID: <20220810093859.GF862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 07:55:38PM +0200, Paolo Bonzini wrote:
> On 7/21/22 11:44, David Hildenbrand wrote:
> > 
> > Also, I*think*  you can place pages via userfaultfd into shmem. Not
> > sure if that would count "auto alloc", but it would certainly bypass
> > fallocate().
> 
> Yeah, userfaultfd_register would probably have to forbid this for
> F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for this,
> adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then userfault_register
> would do something like memfile_node_get_flags(vma->vm_file) and check the
> result.

Then we need change userfault_register uAPI for a new property flag.
Userspace should still the decision-maker for this flag.

> 
> This means moving this patch later, after "mm: Introduce memfile_notifier".

Yes, it makes sense now.

Chao
> 
> Thanks,
> 
> Paolo
