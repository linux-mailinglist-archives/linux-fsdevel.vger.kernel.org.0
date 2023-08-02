Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD376D1F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHBP3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjHBP3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:29:14 -0400
Received: from outbound-smtp51.blacknight.com (outbound-smtp51.blacknight.com [46.22.136.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059B30C4
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:27:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id 49103FAE4A
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 16:27:04 +0100 (IST)
Received: (qmail 2300 invoked from network); 2 Aug 2023 15:27:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Aug 2023 15:27:04 -0000
Date:   Wed, 2 Aug 2023 16:27:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/8] kvm: explicitly set FOLL_HONOR_NUMA_FAULT in
 hva_to_pfn_slow()
Message-ID: <20230802152702.wamtroy3zm7nbtvs@techsingularity.net>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-4-david@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:39PM +0200, David Hildenbrand wrote:
> KVM is *the* case we know that really wants to honor NUMA hinting falls.
> As we want to stop setting FOLL_HONOR_NUMA_FAULT implicitly, set
> FOLL_HONOR_NUMA_FAULT whenever we might obtain pages on behalf of a VCPU
> to map them into a secondary MMU, and add a comment why.
> 
> Do that unconditionally in hva_to_pfn_slow() when calling
> get_user_pages_unlocked().
> 
> kvmppc_book3s_instantiate_page(), hva_to_pfn_fast() and
> gfn_to_page_many_atomic() are similarly used to map pages into a
> secondary MMU. However, FOLL_WRITE and get_user_page_fast_only() always
> implicitly honor NUMA hinting faults -- as documented for
> FOLL_HONOR_NUMA_FAULT -- so we can limit this change to a single location
> for now.
> 
> Don't set it in check_user_page_hwpoison(), where we really only want to
> check if the mapped page is HW-poisoned.
> 
> We won't set it for other KVM users of get_user_pages()/pin_user_pages()
> * arch/powerpc/kvm/book3s_64_mmu_hv.c: not used to map pages into a
>   secondary MMU.
> * arch/powerpc/kvm/e500_mmu.c: only used on shared TLB pages with userspace
> * arch/s390/kvm/*: s390x only supports a single NUMA node either way
> * arch/x86/kvm/svm/sev.c: not used to map pages into a secondary MMU.
> 
> This is a preparation for making FOLL_HONOR_NUMA_FAULT no longer
> implicitly be set by get_user_pages() and friends.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Seems sane but I don't know KVM well enough to know if this is the only
relevant case so didn't ack.

-- 
Mel Gorman
SUSE Labs
