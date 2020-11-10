Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3702ACEDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 06:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgKJFHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 00:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgKJFH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:07:27 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF65C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 21:07:27 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id x20so10655328ilj.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 21:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTT3BNT00/uP9G28JdGA733dPjCpFvplKZsaI68H9g0=;
        b=D9qqOvFB6RScKXJpSZ2m50RCJLpyrZ0rY6CXpE6AbdTwgOhCs7yYthsk/qwVU6N6lr
         lC1TkBW1KPNZP5R5LFcAhG4jeyOPVlQXOoYxPitGQ2NDQsCWlYIJDWH2AuAQo9PN6C7U
         g8IDTqxbwHOAXC1EvqzvMz9glZesSt7N+NtZsSlZ7sHRWss70zun9UNLbjHg2xAtxnBa
         KFx/7Fe/sBdEHtBsf74KuPyhGqOmJgIc3tevr+pUN/ey6gWqnj9734e8+jV3q1SdMozH
         qiQd8Pc3uwwHnmK9wkg98sP+q1Zil+mxjdqL7yb9xbYRrRWEM0kiuDdK78IA2/kXE322
         d3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTT3BNT00/uP9G28JdGA733dPjCpFvplKZsaI68H9g0=;
        b=beEr4gwofFsyCgJRvISjeEO8Hr+3jVzILdyZ53FRKjYItYIj4ZWtzsu7I4gv0WmUOI
         Mnwima756ciEFDMWdqwiGAZG+5Db6p+7umGZNcSJX+Fma9icim1QnX52ulqcBdXPZBya
         CMwNW4rhGA+rIqGgjHOm7g3/4X4hmdXhmNiofUjsbjq6LIbz7/rFe6K49fYdroLyB/aL
         2Q4auMBLULF+QJkYF9hV4iU7Y/hVKN+reONghOjpooUQtKul75iCzs/FW/FSJfSVTGq8
         ti9VSrYon6wXuRFnjFwYSsoa/qS+hBVZtDVVPxAayKgAlcywweEL4J+M/4UAcFP+lXhf
         btpQ==
X-Gm-Message-State: AOAM532kx5CKBv39IfhOqdpq7thevjNC00K6+2DhZtIjl+hu1wgV+RPp
        TNjEE5om/r+YIA2O9ZBb7Pcozc11kyNGBkyLBf1V2R5E
X-Google-Smtp-Source: ABdhPJwdkviQvm8iWl+oLFjkT4Lks/9BvpYlrIOaZcQRzn2iW0cGphzG2Az31kp8R8Ep/Ii7idFPmVkRbQogaD9gZfo=
X-Received: by 2002:a92:6403:: with SMTP id y3mr12772507ilb.72.1604984846040;
 Mon, 09 Nov 2020 21:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com>
