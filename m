Return-Path: <linux-fsdevel+bounces-31000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5639907D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5C71C24251
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD201C3048;
	Fri,  4 Oct 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEWf/fs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEA1E3DE4
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056103; cv=none; b=U7whBSeJcVzmV6X9tx42bXW0g/Jliihi6HZeVgIzPX7REJLdAzS4lALz7N8K7+IKM8VxsgYOB2w45VVtH1KIcpwsTq+/roF2iIQbLhACQfQiG0rC8ozGeDQqaNotEgDUWAYZfT0yKFX2M/zZdImZgfPYXUK+wd7g41Y2yjIm0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056103; c=relaxed/simple;
	bh=NJqPIc6Or4jdfoUX/6PWP5k0zvJTDAlwpulwJOphuoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mzrt6UIX5ckY1n+KrLErTEuyYPIXDM/iEi7XCxd1EBp6VWKlYnyEdyhklcwEOBGAKYHLL+zqWwyOvpYhv76f4xnFeXulSQjKRqRGrFturGVc0hqPzWiAW1vfX+X8oHtHcV1H851WBZWyI2sIm+/nX7DhOQpGL3noeLcr5jZIXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEWf/fs3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a99e8d5df1so215923985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728056101; x=1728660901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts5o9mOdmnBu9EbO4AMhHSTZuXpxJZzGb0fCmCVc/6U=;
        b=aEWf/fs3fisYu4KTMO0Whei6yIbRb3jW3k7EAHDH+mIZ62tIoR9iexBXPuwkUuAcGI
         zxRBGJymmb8o/PrHiAj10VVCNXbOCuqnW0jGbJfdWKpdYlcmvJxnZoizeae4f+GmQrS0
         JMJluSvy6z3aW9zhsiJfxdIBLrtuTs+3DBSzbPqxZVYsDO9vvy7z3SB+EHOty549gK/0
         kJLTUuCjLgyXHlicbLYtYuQZDclUHHYDOykJwO+7EdOLOfnrV4qvNl1ctwbI5A1HJTbQ
         YxTYzJ1xmr1GuHVITtzXEle1Q74qR/P/FAUsI5qlUPrUY7wZ2cllSYtnQAglCmivEYmh
         HM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056101; x=1728660901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts5o9mOdmnBu9EbO4AMhHSTZuXpxJZzGb0fCmCVc/6U=;
        b=kd50F0bft6AT9xZ4LTOpULF/dlPd0aR6NRdnmE+Q5ju6fTEAQLv4S9gIXKSyw0hBnZ
         /QBiM1owJ2Y51+hpFASM7tXQDoSVL4ADHHW0ZHYGYynjXnvRyyZoOS7BjRSCJo2HinLm
         SX6eXOmprfN+9S1T8pcGQjASlEMKIfMgJ3SGdoLT2qaZRZPXdfN45JyyAgg7sink6Se/
         9v+fGkFr7jRsrxS1yrH1BXGwY6ivp4leeTCBp5tVq68v9beCHfxZPpO86nE1kKnSrICg
         DVQpQ0bvsp1OIHjGrc4X+iVupZZheGhU4q/6iZAM+AggpZ+YCqwQs5q3RvtIeCtJ7KV0
         I6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXwrsrmbq78ZEEChr6ZEQXE4zMAwo88i5onyyiYIoEXwyhqFis5rAeGbE1d5F8G0mw5UI25gc8hkDFt2kf7@vger.kernel.org
X-Gm-Message-State: AOJu0YxcB4ZrQE3Fv4hs69UavSeLJwDyGmB7aVZzeNm55UgDlh6S9Q1R
	ZcFzN/wnCBMjJb8cB9pe0ZlZJVqUGuz69C2sd7s1z5OH8JuUgHHV2M/3NpwOBG15DJGVNmrlGUj
	ONw22AcZxRd6b+nM0Ni/wh9xi/ps=
X-Google-Smtp-Source: AGHT+IEQrSH4KldYykOI/E/iWU4IdSe8iYrtSc+ewfQanbGpqq/HovX8N4wap9Sozvx/EHxpQtk0clLTPxQpAq802U8=
X-Received: by 2002:a05:620a:d83:b0:7a8:325:5309 with SMTP id
 af79cd13be357-7ae6f421cdamr443212185a.12.1728056100598; Fri, 04 Oct 2024
 08:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003142922.111539-1-amir73il@gmail.com>
