Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FDC31CFF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBPSNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 13:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBPSNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:13:09 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC66C06174A;
        Tue, 16 Feb 2021 10:12:29 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id s24so11113080iob.6;
        Tue, 16 Feb 2021 10:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bic/7TfMAQTKdUd8PF3NaZBg5kvtJB2URdx0ANx8XqE=;
        b=s+BFQ2K0aS4PE7Mc+0tt8KCiVWMxg1I2WRratT/Vn6JyOuV0b0Jk9DZJPDYNTNFFg9
         Rl+R9PMMjI8ysRAxvYWdi2h/yX7P0YXPZTBIadDQpM0xFVv0Vs2VHFRkeZt4Z5Gb14WB
         0c5beVDxCRZ7FKpdA9o9ICn6hgBxckzDAeByndCR3H9B2FkNkWMhOMzeE+u5cE31xbm4
         7PgLP+zP5fJAaQX3OsXWoSKEcHyMGGfIyF91xTYSFL3XDuX6nkPreKQIFWtZjIUsA3PQ
         QbT/VS3TXV+T171B4TA9LEhBaDaW233XM3ypCSOOaJTbU/N2IqwguGlv45Fl7V5Zu1go
         wJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bic/7TfMAQTKdUd8PF3NaZBg5kvtJB2URdx0ANx8XqE=;
        b=lxHpPbQkArxzmRvPOF/ZNKZHqJ8M3azc5/updvzJHv1EU84HaUoxOQl9GFNmG+uLJR
         xBux+WyhIHq1szQLu5UOQrURguXX0FIaspjx7EsQSNLnwY6mMILlb34wX1Sh96gs4C04
         ZTlBwmT3h43YOTJnhnukhtYE16Gv7VEUzVueCcOPZhxLprK51obLjWXkT+89vSOqxcR0
         jhd3vhJFjzY8Hlz+njhFNUqF21j6hncKv9HEadsXQnSSuYHynpWLLyzl3I5YGoLYYQzW
         08ZPq1iiohHnp7MzmmHwopJdFvKEO6Gg0KCE3NlHt7d8MsgLkAlLiIflLre4/RxwdLgy
         ZvFA==
X-Gm-Message-State: AOAM533Hgz1CZh3TkAGSMCnaXc84y11pWCNbySqGFdoDVuV40Dh8FYlz
        To8MU/n+iJZH+AigBVgu+CKb/7sX9D7mbM52WJlmPuiI
X-Google-Smtp-Source: ABdhPJxJZQnHTfY1ecetDV3FRFxyIcUegyehKPDGZVxZfXb55LJvxoPEMnstPGWTms+hs7NUnvGgkMdsqS3Ej1uC0DE=
X-Received: by 2002:a6b:3b53:: with SMTP id i80mr17421270ioa.203.1613499149156;
 Tue, 16 Feb 2021 10:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-3-amir73il@gmail.com>
 <20210216170154.GG21108@quack2.suse.cz>
In-Reply-To: <20210216170154.GG21108@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Feb 2021 20:12:18 +0200
Message-ID: <CAOQ4uxhwZG=aC+ZpB90Gn_5aNmQrwsJUnniWVhFXoq454vuyHA@mail.gmail.com>
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

On Tue, Feb 16, 2021 at 7:01 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 24-01-21 20:42:04, Amir Goldstein wrote:
> > Add limited support for unprivileged fanotify event listener.
> > An unprivileged event listener does not get an open file descriptor in
> > the event nor the process pid of another process.  An unprivileged event
> > listener cannot request permission events, cannot set mount/filesystem
> > marks and cannot request unlimited queue/marks.
> >
> > This enables the limited functionality similar to inotify when watching a
> > set of files and directories for OPEN/ACCESS/MODIFY/CLOSE events, without
> > requiring SYS_CAP_ADMIN privileges.
> >
> > The FAN_REPORT_DFID_NAME init flag, provide a method for an unprivileged
> > event listener watching a set of directories (with FAN_EVENT_ON_CHILD)
> > to monitor all changes inside those directories.
> >
> > This typically requires that the listener keeps a map of watched directory
> > fid to dirfd (O_PATH), where fid is obtained with name_to_handle_at()
> > before starting to watch for changes.
> >
> > When getting an event, the reported fid of the parent should be resolved
> > to dirfd and fstatsat(2) with dirfd and name should be used to query the
> > state of the filesystem entry.
> >
> > Note that even though events do not report the event creator pid,
> > fanotify does not merge similar events on the same object that were
> > generated by different processes. This is aligned with exiting behavior
> > when generating processes are outside of the listener pidns (which
> > results in reporting 0 pid to listener).
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> The patch looks mostly good to me. Just two questions:
>
> a) Remind me please, why did we decide pid isn't safe to report to
> unpriviledged listeners?

Just because the information that process X modified file Y is not an
information that user can generally obtain without extra capabilities(?)
I can add a flag FAN_REPORT_OWN_PID to make that behavior
explicit and then we can relax reporting pids later.

>
> b) Why did we decide returning open file descriptors isn't safe for
> unpriviledged listeners? Is it about FMODE_NONOTIFY?
>

Don't remember something in particular. I feels risky.

> I'm not opposed to either but I'm wondering. Also with b) old style
> fanotify events are not very useful so maybe we could just disallow all
> notification groups without FID/DFID reporting? In the future if we ever
> decide returning open fds is safe or how to do it, we can enable that group
> type for unpriviledged users. However just starting to return open fds
> later won't fly because listener has to close these fds when receiving
> events.
>

I like this option better.

Thanks,
Amir.
