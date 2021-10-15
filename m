Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4104042E875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 07:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhJOFnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 01:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOFnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:43:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B613FC061570;
        Thu, 14 Oct 2021 22:41:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d125so6471851iof.5;
        Thu, 14 Oct 2021 22:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJic0if03qAgJDXU8K2OH89hzmK7tAPvWQLCw9ePAQ8=;
        b=iNftvuMMF8k7bxptDP10+bAJor1r50rbziSmaWOYCQtaMlqXR8dVPXl4ERMzVDdlsq
         WTzqZlfwylWEc58A88bblCjeQScJZvbsiv7d5V8nXgBufE5cFuF0fO8i6SI7hydxJbsJ
         CVqA9uMDvjKt7Vg35Joww0Fh6mIsjpVMZacHaMRzLytiHM7WWjFlVIeTl35JogSFB/Wn
         +EixBy6LetsAiKMig/LSLJJf3FfzAyHjI2us5lftR2oc6UJUhcEpGAQ+mkLw0CgsiqYk
         B29/hg/0ThPm6OhdLkVEbNdDG3J3U+U87TjJ7lmjHxHAKu8EgXWzqR0CM02HVpwG31gE
         IxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJic0if03qAgJDXU8K2OH89hzmK7tAPvWQLCw9ePAQ8=;
        b=YCwV1WCaWHZLfXBdfjIEdahTozYOOYoWUS4FZ+IcajQ5zifxkTlVaIucuhxgyIyfHV
         3sYGOZ3Z33bNvAe0wIRXlDcapZ6qQl2smIXqBoHkCDhb430oxXTdYbiT/+2FE8yYxi9f
         Q8o7K+8nypb2IlgarSEO7R7xyj1/U4mT+mJ+nKbp9Nhm6HOf1N2L/ym+dev6mVkCIvVC
         bzyDSfH+z3zd1zl8ZDtaCBwEx/tGOOnQfqZ+5I8T9rDx0PWNsQXr9iyExLhZPqLfgrd6
         JUSayPJv3PidZWuW/0UPBXWy9cF+BfFvNEoMKimVkBdZVzts0CPPVeJrxiy9ERBv+zLS
         G0IQ==
X-Gm-Message-State: AOAM532j637eLE0Y7+SZt2oLCx1Odi6BMwWjbqts7vrzSHJ/NSClm68F
        QfmFqrk6pTvnITqpkWPhA2COLwI6k7j88+HdgtglJTZO5eM=
X-Google-Smtp-Source: ABdhPJxW1cTU+XZmgk0xifkrvKfHj89Jy8LEdvO9s9SLvhYwNNcyzWUluXFHTMhzzo0YAfTQE/AGPxrlhOFIKOJQEiQ=
X-Received: by 2002:a6b:b5d8:: with SMTP id e207mr2362473iof.52.1634276464152;
 Thu, 14 Oct 2021 22:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-12-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 08:40:53 +0300
Message-ID: <CAOQ4uxjvAC=hQUXuhDvAEXBNEijriRRK1xhWs24VV6io+0-7kw@mail.gmail.com>
Subject: Re: [PATCH v7 11/28] fsnotify: Pass group argument to free_event
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

On Fri, Oct 15, 2021 at 12:38 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> For group-wide mempool backed events, like FS_ERROR, the free_event
> callback will need to reference the group's mempool to free the memory.
> Wire that argument into the current callers.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c        | 3 ++-
>  fs/notify/group.c                    | 2 +-
>  fs/notify/inotify/inotify_fsnotify.c | 3 ++-
>  fs/notify/notification.c             | 2 +-
>  include/linux/fsnotify_backend.h     | 2 +-
>  5 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index f82e20228999..c620b4f6fe12 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -835,7 +835,8 @@ static void fanotify_free_name_event(struct fanotify_event *event)
>         kfree(FANOTIFY_NE(event));
>  }
>
> -static void fanotify_free_event(struct fsnotify_event *fsn_event)
> +static void fanotify_free_event(struct fsnotify_group *group,
> +                               struct fsnotify_event *fsn_event)
>  {
>         struct fanotify_event *event;
>
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index fb89c351295d..6a297efc4788 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -88,7 +88,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
>          * that deliberately ignores overflow events.
>          */
>         if (group->overflow_event)
> -               group->ops->free_event(group->overflow_event);
> +               group->ops->free_event(group, group->overflow_event);
>
>         fsnotify_put_group(group);
>  }
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> index a96582cbfad1..d92d7b0adc9a 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -177,7 +177,8 @@ static void inotify_free_group_priv(struct fsnotify_group *group)
>                 dec_inotify_instances(group->inotify_data.ucounts);
>  }
>
> -static void inotify_free_event(struct fsnotify_event *fsn_event)
> +static void inotify_free_event(struct fsnotify_group *group,
> +                              struct fsnotify_event *fsn_event)
>  {
>         kfree(INOTIFY_E(fsn_event));
>  }
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 44bb10f50715..9022ae650cf8 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -64,7 +64,7 @@ void fsnotify_destroy_event(struct fsnotify_group *group,
>                 WARN_ON(!list_empty(&event->list));
>                 spin_unlock(&group->notification_lock);
>         }
> -       group->ops->free_event(event);
> +       group->ops->free_event(group, event);
>  }
>
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 035438fe4a43..1e69e9fe45c9 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -155,7 +155,7 @@ struct fsnotify_ops {
>                             const struct qstr *file_name, u32 cookie);
>         void (*free_group_priv)(struct fsnotify_group *group);
>         void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
> -       void (*free_event)(struct fsnotify_event *event);
> +       void (*free_event)(struct fsnotify_group *group, struct fsnotify_event *event);
>         /* called on final put+free to free memory */
>         void (*free_mark)(struct fsnotify_mark *mark);
>  };
> --
> 2.33.0
>
