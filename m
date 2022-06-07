Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB4540310
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiFGPx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbiFGPxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:53:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502A2613B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 08:52:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so22221757ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pufS40r/uX2ZtSB9s8FIZ6SlwwrSkU1jYicxPJP0Dvk=;
        b=EI/3FnfDm7xULUdj70TuQ6pbIIND9Ooo8uGbWhUrAbDTViCBtm4wpTdixdKFNo4aCK
         f1yE8jNnKNNOTXbuS4EI/9GbcqVUEVRKTQAMSj3vIvvF7eKo91aVzAsh+nLIzVm54tDG
         z01TQWwsfS6Mcq+/5BW/nW49mcHHd4TAfDhm5S3Bd3Ge5bxjx8cLjrLZ2URBEjFD9ZrX
         ZQ+oyGHvCBvbSRIasswi2yzcD8CmeiaKpp1BdunZwyBJmGWKE5c8hKDc4LWDi+6Wy66h
         urZhDietLh4l7fsCWLfQixf/BNyrrizYPXwqKUq0kF6CmoqighGAY+ed/Cz//ADdglzR
         FC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pufS40r/uX2ZtSB9s8FIZ6SlwwrSkU1jYicxPJP0Dvk=;
        b=37lGnl2SZlDxR9fbL2UzmJWyt8+YUfafajaLo+brHC7c5P2fDrV7Bdh6GaPF1bQfzK
         FNCoV3dt219kgkOHjE/w3JnW36Zgjoqfvt04Rlpl4g+4Q2o+Nr3mmji/xJzz81Pnl0tH
         75ZwK/y6pHSZb84lcPdq9/GKDn9uzvom5nOs9NjbF7MhxhrubkKk5Vae0UZDaNh+Vi6t
         jJEGvL9hoQvReIAN439rL/v4b+BTBcdsrL98If2NTvmDFPInGQq3y/alUs3qo557X+g0
         BwQHNfc45aY8++UUNkpt04ctTJznWWB/UxBmdZnxeAWmk/rAYexSc3mfw1fFk4i7g8qL
         umPA==
X-Gm-Message-State: AOAM5303jxtAmiEpZGly49dvOKU0agNImitHy/4rH4YSZxErpuCmuAxR
        0w4TiOPhn3L6TSHBT7rRkpVwPrsGkhy+qH+1rUrEPw==
X-Google-Smtp-Source: ABdhPJzJd85uN4waRQ5S7rEJKLXqx9BZbE/tIhMePQ2Jb2RkKVtxHLi3crqOpmq8r60CdWOGHPfuTeN5wRlBGvmHDeo=
X-Received: by 2002:a17:907:90c8:b0:711:c8e1:7109 with SMTP id
 gk8-20020a17090790c800b00711c8e17109mr12331055ejb.492.1654617176082; Tue, 07
 Jun 2022 08:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-2-pasha.tatashin@soleen.com> <Yp1qO70pdxLx4h1H@MiWiFi-R3L-srv>
In-Reply-To: <Yp1qO70pdxLx4h1H@MiWiFi-R3L-srv>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 7 Jun 2022 11:52:18 -0400
Message-ID: <CA+CK2bACmbW9saepkMy6G5FtssBhCv2NsoLGeFdF0XosKg5A-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to ssize_t
To:     Baoquan He <bhe@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com,
        Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 5, 2022 at 10:45 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > Currently, the maximum file size that is supported is 2G. This may be
> > too small in some cases. For example, kexec_file_load() system call
> > loads initramfs. In some netboot cases initramfs can be rather large.
> >
> > Allow to use up-to ssize_t bytes. The callers still can limit the
> > maximum file size via buf_size.
>
> If we really met initramfs bigger than 2G, it's reasonable to increase
> the limit. While wondering why we should take sszie_t, but not size_t.

ssize_t instead of size_t so we can return errors as negative values.

