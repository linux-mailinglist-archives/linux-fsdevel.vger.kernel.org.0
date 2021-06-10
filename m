Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6E13A23C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 07:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJFUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 01:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJFUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 01:20:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06924C061574;
        Wed,  9 Jun 2021 22:18:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v13so622851ilh.13;
        Wed, 09 Jun 2021 22:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pucqiw8cDxAXI7cl3O7sFouRXCg/0ax4Vi77PQ0rrE4=;
        b=soKeTEn/zR2axHUQU7gHxjsE9N3NKFrfF3R8cFPIH/0huEO2HfrArXtUt1QuIeoExI
         uPnAcR28MVjInzyBSaf/CbyHDvoLZOX7uRP+VMJnrsuVGxZ2Rr1FWu50z3FtawA0PzL9
         d0eehT/wZihBBOlUAHGdf4xjv1ZHNUV6OIgfkeHCTontIfCUewVd0mFrlVr2ktIu86G1
         tBAjODKD76OcBYWgrVJHp6Egk2YSR9NdAr2DB5RNYM3V8MkP7DA11sMMtu62ul5egR0N
         8xmRMT0+jHyBTdelOS68MSIHiYLFBaS1QcgOfiBxHPboWm8phBZtHRkVqsVhNX031qes
         U68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pucqiw8cDxAXI7cl3O7sFouRXCg/0ax4Vi77PQ0rrE4=;
        b=gQE4x9MGcl4FI1u9i11R4b9lDiIHiaA/oFE0RNTY2nuiePswAKTzWSN+G2itUVOrhv
         5st3LHct1b0ERhKoARjh47S/XyN8iXYyCIu1WRluNDc0LNMKvXTii9E3BaSaI3K7o3Y3
         aWTKra+Dyxr2/qWKRGljsfHWDRT6WG6uQflM9NiGNcP/jZ9Jx0jZ9LaMN1IE5EpytiO8
         CC880+z0q+OzB1LMeCl+qDW3jFTtuWg1tl/WCTuJIuWNH+cog0Q+34Hy4UvxXiYqzqdA
         BwGEOOPbskXr1FTOGqSVIFZ4LnaSg9W3VNHeSPhCTS+Jz9Qob+Y2EEPuqQOhI/pU2l0y
         V03A==
X-Gm-Message-State: AOAM532vamTWQGuQupe5Xj9gg68zsCXW2QxLsvvzlo9mYdTgXgHXD3vr
        aEwVtYwYyKeBhV4rHQ4LDKjDby6Z6NiyrFTFbac=
X-Google-Smtp-Source: ABdhPJzLFxFroIbuUmwHZegxS2FEEb25j4JSR87/E/1JZPQqEN/qKLzZUveL7gextFHtd3+nI1fUAh7ooHWa2LrLVhk=
X-Received: by 2002:a92:4446:: with SMTP id a6mr2525654ilm.9.1623302293470;
 Wed, 09 Jun 2021 22:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623282854.git.repnop@google.com> <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
