Return-Path: <linux-fsdevel+bounces-53161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCAAEB1D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1021BC74CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95E27F006;
	Fri, 27 Jun 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT2wAW2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96525178F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014792; cv=none; b=M3w5Taj7tAzut5LuK+VrJBg19rHs3rCEGrKNiq+WDFmZnDTGiFht4tjp0x0pCUazbDVNh3+jJ5YgnqHhTIE0zb+kgORy+pTBOQjv7+07mDINpuCKPNMjt2+Ky7NxypOodDX63BLcR35syu9Dd+aba8oIxJVgWaSH0uE0R8jQb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014792; c=relaxed/simple;
	bh=Xn0tn+0u+2R3qBfLHd0XR3hTV0+t/f86g6pFRTVks5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIyX3ddwBtcdcHDiSapFaLfb7CcPaXiWLEYrK/qh2IkvZBe74nMVKLB48x/sjx4O9kfeenH0OVDW0zXLJfs/7fOSYMqftUADSOQ31TS4N1QOH12qrXx9PBy8SNrCuuvvXzF/MyVwm00rTfRiNypxCFyKCxGKI4QIVUWTmmEFy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT2wAW2v; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0de1c378fso199209866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 01:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751014789; x=1751619589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6z/FO3McDwa0g0E4KRBkjlrIDGeQK5Mm0CDTNIR/q4=;
        b=fT2wAW2v88ZMuHqQIW4ahFIZHMV9oA34PVOEwUaBza1zaNsC3t3DYquJ0VtBejpLzl
         5bQ+/HF1a9r0Gh+KEY1xEaRf3bQIGbK67hQAmAn1gceXsTI/ta1Xr4zT40Y4dTPpjtpP
         zX78PWeSGqh1okEEInbwnAlhwDBUEZY2EzVxGj08OdtbTSEQljEjp72EVDQ750lwRzUQ
         PD3ItiDUx0Bv3iB6/FNH9K1zK2HOp8Sb81BUKUOLWQXIN0G3KKIMkFLwDQqGmfkVyNGn
         iW1YZp1vU8dppzsjgwfBn6oL9mbgnLlgMWcexkl/JWQCUuYfJAGsYrmvubkXl2mLW+K8
         aaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751014789; x=1751619589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6z/FO3McDwa0g0E4KRBkjlrIDGeQK5Mm0CDTNIR/q4=;
        b=ha1zivGH7kO8E4plUMtGST98nVdZQsJn9UTa9LIUyu4dy2Uty4uKnKro8CyUvIEhcm
         0FXqRovuRaXyZqpQ8HQdR0JY3YsG4oxTrs7sCgIBcDQNnLy2TiOvWbVGukFQM8XS3a9w
         QWgcyz65/qilAcK0aW4d56Dy9lXh3BQedGPuaijF1uYyhnIGPqJHzXRXo4r+xTXRlYIH
         ZLYrYBE4WpvHjjV7+ChM4oiHdIsXWdOqR7wtM0WbXtckpMQbjKPYUv1Pj5Q/S8iF2DHh
         IUdvjuQ5pvYZc5O3+txYgHK7TBuaURv+T0RxkJlWBkYbRj8PinFbxVeUR49VBRiANEZ0
         8mpg==
X-Forwarded-Encrypted: i=1; AJvYcCXvY0OUCXO7lYTEiMkdmrL7REV3WHHq0jdjSAFy/aT9lHU/1n1llHkOfqZexWtCaB6vIF6x9YV+TEqyVOSd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05jXUtqLNoF4+siohnnPJRY3PRtoK6zWwyrDGXoQALG6uzyaf
	WYqbKbCYwDs5qpg19Wgv5AxKv1yfI/QsO8Cwl5yZcGrRJmW9Xne3phOYSXZ1xKaom3B6iXwVY1T
	QJxS7AzyfY5EquXQgfnHs+fDcnpIRiw4=
