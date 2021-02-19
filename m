Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0D31F630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 10:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBSJDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 04:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBSJCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:02:35 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE222C061574;
        Fri, 19 Feb 2021 01:01:54 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id a7so4861100iok.12;
        Fri, 19 Feb 2021 01:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrVrPsV7tr9EvKvZpN0nYI8GXhwIJc8v9gJNiFZ3B+w=;
        b=eSTRGY6KAtn6aP9eLT8fNhP3TKTgRSTsufJsUHlNdCFHTMXgE1pYPixEmVOoRG1Lbx
         JecbP5hiOKV+TmkUNOniYk5BZdvS+Vlk0XOtWurBooOCKNUvGRqZwC6RPUGO3GdncKq/
         FIblZsv2lFU02HR098RhlMx5sUJDT91sncnQTS3aUvJQ1xzynXdThoDIcViZwkFBvEyX
         jpuyu5q/7CmZoua0Rg0DhCO4RI+BTHDofkm3KeTW2ueXoRPu7tDZDYgR2GADdYwTaekE
         aa6L3S04MHVgiS+DlNBvmxnuUcitOT8IBGeERYWx0uPGnVJTAjcouOHRfiunEU/nKzjv
         vrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrVrPsV7tr9EvKvZpN0nYI8GXhwIJc8v9gJNiFZ3B+w=;
        b=a90bMp+83Aw2zj8cQaBtF+cTNTIo0J7w9nSjYJEdvQQkhpld4VqDOyDAAmuFBHSfta
         5RiYdyvxJ/9mwMvyz9/xru3dlNt8jq7hkQI4Jnoo7eGQDfXrzJjhYd3RovDOphT4uBpk
         oymIq0XuqpXoprR7mV7rrc84awi7tYL/LvDkdNgHoybbfdiHLJVrwPwrOHws8x9dyzrh
         8Cs3mRgjYVVikEMU7pCfxD6auC2/QFhIgcSEBYat8XnWPAp9n1z+bihkF8QEnSjWMD12
         QAxSuSv+ZSprmzYIxIY4cRAyBrV3OhzRKIcQYA6a6JOH/UT91RnSyBvpe7p2dpFmrzhf
         YBjg==
X-Gm-Message-State: AOAM530XHL0gpzm3J2PeY49b5EMqAhUBYdol06eSiPgUws1b/DkN/qeT
        GnP0pqKwpFl8wWgQrgh6MUZKoX9Vlyy3/IVTuSI9WgH2Kqk=
X-Google-Smtp-Source: ABdhPJyXLlIWyTs6HxfKT7+GetFPUKlFSD2epOUaG1Tk9ve2+QS5AbPoJAElCkSNtZO9B+WKvnnbgHg/6A4vOMDuFnM=
X-Received: by 2002:a02:660b:: with SMTP id k11mr8882026jac.120.1613725314122;
 Fri, 19 Feb 2021 01:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-2-amir73il@gmail.com>
 <20210216162754.GF21108@quack2.suse.cz> <CAOQ4uxj8BbAnDQ9RyEM3fUtw7SPd38d1JsgfB2vN2Zni1UndQg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8BbAnDQ9RyEM3fUtw7SPd38d1JsgfB2vN2Zni1UndQg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Feb 2021 11:01:42 +0200
Message-ID: <CAOQ4uxjabma+BkLC07VXCDF6R9c4o+SMDzFcoEFXPPzgd0Dj9Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] fanotify: configurable limits via sysfs
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 8:57 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 16, 2021 at 6:27 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> >
> > I'm sorry that I've got to this only now.
> >
> > On Sun 24-01-21 20:42:03, Amir Goldstein wrote:
> > > fanotify has some hardcoded limits. The only APIs to escape those limits
> > > are FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARKS.
> > >
> > > Allow finer grained tuning of the system limits via sysfs tunables under
> > > /proc/sys/fs/fanotify/, similar to tunables under /proc/sys/fs/inotify,
> > > with some minor differences.
> > >
> > > - max_queued_events - global system tunable for group queue size limit.
> > >   Like the inotify tunable with the same name, it defaults to 16384 and
> > >   applies on initialization of a new group.
> > >
> > > - max_listener_marks - global system tunable of marks limit per group.
> > >   Defaults to 8192. inotify has no per group marks limit.
> > >
> > > - max_user_marks - user ns tunable for marks limit per user.
> > >   Like the inotify tunable named max_user_watches, it defaults to 1048576
> > >   and is accounted for every containing user ns.
> > >
> > > - max_user_listeners - user ns tunable for number of listeners per user.
> > >   Like the inotify tunable named max_user_instances, it defaults to 128
> > >   and is accounted for every containing user ns.
> >
> > I think term 'group' is used in the manpages even more and in the code as
> > well. 'listener' more generally tends to refer to the application listening
> > to the events. So I'd rather call the limits 'max_group_marks' and
> > 'max_user_groups'.
> >
> > > The slightly different tunable names are derived from the "listener" and
> > > "mark" terminology used in the fanotify man pages.
> > >
> > > max_listener_marks was kept for compatibility with legacy fanotify
> > > behavior. Given that inotify max_user_instances was increased from 8192
> > > to 1048576 in kernel v5.10, we may want to consider changing also the
> > > default for max_listener_marks or remove it completely, leaving only the
> > > per user marks limit.
> >
> > Yes, probably I'd just drop 'max_group_marks' completely and leave just
> > per-user marks limit. You can always tune it in init_user_ns if you wish.
> > Can't you?
> >
>
> So I am fine with making this change but what about
> FAN_UNLIMITED_MARKS?
>
> What will it mean?
> Should the group be able to escape ucount limits?
>

Nevermind, I figured it out on my own:

 "Note that when a group is initialized with FAN_UNLIMITED_MARKS, its own
  marks are not accounted in the per user marks account, so in effect the
  limit of max_user_marks is only for the collection of groups that are
  not initialized with FAN_UNLIMITED_MARKS."

I've pushed the result to branch fanotify_limits.
I won't post during the merge window unless you tell me to.

Do you think we should go ahead with merging this change before
the unprivileged fanotify change?

IMO, this interface is useful even for privileged groups - I have been carrying
a private patch for max_queued_events for a long time as the default limit is
too low and I wanted to avoid unlimited memory usage without the hassle
of setting up a memcg.

Thanks,
Amir.
