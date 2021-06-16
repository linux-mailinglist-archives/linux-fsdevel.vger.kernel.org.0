Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6193A95D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhFPJTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhFPJTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:19:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4EC061574;
        Wed, 16 Jun 2021 02:16:58 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l64so2264742ioa.7;
        Wed, 16 Jun 2021 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rTXKe+/+AwyeRd04+g9hJ6S6IvvnCkcBshN5TKiCsMc=;
        b=dlXc5LiPMg3i3EPzPUYsNxgfGoPvRsrXpDz9MtR6sxJd3pGHNUltppVC4lTA/IbbeV
         VO1RvXgP5ZWEV9+jrEnF1Txlw5bR7n74Upt3REStISiR0EyygBIGD9sfG/Zptjz08LG+
         BWRYCeodc+WltJMZ54nopfG9OI82uBP1bX8p73Wnu+RjY4sUAY+JYijIoHv+8OvbTXfS
         dWNRIa4acyg/0XTd8SRlzFV2SGXwLbB1eRLdyY79E1d6lwSYiYrfbNaqPQM7oMuh/yA2
         Llqz6zgy2xhCId7QilZ1GxAshpR7VhsMFAweJP9ccq7YEyEyhCzHmWcTfwwfePJ6mWde
         y1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTXKe+/+AwyeRd04+g9hJ6S6IvvnCkcBshN5TKiCsMc=;
        b=G7pLKPXrRlgX+JMfiI6avbZcnK5/SF2iR6S6HeVarwDubRadhVm9hDi4U5Lr9/2m4t
         JKca1Ir6uxur3rggW03yjIGPxs9upY6tqgR7juCzHcD5YPft3RVBWYLo0sRrCgb+68PJ
         QXb1DZIztjHbRdSRljjWwHjclVGwJLvSOWZ/xuDJYcwNGGu/1zMw1ExIgjVbzjkjrGnD
         9/X43kabEinYBpswTXZ2drzIPZ+tFNppxk026LcNgZznVnG1dsFLSeQGUDaxkzlGeykW
         EVLfhun67Yy7qKYMNY5GPjgIpRZk9d4TESQ4Jhu5prM1vyn+dR/VzecTGzd3bf21ypZx
         V8aQ==
X-Gm-Message-State: AOAM533T1lSy5x4fef8eP9WX8tZQYCHOP6Wp01nl0kWodHbqhiYbXCxv
        Vc3fSk+pFGLcgNyYKvBRlUEM7sDrIAMvJHsyker52lr5
X-Google-Smtp-Source: ABdhPJwvVWVRDWXBz+9GIoB6VMggmZasTq88IRV/ZGmvgmU/pQMpQok5KkARlzogSND2aE1QbgX9GeRofRj/KvOfCkw=
X-Received: by 2002:a02:908a:: with SMTP id x10mr3249639jaf.30.1623835017518;
 Wed, 16 Jun 2021 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210615235556.970928-1-krisman@collabora.com> <20210615235556.970928-5-krisman@collabora.com>
In-Reply-To: <20210615235556.970928-5-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 12:16:46 +0300
Message-ID: <CAOQ4uxh0FYZnFH3sGcStYTHQdbzBcVP_FYaYD_NQ7Hg-dBs6KA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] fanotify: Split superblock marks out to a new cache
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:56 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_ERROR will require an error structure to be stored per mark.  But,

FAN_FS_ERROR

> since FAN_ERROR doesn't apply to inode/mount marks, it should suffice to
> only expose this information for superblock marks. Therefore, wrap this
> kind of marks into a container and plumb it for the future.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v1:
>   - Only extend superblock marks
> ---
>  fs/notify/fanotify/fanotify.c      | 10 ++++++++--
>  fs/notify/fanotify/fanotify.h      | 11 +++++++++++
>  fs/notify/fanotify/fanotify_user.c | 29 ++++++++++++++++++++++++++++-
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 057abd2cf887..f85efb24cfb4 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -867,9 +867,15 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
>                 dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
>  }
>
> -static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
> +static void fanotify_free_mark(struct fsnotify_mark *mark)
>  {
> -       kmem_cache_free(fanotify_mark_cache, fsn_mark);
> +       if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
> +               struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
> +
> +               kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
> +       } else {
> +               kmem_cache_free(fanotify_mark_cache, mark);
> +       }
>  }
>
>  const struct fsnotify_ops fanotify_fsnotify_ops = {
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 4a5e555dc3d2..aec05e21d5a9 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -6,6 +6,7 @@
>  #include <linux/hashtable.h>
>
>  extern struct kmem_cache *fanotify_mark_cache;
> +extern struct kmem_cache *fanotify_sb_mark_cache;
>  extern struct kmem_cache *fanotify_fid_event_cachep;
>  extern struct kmem_cache *fanotify_path_event_cachep;
>  extern struct kmem_cache *fanotify_perm_event_cachep;
> @@ -129,6 +130,16 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>                name->name);
>  }
>
> +struct fanotify_sb_mark {
> +       struct fsnotify_mark fsn_mark;
> +};
> +
> +static inline
> +struct fanotify_sb_mark *FANOTIFY_SB_MARK(struct fsnotify_mark *mark)
> +{
> +       return container_of(mark, struct fanotify_sb_mark, fsn_mark);
> +}
> +
>  /*
>   * Common structure for fanotify events. Concrete structs are allocated in
>   * fanotify_handle_event() and freed when the information is retrieved by
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index af518790a80f..db378480f1b1 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -99,6 +99,7 @@ struct ctl_table fanotify_table[] = {
>  extern const struct fsnotify_ops fanotify_fsnotify_ops;
>
>  struct kmem_cache *fanotify_mark_cache __read_mostly;
> +struct kmem_cache *fanotify_sb_mark_cache __read_mostly;
>  struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_path_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
> @@ -915,6 +916,27 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>         return mask & ~oldmask;
>  }
>
> +static struct fsnotify_mark *fanotify_alloc_mark(unsigned int type)
> +{
> +       struct fanotify_sb_mark *sb_mark;
> +
> +       switch (type) {
> +       case FSNOTIFY_OBJ_TYPE_SB:
> +               sb_mark = kmem_cache_zalloc(fanotify_sb_mark_cache, GFP_KERNEL);
> +               if (!sb_mark)
> +                       return NULL;
> +               return &sb_mark->fsn_mark;
> +
> +       case FSNOTIFY_OBJ_TYPE_INODE:
> +       case FSNOTIFY_OBJ_TYPE_PARENT:
> +       case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +               return kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +       default:
> +               WARN_ON(1);
> +               return NULL;
> +       }
> +}
> +
>  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>                                                    fsnotify_connp_t *connp,
>                                                    unsigned int type,
> @@ -933,13 +955,16 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>             !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>                 return ERR_PTR(-ENOSPC);
>
> -       mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +       mark = fanotify_alloc_mark(type);
>         if (!mark) {
>                 ret = -ENOMEM;
>                 goto out_dec_ucounts;
>         }
>
>         fsnotify_init_mark(mark, group);
> +       if (type == FSNOTIFY_OBJ_TYPE_SB)
> +               mark->flags |= FSNOTIFY_MARK_FLAG_SB;
> +

Please make sure to set the flag inside fanotify_alloc_mark() similar to
how fanotify_alloc_*_event() set the event type that is checked
in fanotify_free_event().

It mean passing group to fanotify_alloc_mark() and calling
fsnotify_init_mark() inside fanotify_alloc_mark().

Thanks,
Amir.
