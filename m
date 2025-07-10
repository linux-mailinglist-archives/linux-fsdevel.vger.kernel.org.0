Return-Path: <linux-fsdevel+bounces-54448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E572AFFC84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8A54A153B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243328CF77;
	Thu, 10 Jul 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrnjKkUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35D28C5BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136725; cv=none; b=h7FxVFVmnJs0UsIUBhZE9DBBJAzcyPwJtWOZrtGcseeeEkjc5ybi8K0OrYCUvFPv5MMcR+5tovdqi9lWpcnbkYeuJe7rFj5i97XuRcWtiVzfe5ROwnEOU0/7GgwJHFDnWwSX3T/YLm3qoy2CKCoU+A22WX3FHu/Us6NJyZyZeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136725; c=relaxed/simple;
	bh=+7roc2qKmyoqGvyVtunNt1rI9jLhD47pCaFaLv4pHBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pisL5cAtttvMMb6FTp0t1lSq4y+iFgnkIMiZrUfrldXWvohhj2KppAhZ62qMwogXCfmuW4pYOpvUBTw0nHGQLAp7bIfHtM9SwyeeQQekb/iFTIdbfc6X8E+gBAnlEGp1zBDFeOiFQtWu0sQV5v8IYZEiMRwEXB+9zKE/p1/k6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrnjKkUe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0df6f5758so122670666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752136721; x=1752741521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoB1to8PXJ/hSnNtEZvt44d9qQ/PMels7qiQLN/Mxzo=;
        b=ZrnjKkUes1YO7NVg5UiCNTbHm02t5KDtHwnoY6xaacebdpG8qpmdkGCN3MoMuAdtFS
         ccVDFsonf4UheXIBotttbpKbj8Cm1JKpy97jEILelXJeaIbJx9B984a43ZpgwGU26eNk
         TRGkPuLCgftS0tj2Jk4fvmEX6KQWFES+i6hPJB1sDjJJ96caeZbNeMhdzTslOQRDX7tu
         bYCJVLODeWz63zkfF0lOZO658Q3HngblKuOjtn6KTYTeiilk7PwUHiRaM+uZNHKmqb1A
         9+EIqWGIqUmerjjINEZFkCWOLCaf8KQbGFf99cc3ZcCDxBsg7quLOQz6iIWoNnNV00sg
         75Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136721; x=1752741521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoB1to8PXJ/hSnNtEZvt44d9qQ/PMels7qiQLN/Mxzo=;
        b=iYVwb9+awfiYfp1e4pDFXiz9xP0TBIIahSGIUjfouTplb+xz7O4WQmh3Rm8SKSdlFD
         c98VQxnayXXDZ4b0geMQSG1utKzKeAmCr0eCVmVTTgldgPR0DPJEEJnz2j6D6lTbIHMR
         ouYnx8++tEWy2hYnQm2u8WVcGlff/ppsVwRP3VMsItmZ/O/0RwnmjF83qsv/DX3ZV6Fq
         GCLmgt1kmvY4Xqoq4gVxEIM1IOaCYWgIt19HoXDVmuRyCJwfO4TiIbCo+b2vHPA/jycO
         uwF8MWQq7MitgsYkDmb7d+hCzXBJPO4TmjBlLCZOVcDp/Hi+KcdZK6vFRvAX69fED0s8
         GmAw==
X-Forwarded-Encrypted: i=1; AJvYcCU6amupU7AaKkg7g50toy8miAx+XomU9xv9OL7TbXqlDQ0cYD0DFzqXluUfPIXhkzqZG2n1DiGBdLZnGnex@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSuy1LKdz3g/sbqnEHPyp6fssprNfpIqdKJ2k4NATn6meet7z
	rzrUZ8LLz6MsZ14xK2V4Ytgkb9p1NnehR3D81Eeg+kApQXofKbQSO8puF2temFz4IULkGMZLMLd
	0eObmK1urMxe+Axb4J856kefLX8DIXkk=
X-Gm-Gg: ASbGncsTGU8WpqeoIA5K2wJmosQdosKEWlK5lZJ4O/l36k26AY0g13sN0tGfiLd9MFV
	4mN6MXLbKFdxc+zaenunWN2dyIgZkm6SSYIxFW2ZWniT08fk9bmb5wuckztIK44odB/aZ6yvoaA
	9yejOE/Kc3E/Ww0fW9jfr8iprtJiFZI7kUa5NNC4RjJmkamJwqMz9Elg==
