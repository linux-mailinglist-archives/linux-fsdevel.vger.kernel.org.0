Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836773D756C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhG0M5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhG0M5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:57:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60DEC061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 05:57:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso4107425pjq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+OLe4SwBjD3Geveq3gUDmMMou2dUigqaRFQxgLA7Ezk=;
        b=QSHIwZzUgPD2aHYSt5mb+1L8fBEQhacAJ7ZZuQ84aRa7gl3nBmKm3ReBjI4TzrlzaA
         +I303AH1H1KlcVC6LIi97rJZTzCvf/w0abGqkvMEqB7Mc0hfU7+j8XiIO2p6TE/ProMv
         hugmB2GMlbKeZ186yHV2xknYU1ffhqrVhzsuJQGXHPSrbtTj5PzyThbJ0IOK773IzZtU
         j3NUQSdfmCxPdi7vTgmXQBiBptOJrIqwK+5+ox1i4aljLznMG0vsGeISfu0tMcsqqH85
         AmlcMaDYVsbwCEyVMI8QT3JTd7dRbPsMV41LutqApx9Z2gO9Ki8ZIUaIxwbTHVhL7/9+
         CNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+OLe4SwBjD3Geveq3gUDmMMou2dUigqaRFQxgLA7Ezk=;
        b=CVqOKA1moi2saTscZ+UXK+oXiR00YkwQtobXBHyhV1ZtwOgUis2mZzJdOLiSta6sHB
         AK2mAmzHREZPeXN2OCDwcn65bxwDA25uSA3DlutsfpIWJQ8t4/zGP+vRVcgTaWOh/jRf
         sCqLAAJuQrVrlfEjoTnjRXEbX2hAzVJEEYXZgnAHZn4iL3umQEMqF2/hvOYCb5/qMpVK
         CP7/r23p7vs3mMe1W7rW0hw9J+I9lREg4wtjOksqfSHJsCr+dIuXNB8jueOlWdPImBnm
         UXjut+4wAfkojijDZhvondJtZuViL3LXAfX9Jol6V7zqgO+ySIsVuoXj0m7zzRDqWCKh
         fjxg==
X-Gm-Message-State: AOAM5327sqgehEoyWSSzVGx1sRfdYMDK1d0CPqE3zyBnF7JnmF5RmNZa
        VOcI+adtcktxEWHRj9V1usG1fQ==
X-Google-Smtp-Source: ABdhPJwFPlVfauZjy+10jsZ+iisjwQLAANVlBKN5kkwy+6GgSXjIrLx6kl1kcpGRCtitAhDHA9r7Lw==
X-Received: by 2002:a17:902:868b:b029:12b:84f8:d916 with SMTP id g11-20020a170902868bb029012b84f8d916mr18770845plo.75.1627390668985;
        Tue, 27 Jul 2021 05:57:48 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c654:968d:5171:3855])
        by smtp.gmail.com with ESMTPSA id o2sm3853542pfp.28.2021.07.27.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 05:57:48 -0700 (PDT)
Date:   Tue, 27 Jul 2021 22:57:37 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] fanotify/fanotify_user.c: introduce a generic
 info record copying helper
Message-ID: <YQACwX4i1UjWqtfZ@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <5ac9237ed6f055613c817eb1b9eedcaf1e53d4e6.1626845288.git.repnop@google.com>
 <CAOQ4uxj8jzdT4uKzE7hFDo=KwiyH+E0GHbHpToWRpFZ+zX3fhw@mail.gmail.com>
 <CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:16:33AM +0300, Amir Goldstein wrote:
