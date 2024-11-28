Return-Path: <linux-fsdevel+bounces-36106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43339DBBB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 18:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D043164488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0DE1C07F2;
	Thu, 28 Nov 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsTjaN3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914D211C;
	Thu, 28 Nov 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732814363; cv=none; b=Ta/CDehM6Q3X11rw6H7hiRhk0nfzwEOa8a0deIq5dEYyV1hC/DvLrqFeYfDZ+g4/9S/hqDQZh0uGfd738cYI9213k86LddjC0BdR/nBvuZbs7F1b7ec8S8NZDUNqqELPWDQcKteIHnoIRSawDqtSe4FgRu43GrCB9XzOEaZjCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732814363; c=relaxed/simple;
	bh=lT2LXHNWW/iC8KBP70LzdpuJFpQ0+jPk3naMytUqXDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCWkyKhFneFKMzJGRnuwesps8kNf7P52XEXHwy7hG9KvCAwE6uumvlimob0kECsYoOH1JZfDYfVPM9xjatTnpCYta683eRx0HGeB+vF5HZ0uDObk+FNkPanWHnXg/DUo2YdFR3I2KUgZrhRDkwYQRNmLybY/cmyh5Mu98mkAmRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsTjaN3v; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa530a94c0eso144847866b.2;
        Thu, 28 Nov 2024 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732814360; x=1733419160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVVgupCFKgPii8sVMx+hkdxtwfjB/fz6SblpEzFhKN0=;
        b=lsTjaN3vnru/9NdH0nUizC9YhJT/J1dRojEkbYQJqwaOjEkysEv5FOvqQLOT4IrvEH
         ZuqnytujZRMIfC+Z2p7iYXutFYV21nCq20d7qR35eUOgewekArmXuCjREDON0hHn/Me4
         55GUuZvOpp5PRhPu3WAs6IaukuKgPEnyKds7iAtZSP9qGzlOhBrDlCMcdoz/eywUcVW9
         q+ao6DuUvqIEaFaBhM6UAxcfVaviFI8xDUhOIDETnx9u69jMPwpiDpoOUu57aMDa1rQw
         +U5A6PyT+cg6oIrFbBpXiOk8gp6qK7snprpOmFGD7J50VG4coc58vonZ8RBxGJ55wRec
         JwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732814360; x=1733419160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVVgupCFKgPii8sVMx+hkdxtwfjB/fz6SblpEzFhKN0=;
        b=rB+uposTQupwf4w+KIrvGldyowksfWfd74H1QDHbam5+G2hr2hMUu9H5scLreh8qcD
         3KX/MdmK1w5NkL+CHM36aY2r/GtcD4bHlJmDeYGTod3JCESaBK5ZsWz5vgFPsb9W03OV
         E9xR/jtCmE4ZHj9q+2qbnob3Q0qKYg2XK2UjBW93GTL21/KXTPOXRTaEIDHxEs9RRYoK
         LPwS6l9HfUKo1w/+dOuPTZIgmXgWMJq54cwhxH4kysup43xcdOGQWRSqZlDA1PkgFkBt
         eLBXDg7BHYOh/T8ptIR/qdXhho5MansMfN/AijI3CK7lYPM7qAscdY6T4ZP4UHjUk89N
         a1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxR2LDvIKDeqPQamljZH1xsfVYjKrGJHWEE3K0/gq2+RHL+0rLZ3meJGKVjMpUTMkevNVORADHaAYAVHSB@vger.kernel.org, AJvYcCWZ8Fp8s3wCcaOpV25Jcn747+39iLtGf65nawVNpHlXACDegSmyDihu4val0fDnogDJOjzG3N4yMXCK/O7I@vger.kernel.org, AJvYcCWw8VABjjqc6StEEtXvMR2yk9JmtGcPnxb9BdtbLh9wXEaA7u3GL8/dOXauqN8nhc/wDDrthI5V4NHP@vger.kernel.org
X-Gm-Message-State: AOJu0YzVb6sjZ8fgCeHGxMRUPVqjyr3AWKwJY7ISD563S76LH2hmJ37w
	dCZ8CMxiPCF1ebUkfjCr3rttW0Q2deqpe7CqCeMIRyH+OMC629V0866mjcTBsZv6erYqPEZrYW/
	7dRnnJ96a4M8p8SIoc/q3RSEXFSA=
