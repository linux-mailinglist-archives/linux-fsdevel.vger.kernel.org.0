Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641B13EB2BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhHMIlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbhHMIlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:41:08 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B128C061756;
        Fri, 13 Aug 2021 01:40:42 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id f15so6040020ilk.4;
        Fri, 13 Aug 2021 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//14LGuNLlUtJO8ZuTsuudem0p3ym1bzgNa9Q4lrwv4=;
        b=gCXCIgMEKrMj+covUc+7TMS6TQ02ugY21ERYSh4ktwWWkAhFgj9GHVNwaPcMeM/jKW
         mGCl9ncsuuiUpadGYkbCV8WdcmpZ4MRGh2ERx2W8zp3rHMM55Umyz9rlQsoV8mnzJMF8
         +zlx0WuyHBg7obpWJpkAwQbYz9FjSngdK4sIpBJ/gAUZIebdeLhwiBjZjXhUZwMJualO
         kvQRUZozUJYSgglLOxRWhCxYnU3T+ROAlx4pYjtQ5V7zs9AV2KCfhlK+zJM8sSFAAvfJ
         70MBWlREdUagSL9t0d94fdi5PyaBLaS891K1TuTZExh83Q4B+6Eck2nyj2Srvo/TND4h
         MjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//14LGuNLlUtJO8ZuTsuudem0p3ym1bzgNa9Q4lrwv4=;
        b=t7kBV9DWNEtfPcT37zdq2fNjwRugQSCuUAw/4mpGveH7kkS4BZ6oRJkcOvKk5LPJme
         0kNeklM8MiS6xxWJZSUkS8rBiBLWRXc+OypA3JmX8Ut1jGtrfE5wqMC6CthkQ1Mfnnok
         oMXNphwayJ1bzRLEQUEK2koNZ+CrZ6Ir2S4YjBuUgYNI74Zk31/8h83jpa80rMATJRl8
         oxSaqY7j98dr+HOXRytfp+jfWsSALFj4B9DzdxR45qRuNT0vTRcwIqe1HDfSMhyUneN2
         ro5uIymYdZjEWwWMhlEGert9iwlK4NjjEc3BojMHbeUfrb4qDEY2ScLSuPGjWZD6XJEx
         AeTA==
X-Gm-Message-State: AOAM531bzdPokzUVk3X+6JxkXsQr4kzrzewX4MylK3Y49vNW5Lh9DCEr
        0oMjQo4S6EKFVjdicUDJzW7Ize6VbVjAdyIgeeA=
X-Google-Smtp-Source: ABdhPJwazYPentWqY5uT39FGKeuVIVBot/7WzWF67MCvCdwahcFZ/1/ZLfbDDPMlRpW2oQ1M+7At1VGzN00c15I/LMk=
X-Received: by 2002:a92:c0ce:: with SMTP id t14mr1039665ilf.72.1628844041615;
 Fri, 13 Aug 2021 01:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-16-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-16-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 11:40:30 +0300
