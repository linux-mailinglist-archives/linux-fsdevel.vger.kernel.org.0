Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7903D6681
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhGZR2W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 13:28:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhGZR2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:28:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8688121F57;
        Mon, 26 Jul 2021 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627322929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ooMmTsOY2gNSdfmmjqC+o292JgqAW44JXDUL2PUxUU=;
        b=Y/f1xVuJXbK+9SbvAGZ9W03R/HJAPEpd1VRFTpT5+CHNgW8bhEugDtXKp722ApYTdOoUoD
        f4BmZIsTGUTDII1LMuhWV4gy6dtwGggrYn7RWY2gs+zpbE5rWE9nXaNIK2eWsT8Z8tSVJS
        Lwv+13u68aZExOA69dKOyEKm4FgY6Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627322929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ooMmTsOY2gNSdfmmjqC+o292JgqAW44JXDUL2PUxUU=;
        b=2y/yLCZEFwo052F8+K2ZLEK3WpSezqABSEfhXpne5+nh1n/pe5VI2TaPIsZ0EisAZZ0Tk4
        YJ/Ug4L7m9+TIADA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2EF7DA3B81;
        Mon, 26 Jul 2021 18:08:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 064B31E3B13; Mon, 26 Jul 2021 20:08:48 +0200 (CEST)
Date:   Mon, 26 Jul 2021 20:08:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 5/7] iomap: Support restarting direct I/O requests
 after user copy failures
Message-ID: <20210726180847.GO20621@quack2.suse.cz>
References: <20210723205840.299280-1-agruenba@redhat.com>
 <20210723205840.299280-6-agruenba@redhat.com>
 <20210726171940.GM20621@quack2.suse.cz>
 <CAHpGcMLtQ1=WOT1mTUS4=iWBwHLQ-EBzY=+XuSGJfu4gVPYTLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMLtQ1=WOT1mTUS4=iWBwHLQ-EBzY=+XuSGJfu4gVPYTLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-07-21 19:45:22, Andreas Grünbacher wrote:
> Jan Kara <jack@suse.cz> schrieb am Mo., 26. Juli 2021, 19:21:
> 
> > On Fri 23-07-21 22:58:38, Andreas Gruenbacher wrote:
> > > In __iomap_dio_rw, when iomap_apply returns an -EFAULT error, complete
> > the
> > > request synchronously and reset the iterator to the start position.  This
> > > allows callers to deal with the failure and retry the operation.
> > >
> > > In gfs2, we need to disable page faults while we're holding glocks to
> > prevent
> > > deadlocks.  This patch is the minimum solution I could find to make
> > > iomap_dio_rw work with page faults disabled.  It's still expensive
> > because any
> > > I/O that was carried out before hitting -EFAULT needs to be retried.
> > >
> > > A possible improvement would be to add an IOMAP_DIO_FAULT_RETRY or
> > similar flag
> > > that would allow iomap_dio_rw to return a short result when hitting
> > -EFAULT.
> > > Callers could then retry only the rest of the request after dealing with
> > the
> > > page fault.
> > >
> > > Asynchronous requests turn into synchronous requests up to the point of
> > the
> > > page fault in any case, but they could be retried asynchronously after
> > dealing
> > > with the page fault.  To make that work, the completion notification
> > would have
> > > to include the bytes read or written before the page fault(s) as well,
> > and we'd
> > > need an additional iomap_dio_rw argument for that.
> > >
> > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > ---
> > >  fs/iomap/direct-io.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index cc0b4bc8861b..b0a494211bb4 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -561,6 +561,15 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter
> > *iter,
> > >               ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
> > >                               iomap_dio_actor);
> > >               if (ret <= 0) {
> > > +                     if (ret == -EFAULT) {
> > > +                             /*
> > > +                              * To allow retrying the request, fail
> > > +                              * synchronously and reset the iterator.
> > > +                              */
> > > +                             wait_for_completion = true;
> > > +                             iov_iter_revert(dio->submit.iter,
> > dio->size);
> > > +                     }
> > > +
> >
> > Hum, OK, but this means that if userspace submits large enough write, GFS2
> > will livelock trying to complete it? While other filesystems can just
> > submit multiple smaller bios constructed in iomap_apply() (paging in
> > different parts of the buffer) and thus complete the write?
> >
> 
> No. First, this affects reads but not writes. We cannot just blindly repeat
> writes; when a page fault occurs in the middle of a write, the result will
> be a short write. For reads, the plan is to ads a flag to allow
> iomap_dio_rw to return a partial result when a page fault occurs.
> (Currently, it fails the entire request.) Then we can handle the page fault
> and complete the rest of the request.
> 
> The changes needed for that are simple on the iomap side, but we need to go
> through some gymnastics for handling the page fault without giving up the
> glock in the non-contended case. There will still be the potential for
> losing the lock and having to re-acquire it, in which case we'll actually
> have to repeat the entire read.

I've missed you've already sent out v4 (I'm catching up after vacation so
my mailbox is a bit of a mess). What's in there addresses my objection.
I'm sorry for the noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
