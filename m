Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF8213B25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGCNij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 09:38:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCNij (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:38:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE505AEE4;
        Fri,  3 Jul 2020 13:38:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 369EB1E12EB; Fri,  3 Jul 2020 15:38:36 +0200 (CEST)
Date:   Fri, 3 Jul 2020 15:38:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: fsnotify pre-modify VFS hooks (Was: fanotify and LSM path hooks)
Message-ID: <20200703133836.GB21364@quack2.suse.cz>
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz>
 <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz>
 <CAOQ4uxgsJ7NRtFbRYyBj_RW-trysOrUTKUnkYKYR5OMyq-+HXQ@mail.gmail.com>
 <20200630092042.GL26507@quack2.suse.cz>
 <CAOQ4uxjO6Y6js-txx+_tuCx50cDobQpGMHnBe6R5fBA09-4yDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjO6Y6js-txx+_tuCx50cDobQpGMHnBe6R5fBA09-4yDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-06-20 17:28:10, Amir Goldstein wrote:
> On Tue, Jun 30, 2020 at 12:20 PM Jan Kara <jack@suse.cz> wrote:
> > the number of variants you have to introduce and then pass NULL in some
> > places because you don't have the info available and then it's not
> > immediately clear what semantics the event consumers can expect... That
> > would be good to define and then verify in the code.
> >
> 
> I am not sure I understand what you mean.
> Did you mean that mnt_want_write_at() mnt_want_write_path() should be
> actual functions instead of inline wrappers or something else?

Now looking at it, I find mnt_want_write_at2() the most confusing one. Also
the distinction between mnt_want_write_at() and mnt_want_write_path() seems
somewhat arbitrary at the first sight (how do you decide where to use
what?) but there I guess I see where you are coming from...

> > Also given you have the requirement "no fs locks on event generation", I'm
> > not sure how reliable this can be. If you don't hold fs locks when
> > generating event, cannot it happen that actually modified object is
> > different from the reported one because we raced with some other fs
> > operations? And can we prove that? So what exactly is the usecase and
> > guarantees the event needs to provide?
> 
> That's a good question. Answer is not trivial.
> The use case is "persistent change tracking snapshot".
> "snapshot" because it tracks ALL changes since a point in time -
> there is no concept of "consuming" events.

So you want to answer question like: "Which paths changed since given point
in time?" 100% reliably (no false negatives) in a powerfail safe manner? So
effectively something like btrfs send-receive?

> It is important to note that this is complementary to real time fs events.
> A user library may combine the two mechanisms to a stream of changes
> (either recorded or live), but that is out of scope for this effort.
> Also, userspace would likely create periodic snapshots, so that e.g.
> current snapshot records changes, while previous snapshot recorded
> changes are being scanned.
> 
> The concept is to record every dir fid *before* an immediate child or directory
> metadata itself may change, so that after a crash, all recorded dir fids
> may be scanned to search for possibly missed changes.
> 
> The dir fid is stable, so races are not an issue in that respect.
> When name is recorded, change tracking never examines the object at that
> name, it just records the fact that there has been a change at [dir fid;name].
> This is mostly needed to track creates.

You're right that by only tracking dir fids where something changed you've
elliminated most of problems since once we lookup a path, the change is
definitely going to happen in the dir we've looked up. If it really happens
or on which inode in the dir is not determined yet but the dir fid is. I'm
not yet 100% sure how you'll link the dir fids to actual paths on query or
how the handling of leaf dir entries is going to work but it seems possible
:)

> Other than that, races should be handled by the backend itself, so proof is
> pending the completion of the backend POC, but in hand waving:
> - All name changes in the filesystem call the backend before the change
>   (because backend marks sb) and backend is responsible for locking
> against races
> - My current implementation uses overlayfs upper/index as the change
>   track storage, which has the benefit that the test "is change recorded"
>   is implemented by decode_fh and/or name lookup, so it is already very much
>   optimized by inode and dentry cache and shouldn't need any locking for
>   most  pre_modify calls
> - It is also not a coincidence that overlayfs changes to upper fs do not
>   trigger pre_modify hooks because that prevents the feedback loop.
>   I wrote in commit message that "is consistent with the fact that overlayfs
>   sets the FMODE_NONOTIFY flag on underlying open files" - that is needed
>   because the path in underlying files is "fake" (open_with_fake_path()).
> 
> If any of this hand waving sounds terribly wrong please let me know.
> Otherwise I will report back after POC is complete with a example backend.

It sounds like it could work :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
