Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04F52F049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351405AbiETQNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349875AbiETQNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 12:13:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312041666A2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 09:13:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w4so12093587wrg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ipqOEuFHu2Nd21bFt01/0+/z/eZlM2I6EgR6QTamA4c=;
        b=Vi8bKKQtMJOCH6PWFXZrgIIwYCB1hRYAZN5J1IvH8FdLKxkln8YsdvvKPM736hEneU
         t2+ggDTtFOQdzEmWNu8TxsS1dlmRzZ3mQX6h2YkC5Vd4Uf3mhAp9+hBuOKNJZpo8CQZo
         umdy+46JvMpUIR5Io/nT1dTTZZ1uXG/SSQZ45xNVdZgP2Xi1dpDedndVCwQb5L5eXNaH
         gPNHNRpnzahyzEfFg3EIWwf8hFsjbQ6rzJqjE2YcZKTKsMiWwAl2sSiq5UuJpvhq4Uqz
         cSq1yEQIs9lLAZ9dFyOtH1oEBi7skSV2FcgLlF2MSOMvMgztU+TJ5EDyxxK14N0eLfYq
         whtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ipqOEuFHu2Nd21bFt01/0+/z/eZlM2I6EgR6QTamA4c=;
        b=ZmX7hSOAvXmweFyTQvItLm98pUFbaM8y+iYWDz/yzvJYLSAMMnhXQG5VmZXqUcG9nm
         ++FMWELih8qpMAjre/0XCAVC0vtX8p0NGwgS8zFcENoZ0tNRdO1kTKrbvcVTWnZLDegj
         7MvCIn4w+CH9xMhePHzcbWb55WN6lIiSGC7EounYwozhr8PPcSpDhQeRNn9Z6cgZV4eW
         pPZp4MMOQdDMIHnLoEEsULjOva3wMO7RQFkDeD0CaoBuVkeZr7BJWJKtruKxk4Krgi1q
         gT0LZ98QaBBWt5P+M7/9x+wMlcVIhVmPj8Iu8+OFw9zq2quyC7Xn4g1KtXvTwGW4C48b
         iv1A==
X-Gm-Message-State: AOAM533o70b9J0aMUviO95N56bzbOf5M1V3QMAIdyeMf/ADa8FwlSatV
        AFm9zCYNyKX5kRREyHNZIOB+2a/esqDobZKJOq+aEQ==
X-Google-Smtp-Source: ABdhPJzjmqWEsH8KmAjKreitYthaopgQb5uZCsdbBmAh580hzRoKENMPcSwBNbVBbp99jxXB145gAI0PZpVqxd2TVMA=
X-Received: by 2002:a5d:5846:0:b0:20c:7407:5fa1 with SMTP id
 i6-20020a5d5846000000b0020c74075fa1mr8871905wrf.116.1653063183383; Fri, 20
 May 2022 09:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220519214021.3572840-1-kaleshsingh@google.com> <4e35dc30-1157-50b3-e3b6-954481a0524d@amd.com>
