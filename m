Return-Path: <linux-fsdevel+bounces-3190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D27F0CF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 08:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CE41C210EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DB79EF;
	Mon, 20 Nov 2023 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCooPW0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C364B7
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 23:42:37 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789a4c01easo276571585a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 23:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700466156; x=1701070956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEJbzHDXqnVroQ8QuASP2BM7V/2IbkkTl5m7+ORVkmE=;
        b=iCooPW0KkvflRU2ivv8qRtGzGZ+SFmw+6xvnVhKD/abimOoRrZ6C1I4zvGN2cHHc1l
         qmXNGBSPLeH7mGjm+PfBRkta1hOB21eBPpV3tQMoUATZcyniSrNIqKAhvUvT2o90uneO
         MakxHeVV5wmQSETIJ3QwDrAQgxwRwev0jmkHaVUPljt/OI15coon1XsWviJJ+PnJocxG
         Wye19HVu28EgvbbQLYmK32wDNqseXEX9tofKR3XjJTwgqdrS7ipNdP4pm8WW8/RJLGtu
         +/70qbdVny1HkCyJxpbZC+9kPnbA2t2hhARvpdUJA94q7FgDxwuh/vZNoFoIYadvgUF4
         2PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700466156; x=1701070956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEJbzHDXqnVroQ8QuASP2BM7V/2IbkkTl5m7+ORVkmE=;
        b=QRN80lSU+Npg24C/KTF/0LEyn5FN8gn8Kc+F9t2JE36hs+EwrVl9ux9iT7nOwyXiue
         AxZPRarPHYd/yGmhJgMT6bMYYScxSp7OKElIAT1NBCdR2LbD7Fu+fFdKyLtNvBJ2Kli/
         cxrjKlwf7WKeEx4vPhv3QPUN7jhvK4k1EY7LFz3FRwBtqJC8JU3M8jX2dT0CgODClMuI
         P11qKFb/MVicde7cYEoT0KdivuJmua8D9IPkiPz/yMPjsBRqA6o3/fgJeuA8/ty/Gw0f
         +oTg8wcnJH6tA8pGrhWPIr/MMHHWk6dsmE9vAyzT4kbm8KqiQoAtEjtF9In1vcbji3b0
         tTvw==
X-Gm-Message-State: AOJu0YySqYBNywjDSo7bMYe7xT6Adm2Dxuj0PciXYLCQ40kqzQhclEtv
	TAuMPaJnrROVHBZtHwTzo2Mf2t5uj0WcqSNTOHYq2Lc8yNE=
X-Google-Smtp-Source: AGHT+IESqH7LAQRqlT+IWz7BWk30AkyWTWraF6oR6RVwYV1aBMWlHZD9nJCDAXqVS7HtMYF9Wt/YIeG3sDtELRp0kag=
X-Received: by 2002:a05:6214:dce:b0:679:dd81:c1d7 with SMTP id
 14-20020a0562140dce00b00679dd81c1d7mr2076759qvt.65.1700466156410; Sun, 19 Nov
 2023 23:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231118183018.2069899-1-amir73il@gmail.com> <20231118183018.2069899-3-amir73il@gmail.com>
In-Reply-To: <20231118183018.2069899-3-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Nov 2023 09:42:24 +0200
Message-ID: <CAOQ4uxjLVNqij3GUYrzo1ePyruPQO1S+L62kuMJCTeAVjVvm5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 8:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> non-uniform fsid (e.g. btrfs non-root subvol).
>
> When group is watching inodes all from the same filesystem (or subvol),
> allow adding inode marks with "weak" fsid, because there is no ambiguity
> regarding which filesystem reports the event.
>
> The first mark added to a group determines if this group is single or
> multi filesystem, depending on the fsid at the path of the added mark.
>
> If the first mark added has a "strong" fsid, marks with "weak" fsid
> cannot be added and vice versa.
>
> If the first mark added has a "weak" fsid, following marks must have
> the same "weak" fsid and the same sb as the first mark.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 15 +----
>  fs/notify/fanotify/fanotify.h      |  6 ++
>  fs/notify/fanotify/fanotify_user.c | 97 ++++++++++++++++++++++++------
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 90 insertions(+), 29 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index aff1ab3c32aa..1e4def21811e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -29,12 +29,6 @@ static unsigned int fanotify_hash_path(const struct pa=
th *path)
>                 hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
>  }
>
> -static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
> -                                      __kernel_fsid_t *fsid2)
> -{
> -       return fsid1->val[0] =3D=3D fsid2->val[0] && fsid1->val[1] =3D=3D=
 fsid2->val[1];
> -}
> -
>  static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
>  {
>         return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
> @@ -851,7 +845,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnot=
ify_iter_info *iter_info)
>                 if (!(mark->flags & FSNOTIFY_MARK_FLAG_HAS_FSID))
>                         continue;
>                 fsid =3D FANOTIFY_MARK(mark)->fsid;
> -               if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
> +               if (!(mark->flags & FSNOTIFY_MARK_FLAG_WEAK_FSID) &&
> +                   WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
>                         continue;
>                 return fsid;
>         }
> @@ -933,12 +928,8 @@ static int fanotify_handle_event(struct fsnotify_gro=
up *group, u32 mask,
>                         return 0;
>         }
>
> -       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
> +       if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
>                 fsid =3D fanotify_get_fsid(iter_info);
> -               /* Racing with mark destruction or creation? */
> -               if (!fsid.val[0] && !fsid.val[1])
> -                       return 0;
> -       }
>
>         event =3D fanotify_alloc_event(group, mask, data, data_type, dir,
>                                      file_name, &fsid, match_mask);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index 2847fa564298..9c97ae638ac5 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -504,6 +504,12 @@ static inline __kernel_fsid_t *fanotify_mark_fsid(st=
ruct fsnotify_mark *mark)
>         return &FANOTIFY_MARK(mark)->fsid;
>  }
>
> +static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
> +                                      __kernel_fsid_t *fsid2)
> +{
> +       return fsid1->val[0] =3D=3D fsid2->val[0] && fsid1->val[1] =3D=3D=
 fsid2->val[1];
> +}
> +
>  static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark=
 *mark)
