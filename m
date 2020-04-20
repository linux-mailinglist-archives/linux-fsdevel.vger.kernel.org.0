Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA491B07DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgDTLnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgDTLnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:43:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFFEC061A0C;
        Mon, 20 Apr 2020 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y3v9H7gulitO+Y85OVNVzldz0TRWO8cQsHtyyEuI5ig=; b=g7JEJ58UfwyeWV04dJy7haqXcR
        FkY7TCFjfydjy7CUKLk2sKTRTGMeWlNvIH6QaFdDcJ6LNamrUKqVtRcrYX13W0QaBjHoZgQRwTrWr
        pFMw6Zh2CU0LWD4TLAEVKbFuQrrB+5ujPnG45zzsqeSt+qZFmCfJvo+ZWZer92aHWA9AX6zXTHxmR
        SZTQ0uswpYDxkQli+e+cy4XXvjLfdwzNe85/eZjU4D+5T9gllu2ggGK4e+wrNS8ioWTjEeUaLiDp9
        BBpgydRU02eR0+H8csye5k3wOpZi5BcrTH2LP3QdS1jLAlgaTQNjvb0utJkJEpp5gVZ/qj8/l1oQZ
        Kc/2zb2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQUpI-0006Jo-4N; Mon, 20 Apr 2020 11:43:00 +0000
Date:   Mon, 20 Apr 2020 04:43:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 24/25] fuse: Convert from readpages to readahead
Message-ID: <20200420114300.GB5820@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-25-willy@infradead.org>
 <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 01:14:17PM +0200, Miklos Szeredi wrote:
> > +       for (;;) {
> > +               struct fuse_io_args *ia;
> > +               struct fuse_args_pages *ap;
> > +
> > +               nr_pages = readahead_count(rac) - nr_pages;
> 
> Hmm.  I see what's going on here, but it's confusing.   Why is
> __readahead_batch() decrementing the readahead count at the start,
> rather than at the end?
> 
> At the very least it needs a comment about why nr_pages is calculated this way.

Because usually that's what we want.  See, for example, fs/mpage.c:

        while ((page = readahead_page(rac))) {
                prefetchw(&page->flags);
                args.page = page;
                args.nr_pages = readahead_count(rac);
                args.bio = do_mpage_readpage(&args);
                put_page(page);
        }

fuse is different because it's trying to allocate for the next batch,
not for the batch we're currently on.

I'm a little annoyed because I posted almost this exact loop here:

https://lore.kernel.org/linux-fsdevel/CAJfpegtrhGamoSqD-3Svfj3-iTdAbfD8TP44H_o+HE+g+CAnCA@mail.gmail.com/

and you said "I think that's fine", modified only by your concern
for it not being obvious that nr_pages couldn't be decremented by
__readahead_batch(), so I modified the loop slightly to assign to
nr_pages.  The part you're now complaining about is unchanged.

> > +               if (nr_pages > max_pages)
> > +                       nr_pages = max_pages;
> > +               if (nr_pages == 0)
> > +                       break;
> > +               ia = fuse_io_alloc(NULL, nr_pages);
> > +               if (!ia)
> > +                       return;
> > +               ap = &ia->ap;
> > +               nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> > +               for (i = 0; i < nr_pages; i++) {
> > +                       fuse_wait_on_page_writeback(inode,
> > +                                                   readahead_index(rac) + i);
> 
> What's wrong with ap->pages[i]->index?  Are we trying to wean off using ->index?

It saves reading from a cacheline?  I wouldn't be surprised if the
compiler hoisted the read from rac->_index to outside the loop and just
iterated from rac->_index to rac->_index + nr_pages.