X-Google-Smtp-Source: AGHT+IFVp4OKHuKHVcPwBcu5VFeg5U+ZjsAXi195bJct+Ukujeo4L3n9vrz2YossTqZmCrSjtXKR8AXh25je0QZS1B8=
X-Received: by 2002:a17:907:60cf:b0:ad8:8cd8:a3b7 with SMTP id
 a640c23a62f3a-ae6e6ea26aemr178309566b.23.1752136720718; Thu, 10 Jul 2025
 01:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710042049.3705747-1-ibrahimjirdeh@meta.com> <20250710042049.3705747-4-ibrahimjirdeh@meta.com>
In-Reply-To: <20250710042049.3705747-4-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Jul 2025 10:38:29 +0200
X-Gm-Features: Ac12FXxcCwy-Wc77bUswZMLpJDx7gYTXYgDHQlj4i4AE1Vgwqhr2yw4TYfOgSmQ
Message-ID: <CAOQ4uxgFpCS2H6v5V6AH-Z15at7ZDUFdp+dXdfpo7agMRRyjtg@mail.gmail.com>
Subject: Re: [PATCH 3/3] [PATCH v2 3/3] fanotify: introduce event response identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com, 
	ibrahimjirdeh <ibrahimjirdeh@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 6:21=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> From: ibrahimjirdeh <ibrahimjirdeh@fb.com>
>
> Summary:

Formatting issue.

