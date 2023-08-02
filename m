Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1576D114
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjHBPIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjHBPI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:08:26 -0400
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A52704
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:08:19 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id A8CA3FAE40
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 16:08:17 +0100 (IST)
Received: (qmail 16070 invoked from network); 2 Aug 2023 15:08:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Aug 2023 15:08:17 -0000
Date:   Wed, 2 Aug 2023 16:08:16 +0100
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
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Message-ID: <20230802150816.aaubbx4t7745lqik@techsingularity.net>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-2-david@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:37PM +0200, David Hildenbrand wrote:
> Unfortunately commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
> gup_can_follow_protnone()") missed that follow_page() and
> follow_trans_huge_pmd() never implicitly set FOLL_NUMA because they really
> don't want to fail on PROT_NONE-mapped pages -- either due to NUMA hinting
> or due to inaccessible (PROT_NONE) VMAs.
> 
> As spelled out in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting page
> faults from gup/gup_fast"): "Other follow_page callers like KSM should not
> use FOLL_NUMA, or they would fail to get the pages if they use follow_page
> instead of get_user_pages."
> 
> liubo reported [1] that smaps_rollup results are imprecise, because they
> miss accounting of pages that are mapped PROT_NONE. Further, it's easy
> to reproduce that KSM no longer works on inaccessible VMAs on x86-64,
> because pte_protnone()/pmd_protnone() also indictaes "true" in
> inaccessible VMAs, and follow_page() refuses to return such pages right
> now.
> 
> As KVM really depends on these NUMA hinting faults, removing the
> pte_protnone()/pmd_protnone() handling in GUP code completely is not really
> an option.
> 
> To fix the issues at hand, let's revive FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
> to restore the original behavior for now and add better comments.
> 
> Set FOLL_HONOR_NUMA_FAULT independent of FOLL_FORCE in
> is_valid_gup_args(), to add that flag for all external GUP users.
> 
> Note that there are three GUP-internal __get_user_pages() users that don't
> end up calling is_valid_gup_args() and consequently won't get
> FOLL_HONOR_NUMA_FAULT set.
> 
> 1) get_dump_page(): we really don't want to handle NUMA hinting
>    faults. It specifies FOLL_FORCE and wouldn't have honored NUMA
>    hinting faults already.
> 2) populate_vma_page_range(): we really don't want to handle NUMA hinting
>    faults. It specifies FOLL_FORCE on accessible VMAs, so it wouldn't have
>    honored NUMA hinting faults already.
> 3) faultin_vma_page_range(): we similarly don't want to handle NUMA
>    hinting faults.
> 
> To make the combination of FOLL_FORCE and FOLL_HONOR_NUMA_FAULT work in
> inaccessible VMAs properly, we have to perform VMA accessibility checks in
> gup_can_follow_protnone().
> 
> As GUP-fast should reject such pages either way in
> pte_access_permitted()/pmd_access_permitted() -- for example on x86-64 and
> arm64 that both implement pte_protnone() -- let's just always fallback
> to ordinary GUP when stumbling over pte_protnone()/pmd_protnone().
> 
> As Linus notes [2], honoring NUMA faults might only make sense for
> selected GUP users.
> 
> So we should really see if we can instead let relevant GUP callers specify
> it manually, and not trigger NUMA hinting faults from GUP as default.
> Prepare for that by making FOLL_HONOR_NUMA_FAULT an external GUP flag
> and adding appropriate documenation.
> 
> [1] https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
> [2] https://lore.kernel.org/r/CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com
> 
> Reported-by: liubo <liubo254@huawei.com>
> Closes: https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
> Reported-by: Peter Xu <peterx@redhat.com>
> Closes: https://lore.kernel.org/all/ZMKJjDaqZ7FW0jfe@x1n/
> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I agree that FOLL_REMOTE probably needs separate treatment but also agree
that it's outside the context of this patch, particularly as a -stable
candidate so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

I've a minor nit below that would be nice to get fixed up, but not
mandatory.

> ---
>  include/linux/mm.h       | 21 +++++++++++++++------
>  include/linux/mm_types.h |  9 +++++++++
>  mm/gup.c                 | 29 +++++++++++++++++++++++------
>  mm/huge_memory.c         |  2 +-
>  4 files changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2493ffa10f4b..f463d3004ddc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>  		gup_flags |= FOLL_UNLOCKABLE;
>  	}
>  
> +	/*
> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
> +	 * KVM really require it to benefit from autonuma.
> +	 */
> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
> +
>  	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>  	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
>  			 (FOLL_PIN | FOLL_GET)))

Expand on *why* KVM requires it even though I suspect this changes later
in the series. Maybe "Some GUP users like KVM require the hint to be as
the calling context of GUP is functionally similar to a memory reference
from task context"?

Also minor nit -- s/autonuma/NUMA Balancing/ or numab. autonuma refers to
a specific implementation of automatic balancing that operated similar to
khugepaged but not merged. If you grep for it, you'll find that autonuma
is only referenced in powerpc-specific code. It's not important these
days but very early on, it was very confusing if AutoNUMA was mentioned
when NUMAB was intended.

-- 
Mel Gorman
SUSE Labs
