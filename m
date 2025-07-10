Return-Path: <linux-fsdevel+bounces-54450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46FAFFCB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32BB168EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5D28C840;
	Thu, 10 Jul 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoGI22J9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3123C4EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137157; cv=none; b=EydH5EbLQVfi/FdVLCuJlfbiUF8BTH6w4QnUEzxfDrj6bXbB4JHupI5PKJKGHb/+oMlKKVxxMV4vFxlwB0RGZgryECqdfLwtenH9r7d0RedgHEctdTFPh+aX1Drjuzjd/ehcXx6yuXOJxLcWgFVeQ1T18spUEsiN5x5Vo2auPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137157; c=relaxed/simple;
	bh=BHSaSIjbjBCro6mRwx9jtQjWDQZsJnrqK7Lo+bbB2qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBUgAvxsr5VDYd/5s/gQl33os25hV3nbC7mHKA+wFVkdBxzOz+yHsiRfFDiQ7OUTr6EflNlcdlr0DI3MwUSnPsuIdEMTRE/1jZTRrS5UrPk+fv/v81Dc4YAoC8VWAXe9w5JzmssvbHoZ7pfFD25cNBoED8jySIIPr5BlvEdCS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoGI22J9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso1157550a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137153; x=1752741953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOSRUgXdFZRBbBDxq6WaguL+2fvwhV3lJejJ/of6HB4=;
        b=XoGI22J9jgW9zFe0NDBIQdvc4pkcAB4ZoHZ0nzFTjMIU//vlTosDVOCH2Dhx5aDzb3
         C/0bEVZ8dxIPadO0BI6dp+DQxkKC/ADr68KypFRQ+W2FP9UU83GijmJe50PAY12Y2vbH
         515ivSs+g2G6uHyRml1Wt0nntGEHlkMe6RmMzDoD16KLeDJjmrlPYdUexAFlatVujAIa
         cP0y35ZIf0+NMGHFPFmDiJ6s/S7xELZriq2yHjXLosFkMqEohMvvF8Ddzgnjc2ESObau
         P1y4PtnbZNFGFXQmwvJPJQN4WcsOtbrTx1ptIak41GGt/YFwuvbD17szFGl+Iu5cCl1K
         LrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137153; x=1752741953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOSRUgXdFZRBbBDxq6WaguL+2fvwhV3lJejJ/of6HB4=;
        b=p04OYfaIq7v98XWXjJJQGuCT/US1BUdXSMuyH9I/iqCkFY5u6nUNqdSJ+qfgSgrnik
         m4NLBsmjiitmVBiRN0Iovy4cAvZoCXeJo0er8UvVaolui+mil0vGAU61i4q48iYgFACW
         VBG2WR69D6MBYCblrl1kmGI4EpOTYxlFLaaox0/YXPjeMgSpZbJLIQ9adK8+O+1JgmF5
         obTDJeWif/zo8nApS3HBzAOiYJWLCe2Z5PWqFL0ZwHhaYtTOb3644iorP7UYrs1jgc2C
         ZFg1el+hbiK7JqgANiglRk6JuL7whMum2aLzc+BVdN4zUUaIE++9+dykCUtNhXvmhVwF
         T7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWC732OWT1OJnPDJfQINbzYvFG3nv7takAg5d2GxrjZOu1wMkNREdoiFYuKMBBcFHxyRYR4r7lXfiTMgzCw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzedty7HLd83d8LqcZzE2dZRYd+5BiYfKHDCSPtjhRzJ1pSnMKJ
	ibBG1apdH65DZLgHJBERifZigk+02nxVDeQFqtROVC38Hmed98hdva2rW0wKLjJMe6fdQkLQcMU
	V84QHHpwT3+N7RNNRXzJfl4fM/OHj0CY=
X-Gm-Gg: ASbGncvQJYmdSo4zdvrP3O9OXk6uy4pb/3sxira28j+ZGlTAEIg+TiKryue1UJLfqo2
	v1zNucZiXwGgT0GGCOSL5gXFWcIl+ZY2R34fBWgz9N54Z8l54S/Pp59JrYSlnMANJSEMpGweI5s
	R35bn+YQ9RziAYMzTc0FKskZYiLdGJkeBvygjpT2t/DBY=
