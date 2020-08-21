Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6408D24D777
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHUOke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgHUOkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:40:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30FAC061573;
        Fri, 21 Aug 2020 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LPdMepALIKPtCXgUpR/O4dSI8kyy8mXzFAIS6TzWD58=; b=LUBRg+7Dju/SDVaVPmRyIDZXPt
        sHV7tor8YqSQU4L20a1Mxq7JN54SJt3cXVp9X7hDYJaoHBeJv2Hi0iwxnKFoJUnfClZt+agdq9iVz
        AU6LyUSa0spNXc7nidbLD4OJrQc3jwkCWLFYXmfCLm6dvxpxM2zO6YhHW18M/M4R4iXQo+w0sgXHF
        K9M09bw0Jl3vUbxsPs6gthJz3st6lKhVBpNgjTx41SYxVNZrglzoLH3GdmOWHhC/oxlwTbl3e25E1
        JvEuAxZEfxH2VkcoxBWFf7wDxoa+18uAhhb1pku1Cs+TIdNgzXXsRLMI7IyMC3SuedRufWaLOvwt3
        0+s7GnJg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k98DO-0001Xi-02; Fri, 21 Aug 2020 14:40:22 +0000
Date:   Fri, 21 Aug 2020 15:40:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     darrick.wong@oracle.com, david@fromorbit.com, yukuai3@huawei.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Splitting an iomap_page
Message-ID: <20200821144021.GV17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have only bad ideas for solving this problem, so I thought I'd share.

Operations like holepunch or truncate call into
truncate_inode_pages_range() which just remove THPs which are
entirely within the punched range, but pages which contain one or both
ends of the range need to be split.

What I have right now, and works, calls do_invalidatepage() from
truncate_inode_pages_range().  The iomap implementation just calls
iomap_page_release().  We have the page locked, and we've waited for
writeback to finish, so there is no I/O outstanding against the page.
We may then get into one of the writepage methods without an iomap being
allocated, so we have to allocate it.  Patches here:

http://git.infradead.org/users/willy/pagecache.git/commitdiff/167f81e880ef00d83ab7db50d56ed85bfbae2601
http://git.infradead.org/users/willy/pagecache.git/commitdiff/82fe90cde95420c3cf155b54ed66c74d5fb6ffc5

If the page is Uptodate, this works great.  But if it's not, then we're
going to unnecessarily re-read data from storage -- indeed, we may as
well just dump the entire page if it's !Uptodate.  Of course, right now
the only way to get THPs is through readahead and that's going to always
read the entire page, so we're never going to see a !Uptodate THP.  But
in the future, maybe we shall?  I wouldn't like to rely on that without
pasting some big warnings for anyone who tries to change it.

Alternative 1: Allocate a new iop for each base page if needed.  This is
the obvious approach.  If the block size is >= PAGE_SIZE, we don't even
need to allocate a new iop; we can just mark the page as being Uptodate
if that range is.  The problem is that we might need to allocate a lot of
them -- 512 if we're splitting a 2MB page into 4kB chunks (which would
be 12kB -- plus a 2kB array to hold 512 pointers).  And at the point
where we know we need to allocate them, we're under a spin_lock_irq().
We could allocate them in advance, but then we might find out we aren't
going to split this page after all.

Alternative 2: Always allocate an iop for each base page in a THP.  We pay
the allocation price up front for every THP, even though the majority
will never be split.  It does save us from allocating any iop at all for
block size >= page size, but it's a lot of extra overhead to gather all
the Uptodate bits.  As above, it'd be 12kB of iops vs 80 bytes that we
currently allocate for a 2MB THP.  144 once we also track dirty bits.

Alternative 3: Allow pages to share an iop.  Do something like add a
pgoff_t base and a refcount_t to the iop and have each base page point
to the same iop, using the part of the bit array indexed by (page->index
- base) * blocks_per_page.  The read/write count are harder to share,
and I'm not sure I see a way to do it.

Alternative 4: Don't support partially-uptodate THPs.  We declare (and
enforce with strategic assertions) that all THPs must always be Uptodate
(or Error) once unlocked.  If your workload benefits from using THPs,
you want to do big I/Os anyway, so these "write 512 bytes at a time
using O_SYNC" workloads aren't going to use THPs.

Funnily, buffer_heads are easier here.  They just need to be reparented
to their new page.  Of course, they're allocated up front, so they're
essentially alternative 2.

