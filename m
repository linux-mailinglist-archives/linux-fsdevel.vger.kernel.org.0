Return-Path: <linux-fsdevel+bounces-28797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D807F96E5C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 00:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0208E1C2396A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400551A4E8B;
	Thu,  5 Sep 2024 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOYXbrz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618213D638
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575534; cv=none; b=kESSrJ23aycY0UFGTlty2GGhTwMQk81TJNZj4OGBuc9jjd/djKOLkQe2Kqd8A65uzp6B0UhXaS44YViFUO19rT2bgptDCt9c/muA9i6tHoXUQN9Qg0pGo4gbrC9ewSjbVIJJ+JUTQlfZlhClwvj/klsr3VEwmNDyYXZO8z+EutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575534; c=relaxed/simple;
	bh=WpmPpRrpocIgwXzp+9rArG4+tf0T4HsThift1WKvWJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOHhUVr7kxq8yZJbDhk7N8KZTPPjSr8iwUcdr59Upbt/fieOgV9eaa+dXU7sd9gNmkeN1Fv6KI3fit54UAiFar6vzR5LseJ3sAR1ytJZ61a/oOLh9UE/FzStEdvoUlFnQygC6TVfEhp4LywhssIOTa8+ikEQxMQ3MojLE45vGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOYXbrz5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45677965a0eso8015051cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575532; x=1726180332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSWQkdvlZMbFAKfLOn0doTCKnTEqmIuCgE2OGPUKmDY=;
        b=dOYXbrz5Y4gS3Y109hZclhaRJ5nSXu1s3skapaP7LnjsSo3MkLXKhIoMjr+MS8VFdX
         KEr4aLpSGt1ogT0nv7UBB9rbNKfLEsZ1RaqZ24Ly2pSLxPuga2xO0SMlugR5aeGo6lZc
         +m4cApr4U6G8/to4taNFgFvwIVDKdRwNCWYfhbUjovESjbQfZqudX7juHlBB3aNI47Y5
         NQShcxRJYyAszTyQqH1L+ZsuyRE5Uou7jfZx6qCQhfK/i3R1ao5z6zQiI9sutwhLP1tM
         YIEDwfEVP5Y+0lcdq3a2ZWBpwKuWvH/Ju7EMfxxswGqrvmnjXTcGxN9QXlpSOk735t3c
         sTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575532; x=1726180332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSWQkdvlZMbFAKfLOn0doTCKnTEqmIuCgE2OGPUKmDY=;
        b=RzoC7RBBSntwMXdPGp5SwUvcCkfV/ZuvxhSvWyKQl/hCrWILmysESriLexYdOXaHTu
         xtT+z5DxP1qAM66afgnbBHRES8MdnCd+p6nCVgLmFM+j+KPDQJHHNca7oqQ/ROHd1kHL
         RJBc+Q5INhqf2CMTfSdJ/HSsGw13LTxK2RnrjjSK9hqGrXCZKUoJcRUQG7CeZf84Ch04
         Z6j7ithn3MON84a22sCsfsLM1Xp8JFzDPum3WRqF+Xusey2/eViTsUsZJpDxACkTQItG
         Z996ucRYzradJACayGfSQWa4XeU4SfI5WhaUQ0eUN3faa/nPU779hsqVJ1G2Jq4Kplmk
         Ba9g==
X-Forwarded-Encrypted: i=1; AJvYcCUgBqyRUOeJR4Omgch2mI/qhLBtr0+z2b4M/filbVKXm9UJnrRT+001yada/4uKTe3dzquMlw2CNi4pnMAC@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRttmh/gNum9YgJfrDwmCYrqp5Jip90cPkcOAEcKQkQOw3Cc2
	REY4nVf95ZCLmyWI/FYF3ETbB5hFzi6Qlk6lcI/iIWScsNYglzJ/kZVCfBUacvB+qu6JuLceso1
	TceHmiPfj2LPokATDpkKAZ14XXkY=