X-Google-Smtp-Source: AGHT+IFrG2rptkeZRKRf3ItVbhUZ6ehwFm7X/O+BKlikVNLJja/qs33jb/Zo2b4P6PaR47OSJq+mbfI1a+fAcrpThjo=
X-Received: by 2002:a17:907:944f:b0:adb:9e8:8f17 with SMTP id
 a640c23a62f3a-ae6e7143474mr182335466b.52.1752137152295; Thu, 10 Jul 2025
 01:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710042049.3705747-1-ibrahimjirdeh@meta.com>
 <20250710042049.3705747-4-ibrahimjirdeh@meta.com> <CAOQ4uxgFpCS2H6v5V6AH-Z15at7ZDUFdp+dXdfpo7agMRRyjtg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgFpCS2H6v5V6AH-Z15at7ZDUFdp+dXdfpo7agMRRyjtg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Jul 2025 10:45:40 +0200
X-Gm-Features: Ac12FXwL4jPyXYNdlpuc36fqZVV18NJ0zG1CVTdnDVDrb6-clBZYzh_OYQIAupY
Message-ID: <CAOQ4uxiSqm5Uso_J1+4efAgefdUJDhwGQOt8WDd8NFkB6Y1RcQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] [PATCH v2 3/3] fanotify: introduce event response identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com, 
	ibrahimjirdeh <ibrahimjirdeh@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 10:38=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Jul 10, 2025 at 6:21=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@met=