> This adds support for responding to events via response identifier. This
> prevents races if there are multiple processes backing the same fanotify
> group (eg. handover of fanotify group to new instance of a backing daemon=
).
> It is also useful for reporting pre-dir-content events without an
> event->fd:
> https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2r=
inzwbq7xxfjf5z7@3nqidi3mno46/.
>
> Rather than introducing a new event identifier field and extending
> fanotify_event_metadata, we have opted to overload event->fd and restrict
> this functionality to use-cases which are using file handle apis
> (FAN_REPORT_FID).
>
> In terms of how response ids are allocated, we use an idr for allocation
> and restrict the id range to below -255 to ensure there is no overlap wit=
h
> existing fd-as-identifier usage. We can also leverage the added idr for
> more efficient lookup when handling response although that is not done
> in this patch.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxheeLXdTLLWrixnTJcxVP+B=
V4ViXijbvERHPenzgDMUTA@mail.gmail.com/
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  fs/notify/fanotify/fanotify.c       |   3 +
>  fs/notify/fanotify/fanotify.h       |   5 +-
>  fs/notify/fanotify/fanotify_user.c  | 129 ++++++++++++++++++----------
>  include/linux/fanotify.h            |   3 +-
>  include/linux/fsnotify_backend.h    |   1 +
>  include/uapi/linux/fanotify.h       |  11 ++-
>  tools/include/uapi/linux/fanotify.h |  11 ++-
>  7 files changed, 110 insertions(+), 53 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 34acb7c16e8b..d9aebd359199 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -1106,6 +1106,9 @@ static void fanotify_free_event(struct fsnotify_gro=
up *group,
>
>         event =3D FANOTIFY_E(fsn_event);
>         put_pid(event->pid);
> +       if (fanotify_is_perm_event(event->mask) &&
> +           FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
> +               idr_remove(&group->response_idr, -FANOTIFY_PERM(event)->i=
d);
>         switch (event->type) {
>         case FANOTIFY_EVENT_TYPE_PATH:
>                 fanotify_free_path_event(event);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index f6d25fcf8692..8d62321237d6 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -444,7 +444,10 @@ struct fanotify_perm_event {
>         size_t count;
>         u32 response;                   /* userspace answer to the event =
*/
>         unsigned short state;           /* state of the event */
> -       int fd;         /* fd we passed to userspace for this event */
> +       union {
> +               __s32 fd;                       /* fd we passed to usersp=
ace for this event */
> +               __s32 id;                       /* FAN_REPORT_RESPONSE_ID=
 */
> +       };

That's an "int" and I don't think that we need a union in this internal con=
text.
int id; /* id we passed to userspace for this event */
is always correct, whether the id is also an fd or not.


>         union {
>                 struct fanotify_response_info_header hdr;
>                 struct fanotify_response_info_audit_rule audit_rule;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 19d3f2d914fe..b033f86e0db3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -330,14 +330,16 @@ static int process_access_response(struct fsnotify_=
group *group,
>                                    size_t info_len)
>  {
>         struct fanotify_perm_event *event;
> -       int fd =3D response_struct->fd;
> +       int id =3D FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) ?
> +                        response_struct->id :
> +                        response_struct->fd;

Not needed. Can always use int id =3D response_struct->id;
it is never used as an actual fd in this context.
But this function would be a good place to add:

BUILD_BUG_ON(sizeof(response_struct->id) !=3D sizeof(response_struct->fd));
BUILD_BUG_ON(offsetof(struct fanotity_response, id) !=3D offsetof(struct
fanotify_repose, fd));

to make sure that code can use either alternative safely.

>         u32 response =3D response_struct->response;
>         int errno =3D fanotify_get_response_errno(response);
>         int ret =3D info_len;
>         struct fanotify_response_info_audit_rule friar;
>
> -       pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%=
p size=3D%zu\n",
> -                __func__, group, fd, response, errno, info, info_len);
> +       pr_debug("%s: group=3D%p id=3D%d response=3D%x errno=3D%d buf=3D%=
p size=3D%zu\n",
> +                __func__, group, id, response, errno, info, info_len);
>         /*
>          * make sure the response is valid, if invalid we do nothing and =
either
>          * userspace can send a valid response or we will clean it up aft=
er the
> @@ -385,19 +387,24 @@ static int process_access_response(struct fsnotify_=
group *group,
>                 ret =3D process_access_response_info(info, info_len, &fri=
ar);
>                 if (ret < 0)
>                         return ret;
> -               if (fd =3D=3D FAN_NOFD)
> +               if (id =3D=3D FAN_NOFD)
>                         return ret;
>         } else {
>                 ret =3D 0;
>         }
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) && id >=3D -255=
)
> +               return -EINVAL;
>
> -       if (fd < 0)
> +       if (!FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) && id < 0)
>                 return -EINVAL;

Please use helper for both cases above:
static inline fanotify_is_valid_response_id(struct fsnotify_group
*group, int id)

>
>         spin_lock(&group->notification_lock);
>         list_for_each_entry(event, &group->fanotify_data.access_list,
>                             fae.fse.list) {
> -               if (event->fd !=3D fd)
> +               int other_id =3D FAN_GROUP_FLAG(group, FAN_REPORT_RESPONS=
E_ID) ?
> +                                      event->id :
> +                                      event->fd;
> +               if (other_id !=3D id)

No need. can use if (event->id !=3D id)

>                         continue;
>
>                 list_del_init(&event->fae.fse.list);
> @@ -765,48 +772,58 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>             task_tgid(current) !=3D event->pid)
>                 metadata.pid =3D 0;
>
> -       /*
> -        * For now, fid mode is required for an unprivileged listener and
> -        * fid mode does not report fd in events.  Keep this check anyway
> -        * for safety in case fid mode requirement is relaxed in the futu=
re
> -        * to allow unprivileged listener to get events with no fd and no=
 fid.
> -        */
> -       if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> -           path && path->mnt && path->dentry) {
> -               fd =3D create_fd(group, path, &f);
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
> +               ret =3D idr_alloc_cyclic(&group->response_idr, event, 256=
, INT_MAX,
> +                                      GFP_NOWAIT);
> +               if (ret < 0)
> +                       return ret;
> +               metadata.id =3D -ret;
> +       } else {

Please avoid this unneeded churn and unneeded nesting:

+       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
...
+       } else if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && ...

And I would assign fd =3D -ret; to make the code below simpler...

>                 /*
> -                * Opening an fd from dentry can fail for several reasons=
.
> -                * For example, when tasks are gone and we try to open th=
eir
> -                * /proc files or we try to open a WRONLY file like in sy=
sfs
> -                * or when trying to open a file that was deleted on the
> -                * remote network server.
> -                *
> -                * For a group with FAN_REPORT_FD_ERROR, we will send the
> -                * event with the error instead of the open fd, otherwise
> -                * Userspace may not get the error at all.
> -                * In any case, userspace will not know which file failed=
 to
> -                * open, so add a debug print for further investigation.
> +                * For now, fid mode is required for an unprivileged list=
ener and
> +                * fid mode does not report fd in events.  Keep this chec=
k anyway
> +                * for safety in case fid mode requirement is relaxed in =
the future
> +                * to allow unprivileged listener to get events with no f=
d and no fid.
>                  */
> -               if (fd < 0) {
> -                       pr_debug("fanotify: create_fd(%pd2) failed err=3D=
%d\n",
> -                                path->dentry, fd);
> -                       if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR)) =
{
> -                               /*
> -                                * Historically, we've handled EOPENSTALE=
 in a
> -                                * special way and silently dropped such
> -                                * events. Now we have to keep it to main=
tain
> -                                * backward compatibility...
> -                                */
> -                               if (fd =3D=3D -EOPENSTALE)
> -                                       fd =3D 0;
> -                               return fd;
> +               if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
> +                   path->mnt && path->dentry) {
> +                       fd =3D create_fd(group, path, &f);
> +                       /*
> +                        * Opening an fd from dentry can fail for several=
 reasons.
> +                        * For example, when tasks are gone and we try to=
 open their
> +                        * /proc files or we try to open a WRONLY file li=
ke in sysfs
> +                        * or when trying to open a file that was deleted=
 on the
> +                        * remote network server.
> +                        *
> +                        * For a group with FAN_REPORT_FD_ERROR, we will =
send the
> +                        * event with the error instead of the open fd, o=
therwise
> +                        * Userspace may not get the error at all.
> +                        * In any case, userspace will not know which fil=
e failed to
> +                        * open, so add a debug print for further investi=
gation.
> +                        */
> +                       if (fd < 0) {
> +                               pr_debug(
> +                                       "fanotify: create_fd(%pd2) failed=
 err=3D%d\n",
> +                                       path->dentry, fd);
> +                               if (!FAN_GROUP_FLAG(group,
> +                                                   FAN_REPORT_FD_ERROR))=
 {
> +                                       /*
> +                                        * Historically, we've handled EO=
PENSTALE in a
> +                                        * special way and silently dropp=
ed such
> +                                        * events. Now we have to keep it=
 to maintain
> +                                        * backward compatibility...
> +                                        */
> +                                       if (fd =3D=3D -EOPENSTALE)
> +                                               fd =3D 0;
> +                                       return fd;
> +                               }
>                         }
>                 }
> +               if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> +                       metadata.fd =3D fd;
> +               else
> +                       metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>         }
> -       if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> -               metadata.fd =3D fd;
> -       else
> -               metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>

IMO, this is shorter and nicer after assigning fd =3D -ret; above:

       if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR |

FAN_REPORT_RESPONSE_ID))
               metadata.fd =3D fd;
       else
               metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;

