Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E150176D220
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjHBPgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjHBPfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:35:53 -0400
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 08:35:20 PDT
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76800268D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:35:20 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id DEE5A235D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 16:28:49 +0100 (IST)
Received: (qmail 12428 invoked from network); 2 Aug 2023 15:28:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Aug 2023 15:28:49 -0000
Date:   Wed, 2 Aug 2023 16:28:47 +0100
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
Subject: Re: [PATCH v2 4/8] mm/gup: don't implicitly set FOLL_HONOR_NUMA_FAULT
Message-ID: <20230802152847.c3pz5o4pfsmkuv3u@techsingularity.net>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-5-david@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:40PM +0200, David Hildenbrand wrote:
> Commit 0b9d705297b2 ("mm: numa: Support NUMA hinting page faults from
> gup/gup_fast") from 2012 documented as the primary reason why we would want
> to handle NUMA hinting faults from GUP:
> 
>   KVM secondary MMU page faults will trigger the NUMA hinting page
>   faults through gup_fast -> get_user_pages -> follow_page ->
>   handle_mm_fault.
> 
> That is still the case today, and relevant KVM code has been converted to
> manually set FOLL_HONOR_NUMA_FAULT. So let's stop setting
> FOLL_HONOR_NUMA_FAULT for all GUP users and cross fingers that not that
> many other ones that really require such handling for autonuma remain.
> 
> Possible interaction with MMU notifiers:
> 
>  Assume a driver obtains a page using get_user_pages() to map it into
>  a secondary MMU, and uses the MMU notifier framework to get notified on
>  changes.
> 
>  Assume get_user_pages() succeeded on a PROT_NONE-mapped page (because
>  FOLL_HONOR_NUMA_FAULT is not set) in an accessible VMA and the page is
>  mapped into a secondary MMU. Once user space would turn that mapping
>  inaccessible using mprotect(PROT_NONE), the actual PTE in the page table
>  might not change. If the MMU notifier would be smart and optimize for that
>  case "why notify if the PTE didn't change", that could be problematic.
> 
>  At least change_pmd_range() with MMU_NOTIFY_PROTECTION_VMA for now does an
>  unconditional mmu_notifier_invalidate_range_start() ->
>  mmu_notifier_invalidate_range_end() and should be fine.
> 
>  Note that even if a PTE in an accessible VMA is pte_protnone(), the
>  underlying page might be accessed by a secondary MMU that does not set
>  FOLL_HONOR_NUMA_FAULT, and test_young() MMU notifiers would return "true".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Also seems sane but a large portion of its correctness also depends on
patch 3 being correct.

-- 
Mel Gorman
SUSE Labs
