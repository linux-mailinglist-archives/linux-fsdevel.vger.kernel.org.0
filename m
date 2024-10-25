Return-Path: <linux-fsdevel+bounces-32883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927439B0329
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51537282350
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A821BC5C;
	Fri, 25 Oct 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGMUjOdl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC382064E0;
	Fri, 25 Oct 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860627; cv=none; b=SHB5VgaY2LotDE5bkFol1JhEaBZgeKWTXbsox/eGgefkymyOv78wZXnpaAv4ME8f2g+wZ33kK6pw8xf/u93/+pjcQQLVESjhLvGDGb5KpIQeKF9m4KAjxKoXXI19SP/ejyk6VvbE3jWVSh9fCgTxTBlFN5nf/Yyeh/Sx0kRf0qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860627; c=relaxed/simple;
	bh=Gicd/I8M7GxPor8aNTdwt1DHWF57vZyMuljGjupxin4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0R/WtlB5qjW4uGQcYdxIj1Z+NAJnDeYBx61CtCuulJeltbVfUJ9qpSRimN9hBN0+CvxD6RJ2RD0p39jsD3aInLCMinZiAqlVGlAEwyPVJuK5yGTQkRP/mkN4dsz7desynFERWxQn896lit/WfEzIkxWGpwqfYAPLI3QEph2fjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGMUjOdl; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so638744241.2;
        Fri, 25 Oct 2024 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729860624; x=1730465424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EmHSEMXHuqWTqs2dMjBSQS45igTAqZ1OnjsJbkbpFc=;
        b=EGMUjOdlXQrB5EUnwbqMKz5p0dDG4O2gUtZoe4cYXKIkpoR0MOek6WOQuTepHXqwBK
         Ofqdlneq7MdHMoPSTHQcxPoaKqHaviNF3yhFa0F2SpzHJ2m7B+u2e6V+Vn05mpfHtlTb
         6yl2h70gci+z7YV1fovmrKvrqlvJZW9bKZb3qgvFGfXiW5WJY9jBG/0QH/yn8nFSb1ze
         dCMw4No2DuaitPiq5SgeC7IQ83ky3S1hVly+V65Bu+WxyDh1va4Iwj4j8s4tDVd4ByGD
         1YOxt0TlOtFIYOvE3kX84y1/iyMchzEIdiSyYA5zZvRKE0mcBMJBM604MnEBNOih6FVd
         mw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729860624; x=1730465424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EmHSEMXHuqWTqs2dMjBSQS45igTAqZ1OnjsJbkbpFc=;
        b=gXFKsG67ArGZlov4TwPK7Pa6Wq3OJzloYOHvsyebLEkW2S+S0rf5RPsPxVD0qnco++
         CJacx0qvzJ9MM34c1OvbC71+maFsS46pBGHfCDprZrt9V4GH+KuM7mrGE7qX9zSXcxoV
         MTAFCsxqO8x/gXbKS+kzlbcpyMfRh8DiaA73rVKRDNfCQRKA6r8B8HjsWTzVNo7QyDWg
         TMi0TKNDM65s2FFConkBAf2sYJIFOOjvBBvxxa4Setb4Ig/KaTNXRphNVsZ/7c5L8F+n
         laEYYNuyG6VXCxjLskUwwxDoatGos8nr6qyE7qq4t5BN4uCmfOeJBwSsHHvTojFRg+Mg
         DPxw==
X-Forwarded-Encrypted: i=1; AJvYcCU7dVOvAPT8ftw/lXN6+bwbU1lybx9oiBJLWC3dEZtWiSV9QVpLaE3hM005UyvdhaHbCcbj6CLfW8OiZ9zsqg==@vger.kernel.org, AJvYcCV/9vdrfTumCmMJrPg5U0L6gXG+saJWKiIg5BCTkRdrZXX34cphaZ/cacvUejHJfdMsG9etOBUlVzQ=@vger.kernel.org, AJvYcCW7SDY5a6WZbXdpASkpQcGHLFURgHLwb3vAYmpGRswa+ag/rTwvz5fp0aqcdW54D+jmGd+xndg8j2g0a7S2FmlM@vger.kernel.org, AJvYcCX61OMy4M2c7q0+erOci2wue8PQ4d68zarjywG0FZWzaFdC9hp7sg0258fZm3QBClF3wlbnPIBUG3xtz82Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyujNMdeinIkzmt0CJcFBHLyv1yh189WNH250i4xMQZy0UXsr4e
	k0nQQSTwe5W/QVF2VsR9hb+HyDGJzktdi2TKEOdEQ6kunKk3Xhul5l+GIwzlOv0sHT1bPe9YMQk
	cq6xvRtA/Q8jtNZeZ3e0MpDnlWXE=
X-Google-Smtp-Source: AGHT+IEbGP+hlLzUqhS0RCLyGPfc8jr7OmiybYsOLWuFXt/b9D6XHhcoNY++XU11x3iEj0RjmGWAgyNjztqN5HcHO+I=
X-Received: by 2002:a05:6102:945:b0:4a3:c516:3173 with SMTP id
 ada2fe7eead31-4a871032c42mr7398496137.12.1729860623491; Fri, 25 Oct 2024
 05:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com> <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 25 Oct 2024 13:50:12 +0100
