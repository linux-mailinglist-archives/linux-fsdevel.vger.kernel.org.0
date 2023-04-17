Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803C06E42BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDQIic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDQIib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:38:31 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF64209;
        Mon, 17 Apr 2023 01:38:28 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id d21so2001407vsv.9;
        Mon, 17 Apr 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681720708; x=1684312708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaqMRQe4vxt2SFU/D1x9tRHiV95TATHHze/DOR+yfVc=;
        b=ZQDxm3nmNJWsLXRd3PEME147Lz3djHkp6u926M5ll1kyHSuXcKNpckBrtjmzKXTa3N
         sjAHuqp28Wa+GQiY1gSo/zzHlCaNb4eJwHZyV8SgF9TV8yO3JHU78eT4QgHeAPSPkyuM
         IHreO6GNTNg1IKt18SZYu8KfxGupuQsYw/4r+hxdq1WsJXlwkR+4wzjOIRZ7QF5Je49c
         OHNCFPPVtvOiTZn9789/sxdKLvq9fEk0QsABoa4BBoOV/yus9xDt3A5A/vSTA4zxYHWn
         QO01QIPsOHaF901o0LzW2jY2pmYMWSixtoDAPZTNVK1U5x96KCQr6Deh95Rxs6n+jrfz
         HHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681720708; x=1684312708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaqMRQe4vxt2SFU/D1x9tRHiV95TATHHze/DOR+yfVc=;
        b=C8vPJ/+/CWIu5LhXdwdE8PRjX9yHxUoQePDx6RjAabx1+JTqYX3+w1+u1PSmCFQmaX
         NQ/e9oZsOLIngV7zzqWxlxh1ZMTQvxZebbmGUWpg1SRmWgB4aDAw6/CadlCVRfYYM2S3
         oSAN+F9gwBYiox1wlKXqF9/9xYFQ8wBlx1B7AeyilC35taMUPw42oXy1gekaSkaX0uco
         zxIkaT0fmEhvfqB5+0FCDnEMI6uauZ4vU0kD0HTwk2b5YRcFgpBFksmlEsYEqJlbJi6C
         CZq5OTbJOq98MwHxk5r6jXP8Kp2n9rAJr+erkS9IupSKiyryclCewhFSL18+xCeJg/Tz
         sueA==
X-Gm-Message-State: AAQBX9d+6DAKyP29tIm89qvJGeruPhjdGzJEM5HT7RQPtbhU6ArLYMv4
        yOkmqUgxngT+uxVVt432AUDJ+z5I5Xk2F4vR9PM=
X-Google-Smtp-Source: AKy350ZaXwuSepYGJZgQ+eSZOM/+a3iYI7OOxcCV3C/DCXSU4vFHA6L6yzsyDWa61roABEocXPox0tQ4t3SvPSzF92o=
X-Received: by 2002:a67:ca8b:0:b0:42e:3757:f5fc with SMTP id
 a11-20020a67ca8b000000b0042e3757f5fcmr7426916vsl.0.1681720707789; Mon, 17 Apr
 2023 01:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230414182903.1852019-1-amir73il@gmail.com> <20230414182903.1852019-3-amir73il@gmail.com>
In-Reply-To: <20230414182903.1852019-3-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Apr 2023 11:38:16 +0300
Message-ID: <CAOQ4uxg77SkRT7ePmrPuYH-gJgYe6w6ts4-nNv5cap6PQ2bkKg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] fanotify: report mntid info record with
 FAN_UNMOUNT events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 9:29=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Report mntid in an info record of type FAN_EVENT_INFO_TYPE_MNTID
> with FAN_UNMOUNT event in addition to the fid info record.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 37 +++++++++++++++++++------
>  fs/notify/fanotify/fanotify.h      | 20 +++++++++++++-
>  fs/notify/fanotify/fanotify_user.c | 44 +++++++++++++++++++++++++++---
>  include/uapi/linux/fanotify.h      | 10 +++++++
>  4 files changed, 97 insertions(+), 14 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 384d2b2e55e7..c204259be6cc 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -17,6 +17,7 @@
>  #include <linux/stringhash.h>
>
>  #include "fanotify.h"
> +#include "../../mount.h" /* for mnt_id */
>
>  static bool fanotify_path_equal(const struct path *p1, const struct path=
 *p2)
