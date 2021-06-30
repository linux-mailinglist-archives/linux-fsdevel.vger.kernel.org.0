Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437FF3B7C10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhF3DcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhF3DcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:32:17 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE095C061760;
        Tue, 29 Jun 2021 20:29:46 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h3so1462845ilc.9;
        Tue, 29 Jun 2021 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKYRP5epcL/v/Np375UP7wnRZn7yflyEm+8YidngdYk=;
        b=PzkgUHEwBh0KDUGFEP1m868TuVWRGVckcfByzFs/hkmQeURHT6r22G0BGUUqlX7sBe
         qNdxFzQFkKQJTVp0LFiAMOo9PfqjXceTQfPc2UrKKkcWop9y+477bIc+o9XzCOHuqKin
         sY6yMlQXwkWLXBTlVfE4VZSd514/uSYqQ6TPy/zq6J0KUUyLLulyeMo8ggImZ08c37L0
         tiPLdI9X/dxlaQo4gEkJeH4V8O9OkhQ+EvWI87DgCtQS3DpqjnYwOieP77jY8B2UCV3q
         3LTdzILsvE1EIrE4UzHojKjKkNQr54mmLBnCIHrxN/2tt790n67lIYu08nuGzOrDirqx
         du9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKYRP5epcL/v/Np375UP7wnRZn7yflyEm+8YidngdYk=;
        b=rWhUO5C1hVK8sCnGbQvdcn7CMRq0NJIuAYt23Ywt2j8PoA9U0wW0ePMZJaWnBHLDt6
         H5sAMRwJ12vSq9bW32wATb4gvHUVrz5a1OvKtVNriA7T5LQaYv74+WhI9LDlywGK/kCT
         F8K1VO+2K6uEpAGu8lDOMH0pA/qQkaCJiAcZB9ZVi8+PpSVOt3hOJuZmA2h+51QodxGO
         KtqB7IviO4CEAXtRIZesFjMvm+Lo+blOF3m1rvvSRctSzbwrfrzApC7NktJ+p7euVfE3
         VDw257Z11zFO7BkwAE3nw0QYYtQxVk7aIEpn7U1ERG9aYOto8GzP678+zcChYv1KitVc
         LPwQ==
X-Gm-Message-State: AOAM531dk9pODU1f+obmBjcHPn+aNXlzsPnPge3U7xSYUv8zfx2FpsTP
        L3WzDZCnzoPIOQDQmfjP6Nol7sdJr/eHapXWlW8=
X-Google-Smtp-Source: ABdhPJwuofd5srm+7saR5pR1G1WGVKzvHDv9cTAz7QsU6it4Z9nSVGgQE35dRRfOWokXxiCKycIv2gPCToJys1fxHWU=
X-Received: by 2002:a92:c263:: with SMTP id h3mr3523109ild.250.1625023786315;
 Tue, 29 Jun 2021 20:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-8-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-8-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:29:35 +0300
Message-ID: <CAOQ4uxg8TC7RJkYFDgL5VfgBxQhig8_ZqJG3VpXC+PA-OwCnTg@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

()


