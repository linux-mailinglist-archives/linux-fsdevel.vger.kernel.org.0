Return-Path: <linux-fsdevel+bounces-54589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F2B0139B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2B31C2245B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531AA1D7E41;
	Fri, 11 Jul 2025 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1B7uvoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DE1A29A
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215602; cv=none; b=pNnjsR1AXBYfhWgHhW5eA5mgdaNecsnWuc5gDzt5vpsa2x2TgkxQSGY6r7bYNk9IsIcMkbCSxf0mEZRntErOFCbHAaEjFLGJdUOx9UU7fLCgRmZqxFbaSxZAeeuwM2F0vE9fnWFNQzzmBDN26Z80pGMA3m7+RvMR/UGrCqy/avQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215602; c=relaxed/simple;
	bh=9YWZwS+AEEWCZfQMbGBr5PdufgqlzfqTkcPaYTqT5rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu9GA63HLz6rudQA4Wb4BSj/q7C14gPZtmZaHCzJbaeRAdVlcq1/xYO9dHQT60YTcsb0oZ+lk99SO+CImHYl+rtrgK1tEO35dCOxXAqbJf1AvSMHpI3Auo+yU29CbJ/qpMQR7emA3aGt1hNLN5wTpcVTwj51JM6ZnDIz/Xi4Btg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1B7uvoW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so3012837a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 23:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752215599; x=1752820399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj4tIN5A/wH5y2ZNvy0hUFAPPY/KTTo/Vb4fbdxAhSg=;
        b=S1B7uvoWna8DWWZvdbjTxB0nKQUWfTHfWQB4X6+8k38nft2urs2IPYiZow/r21Ij/Q
         o5rZvvaEhekqo62OH2sMdcLrWDolpb0/pgqsb16ppQw+KMQFpoYpElBvgktmI2sNGMtJ
         5BgPG1dyiNdang+U6owR4wMVsKGSYdGpRVKJmKgQT/mjOZ9tj0CRnfOm/7TCZ700V9ry
         kppGFMNimYvorX51RTQepgl7I2AHdakF8ncPehtW/gie1s+lOaM8Ge+4SqlJlfCmCUxv
         icad4HAeuzy26zh5eNYstWAgeEn/vMtfNPBbZVLDQt3RwnShKXaDICr2kosiUtZBRW55
         LCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215599; x=1752820399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rj4tIN5A/wH5y2ZNvy0hUFAPPY/KTTo/Vb4fbdxAhSg=;
        b=Va/9E6ZNWidGQsrayoy/DuqqjLMhmpsAQVkZs6P0g/9J1RAfpdAAS709UpqZzUP6K7
         kaiWR28tkT/8F+yEZplXg/WmJn6fthSlR6WizksYfqS63Rn6EYs4xMH8mvRUba5OjR69
         T6Qs1H/aA1F022jlhk5GSsn4by/p95fSuiw4Cml9C+iSx1uqNZsDOdkQAS9kpVzNFrZG
         mb+ICasb/etkWRNHBaIBE5tJW1A8kG82504wLCQu23bBQWJwc+hGdEI8Ay704uc2oDrD
         rdiSI9q7TdNObMho8V77g7Fx3QcZSYTEa9wlC1piIN8RpwFpXbYzWtnYnkwsFlXoaWea
         7uIg==
X-Forwarded-Encrypted: i=1; AJvYcCULfmYiHdvikJZJ+L2yyoEjgCeE60S/VGhIMVmBdoeqkcWca9AkqTFpC7VKlE+f+9AtLNRjRvbs2ptEJM5t@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/jQY5O0qz0xzZ48NGntO6LqCLSYPjQLfiO0xcOSJaDrJ833+
	l2wdN3A2GJUB66fnLIb29archrG4bNMHgE5+ysxn5oARYkD5HAfEotPhr6ekEkYiOqmFfR+tCe1
	sZctDarDKgr9TxLy2+PDWn+OFMq2dL/MN63zyiBH2sw==