X-Gm-Gg: ASbGnctr/qUgIRRsVjoeqaW8EhH2g2CnQTCwmnt+bU9vwNaTlK1A20yw/Cj6Kl8f/vQ
	aU1FhXAATM4mfJ5N9Z4PNMolaG59oOMniLo2Pxew5MGQadgAlgyqDz+UBvRb5NZx/MmAsj278eC
	2XxO14johmlTPvi25VNnV7N/BscAJ4CrpVHYCH5JRsErs=
X-Google-Smtp-Source: AGHT+IESdpJtPKEa6YkOLQwHmhlg+N7GnBU8+ivoytPyPHwBeNz4ftKKOglD2aeiQVcW7L1fic+Up6ypBttttE1BNtc=
X-Received: by 2002:a17:907:3e1a:b0:ae3:5e70:332b with SMTP id
 a640c23a62f3a-ae35e7036a8mr97973366b.52.1751014788161; Fri, 27 Jun 2025
 01:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjki2j7-XrK7D_13uftAi5stfRobiMV_TZkc_LRwQCqwg@mail.gmail.com>
 <20250627060548.2542757-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250627060548.2542757-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Jun 2025 10:59:36 +0200
X-Gm-Features: Ac12FXwXZVi1MXJlt9Uk2V0tJuBO_yEjTeXKYMzIApMyPIe_3ScP2yDJQtGFTpc
Message-ID: <CAOQ4uxheeLXdTLLWrixnTJcxVP+BV4ViXijbvERHPenzgDMUTA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 8:05=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> On 6/24/25, 3:41 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
> > On Mon, Jun 23, 2025 at 9:36 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com>=
 wrote:
> > >
> > > This adds support for responding to events via a unique event
> > > identifier. The main goal is to prevent races if there are multiple
> > > processes backing the same fanotify group (eg. handover of fanotify
> > > group to new instance of a backing daemon). A new event id field is
> > > added to fanotify metadata which is unique per group, and this behavi=
or
> > > is guarded by FAN_ENABLE_EVENT_ID flag.
> >
> > FWIW, we also need this functionality for reporting pre-dir-content
> > events without an event->fd:
> > https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd=
2rinzwbq7xxfjf5z7@3nqidi3mno46/
> >
> > In theory, if you can manage with pre-content events that report fid
> > instead of open O_PATH fd, then we can add support for this mode
> > and tie the event->id solution with the FAN_NOFD case, but I am not sur=
e
> > whether this would be too limiting for users.
> >
> > You will notice that in this patch review, I am adding more questions
> > than answers.
> >
> > The idea is to spark a design discussion and see if we can reach
> > consensus before you post v2.
>
> Thanks for the thoughtful feedback / discussion. I had a few questions fo=
r the
> high level comment about separating response id from event id, but will m=
ake
> sure to incorporate the additional suggestions eg. using s32 / idr depend=
ing
> on which approach we choose.
>
> >
> > >
> > > Some related discussion which this follows:
> > > https://lore.kernel.org/all/CAOQ4uxhuPBWD=3DTYZw974NsKFno-iNYSkHPw6WT=
fG_69ovS=3DnJA@mail.gmail.com/
> > >
> > > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > > ---
> > >  fs/notify/fanotify/fanotify.h       |  1 +
> > >  fs/notify/fanotify/fanotify_user.c  | 37 +++++++++++++++++++++++----=
--
> > >  include/linux/fanotify.h            |  3 ++-
> > >  include/linux/fsnotify_backend.h    |  1 +
> > >  include/uapi/linux/fanotify.h       |  4 ++++
> > >  tools/include/uapi/linux/fanotify.h |  4 ++++
> > >  6 files changed, 42 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanot=
ify.h
> > > index b78308975082..383c28c3f977 100644
> > > --- a/fs/notify/fanotify/fanotify.h
> > > +++ b/fs/notify/fanotify/fanotify.h
> > > @@ -442,6 +442,7 @@ struct fanotify_perm_event {
> > >         u32 response;                   /* userspace answer to the ev=
ent */
> > >         unsigned short state;           /* state of the event */
> > >         int fd;         /* fd we passed to userspace for this event *=
/
> > > +       u64 event_id;           /* unique event identifier for this e=
vent */
> > >         union {
> > >                 struct fanotify_response_info_header hdr;
> > >                 struct fanotify_response_info_audit_rule audit_rule;
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/=
fanotify_user.c
> > > index 02669abff4a5..c523c6283f1b 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -331,13 +331,15 @@ static int process_access_response(struct fsnot=
ify_group *group,
> > >  {
> > >         struct fanotify_perm_event *event;
> > >         int fd =3D response_struct->fd;
> > > +       u64 event_id =3D response_struct->event_id;
> > >         u32 response =3D response_struct->response;
> > >         int errno =3D fanotify_get_response_errno(response);
> > >         int ret =3D info_len;
> > >         struct fanotify_response_info_audit_rule friar;
> > >
> > > -       pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=
=3D%p size=3D%zu\n",
> > > -                __func__, group, fd, response, errno, info, info_len=
);
> > > +       pr_debug(
> > > +               "%s: group=3D%p fd=3D%d event_id=3D%lld response=3D%x=
 errno=3D%d buf=3D%p size=3D%zu\n",
> > > +               __func__, group, fd, event_id, response, errno, info,=
 info_len);
> > >         /*
> > >          * make sure the response is valid, if invalid we do nothing =
and either
> > >          * userspace can send a valid response or we will clean it up=
 after the
> > > @@ -398,13 +400,18 @@ static int process_access_response(struct fsnot=
ify_group *group,
> > >                 ret =3D 0;
> > >         }
> > >
> > > -       if (fd < 0)
> > > +       u64 id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID) ? event=
_id : fd;
> > > +
> > > +       if (id < 0)
> >
> > u64 cannot be negative.
> > I think we need to keep negative error values as invalid for better
> > backward compat
> > e.g. in case someone ends up writing FAN_NOFD in the response.
> >
> > Jan has suggested that we use an idr (could be cyclic) for event id and=
 then
> > s32 is enough for a permission event/response id.
> > We could even start idr range at 256 and use response_struct->fd < -255
> > range as non-fd event ids.
> > We skip the range -255..-1 to continue to support FAN_REPORT_FD_ERROR.
> >
> > This is convenient if we agree to overload event->fd and never need to
> > report both path fd and an event id.
> >
> > OTOH, I can envision other uses of a u64 event id, unrelated to permiss=
ion
> > event response.
> >
> > I am considering extending fanotify API as a standard API to access fs
> > built-in persistent change journal, for fs that support it (e.g. lustre=
, ntfs).
> > In those filesystems, the persistent events have a u64 id,
> > so extending the fanotify API to describe the event with u64 id could b=
e
> > useful down the road.
> >
> > But an event id and permission response id do not have to be the same i=
d..
> >
> >
> > >                 return -EINVAL;
> > >
> > >         spin_lock(&group->notification_lock);
> > >         list_for_each_entry(event, &group->fanotify_data.access_list,
> > >                             fae.fse.list) {
> > > -               if (event->fd !=3D fd)
> > > +               u64 other_id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVE=
NT_ID) ?
> > > +                                      event->event_id :
> > > +                                      event->fd;
> > > +               if (other_id !=3D id)
> > >                         continue;
> > >
> > >                 list_del_init(&event->fae.fse.list);
> > > @@ -815,6 +822,15 @@ static ssize_t copy_event_to_user(struct fsnotif=
y_group *group,
> > >         else
> > >                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
> > >
> > > +       /*
> > > +        * Populate unique event id for group with FAN_ENABLE_EVENT_I=
D.
> > > +        */
> > > +       if (FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID))
> > > +               metadata.event_id =3D
> > > +                       (u64)atomic64_inc_return(&group->event_id_cou=
nter);
> > > +       else
> > > +               metadata.event_id =3D -1;
> > > +
> > >         if (pidfd_mode) {
> > >                 /*
> > >                  * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TI=
D mutual
> > > @@ -865,8 +881,10 @@ static ssize_t copy_event_to_user(struct fsnotif=
y_group *group,
> > >         if (pidfd_file)
> > >                 fd_install(pidfd, pidfd_file);
> > >
> > > -       if (fanotify_is_perm_event(event->mask))
> > > +       if (fanotify_is_perm_event(event->mask)) {
> > >                 FANOTIFY_PERM(event)->fd =3D fd;
> > > +               FANOTIFY_PERM(event)->event_id =3D metadata.event_id;
> > > +       }
> >
> > Need to fix all the uses of FAN_EVENT_METADATA_LEN macro to be made
> > conditional of FAN_REPORT_EVENT_ID, so we do not copy out this new fiel=
d
> > without user opt-in.
> >
> > >
> > >         return metadata.event_len;
> > >
> > > @@ -951,7 +969,11 @@ static ssize_t fanotify_read(struct file *file, =
char __user *buf,
> > >                 if (!fanotify_is_perm_event(event->mask)) {
> > >                         fsnotify_destroy_event(group, &event->fse);
> > >                 } else {
> > > -                       if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < =
0) {
> > > +                       u64 event_id =3D
> > > +                               FAN_GROUP_FLAG(group, FAN_ENABLE_EVEN=
T_ID) ?
> > > +                                       FANOTIFY_PERM(event)->fd :
> > > +                                       FANOTIFY_PERM(event)->event_i=
d;
> > > +                       if (ret <=3D 0 || event_id < 0) {
> > >                                 spin_lock(&group->notification_lock);
> > >                                 finish_permission_event(group,
> > >                                         FANOTIFY_PERM(event), FAN_DEN=
Y, NULL);
> > > @@ -1649,6 +1671,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> > >         }
> > >
> > >         group->default_response =3D FAN_ALLOW;
> > > +       atomic64_set(&group->event_id_counter, 0);
> > >
> > >         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEU=
E));
> > >         if (flags & FAN_UNLIMITED_QUEUE) {
> > > @@ -2115,7 +2138,7 @@ static int __init fanotify_user_setup(void)
> > >                                      FANOTIFY_DEFAULT_MAX_USER_MARKS)=
;
> > >
> > >         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FL=
AGS);
> > > -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
> > > +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
> > >         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
> > >
> > >         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> > > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > > index 182fc574b848..08bdb7aac070 100644
> > > --- a/include/linux/fanotify.h
> > > +++ b/include/linux/fanotify.h
> > > @@ -38,7 +38,8 @@
> > >                                          FAN_REPORT_PIDFD | \
> > >                                          FAN_REPORT_FD_ERROR | \
> > >                                          FAN_UNLIMITED_QUEUE | \
> > > -                                        FAN_UNLIMITED_MARKS)
> > > +                                        FAN_UNLIMITED_MARKS | \
> > > +                                        FAN_ENABLE_EVENT_ID)
> > >
> > >  /*
> > >   * fanotify_init() flags that are allowed for user without CAP_SYS_A=
DMIN.
> > > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotif=
y_backend.h
> > > index 9683396acda6..58584a4e500a 100644
> > > --- a/include/linux/fsnotify_backend.h
> > > +++ b/include/linux/fsnotify_backend.h
> > > @@ -232,6 +232,7 @@ struct fsnotify_group {
> > >         enum fsnotify_group_prio priority;      /* priority for sendi=
ng events */
> > >         bool shutdown;          /* group is being shut down, don't qu=
eue more events */
> > >         unsigned int default_response; /* default response sent on gr=
oup close */
> > > +       atomic64_t event_id_counter; /* counter to generate unique ev=
ent ids */
> > >
> > >  #define FSNOTIFY_GROUP_USER    0x01 /* user allocated group */
> > >  #define FSNOTIFY_GROUP_DUPS    0x02 /* allow multiple marks per obje=
ct */
> > > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanot=
ify.h
> > > index 7badde273a66..e9fb8827fe1b 100644
> > > --- a/include/uapi/linux/fanotify.h
> > > +++ b/include/uapi/linux/fanotify.h
> > > @@ -67,6 +67,8 @@
> > >  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent targ=
et id  */
> > >  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can repo=
rt error */
> > >  #define FAN_REPORT_MNT         0x00004000      /* Report mount event=
s */
> > > +/* Flag to populate and respond using unique event id */
> > > +#define FAN_ENABLE_EVENT_ID            0x00008000
> >
> > While it's true that the feature impacts more than the reported event
> > format, this is the main thing that it does, so please name it
> > FAN_REPORT_EVENT_ID
> >
> > >
> > >  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID *=
/
> > >  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME=
)
> > > @@ -143,6 +145,7 @@ struct fanotify_event_metadata {
> > >         __aligned_u64 mask;
> > >         __s32 fd;
> > >         __s32 pid;
> > > +       __u64 event_id;
> > >  };
> >
> > Not sure if this change calls for bumping FANOTIFY_METADATA_VERSION
> > but I think we should not extend the reported metadata_len
> > unless the user opted-in with FAN_REPORT_EVENT_ID.
> >
> > If we do that we may break buggy programs that use the
> > FAN_EVENT_METADATA_LEN macro and it is an unneeded risk.
> >
> > We should probably deprecate the FAN_EVENT_METADATA_LEN
> > definition in uapi/fanotify.h altogether and re-write the FAN_EVENT_OK(=
) macro.
> >
> > I know I asked for it, but extending fanotify_event_metadata does seem
> > to be a bit of a pain.
> >
>
> Do we prefer to scope this change to adding (s32) response id and not add=
 new
> event id field yet.
>
> > Thinking out loud, if we use idr to allocate an event id, as Jan sugges=
ted,
> > and we do want to allow it along side event->fd,
> > then we could also overload event->pid, i.e. the meaning of
> > FAN_ERPORT_EVENT_ID would be "event->pid is an event id",
> > Similarly to the way that we overloaded event->pid with FAN_REPORT_TID.
> > Users that need both event id and pid can use FAN_REPORT_PIDFD.
> >
>
> At least for our usecase, having event->fd along with response id availab=
le
> would be helpful as we do not use fid mode mentioned above.

You cannot use the fid mode mentioned above because it is not yet
supported with pre-content events :)

My argument goes like this:
1. We are planning to add fid support for pre-content events for other
    reasons anyway (pre-dir-content events)
2. For this mode, event->fd will (probably) not be reported anyway,
    so for this mode, we will have to use a different response id
3. Since event->fd will not be used, it would make a lot of sense and
    very natural to reuse the field for a response id

So if we accept the limitation that writing an advanced hsm service
that supports non-interrupted restart requires that service to use the
new fid mode, we hit two birds with one event field ;)

