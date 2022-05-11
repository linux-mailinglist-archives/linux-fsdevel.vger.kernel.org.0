Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E41523468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbiEKNiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiEKNh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 09:37:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7566AF8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:37:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id k2so1985573qtp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OX4EPAZElJ2uM231Vbp/NaGA0e7SJ3sxr6tOpCJiYh0=;
        b=D+e74cjuv+yGA4mvddDyHQGJP6d/Z0dFAr0qaO7fkd8R3cC3y/43DE+L5SjdflrWxx
         HsR5m5mmfGiHAdV8dfV+G6dKQUDLndL27S1WmAadl2AAqM9jEWzU/b3acxLRey/7IFtn
         47b87qnvxEBreq9YyzATPTAyd/RxdRsOwPmwqCa+Ffp+LXiPTMdAPp42DCZ8Yy3k3b89
         mHBIP5Er+gCdyaH+Jj3zESZbzMjBZN2q4e778Af7cBhvxlEH5XUL20ziqBEs4mMiutCW
         UJfTLrIWED4cNXgqG0+2OWSeizHrTjRY1TJx5ZAIyuf3Tj2gBs+4bRh6lYKqyeTlcapm
         rrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OX4EPAZElJ2uM231Vbp/NaGA0e7SJ3sxr6tOpCJiYh0=;
        b=fOXtIJQdZHzbciECbl96ngZk6sp1QDuNI5WG/PX/1PoxcXoq2/tJfCViQPuuP8ICZU
         RL8fBaEPXM2yMWVYjq731yRMfXSb6YkvV3FAm0SbqxLROUOKAk545G9E+3XYl/feLehd
         hz2Qw1NI5jBcTpyOxclHtiqJ9/JGUkQNZiyC6JhPWR+vdBMds0s/j8FbBwvtxjSLpCfh
         fMgkfxG2UEPaRpl9U+5GMriCtouJUdvGTB1yzA8YbbzisM1lcPv6tJMmoMeq5RMQoz8H
         pOBICHOgvKO8u4Q1+07BOkyI6Kdn0DvK476Cc7zHK6t8Qm/6oYheK9MPbV9gxVdUZhDw
         A7TQ==
X-Gm-Message-State: AOAM531+LEqFMyaKBTEMyyIHzfrcvWd3BNxxBA6zthRM6VOedTXC+HkO
        KjYE0oTrGeOnwxg0wt6lzHnhwFNa/xi7rVAh8oeqNFvtrgM=
X-Google-Smtp-Source: ABdhPJxvfuTyCTMREcdV5IDMkaEFKWIYv01sXq27vN0onDZZMHT2K1zrOViiduyB+xjA66B6O01ZBxqaZyTQe6ezGAg=
X-Received: by 2002:a05:622a:1a9c:b0:2f3:d873:4acc with SMTP id
 s28-20020a05622a1a9c00b002f3d8734accmr14730186qtc.424.1652276268150; Wed, 11
 May 2022 06:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220511092914.731897-1-amir73il@gmail.com> <20220511092914.731897-3-amir73il@gmail.com>
 <20220511130912.fohl7qakxaobepf7@quack3.lan>
In-Reply-To: <20220511130912.fohl7qakxaobepf7@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 May 2022 16:37:36 +0300
Message-ID: <CAOQ4uxjMOVKLD4oeN2zZ-nDKxWouFX9_+00S7CAm3X3VWGfgnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsnotify: consistent behavior for parent not watching children
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Wed, May 11, 2022 at 4:09 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 11-05-22 12:29:14, Amir Goldstein wrote:
> > The logic for handling events on child in groups that have a mark on
> > the parent inode, but without FS_EVENT_ON_CHILD flag in the mask is
> > duplicated in several places and inconsistent.
> >
> > Move the logic into the preparation of mark type iterator, so that the
> > parent mark type will be excluded from all mark type iterations in that
> > case.
> >
> > This results in several subtle changes of behavior, hopefully all
> > desired changes of behavior, for example:
> >
> > - Group A has a mount mark with FS_MODIFY in mask
> > - Group A has a mark with ignore mask that does not survive FS_MODIFY
> >   and does not watch children on directory D.
> > - Group B has a mark with FS_MODIFY in mask that does watch children
> >   on directory D.
> > - FS_MODIFY event on file D/foo should not clear the ignore mask of
> >   group A, but before this change it does
>
> Since FS_MODIFY of directory never happens I guess the ignore mask is never
> cleared? Am I missing something?

According to the code in send_to_group()
If D has FS_EVENT_ON_CHILD in mask then
The the inode mask on D would get events on D/foo
therefore
The ignore mask on D should ignore events (e.g. from mount mark) on D/foo
therefore
A MODIFY event on D/foo should clear the ignore mask on D

This is expected. The bug is that the ignore mask is cleared also
when D does not have FS_EVENT_ON_CHILD in the mask.

>
> > And if group A ignore mask was set to survive FS_MODIFY:
> > - FS_MODIFY event on file D/foo should be reported to group A on account
> >   of the mount mark, but before this change it is wrongly ignored
> >
> > Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> > Reported-by: Jan Kara <jack@suse.com>
> > Link: https://lore.kernel.org/linux-fsdevel/20220314113337.j7slrb5srxukztje@quack3.lan/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Just one nit below.
>
> > @@ -393,6 +386,23 @@ static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
> >       return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
> >  }
> >
> > +static void fsnotify_iter_set_report_mark_type(
> > +             struct fsnotify_iter_info *iter_info, int iter_type)
> > +{
> > +     struct fsnotify_mark *mark = iter_info->marks[iter_type];
> > +
> > +     /*
> > +      * FSNOTIFY_ITER_TYPE_PARENT indicates that this inode is watching
> > +      * children and interested in this event, which is an event
> > +      * possible on child. But is *this mark* watching children?
> > +      */
> > +     if (iter_type == FSNOTIFY_ITER_TYPE_PARENT &&
> > +         !(mark->mask & FS_EVENT_ON_CHILD))
> > +             return;
> > +
> > +     fsnotify_iter_set_report_type(iter_info, iter_type);
> > +}
> > +
> >  /*
> >   * iter_info is a multi head priority queue of marks.
> >   * Pick a subset of marks from queue heads, all with the same group
> > @@ -423,7 +433,7 @@ static bool fsnotify_iter_select_report_types(
> >       fsnotify_foreach_iter_type(type) {
> >               mark = iter_info->marks[type];
> >               if (mark && mark->group == iter_info->current_group)
> > -                     fsnotify_iter_set_report_type(iter_info, type);
> > +                     fsnotify_iter_set_report_mark_type(iter_info, type);
> >       }
>
> I think it is confusing to hide another condition in
> fsnotify_iter_set_report_mark_type() I'd rather have it explicitely here in
> fsnotify_iter_select_report_types().

OK.

Thanks,
Amir.