>         if (pidfd_mode) {
>                 /*
> @@ -858,8 +875,12 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
>         if (pidfd_file)
>                 fd_install(pidfd, pidfd_file);
>
> -       if (fanotify_is_perm_event(event->mask))
> -               FANOTIFY_PERM(event)->fd =3D fd;
> +       if (fanotify_is_perm_event(event->mask)) {
> +               if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
> +                       FANOTIFY_PERM(event)->id =3D metadata.id;
> +               else
> +                       FANOTIFY_PERM(event)->fd =3D fd;

Again, no need for a special case here.

FANOTIFY_PERM(event)->id =3D fd;

> +       }
>
>         return metadata.event_len;
>
> @@ -944,7 +965,11 @@ static ssize_t fanotify_read(struct file *file, char=
 __user *buf,
>                 if (!fanotify_is_perm_event(event->mask)) {
>                         fsnotify_destroy_event(group, &event->fse);
>                 } else {
> -                       if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
> +                       if (ret <=3D 0 ||
> +                           ((FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_I=
D) &&
> +                             FANOTIFY_PERM(event)->id >=3D -255) ||
> +                            (!FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_=
ID) &&
> +                             FANOTIFY_PERM(event)->fd < 0))) {

Please create a small helper fanotify_is_valid_response_id()


>                                 spin_lock(&group->notification_lock);
>                                 finish_permission_event(group,
>                                         FANOTIFY_PERM(event), FAN_DENY, N=
ULL);
> @@ -1584,6 +1609,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>                 return -EINVAL;
>
>         /*
> +     * With group that reports fid info and allows only pre-content even=
ts,

This line is true, but the word "only" is not clear in this context,
after the change from (class !=3D FAN_CLASS_PRE_CONTENT_FID),
so I would drop the word "only".

> +     * user may request to get a response id instead of event->fd.
> +     * FAN_REPORT_FD_ERROR does not make sense in this case.

This last line is not relevant anymore.

> +     */
> +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> +           (!fid_mode || class =3D=3D FAN_CLASS_NOTIF))
> +               return -EINVAL;
> +
> +       /*
>          * Child name is reported with parent fid so requires dir fid.
>          * We can report both child fid and dir fid with or without name.
>          */
> @@ -1660,6 +1694,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>                 fd =3D -EINVAL;
>                 goto out_destroy_group;
>         }
> +       idr_init(&group->response_idr);
>
>         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
>         if (flags & FAN_UNLIMITED_QUEUE) {
> @@ -2145,7 +2180,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 879cff5eccd4..4463fcfd16bb 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -38,7 +38,8 @@
>                                          FAN_REPORT_PIDFD | \
>                                          FAN_REPORT_FD_ERROR | \
>                                          FAN_UNLIMITED_QUEUE | \
> -                                        FAN_UNLIMITED_MARKS)
> +                                        FAN_UNLIMITED_MARKS | \
> +                                        FAN_REPORT_RESPONSE_ID)
>

For my OCD, place it after FAN_REPORT_FD_ERROR please ;)

Thanks,
Amir.