X-Google-Smtp-Source: AGHT+IEsZAC+cmRxMs3GNBbLCqeK2TbjpgC/eugbBp9Qz/Bcpx68elOdeRN8/ytVy9hPk1iUKzd57retdGuEOK72W7o=
X-Received: by 2002:a05:622a:13ca:b0:456:8a43:e377 with SMTP id
 d75a77b69052e-4580c791fd5mr7436811cf.60.1725575531571; Thu, 05 Sep 2024
 15:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905174541.392785-1-joannelkoong@gmail.com> <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm>
In-Reply-To: <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Sep 2024 15:32:00 -0700
Message-ID: <CAJnrk1Z6R3cOMeVTaE0L1Nn4WO2K-4d3E0PY+-s_iege0PaEVA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	sweettea-kernel@dorminy.me, kernel-team@meta.com, laoji.jx@alibaba-inc.com, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:16=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 9/5/24 19:45, Joanne Koong wrote:
> > Introduce the capability to dynamically configure the fuse max pages
> > limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
> > This enhancement allows system administrators to adjust the value
> > based on system-specific requirements.
> >
> > This removes the previous static limit of 256 max pages, which limits
> > the max write size of a request to 1 MiB (on 4096 pagesize systems).
> > Having the ability to up the max write size beyond 1 MiB allows for the
> > perf improvements detailed in this thread [1].
>
> the change itself looks good to me, but have you seen this discussion her=
e?
>
> https://lore.kernel.org/lkml/CAJfpegs10SdtzNXJfj3=3DvxoAZMhksT5A1u5W5L6nK=
L-P2UOuLQ@mail.gmail.com/T/
>
>
> Miklos is basically worried about page pinning and accounting for that
> for unprivileged user processes.
>

Thanks for the link to the previous discussion, Bernd. I'll cc Xu and
Jingbo, who started that thread, to this email.

I'm curious whether this sysctl approach might mitigate those worries
here since modifying the sysctl value will require admin privileges to
explicitly opt into this. I liked Sweet Tea's comment

"Perhaps, in analogy to soft and hard limits on pipe size,
FUSE_MAX_MAX_PAGES could be increased and treated as the maximum
possible hard limit for max_write; and the default hard limit could stay
at 1M, thereby allowing folks to opt into the new behavior if they care
about the performance more than the memory?"

where something like this could let admins choose what aspects they'd
like to optimize for.

My understanding of how bigger write buffers affects pinning is that
each chunk of the write will pin a higher number of contiguous pages
at one time (but overall for the duration of the write request, the
number for total pages that get pinned are the same). My understanding
is that the pages only get pinned when we do the copying to the fuse
server's buffer (and is not pinned while the server is servicing the
request).


Thanks,
Joanne

