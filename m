Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606EE76D222
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjHBPgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjHBPfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:35:54 -0400
Received: from outbound-smtp43.blacknight.com (outbound-smtp43.blacknight.com [46.22.139.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62433C24
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:35:20 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp43.blacknight.com (Postfix) with ESMTPS id 92B0B2236
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 16:16:15 +0100 (IST)
Received: (qmail 9455 invoked from network); 2 Aug 2023 15:16:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Aug 2023 15:16:15 -0000
Date:   Wed, 2 Aug 2023 16:16:13 +0100
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
Subject: Re: [PATCH v2 2/8] smaps: use vm_normal_page_pmd() instead of
 follow_trans_huge_pmd()
Message-ID: <20230802151613.3nyg3xof3gyovlxu@techsingularity.net>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-3-david@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:38PM +0200, David Hildenbrand wrote:
> We shouldn't be using a GUP-internal helper if it can be avoided.
> 
> Similar to smaps_pte_entry() that uses vm_normal_page(), let's use
> vm_normal_page_pmd() that similarly refuses to return the huge zeropage.
> 
> In contrast to follow_trans_huge_pmd(), vm_normal_page_pmd():
> 
> (1) Will always return the head page, not a tail page of a THP.
> 
>  If we'd ever call smaps_account with a tail page while setting "compound
>  = true", we could be in trouble, because smaps_account() would look at
>  the memmap of unrelated pages.
> 
>  If we're unlucky, that memmap does not exist at all. Before we removed
>  PG_doublemap, we could have triggered something similar as in
>  commit 24d7275ce279 ("fs/proc: task_mmu.c: don't read mapcount for
>  migration entry").
> 
>  This can theoretically happen ever since commit ff9f47f6f00c ("mm: proc:
>  smaps_rollup: do not stall write attempts on mmap_lock"):
> 
>   (a) We're in show_smaps_rollup() and processed a VMA
>   (b) We release the mmap lock in show_smaps_rollup() because it is
>       contended
>   (c) We merged that VMA with another VMA
>   (d) We collapsed a THP in that merged VMA at that position
> 
>  If the end address of the original VMA falls into the middle of a THP
>  area, we would call smap_gather_stats() with a start address that falls
>  into a PMD-mapped THP. It's probably very rare to trigger when not
>  really forced.
> 
> (2) Will succeed on a is_pci_p2pdma_page(), like vm_normal_page()
> 
>  Treat such PMDs here just like smaps_pte_entry() would treat such PTEs.
>  If such pages would be anonymous, we most certainly would want to
>  account them.
> 
> (3) Will skip over pmd_devmap(), like vm_normal_page() for pte_devmap()
> 
>  As noted in vm_normal_page(), that is only for handling legacy ZONE_DEVICE
>  pages. So just like smaps_pte_entry(), we'll now also ignore such PMD
>  entries.
> 
>  Especially, follow_pmd_mask() never ends up calling
>  follow_trans_huge_pmd() on pmd_devmap(). Instead it calls
>  follow_devmap_pmd() -- which will fail if neither FOLL_GET nor FOLL_PIN
>  is set.
> 
>  So skipping pmd_devmap() pages seems to be the right thing to do.
> 
> (4) Will properly handle VM_MIXEDMAP/VM_PFNMAP, like vm_normal_page()
> 
>  We won't be returning a memmap that should be ignored by core-mm, or
>  worse, a memmap that does not even exist. Note that while
>  walk_page_range() will skip VM_PFNMAP mappings, walk_page_vma() won't.
> 
>  Most probably this case doesn't currently really happen on the PMD level,
>  otherwise we'd already be able to trigger kernel crashes when reading
>  smaps / smaps_rollup.
> 
> So most probably only (1) is relevant in practice as of now, but could only
> cause trouble in extreme corner cases.
> 
> Fixes: ff9f47f6f00c ("mm: proc: smaps_rollup: do not stall write attempts on mmap_lock")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Maybe move the follow_trans_huge_pmd() declaration from linux/huge_mm.h
to mm/internal.h to discourage future mistakes? Otherwise

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
