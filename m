Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A63B7C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhF3DPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 23:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhF3DPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:15:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED92C061760;
        Tue, 29 Jun 2021 20:13:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l5so1397374iok.7;
        Tue, 29 Jun 2021 20:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgOlP1mIeiW5ZmRgmpeSNvUCWk9mw1dHHaN/pWphchI=;
        b=W1U9LkraBi9jIgW45RTFOo39Z+eEtTlYRmbAHs6wgDqTE8VFx3x7G5wAQxT/a6l3Ud
         ZIua0WIlIeW216KUHba0NO/hdvbEJMCTDkfzKdo0ZogWA51cAM92RIWvTmR9z8MEmZKC
         FwGy8OeFq9SdwtsNCOo5tIOpnmC3bl6OPZj2W7blthEKN6MDf9J7xba9Lz8ys0To25Co
         0ELuK8m0cUlyeDfJmmA4RvOD2FmKsoI3Un4XThVpYf5jthXQfL4OaESKE7pq4dMJN3Lv
         Lv4zLI9MTfdXdzod69Dq7lcBqQRu6eZa5xdz9ltpAd0Jn9lWYCq3IOOcDOZO9ID+qOpt
         R+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgOlP1mIeiW5ZmRgmpeSNvUCWk9mw1dHHaN/pWphchI=;
        b=dJPM9SqZ4aO6E4xjZVQpSpC05jNdl0iVg05Oz04ZxpRkHKfVyYZkMF0NNWKvPUZycu
         cvnBhZkTCGFLhLxLsB8ZRqjvU70atK5AAjJU2OqXKUSkGc0DRFr0/kRMfKZ4fR8tGmXk
         hruN1OJbVRWvPf15U3ckRVZ0YMQ16wwc6u3XbSI3bIIEwmPPCmyK1/X0Qutm6sCniYDV
         A4NmkmZyOm7Ech+lXw8Gf2d+4NfT7Xx1LCIPGvPkHBusIdXBNgNHLMu6tWSmaOz+GgKz
         xi8U0EIomVTxY1UBdGDoqHaMAfSXjEBZy5SsMLkMoIrxazlLDNDDVdFQqbL0iQp78hl5
         YWnw==
X-Gm-Message-State: AOAM531+gj/dMhjEi1g5b0nb6ks5IDokCDuUiiP/RaLihDp3G3gljfYY
        MV1efnOW/+HD3llBZecyrZBg7EePwuWBNSfS/wxr8P+Sppw=
X-Google-Smtp-Source: ABdhPJxpGH7Fm714bD4fgx1TJQGhqW8MHZ7jAxQlVjWUx88mly5+a8j9YkKKXOE/pBwNDymzd2Sr9oVaYWKl0d2gsek=
X-Received: by 2002:a5e:aa07:: with SMTP id s7mr6248373ioe.186.1625022784593;
 Tue, 29 Jun 2021 20:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-2-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-2-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:12:53 +0300
Message-ID: <CAOQ4uxjHV6+8a1+Ff09ezSdEvG7SyO9kF+eHsw4xGvNLWF7gtQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] fsnotify: Don't insert unmergeable events in hashtable
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

On Tue, Jun 29, 2021 at 10:11 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Some events, like the overflow event, are not mergeable, so they are not
> hashed.  But, when failing inside fsnotify_add_event for lack of space,
> fsnotify_add_event() still calls the insert hook, which adds the
> overflow event to the merge list.  Add a check to prevent any kind of
> unmergeable event to be inserted in the hashtable.
>
> Fixes: 94e00d28a680 ("fsnotify: use hash table for faster events merge")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v2:
>   - Do check for hashed events inside the insert hook (Amir)
> ---
>  fs/notify/fanotify/fanotify.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 057abd2cf887..310246f8d3f1 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -702,6 +702,9 @@ static void fanotify_insert_event(struct fsnotify_group *group,
>
>         assert_spin_locked(&group->notification_lock);
>
> +       if (!fanotify_is_hashed_event(event->mask))
> +               return;
> +
>         pr_debug("%s: group=%p event=%p bucket=%u\n", __func__,
>                  group, event, bucket);
>
> @@ -779,8 +782,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>
>         fsn_event = &event->fse;
>         ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
> -                                fanotify_is_hashed_event(mask) ?
> -                                fanotify_insert_event : NULL);
> +                                fanotify_insert_event);
>         if (ret) {
>                 /* Permission events shouldn't be merged */
>                 BUG_ON(ret == 1 && mask & FANOTIFY_PERM_EVENTS);
> --
> 2.32.0
>
