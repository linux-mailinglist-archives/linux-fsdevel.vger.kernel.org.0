Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840CE3B67D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhF1Rnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbhF1Rnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:43:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730CC061574;
        Mon, 28 Jun 2021 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dcbgj49559dFb30xLAo+op+AaQ7fzXSGkaSKIYswv5s=; b=Vqna+kA64tPSKm37aRwZhck3Qb
        t/QQ62Hqprfj9O/PRbHRacQt53JzjdmS+gN+0SL1vnfY7QpScl3ij2gy2S8FMQPwYhAIQGxavjqB3
        lwizkiNHmohpaz3reb9UPa8SpCRC0kl6OCSJTTRr5Nb+c8/416xltIilEW+yDrT2X/IHFiU2HSS++
        k88TYRX4SAsaupDtTcLzsobUcU5O29lq8CXoBiRNM2PSzVHqYJm0kfjmUeZc4nR4Wx3hGXZHt7+X2
        XS1Df8dWGftEzLnzemLf3knp35VjybyO7uqEqqHBh+8jxKrJciesVLcZmTBFPtKGOkJPddGY17zHJ
        TtbO+QyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxvDx-003IPs-Gk; Mon, 28 Jun 2021 17:39:20 +0000
Date:   Mon, 28 Jun 2021 18:39:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YNoJPZ4NWiqok/by@casper.infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628172727.1894503-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 07:27:25PM +0200, Andreas Gruenbacher wrote:
> (1) In iomap_readpage_actor, an iomap_page is attached to the page even
> for inline inodes.  This is unnecessary because inline inodes don't need
> iomap_page objects.  That alone wouldn't cause any real issues, but when
> iomap_read_inline_data copies the inline data into the page, it sets the
> PageUptodate flag without setting iop->uptodate, causing an
> inconsistency between the two.  This will trigger a WARN_ON in
> iomap_page_release.  The fix should be not to allocate iomap_page
> objects when reading from inline inodes (patch 1).

I don't have a problem with this patch.

> (2) When un-inlining an inode, we must allocate a page with an attached
> iomap_page object (iomap_page_create) and initialize the iop->uptodate
> bitmap (iomap_set_range_uptodate).  We can't currently do that because
> iomap_page_create and iomap_set_range_uptodate are not exported.  That
> could be fixed by exporting those functions, or by implementing an
> additional helper as in patch 2.  Which of the two would you prefer?

Not hugely happy with either of these options, tbh.  I'd rather we apply
a patch akin to this one (plucked from the folio tree), so won't apply:

@@ -1305,7 +1311,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
                struct writeback_control *wbc, struct inode *inode,
                struct folio *folio, loff_t end_pos)
 {
-       struct iomap_page *iop = to_iomap_page(folio);
+       struct iomap_page *iop = iomap_page_create(inode, folio);
        struct iomap_ioend *ioend, *next;
        unsigned len = i_blocksize(inode);
        unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1313,7 +1319,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
        int error = 0, count = 0, i;
        LIST_HEAD(submit_list);

-       WARN_ON_ONCE(nblocks > 1 && !iop);
        WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);

        /*

so permit pages without an iop to enter writeback and create an iop
*then*.  Would that solve your problem?

> (3) We're not yet using iomap_page_mkwrite, so iomap_page objects don't
> get created on .page_mkwrite, either.  Part of the reason is that
> iomap_page_mkwrite locks the page and then calls into the filesystem for
> uninlining and for allocating backing blocks.  This conflicts with the
> gfs2 locking order: on gfs2, transactions must be started before locking
> any pages.  We can fix that by calling iomap_page_create from
> gfs2_page_mkwrite, or by doing the uninlining and allocations before
> calling iomap_page_mkwrite.  I've implemented option 2 for now; see
> here:

I think this might also solve this problem?