>  {
> @@ -41,6 +42,11 @@ static unsigned int fanotify_hash_fsid(__kernel_fsid_t=
 *fsid)
>                 hash_32(fsid->val[1], FANOTIFY_EVENT_HASH_BITS);
>  }
>
> +static unsigned int fanotify_hash_mntid(int mntid)
> +{
> +       return hash_32(mntid, FANOTIFY_EVENT_HASH_BITS);
> +}

This hash is not needed of course as I later decided to never merge
FAN_UNMOUNT events.

> +
>  static bool fanotify_fh_equal(struct fanotify_fh *fh1,
>                               struct fanotify_fh *fh2)
>  {
> @@ -133,6 +139,12 @@ static bool fanotify_error_event_equal(struct fanoti=
fy_error_event *fee1,
>         return true;
>  }
>
> +/*
> + * FAN_RENAME and FAN_UNMOUNT are reported with special info record type=
s,
> + * so we cannot merge them with other events.
> + */
> +#define FANOTIFY_NO_MERGE_EVENTS (FAN_RENAME | FAN_UNMOUNT)
> +
>  static bool fanotify_should_merge(struct fanotify_event *old,
>                                   struct fanotify_event *new)
>  {
> @@ -153,11 +165,8 @@ static bool fanotify_should_merge(struct fanotify_ev=
ent *old,
>         if ((old->mask & FS_ISDIR) !=3D (new->mask & FS_ISDIR))
>                 return false;
>
> -       /*
> -        * FAN_RENAME event is reported with special info record types,
> -        * so we cannot merge it with other events.
> -        */
> -       if ((old->mask & FAN_RENAME) !=3D (new->mask & FAN_RENAME))
> +       if ((old->mask & FANOTIFY_NO_MERGE_EVENTS) ||
> +           (new->mask & FANOTIFY_NO_MERGE_EVENTS))
>                 return false;

BTW there is a minor change of logic here, from not merging FAN_RENAME
events with anything but other FAN_RENAME events, to not merging
FAN_RENAME events at all.

But considering that FAN_RENAME events always have name info, the
only possible merge of FAN_RENAME events is in a situation of
loop { mv A B; mv B A;}
and I don't think that this corner case justifies the merge of rename event=
s.


>
>         switch (old->type) {
> @@ -593,9 +602,11 @@ static struct fanotify_event *fanotify_alloc_perm_ev=
ent(const struct path *path,
>
>  static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
>                                                        __kernel_fsid_t *f=
sid,
> +                                                      struct mount *mnt,
>                                                        unsigned int *hash=
,
>                                                        gfp_t gfp)
>  {
> +       unsigned int fh_len =3D fanotify_encode_fh_len(id);
>         struct fanotify_fid_event *ffe;
>
>         ffe =3D kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
> @@ -605,8 +616,14 @@ static struct fanotify_event *fanotify_alloc_fid_eve=
nt(struct inode *id,
>         ffe->fae.type =3D FANOTIFY_EVENT_TYPE_FID;
>         ffe->fsid =3D *fsid;
>         *hash ^=3D fanotify_hash_fsid(fsid);
> -       fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id=
),
> -                          hash, gfp);
> +       fanotify_encode_fh(&ffe->object_fh, id, fh_len, hash, gfp);
> +       /* Record fid event with fsid, mntid and empty fh */
> +       if (mnt && !WARN_ON_ONCE(fh_len)) {
> +               ffe->mnt_id =3D mnt->mnt_id;
> +               ffe->object_fh.flags =3D FANOTIFY_FH_FLAG_MNT_ID;
> +               if (hash)
> +                       *hash ^=3D fanotify_hash_mntid(mnt->mnt_id);
> +       }
>
>         return &ffe->fae;
>  }
> @@ -737,6 +754,7 @@ static struct fanotify_event *fanotify_alloc_event(
>                                               fid_mode);
>         struct inode *dirid =3D fanotify_dfid_inode(mask, data, data_type=
, dir);
>         const struct path *path =3D fsnotify_data_path(data, data_type);
> +       struct mount *mnt =3D NULL;
>         struct mem_cgroup *old_memcg;
>         struct dentry *moved =3D NULL;
>         struct inode *child =3D NULL;
> @@ -746,7 +764,8 @@ static struct fanotify_event *fanotify_alloc_event(
>         struct pid *pid;
>
>         if (mask & FAN_UNMOUNT && !WARN_ON_ONCE(!path || !fid_mode)) {
> -               /* Record fid event with fsid and empty fh */
> +               /* Record fid event with fsid, mntid and empty fh */
> +               mnt =3D real_mount(path->mnt);
>                 id =3D NULL;
>         } else if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
>                 /*
> @@ -834,7 +853,7 @@ static struct fanotify_event *fanotify_alloc_event(
>                 event =3D fanotify_alloc_name_event(dirid, fsid, file_nam=
e, child,
>                                                   moved, &hash, gfp);
>         } else if (fid_mode) {
> -               event =3D fanotify_alloc_fid_event(id, fsid, &hash, gfp);
> +               event =3D fanotify_alloc_fid_event(id, fsid, mnt, &hash, =
gfp);
>         } else {
>                 event =3D fanotify_alloc_path_event(path, &hash, gfp);
>         }
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index f98dcf5b7a19..3d8391a77031 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -33,6 +33,7 @@ struct fanotify_fh {
>         u8 type;
>         u8 len;
>  #define FANOTIFY_FH_FLAG_EXT_BUF 1
> +#define FANOTIFY_FH_FLAG_MNT_ID  2
>         u8 flags;
>         u8 pad;
>         unsigned char buf[];
> @@ -279,7 +280,10 @@ static inline void fanotify_init_event(struct fanoti=
fy_event *event,
>  struct {                                                               \
>         struct fanotify_fh (name);                                      \
>         /* Space for object_fh.buf[] - access with fanotify_fh_buf() */ \
> -       unsigned char _inline_fh_buf[(size)];                           \
> +       union {                                                         \
> +               unsigned char _inline_fh_buf[(size)];                   \
> +               int mnt_id;     /* For FAN_UNMOUNT */                   \
> +       };                                                              \
>  }
>
>  struct fanotify_fid_event {
> @@ -335,6 +339,20 @@ static inline __kernel_fsid_t *fanotify_event_fsid(s=
truct fanotify_event *event)
>                 return NULL;
>  }
>
> +static inline int fanotify_event_mntid(struct fanotify_event *event)
> +{
> +       struct fanotify_fh *fh =3D NULL;
> +
> +       if (event->mask & FAN_UNMOUNT &&
> +           event->type =3D=3D FANOTIFY_EVENT_TYPE_FID)
> +               fh =3D &FANOTIFY_FE(event)->object_fh;
> +
> +       if (fh && !fh->len && fh->flags =3D=3D FANOTIFY_FH_FLAG_MNT_ID)
> +               return FANOTIFY_FE(event)->mnt_id;
> +
> +       return 0;
> +}
> +
>  static inline struct fanotify_fh *fanotify_event_object_fh(
>                                                 struct fanotify_event *ev=
ent)
>  {
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 0b3de6218c56..db3b79b8e901 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -120,7 +120,9 @@ struct kmem_cache *fanotify_perm_event_cachep __read_=
mostly;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
>         (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_hand=
le))
> -#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> +#define FANOTIFY_MNTID_INFO_LEN \
> +       sizeof(struct fanotify_event_info_mntid)
> +#define FANOTIFY_PIDFD_INFO_LEN \
>         sizeof(struct fanotify_event_info_pidfd)
>  #define FANOTIFY_ERROR_INFO_LEN \
>         (sizeof(struct fanotify_event_info_error))
> @@ -178,8 +180,11 @@ static size_t fanotify_event_len(unsigned int info_m=
ode,
>                 dot_len =3D 1;
>         }
>
> +       if (fanotify_event_mntid(event))
> +               event_len +=3D FANOTIFY_MNTID_INFO_LEN;
> +
>         if (info_mode & FAN_REPORT_PIDFD)
> -               event_len +=3D FANOTIFY_PIDFD_INFO_HDR_LEN;
> +               event_len +=3D FANOTIFY_PIDFD_INFO_LEN;
>
>         if (fanotify_event_has_object_fh(event)) {
>                 fh_len =3D fanotify_event_object_fh_len(event);
> @@ -515,7 +520,7 @@ static int copy_pidfd_info_to_user(int pidfd,
>                                    size_t count)
>  {
>         struct fanotify_event_info_pidfd info =3D { };
> -       size_t info_len =3D FANOTIFY_PIDFD_INFO_HDR_LEN;
> +       size_t info_len =3D FANOTIFY_PIDFD_INFO_LEN;
>
>         if (WARN_ON_ONCE(info_len > count))
>                 return -EFAULT;
> @@ -530,6 +535,26 @@ static int copy_pidfd_info_to_user(int pidfd,
>         return info_len;
>  }
>
> +static int copy_mntid_info_to_user(int mntid,
> +                                  char __user *buf,
> +                                  size_t count)
> +{
> +       struct fanotify_event_info_mntid info =3D { };
> +       size_t info_len =3D FANOTIFY_MNTID_INFO_LEN;
> +
> +       if (WARN_ON_ONCE(info_len > count))
> +               return -EFAULT;
> +
> +       info.hdr.info_type =3D FAN_EVENT_INFO_TYPE_MNTID;
> +       info.hdr.len =3D info_len;
> +       info.mnt_id =3D mntid;
> +
> +       if (copy_to_user(buf, &info, info_len))
> +               return -EFAULT;
> +
> +       return info_len;
> +}
> +
>  static int copy_info_records_to_user(struct fanotify_event *event,
>                                      struct fanotify_info *info,
>                                      unsigned int info_mode, int pidfd,
> @@ -538,6 +563,7 @@ static int copy_info_records_to_user(struct fanotify_=
event *event,
>         int ret, total_bytes =3D 0, info_type =3D 0;
>         unsigned int fid_mode =3D info_mode & FANOTIFY_FID_BITS;
>         unsigned int pidfd_mode =3D info_mode & FAN_REPORT_PIDFD;
> +       int mntid =3D fanotify_event_mntid(event);
>
>         /*
>          * Event info records order is as follows:
> @@ -632,6 +658,16 @@ static int copy_info_records_to_user(struct fanotify=
_event *event,
>                 total_bytes +=3D ret;
>         }
>
> +       if (mntid) {
> +               ret =3D copy_mntid_info_to_user(mntid, buf, count);
> +               if (ret < 0)
> +                       return ret;
> +
> +               buf +=3D ret;
> +               count -=3D ret;
> +               total_bytes +=3D ret;
> +       }
> +
>         if (pidfd_mode) {
>                 ret =3D copy_pidfd_info_to_user(pidfd, buf, count);
>                 if (ret < 0)
> @@ -1770,7 +1806,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          * inotify sends unsoliciled IN_UNMOUNT per marked inode on sb sh=
utdown.
>          * FAN_UNMOUNT event is about unmount of a mount, not about sb sh=
utdown,
>          * so allow setting it only in mount mark mask.
> -        * FAN_UNMOUNT requires FAN_REPORT_FID to report fsid with empty =
fh.
> +        * FAN_UNMOUNT requires FAN_REPORT_FID to report fsid and mntid.
>          */
>         if (mask & FAN_UNMOUNT &&
>             (!(fid_mode & FAN_REPORT_FID) || mark_type !=3D FAN_MARK_MOUN=
T))
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index 70f2d43e8ba4..886efbd877ba 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -144,6 +144,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID       3
>  #define FAN_EVENT_INFO_TYPE_PIDFD      4
>  #define FAN_EVENT_INFO_TYPE_ERROR      5
> +#define FAN_EVENT_INFO_TYPE_MNTID      6
>
>  /* Special info types for FAN_RENAME */
>  #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME      10
> @@ -184,6 +185,15 @@ struct fanotify_fhandle {
>         __u64 fh_ino;
>  };
>
> +/*
> + * This structure is used for info records of type FAN_EVENT_INFO_TYPE_M=
NTID.
> + */
> +struct fanotify_event_info_mntid {
> +       struct fanotify_event_info_header hdr;
> +       /* matches mount_id from name_to_handle_at(2) */
> +       __s32 mnt_id;
> +};
> +
>  /*
>   * This structure is used for info records of type FAN_EVENT_INFO_TYPE_P=
IDFD.
>   * It holds a pidfd for the pid that was responsible for generating an e=
vent.
> --
> 2.34.1
>
