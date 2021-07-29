Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43A3DAF73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 00:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhG2WtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhG2WtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:49:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0CC061765
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 15:49:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l19so12456126pjz.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cud3OIkgb3qTpL75CZeQ4prefyp9kbYPmFH5eW7nSl0=;
        b=pngrPVc1ThDnBlTMX37huWkZLhfwyBbhEvacbRWVmsLUTE698eeDlGMCjL1HcKZ2Y5
         2UZmcnqRNphPnwhBqA8a70FfJkN3VoLf4zE0/xICG4dPOmnqMYLxvBpcAxYVWJLf2cvi
         gy+8a6msQAmlTsJT9W0R7Q5vjf4Ize3MMZBDfTaX2qVnPRrXix4okmMsnUOMyp8tVgas
         AEHd37T8235msNSausxzC7/6bIfZxPmHmW0vigz5ZvAKYKQjmrwyYLkDYtmePhv4bDKO
         0HT7i88Wk9R7ybF4w3QFyEz8S5w7lN51oFp8o1bXVBYwn9Z5WlwNwa5hQB577Qy+rwvK
         3VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cud3OIkgb3qTpL75CZeQ4prefyp9kbYPmFH5eW7nSl0=;
        b=YMLqFQgX6au07JmhnIyCtX+PAGfHrBLyR7ek41pPD5/yo/CzeHFdnZ2NcHob+a5Hgs
         YtUr65hTEn786qbgMisXncGo17vJGhjurkHU3de+8bqCCcHqHJEMZZeowgBul+1aTw2O
         EctFtO9+he4cxpd3gXtWKzXY9p7jPUrbneDzsUFV0nKO+6KQtKkN4uI0om9c6hIdyPNT
         KRAwyGLXfi+o++e67SscYDzM8Ha1Z/jL7Da8/Vtc1I63Or2swmEiadYcbNvh7XPC+RRQ
         7SBwgtIjmLynd0alTvD/ius4XcHNKzAgy/kApTp4c0IYqU+NT+kA5ToP0+HiypMj4Q3G
         VL4w==
X-Gm-Message-State: AOAM5319lnjnCWkPuq1/9cQerZ4rvkPugEjM8/B1M8A4ChSa+MvXLIJc
        rPN47tmNBQM2bI+VkNLsdLslhw==
X-Google-Smtp-Source: ABdhPJy4PXErrWgDXOCNXUSpbIXGeRYQnnjP5FknlN72tzyDYHxD4GkLjobNpmAyfUemapUXSC8gEQ==
X-Received: by 2002:a05:6a00:158e:b029:32b:9de5:a199 with SMTP id u14-20020a056a00158eb029032b9de5a199mr7229064pfk.76.1627598943460;
        Thu, 29 Jul 2021 15:49:03 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com. [35.240.157.64])
        by smtp.gmail.com with ESMTPSA id w15sm4340796pjc.45.2021.07.29.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:49:02 -0700 (PDT)
Date:   Thu, 29 Jul 2021 22:48:54 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YQMwVjLir+KYOTpY@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <YQAB+peigKOy/66O@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAB+peigKOy/66O@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:54:18PM +1000, Matthew Bobrowski wrote:
> Hey Jann,
> 
> On Tue, Jul 27, 2021 at 02:23:38AM +0200, Jann Horn wrote:
> > On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > allows userspace applications to control whether a pidfd info record
> > > containing a pidfd is to be returned with each event.
> > >
> > > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > > struct fanotify_event_info_pidfd object will be supplied alongside the
> > > generic struct fanotify_event_metadata within a single event. This
> > > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > > the event structure is supplied to the userspace application. Usage of
> > > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > > permitted, and in this case a struct fanotify_event_info_pidfd object
> > > will follow any struct fanotify_event_info_fid object.
> > >
> > > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > > limited to privileged processes only i.e. listeners that are running
> > > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > > these initialization flags with FAN_REPORT_PIDFD will result with
> > > EINVAL being returned to the caller.
> > >
> > > In the event of a pidfd creation error, there are two types of error
> > > values that can be reported back to the listener. There is
> > > FAN_NOPIDFD, which will be reported in cases where the process
> > > responsible for generating the event has terminated prior to fanotify
> > > being able to create pidfd for event->pid via pidfd_create(). The
> > > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > > creation error occurred when calling pidfd_create().
> > [...]
> > > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > >         }
> > >         metadata.fd = fd;
> > >
> > > +       if (pidfd_mode) {
> > > +               /*
> > > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > > +                * support within fanotify, the pidfd API only supported the
> > > +                * creation of pidfds for thread-group leaders.
> > > +                */
> > > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > > +
> > > +               /*
> > > +                * The PIDTYPE_TGID check for an event->pid is performed
> > > +                * preemptively in attempt to catch those rare instances where
> > > +                * the process responsible for generating the event has
> > > +                * terminated prior to calling into pidfd_create() and acquiring
> > > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > > +                * cases. All other pidfd creation errors are represented as
> > > +                * FAN_EPIDFD.
> > > +                */
> > > +               if (metadata.pid == 0 ||
> > > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > +                       pidfd = FAN_NOPIDFD;
> > > +               } else {
> > > +                       pidfd = pidfd_create(event->pid, 0);
> > > +                       if (pidfd < 0)
> > > +                               pidfd = FAN_EPIDFD;
> > > +               }
> > > +       }
> > > +
> > 
> > As a general rule, f_op->read callbacks aren't allowed to mess with
> > the file descriptor table of the calling process. A process should be
> > able to receive a file descriptor from an untrusted source and call
> > functions like read() on it without worrying about affecting its own
> > file descriptor table state with that.
> 
> Interesting, thanks for bringing this up. I never knew about this general
> rule. Do you mind elaborating a little on why f_op->read() callbacks aren't
> allowed to mess with the fdtable of the calling process? I don't quite
> exactly understand why this is considered to be suboptimal.

Nevermind. I done a little extra thinking about this and I can see exactly why
this could be problematic.

/M