> On Wed, Jul 21, 2021 at 9:35 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Jul 21, 2021 at 9:18 AM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > The copy_info_records_to_user() helper allows for the separation of
> > > info record copying routines/conditionals from copy_event_to_user(),
> > > which reduces the overall clutter within this function. This becomes
> > > especially true as we start introducing additional info records in the
> > > future i.e. struct fanotify_event_info_pidfd. On success, this helper
> > > returns the total amount of bytes that have been copied into the user
> > > supplied buffer and on error, a negative value is returned to the
> > > caller.
> > >
> > > The newly defined macro FANOTIFY_INFO_MODES can be used to obtain info
> > > record types that have been enabled for a specific notification
> > > group. This macro becomes useful in the subsequent patch when the
> > > FAN_REPORT_PIDFD initialization flag is introduced.
> > >
> > > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > > ---
> > >  fs/notify/fanotify/fanotify_user.c | 155 ++++++++++++++++-------------
> > >  include/linux/fanotify.h           |   2 +
> > >  2 files changed, 90 insertions(+), 67 deletions(-)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 182fea255376..d19f70b2c24c 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -173,7 +173,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> > >         size_t event_size = FAN_EVENT_METADATA_LEN;
> > >         struct fanotify_event *event = NULL;
> > >         struct fsnotify_event *fsn_event;
> > > -       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > > +       unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
> > >
> > >         pr_debug("%s: group=%p count=%zd\n", __func__, group, count);
> > >
> > > @@ -183,8 +183,8 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
> > >                 goto out;
> > >
> > >         event = FANOTIFY_E(fsn_event);
> > > -       if (fid_mode)
> > > -               event_size += fanotify_event_info_len(fid_mode, event);
> > > +       if (info_mode)
> > > +               event_size += fanotify_event_info_len(info_mode, event);
> > >
> > >         if (event_size > count) {
> > >                 event = ERR_PTR(-EINVAL);
> > > @@ -401,6 +401,86 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> > >         return info_len;
> > >  }
> > >
> > > +static int copy_info_records_to_user(struct fanotify_event *event,
> > > +                                    struct fanotify_info *info,
> > > +                                    unsigned int info_mode,
> > > +                                    char __user *buf, size_t count)
> > > +{
> > > +       int ret, total_bytes = 0, info_type = 0;
> > > +       unsigned int fid_mode = info_mode & FANOTIFY_FID_BITS;
> > > +
> > > +       /*
> > > +        * Event info records order is as follows: dir fid + name, child fid.
> > > +        */
> > > +       if (fanotify_event_dir_fh_len(event)) {
> > > +               info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
> > > +                                            FAN_EVENT_INFO_TYPE_DFID;
> > > +               ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> > > +                                           fanotify_info_dir_fh(info),
> > > +                                           info_type,
> > > +                                           fanotify_info_name(info),
> > > +                                           info->name_len, buf, count);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +
> > > +               buf += ret;
> > > +               count -= ret;
> > > +               total_bytes += ret;
> > > +       }
> > > +
> > > +       if (fanotify_event_object_fh_len(event)) {
> > > +               const char *dot = NULL;
> > > +               int dot_len = 0;
> > > +
> > > +               if (fid_mode == FAN_REPORT_FID || info_type) {
> > > +                       /*
> > > +                        * With only group flag FAN_REPORT_FID only type FID is
> > > +                        * reported. Second info record type is always FID.
> > > +                        */
> > > +                       info_type = FAN_EVENT_INFO_TYPE_FID;
> > > +               } else if ((fid_mode & FAN_REPORT_NAME) &&
> > > +                          (event->mask & FAN_ONDIR)) {
> > > +                       /*
> > > +                        * With group flag FAN_REPORT_NAME, if name was not
> > > +                        * recorded in an event on a directory, report the name
> > > +                        * "." with info type DFID_NAME.
> > > +                        */
> > > +                       info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
> > > +                       dot = ".";
> > > +                       dot_len = 1;
> > > +               } else if ((event->mask & ALL_FSNOTIFY_DIRENT_EVENTS) ||
> > > +                          (event->mask & FAN_ONDIR)) {
> > > +                       /*
> > > +                        * With group flag FAN_REPORT_DIR_FID, a single info
> > > +                        * record has type DFID for directory entry
> > > +                        * modificatio\ n event and for event on a directory.
> 
> Just notices this typo in the copied comment:
> modificatio\ n
> 
> And for the next posting, please remove the mention of fanotify_user.c from
> the commit title - it adds no information and clutters the git oneline log.
> This concerns patch 3/5 as well. It does NOT concern the kernel/pid.c patches.

Noted.

/M
