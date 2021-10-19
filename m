Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C065A432DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhJSGMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSGMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:12:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2EC06161C;
        Mon, 18 Oct 2021 23:09:48 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 188so19018781iou.12;
        Mon, 18 Oct 2021 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5rJyZ7oh6ui19udFyfoWTO4pqqrSsGWtbBgzoa5u3E=;
        b=jKJiL1ZfL/peN/qWwz0YQ6+deNz5DWrDJY/DYE5b+aWemC4lprUzoIbkrdXponTq2D
         bwdsS7JuaH6yh/ogGMNU76+K9++qcgV/kC1rJ3BySbwRh4dhBkbLtExAnH0Uf0lNnyGz
         RCbKp9nySjfYytQFZH4UmkGJLujTU8j37D1wqz3d0UMbCU8DQ3qEAmd7dXGdNEUq050+
         M4FpyZZayQqazLYHobheAutKXydBiFrArqHZNc6KjkppyzgLbkk2sl3ATaCkiV0KLwnY
         avdW6I/FfD24Xem73UT2Vu6m3Gly/3JHLki5yJa4iJIkrZpGsPx/z4xfS2t3vfUSI5lc
         R03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5rJyZ7oh6ui19udFyfoWTO4pqqrSsGWtbBgzoa5u3E=;
        b=ORAtG6TjgMMYl7GChR9v0gp30Pgs0ZN+t0V8JGCeN3nOwres5vc6HRXxtw3xZREgB4
         0LHs8k2wO8W+N7DmHoptTgl9z1sbAqWthIoYHBQ4tacCdF2d1PBXHjWEVXXnRKidBBrD
         AuABR2qPIf4QEZuB+NI/cciy5kNj02HxtGPvvVeYkQNwR1kbRZeVSVsrHgWKAtnwta7g
         QBDZx5S5iG+tbOC1wEU5zY8Z/p92j7F1S75n6+Cex96QL62/9k/pB1yvLUVDdnRlaQS9
         njtAUShx5t7OrPO4BzDuA/EPoRNIIJElRBJWhZtMUGgnPYtr5OnahI9lwXuR70mySt8K
         CtGw==
X-Gm-Message-State: AOAM532kXDowqyYY52u4AbNGfu44zEbLlnrxzEitD4lRItN8wbOqtfmO
        /V4auBc1t8axRJ5AXAGvY4rk4G0B3vxOrg2F6ymRQH1F6+o=
X-Google-Smtp-Source: ABdhPJz0ZPGfWbmNLYA+lHTH9bCVq9WLqLu7l8RSRR6bY8LX4YMj+HO5y+4m8Lg52esVNCpB+XZT8Lip4iftkBR3tYM=
X-Received: by 2002:a02:270c:: with SMTP id g12mr2744605jaa.75.1634623787541;
 Mon, 18 Oct 2021 23:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-24-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-24-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 09:09:36 +0300
Message-ID: <CAOQ4uxhh-qMLnHWJKwxZ3PZqCNq13tM9c++2W8hCAegW_Vt7Tw@mail.gmail.com>
Subject: Re: [PATCH v8 23/32] fanotify: Wrap object_fh inline space in a
 creator macro
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
> fanotify_error_event would duplicate this sequence of declarations that
> already exist elsewhere with a slight different size.  Create a helper
> macro to avoid code duplication.
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

with minor nit

> ---
> Among the suggestions, I think this is simpler because it avoids
> deep nesting the variable-sized attribute, which would have been hidden
> inside fee->ffe->object_fh.buf.
>
> It also avoids touching the allocators, which are nicely hidden inside
> helper KMEM_CACHE() macros that hides several parameters.

I like this option best as well.

> ---
>  fs/notify/fanotify/fanotify.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 2b032b79d5b0..a5e81d759f65 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -171,12 +171,19 @@ static inline void fanotify_init_event(struct fanotify_event *event,
>         event->pid = NULL;
>  }
>
> +#define FANOTIFY_INLINE_FH(size)                                       \
> +struct {                                                               \
> +       struct fanotify_fh object_fh;                                   \
> +       /* Space for object_fh.buf[] - access with fanotify_fh_buf() */ \
> +       unsigned char _inline_fh_buf[(size)];                           \
> +}
> +
>  struct fanotify_fid_event {
>         struct fanotify_event fae;
>         __kernel_fsid_t fsid;
> -       struct fanotify_fh object_fh;
> -       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> -       unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
> +
> +       /* This must be the last element of the structure. */
> +       FANOTIFY_INLINE_FH(FANOTIFY_INLINE_FH_LEN);
>  };

It's not true that is must be the last element.
this is only true for struct fanotify_fh with zero size buf[].

Thanks,
Amir.
