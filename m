Return-Path: <linux-fsdevel+bounces-53137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C2AEAEB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC94F562973
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 06:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69071EA7CF;
	Fri, 27 Jun 2025 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dyhh1d5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E461FAC23
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004360; cv=none; b=O1hvLPp4vH51MYkNgaIFfeRJraGMQPYTrKaLhWFvHWuKPa9qOKE6keFicruVz02rMfFslSLNE0h/7LrdR34YS9XdY4i7RQ+po3cSsbHlKN7oenO4A4j3KOR7StFfmii8xMyxnho9a16OF+cX52rhsWwXAcDPjMj/e/hQCcSfUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004360; c=relaxed/simple;
	bh=Laz8MTGiRgD+5XYk2aeRecOWsAFYeawIqTP12VD+n/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EavHCcTkuyTo4dPqiavasEHkoWDnERoa9jhItkTGklk1a8SGLjQZgm5MPt+69gScDPi8Pm77c24NVaoeJkE/Y5g30tMCx4PtahzLr4rtpEf7mot3VMfWwAkJzo4FyU9P9iHbYIW0nfZifZAmWQ8uhNIY40Dr/tOITvzVVTmipEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dyhh1d5r; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4rCaJ006995
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 23:05:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MWkCzyPJpQmmN3o3HGqoWjo83iFBv2sSKkyuj8i0Zek=; b=dyhh1d5rsKPO
	/Qh8DVmwzA4yG41qCjp+msZGTt9OvlCcDPQEMtRK3ewSF1OqQFPiCZDYLbQHlCnx
	vW92BImOUS6+4DmRXUwhJZFcehyz0+FQ8QP2EozcwV18PnW51oYi1aw0EyV/Ux5K
	8+B0rnP7+tEgF41p0OU7TF666hG1z+BAVXySqDxp5YrB1eIsSVG144rA94o3C+US
	8l8vT1ns4jKG80pURdn0fycCtO5ofxgLDHbGx4MwwsNh/aNHfwZ28rgz45DFLKhw
	tEHMlGyCHavEhIer0ArvjajV3nJyK8E6CCyCt89n9ijqWOC0MbLOvpGP7PW926l9
	kUwLlOt+Hw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47hjb6ru8x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 23:05:56 -0700 (PDT)
Received: from twshared6134.33.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 27 Jun 2025 06:05:54 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id A830A30AA6F73; Thu, 26 Jun 2025 23:05:52 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
Date: Thu, 26 Jun 2025 23:05:48 -0700
Message-ID: <20250627060548.2542757-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxjki2j7-XrK7D_13uftAi5stfRobiMV_TZkc_LRwQCqwg@mail.gmail.com>
References: <CAOQ4uxjki2j7-XrK7D_13uftAi5stfRobiMV_TZkc_LRwQCqwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA0NyBTYWx0ZWRfXy+q+jS+6m4S2 jGRRKPk5YKXrxG7w6b/51cpXBzCfQ9ZriNJoD91gk/wF9ahMfFLF5MxxBA2JfdITvOf/yDHpQAz fXmcaK01qqcIaRch1zc5ErdUiHVRo1VuOj4ac9P61WSv4+wiMC9bdRZwvsxKGeI8dlNahz4mdaX
 0i54COMPID/b7UV89byLWU1bLBgog59yrYcgiwQjELicLHy4CsWCxZgm8UAr09vq1o/D+BKunsw bJO1h+h0b1Er/JhUTuEphjgHNfQv3rWsZhSyQyXIF51uSnJ/o/LeVA+SwnRZucuj+NiaJsuLzkN kgPEjDihf45kG3kDcBDbv7nTBH83mipYlF45nMC2mxidNy28ISnF34nMJHt+Y8AngLW51T7Kq5Y
 znd04vRXxl5NBFvWT/ZIXZXu2+W3FsrIllNNdgjxTG7VYkykdUE51tphVnQlI/dDHPcS+Ep4
X-Proofpoint-ORIG-GUID: 5tzBHDmUUyBcgTf9tUopGwldCtgo3JRF
X-Proofpoint-GUID: 5tzBHDmUUyBcgTf9tUopGwldCtgo3JRF
X-Authority-Analysis: v=2.4 cv=P+w6hjAu c=1 sm=1 tr=0 ts=685e34c4 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=aRSxYWcjhCuQVWMP9SEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01

