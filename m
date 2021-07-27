Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB33D6D33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 06:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhG0ET6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 00:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhG0ETz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:19:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4B4C061757;
        Mon, 26 Jul 2021 21:19:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y9so14516539iox.2;
        Mon, 26 Jul 2021 21:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HyQEWajs6gKlK2el13XxS19mM05zk1DJ2vAxQiaDAQ=;
        b=mUzJ3W3C7KCmdXS9UKfil6/cjzcAZ9jB4dQKO3Vt9CFu7f2e749c+s9CXNErbZdtSI
         XALPH7IQeOcmZH1uFDAvfQ0cDs2MNSj8BSodF6fOf2NhpUoNCaFQu+HLgwugihW+IQdn
         Jojy0diicPHVvJ4ESnqSSe2zooB2xWlk0o+7XrzRCeIfM6XaAEmqtYfsV3YEqo55tzA+
         fjvjmeHFPv4kh7YgzUuCRtiMbrRg3qGdLTTiIhKcEq7kVT/clz/CpBn82aw6JtDVo9DW
         Xoo6QXOcoIr6IZNG5GQfxDAyrtLMX11XDsjboZAjiiW1kvCJUosf5pGV5UVW1oNoJ8UM
         jrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HyQEWajs6gKlK2el13XxS19mM05zk1DJ2vAxQiaDAQ=;
        b=cv7boEdcP4K6elDumdp+a+mpRF5qRlSsaWi5+G5i19sN8z9ml90BrUs/E3RnxREzeV
         aUa6d9/ipQYtzgt+SohNB9kHg3nfjZ2YO9+nLpgP5wyV1hn9FllvF/XTfy2xkEWpGjkt
         DClBe2I6fr8QqonZf0IoailRNQGhqZ6Q4SDx78METY7zypx/yNKPP1pl2VqpeuvHFtz/
         u5Cr9NB3alftijTHgjeBRoFxHCgoSLoJru3ff3g0iC4QNNBm/G61btpv1TON4zS5uE6l
         DfOs5yR55taiynI1MFEc2glmXqdgY5RlPiw37q5GiBqCF3+Ox/NbfqYgwT0FFIGkvsKs
         Zp7Q==
X-Gm-Message-State: AOAM530yD43gE+YZr6AzVSOuyLLlxRV1Zuix8FfqueveT9NgViF1auRT
        Y/J6mQZHH9Hxm8/94S+6EjBPe7+BUC11EycHBvU=
X-Google-Smtp-Source: ABdhPJx9YfK9Plnjg/IpeAKDminFtUX/ciSMbGc2dhhy2O9WnQL7sa7bdValjP7git4DMDU3vtTUZIMg2uI1KWONkE8=
X-Received: by 2002:a05:6638:1907:: with SMTP id p7mr19823533jal.93.1627359595126;
 Mon, 26 Jul 2021 21:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
In-Reply-To: <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jul 2021 07:19:43 +0300
Message-ID: <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 3:24 AM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd info record
> > containing a pidfd is to be returned with each event.
> >
> > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > struct fanotify_event_info_pidfd object will be supplied alongside the
> > generic struct fanotify_event_metadata within a single event. This
> > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > the event structure is supplied to the userspace application. Usage of
> > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > permitted, and in this case a struct fanotify_event_info_pidfd object
> > will follow any struct fanotify_event_info_fid object.
> >
> > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > limited to privileged processes only i.e. listeners that are running
> > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > these initialization flags with FAN_REPORT_PIDFD will result with
> > EINVAL being returned to the caller.
> >
> > In the event of a pidfd creation error, there are two types of error
> > values that can be reported back to the listener. There is
> > FAN_NOPIDFD, which will be reported in cases where the process
> > responsible for generating the event has terminated prior to fanotify
> > being able to create pidfd for event->pid via pidfd_create(). The
> > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > creation error occurred when calling pidfd_create().
> [...]
> > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         }
> >         metadata.fd = fd;
> >
> > +       if (pidfd_mode) {
> > +               /*
> > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > +                * support within fanotify, the pidfd API only supported the
> > +                * creation of pidfds for thread-group leaders.
> > +                */
> > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > +
> > +               /*
> > +                * The PIDTYPE_TGID check for an event->pid is performed
> > +                * preemptively in attempt to catch those rare instances where
> > +                * the process responsible for generating the event has
> > +                * terminated prior to calling into pidfd_create() and acquiring
> > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > +                * cases. All other pidfd creation errors are represented as
> > +                * FAN_EPIDFD.
> > +                */
> > +               if (metadata.pid == 0 ||
> > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > +                       pidfd = FAN_NOPIDFD;
> > +               } else {
> > +                       pidfd = pidfd_create(event->pid, 0);
> > +                       if (pidfd < 0)
> > +                               pidfd = FAN_EPIDFD;
> > +               }
> > +       }
> > +
>
> As a general rule, f_op->read callbacks aren't allowed to mess with
> the file descriptor table of the calling process. A process should be
> able to receive a file descriptor from an untrusted source and call
> functions like read() on it without worrying about affecting its own
> file descriptor table state with that.
>

Interesting. I've never considered this interface flaw.
Thanks for bringing this up!

> I realize that existing fanotify code appears to be violating that
> rule already, and that you're limiting creation of fanotify file
> descriptors that can hit this codepath to CAP_SYS_ADMIN, but still, I
> think fanotify_read() probably ought to be an ioctl, or something
> along those lines, instead of an f_op->read handler if it messes with
> the caller's fd table?

Naturally, we cannot change the legacy interface.
However, since fanotify has a modern FAN_REPORT_FID interface
which does not mess with fd table maybe this is an opportunity not
to repeat the same mistake for the FAN_REPORT_FID interface.

Matthew, can you explain what is the use case of the consumer
application of pidfd. I am guessing this is for an audit user case?
because if it were for permission events, event->pid would have been
sufficient.

If that is the case, then I presume that the application does not really
need to operate on the pidfd, it only need to avoid reporting wrong
process details after pid wraparound?

If that is the case, then maybe a model similar to inode generation
can be used to report a "pid generation" in addition to event->pid
and export pid generation in /proc/<pid>/status?

Or am I completely misunderstanding the use case?

Thanks,
Amir.