X-Gm-Gg: ASbGncty8WdgF+gaUGeBxEAkUfc1P0c87dWqoj6tWV8koo7AFfgIlLgtvNk6EHGb7/Y
	r88/s5j4kXHPnNxs7zWDd/7kiWQrTN78okK+BV7lpvCrTT/keCSw9LPIelSBdIvloWHt2I1rPFM
	8kf9fXdwnS2bto6wcJkoj/AQOdIrXYU3/Xb1gan6tKluN6te2onVulXyTrqUinI4W2RURVyzSTc
	64M7JiNczs7yq48bA==
X-Google-Smtp-Source: AGHT+IGL+ZC1qKJ8B1KHYiH7ResvFNGCKvI4caNjC3fYV2AhaTTVS4UeD5K6sJjBfXshyqqJRDB0aLyoNo1bqlUvM+E=
X-Received: by 2002:a17:907:1b0b:b0:ae3:5e70:330d with SMTP id
 a640c23a62f3a-ae6fbc109bamr204311466b.12.1752215598660; Thu, 10 Jul 2025
 23:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711023604.593885-1-ibrahimjirdeh@meta.com> <20250711023604.593885-4-ibrahimjirdeh@meta.com>
In-Reply-To: <20250711023604.593885-4-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 08:33:07 +0200
X-Gm-Features: Ac12FXxmdnN6yMpi_DccUQxBd31IE87xlAt4MiPEKqy8AuIoFepnuxQgwtAeXTA
Message-ID: <CAOQ4uxjK0-kCe4OpJHcf70ATy2ZR0fPg6C6NkVOJ1ReH4rHNpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fanotify: introduce event response identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:36=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
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
>  fs/notify/fanotify/fanotify.c       |  3 ++
>  fs/notify/fanotify/fanotify.h       | 11 ++++-
>  fs/notify/fanotify/fanotify_user.c  | 63 ++++++++++++++++++++---------
>  include/linux/fanotify.h            |  1 +
>  include/linux/fsnotify_backend.h    |  1 +
>  include/uapi/linux/fanotify.h       | 11 ++++-
>  tools/include/uapi/linux/fanotify.h | 11 ++++-
>  7 files changed, 77 insertions(+), 24 deletions(-)
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

idr_*() are not thread safe and there is no group lock held here.
But I misled you.
You should use ida_alloc_min()/ida_free() which are simpler and thread safe=
.


