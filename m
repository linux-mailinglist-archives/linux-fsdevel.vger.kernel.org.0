Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE153A977
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiFAO6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFAO6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:58:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F6F579BD
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 07:58:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so2714974wrg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bcxJZOoEGdj9HHyfjULCcOOxYPoZGRjHpoFm81lNVOs=;
        b=P+A7Ep4P+FL+NTqEOtoX8UyZXTOoMsHDrPThvBn0p2XBWcLvNZFCRF7csyce5aJIgC
         /9J8TqZFKIKxg2L9BWSFt0+g/QdglYWeGwGr9vBpkG6lvUtwe24zixvQnaVAwqK2LTTw
         1epOyxU982uVJ8EcAUJAU6U9HLFl24Deyae4kvazM0NpvT9iCnL1FaKKzMmKp4f/M2Cf
         KtruZqQI5Mxe/3mT8Qb8rfG3YG75gK3bweRHBCVUOlHWwTfHTMSj3dbyzs0XWy9/z5XF
         jQKHq1dd7J3P8yVThLPD9s+w3k5yM1y6Z2oMhGM33BXvo/V2LfUPw0tyLQzHiaLK66HC
         0syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bcxJZOoEGdj9HHyfjULCcOOxYPoZGRjHpoFm81lNVOs=;
        b=1s90zg+6iqPBKgVzx0Ay/wrwGN4uqRAtCEsvTGhzCRBf493H7yGfaorW+z9hUsEm8L
         Y3hhBWV+4mM2YZB4geNg6H9nhUJrWi2L97fnxKzMv6jFSxtsgtwhj1YP0IuYxKNpaZI5
         EChKq8ow+AiSGQwCyJI7o/cPiyyzzilAmU8+DGiKvuR/VkREfa7bpNCgs3H0NfQTfFDO
         wGz96eFQONicnS5HgdmDWDPA4aULk0wKI/3LDyaAVDK/eYQw5SVxf1Q5EH4J2f1rm+cO
         9yEO24X52+84X7qjIOhkYkplF3AU3glTGqpb+kEArRuNYL4cWInGn5IvZEyCGiaAf7kd
         bA8g==
X-Gm-Message-State: AOAM530W2oJkZ6XMBWVDvSoDq/HiOk8eivJd9FjreIXwLVkXlQbl56Kv
        Xau8urPcycMg9r1ifjmYnTTMItrn15YyQtwk6UQRRw==
X-Google-Smtp-Source: ABdhPJwGBhJdLWicc8l4yIAJBeULOWR4YtzFjOWhqpz0EB4Y0mtAJ7jVfp5UnN5oAyj8L/4fmel35fvjSN1Ws9Bq2yA=
X-Received: by 2002:a05:6000:71b:b0:20e:ed96:e976 with SMTP id
 bs27-20020a056000071b00b0020eed96e976mr178409wrb.500.1654095506747; Wed, 01
 Jun 2022 07:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220531212521.1231133-1-kaleshsingh@google.com>
 <20220531212521.1231133-2-kaleshsingh@google.com> <78efbada-6dd5-ead7-fc10-38b5e1e92fc5@amd.com>
In-Reply-To: <78efbada-6dd5-ead7-fc10-38b5e1e92fc5@amd.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 1 Jun 2022 07:58:15 -0700
Message-ID: <CAC_TJve6CTA-ssG9zJm2_=MJqRhCqV7Bwgz1YiSH7RVVy+pg4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] procfs: Add 'size' to /proc/<pid>/fdinfo/
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
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

On Wed, Jun 1, 2022 at 6:55 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 31.05.22 um 23:25 schrieb Kalesh Singh:
> > To be able to account the amount of memory a process is keeping pinned
> > by open file descriptors add a 'size' field to fdinfo output.
> >
> > dmabufs fds already expose a 'size' field for this reason, remove this
> > and make it a common field for all fds. This allows tracking of
> > other types of memory (e.g. memfd and ashmem in Android).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> At least for the DMA-buf part feel free to add an Reviewed-by: Christian
> K=C3=B6nig <christian.koenig@amd.com> for this.

