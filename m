Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B2411A896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfLKKGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 05:06:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:35976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbfLKKGH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:06:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C549ACB6;
        Wed, 11 Dec 2019 10:06:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6AEA51E0B23; Wed, 11 Dec 2019 11:06:04 +0100 (CET)
Date:   Wed, 11 Dec 2019 11:06:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20191211100604.GL1551@quack2.suse.cz>
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz>
 <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org>
 <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-12-19 22:27:31, Amir Goldstein wrote:
> On Wed, Dec 4, 2019 at 9:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 04, 2019 at 08:37:09PM +0200, Amir Goldstein wrote:
> > > On Wed, Dec 4, 2019 at 7:34 PM Jan Kara <jack@suse.cz> wrote:
> > > > The problem is there's no better reliable way. For example even if fanotify
> > > > event provided a name as in the Amir's commit you reference, this name is
> > > > not very useful. Because by the time your application gets to processing
> > > > that fanotify event, the file under that name need not exist anymore, or
> > >
> > > For DELETE event, file is not expected to exist, the filename in event is
> > > always "reliable" (i.e. this name was unlinked).
> >
> > Jan already pointed out that events may be reordered.  So a CREATE event
> > and DELETE event may arrive out of order for the same file.  This will
> > confuse any agent.
> >
> 
> Right. Re-ordering of events is an issue that needs to be addressed.
> But the truth is that events for the same file are not re-ordered, they
> are merged (though a DELETE_SELF and CREATE could be re-ordered
> because they are not on the same object).

Well, once you start mixing cross-directory rename into the game, things
get even more interesting. Currently, rename events can get reordered
basically arbitrarily against any other operation on that directory because
fsnotify_move() calls happen outside of any locks.

> The way to frame this correctly IMO is that fsnotify events let application
> know that "something has changed", without any ordering guaranty
> beyond "sometime before the event was read".
> 
> So far, that "something" can be a file (by fd), an inode (by fid),
> more specifically a directory inode (by fid) where in an entry has
> changed.
> 
> Adding filename info extends that concept to "something has changed
> in the namespace at" (by parent fid+name).
> All it means is that application should pay attention to that part of
> the namespace and perform a lookup to find out what has changed.
>
> Maybe the way to mitigate wrong assumptions about ordering and
> existence of the filename in the namespace is to omit the event type
> for "filename events", for example: { FAN_CHANGE, pfid, name }.

So this event would effectively mean: In directory pfid, some filename
event has happened with name "name" - i.e. "name" was created (could mean
also mkdir), deleted, moved. Am I right? And the application would then
open_by_handle(2) + open_at(2) + fstat(2) the object pointed to by
(pfid, name) pair and copy whatever it finds to the other end (or delete on
the other end in case of ENOENT)?

After some thought, yes, I think this is difficult to misuse (or infer some
false guarantees out of it). As far as I was thinking it also seems good
enough to implement more efficient syncing of directories. Mohammad, would
this kind of event be enough for your needs? Frankly, I'd like to see a
sample program (say dir-tree-sync) that uses this event before merging the
kernel change so that we can verify that indeed this event is usable for
practical purposes in a race-free way...

> I know that defining a good API is challenging, but I have no doubt
> that the need is real.
> If anyone doubts that, please present an alternative that users can
> actually use.

I agree the need is real when synchronizing large directories. For smaller
directories, readdir + stat is fine but with growing directories this gets
pretty inefficient. btrfs send+receive is actually a nice solution to this
(and is reliable because it is effectively just a comparison of two COW
snapshots - i.e., two static things) but then it has also downsides (in
particular that it is fs specific).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