>
> Thanks,
> Bernd
>
>
> >
> > $ sysctl -a | grep max_pages_limit
> > fs.fuse.max_pages_limit =3D 256
> >
> > $ sysctl -n fs.fuse.max_pages_limit
> > 256
> >
> > $ echo 1024 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> > 1024
> >
> > $ sysctl -n fs.fuse.max_pages_limit
> > 1024
> >
> > $ echo 65536 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> > tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument
> >
> > $ echo 0 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> > tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument
> >
> > $ echo 65535 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> > 65535
> >
> > $ sysctl -n fs.fuse.max_pages_limit
> > 65535
> >
> > v2 (original):
> > https://lore.kernel.org/linux-fsdevel/20240702014627.4068146-1-joannelk=
oong@gmail.com/
> >
> > v1:
> > https://lore.kernel.org/linux-fsdevel/20240628001355.243805-1-joannelko=
ong@gmail.com/
> >
> > Changes from v1:
> > - Rename fuse_max_max_pages to fuse_max_pages_limit internally
> > - Rename /proc/sys/fs/fuse/fuse_max_max_pages to
> >   /proc/sys/fs/fuse/max_pages_limit
> > - Restrict fuse max_pages_limit sysctl values to between 1 and 65535
> >   (inclusive)
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jeffle=
xu@linux.alibaba.com/T/#u
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  Documentation/admin-guide/sysctl/fs.rst | 10 +++++++
> >  fs/fuse/Makefile                        |  2 +-
> >  fs/fuse/fuse_i.h                        | 14 +++++++--
> >  fs/fuse/inode.c                         | 11 ++++++-
> >  fs/fuse/ioctl.c                         |  4 ++-
> >  fs/fuse/sysctl.c                        | 40 +++++++++++++++++++++++++
> >  6 files changed, 75 insertions(+), 6 deletions(-)
> >  create mode 100644 fs/fuse/sysctl.c
> >
> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/ad=
min-guide/sysctl/fs.rst
> > index 47499a1742bd..fa25d7e718b3 100644
> > --- a/Documentation/admin-guide/sysctl/fs.rst
> > +++ b/Documentation/admin-guide/sysctl/fs.rst
> > @@ -332,3 +332,13 @@ Each "watch" costs roughly 90 bytes on a 32-bit ke=
rnel, and roughly 160 bytes
> >  on a 64-bit one.
> >  The current default value for ``max_user_watches`` is 4% of the
> >  available low memory, divided by the "watch" cost in bytes.
> > +
> > +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This directory contains the following configuration options for FUSE
> > +filesystems:
> > +
> > +``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
> > +setting/getting the maximum number of pages that can be used for servi=
cing
> > +requests in FUSE.
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 6e0228c6d0cb..cd4ef3e08ebf 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -7,7 +7,7 @@ obj-$(CONFIG_FUSE_FS) +=3D fuse.o
> >  obj-$(CONFIG_CUSE) +=3D cuse.o
> >  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> >
> > -fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir=
.o ioctl.o
> > +fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir=
.o ioctl.o sysctl.o
> >  fuse-y +=3D iomode.o
> >  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> >  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index f23919610313..bb252a3ea37b 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -35,9 +35,6 @@
> >  /** Default max number of pages that can be used in a single read requ=
est */
> >  #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
> >
> > -/** Maximum of max_pages received in init_out */
> > -#define FUSE_MAX_MAX_PAGES 256
> > -
> >  /** Bias for fi->writectr, meaning new writepages must not be sent */
> >  #define FUSE_NOWRITE INT_MIN
> >
> > @@ -47,6 +44,9 @@
> >  /** Number of dentries for each connection in the control filesystem *=
/
> >  #define FUSE_CTL_NUM_DENTRIES 5
> >
> > +/** Maximum of max_pages received in init_out */
> > +extern unsigned int fuse_max_pages_limit;
> > +
> >  /** List of active connections */
> >  extern struct list_head fuse_conn_list;
> >
> > @@ -1472,4 +1472,12 @@ ssize_t fuse_passthrough_splice_write(struct pip=
e_inode_info *pipe,
> >                                     size_t len, unsigned int flags);
> >  ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct=
 *vma);
> >
> > +#ifdef CONFIG_SYSCTL
> > +extern int fuse_sysctl_register(void);
> > +extern void fuse_sysctl_unregister(void);
> > +#else
> > +#define fuse_sysctl_register()               (0)
> > +#define fuse_sysctl_unregister()     do { } while (0)
> > +#endif /* CONFIG_SYSCTL */
> > +
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 99e44ea7d875..973e58df816a 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -35,6 +35,8 @@ DEFINE_MUTEX(fuse_mutex);
> >
> >  static int set_global_limit(const char *val, const struct kernel_param=
 *kp);
