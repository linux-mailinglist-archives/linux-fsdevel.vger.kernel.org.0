Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077D31FCFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBSQRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhBSQR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:17:28 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A6C061574;
        Fri, 19 Feb 2021 08:16:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u20so6138224iot.9;
        Fri, 19 Feb 2021 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVC1lUy6yBX+RjfN1vbz03Jol154WSsJeAHa1xpGG1w=;
        b=R6nCxjX0R5E+fjHijcUZSbger7NLM8AdWaadFqNsy1CBNXIxSorZp0S1rrPklPs2id
         gfrjqUWgsnJ/TyM8NdBqr+8pTIZVHc7Kc6xRzTIOWOkMVH2De8QjBi2j42/V+z1Sy3kV
         O6tBsZ2caRB7i/Sm04RVMh9dJj2mSJNP58rhfKUnju+EdFzWcQnlyNd0LMHNa9cBrd1D
         orOnL2/MDl6CvXZkJNU360gr0a5IOeuUHARh209CEVJMRQtABwqAPZn6DieT6eD05r+i
         LFXafQPDTnRmssvpzupQZNneJZmAIHQTtAgYSjtkEYns7X6P4gerZsZr0MPxAY3OkAeu
         J0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVC1lUy6yBX+RjfN1vbz03Jol154WSsJeAHa1xpGG1w=;
        b=dx3DXB34liLLqh1pDDbbVhJ5oq3IB568wDqDDtCrvSuacfOnTHhGkrsbADEQ0VoZe3
         NTNRRK4VXTW+RzpDfVFaC+R5r1Fik4iMm3r74L+E+MYiqqkXUqSwUwDipLpSEWj2m60Q
         bsdaElI93fpzUVpg7wdXtUrEFQVKyE6ZV5zxrsbWoJ/PxAKVyv6LKl0sRsmYF/GSxpqU
         eV8OwxMHqDn3dKzpQ9mEBKCuUxesyvvP1YqyzPm6c4ciTYI3Gb1sCVz7cMNEsUpDx5bt
         HJOH/U1CNP9Fn6d7om8fW+2JFQ3FNSdFD5HhjQ8EltSI0L5+QCVbZ5IPISkpEnfLS+5W
         27xQ==
X-Gm-Message-State: AOAM532AWDJbxY3dum0cvGuBDbO4nOb4ynReRaQ2myzz6wnVD0UexqZN
        +h3gI4RVPk8iBToxYDF1hbKBwR5lM51i4hgg3nFdnkJ2aAs=
X-Google-Smtp-Source: ABdhPJxtBUaqTrg6LmDS+m5jzyvXa27KEtmVVSV4PB1kq11JS8lAnnIV4VUVixNpxoU4a9Gc1lleoxDGwYJJ6r78GVM=
X-Received: by 2002:a02:bb16:: with SMTP id y22mr10482944jan.123.1613751406497;
 Fri, 19 Feb 2021 08:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-3-amir73il@gmail.com>
 <20210216170154.GG21108@quack2.suse.cz> <CAOQ4uxhwZG=aC+ZpB90Gn_5aNmQrwsJUnniWVhFXoq454vuyHA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhwZG=aC+ZpB90Gn_5aNmQrwsJUnniWVhFXoq454vuyHA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Feb 2021 18:16:35 +0200
Message-ID: <CAOQ4uxhnrZu0phZniiBEqPJJZwWfs3UbCJt0atkHirdHQVCWgw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] fanotify: support limited functionality for
 unprivileged users
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 8:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 16, 2021 at 7:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 24-01-21 20:42:04, Amir Goldstein wrote:
> > > Add limited support for unprivileged fanotify event listener.
> > > An unprivileged event listener does not get an open file descriptor in
> > > the event nor the process pid of another process.  An unprivileged event
> > > listener cannot request permission events, cannot set mount/filesystem
> > > marks and cannot request unlimited queue/marks.
> > >
> > > This enables the limited functionality similar to inotify when watching a
> > > set of files and directories for OPEN/ACCESS/MODIFY/CLOSE events, without
> > > requiring SYS_CAP_ADMIN privileges.
> > >
> > > The FAN_REPORT_DFID_NAME init flag, provide a method for an unprivileged
> > > event listener watching a set of directories (with FAN_EVENT_ON_CHILD)
> > > to monitor all changes inside those directories.
> > >
> > > This typically requires that the listener keeps a map of watched directory
> > > fid to dirfd (O_PATH), where fid is obtained with name_to_handle_at()
> > > before starting to watch for changes.
> > >
> > > When getting an event, the reported fid of the parent should be resolved
> > > to dirfd and fstatsat(2) with dirfd and name should be used to query the
> > > state of the filesystem entry.
> > >
> > > Note that even though events do not report the event creator pid,
> > > fanotify does not merge similar events on the same object that were
> > > generated by different processes. This is aligned with exiting behavior
> > > when generating processes are outside of the listener pidns (which
> > > results in reporting 0 pid to listener).
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > The patch looks mostly good to me. Just two questions:
> >
> > a) Remind me please, why did we decide pid isn't safe to report to
> > unpriviledged listeners?
>
> Just because the information that process X modified file Y is not an
> information that user can generally obtain without extra capabilities(?)
> I can add a flag FAN_REPORT_OWN_PID to make that behavior
> explicit and then we can relax reporting pids later.
>

FYI a patch for flag FAN_REPORT_SELF_PID is pushed to branch
fanotify_unpriv.

The UAPI feels a bit awkward with this flag, but that is the easiest way
to start without worrying about disclosing pids.

I guess we can require that unprivileged listener has pid 1 in its own
pid ns. The outcome is similar to FAN_REPORT_SELF_PID, except
it can also get pids of its children which is probably fine.

I am not sure if this is a reasonable option from users POV.

> >
> > b) Why did we decide returning open file descriptors isn't safe for
> > unpriviledged listeners? Is it about FMODE_NONOTIFY?
> >
>
> Don't remember something in particular. I feels risky.
>
> > I'm not opposed to either but I'm wondering. Also with b) old style
> > fanotify events are not very useful so maybe we could just disallow all
> > notification groups without FID/DFID reporting? In the future if we ever
> > decide returning open fds is safe or how to do it, we can enable that group
> > type for unpriviledged users. However just starting to return open fds
> > later won't fly because listener has to close these fds when receiving
> > events.
> >
>
> I like this option better.
>

This is also pushed to branch fanotify_unpriv.
With all the behavior specified explicitly in fanotify_init() and
fanotify_mark() flags, there is no need for the internal
FANOTIFY_UNPRIV group flag, which looks better IMO.

Thanks,
Amir.