X-Gm-Gg: ASbGncsOmDas3o3/nR7gnk8oTSHnRV1ipI6yjjVWlcNHMRB7/fM5z/o+G6Pp7z2sELm
	mA7FXm9sp99mkYYEL8YGVl/FI2ZiwcIw=
X-Google-Smtp-Source: AGHT+IEtkXsNrR1KjyMsJ7i+2hLuQQtPfSdQDbN/2CraE9Ha2lBomFHybPHw7eb1Iw9/3a8pJSyVfSYXQ4DmEFB6EoQ=
X-Received: by 2002:a17:907:2d25:b0:aa5:274b:60eb with SMTP id
 a640c23a62f3a-aa581059879mr729658666b.44.1732814359899; Thu, 28 Nov 2024
 09:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org> <20241128-work-pidfs-v1-1-80f267639d98@kernel.org>
In-Reply-To: <20241128-work-pidfs-v1-1-80f267639d98@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Nov 2024 18:19:08 +0100
Message-ID: <CAOQ4uxjiHT1F3EXTkxwg1iUGJ583g9j+txe71VjqCbT-4rzV+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] pidfs: rework inode number allocation
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:34=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Recently we received a patchset that aims to enable file handle encoding
> and decoding via name_to_handle_at(2) and open_by_handle_at(2).
>
> A crucical step in the patch series is how to go from inode number to
> struct pid without leaking information into unprivileged contexts. The
> issue is that in order to find a struct pid the pid number in the
> initial pid namespace must be encoded into the file handle via
> name_to_handle_at(2). This can be used by containers using a separate
> pid namespace to learn what the pid number of a given process in the
> initial pid namespace is. While this is a weak information leak it could
> be used in various exploits and in general is an ugly wart in the design.
>
> To solve this problem a new way is needed to lookup a struct pid based
> on the inode number allocated for that struct pid. The other part is to
> remove the custom inode number allocation on 32bit systems that is also
> an ugly wart that should go away.
>
> So, a new scheme is used that I was discusssing with Tejun some time
> back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
> are used for the generation number. This gives a 64 bit inode number
> that is unique on both 32 bit and 64 bit. The lower 32 bit number is
> recycled slowly and can be used to lookup struct pids.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c            | 92 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/pidfs.h |  2 ++
>  kernel/pid.c          | 11 +++---
>  3 files changed, 98 insertions(+), 7 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 618abb1fa1b84cf31282c922374e28d60cd49d00..09a0c8ac805301927a94758b3=
f7d1e513826daf9 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -23,6 +23,88 @@
>  #include "internal.h"
>  #include "mount.h"
>
> +static u32 pidfs_ino_highbits;
> +static u32 pidfs_ino_last_ino_lowbits;
> +
> +static DEFINE_IDR(pidfs_ino_idr);
> +
> +static inline ino_t pidfs_ino(u64 ino)
> +{
> +       /* On 32 bit low 32 bits are the inode. */
> +       if (sizeof(ino_t) < sizeof(u64))
> +               return (u32)ino;
> +
> +       /* On 64 bit simply return ino. */
> +       return ino;
> +}
> +
> +static inline u32 pidfs_gen(u64 ino)
> +{
> +       /* On 32 bit the generation number are the upper 32 bits. */
> +       if (sizeof(ino_t) < sizeof(u64))
> +               return ino >> 32;
> +
> +       /* On 64 bit the generation number is 1. */
> +       return 1;
> +}
> +
> +/*
> + * Construct an inode number for struct pid in a way that we can use the
> + * lower 32bit to lookup struct pid independent of any pid numbers that
> + * could be leaked into userspace (e.g., via file handle encoding).
> + */
> +int pidfs_add_pid(struct pid *pid)
> +{
> +       u32 ino_highbits;
> +       int ret;
> +
> +       ret =3D idr_alloc_cyclic(&pidfs_ino_idr, pid, 1, 0, GFP_ATOMIC);
> +       if (ret >=3D 0 && ret < pidfs_ino_last_ino_lowbits)
> +               pidfs_ino_highbits++;
> +       ino_highbits =3D pidfs_ino_highbits;
> +       pidfs_ino_last_ino_lowbits =3D ret;
> +       if (ret < 0)
> +               return ret;
> +

This code looks "too useful" to be in a random filesystem.
Maybe work a generation counter into idr_alloc_cyclic or
just let it let the caller know that the range has been cycled?
Only if this is not too complicated to do.

> +       pid->ino =3D (u64)ino_highbits << 32 | ret;
> +       pid->stashed =3D NULL;
> +       return 0;
> +}
> +
> +void pidfs_remove_pid(struct pid *pid)
> +{
> +       idr_remove(&pidfs_ino_idr, (u32)pidfs_ino(pid->ino));
> +}
> +
> +/* Find a struct pid based on the inode number. */
> +static __maybe_unused struct pid *pidfs_ino_get_pid(u64 ino)
> +{
> +       ino_t pid_ino =3D pidfs_ino(ino);
> +       u32 gen =3D pidfs_gen(ino);
> +       struct pid *pid;
> +
> +       guard(rcu)();
> +
> +       /* Handle @pid lookup carefully so there's no risk of UAF. */
> +       pid =3D idr_find(&pidfs_ino_idr, (u32)ino);
> +       if (!pid)
> +               return NULL;
> +
> +       if (sizeof(ino_t) < sizeof(u64)) {
> +               if (gen && pidfs_gen(pid->ino) !=3D gen)
> +                       pid =3D NULL;
> +       } else {
> +               if (pidfs_ino(pid->ino) !=3D pid_ino)
> +                       pid =3D NULL;
> +       }
> +
> +       /* Within our pid namespace hierarchy? */
> +       if (pid_vnr(pid) =3D=3D 0)
> +               pid =3D NULL;
> +
> +       return get_pid(pid);
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  /**
>   * pidfd_show_fdinfo - print information about a pidfd
> @@ -491,6 +573,16 @@ struct file *pidfs_alloc_file(struct pid *pid, unsig=
ned int flags)
>
>  void __init pidfs_init(void)
>  {
> +       /*
> +        * On 32 bit systems the lower 32 bits are the inode number and
> +        * the higher 32 bits are the generation number. The starting
> +        * value for the inode number and the generation number is one.
> +        */
> +       if (sizeof(ino_t) < sizeof(u64))
> +               pidfs_ino_highbits =3D 1;
> +       else
> +               pidfs_ino_highbits =3D 0;
> +
>         pidfs_mnt =3D kern_mount(&pidfs_type);
>         if (IS_ERR(pidfs_mnt))
>                 panic("Failed to mount pidfs pseudo filesystem");
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 75bdf9807802a5d1a9699c99aa42648c2bd34170..2958652bb108b8a2e02128e17=
317be4545b40a01 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -4,5 +4,7 @@
>
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
>  void __init pidfs_init(void);
> +int pidfs_add_pid(struct pid *pid);
> +void pidfs_remove_pid(struct pid *pid);
>
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 115448e89c3e9e664d0d51c8d853e8167ba0540c..9f321c6456d24af705c28f025=
6ca4de771f5e681 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -64,11 +64,6 @@ int pid_max =3D PID_MAX_DEFAULT;
>
>  int pid_max_min =3D RESERVED_PIDS + 1;
>  int pid_max_max =3D PID_MAX_LIMIT;
> -/*
> - * Pseudo filesystems start inode numbering after one. We use Reserved
> - * PIDs as a natural offset.
> - */
> -static u64 pidfs_ino =3D RESERVED_PIDS;
>
>  /*
>   * PID-map pages start out as NULL, they get allocated upon
> @@ -157,6 +152,7 @@ void free_pid(struct pid *pid)
>                 }
>
>                 idr_remove(&ns->idr, upid->nr);
> +               pidfs_remove_pid(pid);
>         }
>         spin_unlock_irqrestore(&pidmap_lock, flags);
>
> @@ -276,8 +272,9 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t=
 *set_tid,
>         spin_lock_irq(&pidmap_lock);
>         if (!(ns->pid_allocated & PIDNS_ADDING))
>                 goto out_unlock;
> -       pid->stashed =3D NULL;
> -       pid->ino =3D ++pidfs_ino;
> +       retval =3D pidfs_add_pid(pid);

I hope this does not create a scalability issue compared to the prev method=
?

> +       if (retval)
> +               goto out_unlock;
>         for ( ; upid >=3D pid->numbers; --upid) {
>                 /* Make the PID visible to find_pid_ns. */
>                 idr_replace(&upid->ns->idr, pid, upid->nr);
>
> --
> 2.45.2
>

Nice idea!
If there is something wrong with it, then I could not find it ;)

Thanks,
Amir.

