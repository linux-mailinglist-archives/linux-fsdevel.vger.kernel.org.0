Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1393559891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiFXLcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXLcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:32:39 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217056756;
        Fri, 24 Jun 2022 04:32:37 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id q42so773714uac.0;
        Fri, 24 Jun 2022 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2D9L8EqqgfA5GdFAq09NImYP+99NLl6cCeM4bsTTWE=;
        b=Hnm/jPGcSLmnlTbSYvuii1hh6j/y3YVm7+hznjrT5s1FycVnASrEkfhggoUyPeO8xc
         2SkkrXnQR8ESL9bUD6FvZ4kWP077gtAaQUpmagBmZa6aphkMK4xlBdutYkZAf9P9kjyk
         V0sH0UKSRf3ajBFsF+sRfVAus0pSo+XGd0hTRVCuQqK3OOCKP+ov6FxZP4qjr69CTic5
         d/FmvTBctFufVajeViYh2vAJQzk/5tZCi9V2p2f/Ee24L/hKy2enf9AH8ZcQzwrq4+BM
         ZK3AiJ3mLj5/su1t9ulERTHxNM6T0VZJPWLUl/UiqIVs+8XXk4JOdtj9s0AeG6F0O3mJ
         Vw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2D9L8EqqgfA5GdFAq09NImYP+99NLl6cCeM4bsTTWE=;
        b=4/eSgHr6bEgImCGV+m71CJumAg8PFWK7cqPDZUPT6VX4DlDV6+9cRtUTKnF+GxJLYl
         2Jf9FixR0ZAPQHob70A3YHOrzrMIiEXIKfZp+I8Cd/epoH4FpLSiEvAhuE8xZ2eKxJUg
         fthv0t/ebDVUhwXOUhDes/Vb0lDGrY07XFDu6LiPbI4HkIayBNiNUxh5aX8u/RAK2CiM
         zFPDynFW8oKOH2ctpfXwoi9PJlKeftRs1q9tbvQlOEw4pNV4sr+TgpspYs+2U9mzJdkZ
         k/jXftxa3hiXQ+SUwlTY2UiKSfNNrR3KQLIVAGjNmd7PF3NUc16wEGTxsrbndHsa3WDI
         wy+w==
X-Gm-Message-State: AJIora+UWb2zl8XmK7lb0N3rLU/8qKFqG1d5G60JEd31+0/0aU6bfWeJ
        //fVhAv7XeCP3knRksu7tUHIKbgHyZcL5kKfX0Q=
X-Google-Smtp-Source: AGRyM1vv5/THzI9I3kXPhMbf5hSu7lCxjos2xf+ShWK671l7mWhcjxkPw7WX41RG4/b3XtKL284BlGxAcVxKjBUvJRI=
X-Received: by 2002:ab0:67d2:0:b0:37f:d4b:f9c2 with SMTP id
 w18-20020ab067d2000000b0037f0d4bf9c2mr7226731uar.60.1656070356492; Fri, 24
 Jun 2022 04:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134551.2066847-1-amir73il@gmail.com> <20220620134551.2066847-2-amir73il@gmail.com>
 <20220622155248.d6oywn3rkurbijs6@quack3.lan>
In-Reply-To: <20220622155248.d6oywn3rkurbijs6@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Jun 2022 14:32:24 +0300
Message-ID: <CAOQ4uxitaemN+jfx+ZZ2jn4Z1a_bOj2k8mwOn60vnM-EWDw40g@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: prepare for setting event flags in ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 6:52 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 20-06-22 16:45:50, Amir Goldstein wrote:
> > Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> > The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> > ignore mask is always implicitly applied to events on directories.
> >
> > Define a mark flag that replaces this legacy behavior with logic of
> > applying the ignore mask according to event flags in ignore mask.
> >
> > Implement the new logic to prepare for supporting an ignore mask that
> > ignores events on children and ignore mask that does not ignore events
> > on directories.
> >
> > To emphasize the change in terminology, also rename ignored_mask mark
> > member to ignore_mask and use accessor to get only ignored events or
> > events and flags.
> >
> > This change in terminology finally aligns with the "ignore mask"
> > language in man pages and in most of the comments.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Looks mostly good to me. Just one question / suggestion: You are
> introducing helpers fsnotify_ignore_mask() and fsnotify_ignored_events().
> So shouldn't we be using these helpers as much as possible throughout the
> code? Because in several places I had to check the code around whether
> using mark->ignore_mask directly is actually fine. In particular:

