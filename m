Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35D387F16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 19:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbhERR56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 13:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhERR56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 13:57:58 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A630AC061573;
        Tue, 18 May 2021 10:56:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a11so10348496ioo.0;
        Tue, 18 May 2021 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gT2v9I2WQYvTjy8a5X1kwGlF67qYdtQh8WHqFN4nOuc=;
        b=jSTX4dVZhfS12GYVU/ZStl7sa8zMSKgE5XRMnJQ8eRHpslmcqQg4hQeFoY6MIF0ASa
         /x+6ICtQJHm7Q7r1ItxkKf33b46HVppnffyll7PlSZChhmjpran0Jib2JPWy0TZ2ZDSn
         UzqEI3BJvr7dk9q1aIT9Q8wILGdz33TUbpRj4PnWdIafLEl+1hvJS9GrjtbkvVLRC58Y
         M7d/IbBCokzcokXl2XXJahIT2fEwPQqspWXt/QtNYcpT8J6GfQ7RIS636OBc62SeutsS
         PjBfSTcEi5atZTmlyq4nAj2jYlXSsBFPqKI0LtOnCYnc4v9hlB5+LMsdbRw5wQ1jACi3
         CwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gT2v9I2WQYvTjy8a5X1kwGlF67qYdtQh8WHqFN4nOuc=;
        b=ZeMZ5YFrtrAAcG5BgSjVR2oIGTFE1IuHEx6trzXJk1KyR/GlJxcRyQIRsa4h2Y3/Cx
         0UHbr82f1lBSVMqdlXy+It0rcykTV81JStK8M8seT6Sg/cDtDa+GIruiEgrtiU20NxA4
         gYaWn9JqqwtwrUU4dD6xuYRmWpN19VK8vcbKGkuQvfFkbvgKkTElp6JNVO5rJX3JwAUD
         a8yDC3f+/l8Fob7T6JWTqr+iMBPoQ/0uuDXePPWs/LCbc0/cxPouj/bN46FoFfCQIgBN
         Sl6E+UK7ITpmEU7UrJ9UGez8BB/EAID6vEcQLt95dkmiU7xeY9+HUgk1yZJK3j4QYF9x
         ++Cw==
X-Gm-Message-State: AOAM530+GkvW6BRDWiXurcv/BbuOeLVUFyAD7TTaqq85G/8HOdZNv6Ur
        FCa1TFP1rA2CBDw4VjLjmPg/Wkr8db4kSm+DkTg=
X-Google-Smtp-Source: ABdhPJzauNqKCZdhExFIqnEfvGz7nCc3cvSYLyUoB4NOnDVmcLCw9uN4EPnEkByDs/3nadvK/82uV1falg17nUheWHU=
X-Received: by 2002:a05:6638:3445:: with SMTP id q5mr7155155jav.120.1621360599076;
 Tue, 18 May 2021 10:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
 <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com>
In-Reply-To: <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 May 2021 20:56:27 +0300
Message-ID: <CAOQ4uxhsxmzWp+YMRBA3xFDzJ1ov--n=f+VAnBsJZ_4DyHoYXw@mail.gmail.com>
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

On Tue, May 18, 2021 at 5:43 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 10 May 2021 at 18:32, Amir Goldstein <amir73il@gmail.com> wrote:
> >
>
> > > I see, right. I agree that is unfortunate especially for stuff like audit
> > > or fanotify permission events so we should fix that.
> > >
> >
> > Miklos,
> >
> > Do you recall what is the reason for using FMODE_NONOTIFY
> > for realfile?
>
> Commit d989903058a8 ("ovl: do not generate duplicate fsnotify events
> for "fake" path").
>
> > I can see that events won't be generated anyway for watchers of
> > underlying file, because fsnotify_file() looks at the "fake" path
> > (i.e. the overlay file path).
> >
> > I recently looked at a similar issue w.r.t file_remove_privs() when
> > I was looking at passing mnt context to notify_change() [1].
> >
> > My thinking was that we can change d_real() to provide the real path:
> >
> > static inline struct path d_real_path(struct path *path,
> >                                     const struct inode *inode)
> > {
> >         struct realpath = {};
> >         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
> >                return *path;
> >         dentry->d_op->d_real(path->dentry, inode, &realpath);
> >         return realpath;
> > }
> >
> > static inline struct dentry *d_real(struct dentry *dentry,
> >                                     const struct inode *inode)
> > {
> >         struct realpath = {};
> >         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
> >                return dentry;
> >         dentry->d_op->d_real(path->dentry, inode, &realpath);
> >         return realpath.dentry;
> > }
> >
> >
> > Another option, instead of getting the realpath, just detect the
> > mismatch of file_inode(file) != d_inode(path->dentry) in
> > fanotify_file() and pass FSNOTIFY_EVENT_DENTRY data type
> > with d_real() dentry to backend instead of FSNOTIFY_EVENT_PATH.
> >
> > For inotify it should be enough and for fanotify it is enough for
> > FAN_REPORT_FID and legacy fanotify can report FAN_NOFD,
> > so at least permission events listeners can identify the situation and
> > be able to block access to unknown paths.
> >
> > Am I overcomplicating this?
> >
> > Any magic solution that I am missing?
>
> Agree, dentry events should still happen.

Alas, the more critical issue is with fanotify permission events
which are path events.

>
> Path events: what happens if you bind mount, then detach (lazy
> umount)?   Isn't that exactly the same as what overlayfs does on the
> underlying mounts?
>

No, it isn't.

In the detached mount case, the fanotify listener will get an open fd
from fanotify_user.c::create_fd() using dentry_open() on the detached
path. When the listener will read proc/self/fd/<fd> symlink, it will see
the path from the fs root.

Assuming that marks were set on a group of files or directories
with FAN_OPEN_PERM in the event mask, the path from fs root provides
enough information to understand what is going on and in any case the
fd can be used to read metadata or content from the file before making the
permission decision.

Is there a reason for the fake path besides the displayed path in
/proc/self/maps?

Does it make sense to keep one realfile with fake path for mmaped
files along side a realfile with private/detached path used for all the
other operations?

While at it, we can also cache both upper and lower realfiles in case
file was copied up after open.

Better ideas?

Thanks,
Amir.
