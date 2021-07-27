Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472153D7102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhG0IQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhG0IQp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:16:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE931C061757;
        Tue, 27 Jul 2021 01:16:44 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r18so15030432iot.4;
        Tue, 27 Jul 2021 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sP8eKZ1XYYokuigntJ2pKqnPDXKqzr0gADQFPYAP/F0=;
        b=ZIbksXglz0e8nvEHWrY+mdEE+bNMt2sZuDLW6CpWne4HLRmCnyaT6SJNUOEPzXzdC1
         qqF8bmMlLkkYY58+O6NVL+7ZvYdEstzp8OL8m84rAnCkAOAzav+aPNeWUvYKPUyR2yjK
         xB5770Ay737fd/KiQdUUbDdXySit084aH4fC2QsGfAlYnbHGl9iNBoCGJdwSbYqh0H9h
         +zGJEnXlTbqCIuv9xOoN8IucdY86g93Rl/pEC0cL6w3zRSQMHtBK5bmF+TxC+5/r+Mxv
         fFagCnQvY1IKer0kANqp99tip0dmwWf+qHrVpsTE0wCKa36EmxEcMqfnaDqGk9MBL0+E
         yBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sP8eKZ1XYYokuigntJ2pKqnPDXKqzr0gADQFPYAP/F0=;
        b=Rgw+P6+z/ByRq9kQ/ACvRNQmN0HR9o9hrdXJK3itis2BDI6SqitjxC1tNVY6g7M8uJ
         v6Bi0i38+AGiUK+nMoQXmMdhKOpOThAhlMmVTdwwcwiIitn4T0vctSjlXOXEErcU8+LN
         s6XCdrACXop6VPlnm044lOSvGImiuJ1MFcNWwY2Ar6Ue98serCdI0kXHOwT/16OzYSsw
         Ystfm8JJCCBT+LwfOMS1xAvHXS8KV/Vlwgvp8HWl3qgKTFtf1AWk3UG/hDM0KC/3I4xk
         YCeMZ4c+fRI9HjJVx/bZt4YSfpSUsDSaPq0Q+OswDhsQQPn83nhQX7ltUkaZ5wOh4818
         Zu1Q==
X-Gm-Message-State: AOAM532s+Y/1uI9oji0B7XdhsQSW3e6fDhD5149FVtP99ju5xOGPmssH
        X4ZcN+LiRzykpRB7Ah0pkwHpkJac7kI6lHHJxls=
X-Google-Smtp-Source: ABdhPJyzTxUEARhWR3GJXMzMXYIDCi9AdH6GOVhq6lMHJTWBTHL+qtdQTPGOL49nz+Vc/ybGO3vUwcPwP9VE70uGoWA=
X-Received: by 2002:a6b:7b44:: with SMTP id m4mr17981714iop.72.1627373804363;
 Tue, 27 Jul 2021 01:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <5ac9237ed6f055613c817eb1b9eedcaf1e53d4e6.1626845288.git.repnop@google.com>
 <CAOQ4uxj8jzdT4uKzE7hFDo=KwiyH+E0GHbHpToWRpFZ+zX3fhw@mail.gmail.com>
In-Reply-To: <CAOQ4uxj8jzdT4uKzE7hFDo=KwiyH+E0GHbHpToWRpFZ+zX3fhw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jul 2021 11:16:33 +0300
Message-ID: <CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com>
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

On Wed, Jul 21, 2021 at 9:35 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jul 21, 2021 at 9:18 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > The copy_info_records_to_user() helper allows for the separation of
> > info record copying routines/conditionals from copy_event_to_user(),
> > which reduces the overall clutter within this function. This becomes
> > especially true as we start introducing additional info records in the
> > future i.e. struct fanotify_event_info_pidfd. On success, this helper
> > returns the total amount of bytes that have been copied into the user
> > supplied buffer and on error, a negative value is returned to the
> > caller.
> >
> > The newly defined macro FANOTIFY_INFO_MODES can be used to obtain info
> > record types that have been enabled for a specific notification
> > group. This macro becomes useful in the subsequent patch when the
> > FAN_REPORT_PIDFD initialization flag is introduced.
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 155 ++++++++++++++++-------------
> >  include/linux/fanotify.h           |   2 +
> >  2 files changed, 90 insertions(+), 67 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 182fea255376..d19f70b2c24c 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -173,7 +173,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> >         size_t event_size = FAN_EVENT_METADATA_LEN;
> >         struct fanotify_event *event = NULL;
> >         struct fsnotify_event *fsn_event;
> > -       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > +       unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
> >
> >         pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
> >
> > @@ -183,8 +183,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> >                 goto out;
> >
> >         event = FANOTIFY_E(fsn_event);
> > -       if (fid_mode)
> > -               event_size += fanotify_event_info_len(fid_mode, event);
> > +       if (info_mode)
> > +               event_size += fanotify_event_info_len(info_mode, event);
> >
> >         if (event_size > count) {
> >                 event = ERR_PTR(-EINVAL);
> > @@ -401,6 +401,86 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >         return info_len;
> >  }
> >
> > +static int copy_info_records_to_user(struct fanotify_event *event,
> > +                                    struct fanotify_info *info,
> > +                                    unsigned int info_mode,
> > +                                    char __user *buf, size_t count)
> > +{
> > +       int ret, total_bytes = 0, info_type = 0;
> > +       unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
> > +
> > +       /*
> > +        * Event info records order is as follows: dir fid + name, child fid.
> > +        */
> > +       if (fanotify_event_dir_fh_len(event)) {
> > +               info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> > +                                            FAN_EVENT_INFO_TYPE_DFID;
> > +               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> > +                                           fanotify_info_dir_fh(info),
> > +                                           info_type,
> > +                                           fanotify_info_name(info),
> > +                                           info->name_len, buf, count);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               buf += ret;
> > +               count -= ret;
> > +               total_bytes += ret;
> > +       }
> > +
> > +       if (fanotify_event_object_fh_len(event)) {
> > +               const char *dot = NULL;
> > +               int dot_len = 0;
> > +
> > +               if (fid_mode == FAN_REPORT_FID || info_type) {
> > +                       /*
> > +                        * With only group flag FAN_REPORT_FID only type FID is
> > +                        * reported. Second info record type is always FID.
> > +                        */
> > +                       info_type = FAN_EVENT_INFO_TYPE_FID;
> > +               } else if ((fid_mode & FAN_REPORT_NAME) &&
> > +                          (event->mask & FAN_ONDIR)) {
> > +                       /*
> > +                        * With group flag FAN_REPORT_NAME, if name was not
> > +                        * recorded in an event on a directory, report the name
> > +                        * "." with info type DFID_NAME.
> > +                        */
> > +                       info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
> > +                       dot = ".";
> > +                       dot_len = 1;
> > +               } else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
> > +                          (event->mask & FAN_ONDIR)) {
> > +                       /*
> > +                        * With group flag FAN_REPORT_DIR_FID, a single info
> > +                        * record has type DFID for directory entry
> > +                        * modificatio\ n event and for event on a directory.

Just notices this typo in the copied comment:
modificatio\ n

And for the next posting, please remove the mention of fanotify_user.c from
the commit title - it adds no information and clutters the git oneline log.
This concerns patch 3/5 as well. It does NOT concern the kernel/pid.c patches.

Thanks,
Amir.
