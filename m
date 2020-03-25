Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A1192C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCYPcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 11:32:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgCYPca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L8UzQwxATOZdjWZ+3tNM04b2mH/5tj4IRSDfIFAnCq4=; b=nwr8fvcCAKrcOHuwe8r/p16lMc
        bZh3DEdAU9aGBWN3F5ynv1Ne93Ij03ZhftdP2p/j/SwKFdDbTLj5/ZaltpVeKwhDVOtZpmt6dBgOM
        Y5kNAkTDyJM9LmxIOgZivD4BtHVK41PC4z2UtEwA8qUzMYjVHQwzjfESuvsJdyTL91AdLqA/lHmDm
        b4ONx8n6tUgKbzMesC9PHNx/tJe345Szba01BQVbNkeQ4aBKyS9/rqkTgJMFlzt5JsbGeTzjBPG19
        tW79XBGQHh8i08Okr8byBxVFG1QH7u5q9rAcay5PaTaRDoWupoIchhUNkRzhk4f/AQVLTP2rNvR7K
        5pnTChzQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH816-0004oZ-U3; Wed, 25 Mar 2020 15:32:28 +0000
Date:   Wed, 25 Mar 2020 08:32:28 -0700
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
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
Message-ID: <20200325153228.GB22483@bombadil.infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
 <20200325120254.GA22483@bombadil.infradead.org>
 <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:43:02PM +0100, Miklos Szeredi wrote:
> >
> > -       while ((page = readahead_page(rac))) {
> > -               if (fuse_readpages_fill(&data, page) != 0)
> > +               nr_pages = min(readahead_count(rac), fc->max_pages);
> 
> Missing fc->max_read clamp.

Yeah, I realised that.  I ended up doing ...

+       unsigned int i, max_pages, nr_pages = 0;
...
+       max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE);

> > +               ia = fuse_io_alloc(NULL, nr_pages);
> > +               if (!ia)
> >                         return;
> > +               ap = &ia->ap;
> > +               __readahead_batch(rac, ap->pages, nr_pages);
> 
> nr_pages = __readahead_batch(...)?

That's the other bug ... this was designed for btrfs which has a fixed-size
buffer.  But you want to dynamically allocate fuse_io_args(), so we need to
figure out the number of pages beforehand, which is a little awkward.  I've
settled on this for the moment:

        for (;;) {
               struct fuse_io_args *ia;
                struct fuse_args_pages *ap;

                nr_pages = readahead_count(rac) - nr_pages;
                if (nr_pages > max_pages)
                        nr_pages = max_pages;
                if (nr_pages == 0)
                        break;
                ia = fuse_io_alloc(NULL, nr_pages);
                if (!ia)
                        return;
                ap = &ia->ap;
                __readahead_batch(rac, ap->pages, nr_pages);
                for (i = 0; i < nr_pages; i++) {
                        fuse_wait_on_page_writeback(inode,
                                                    readahead_index(rac) + i);
                        ap->descs[i].length = PAGE_SIZE;
                }
                ap->num_pages = nr_pages;
                fuse_send_readpages(ia, rac->file);
        }

but I'm not entirely happy with that either.  Pondering better options.

> This will give consecutive pages, right?

readpages() was already being called with consecutive pages.  Several
filesystems had code to cope with the pages being non-consecutive, but
that wasn't how the core code worked; if there was a discontiguity it
would send off the pages that were consecutive and start a new batch.

__readahead_batch() can't return fewer than nr_pages, so you don't need
to check for that.
