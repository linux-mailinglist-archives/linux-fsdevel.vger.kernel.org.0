Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C7C592F67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbiHONJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHONJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:09:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FCE1A050;
        Mon, 15 Aug 2022 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660568948; x=1692104948;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=uC6wcjTIjKWZdEEUC6nc6q/QLuQ42xa9S3mFqSAWmAc=;
  b=D7z1M7k05lfgk/4oNMiHl6lR0EEZWjiK78uYc0+ltrFjyA/mNld6zARG
   k7ZgsdkTCNGGjsnJr9RofIHSyuCJkl7M7ioTOZqbHuDVBMdnw8Rx83D58
   DyB1YNE9SkEX4soApUwcFZLdY4JfrN6g1kl16OIBGm5A3pD+z0ZfpBocw
   bvXfl/EDl4g45w/YWmRLpPVQFHBTkQXlKcrJ3vNGrmXWiEYXP/YkKNGmT
   mYMWjiCJJM0rVu5H5VPiCYJfhfK0BsqykWt6WjqS2Gh6NEEAtNb+1KpZz
   49OTVE0IsSIQYsZgXwN3+vm3VGJwRolVvb4SzGaU7FgsLfpy9/h9mDlWX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="317937105"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="317937105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 06:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="635470742"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2022 06:08:56 -0700
Date:   Mon, 15 Aug 2022 21:04:11 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220815130411.GA1073443@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <b21f41e5-0322-bbfb-b9c2-db102488592d@amd.com>
 <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:18:43PM +0530, Nikunj A. Dadhania wrote:
> 
> 
> On 12/08/22 12:48, Gupta, Pankaj wrote:
> > 
> >>>>>>
> >>>>>> However, fallocate() preallocates full guest memory before starting the guest.
> >>>>>> With this behaviour guest memory is *not* demand pinned. Is there a way to
> >>>>>> prevent fallocate() from reserving full guest memory?
> >>>>>
> >>>>> Isn't the pinning being handled by the corresponding host memory backend with mmu > notifier and architecture support while doing the memory operations e.g page> migration and swapping/reclaim (not supported currently AFAIU). But yes, we need> to allocate entire guest memory with the new flags MEMFILE_F_{UNMOVABLE, UNRECLAIMABLE etc}.
> >>>>
> >>>> That is correct, but the question is when does the memory allocated, as these flags are set,
> >>>> memory is neither moved nor reclaimed. In current scenario, if I start a 32GB guest, all 32GB is
> >>>> allocated.
> >>>
> >>> I guess so if guest memory is private by default.
> >>>
> >>> Other option would be to allocate memory as shared by default and
> >>> handle on demand allocation and RMPUPDATE with page state change event. But still that would be done at guest boot time, IIUC.
> >>
> >> Sorry! Don't want to hijack the other thread so replying here.
> >>
> >> I thought the question is for SEV SNP. For SEV, maybe the hypercall with the page state information can be used to allocate memory as we use it or something like quota based memory allocation (just thinking).
> > 
> > But all this would have considerable performance overhead (if by default memory is shared) and used mostly at boot time. 
> 
> > So, preallocating memory (default memory private) seems better approach for both SEV & SEV SNP with later page management (pinning, reclaim) taken care by host memory backend & architecture together.
> 
> I am not sure how will pre-allocating memory help, even if guest would not use full memory it will be pre-allocated. Which if I understand correctly is not expected.

Actually the current version allows you to delay the allocation to a
later time (e.g. page fault time) if you don't call fallocate() on the
private fd. fallocate() is necessary in previous versions because we
treat the existense in the fd as 'private' but in this version we track
private/shared info in KVM so we don't rely on that fact from memory
backstores.

Definitely the page will still be pinned once it's allocated, there is
no way to swap it out for example just with the current code. That kind
of support, if desirable, can be extended through MOVABLE flag and some
other callbacks to let feature-specific code to involve.

Chao
> 
> Regards
> Nikunj
