Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADF8BD5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfHMPkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:40:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfHMPkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OYU/HgkyfhyZl1cUBQoMtKQZrCgqca13pWHrNaZboaw=; b=QG2hllValJs13QOZD2xHzPN/6
        zCAWcSIJBEWBawhrY0iAvWDHm+YzkkWqnaKrZ2yGkvfK/YYxfm06X5QhcGJPCFBK7Tl2fJXdA70Lj
        UACtrfBIsLS5n2P4qO+/L7Id/VWYVHcEh/GIWx+NDMVvp0VoX+wefYKRUsS4AnSWUp4qXEjNWuswf
        D4mzy8YTAXrlbvPUAEwsNn8T+t1ssz5K3HMo5r8itfjsP8uKR/I09uYTGKqRwVSvaa3arH3xcz9uk
        tjxmDb9zYUn5FmJCNxgp3fV3Xc5paG69yY/8igiB6CFOzHv/jN6SvF2I3QYbWzTBTKuEkPcHrH3FB
        91fysjeCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxYuA-0002VR-GK; Tue, 13 Aug 2019 15:40:10 +0000
Date:   Tue, 13 Aug 2019 08:40:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190813154010.GD5307@bombadil.infradead.org>
References: <20190813151434.GQ7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813151434.GQ7138@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:14:34AM -0700, Darrick J. Wong wrote:
> +		/*
> +		 * Now that we've locked both pages, make sure they still
> +		 * represent the data we're interested in.  If not, someone
> +		 * is invalidating pages on us and we lose.
> +		 */
> +		if (src_page->mapping != src->i_mapping ||
> +		    src_page->index != srcoff >> PAGE_SHIFT ||
> +		    dest_page->mapping != dest->i_mapping ||
> +		    dest_page->index != destoff >> PAGE_SHIFT) {
> +			same = false;
> +			goto unlock;
> +		}

It is my understanding that you don't need to check the ->index here.
If I'm wrong about that, I'd really appreciate being corrected, because
the page cache locking is subtle.

You call read_mapping_page() which returns the page with an elevated
refcount.  That means the page can't go back to the page allocator and
be allocated again.  It can, because it's unlocked, still be truncated,
so the check for ->mapping after locking it is needed.  But the check
for ->index being correct was done by find_get_entry().

See pagecache_get_page() -- if we specify FGP_LOCK, then it will lock
the page, check the ->mapping but not check ->index.  OK, it does check
->index, but in a VM_BUG_ON(), so it's not something that ought to be
able to be wrong.

