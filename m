Return-Path: <linux-fsdevel+bounces-54751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E092B0298F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 08:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E2D1BC522B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14701E7C1C;
	Sat, 12 Jul 2025 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFKf+IPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27514139B
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752301029; cv=none; b=NUmyx0yLD8v3NVtKoZmWJepKi520pEZ9Y5fE5rDKFW20dwF39MdRs1puvJWVgWIuDifo0h1nAIymVVyVDVSsm0EAzTloiuUgNXWo20D3JL0JASbk/+9rG0qmKFWxcnP3n1376jBanJT0VMA2NqEKp9boyloLjw0HauBap/IehO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752301029; c=relaxed/simple;
	bh=rapMlDFX2BhfyVb3bBf4y2fzlOLUqkGlUjjD4XaTFq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjBVfbx4lRrXjcFK5LBll2OYbtlW1rbnyScC0LFQ2vqX3qBc+FBi0tJ7XYDU/YbSEKBKW9C8lFS6iTjKGzwBmeK027h11KyIT/q0uDCoLfe0HVU8nCcSD1zAfUs6zT+ORLE+9h6mCY9tSDwDrNx41psPqVUWvUyeRf2m+4AbOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFKf+IPG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so2580116f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752301025; x=1752905825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyZjp/YHDLg+PhY13WtkzDdqPn1kY1EvbjzAtinge2s=;
        b=iFKf+IPGSJUAj+D/O+PuI9WQVKIqftSYHryKx1OEnIvKbKcupJXLmLn/b52AS7aqe6
         KiR6wqa6566wz9cANlMcqLQLYJDGfCr5vq3kENfXIeWMlaBh3jwT4H6SIfZuS8LyPjBe
         oZfzZu82LAezy4uPeHgXmsO6USIUdmHX+C6ZsjiuJdR+CoggHeyW7RbEteoOJWekjWkT
         3BTwh4LP4uf4OG5PsdIYT2kAadkbzhqiSmoDRhsNXTKDsV7vtPzjHE4AJH4CUJ52yDcg
         LFVah5qt1YsFaMrAy2xk0cSrrMho0NxEuXyURF81uSz0i6/Zs8ATTfcs2TFUsaVmXE3f
         wXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752301025; x=1752905825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyZjp/YHDLg+PhY13WtkzDdqPn1kY1EvbjzAtinge2s=;
        b=VVxcvxjfEtZdIjmr80y9QpKPIyx2VqyfLjO0lUm/SGLxIEGFTGlTd+hpIOYfPyhrVS
         MDUVC8RriKP9FyOrfoPxam9t7XlsdcBDtV0o5ZT8FdEr5WOsshcsY5qq/bDc5zKe4b5y
         ZV1HioBIAjJpBsf/zB4IUYFRan/g1jQBQmoIdYCuohitb8E4pjUIA2sjaoiYXnUticSn
         w6hxsn98vVoOW6uFN7UX/lAdIcSaZnUwxHUavRwUtgHDwlMAg/Iyk+pEOobCeYhfzvDI
         EVuAuWKjaOXl5fphi5vixCtgGC+MLIT95/rdLyNutaks+xhFDczB6N6jCUUEKUjDXD60
         OKbw==
X-Forwarded-Encrypted: i=1; AJvYcCVLHfYqSJewHl7qr7FNIcxBWgjszXqCaaWgWCVsOlgk/dgq5rpn4bRtMwmUMgjX3hK/08R0TtZZY34y8Qml@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhD2uIaId7knmStA78nxsRlRAA3OWWcJXXDctClLA8EnZN92u
	Tm/xMaV14MRR3pDbeeEFfi9YmSntw9/lw+hQ/H8dQbGmFTuu08eKr9mbnJ57coW0gxxCTyLRiGB
	26xk/6xsQlVQ1+3Vnpq1H5NKuvNdYZ2c=
