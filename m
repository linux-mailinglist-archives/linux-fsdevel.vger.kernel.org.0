Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B653D6B03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 02:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhGZXnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 19:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhGZXni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:43:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC6C061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 17:24:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d18so18631442lfb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 17:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjZYlUcYN5sBjobFWb8nzDIYMaNSgZ99MDYf3js36Iw=;
        b=HywrTTgoNUUzZe2DeeXbBRJypzzAVZ55Lq57vLT1GBqBAD9USb2aXOLnFDhijm7R7J
         fDmPQoU3rzLlnfWURe9mWP+GVTW3bpP0jKOba8Xr/6+vKXagm+YwP0Np2giFSOo9nvbq
         sBf+5L2BovfnFDuz0nDAXiiFlN+jxoNnb5zpjfgvv0UXKx2v5EA2R5Ca4j9oehkZVKaM
         ibzWtWLjPQeYs2AC4GZfs775gQX4EqP7NluN53qc0X5T60XwTb50Lj9rBKK/Ezf69nH3
         fKxHyYsFLQPQ12/qWeg7X2bu64SaWvqZetQSkZ14T9a6Knue6H/2O/tBqOx8HugM7AEW
         uiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjZYlUcYN5sBjobFWb8nzDIYMaNSgZ99MDYf3js36Iw=;
        b=osGILAptLlSR4xO/CTZx3ng1XOFlo+K93LoHTQbLGyMi/0KKUx7d0Y8+nY3dqEKmae
         ZW4pA9JrUM/ihZE7PMD1rxpRW9xiNjDKqpXwTvb1aj7VNYvhNiR7uonI9HEcFZv/2k5v
         KUSC7nhUfYGr/vABX0eoVuPyoAAWW9GjxfCmuVHXIy3At2LKCfht4+rxYz834l5Q1Smr
         +GD6cQOnHwNvI9tUnhCHizKxlCF01ZeBbdXFbkcksCguvygNkI545obMdBjQkIKxjgIp
         l+3Znxj5lGawe+Wq0nkpTuI81CjCjKa9UD7ePFijriyTAYcahao4XuB31jw+M93BRzn0
         5sEA==
X-Gm-Message-State: AOAM531WDEilCt3MUEuazLdVWyltZ7h+/Zf2EVsVQ9ZKF7rrKTf1MedL
        GBFX2v4WxzpyrSbONGdny2txdQSHZpkr+LblpG7aDQ==
X-Google-Smtp-Source: ABdhPJwIpTei0rR0Pvs3k6MXJc1oRgaLyIaXUZjcmPG4p7RfDNJGMAP/zRAF7ursSQX4Tgzuw8EUq38/PKgE+Fg53q4=
X-Received: by 2002:a05:6512:da:: with SMTP id c26mr15226815lfp.390.1627345444712;
 Mon, 26 Jul 2021 17:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
In-Reply-To: <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 27 Jul 2021 02:23:38 +0200
Message-ID: <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
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
> there is FAN_EPIDFD, which will be reported if a more generic pidfd
> creation error occurred when calling pidfd_create().
[...]
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
> +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> +                * cases. All other pidfd creation errors are represented as
> +                * FAN_EPIDFD.
> +                */
> +               if (metadata.pid == 0 ||
> +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> +                       pidfd = FAN_NOPIDFD;
> +               } else {
> +                       pidfd = pidfd_create(event->pid, 0);
> +                       if (pidfd < 0)
> +                               pidfd = FAN_EPIDFD;
> +               }
> +       }
> +

As a general rule, f_op->read callbacks aren't allowed to mess with
the file descriptor table of the calling process. A process should be
able to receive a file descriptor from an untrusted source and call
functions like read() on it without worrying about affecting its own
file descriptor table state with that.

I realize that existing fanotify code appears to be violating that
rule already, and that you're limiting creation of fanotify file
descriptors that can hit this codepath to CAP_SYS_ADMIN, but still, I
think fanotify_read() probably ought to be an ioctl, or something
along those lines, instead of an f_op->read handler if it messes with
the caller's fd table?
