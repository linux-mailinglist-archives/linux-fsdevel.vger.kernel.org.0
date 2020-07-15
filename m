Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB28220CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 14:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGOMfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgGOMfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:35:00 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90602C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 05:35:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r12so1801352ilh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMM1LJMKcluZERyzxTbnBheEyP+mTQpYVSwQDsHOxV0=;
        b=ANwxTDc0cBeZ+884LiLnWSUDcfxQovXTG0sPng3n/vLlGbHDRlzSKeU8OVmeBk/Qao
         kbqjuvgdwl9YAxM81rrGzXuJcv7WjEKQ7jtWDhLM5jdSCG/dvSsT2sTxEHEhlVlf0njV
         FIIlXHc6IJCZOw14LkYc/DVIsyHGs80k6010oLWSwTronp/HAWb9MeOg3YrbIeXmufnh
         Wo7tvJFmcrURNpjHgN11wY0OXaHS9DE2vTz4eFHeMnnf2P5eYJHkhzSbuT2vHv/CvfGH
         swP4l/01nqcqyqeqpoVXiKkFVxMihashVw81yvXbwuS/erX0vxuZEoPRvfyj8nnNW8mi
         JM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMM1LJMKcluZERyzxTbnBheEyP+mTQpYVSwQDsHOxV0=;
        b=PGDURjjPWLb04bMFu4PqHyVF3yAAiB7JH4LGkGs7WLOI+yYxFxTIlcSIBhJs/OvaJt
         dNo/8p8eLoLERSxx/lnLw6DqBJmOlSAmIslWeVHWIEzIZe/gha33wiCE3VkNWQMzqT4/
         A/yQtVe7DgKDGIGds1nhz1D5CnVvenOUpjUf3fJb6riSRiUK8ySrohUeWls1897ZoBr2
         hnOxPiuQK42hg5drpfaIcpcRiNC30LxZeGEH/fD6qQj80K8wlQp6GV4WvAO5yGoq21l8
         pvwg9zEVNQoICOD0Oxd9Kkg8oPvDz2OV5IsYqQ6zTUBxFQ65MYsGEGEoc/HdUjx9q1Dp
         GS2w==
X-Gm-Message-State: AOAM531x0STpVnhdf/9HxAnqR7TsJlrRVZM09fs1N/O5vCSaeFqMkpWt
        WdlrxVPlf+f1jIdH6LMkQY8yL5v8V535NjkfNf4mE7Y+
X-Google-Smtp-Source: ABdhPJwPFy+aG2u1qyogUAjqKMeNx1gtaQc/hm4tBnHXGlPJCeQh+IqXvl6QSsN6UYPFJWR0a/04MtgS2Q27hu9OnXM=
X-Received: by 2002:a92:c205:: with SMTP id j5mr9877799ilo.137.1594816499974;
 Wed, 15 Jul 2020 05:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200715122921.5995-1-jack@suse.cz>
In-Reply-To: <20200715122921.5995-1-jack@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jul 2020 15:34:48 +0300
Message-ID: <CAOQ4uxjJCKVQU0FaN-gU4RLcE97YnNAZMdg6RRbKeLjOLW7dCw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Avoid softlockups when reading many events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Francesco Ruggeri <fruggeri@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 3:29 PM Jan Kara <jack@suse.cz> wrote:
>
> When user provides large buffer for events and there are lots of events
> available, we can try to copy them all to userspace without scheduling
> which can softlockup the kernel (furthermore exacerbated by the
> contention on notification_lock). Add a scheduling point after copying
> each event.
>
> Note that usually the real underlying problem is the cost of fanotify
> event merging and the resulting contention on notification_lock but this
> is a cheap way to somewhat reduce the problem until we can properly
> address that.
>
> Reported-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fanotify/fanotify_user.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> This is a quick mending we can do immediately and is probably a good idea
> nevertheless... I'll queue it up if Amir agrees.
>

Sure. fine by me.
Maybe add a lore link to the issue report.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 63b5dffdca9e..d7f63aeca992 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -412,6 +412,11 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>
>         add_wait_queue(&group->notification_waitq, &wait);
>         while (1) {
> +               /*
> +                * User can supply arbitrarily large buffer. Avoid softlockups
> +                * in case there are lots of available events.
> +                */
> +               cond_resched();
>                 event = get_one_event(group, count);
>                 if (IS_ERR(event)) {
>                         ret = PTR_ERR(event);
> --
> 2.16.4
>
