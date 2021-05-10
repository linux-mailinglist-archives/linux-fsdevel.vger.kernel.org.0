Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61D3793DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhEJQdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhEJQdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 12:33:12 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C74C061574;
        Mon, 10 May 2021 09:32:07 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w13so2449744ilv.11;
        Mon, 10 May 2021 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HEWf3005QuvEqIfbbuarR+iJs1GsrPXMl+pWUUy1SvE=;
        b=rI1VgEBhj8d5qIOOPcPBaCz8+aKS4WNeAjwiCt0Z3E+M9KQodPdp23aoc9VVZqnnY7
         eHXU7cv/rBqrrpZkCXg2wg+9JQyHUVhky/GbOHXrVRxbnfMN1K79s/2gIqwBmfDzXUw0
         Z2GvCbzirVgRvWjL0E+KGzeBV2mK7ZmnqhzALH20fmEUSJy31+YQxLJ2pYljO/ATt9ZZ
         2GcuTBvPh3k1d7cfHFP0TsVfU3CvskFN7PzjAtiPMKkj3K/usEgg9A9b/GTNPaiUQIiS
         tW+IG4WF5U70V3wgskR+b57JbcLf/wt61gen0508A8qbaF2oQef/lXNaTXyWSsAQh32X
         4Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HEWf3005QuvEqIfbbuarR+iJs1GsrPXMl+pWUUy1SvE=;
        b=Q9lpNUk4C8TJJoa0OVX2qYH0tsSuXELXWRQiDp+SF0aK7cEXwAqDPwMu2SWbeby8DB
         F5UBA7Fi4R7YQZZAA2EPBMCdYWPNBtScT9Y7CZX3EGiTV+zH6yLCFQ8srHSAFpuPOLCW
         Z63MxvLIH/2MNG6txXTea3U3Sy3YEa9hzCD55pVVNo8DRoXdp8cNXISuEpwc/vekx4J9
         ug88aQ6Q78bUaJjDC8mJjXjgMBa9YcHqg53VF9TTZgU67rYF78bfiDQRsosEopY2TwxW
         KtAz0TkOuOrcZQumDl3kXYNSLTS/b0THOMK9mmwF99+a4YQvBYJaGhjy9k93kdQcBEmI
         UXOg==
X-Gm-Message-State: AOAM5323VWanF6mq8o50yN5pB71EbtnwO3gJARt5HUtWrN/A2aJmjBlM
        m0nvpCm//hqtNZz8OmiXGULq4ZzhGmugUoBfLj/Uvzon2EM=
X-Google-Smtp-Source: ABdhPJzNdf3/kf5koq92R7x+ivtev4/Nw03uVjURYL3B16Qfb377h/KGDB2mjxdumGkBjFUyTGDDj6BWSPrIWrdOw9g=
X-Received: by 2002:a05:6e02:1142:: with SMTP id o2mr9564450ill.9.1620664327034;
 Mon, 10 May 2021 09:32:07 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 10 May 2021 19:31:56 +0300
Message-ID: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
Subject: Re: fsnotify events for overlayfs real file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > > > open and write to a file.
> > > >
> > > > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > > > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > > > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> > > >
> > > > I wonder if that is a problem that we need to fix...
> > >
> > > I assume you are speaking of the filesystem that is absorbing the changes?
> > > AFAIU usually you are not supposed to access that filesystem alone but
> > > always access it only through overlayfs and in that case you won't see the
> > > problem?
> > >
> >
> > Yes I am talking about the "backend" store for overlayfs.
> > Normally, that would be a subtree where changes are not expected
> > except through overlayfs and indeed it is documented that:
> > "If the underlying filesystem is changed, the behavior of the overlay
> >  is undefined, though it will not result in a crash or deadlock."
> > Not reporting events falls well under "undefined".
> >
> > But that is not the problem.
> > The problem is that if user A is watching a directory D for changes, then
> > an adversary user B which has read/write access to D can:
> > - Clone a userns wherein user B id is 0
> > - Mount a private overlayfs instance using D as upperdir
> > - Open file in D indirectly via private overlayfs and edit it
> >
> > So it does not require any special privileges to circumvent generating
> > events. Unless I am missing something.
>
> I see, right. I agree that is unfortunate especially for stuff like audit
> or fanotify permission events so we should fix that.
>

Miklos,

Do you recall what is the reason for using FMODE_NONOTIFY
for realfile?

I can see that events won't be generated anyway for watchers of
underlying file, because fsnotify_file() looks at the "fake" path
(i.e. the overlay file path).

I recently looked at a similar issue w.r.t file_remove_privs() when
I was looking at passing mnt context to notify_change() [1].

My thinking was that we can change d_real() to provide the real path:

static inline struct path d_real_path(struct path *path,
                                    const struct inode *inode)
{
        struct realpath = {};
        if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
               return *path;
        dentry->d_op->d_real(path->dentry, inode, &realpath);
        return realpath;
}

static inline struct dentry *d_real(struct dentry *dentry,
                                    const struct inode *inode)
{
        struct realpath = {};
        if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
               return dentry;
        dentry->d_op->d_real(path->dentry, inode, &realpath);
        return realpath.dentry;
}


Another option, instead of getting the realpath, just detect the
mismatch of file_inode(file) != d_inode(path->dentry) in
fanotify_file() and pass FSNOTIFY_EVENT_DENTRY data type
with d_real() dentry to backend instead of FSNOTIFY_EVENT_PATH.

For inotify it should be enough and for fanotify it is enough for
FAN_REPORT_FID and legacy fanotify can report FAN_NOFD,
so at least permission events listeners can identify the situation and
be able to block access to unknown paths.

Am I overcomplicating this?

Any magic solution that I am missing?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxiWb5Auyrbrj44hvdMcvMhx1YPRrR90RkicntmyfF+Ugw@mail.gmail.com/
