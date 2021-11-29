Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652E5462583
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhK2Wkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhK2WkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:40:19 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2CC201F90
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 11:15:31 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m9so23046195iop.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fV8wZakd4l8oOKM3/Zmm43SWH/XkVAi9BWWx6yZhMk=;
        b=UtP/oDsPIPxhpgcSGNTUTNtovdWbLgFQeM9ohhlileCAyuOYtJv0NQlZG4U0MWCKrw
         GC5//FnL/cokRNdB3PXB2tjLiVI5SStJ0+f8ebBVXxLXgOax1EpHJRXgyRL5czNDie28
         9+23OYnVG+2h21wwQaGBHxGJBU4ZATfp+OHI1Z5J1mRnN7YQKJ5Cero600tH8830BXIQ
         O6aIqCLEY2nqooDi/v5I6BG8gqVC1FR93dsfJnWldJumFW6wdu/Sp7CYlVUb4x6a/8L/
         kUBQVQofcuDuUOt8eecBkWI4z5Np09ccXBEAxiNoenlD66IRI6hwgGLrfddLZtYxG6p9
         JUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fV8wZakd4l8oOKM3/Zmm43SWH/XkVAi9BWWx6yZhMk=;
        b=heP2akG+r99rJEdcBZ73AqwsWxLH0B1EoVqykr/BIsgzvYFm4ObBh8LmPCNBup6BLW
         yAwxgQml/6jZOfqKyywH5w7Y8MeH4Fz49CTr4mOEjivVDS9P7GqT0q15/xYv9RA83YPV
         HnZeMWHG1j/SgroK3gL310PzEZ+SLbaqrmzHhUZnBcl52KAWZATl86NxR2rGF57LENfD
         q+oV6vUXaGDAMISvAj5+AusMnS/1AGtjgiJdER0INJUVRIMmUQUxTK71rDMhdfSkVm1y
         HK/LSNW46ywNjq4l3EsYLtiAxPUA8ZmawNuju2R+XnU8H2cHEzzi6ZbnPVozz0qqcDfJ
         2a1Q==
X-Gm-Message-State: AOAM5311EbMkoUhltiOhzkqGAGVemg2SAqYCitGMeC5QecswWqLe/PC+
        Spbud8KyT5IyZqBKDCkApFfuf2KK5BT1S4jA3tLnQv+pnIw=
X-Google-Smtp-Source: ABdhPJzZA+rNELiBzhrVhGgAT5E1WrWlcz3896h+6KyqfSdzPw45qhkaib2+oANLRvJhR0RfhZPFgnFfXsXvricQON0=
X-Received: by 2002:a02:a489:: with SMTP id d9mr67071286jam.47.1638213330479;
 Mon, 29 Nov 2021 11:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20211119071738.1348957-1-amir73il@gmail.com> <20211119071738.1348957-8-amir73il@gmail.com>
 <20211126151434.GJ13004@quack2.suse.cz>
In-Reply-To: <20211126151434.GJ13004@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 29 Nov 2021 21:15:19 +0200
Message-ID: <CAOQ4uxj1pP2QPy=7MPeuB2mbEGSbQ4fhXR7_rkkB14Xp7yiERQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] fanotify: record either old name new name or both
 for FAN_RENAME
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 26, 2021 at 5:14 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 19-11-21 09:17:36, Amir Goldstein wrote:
> > We do not want to report the dirfid+name of a directory whose
> > inode/sb are not watched, because watcher may not have permissions
> > to see the directory content.
> >
> > The FAN_MOVED_FROM/TO flags are used internally to indicate to
> > fanotify_alloc_event() if we need to record only the old parent+name,
> > only the new parent+name or both.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c | 57 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 50 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 018b32a57702..c0a3fb1dd066 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -290,6 +290,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >       __u32 marks_mask = 0, marks_ignored_mask = 0;
> >       __u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
> >                                    FANOTIFY_EVENT_FLAGS;
> > +     __u32 moved_mask = 0;
> >       const struct path *path = fsnotify_data_path(data, data_type);
> >       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> >       struct fsnotify_mark *mark;
> > @@ -327,17 +328,44 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >                       continue;
> >
> >               /*
> > -              * If the event is on a child and this mark is on a parent not
> > -              * watching children, don't send it!
> > +              * In the special case of FAN_RENAME event, inode mark is the
> > +              * mark on the old dir and parent mark is the mark on the new
> > +              * dir.  We do not want to report the dirfid+name of a directory
> > +              * whose inode/sb are not watched.  The FAN_MOVE flags
> > +              * are used internally to indicate if we need to report only
> > +              * the old parent+name, only the new parent+name or both.
> >                */
> > -             if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> > -                 !(mark->mask & FS_EVENT_ON_CHILD))
> > +             if (event_mask & FAN_RENAME) {
> > +                     /* Old dir sb are watched - report old info */
> > +                     if (type != FSNOTIFY_OBJ_TYPE_PARENT &&
> > +                         (mark->mask & FAN_RENAME))
> > +                             moved_mask |= FAN_MOVED_FROM;
> > +                     /* New dir sb are watched - report new info */
> > +                     if (type != FSNOTIFY_OBJ_TYPE_INODE &&
> > +                         (mark->mask & FAN_RENAME))
> > +                             moved_mask |= FAN_MOVED_TO;
> > +             } else if (type == FSNOTIFY_OBJ_TYPE_PARENT &&
> > +                        !(mark->mask & FS_EVENT_ON_CHILD)) {
> > +                     /*
> > +                      * If the event is on a child and this mark is on
> > +                      * a parent not watching children, don't send it!
> > +                      */
> >                       continue;
> > +             }
>
> It feels a bit hacky to mix the "what info to report" into the mask
> especially as otherwise perfectly valid flags. Can we perhaps have a
> separate function to find this out (like fanotify_rename_info_report_mask()
> or something like that) and use it in fanotify_alloc_event() or directly in
> fanotify_handle_event() and pass the result to fanotify_alloc_event()?
> That would seem a bit cleaner to me.

I used fsnotify_iter_info *match_info arg to fanotify_group_event_mask()
to indicate the marks of this group that matched the event and passed
it into fanotify_alloc_event().

Thanks,
Amir.
