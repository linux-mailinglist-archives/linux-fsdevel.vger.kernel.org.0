Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5931EF46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 20:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhBRTIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 14:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhBRS6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:58:00 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C1C061574;
        Thu, 18 Feb 2021 10:57:20 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s17so3128261ioj.4;
        Thu, 18 Feb 2021 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4xxXYKJo5IV3bB9fNqOq03Zn+tFydpSlHd7y6T/7rA=;
        b=Ii03twkrTTNQ3M8wsgGS/6aYPx0ugsGb8RM+2lz7YuGnmD2sHaUIp/9CYFoY2JTv7W
         jDPrXSjroXzaSKeHI/y3H5luQqC9z6ty4q0auB5hNEO1XDhP5Qg2BIFB0Hm7qZVMHXIO
         0HY56yFCyYhafOeICpBs+v3P0TMVU5+895wVgQb3GozWvwZg8DaK2fMQINtNDeen2Z9+
         cCWv0p2526t5kpQQHsY7SVjCjyytf1ilPJGSUmA9hWmCX5scH/zHZmZ169cGMCBgF9m+
         5ezZiGhqTl6bflB7v3YIEmYF3pJSAlItbHPTFQP4DAjh/v0YGfQoQB6h7e72uLG4xlCm
         Vr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4xxXYKJo5IV3bB9fNqOq03Zn+tFydpSlHd7y6T/7rA=;
        b=suj0BKb/smp8S2dIXvAc6dQK5/xS286VXoT31kFCa//YCn/ypiciHXU/Zv5pcZx9Zn
         AP+FxpIsemShc9bOeBNkuxZ/A6LQcrXVXTDzopwqX5LB7eGn3R2o3ZqTnBrz0wNKjsnb
         0fHbqUwz9CDETAH+ITBiOPJq4CP1L2ydTUd/b53XQUK12F/mrawCELTVUl/i4sdbXbVW
         XXPylx0vi5uuregk2HgpiHqZNkvDg4CS+0Eq2mARIJQxzrZxSGx6NdrDYEySLWTtOIe+
         zu/SjNy+sKffxnbNO0laRqLmVvSARK9ECwYKMXe76lFPWhDgiK7vQiYilwueWh3Is9lJ
         URtw==
X-Gm-Message-State: AOAM532fl9399jxSJBWPB+rtgaC6MKJorXBaxtfnjJeDDuotlPwYJnhr
        d/dKJziGX84QwtEo5EDy8l/OP6s5SKe5cPEkBVIFLbQvuBU=
X-Google-Smtp-Source: ABdhPJx87FVeRedno9dW12aEXtx4a6OTuFu5D8r4dF6Lq18/UmBlTyFM0rlLCldmw/6w0yOT71RBN6lhaMoKG5Ln1aA=
X-Received: by 2002:a02:74a:: with SMTP id f71mr5795794jaf.30.1613674639752;
 Thu, 18 Feb 2021 10:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20210124184204.899729-1-amir73il@gmail.com> <20210124184204.899729-2-amir73il@gmail.com>
 <20210216162754.GF21108@quack2.suse.cz>
In-Reply-To: <20210216162754.GF21108@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 20:57:08 +0200
Message-ID: <CAOQ4uxj8BbAnDQ9RyEM3fUtw7SPd38d1JsgfB2vN2Zni1UndQg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] fanotify: configurable limits via sysfs
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 6:27 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
>
> I'm sorry that I've got to this only now.
>
> On Sun 24-01-21 20:42:03, Amir Goldstein wrote:
> > fanotify has some hardcoded limits. The only APIs to escape those limits
> > are FAN_UNLIMITED_QUEUE and FAN_UNLIMITED_MARKS.
> >
> > Allow finer grained tuning of the system limits via sysfs tunables under
> > /proc/sys/fs/fanotify/, similar to tunables under /proc/sys/fs/inotify,
> > with some minor differences.
> >
> > - max_queued_events - global system tunable for group queue size limit.
> >   Like the inotify tunable with the same name, it defaults to 16384 and
> >   applies on initialization of a new group.
> >
> > - max_listener_marks - global system tunable of marks limit per group.
> >   Defaults to 8192. inotify has no per group marks limit.
> >
> > - max_user_marks - user ns tunable for marks limit per user.
> >   Like the inotify tunable named max_user_watches, it defaults to 1048576
> >   and is accounted for every containing user ns.
> >
> > - max_user_listeners - user ns tunable for number of listeners per user.
> >   Like the inotify tunable named max_user_instances, it defaults to 128
> >   and is accounted for every containing user ns.
>
> I think term 'group' is used in the manpages even more and in the code as
> well. 'listener' more generally tends to refer to the application listening
> to the events. So I'd rather call the limits 'max_group_marks' and
> 'max_user_groups'.
>
> > The slightly different tunable names are derived from the "listener" and
> > "mark" terminology used in the fanotify man pages.
> >
> > max_listener_marks was kept for compatibility with legacy fanotify
> > behavior. Given that inotify max_user_instances was increased from 8192
> > to 1048576 in kernel v5.10, we may want to consider changing also the
> > default for max_listener_marks or remove it completely, leaving only the
> > per user marks limit.
>
> Yes, probably I'd just drop 'max_group_marks' completely and leave just
> per-user marks limit. You can always tune it in init_user_ns if you wish.
> Can't you?
>

So I am fine with making this change but what about
FAN_UNLIMITED_MARKS?

What will it mean?
Should the group be able to escape ucount limits?

Thanks,
Amir.
