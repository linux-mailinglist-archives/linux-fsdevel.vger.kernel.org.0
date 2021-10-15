Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA05F42E9B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhJOHLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 03:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhJOHLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:11:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B863BC061570;
        Fri, 15 Oct 2021 00:09:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p68so6646100iof.6;
        Fri, 15 Oct 2021 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrIa+Gd3PwJbclpIccvv2Hu6x+1iM7XaOA+wnikUz4k=;
        b=GB0ViLGCKKZ8XqLvvB3aCn7HHyqBi3csOxb7UEX9hIV3JzpONmziagWgpFo3+gQXDG
         uVLLOBPkd7bC8SKdS3Yr2F/v8AmNtOIwz+h7XyJOZ98pIW2EeUxuSv1xAzYLUk7j2GxJ
         GFbCbbyOX3+YlWTQ8wonap5xYdXcZNYHXYgH3VO02HgdPR8Z8IMMp1XgXD3xRnDAMVqZ
         rtdtVKa9+sOHv+SUJggHXFXIgnWvzTKkYse/W0kpgMV3P/JACAQmYIwAG74XtqCG9Xck
         2H1bJAdN9o2j4pKYgo0pVHmIvCkfVYgVawq7AKdmfLVHit1y7/l1p/Qs91Z/12D91h3r
         3HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrIa+Gd3PwJbclpIccvv2Hu6x+1iM7XaOA+wnikUz4k=;
        b=0TaTxJnejRRklAPG2WMRdxuKDo0fqI8jZYuFfrgx26Kk35gutro4kbe+dezX/XUMBl
         jftZERXW0q36K59bMCSVqisQPRo0G6JeDs2rj7iMbIFJN+T+U/zvs3MM/sdEO4QlPeYQ
         oYd6Ymj2UI+upQiEruwj+ilvoPBDQ9aUMsPOT3VWyWwN26XPoBqURuQNRpnyVsfuvoq6
         s89xDykpIKpIQcWyIBRZKqoAj72FQFXMsSQs8NVVUiW/rDiDTgfRrPQZwx6fisAXLkTt
         Sv3KqkWDLRTL6ttAFgDL/U/VJtRFSceX10gb1860Zaubomc7xhapYMt+jeL+/82nEbvf
         /evQ==
X-Gm-Message-State: AOAM532epjL7/8xvr+FwgaUKx+ZqPYLkIZZxbc9kvOnWLxQXXz4nGobF
        1cd2LoVwOSbm7auDfpRaXy9p7ywD+iJ8VdugABHPdXVq
X-Google-Smtp-Source: ABdhPJyQnAPj+NxWHv8MS1W1L3bVJ02N0E5aBjYl4HKRuUCpVVD6PHSR6gZayxu4elyqVHOWLxwhyWCD44UB+d9UmNA=
X-Received: by 2002:a5e:c018:: with SMTP id u24mr2551476iol.197.1634281787206;
 Fri, 15 Oct 2021 00:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-22-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-22-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 10:09:36 +0300
Message-ID: <CAOQ4uxiOhQjQMruHR-ZM0SNdaRyi7BGsZK=Y_nSh1=361oC81g@mail.gmail.com>
Subject: Re: [PATCH v7 21/28] fanotify: Support merging of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Error events (FAN_FS_ERROR) against the same file system can be merged
> by simply iterating the error count.  The hash is taken from the fsid,
> without considering the FH.  This means that only the first error object
> is reported.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c | 39 ++++++++++++++++++++++++++++++++---
>  fs/notify/fanotify/fanotify.h |  4 +++-
>  2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 9b970359570a..7032083df62a 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -111,6 +111,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
>         return fanotify_info_equal(info1, info2);
>  }
>
> +static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
> +                                      struct fanotify_error_event *fee2)
> +{
> +       /* Error events against the same file system are always merged. */
> +       if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
> +               return false;
> +
> +       return true;
> +}
> +
>  static bool fanotify_should_merge(struct fanotify_event *old,
>                                   struct fanotify_event *new)
>  {
> @@ -141,6 +151,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>         case FANOTIFY_EVENT_TYPE_FID_NAME:
>                 return fanotify_name_event_equal(FANOTIFY_NE(old),
>                                                  FANOTIFY_NE(new));
> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +               return fanotify_error_event_equal(FANOTIFY_EE(old),
> +                                                 FANOTIFY_EE(new));
>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -148,6 +161,22 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>         return false;
>  }
>
> +static void fanotify_merge_error_event(struct fanotify_error_event *dest,
> +                                      struct fanotify_error_event *origin)
> +{
> +       dest->err_count++;
> +}
> +
> +static void fanotify_merge_event(struct fanotify_event *dest,
> +                                struct fanotify_event *origin)
> +{
> +       dest->mask |= origin->mask;
> +
> +       if (origin->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +               fanotify_merge_error_event(FANOTIFY_EE(dest),
> +                                          FANOTIFY_EE(origin));
> +}
> +
>  /* Limit event merges to limit CPU overhead per event */
>  #define FANOTIFY_MAX_MERGE_EVENTS 128
>
> @@ -175,7 +204,7 @@ static int fanotify_merge(struct fsnotify_group *group,
>                 if (++i > FANOTIFY_MAX_MERGE_EVENTS)
>                         break;
>                 if (fanotify_should_merge(old, new)) {
> -                       old->mask |= new->mask;
> +                       fanotify_merge_event(old, new);
>                         return 1;
>                 }
>         }
> @@ -577,7 +606,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  static struct fanotify_event *fanotify_alloc_error_event(
>                                                 struct fsnotify_group *group,
>                                                 __kernel_fsid_t *fsid,
> -                                               const void *data, int data_type)
> +                                               const void *data, int data_type,
> +                                               unsigned int *hash)
>  {
>         struct fs_error_report *report =
>                         fsnotify_data_error_report(data, data_type);
> @@ -591,6 +621,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
>                 return NULL;
>
>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->err_count = 1;
> +
> +       *hash ^= fanotify_hash_fsid(fsid);
>
>         return &fee->fae;
>  }

Forgot to store fee->fsid?

Thanks,
Amir.