In-Reply-To: <20241003142922.111539-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 17:34:48 +0200
Message-ID: <CAOQ4uxhb5z1t89NDefks-L-LgGq48bhOyftOdwrHPHR_Yw3H0g@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: allow reporting errors on failure to open fd
To: Jan Kara <jack@suse.cz>
Cc: Krishna Vivek Vitta <kvitta@microsoft.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:29=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> When working in "fd mode", fanotify_read() needs to open an fd
> from a dentry to report event->fd to userspace.
>
> Opening an fd from dentry can fail for several reasons.
> For example, when tasks are gone and we try to open their
> /proc files or we try to open a WRONLY file like in sysfs
> or when trying to open a file that was deleted on the
> remote network server.
>
> Add a new flag FAN_REPORT_FD_ERROR for fanotify_init().
> For a group with FAN_REPORT_FD_ERROR, we will send the
> event with the error instead of the open fd, otherwise
> userspace may not get the error at all.
>
> The FAN_REPORT_FD_ERROR flag is not allowed for groups in "fid mode"
> which do not use open fd's as the object identifier.
>
> For ean overflow event, we report -EBADF to avoid confusing FAN_NOFD
> with -EPERM.  Similarly for pidfd open errors we report either -ESRCH
> or the open error instead of FAN_NOPIDFD and FAN_EPIDFD.
>
> In any case, userspace will not know which file failed to
> open, so add a debug print for further investigation.
>
> Reported-by: Krishna Vivek Vitta <kvitta@microsoft.com>
> Closes: https://lore.kernel.org/linux-fsdevel/SI2P153MB07182F3424619EDDD1=
F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Jan,
>
> This is my proposal for a slightly better UAPI for error reporting,
> taking into account your review comments on v1 [1].
>
> I have written some basic LTP tests for the simple cases [2], but
> not yet for actual open errors.

FWIW, pushed a new test case for reporting -EROFS error either to
fanotify_read() or in event->fd.

Thanks,
Amir.

