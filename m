Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA71277EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 10:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLTJUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 04:20:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42036 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTJUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:20:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so9265470ljo.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3v7dxzSJEJ1yWkClVjvOyMii5LUuWGWUSQjt8LKR3wA=;
        b=cSPcVwWIVS1ArGZRrJfotRqRQooXD8MIeMchCt+DhIL0IxF/ZlKkI4jg1aAydkRK+r
         OHjXxr/DIapkkt3MnnXJ4nI+FENizI+oMHKMKTYIP6Tj2MXeJ2VBNv7kdDYCxiDXfPxV
         opo142e9QxQY7ddx+jsyPP3Szd1Sm9lS8QC5DAv+fy6YHfQo6YOVqLSyp+Pgby7SuVOq
         2FwQcbJqu73W1/GOPIPvuJ6dlp2keMafuCu6nXbClec0IN2kt5HQS3pFfbBjUujMRXN+
         3XLGcE8YGj0uBaeyPAKl14aNj4KdhovWo5mvhkCqPMGWB0fo1x5+n4NV3aFEM8aSAGyW
         dqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3v7dxzSJEJ1yWkClVjvOyMii5LUuWGWUSQjt8LKR3wA=;
        b=aTOAOUanJlHK3WEu6G6VuuHXnAtJW7dRVDFznQwiN+k+LGy8J2SIsDLt4bxzIm+k8w
         Y/0JbjdjPLssIf+mSX95h+bEtUCLgaM7bpksaxJNS9xNkiesjwFrAbs0xrRRy4mnrEP6
         T4Rzy19uMryc9KXWU4fMBf3+b9aLfzZD4FmA3fLF00alfP+v1wpUfelmOhu9llUNWnht
         5E2aew564d7F5eT0Dt7X0fwyPFXUoBe9iIDmVw4ReRP/p17h2/A5CvOwLKwvuX7KY75R
         EJXTyTlh4OQaaHLw2R3eSfmygTN5yJ4rGyWtshvQGBNA9llKFr79a1rTNsELn1vLcbWS
         qdzQ==
X-Gm-Message-State: APjAAAWdEZ/byTVWQqXe7EZpI34tuu8NHDj8fFgk802OTbTD5oFzLGrm
        ymMRmPD3H+9RXyXvMy2ZInxPTgUB15+kQYuUghjKjg==
X-Google-Smtp-Source: APXvYqzkgitfd8EblC1qDia6uilzFpgb0yD6XfXD6tjTDy/iHZuEFJgr8hb+2pI9Ng9Y4SA3O6d1QgLiQ0AXG0L6h3o=
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr9026170ljq.109.1576833618773;
 Fri, 20 Dec 2019 01:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal> <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
In-Reply-To: <CALCETrUK-SHA=sOUrBscpf+Bpxxff2L3RpXEaAfRHNnHGxa-LQ@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Fri, 20 Dec 2019 10:20:07 +0100
Message-ID: <CAHrFyr6oWgeQGS9Yh4akorWyrfdYt6j6Y6v=v9=rDVgf5TbMQg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, ealvarez@mozilla.com,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        gpascutto@mozilla.com, Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        jld@mozilla.com, LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 2:43 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Dec 18, 2019 at 3:55 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > +
> > +       if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> > +               file = ERR_PTR(-EPERM);
> > +               goto out;
> > +       }
>
> I don't think this is MODE_READ.  By copying an fd from the task, you
> can easily change its state.
>
> IMO it would be really nice if pidfd could act more like a capability

That's ultimately what I would like to get to.

> here and carry a ptrace mode, for example.  But I guess it doesn't
> right now.

It doesn't right now for mainly two reasons.
The way I think about it is that a pidfd gets a capability at process
creation time. Before v5.3 we couldn't have done that because legacy
clone() couldn't be extended anymore. Imho, this has changed with clone3().
The other reason was that the basic properties a process can be created
with right now do not lend itself to be turned into a capability. Even
if they did
suddenly treating them like such would prevent userspace from switching to
clone3() because it would regress usecases they had.
However, for new properties this is not a problem. I have some ideas around this
(e.g. spawning private processes only reapable through pidfds and auto-cleanup
if there's no pidfd anymore).
From an implementation perspective clone3() could get a __aligned_u64 caps
(naming up for debate since we don't want people to think this is equivalent
to our current capabilities) field.
Where at process creation time you could e.g. specify PIDFD_CAP_GET_FD and
only then can you use that pidfd to get file descriptors from other processes.
You still need ptrace_access() to get the actual fd of course.

Christian
