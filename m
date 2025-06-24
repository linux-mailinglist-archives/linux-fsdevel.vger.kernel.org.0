Return-Path: <linux-fsdevel+bounces-52744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F6EAE62BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C51C18921A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3179028136E;
	Tue, 24 Jun 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWLNVYVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F24218ABA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761702; cv=none; b=LC8So/FSy7WCIEK0aZ3ZhPDpUoySfJjkWbVcxAGg2SDEKUVC7aaxL/eXew0b2SVMSPuMck7zJTKWYYXC+/viKaTOkp/kjNiyt0tAg5/CgQPGUGEstFtozTtZ1H0r1G0v7pZcfvWo8HlKrx4Atc4hlHarUpEf3GtywD3wVHGrEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761702; c=relaxed/simple;
	bh=I08ldsnCaMFZoZpcG65TSNJBeRPZZNzaUplRTPmJEEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYPfWCHaj8N81RlzwnmvFVqzgR9K84q0z6CIHCUbCfJ1bbqEJ7T0iFn/HXzGI0JbAW2U8Ct3S4uedBFRZg+dtCwh37yR3yVJWE0N4fcnoiZuO4TAwDvz4W+rMulPhLn1bN7APXeeP25WP8HXwW9LHPbZ6/3ss0pXqpBoDbOtAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWLNVYVJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso573017a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750761699; x=1751366499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVjRtXt0kpRj9ojd9VVwxlTJ8wJQ/hrB/hOXHXlJpTc=;
        b=NWLNVYVJytUHphBVQLQY0b4RCPnW2YLSUBKzlOv9QMXnHPu5ywdjg+vUb9E3SSJHQm
         n2yuj1MLaosqKbL0grMxbaE20J1xa2DnEWhUG/DLLuIbwKj2asGkHWKn2uwWEJ6oVxcE
         n+xUbHWIF1RTJ7Qr+1CEyUvKDPw2i1ZIcN3aMRcjBKEPTAkntW8z8TcVi/6pi6kzlJIM
         lLqjpXOdLOkpT1Fui7CiPUyXQNU4Inpp+EhAlXHnb92lcFKSznEDwPwEAI2I+haQ+OKF
         g9TKZM97Z1RT8K+emGpfDzo+hCNmWyHRhGnGyWbcUp9eyULy5ZTtQ/iT2+Mtuak4OonQ
         mqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761699; x=1751366499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVjRtXt0kpRj9ojd9VVwxlTJ8wJQ/hrB/hOXHXlJpTc=;
        b=tPcmrQH/yQ1S5Dwec9vb0D8yllPU4/D9kxMGWIFMlLEqmQetrxMZmnMjYaaxBab3XS
         ytf0DwmrFXYWkC+LaennW0z4t86RpZReffiJ20FN6nKxzgMlmQ8f+vBkXTpPgAB1RtGF
         x3Y8+juv2LODNtCO0WGyCMpG9FyMUXqu8NI6++DgpVgBILbDukcOYCBV29+IKbW8MVND
         1B0g7u1Yf+MiXyK4usd7m7aAEWpUELa8qqpfoZKb0MIn5FuH4R8bj/LlYQtlJs7OTbgs
         JK9zni9sT7sCyIyfefZKaRwZvR7ROqT3Vi+TSfQ+CE/SVdcnWgVlLGdpVhmD4ITNxw+1
         AULg==
X-Forwarded-Encrypted: i=1; AJvYcCUpTaCmSBsaZMNlUo3b80AipzGIUZ9R1U5Stay8/r27u8qDWiA8mTDTyl0bwY/IGjHfAeLk9RuVZ27MebgY@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbxFjjmiFk+/6t0qug32FoRxZeVOd2LEMpQnrh26+9BpjeqKv
	S2ViBSTiQbN+zxjYElGxGt75T8rhzRqZrNjddRVv5SoeoSXv1f+alMHVfIFhQS6VlRyqf18mdZ3
	C4v+VSNwoF+0NYI/YsxIMcbn6daDqfPU=
X-Gm-Gg: ASbGncs+jvgjaBvU72S8VODqiQ4SI1t/BQoeTwvPV3+03M1IQIxTiTIig/fgcVsz+Ih
	EaDkFksuo1dbPFcHsLimM/YuGL2+LJdCj/76F/MiEwBhzoMKGc5yKf/N5PnnaSzvE+I0GOccPfd
	+/Bp6FLY4lr6x6gxKBLuqBOakEboosW9I5DuPV10eVaW4=
X-Google-Smtp-Source: AGHT+IHhsu/JMeN5rjTLBNBrD9+FJxwasV2g/OA0NcJy1S5JAoompg6GGcn0VmeK4Pd596B+UW8vJkkQbQPH+ZHYCU0=
X-Received: by 2002:a17:907:868a:b0:ae0:2265:cf19 with SMTP id
 a640c23a62f3a-ae057bbbe5amr1444828066b.47.1750761698262; Tue, 24 Jun 2025
 03:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623193631.2780278-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250623193631.2780278-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 12:41:26 +0200
