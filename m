Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9904F3AC17E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 05:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhFRDmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFRDmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:42:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA1C061574;
        Thu, 17 Jun 2021 20:40:38 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lu5Ml-009UHM-Ku; Fri, 18 Jun 2021 03:40:23 +0000
Date:   Fri, 18 Jun 2021 03:40:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, jlayton@kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] afs: Fix afs_write_end() to handle short writes
Message-ID: <YMwVp268KTzTf8cN@zeniv-ca.linux.org.uk>
References: <YMdZbsvBNYBtZDC2@casper.infradead.org>
 <162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk>
 <162367682522.460125.5652091227576721609.stgit@warthog.procyon.org.uk>
 <466590.1623677832@warthog.procyon.org.uk>
 <YMddm2P0vD+4edBu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMddm2P0vD+4edBu@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 02:46:03PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 14, 2021 at 02:37:12PM +0100, David Howells wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > >  (1) If the page is not up to date, then we should just return 0
> > > >      (ie. indicating a zero-length copy).  The loop in
> > > >      generic_perform_write() will go around again, possibly breaking up the
> > > >      iterator into discrete chunks.
> > > 
> > > Does this actually work?  What about the situation where you're reading
> > > the last page of a file and thus (almost) always reading fewer bytes
> > > than a PAGE_SIZE?
> > 
> > Al Viro made such a change for Ceph - and we're writing, not reading.
> 
> I'd feel better if you said "xfstests doesn't show any new problems"
> than arguing to authority.
> 
> I know the operation which triggers this path is a call to write(),
> but if, say, the file is 32 bytes long, not in cache, and you write
> bytes 32-63, the client must READ bytes 0-31 from the server, which
> is less than a full page.

[as commented on IRC several days ago]

Short copy has nothing to do with destination; it's about failures on
source - e.g. source page we'd prefaulted before locking the destination
got evicted by the time we got around to copying; we can't afford
page faults while holding some pages locked, so we do it with
pagefault_disable() and get a short copy on #PF.

The story with short copies is this:
	* write() is about to copy the next chunk of data into
page cache of the file we are writing into.  We have decided what
part of the destination page will be copied over, faulted the
source in and locked the destination page.

	* if the page is not uptodate, we might need to read
some parts before copying new data into it; the work that needs
to be done depends upon the part of page we are going to overwrite.
E.g. if we are going to copy over the entire thing, we do
_not_ want to bother reading anything into it - if copying
works, we'll destroy the previous contents anyway.
	That's what ->write_begin() is about - it should
do whatever's needed in preparation to copying new data.

	* NOW we can copy the data.  Hopefully the copy will
be successful (i.e. we don't run into evicted source pages,
memory errors, races with munmap(), etc.), but it might fail
halfway through - we are doing that part with page faults
disabled.

	* finally we can do write to disk/server/whatnot.
That's what ->write_end() is for.  Ideally, it'll just
send the newly copied data on its way.  However, in case of
short copy we might have problems.  Consider e.g. a block
filesystem that has 4 blocks per page; the chunk we were
going to write went from the middle of the 1st to the
middle of the 4th block.  ->write_begin() made sure that
1st and 4th blocks had been uptodate.  It had not bothered
with the 2nd and the 3rd blocks, since we were going to
overwrite them anyway.  And had the copy succeeded, we'd
be fine - page fully uptodate, can write the data to
disk and be done with that.  However, the copy failed
halfway through the 3rd block.  What do we have?
1st block: uptodate, partly old data, partly new one.
2nd block: uptodate, new data
3rd block: beginning is filled with new data, garbage in the rest
4th block: uptodate, old data.
What to do?  Everything up to the beginning of the 3rd block
is fine, but the 3rd one is a hopeless mess.  We can't write it
out - the garbage would end up on disk.  We can't replace the
garbage with valid data without reading it from disk - and that'll
lose the new data we'd managed to copy there.

The best we can do in such situation is to treat that as
having advanced to the beginning of the third block, despite
having copied more than that.  The caller (generic_perform_write())
will choose the next chunk starting at that point (beginning of
the 3rd block) and repeat the whole sequence for that chunk,
including the fault-in.

So ->write_end() gets 3 numbers - two describing the range we
prepared for (what ->write_begin() had received) and the third
telling how much had been actually copied.  Again, "short copy"
here does not refer to any preparations done by ->write_begin() -
it's about having told ->write_begin() we would copy over given
range and only managing to fill a part of that range.

Note that if page is uptodate, we are fine - _everything_
in that page matches what we want in file, so we can deal with
sending it to disk/server/whatnot.  If there'd been a short
copy the caller will obviously need to continue from the point
where the copy stopped, but that's not our problem.

What to do in case of short copy into non-uptodate page is
up to filesystem.  Saying "sod it, I'm not taking any of
that, just repeat the entire thing" is always fine.  We might
do better than that (see above for one such example), but
the caller will be OK if we don't.  It's a rare case, and
you either need something like race with munmap() of part of
source buffer from another thread or severe memory pressure
for that to trigger in the first place.