In-Reply-To: <4e35dc30-1157-50b3-e3b6-954481a0524d@amd.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 20 May 2022 09:12:51 -0700
Message-ID: <CAC_TJvcObmm3=ZJSd9ucGF04LnO3B2U0PH=ajTorvx66rdeLBA@mail.gmail.com>
Subject: Re: [RFC PATCH] procfs: Add file path and size to /proc/<pid>/fdinfo
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Colin Cross <ccross@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 11:29 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 19.05.22 um 23:40 schrieb Kalesh Singh:
> > Processes can pin shared memory by keeping a handle to it through a
> > file descriptor; for instance dmabufs, memfd, and ashsmem (in Android).
> >
> > In the case of a memory leak, to identify the process pinning the
> > memory, userspace needs to:
> >    - Iterate the /proc/<pid>/fd/* for each process
> >    - Do a readlink on each entry to identify the type of memory from
> >      the file path.
> >    - stat() each entry to get the size of the memory.
> >
> > The file permissions on /proc/<pid>/fd/* only allows for the owner
> > or root to perform the operations above; and so is not suitable for
> > capturing the system-wide state in a production environment.
> >
> > This issue was addressed for dmabufs by making /proc/*/fdinfo/*
> > accessible to a process with PTRACE_MODE_READ_FSCREDS credentials[1]
> > To allow the same kind of tracking for other types of shared memory,
> > add the following fields to /proc/<pid>/fdinfo/<fd>:
> >
> > path - This allows identifying the type of memory based on common
> >         prefixes: e.g. "/memfd...", "/dmabuf...", "/dev/ashmem..."
> >
> >         This was not an issued when dmabuf tracking was introduced
> >         because the exp_name field of dmabuf fdinfo could be used
> >         to distinguish dmabuf fds from other types.
> >
> > size - To track the amount of memory that is being pinned.
> >
> >         dmabufs expose size as an additional field in fdinfo. Remove
> >         this and make it a common field for all fds.
> >
> > Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
> > -- the same as for /proc/<pid>/maps which also exposes the path and
> > size for mapped memory regions.
> >
> > This allows for a system process with PTRACE_MODE_READ_FSCREDS to
> > account the pinned per-process memory via fdinfo.
>
> I think this should be split into two patches, one adding the size and
> one adding the path.
>
> Adding the size is completely unproblematic, but the path might raise
> some eyebrows.

Hi Christian,

Thanks for reviewing. "path" is exposed under the same ptrace
capability as in /proc/pid/maps. If we want to be more cautious, then
perhaps only adding "path" for the applicable anon inodes (dmabuf,
memfd, ...)? But prefer to keep it generic if no one sees an issue
with that.

>
> >
> > [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flore.kernel.org%2Flkml%2F20210308170651.919148-1-kaleshsingh%40google.com%=
2F&amp;data=3D05%7C01%7Cchristian.koenig%40amd.com%7C95ee7bf71c2c4aa342fa08=
da39e03398%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637885932392014544%=
7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw=
iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dkf%2B2es12hV3z5zjOFhx3EyxI1XEMe=
HexqTLNpNoDhAY%3D&amp;reserved=3D0
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >   Documentation/filesystems/proc.rst | 22 ++++++++++++++++++++--
> >   drivers/dma-buf/dma-buf.c          |  1 -
> >   fs/proc/fd.c                       |  9 +++++++--
> >   3 files changed, 27 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 061744c436d9..ad66d78aca51 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1922,13 +1922,16 @@ if precise results are needed.
> >   3.8 /proc/<pid>/fdinfo/<fd> - Information about opened file
> >   ---------------------------------------------------------------
> >   This file provides information associated with an opened file. The re=
gular
> > -files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> > +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'si=
ze',
> > +and 'path'.
> > +
> >   The 'pos' represents the current offset of the opened file in decimal
> >   form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask=
 the
> >   file has been created with [see open(2) for details] and 'mnt_id' rep=
resents
> >   mount ID of the file system containing the opened file [see 3.5
> >   /proc/<pid>/mountinfo for details]. 'ino' represents the inode number=
 of
> > -the file.
> > +the file, 'size' represents the size of the file in bytes, and 'path'
> > +represents the file path.
> >
> >   A typical output is::
> >
> > @@ -1936,6 +1939,8 @@ A typical output is::
> >       flags:  0100002
> >       mnt_id: 19
> >       ino:    63107
> > +        size:   0
> > +        path:   /dev/null
> >
> >   All locks associated with a file descriptor are shown in its fdinfo t=
oo::
> >
> > @@ -1953,6 +1958,8 @@ Eventfd files
> >       flags:  04002
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[eventfd]
> >       eventfd-count:  5a
> >
> >   where 'eventfd-count' is hex value of a counter.
> > @@ -1966,6 +1973,8 @@ Signalfd files
> >       flags:  04002
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[signalfd]
> >       sigmask:        0000000000000200
> >
> >   where 'sigmask' is hex value of the signal mask associated
> > @@ -1980,6 +1989,8 @@ Epoll files
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[eventpoll]
> >       tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:6=
1af sdev:7
> >
> >   where 'tfd' is a target file descriptor number in decimal form,
> > @@ -1998,6 +2009,8 @@ For inotify files the format is the following::
> >       flags:  02000000
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:inotify
> >       inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fha=
ndle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
> >
> >   where 'wd' is a watch descriptor in decimal form, i.e. a target file
> > @@ -2021,6 +2034,8 @@ For fanotify files the format is::
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[fanotify]
> >       fanotify flags:10 event-flags:0
> >       fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
> >       fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:4000=
0000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> > @@ -2046,6 +2061,8 @@ Timerfd files
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[timerfd]
> >       clockid: 0
> >       ticks: 0
> >       settime flags: 01
> > @@ -2070,6 +2087,7 @@ DMA Buffer files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   32768
> > +        path:   /dmabuf:
> >       count:  2
> >       exp_name:  system-heap
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index b1e25ae98302..d61183ff3c30 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -377,7 +377,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m,=
 struct file *file)
> >   {
> >       struct dma_buf *dmabuf =3D file->private_data;
> >
> > -     seq_printf(m, "size:\t%zu\n", dmabuf->size);
> >       /* Don't count the temporary reference taken inside procfs seq_sh=
ow */
> >       seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
> >       seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
> > diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> > index 913bef0d2a36..a8a968bc58f0 100644
> > --- a/fs/proc/fd.c
> > +++ b/fs/proc/fd.c
> > @@ -54,10 +54,15 @@ static int seq_show(struct seq_file *m, void *v)
> >       if (ret)
> >               return ret;
> >
> > -     seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n"=
,
> > +     seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\ns=
ize:\t%zu\n",
> >                  (long long)file->f_pos, f_flags,
> >                  real_mount(file->f_path.mnt)->mnt_id,
> > -                file_inode(file)->i_ino);
> > +                file_inode(file)->i_ino,
> > +                file_inode(file)->i_size);
>
> We might consider splitting this into multiple seq_printf calls, one for
> each printed attribute.
>
> It becomes a bit unreadable and the minimal additional overhead
> shouldn't matter that much.

Agreed. WIll update in the next version.

Thanks,
Kalesh
>
> Regards,
> Christian.
>
> > +
> > +     seq_puts(m, "path:\t");
> > +     seq_file_path(m, file, "\n");
> > +     seq_putc(m, '\n');
> >
> >       /* show_fd_locks() never deferences files so a stale value is saf=
e */
> >       show_fd_locks(m, file, files);
> >
> > base-commit: b015dcd62b86d298829990f8261d5d154b8d7af5
>
