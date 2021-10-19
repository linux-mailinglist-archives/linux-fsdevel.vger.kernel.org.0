Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E49432D77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhJSFzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSFzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:55:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B1C06161C;
        Mon, 18 Oct 2021 22:52:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so6922507ilo.7;
        Mon, 18 Oct 2021 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7Os6X7/r21pXpIsxTkGiN0sAW85QcFvdx7kW8FSqXg=;
        b=d4x2D5iMi1HOp9dv9I0Wpx1EEsfeqhJjYw4OZOVLc4Bujol8aMKSSiuQdn0VFLLSma
         xoBBecCPDxDeu29sRet/WNqRncjXRGwdOV5RVFo3IvTKY+b4q7G4A85OTRXdyS4YevmO
         dsr9Dq6jquozRwF8GV7E4gqpwxESk6pE64Aqx6/caIwj3Z+KTL0bbxG8p+IrMg89HDx5
         mzDqns3AvcqA/Rji5LFFHEnH3MwygFOCAZRkxiv0CpD97Ya1ASFzNZm3xRJXy4aeLu+E
         V/DsAy0Z9nR2q3vAERI7wInmSMafFV5MEsWcfFP4bAX0J8CHLnBqaCSzrVNqOeXHVMw3
         appg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7Os6X7/r21pXpIsxTkGiN0sAW85QcFvdx7kW8FSqXg=;
        b=J99jbttW0IauN08HxnAqIAEICviRyXhe7Qk2rG9rkaOsXq1EKMNBB88HL1OfIgmnE2
         izIHDYBzC9hq5NcnEHNaVw30I6N2t1fhVWRKS3GHgV0ZklNfzhbUVPLBBTWwfAn3U0md
         BLRqmC+LX+fihrtcufQ5h23mbc5U0QF4YhmuXmwpbzEqiYgz4VYMVKukMhDMyos2AfwY
         1r9a1nTsqa0is1A+W6AsgRdD7QJ5VNti8tAEdo/YYRTyPzZi+MxcssunV7zz7afmB9x4
         mIfOw4zrWEst/OLoa7kSDWLk8+NStNyl4vqyZK4v46KTSh+JU7SgWyzw0GDKC+DXSdU/
         UVKA==
X-Gm-Message-State: AOAM533L8swB0lW5N0bsX6dIo6xark+GzoTLDVleXapz3B2O9uU2+aJ9
        Y/lQ9qPE307BgqcyGc7wIzjYXoDKuEQX+ynaqII=
X-Google-Smtp-Source: ABdhPJwj6dsoL4P5XEZ3cRQkGJa56Xqwk6viuhO10zrAFaYa7Go6L67xBLRiJzrAwU4gGIi6UJaAQaVe6FyQ9g/whEM=
X-Received: by 2002:a05:6e02:1b04:: with SMTP id i4mr17480955ilv.319.1634622769866;
 Mon, 18 Oct 2021 22:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-22-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-22-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 08:52:38 +0300
Message-ID: <CAOQ4uxhhJou6yytuRZsBX5nDn-em4PTam=p+LqfZLs=QeMc1-w@mail.gmail.com>
Subject: Re: [PATCH v8 21/32] fanotify: Support enqueueing of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Once an error event is triggered, enqueue it in the notification group,
> similarly to what is done for other events.  FAN_FS_ERROR is not
> handled specially, since the memory is now handled by a preallocated
> mempool.
>
> For now, make the event unhashed.  A future patch implements merging of
> this kind of event.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v7:
>   - WARN_ON -> WARN_ON_ONCE (Amir)
> ---
>  fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify.h |  6 ++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 01d68dfc74aa..1f195c95dfcd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -574,6 +574,27 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>         return &fne->fae;
>  }
>
> +static struct fanotify_event *fanotify_alloc_error_event(
> +                                               struct fsnotify_group *group,
> +                                               __kernel_fsid_t *fsid,
> +                                               const void *data, int data_type)
> +{
> +       struct fs_error_report *report =
> +                       fsnotify_data_error_report(data, data_type);
> +       struct fanotify_error_event *fee;
> +
> +       if (WARN_ON_ONCE(!report))
> +               return NULL;
> +
> +       fee = mempool_alloc(&group->fanotify_data.error_events_pool, GFP_NOFS);
> +       if (!fee)
> +               return NULL;
> +
> +       fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +
> +       return &fee->fae;
> +}
> +
>  static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>                                                    u32 mask, const void *data,
>                                                    int data_type, struct inode *dir,
> @@ -641,6 +662,9 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>
>         if (fanotify_is_perm_event(mask)) {
>                 event = fanotify_alloc_perm_event(path, gfp);
> +       } else if (fanotify_is_error_event(mask)) {
> +               event = fanotify_alloc_error_event(group, fsid, data,
> +                                                  data_type);
>         } else if (name_event && (file_name || child)) {
>                 event = fanotify_alloc_name_event(id, fsid, file_name, child,
>                                                   &hash, gfp);
> @@ -850,6 +874,14 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>         kfree(FANOTIFY_NE(event));
>  }
>
> +static void fanotify_free_error_event(struct fsnotify_group *group,
> +                                     struct fanotify_event *event)
> +{
> +       struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +       mempool_free(fee, &group->fanotify_data.error_events_pool);
> +}
> +
>  static void fanotify_free_event(struct fsnotify_group *group,
>                                 struct fsnotify_event *fsn_event)
>  {
> @@ -873,6 +905,9 @@ static void fanotify_free_event(struct fsnotify_group *group,
>         case FANOTIFY_EVENT_TYPE_OVERFLOW:
>                 kfree(event);
>                 break;
> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +               fanotify_free_error_event(group, event);
> +               break;
>         default:
>                 WARN_ON_ONCE(1);
>         }
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index a577e87fac2b..ebef952481fa 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -298,6 +298,11 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
>         return container_of(fse, struct fanotify_event, fse);
>  }
>
> +static inline bool fanotify_is_error_event(u32 mask)
> +{
> +       return mask & FAN_FS_ERROR;
> +}
> +
>  static inline bool fanotify_event_has_path(struct fanotify_event *event)
>  {
>         return event->type == FANOTIFY_EVENT_TYPE_PATH ||
> @@ -327,6 +332,7 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
>         return !(fanotify_is_perm_event(mask) ||
> +                fanotify_is_error_event(mask) ||
>                  fsnotify_is_overflow_event(mask));
>  }
>
> --
> 2.33.0
>
