Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7502CD64F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgLCM7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 07:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgLCM7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:59:39 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12EC061A4E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 04:58:53 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p5so1796330iln.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkG2l96WaQVHlEMwU7qBFa9Qx1zWZpmlAPl9N5Gfqzk=;
        b=Kwr52O0Qp9DDk+daIy2cmBS1mNGp596CIO0sWuPAztGbaf/u6rW5cCzvR3Rud9l/Bb
         4Osn6opCdejx9cLAjsGOqX0SlE8+9Y5zFPBWUx+zCA7u8R2iCWNQeik9phJ43ei/OVwn
         lgtvLi5v5wA+OU99KbxSjSTNhA+B2OR9rIBelDj9fUA1U7GhCAsPjORBWxkrGCWXpKV+
         oSkK43vuWSZ12UVyCMBwjB3TuN19jCGI3p29SBH6+418DKH7Qno2fVRN+7Dr9ehMoZ4E
         NeVmqK82uUVtbb5P1UWdQBjrmYbkXwmLrCEmtneL1wrF3k0auCWuYX/xO+AgORYeQ8zg
         yU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkG2l96WaQVHlEMwU7qBFa9Qx1zWZpmlAPl9N5Gfqzk=;
        b=eJ8KO+0yUL2518QR93gKGobh0QVRBty82o7QKqvZNRI66A+vUkW0NXpbWXpLU2tGnT
         5kz85lxD3m773fIoZ7Aa19xVuhOAJK6ray/kQ+Bv4zqGkEjzGSYsdOtR5Yvs92Igdj2p
         F5lsp/5WeE+Is8eBFyRshYXQWmgu44OKGhON/y0CceBRCPBPFHHpnjg1NKDIXxmr8JSM
         WE3QWz4cS/TUmwgq9oSpIPz00TTTCpf6JBbLlK/oSRV3NU/szAlr3nQ3Hb5lKo6/9++4
         hqqISe6TCeaFa9OpR4yIieICHRwhh6O7XHur9woyB0j6YqtSRMy0NpJ4HmlJp3KemBQc
         uGAA==
X-Gm-Message-State: AOAM532OQRLD1DX9uW1WExYTjgCWRMeEGGhXEgbtgVwpwrcLH3amuUQo
        9rKNH/bD2+9J4+MNRuC8gIpAP85i0Q8iyjAPHfo=
X-Google-Smtp-Source: ABdhPJzo/wxXMyqhV43o5PMCnVCW+swxijWRIwjNUHTIT1YPGZjAt0xzcoBnFN2UzT/acaTvUsXu3KrsxQCbBbg2SO4=
X-Received: by 2002:a92:6403:: with SMTP id y3mr2867813ilb.72.1607000332371;
 Thu, 03 Dec 2020 04:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20201202120713.702387-1-amir73il@gmail.com> <20201202120713.702387-4-amir73il@gmail.com>
 <20201203115336.GD11854@quack2.suse.cz>
In-Reply-To: <20201203115336.GD11854@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 14:58:41 +0200
Message-ID: <CAOQ4uxgi0LjdsetRyWoz+y9s4YdVxJwoY+0JGF3bgSpC+8Awqg@mail.gmail.com>
Subject: Re: [PATCH 3/7] fsnotify: fix events reported to watching parent and child
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 1:53 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-12-20 14:07:09, Amir Goldstein wrote:
> > fsnotify_parent() used to send two separate events to backends when a
> > parent inode is watcing children and the child inode is also watching.
>                      ^^ watching
>
> > In an attempt to avoid duplicate events in fanotify, we unified the two
> > backend callbacks to a single callback and handled the reporting of the
> > two separate events for the relevant backends (inotify and dnotify).
> >
> > The unified event callback with two inode marks (parent and child) is
> > called when both parent and child inode are watched and interested in
> > the event, but they could each be watched by a different group.
> >
> > So before reporting the parent or child event flavor to backend we need
> > to check that the group is really interested in that event flavor.
>
> So I'm not 100% sure what is the actual visible problem - is it that we
> could deliver events a group didn't ask for?

Sort of yes. See:
https://github.com/amir73il/ltp/blob/fsnotify-fixes/testcases/kernel/syscalls/inotify/inotify11.c

>
> Also I'm confused by a "different group" argument above. AFAICT
> fsnotify_iter_select_report_types() makes sure we always select marks from
> a single group and only after that we look at mark's masks.

The group will get an event it has ask for but on the wrong object.

>
> That being said I agree that the loop in send_to_group() will 'or' parent
> and child masks and then check test_mask & marks_mask & ~marks_ignored_mask
> so if either parent *or* child was interested in the event, we'll deliver
> it to both parent and the child. Fanotify is not prone to this since it
> does its own checks. Dnotify also isn't prone to the problem because it
> has only events on directories (so there are never two inodes to deliver
> to).

FS_ATTRIB on dir will be delivered to parent watcher as well as child watcher
I think.

> Inotify is prone to the problem although only because we have 'wd' in
> the event. So an inotify group can receive event also with a wrong 'wd'.
>

