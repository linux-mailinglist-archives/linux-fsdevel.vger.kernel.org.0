Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63DB3D2045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhGVIVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 04:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhGVIVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:21:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B3C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 02:01:53 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p186so5424059iod.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jul 2021 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yhsiokYt6SPwL0tm1Tg/050ZNsJyEUMf6hh1e7XhLs=;
        b=sERrwW0AyBO32fKi3JZG6Uk9+nOtI7+Hv3YDX0OW7dpMyp79u/ll7oZEhh7utwOnq0
         yDBf8oFfbGK5sfQHQoTE1kFoZAGpUNRr/z5P90HXklru5Jl6PMtDo43cLXh+tHKC8e8x
         YEfHhTwyrXJLpPp8cOw5LZU9bMNgaIub0tzKiV5xSsFmaHXxhn8T9/v2LDzWrb4OHyMH
         ApyM0+Fw4H40tpcN9Tkr+naSW8ASpkSZ9bbCKHjTiAuIxvXVjx/12wKcBI2EZuMzDCai
         wAxN9A25YH5Cm5c+jUfrWoGkPHMUlVID0Wtthxs0gqpkvwKqRIJEsbBLJSIkTlSgnFNQ
         bXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yhsiokYt6SPwL0tm1Tg/050ZNsJyEUMf6hh1e7XhLs=;
        b=lwFkF0pUDOaE/mlBtDwn4Hjl3UH4qKzKJP9I+5aGbjSpqA3Dr/oidal4YWUoGV7KDp
         evH0PxiNJ7RZZ4Jh0/u6sEaEcVDh/dg5rLXVcCvygKIKVTDQbbwasc5/k6WrOJtZPI8R
         rErhWDdDu7UN20ZrATJXWyU2f4hGrEhfAG2xY3Tosp/I3nfXjxdorJ2dfwfw2vpAHpgz
         Aw+QNLWOPbJ+l8dFz6D6c/TpCkwJyMsAPqWBGxV+2vsZaTjWNuq6nOxqkllhDckYq+2X
         RvQtBQPeP95mg5wdd5ICOv5Y0V4tTDXiCZvmM7aGal6HGMao0/4uQ10EjR61MbGaReen
         1/vA==
X-Gm-Message-State: AOAM533v0ZRkmkTkIpEv8SPUdQqWFpLxy1/HtPZcfbex7OfsvPs2PXhy
        4mRTBoQtFN23UCbb6eZF1iDjy3oigXpWZoLhn84=
X-Google-Smtp-Source: ABdhPJxnGeD5sLx+SUv4rx1+Vh5g/tuMLBH8EigDYxlxGc8KugG9Te7JYcZZZG2L0bqmYDcWhIcBvSQ/8ZsrPfAZce8=
X-Received: by 2002:a6b:7b44:: with SMTP id m4mr29734345iop.72.1626944513321;
 Thu, 22 Jul 2021 02:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210721125407.GA25822@kili> <YPih+xdLAJ2qQ/uW@google.com>