Pasha

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
> >  include/linux/kernel_read_file.h | 32 +++++++++++++--------------
> >  include/linux/limits.h           |  1 +
> >  3 files changed, 36 insertions(+), 35 deletions(-)
> >
> > diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> > index 1b07550485b9..5d826274570c 100644
> > --- a/fs/kernel_read_file.c
> > +++ b/fs/kernel_read_file.c
> > @@ -29,15 +29,15 @@
> >   * change between calls to kernel_read_file().
> >   *
> >   * Returns number of bytes read (no single read will be bigger
> > - * than INT_MAX), or negative on error.
> > + * than SSIZE_MAX), or negative on error.
> >   *
> >   */
> > -int kernel_read_file(struct file *file, loff_t offset, void **buf,
> > -                  size_t buf_size, size_t *file_size,
> > -                  enum kernel_read_file_id id)
> > +ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
> > +                      size_t buf_size, size_t *file_size,
> > +                      enum kernel_read_file_id id)
> >  {
> >       loff_t i_size, pos;
> > -     size_t copied;
> > +     ssize_t copied;
> >       void *allocated = NULL;
> >       bool whole_file;
> >       int ret;
> > @@ -58,7 +58,7 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
> >               goto out;
> >       }
> >       /* The file is too big for sane activities. */
> > -     if (i_size > INT_MAX) {
> > +     if (i_size > SSIZE_MAX) {
> >               ret = -EFBIG;
> >               goto out;
> >       }
> > @@ -124,12 +124,12 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file);
> >
> > -int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> > -                            size_t buf_size, size_t *file_size,
> > -                            enum kernel_read_file_id id)
> > +ssize_t kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> > +                                size_t buf_size, size_t *file_size,
> > +                                enum kernel_read_file_id id)
> >  {
> >       struct file *file;
> > -     int ret;
> > +     ssize_t ret;
> >
> >       if (!path || !*path)
> >               return -EINVAL;
> > @@ -144,14 +144,14 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> >
> > -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > -                                   void **buf, size_t buf_size,
> > -                                   size_t *file_size,
> > -                                   enum kernel_read_file_id id)
> > +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > +                                       void **buf, size_t buf_size,
> > +                                       size_t *file_size,
> > +                                       enum kernel_read_file_id id)
> >  {
> >       struct file *file;
> >       struct path root;
> > -     int ret;
> > +     ssize_t ret;
> >
> >       if (!path || !*path)
> >               return -EINVAL;
> > @@ -171,12 +171,12 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
> >
> > -int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> > -                          size_t buf_size, size_t *file_size,
> > -                          enum kernel_read_file_id id)
> > +ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
> > +                              size_t buf_size, size_t *file_size,
> > +                              enum kernel_read_file_id id)
> >  {
> >       struct fd f = fdget(fd);
> > -     int ret = -EBADF;
> > +     ssize_t ret = -EBADF;
> >
> >       if (!f.file || !(f.file->f_mode & FMODE_READ))
> >               goto out;
> > diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> > index 575ffa1031d3..90451e2e12bd 100644
> > --- a/include/linux/kernel_read_file.h
> > +++ b/include/linux/kernel_read_file.h
> > @@ -35,21 +35,21 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
> >       return kernel_read_file_str[id];
> >  }
> >
> > -int kernel_read_file(struct file *file, loff_t offset,
> > -                  void **buf, size_t buf_size,
> > -                  size_t *file_size,
> > -                  enum kernel_read_file_id id);
> > -int kernel_read_file_from_path(const char *path, loff_t offset,
> > -                            void **buf, size_t buf_size,
> > -                            size_t *file_size,
> > -                            enum kernel_read_file_id id);
> > -int kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > -                                   void **buf, size_t buf_size,
> > -                                   size_t *file_size,
> > -                                   enum kernel_read_file_id id);
> > -int kernel_read_file_from_fd(int fd, loff_t offset,
> > -                          void **buf, size_t buf_size,
> > -                          size_t *file_size,
> > -                          enum kernel_read_file_id id);
> > +ssize_t kernel_read_file(struct file *file, loff_t offset,
> > +                      void **buf, size_t buf_size,
> > +                      size_t *file_size,
> > +                      enum kernel_read_file_id id);
> > +ssize_t kernel_read_file_from_path(const char *path, loff_t offset,
> > +                                void **buf, size_t buf_size,
> > +                                size_t *file_size,
> > +                                enum kernel_read_file_id id);
> > +ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
> > +                                       void **buf, size_t buf_size,
> > +                                       size_t *file_size,
> > +                                       enum kernel_read_file_id id);
> > +ssize_t kernel_read_file_from_fd(int fd, loff_t offset,
> > +                              void **buf, size_t buf_size,
> > +                              size_t *file_size,
> > +                              enum kernel_read_file_id id);
> >
> >  #endif /* _LINUX_KERNEL_READ_FILE_H */
> > diff --git a/include/linux/limits.h b/include/linux/limits.h
> > index b568b9c30bbf..f6bcc9369010 100644
> > --- a/include/linux/limits.h
> > +++ b/include/linux/limits.h
> > @@ -7,6 +7,7 @@
> >  #include <vdso/limits.h>
> >
> >  #define SIZE_MAX     (~(size_t)0)
> > +#define SSIZE_MAX    ((ssize_t)(SIZE_MAX >> 1))
> >  #define PHYS_ADDR_MAX        (~(phys_addr_t)0)
> >
> >  #define U8_MAX               ((u8)~0U)
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
>
