Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0242E8C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 08:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhJOGSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhJOGSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:18:03 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15025C061570;
        Thu, 14 Oct 2021 23:15:58 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z69so3394603iof.9;
        Thu, 14 Oct 2021 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNefl0Lwyg8ukvIGSz9vJ/dogY+SIRasnoqyklmJWpk=;
        b=o4+WkTm7T07Q7rXsOIGtm3jCUfJRFvvnr45CmWtxvj2oO+iIhcLjZkouxK3Ch0XVp/
         ZBObzv/Dwj87mMjd81wLqF/wzGJHt1rlp2psm6pk6JXrxY4rr+MTGhKbCZoWUY2xLdSN
         II7dCIhTUlfXSzqamAM2gKn7ZcYfRw4GZUbI3CHA3Vb6EycwXnfJS48Hdj90fZTdl9rA
         CGg+2cpQvpzZCtAXjf3b9k+3TTf6c363XxLYLOlHGPKb7dcD045DbZmWG7h7dTXFQFBV
         XIxcZe7fSL8iwqwwBBYaZQ33j5+lzCziwCGiHhnEpm0Gm6HSWiMKS9A2sI4QlZyMOR8v
         XggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNefl0Lwyg8ukvIGSz9vJ/dogY+SIRasnoqyklmJWpk=;
        b=LqDW3oJLLYAid3W4J9m0AMLC3B3DZjqZTbgKTtILCbPwHHni1Q8P0+0MWbTebyemGx
         9TnrmFEPLM0ua3K2b/51Op4cfjmHAVw1VGxq0FfP+e9eE1w7YaKII01RGGwhmxOzdedX
         CZnWXqPKlspWWdlo07KBRwlHt3k1/D89LtSfRiLh/AKB5gjpMpzsY3zY0gQdqK44Tk/b
         ONSXsqgvVpV0GYMMORls8CEC/Dw/jEjnheA84DXkgm32XF6QX+1RrQYNdUw3U6ZwF/+/
         J83t/spLQaIsOSNBWjIz6qp+XNXUplJ/Z4gORrt1HnLUZbBQUzuF3FktD/3x1gHT+/oU
         YMew==
X-Gm-Message-State: AOAM533nmzdeTRtge43TbfVZDNB/VNwk/gPPEJD+6ESQR8wjnDcMvnsg
        hfNvI9s7dWmAV1dwkKwhDt0IMm4Pjum+N/+OSSQ=
X-Google-Smtp-Source: ABdhPJw7RcmDAmHs6vHSYT0F2ftblSXgxDaA5WEQ5Q+DMoq/D1RrLL6N1BaKYS/qGXHrgcoUMHCyI8ramHMAlqwvBwI=
X-Received: by 2002:a6b:b5d8:: with SMTP id e207mr2444791iof.52.1634278557569;
 Thu, 14 Oct 2021 23:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-20-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-20-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 09:15:46 +0300
Message-ID: <CAOQ4uxjhTu+fPwZfjGtzcoj3-RLxBSh8ozyLjWzcTC0YJAwnwA@mail.gmail.com>
Subject: Re: [PATCH v7 19/28] fanotify: Limit number of marks with
 FAN_FS_ERROR per group
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
> Since FAN_FS_ERROR memory must be pre-allocated, limit a single group
> from watching too many file systems at once.  The current scheme
> guarantees 1 slot per filesystem, so limit the number of marks with
> FAN_FS_ERROR per group.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 10 ++++++++++
>  include/linux/fsnotify_backend.h   |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index f1cf863d6f9f..5324890500fc 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -959,6 +959,10 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
>
>         removed = fanotify_mark_remove_from_mask(fsn_mark, mask, flags,
>                                                  umask, &destroy_mark);
> +
> +       if (removed & FAN_FS_ERROR)
> +               group->fanotify_data.error_event_marks--;
> +
>         if (removed & fsnotify_conn_mask(fsn_mark->connector))
>                 fsnotify_recalc_mask(fsn_mark->connector);
>         if (destroy_mark)
> @@ -1057,6 +1061,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>
>  static int fanotify_group_init_error_pool(struct fsnotify_group *group)
>  {
> +       if (group->fanotify_data.error_event_marks >= FANOTIFY_DEFAULT_FEE_POOL)
> +               return -ENOMEM;

Why not try to mempool_resize()?
Also, I did not read the rest of the patches yet, but don't we need two
slots per mark? one for alloc-pre-enqueue and one for free-post-dequeue?

Thanks,
Amir.
