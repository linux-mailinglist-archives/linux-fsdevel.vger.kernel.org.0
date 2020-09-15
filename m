Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC52226A4BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIOMLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 08:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIOMJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:09:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B5C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 05:09:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so3896017qki.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDE7GdgltkSOIkfO/rfMw6sCqaS9Bsq8TbcW6NBrlSA=;
        b=kXoVDxvN7DndapcSu+l47L43PDGphATr8yW/tC0omD6Is0ijdVOouyYCJkTqfHq8hn
         +lHITLomC+eM5L7L/Yb3nepocbQQJ1YY3whc2T5Xcb2KXO7axBjQ5J14dEeGX3kSLeJN
         peijTOk4cdMAEmocw1oSr3/LyAjbPosFRAaa5tEhuOOoloaD8eVmwh0x2Donz0XViEVF
         5CANdLoHY9IQJvuMGvwHdeqTV+gZJrN4DkYeRjcBTPlrcLOlsVDgWbNf9HXSN3RAnhee
         +rJkw1sSjDzMvRVY2Wp6WVS9CioPTZyWSIISV5rvWT5hzGeBov0mdRImhGgFotjmfBVG
         xXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDE7GdgltkSOIkfO/rfMw6sCqaS9Bsq8TbcW6NBrlSA=;
        b=RI2FFTCWdZlkcLxUp3kuVQ+Fpeh55fuJNh+BNMw9BLluVF5LqWnP4Yko4DCL/PGcQ+
         S12db41AkmQlhnGumHVQOsi2I2lgm1SgC+6/B/+LOW2no0vaMjRoP/fgbq5OlGjyoR4R
         MWsIgNVQJgS628dpwfMAZNmmmLGqT4WbcC3yqrlQ187OyUmWq/eYoeTmD1pfVqWQZWzI
         VACW27HboXVia2ElvG8bAPdfFmDqCXQIlB47xptA2YYw39Tigz7yOx39oGMB1kXiKLu4
         QZu9D7PB6mVmAKXKUrdCCtDztKXe35B7xzwvTknEOZ143oAVvA11qwkGn9BRm9ujdHob
         4qdQ==
X-Gm-Message-State: AOAM531m5IylpZyG5/cyuSjDvYHm4bgmgW1t0LWK5nd2DDHng27/ufz+
        IKmzzFfuHdMEBTEHJ7LXo2pdS+xmYIYJn4OKNho=
X-Google-Smtp-Source: ABdhPJw3Srs65na85dJ0g29L8US0zN93DCQROxY0x27hHlAS+U5lNGZ8ddh11tAz3OlqD8Vs47r+W2UqXDszLfpAg5g=
X-Received: by 2002:a37:c408:: with SMTP id d8mr16463899qki.71.1600171771222;
 Tue, 15 Sep 2020 05:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172737.GA5011@192.168.3.9> <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Tue, 15 Sep 2020 20:09:20 +0800
Message-ID: <CAA70yB6-GFpnLCRmNGzGVK7qf_MG++7+0wUz61cqzNNoBN_iyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] inotify: add support watch open exec event
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Weiping Zhang <zhangweiping@didiglobal.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 4:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > > Now the IN_OPEN event can report all open events for a file, but it can
> > > not distinguish if the file was opened for execute or read/write.
> > > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > > want to monitor a file was opened for execute, they can pass a more
> > > precise event IN_OPEN_EXEC to inotify_add_watch.
> > >
> > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> >
> > Thanks for the patch but what I'm missing is a justification for it. Is
> > there any application that cannot use fanotify that needs to distinguish
> > IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> > specialized purposes (e.g. audit) which are generally priviledged and need
> > to use fanotify anyway so I don't see this as an interesting feature for
> > inotify...
>
fanotify meets my requirement, thanks.

> That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
> Last time this was discussed [2], FAN_UNPRIVILEGED did not have
> feature parity with inotify, but now it mostly does, short of (AFAIK):
> 1. Rename cookie (*)
> 2. System tunables for limits
>
> The question is - should I pursue it?
>
> You asked about incentive to use feature parity fanotify and not intotify.
> One answer is the ignored mask. It may be a useful feature to some.
>
> But mostly, using the same interface for both priv and unpriv is convenient
> for developers and it is convenient for kernel maintainers.
> I'd like to be able to make the statement that inotify code is maintained in
> bug fixes only mode, which has mostly been the reality for a long time.
> But in order to be able to say "no reason to add IN_OPEN_EXEC", we
> do need to stand behind the feature parity with intotify.
>
> So I apologize to Weiping for hijacking his thread, but I think we should
> get our plans declared before deciding on IN_OPEN_EXEC, because
> whether there is a valid use case for non-priv user who needs IN_OPEN_EXEC
> event is not the main issue IMO. Even if there isn't, we need an answer for
> the next proposed inotify feature that does have a non-priv user use case.
>
> Thanks,
> Amir.
>
> [1] https://github.com/amir73il/linux/commits/fanotify_unpriv
> [2] https://lore.kernel.org/linux-fsdevel/20181114135744.GB20704@quack2.suse.cz/
>
> (*) I got an internal complaint about missing the rename cookie with
> FAN_REPORT_NAME, so I had to carry a small patch internally.
> The problem is not that the rename cookie is really needed, but that without
> the rename cookie, events can be re-ordered across renames and that can
> generate some non-deterministic event sequences.
>
> So I am thinking of keeping the rename cookie in the kernel event just for
> no-merge indication and then userspace can use object fid to match
> MOVED_FROM/MOVED_TO events.
