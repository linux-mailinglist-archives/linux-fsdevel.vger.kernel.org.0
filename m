Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8183B7C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhF3DUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhF3DUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:20:08 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D6C061760;
        Tue, 29 Jun 2021 20:17:39 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a11so1482161ilf.2;
        Tue, 29 Jun 2021 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VDtq/ZVfw/EYu5s+56EaR7QuoOQ3YG39vfVqpGHWaI=;
        b=be80ratPp3Yr7jpvjmG0cmbY21v2umg/6mldkg+6+BJNBFVERYme6puOOFBiyY8bfw
         FC0zn20TEd5KYWLLZaDEVRNHOECraEXs9tfOo2DyawcRZQVZVlar93zFDYlRInS/JHHB
         uj8PbwCpkhp7LoA5I+qTDxTOgOVrfCwcp4u9LsCrWg4mfgKbaCi9vq/eI2HseU1tEoHL
         Y8wg+S9EsLwhxsa+D4FLeoEnonH4cNccKOF1VK8I9KASZM9e8Ujnj3InLF+rdd+V65tL
         kmSW7tSJrypahB4euptTFDbzFVVRKhs+KW4ewFo2EADue1p2IogHS7KIs2Eh8/Q5t7x3
         YWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VDtq/ZVfw/EYu5s+56EaR7QuoOQ3YG39vfVqpGHWaI=;
        b=ccLZp3PDVdqiGMXTJwoAj8Wz6hW4XVFLSnP+fekOFWc0AYIzLtE6QZDTpIwVoUJFWl
         UEqHMDXpZtoRNjxAbn0lTvq1nJvfFwhZ9o08MRqfT590hs8SJVG+jMgE50M4qSAmESxy
         d1QPWy3qMEZWEY26GXz740IiUvsiy7x9en3DlQ1CJRY2dH33MH/2pkhQlTQbnfHiYWMm
         s/EieNcgHJXglQ5YFo+74rdVbYm0o86cEvVVEhINbhFzG1FWX4xHoLWBXDSRl6+T3y1w
         K9NJUj2ODhKLlwWtIM/cK3Eic4csidDmJl2VFum/mXoym0WdR7CpJSb3wzxAE+XUvYDv
         Yg1w==
X-Gm-Message-State: AOAM531dvn4UnaUEijlZbdaEbX69MMoxJJnBxtQ6PZ5qrwlRvKs9FMuE
        9CWlrsV7tp4fjJ+CTQ1bdup8n+PQ4LlAIt/ZAM8=
X-Google-Smtp-Source: ABdhPJwUvOjzD0ac9dzl8ojYk6WbZlqF0JVIeEB+Yia7a+EW8E3rzJTukDLZhp/TXId75StFE8YR0z6P4s1TZb1kd2g=
X-Received: by 2002:a92:dd05:: with SMTP id n5mr13808641ilm.72.1625023058592;
 Tue, 29 Jun 2021 20:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-5-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-5-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:17:27 +0300
Message-ID: <CAOQ4uxgNzHAhLKh5eOO5aDgCr5zirDrdh_a0H1i4ZrxtzJgqTQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] fanotify: Split superblock marks out to a new cache
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

On Tue, Jun 29, 2021 at 10:12 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_ERROR will require an error structure to be stored per mark.  But,
> since FAN_ERROR doesn't apply to inode/mount marks, it should suffice to
FAN_FS_ERROR

> only expose this information for superblock marks. Therefore, wrap this
> kind of marks into a container and plumb it for the future.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

With typo fixes:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v2:
>   - Move mark initialization to fanotify_alloc_mark (Amir)
>
> Changes since v1:
>   - Only extend superblock marks (Amir)
> ---
>  fs/notify/fanotify/fanotify.c      | 10 ++++++--
>  fs/notify/fanotify/fanotify.h      | 13 ++++++++++
>  fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++--
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 310246f8d3f1..0f760770d4c9 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -869,9 +869,15 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
>                 dec_ucount(group->fanotify_data.ucounts, UCOUNT_FANOTIFY_MARKS);
>  }
>
> -static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
> +static void fanotify_free_mark(struct fsnotify_mark *mark)
>  {
> -       kmem_cache_free(fanotify_mark_cache, fsn_mark);
> +       if (mark->flags & FSNOTIFY_MARK_FLAG_SB) {
> +               struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);

I guess you meant sb_mark?

> +
> +               kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
> +       } else {
> +               kmem_cache_free(fanotify_mark_cache, mark);
> +       }
>  }
>
>  const struct fsnotify_ops fanotify_fsnotify_ops = {
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 4a5e555dc3d2..fd125a949187 100644
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
> @@ -129,6 +130,18 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
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
> +       WARN_ON(!(mark->flags & FSNOTIFY_MARK_FLAG_SB));
> +
> +       return container_of(mark, struct fanotify_sb_mark, fsn_mark);
> +}
> +
>  /*
>   * Common structure for fanotify events. Concrete structs are allocated in
>   * fanotify_handle_event() and freed when the information is retrieved by
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 67b18dfe0025..a42521e140e6 100644
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
> @@ -915,6 +916,38 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>         return mask & ~oldmask;
>  }
>
> +static struct fsnotify_mark *fanotify_alloc_mark(struct fsnotify_group *group,
> +                                                unsigned int type)
> +{
> +       struct fanotify_sb_mark *sb_mark;
> +       struct fsnotify_mark *mark;
> +
> +       switch (type) {
> +       case FSNOTIFY_OBJ_TYPE_SB:
> +               sb_mark = kmem_cache_zalloc(fanotify_sb_mark_cache, GFP_KERNEL);
> +               if (!sb_mark)
> +                       return NULL;
> +               mark = &sb_mark->fsn_mark;
> +               break;
> +
> +       case FSNOTIFY_OBJ_TYPE_INODE:
> +       case FSNOTIFY_OBJ_TYPE_PARENT:
> +       case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +               mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +               break;
> +       default:
> +               WARN_ON(1);
> +               return NULL;
> +       }
> +
> +       fsnotify_init_mark(mark, group);
> +
> +       if (type == FSNOTIFY_OBJ_TYPE_SB)
> +               mark->flags |= FSNOTIFY_MARK_FLAG_SB;
> +
> +       return mark;
> +}
> +
>  static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>                                                    fsnotify_connp_t *connp,
>                                                    unsigned int type,
> @@ -933,13 +966,12 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>             !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>                 return ERR_PTR(-ENOSPC);
>
> -       mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +       mark = fanotify_alloc_mark(group, type);
>         if (!mark) {
>                 ret = -ENOMEM;
>                 goto out_dec_ucounts;
>         }
>
> -       fsnotify_init_mark(mark, group);
>         ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
>         if (ret) {
>                 fsnotify_put_mark(mark);
> @@ -1497,6 +1529,8 @@ static int __init fanotify_user_setup(void)
>
>         fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
>                                          SLAB_PANIC|SLAB_ACCOUNT);
> +       fanotify_sb_mark_cache = KMEM_CACHE(fanotify_sb_mark,
> +                                           SLAB_PANIC|SLAB_ACCOUNT);
>         fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
>                                                SLAB_PANIC);
>         fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..c4473b467c28 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -401,6 +401,7 @@ struct fsnotify_mark {
>  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY 0x01
>  #define FSNOTIFY_MARK_FLAG_ALIVE               0x02
>  #define FSNOTIFY_MARK_FLAG_ATTACHED            0x04
> +#define FSNOTIFY_MARK_FLAG_SB                  0x08
>         unsigned int flags;             /* flags [mark->lock] */
>  };
>
> --
> 2.32.0
>