On 6/24/25, 3:41 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
> On Mon, Jun 23, 2025 at 9:36 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com>=
 wrote:
> >
> > This adds support for responding to events via a unique event
> > identifier. The main goal is to prevent races if there are multiple
> > processes backing the same fanotify group (eg. handover of fanotify
> > group to new instance of a backing daemon). A new event id field is
> > added to fanotify metadata which is unique per group, and this behavi=
or
> > is guarded by FAN_ENABLE_EVENT_ID flag.
>
> FWIW, we also need this functionality for reporting pre-dir-content
> events without an event->fd:
> https://lore.kernel.org/linux-fsdevel/2dx3pbcnv5w75fxb2ghqtsk6gzl6cuxmd=
2rinzwbq7xxfjf5z7@3nqidi3mno46/
>
> In theory, if you can manage with pre-content events that report fid
> instead of open O_PATH fd, then we can add support for this mode
> and tie the event->id solution with the FAN_NOFD case, but I am not sur=
e
> whether this would be too limiting for users.
>
> You will notice that in this patch review, I am adding more questions
> than answers.
>
> The idea is to spark a design discussion and see if we can reach
> consensus before you post v2.

Thanks for the thoughtful feedback / discussion. I had a few questions fo=
r the
high level comment about separating response id from event id, but will m=
ake
sure to incorporate the additional suggestions eg. using s32 / idr depend=
ing
on which approach we choose.