In-Reply-To: <20201109180016.80059-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Nov 2020 07:07:14 +0200
Message-ID: <CAOQ4uxhkMk49FeYp+QxcLnkqgO+MNaS4XaLxJDW6GTg2UpaC3g@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 8:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> A filesystem view is a subtree of a filesystem accessible from a specific
> mount point.  When marking an FS view, user expects to get events on all
> inodes that are accessible from the marked mount, even if the events
> were generated from another mount.
>
> In particular, the events such as FAN_CREATE, FAN_MOVE, FAN_DELETE that
> are not delivered to a mount mark can be delivered to an FS view mark.
>
> One example of a filesystem view is btrfs subvolume, which cannot be
> marked with a regular filesystem mark.
>
> Another example of a filesystem view is a bind mount, not on the root of
> the filesystem, such as the bind mounts used for containers.
>
> A filesystem view mark is composed of a heads sb mark and an sb_view mark.
> The filesystem view mark is connected to the head sb mark and the head
> sb mark is connected to the sb object. The mask of the head sb mask is
> a cumulative mask of all the associated sb_view mark masks.
>
> Filesystem view marks cannot co-exist with a regular filesystem mark on
> the same filesystem.
>
> When an event is generated on the head sb mark, fsnotify iterates the
> list of associated sb_view marks and filter events that happen outside
> of the sb_view mount's root.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Jan,
>
> I started to play with ideas of filtering events by subtree.
> My first approach was to do that in userspace.
>
> This becomes quite easy if you are able to create a bind mount on the
> subtree of interest - you use a 'mount_fd' from within the bind mount
> for open_by_handle_at() of the dirfid and the magic symlink in /proc
> resolves that fd to / for dirs outside the bind mount path.
>
> Having done that, it seems pretty silly to go to userspace and back to
> kernel for the filtering, so many wasted cycles when we can do the same
> filtering much sooner.
>
> The name "fs view" is inspired by Mark's proposal of the same name [1].
> We do not have to restrict the "fs view" points to mount points, but it
> created conventient semantics and I pretty much like the idea that
> FAN_MARK_MOUNT|FAN_MARK_FILESYSTEM gives you this new hybrid thing.
>
> This is just a POC that I sketched with obvious missing pieces, but at
> least with a single fs view mark that I tested it works.
>
> Thoughts?
>
> Amir.
>
>
> [1] https://lore.kernel.org/linux-fsdevel/20180508180436.716-2-mfasheh@suse.de/
>
>  fs/notify/fanotify/fanotify_user.c | 115 ++++++++++++++++++++++++++---
>  fs/notify/fdinfo.c                 |   9 +++
>  fs/notify/fsnotify.c               |  37 +++++++++-
>  fs/notify/fsnotify.h               |   8 ++
>  fs/notify/group.c                  |   2 +-
>  fs/notify/mark.c                   |  11 ++-
>  include/linux/fanotify.h           |   1 +
>  include/linux/fsnotify_backend.h   |  44 +++++++++--
>  include/uapi/linux/fanotify.h      |   2 +
>  9 files changed, 207 insertions(+), 22 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3e01d8f2ab90..1a46898a1bc8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -760,7 +760,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
>
>         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
>                                                  umask, &destroy_mark);
> -       if (removed & fsnotify_conn_mask(fsn_mark->connector))
> +       if (!mask || (removed & fsnotify_conn_mask(fsn_mark->connector)))
>                 fsnotify_recalc_mask(fsn_mark->connector);
>         if (destroy_mark)
>                 fsnotify_detach_mark(fsn_mark);
> @@ -781,6 +781,35 @@ static int fanotify_remove_vfsmount_mark(struct fsnotify_group *group,
>                                     mask, flags, umask);
>  }
>
> +static int fanotify_remove_sb_view_mark(struct fsnotify_group *group,
> +                                       struct vfsmount *mnt, __u32 mask,
> +                                       unsigned int flags, __u32 umask)
> +{
> +       struct fsnotify_mark *sb_mark;
> +       int ret;
> +
> +       /* Find the head sb mark */
> +       mutex_lock(&group->mark_mutex);
> +       sb_mark = fsnotify_find_mark(&mnt->mnt_sb->s_fsnotify_marks, group);
> +       mutex_unlock(&group->mark_mutex);
> +       /* Cannot have both sb mark and sb_view marks on the same sb */
> +       if (!sb_mark || !(sb_mark->flags & FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD)) {
> +               if (sb_mark)
> +                       fsnotify_put_mark(sb_mark);
> +               return -ENOENT;
> +       }
> +
> +       /* Update or destroy the sb_view mark */
> +       ret = fanotify_remove_mark(group, &fsnotify_sbv_mark(sb_mark)->sbv_marks,
> +                                  mask, flags, umask);
> +       fsnotify_put_mark(sb_mark);
> +       if (ret)
> +               return ret;
> +
> +       /* Remove mask 0 to update or destroy the head sb mark */
> +       return fanotify_remove_mark(group, &mnt->mnt_sb->s_fsnotify_marks, 0, flags, umask);
> +}
> +
>  static int fanotify_remove_sb_mark(struct fsnotify_group *group,
>                                    struct super_block *sb, __u32 mask,
>                                    unsigned int flags, __u32 umask)
> @@ -833,6 +862,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>                 return ERR_PTR(-ENOMEM);
>
>         fsnotify_init_mark(mark, group);
> +       fsnotify_sbv_mark(mark)->mnt = NULL;
>         ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
>         if (ret) {
>                 fsnotify_put_mark(mark);
> @@ -843,13 +873,19 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>  }
>
>
> -static int fanotify_add_mark(struct fsnotify_group *group,
> +/* Returns fsnotify_mark with elevated refcount */
> +static struct fsnotify_mark *__fanotify_add_mark(struct fsnotify_group *group,
>                              fsnotify_connp_t *connp, unsigned int type,
>                              __u32 mask, unsigned int flags,
> -                            __kernel_fsid_t *fsid)
> +                            __kernel_fsid_t *fsid, struct vfsmount *mnt)
>  {
>         struct fsnotify_mark *fsn_mark;
>         __u32 added;
> +       unsigned int sb_view_head = 0;
> +
> +       if (type == FSNOTIFY_OBJ_TYPE_SB &&
> +           (flags & FAN_MARK_FS_VIEW) == FAN_MARK_FS_VIEW)
> +               sb_view_head = FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD;
>
>         mutex_lock(&group->mark_mutex);
>         fsn_mark = fsnotify_find_mark(connp, group);
> @@ -857,14 +893,38 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>                 fsn_mark = fanotify_add_new_mark(group, connp, type, fsid);
>                 if (IS_ERR(fsn_mark)) {
>                         mutex_unlock(&group->mark_mutex);
> -                       return PTR_ERR(fsn_mark);
> +                       return fsn_mark;
>                 }
> +               if (type == FSNOTIFY_OBJ_TYPE_SB_VIEW)
> +                       fsnotify_sbv_mark(fsn_mark)->mnt = mnt;
> +               else
> +                       fsn_mark->flags |= sb_view_head;
> +
> +       } else if ((fsn_mark->flags & FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD) != sb_view_head) {
> +               /* Cannot have both sb mark and sb_view marks on the same sb */
> +               mutex_unlock(&group->mark_mutex);
> +               fsnotify_put_mark(fsn_mark);
> +               return ERR_PTR(-EEXIST);
>         }
>         added = fanotify_mark_add_to_mask(fsn_mark, mask, flags);
> -       if (added & ~fsnotify_conn_mask(fsn_mark->connector))
> +       if (!mask || (added & ~fsnotify_conn_mask(fsn_mark->connector)))
>                 fsnotify_recalc_mask(fsn_mark->connector);
>         mutex_unlock(&group->mark_mutex);
>
> +       return fsn_mark;
> +}
> +
> +static int fanotify_add_mark(struct fsnotify_group *group,
> +                            fsnotify_connp_t *connp, unsigned int type,
> +                            __u32 mask, unsigned int flags,
> +                            __kernel_fsid_t *fsid, struct vfsmount *mnt)
> +{
> +       struct fsnotify_mark *fsn_mark;
> +
> +       fsn_mark = __fanotify_add_mark(group, connp, type, mask, flags, fsid, mnt);
> +       if (IS_ERR(fsn_mark))
> +               return PTR_ERR(fsn_mark);
> +
>         fsnotify_put_mark(fsn_mark);
>         return 0;
>  }
> @@ -874,7 +934,31 @@ static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
>                                       unsigned int flags, __kernel_fsid_t *fsid)
>  {
>         return fanotify_add_mark(group, &real_mount(mnt)->mnt_fsnotify_marks,
> -                                FSNOTIFY_OBJ_TYPE_VFSMOUNT, mask, flags, fsid);
> +                                FSNOTIFY_OBJ_TYPE_VFSMOUNT, mask, flags, fsid, NULL);
> +}
> +
> +static int fanotify_add_sb_view_mark(struct fsnotify_group *group,
> +                                    struct vfsmount *mnt, __u32 mask,
> +                                    unsigned int flags, __kernel_fsid_t *fsid)
> +{
> +       struct fsnotify_mark *sb_mark;
> +       int ret;
> +
> +       sb_mark = __fanotify_add_mark(group, &mnt->mnt_sb->s_fsnotify_marks,
> +                                     FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsid, mnt);
> +       if (IS_ERR(sb_mark))
> +               return PTR_ERR(sb_mark);
> +
> +       /* Add to sb_view mark */
> +       ret = fanotify_add_mark(group, &fsnotify_sbv_mark(sb_mark)->sbv_marks,
> +                               FSNOTIFY_OBJ_TYPE_SB_VIEW, mask, flags, fsid, mnt);
> +       fsnotify_put_mark(sb_mark);
> +       if (ret)
> +               return ret;
> +
> +       /* Add mask 0 to re-calc the sb object mask after updating the sb view head mark mask */
> +       return fanotify_add_mark(group, &mnt->mnt_sb->s_fsnotify_marks, FSNOTIFY_OBJ_TYPE_SB, 0,
> +                                flags, fsid, mnt);
>  }
>
>  static int fanotify_add_sb_mark(struct fsnotify_group *group,
> @@ -882,7 +966,7 @@ static int fanotify_add_sb_mark(struct fsnotify_group *group,
>                                 unsigned int flags, __kernel_fsid_t *fsid)
>  {
>         return fanotify_add_mark(group, &sb->s_fsnotify_marks,
> -                                FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsid);
> +                                FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsid, NULL);
>  }
>
>  static int fanotify_add_inode_mark(struct fsnotify_group *group,
> @@ -902,7 +986,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
>                 return 0;
>
>         return fanotify_add_mark(group, &inode->i_fsnotify_marks,
> -                                FSNOTIFY_OBJ_TYPE_INODE, mask, flags, fsid);
> +                                FSNOTIFY_OBJ_TYPE_INODE, mask, flags, fsid, NULL);
>  }
>
>  static struct fsnotify_event *fanotify_alloc_overflow_event(void)
> @@ -1116,7 +1200,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>         struct path path;
>         __kernel_fsid_t __fsid, *fsid = NULL;
>         u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
> -       unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
> +       unsigned int mark_type = FANOTIFY_MARK_TYPE(flags);
>         bool ignored = flags & FAN_MARK_IGNORED_MASK;
>         unsigned int obj_type, fid_mode;
>         u32 umask = 0;
> @@ -1139,6 +1223,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>         case FAN_MARK_MOUNT:
>                 obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
>                 break;
> +       case FAN_MARK_FS_VIEW:
> +               obj_type = FSNOTIFY_OBJ_TYPE_SB_VIEW;
> +               break;
>         case FAN_MARK_FILESYSTEM:
>                 obj_type = FSNOTIFY_OBJ_TYPE_SB;
>                 break;
> @@ -1205,6 +1292,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 ret = 0;
>                 if (mark_type == FAN_MARK_MOUNT)
>                         fsnotify_clear_vfsmount_marks_by_group(group);
> +               else if (mark_type == FAN_MARK_FS_VIEW)
> +                       fsnotify_clear_sb_view_marks_by_group(group);
>                 else if (mark_type == FAN_MARK_FILESYSTEM)
>                         fsnotify_clear_sb_marks_by_group(group);
>                 else
> @@ -1256,6 +1345,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 if (mark_type == FAN_MARK_MOUNT)
>                         ret = fanotify_add_vfsmount_mark(group, mnt, mask,
>                                                          flags, fsid);
> +               else if (mark_type == FAN_MARK_FS_VIEW)
> +                       ret = fanotify_add_sb_view_mark(group, mnt, mask,
> +                                                       flags, fsid);
>                 else if (mark_type == FAN_MARK_FILESYSTEM)
>                         ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
>                                                    flags, fsid);
> @@ -1267,6 +1359,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>                 if (mark_type == FAN_MARK_MOUNT)
>                         ret = fanotify_remove_vfsmount_mark(group, mnt, mask,
>                                                             flags, umask);
> +               else if (mark_type == FAN_MARK_FS_VIEW)
> +                       ret = fanotify_remove_sb_view_mark(group, mnt, mask,
> +                                                          flags, umask);
>                 else if (mark_type == FAN_MARK_FILESYSTEM)
>                         ret = fanotify_remove_sb_mark(group, mnt->mnt_sb, mask,
>                                                       flags, umask);
> @@ -1318,7 +1413,7 @@ static int __init fanotify_user_setup(void)
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
>
> -       fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> +       fanotify_mark_cache = KMEM_CACHE(fsnotify_sb_view_mark,
>                                          SLAB_PANIC|SLAB_ACCOUNT);
>         fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
>                                                SLAB_PANIC);
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index f0d6b54be412..4b00575e9bd1 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -115,6 +115,9 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
>
>         if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
>                 mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
> +       if (mark->connector->type == FSNOTIFY_OBJ_TYPE_SB_VIEW ||
> +           (mark->flags & FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD))
> +               mflags |= FAN_MARK_FS_VIEW;
>
>         if (mark->connector->type == FSNOTIFY_OBJ_TYPE_INODE) {
>                 inode = igrab(fsnotify_conn_inode(mark->connector));
> @@ -131,6 +134,12 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
>
>                 seq_printf(m, "fanotify mnt_id:%x mflags:%x mask:%x ignored_mask:%x\n",
>                            mnt->mnt_id, mflags, mark->mask, mark->ignored_mask);
> +       } else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_SB_VIEW) {
> +               struct vfsmount *mnt = fsnotify_sbv_mark(mark)->mnt;
> +
> +               seq_printf(m, "fanotify sdev:%x mnt_id:%x mflags:%x mask:%x ignored_mask:%x\n",
> +                          mnt->mnt_sb->s_dev, real_mount(mnt)->mnt_id, mflags, mark->mask,
> +                          mark->ignored_mask);
>         } else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_SB) {
>                 struct super_block *sb = fsnotify_conn_sb(mark->connector);
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 8d3ad5ef2925..7af2132372fc 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -275,6 +275,9 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>         return ops->handle_inode_event(child_mark, mask, inode, NULL, NULL);
>  }
>
> +static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp);
> +static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark);
> +
>  static int send_to_group(__u32 mask, const void *data, int data_type,
>                          struct inode *dir, const struct qstr *file_name,
>                          u32 cookie, struct fsnotify_iter_info *iter_info)
> @@ -305,9 +308,39 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>                 if (!fsnotify_iter_should_report_type(iter_info, type))
>                         continue;
>                 mark = iter_info->marks[type];
> +               if (!mark)
> +                       continue;
> +
>                 /* does the object mark tell us to do something? */
> -               if (mark) {
> -                       group = mark->group;
> +               group = mark->group;
> +               if (type == FSNOTIFY_OBJ_TYPE_SB && mark &&
> +                    (mark->flags & FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD)) {
> +                       const struct path *path = fsnotify_data_path(data, data_type);
> +                       struct fsnotify_sb_view_mark *sbv_mark = (void *)mark;
> +
> +                       /* TODO: pass FSNOTIFY_EVENT_DENTRY data type for dir modify events */
> +                       if (!path || !sbv_mark->sbv_marks)
> +                               continue;
> +
> +                       /*
> +                        * Iterate sb_view marks and apply masks if victim is under mnt root.
> +                        * We already have rcu read lock and d_ancestor is accurate enough

Yeh, we don't have rcu read lock. We need to either take it or use the
more strict
is_subdir() check.

> +                        * for our needs - if any of the ancestors have been moved in or out
> +                        * of the mnt root path, we may either send the event or not.
> +                        * The important thing is that if ancestry was always under mnt root
> +                        * we will send the event.
> +                        */
> +                       for (sbv_mark = (void *)fsnotify_first_mark(&sbv_mark->sbv_marks);
> +                            sbv_mark; sbv_mark = (void *)fsnotify_next_mark((void *)sbv_mark)) {
> +                               if ((!(test_mask & sbv_mark->fsn_mark.mask) &&
> +                                    !(test_mask & sbv_mark->fsn_mark.ignored_mask)) ||
> +                                   !d_ancestor(sbv_mark->mnt->mnt_root, path->dentry))
> +                                       continue;
> +
> +                               marks_mask |= sbv_mark->fsn_mark.mask;
> +                               marks_ignored_mask |= sbv_mark->fsn_mark.ignored_mask;
> +                       }
> +               } else {
>                         marks_mask |= mark->mask;
>                         marks_ignored_mask |= mark->ignored_mask;
>                 }
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index ff2063ec6b0f..5aaabf2bee31 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -21,6 +21,12 @@ static inline struct mount *fsnotify_conn_mount(
>         return container_of(conn->obj, struct mount, mnt_fsnotify_marks);
>  }
>
> +static inline struct fsnotify_sb_view_mark *fsnotify_conn_sb_view_mark(
> +                               struct fsnotify_mark_connector *conn)
> +{
> +       return container_of(conn->obj, struct fsnotify_sb_view_mark, sbv_marks);
> +}
> +
>  static inline struct super_block *fsnotify_conn_sb(
>                                 struct fsnotify_mark_connector *conn)
>  {
> @@ -48,11 +54,13 @@ static inline void fsnotify_clear_marks_by_inode(struct inode *inode)
>  static inline void fsnotify_clear_marks_by_mount(struct vfsmount *mnt)
>  {
>         fsnotify_destroy_marks(&real_mount(mnt)->mnt_fsnotify_marks);
> +       /* TODO: clear sb_view marks associated with this mnt */
>  }
>  /* run the list of all marks associated with sb and destroy them */
>  static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>  {
>         fsnotify_destroy_marks(&sb->s_fsnotify_marks);
> +       /* TODO: clear sb_view marks associated with this sb */
>  }
>
>  /*
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index a4a4b1c64d32..a5367b66f33a 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -58,7 +58,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
>         fsnotify_group_stop_queueing(group);
>
>         /* Clear all marks for this group and queue them for destruction */
> -       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK);
> +       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK, 0);
>
>         /*
>          * Some marks can still be pinned when waiting for response from
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 8387937b9d01..81825de6a6a9 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -103,6 +103,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
>                 return &fsnotify_conn_inode(conn)->i_fsnotify_mask;
>         else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT)
>                 return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
> +       else if (conn->type == FSNOTIFY_OBJ_TYPE_SB_VIEW)
> +               return &fsnotify_conn_sb_view_mark(conn)->fsn_mark.mask;
>         else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
>                 return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
>         return NULL;
> @@ -185,6 +187,8 @@ static void *fsnotify_detach_connector_from_object(
>                 atomic_long_inc(&inode->i_sb->s_fsnotify_inode_refs);
>         } else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>                 fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
> +       } else if (conn->type == FSNOTIFY_OBJ_TYPE_SB_VIEW) {
> +               fsnotify_conn_sb_view_mark(conn)->fsn_mark.mask = 0;
>         } else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
>                 fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
>         }
> @@ -720,9 +724,9 @@ struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
>  }
>  EXPORT_SYMBOL_GPL(fsnotify_find_mark);
>
> -/* Clear any marks in a group with given type mask */
> +/* Clear any marks in a group with given type mask or given flags */
>  void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
> -                                  unsigned int type_mask)
> +                                  unsigned int type_mask, unsigned int flags_mask)
>  {
>         struct fsnotify_mark *lmark, *mark;
>         LIST_HEAD(to_free);
> @@ -744,7 +748,8 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
>          */
>         mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
>         list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
> -               if ((1U << mark->connector->type) & type_mask)
> +               if (((1U << mark->connector->type) & type_mask) ||
> +                   (mark->flags & flags_mask))
>                         list_move(&mark->g_list, &to_free);
>         }
>         mutex_unlock(&group->mark_mutex);
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 3e9c56ee651f..6f36bece5518 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -27,6 +27,7 @@
>
>  #define FANOTIFY_MARK_TYPE_BITS        (FAN_MARK_INODE | FAN_MARK_MOUNT | \
>                                  FAN_MARK_FILESYSTEM)
> +#define FANOTIFY_MARK_TYPE(flags) ((flags) & FANOTIFY_MARK_TYPE_BITS)
>
>  #define FANOTIFY_MARK_FLAGS    (FANOTIFY_MARK_TYPE_BITS | \
>                                  FAN_MARK_ADD | \
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index f8529a3a2923..441b3d5d9241 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -279,6 +279,7 @@ enum fsnotify_obj_type {
>         FSNOTIFY_OBJ_TYPE_INODE,
>         FSNOTIFY_OBJ_TYPE_CHILD,
>         FSNOTIFY_OBJ_TYPE_VFSMOUNT,
> +       FSNOTIFY_OBJ_TYPE_SB_VIEW,
>         FSNOTIFY_OBJ_TYPE_SB,
>         FSNOTIFY_OBJ_TYPE_COUNT,
>         FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
> @@ -287,6 +288,7 @@ enum fsnotify_obj_type {
>  #define FSNOTIFY_OBJ_TYPE_INODE_FL     (1U << FSNOTIFY_OBJ_TYPE_INODE)
>  #define FSNOTIFY_OBJ_TYPE_CHILD_FL     (1U << FSNOTIFY_OBJ_TYPE_CHILD)
>  #define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL  (1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
> +#define FSNOTIFY_OBJ_TYPE_SB_VIEW_FL   (1U << FSNOTIFY_OBJ_TYPE_SB_VIEW)
>  #define FSNOTIFY_OBJ_TYPE_SB_FL                (1U << FSNOTIFY_OBJ_TYPE_SB)
>  #define FSNOTIFY_OBJ_ALL_TYPES_MASK    ((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
>
> @@ -403,9 +405,30 @@ struct fsnotify_mark {
>  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY 0x01
>  #define FSNOTIFY_MARK_FLAG_ALIVE               0x02
>  #define FSNOTIFY_MARK_FLAG_ATTACHED            0x04
> +#define FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD                0x08
>         unsigned int flags;             /* flags [mark->lock] */
>  };
>
> +/*
> + * The head sb_view mark is connected to an sb objects and the rest of the
> + * sb_view marks are connected to the head mark.
> + * The mask on the head mark is the cumulative mask of all sb_view marks.
> + */
> +struct fsnotify_sb_view_mark {
> +       struct fsnotify_mark fsn_mark;
> +       union {
> +               /* sb_view marks connected to this head sb mark */
> +               struct fsnotify_mark_connector __rcu *sbv_marks;
> +               /* mntpoint associated with this sb view mark */
> +               struct vfsmount *mnt;
> +       };
> +};
> +
> +static inline struct fsnotify_sb_view_mark *fsnotify_sbv_mark(struct fsnotify_mark *fsn_mark)
> +{
> +       return container_of(fsn_mark, struct fsnotify_sb_view_mark, fsn_mark);
> +}
> +
>  #ifdef CONFIG_FSNOTIFY
>
>  /* called from the vfs helpers */
> @@ -552,22 +575,31 @@ extern void fsnotify_detach_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_free_mark(struct fsnotify_mark *mark);
>  /* Wait until all marks queued for destruction are destroyed */
>  extern void fsnotify_wait_marks_destroyed(void);
> -/* run all the marks in a group, and clear all of the marks attached to given object type */
> -extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type);
> +/* run all the marks in a group, and clear all of the marks by object type and flags */
> +extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type,
> +                                         unsigned int flags);
>  /* run all the marks in a group, and clear all of the vfsmount marks */
>  static inline void fsnotify_clear_vfsmount_marks_by_group(struct fsnotify_group *group)
>  {
> -       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL);
> +       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL, 0);
>  }
>  /* run all the marks in a group, and clear all of the inode marks */
>  static inline void fsnotify_clear_inode_marks_by_group(struct fsnotify_group *group)
>  {
> -       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE_FL);
> +       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE_FL, 0);
> +}
> +/* run all the marks in a group, and clear all of the sb view marks */
> +static inline void fsnotify_clear_sb_view_marks_by_group(struct fsnotify_group *group)
> +{
> +       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_VIEW_FL, 0);
> +       /* Clear all sb marks associated with sb view marks */
> +       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_FL,
> +                                     FSNOTIFY_MARK_FLAG_SB_VIEW_HEAD);
>  }
> -/* run all the marks in a group, and clear all of the sn marks */
> +/* run all the marks in a group, and clear all of the sb marks */
>  static inline void fsnotify_clear_sb_marks_by_group(struct fsnotify_group *group)
>  {
> -       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_FL);
> +       fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_FL, 0);
>  }
>  extern void fsnotify_get_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_put_mark(struct fsnotify_mark *mark);
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index fbf9c5c7dd59..c8e43c0ed89b 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -79,6 +79,8 @@
>  #define FAN_MARK_INODE         0x00000000
>  #define FAN_MARK_MOUNT         0x00000010
>  #define FAN_MARK_FILESYSTEM    0x00000100
> +/* FS View is a subtree of a filesystem accessible from a specific mount point */
> +#define FAN_MARK_FS_VIEW       (FAN_MARK_FILESYSTEM | FAN_MARK_MOUNT)
>
>  /* Deprecated - do not use this in programs and do not add new flags here! */
>  #define FAN_ALL_MARK_FLAGS     (FAN_MARK_ADD |\
> --
> 2.25.1
>
