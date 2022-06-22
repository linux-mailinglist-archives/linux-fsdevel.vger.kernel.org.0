Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ABC555349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiFVSbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359273AbiFVSbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:31:21 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CB3B2BF;
        Wed, 22 Jun 2022 11:31:18 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id b81so8744867vkf.1;
        Wed, 22 Jun 2022 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRjJ1rSC0xlHCXZ2VwDKfLap9+4Ib3wKG/Ud565cchk=;
        b=mpWbw4byrr3CUUSq1sKiIklXXmE3IYkz2L9gQJRnbmMWLhVU+/57NoIaaokR0cVlgJ
         HHCl3qySffM3I77Iu0mJtOBR1c4RaGwz05ZnKr2zgXRale/5wsM4hDwn0IW2UQq8HzTp
         UKRl1QDiHopOgXOOJKZWztmQWhQQq+u7/80YnfeztWIBHmppLTN0sEBfaE5/z+doR6i5
         A5Kpc76ecx4A7xZ8K7uh4vlElTuY5NpJw2vDY311fTZ/ejI0iCCZrqJWJHzp5uvtFGE+
         K7BgK9maK0lkeI1of9EIEomgGXiSmP1U0DSFF1MEEtGyZG82BqaBgncxbBSu7abotZ4m
         4x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRjJ1rSC0xlHCXZ2VwDKfLap9+4Ib3wKG/Ud565cchk=;
        b=vUphG9ZqqWr/n9gA4WaG2vynfRmcDynItO9L9n1m5mD71ZK6Xy6BToH+52BYV0MTm8
         AVTLmgmkISePBz83E1uhscyIbuVGsqKdhvdRQ45+zlN07kg+ATu9wr8fxo6Pc0tM7Dzp
         aG2/5Zt0iVjLBmpps9sa2BfB44lZZVT/4BvtcuI2h2zgIRhPyUUSpJiKojGZTa9yrOAj
         +I1vanAIQk1/p1fLNystcfQVi8yjeapMRDGSDD+IxIDREERhj7tFR9VZYWwYvrr4Oj25
         ie3pzs5M404sci+G0kEIl8nBhaV42W6vuLBU9d3k6/SgJByxtaF03ciP2pzIpl6wPDHj
         KJZQ==
X-Gm-Message-State: AJIora+4H02tsFSRxRZNnv7cq4RdgkKMA8DeThhC0eJKSys0nb7vauks
        8qE5AkAqdxmZ7Cu62b+ENvbwLcZ5VFccn56uqOomZmXXYRc=
X-Google-Smtp-Source: AGRyM1vcrBIwqupsNIJhbyovfM6u9AZ3mXidoDVOlqf4cCcdiJfStQ4p3q1HWyXU2lqIxZpgLf8+4LpgBPFFJo89ezY=
X-Received: by 2002:a1f:168d:0:b0:36c:86b6:7883 with SMTP id
 135-20020a1f168d000000b0036c86b67883mr2553105vkw.15.1655922676799; Wed, 22
 Jun 2022 11:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220620134551.2066847-1-amir73il@gmail.com> <20220620134551.2066847-2-amir73il@gmail.com>
 <20220622155248.d6oywn3rkurbijs6@quack3.lan>
In-Reply-To: <20220622155248.d6oywn3rkurbijs6@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Jun 2022 21:31:05 +0300
Message-ID: <CAOQ4uxjZ84qY4OgJFCnxf1KT1_d013k0+XmU8iwiJVOSJSVMhQ@mail.gmail.com>
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
>

I can't remember if I left those cases on purpose.
I will check if it makes sense to use a macro here.

Amir.
