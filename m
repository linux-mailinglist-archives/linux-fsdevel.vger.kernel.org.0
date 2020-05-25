Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5E1E095A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgEYIuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388800AbgEYIug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 04:50:36 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D49C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 01:50:36 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b15so16664781ilq.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2020 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHaqxNuF3YvsvpprZOBQKNmTU8lSEV2Qm79xNY4I7PQ=;
        b=i0bbQvYfJYjmCKTYQs8tFTVBauraeA0eYRWIMvHogEVQGHb4LkcoSCGZCpV1Putdur
         oLSybPxVrzV112skBiR1W3DQXj8pQhuUNdWe1lKXoyQiCkyWo14cfbq9HjLRfrI5F2wR
         1+jSmXBI2mA0CUjYjfnYzzVCPSgMVwADCtaoKdX0MKK1Yx6Md1OLtWcISXzAEguu3m6o
         4wurLZ8cYt7USsixPe0tpM4p7uFxPAZoPAf2BtClhfmttLzthonnU/9MolA4b0F77DE9
         QZKoiIQlShku7a7iKV1UduZkYAk5YLBV7U3+kM399HbKeZdoVUKUGwpKXefiQZwZeunC
         laxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHaqxNuF3YvsvpprZOBQKNmTU8lSEV2Qm79xNY4I7PQ=;
        b=IXXrIewV1ZSGcCEKt6/FrqUELGqB/fl/M22CIraUaS0FTdOTsbZCQYiJ2ZbwnsN9GX
         Awl1WkE/bHos7uApy7R0sJbxzQVcynVobkaazkxph+lQL4FMOxjz6v3y9P2rms4Ei5i3
         Kb+OSwWKxIoRXHBC6MIzEPhOANv+bBL4XBIugWW4OHnpn8Ww2xmreFc0qxMZPA+w2Lng
         r40rFv/42U3tM8YV/kruW5BKa/sACAsaj1jp3zJtxapY2xMrFBS+WZniaiakXFmWEYhH
         Ua0E/6IWgRAF2xVOobAa6vPIdbvcFTYuhKcEzC3lFSNbYti386FpsCrTccYKUlxagTfD
         okAQ==
X-Gm-Message-State: AOAM533EBV4glxuqWtN1IXpMZ5c0Cj2MR89735P6POZZhCHROI2jJhHm
        m7jL98DY8oQ//VDwYjVNKlwuAcll/YxdU0o9lmE1gg==
X-Google-Smtp-Source: ABdhPJz8v2uHsAaJK74rwivmtc41Yeyb6gc3J389/PwVbE9eVCvB8FN5CpYd09Fv+XzmK9VU6f3/S52RNJC04vpaYqA=
X-Received: by 2002:a92:495d:: with SMTP id w90mr23502841ila.275.1590396635414;
 Mon, 25 May 2020 01:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200524072441.18258-1-amir73il@gmail.com> <20200525084455.GL14199@quack2.suse.cz>
In-Reply-To: <20200525084455.GL14199@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 May 2020 11:50:24 +0300
Message-ID: <CAOQ4uxi_0PYyRO5jQKUvxjz5drZtQeJBq=2hkLX9WSS7APo+=A@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix ignore mask logic for events on child and
 on dir
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 11:44 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 24-05-20 10:24:41, Amir Goldstein wrote:
> > The comments in fanotify_group_event_mask() say:
> >
> >   "If the event is on dir/child and this mark doesn't care about
> >    events on dir/child, don't send it!"
> >
> > Specifically, mount and filesystem marks do not care about events
> > on child, but they can still specify an ignore mask for those events.
> > For example, a group that has:
> > - A mount mark with mask 0 and ignore_mask FAN_OPEN
> > - An inode mark on a directory with mask FAN_OPEN | FAN_OPEN_EXEC
> >   with flag FAN_EVENT_ON_CHILD
> >
> > A child file open for exec would be reported to group with the FAN_OPEN
> > event despite the fact that FAN_OPEN is in ignore mask of mount mark,
> > because the mark iteration loop skips over non-inode marks for events
> > on child when calculating the ignore mask.
> >
> > Move ignore mask calculation to the top of the iteration loop block
> > before excluding marks for events on dir/child.
> >
> > Reported-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/linux-fsdevel/20200521162443.GA26052@quack2.suse.cz/
> > Fixes: 55bf882c7f13 "fanotify: fix merging marks masks with FAN_ONDIR"
> > Fixes: b469e7e47c8a "fanotify: fix handling of events on child..."
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Thanks! I've added the patch to my tree. I don't think this is really
> urgent fix so I plan to push it to Linus in the coming merge window.
>

Agreed.

Thanks,
Amir.
