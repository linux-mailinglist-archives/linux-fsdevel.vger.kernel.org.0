Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260873C63FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhGLTsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhGLTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:48:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB8C0613E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 12:46:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a127so17393805pfa.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=izReUsFSnW2KAtNEGF3f28+bNVRxftAoovKaDAlS05k=;
        b=ccvnfNHi8QwmLN8NpuKKeAFBp5bauedhz6K5/rZ+hane5/bRL/zrYGMd1imY49TqSB
         b0h3VdHa1NmYZQ2/knGSMexYzzzpBuCI1MrGKl4I2bvB9kGxa6NsVxhzz+VG1tqc3aSA
         XGJ/7GkJGRtsF7GayEfIAm6OLEzsDH3QL2FFFa/grJy4XK6ud1V6mZIDurZTHuKaA2HN
         7J44aesiNPBSc9yvo8LO/TZn45e1gPpN1+Gr5DM0zd3ZyHjQfKQt16McOSzWUyjcfQ9E
         H2BoM3K9oqUCR/gqFbkIJcF2LkX7rwp3QFSwaSMzxPzN4+BS0HinQ+dgxWv+CZXwnJ3e
         6aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=izReUsFSnW2KAtNEGF3f28+bNVRxftAoovKaDAlS05k=;
        b=AP7xctu1d2AlNxruKSzQingjQq4qt6khIUWlGuz/S3ppYmDSTu8AaXaE5aFMzkC47A
         pWON4JUz2jfTATFbXG5O+sw7zgQ9ClfIb+PUZJd4/ZWdFlLAPoIFcjAzRqLKuS3hfrkS
         JHk4IgNsusbGql6n9qspBDsHyzjZfnBhlNRt8/vdB3b+rRyKcOAknpWZYLDm8ooEtoAU
         wZrd0CH0CW17HUXbalFqBkZfvj+1V+EK5nY9D2a0I5FqbFp5yffeo/x+leoVPU44nOYv
         IozXcPDka0wT4YIOn+YA2HRxpaUzGYTAbiuU+uR2jbWq3bXwp3DnGrdhihVhNHNfWrzl
         HIAQ==
X-Gm-Message-State: AOAM532vetuR1GgMJZtnUI5hxxJxymv8YMCiQqQMgQqn5TljttuLbJmY
        TS9dpbXKYbD2TXhSGAo+zXwS/Gm6uz9WzM0GxKmZfQ==
X-Google-Smtp-Source: ABdhPJzaU7hq7i25/r9ogvTlHBE+8LCgSumyTj16i0E+PKcsefNqt87b4cbEppQaDhI76H7OHWrkqQTIM/JKg7EwKbI=
X-Received: by 2002:a65:6412:: with SMTP id a18mr654516pgv.445.1626119162849;
 Mon, 12 Jul 2021 12:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210708155647.44208-1-kaleshsingh@google.com> <CAHk-=whDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn-d+g@mail.gmail.com>
In-Reply-To: <CAHk-=whDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn-d+g@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 12 Jul 2021 12:45:51 -0700
Message-ID: <CAC_TJvfAsaM3AbK+P5PnYeNhKE-gXK6iL0WLURcJ0QSTGuYhwQ@mail.gmail.com>
Subject: Re: [PATCH] procfs: Prevent unpriveleged processes accessing fdinfo
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 10, 2021 at 11:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jul 8, 2021 at 8:57 AM Kalesh Singh <kaleshsingh@google.com> wrot=
e:
> >
> > The file permissions on the fdinfo dir from were changed from
> > S_IRUSR|S_IXUSR to S_IRUGO|S_IXUGO, and a PTRACE_MODE_READ check was
> > added for opening the fdinfo files [1]. However, the ptrace permission
> > check was not added to the directory, allowing anyone to get the open F=
D
> > numbers by reading the fdinfo directory.
> >
> > Add the missing ptrace permission check for opening the fdinfo director=
y.
>
> The more I look at this, the more I feel like we should look at
> instead changing how "get_proc_task()" works.
>
> That's one of the core functions for /proc, and I wonder if we
> couldn't just make it refuse to look up a task that has gone through a
> suid execve() since the proc inode was opened.
>
> I don't think it's basically ever ok to open something for one thread,
> and then use it after the thread has gone through a suid thing.
>
> In fact, I wonder if we could make it even stricter, and go "any exec
> at all", but I think a suid exec might be the minimum we should do.
>
> Then the logic really becomes very simple: we did the permission
> checks at open time (like UNIX permission checks should be done), and
> "get_proc_task()" basically verifies that "yeah, that open-time
> decision is still valid".
>
> Wouldn't that make a lot of sense?

I think checking that the last open is after the last exec works, but
there are a few cases I=E2=80=99m not clear on:

Process A opens /proc/A/*/<file>. (Given it has the required
permissions - checked in open())

        Process A Start exec time =3D T1
        Proc inode open time /proc/A/*/<file>  =3D T2

T2 > T1: --> Process A can access /proc/A/*/<file> (FD 4)  -- OK


Process A does a fork and exec Process B

        Process B Start exec time =3D T3
        Proc inode open time /proc/A/*/<file>  =3D T2

T2 < T3: --> Process B can=E2=80=99t access /proc/A/*/<file> (by the copied=
 FD 4) -- OK


Process B opens /proc/B/*/<file> (Given it has the required
permissions - checked in open())

        Process B Start exec time =3D T3
        Proc inode open time /proc/B/*/<file>  =3D T4.

T4 > T3: --> Process B can access /proc/B/*/<file> (FD 5)  -- OK


Process A opens /proc/A/*/<file> (Given it has the required
permissions - checked in open())

        Process A Start exec time =3D T1
        Proc inode open time /proc/A/*/<file>  =3D T5.

T5 > T1: --> Process A can access /proc/A/*/<file> (FD 5) -- OK

But,

        Process B Start exec time =3D T3
        Proc inode open time /proc/A/*/<file>  =3D T5.

T5 > T3: --> Process B can access /proc/A/*/<file> (by the copied FD
4) -- NOT OK


I think for the case above we could add a map to track the inode open
times per task at the cost of some added complexity.

For tracking the last exec times, I thought we could maybe reuse the
task_struct -> struct sched_entity se -> u64 exec_start /
sum_exec_runtime as indicators. These are relative to the task and set
to 0 on fork. But the inode open time needs to be comparable across
tasks in the case of a fork-exec as above. As I understand, we may
need a per-task field like last_exec_time, but I=E2=80=99m not sure we want=
 to
incur the extra memory overhead for adding more fields to task_struct?

Please let me know if my understanding is not correct or if there is
something I overlooked here.

Thanks,
Kalesh

>
>              Linus
