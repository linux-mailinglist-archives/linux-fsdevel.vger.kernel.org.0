Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8253B10A1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEAPeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:34:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfEAPeM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:34:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22A71ADD4;
        Wed,  1 May 2019 15:34:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CF7DE1E3BEC; Wed,  1 May 2019 17:34:09 +0200 (CEST)
Date:   Wed, 1 May 2019 17:34:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [GIT PULL] fsnotify fix for v5.1-rc8
Message-ID: <20190501153409.GC6024@quack2.suse.cz>
References: <20190430214149.GA482@quack2.suse.cz>
 <CAHk-=wgn8iEOsT0wwHu4RoZSODb7bRAq5bS59wgZttHbn4gZrg@mail.gmail.com>
 <20190501145228.GB6024@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501145228.GB6024@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-05-19 16:52:28, Jan Kara wrote:
> On Tue 30-04-19 15:10:30, Linus Torvalds wrote:
> > On Tue, Apr 30, 2019 at 2:41 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > to get a fix of user trigerable NULL pointer dereference syzbot has
> > > recently spotted. The problem has been introduced in rc1 so no CC stable is
> > > needed.
> > 
> > Hmm. Pulled, but I thin kthe use of READ_ONCE/WRITE_ONCE is suspicious.
> > 
> > If we're reading a pointer like this locklessly, the proper sequence
> > is almost always something like "smp_store_release()" to write the
> > pointer, and "smp_load_acquire()" to read it.
> > 
> > Because that not only does the "access once" semantics, but it also
> > guarantees that when we actually look _through_ the pointer, we see
> > the data that was written to it. In contrast, code like this (from the
> > fix)
> > 
> > +       WRITE_ONCE(mark->connector, conn);
> > 
> >    ...
> > 
> > +               conn = READ_ONCE(iter_info->marks[type]->connector);
> > +               /* Mark is just getting destroyed or created? */
> > +               if (!conn)
> > +                       continue;
> > +               fsid = conn->fsid;
> > 
> > is rather suspicious, because there's no obvious guarantee that tjhe
> > "conn->fsid" part was written on one CPU before we read it on another.
> 
> Hum, you're right. The WRITE_ONCE(mark->connector, conn) still is not
> enough. It needs to have a barrier so that the connector initialization is
> guaranteed to be visible by RCU reader.
> READ_ONCE(iter_info->marks[type]->connector) is safe as is already contains
> smp_read_barrier_depends() which is all that should be needed once we have
> write barrier before WRITE_ONCE().
> 
> Since I don't think this is a practical problem, I'll just queue the fix
> for the merge window. Thanks for spotting this!

And looking some more into this. I don't think the issue can happen at all.
The thing is that the "connector" gets allocated, initialized, and attached
to inode / mntpoint / sb using cmpxchg() which provides the barrier. Then
mark gets added to connector's list and mark->connector is set. So *mark*
changes happening in fsnotify_add_mark_list() can get reordered (but
there's just list addition there) but *connector* changes are safely
visible. But this certainly deserves a comment as even I got confused and
it was me who wrote this all ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
