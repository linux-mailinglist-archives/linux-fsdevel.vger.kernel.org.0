Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5845025A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhKOK0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 05:26:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhKOK0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:26:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC7B71FD66;
        Mon, 15 Nov 2021 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636971814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPUumuPVustUG2HDLbAv8GjadAS91qycCHNjWd9B11g=;
        b=YJvS76exNWyEE2EpdzzPd5Htv0q2IHn52LB2gGLxg99UseYLFhtTWHNfzBHJ1o3sxh/jmk
        a8X0Tj8KP46KQxFIIf181JMu4soBAeaYSptxYLiFqvPvdr5YMAkCm0B9X6QyqdfUg8vdDM
        hWT+2ZxpZ/a8clJF0lNfoy7WQEqOyIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636971814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPUumuPVustUG2HDLbAv8GjadAS91qycCHNjWd9B11g=;
        b=y79pZQVc6NwH+NPJEpT/2JF8Xu3jLwbVizqIpK988FO/o4etkqEfg5Y5U68DojS0djyRue
        Rv4WvqtrTu8JsCDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id ADF2AA3B87;
        Mon, 15 Nov 2021 10:23:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 36E851E0C01; Mon, 15 Nov 2021 11:23:30 +0100 (CET)
Date:   Mon, 15 Nov 2021 11:23:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
Message-ID: <20211115102330.GC23412@quack2.suse.cz>
References: <20211029114028.569755-1-amir73il@gmail.com>
 <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz>
 <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 13-11-21 21:31:25, Amir Goldstein wrote:
> On Sat, Nov 13, 2021 at 11:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 6:39 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi Amir!
> > >
> > > On Sat 06-11-21 18:29:39, Amir Goldstein wrote:
> > > > On Fri, Oct 29, 2021 at 2:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > This patch set follows up on the discussion on FAN_REPORT_TARGET_FID [1]
> > > > > from 3 months ago.
> > > > >
> > > > > With FAN_REPORT_PIDFD in 5.15 and FAN_FS_ERROR on its way to 5.16,
> > > > > I figured we could get an early (re)start of the discussion on
> > > > > FAN_REPORT_TARGET_FID towards 5.17.
> > > > >
> > > > > The added information in dirent events solves problems for my use case -
> > > > > It helps getting the following information in a race free manner:
> > > > > 1. fid of a created directory on mkdir
> > > > > 2. from/to path information on rename of non-dir
> > > > >
> > > > > I realize those are two different API traits, but they are close enough
> > > > > so I preferred not to clutter the REPORT flags space any further than it
> > > > > already is. The single added flag FAN_REPORT_TARGET_FID adds:
> > > > > 1. child fid info to CREATE/DELETE/MOVED_* events
> > > > > 2. new parent+name info to MOVED_FROM event
> > > > >
> > > > > Instead of going the "inotify way" and trying to join the MOVED_FROM/
> > > > > MOVED_TO events using a cookie, I chose to incorporate the new
> > > > > parent+name intomation only in the MOVED_FROM event.
> > > > > I made this choice for several reasons:
> > > > > 1. Availability of the moved dentry in the hook and event data
> > > > > 2. First info record is the old parent+name, like FAN_REPORT_DFID_NAME
> > > > > 3. Unlike, MOVED_TO, MOVED_FROM was useless for applications that use
> > > > >    DFID_NAME info to statat(2) the object as we suggested
> > > > >
> > > > > I chose to reduce testing complexity and require all other FID
> > > > > flags with FAN_REPORT_TARGET_FID and there is a convenience
> > > > > macro FAN_REPORT_ALL_FIDS that application can use.
> > > >
> > > > Self comment - Don't use ALL_ for macro names in uapi...
> > > > There are 3 comment of "Deprecated ..."  for ALL flags in fanotify.h alone...
> > >
> > > Yeah, probably the ALL_FIDS is not worth the possible confusion when we add
> > > another FID flag later ;)
> > >
> > > > BTW, I did not mention the FAN_RENAME event alternative proposal in this posting
> > > > not because I object to FAN_RENAME, just because it was simpler to implement
> > > > the MOVED_FROM alternative, so I thought I'll start with this proposal
> > > > and see how
> > > > it goes.
> > >
> > > I've read through all the patches and I didn't find anything wrong.
> > > Thinking about FAN_RENAME proposal - essentially fsnotify_move() would call
> > > fsnotify_name() once more with FS_RENAME event and we'd gate addition of
> > > second dir+name info just by FS_RENAME instead of FS_MOVED_FROM &&
> > > FAN_REPORT_TARGET_FID. Otherwise everything would be the same as in the
> > > current patch set, wouldn't it? IMHO it looks like a bit cleaner API so I'd
> > > lean a bit more towards that.
> >
> > I grew to like FAN_RENAME better myself as well.
> > To make sure we are talking about the same thing:
> > 1. FAN_RENAME always reports 2*(dirfid+name)
> > 2. FAN_REPORT_TARGET_FID adds optional child fid record to
> >     CREATE/DELETE/RENAME/MOVED_TO/FROM
> >

