Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82783A9462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 09:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFPHv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 03:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhFPHv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:51:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572DC061574;
        Wed, 16 Jun 2021 00:49:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id k16so2022526ios.10;
        Wed, 16 Jun 2021 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikE/o+HB7qUet0sUVn4IHjdD7oxXYQwPbHytFooRh/U=;
        b=WNNLbk1yLBUcI9CG/a9fGj1jr0GMakQ61DFFtDScpBVDAOdm4Qp134tqEnKf/eYtVh
         xsAwjjO2AaYGv6KV0pNlV7JgU8LmQDRRw5QnlEPY9gviKRhnGRQlgEiKvah04fjOItgq
         PCeeocnplDKTeYkxUtdv62zGRz7DQnGWG6FE48YF//m2034Ds055mKz8AZ+nVOYwzYJJ
         U7LfGJhWzkYprWycwVzaoWqQIUswroGCaj7ZOEE5WdKj+Nja3P1+fq9jf4doWPUztMvz
         OAlW8yaJg/dobrS6Vfk9WqSTEpnwHzoq2+p2iWw3PmECEdUIJwgCfcNeJAqtJ6kfAY1Z
         sU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikE/o+HB7qUet0sUVn4IHjdD7oxXYQwPbHytFooRh/U=;
        b=D+gbxiaFmLsIg2t/hR+eLAxBxdU1mw010BsQUp/SFAWdcNOiBZxle3zeQOCxolYtxb
         +qeu974s7YL0P63KXK26bazYDmsRBs6uoBQWKTuaZ7RMYqcD0t/AQHTYF9dQSUogj0xV
         Gj5FzuFcEDPhxMej7psluyBY8SWn55FMGf4nZJPokiB97YifuBg8f21FlgcgyUhvQewj
         czSfRB6bqcvMkLgIQiCSP6P3ye6pcgTvgFMEmmmobYg8B+GQeJMCPJI2syhKBvk2vm3s
         cZibHCdE9kUgXjm0h586BOW38SppHjgGSigX5suX8fxCEekn6VUpIcMMNQHcL2pHGGiU
         D0Lw==
X-Gm-Message-State: AOAM531PHmnzJ3YDZYCZ3uImoAdY+1ofgtb/Veom5m/YuJuj87k5+Hxh
        PFKS59T/Cm303XBPutO8Vo0ND/8FZ4CTihazgaw=
X-Google-Smtp-Source: ABdhPJwXrUhXi7U4IriLfkBrif391loRpNV7PNC1ipWHu6QvIAwQ596ZlU+5unZJA/st3dXcgQbgn6Ess4ZvBc0MzUs=
X-Received: by 2002:a05:6602:2d83:: with SMTP id k3mr2674281iow.5.1623829761493;
 Wed, 16 Jun 2021 00:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210615235556.970928-1-krisman@collabora.com> <20210615235556.970928-2-krisman@collabora.com>
In-Reply-To: <20210615235556.970928-2-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 10:49:10 +0300
Message-ID: <CAOQ4uxh-4dRSWQZr0Y7WrVmQc1ZLo=WXhmqD3DDMrWn0CgSC-A@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] fsnotify: Don't call insert hook for overflow events
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
> Overflow events are not mergeable, so they are not hashed_events.  But,
> when failing inside fsnotify_add_event, for lack of space,
> fsnotify_add_event() still calls the insert hook, which adds the
> overflow event to the merge list.
>
> Avoid calling the insert hook when adding an overflow event.
>
> Fixes: 94e00d28a680 ("fsnotify: use hash table for faster events merge")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/notification.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/notify/notification.c b/fs/notify/notification.c
> index 32f45543b9c6..033294669e07 100644
> --- a/fs/notify/notification.c
> +++ b/fs/notify/notification.c
> @@ -106,6 +106,11 @@ int fsnotify_add_event(struct fsnotify_group *group,
>                         return ret;
>                 }
>                 event = group->overflow_event;
> +               /*
> +                * Since overflow events are not mergeable, don't insert
> +                * them in the merge hash.
> +                */
> +               insert = NULL;
>                 goto queue;
>         }
>

Hmm, the fix looks correct, but a bit fragile.
While it makes sense that @insert is the counterpart of @merge
there is nothing in the API that mandates it.

Therefore, it would be more robust IMO to add a check
fanotify_is_hashed_event(mask) in fanotify_insert_event()
to match fanotify_is_hashed_event(mask)  in get_one_event().

If we do that, we can also simplify:

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -779,8 +779,7 @@ static int fanotify_handle_event(struct
fsnotify_group *group, u32 mask,

        fsn_event = &event->fse;
        ret = fsnotify_add_event(group, fsn_event, fanotify_merge,
-                                fanotify_is_hashed_event(mask) ?
-                                fanotify_insert_event : NULL);
+                                fanotify_insert_event);


Thanks,
Amir.