Message-ID: <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:41=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> It is useful to be able to utilise the pidfd mechanism to reference the
> current thread or process (from a userland point of view - thread group
> leader from the kernel's point of view).
>
> Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
>
> For convenience and to avoid confusion from userland's perspective we ali=
as
> these:
>
> * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always wh=
at
>   the user will want to use, as they would find it surprising if for
>   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
>   and that failed.
>
> * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
>   have no concept of thread groups or what a thread group leader is, and
>   from userland's perspective and nomenclature this is what userland
>   considers to be a process.
>
> Due to the refactoring of the central __pidfd_get_pid() function we can
> implement this functionality centrally, providing the use of this sentine=
l
> in most functionality which utilises pidfd's.
>
> We need to explicitly adjust kernel_waitid_prepare() to permit this (thou=
gh
> it wouldn't really make sense to use this there, we provide the ability f=
or
> consistency).
>
> We explicitly disallow use of this in setns(), which would otherwise have
> required explicit custom handling, as it doesn't make sense to set the
> current calling thread to join the namespace of itself.
>
> As the callers of pidfd_get_pid() expect an increased reference count on
> the pid we do so in the self case, reducing churn and avoiding any breaka=
ge
> from existing logic which decrements this reference count.
>
> This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDF=
S,
> ...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
> pidfd_getfd() system calls.
>
> Things such as polling a pidfs and general fd operations are not supporte=
d,
> this strictly provides the sentinel for APIs which explicitly accept a
> pidfd.
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/pid.h        |  8 ++++--
>  include/uapi/linux/pidfd.h | 15 +++++++++++
>  kernel/exit.c              |  3 ++-
>  kernel/nsproxy.c           |  1 +
>  kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
>  5 files changed, 57 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index d466890e1b35..3b2ac7567a88 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -78,11 +78,15 @@ struct file;
>   * __pidfd_get_pid() - Retrieve a pid associated with the specified pidf=
d.
>   *
>   * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> =
file if
> - *              @alloc_proc is also set.
> + *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the=
 current
> + *              thread or thread group leader.
>   * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed i=
nstead
>   *              of a pidfd, and this will be used to determine the pid.
> +
>   * @flags:      Output variable, if non-NULL, then the file->f_flags of =
the
> - *              pidfd will be set here.
> + *              pidfd will be set here or If PIDFD_SELF_THREAD is set, t=
his is
> + *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROU=
P then
> + *              this is set to zero.
>   *
>   * Returns: If successful, the pid associated with the pidfd, otherwise =
an
>   *          error.
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..0ca2ebf906fd 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -29,4 +29,19 @@
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
>
> +/*
> + * Special sentinel values which can be used to refer to the current thr=
ead or
> + * thread group leader (which from a userland perspective is the process=
).
> + */
> +#define PIDFD_SELF             PIDFD_SELF_THREAD
> +#define PIDFD_SELF_PROCESS     PIDFD_SELF_THREAD_GROUP
> +
> +#define PIDFD_SELF_THREAD      -100 /* Current thread. */

This conflicts with AT_FDCWD, might be worth changing?

> +#define PIDFD_SELF_THREAD_GROUP        -200 /* Current thread group lead=
er. */

We might want to pick some range outside of the negative errno space
(-4096 IIRC), since we have plenty of values to pick from (2^31 at
least).

> +static inline int pidfd_is_self_sentinel(pid_t pid)
> +{
> +       return pid =3D=3D PIDFD_SELF_THREAD || pid =3D=3D PIDFD_SELF_THRE=
AD_GROUP;
> +}

Do we want this in the uapi header? Even if this is useful, it might
come with several drawbacks such as breaking scripts that parse kernel
headers (and a quick git grep suggests we do have static inlines in
headers, but in rather obscure ones) and breaking C89:

<source>:8:8: error: unknown type name 'inline'
    8 | static inline int pidfd_is_self_sentinel(pid_t pid)

:)

> +
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 619f0014c33b..3eb20f8252ee 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -71,6 +71,7 @@
>  #include <linux/user_events.h>
>  #include <linux/uaccess.h>
>
> +#include <uapi/linux/pidfd.h>
>  #include <uapi/linux/wait.h>
>
>  #include <asm/unistd.h>
> @@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int=
 which, pid_t upid,
>                 break;
>         case P_PIDFD:
>                 type =3D PIDTYPE_PID;
> -               if (upid < 0)
> +               if (upid < 0 && !pidfd_is_self_sentinel(upid))
>                         return -EINVAL;
>
>                 pid =3D pidfd_get_pid(upid, &f_flags);
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index dc952c3b05af..d239f7eeaa1f 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
>         struct nsset nsset =3D {};
>         int err =3D 0;
>
> +       /* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
>         if (!fd_file(f))
>                 return -EBADF;
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 94c97559e5c5..8742157b36f8 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespac=
e *ns)
>  }
>  EXPORT_SYMBOL_GPL(find_ge_pid);
>
> +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *=
flags)
> +{
> +       bool is_thread =3D pidfd =3D=3D PIDFD_SELF_THREAD;
> +       enum pid_type type =3D is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> +       struct pid *pid =3D *task_pid_ptr(current, type);
> +
> +       /* The caller expects an elevated reference count. */
> +       get_pid(pid);

It would be really really nice to avoid the get here, but I imagine
it'll take some refactoring around put_pid's?

> +       return pid;
> +}
> +
>  struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
>                             unsigned int *flags)
>  {
> -       struct pid *pid;
> -       struct fd f =3D fdget(pidfd);
> -       struct file *file =3D fd_file(f);
> +       if (pidfd_is_self_sentinel(pidfd)) {
> +               return pidfd_get_pid_self(pidfd, flags);
> +       } else {

Skipping the else here might make the rest of the code more legible
(since the sentinel branch returns anyway...).

--=20
Pedro

