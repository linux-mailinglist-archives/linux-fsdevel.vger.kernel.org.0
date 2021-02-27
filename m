Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5A326C42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 09:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhB0Icp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 03:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhB0Ico (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 03:32:44 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8013FC06174A
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 00:32:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id f20so12225946ioo.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 00:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=in6hTPPA1QoV9eYr/vSdKKze4u7A4lMv7UeZOp16gNI=;
        b=DxMJTsw24eRzRT7lSJ6AqVrhc9ucXTYuCHahPBPjTXQUrHSfMrLLwradFlMtVnLw0t
         FApnFpNGLPEPUVXq+D3ZOTXvSwepdnvRgLN0UytEvN6BcYXqXYFpSF+aQftJrljVc++2
         oHawSxiXFXQXJUsgYZWQuPw9Lnws+W0d32Ys7Kjck1cw5aW8/QLNIobes/5jRCY9EUOQ
         arlk9gx+bmxN/FqBaZ6Gg87s/ftt1lGC1MfsJIcwkbUmreZRczv3yKahGh0ZJGG8dz+8
         qPX5kV7oAzfJYIR3YTJraT3GqLa8dRguZza/4bbQsznSwaZYn/bl0M4E3cpMuon76KDJ
         Smlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=in6hTPPA1QoV9eYr/vSdKKze4u7A4lMv7UeZOp16gNI=;
        b=L+8TWgU6ZgbCl8G6t24tLmG13yVCYl/XeTpAZHsp8PxYvgP0BvT1Mt/I2wdtkp1NYv
         +pbp2cEQjnQxbmMOwIWt4bfl/rwFXX0mztPY5DLkJbNkCrfqu8WihtthBZLWT/9BaZn3
         0499msxfU3LXrccrrt6nWGfv5o+DfLGvRDbEc9sPGwgx4w0cWDLPGP1vHAFS+t7jTgal
         7Um1meoGXg9M3ZVrOU/yZQy+rO8d2B4kv4nn1++5OKbvapVg5hK6jRwXHhJWD6VSS2iI
         Reaf78XnPzxZhVEw/dUQWAl/ms5U5LsE2JtfzamIokUKCkrCeZa6Q8ly9nwUcf3D6C/T
         LRyg==
X-Gm-Message-State: AOAM530nZTXaMFsXRnifo6cz+QMTAHw9xkzv8ZdYAtOJqzt0XLime0az
        mfuywlboA0uCWxNaYoYiF4qqRrgss2URXplN7CWQwTucvAfgng==
X-Google-Smtp-Source: ABdhPJwsfECbHf0VMyVxqHBMbx5F7AziX36x7JurfvxeEShN4WKNnR8MNNW5s+DDaP6DZ4q4Ea1w3zWso2YzciDz4UE=
X-Received: by 2002:a02:ccb2:: with SMTP id t18mr6724274jap.123.1614414723925;
 Sat, 27 Feb 2021 00:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-6-amir73il@gmail.com>
In-Reply-To: <20210202162010.305971-6-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Feb 2021 10:31:52 +0200
Message-ID: <CAOQ4uxiqnD7Qr=__apodWYfQYQ_JOvVnaZsi4jjGQmJ9S5hMyA@mail.gmail.com>
Subject: Re: [PATCH 5/7] fanotify: limit number of event merge attempts
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 2, 2021 at 6:20 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Event merges are expensive when event queue size is large.
> Limit the linear search to 128 merge tests.
> In combination with 128 hash lists, there is a potential to
> merge with up to 16K events in the hashed queue.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 12df6957e4d8..6d3807012851 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -129,11 +129,15 @@ static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
>         return false;
>  }
>
> +/* Limit event merges to limit CPU overhead per event */
> +#define FANOTIFY_MAX_MERGE_EVENTS 128
> +
>  /* and the list better be locked by something too! */
>  static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
>  {
>         struct fsnotify_event *test_event;
>         struct fanotify_event *new;
> +       int i = 0;
>
>         pr_debug("%s: list=%p event=%p\n", __func__, list, event);
>         new = FANOTIFY_E(event);
> @@ -147,6 +151,8 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
>                 return 0;
>
>         list_for_each_entry_reverse(test_event, list, list) {
> +               if (++i > FANOTIFY_MAX_MERGE_EVENTS)
> +                       break;
>                 if (fanotify_should_merge(test_event, event)) {
>                         FANOTIFY_E(test_event)->mask |= new->mask;
>                         return 1;
> --
> 2.25.1
>

Jan,

I was thinking that this patch or a variant thereof should be applied to stable
kernels, but not the entire series.

OTOH, I am concerned about regressing existing workloads that depend on
merging events on more than 128 inodes.
I thought of this compromise between performance and functional regressions:

/*
 * Limit event merges to limit CPU overhead per new event.
 * For legacy mode, avoid unlimited CPU overhead, but do not regress the event
 * merge ratio in heavy concurrent workloads with default queue size.
 * For new FAN_REPORT_FID modes, make sure that CPU overhead is low.
 */
#define FANOTIFY_MAX_MERGE_OLD_EVENTS   16384
#define FANOTIFY_MAX_MERGE_FID_EVENTS   128

static inline int fanotify_max_merge_events(struct fsnotify_group *group)
{
        if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
                return FANOTIFY_MAX_MERGE_FID_EVENTS;
        else
                return FANOTIFY_MAX_MERGE_OLD_EVENTS;
}

I can start the series with this patch and change that to:

#define FANOTIFY_MAX_MERGE_FID_EVENTS   128

static inline int fanotify_max_merge_events(struct fsnotify_group *group)
{
               return FANOTIFY_MAX_MERGE_EVENTS;
}

At the end of the series.

What do you think?

Thanks,
Amir.