In-Reply-To: <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 10 Jun 2021 08:18:01 +0300
Message-ID: <CAOQ4uxj2t+z1BWimWKKTae3saDbZQ=-h+6JSnr=Vyv1=rGT0Jw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 3:22 AM Matthew Bobrowski <repnop@google.com> wrote:
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
> these initialisation flags with FAN_REPORT_PIDFD will result with
> EINVAL being returned to the caller.
>
> In the event of a pidfd creation error, there are two types of error
> values that can be reported back to the listener. There is
> FAN_NOPIDFD, which will be reported in cases where the process
> responsible for generating the event has terminated prior to fanotify
> being able to create pidfd for event->pid via pidfd_create(). The
> there is FAN_EPIDFD, which will be reported if a more generic pidfd
> creation error occurred when calling pidfd_create().
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
>
> ---
>
> Changes since v1:
>
> * Explicit checks added to copy_event_to_user() for unprivileged
>   listeners via FANOTIFY_UNPRIV. Only processes running with the
>   CAP_SYS_ADMIN capability can receive pidfds for events.
>
> * The pidfd creation via pidfd_create() has been taken out from
>   copy_pidfd_info_to_user() and put into copy_event_to_user() so that
>   proper clean up of the installed file descriptor can take place in
>   the event that we error out during one of the info copying routines.
>
> * Before pidfd creation is done via pidfd_create(), we perform an
>   explicit check using pid_has_task() to make sure that the process
>   responsible for generating the event in the first place hasn't been
>   terminated. If it has, we supply the FAN_NOPIDFD error to the
>   listener which explicitly indicates this was the case. All other
>   pidfd creation errors are represented by FAN_EPIDFD.
>
> * An additional check has been implemented before calling into
>   pidfd_create() to see whether pid_vnr() had returned 0 for
>   event->pid. In such cases, we also return FAN_NOPIDFD within the
>   pidfd info record as returning metadata->pid = 0 with a valid pidfd
>   doesn't make much sense and could lead to possible security problem.
>
>  fs/notify/fanotify/fanotify_user.c | 98 ++++++++++++++++++++++++++++--
>  include/linux/fanotify.h           |  3 +-
>  include/uapi/linux/fanotify.h      | 13 ++++
>  3 files changed, 107 insertions(+), 7 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 85d6eea8d45d..1ce66bcfd9b5 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -106,6 +106,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  #define FANOTIFY_EVENT_ALIGN 4
>  #define FANOTIFY_FID_INFO_HDR_LEN \
>         (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> +       sizeof(struct fanotify_event_info_pidfd)
>
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -138,6 +140,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
>                 dot_len = 1;
>         }
>
> +       if (info_mode & FAN_REPORT_PIDFD)
> +               info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> +
>         if (fh_len)
>                 info_len += fanotify_fid_info_len(fh_len, dot_len);
>
> @@ -401,13 +406,34 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>         return info_len;
>  }
>
> +static int copy_pidfd_info_to_user(int pidfd,
> +                                  char __user *buf,
> +                                  size_t count)
> +{
> +       struct fanotify_event_info_pidfd info = { };
> +       size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> +
> +       if (WARN_ON_ONCE(info_len > count))
> +               return -EFAULT;
> +
> +       info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> +       info.hdr.len = info_len;
> +       info.pidfd = pidfd;
> +
> +       if (copy_to_user(buf, &info, info_len))
> +               return -EFAULT;
> +
> +       return info_len;
> +}
> +
>  static int copy_info_records_to_user(struct fanotify_event *event,
>                                      struct fanotify_info *info,
> -                                    unsigned int info_mode,
> +                                    unsigned int info_mode, int pidfd,
>                                      char __user *buf, size_t count)
>  {
>         int ret, total_bytes = 0, info_type = 0;
>         unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
> +       unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
>
>         /*
>          * Event info records order is as follows: dir fid + name, child fid.
> @@ -478,6 +504,16 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>                 total_bytes += ret;
>         }
>
> +       if (pidfd_mode) {
> +               ret = copy_pidfd_info_to_user(pidfd, buf, count);
> +               if (ret < 0)
> +                       return ret;
> +
> +               buf += ret;
> +               count -= ret;
> +               total_bytes += ret;
> +       }
> +
>         return total_bytes;
>  }
>
> @@ -489,8 +525,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         struct path *path = fanotify_event_path(event);
>         struct fanotify_info *info = fanotify_event_info(event);
>         unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
> +       unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
>         struct file *f = NULL;
> -       int ret, fd = FAN_NOFD;
> +       int ret, pidfd = 0, fd = FAN_NOFD;

It feels like this should be pidfd = FAN_NOPIDFD?

>
>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>
> @@ -524,6 +561,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         }
>         metadata.fd = fd;
>
> +       /*
> +        * Currently, reporting a pidfd to an unprivileged listener is not
> +        * supported. The FANOTIFY_UNPRIV flag is to be kept here so that a
> +        * pidfd is not accidentally leaked to an unprivileged listener.
> +        */
> +       if (pidfd_mode && !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) {
> +               /*
> +                * The PIDTYPE_TGID check for an event->pid is performed
> +                * preemptively in attempt to catch those rare instances
> +                * where the process responsible for generating the event has
> +                * terminated prior to calling into pidfd_create() and
> +                * acquiring a valid pidfd. Report FAN_NOPIDFD to the listener
> +                * in those cases.
> +                */
> +               if (metadata.pid == 0 ||
> +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> +                       pidfd = FAN_NOPIDFD;
> +               } else {
> +                       pidfd = pidfd_create(event->pid, 0);
> +                       if (pidfd < 0)
> +                               /*
> +                                * All other pidfd creation errors are reported
> +                                * as FAN_EPIDFD to the listener.
> +                                */
> +                               pidfd = FAN_EPIDFD;

That's an anti pattern. a multi-line statement, even due to comment should
be inside {}, but in this case, I think it is better to put this
comment as another
line in the big comment above which explains both the if and the else, because
it is in fact a continuation of the comment above.

> +               }
> +       }
> +
>         ret = -EFAULT;
>         /*
>          * Sanity check copy size in case get_one_event() and
> @@ -545,10 +610,19 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                 fd_install(fd, f);
>
>         if (info_mode) {
> -               ret = copy_info_records_to_user(event, info, info_mode,
> -                                               buf, count);
> +               /*
> +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> +                * exclusion is ever lifted. At the time of incorporating pidfd
> +                * support within fanotify, the pidfd API only supported the
> +                * creation of pidfds for thread-group leaders.
> +                */
> +               WARN_ON_ONCE(pidfd_mode &&
> +                            FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +

This WARN_ON, if needed at all, would be better places inside if (pidfd_mode &&
code block above where you would only need to
     WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
as close as possible to PIDTYPE_TGID line.

> +               ret = copy_info_records_to_user(event, info, info_mode, pidfd,
> +                                               buf, count);
>                 if (ret < 0)
> -                       return ret;
> +                       goto out_close_fd;

This looks like a bug in upstream.
It should have been goto out_close_fd to begin with.
We did already copy metadata.fd to user, but the read() call
returns an error.
You should probably fix it before the refactoring patch, so it
can be applied to stable kernels.

>         }
>
>         return metadata.event_len;
> @@ -558,6 +632,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                 put_unused_fd(fd);
>                 fput(f);
>         }
> +
> +       if (pidfd < 0)

That condition is reversed.
We do not seem to have any test coverage for this error handling
Not so surprising that upstream had a bug...

> +               put_unused_fd(pidfd);
> +
>         return ret;
>  }
>

Thanks,
Amir.
