Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32BB16C3D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgBYO1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 09:27:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32783 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgBYO1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:27:14 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so2454279ioh.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKtolOITCKPMbVBYgv9Bpor58H2AqX1gAl4HSp9rYe4=;
        b=FwgDvSxUWSxf5sF2ksDzBQV8BLXzTn+RFx4575raHtCLqe8V2eMHhdlfRbhuDREmNm
         EB2nWAg2ClXI//A8XFe/707tzpcV/cLXXjEO5/8N5W/H972N2ndeRDVOP5ryk4a/bXYd
         ypxJWNNlSDc9CPWAhH6k1HrUB0323L2Ghvs/64enO+GchBrFlyg0c25gyHADrENkrNz6
         wQxpkBsLR4OTp4+h5ggwNbmqHfQDJLFVx1mUfJmLuwldv2MnEY5TSRce6J4JFmiNWQ1m
         Jr4PLxkFlL/GYgUN/D7MzyIZcVIdFrCLo4IsBbh1XVE8+Npv48VhIm1EYu3TbeRUy8NS
         p6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKtolOITCKPMbVBYgv9Bpor58H2AqX1gAl4HSp9rYe4=;
        b=PJJENktaJt3uXAuDP1WXvybH/j0UO9UI0yVDsJU0W3MsB3ugRIuSBbpVKcoBBGrXZS
         dVfsHzDi75INXXLidv5Pso7AtgMAKOh4Ir9gjOhkLlcvVurqSOn5v7MMGG5XffiRTcuJ
         AJuKuEZcQv9DnwbQRgyGz/MWlv4QtPLvaCkIF9jnJQ7HY1S1DO3OhbpGTY5DiSnOua94
         kmuqorNYymb+bP5neqCtqM2Rye4U8DwZIbyHK5I9/6iQBw8G+tV+7nj/Zdrxo0YJ17sW
         /SczigJ7DB7+fZBCxAJjq/rx3Ps8uAoMFeHuKuafmskPWKBTQ8+osTBN4FBM1e747fuP
         5vSQ==
X-Gm-Message-State: APjAAAWMYaYcCGNcwDUCJIjuMCwnzzGc4d1eIbudjFK2NcmswklEqYSR
        TYyxPZgkySLg3MeSVjRbZIQcZOGipbYreI6lXh4j26Tm
X-Google-Smtp-Source: APXvYqzDxtW13rPI5UE8PUpcGk9NNc7fh4me2yJ8o7ydDazoBt3CaUYHfazJh3E2m4me/ICFAFE/O8QJn2YbRIDjrIQ=
X-Received: by 2002:a02:8817:: with SMTP id r23mr58655944jai.120.1582640834095;
 Tue, 25 Feb 2020 06:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-3-amir73il@gmail.com>
 <20200225134612.GA10728@quack2.suse.cz>
In-Reply-To: <20200225134612.GA10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 25 Feb 2020 16:27:02 +0200
Message-ID: <CAOQ4uxjRaidKvh=7UBNHZTwfqLne+JXeOkWb0BVsvJep26kFyw@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 3:46 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 17-02-20 15:14:41, Amir Goldstein wrote:
> > Most of the code in fsnotify hooks is boiler plate of one or the other.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  include/linux/fsnotify.h | 96 +++++++++++++++-------------------------
> >  1 file changed, 36 insertions(+), 60 deletions(-)
>
> Nice cleanup. Just two comments below.
>
> > @@ -58,8 +78,6 @@ static inline int fsnotify_path(struct inode *inode, const struct path *path,
> >  static inline int fsnotify_perm(struct file *file, int mask)
> >  {
> >       int ret;
> > -     const struct path *path = &file->f_path;
> > -     struct inode *inode = file_inode(file);
> >       __u32 fsnotify_mask = 0;
> >
> >       if (file->f_mode & FMODE_NONOTIFY)
>
> I guess you can drop the NONOTIFY check from here. You've moved it to
> fsnotify_file() and there's not much done in this function to be worth
> skipping...

True.

>
> > @@ -70,7 +88,7 @@ static inline int fsnotify_perm(struct file *file, int mask)
> >               fsnotify_mask = FS_OPEN_PERM;
> >
> >               if (file->f_flags & __FMODE_EXEC) {
> > -                     ret = fsnotify_path(inode, path, FS_OPEN_EXEC_PERM);
> > +                     ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
> >
> >                       if (ret)
> >                               return ret;
>
> Hum, I think we could simplify fsnotify_perm() even further by having:
>
>         if (mask & MAY_OPEN) {
>                 if (file->f_flags & __FMODE_EXEC)
>                         fsnotify_mask = FS_OPEN_EXEC_PERM;
>                 else
>                         fsnotify_mask = FS_OPEN_PERM;
>         } ...
>

But the current code sends both FS_OPEN_EXEC_PERM and FS_OPEN_PERM
on an open for exec. I believe that is what was discussed when Matthew wrote
the OPEN_EXEC patches, so existing receivers of OPEN_PERM event on exec
will not regress..

Thanks,
Amir.
