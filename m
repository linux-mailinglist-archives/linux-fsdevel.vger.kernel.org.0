Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07D1586E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 01:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgBKAsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 19:48:39 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43338 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727546AbgBKAsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:48:39 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4253A3A3735;
        Tue, 11 Feb 2020 11:48:32 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1Jj4-0004Gl-R4; Tue, 11 Feb 2020 11:48:30 +1100
Date:   Tue, 11 Feb 2020 11:48:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org, hch@infradead.org,
        jack@suse.cz, akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/3] vfs: have syncfs() return error when there are
 writeback errors
Message-ID: <20200211004830.GB10737@dread.disaster.area>
References: <20200207170423.377931-1-jlayton@kernel.org>
 <20200207205243.GP20628@dread.disaster.area>
 <20200207212012.7jrivg2bvuvvful5@alap3.anarazel.de>
 <20200210214657.GA10776@dread.disaster.area>
 <20200211000405.5fohxgpt554gmnhu@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211000405.5fohxgpt554gmnhu@alap3.anarazel.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=vNYKtK0NrCcJUg9B7GIA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:04:05PM -0800, Andres Freund wrote:
> Hi,
> 
> (sorry if somebody got this twice)
> 
> David added you, because there's discussion about your notify work
> below.
> 
> On 2020-02-11 08:46:57 +1100, Dave Chinner wrote:
> > On Fri, Feb 07, 2020 at 01:20:12PM -0800, Andres Freund wrote:
> > > Hi,
> > > 
> > > On 2020-02-08 07:52:43 +1100, Dave Chinner wrote:
> > > > On Fri, Feb 07, 2020 at 12:04:20PM -0500, Jeff Layton wrote:
> > > > > You're probably wondering -- Where are v1 and v2 sets?
> > > 
> > > > > The basic idea is to track writeback errors at the superblock level,
> > > > > so that we can quickly and easily check whether something bad happened
> > > > > without having to fsync each file individually. syncfs is then changed
> > > > > to reliably report writeback errors, and a new ioctl is added to allow
> > > > > userland to get at the current errseq_t value w/o having to sync out
> > > > > anything.
> > > > 
> > > > So what, exactly, can userspace do with this error? It has no idea
> > > > at all what file the writeback failure occurred on or even
> > > > what files syncfs() even acted on so there's no obvious error
> > > > recovery that it could perform on reception of such an error.
> > > 
> > > Depends on the application.  For e.g. postgres it'd to be to reset
> > > in-memory contents and perform WAL replay from the last checkpoint.
> > 
> > What happens if a user runs 'sync -f /path/to/postgres/data' instead
> > of postgres? All the writeback errors are consumed at that point by
> > reporting them to the process that ran syncfs()...
> 
> We'd have to keep an fd open from *before* we start durable operations,
> which has a sampled errseq_t from before we rely on seeing errors.
> 
> 
> > > Due to various reasons* it's very hard for us (without major performance
> > > and/or reliability impact) to fully guarantee that by the time we fsync
> > > specific files we do so on an old enough fd to guarantee that we'd see
> > > the an error triggered by background writeback.  But keeping track of
> > > all potential filesystems data resides on (with one fd open permanently
> > > for each) and then syncfs()ing them at checkpoint time is quite doable.
> > 
> > Oh, you have to keep an fd permanently open to every superblock that
> > application holds data on so that errors detected by other users of
> > that filesystem are also reported to the application?
> 
> Right
> 
> Currently it's much worse (you probably now?):

*nod*

> > FWIW, explicit userspace error notifications for data loss events is
> > one of the features that David Howell's generic filesystem
> > notification mechanism is intended to provide.  Hence I'm not sure
> > that there's a huge amount of value in providing a partial solution
> > that only certain applications can use when there's a fully generic
> > mechanism for error notification just around the corner.
> 
> Interesting. I largely missed that work, unfortunately. It's hard to
> keep up with all kernel things, while also maintaining / developing an
> RDBMS :/

It's hard enough trying to keep up with everything as a filesystem
developer... :/

> I assume the last state that includes the superblock layer stuff is at
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications
> whereas there's a newer
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-core
> not including that. There do seem to be some significant changes between
> the two.

ANd they are out of date, anyway, because they are still based on
a mmap'd ring buffer rather than the pipe infrastructure. See this
branch for the latest:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications-pipe-core

It doesn't have all the block/superblock/usb notification
infrastructure in it, just the keyring implementation. No point
reimplementing everything while the core notification mechanism is
still changing...

> 
> As far as I can tell the superblock based stuff does *not* actually
> report any errors yet (contrast to READONLY, EDQUOT). Is the plan here
> to include writeback errors as well? Or just filesystem metadata/journal
> IO?

Right, that part hasn't been implemented yet, though it's repeatedly
mentioned as intended to be supported functionality. It will depend
on the filesystem to what it is going to report, but I would expect
that it will initially be focussed on reporting user data errors
(e.g. writeback errors, block device gone bad data loss reports,
etc). It may not be possible to do anything sane with
metadata/journal IO errors as they typically cause the filesystem to
shutdown.

Of course, a filesystem shutdown is likely to result in a thundering
herd of userspace IO error notifications (think hundreds of GB of
dirty page cache getting EIO errors). Hence individual filesystems
will have to put some thought into how critical filesystem error
notifications are handled.

That said, we likely want userspace notification of metadata IO
errors for our own purposes. e.g. so we can trigger the online
filesystem repair code to start trying to fix whatever went wrong. I
doubt there's much userspace can do with things like "bad freespace
btree block" notifications, whilst the filesystem's online repair
tool can trigger a free space scan and rebuild/repair it without
userspace applications even being aware that we just detected and
corrected a critical metadata corruption....

> I don't think that block layer notifications would be sufficient for an
> individual userspace application's data integrity purposes? For one,
> it'd need to map devices to relevant filesystems afaictl. And there's
> also errors above the block layer.

Block device errors separate notifications to the superblock
notifications. If you want the notification of raw block device
errors, then that's what you listen for. If you want the filesystem
to actually tell you what file and offset that EIO was generated
for, then you'd get that through the superblock notifier, not the
block device notifier...

> Based on skimming the commits in those two trees, I'm not quite sure I
> understand what the permission model will be for accessing the
> notifications will be? Seems anyone, even within a container or
> something, will see blockdev errors from everywhere?  The earlier
> superblock support (I'm not sure I like that name btw, hard to
> understand for us userspace folks), seems to have required exec
> permission, but nothing else.

I'm not really familiar with those details - I've only got all the
"how it fits into the big picture" stuff in my head. Little
implementation details like that :) aren't that important to me -
all I need to know is how the infrastructure interacts with the
kernel filesystem code and whether it provides the functionality we
need to report filesystem errors directly to userspace...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
