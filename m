Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC843E5DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 16:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbhHJO2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbhHJO2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:28:19 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084AAC09B074
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 07:22:34 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id f8so15557858ilr.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8OIgcucCMQQFi7YtWUXvKPJW8qPj3/vRfmk/ggO800=;
        b=E+VW+alznpP8gdT7FpjNbpAgc56gXpBBh/b58dJJsqv2UZhv20p+d5pUu38xBkldtX
         if1nfrYeCBUzPJezL+jmziBACsmAANe+hRU2cqNOn2+uOqgi5AkhGFH+3FOk4MsXgkyB
         9Yoy71mZ2qk1YxFcObZ0blvpeZZYnx4GOptEhqp6XHqHLkjxyN3ddBELbmjgoB2zXURK
         21hPR4RY+w0/fQXbKxYXLZwpU640CN0VVhpUZx43enrd/IPKK2dRxTTktjJBdTfLBvZd
         tjTm7q5R9+ME5hgm4BMkdWGZkFJdJwQCqz5Gp1B5QmzDQsQfWS6fskK9yZ8Mo5OErwzb
         SHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8OIgcucCMQQFi7YtWUXvKPJW8qPj3/vRfmk/ggO800=;
        b=e+RWPE9sGS77Rpj+TYr5I+bv76AcN+tYKYQ7aNY8Q4qLhYksy3Zp+7ALOJJFwe1L03
         4Rb6NVJ9qJjhKA1e4F7L93Fnn0iVSZu4To9TWOOeYk0fvMx+HAKADIzQrajhCHvr1WgN
         Kvv3QMcF9ye42ITPQ6Ure0W8wnPs3Dw5hXX0DfOtMdJV61zMkP7YLlC74tFijOhZTXeR
         z+FbzhhOJ32mM4yRGdqRVEEFKNVaNejr4bqyD91mJBaJlExEq2GkZgIVFkUU4xFi4sNR
         JIWl9rqMCyEDQj20FmCDwL57Cv3o5DavR7tIJiYMU79CQvob185Cmd/NWYDuqY3hsBBL
         qK3g==
X-Gm-Message-State: AOAM532DXA4hhneSyTcul8AdwAh/eN/Q/81sniklOr3Fj5vFlxKZob1J
        dxrr7+SUWTGtw8zAsY3YlMIXqA+sBEmdGmefikU=
X-Google-Smtp-Source: ABdhPJxPpFlhbscgETq4ujGHGc5rTtgn1Fi/nR739lblM7K+MtRIZfoBe8RcaN9l36BtQFmkqTIDNcHVLEzXqlLookM=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr847181ilh.9.1628605353461;
 Tue, 10 Aug 2021 07:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210803180344.2398374-1-amir73il@gmail.com> <20210803180344.2398374-4-amir73il@gmail.com>
 <20210810104734.GC18722@quack2.suse.cz>
In-Reply-To: <20210810104734.GC18722@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Aug 2021 17:22:22 +0300
Message-ID: <CAOQ4uxgLPt=7g+K5Tg9ee6uZBpn_RgO5b0W-mhpmF_bxnb3q7Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] fsnotify: count all objects with attached connectors
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:47 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 03-08-21 21:03:43, Amir Goldstein wrote:
> > Rename s_fsnotify_inode_refs to s_fsnotify_conectors and count all
> > objects with attached connectors, not only inodes with attached
> > connectors.
> >
> > This will be used to optimize fsnotify() calls on sb without any
> > type of marks.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fsnotify.c |  6 +++---
> >  fs/notify/mark.c     | 45 +++++++++++++++++++++++++++++++++++++++++---
> >  include/linux/fs.h   |  4 ++--
> >  3 files changed, 47 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 30d422b8c0fc..a5de7f32c493 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -87,9 +87,9 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
> >
> >       if (iput_inode)
> >               iput(iput_inode);
> > -     /* Wait for outstanding inode references from connectors */
> > -     wait_var_event(&sb->s_fsnotify_inode_refs,
> > -                    !atomic_long_read(&sb->s_fsnotify_inode_refs));
> > +     /* Wait for outstanding object references from connectors */
> > +     wait_var_event(&sb->s_fsnotify_connectors,
> > +                    !atomic_long_read(&sb->s_fsnotify_connectors));
> >  }
>
> I think this is wrong and will deadlock unmount if there's pending sb mark
> because s_fsnotify_connectors won't drop to 0. I think you need to move
> this wait to fsnotify_sb_delete() after fsnotify_clear_marks_by_sb().

Oops.
Thanks for catching this.

Amir.
