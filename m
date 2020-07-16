Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31F222936
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 19:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgGPRUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgGPRUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:20:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C2C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 10:20:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o3so5702007ilo.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/fNskhZQSlEWPzq8YKnwQxe94+wY9nLK+aOyJAPuyg=;
        b=XLQ1Md9K9z4XyeSEhckH3uQXNGvZvV+RGH3+seFkpbSs3O3lwdUrDbv3cNS4LKMlRW
         O01gNRJ3mZw16KwLxcYCEiRK+WUzI80xy1/RRxegrn2u2aqEOKDVCUG/g5LJ/3TFolLQ
         UAyd6GV0gYERVcUU7iAp+rs9Aw7jMw9USi7QiKdEVQPks5o0oX5yNxdAN/2+cx5ttYcv
         ntzhlTyoyXl3gAd13wN66qF3qWsmejmwyLzxeq+5vHNWiw3XfYNBug6P/Ht9ex+GnKsY
         5jea4MAmBr5F9WIoAwA/TOmFPCyJjsf3B2m6o33YrP1To7Jam7G5S/e/GZEJazySJ89f
         uvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/fNskhZQSlEWPzq8YKnwQxe94+wY9nLK+aOyJAPuyg=;
        b=VOnonhvNCDAi+8df1JZQOdDEGbBGi3ZZUq9kR9acUVC7AL4GGLav5t5vDqAUyqjv7O
         uvJaV++qLlS5N036eClmOjLQEsgM9DLzjrHpAqrkhp0mCCvyAeCfEeuXuDvXBgREV8yl
         CcNATiwmoFbFGpZT/SzEM2RJfb/ZUgxU16dTYKlRbEFh/EhM0WIXYGDq52dDFCfsvo6a
         6UQWGVW/Ve1zM8goorZg5fAY2DLODGUvCH1BS0hDF1OHQl5bHloitmtyr9dS2hcHtJBU
         Q56Ejj4GJd3yPsS4LR+gnxbCriY97mfIPUswfNCGaL26cGTPnxr7DHrbvMGugGjqCEcd
         sh8Q==
X-Gm-Message-State: AOAM533PxlCbzwW4e5ylYhKundzOU0r0gFcSd0K1O7YztKx7St0Weyqk
        Zdj5OGxyH7bUzvJzK9VqUnXxCVlkFNIxdsTkNX8=
X-Google-Smtp-Source: ABdhPJyDc0KBRiYjx4t1XfjGcF9DeONP+QI98ucLqUEtiu3zYGl4q+hedsOPt0qxjl/nQnWe3N67A5DkssedsZtpE1M=
X-Received: by 2002:a92:c205:: with SMTP id j5mr5808830ilo.137.1594920016917;
 Thu, 16 Jul 2020 10:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-16-amir73il@gmail.com>
 <20200716170133.GJ5022@quack2.suse.cz>
In-Reply-To: <20200716170133.GJ5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 20:20:04 +0300
Message-ID: <CAOQ4uxhuMyOjcs=qct6Hz3OOonYAJ9qhnhCkf-yy4zvZxTgFfw@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 8:01 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 11:42:23, Amir Goldstein wrote:
> > Similar to events "on child" to watching directory, send event "on child"
> > with parent/name info if sb/mount/non-dir marks are interested in
> > parent/name info.
> >
> > The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> > interest in parent/name info for events on non-directory inodes.
> >
> > Events on "orphan" children (disconnected dentries) are sent without
> > parent/name info.
> >
> > Events on direcories are send with parent/name info only if the parent
> > directory is watching.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Hum, doesn't this break ignore mask handling in
> fanotify_group_event_mask()? Because parent's ignore mask will be included
> even though parent is added into the iter only to carry the parent info...
>

Hmm, break ignore mask handling? or fix it?

Man page said:
"Having these two types of masks permits a mount point or directory to be
 marked for receiving events, while at the  same time ignoring events for
 specific objects under that mount point or directory."

The author did not say what to expect from marking a mount and ignoring
a directory.

As it turns out, I need this exact functionality for my snapshot.
- sb is watching all (pre) modify events
- after dir has been marked with a change in snapshot an exclude
  mark is set on that dir inode
- further modification events on files inside that dir are ignored
  without calling event handler

I am sure you are aware that we have been fixing a lot of problems
in handling combinations of mark masks.
I see the unified event as another step in the direction to fix those
issues and to get consistent and expected behavior.

Thanks,
Amir.
