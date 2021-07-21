Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6E53D08FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhGUFys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhGUFyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:54:46 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1987C061574;
        Tue, 20 Jul 2021 23:35:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v26so1155208iom.11;
        Tue, 20 Jul 2021 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1uJAgYZ/Oc4JHLBzSVMNZPEXe0EH86/omgrRve02Kg=;
        b=hSLqggjE/c223eJhdCG0k6xZt0vQantraeLGVmLH4NyPWRsNc8AEmV3CAHVzhC+OQE
         nxZMhTYDds3KShqv8Tx10Tb1YmrttWNh5ExGsXHurJol2thLtOzC3IWsz+RDos+EqL/k
         rcgrXyaSWyVJQPgjCem51wR5lyiD00ieC7VtD+jGoMWZ1Lcw4KnVv79opsPhLZscHkuo
         oBEtLxqVUHSHONT6OEfFxWFqtq+oOsQRVolAfRGXU0CjViPSfEUkIzUPgFipJ+HKMYP1
         e+abRfFqKg6F4otkEt3yVzJC4s3VXqnTuGVEmFxzaiv1U4vnHwxs7czOwbkXtbWBi3iM
         Tsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1uJAgYZ/Oc4JHLBzSVMNZPEXe0EH86/omgrRve02Kg=;
        b=E4uR+q3lPtAY5QjQxax1gOOgZN0uQToaYYXx9e67PGf+50v6ED0gOmc3Xi86WFB8MS
         mHVA7B2e9d6eNa3fg67xGfEMOp+3IETDDVffhWiaY8o6n8k/PPobdMHvT5JAHFSttkJb
         AWEJzKI+hL7f1WOaSQOgKIX0tEJ+2Wlt3XS4pLagevIweOJuvPKS8ioK7QnbN9grwLul
         btKQRenQtj/XDMput6fiMPyuFYJEabfBqO17jJPhXQsXhN2D9un9nii8b2PlK2h7VZvg
         4J5pVFRI4N8Us1hcJmUHLrqpaZZ5xdk+5vCSAbZdqjcXG97OfsavBgdHfd+sLgjzlQ4l
         1Vhg==
X-Gm-Message-State: AOAM532NMrz97/3jNzwBOthA1P7fdDkdrL98ffzL21XSsgUH1R6h6nsb
        05q7b4PBbDaJBGNrAaXazeUq9HX2SrYForN3L5Q=
X-Google-Smtp-Source: ABdhPJyW/lVrvLFTmbxoRKp6rXxcn8wluibYq/AlDZrzuJYWszPR3ggE89X9LHKRiOfBiNZniYyY1oV96idENwtYwJ4=
X-Received: by 2002:a05:6602:3304:: with SMTP id b4mr25550933ioz.186.1626849321322;
 Tue, 20 Jul 2021 23:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <5ac9237ed6f055613c817eb1b9eedcaf1e53d4e6.1626845288.git.repnop@google.com>
