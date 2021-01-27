Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46C23061CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhA0RTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 12:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhA0RRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:17:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547FC06178B
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 09:16:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w18so1598204pfu.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eZkRAFReyCaCfsUebKjqhppx54eZqZXUA8gRquKcsPU=;
        b=dimGUWBu88dX8OdBPtqV1K4RlZBNMOe3qLaj2DFeriW0zXGvfLXQdvpDQW90G+pq8w
         p6xdN0AtXLBzz2oPtDzXqxZIr8psZaQU+lB+nDni6Zl/WIpcblkhLxycbxPAvV8te05i
         KsVIp+ePdyQmOMOK1htw20UOkkjeFnjUvviVoIEY2ofKY9lhBjfLrheC8MM/6mQmKGDo
         lgZrbx94cvm3t6pqu1kCexYTDa1cFG519/QRDEJtzXaZ7GklAYFE3S3JdLgmQXJO7Olf
         5tbc9e9YBFuaJlg9N990aaa1pAzjhautowBMkQc84YuILgD85YeIKeYhHvbjucdynQoo
         2yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eZkRAFReyCaCfsUebKjqhppx54eZqZXUA8gRquKcsPU=;
        b=OzHwTXJT3TNlVkbmrOErI7t5Sysk1zxIhu1E1YdEfrU/y4AbcGcaAfeY/rYgy33AMv
         5/l8ROWPNbvhizMzpn+ZJHsjdTFC9LdA1f3AB5URu36GSQS1syuNAVvsv+WcLwPcyB2U
         /o8Jv2p787gZliTN2Bko0bRdpZanMq9zxwU8qBwPMibMxZz5qwfP4CulUUbapH1/IVKt
         VqdjLQVRA9xNZRWVoLzdNmVpE1k+9v7u+DDfa7IkG6c5D/inKThu/DR0G41hqT5IY4Ta
         SujQEa6ZYb1M+uJpEakPQToe2uX37gy5reIFqD5bXpZd2wgcwLRtRmPiCKCXrkZgyV4L
         OLqw==
X-Gm-Message-State: AOAM530rqbttQSaEZkvY4/xB/AzsYSHEmmXaBYjZfuHnB/OMu/3gxFUW
        R/y5Fn+VDblxYNM7jVy8TL9Oo+O/bhFlyH4I2aAwgQ==
X-Google-Smtp-Source: ABdhPJxKQ8+LIsyyI6CfO9fy/6S4KtVkebVD7Kd1qkb+yv7kQN6fPglxpJCY+HhjUK+MV4uOLoP/VTT9u1mKmJvI5fg=
X-Received: by 2002:a63:724a:: with SMTP id c10mr10790208pgn.124.1611767794770;
 Wed, 27 Jan 2021 09:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20210126225138.1823266-1-kaleshsingh@google.com> <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
In-Reply-To: <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 27 Jan 2021 12:16:23 -0500
Message-ID: <CAC_TJvfuFiDSWD+ud_rJJ6zFQjYhcK1Rfqyrne4OBB4ZfJ0oMQ@mail.gmail.com>
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
To:     Jann Horn <jannh@google.com>
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
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 5:47 AM Jann Horn <jannh@google.com> wrote:
>
> +jeffv from Android
>
> On Tue, Jan 26, 2021 at 11:51 PM Kalesh Singh <kaleshsingh@google.com> wr=
ote:
> > In order to measure how much memory a process actually consumes, it is
> > necessary to include the DMA buffer sizes for that process in the memor=
y
> > accounting. Since the handle to DMA buffers are raw FDs, it is importan=
t
> > to be able to identify which processes have FD references to a DMA buff=
er.
>
> Or you could try to let the DMA buffer take a reference on the
> mm_struct and account its size into the mm_struct? That would probably
> be nicer to work with than having to poke around in procfs separately
> for DMA buffers.
>
> > Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> > /proc/<pid>/fdinfo -- both of which are only root readable, as follows:
>
> That's not quite right. They can both also be accessed by the user
> owning the process. Also, fdinfo is a standard interface for
> inspecting process state that doesn't permit reading process memory or
> manipulating process state - so I think it would be fine to permit
> access to fdinfo under a PTRACE_MODE_READ_FSCRED check, just like the
> interface you're suggesting.


Hi everyone. Thank you for the feedback.

I understand there is a deeper problem of accounting shared memory in
the kernel, that=E2=80=99s not only specific to the DMA buffers. In this ca=
se
DMA buffers, I think Jann=E2=80=99s proposal is the cleanest way to attribu=
te
the shared buffers to processes. I can respin a patch modifying fdinfo
as suggested, if this is not an issue from a security perspective.

Thanks,
Kalesh

>
>
> >   1. Do a readlink on each FD.
> >   2. If the target path begins with "/dmabuf", then the FD is a dmabuf =
FD.
> >   3. stat the file to get the dmabuf inode number.
> >   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
> >
> > Android captures per-process system memory state when certain low memor=
y
> > events (e.g a foreground app kill) occur, to identify potential memory
> > hoggers. To include a process=E2=80=99s dmabuf usage as part of its mem=
ory state,
> > the data collection needs to be fast enough to reflect the memory state=
 at
> > the time of such events.
> >
> > Since reading /proc/<pid>/fd/ and /proc/<pid>/fdinfo/ requires root
> > privileges, this approach is not suitable for production builds.
>
> It should be easy to add enough information to /proc/<pid>/fdinfo/ so
> that you don't need to look at /proc/<pid>/fd/ anymore.
>
> > Granting
> > root privileges even to a system process increases the attack surface a=
nd
> > is highly undesirable. Additionally this is slow as it requires many
> > context switches for searching and getting the dma-buf info.
>
> What do you mean by "context switches"? Task switches or kernel/user
> transitions (e.g. via syscall)?
>
> > With the addition of per-buffer dmabuf stats in sysfs [1], the DMA buff=
er
> > details can be queried using their unique inode numbers.
> >
> > This patch proposes adding a /proc/<pid>/task/<tid>/dmabuf_fds interfac=
e.
> >
> > /proc/<pid>/task/<tid>/dmabuf_fds contains a list of inode numbers for
> > every DMA buffer FD that the task has. Entries with the same inode
> > number can appear more than once, indicating the total FD references
> > for the associated DMA buffer.
> >
> > If a thread shares the same files as the group leader then its
> > dmabuf_fds file will be empty, as these dmabufs are reported by the
> > group leader.
> >
> > The interface requires PTRACE_MODE_READ_FSCRED (same as /proc/<pid>/map=
s)
> > and allows the efficient accounting of per-process DMA buffer usage wit=
hout
> > requiring root privileges. (See data below)
>
> I'm not convinced that introducing a new procfs file for this is the
> right way to go. And the idea of having to poke into multiple
> different files in procfs and in sysfs just to be able to compute a
> proper memory usage score for a process seems weird to me. "How much
> memory is this process using" seems like the kind of question the
> kernel ought to be able to answer (and the kernel needs to be able to
> answer somewhat accurately so that its own OOM killer can do its job
> properly)?
