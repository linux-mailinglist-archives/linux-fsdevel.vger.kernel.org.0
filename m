Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D834450928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhKOQGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 11:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbhKOQG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:06:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BFC061714;
        Mon, 15 Nov 2021 08:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qkUydK/JEpz1c2gCYWSYemddT0P7Gi6azgiiqazupB4=; b=UuWeihRGHAaodRxfmRwxonWNv4
        BDZIGfo/ORjAo8uV4/sfJfXy1Bi5Px4Tmo/D24gJjyNphP4WA0HBaTVDzxSItgHL7ISKDnGU+BcGH
        q0czvecHi403XDDlHZjKMWdnl5suM9VDeccTmxKVjttW7bkuoPtcUgTPCBUr5pdY4A2BvDbJti8rA
        6Ie8/x6ezNC8u45jfRzA1mWQJBMVjzjydMh1MczP0lNAmGLsBoXqRB3TndFwZDfvz1wrGnHnu51VK
        OGZagW4a3+MP3ULFxJ/sGAGAjqfKLZC17xj3UEclfOJz7k66atZN/UBXV/OzDEDqZWUo4/Q81V7ih
        L2s9sceQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmeS2-005p33-No; Mon, 15 Nov 2021 16:03:22 +0000
Date:   Mon, 15 Nov 2021 16:03:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 04/28] fs: Rename AS_THP_SUPPORT and
 mapping_thp_support
Message-ID: <YZKEyrrH4SjqV8W7@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-5-willy@infradead.org>
 <YYo0L60o7ThqGzlX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYo0L60o7ThqGzlX@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 12:41:19AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 08, 2021 at 04:05:27AM +0000, Matthew Wilcox (Oracle) wrote:
> > These are now indicators of multi-page folio support, not THP support.
> 
> Given that we don't use the large foltio term anywhere else this really
> needs to grow a comment explaining what the flag means.

I think I prefer the term 'large' to 'multi'.  What would you think to
this patch (not on top of any particular branch; just to show the scope
of it ...)

+++ b/include/linux/page-flags.h
@@ -692,7 +692,7 @@ static inline bool folio_test_single(struct folio *folio)
        return !folio_test_head(folio);
 }

-static inline bool folio_test_multi(struct folio *folio)
+static inline bool folio_test_large(struct folio *folio)
 {
        return folio_test_head(folio);
 }
+++ b/mm/filemap.c
@@ -192,9 +192,9 @@ static void filemap_unaccount_folio(struct address_space *mapping,
        __lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
        if (folio_test_swapbacked(folio)) {
                __lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
-               if (folio_test_multi(folio))
+               if (folio_test_large(folio))
                        __lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
-       } else if (folio_test_multi(folio)) {
+       } else if (folio_test_large(folio)) {
                __lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
                filemap_nr_thps_dec(mapping);
        }
@@ -236,7 +236,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
        if (freepage)
                freepage(&folio->page);

-       if (folio_test_multi(folio) && !folio_test_hugetlb(folio)) {
+       if (folio_test_large(folio) && !folio_test_hugetlb(folio)) {
                folio_ref_sub(folio, folio_nr_pages(folio));
                VM_BUG_ON_FOLIO(folio_ref_count(folio) <= 0, folio);
        } else {
+++ b/mm/memcontrol.c
@@ -5558,7 +5558,7 @@ static int mem_cgroup_move_account(struct page *page,

        VM_BUG_ON(from == to);
        VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-       VM_BUG_ON(compound && !folio_test_multi(folio));
+       VM_BUG_ON(compound && !folio_test_large(folio));

        /*
         * Prevent mem_cgroup_migrate() from looking at

