Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833F1B1B6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUBxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 21:53:14 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51870 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbgDUBxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:53:14 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 85D3E58BAA2;
        Tue, 21 Apr 2020 11:53:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jQi61-0007b5-Dv; Tue, 21 Apr 2020 11:53:09 +1000
Date:   Tue, 21 Apr 2020 11:53:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
Message-ID: <20200421015309.GA27860@dread.disaster.area>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
 <20200419232046.GC9765@dread.disaster.area>
 <20200420003025.GZ5820@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420003025.GZ5820@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=TbtYE95lTQodrqKYD-cA:9 a=yr81cdKRjUySGoIo:21 a=X33s6ejLKMF8arWw:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 05:30:25PM -0700, Matthew Wilcox wrote:
> On Mon, Apr 20, 2020 at 09:20:46AM +1000, Dave Chinner wrote:
> > On Sat, Apr 18, 2020 at 08:14:43PM -0700, Matthew Wilcox wrote:
> > > On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
> > > > When reading md code, I find md-bitmap.c copies __clear_page_buffers from
> > > > buffer.c, and after more search, seems there are some places in fs could
> > > > use this function directly. So this patchset tries to export the function
> > > > and use it to cleanup code.
> > > 
> > > OK, I see why you did this, but there are a couple of problems with it.
> > > 
> > > One is just a sequencing problem; between exporting __clear_page_buffers()
> > > and removing it from the md code, the md code won't build.
> > > 
> > > More seriously, most of this code has nothing to do with buffers.  It
> > > uses page->private for its own purposes.
> > > 
> > > What I would do instead is add:
> > > 
> > > clear_page_private(struct page *page)
> > > {
> > > 	ClearPagePrivate(page);
> > > 	set_page_private(page, 0);
> > > 	put_page(page);
> > > }
> > > 
> > > to include/linux/mm.h, then convert all callers of __clear_page_buffers()
> > > to call that instead.
> > 
> > While I think this is the right direction, I don't like the lack of
> > symmetry between set_page_private() and clear_page_private() this
> > creates.  i.e. set_page_private() just assigned page->private, while
> > clear_page_private clears both a page flag and page->private, and it
> > also drops a page reference, too.
> > 
> > Anyone expecting to use set/clear_page_private as a matched pair (as
> > the names suggest they are) is in for a horrible surprise...
> > 
> > This is a public service message brought to you by the Department
> > of We Really Suck At API Design.
> 
> Oh, blast.  I hadn't noticed that.  And we're horribly inconsistent
> with how we use set_page_private() too -- rb_alloc_aux_page() doesn't
> increment the page's refcount, for example.
> 
> So, new (pair of) names:
> 
> set_fs_page_private()
> clear_fs_page_private()

Except set_fs() is already used for something else entirely, so now
we have the same prefix having completely different meanings.

Naming is hard.

Realistically, we want these interfaces for use cases where we have
an external object we store in page->private, right? That's an
unsigned long, not a pointer, so we have to cast page->private for
this sort of use. So, yes, I'd definitely like to see:

> since it really seems like it's only page cache pages which need to
> follow the rules about setting PagePrivate and incrementing the refcount.
> Also, I think I'd like to see them take/return a void *:

This sort of API cleanup.

> void *set_fs_page_private(struct page *page, void *data)
> {
> 	get_page(page);
> 	set_page_private(page, (unsigned long)data);
> 	SetPagePrivate(page);
> 	return data;
> }
> 
> void *clear_fs_page_private(struct page *page)
> {
> 	void *data = (void *)page_private(page);
> 
> 	if (!PagePrivate(page))
> 		return NULL;
> 	ClearPagePrivate(page);
> 	set_page_private(page, 0);
> 	put_page(page);
> 	return data;
> }

I think we need a page_private() variant that returns a void *
rather than having to cast it everywhere we directly access the
private pointer. i.e. The API becomes:

page_get_private_ptr()		- replaces page_private()
page_set_private_ptr()		- replaces set_page_private()
page_clear_private_ptr()	- replaces clear_page_private()

> That makes iomap simpler:
> 
>  static void
>  iomap_page_release(struct page *page)
>  {
> -	struct iomap_page *iop = to_iomap_page(page);
> +	struct iomap_page *iop = clear_fs_page_private(page);
> 
>  	if (!iop)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_count));
>  	WARN_ON_ONCE(atomic_read(&iop->write_count));
> -	ClearPagePrivate(page);
> -	set_page_private(page, 0);
> -	put_page(page);
>  	kfree(iop);
>  }

*nod*

Much nicers :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
