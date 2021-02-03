Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33C30E43D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 21:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBCUu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 15:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhBCUuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:50:22 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA32C061573
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 12:49:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o16so575695pgg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 12:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=M8lFoGv6mHlkS4pfcEZxXT0GjlBrKSHlOVSDDjgilMk=;
        b=rM1xvLKChJbMhPiPxDWEcePASMy0cf8HeErbywGhn2uz/vxUt3AWciE3Uj63Z9rkey
         3clwXdhoaZ9tcupljd+xCp/yiRwzX/ekcHuZsIbhXa17Qm+44qBkGfi0JFpr2BfLDeUP
         uL4Jo+ge5eJYzKr58jmA5TrlIeovIVSgJdXR6bfIIoYV+m7rgmaz3WLeyQzZxEEjpNnU
         UNyxblr37Vse2cJev1TBfQXLjVuw5otZVV5JNNT8jZRq/IIGsHa9JjamNNJP/gdZTaZo
         +iWKjsNqQHVX2hrRwm0Ki4jIyyS7RT2xYbuq6koIXVc5C5NFulhXVP9qaCbJ3Xt/zb+N
         PvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=M8lFoGv6mHlkS4pfcEZxXT0GjlBrKSHlOVSDDjgilMk=;
        b=nCIvtCnmXn960TYCai2pp32MQEAA0Xr3agAn4Vgy2vLcFjukgDhZ6PnGUdVjMjMokL
         KZOX+a5xew0HO/DDF2l8P5T2GBdEVHkbczc/y4LwNa0XGDqObvc/9ZH9VGVapvOU4zsI
         DyXYv+LD3bv3q61ZRJs50fFTybfTGRfHecY4X36f88fRCRG8QYAzpenpQY1iNE8kmRCe
         WQ73vOHuH+GkRHz/Gnze4C9bYUxtHvmB7adSL3PZZpGWgtT2Siq84aWmykPmW4e5YrSC
         5TrBq2d+MBmLm6vZBkHk7HvrwlQETm4a+yz266rUEbVoQ7r4gOQVxpjOhgSGrTMXntzm
         5/Rg==
X-Gm-Message-State: AOAM532ATmDmwZg1Hbh8HqwmZZhJONWcngRt1zradxgcIlWAtJrwVQYP
        AgjPAiNSws5eFnbJ/ooBi5ia1VPpbOljcVq6AR6UrQ==
X-Received: by 2002:aa7:910a:0:b029:1c8:9947:305c with SMTP id
 10-20020aa7910a0000b02901c89947305cmt3620828pfh.75.1612385380012; Wed, 03 Feb
 2021 12:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20210128182432.2216573-1-kaleshsingh@google.com>
In-Reply-To: <20210128182432.2216573-1-kaleshsingh@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 3 Feb 2021 15:49:27 -0500
Message-ID: <CAC_TJvdUN27PsjnehS03UQB=LdQUo9KJK=q1bgxJnZh2FJzXjw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow reading process DMA buf stats from fdinfo
Cc:     Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Kees Cook <keescook@chromium.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 1:24 PM Kalesh Singh <kaleshsingh@google.com> wrote=
:
>
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. In order to measure how much memory a process actually consumes,
> it is necessary to include the DMA buffer sizes for that process in the
> memory accounting. Since the handle to DMA buffers are raw FDs, it is
> important to be able to identify which processes have FD references to
> a DMA buffer.
>
> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both are only readable by the process owner,
> as follows:
>   1. Do a readlink on each FD.
>   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD=
.
>   3. stat the file to get the dmabuf inode number.
>   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
>
> Accessing other processes=E2=80=99 fdinfo requires root privileges. This =
limits
> the use of the interface to debugging environments and is not suitable
> for production builds.  Granting root privileges even to a system process
> increases the attack surface and is highly undesirable.
>
> This series proposes making the requirement to read fdinfo less strict
> with PTRACE_MODE_READ.
>

Hi everyone,

I will send v2 of this patch series. Please let me know if you have
any other comments or feedback, that should be addressed in the new
version.

Thanks,
Kalesh

> Kalesh Singh (2):
>   procfs: Allow reading fdinfo with PTRACE_MODE_READ
>   dmabuf: Add dmabuf inode no to fdinfo
>
>  drivers/dma-buf/dma-buf.c |  1 +
>  fs/proc/base.c            |  4 ++--
>  fs/proc/fd.c              | 15 ++++++++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)
>
> --
> 2.30.0.365.g02bc693789-goog
>