Message-ID: <CAOQ4uxhAhmWTieCx0BJKde14gwJJe6DH-Xv2wg7On5Ley99Hqg@mail.gmail.com>
Subject: Re: [PATCH v6 15/21] fanotify: Preallocate per superblock mark error event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Error reporting needs to be done in an atomic context.  This patch
> introduces a single error slot for superblock marks that report the
> FAN_FS_ERROR event, to be used during event submission.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes v5:
>   - Restore mark references. (jan)
>   - Tie fee slot to the mark lifetime.(jan)
>   - Don't reallocate event(jan)
> ---
>  fs/notify/fanotify/fanotify.c      | 12 ++++++++++++
>  fs/notify/fanotify/fanotify.h      | 13 +++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 31 ++++++++++++++++++++++++++++--
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index ebb6c557cea1..3bf6fd85c634 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -855,6 +855,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>         kfree(FANOTIFY_NE(event));
>  }
>
> +static void fanotify_free_error_event(struct fanotify_event *event)
> +{
> +       /*
> +        * The actual event is tied to a mark, and is released on mark
> +        * removal
> +        */
> +}
> +
>  static void fanotify_free_event(struct fsnotify_event *fsn_event)
>  {
>         struct fanotify_event *event;
> @@ -877,6 +885,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
>         case FANOTIFY_EVENT_TYPE_OVERFLOW:
>                 kfree(event);
>                 break;
> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +               fanotify_free_error_event(event);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -894,6 +905,7 @@ static void fanotify_free_mark(struct fsnotify_mark *mark)
>         if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
>                 struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
>
> +               kfree(fa_mark->fee_slot);
>                 kmem_cache_free(fanotify_sb_mark_cache, fa_mark);
>         } else {
>                 kmem_cache_free(fanotify_mark_cache, mark);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index b3ab620822c2..3f03333df32f 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -139,6 +139,7 @@ enum fanotify_mark_bits {
>
>  struct fanotify_sb_mark {
>         struct fsnotify_mark fsn_mark;
> +       struct fanotify_error_event *fee_slot;
>  };
>
>  static inline
> @@ -161,6 +162,7 @@ enum fanotify_event_type {
>         FANOTIFY_EVENT_TYPE_PATH,
>         FANOTIFY_EVENT_TYPE_PATH_PERM,
>         FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
> +       FANOTIFY_EVENT_TYPE_FS_ERROR, /* struct fanotify_error_event */
>         __FANOTIFY_EVENT_TYPE_NUM
>  };
>
> @@ -216,6 +218,17 @@ FANOTIFY_NE(struct fanotify_event *event)
>         return container_of(event, struct fanotify_name_event, fae);
>  }
>
> +struct fanotify_error_event {
> +       struct fanotify_event fae;
> +       struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
> +};
> +
> +static inline struct fanotify_error_event *
> +FANOTIFY_EE(struct fanotify_event *event)
> +{
> +       return container_of(event, struct fanotify_error_event, fae);
> +}
> +
>  static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
>  {
>         if (event->type == FANOTIFY_EVENT_TYPE_FID)
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 54107f1533d5..b77030386d7f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -947,8 +947,10 @@ static struct fsnotify_mark *fanotify_alloc_mark(struct fsnotify_group *group,
>
>         fsnotify_init_mark(mark, group);
>
> -       if (type == FSNOTIFY_OBJ_TYPE_SB)
> +       if (type == FSNOTIFY_OBJ_TYPE_SB) {
>                 mark->flags |= FANOTIFY_MARK_FLAG_SB_MARK;
> +               sb_mark->fee_slot = NULL;
> +       }
>
>         return mark;
>  }
> @@ -999,6 +1001,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         __u32 added;
> +       int ret = 0;
>
>         mutex_lock(&group->mark_mutex);
>         fsn_mark = fsnotify_find_mark(connp, group);
> @@ -1009,13 +1012,37 @@ static int fanotify_add_mark(struct fsnotify_group *group,
>                         return PTR_ERR(fsn_mark);
>                 }
>         }
> +
> +       /*
> +        * Error events are allocated per super-block mark only if
> +        * strictly needed (i.e. FAN_FS_ERROR was requested).
> +        */
> +       if (type == FSNOTIFY_OBJ_TYPE_SB && !(flags & FAN_MARK_IGNORED_MASK) &&
> +           (mask & FAN_FS_ERROR)) {
> +               struct fanotify_sb_mark *sb_mark = FANOTIFY_SB_MARK(fsn_mark);
> +
> +               if (!sb_mark->fee_slot) {
> +                       struct fanotify_error_event *fee =
> +                               kzalloc(sizeof(*fee), GFP_KERNEL_ACCOUNT);
> +                       if (!fee) {
> +                               ret = -ENOMEM;
> +                               goto out;
> +                       }
> +                       fanotify_init_event(&fee->fae, 0, FS_ERROR);
> +                       fee->sb_mark = sb_mark;

I think Jan wanted to avoid zalloc()?
Please use kmalloc() and init the rest of the fee-> members.
We do not need to fill the entire fh buf with zeroes.

Thanks,
Amir.