X-Gm-Gg: ASbGncuC5E8m1c6JmKxalMoGveMQVkRMlDbL9nYuK8aMATOT+u0y/vbGbYOCqsgsN9x
	Fur2lM26G2jD5G0oxNF9WzxSmzzjRgxFC8cJ7ppRIWvSHg4bLWg7gWFqO7/zyYGiftPRXmnVsjN
	xGXdbm6oeJ2lRu3nHX3nsQNmJnw846clFT9BLF0UFK81OW5ayMboQwaI/nvWPvwZ91GsQbfsB/j
	SJJuTg=
X-Google-Smtp-Source: AGHT+IHK9lvcy0UyF/iuFUAzfIJAUIylzrQxWScNBjHOGduyzuQm2sVHAHiahDzqlrmsAnwGY+Hy8kNOW/HX596Sg0I=
X-Received: by 2002:a05:6000:2d88:b0:3a4:dfa9:ce28 with SMTP id
 ffacd0b85a97d-3b5f187d13emr4119085f8f.5.1752301024988; Fri, 11 Jul 2025
 23:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711183101.4074140-1-ibrahimjirdeh@meta.com> <20250711183101.4074140-4-ibrahimjirdeh@meta.com>
In-Reply-To: <20250711183101.4074140-4-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Jul 2025 08:16:53 +0200
X-Gm-Features: Ac12FXwQFIPs4JtskTlTc8gpSdhYYTEglhxiCRtl5QEJGUd9XTwxhKgFMscrBS4
Message-ID: <CAOQ4uxj7Ms0PKuAA3ypU9WUz7_CF5E_JPA-2hy1qYsg1PokNrw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fanotify: introduce event response identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:32=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
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
> In terms of how response ids are allocated, we use an ida for allocation
> and restrict the id range to below -255 to ensure there is no overlap wit=
h
> existing fd-as-identifier usage.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxheeLXdTLLWrixnTJcxVP+B=
V4ViXijbvERHPenzgDMUTA@mail.gmail.com/
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>