>         switch (event->type) {
>         case FANOTIFY_EVENT_TYPE_PATH:
>                 fanotify_free_path_event(event);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index f6d25fcf8692..b6a414f44acc 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -444,7 +444,7 @@ struct fanotify_perm_event {
>         size_t count;
>         u32 response;                   /* userspace answer to the event =
*/
>         unsigned short state;           /* state of the event */
> -       int fd;         /* fd we passed to userspace for this event */
> +       int id;         /* id we passed to userspace for this event */
>         union {
>                 struct fanotify_response_info_header hdr;
>                 struct fanotify_response_info_audit_rule audit_rule;
> @@ -559,3 +559,12 @@ static inline u32 fanotify_get_response_errno(int re=
s)
>  {
>         return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
>  }
> +
> +static inline bool fanotify_is_valid_response_id(struct fsnotify_group *=
group,
> +                                                int id)
> +{
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
> +               return id < -255;
> +
> +       return id >=3D 0;
> +}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 19d3f2d914fe..2e14db38d298 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -330,14 +330,19 @@ static int process_access_response(struct fsnotify_=
group *group,
>                                    size_t info_len)
>  {
>         struct fanotify_perm_event *event;
> -       int fd =3D response_struct->fd;
> +       int id =3D response_struct->id;
>         u32 response =3D response_struct->response;
>         int errno =3D fanotify_get_response_errno(response);
>         int ret =3D info_len;
>         struct fanotify_response_info_audit_rule friar;
>
> -       pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%=
p size=3D%zu\n",
> -                __func__, group, fd, response, errno, info, info_len);
> +       BUILD_BUG_ON(sizeof(response_struct->id) !=3D
> +                    sizeof(response_struct->fd));
> +       BUILD_BUG_ON(offsetof(struct fanotify_response, id) !=3D
> +                    offsetof(struct fanotify_response, fd));
> +
> +       pr_debug("%s: group=3D%p id=3D%d response=3D%x errno=3D%d buf=3D%=
p size=3D%zu\n",
> +                __func__, group, id, response, errno, info, info_len);
>         /*
>          * make sure the response is valid, if invalid we do nothing and =
either
>          * userspace can send a valid response or we will clean it up aft=
er the
> @@ -385,19 +390,18 @@ static int process_access_response(struct fsnotify_=
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
> -
> -       if (fd < 0)
> +       if (!fanotify_is_valid_response_id(group, id))
>                 return -EINVAL;
>
>         spin_lock(&group->notification_lock);
>         list_for_each_entry(event, &group->fanotify_data.access_list,
>                             fae.fse.list) {
> -               if (event->fd !=3D fd)
> +               if (event->id !=3D id)
>                         continue;
>
>                 list_del_init(&event->fae.fse.list);
> @@ -765,14 +769,20 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
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
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
> +               ret =3D idr_alloc_cyclic(&group->response_idr, event, 256=
,
> +                                      INT_MAX, GFP_NOWAIT);

So please use ida_alloc_min() with GFP_KERNEL
there is no reason for special memory allocation flags in this context.

> +               if (ret < 0)
> +                       return ret;
> +               fd =3D -ret;
> +       } else if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
> +                  path->mnt && path->dentry) {
> +               /*
> +                * For now, fid mode is required for an unprivileged list=
ener and
> +                * fid mode does not report fd in events.

Actually, my FAN_CLASS_PRE_CONTENT_FID patch makes this comment
inaccurate. The code is still correct, but not the reasoning to explain it.

I could change it myself in my patch, but as you move the comment might as
well fix it.

 /*
  * For now, fid mode and no-permission-events class are required
  * for FANOTIFY_UNPRIV listener and fid mode does not report fd in
  * non-permission notification events.  Keep this check anyway...

> Keep this check anyway
> +                * for safety in case fid mode requirement is relaxed in =
the future
> +                * to allow unprivileged listener to get events with no f=
d and no fid.
> +                */
>                 fd =3D create_fd(group, path, &f);
>                 /*
>                  * Opening an fd from dentry can fail for several reasons=
.
> @@ -803,7 +813,11 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
>                         }
>                 }
>         }
> -       if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> +
> +       BUILD_BUG_ON(sizeof(metadata.id) !=3D sizeof(metadata.fd));
> +       BUILD_BUG_ON(offsetof(struct fanotify_event_metadata, id) !=3D
> +                    offsetof(struct fanotify_event_metadata, fd));
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR | FAN_REPORT_RESPON=
SE_ID))
>                 metadata.fd =3D fd;
>         else
>                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
> @@ -859,7 +873,7 @@ static ssize_t copy_event_to_user(struct fsnotify_gro=
up *group,
>                 fd_install(pidfd, pidfd_file);
>
>         if (fanotify_is_perm_event(event->mask))
> -               FANOTIFY_PERM(event)->fd =3D fd;
> +               FANOTIFY_PERM(event)->id =3D fd;
>
>         return metadata.event_len;
>
> @@ -944,7 +958,9 @@ static ssize_t fanotify_read(struct file *file, char =
__user *buf,
>                 if (!fanotify_is_perm_event(event->mask)) {
>                         fsnotify_destroy_event(group, &event->fse);
>                 } else {
> -                       if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
> +                       if (ret <=3D 0 ||
> +                           !fanotify_is_valid_response_id(
> +                                   group, FANOTIFY_PERM(event)->id)) {
>                                 spin_lock(&group->notification_lock);
>                                 finish_permission_event(group,
>                                         FANOTIFY_PERM(event), FAN_DENY, N=
ULL);
> @@ -1584,6 +1600,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>                 return -EINVAL;
>
>         /*
> +     * With group that reports fid info and allows pre-content events,
> +     * user may request to get a response id instead of event->fd.
> +     */

Seems like the indentation here is off.

> +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> +           (!fid_mode || class =3D=3D FAN_CLASS_NOTIF))
> +               return -EINVAL;
> +
> +       /*
>          * Child name is reported with parent fid so requires dir fid.
>          * We can report both child fid and dir fid with or without name.
>          */
> @@ -1660,6 +1684,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>                 fd =3D -EINVAL;
>                 goto out_destroy_group;
>         }
> +       idr_init(&group->response_idr);

So ida_init() and you are also missing ida_destroy() in
fanotify_free_group_priv()

Thanks,
Amir.

