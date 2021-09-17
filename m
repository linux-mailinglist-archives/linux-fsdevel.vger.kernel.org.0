Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A519340F774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhIQM2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 08:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhIQM2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:28:10 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01DC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 05:26:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z6so5212827iof.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQB0qoXcfToceQ+/r9nrflH7fJ+OIE6ZHlA7cWyY4zw=;
        b=B561/Nw2qtIZ5fCVxVYMBSx6eR4sZMJMJtZKiWUJeC7n/ETZRGngeFRBOV6S4waCSY
         nUdWKXK2BC8UE/NPFaDlueDrzq387pRIxw8QFxotoIRdegNtMcGOW3YXkOE202aHTJ8X
         VICeCOFQe/BJGiHV+Zz1LE9gPlhWt6OGBNHTSuIqXuIUkP3LP6D090r5CNsV8L6wN0kl
         7Y/XC1IR1yzL8mzkQr33LUU9L9vpvE7lOISEp62CeOGJmBjWMxYZ57961SSphw7L1Zsh
         OlDvoX1iWlb6H2azq9iWSLy/x8Y0uodCFQDBHYh+ebB0rJl1u1jASfV0cMDGJHkw+HMd
         /9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQB0qoXcfToceQ+/r9nrflH7fJ+OIE6ZHlA7cWyY4zw=;
        b=DiDfKDwQ4Ptf2lDSMl19NJNycFXmXrmVyXwBn1McZkrpTD0ffuEm2LURXtmmT9gFMC
         5P+DqRswKJsdb7hTuCXhAMhdeClS+cQimG2BYKWEpIft/WOZqFfpxXlzkckcF2Eygnw9
         NBlHqHRwOm/lzwXspEWm0omCBEGU9G2Yb2M4NpRPeQAU1z7No5fs7zz9fW6B8tVQsrDO
         csS7lc6VxkvtBivmkq+kNE8A2tihFtdlKFavtcJ6+MPRwXxFZ3Cm4+XJ4nE6dx3tJNgF
         cnm8jDXNU154e+Yq0H3PHy1sSpVJXrpzt3zut1kpOX0Cl6ji8cEf5dktT+ySI+CzlcNQ
         bp5g==
X-Gm-Message-State: AOAM530zSbg7kJVDPUU/UcwF8fh6YBXJu0AvO/52D1WJhM1kS8wruHR+
        iL9gZMdPJQkeB3HMBwVI29Y7MiKCuqMHORyJ2O4=
X-Google-Smtp-Source: ABdhPJxK+FhDUkl2pVE6z+BDPC9kkIg2JNakwj1glEBnSuySbhoe+df/2X0uUxkx4Oja/clNDEXqU3rmRpvun2CJO4o=
X-Received: by 2002:a5e:dc02:: with SMTP id b2mr8486860iok.197.1631881606894;
 Fri, 17 Sep 2021 05:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210916140649.1057-1-shengyong2021@gmail.com>
 <20210917084922.GC5284@quack2.suse.cz> <f52ff4e1-6d97-2d90-5b85-815311caea56@gmail.com>
In-Reply-To: <f52ff4e1-6d97-2d90-5b85-815311caea56@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Sep 2021 15:26:35 +0300
Message-ID: <CAOQ4uxiEYbHr0Z7orXJARG=2yb9oNvy=2jKALpikmYgcOjUOOA@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Extend ioctl to allow to suppress events
To:     Sheng Yong <shengyong2021@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 3:05 PM Sheng Yong <shengyong2021@gmail.com> wrote:
>
> Hi, Honza,
>
> On 2021/9/17 16:49, Jan Kara wrote:
> > On Thu 16-09-21 22:06:49, Sheng Yong wrote:
> >> This patch adds a new ioctl cmd INOTIFY_IOC_SUPRESS to stop queueing
> >> events temporarily. A second ioctl could resume queueing events again.
> >> With it enabled, we could easily suppress events instead of updating
> >> or removing watches, especially if we have losts of watches referring
> >> to one inotify instance, for example watching a directory recursively.
> >>
> >> Signed-off-by: Sheng Yong <shengyong2021@gmail.com>
> >
> > Thanks for the patch! This ioctl on its own is equivalent to shutting down
> > the notification group so I don't think it is really useful on its own.
>
> Thanks for your reply.
> Yes, this ioctl reuses the stop-queueing-events procedure of shutdown.
>
> > If you add ioctl to resume queueing, it makes some sense but can you
> > ellaborate a bit more why you need to stop receiving events temporarily?
>
> The usecase is that we use rsync+inotify to backup files. Let's say there are
> two tasks: 1) "real-time" task reads events and syncs the file; 2) periodic
> task syncs all files recursively in the source directory.
>
> If the queue get overflowed and new events are discarded, we have to start a
> recursive sync. But recursive sync takes a very long time to scan, compare and
> transmit data, we prefer a periodic task to do that, so that we could ignore
> overflow events.
>
> When the periodic task is working, I think the "real-time" task should stop
> reading and handling new events temporarily to avoid duplicated IO in both
> sides. I think stop queueing new events is the easiest way to do that.
>

Having some experience with similar applications, I have highs doubts about
this models. Anyway, you should be able to achieve better results with fanotify
by adding an FAN_MARK_FILESYSTEM mark with ignored mask or by using
a FAN_MARK_FILESYSTEM instead of recursive inotify to begin with.
See: https://github.com/inotify-tools/inotify-tools/pull/134

Thanks,
Amir.
