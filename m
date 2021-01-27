Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73C8305148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhA0EqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhA0DCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED296C061788;
        Tue, 26 Jan 2021 19:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KInmekppXEkYTPkrUjL8o9RUj8TT2e5M46gGzwoDGjQ=; b=hSF/WDFxslXz5B1CInRT4vI+g0
        c047ULVTL+DpBc9p8nMfkZcwdcZjsLy4nAZrdmmyjsyycw2ycuvWRqu4Il/Vyjgz5Qb/APv7H5WBI
        amjhcuwn3hZUi6aVlMViCUIarFns3Z7vm0tJvJCsEI5ld4Of/y9Sk/EaBmZMUzM8LjnerN5ulLbcI
        4vX8h8f2/AfEqj/FlKySh5QJQXyAPrv/4JVnJRvjwJs0DEfgPGXA32JGm44+DZ6w7ByllS2v5EfzI
        aVc4VpIiZW2scWlTRQcaJ6Fdsvc1UpZb/Y2uHpSm1mzLOYn9Xs6QIrQ0kCjxpS4uesY0jmItitDiY
        iKSDB6EQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4b3C-006YDA-SR; Wed, 27 Jan 2021 02:59:31 +0000
Date:   Wed, 27 Jan 2021 02:59:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v4] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-ID: <20210127025922.GS308988@casper.infradead.org>
References: <cover.1611642038.git.cgoldswo@codeaurora.org>
 <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
 <YBCexclveGV2KH1G@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCexclveGV2KH1G@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 02:59:17PM -0800, Minchan Kim wrote:
> The release buffer_head in LRU is great improvement for migration
> point of view.
> 
> A question: 
> 
> Can't we invalidate(e.g., invalidate_bh_lrus) bh_lru in migrate_prep or
> elsewhere when migration found the failure and is about to retry?
> 
> Migration has done such a way for other per-cpu stuffs for a long time,
> which would be more consistent with others and might be faster sometimes
> with reducing IPI calls for page.

Should lru_add_drain_all() also handle draining the buffer lru for all
callers?  A quick survey ...

invalidate_bdev() already calls invalidate_bh_lrus()
compact_nodes() would probably benefit from the BH LRU being invalidated
POSIX_FADV_DONTNEED would benefit if the underlying filesystem uses BHs
check_and_migrate_cma_pages() would benefit
khugepaged_do_scan() doesn't need it today
scan_get_next_rmap_item() looks like it only works on anon pages (?) so
	doesn't need it
mem_cgroup_force_empty() probably needs it
mem_cgroup_move_charge() ditto
memfd_wait_for_pins() doesn't need it
shake_page() might benefit
offline_pages() would benefit
alloc_contig_range() would benefit

Seems like most would benefit and a few won't care.  I think I'd lean
towards having lru_add_drain_all() call invalidate_bh_lrus(), just to
simplify things.
