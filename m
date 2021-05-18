Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0C387B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhEROoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhEROog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 10:44:36 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE909C061573
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 07:43:18 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 20so3299773uaf.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 May 2021 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NJS4BT8nKKIEzjadjztzmkHWrSH/ly6k2XtFbYYqtY=;
        b=ot0shic8SKoxbOBysgZfoTlIK7zf5cofWrytZCBs8KNPRXouMieUDdph30n4Mk66Yr
         f2ihwTpLMMxBk59OgnhUpTXXgiv4R0FdVX7mYDQMvDvxdOjpKiWVY1hxzkNuVoO46RcY
         7n86YLuOac4Gsp+FnEMpy/QslUc0goo7UpJns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NJS4BT8nKKIEzjadjztzmkHWrSH/ly6k2XtFbYYqtY=;
        b=BnFW0BbgunYjlTZgfI3td2dexz2KqzFBSvbMpsewZkesPIoYbxXkEGCI7UbSFo0NU3
         FyzoP+UfQnDg5W7du/tQ7x29e/vJWq/0zQXuaFtwxfA6EYD+Tvogmhf0BJjf9uJlENdw
         WueJUpcDzS1VW3YpC1CE4ACxxOqy+FtC6Hj5O/m6qoHLEv9VqEjAaa8e0TWtjMDhrskE
         FIqcFNnm2ntOjxgLf2IbcZ27C3PlbF9GsA2eimq3kIIboA4AkzvfkkpYzhq5IwN3/1Vt
         bBkBw9pP3c5gLfbozSA/SeJU4As2vl+S+vtJNzJIP2LgyX5YvAJlNu2Pq46NtD0x5rRD
         EUtg==
X-Gm-Message-State: AOAM533f3m0jroDKxqkCxfVSsEug/kK3mKX/hI+EWNXToGmdmsJffdnG
        CD9RJhfCaBpfe39dqSs0RSO0Ihbpou60S/mOz66R0luiQF2zXA==
X-Google-Smtp-Source: ABdhPJxRpelP85C/V/PHHmqJWlYMcnftRkoxLwLCTQlms4Th/kPTXFGsttYFYFHW+einymu6Ua5sDiR4a+Wy7b1YGbQ=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr6751886uao.9.1621348998165;
 Tue, 18 May 2021 07:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
In-Reply-To: <CAOQ4uxguanxEis-82vLr7OKbxsLvk86M0Ehz2nN1dAq8brOxtw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 May 2021 16:43:06 +0200
Message-ID: <CAJfpeguCwxXRM4XgQWHyPxUbbvUh-M6ei-tYa5Y0P56MJMW7OA@mail.gmail.com>
Subject: Re: fsnotify events for overlayfs real file
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 10 May 2021 at 18:32, Amir Goldstein <amir73il@gmail.com> wrote:
>

> > I see, right. I agree that is unfortunate especially for stuff like audit
> > or fanotify permission events so we should fix that.
> >
>
> Miklos,
>
> Do you recall what is the reason for using FMODE_NONOTIFY
> for realfile?

Commit d989903058a8 ("ovl: do not generate duplicate fsnotify events
for "fake" path").

> I can see that events won't be generated anyway for watchers of
> underlying file, because fsnotify_file() looks at the "fake" path
> (i.e. the overlay file path).
>
> I recently looked at a similar issue w.r.t file_remove_privs() when
> I was looking at passing mnt context to notify_change() [1].
>
> My thinking was that we can change d_real() to provide the real path:
>
> static inline struct path d_real_path(struct path *path,
>                                     const struct inode *inode)
> {
>         struct realpath = {};
>         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
>                return *path;
>         dentry->d_op->d_real(path->dentry, inode, &realpath);
>         return realpath;
> }
>
> static inline struct dentry *d_real(struct dentry *dentry,
>                                     const struct inode *inode)
> {
>         struct realpath = {};
>         if (!unlikely(dentry->d_flags & DCACHE_OP_REAL))
>                return dentry;
>         dentry->d_op->d_real(path->dentry, inode, &realpath);
>         return realpath.dentry;
> }
>
>
> Another option, instead of getting the realpath, just detect the
> mismatch of file_inode(file) != d_inode(path->dentry) in
> fanotify_file() and pass FSNOTIFY_EVENT_DENTRY data type
> with d_real() dentry to backend instead of FSNOTIFY_EVENT_PATH.
>
> For inotify it should be enough and for fanotify it is enough for
> FAN_REPORT_FID and legacy fanotify can report FAN_NOFD,
> so at least permission events listeners can identify the situation and
> be able to block access to unknown paths.
>
> Am I overcomplicating this?
>
> Any magic solution that I am missing?

Agree, dentry events should still happen.

Path events: what happens if you bind mount, then detach (lazy
umount)?   Isn't that exactly the same as what overlayfs does on the
underlying mounts?

Thanks,
Miklos
