Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC8F3058D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhA0KvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 05:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhA0Ksu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:48:50 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54503C06178C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 02:47:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t12so1521705ljc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nt9pdiLty5VAzHiVzQ9Z0VE2Bkzi2Zy4BkFRJGQTy+s=;
        b=RkI69ax2YOOuKLnURhraOk6rkuVkZAdIrcLC8ROzb78X3XKcsHv7ZkY1MlD4SJgGMv
         mvSeWdPu6cvDFRvCbp1iTBbLA1Zl8F7eXpM479ayN+NeCBRjUZ9u4HUy3EzFV1sYTJcy
         PYB/fNUbJlr64E477+47TxBf7b4ryCO7tAewLY6czi6NhEMjHxiI15j/4hIaqSUmrqvt
         hnkovTZkaCRWB504JvBAbJB02VSyoiNAOfs8HPotmXVpd8A4rbeS6mMZhro1+rQDyfcn
         ljPWQoMwPkLz6Wc1OU0ppRL02EqrNXZCGQXG1ygbkLlN+Jif1Tk4RsoVvqn8fhhDYg0j
         bsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nt9pdiLty5VAzHiVzQ9Z0VE2Bkzi2Zy4BkFRJGQTy+s=;
        b=hJin9K/l+oKRx+3FusJaD7eUoblzjbMpCkndc5qwa1p6tkwcvatEBfN/W3CG/km1Be
         clzpatgcRyF/6oVLZl83Z4a2w7wm0BZsjb3ohCYigr+8SfM2zCUT97tpg2xNhz4rClHi
         OCXWTkFbHMU8EscOZxFqQJzsVC/VQEilXyzRUZeUJc6zuW4vcR+BeyCcDiWj5oEdK71Q
         rzN61LxXiyc06IkR1CMsKfv7jTut3iBWW9BdTH0d60XiEQDNdl1szXkNidF0cUNQmzKB
         aBcNRAJk4VyWrMUi8gWpY7oB/q2kxtpKP8mnaFjRCfWNHJ6LSBGZ+0z1foQn9++c4FUn
         u9qQ==
X-Gm-Message-State: AOAM530ejncW29ynslV1Mk3k2tlRsrfX3HvLb8/ewLzR5HoHb4u06rjo
        6w2Byn7kTptVO5zl4m6wa1UDlikQXqCAQfXOBClAAA==
X-Google-Smtp-Source: ABdhPJwad4Dbjby0b67biXG1UmzBFT032qoQOR80f/hQK6P7qLf8Q2hmv4TTfsdOlkWpWnRX5IIbsSeyI8gxECdjNcI=
X-Received: by 2002:a2e:908e:: with SMTP id l14mr5465324ljg.226.1611744476438;
 Wed, 27 Jan 2021 02:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20210126225138.1823266-1-kaleshsingh@google.com>
In-Reply-To: <20210126225138.1823266-1-kaleshsingh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Jan 2021 11:47:29 +0100
Message-ID: <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        kernel-team <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, Hui Su <sh_def@163.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+jeffv from Android

On Tue, Jan 26, 2021 at 11:51 PM Kalesh Singh <kaleshsingh@google.com> wrot=
e:
> In order to measure how much memory a process actually consumes, it is
> necessary to include the DMA buffer sizes for that process in the memory
> accounting. Since the handle to DMA buffers are raw FDs, it is important
> to be able to identify which processes have FD references to a DMA buffer=
.

Or you could try to let the DMA buffer take a reference on the
mm_struct and account its size into the mm_struct? That would probably
be nicer to work with than having to poke around in procfs separately
for DMA buffers.

> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both of which are only root readable, as follows:

That's not quite right. They can both also be accessed by the user
owning the process. Also, fdinfo is a standard interface for
inspecting process state that doesn't permit reading process memory or
manipulating process state - so I think it would be fine to permit
access to fdinfo under a PTRACE_MODE_READ_FSCRED check, just like the
interface you're suggesting.

>   1. Do a readlink on each FD.
>   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD=
.
>   3. stat the file to get the dmabuf inode number.
>   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
>
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. To include a process=E2=80=99s dmabuf usage as part of its memor=
y state,
> the data collection needs to be fast enough to reflect the memory state a=
t
> the time of such events.
>
> Since reading /proc/<pid>/fd/ and /proc/<pid>/fdinfo/ requires root
> privileges, this approach is not suitable for production builds.

It should be easy to add enough information to /proc/<pid>/fdinfo/ so
that you don't need to look at /proc/<pid>/fd/ anymore.

> Granting
> root privileges even to a system process increases the attack surface and
> is highly undesirable. Additionally this is slow as it requires many
> context switches for searching and getting the dma-buf info.

What do you mean by "context switches"? Task switches or kernel/user
transitions (e.g. via syscall)?

> With the addition of per-buffer dmabuf stats in sysfs [1], the DMA buffer
> details can be queried using their unique inode numbers.
>
> This patch proposes adding a /proc/<pid>/task/<tid>/dmabuf_fds interface.
>
> /proc/<pid>/task/<tid>/dmabuf_fds contains a list of inode numbers for
> every DMA buffer FD that the task has. Entries with the same inode
> number can appear more than once, indicating the total FD references
> for the associated DMA buffer.
>
> If a thread shares the same files as the group leader then its
> dmabuf_fds file will be empty, as these dmabufs are reported by the
> group leader.
>
> The interface requires PTRACE_MODE_READ_FSCRED (same as /proc/<pid>/maps)
> and allows the efficient accounting of per-process DMA buffer usage witho=
ut
> requiring root privileges. (See data below)

I'm not convinced that introducing a new procfs file for this is the
right way to go. And the idea of having to poke into multiple
different files in procfs and in sysfs just to be able to compute a
proper memory usage score for a process seems weird to me. "How much
memory is this process using" seems like the kind of question the
kernel ought to be able to answer (and the kernel needs to be able to
answer somewhat accurately so that its own OOM killer can do its job
properly)?