X-Gm-Features: Ac12FXzjijMuKAVzGKjr7Wlv6Ue_zH-5W142b544rz79IwWFDcyGv-SOPdJfJWw
Message-ID: <CAOQ4uxjki2j7-XrK7D_13uftAi5stfRobiMV_TZkc_LRwQCqwg@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:36=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> This adds support for responding to events via a unique event
> identifier. The main goal is to prevent races if there are multiple
> processes backing the same fanotify group (eg. handover of fanotify
> group to new instance of a backing daemon). A new event id field is
> added to fanotify metadata which is unique per group, and this behavior
> is guarded by FAN_ENABLE_EVENT_ID flag.

FWIW, we also need this functionality for reporting pre-dir-content
events without an event->fd:
https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd2rin=
zwbq7xxfjf5z7@3nqidi3mno46/

In theory, if you can manage with pre-content events that report fid
instead of open O_PATH fd, then we can add support for this mode
and tie the event->id solution with the FAN_NOFD case, but I am not sure
whether this would be too limiting for users.

You will notice that in this patch review, I am adding more questions
than answers.

The idea is to spark a design discussion and see if we can reach
consensus before you post v2.

>
> Some related discussion which this follows:
> https://lore.kernel.org/all/CAOQ4uxhuPBWD=3DTYZw974NsKFno-iNYSkHPw6WTfG_6=
9ovS=3DnJA@mail.gmail.com/
>
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  fs/notify/fanotify/fanotify.h       |  1 +
>  fs/notify/fanotify/fanotify_user.c  | 37 +++++++++++++++++++++++------
>  include/linux/fanotify.h            |  3 ++-
>  include/linux/fsnotify_backend.h    |  1 +
>  include/uapi/linux/fanotify.h       |  4 ++++
>  tools/include/uapi/linux/fanotify.h |  4 ++++
>  6 files changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index b78308975082..383c28c3f977 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -442,6 +442,7 @@ struct fanotify_perm_event {
>         u32 response;                   /* userspace answer to the event =
*/
>         unsigned short state;           /* state of the event */
>         int fd;         /* fd we passed to userspace for this event */
> +       u64 event_id;           /* unique event identifier for this event=
 */
>         union {
>                 struct fanotify_response_info_header hdr;
>                 struct fanotify_response_info_audit_rule audit_rule;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 02669abff4a5..c523c6283f1b 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -331,13 +331,15 @@ static int process_access_response(struct fsnotify_=
group *group,
>  {
>         struct fanotify_perm_event *event;
>         int fd =3D response_struct->fd;
> +       u64 event_id =3D response_struct->event_id;
>         u32 response =3D response_struct->response;
>         int errno =3D fanotify_get_response_errno(response);
>         int ret =3D info_len;
>         struct fanotify_response_info_audit_rule friar;
>
> -       pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=3D%=
p size=3D%zu\n",
> -                __func__, group, fd, response, errno, info, info_len);
> +       pr_debug(
> +               "%s: group=3D%p fd=3D%d event_id=3D%lld response=3D%x err=
no=3D%d buf=3D%p size=3D%zu\n",
> +               __func__, group, fd, event_id, response, errno, info, inf=
o_len);
>         /*
>          * make sure the response is valid, if invalid we do nothing and =
either
>          * userspace can send a valid response or we will clean it up aft=
er the
> @@ -398,13 +400,18 @@ static int process_access_response(struct fsnotify_=
group *group,
>                 ret =3D 0;
>         }
>
> -       if (fd < 0)
> +       u64 id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID) ? event_id =
: fd;
> +
> +       if (id < 0)

u64 cannot be negative.
I think we need to keep negative error values as invalid for better
backward compat
e.g. in case someone ends up writing FAN_NOFD in the response.

Jan has suggested that we use an idr (could be cyclic) for event id and the=
n
s32 is enough for a permission event/response id.
We could even start idr range at 256 and use response_struct->fd < -255
range as non-fd event ids.
We skip the range -255..-1 to continue to support FAN_REPORT_FD_ERROR.

This is convenient if we agree to overload event->fd and never need to
report both path fd and an event id.

OTOH, I can envision other uses of a u64 event id, unrelated to permission
event response.

I am considering extending fanotify API as a standard API to access fs
built-in persistent change journal, for fs that support it (e.g. lustre, nt=
fs).
In those filesystems, the persistent events have a u64 id,
so extending the fanotify API to describe the event with u64 id could be
useful down the road.

But an event id and permission response id do not have to be the same id..


>                 return -EINVAL;
>
>         spin_lock(&group->notification_lock);
>         list_for_each_entry(event, &group->fanotify_data.access_list,
>                             fae.fse.list) {
> -               if (event->fd !=3D fd)
> +               u64 other_id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_I=
D) ?
> +                                      event->event_id :
> +                                      event->fd;
> +               if (other_id !=3D id)
>                         continue;
>
>                 list_del_init(&event->fae.fse.list);
> @@ -815,6 +822,15 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
>         else
>                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>
> +       /*
> +        * Populate unique event id for group with FAN_ENABLE_EVENT_ID.
> +        */
> +       if (FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID))
> +               metadata.event_id =3D
> +                       (u64)atomic64_inc_return(&group->event_id_counter=
);
> +       else
> +               metadata.event_id =3D -1;
> +
>         if (pidfd_mode) {
>                 /*
>                  * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mu=
tual
> @@ -865,8 +881,10 @@ static ssize_t copy_event_to_user(struct fsnotify_gr=
oup *group,
>         if (pidfd_file)
>                 fd_install(pidfd, pidfd_file);
>
> -       if (fanotify_is_perm_event(event->mask))
> +       if (fanotify_is_perm_event(event->mask)) {
>                 FANOTIFY_PERM(event)->fd =3D fd;
> +               FANOTIFY_PERM(event)->event_id =3D metadata.event_id;
> +       }

Need to fix all the uses of FAN_EVENT_METADATA_LEN macro to be made
conditional of FAN_REPORT_EVENT_ID, so we do not copy out this new field
without user opt-in.

>
>         return metadata.event_len;
>
> @@ -951,7 +969,11 @@ static ssize_t fanotify_read(struct file *file, char=
 __user *buf,
>                 if (!fanotify_is_perm_event(event->mask)) {
>                         fsnotify_destroy_event(group, &event->fse);
>                 } else {
> -                       if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < 0) {
> +                       u64 event_id =3D
> +                               FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID=
) ?
> +                                       FANOTIFY_PERM(event)->fd :
> +                                       FANOTIFY_PERM(event)->event_id;
> +                       if (ret <=3D 0 || event_id < 0) {
>                                 spin_lock(&group->notification_lock);
>                                 finish_permission_event(group,
>                                         FANOTIFY_PERM(event), FAN_DENY, N=
ULL);
> @@ -1649,6 +1671,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         }
>
>         group->default_response =3D FAN_ALLOW;
> +       atomic64_set(&group->event_id_counter, 0);
>
>         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
>         if (flags & FAN_UNLIMITED_QUEUE) {
> @@ -2115,7 +2138,7 @@ static int __init fanotify_user_setup(void)
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
> index 182fc574b848..08bdb7aac070 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -38,7 +38,8 @@
>                                          FAN_REPORT_PIDFD | \
>                                          FAN_REPORT_FD_ERROR | \
>                                          FAN_UNLIMITED_QUEUE | \
> -                                        FAN_UNLIMITED_MARKS)
> +                                        FAN_UNLIMITED_MARKS | \
> +                                        FAN_ENABLE_EVENT_ID)
>
>  /*
>   * fanotify_init() flags that are allowed for user without CAP_SYS_ADMIN=
.
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 9683396acda6..58584a4e500a 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -232,6 +232,7 @@ struct fsnotify_group {
>         enum fsnotify_group_prio priority;      /* priority for sending e=
vents */
>         bool shutdown;          /* group is being shut down, don't queue =
more events */
>         unsigned int default_response; /* default response sent on group =
close */
> +       atomic64_t event_id_counter; /* counter to generate unique event =
ids */
>
>  #define FSNOTIFY_GROUP_USER    0x01 /* user allocated group */
>  #define FSNOTIFY_GROUP_DUPS    0x02 /* allow multiple marks per object *=
/
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 7badde273a66..e9fb8827fe1b 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -67,6 +67,8 @@
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
>  #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
> +/* Flag to populate and respond using unique event id */
> +#define FAN_ENABLE_EVENT_ID            0x00008000

While it's true that the feature impacts more than the reported event
format, this is the main thing that it does, so please name it
FAN_REPORT_EVENT_ID

>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -143,6 +145,7 @@ struct fanotify_event_metadata {
>         __aligned_u64 mask;
>         __s32 fd;
>         __s32 pid;
> +       __u64 event_id;
>  };

Not sure if this change calls for bumping FANOTIFY_METADATA_VERSION
but I think we should not extend the reported metadata_len
unless the user opted-in with FAN_REPORT_EVENT_ID.

If we do that we may break buggy programs that use the
FAN_EVENT_METADATA_LEN macro and it is an unneeded risk.

We should probably deprecate the FAN_EVENT_METADATA_LEN
definition in uapi/fanotify.h altogether and re-write the FAN_EVENT_OK() ma=
cro.

I know I asked for it, but extending fanotify_event_metadata does seem
to be a bit of a pain.

Thinking out loud, if we use idr to allocate an event id, as Jan suggested,
and we do want to allow it along side event->fd,
then we could also overload event->pid, i.e. the meaning of
FAN_ERPORT_EVENT_ID would be "event->pid is an event id",
Similarly to the way that we overloaded event->pid with FAN_REPORT_TID.
Users that need both event id and pid can use FAN_REPORT_PIDFD.

>
>  #define FAN_EVENT_INFO_TYPE_FID                1
> @@ -226,6 +229,7 @@ struct fanotify_event_info_mnt {
>
>  struct fanotify_response {
>         __s32 fd;
> +       __u64 event_id;
>         __u32 response;
>  };
>

Most likely we will end up with s32 response id, but if we do decide on
a separate u64 field, please move it to end for better struct alignment.

Thanks,
Amir.

