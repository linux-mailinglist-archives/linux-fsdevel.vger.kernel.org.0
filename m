Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1779529440F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgJTUmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 16:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgJTUme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603226552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmjO6QniYZl+YplQxqK/hVHiry7M+krWuodsm/yS+i4=;
        b=F99SqyshBCRDsX8/t/NYhCcegTOJ4CSzRgrbqmSOpBsx60rcVDTb4gb98iAim1MAmBsx37
        FtDaTVD0PRjUMYUPWntVrjVhGBFzDbvGNcSN0pR5jm0xEAv5r3A2ImJp4mv7s2abb4ABYY
        Edp5zZg3TtxmcIn/OhG4SbQiiovNL7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-wWQxqmBUPgqxND_VKvgy0w-1; Tue, 20 Oct 2020 16:42:30 -0400
X-MC-Unique: wWQxqmBUPgqxND_VKvgy0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30EEE57053;
        Tue, 20 Oct 2020 20:42:28 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-203.rdu2.redhat.com [10.10.115.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0901219D6C;
        Tue, 20 Oct 2020 20:42:27 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8D580220307; Tue, 20 Oct 2020 16:42:26 -0400 (EDT)
Date:   Tue, 20 Oct 2020 16:42:26 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some
 more lock_page work..)
Message-ID: <20201020204226.GA376497@redhat.com>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
 <20201015151606.GA226448@redhat.com>
 <20201015195526.GC226448@redhat.com>
 <CAHk-=wj0vjx0jzaq5Gha-SmDKc3Hnog5LKX0eJZkudBvEQFAUA@mail.gmail.com>
 <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtAstEo+nYgT81swYZWdziaZP_40QGAXcTORqYwgeWNUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:02:21PM +0200, Miklos Szeredi wrote:
> On Thu, Oct 15, 2020 at 11:22 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Oct 15, 2020 at 12:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > I am wondering how should I fix this issue. Is it enough that I drop
> > > the page lock (but keep the reference) inside the loop. And once copying
> > > from user space is done, acquire page locks for all pages (Attached
> > > a patch below).
> >
> > What is the page lock supposed to protect?
> >
> > Because whatever it protects, dropping the lock drops, and you'd need
> > to re-check whatever the page lock was there for.
> >
> > > Or dropping page lock means that there are no guarantees that this
> > > page did not get written back and removed from address space and
> > > a new page has been placed at same offset. Does that mean I should
> > > instead be looking up page cache again after copying from user
> > > space is done.
> >
> > I don't know why fuse does multiple pages to begin with. Why can't it
> > do whatever it does just one page at a time?
> >
> > But yes, you probably should look the page up again whenever you've
> > unlocked it, because it might have been truncated or whatever.
> >
> > Not that this is purely about unlocking the page, not about "after
> > copying from user space". The iov_iter_copy_from_user_atomic() part is
> > safe - if that takes a page fault, it will just do a partial copy, it
> > won't deadlock.
> >
> > So you can potentially do multiple pages, and keep them all locked,
> > but only as long as the copies are all done with that
> > "from_user_atomic()" case. Which normally works fine, since normal
> > users will write stuff that they just generated, so it will all be
> > there.
> >
> > It's only when that returns zero, and you do the fallback to pre-fault
> > in any data with iov_iter_fault_in_readable() that you need to unlock
> > _all_ pages (and once you do that, I don't see what possible advantage
> > the multi-page array can have).
> >
> > Of course, the way that code is written, it always does the
> > iov_iter_fault_in_readable() for each page - it's not written like
> > some kind of "special case fallback thing".
> 
> This was added by commit ea9b9907b82a ("fuse: implement
> perform_write") in v2.6.26 and remains essentially unchanged, AFAICS.
> So this is an old bug indeed.
> 
> So what is the page lock protecting?   I think not truncation, because
> inode_lock should be sufficient protection.
> 
> What it does after sending a synchronous WRITE and before unlocking
> the pages is set the PG_uptodate flag, but only if the complete page
> was really written, which is what the uptodate flag really says:  this
> page is in sync with the underlying fs.
> 
> So I think the page lock here is trying to protect against concurrent
> reads/faults on not uptodate pages.  I.e. until the WRITE request
> completes it is unknown whether the page was really written or not, so
> any reads must block until this state becomes known.  This logic falls
> down on already cached pages, since they start out uptodate and the
> write does not clear this flag.
> 
> So keeping the pages locked has dubious value: short writes don't seem
> to work correctly anyway. Which means that we can probably just set
> the page uptodate right after filling it from the user buffer, and
> unlock the page immediately.

Hi Miklos,

As you said, for the full page WRITE, we can probably mark it
page uptodate write away and drop page lock (Keep reference and
send WRITE request to fuse server). For the partial page write this will
not work and there seem to be atleast two options.

A. Either we read the page back from disk first and mark it uptodate.

B. Or we keep track of such partial writes and block any further
   reads/readpage/direct_IO on these pages till partial write is
   complete. After that looks like page will be left notuptodate
   in page cache and reader will read it from disk. We are doing
   something similar for tracking writeback requests. It is much
   more complicated though and we probably can design something
   simpler for these writethrough/synchronous writes.

I am assuming that A. will lead to performance penalty for short
random writes. So B might be better from performance point of
view.

Is it worth giving option B a try.

Thanks
Vivek

