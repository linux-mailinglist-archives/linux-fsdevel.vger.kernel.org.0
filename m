Return-Path: <linux-fsdevel+bounces-58587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D68B2F349
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9131C809ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9E2EF675;
	Thu, 21 Aug 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpU7iW/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FC32EF643
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767145; cv=none; b=K7SIfxb02dhfn5ADUCz6T6ABiFnqT7+gZKH0GC1lYMa1O+wia3k3NkB6Fk8WlVZz4S+KgLo800tvBo73rUV3dJCAexlpaGzictj5bC9HgO4BvUHOl1feKI+2sy23EwtHeROlWKnT/deObXz1fvnCd6PIOBd5YfHvfzk+9Fhqp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767145; c=relaxed/simple;
	bh=lWR7+05hG8dAs8ftqxBIDhqyX1NM6zsBqo6/jKUEwlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFa3lYG5VNayLCGYt2CTvcXA8tLc2G1K6HB5nY7UkRFWz3+DPWi/YbBjS/LaOiKVkPi5tRgrBN0Nh0Zy5FuN2yliE0BPVuyji0WVb0ncwpgdBxPWrMzZdmlgAja5w65bDMWhn95bnf8XnH+jcAKhhevEASlsUgICbGlby5Q/GCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpU7iW/H; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61a99d32a84so1490312a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767140; x=1756371940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA5+ta3Ldlbj20vKasUX/0vd8ixvm+r2j7Jz2HM2GWs=;
        b=UpU7iW/Hgb33ykpBl93BXJhIabjpjumtthBstfD2a1RN6dsdEYr03ODbNOI9ICcYmz
         QGi2kbEoqDT+1vb0grJsabvu2rn82igT3adXh03k21izbc6+A3fsc1CefELs04e/4b5Y
         V4ze/qCCavmzDW60RCPo4FVkGlrCAgI5Pj/90IWsOaEgEqxu+mdhQ47TTEVWOkv0VyIS
         bGNgSCy/vlFKZuHr2HsCNR8p2bNQjwAU5oCHqZUtJbCPFSWZQ0Jj2JgOt6rlNQHj3Fgl
         njiAAuhgkTwFQ0M5FXt288dryHNhOBxB5qyAPHczMdUulKmwy9b1zZw8qphhoKL0NUFV
         phHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767140; x=1756371940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA5+ta3Ldlbj20vKasUX/0vd8ixvm+r2j7Jz2HM2GWs=;
        b=ds01Sm078wlYOso4oIdtn2JAahNL/OfH3x88tL+lzNtEl8oHjnwjyeMdbQIxJXxnw5
         JFjesDMtJIu+TrAKsiLiMqOgIUgBhNnLlUDZGP38lXJmBUEarioeF2nWBo2dchHEXQVf
         wroOuqOp+ujQDHWUD/VjHm0+Hx2SLtXxoQry1eeTC58TYmwN9CIgFlz6DjfGC2sh35mD
         tieAqDUGGVcZzNCNFKLqJ1FhinoHBFy+QuHe+gxqRX6ULmPHoaTJEZ4kV14ogXRx0gK2
         Mcp0azJetMD9UV4DqOi8rVvap304/AMJ05RM8M+r5iZRIDKPphnBltIVm/n44P5ZMUeR
         I+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhIwDvA5/VY9xiA4uCDfKTfyBttFUo+/Rs9zbQDPhh9Bib+3Csm7EuFjoZXAW4fWm9PDQKAQ6aTMTFmWgJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwc0BV1bWfHqPCGbTOBpQhQdS87KVMCjEqYx9dMVAHmZE48wIE
	pJxrkXyjxMIVOBtRHyNOZF2mJLmCTYJlVZeIY5YGHCGMEChcYKwKcJyYY4OTxG1WAPKnjLQIWyP
	fFBo/zQ+cFoJMNwTgkGckvHjPCcNxL1Y=
X-Gm-Gg: ASbGncvTlTdScromTeMRKKR85lyd13m8dY8zBWEHZEv99g8zR2OPdvYswy1oyGvbxfk
	cbXyIlDAjNi25WlxzCQuiyotlfn9AiR3RWPs/Xcx8BGLljj1yQNYghl/5NSR79q6y3GejRRASvR
	CWQeg1wAHIKPPB0FyVLL9frGah8iDJu8YLk+vkpwqqBUa1IGbRNfOk7l+6CCeKFQPzHN0SXGayU
	5EVMCA=
