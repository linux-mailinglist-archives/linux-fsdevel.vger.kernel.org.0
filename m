Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8F3A3C87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFKHGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFKHGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:06:31 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776B7C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 00:04:18 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b5so4186933ilc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PonvJ+0iaBtVTjynvsU6VSJUxXEXSlhx9cOSdTQWrPY=;
        b=C8QqGXO8MtiVsrHLX9I2JyRClU7wZNH+QZ8xaHztdEkkyHZqmJPXQQFf3IWTcEbm1q
         aZsYfqGAQ2Sy2iMw2gj340cNADgA+yLjhW/De0jmTh8zkLZjsPLn+C/htvI87Zaw27cS
         BNNBdBTQ78Av3AMvVN4lPZrldwTgegXGqi70XfkK/ypH7fQx6iMl8/fdk4HbnnvuCOQA
         4N9bQFYvGJvnJFnKhLAB3ELghOHnYE++vSSX1fv3xaop8+76M4G3tu3dlRyuI60Wh2w3
         6hpr8Ch0mFwQyaXUZUht6O9JJ6qpTccgv4h15QPNizELLgpP/uDJD8twkKlSnpwmwGzQ
         lz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PonvJ+0iaBtVTjynvsU6VSJUxXEXSlhx9cOSdTQWrPY=;
        b=dQg65ZflVFwuILEi4rX1apd7KH6ldgi4CYpy9G+uiHSRwh7OKDbVKXC+pBC26RNmuG
         WJ/ayDO3D/o++uvf1vNV46t246zNNq+ZX5OJdOzNlD3rEVq81WTwfRmIYxCpA85dd+xQ
         GFPux/f6Z0sGUemZvKzcv6a1z+YPzocStMN4J+83bapDU9cxYDs93GoA8jdtSn3qX0Ai
         SEG9CyJMfEG22KF0vBfGXpBt89UHRwOHpI/uK9HDW0H1HiKUc/vWPsDl/cY2z3YiZF8U
         ugqOmb938IqLZLvQN11XI1kSHgus9eoLBb4t0BnNubz/mKLQp+UGWzSPVXfqE0enP/bX
         t49Q==
X-Gm-Message-State: AOAM5305gce1J3gStY/dcQrlyW/EEbs49IoZh9KrAMIS30eZ9nLMSeLk
        YLYDVEZ7OuH3QRoJkKLNV7P+oE4mzf+2Z2+Rcxg=
X-Google-Smtp-Source: ABdhPJxpBzxxJ7//PKpowWoBtqikbu+kNSpXcbnmWm0tbA0hUE0m5ezJZJYHu5mGneIhHRfESLx3fgpvNmjFQIMwosA=
X-Received: by 2002:a92:4446:: with SMTP id a6mr2190900ilm.9.1623395057881;
 Fri, 11 Jun 2021 00:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
In-Reply-To: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Jun 2021 10:04:06 +0300
Message-ID: <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 11, 2021 at 6:32 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> Ensure that clean up is performed on the allocated file descriptor and
> struct file object in the event that an error is encountered while copying
> fid info objects. Currently, we return directly to the caller when an error
> is experienced in the fid info copying helper, which isn't ideal given that
> the listener process could be left with a dangling file descriptor in their
> fdtable.
>
> Fixes: 44d705b0370b1 ("fanotify: report name info for FAN_DIR_MODIFY event")
> Fixes: 5e469c830fdb5 ("fanotify: copy event fid info to user")
> Link: https://lore.kernel.org/linux-fsdevel/YMKv1U7tNPK955ho@google.com/T/#m15361cd6399dad4396aad650de25dbf6b312288e
>

This newline should not be here.

> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---
>
> Hey Amir/Jan,
>
> I wasn't 100% sure what specific commit hash I should be referencing in the
> fix tags, so please let me know if that needs to be changed.

Trick question.
There are two LTS kernels where those fixes are relevant 5.4.y and 5.10.y
(Patch would be picked up for latest stable anyway)
The first Fixes: suggests that the patch should be applied to 5.10+
and the second Fixes: suggests that the patch should be applied to 5.4+

In theory, you could have split this to two patches, one auto applied to 5.4+
and the other auto applied to +5.10.

In practice, this patch would not auto apply to 5.4.y cleanly even if you split
it and also, it's arguably not that critical to worth the effort, so I would
keep the first Fixes: tag and drop the second to avoid the noise of the
stable bots trying to apply the patch.

If you want to do a service to the 5.4.y downstream community,
you can send a backport patch directly to stable list *after* this patch
is applied to master.

>
> Should we also be CC'ing <stable@vger.kernel.org> so this gets backported?
>

Yes and no.
Actually CC-ing the stable list is not needed, so don't do it.
Cc: tag in the commit message is somewhat redundant to Fixes: tag
these days, but it doesn't hurt to be explicit about intentions.
Specifying:
    Cc: <stable@vger.kernel.org> # v5.10+

Could help as a hint in case the Fixes: tags is for an old commit, but
you know that the patch would not apply before 5.10 and you think it
is not worth the trouble (as in this case).

But if you do specify stable kernel version hint, try not to get it wrong
like I did :-/
https://lore.kernel.org/linux-fsdevel/20210608122829.GI5562@quack2.suse.cz/

CC-ing Greg in case my understanding of the stable kernel patch
candidate analysis process is wrong.

Thanks,
Amir.

>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index be5b6d2c01e7..64864fb40b40 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -471,7 +471,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                                         info_type, fanotify_info_name(info),
>                                         info->name_len, buf, count);
>                 if (ret < 0)
> -                       return ret;
> +                       goto out_close_fd;
>
>                 buf += ret;
>                 count -= ret;
> @@ -519,7 +519,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                                         fanotify_event_object_fh(event),
>                                         info_type, dot, dot_len, buf, count);
>                 if (ret < 0)
> -                       return ret;
> +                       goto out_close_fd;
>
>                 buf += ret;
>                 count -= ret;
> --
> 2.32.0.272.g935e593368-goog
>
> /M