Thanks for the review, Christian.

--Kalesh

>
> Regards,
> Christian.
>
> > ---
> >
> > Changes from rfc:
> >    - Split adding 'size' and 'path' into a separate patches, per Christ=
ian
> >    - Split fdinfo seq_printf into separate lines, per Christian
> >    - Fix indentation (use tabs) in documentaion, per Randy
> >
> >   Documentation/filesystems/proc.rst | 12 ++++++++++--
> >   drivers/dma-buf/dma-buf.c          |  1 -
> >   fs/proc/fd.c                       |  9 +++++----
> >   3 files changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 1bc91fb8c321..779c05528e87 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1886,13 +1886,14 @@ if precise results are needed.
> >   3.8 /proc/<pid>/fdinfo/<fd> - Information about opened file
> >   ---------------------------------------------------------------
> >   This file provides information associated with an opened file. The re=
gular
> > -files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> > +files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', an=
d 'size'.
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
> > +the file, and 'size' represents the size of the file in bytes.
> >
> >   A typical output is::
> >
> > @@ -1900,6 +1901,7 @@ A typical output is::
> >       flags:  0100002
> >       mnt_id: 19
> >       ino:    63107
> > +     size:   0
> >
> >   All locks associated with a file descriptor are shown in its fdinfo t=
oo::
> >
> > @@ -1917,6 +1919,7 @@ Eventfd files
> >       flags:  04002
> >       mnt_id: 9
> >       ino:    63107
> > +     size:   0
> >       eventfd-count:  5a
> >
> >   where 'eventfd-count' is hex value of a counter.
> > @@ -1930,6 +1933,7 @@ Signalfd files
> >       flags:  04002
> >       mnt_id: 9
> >       ino:    63107
> > +     size:   0
> >       sigmask:        0000000000000200
> >
> >   where 'sigmask' is hex value of the signal mask associated
> > @@ -1944,6 +1948,7 @@ Epoll files
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +     size:   0
> >       tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:6=
1af sdev:7
> >
> >   where 'tfd' is a target file descriptor number in decimal form,
> > @@ -1962,6 +1967,7 @@ For inotify files the format is the following::
> >       flags:  02000000
> >       mnt_id: 9
> >       ino:    63107
> > +     size:   0
> >       inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fha=
ndle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
> >
> >   where 'wd' is a watch descriptor in decimal form, i.e. a target file
> > @@ -1985,6 +1991,7 @@ For fanotify files the format is::
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +     size:   0
> >       fanotify flags:10 event-flags:0
> >       fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
> >       fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:4000=
0000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> > @@ -2010,6 +2017,7 @@ Timerfd files
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +     size:   0
> >       clockid: 0
> >       ticks: 0
> >       settime flags: 01
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 32f55640890c..5f2ae38c960f 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -378,7 +378,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m,=
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
> > index 913bef0d2a36..464bc3f55759 100644
> > --- a/fs/proc/fd.c
> > +++ b/fs/proc/fd.c
> > @@ -54,10 +54,11 @@ static int seq_show(struct seq_file *m, void *v)
> >       if (ret)
> >               return ret;
> >
> > -     seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n"=
,
> > -                (long long)file->f_pos, f_flags,
> > -                real_mount(file->f_path.mnt)->mnt_id,
> > -                file_inode(file)->i_ino);
> > +     seq_printf(m, "pos:\t%lli\n", (long long)file->f_pos);
> > +     seq_printf(m, "flags:\t0%o\n", f_flags);
> > +     seq_printf(m, "mnt_id:\t%i\n", real_mount(file->f_path.mnt)->mnt_=
id);
> > +     seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
> > +     seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_siz=
e);
> >
> >       /* show_fd_locks() never deferences files so a stale value is saf=
e */
> >       show_fd_locks(m, file, files);
>