Correct, that's what I meant.

> Err, I tried the FAN_RENAME approach and hit a semantic issue:
> Users can watch a directory inode and get only MOVED_FROM
> when entries are moved from this directory. Same for MOVED_TO.
> How would FAN_RENAME behave when setting FAN_RENAME on a directory inode?
> Should listeners get events on files renamed in and out of that
> directory?
> 
> I see several options:
> 1. Go back to FAN_MOVED_FROM as in this patch set, where semantics are clear

Well, semantics are clear but in principle user does not have access to
target dir either so the permission problems are the same as with option 2,
aren't they?

> 2. Report FAN_RENAME if either old or new dir is watched (or mount/sb)
> 3. Report FAN_RENAME only if both old and new dirs are watched (or mount/sb)
> 
> For option 2, we may need to hide information records, For example,
> because an unprivileged listener may not have access to old or new
> directory.

Good spotting. That can indeed be a problem.

> A variant of option 3, is that FAN_RENAME will be an event mask flag
> that can be added to FAN_MOVE events, to request that if both FROM/TO events
> are going to be reported, then a single joint event will be reported
> instead, e.g:
> 
> #define FAN_MOVE (FAN_MOVED_FROM | FAN_MOVED_TO)
> #define FAN_RENAME (FAN_MOVE | __FAN_MOVE_JOIN)
> 
> Instead of generating an extra FS_RENAME event in fsnotify_move(),
> fsnotify() will search for matching marks on the moved->d_parent->d_inode
> of MOVED_FROM event add the mark as the FSNOTIFY_OBJ_TYPE_PARENT
> mark iterator type and then fanotify_group_event_mask() will be able
> to tell if the
> event should be reported as FAN_MOVED_FROM, FAN_MOVED_TO or a joint
> FAN_RENAME.
> 
> If a group has the FAN_RENAME mask on the new parent dir, then
> FS_MOVED_TO events can be dropped, because the event was already
> reported as FAN_MOVED_TO or FAN_RENAME with the FS_MOVED_FROM
> event.
> 
> Am I over complicating this?
> Do you have a better and clearer semantics to propose?

So from API POV I like most keeping FAN_RENAME separate from FAN_MOVED_TO &
FAN_MOVED_FROM. It would be generated whenever source or target is tagged
with FAN_RENAME, source info is provided if source is tagged, target info
is provided when target is tagged (both are provides when both are tagged).
So it is kind of like FAN_MOVED_FROM | FAN_MOVED_TO but with guaranteed
merging. This looks like a clean enough and simple to explain API. Sure it
duplicates FAN_MOVED_FROM & FAN_MOVED_TO a lot but I think the simplicity
of the API outweights the duplication. Basically FAN_MOVED_FROM &
FAN_MOVED_TO could be deprecated with this semantics of FAN_RENAME although
I don't think we want to do it for compatibility reasons.

Implementation-wise we have couple of options. Currently the simplest I can
see is that fsnotify() would iterate marks on both source & target dirs
(like we already do for inode & parent) when it handles FS_RENAME event. In
fanotify_handle_event() we will decide which info to report with FAN_RENAME
event based on which marks in iter_info have FS_RENAME set (luckily mount
marks are out of question for rename events so it will be relatively
simple). What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
