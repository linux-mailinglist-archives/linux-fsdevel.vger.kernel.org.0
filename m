Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2C1E095D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbgEYIxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbgEYIxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 04:53:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26205C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 01:53:06 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q8so16548579iow.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSdiz594vlONC2gWZST0Vpac9KT+4VGrVUO768ccf7Q=;
        b=EMcILyQMTh34AGkxt9mkFNmzQqRq0fwRmTgI4QH5lhqhjMu7DY4I3lr7R2T1FOLDXC
         SoLVYbEIJUUEl91O5AzzoqT1dm+6EJUjl/yeBrf2W/q2W+MCtJnBaRsu9rWRPa7Bmgo7
         6XrlOpC7+GTd/n9pqX3ZCH58vfawu9/jCMC9mkLw7lneCVO9e5MutGQF9xs0tzys7z6W
         O/7XoxsBkkjjjCuUtk0oMAArSfebNs0YfYIlXCBXAP+nbZbaDl1tmAWJQ5w/9Tjk2X3P
         g7ZT5D3WlDbcHr9qdxuGUQbRi9V5/MWzjW0TujNpygtk6gtHv8MHxaiAVOTHnC2kIlgj
         15LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSdiz594vlONC2gWZST0Vpac9KT+4VGrVUO768ccf7Q=;
        b=lCS4OWUXd2zvSdpnhP6rodPhOMEJ222GgfXHc6XkQl5WpKOgexbwOmKH5z0q5JU/iD
         9KtxXAQyWA54ciojx8NMQNcDH8EsZXwmIqRytANPOwT/w5Dm8qPP47HGZetZkP+Ye++P
         F29pnIUSe5AYgctfVtFiTjUvMtSVi/o/gQt97XMuWW2x44vEWT+go6+3ZzHL0+mhH7fe
         55K9BWcwMck9YH2Zpk8uo3E7kYeujUwYfmAm9nsfdeBxxvaZcy84AjqpU6aITUxQ/3je
         0v3j1OgIBcm6DvgbjcFzYeoP6VciS5aQlvVA/slVSgczgKSOI7MkWKF+rhEkJoXSDIfT
         9/tA==
X-Gm-Message-State: AOAM533y9ZBW6gxdq2txQm4VZC/DGo/bFL+/DX9kwkQK4rbsf0MarKwe
        ERQaKsqxr+SmsY77gyZwlYB9Rz95CnUYeOONTYDZDq6m
X-Google-Smtp-Source: ABdhPJy6vBY9ZY/AkqIvFkLPNwSH7Ie56SzvzyWuDVb0BHly2MbW8Ru/MSdik7QEb+4PSgH+R7q9oFbQcpw9YOLn3P4=
X-Received: by 2002:a02:85a5:: with SMTP id d34mr10296785jai.123.1590396785277;
 Mon, 25 May 2020 01:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200521162443.GA26052@quack2.suse.cz> <CAOQ4uxirUfcpOdxFG9TAHUFSz+A5FMJdT=y4UKwpFUVov43nSA@mail.gmail.com>
 <CAOQ4uxgBGTAnZUedY3dEwR9V=hdrr_4PH_snj9E=sz-_UuVzTg@mail.gmail.com> <20200525072322.GG14199@quack2.suse.cz>
In-Reply-To: <20200525072322.GG14199@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 May 2020 11:52:54 +0300
Message-ID: <CAOQ4uxiL8W4S7qdc+AOJCf0GND0K_EgxuxKY1uhY3Qbvi1RAVA@mail.gmail.com>
Subject: Re: Ignore mask handling in fanotify_group_event_mask()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 10:23 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 23-05-20 20:14:58, Amir Goldstein wrote:
> > On Thu, May 21, 2020 at 9:10 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, May 21, 2020 at 7:24 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Hello Amir!
> > > >
> > > > I was looking into backporting of commit 55bf882c7f13dd "fanotify: fix
> > > > merging marks masks with FAN_ONDIR" and realized one oddity in
> > > > fanotify_group_event_mask(). The thing is: Even if the mark mask is such
> > > > that current event shouldn't trigger on the mark, we still have to take
> > > > mark's ignore mask into account.
> > > >
> > > > The most realistic example that would demonstrate the issue that comes to my
> > > > mind is:
> > > >
> > > > mount mark watching for FAN_OPEN | FAN_ONDIR.
> > > > inode mark on a directory with mask == 0 and ignore_mask == FAN_OPEN.
> > > >
> > > > I'd expect the group will not get any event for opening the dir but the
> > > > code in fanotify_group_event_mask() would not prevent event generation. Now
> > > > as I've tested the event currently actually does not get generated because
> > > > there is a rough test in send_to_group() that actually finds out that there
> > > > shouldn't be anything to report and so fanotify handler is actually never
> > > > called in such case. But I don't think it's good to have an inconsistent
> > > > test in fanotify_group_event_mask(). What do you think?
> > > >
> > >
> > > I agree this is not perfect.
> > > I think that moving the marks_ignored_mask line
> > > To the top of the foreach loop should fix the broken logic.
> > > It will not make the code any less complicated to follow though.
> > > Perhaps with a comment along the lines of:
> > >
> > >              /* Ignore mask is applied regardless of ISDIR and ON_CHILD flags */
> > >              marks_ignored_mask |= mark->ignored_mask;
> > >
> > > Now is there a real bug here?
> > > Probably not because send_to_group() always applied an ignore mask
> > > that is greater or equal to that of fanotify_group_event_mask().
> > >
> >
> > That's a wrong statement of course.
> > We do need to re-apply the ignore mask when narrowing the event mask.
> >
> > Exposing the bug requires a "compound" event.
> >
> > The only case of compound event I could think of is this:
> >
> > mount mark with mask == 0 and ignore_mask == FAN_OPEN. inode mark
> > on a directory with mask == FAN_EXEC | FAN_EVENT_ON_CHILD.
> >
> > The event: FAN_OPEN | FAN_EXEC | FAN_EVENT_ON_CHILD
> > would be reported to group with the FAN_OPEN flag despite the
> > fact that FAN_OPEN is in ignore mask of mount mark because
> > the mark iteration loop skips over non-inode marks for events
> > on child.
> >
> > I'll try to work that case into the relevant LTP test to prove it and
> > post a fix.
>
> Ha, that's clever. But FAN_EXEC does not exist in current fanotify. We only
> have FAN_OPEN_EXEC... And I don't think we have any compound events.
>

Typo. I meant FAN_OPEN_EXEC and you can see from LTP test
we do have at least this one compound event.

We could also split it if we wanted to, but no reason to do it now.

Thanks,
Amir.