X-Google-Smtp-Source: AGHT+IHM/KBgACjCvsgI1puqUryPV8QzS/AiJm3TyWm9vr7QZARMugYYXMqx41MylXzX0GsgZSGszCkNXGMsh96B4Nk=
X-Received: by 2002:a05:6402:278c:b0:613:5257:6cad with SMTP id
 4fb4d7f45d1cf-61bfa3ff4aamr1094100a12.11.1755767139536; Thu, 21 Aug 2025
 02:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs> <175573709222.17510.17568403217413241879.stgit@frogsfrogsfrogs>
In-Reply-To: <175573709222.17510.17568403217413241879.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Aug 2025 11:05:28 +0200
X-Gm-Features: Ac12FXxAVcDZM_6CJC3CRrjQll1tq6QS7e-X-GIooRqFHHZn29bYAZthOWWG29I
Message-ID: <CAOQ4uxg_A-Zck33c61_yn+jiWRW8OjKO4QxJQJ31Tci0sxFpQA@mail.gmail.com>
Subject: Re: [PATCH 05/23] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> In preparation for iomap, move the passthrough-specific validation code
> back to passthrough.c and create a new Kconfig item for conditional
> compilation of backing.c.  In the next patch, iomap will share the
> backing structures.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h      |   14 ++++++
>  fs/fuse/fuse_trace.h  |   35 ++++++++++++++++
>  fs/fuse/Kconfig       |    4 ++
>  fs/fuse/Makefile      |    3 +
>  fs/fuse/backing.c     |  106 +++++++++++++++++++++++++++++++++++++------=
------
>  fs/fuse/dev.c         |    4 +-
>  fs/fuse/inode.c       |    4 +-
>  fs/fuse/passthrough.c |   28 +++++++++++++
>  8 files changed, 165 insertions(+), 33 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 2be2cbdf060536..1762517a1b99c8 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -958,7 +958,7 @@ struct fuse_conn {
>         /* New writepages go into this bucket */
>         struct fuse_sync_bucket __rcu *curr_bucket;
>
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> +#ifdef CONFIG_FUSE_BACKING
>         /** IDR for backing files ids */
>         struct idr backing_files_map;
>  #endif
> @@ -1536,7 +1536,7 @@ void fuse_file_release(struct inode *inode, struct =
fuse_file *ff,
>                        unsigned int open_flags, fl_owner_t id, bool isdir=
);
>
>  /* backing.c */
> -#ifdef CONFIG_FUSE_PASSTHROUGH
> +#ifdef CONFIG_FUSE_BACKING
>  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
>  void fuse_backing_put(struct fuse_backing *fb);
>  struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id);
> @@ -1596,6 +1596,16 @@ static inline struct file *fuse_file_passthrough(s=
truct fuse_file *ff)
>  #endif
>  }
>
> +#ifdef CONFIG_FUSE_PASSTHROUGH
> +int fuse_passthrough_backing_open(struct fuse_conn *fc,
> +                                 struct fuse_backing *fb);
> +int fuse_passthrough_backing_close(struct fuse_conn *fc,
> +                                  struct fuse_backing *fb);
> +#else
> +# define fuse_passthrough_backing_open(...)    (-EOPNOTSUPP)
> +# define fuse_passthrough_backing_close(...)   (-EOPNOTSUPP)
> +#endif
> +
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *=
iter);
>  ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter =
*iter);
>  ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index 2389072b734636..660d9b5206a175 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h
> @@ -174,6 +174,41 @@ TRACE_EVENT(fuse_request_end,
>                   __entry->unique, __entry->len, __entry->error)
>  );
>
> +#ifdef CONFIG_FUSE_BACKING
> +TRACE_EVENT(fuse_backing_class,
> +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx,
> +                const struct fuse_backing *fb),
> +
> +       TP_ARGS(fc, idx, fb),
> +
> +       TP_STRUCT__entry(
> +               __field(dev_t,                  connection)
> +               __field(unsigned int,           idx)
> +               __field(unsigned long,          ino)
> +       ),
> +
> +       TP_fast_assign(
> +               struct inode *inode =3D file_inode(fb->file);
> +
> +               __entry->connection     =3D       fc->dev;
> +               __entry->idx            =3D       idx;
> +               __entry->ino            =3D       inode->i_ino;
> +       ),
> +
> +       TP_printk("connection %u idx %u ino 0x%lx",
> +                 __entry->connection,
> +                 __entry->idx,
> +                 __entry->ino)
> +);
> +#define DEFINE_FUSE_BACKING_EVENT(name)                \
> +DEFINE_EVENT(fuse_backing_class, name,         \
> +       TP_PROTO(const struct fuse_conn *fc, unsigned int idx, \
> +                const struct fuse_backing *fb), \
> +       TP_ARGS(fc, idx, fb))
> +DEFINE_FUSE_BACKING_EVENT(fuse_backing_open);
> +DEFINE_FUSE_BACKING_EVENT(fuse_backing_close);
> +#endif
> +
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>
>  /* tracepoint boilerplate so we don't have to keep doing this */
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 6be74396ef5198..ebb9a2d76b532e 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -59,12 +59,16 @@ config FUSE_PASSTHROUGH
>         default y
>         depends on FUSE_FS
>         select FS_STACK
> +       select FUSE_BACKING
>         help
>           This allows bypassing FUSE server by mapping specific FUSE oper=
ations
>           to be performed directly on a backing file.
>
>           If you want to allow passthrough operations, answer Y.
>
> +config FUSE_BACKING
> +       bool
> +
>  config FUSE_IOMAP
>         bool "FUSE file IO over iomap"
>         default y
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index c79f786d0c90c3..27be39317701d6 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -14,7 +14,8 @@ fuse-y :=3D trace.o     # put trace.o first so we see f=
trace errors sooner
>  fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o
>  fuse-y +=3D iomode.o
>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> -fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
> +fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> +fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
>  fuse-$(CONFIG_FUSE_IOMAP) +=3D file_iomap.o
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index ddb23b7400fc72..c128bed95a76b8 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include "fuse_i.h"
> +#include "fuse_trace.h"
>
>  #include <linux/file.h>
>
> @@ -81,16 +82,14 @@ void fuse_backing_files_free(struct fuse_conn *fc)
>
>  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
>  {
> -       struct file *file;
> -       struct super_block *backing_sb;
> +       struct file *file =3D NULL;
>         struct fuse_backing *fb =3D NULL;
> -       int res;
> +       int res, passthrough_res;
>
>         pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
>
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
>         res =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +       if (!fc->passthrough)
>                 goto out;
>
>         res =3D -EINVAL;
> @@ -102,46 +101,68 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>         if (!file)
>                 goto out;
>
> -       backing_sb =3D file_inode(file)->i_sb;
> -       res =3D -ELOOP;
> -       if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> -               goto out_fput;
> -
>         fb =3D kmalloc(sizeof(struct fuse_backing), GFP_KERNEL);
>         res =3D -ENOMEM;
>         if (!fb)
> -               goto out_fput;
> +               goto out_file;
>
> +       /* fb now owns file */
>         fb->file =3D file;
> +       file =3D NULL;
>         fb->cred =3D prepare_creds();
>         refcount_set(&fb->count, 1);
>
> +       /*
> +        * Each _backing_open function should either:
> +        *
> +        * 1. Take a ref to fb if it wants the file and return 0.
> +        * 2. Return 0 without taking a ref if the backing file isn't nee=
ded.
> +        * 3. Return an errno explaining why it couldn't attach.
> +        *
> +        * If at least one subsystem bumps the reference count to open it=
,
> +        * we'll install it into the index and return the index.  If nobo=
dy
> +        * opens the file, the error code will be passed up.  EPERM is th=
e
> +        * default.
> +        */
> +       passthrough_res =3D fuse_passthrough_backing_open(fc, fb);
> +
> +       if (refcount_read(&fb->count) < 2) {
> +               if (passthrough_res)
> +                       res =3D passthrough_res;
> +               if (!res)
> +                       res =3D -EPERM;
> +               goto out_fb;
> +       }
> +
>         res =3D fuse_backing_id_alloc(fc, fb);
> -       if (res < 0) {
> -               fuse_backing_free(fb);
> -               fb =3D NULL;
> -       }
> +       if (res < 0)
> +               goto out_fb;
> +
> +       trace_fuse_backing_open(fc, res, fb);
>
> -out:
>         pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
> -
> +       fuse_backing_put(fb);
>         return res;
>
> -out_fput:
> -       fput(file);
> -       goto out;
> +out_fb:
> +       fuse_backing_free(fb);
> +out_file:
> +       if (file)
> +               fput(file);
> +out:
> +       pr_debug("%s: ret=3D%i\n", __func__, res);
> +       return res;
>  }
>
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>  {
> -       struct fuse_backing *fb =3D NULL;
> -       int err;
> +       struct fuse_backing *fb =3D NULL, *test_fb;
> +       int err, passthrough_err;
>
>         pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
>
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
>         err =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +       if (!fc->passthrough)
>                 goto out;
>
>         err =3D -EINVAL;
> @@ -149,12 +170,45 @@ int fuse_backing_close(struct fuse_conn *fc, int ba=
cking_id)
>                 goto out;
>
>         err =3D -ENOENT;
> -       fb =3D fuse_backing_id_remove(fc, backing_id);
> +       fb =3D fuse_backing_lookup(fc, backing_id);
>         if (!fb)
>                 goto out;
>
> +       /*
> +        * Each _backing_close function should either:
> +        *
> +        * 1. Release the ref that it took in _backing_open and return 0.
> +        * 2. Don't release the ref if the backing file is busy, and retu=
rn 0.
> +        * 2. Return an errno explaining why it couldn't detach.
> +        *
> +        * If there are no more active references to the backing file, it=
 will
> +        * be closed and removed from the index.  If there are still acti=
ve
> +        * references to the backing file other than the one we just took=
, the

That does not look right.
The fuse_backing object can often outliive the backing_id mapping
1. fuse server attached backing fd to backing id 1
2. fuse server opens a file with passthrough to backing id 1
3. fuse inode holds a refcount to the fuse_backing object
4. fuse server closes backing id 1 mapping
5. fuse server closes file, drops last reference to fuse_backing object

IOW, fb->count is not about being in the index.
With your code the fuse server call in #4 above will end up leaving the
fuse_backing object in the index and after #5 it will remain a dangling
object in the index.

TBH, I don't understand why we need any of the complexity
of two subsystems claiming the same fuse_backing object for two
different purposes.

Also, I think that an explicit statement from the server about the
purpose of the backing file is due (like your commit message implies)
This could be easily done with the backing open flags member:

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index c63990254649c..e5a675fca7505 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -96,7 +96,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct
fuse_backing_map *map)
                goto out;

        res =3D -EINVAL;
-       if (map->flags || map->padding)
+       if (map->flags & ~FUSE_BACKING_VALID_FLAGS || map->padding)
                goto out;

        file =3D fget_raw(map->fd);
@@ -127,8 +127,10 @@ int fuse_backing_open(struct fuse_conn *fc,
struct fuse_backing_map *map)
         * opens the file, the error code will be passed up.  EPERM is the
         * default.
         */
-       passthrough_res =3D fuse_passthrough_backing_open(fc, fb);
-       iomap_res =3D fuse_iomap_backing_open(fc, fb);
+       if (map->flags & FUSE_BACKING_IOMAP)
+               iomap_res =3D fuse_iomap_backing_open(fc, fb);
+       else
+               passthrough_res =3D fuse_passthrough_backing_open(fc, fb);

        if (refcount_read(&fb->count) < 2) {
                if (passthrough_res)
@@ -192,8 +194,10 @@ int fuse_backing_close(struct fuse_conn *fc, int
backing_id)
         * references to the backing file other than the one we just took, =
the
         * error code will be passed up.  EBUSY is the default.
         */
-       passthrough_err =3D fuse_passthrough_backing_close(fc, fb);
-       iomap_err =3D fuse_iomap_backing_close(fc, fb);
+       if (fb->bdev)
+               iomap_err =3D fuse_iomap_backing_close(fc, fb);
+       else
+               passthrough_err =3D fuse_passthrough_backing_close(fc, fb);

        if (refcount_read(&fb->count) > 1) {
                if (passthrough_err)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 70b5530e587d4..ee81903ad2f98 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1148,6 +1148,10 @@ struct fuse_notify_retrieve_in {
        uint64_t        dummy4;
 };

+/* basic file I/O functionality through iomap */
+#define FUSE_BACKING_IOMAP             (1 << 0)
+#define FUSE_BACKING_VALID_FLAGS       (FUSE_BACKING_IOMAP)
+
 struct fuse_backing_map {
        int32_t         fd;
        uint32_t        flags;


> +        * error code will be passed up.  EBUSY is the default.
> +        */
> +       passthrough_err =3D fuse_passthrough_backing_close(fc, fb);
> +
> +       if (refcount_read(&fb->count) > 1) {
> +               if (passthrough_err)
> +                       err =3D passthrough_err;
> +               if (!err)
> +                       err =3D -EBUSY;
> +               goto out_fb;
> +       }
> +
> +       trace_fuse_backing_close(fc, backing_id, fb);
> +
> +       err =3D -ENOENT;
> +       test_fb =3D fuse_backing_id_remove(fc, backing_id);
> +       if (!test_fb)
> +               goto out_fb;
> +
> +       WARN_ON(fb !=3D test_fb);
> +       pr_debug("%s: fb=3D0x%p, err=3D0\n", __func__, fb);
> +       fuse_backing_put(fb);
> +       return 0;
> +out_fb:
>         fuse_backing_put(fb);
> -       err =3D 0;
>  out:
>         pr_debug("%s: fb=3D0x%p, err=3D%i\n", __func__, fb, err);
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index dbde17fff0cda9..31d9f006836ac1 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2623,7 +2623,7 @@ static long fuse_dev_ioctl_backing_open(struct file=
 *file,
>         if (!fud)
>                 return -EPERM;
>
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&map, argp, sizeof(map)))
> @@ -2640,7 +2640,7 @@ static long fuse_dev_ioctl_backing_close(struct fil=
e *file, __u32 __user *argp)
>         if (!fud)
>                 return -EPERM;
>
> -       if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (!IS_ENABLED(CONFIG_FUSE_BACKING))
>                 return -EOPNOTSUPP;
>
>         if (get_user(backing_id, argp))
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9448a11c828fef..1f3f91981410aa 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -993,7 +993,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse=
_mount *fm,
>         fc->name_max =3D FUSE_NAME_LOW_MAX;
>         fc->timeout.req_timeout =3D 0;
>
> -       if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +       if (IS_ENABLED(CONFIG_FUSE_BACKING))
>                 fuse_backing_files_init(fc);
>
>         INIT_LIST_HEAD(&fc->mounts);
> @@ -1030,7 +1030,7 @@ void fuse_conn_put(struct fuse_conn *fc)
>                         WARN_ON(atomic_read(&bucket->count) !=3D 1);
>                         kfree(bucket);
>                 }
> -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> +               if (IS_ENABLED(CONFIG_FUSE_BACKING))
>                         fuse_backing_files_free(fc);
>                 call_rcu(&fc->rcu, delayed_release);
>         }
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index e0b8d885bc81f3..dfc61cc4bd21af 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -197,3 +197,31 @@ void fuse_passthrough_release(struct fuse_file *ff, =
struct fuse_backing *fb)
>         put_cred(ff->cred);
>         ff->cred =3D NULL;
>  }
> +
> +int fuse_passthrough_backing_open(struct fuse_conn *fc,
> +                                 struct fuse_backing *fb)
> +{
> +       struct super_block *backing_sb;
> +
> +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;

This limitation is not specific to fuse passthrough.
While the fuse passthrough use case is likely to request many fuse
backing files,
the limitation is here to protect from malicious actors and the same ioctl =
used
by the iomap fuse server can just as well open many "lsof invisible" files,
so the limitation should be in the generic function.

> +
> +       backing_sb =3D file_inode(fb->file)->i_sb;
> +       if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> +               return -ELOOP;
> +
> +       fuse_backing_get(fb);
> +       return 0;
> +}
> +
> +int fuse_passthrough_backing_close(struct fuse_conn *fc,
> +                                  struct fuse_backing *fb)
> +{
> +       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +

Probably this comment in upstream is not very accurate because there is no
harm done in closing the backing files, but sure for symmetry.
Same comment as above through, unless there are reasons to relax
CAP_SYS_ADMIN for file iomap, would leave this in the genetic code.

And then there is not much justification left for the close helpers IMO,
especially given that the implementation wrt removing from index is
incorrect, I would keep it simple:

@@ -175,11 +177,19 @@ int fuse_backing_close(struct fuse_conn *fc, int
backing_id)
        if (backing_id <=3D 0)
                goto out;

-       err =3D -ENOENT;
-       fb =3D fuse_backing_lookup(fc, backing_id);
-       if (!fb)
+       err =3D -EPERM;
+       if (!capable(CAP_SYS_ADMIN))
                goto out;

+       err =3D -EBUSY;
+       if (fb->bdev)
+               goto out;
+
+       fb =3D fuse_backing_id_remove(fc, backing_id);
+       if (!fb)
+               err =3D -ENOENT;
+       goto out_fb;
+

Thanks,
Amir.