a.com> wrote:
> >
> > From: ibrahimjirdeh <ibrahimjirdeh@fb.com>
> >
> > Summary:
>
> Formatting issue.
>
> > This adds support for responding to events via response identifier. Thi=
s
> > prevents races if there are multiple processes backing the same fanotif=
y
> > group (eg. handover of fanotify group to new instance of a backing daem=
on).
> > It is also useful for reporting pre-dir-content events without an
> > event->fd:
> > https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd=
2rinzwbq7xxfjf5z7@3nqidi3mno46/.
> >
> > Rather than introducing a new event identifier field and extending
> > fanotify_event_metadata, we have opted to overload event->fd and restri=
ct
> > this functionality to use-cases which are using file handle apis
> > (FAN_REPORT_FID).
> >
> > In terms of how response ids are allocated, we use an idr for allocatio=
n
> > and restrict the id range to below -255 to ensure there is no overlap w=
ith
> > existing fd-as-identifier usage. We can also leverage the added idr for
> > more efficient lookup when handling response although that is not done
> > in this patch.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxheeLXdTLLWrixnTJcxVP=
+BV4ViXijbvERHPenzgDMUTA@mail.gmail.com/
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > ---
> >  fs/notify/fanotify/fanotify.c       |   3 +
> >  fs/notify/fanotify/fanotify.h       |   5 +-
> >  fs/notify/fanotify/fanotify_user.c  | 129 ++++++++++++++++++----------
> >  include/linux/fanotify.h            |   3 +-
> >  include/linux/fsnotify_backend.h    |   1 +
> >  include/uapi/linux/fanotify.h       |  11 ++-
> >  tools/include/uapi/linux/fanotify.h |  11 ++-
> >  7 files changed, 110 insertions(+), 53 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index 34acb7c16e8b..d9aebd359199 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -1106,6 +1106,9 @@ static void fanotify_free_event(struct fsnotify_g=
roup *group,
> >
> >         event =3D FANOTIFY_E(fsn_event);
> >         put_pid(event->pid);
> > +       if (fanotify_is_perm_event(event->mask) &&
> > +           FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
> > +               idr_remove(&group->response_idr, -FANOTIFY_PERM(event)-=
>id);
> >         switch (event->type) {
> >         case FANOTIFY_EVENT_TYPE_PATH:
> >                 fanotify_free_path_event(event);
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index f6d25fcf8692..8d62321237d6 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -444,7 +444,10 @@ struct fanotify_perm_event {
> >         size_t count;
> >         u32 response;                   /* userspace answer to the even=
t */
> >         unsigned short state;           /* state of the event */
> > -       int fd;         /* fd we passed to userspace for this event */
> > +       union {
> > +               __s32 fd;                       /* fd we passed to user=
space for this event */
> > +               __s32 id;                       /* FAN_REPORT_RESPONSE_=
ID */
> > +       };
>
> That's an "int" and I don't think that we need a union in this internal c=
ontext.
> int id; /* id we passed to userspace for this event */
> is always correct, whether the id is also an fd or not.
>
>
> >         union {
> >                 struct fanotify_response_info_header hdr;
> >                 struct fanotify_response_info_audit_rule audit_rule;
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 19d3f2d914fe..b033f86e0db3 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -330,14 +330,16 @@ static int process_access_response(struct fsnotif=
y_group *group,
> >                                    size_t info_len)
> >  {
> >         struct fanotify_perm_event *event;
> > -       int fd =3D response_struct->fd;
> > +       int id =3D FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) ?
> > +                        response_struct->id :
> > +                        response_struct->fd;
>
> Not needed. Can always use int id =3D response_struct->id;
> it is never used as an actual fd in this context.
> But this function would be a good place to add:
>
> BUILD_BUG_ON(sizeof(response_struct->id) !=3D sizeof(response_struct->fd)=
);
> BUILD_BUG_ON(offsetof(struct fanotity_response, id) !=3D offsetof(struct
> fanotify_repose, fd));
>
> to make sure that code can use either alternative safely.
>
> >         u32 response =3D response_struct->response;
> >         int errno =3D fanotify_get_response_errno(response);
> >         int ret =3D info_len;
> >         struct fanotify_response_info_audit_rule friar;
> >
> > -       pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=
=3D%p size=3D%zu\n",
> > -                __func__, group, fd, response, errno, info, info_len);
> > +       pr_debug("%s: group=3D%p id=3D%d response=3D%x errno=3D%d buf=
=3D%p size=3D%zu\n",
> > +                __func__, group, id, response, errno, info, info_len);
> >         /*
> >          * make sure the response is valid, if invalid we do nothing an=
d either
> >          * userspace can send a valid response or we will clean it up a=
fter the
> > @@ -385,19 +387,24 @@ static int process_access_response(struct fsnotif=
y_group *group,
> >                 ret =3D process_access_response_info(info, info_len, &f=
riar);
> >                 if (ret < 0)
> >                         return ret;
> > -               if (fd =3D=3D FAN_NOFD)
> > +               if (id =3D=3D FAN_NOFD)
> >                         return ret;
> >         } else {
> >                 ret =3D 0;
> >         }
> > +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) && id >=3D -2=
55)
> > +               return -EINVAL;
> >
> > -       if (fd < 0)
> > +       if (!FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID) && id < 0)
> >                 return -EINVAL;
>
> Please use helper for both cases above:
> static inline fanotify_is_valid_response_id(struct fsnotify_group
> *group, int id)
>
> >
> >         spin_lock(&group->notification_lock);
> >         list_for_each_entry(event, &group->fanotify_data.access_list,
> >                             fae.fse.list) {
> > -               if (event->fd !=3D fd)
> > +               int other_id =3D FAN_GROUP_FLAG(group, FAN_REPORT_RESPO=
NSE_ID) ?
> > +                                      event->id :
> > +                                      event->fd;
> > +               if (other_id !=3D id)
>
> No need. can use if (event->id !=3D id)
>
> >                         continue;
> >
> >                 list_del_init(&event->fae.fse.list);
> > @@ -765,48 +772,58 @@ static ssize_t copy_event_to_user(struct fsnotify=
_group *group,
> >             task_tgid(current) !=3D event->pid)
> >                 metadata.pid =3D 0;
> >
> > -       /*
> > -        * For now, fid mode is required for an unprivileged listener a=
nd
> > -        * fid mode does not report fd in events.  Keep this check anyw=
ay
> > -        * for safety in case fid mode requirement is relaxed in the fu=
ture
> > -        * to allow unprivileged listener to get events with no fd and =
no fid.
> > -        */
> > -       if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> > -           path && path->mnt && path->dentry) {
> > -               fd =3D create_fd(group, path, &f);
> > +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
> > +               ret =3D idr_alloc_cyclic(&group->response_idr, event, 2=
56, INT_MAX,
> > +                                      GFP_NOWAIT);
> > +               if (ret < 0)
> > +                       return ret;
> > +               metadata.id =3D -ret;
> > +       } else {
>
> Please avoid this unneeded churn and unneeded nesting:
>
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID)) {
> ...
> +       } else if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && ...
>
> And I would assign fd =3D -ret; to make the code below simpler...
>
> >                 /*
> > -                * Opening an fd from dentry can fail for several reaso=
ns.
> > -                * For example, when tasks are gone and we try to open =
their
> > -                * /proc files or we try to open a WRONLY file like in =
sysfs
> > -                * or when trying to open a file that was deleted on th=
e
> > -                * remote network server.
> > -                *
> > -                * For a group with FAN_REPORT_FD_ERROR, we will send t=
he
> > -                * event with the error instead of the open fd, otherwi=
se
> > -                * Userspace may not get the error at all.
> > -                * In any case, userspace will not know which file fail=
ed to
> > -                * open, so add a debug print for further investigation=
.
> > +                * For now, fid mode is required for an unprivileged li=
stener and
> > +                * fid mode does not report fd in events.  Keep this ch=
eck anyway
> > +                * for safety in case fid mode requirement is relaxed i=
n the future
> > +                * to allow unprivileged listener to get events with no=
 fd and no fid.
> >                  */
> > -               if (fd < 0) {
> > -                       pr_debug("fanotify: create_fd(%pd2) failed err=
=3D%d\n",
> > -                                path->dentry, fd);
> > -                       if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR)=
) {
> > -                               /*
> > -                                * Historically, we've handled EOPENSTA=
LE in a
> > -                                * special way and silently dropped suc=
h
> > -                                * events. Now we have to keep it to ma=
intain
> > -                                * backward compatibility...
> > -                                */
> > -                               if (fd =3D=3D -EOPENSTALE)
> > -                                       fd =3D 0;
> > -                               return fd;
> > +               if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) && path &&
> > +                   path->mnt && path->dentry) {
> > +                       fd =3D create_fd(group, path, &f);
> > +                       /*
> > +                        * Opening an fd from dentry can fail for sever=
al reasons.
> > +                        * For example, when tasks are gone and we try =
to open their
> > +                        * /proc files or we try to open a WRONLY file =
like in sysfs
> > +                        * or when trying to open a file that was delet=
ed on the
> > +                        * remote network server.
> > +                        *
> > +                        * For a group with FAN_REPORT_FD_ERROR, we wil=
l send the
> > +                        * event with the error instead of the open fd,=
 otherwise
> > +                        * Userspace may not get the error at all.
> > +                        * In any case, userspace will not know which f=
ile failed to
> > +                        * open, so add a debug print for further inves=
tigation.
> > +                        */
> > +                       if (fd < 0) {
> > +                               pr_debug(
> > +                                       "fanotify: create_fd(%pd2) fail=
ed err=3D%d\n",
> > +                                       path->dentry, fd);
> > +                               if (!FAN_GROUP_FLAG(group,
> > +                                                   FAN_REPORT_FD_ERROR=
)) {
> > +                                       /*
> > +                                        * Historically, we've handled =
EOPENSTALE in a
> > +                                        * special way and silently dro=
pped such
> > +                                        * events. Now we have to keep =
it to maintain
> > +                                        * backward compatibility...
> > +                                        */
> > +                                       if (fd =3D=3D -EOPENSTALE)
> > +                                               fd =3D 0;
> > +                                       return fd;
> > +                               }
> >                         }
> >                 }
> > +               if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> > +                       metadata.fd =3D fd;
> > +               else
> > +                       metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
> >         }
> > -       if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR))
> > -               metadata.fd =3D fd;
> > -       else
> > -               metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
> >
>
> IMO, this is shorter and nicer after assigning fd =3D -ret; above:
>
>        if (FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR |
>
> FAN_REPORT_RESPONSE_ID))
>                metadata.fd =3D fd;
>        else
>                metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>

And above this code is also a good place to place the build assertion:

BUILD_BUG_ON(sizeof(metadata.id) !=3D sizeof(metadata.fd));
BUILD_BUG_ON(offsetof(struct fanotity_event_metadata, id) !=3D offsetof(str=
uct
fanotity_event_metadata, fd));

Which provides the justification to use the union fields interchangeably
in this simplified code.

Thanks,
Amir.

