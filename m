Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69C58E9DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiHJJmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiHJJmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:42:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493B4E62E;
        Wed, 10 Aug 2022 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660124558; x=1691660558;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=qA0d1ma9sBVaq90sMThImxJYL3jWm10WlrkDB0bRLLI=;
  b=VpsHeolrfT1/vhuV9XRwjMznWM1hv7AWaLCMwz+AX0oXIGsxAF4gaVVP
   pg0v+jgbSrW7O+q2+IdXtGwy7L3DiG+CXTws3Yuma2hir5nYxPZ3k4cJi
   SRL6F98kuMy33lG6QnPzjkY9Ipu5mq/78000ZNTiZ1XAdi3KAI8+NW0N0
   oFB1maDuPtdwMj59lAAr/Phx8CTA5UQQHipq206w09hLRYNZIcFtGQTTj
   ra80LR1ktFEGx1lxLFW/vUESBEJHRyKfGRjjStV9Gdla4p8s2zzrnFHbN
   NG+Wj35ipPM29fWvAG1xIJcbek1hejW1PNe7lZTUcHcGnArqewtmfcFXH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291043656"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="291043656"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="601757337"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2022 02:42:27 -0700
Date:   Wed, 10 Aug 2022 17:37:41 +0800
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
Subject: Re: [PATCH v7 05/14] mm/memfd: Introduce MFD_INACCESSIBLE flag
Message-ID: <20220810093741.GE862421@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-6-chao.p.peng@linux.intel.com>
 <203c752f-9439-b5ae-056c-27b2631dcb81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203c752f-9439-b5ae-056c-27b2631dcb81@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 03:28:50PM +0200, David Hildenbrand wrote:
> On 06.07.22 10:20, Chao Peng wrote:
> > Introduce a new memfd_create() flag indicating the content of the
> > created memfd is inaccessible from userspace through ordinary MMU
> > access (e.g., read/write/mmap). However, the file content can be
> > accessed via a different mechanism (e.g. KVM MMU) indirectly.
> > 
> > It provides semantics required for KVM guest private memory support
> > that a file descriptor with this flag set is going to be used as the
> > source of guest memory in confidential computing environments such
> > as Intel TDX/AMD SEV but may not be accessible from host userspace.
> > 
> > The flag can not coexist with MFD_ALLOW_SEALING, future sealing is
> > also impossible for a memfd created with this flag.
> 
> It's kind of weird to have it that way. Why should the user have to
> care? It's the notifier requirement to have that, no?
> 
> Why can't we handle that when register a notifier? If anything is
> already mapped, fail registering the notifier if the notifier has these
> demands. If registering succeeds, block it internally.
> 
> Or what am I missing? We might not need the memfile set flag semantics
> eventually and would not have to expose such a flag to user space.

This makes sense if doable. The major concern was: is there a reliable
way to detect this (already mapped) at the time of memslot registering.

Chao
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