> >
> > +unsigned int fuse_max_pages_limit =3D 256;
> > +
> >  unsigned max_user_bgreq;
> >  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> >                 &max_user_bgreq, 0644);
> > @@ -932,7 +934,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fu=
se_mount *fm,
> >       fc->pid_ns =3D get_pid_ns(task_active_pid_ns(current));
> >       fc->user_ns =3D get_user_ns(user_ns);
> >       fc->max_pages =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ;
> > -     fc->max_pages_limit =3D FUSE_MAX_MAX_PAGES;
> > +     fc->max_pages_limit =3D fuse_max_pages_limit;
> >
> >       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >               fuse_backing_files_init(fc);
> > @@ -2039,8 +2041,14 @@ static int __init fuse_fs_init(void)
> >       if (err)
> >               goto out3;
> >
> > +     err =3D fuse_sysctl_register();
> > +     if (err)
> > +             goto out4;
> > +
> >       return 0;
> >
> > + out4:
> > +     unregister_filesystem(&fuse_fs_type);
> >   out3:
> >       unregister_fuseblk();
> >   out2:
> > @@ -2053,6 +2061,7 @@ static void fuse_fs_cleanup(void)
> >  {
> >       unregister_filesystem(&fuse_fs_type);
> >       unregister_fuseblk();
> > +     fuse_sysctl_unregister();
> >
> >       /*
> >        * Make sure all delayed rcu free inodes are flushed before we
> > diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> > index 572ce8a82ceb..a6c8ee551635 100644
> > --- a/fs/fuse/ioctl.c
> > +++ b/fs/fuse/ioctl.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/fileattr.h>
> >  #include <linux/fsverity.h>
> >
> > +#define FUSE_VERITY_ENABLE_ARG_MAX_PAGES 256
> > +
> >  static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args=
 *args,
> >                              struct fuse_ioctl_out *outarg)
> >  {
> > @@ -140,7 +142,7 @@ static int fuse_setup_enable_verity(unsigned long a=
rg, struct iovec *iov,
> >  {
> >       struct fsverity_enable_arg enable;
> >       struct fsverity_enable_arg __user *uarg =3D (void __user *)arg;
> > -     const __u32 max_buffer_len =3D FUSE_MAX_MAX_PAGES * PAGE_SIZE;
> > +     const __u32 max_buffer_len =3D FUSE_VERITY_ENABLE_ARG_MAX_PAGES *=
 PAGE_SIZE;
> >
> >       if (copy_from_user(&enable, uarg, sizeof(enable)))
> >               return -EFAULT;
> > diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> > new file mode 100644
> > index 000000000000..b272bb333005
> > --- /dev/null
> > +++ b/fs/fuse/sysctl.c
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * linux/fs/fuse/fuse_sysctl.c
> > + *
> > + * Sysctl interface to fuse parameters
> > + */
> > +#include <linux/sysctl.h>
> > +
> > +#include "fuse_i.h"
> > +
> > +static struct ctl_table_header *fuse_table_header;
> > +
> > +/* Bound by fuse_init_out max_pages, which is a u16 */
> > +static unsigned int sysctl_fuse_max_pages_limit =3D 65535;
> > +
> > +static struct ctl_table fuse_sysctl_table[] =3D {
> > +     {
> > +             .procname       =3D "max_pages_limit",
> > +             .data           =3D &fuse_max_pages_limit,
> > +             .maxlen         =3D sizeof(fuse_max_pages_limit),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec_minmax,
> > +             .extra1         =3D SYSCTL_ONE,
> > +             .extra2         =3D &sysctl_fuse_max_pages_limit,
> > +     },
> > +};
> > +
> > +int fuse_sysctl_register(void)
> > +{
> > +     fuse_table_header =3D register_sysctl("fs/fuse", fuse_sysctl_tabl=
e);
> > +     if (!fuse_table_header)
> > +             return -ENOMEM;
> > +     return 0;
> > +}
> > +
> > +void fuse_sysctl_unregister(void)
> > +{
> > +     unregister_sysctl_table(fuse_table_header);
> > +     fuse_table_header =3D NULL;
> > +}

