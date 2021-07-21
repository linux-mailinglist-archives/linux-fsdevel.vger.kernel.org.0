Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE93D095C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 09:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhGUGY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 02:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhGUGY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:24:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8515C061574;
        Wed, 21 Jul 2021 00:05:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z1so1519806ils.0;
        Wed, 21 Jul 2021 00:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEPANnKUTIiGA2SYHJ7Kkp+f2/H+m9BShhgfPBiQnTw=;
        b=Tb7hJXiuvgHh9Xd2FlUdISdM7TFbhIhFfdwujOdecRVlEWCs/m8eobj5YO3PlPzm3P
         oWkqBkWqvczXfqOzA/ZX95EX3HTMMP9p0ZUOwzY64iWLNwsSoFhPzipNEQeYA4JDafe9
         iUMfGF77FSp9bl7gtfl/9/F1fYZ9g/HNA6ZnKIBi8OUI/79Vo8DjDKBiaGkjSP3UJ8C8
         FSStLfjnI8c8kWdb3bdEzrmzfeCSFneahYih0ivLL8x+H+2VAfrS3m4Zao/hdgWYiRZo
         vUrYkUKSz/bFmNVwZeKWx/HNFgQeW313zTYX0MoR8Cp2rDwmaXX739LGRuduy6UgVqVF
         bBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEPANnKUTIiGA2SYHJ7Kkp+f2/H+m9BShhgfPBiQnTw=;
        b=g4wj/0NetOTUh3Em6JI+QEWVGKDu3cA4vGkXde47TTwYWjsW46gKsBv5ehJrYjPMFL
         ZIfoUNYyJHK25KNAiWzi3XQLWlYWENM89WhbOosvueatBgBboOylYkRRUaatw6b7tmpJ
         tz3BpDFSl0ADqWlqxjC1H9R7mpTIYmfBjbdeCFTlHjiAe9l6/8ALMG76etPztKrZPJlw
         xMTwWIeI5gJc6upYw5crsglzxJbtAwkJznBH/l4eY9YxezFkhLLdpkI9oXtAQ3BNGyNQ
         EKuSLUt6grE9Y6TNgdgjSmBH+8wN0QGBd7lAVKPt+t7+douwyFAsZJVwR56qL1a5d0Oo
         9tvg==
X-Gm-Message-State: AOAM5308oLdq1QRzyokqQPqs0aDHIYFhR656YzRqGWqzMnIgLV1owSRv
        +g3l2ZejiTAjJ3w1muLuPHbaB6O+1JnhRzgy9As=
X-Google-Smtp-Source: ABdhPJxRQZ305mXtmnM/B4YwHMw8eIluJL62wMnNKBkv7vL6YllttBSqVJo+Jl0veP5iGWy5y+5uKecayzsVFqLl4+M=
X-Received: by 2002:a05:6e02:d93:: with SMTP id i19mr11188840ilj.72.1626851132259;
 Wed, 21 Jul 2021 00:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
In-Reply-To: <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 10:05:17 +0300
Message-ID: <CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 9:19 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> allows userspace applications to control whether a pidfd info record
> containing a pidfd is to be returned with each event.
>
> If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> struct fanotify_event_info_pidfd object will be supplied alongside the
> generic struct fanotify_event_metadata within a single event. This
> functionality is analogous to that of FAN_REPORT_FID in terms of how
> the event structure is supplied to the userspace application. Usage of
> FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> permitted, and in this case a struct fanotify_event_info_pidfd object
> will follow any struct fanotify_event_info_fid object.
>
> Currently, the usage of FAN_REPORT_TID is not permitted along with
> FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> limited to privileged processes only i.e. listeners that are running
> with the CAP_SYS_ADMIN capability. Attempting to supply either of
> these initialization flags with FAN_REPORT_PIDFD will result with
> EINVAL being returned to the caller.
>
> In the event of a pidfd creation error, there are two types of error
> values that can be reported back to the listener. There is
> FAN_NOPIDFD, which will be reported in cases where the process
> responsible for generating the event has terminated prior to fanotify
> being able to create pidfd for event->pid via pidfd_create(). The

I think that "...prior to event listener reading the event..." is a more
accurate description of the situation.

> there is FAN_EPIDFD, which will be reported if a more generic pidfd
> creation error occurred when calling pidfd_create().
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---
>
> Changes since v2:
>
>  * The FAN_REPORT_PIDFD flag value has been changed from 0x00001000 to
>    0x00000080. This was so that future FID related initialization flags
>    could be grouped nicely.
>
> * Fixed pidfd clean up at out_close_fd label in
>   copy_event_to_user(). Reversed the conditional and it now uses the
>   close_fd() helper instead of put_unused_fd() as we also need to close the
>   backing file, not just just mark the pidfd free in the fdtable.
>
> * Shuffled around the WARN_ON_ONCE(FAN_REPORT_TID) within
>   copy_event_to_user() so that it's inside the if (pidfd_mode) branch. It
>   makes more sense to be as close to pidfd creation as possible.
>
> * Fixed up the comment block within the if (pidfd_mode) branch.
>
>  fs/notify/fanotify/fanotify_user.c | 88 ++++++++++++++++++++++++++++--
>  include/linux/fanotify.h           |  3 +-
>  include/uapi/linux/fanotify.h      | 13 +++++
>  3 files changed, 98 insertions(+), 6 deletions(-)
>

[...]

>
> @@ -489,8 +526,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         struct path *path = fanotify_event_path(event);
>         struct fanotify_info *info = fanotify_event_info(event);
>         unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
> +       unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
>         struct file *f = NULL;
> -       int ret, fd = FAN_NOFD;
> +       int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
>
>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>
> @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         }
>         metadata.fd = fd;
>
> +       if (pidfd_mode) {
> +               /*
> +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> +                * exclusion is ever lifted. At the time of incoporating pidfd
> +                * support within fanotify, the pidfd API only supported the
> +                * creation of pidfds for thread-group leaders.
> +                */
> +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +
> +               /*
> +                * The PIDTYPE_TGID check for an event->pid is performed
> +                * preemptively in attempt to catch those rare instances where
> +                * the process responsible for generating the event has
> +                * terminated prior to calling into pidfd_create() and acquiring

I find the description above to be "over dramatic".
An event listener reading events after generating process has terminated
could be quite common in case of one shot tools like mv,touch,etc.

Thanks,
Amir.