Looks nice!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c       |  4 ++
>  fs/notify/fanotify/fanotify.h       | 11 ++++-
>  fs/notify/fanotify/fanotify_user.c  | 63 ++++++++++++++++++++---------
>  include/linux/fanotify.h            |  1 +
>  include/linux/fsnotify_backend.h    |  1 +
>  include/uapi/linux/fanotify.h       | 11 ++++-
>  tools/include/uapi/linux/fanotify.h | 11 ++++-
>  7 files changed, 78 insertions(+), 24 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 34acb7c16e8b..307532464226 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -1045,6 +1045,7 @@ static void fanotify_free_group_priv(struct fsnotif=
y_group *group)
>  {
>         put_user_ns(group->user_ns);
>         kfree(group->fanotify_data.merge_hash);
> +       ida_destroy(&group->response_ida);
>         if (group->fanotify_data.ucounts)
>                 dec_ucount(group->fanotify_data.ucounts,
>                            UCOUNT_FANOTIFY_GROUPS);
> @@ -1106,6 +1107,9 @@ static void fanotify_free_event(struct fsnotify_gro=
up *group,
>
>         event =3D FANOTIFY_E(fsn_event);
>         put_pid(event->pid);
> +       if (fanotify_is_perm_event(event->mask) &&
> +           FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
> +               ida_free(&group->response_ida, -FANOTIFY_PERM(event)->id)=
;
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
> index 19d3f2d914fe..99af23b257f9 100644
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
> +               ret =3D ida_alloc_min(&group->response_ida, 256, GFP_KERN=
EL);
> +               if (ret < 0)
> +                       return ret;
> +               fd =3D -ret;
> +       } else if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
> +                  path->mnt && path->dentry) {
> +               /*
> +                * For now, fid mode and no-permission-events class are r=
equired for
> +                * FANOTIFY_UNPRIV listener and fid mode does not report =
fd in
> +                * non-permission notification events. Keep this check an=
yway for
> +                * safety in case fid mode requirement is relaxed in the =
future to
> +                * allow unprivileged listener to get events with no fd a=
nd no fid.
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
> @@ -1583,6 +1599,14 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>             (class | fid_mode) !=3D FAN_CLASS_PRE_CONTENT_FID)
>                 return -EINVAL;
>
> +       /*
> +        * With group that reports fid info and allows pre-content events=
,
> +        * user may request to get a response id instead of event->fd.
> +        */
> +       if ((flags & FAN_REPORT_RESPONSE_ID) &&
> +           (!fid_mode || class =3D=3D FAN_CLASS_NOTIF))
> +               return -EINVAL;
> +
>         /*
>          * Child name is reported with parent fid so requires dir fid.
>          * We can report both child fid and dir fid with or without name.
> @@ -1660,6 +1684,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>                 fd =3D -EINVAL;
>                 goto out_destroy_group;
>         }
> +       ida_init(&group->response_ida);
>
>         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
>         if (flags & FAN_UNLIMITED_QUEUE) {
> @@ -2145,7 +2170,7 @@ static int __init fanotify_user_setup(void)
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
> index 879cff5eccd4..85fce0a15005 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -37,6 +37,7 @@
>                                          FAN_REPORT_TID | \
>                                          FAN_REPORT_PIDFD | \
>                                          FAN_REPORT_FD_ERROR | \
> +                                        FAN_REPORT_RESPONSE_ID | \
>                                          FAN_UNLIMITED_QUEUE | \
>                                          FAN_UNLIMITED_MARKS)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 832d94d783d9..27299d5ca668 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -232,6 +232,7 @@ struct fsnotify_group {
>         unsigned int max_events;                /* maximum events allowed=
 on the list */
>         enum fsnotify_group_prio priority;      /* priority for sending e=
vents */
>         bool shutdown;          /* group is being shut down, don't queue =
more events */
> +       struct ida response_ida; /* used for response id allocation */
>
>  #define FSNOTIFY_GROUP_USER    0x01 /* user allocated group */
>  #define FSNOTIFY_GROUP_DUPS    0x02 /* allow multiple marks per object *=
/
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 28074ab3e794..e705dda14dfc 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -67,6 +67,7 @@
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
>  #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
> +#define FAN_REPORT_RESPONSE_ID         0x00008000 /* event->fd is a resp=
onse id */
>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -144,7 +145,10 @@ struct fanotify_event_metadata {
>         __u8 reserved;
>         __u16 metadata_len;
>         __aligned_u64 mask;
> -       __s32 fd;
> +       union {
> +               __s32 fd;
> +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> +       };
>         __s32 pid;
>  };
>
> @@ -228,7 +232,10 @@ struct fanotify_event_info_mnt {
>  #define FAN_RESPONSE_INFO_AUDIT_RULE   1
>
>  struct fanotify_response {
> -       __s32 fd;
> +       union {
> +               __s32 fd;
> +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> +       };
>         __u32 response;
>  };
>
> diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
> index e710967c7c26..6a3ada7c4abf 100644
> --- a/tools/include/uapi/linux/fanotify.h
> +++ b/tools/include/uapi/linux/fanotify.h
> @@ -67,6 +67,7 @@
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
>  #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
> +#define FAN_REPORT_RESPONSE_ID         0x00008000 /* event->fd is a resp=
onse id */
>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -141,7 +142,10 @@ struct fanotify_event_metadata {
>         __u8 reserved;
>         __u16 metadata_len;
>         __aligned_u64 mask;
> -       __s32 fd;
> +       union {
> +               __s32 fd;
> +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> +       };
>         __s32 pid;
>  };
>
> @@ -225,7 +229,10 @@ struct fanotify_event_info_mnt {
>  #define FAN_RESPONSE_INFO_AUDIT_RULE   1
>
>  struct fanotify_response {
> -       __s32 fd;
> +       union {
> +               __s32 fd;
> +               __s32 id; /* FAN_REPORT_RESPONSE_ID */
> +       };
>         __u32 response;
>  };
>
> --
> 2.47.1
>