On Tue, Jun 29, 2021 at 10:12 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> There are a lot of arguments to fsnotify() and the handle_event() method.
> Pass them in a const struct instead of on the argument list.
>
> Apart from being more tidy, this helps with passing error reports to the
> backend.  __fsnotify_parent() argument list was intentionally left
> untouched, because its argument list is still short enough and because
> most of the event info arguments are initialized inside
> __fsnotify_parent().
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c    | 59 +++++++++++------------
>  fs/notify/fsnotify.c             | 83 +++++++++++++++++---------------
>  include/linux/fsnotify.h         | 15 ++++--
>  include/linux/fsnotify_backend.h | 73 +++++++++++++++++++++-------
>  4 files changed, 140 insertions(+), 90 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0f760770d4c9..4f2febb15e94 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -253,21 +253,22 @@ static int fanotify_get_response(struct fsnotify_group *group,
>   * been included within the event mask, but have not been explicitly
>   * requested by the user, will not be present in the returned mask.
>   */
> -static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> -                                    struct fsnotify_iter_info *iter_info,
> -                                    u32 event_mask, const void *data,
> -                                    int data_type, struct inode *dir)
> +static u32 fanotify_group_event_mask(
> +                               struct fsnotify_group *group, u32 event_mask,
> +                               const struct fsnotify_event_info *event_info,
> +                               struct fsnotify_iter_info *iter_info)
>  {
>         __u32 marks_mask = 0, marks_ignored_mask = 0;
>         __u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
>                                      FANOTIFY_EVENT_FLAGS;
> -       const struct path *path = fsnotify_data_path(data, data_type);
> +       const struct path *path = fsnotify_event_info_path(event_info);
>         unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>         struct fsnotify_mark *mark;
>         int type;
>
>         pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
> -                __func__, iter_info->report_mask, event_mask, data, data_type);
> +                __func__, iter_info->report_mask, event_mask,
> +                event_info->data, event_info->data_type);
>
>         if (!fid_mode) {
>                 /* Do we have path to open a file descriptor? */
> @@ -278,7 +279,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>                         return 0;
>         } else if (!(fid_mode & FAN_REPORT_FID)) {
>                 /* Do we have a directory inode to report? */
> -               if (!dir && !(event_mask & FS_ISDIR))
> +               if (!event_info->dir && !(event_mask & FS_ISDIR))
>                         return 0;
>         }
>
> @@ -427,13 +428,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>   * FS_ATTRIB reports the child inode even if reported on a watched parent.
>   * FS_CREATE reports the modified dir inode and not the created inode.
>   */
> -static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
> -                                       int data_type, struct inode *dir)
> +static struct inode *fanotify_fid_inode(u32 event_mask,
> +                               const struct fsnotify_event_info *event_info)
>  {
>         if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
> -               return dir;
> +               return event_info->dir;
>
> -       return fsnotify_data_inode(data, data_type);
> +       return fsnotify_event_info_inode(event_info);
>  }
>
>  /*
> @@ -444,18 +445,18 @@ static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
>   * reported to parent.
>   * Otherwise, do not report dir fid.
>   */
> -static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
> -                                        int data_type, struct inode *dir)
> +static struct inode *fanotify_dfid_inode(u32 event_mask,
> +                               const struct fsnotify_event_info *event_info)
>  {
> -       struct inode *inode = fsnotify_data_inode(data, data_type);
> +       struct inode *inode = fsnotify_event_info_inode(event_info);
>
>         if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
> -               return dir;
> +               return event_info->dir;
>
>         if (S_ISDIR(inode->i_mode))
>                 return inode;
>
> -       return dir;
> +       return event_info->dir;
>  }
>
>  static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
> @@ -563,17 +564,17 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>         return &fne->fae;
>  }
>
> -static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> -                                                  u32 mask, const void *data,
> -                                                  int data_type, struct inode *dir,
> -                                                  const struct qstr *file_name,
> -                                                  __kernel_fsid_t *fsid)
> +static struct fanotify_event *fanotify_alloc_event(
> +                               struct fsnotify_group *group, u32 mask,
> +                               const struct fsnotify_event_info *event_info,
> +                               __kernel_fsid_t *fsid)
>  {
>         struct fanotify_event *event = NULL;
>         gfp_t gfp = GFP_KERNEL_ACCOUNT;
> -       struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
> -       struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
> -       const struct path *path = fsnotify_data_path(data, data_type);
> +       struct inode *id = fanotify_fid_inode(mask, event_info);
> +       struct inode *dirid = fanotify_dfid_inode(mask, event_info);
> +       const struct path *path = fsnotify_event_info_path(event_info);
> +       const struct qstr *file_name = event_info->name;
>         unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>         struct mem_cgroup *old_memcg;
>         struct inode *child = NULL;
> @@ -712,9 +713,7 @@ static void fanotify_insert_event(struct fsnotify_group *group,
>  }
>
>  static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
> -                                const void *data, int data_type,
> -                                struct inode *dir,
> -                                const struct qstr *file_name, u32 cookie,
> +                                const struct fsnotify_event_info *event_info,
>                                  struct fsnotify_iter_info *iter_info)
>  {
>         int ret = 0;
> @@ -744,8 +743,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>
>         BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
>
> -       mask = fanotify_group_event_mask(group, iter_info, mask, data,
> -                                        data_type, dir);
> +       mask = fanotify_group_event_mask(group, mask, event_info, iter_info);
>         if (!mask)
>                 return 0;
>
> @@ -767,8 +765,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>                         return 0;
>         }
>
> -       event = fanotify_alloc_event(group, mask, data, data_type, dir,
> -                                    file_name, &fsid);
> +       event = fanotify_alloc_event(group, mask, event_info, &fsid);
>         ret = -ENOMEM;
>         if (unlikely(!event)) {
>                 /*
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 30d422b8c0fc..36205a769dde 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -177,8 +177,8 @@ static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
>   * Notify only the child without name info if parent is not watching and
>   * inode/sb/mount are not interested in events with parent and name info.
>   */
> -int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> -                     int data_type)
> +int __fsnotify_parent(struct dentry *dentry, __u32 mask,
> +                     const void *data, int data_type)
>  {
>         const struct path *path = fsnotify_data_path(data, data_type);
>         struct mount *mnt = path ? real_mount(path->mnt) : NULL;
> @@ -229,7 +229,11 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>         }
>
>  notify:
> -       ret = fsnotify(mask, data, data_type, p_inode, file_name, inode, 0);
> +       ret = __fsnotify(mask, &(struct fsnotify_event_info) {
> +                               .data = data, .data_type = data_type,
> +                               .dir = p_inode, .name = file_name,
> +                               .inode = inode,
> +                               });
>
>         if (file_name)
>                 release_dentry_name_snapshot(&name);
> @@ -240,13 +244,11 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  EXPORT_SYMBOL_GPL(__fsnotify_parent);
>
>  static int fsnotify_handle_inode_event(struct fsnotify_group *group,
> -                                      struct fsnotify_mark *inode_mark,
> -                                      u32 mask, const void *data, int data_type,
> -                                      struct inode *dir, const struct qstr *name,
> -                                      u32 cookie)
> +                              struct fsnotify_mark *inode_mark, u32 mask,
> +                              const struct fsnotify_event_info *event_info)
>  {
> -       const struct path *path = fsnotify_data_path(data, data_type);
> -       struct inode *inode = fsnotify_data_inode(data, data_type);
> +       const struct path *path = fsnotify_event_info_path(event_info);
> +       struct inode *inode = fsnotify_event_info_inode(event_info);
>         const struct fsnotify_ops *ops = group->ops;
>
>         if (WARN_ON_ONCE(!ops->handle_inode_event))
> @@ -260,16 +262,17 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
>         if (!(mask & inode_mark->mask & ALL_FSNOTIFY_EVENTS))
>                 return 0;
>
> -       return ops->handle_inode_event(inode_mark, mask, inode, dir, name, cookie);
> +       return ops->handle_inode_event(inode_mark, mask, inode, event_info->dir,
> +                                      event_info->name, event_info->cookie);
>  }
>
>  static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> -                                const void *data, int data_type,
> -                                struct inode *dir, const struct qstr *name,
> -                                u32 cookie, struct fsnotify_iter_info *iter_info)
> +                                const struct fsnotify_event_info *event_info,
> +                                struct fsnotify_iter_info *iter_info)
>  {
>         struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
>         struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
> +       struct fsnotify_event_info child_event_info = { };
>         int ret;
>
>         if (WARN_ON_ONCE(fsnotify_iter_sb_mark(iter_info)) ||
> @@ -284,8 +287,8 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>                  * interested in this event?
>                  */
>                 if (parent_mark->mask & FS_EVENT_ON_CHILD) {
> -                       ret = fsnotify_handle_inode_event(group, parent_mark, mask,
> -                                                         data, data_type, dir, name, 0);
> +                       ret = fsnotify_handle_inode_event(group, parent_mark,
> +                                                         mask, event_info);
>                         if (ret)
>                                 return ret;
>                 }
> @@ -302,18 +305,22 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>                  * The child watcher is expecting an event without a file name
>                  * and without the FS_EVENT_ON_CHILD flag.
>                  */
> +               if (WARN_ON_ONCE(!event_info->inode))
> +                       return 0;
> +
>                 mask &= ~FS_EVENT_ON_CHILD;
> -               dir = NULL;
> -               name = NULL;
> +               child_event_info = *event_info;
> +               child_event_info.dir = NULL;
> +               child_event_info.name = NULL;
> +               event_info = &child_event_info;
>         }
>
> -       return fsnotify_handle_inode_event(group, inode_mark, mask, data, data_type,
> -                                          dir, name, cookie);
> +       return fsnotify_handle_inode_event(group, inode_mark, mask, event_info);
>  }
>
> -static int send_to_group(__u32 mask, const void *data, int data_type,
> -                        struct inode *dir, const struct qstr *file_name,
> -                        u32 cookie, struct fsnotify_iter_info *iter_info)
> +static int send_to_group(__u32 mask,
> +                        const struct fsnotify_event_info *event_info,
> +                        struct fsnotify_iter_info *iter_info)
>  {
>         struct fsnotify_group *group = NULL;
>         __u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> @@ -351,18 +358,18 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>
>         pr_debug("%s: group=%p mask=%x marks_mask=%x marks_ignored_mask=%x data=%p data_type=%d dir=%p cookie=%d\n",
>                  __func__, group, mask, marks_mask, marks_ignored_mask,
> -                data, data_type, dir, cookie);
> +                event_info->data, event_info->data_type, event_info->dir,
> +                event_info->cookie);
>
>         if (!(test_mask & marks_mask & ~marks_ignored_mask))
>                 return 0;
>
>         if (group->ops->handle_event) {
> -               return group->ops->handle_event(group, mask, data, data_type, dir,
> -                                               file_name, cookie, iter_info);
> +               return group->ops->handle_event(group, mask, event_info,
> +                                               iter_info);
>         }
>
> -       return fsnotify_handle_event(group, mask, data, data_type, dir,
> -                                    file_name, cookie, iter_info);
> +       return fsnotify_handle_event(group, mask, event_info, iter_info);
>  }
>
>  static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
> @@ -448,21 +455,22 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>   * in whatever means they feel necessary.
>   *
>   * @mask:      event type and flags
> + * Input args in struct fsnotify_event_info:
>   * @data:      object that event happened on
>   * @data_type: type of object for fanotify_data_XXX() accessors
>   * @dir:       optional directory associated with event -
> - *             if @file_name is not NULL, this is the directory that
> - *             @file_name is relative to
> - * @file_name: optional file name associated with event
> + *             if @name is not NULL, this is the directory that
> + *             @name is relative to
> + * @name:      optional file name associated with event
>   * @inode:     optional inode associated with event -
>   *             either @dir or @inode must be non-NULL.
>   *             if both are non-NULL event may be reported to both.
>   * @cookie:    inotify rename cookie
>   */
> -int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> -            const struct qstr *file_name, struct inode *inode, u32 cookie)
> +int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
>  {
> -       const struct path *path = fsnotify_data_path(data, data_type);
> +       const struct path *path = fsnotify_event_info_path(event_info);
> +       struct inode *inode = event_info->inode;
>         struct fsnotify_iter_info iter_info = {};
>         struct super_block *sb;
>         struct mount *mnt = NULL;
> @@ -475,13 +483,13 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>
>         if (!inode) {
>                 /* Dirent event - report on TYPE_INODE to dir */
> -               inode = dir;
> +               inode = event_info->dir;
>         } else if (mask & FS_EVENT_ON_CHILD) {
>                 /*
>                  * Event on child - report on TYPE_PARENT to dir if it is
>                  * watching children and on TYPE_INODE to child.
>                  */
> -               parent = dir;
> +               parent = event_info->dir;
>         }
>         sb = inode->i_sb;
>
> @@ -538,8 +546,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>          * That's why this traversal is so complicated...
>          */
>         while (fsnotify_iter_select_report_types(&iter_info)) {
> -               ret = send_to_group(mask, data, data_type, dir, file_name,
> -                                   cookie, &iter_info);
> +               ret = send_to_group(mask, event_info, &iter_info);
>
>                 if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
>                         goto out;
> @@ -552,7 +559,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(fsnotify);
> +EXPORT_SYMBOL_GPL(__fsnotify);
>
>  static __init int fsnotify_init(void)
>  {
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..8c2c681b4495 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -30,7 +30,10 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
>                                  struct inode *child,
>                                  const struct qstr *name, u32 cookie)
>  {
> -       fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
> +       __fsnotify(mask, &(struct fsnotify_event_info) {
> +                       .data = child, .data_type = FSNOTIFY_EVENT_INODE,
> +                       .dir = dir, .name = name, .cookie = cookie,
> +                       });
>  }
>
>  static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
> @@ -44,7 +47,10 @@ static inline void fsnotify_inode(struct inode *inode, __u32 mask)
>         if (S_ISDIR(inode->i_mode))
>                 mask |= FS_ISDIR;
>
> -       fsnotify(mask, inode, FSNOTIFY_EVENT_INODE, NULL, NULL, inode, 0);
> +       __fsnotify(mask, &(struct fsnotify_event_info) {
> +                       .data = inode, .data_type = FSNOTIFY_EVENT_INODE,
> +                       .inode = inode,
> +                       });
>  }
>
>  /* Notify this dentry's parent about a child's events. */
> @@ -68,7 +74,10 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>         return __fsnotify_parent(dentry, mask, data, data_type);
>
>  notify_child:
> -       return fsnotify(mask, data, data_type, NULL, NULL, inode, 0);
> +       return __fsnotify(mask, &(struct fsnotify_event_info) {
> +                               .data = data, .data_type = data_type,
> +                               .inode = inode,
> +                               });
>  }
>
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index f9e2c6cd0f7d..b1590f654ade 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -112,6 +112,28 @@ struct fsnotify_iter_info;
>
>  struct mem_cgroup;
>
> +/*
> + * Event info args passed to fsnotify() and to backends on handle_event():
> + * @data:      object that event happened on
> + * @data_type: type of object for fanotify_data_XXX() accessors
> + * @dir:       optional directory associated with event -
> + *             if @name is not NULL, this is the directory that
> + *             @name is relative to
> + * @name:      optional file name associated with event
> + * @inode:     optional inode associated with event -
> + *             either @dir or @inode must be non-NULL.
> + *             if both are non-NULL event may be reported to both.
> + * @cookie:    inotify rename cookie
> + */
> +struct fsnotify_event_info {
> +       const void *data;
> +       int data_type;
> +       struct inode *dir;
> +       const struct qstr *name;
> +       struct inode *inode;
> +       u32 cookie;
> +};
> +
>  /*
>   * Each group much define these ops.  The fsnotify infrastructure will call
>   * these operations for each relevant group.
> @@ -119,13 +141,7 @@ struct mem_cgroup;
>   * handle_event - main call for a group to handle an fs event
>   * @group:     group to notify
>   * @mask:      event type and flags
> - * @data:      object that event happened on
> - * @data_type: type of object for fanotify_data_XXX() accessors
> - * @dir:       optional directory associated with event -
> - *             if @file_name is not NULL, this is the directory that
> - *             @file_name is relative to
> - * @file_name: optional file name associated with event
> - * @cookie:    inotify rename cookie
> + * @event_info: information attached to the event
>   * @iter_info: array of marks from this group that are interested in the event
>   *
>   * handle_inode_event - simple variant of handle_event() for groups that only
> @@ -147,8 +163,7 @@ struct mem_cgroup;
>   */
>  struct fsnotify_ops {
>         int (*handle_event)(struct fsnotify_group *group, u32 mask,
> -                           const void *data, int data_type, struct inode *dir,
> -                           const struct qstr *file_name, u32 cookie,
> +                           const struct fsnotify_event_info *event_info,
>                             struct fsnotify_iter_info *iter_info);
>         int (*handle_inode_event)(struct fsnotify_mark *mark, u32 mask,
>                             struct inode *inode, struct inode *dir,
> @@ -262,6 +277,12 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>         }
>  }
>
> +static inline struct inode *fsnotify_event_info_inode(
> +                               const struct fsnotify_event_info *event_info)
> +{
> +       return fsnotify_data_inode(event_info->data, event_info->data_type);
> +}
> +
>  static inline const struct path *fsnotify_data_path(const void *data,
>                                                     int data_type)
>  {
> @@ -273,6 +294,12 @@ static inline const struct path *fsnotify_data_path(const void *data,
>         }
>  }
>
> +static inline const struct path *fsnotify_event_info_path(
> +                               const struct fsnotify_event_info *event_info)
> +{
> +       return fsnotify_data_path(event_info->data, event_info->data_type);
> +}
> +
>  enum fsnotify_obj_type {
>         FSNOTIFY_OBJ_TYPE_INODE,
>         FSNOTIFY_OBJ_TYPE_PARENT,
> @@ -410,11 +437,22 @@ struct fsnotify_mark {
>  /* called from the vfs helpers */
>
>  /* main fsnotify call to send events */
> -extern int fsnotify(__u32 mask, const void *data, int data_type,
> -                   struct inode *dir, const struct qstr *name,
> -                   struct inode *inode, u32 cookie);
> -extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> -                          int data_type);
> +extern int __fsnotify(__u32 mask,
> +                     const struct fsnotify_event_info *event_info);
> +extern int __fsnotify_parent(struct dentry *dentry, __u32 mask,
> +                            const void *data, int data_type);
> +
> +static inline int fsnotify(__u32 mask, const void *data, int data_type,
> +                          struct inode *dir, const struct qstr *name,
> +                          struct inode *inode, u32 cookie)
> +{
> +       return __fsnotify(mask, &(struct fsnotify_event_info) {
> +                               .data = data, .data_type = data_type,
> +                               .dir = dir, .name = name, .inode = inode,
> +                               .cookie = cookie,
> +                               });
> +}
> +
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
> @@ -594,15 +632,14 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
>
>  #else
>
> -static inline int fsnotify(__u32 mask, const void *data, int data_type,
> -                          struct inode *dir, const struct qstr *name,
> -                          struct inode *inode, u32 cookie)
> +static inline int fsnotify(__u32 mask,
> +                          const struct fsnotify_event_info *event_info)
>  {
>         return 0;
>  }
>

Did you miss the kernel test robot messages on v2?
These noop implementations in my patch are wrong.
noop implementation of fsnotify() should not change signature
and noop implementation of __fsnotify() should be added.

Thanks,
Amir.


>  static inline int __fsnotify_parent(struct dentry *dentry, __u32 mask,
> -                                 const void *data, int data_type)
> +                                   const void *data, int data_type)
>  {
>         return 0;
>  }
> --
> 2.32.0
>
