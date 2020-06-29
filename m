Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346D220E488
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbgF2V0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgF2Smr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:47 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD28C033C38
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 11:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y0krb9teudPRh5wBThYONBp+1hvAAJWXWz0XE5GFT9Y=; b=IheCnqGzszyfBG86ok2ZvWBYOt
        uQMOPI4vVNjzvMifEYAB/3bKNeFPOnGr4lq2DU6UYO93BrtWmTfWpHVMQ5fermTIFfIJBzve4te3Z
        CCYIgLLFDNKyIbFD2Q6yRGzLYXBSMYV8CHkazRz2u/8gPL2s24+jUqmL9VXC4ZREJsA7gHJHB2eMF
        ro9hbMP1BAllUkZ0JMXqlHO0kHR5ws2pt1fX1OZHbPU6NcexDlrLCliadfQCbkfoPBcjMVx674xUa
        KAkhH5j55dtucl4ktjQlkGEB7pxQ03xTKZb1Kpv13gkP6o6W5SYd/8MdcOS4p6U2T7zGH7i4i4vdf
        5mC+lQBw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyZw-0006St-Dm; Mon, 29 Jun 2020 18:32:28 +0000
Date:   Mon, 29 Jun 2020 19:32:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/7] mm: Replace hpage_nr_pages with thp_nr_pages
Message-ID: <20200629183228.GH25523@casper.infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-6-willy@infradead.org>
 <8bf5ae79-eace-5345-1a77-69d9e2e083b3@oracle.com>
 <20200629181440.GG25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629181440.GG25523@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:14:40PM +0100, Matthew Wilcox wrote:
> Thank you!  Clearly I wasn't thinking about this patch and just did a
> mindless search-and-replace!  I should evaluate the other places where
> I did this and see if any of them are wrong too.

add_page_to_lru_list() and friends -- safe.  hugetlbfs doesn't use the
  LRU lists.
find_subpage() -- safe.  hugetlbfs has already returned by this point.
readahead_page() and friends -- safe.  hugetlbfs doesn't readahead.
isolate_migratepages_block() -- probably safe.  I don't think hugetlbfs
  pages are migratable, and it calls del_page_from_lru_list(), so I
  infer hugetlbfs doesn't reach this point.
unaccount_page_cache_page() -- safe.  hugetlbfs has already returned by
  this point.
check_and_migrate_cma_pages() -- CMA pages aren't hugetlbfs pages.
mlock_migrate_page() -- not used for hugetlbfs.
mem_cgroup_move_account() mem_cgroup_charge() mem_cgroup_migrate()
mem_cgroup_swapout() mem_cgroup_try_charge_swap() -- I don't think
  memory cgroups control hugetlbfs pages.
do_migrate_range() -- explicitly not in the hugetlb arm of this if
  statement
migrate_page_add() -- Assumes LRU
putback_movable_pages() -- Also LRU
expected_page_refs() migrate_page_move_mapping() copy_huge_page()
unmap_and_move() add_page_for_migration() numamigrate_isolate_page()
  -- more page migration
mlock.c: This is all related to being on the LRU list
page_io.c: We don't swap out hugetlbfs pages
pfn_is_match() -- Already returned from this function for hugetlbfs pages
do_page_add_anon_rmap() page_add_new_anon_rmap() rmap_walk_anon()
  -- hugetlbfs pages aren't anon.
rmap_walk_file() -- This one I'm unsure about.  There's explicit
  support for hugetlbfs elsewhere in the file, and maybe this is never
  called for hugetlb pages.  Help?
swap.c, swap_state.c, swapfile.c: No swap for hugetlbfs pages.
vmscan.c: hugetlbfs pages not on the LRUs
workingset.c: hugetlbfs pages not on the LRUs

So I think you found the only bug of this type, although I'm a little
unsure about the rmap_walk_file().