In-Reply-To: <5ac9237ed6f055613c817eb1b9eedcaf1e53d4e6.1626845288.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 09:35:09 +0300
Message-ID: <CAOQ4uxj8jzdT4uKzE7hFDo=KwiyH+E0GHbHpToWRpFZ+zX3fhw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] fanotify/fanotify_user.c: introduce a generic info
 record copying helper
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 9:18 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> The copy_info_records_to_user() helper allows for the separation of
> info record copying routines/conditionals from copy_event_to_user(),
> which reduces the overall clutter within this function. This becomes
> especially true as we start introducing additional info records in the
> future i.e. struct fanotify_event_info_pidfd. On success, this helper
> returns the total amount of bytes that have been copied into the user
> supplied buffer and on error, a negative value is returned to the
> caller.
>
> The newly defined macro FANOTIFY_INFO_MODES can be used to obtain info
> record types that have been enabled for a specific notification
> group. This macro becomes useful in the subsequent patch when the
> FAN_REPORT_PIDFD initialization flag is introduced.
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify_user.c | 155 ++++++++++++++++-------------
>  include/linux/fanotify.h           |   2 +
>  2 files changed, 90 insertions(+), 67 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 182fea255376..d19f70b2c24c 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -173,7 +173,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>         size_t event_size = FAN_EVENT_METADATA_LEN;
>         struct fanotify_event *event = NULL;
>         struct fsnotify_event *fsn_event;
> -       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> +       unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
>
>         pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
>
> @@ -183,8 +183,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
>                 goto out;
>
>         event = FANOTIFY_E(fsn_event);
> -       if (fid_mode)
> -               event_size += fanotify_event_info_len(fid_mode, event);
> +       if (info_mode)
> +               event_size += fanotify_event_info_len(info_mode, event);
>
>         if (event_size > count) {
>                 event = ERR_PTR(-EINVAL);
> @@ -401,6 +401,86 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>         return info_len;
>  }
>
> +static int copy_info_records_to_user(struct fanotify_event *event,
> +                                    struct fanotify_info *info,
> +                                    unsigned int info_mode,
> +                                    char __user *buf, size_t count)
> +{
> +       int ret, total_bytes = 0, info_type = 0;
> +       unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
> +
> +       /*
> +        * Event info records order is as follows: dir fid + name, child fid.
> +        */
> +       if (fanotify_event_dir_fh_len(event)) {
> +               info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> +                                            FAN_EVENT_INFO_TYPE_DFID;
> +               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> +                                           fanotify_info_dir_fh(info),
> +                                           info_type,
> +                                           fanotify_info_name(info),
> +                                           info->name_len, buf, count);
> +               if (ret < 0)
> +                       return ret;
> +
> +               buf += ret;
> +               count -= ret;
> +               total_bytes += ret;
> +       }
> +
> +       if (fanotify_event_object_fh_len(event)) {
> +               const char *dot = NULL;
> +               int dot_len = 0;
> +
> +               if (fid_mode == FAN_REPORT_FID || info_type) {
> +                       /*
> +                        * With only group flag FAN_REPORT_FID only type FID is
> +                        * reported. Second info record type is always FID.
> +                        */
> +                       info_type = FAN_EVENT_INFO_TYPE_FID;
> +               } else if ((fid_mode & FAN_REPORT_NAME) &&
> +                          (event->mask & FAN_ONDIR)) {
> +                       /*
> +                        * With group flag FAN_REPORT_NAME, if name was not
> +                        * recorded in an event on a directory, report the name
> +                        * "." with info type DFID_NAME.
> +                        */
> +                       info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
> +                       dot = ".";
> +                       dot_len = 1;
> +               } else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
> +                          (event->mask & FAN_ONDIR)) {
> +                       /*
> +                        * With group flag FAN_REPORT_DIR_FID, a single info
> +                        * record has type DFID for directory entry
> +                        * modificatio\ n event and for event on a directory.
> +                        */
> +                       info_type = FAN_EVENT_INFO_TYPE_DFID;
> +               } else {
> +                       /*
> +                        * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
> +                        * a single info record has type FID for event on a
> +                        * non-directory, when there is no directory to report.
> +                        * For example, on FAN_DELETE_SELF event.
> +                        */
> +                       info_type = FAN_EVENT_INFO_TYPE_FID;
> +               }
> +
> +               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> +                                           fanotify_event_object_fh(event),
> +                                           info_type, dot, dot_len,
> +                                           buf, count);
> +               if (ret < 0)
> +                       return ret;
> +
> +               buf += ret;
> +               count -= ret;
> +               total_bytes += ret;
> +       }
> +
> +       return total_bytes;
> +}
> +
>  static ssize_t copy_event_to_user(struct fsnotify_group *group,
>                                   struct fanotify_event *event,
>                                   char __user *buf, size_t count)
> @@ -408,15 +488,14 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         struct fanotify_event_metadata metadata;
>         struct path *path = fanotify_event_path(event);
>         struct fanotify_info *info = fanotify_event_info(event);
> -       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> +       unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
>         struct file *f = NULL;
>         int ret, fd = FAN_NOFD;
> -       int info_type = 0;
>
>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
>
>         metadata.event_len = FAN_EVENT_METADATA_LEN +
> -                               fanotify_event_info_len(fid_mode, event);
> +                               fanotify_event_info_len(info_mode, event);
>         metadata.metadata_len = FAN_EVENT_METADATA_LEN;
>         metadata.vers = FANOTIFY_METADATA_VERSION;
>         metadata.reserved = 0;
> @@ -465,69 +544,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>         if (f)
>                 fd_install(fd, f);
>
> -       /* Event info records order is: dir fid + name, child fid */
> -       if (fanotify_event_dir_fh_len(event)) {
> -               info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> -                                            FAN_EVENT_INFO_TYPE_DFID;
> -               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> -                                           fanotify_info_dir_fh(info),
> -                                           info_type,
> -                                           fanotify_info_name(info),
> -                                           info->name_len, buf, count);
> -               if (ret < 0)
> -                       goto out_close_fd;
> -
> -               buf += ret;
> -               count -= ret;
> -       }
> -
> -       if (fanotify_event_object_fh_len(event)) {
> -               const char *dot = NULL;
> -               int dot_len = 0;
> -
> -               if (fid_mode == FAN_REPORT_FID || info_type) {
> -                       /*
> -                        * With only group flag FAN_REPORT_FID only type FID is
> -                        * reported. Second info record type is always FID.
> -                        */
> -                       info_type = FAN_EVENT_INFO_TYPE_FID;
> -               } else if ((fid_mode & FAN_REPORT_NAME) &&
> -                          (event->mask & FAN_ONDIR)) {
> -                       /*
> -                        * With group flag FAN_REPORT_NAME, if name was not
> -                        * recorded in an event on a directory, report the
> -                        * name "." with info type DFID_NAME.
> -                        */
> -                       info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
> -                       dot = ".";
> -                       dot_len = 1;
> -               } else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
> -                          (event->mask & FAN_ONDIR)) {
> -                       /*
> -                        * With group flag FAN_REPORT_DIR_FID, a single info
> -                        * record has type DFID for directory entry modification
> -                        * event and for event on a directory.
> -                        */
> -                       info_type = FAN_EVENT_INFO_TYPE_DFID;
> -               } else {
> -                       /*
> -                        * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
> -                        * a single info record has type FID for event on a
> -                        * non-directory, when there is no directory to report.
> -                        * For example, on FAN_DELETE_SELF event.
> -                        */
> -                       info_type = FAN_EVENT_INFO_TYPE_FID;
> -               }
> -
> -               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> -                                           fanotify_event_object_fh(event),
> -                                           info_type, dot, dot_len,
> -                                           buf, count);
> +       if (info_mode) {
> +               ret = copy_info_records_to_user(event, info, info_mode,
> +                                               buf, count);
>                 if (ret < 0)
>                         goto out_close_fd;
> -
> -               buf += ret;
> -               count -= ret;
>         }
>
>         return metadata.event_len;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index a16dbeced152..10a7e26ddba6 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -27,6 +27,8 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>
>  #define FANOTIFY_FID_BITS      (FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
>
> +#define FANOTIFY_INFO_MODES    (FANOTIFY_FID_BITS)
> +
>  /*
>   * fanotify_init() flags that require CAP_SYS_ADMIN.
>   * We do not allow unprivileged groups to request permission events.
> --
> 2.32.0.432.gabb21c7263-goog
>
> /M