In-Reply-To: <YPih+xdLAJ2qQ/uW@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 22 Jul 2021 12:01:41 +0300
Message-ID: <CAOQ4uxgLZTTYV9h4SkCwYEm9D+Nd4VX5MbX8e-fUprsLOdPS2w@mail.gmail.com>
Subject: Re: [bug report] fanotify: fix copy_event_to_user() fid error clean up
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 1:39 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Wed, Jul 21, 2021 at 05:54:07AM -0700, Dan Carpenter wrote:
> > Hello Matthew Bobrowski,
> >
> > The patch f644bc449b37: "fanotify: fix copy_event_to_user() fid error
> > clean up" from Jun 11, 2021, leads to the following static checker
> > warning:
> >
> >       fs/notify/fanotify/fanotify_user.c:533 copy_event_to_user()
> >       error: we previously assumed 'f' could be null (see line 462)
>
> I've made a couple comments below. What am I missing?
>
> > fs/notify/fanotify/fanotify_user.c
> >     401 static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >     402                                 struct fanotify_event *event,
> >     403                                 char __user *buf, size_t count)
> >     404 {
> >     405       struct fanotify_event_metadata metadata;
> >     406       struct path *path = fanotify_event_path(event);
> >     407       struct fanotify_info *info = fanotify_event_info(event);
> >     408       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> >     409       struct file *f = NULL;
> >     410       int ret, fd = FAN_NOFD;
> >     411       int info_type = 0;
> >     412
> >     413       pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> >     414
> >     415       metadata.event_len = FAN_EVENT_METADATA_LEN +
> >     416                               fanotify_event_info_len(fid_mode, event);
> >     417       metadata.metadata_len = FAN_EVENT_METADATA_LEN;
> >     418       metadata.vers = FANOTIFY_METADATA_VERSION;
> >     419       metadata.reserved = 0;
> >     420       metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> >     421       metadata.pid = pid_vnr(event->pid);
> >     422       /*
> >     423        * For an unprivileged listener, event->pid can be used to identify the
> >     424        * events generated by the listener process itself, without disclosing
> >     425        * the pids of other processes.
> >     426        */
> >     427       if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> >     428           task_tgid(current) != event->pid)
> >     429               metadata.pid = 0;
> >     430
> >     431       /*
> >     432        * For now, fid mode is required for an unprivileged listener and
> >     433        * fid mode does not report fd in events.  Keep this check anyway
> >     434        * for safety in case fid mode requirement is relaxed in the future
> >     435        * to allow unprivileged listener to get events with no fd and no fid.
> >     436        */
> >     437       if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> >     438           path && path->mnt && path->dentry) {
> >     439               fd = create_fd(group, path, &f);
> >     440               if (fd < 0)
> >     441                       return fd;
> >     442       }
> >
> > "f" is NULL on the else path
>
> Uh ha, although "fd" on the else path also remains set to the initial value
> of FAN_NOFD, right?
>
> >     443       metadata.fd = fd;
> >     444
> >     445       ret = -EFAULT;
> >     446       /*
> >     447        * Sanity check copy size in case get_one_event() and
> >     448        * event_len sizes ever get out of sync.
> >     449        */
> >     450       if (WARN_ON_ONCE(metadata.event_len > count))
> >     451               goto out_close_fd;
> >     452
> >     453       if (copy_to_user(buf, &metadata, FAN_EVENT_METADATA_LEN))
> >     454               goto out_close_fd;
> >                         ^^^^^^^^^^^^^^^^^
> > This is problematic
> >
> >     455
> >     456       buf += FAN_EVENT_METADATA_LEN;
> >     457       count -= FAN_EVENT_METADATA_LEN;
> >     458
> >     459       if (fanotify_is_perm_event(event->mask))
> >     460               FANOTIFY_PERM(event)->fd = fd;
> >     461
> >     462       if (f)
> >                    ^^^
> >
> >     463               fd_install(fd, f);
> >     464
> >     465       /* Event info records order is: dir fid + name, child fid */
> >     466       if (fanotify_event_dir_fh_len(event)) {
> >     467               info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> >     468                                            FAN_EVENT_INFO_TYPE_DFID;
> >     469               ret = copy_info_to_user(fanotify_event_fsid(event),
> >     470                                       fanotify_info_dir_fh(info),
> >     471                                       info_type, fanotify_info_name(info),
> >     472                                       info->name_len, buf, count);
> >     473               if (ret < 0)
> >     474                       goto out_close_fd;
> >     475
> >     476               buf += ret;
> >     477               count -= ret;
> >     478       }
> >     479
> >     480       if (fanotify_event_object_fh_len(event)) {
> >     481               const char *dot = NULL;
> >     482               int dot_len = 0;
> >     483
> >     484               if (fid_mode == FAN_REPORT_FID || info_type) {
> >     485                       /*
> >     486                        * With only group flag FAN_REPORT_FID only type FID is
> >     487                        * reported. Second info record type is always FID.
> >     488                        */
> >     489                       info_type = FAN_EVENT_INFO_TYPE_FID;
> >     490               } else if ((fid_mode & FAN_REPORT_NAME) &&
> >     491                          (event->mask & FAN_ONDIR)) {
> >     492                       /*
> >     493                        * With group flag FAN_REPORT_NAME, if name was not
> >     494                        * recorded in an event on a directory, report the
> >     495                        * name "." with info type DFID_NAME.
> >     496                        */
> >     497                       info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
> >     498                       dot = ".";
> >     499                       dot_len = 1;
> >     500               } else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
> >     501                          (event->mask & FAN_ONDIR)) {
> >     502                       /*
> >     503                        * With group flag FAN_REPORT_DIR_FID, a single info
> >     504                        * record has type DFID for directory entry modification
> >     505                        * event and for event on a directory.
> >     506                        */
> >     507                       info_type = FAN_EVENT_INFO_TYPE_DFID;
> >     508               } else {
> >     509                       /*
> >     510                        * With group flags FAN_REPORT_DIR_FID|FAN_REPORT_FID,
> >     511                        * a single info record has type FID for event on a
> >     512                        * non-directory, when there is no directory to report.
> >     513                        * For example, on FAN_DELETE_SELF event.
> >     514                        */
> >     515                       info_type = FAN_EVENT_INFO_TYPE_FID;
> >     516               }
> >     517
> >     518               ret = copy_info_to_user(fanotify_event_fsid(event),
> >     519                                       fanotify_event_object_fh(event),
> >     520                                       info_type, dot, dot_len, buf, count);
> >     521               if (ret < 0)
> >     522                       goto out_close_fd;
> >                                 ^^^^^^^^^^^^^^^^^
> >
> >
> >     523
> >     524               buf += ret;
> >     525               count -= ret;
> >     526       }
> >     527
> >     528       return metadata.event_len;
> >     529
> >     530 out_close_fd:
> >     531       if (fd != FAN_NOFD) {
> >     532               put_unused_fd(fd);
> > --> 533               fput(f);
> >                         ^^^^^^^
> > This leads to a NULL dereference
>
> Sure would, however if the intial else path is taken above skipping
> create_fd() then "fd" would remain set to FAN_NOFD and "f" would remain set
> to NULL, then this branch would not be taken and thus not leading to a NULL
> dereference?
>
> To make things clearer, avoid any future confusion and possibly tripping
> over such a bug, perhaps it'd be better to split up the fput(f) call into a
> separate branch outside of the current conditional, simply i.e.
>
> ...
>
> if (f)
>         fput(f);
>
> ...
>
> Thoughts?

smatch (apparently) does not know about the relation that f is non NULL
if (fd ==  FAN_NOFD) it needs to study create_fd() for that.

I suggest to move fd_install(fd, f); right after checking of return value
from create_fd() and without the if (f) condition.
That should make it clear for human and robots reading this function
that the cleanup in out_close_fd label is correct.

Thanks,
Amir.