I looked at the code and the only two cases I found were the two cases
that you pointed out that needed to use fsnotify_ignored_events().

>
> > @@ -315,19 +316,23 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >                       return 0;
> >       } else if (!(fid_mode & FAN_REPORT_FID)) {
> >               /* Do we have a directory inode to report? */
> > -             if (!dir && !(event_mask & FS_ISDIR))
> > +             if (!dir && !ondir)
> >                       return 0;
> >       }
> >
> >       fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> > -             /* Apply ignore mask regardless of mark's ISDIR flag */
> > -             marks_ignored_mask |= mark->ignored_mask;
> > +             /*
> > +              * Apply ignore mask depending on whether FAN_ONDIR flag in
> > +              * ignore mask should be checked to ignore events on dirs.
> > +              */
> > +             if (!ondir || fsnotify_ignore_mask(mark) & FAN_ONDIR)
> > +                     marks_ignore_mask |= mark->ignore_mask;
> >
> >               /*
> >                * If the event is on dir and this mark doesn't care about
> >                * events on dir, don't send it!
> >                */
> > -             if (event_mask & FS_ISDIR && !(mark->mask & FS_ISDIR))
> > +             if (ondir && !(mark->mask & FAN_ONDIR))
> >                       continue;
> >
> >               marks_mask |= mark->mask;
>
> So for example here I'm wondering whether a helper should not be used...

fixed.

>
> > @@ -336,7 +341,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >               *match_mask |= 1U << type;
> >       }
> >
> > -     test_mask = event_mask & marks_mask & ~marks_ignored_mask;
> > +     test_mask = event_mask & marks_mask & ~marks_ignore_mask;
>
> Especially because here if say FAN_EVENT_ON_CHILD becomes a part of
> marks_ignore_mask it can result in clearing this flag in the returned
> 'mask' which is likely not what we want if there are some events left
> unignored in the 'mask'?

You are right.
This can end up clearing FAN_ONDIR and then we won't report it.
However, take a look at this:

commit 0badfa029e5fd6d5462adb767937319335637c83
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Jul 16 11:42:09 2020 +0300

    fanotify: generalize the handling of extra event flags

    In fanotify_group_event_mask() there is logic in place to make sure we
    are not going to handle an event with no type and just FAN_ONDIR flag.
    Generalize this logic to any FANOTIFY_EVENT_FLAGS.

    There is only one more flag in this group at the moment -
    FAN_EVENT_ON_CHILD. We never report it to user, but we do pass it in to
    fanotify_alloc_event() when group is reporting fid as indication that
    event happened on child. We will have use for this indication later on.

What the hell did I mean by "We will have use for this indication later on"?
fanotify_alloc_event() does not look at the FAN_EVENT_ON_CHILD flag.
I think I had the idea that events reported in a group with FAN_REPORT_NAME
on an inode mark should not report its parent fid+name to be compatible with
inotify behavior and I think you shot this idea down, but it is only a guess.

>
> > @@ -344,14 +344,16 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
> >       fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> >               group = mark->group;
> >               marks_mask |= mark->mask;
> > -             marks_ignored_mask |= mark->ignored_mask;
> > +             if (!(mask & FS_ISDIR) ||
> > +                 (fsnotify_ignore_mask(mark) & FS_ISDIR))
> > +                     marks_ignore_mask |= mark->ignore_mask;
> >       }
> >
> > -     pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
> > -              __func__, group, mask, marks_mask, marks_ignored_mask,
> > +     pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignore_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
> > +              __func__, group, mask, marks_mask, marks_ignore_mask,
> >                data, data_type, dir, cookie);
> >
> > -     if (!(test_mask & marks_mask & ~marks_ignored_mask))
> > +     if (!(test_mask & marks_mask & ~marks_ignore_mask))
> >               return 0;
>
> And I'm wondering about similar things here...

Fixed here too, but here there is no meaning to the event flags,
because test_mask masks them out.

Thanks,
Amir.
