Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5B2C4DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 04:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgKZDmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 22:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbgKZDmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:42:15 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB56C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 19:42:13 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id f5so574496ilj.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 19:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gr1px6i9cNYYEcg3VeIx81L2j3n8ZP82zVDuSYTPEY=;
        b=oyjvQJnZxZaTJUOF4KISS4c8UUlxpvUnA0vyA1FHCX3ko8JXCE7yEZQiPsAFB05sRS
         8IBu2VqGfjVz1feCzDCI+YZ0xz/gcfn0I+Fp1VmbUoTMJSUiILpZ58DhASNPG4wsxxbr
         wPX1qe3g1oYK39FBkJLmq4GQkzoRy/Qw5FT3tYkiz+hyK7K1UZ6wu0d4N76GAxlvKSaE
         BGJDQkNwaQ8UU4VDu1XpKh0QXhcgrbALk7tySeOpWkillaDHL4cwaP/76mPnqVA53RL/
         9NQnFngymJule75LVE/uXW6uj4l78AaYWnbyiWEJBlfj8b8qM7LxqbBjmMuCkREGpgPT
         sswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gr1px6i9cNYYEcg3VeIx81L2j3n8ZP82zVDuSYTPEY=;
        b=oD5oIszpHoO0NlPRPWzcmH4PG2Z5RIt2H37tKqof5vNq8acEYlI+oZQ5vSKqsAdn0E
         t9/z5Cy9yrldudV9y/LZy6dSweG6AzeiOilWjapLZJHiaIRwnYWEbnAgmMgwTT40r/D7
         UAqxIFWtQaHnheL58xo7dxDoLDIyCAJiKpejUYsRSFqu0QNB3nH8l4ID185nxsWZgsk/
         N8uRNinn0yEXVI5oOoIdocMGQX4ul2pVnqNMmFEKhhdqD0sjZAGdIhrAbS3HWsWw66gv
         vJhPFqWgp+6qhRTEfDlwFk7k3cQPqp1Cu7z2DqOqJTV93f4YdxDC1aaCvGEDShOidEXr
         YDZQ==
X-Gm-Message-State: AOAM531QCFwe5OmtyNnZdHlHA1sEHQgCN3HBHBlsukVoMOBnhfihSbxM
        JL+jMYFRxdgG0l/bOoNAd6nwV+U9udZJX/Hbpgk=
X-Google-Smtp-Source: ABdhPJy6R39HAklBMkfDbFHZf7uqcq4EgOfoZFcSAPozz3QYbhO1WUPoDpcuCCM/VtAGrDXp+Nj5K8DhY7dwT3Dkb48=
X-Received: by 2002:a92:6403:: with SMTP id y3mr1055753ilb.72.1606362133006;
 Wed, 25 Nov 2020 19:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com> <20201125110156.GB16944@quack2.suse.cz>
In-Reply-To: <20201125110156.GB16944@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Nov 2020 05:42:01 +0200
Message-ID: <CAOQ4uxgmExbSmcfhp0ir=7QJMVcwu2QNsVUdFTiGONkg3HgjJw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-11-20 16:47:41, Amir Goldstein wrote:
> > On Tue, Nov 24, 2020 at 3:49 PM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 09-11-20 20:00:16, Amir Goldstein wrote:
> > > > A filesystem view is a subtree of a filesystem accessible from a specific
> > > > mount point.  When marking an FS view, user expects to get events on all
> > > > inodes that are accessible from the marked mount, even if the events
> > > > were generated from another mount.
> > > >
> > > > In particular, the events such as FAN_CREATE, FAN_MOVE, FAN_DELETE that
> > > > are not delivered to a mount mark can be delivered to an FS view mark.
> > > >
> > > > One example of a filesystem view is btrfs subvolume, which cannot be
> > > > marked with a regular filesystem mark.
> > > >
> > > > Another example of a filesystem view is a bind mount, not on the root of
> > > > the filesystem, such as the bind mounts used for containers.
> > > >
> > > > A filesystem view mark is composed of a heads sb mark and an sb_view mark.
> > > > The filesystem view mark is connected to the head sb mark and the head
> > > > sb mark is connected to the sb object. The mask of the head sb mask is
> > > > a cumulative mask of all the associated sb_view mark masks.
> > > >
> > > > Filesystem view marks cannot co-exist with a regular filesystem mark on
> > > > the same filesystem.
> > > >
> > > > When an event is generated on the head sb mark, fsnotify iterates the
> > > > list of associated sb_view marks and filter events that happen outside
> > > > of the sb_view mount's root.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > I gave this just a high-level look (no detailed review) and here are my
> > > thoughts:
> > >
> > > 1) I like the functionality. IMO this is what a lot of people really want
> > > when looking for "filesystem wide fs monitoring".
> > >
> > > 2) I don't quite like the API you propose though. IMO it exposes details of
> > > implementation in the API. I'd rather like to have API the same as for
> > > mount marks but with a dedicated mark type flag in the API - like
> > > FAN_MARK_FILESYSTEM_SUBTREE (or we can keep VIEW if you like it but I think
> > > the less terms the better ;).
> >
> > Sure, FAN_MARK_FS_VIEW is a dedicated mark type.
> > The fact that is it a bitwise OR of MOUNT and FILESYSTEM is just a fun fact.
> > Sorry if that wasn't clear.
> > FAN_MARK_FILESYSTEM_SUBTREE sounds better for uapi.
> >
> > But I suppose you also meant that we should not limit the subtree root
> > to bind mount points?
> >
> > The reason I used a reference to mnt for a sb_view and not dentry
> > is because we have fsnotify_clear_marks_by_mount() callback to
> > handle cleanup of the sb_view marks (which I left as TODO).
> >
> > Alternatively, we can play cache pinning games with the subtree root dentry
> > like the case with inode mark, but I didn't want to get into that nor did I know
> > if we should - if subtree mark requires CAP_SYS_ADMIN anyway, why not
> > require a bind mount as its target, which is something much more visible to
> > admins.
>
> Yeah, I don't have problems with bind mounts in particular. Just I was
> thinking that concievably we could make these marks less priviledged (just
> with CAP_DAC_SEARCH or so) and then mountpoints may be unnecessarily
> restricting. I don't think pinning of subtree root dentry would be
> problematic as such - inode marks pin the inode anyway, this is not
> substantially different - if we can make it work reliably...
>
> In fact I was considering for a while that we could even make subtree
> watches completely unpriviledged - when we walk the dir tree anyway, we
> could also check permissions along the way. Due to locking this would be
> difficult to do when generating the event but it might be actually doable
> if we perform the permission check when reporting the event to userspace.
> Just a food for thought...
>

I think unprivileged subtree watches are something nice for the future, but
for these FS_VIEW (or whatnot) marks, there is a lower hanging opportunity -
make them require privileges relative to userns.

We don't need to relax that right from the start and it may requires some
more work, but it could allow  unprivileged container user to set a
filesystem-like watch on a filesystem where user is privileged relative
to s_user_ns and that is a big win already.

It may also be possible in the future to allow setting this mark on a
"unserns contained" mount - I'm not exactly sure of the details of idmapped
mounts [1], but if mount has a userns associated with it to map fs uids then
in theory we can check the view-ability of the event either at event read time
or at event generation time - it requires that all ancestors have uid/gid that
are *mapped* to the mount userns and nothing else, because we know
that the listener process has CAP_DAC_SEARCH (or more) in the target
userns.

More food for thought...

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20201115103718.298186-1-christian.brauner@ubuntu.com/
