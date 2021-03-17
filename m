Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADB33F8EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhCQTOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhCQTOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:14:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8250C061762;
        Wed, 17 Mar 2021 12:14:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id u20so361924iot.9;
        Wed, 17 Mar 2021 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQoPzktDaqJxILobH2+u2kQgFJc51uu97L9bjYEy/m8=;
        b=bSfmyWXD55Fr6vMv36ATdXiLMTVH3n96e+3XqRGxykL2S3VDBQtIRUO4SD/TkH5LlI
         AXGfy33REBXgnb5fNF11hBRgifGh3bKNjuRQvcaRRmxHHqNIfBpHCjPelWN8P2i/v0iH
         Bt0lPVkHL2RPkV1OZt0Z6rCPJ7h87fw93ZVgwMvkz+GaYF5PR0MjYBwUNnGiMBTktL71
         orpMgnCfIfkEcI7CWBWwfs3N8xIN4ypPhFX7LVO7tymn6QwNqCJX3I6c9IWH4hYkY2aL
         IO+c5DIArHOStGHHBLSvKjhVZaxIuf8u/KJcdI6iiJOUeDIzLH8KAb0U+SCWnyaLCx0b
         FRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQoPzktDaqJxILobH2+u2kQgFJc51uu97L9bjYEy/m8=;
        b=pQv0lDDPgzy/c8X40j8vpsK2u3dOuy426GjP6ASr5iihQPpo18Gy3nldYLCkd0X2cy
         xAwQkVLApgg8DkqXdoJrKDNanulp5IPgh+rKmBc1TZ5HAcdsSZ9jGzonp5HVhzY7yN1n
         ZGqT70+H1Vf2tJbB5sNlzROfyLkY1FrBpR4aPT6oitiN7+/1FPbcyp68Ff8+Wt3Opuqy
         +e+r/qJqlA9yxfTXy2DagUKsj190/Ud8P0z3RVba1rfW0ir1TMHcCaDCVuXGJZgKAOD4
         HzehyYHq1lwttvOwSEbIyD8RgJCMEiYOk/+8X96mDuS/1O4Nqf4HQHlqje2wX6XLMx+v
         rNhw==
X-Gm-Message-State: AOAM530OCiyudBiIIsQswjdsEs1jGQvIdJ865547Fra6oFmVM4Fdb0Kk
        +JKpgH7ytY5ylXxfey7Yqxh7E+Uoe0HiCVRb3St0KhkDp2o=
X-Google-Smtp-Source: ABdhPJxSbAz5IKLX2l3Awx54vE70Jj644wz/4Jd/QG0Cv0TTZMUDsJrpOq3FvWHOoyOAuTgeNUmtkvvqAdCmeDVEvBI=
X-Received: by 2002:a5d:9386:: with SMTP id c6mr7639153iol.203.1616008457379;
 Wed, 17 Mar 2021 12:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein>