>  {
>         unsigned int mflags =3D 0;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index e3d836d4d156..1cc68ea56c17 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -23,7 +23,7 @@
>
>  #include <asm/ioctls.h>
>
> -#include "../../mount.h"
> +#include "../fsnotify.h"
>  #include "../fdinfo.h"
>  #include "fanotify.h"
>
> @@ -1192,11 +1192,68 @@ static bool fanotify_mark_add_to_mask(struct fsno=
tify_mark *fsn_mark,
>         return recalc;
>  }
>
> +struct fan_fsid {
> +       struct super_block *sb;
> +       __kernel_fsid_t id;
> +       bool weak;
> +};
> +
> +static int fanotify_check_mark_fsid(struct fsnotify_group *group,
> +                                   struct fsnotify_mark *mark,
> +                                   struct fan_fsid *fsid)
> +{
> +       struct fsnotify_mark_connector *conn;
> +       struct fsnotify_mark *old;
> +       struct super_block *old_sb =3D NULL;
> +
> +       *fanotify_mark_fsid(mark) =3D fsid->id;
> +       mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_FSID;
> +       if (fsid->weak)
> +               mark->flags |=3D FSNOTIFY_MARK_FLAG_WEAK_FSID;
> +
> +       /* First mark added will determine if group is single or multi fs=
id */
> +       if (list_empty(&group->marks_list))
> +               return 0;
> +
> +       /* Find sb of an existing mark */
> +       list_for_each_entry(old, &group->marks_list, g_list) {
> +               conn =3D READ_ONCE(old->connector);
> +               if (!conn)
> +                       continue;
> +               old_sb =3D fsnotify_connector_sb(conn);
> +               if (old_sb)
> +                       break;
> +       }
> +
> +       /* Only detached marks left? */
> +       if (!old_sb)
> +               return 0;
> +
> +       /* Do not allow mixing of marks with weak and strong fsid */
> +       if ((mark->flags ^ old->flags) & FSNOTIFY_MARK_FLAG_WEAK_FSID)
> +               return -EXDEV;
> +
> +       /* Allow mixing of marks with strong fsid from different fs */
> +       if (!fsid->weak)
> +               return 0;
> +
> +       /* Do not allow mixing marks with weak fsid from different fs */
> +       if (old_sb !=3D fsid->sb)
> +               return -EXDEV;
> +
> +       /* Do not allow mixing marks from different btrfs sub-volumes */
> +       if (!fanotify_fsid_equal(fanotify_mark_fsid(old),
> +                                fanotify_mark_fsid(mark)))
> +               return -EXDEV;
> +
> +       return 0;
> +}
> +
>  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group=
 *group,
>                                                    fsnotify_connp_t *conn=
p,
>                                                    unsigned int obj_type,
>                                                    unsigned int fan_flags=
,
> -                                                  __kernel_fsid_t *fsid)
> +                                                  struct fan_fsid *fsid)
>  {
>         struct ucounts *ucounts =3D group->fanotify_data.ucounts;
>         struct fanotify_mark *fan_mark;
> @@ -1225,8 +1282,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(=
struct fsnotify_group *group,
>
>         /* Cache fsid of filesystem containing the marked object */
>         if (fsid) {
> -               fan_mark->fsid =3D *fsid;
> -               mark->flags |=3D FSNOTIFY_MARK_FLAG_HAS_FSID;
> +               ret =3D fanotify_check_mark_fsid(group, mark, fsid);
> +               if (ret)

OOPS, missed fsnotify_put_mark(mark);
better add a goto target out_put_mark as this is the second case now.

> +                       goto out_dec_ucounts;
>         } else {
>                 fan_mark->fsid.val[0] =3D fan_mark->fsid.val[1] =3D 0;
>         }
> @@ -1289,7 +1347,7 @@ static int fanotify_may_update_existing_mark(struct=
 fsnotify_mark *fsn_mark,
>  static int fanotify_add_mark(struct fsnotify_group *group,
>                              fsnotify_connp_t *connp, unsigned int obj_ty=
pe,
>                              __u32 mask, unsigned int fan_flags,
> -                            __kernel_fsid_t *fsid)
> +                            struct fan_fsid *fsid)
>  {
>         struct fsnotify_mark *fsn_mark;
>         bool recalc;
> @@ -1337,7 +1395,7 @@ static int fanotify_add_mark(struct fsnotify_group =
*group,
>
>  static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
>                                       struct vfsmount *mnt, __u32 mask,
> -                                     unsigned int flags, __kernel_fsid_t=
 *fsid)
> +                                     unsigned int flags, struct fan_fsid=
 *fsid)
>  {
>         return fanotify_add_mark(group, &real_mount(mnt)->mnt_fsnotify_ma=
rks,
>                                  FSNOTIFY_OBJ_TYPE_VFSMOUNT, mask, flags,=
 fsid);
> @@ -1345,7 +1403,7 @@ static int fanotify_add_vfsmount_mark(struct fsnoti=
fy_group *group,
>
>  static int fanotify_add_sb_mark(struct fsnotify_group *group,
>                                 struct super_block *sb, __u32 mask,
> -                               unsigned int flags, __kernel_fsid_t *fsid=
)
> +                               unsigned int flags, struct fan_fsid *fsid=
)
>  {
>         return fanotify_add_mark(group, &sb->s_fsnotify_marks,
>                                  FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsid)=
;
> @@ -1353,7 +1411,7 @@ static int fanotify_add_sb_mark(struct fsnotify_gro=
up *group,
>
>  static int fanotify_add_inode_mark(struct fsnotify_group *group,
>                                    struct inode *inode, __u32 mask,
> -                                  unsigned int flags, __kernel_fsid_t *f=
sid)
> +                                  unsigned int flags, struct fan_fsid *f=
sid)
>  {
>         pr_debug("%s: group=3D%p inode=3D%p\n", __func__, group, inode);
>
> @@ -1564,20 +1622,25 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>         return fd;
>  }
>
> -static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fs=
id)
> +static int fanotify_test_fsid(struct dentry *dentry, unsigned int flags,
> +                             struct fan_fsid *fsid)
>  {
> +       unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
>         __kernel_fsid_t root_fsid;
>         int err;
>
>         /*
>          * Make sure dentry is not of a filesystem with zero fsid (e.g. f=
use).
>          */
> -       err =3D vfs_get_fsid(dentry, fsid);
> +       err =3D vfs_get_fsid(dentry, &fsid->id);
>         if (err)
>                 return err;
>
> -       if (!fsid->val[0] && !fsid->val[1])
> -               return -ENODEV;
> +       /* Allow weak fsid when marking inodes */
> +       fsid->sb =3D dentry->d_sb;
> +       fsid->weak =3D mark_type =3D=3D FAN_MARK_INODE;
> +       if (!fsid->id.val[0] && !fsid->id.val[1])
> +               return fsid->weak ? 0 : -ENODEV;
>
>         /*
>          * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
> @@ -1587,10 +1650,10 @@ static int fanotify_test_fsid(struct dentry *dent=
ry, __kernel_fsid_t *fsid)
>         if (err)
>                 return err;
>
> -       if (root_fsid.val[0] !=3D fsid->val[0] ||
> -           root_fsid.val[1] !=3D fsid->val[1])
> -               return -EXDEV;
> +       if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
> +               return fsid->weak ? 0 : -EXDEV;
>
> +       fsid->weak =3D false;
>         return 0;
>  }
>
> @@ -1675,7 +1738,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         struct fsnotify_group *group;
>         struct fd f;
>         struct path path;
> -       __kernel_fsid_t __fsid, *fsid =3D NULL;
> +       struct fan_fsid __fsid, *fsid =3D NULL;
>         u32 valid_mask =3D FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
>         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
>         unsigned int mark_cmd =3D flags & FANOTIFY_MARK_CMD_BITS;
> @@ -1827,7 +1890,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         }
>
>         if (fid_mode) {
> -               ret =3D fanotify_test_fsid(path.dentry, &__fsid);
> +               ret =3D fanotify_test_fsid(path.dentry, flags, &__fsid);
>                 if (ret)
>                         goto path_put_and_out;
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index a80b525ca653..7f63be5ca0f1 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -529,6 +529,7 @@ struct fsnotify_mark {
>  #define FSNOTIFY_MARK_FLAG_NO_IREF             0x0200
>  #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS    0x0400
>  #define FSNOTIFY_MARK_FLAG_HAS_FSID            0x0800
> +#define FSNOTIFY_MARK_FLAG_WEAK_FSID           0x1000
>         unsigned int flags;             /* flags [mark->lock] */
>  };
>
> --
> 2.34.1
>

