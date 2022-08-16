Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5546F595BB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 14:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiHPMWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiHPMWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:22:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4CA25C68;
        Tue, 16 Aug 2022 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660652525; x=1692188525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3uUd/yG6wpuTb/aR5iTfAme30Qm6tQlD5VU32Fh/CI=;
  b=Tifp/ISUfjpNRaPP/CY94u94leOZ91YRfJkuv3BDszBornbMs5Q6XRQ7
   Ixcw0xfxSGlJ1Jg0hiYU0p5uFCXRilB6YP1Oef6lmkw0edqQbDB88Z1Zk
   92hPzlG/ufTn1JT3E+1Bor79jl97sbJHqhdZcxEGuqk0Z1IAVbJxaAgBF
   8TkLB0HHACBU+bOr/uWseGqjadJawZfkVjkgEF0OV/8Hm9kAqrgBq7FeF
   TucuT2O8paNDEBJxQExyYRDVCGdFPd1jsimk54wcpS0qKHTZDzhCHAQ47
   lhhOfV7Q2m5H6OH4cSsSeil9POTww0F/BnV3p9UUmF5ySbm27HvydlkBK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289773234"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="289773234"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:22:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="675194031"
Received: from damianos-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:21:54 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4FB31104A4E; Tue, 16 Aug 2022 15:24:57 +0300 (+03)
Date:   Tue, 16 Aug 2022 15:24:57 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220816122457.2fjyd4uz5hp5cani@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
 <20220815130411.GA1073443@chaop.bj.intel.com>
 <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:33:00PM +0200, Gupta, Pankaj wrote:
> Hi Chao,
> 
> > 
> > Actually the current version allows you to delay the allocation to a
> > later time (e.g. page fault time) if you don't call fallocate() on the
> > private fd. fallocate() is necessary in previous versions because we
> > treat the existense in the fd as 'private' but in this version we track
> > private/shared info in KVM so we don't rely on that fact from memory
> > backstores.
> 
> Does this also mean reservation of guest physical memory with secure
> processor (both for SEV-SNP & TDX) will also happen at page fault time?
> 
> Do we plan to keep it this way?

If you are talking about accepting memory by the guest, it is initiated by
the guest and has nothing to do with page fault time vs fallocate()
allocation of host memory. I mean acceptance happens after host memory
allocation but they are not in lockstep, acceptance can happen much later.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