In-Reply-To: <20210317174532.cllfsiagoudoz42m@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Mar 2021 21:14:06 +0200
Message-ID: <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 7:45 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Mar 17, 2021 at 02:19:57PM +0200, Amir Goldstein wrote:
> > On Wed, Mar 17, 2021 at 1:42 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 17-03-21 13:01:35, Amir Goldstein wrote:
> > > > On Tue, Mar 16, 2021 at 5:55 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Thu 04-03-21 13:29:19, Amir Goldstein wrote:
> > > > > > Jan,
> > > > > >
> > > > > > These patches try to implement a minimal set and least controversial
> > > > > > functionality that we can allow for unprivileged users as a starting
> > > > > > point.
> > > > > >
> > > > > > The patches were tested on top of v5.12-rc1 and the fanotify_merge
> > > > > > patches using the unprivileged listener LTP tests written by Matthew
> > > > > > and another LTP tests I wrote to test the sysfs tunable limits [1].
> > > > >
> > > > > Thanks. I've added both patches to my tree.
> > > >
> > > > Great!
> > > > I'll go post the LTP tests and work on the man page updates.
> > > >
> > > > BTW, I noticed that you pushed the aggregating for_next branch,
> > > > but not the fsnotify topic branch.
> > > >
> > > > Is this intentional?
> > >
> > > Not really, pushed now. Thanks for reminder.
> > >
> > > > I am asking because I am usually basing my development branches
> > > > off of your fsnotify branch, but I can base them on the unpushed branch.
> > > >
> > > > Heads up. I am playing with extra privileges we may be able to
> > > > allow an ns_capable user.
> > > > For example, watching a FS_USERNS_MOUNT filesystem that the user
> > > > itself has mounted inside userns.
> > > >
> > > > Another feature I am investigating is how to utilize the new idmapped
> > > > mounts to get a subtree watch functionality. This requires attaching a
> > > > userns to the group on fanotify_init().
> > > >
> > > > <hand waving>
> > > > If the group's userns are the same or below the idmapped mount userns,
> > > > then all the objects accessed via that idmapped mount are accessible
> > > > to the group's userns admin. We can use that fact to filter events very
> > > > early based on their mnt_userns and the group's userns, which should be
> > > > cheaper than any subtree permission checks.
> > > > <\hand waving>
> > >
> > > Yeah, I agree this should work. Just it seems to me the userbase for this
> > > functionality will be (at least currently) rather limited. While full
> >
> > That may change when systemd home dirs feature starts to use
> > idmapped mounts.
> > Being able to watch the user's entire home directory is a big win
> > already.
>
> Hey Amir,
> Hey Jan,
>
> I think so too.
>
> >
> > > subtree watches would be IMO interesting to much more users.
> >
> > Agreed.
>
> We have a use-case for subtree watches: One feature for containers we
> have is that users can e.g. tell us that they want the container manager
> to hotplug an arbitrary unix or block device into the container whenever
> the relevant device shows up on the system. For example they could
> instruct the container manager to plugin some new driver device when it
> shows up in /dev. That works nicely because of uevents. But users quite
> often also instruct us to plugin a path once it shows up in some
> directory in the filesystem hierarchy and unplug it once it is removed.
> Right now we're mainting an inotify-based hand-rolled recursive watch to
> make this work so we detect that add and remove event. I would be wildly
> excited if we could get rid of some of that complexity by using subtree
> watches. The container manager on the host will be unaffected by this
> feature since it will usually have root privileges and manage
> unprivileged containers.
> The unprivileged (userns use-case specifically here) subtree watches
> will be necessary and really good to have to make this work for
> container workloads and nested containers, i.e. where the container
> manager itselfs runs in a container and starts new containres. Since the
> subtree feature would be interesting for systemd itself and since our
> container manager (ChromeOS etc.) runs systemd inside unprivileged
> containers on a large scale it would be good if subtree watches could
> work in userns too.
>

I don't understand the subtree watch use case.
You will have to walk me through it.

What exactly is the container manager trying to detect?
That a subdir of a specific name/path was created/deleted?
It doesn't sound like a recursive watch is needed for that.
What am I missing?

As for nested container managers (and systemd), my thinking is
that if all the mounts that manager is watching for serving its containers
are idmapped to that manager's userns (is that a viable option?), then
there shouldn't be a problem to setup userns filtered watches in order to
be notified on all the events that happen via those idmapped mounts
and filtering by "subtree" is not needed.
I am clearly far from understanding the big picture.

> >
> > I was looking into that as well, using the example of nfsd_acceptable()
> > to implement the subtree permission check.
> >
> > The problem here is that even if unprivileged users cannot compromise
> > security, they can still cause significant CPU overhead either queueing
> > events or filtering events and that is something I haven't been able to
> > figure out a way to escape from.
> >
> > BUT, if you allow userns admin to setup subtree watches (a.k.a filtered
> > filesystem marks) on a userns filesystem/idmapped mount, now users
>
> I think that sounds reasonable.
> If the mount really is idmapped, it might be interesting to consider
> checking for privilege in the mnt_userns in addition to the regular
> permission checks that fanotify performs. My (equally handwavy) thinking
> is that this might allow for a nice feature where the creator of the
> mount (e.g. systemd) can block the creation of subtree watches by
> attaching a mnt_userns to the mnt that the user has no privilege in.
> (Just a thought.).
>

Currently, (upstream) only init_userns CAP_SYS_ADMIN can setup
fanotify watches.
In linux-next, unprivileged user can already setup inode watches
(i.e. like inotify).

So I am not sure what you are referring to by "block the creation of
subtree watches".

If systemd were to idmap my home dir to mnt_userns where my user
has CAP_SYS_ADMIN, then allowing my user to setup a watch for
all events on that mount should not be too hard.
If you think that is useful and you want to play with this feature I can
provide a WIP branch soon.

Thanks,
Amir.
