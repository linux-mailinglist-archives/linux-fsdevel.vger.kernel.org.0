Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042BA24E5CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 08:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgHVGG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 02:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVGG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:06:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5451C061573;
        Fri, 21 Aug 2020 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rguNHvh6bim75mcF3k7vPor/ululkyldZg3PQC54Ho4=; b=SOovbYFaTWd9jsdqgjd4Jq3A2J
        2SZ3Pz4NKpVrwfAa+g6oPkFfF2n5NMqo1CZs56uv8LnTOAT5/Z0VUl1RtYgP69nh8xzVPcdKNTK71
        SxolTnvYhHwbuMobewVkhpJZWgumDYWoHf4gDBi+f/Y72MGt9/osvQhRNN7cNSEOIiQduhV/kZA0V
        YJicFZNpsWjy0TcIG1mv/KZ9vFmuSom/HpR/w60c6Ye9c4XHpc+1kmeuJqtTH4kfhveHEvNt1mGHe
        VGWXiZ269P9tzHOlkuQmDr6OFdkMsp2hHZX1o2IE2tcYnBekq477FRyFV/tQV4SlUKRfh6/9YQ2eG
        uiadUBLQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9MfS-00054o-Gu; Sat, 22 Aug 2020 06:06:18 +0000
Date:   Sat, 22 Aug 2020 07:06:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        david@fromorbit.com, yukuai3@huawei.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Splitting an iomap_page
Message-ID: <20200822060618.GE17129@infradead.org>
References: <20200821144021.GV17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821144021.GV17456@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 03:40:21PM +0100, Matthew Wilcox wrote:
> I have only bad ideas for solving this problem, so I thought I'd share.
> 
> Operations like holepunch or truncate call into
> truncate_inode_pages_range() which just remove THPs which are
> entirely within the punched range, but pages which contain one or both
> ends of the range need to be split.
> 
> What I have right now, and works, calls do_invalidatepage() from
> truncate_inode_pages_range().  The iomap implementation just calls
> iomap_page_release().  We have the page locked, and we've waited for
> writeback to finish, so there is no I/O outstanding against the page.
> We may then get into one of the writepage methods without an iomap being
> allocated, so we have to allocate it.  Patches here:
> 
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/167f81e880ef00d83ab7db50d56ed85bfbae2601
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/82fe90cde95420c3cf155b54ed66c74d5fb6ffc5
> 
> If the page is Uptodate, this works great.  But if it's not, then we're
> going to unnecessarily re-read data from storage -- indeed, we may as
> well just dump the entire page if it's !Uptodate.  Of course, right now
> the only way to get THPs is through readahead and that's going to always
> read the entire page, so we're never going to see a !Uptodate THP.  But
> in the future, maybe we shall?  I wouldn't like to rely on that without
> pasting some big warnings for anyone who tries to change it.
> 
> Alternative 1: Allocate a new iop for each base page if needed.  This is
> the obvious approach.  If the block size is >= PAGE_SIZE, we don't even
> need to allocate a new iop; we can just mark the page as being Uptodate
> if that range is.  The problem is that we might need to allocate a lot of
> them -- 512 if we're splitting a 2MB page into 4kB chunks (which would
> be 12kB -- plus a 2kB array to hold 512 pointers).  And at the point
> where we know we need to allocate them, we're under a spin_lock_irq().
> We could allocate them in advance, but then we might find out we aren't
> going to split this page after all.
> 
> Alternative 2: Always allocate an iop for each base page in a THP.  We pay
> the allocation price up front for every THP, even though the majority
> will never be split.  It does save us from allocating any iop at all for
> block size >= page size, but it's a lot of extra overhead to gather all
> the Uptodate bits.  As above, it'd be 12kB of iops vs 80 bytes that we
> currently allocate for a 2MB THP.  144 once we also track dirty bits.
> 
> Alternative 3: Allow pages to share an iop.  Do something like add a
> pgoff_t base and a refcount_t to the iop and have each base page point
> to the same iop, using the part of the bit array indexed by (page->index
> - base) * blocks_per_page.  The read/write count are harder to share,
> and I'm not sure I see a way to do it.
> 
> Alternative 4: Don't support partially-uptodate THPs.  We declare (and
> enforce with strategic assertions) that all THPs must always be Uptodate
> (or Error) once unlocked.  If your workload benefits from using THPs,
> you want to do big I/Os anyway, so these "write 512 bytes at a time
> using O_SYNC" workloads aren't going to use THPs.
> 
> Funnily, buffer_heads are easier here.  They just need to be reparented
> to their new page.  Of course, they're allocated up front, so they're
> essentially alternative 2.

At least initially I'd go for 4.  And then see if someone screams loudly
enough to reconsider.  And if we really have to I wonder if we can do
a variation of variant 1 where we avoid allocating under the irqs
disabled spinlock by a clever retry trick.