>
> >
> > Some related discussion which this follows:
> > https://lore.kernel.org/all/CAOQ4uxhuPBWD=3DTYZw974NsKFno-iNYSkHPw6WT=
fG_69ovS=3DnJA@mail.gmail.com/
> >
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > ---
> >  fs/notify/fanotify/fanotify.h       |  1 +
> >  fs/notify/fanotify/fanotify_user.c  | 37 +++++++++++++++++++++++----=
--
> >  include/linux/fanotify.h            |  3 ++-
> >  include/linux/fsnotify_backend.h    |  1 +
> >  include/uapi/linux/fanotify.h       |  4 ++++
> >  tools/include/uapi/linux/fanotify.h |  4 ++++
> >  6 files changed, 42 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanot=
ify.h
> > index b78308975082..383c28c3f977 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -442,6 +442,7 @@ struct fanotify_perm_event {
> >         u32 response;                   /* userspace answer to the ev=
ent */
> >         unsigned short state;           /* state of the event */
> >         int fd;         /* fd we passed to userspace for this event *=
/
> > +       u64 event_id;           /* unique event identifier for this e=
vent */
> >         union {
> >                 struct fanotify_response_info_header hdr;
> >                 struct fanotify_response_info_audit_rule audit_rule;
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/=
fanotify_user.c
> > index 02669abff4a5..c523c6283f1b 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -331,13 +331,15 @@ static int process_access_response(struct fsnot=
ify_group *group,
> >  {
> >         struct fanotify_perm_event *event;
> >         int fd =3D response_struct->fd;
> > +       u64 event_id =3D response_struct->event_id;
> >         u32 response =3D response_struct->response;
> >         int errno =3D fanotify_get_response_errno(response);
> >         int ret =3D info_len;
> >         struct fanotify_response_info_audit_rule friar;
> >
> > -       pr_debug("%s: group=3D%p fd=3D%d response=3D%x errno=3D%d buf=
=3D%p size=3D%zu\n",
> > -                __func__, group, fd, response, errno, info, info_len=
);
> > +       pr_debug(
> > +               "%s: group=3D%p fd=3D%d event_id=3D%lld response=3D%x=
 errno=3D%d buf=3D%p size=3D%zu\n",
> > +               __func__, group, fd, event_id, response, errno, info,=
 info_len);
> >         /*
> >          * make sure the response is valid, if invalid we do nothing =
and either
> >          * userspace can send a valid response or we will clean it up=
 after the
> > @@ -398,13 +400,18 @@ static int process_access_response(struct fsnot=
ify_group *group,
> >                 ret =3D 0;
> >         }
> >
> > -       if (fd < 0)
> > +       u64 id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID) ? event=
_id : fd;
> > +
> > +       if (id < 0)
>
> u64 cannot be negative.
> I think we need to keep negative error values as invalid for better
> backward compat
> e.g. in case someone ends up writing FAN_NOFD in the response.
>
> Jan has suggested that we use an idr (could be cyclic) for event id and=
 then
> s32 is enough for a permission event/response id.
> We could even start idr range at 256 and use response_struct->fd < -255
> range as non-fd event ids.
> We skip the range -255..-1 to continue to support FAN_REPORT_FD_ERROR.
>
> This is convenient if we agree to overload event->fd and never need to
> report both path fd and an event id.
>
> OTOH, I can envision other uses of a u64 event id, unrelated to permiss=
ion
> event response.
>
> I am considering extending fanotify API as a standard API to access fs
> built-in persistent change journal, for fs that support it (e.g. lustre=
, ntfs).
> In those filesystems, the persistent events have a u64 id,
> so extending the fanotify API to describe the event with u64 id could b=
e
> useful down the road.
>
> But an event id and permission response id do not have to be the same i=
d..
>
>
> >                 return -EINVAL;
> >
> >         spin_lock(&group->notification_lock);
> >         list_for_each_entry(event, &group->fanotify_data.access_list,
> >                             fae.fse.list) {
> > -               if (event->fd !=3D fd)
> > +               u64 other_id =3D FAN_GROUP_FLAG(group, FAN_ENABLE_EVE=
NT_ID) ?
> > +                                      event->event_id :
> > +                                      event->fd;
> > +               if (other_id !=3D id)
> >                         continue;
> >
> >                 list_del_init(&event->fae.fse.list);
> > @@ -815,6 +822,15 @@ static ssize_t copy_event_to_user(struct fsnotif=
y_group *group,
> >         else
> >                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
> >
> > +       /*
> > +        * Populate unique event id for group with FAN_ENABLE_EVENT_I=
D.
> > +        */
> > +       if (FAN_GROUP_FLAG(group, FAN_ENABLE_EVENT_ID))
> > +               metadata.event_id =3D
> > +                       (u64)atomic64_inc_return(&group->event_id_cou=
nter);
> > +       else
> > +               metadata.event_id =3D -1;
> > +
> >         if (pidfd_mode) {
> >                 /*
> >                  * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TI=
D mutual
> > @@ -865,8 +881,10 @@ static ssize_t copy_event_to_user(struct fsnotif=
y_group *group,
> >         if (pidfd_file)
> >                 fd_install(pidfd, pidfd_file);
> >
> > -       if (fanotify_is_perm_event(event->mask))
> > +       if (fanotify_is_perm_event(event->mask)) {
> >                 FANOTIFY_PERM(event)->fd =3D fd;
> > +               FANOTIFY_PERM(event)->event_id =3D metadata.event_id;
> > +       }
>
> Need to fix all the uses of FAN_EVENT_METADATA_LEN macro to be made
> conditional of FAN_REPORT_EVENT_ID, so we do not copy out this new fiel=
d
> without user opt-in.
>
> >
> >         return metadata.event_len;
> >
> > @@ -951,7 +969,11 @@ static ssize_t fanotify_read(struct file *file, =
char __user *buf,
> >                 if (!fanotify_is_perm_event(event->mask)) {
> >                         fsnotify_destroy_event(group, &event->fse);
> >                 } else {
> > -                       if (ret <=3D 0 || FANOTIFY_PERM(event)->fd < =
0) {
> > +                       u64 event_id =3D
> > +                               FAN_GROUP_FLAG(group, FAN_ENABLE_EVEN=
T_ID) ?
> > +                                       FANOTIFY_PERM(event)->fd :
> > +                                       FANOTIFY_PERM(event)->event_i=
d;
> > +                       if (ret <=3D 0 || event_id < 0) {
> >                                 spin_lock(&group->notification_lock);
> >                                 finish_permission_event(group,
> >                                         FANOTIFY_PERM(event), FAN_DEN=
Y, NULL);
> > @@ -1649,6 +1671,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> >         }
> >
> >         group->default_response =3D FAN_ALLOW;
> > +       atomic64_set(&group->event_id_counter, 0);
> >
> >         BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEU=
E));
> >         if (flags & FAN_UNLIMITED_QUEUE) {
> > @@ -2115,7 +2138,7 @@ static int __init fanotify_user_setup(void)
> >                                      FANOTIFY_DEFAULT_MAX_USER_MARKS)=
;
> >
> >         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FL=
AGS);
> > -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
> > +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
> >         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
> >
> >         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > index 182fc574b848..08bdb7aac070 100644
> > --- a/include/linux/fanotify.h
> > +++ b/include/linux/fanotify.h
> > @@ -38,7 +38,8 @@
> >                                          FAN_REPORT_PIDFD | \
> >                                          FAN_REPORT_FD_ERROR | \
> >                                          FAN_UNLIMITED_QUEUE | \
> > -                                        FAN_UNLIMITED_MARKS)
> > +                                        FAN_UNLIMITED_MARKS | \
> > +                                        FAN_ENABLE_EVENT_ID)
> >
> >  /*
> >   * fanotify_init() flags that are allowed for user without CAP_SYS_A=
DMIN.
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotif=
y_backend.h
> > index 9683396acda6..58584a4e500a 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -232,6 +232,7 @@ struct fsnotify_group {
> >         enum fsnotify_group_prio priority;      /* priority for sendi=
ng events */
> >         bool shutdown;          /* group is being shut down, don't qu=
eue more events */
> >         unsigned int default_response; /* default response sent on gr=
oup close */
> > +       atomic64_t event_id_counter; /* counter to generate unique ev=
ent ids */
> >
> >  #define FSNOTIFY_GROUP_USER    0x01 /* user allocated group */
> >  #define FSNOTIFY_GROUP_DUPS    0x02 /* allow multiple marks per obje=
ct */
> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanot=
ify.h
> > index 7badde273a66..e9fb8827fe1b 100644
> > --- a/include/uapi/linux/fanotify.h
> > +++ b/include/uapi/linux/fanotify.h
> > @@ -67,6 +67,8 @@
> >  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent targ=
et id  */
> >  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can repo=
rt error */
> >  #define FAN_REPORT_MNT         0x00004000      /* Report mount event=
s */
> > +/* Flag to populate and respond using unique event id */
> > +#define FAN_ENABLE_EVENT_ID            0x00008000
>
> While it's true that the feature impacts more than the reported event
> format, this is the main thing that it does, so please name it
> FAN_REPORT_EVENT_ID
>
> >
> >  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID *=
/
> >  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME=
)
> > @@ -143,6 +145,7 @@ struct fanotify_event_metadata {
> >         __aligned_u64 mask;
> >         __s32 fd;
> >         __s32 pid;
> > +       __u64 event_id;
> >  };
>
> Not sure if this change calls for bumping FANOTIFY_METADATA_VERSION
> but I think we should not extend the reported metadata_len
> unless the user opted-in with FAN_REPORT_EVENT_ID.
>
> If we do that we may break buggy programs that use the
> FAN_EVENT_METADATA_LEN macro and it is an unneeded risk.
>
> We should probably deprecate the FAN_EVENT_METADATA_LEN
> definition in uapi/fanotify.h altogether and re-write the FAN_EVENT_OK(=
) macro.
>
> I know I asked for it, but extending fanotify_event_metadata does seem
> to be a bit of a pain.
>

Do we prefer to scope this change to adding (s32) response id and not add=
 new
event id field yet.

> Thinking out loud, if we use idr to allocate an event id, as Jan sugges=
ted,
> and we do want to allow it along side event->fd,
> then we could also overload event->pid, i.e. the meaning of
> FAN_ERPORT_EVENT_ID would be "event->pid is an event id",
> Similarly to the way that we overloaded event->pid with FAN_REPORT_TID.
> Users that need both event id and pid can use FAN_REPORT_PIDFD.
>

At least for our usecase, having event->fd along with response id availab=
le
would be helpful as we do not use fid mode mentioned above. Would it make
sense to add response id as an extra information record (similar to pidfd=
)
rather than overloading event->fd / event->pid?

> >
> >  #define FAN_EVENT_INFO_TYPE_FID                1
> > @@ -226,6 +229,7 @@ struct fanotify_event_info_mnt {
> >
> >  struct fanotify_response {
> >         __s32 fd;
> > +       __u64 event_id;
> >         __u32 response;
> >  };
> >
>
> Most likely we will end up with s32 response id, but if we do decide on
> a separate u64 field, please move it to end for better struct alignment=
.
>
> Thanks,
> Amir.