>
> I tested the open error manually using an enhanced fanotify_example [3]
> and the reproducer of the 9p open unlinked file issue [4]:
>
> $ ./fanotify_example /vtmp/
> Press enter key to terminate.
> Listening for events.
> FAN_OPEN_PERM: File /vtmp/config.lock
> FAN_CLOSE_WRITE: fd open failed: No such file or directory
>
> And the debug print in kmsg:
> [ 1836.619957] fanotify: create_fd(/config.lock) failed err=3D-2
>
> fanotify_read() can still return an error with FAN_REPORT_FD_ERROR,
> but not for a failure to open an fd.
>
> Thanks,
> Amir.
>
> Changes since v1:
> - Change pr_warn() =3D> pr_debug()
> - Restrict FAN_REPORT_FD_ERROR to group in fd mode
> - Report fd error also for pidfd errors
> - Report -EBAFD instead of FAN_NOFD in overflow event
>
> [1] https://lore.kernel.org/linux-fsdevel/20240927125624.2198202-1-amir73=
il@gmail.com/
> [2] https://github.com/amir73il/ltp/commits/fan_fd_error
> [3] https://github.com/amir73il/fsnotify-utils/blob/fan_report_fd_error/s=
rc/test/fanotify_example.c
> [4] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgRnzB0E2ESeqgZBHW++zyRj8=
-VmvB38Vxm5OXgr=3DEM9g@mail.gmail.com/
>
>  fs/notify/fanotify/fanotify_user.c | 83 +++++++++++++++++++++---------
>  include/linux/fanotify.h           |  1 +
>  include/uapi/linux/fanotify.h      |  1 +
>  3 files changed, 62 insertions(+), 23 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9644bc72e457..37a0dd8ae883 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -266,13 +266,6 @@ static int create_fd(struct fsnotify_group *group, c=
onst struct path *path,
>                                group->fanotify_data.f_flags | __FMODE_NON=
OTIFY,
>                                current_cred());
>         if (IS_ERR(new_file)) {
> -               /*
> -                * we still send an event even if we can't open the file.=
  this
> -                * can happen when say tasks are gone and we try to open =
their
> -                * /proc files or we try to open a WRONLY file like in sy=
sfs
> -                * we just send the errno to userspace since there isn't =
much
> -                * else we can do.
> -                */
>                 put_unused_fd(client_fd);
>                 client_fd =3D PTR_ERR(new_file);
>         } else {
> @@ -653,6 +646,19 @@ static int copy_info_records_to_user(struct fanotify=
_event *event,
>         return total_bytes;
>  }
>
> +/* Determine with value to report in event->fd */
> +static int event_fd_error(struct fsnotify_group *group, int fd, int nofd=
)
> +{
> +       /* An unprivileged user should never get an open fd or specific e=
rror */
> +       if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV))
> +               return nofd;
> +
> +       if (fd >=3D 0 || FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> +               return fd;
> +
> +       return nofd;
> +}
> +
>  static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                                   struct fanotify_event *event,
>                                   char __user *buf, size_t count)
> @@ -691,8 +697,32 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
>         if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
>             path && path->mnt && path->dentry) {
>                 fd =3D create_fd(group, path, &f);
> -               if (fd < 0)
> -                       return fd;
> +               /*
> +                * Opening an fd from dentry can fail for several reasons=
.
> +                * For example, when tasks are gone and we try to open th=
eir
> +                * /proc files or we try to open a WRONLY file like in sy=
sfs
> +                * or when trying to open a file that was deleted on the
> +                * remote network server.
> +                *
> +                * For a group with FAN_REPORT_FD_ERROR, we will send the
> +                * event with the error instead of the open fd, otherwise
> +                * Userspace may not get the error at all.
> +                * In any case, userspace will not know which file failed=
 to
> +                * open, so add a debug print for further investigation.
> +                */
> +               if (fd < 0) {
> +                       pr_debug("fanotify: create_fd(%pd2) failed err=3D=
%d\n",
> +                                path->dentry, fd);
> +                       if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> +                               return fd;
> +               }
> +       } else {
> +               /*
> +                * For a group with FAN_REPORT_FD_ERROR, report an event =
with
> +                * no file, such as an overflow event with -BADF instead =
of
> +                * FAN_NOFD, because FAN_NOFD collides with -EPERM.
> +                */
> +               fd =3D event_fd_error(group, -EBADF, FAN_NOFD);
>         }
>         metadata.fd =3D fd;
>
> @@ -709,17 +739,17 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>                  * The PIDTYPE_TGID check for an event->pid is performed
>                  * preemptively in an attempt to catch out cases where th=
e event
>                  * listener reads events after the event generating proce=
ss has
> -                * already terminated. Report FAN_NOPIDFD to the event li=
stener
> -                * in those cases, with all other pidfd creation errors b=
eing
> -                * reported as FAN_EPIDFD.
> +                * already terminated.  Depending on flag FAN_REPORT_FD_E=
RROR,
> +                * report either -ESRCH or FAN_NOPIDFD to the event liste=
ner in
> +                * those cases with all other pidfd creation errors repor=
ted as
> +                * the error code itself or as FAN_EPIDFD.
>                  */
>                 if (metadata.pid =3D=3D 0 ||
>                     !pid_has_task(event->pid, PIDTYPE_TGID)) {
> -                       pidfd =3D FAN_NOPIDFD;
> +                       pidfd =3D event_fd_error(group, -ESRCH, FAN_NOPID=
FD);
>                 } else {
>                         pidfd =3D pidfd_prepare(event->pid, 0, &pidfd_fil=
e);
> -                       if (pidfd < 0)
> -                               pidfd =3D FAN_EPIDFD;
> +                       pidfd =3D event_fd_error(group, pidfd, FAN_NOPIDF=
D);
>                 }
>         }
>
> @@ -737,9 +767,6 @@ static ssize_t copy_event_to_user(struct fsnotify_gro=
up *group,
>         buf +=3D FAN_EVENT_METADATA_LEN;
>         count -=3D FAN_EVENT_METADATA_LEN;
>
> -       if (fanotify_is_perm_event(event->mask))
> -               FANOTIFY_PERM(event)->fd =3D fd;
> -
>         if (info_mode) {
>                 ret =3D copy_info_records_to_user(event, info, info_mode,=
 pidfd,
>                                                 buf, count);
> @@ -753,15 +780,18 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>         if (pidfd_file)
>                 fd_install(pidfd, pidfd_file);
>
> +       if (fanotify_is_perm_event(event->mask))
> +               FANOTIFY_PERM(event)->fd =3D fd;
> +
>         return metadata.event_len;
>
>  out_close_fd:
> -       if (fd !=3D FAN_NOFD) {
> +       if (f) {
>                 put_unused_fd(fd);
>                 fput(f);
>         }
>
> -       if (pidfd >=3D 0) {
> +       if (pidfd_file) {
>                 put_unused_fd(pidfd);
>                 fput(pidfd_file);
>         }
> @@ -845,7 +875,7 @@ static ssize_t fanotify_read(struct file *file, char =
__user *buf,
>                 if (!fanotify_is_perm_event(event->mask)) {
>                         fsnotify_destroy_event(group, &event->fse);
>                 } else {
> -                       if (ret <=3D 0) {
> +                       if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
>                                 spin_lock(&group->notification_lock);
>                                 finish_permission_event(group,
>                                         FANOTIFY_PERM(event), FAN_DENY, N=
ULL);
> @@ -1453,7 +1483,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>                 return -EINVAL;
>         }
>
> -       if (fid_mode && class !=3D FAN_CLASS_NOTIF)
> +       /*
> +        * Legacy fanotify mode reports open fd's in event->fd.
> +        * With fid mode, open fd's are not reported and event->fd is FAN=
_NOFD.
> +        * High priority classes require reporting open fd's.
> +        * FAN_REPORT_FD_ERROR is only allowed when reporting open fd's.
> +        */
> +       if (fid_mode &&
> +           (class !=3D FAN_CLASS_NOTIF || flags & FAN_REPORT_FD_ERROR))
>                 return -EINVAL;
>
>         /*
> @@ -1954,7 +1991,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 12);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 13);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 4f1c4f603118..89ff45bd6f01 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -36,6 +36,7 @@
>  #define FANOTIFY_ADMIN_INIT_FLAGS      (FANOTIFY_PERM_CLASSES | \
>                                          FAN_REPORT_TID | \
>                                          FAN_REPORT_PIDFD | \
> +                                        FAN_REPORT_FD_ERROR | \
>                                          FAN_UNLIMITED_QUEUE | \
>                                          FAN_UNLIMITED_MARKS)
>
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index a37de58ca571..34f221d3a1b9 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -60,6 +60,7 @@
>  #define FAN_REPORT_DIR_FID     0x00000400      /* Report unique director=
y id */
>  #define FAN_REPORT_NAME                0x00000800      /* Report events =
with name */
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
> +#define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> --
> 2.34.1
>