If we take into account that (the way I see it) an advanced hsm service
will need to also support pre-dir-content events, then the argument makes
even more sense.

The fact that for your current use cases, you are ok with populating the
entire directory tree in a non-lazy way, does not mean that the use case
will not change in the future to require a lazy population of directory tre=
es.

I have another "hidden motive" with the nudge trying to push you over
towards pre-content events in fid mode:

Allowing pre-content events together with legacy events in the same
mark/group brings up some ugly semantic issues that we did not
see when we added the API.

The flag combination FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID
was never supported, so when we support it, we can start fresh with new rul=
es
like "only pre-content events are allowed in this group" and that simplifie=
s
some of the API questions.

While I have your attention I wanted to ask, as possibly the only
current user of pre-content events, is any of the Meta use cases
setting any other events in the mask along with pre-content events?

*if* we agree to this course I can post a patch to add support for
FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, temporarily
leaving event->fd in use, so that you can later replace it with
a response id.

> Would it make
> sense to add response id as an extra information record (similar to pidfd=
)
> rather than overloading event->fd / event->pid?
>

Yes. That's definitely a valid option.

I admit that my desire/wish to have the event id (or response id) in the
event header has to do more with my own personal sense of aesthetic
then it has to do with technical reasons.

That said, the plan to reuse event->fd aligns quite nicely with
the road ahead to pre-dir-content events, so I am kind of leaning
towards it.

Let's see what Jan had to say.

Thanks,
Amir.

