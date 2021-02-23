Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC592322F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhBWRRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhBWRRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:17:34 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F90C06178B;
        Tue, 23 Feb 2021 09:16:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d15so9712501ioe.4;
        Tue, 23 Feb 2021 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqm02B/mllfyAzyyWjAj/vk3+g5QN1rn4lIudfXEjj4=;
        b=OcKo+ONyCAsXp72p4dSLyaR6AZf29hkoaNLn5NLkxF0aXmIKMIBfV3N2+b4RTmoXp2
         ezntvkRVsdIeW6RrgEokqSSnS8YhnY1rC61DYeDZh9OALSPpEeDIsOqao6gG/NF2Ya87
         S5Hz05o3o0+aHKin9VzYSdZpBMwHCHwmvWYBQ0AGReDqKxzl6pUon5tUCAV/QRVc1/5x
         13UyDYBjiN5fXrAG8OezX5WSKZktw8RrEe6UeyO5jUsX0krDqc/HumONLqUi6p5TJp7d
         JkIXOw+Tse920rUsVzip8a8tVjFuxRZS17sv9rs9hYwzlpTXvw86+RBnEBe6gOeYTUR8
         LVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqm02B/mllfyAzyyWjAj/vk3+g5QN1rn4lIudfXEjj4=;
        b=Bb+EfmDJoVAv4hvHwWZ/fuYQJ0fSYblQIJNVKqubxk4V1wGl3lOn4tEMfDt8lFrBMV
         bjMPr+vz6e0aL6HRb6p7/fjWtMvMOVFjyFpJ8Im8K+8Y15w7zz0Q0pB6VPGoOAzyaQQb
         RXAPJOTUk2xiilZq7X8wzp6PtBgckSFUr6bCR6a34/H5KX9eQTNJR6nhEv1jbv52oPr7
         t4/DSnu4YXT9kP3MoIi5+77ZEGljFmds+T5G2pJeNoghEvlIxX7PNtFYzJlgSxzEAJuE
         ZDcVMUgYrg05fl0+k7slkOAk2r15EMVRrDiOz0icDLuuUpyXHc3OG5ZSWeKFHyoqQCQ2
         fOfg==
X-Gm-Message-State: AOAM531SZHEXaUKKvGrSNd0ehYLB04lhuZKAvcpkCpwCUkKUdUfk5y6z
        3oizdLqSkmnTX2daYs1U6BA9Gd0RgLkrtkeBFNU=
X-Google-Smtp-Source: ABdhPJxJpUJF187LUu7dlUiDCGj6E+R4tpaskWFf7hipYU5CmL7SzsDDP7TUVSmC9pY9M6CSNDsa2aEv6H+3bCAdltc=
X-Received: by 2002:a02:660b:: with SMTP id k11mr28834911jac.120.1614100611307;
 Tue, 23 Feb 2021 09:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-3-amir73il@gmail.com>
 <20210216170154.GG21108@quack2.suse.cz> <CAOQ4uxhwZG=aC+ZpB90Gn_5aNmQrwsJUnniWVhFXoq454vuyHA@mail.gmail.com>
 <CAOQ4uxhnrZu0phZniiBEqPJJZwWfs3UbCJt0atkHirdHQVCWgw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhnrZu0phZniiBEqPJJZwWfs3UbCJt0atkHirdHQVCWgw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Feb 2021 19:16:40 +0200
Message-ID: <CAOQ4uxgS5G2ajTfUWUPB5DsjjP0ji-Vu_9RjEzLJGfkNFz0P4w@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] fanotify: support limited functionality for
 unprivileged users
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 6:16 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Feb 16, 2021 at 8:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Feb 16, 2021 at 7:01 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sun 24-01-21 20:42:04, Amir Goldstein wrote:
> > > > Add limited support for unprivileged fanotify event listener.
> > > > An unprivileged event listener does not get an open file descriptor in
> > > > the event nor the process pid of another process.  An unprivileged event
> > > > listener cannot request permission events, cannot set mount/filesystem
> > > > marks and cannot request unlimited queue/marks.
> > > >
> > > > This enables the limited functionality similar to inotify when watching a
> > > > set of files and directories for OPEN/ACCESS/MODIFY/CLOSE events, without
> > > > requiring SYS_CAP_ADMIN privileges.
> > > >
> > > > The FAN_REPORT_DFID_NAME init flag, provide a method for an unprivileged
> > > > event listener watching a set of directories (with FAN_EVENT_ON_CHILD)
> > > > to monitor all changes inside those directories.
> > > >
> > > > This typically requires that the listener keeps a map of watched directory
> > > > fid to dirfd (O_PATH), where fid is obtained with name_to_handle_at()
> > > > before starting to watch for changes.
> > > >
> > > > When getting an event, the reported fid of the parent should be resolved
> > > > to dirfd and fstatsat(2) with dirfd and name should be used to query the
> > > > state of the filesystem entry.
> > > >
> > > > Note that even though events do not report the event creator pid,
> > > > fanotify does not merge similar events on the same object that were
> > > > generated by different processes. This is aligned with exiting behavior
> > > > when generating processes are outside of the listener pidns (which
> > > > results in reporting 0 pid to listener).
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > The patch looks mostly good to me. Just two questions:
> > >
> > > a) Remind me please, why did we decide pid isn't safe to report to
> > > unpriviledged listeners?
> >
> > Just because the information that process X modified file Y is not an
> > information that user can generally obtain without extra capabilities(?)
> > I can add a flag FAN_REPORT_OWN_PID to make that behavior
> > explicit and then we can relax reporting pids later.
> >
>
> FYI a patch for flag FAN_REPORT_SELF_PID is pushed to branch
> fanotify_unpriv.
>
> The UAPI feels a bit awkward with this flag, but that is the easiest way
> to start without worrying about disclosing pids.
>
> I guess we can require that unprivileged listener has pid 1 in its own
> pid ns. The outcome is similar to FAN_REPORT_SELF_PID, except
> it can also get pids of its children which is probably fine.
>

Jan,

WRT your comment in github:
"So maybe we can just require that this flag is already set by userspace
instead of silently setting it? Like:

if (!(flags & FAN_REPORT_SELF_PID)) return -EPERM;

I'd say that variant is more futureproof and the difference for user
is minimal."

I started with this approach and then I wrote the tests and imagined
the man page
requiring this flag would be a bit awkward, so I changed it to auto-enable.

I am not strongly against the more implicit flag requirement, but in
favor of the
auto-enable approach I would like to argue that with current fanotify you CAN
get zero pid in event, so think about it this way:
If a listener is started in (or moved into) its own pid ns, it will
get zero pid in all
events (other than those generated by itself and its own children).

With the proposed change, the same applies also if the listener is started
without CAP_SYS_ADMIN.

As a matter of fact, we do not need the flag at all, we can determine whether
or not to report pid according to capabilities of the event reader at
event read time.
And we can check for one of:
- CAP_SYS_ADMIN
- CAP_SYS_PACCT
- CAP_SYS_PTRACE

Do you prefer this flag-less approach?

Thanks,
Amir.
