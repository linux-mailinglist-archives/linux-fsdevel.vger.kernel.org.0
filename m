Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C01260ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLSLga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 06:36:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:47452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfLSLga (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:36:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E560ACA7;
        Thu, 19 Dec 2019 11:36:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B5711E0B38; Thu, 19 Dec 2019 12:36:20 +0100 (CET)
Date:   Thu, 19 Dec 2019 12:36:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: RFC: Page cache coherency in dio write path (was: [LSF/MM/BPF
 TOPIC] Bcachefs update)
Message-ID: <20191219113620.GB24349@quack2.suse.cz>
References: <20191216193852.GA8664@kmo-pixel>
 <20191218124052.GB19387@quack2.suse.cz>
 <20191218191114.GA1731524@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218191114.GA1731524@moria.home.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-12-19 14:11:14, Kent Overstreet wrote:
> On Wed, Dec 18, 2019 at 01:40:52PM +0100, Jan Kara wrote:
> > On Mon 16-12-19 14:38:52, Kent Overstreet wrote:
> > > Pagecache consistency:
> > > 
> > > I recently got rid of my pagecache add lock; that added locking to core paths in
> > > filemap.c and some found my locking scheme to be distastefull (and I never liked
> > > it enough to argue). I've recently switched to something closer to XFS's locking
> > > scheme (top of the IO paths); however, I do still need one patch to the
> > > get_user_pages() path to avoid deadlock via recursive page fault - patch is
> > > below:
> > > 
> > > (This would probably be better done as a new argument to get_user_pages(); I
> > > didn't do it that way initially because the patch would have been _much_
> > > bigger.)
> > > 
> > > Yee haw.
> > > 
> > > commit 20ebb1f34cc9a532a675a43b5bd48d1705477816
> > > Author: Kent Overstreet <kent.overstreet@gmail.com>
> > > Date:   Wed Oct 16 15:03:50 2019 -0400
> > > 
> > >     mm: Add a mechanism to disable faults for a specific mapping
> > >     
> > >     This will be used to prevent a nasty cache coherency issue for O_DIRECT
> > >     writes; O_DIRECT writes need to shoot down the range of the page cache
> > >     corresponding to the part of the file being written to - but, if the
> > >     file is mapped in, userspace can pass in an address in that mapping to
> > >     pwrite(), causing those pages to be faulted back into the page cache
> > >     in get_user_pages().
> > >     
> > >     Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > I'm not really sure about the exact nature of the deadlock since the
> > changelog doesn't explain it but if you need to take some lockA in your
> > page fault path and you already hold lockA in your DIO code, then this
> > patch isn't going to cut it. Just think of a malicious scheme with two
> > tasks one doing DIO from fileA (protected by lockA) to buffers mapped from
> > fileB and the other process the other way around...
> 
> Ooh, yeah, good catch...
> 
> The lock in question is - for the purposes of this discussion, a RW lock (call
> it map lock here): the fault handler and the buffered IO paths take it it read
> mode, and the DIO path takes it in write mode to block new pages being added to
> the page cache.
> 
> But get_user_pages() -> page fault invokes the fault handler, hence
> deadlock. My patch was for avoiding this deadlock when the fault handler
> tries locking the same inode's map lock, but as you note this is a more
> general problem...
> 
> This is starting to smell like possibly what wound/wait mutexes were
> invented for, a situation where we need deadlock avoidance because lock
> ordering is under userspace control.
> 
> So for that we need some state describing what locks are held that we can
> refer to when taking the next lock of this class - and since it's got to
> be shared between the dio write path and then (via gup()) the fault
> handler, that means it's pretty much going to have to hang off of task
> struct. Then in the fault handler, when we go to take the map lock we:
>  - return -EFAULT if it's the same lock the dio write path took
>  - trylock; if that fails and lock ordering is wrong (pointer comparison of the
>    locks works here) then we have to do a dance that involves bailing out and
>    retrying from the top of the dio write path.

Well, I don't think the problem is actually limited to your "map lock".
Because by calling get_user_pages() from under "map lock" in DIO code, you
create for example "map lock" (inode A) -> mmap_sem (process P) lock
dependency. And when you do page fault, you create mmap_sem (process Q) ->
"map lock" (inode B) lock dependency. It does not take that much effort to
chain these in a way that will deadlock the system.

And the lock tracking that would be able to detect such locking cycles
would IMHO be too expensive as it would have to cover multiple different
rather hot locks and also be coordinated between multiple processes.

> I dunno. On the plus side, if other filesystems don't want this I think
> this can all be implemented in bcachefs code with only a pointer added to
> task_struct to hang this lock state, but I would much rather either get
> buy in from the other filesystem people and make this a general purpose
> facility or not do it at all.
> 
> And I'm not sure if anyone else cares about the page cache consistency
> issues inherent to dio writes as much as I do... so I'd like to hear from
> other people on that.

I don't think other filesystems care much about DIO cache coherency. But
OTOH I do agree that these page-fault vs DIO vs buffered IO page cache
handling races are making life difficult even for other filesystems because
it is not just about DIO cache coherency but in some nasty corner cases
also about stale data exposure or filesystem corruption. And filesystems
have to jump through the hoops to avoid them. So I think in general people
are interested in somehow making the situation simpler - for example I
think it would simplify life for Dave's range lock he is working on for
XFS...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
