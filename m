Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA11397F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgAMRkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 12:40:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMRkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YctpbuGe1IPkhl3jLN2rW9BnsRulU9T+gp+qDp5l7+M=; b=hq1cOaLqGl/JJDil8k6N4fy6C
        bFiOFHmO32SDpWx66UoRRcUKTgNRwGjWExt7N6rhGWChvwOLuiJ0Zqt/cXAWIUqim3YdByFUTa03Q
        HYUJ0Ipqi7ADnpmnmITNqpuk/dIED4MafwlnVzjojRllOvzcisPj1eti2o75wwPtICqWjp1RVgRF3
        tyJ8Az+4hGHnSBRf8GWAaVVGpWWuV4ulNIw2GzqluAmF2hz6m1gGsADjoFbAIIJd565xwb9uRccgD
        ZguPVLuqhvXeUo6ZByObIVthvQEiR+pvmtv6UwoGsC8gi0Oy39QCrHbyaY3AKy4SlxQWb2rQdfp4X
        9tXCv8BPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir3hA-0002Np-V1; Mon, 13 Jan 2020 17:40:08 +0000
Date:   Mon, 13 Jan 2020 09:40:08 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Message-ID: <20200113174008.GB332@bombadil.infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:42:10PM +0000, Chris Mason wrote:
> On 13 Jan 2020, at 10:37, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > I think everybody hates the readpages API.  The fundamental problem 
> > with
> > it is that it passes the pages to be read on a doubly linked list, 
> > using
> > the ->lru list in the struct page.  That means the filesystems have to
> > do the work of calling add_to_page_cache{,_lru,_locked}, and handling
> > failures (because another task is also accessing that chunk of the 
> > file,
> > and so it fails).
> 
> I've always kind of liked the compromise of sending the lists.  It's 
> really good at the common case and doesn't have massive problems when 
> things break down.

I think we'll have to disagree on that point.  Linked lists are awful
for the CPU in the common case, and the error handling code for "things
break down" is painful.  I'm pretty sure I spotted three bugs in the
CIFS implementation.

> Just glancing through the patches, the old 
> readpages is called in bigger chunks, so for massive reads we can do 
> more effective readahead on metadata.  I don't think any of us actually 
> do, but we could.
> 
> With this new operation, our window is constant, and much smaller.
> 
> > The fundamental question is, how do we indicate to the implementation 
> > of
> > ->readahead what pages to operate on?  I've gone with passing a 
> > pagevec.
> > This has the obvious advantage that it's a data structure that already
> > exists and is used within filemap for batches of pages.  I had to add 
> > a
> > bit of new infrastructure to support iterating over the pages in the
> > pagevec, but with that done, it's quite nice.
> >
> > I think the biggest problem is that the size of the pagevec is limited
> > to 15 pages (60kB).  So that'll mean that if the readahead window 
> > bumps
> > all the way up to 256kB, we may end up making 5 BIOs (and merging 
> > them)
> > instead of one.  I'd kind of like to be able to allocate variable 
> > length
> > pagevecs while allowing regular pagevecs to be allocated on the stack,
> > but I can't figure out a way to do that.  eg this doesn't work:
> >
> > -       struct page *pages[PAGEVEC_SIZE];
> > +       union {
> > +               struct page *pages[PAGEVEC_SIZE];
> > +               struct page *_pages[];
> > +       }
> >
> > and if we just allocate them, useful and wonderful tools are going to
> > point out when pages[16] is accessed that we've overstepped the end of
> > the array.
> >
> > I have considered alternatives to the pagevec like just having the
> > ->readahead implementation look up the pages in the i_pages XArray
> > directly.  That didn't work out too well.
> >
> 
> Btrfs basically does this now, honestly iomap isn't that far away.  
> Given how sensible iomap is for this, I'd rather see us pile into that 
> abstraction than try to pass pagevecs for large ranges.  Otherwise, if 
> the lists are awkward we can make some helpers to make it less error 
> prone?

I did do a couple of helpers for lists for iomap before deciding the
whole thing was too painful.  I didn't look at btrfs until just now, but, um ...

int extent_readpages(struct address_space *mapping, struct list_head *pages,
                     unsigned nr_pages)
..
        struct page *pagepool[16];
..
        while (!list_empty(pages)) {
..
                        list_del(&page->lru);
                        if (add_to_page_cache_lru(page, mapping, page->index,
..
                        pagepool[nr++] = page;

you're basically doing exactly what i'm proposing to be the new interface!
OK, you get one extra page per batch ;-P
