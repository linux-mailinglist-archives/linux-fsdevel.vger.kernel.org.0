Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78143A251F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 09:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJHPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 03:15:14 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:44954 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFJHPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:15:13 -0400
Received: by mail-io1-f46.google.com with SMTP id q3so2436280iop.11;
        Thu, 10 Jun 2021 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjDd7Uq7iGzt6/xpzWYUjJJ0G9Qh4pcbxJCp+7rmx/8=;
        b=BMf0jfbhA5qKTTS7z9TQHqUpWsqaI1kdZAlIztel355FcaFCYRix2J+77M38nLhcFr
         G6dYBvag/1jg7ATbM+AEdlzpuzieYvQzDZVpwyVvNOC0DXgE34dDTmSJsycQi/IHE3Yf
         bNPcsLMRzIF5eGRPygkuvIE1PAdK8e7u+mWZ2BWPerZRnnPxhjbFUlmC/FWQF/OcLyp9
         UkHbATU/R72uikzq5bawND8HgOV5sRQQ7hU8b1XDWkARFcDo6DilLref4ui1FMnER7/h
         GlPq958UcVMfIFC6O0pluoIeCDqGOScYdasl+K2+VBbDgcm6OwThDZrVLJFOoPg0vxKk
         vS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjDd7Uq7iGzt6/xpzWYUjJJ0G9Qh4pcbxJCp+7rmx/8=;
        b=nGbWP8mssxc5yaJRbFIkvNqF1X5vOjTj01jAUKE97/bXl/8s/a+3JKXrgOTH2d7t8p
         oNKgBF1EVdR1G4Qeg2jnGtY2tno44/dl/LcRmxS6Q9Wvm8WFt9iqBfM0Y/ZsZBGwI/zB
         PCyAWblvWDktncJ4wMQTbkUgLFbWYwyqaV5Vz50dV2D9l99q0+yb/WvVO50dZCz+UXaK
         KCl93/P5z6QsqJpCI+pUvR2s3MNn+wbMr91anwYCwaUWw0DTvpkpmEdj6IM3GEfStKBC
         ZPg+y5gfowYYi6fz+s7zTxR9xCPCQL/K5N2cuJbIOIhlR6EqSQOU2fU/+0lqBZCuf/mP
         GjRg==
X-Gm-Message-State: AOAM531lyNKm42m+maRRC9lsDeaYw4zZ6tO16/FNvj6zZ+DajzjJgtSX
        K3FZnI2QRjnC1t/8rG1ePIUbdOjgk8j5DmV1tLQ=
X-Google-Smtp-Source: ABdhPJzkx+5unvU+XObnz+HmupjYQbGxCSuX5v0IxDSzQPvAXtNp2Cv/hGkEQr2umZEOb3tFJAwvmbsJ9kPLbHE0BN0=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr2656890ioa.64.1623309122583;
 Thu, 10 Jun 2021 00:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623282854.git.repnop@google.com> <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
 <CAOQ4uxj2t+z1BWimWKKTae3saDbZQ=-h+6JSnr=Vyv1=rGT0Jw@mail.gmail.com> <YMGyrJMwpvqU2kcr@google.com>
In-Reply-To: <YMGyrJMwpvqU2kcr@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 10 Jun 2021 10:11:51 +0300
Message-ID: <CAOQ4uxhV32Qbk=uyxNEhUkdqzqspib=5FY_J6N-0HdLizDEAXA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > +               ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> > > +                                               buf, count);
> > >                 if (ret < 0)
> > > -                       return ret;
> > > +                       goto out_close_fd;
> >
> > This looks like a bug in upstream.
>
> Yes, I'm glad this was picked up and I was actually wondering why it was
> acceptable to directly return without jumping to the out_close_fd label in
> the case of an error. I felt like it may have been a burden to raise the
> question in the first place because I thought that this got picked up in
> the review already and there was a good reason for having it, despite not
> really making much sense.
>
> > It should have been goto out_close_fd to begin with.
> > We did already copy metadata.fd to user, but the read() call
> > returns an error.
> > You should probably fix it before the refactoring patch, so it
> > can be applied to stable kernels.
>
> Sure, I will send through a patch fixing this before submitting the next
> version of this series though. How do I tag the patch so that it's picked
> up an back ported accordingly?
>

The best option, in case this is a regression (it probably is)
is the Fixes: tag which is both a clear indication for stale
candidate patch tells the bots exactly which stable kernel the
patch should be applied to.

Otherwise, you can Cc: stable (see examples in git)
and generally any commit title with the right keywords
'fix' 'regression' 'bug' should be caught but the stable AI bots.

> > >         }
> > >
> > >         return metadata.event_len;
> > > @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >                 put_unused_fd(fd);
> > >                 fput(f);
> > >         }
> > > +
> > > +       if (pidfd < 0)
> >
> > That condition is reversed.
> > We do not seem to have any test coverage for this error handling
> > Not so surprising that upstream had a bug...
>
> Sorry Amir, I don't quite understand what you mean by "That condition is
> reversed". Presumably you're referring to the fd != FAN_NOFD check and not
> pidfd < 0 here.
>

IDGI, why is the init/cleanup code not as simple as

    int pidfd = FAN_NOPIDFD;
...
out_close_fd:
...
       if (pidfd >= 0)
                 put_unused_fd(fd);

What am I missing?

Thanks,
Amir.
