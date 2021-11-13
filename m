Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9951744F24E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhKMJnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 04:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhKMJnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 04:43:43 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26220C061766
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Nov 2021 01:40:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v65so14332341ioe.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Nov 2021 01:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im1/IV3AUZhnmWYnol3pj3dDJFIBEGQWXcC+Xk5qKJA=;
        b=EaAtL3lnMuRgGC9Ex+OLPoXX7SNwviV9FxLk0DLCgOjfq3ZHoB5WprneH9/aP+oCdC
         AsvwpAEvCrUE2VX2zJYYNkZZlGhOPfEB2BS3wUw4jGKek+oON28BIIgrzOTTYLkQtDMx
         Fzx+ePDjKxu0SBKnh8DwzM0YVLwsTRkKjF1+Ptl6yS1uizaNUgZ22frDyYFOsnTyAgsN
         HmZkZWJZ5htxJeodez1WYrEbSW5zlqHxIELadq2aLC/nQOuZooWA6/n7Oj9Yp+keoC6Y
         8gfz4flqP4/A7AIN+Ri8Odu4oGXxRNfEP+1w6YhXvYXI7D9YrOjIAQZYdnVPD1pBZ9ln
         GyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im1/IV3AUZhnmWYnol3pj3dDJFIBEGQWXcC+Xk5qKJA=;
        b=dg31ITSE8B3k/+RNbOT0VYWq0qHwvjKlqK19dQpIO6/wQIPwqmDqolxDlMJzf8g2IU
         bECy4U5bzb8D5h6xalHUgdO+v9dkWHxfLENM4JyeS4FFguBL0V78H0SNBbs9jJK0JTc8
         f0/EZ19gMDbtVHIhpuC8WuViBX1GuzDxLeYZPVcJyvaJ9W1iU6ynsfztrMsP45MO5Tww
         35qwHfse7uT3SziG8wx5TBA4mQbZfu3tytyYsXSKAGxHQINGK32FYpEDbDaiO/uqgQKJ
         sb9tgmUHhCeX5d/uNCpth6O+PezUTxeLnQJSS5Rqhwgkj2wheP9iITYa3uguPTSljJ/3
         2F2A==
X-Gm-Message-State: AOAM5333+D6XdLSgI2L57DuEZojjTCowTRfTXTJOiYCSYqN9uGrt74+V
        Dp+sMZQnSq0hEMJ4Ykgxe58PnPcw3PFPMxehvBQI5xv2Tus=
X-Google-Smtp-Source: ABdhPJwhthPVRB/63h4GkZ/7UOpFTzrKu9biKkamKiOrqNYdhrv1Uid0X+WlkXZOFkq2COfG/BJFbSmgcMgyUMC/RaA=
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr15453981iow.112.1636796450537;
 Sat, 13 Nov 2021 01:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com> <20211029114028.569755-6-amir73il@gmail.com>
 <20211112164824.GB30295@quack2.suse.cz>
In-Reply-To: <20211112164824.GB30295@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 13 Nov 2021 11:40:39 +0200
Message-ID: <CAOQ4uxgHSiksnkg1TARxcpddnqD5yzreoh4NiWLk+Q+nOO+Duw@mail.gmail.com>
Subject: Re: [PATCH 5/7] fanotify: record new parent and name in MOVED_FROM event
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 6:48 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 29-10-21 14:40:26, Amir Goldstein wrote:
> > In the special case of MOVED_FROM event, if we are recording the child
> > fid due to FAN_REPORT_TARGET_FID init flag, we also record the new
> > parent and name.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ...
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 795bedcb6f9b..d1adcb3437c5 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -592,21 +592,30 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> >                                                       __kernel_fsid_t *fsid,
> >                                                       const struct qstr *name,
> >                                                       struct inode *child,
> > +                                                     struct dentry *moved,
> >                                                       unsigned int *hash,
> >                                                       gfp_t gfp)
> >  {
> >       struct fanotify_name_event *fne;
> >       struct fanotify_info *info;
> >       struct fanotify_fh *dfh, *ffh;
> > +     struct inode *dir2 = moved ? d_inode(moved->d_parent) : NULL;
>
> I think we need to be more careful here (like dget_parent()?). Fsnotify is
> called after everything is unlocked after rename so dentry can be changing
> under us, cannot it? Also does that mean that we could actually get a wrong
> parent here if the dentry is renamed immediately after we unlock things and
> before we report fsnotify event?

fsnotify_move() is called inside lock_rename() (both old_dir and new_dir locks),
which are held by the caller of vfs_rename(), and prevent d_parent/d_name
changes to child dentries, so moved->d_parent is stable here.
You are probably confusing with inode_unlock(target), which is the
child inode lock.

d_parent/d_name are also stable for fsnotify_create/link/unlink/mkdir/rmdir
per the vfs locking rules for those operations. In all those cases, the parent
dir lock is held for vfs helper callers.
This is why we can use dentry->d_name (and moved->d_name) in all those
fsnotify hooks.

Thanks,
Amir.
