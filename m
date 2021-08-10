Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA63E5CA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbhHJONI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbhHJONI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:13:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B571C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 07:12:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y1so32388298iod.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAJ/Axbv07FPT/IrChwgADPqrv2/36sA2pNBTcAesMo=;
        b=uc9tB/R5sJ7WHUW4MwKuq3Pv3BDN6QRytc3mNSV8NLVea7vQFRe+xHa4HrS0vcC+wn
         IPUVu+iKUM+8Z4F4ovnoPw70LT3eg4DfCcEwUyRrXLIIGY4x+/MrseNXejvk2oBENVZP
         m2KenSpzicTPfLhy9refXkcDZF+AvayDqb8tzKf+IM2cv8W3nPNhnBzVIxoPSjMFE3Jd
         mkxu7faOt2soi6msSjqYyZUOVGB0m/IFSmxOXs76PrvmkEuc9I1m/MXvmWnVrlTBTycQ
         QlShljiTL+13fWbEAVzF3QSNrSA6L+pQ2VX+RlRfDOv+6pXGjx7qy50WQoH7BwxlmXyx
         wnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAJ/Axbv07FPT/IrChwgADPqrv2/36sA2pNBTcAesMo=;
        b=ECNPJQy/wDiW+ls533bfp+7g7pxjllH2sc1M/vlT+gD21ccPQtU/qTbAWD4MwXJ0bC
         V/Rl4UXbPrW8gJ/ArxRPHRc1cdaspidUnpFdJgHXIBYwnwnQ+gSoljFU1fn1MRG76bEz
         4ADl0u1M2GKxJzrDGsBhsRxV+CW9iY40Q+H7kzFkTq/Pb6RflaiANCneaQq/AIWl3JLH
         zqh17QC20uXdH7Xc5lce8zImkUVg7D61lg7lS8EjoOeKM0O0EYjkH37QrW2uP/NSoAvz
         j5Z/uNgPszIbaVrs0oSMGwuXktntwzk2ikx+FVMUg+5emV9E9WjcilDmbZLkyFDag57D
         BSzg==
X-Gm-Message-State: AOAM531lqkNV8zoK014ebPMeqTRuPQkbEVnQNzAHMjQ7ibFaC+hHBQWW
        C7U0YoyA3NqXyJe2C1ZNtc+R6S8AxqbDwZ1W978=
X-Google-Smtp-Source: ABdhPJxMXPXIlswFhERGtYu4fTUMWBugDyynWySGLJJTGeJvF0m/QEWboUbPxHJ+Q6zLETMS8QPDgv0yu9q9ZgSyZ6w=
X-Received: by 2002:a05:6638:1036:: with SMTP id n22mr27470966jan.81.1628604765414;
 Tue, 10 Aug 2021 07:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210803180344.2398374-1-amir73il@gmail.com> <20210803180344.2398374-4-amir73il@gmail.com>
 <YRIdVGmgAY+HOJYY@google.com>
In-Reply-To: <YRIdVGmgAY+HOJYY@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Aug 2021 17:12:34 +0300
Message-ID: <CAOQ4uxh_5oRv5v0=tYJDS2jFnOFhdQ2Y1ZwB3ONxj+ydbFZddw@mail.gmail.com>
Subject: Re: [PATCH 3/4] fsnotify: count all objects with attached connectors
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 9:32 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Tue, Aug 03, 2021 at 09:03:43PM +0300, Amir Goldstein wrote:
> > Rename s_fsnotify_inode_refs to s_fsnotify_conectors and count all
>
> s/s_fsnotify_conectors/s_fsnotify_connectors ;)
>
> > objects with attached connectors, not only inodes with attached
> > connectors.
> >
> > This will be used to optimize fsnotify() calls on sb without any
> > type of marks.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Have one question below.
>
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
> >
> >  void fsnotify_sb_delete(struct super_block *sb)
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index 2d8c46e1167d..622bcbface4f 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -172,7 +172,7 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
> >  static void fsnotify_get_inode_ref(struct inode *inode)
> >  {
> >       ihold(inode);
> > -     atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
> > +     atomic_long_inc(&inode->i_sb->s_fsnotify_connectors);
> >  }
> >
> >  static void fsnotify_put_inode_ref(struct inode *inode)
> > @@ -180,8 +180,45 @@ static void fsnotify_put_inode_ref(struct inode *inode)
> >       struct super_block *sb = inode->i_sb;
> >
> >       iput(inode);
> > -     if (atomic_long_dec_and_test(&sb->s_fsnotify_inode_refs))
> > -             wake_up_var(&sb->s_fsnotify_inode_refs);
> > +     if (atomic_long_dec_and_test(&sb->s_fsnotify_connectors))
> > +             wake_up_var(&sb->s_fsnotify_connectors);
> > +}
> > +
> > +static void fsnotify_get_sb_connectors(struct fsnotify_mark_connector *conn)
> > +{
> > +     struct super_block *sb;
> > +
> > +     if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
> > +             return;
> > +
> > +     if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> > +             sb = fsnotify_conn_inode(conn)->i_sb;
> > +     else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
> > +             sb = fsnotify_conn_mount(conn)->mnt.mnt_sb;
> > +     else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
> > +             sb = fsnotify_conn_sb(conn);
>
> I noticed that you haven't provided an explicit case when no conditions are
> matched, however this scenario appears to be handled in
> fsnotify_put_sb_connectors() below. Why is this the case here and not in
> fsnotify_put_sb_connectors()?

No reason. I fixed a warning reported by a static checker here and didn't
notice the other one.

>
> Also, I'm wondering if these blocks of code would be better expressed in a
> switch statement. Alternatively, if these conditionals are shared across
> the two helpers, why not factor out the super_block retrieval into an
> inline helper just to simplify the callsite and not duplicate code? That's
> of course if there is commonality between the two helpers.
>

Makes sense. Will do.

Thanks,
Amir.