True wrong wd and with unexpected name or unexpected missing name.
group1 could be watching a file foo and get events on file bar because
group1 is watching the parent (for another event) and group2 is watching
parent for this event.

> After more pondering about your patch I think what I write above isn't
> actually a problem you were concerned about :) I think you were concerned
> about the situation when event mask gets FS_EVENT_ON_CHILD because some
> group has a mark on the parent which is interested in watching children
> (and so __fsnotify_parent() sets this flag). But then *another* group has
> a mark without FS_EVENT_ON_CHILD on the parent but we'll send the event to
> it regardless. This can actually result in completely spurious event on
> directory inode for inotify & dnotify.
>

Haha lags in emails :)

> If I understood the problem correctly, I suggest modifying beginning of the
> changelog like below because I was able to figure it out but some poor
> distro guy deciding whether this could be fixing the problem his customer
> is hitting or not has a small chance...
>
> "fsnotify_parent() used to send two separate events to backends when a
> parent inode is watching children and the child inode is also watching.
> In an attempt to avoid duplicate events in fanotify, we unified the two
> backend callbacks to a single callback and handled the reporting of the
> two separate events for the relevant backends (inotify and dnotify).
> However the handling is buggy and can result in inotify and dnotify listeners
> receiving events of the type they never asked for or spurious events."
>

ACK

> > The semantics of INODE and CHILD marks were hard to follow and made the
> > logic more complicated than it should have been.  Replace it with INODE
> > and PARENT marks semantics to hopefully make the logic more clear.
>
> Heh, wasn't I complaining about this when I was initially reviewing the
> changes? ;)

You certainly did and rightfully so.
It took me a long time to untangle this knot, so I hope you like the result.

>
> > Fixes: eca4784cbb18 ("fsnotify: send event to parent and child with single callback")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c    |  7 ++-
> >  fs/notify/fsnotify.c             | 78 ++++++++++++++++++--------------
> >  include/linux/fsnotify_backend.h |  6 +--
> >  3 files changed, 51 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 9167884a61ec..1192c9953620 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -268,12 +268,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >                       continue;
> >
> >               /*
> > -              * If the event is for a child and this mark is on a parent not
> > +              * If the event is on a child and this mark is on a parent not
> >                * watching children, don't send it!
> >                */
> > -             if (event_mask & FS_EVENT_ON_CHILD &&
> > -                 type == FSNOTIFY_OBJ_TYPE_INODE &&
> > -                  !(mark->mask & FS_EVENT_ON_CHILD))
> > +             if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> > +                 !(mark->mask & FS_EVENT_ON_CHILD))
> >                       continue;
> >
> >               marks_mask |= mark->mask;
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index c5c68bcbaadf..0676ce4d3352 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -152,6 +152,13 @@ static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
> >       if (mask & FS_ISDIR)
> >               return false;
> >
> > +     /*
> > +      * All events that are possible on child can also may be reported with
> > +      * parent/name info to inode/sb/mount.  Otherwise, a watching parent
> > +      * could result in events reported with unexpected name info to sb/mount.
> > +      */
> > +     BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ~FS_EVENTS_POSS_TO_PARENT);
> > +
> >       /* Did either inode/sb/mount subscribe for events with parent/name? */
> >       marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
> >       marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
> > @@ -249,6 +256,10 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
> >           path && d_unlinked(path->dentry))
> >               return 0;
> >
> > +     /* Check interest of this mark in case event was sent with two marks */
> > +     if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
> > +             return 0;
> > +
> >       return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
> >  }
> >
> > @@ -258,38 +269,40 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> >                                u32 cookie, struct fsnotify_iter_info *iter_info)
> >  {
> >       struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> > -     struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
> > +     struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
> >       int ret;
> >
> >       if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
> >           WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
> >               return 0;
> >
> > -     /*
> > -      * An event can be sent on child mark iterator instead of inode mark
> > -      * iterator because of other groups that have interest of this inode
> > -      * and have marks on both parent and child.  We can simplify this case.
> > -      */
> > -     if (!inode_mark) {
> > -             inode_mark = child_mark;
> > -             child_mark = NULL;
> > +     if (parent_mark) {
> > +             /*
> > +              * parent_mark indicates that the parent inode is watching children
> > +              * and interested in this event, which is an event possible on child.
> > +              * But is this mark watching children and interested in this event?
> > +              */
> > +             if (parent_mark->mask & FS_EVENT_ON_CHILD) {
>
> Is this really enough? I'd expect us to also check (mask &
> parent_mark->mask & ALL_FSNOTIFY_EVENTS) != 0...

I put it up in fsnotify_event_needs_parent() because this check is needed
for both parent and child.

BTW, at first I was thinking we needed to check EVENTS_POSS_ON_CHILD
here but we don't because if event is not EVENTS_POSS_ON_CHILD
(a.k.a. !parent_interested) then flag ON_CHILD is not set and parent_mark
is not iterated .

Thanks,
Amir.
