Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD41F1D40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgFHQ0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbgFHQ0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:26:24 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5BC08C5C2;
        Mon,  8 Jun 2020 09:26:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h3so17337658ilh.13;
        Mon, 08 Jun 2020 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNcGT/39dUgplI+Z67rPFRW0/vt/Bby0Yzd9Cnrfyyw=;
        b=SBhniS7CMUxvzNsPKTK+amWy5fgTtAmWU8wJ8UvJTB3rHNtMjSHhZGgHsr1+rHMLg+
         9Yly7GtI09rTxG/kYMK8Q1Y7CL9zw+ELfuhkDnxpI0NqLE6gUj9md2RzUtPUeTmOL0UG
         cp1azsf4ygURS9qGe3FTklBQ5qBSYgqgCE0l3MqKOw3mS1Yr0pw2ODzd1NZ3OX8apcJi
         hnWfIVDZq5qurxW69G62XWxFk40b7TlwftDeqm3pJZWaOlYvOqLLQTlo9v8qOUDL7nYV
         YNadXBrPiazMmuRLEJCQke83Z8vAQ9cFCUfwyA5Q0MzpgrGNMfx72+DnPKBMXLUMHXSu
         Pb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNcGT/39dUgplI+Z67rPFRW0/vt/Bby0Yzd9Cnrfyyw=;
        b=tpI76GPXGP27vzb7T1KNZkdqbbAhLZbmImujjucffD3FHo+cAlTyPBmmtf2oIA9F86
         5i9uwVvuHxXYonk4ICAO5ipeZrY3AKWXMFL9Q6l1GcdPFQU5u8LIUfvHCiMBERggT327
         w9Umde+CkhC2N+3nPbSwc0V3pZ1XAEyrmHGW+bXpXvMFiobOP34zgQTdEiykURcdOqBE
         ZUpZXrKD21XL6ykTi9PM6TpBzantQU8a4++hVw3QhQRXKeePBjSbD00IaWlo5K4fL5fL
         qLiEZ8zi9hG21xCbKuSqiJPKE1Gy3PhtO1OALbs6Kbbtp2smiXqAujllcbYKiYEOD9W9
         a4YA==
X-Gm-Message-State: AOAM532WH1RUcqHSoP4vAGA0/YhbMNqFJ5pFrgPPKle3eRKUGHgyoJ3X
        4yCLw8y4z8eFGwyRS6MuXm2RTI/eQKtn0WHN6KaLAivs
X-Google-Smtp-Source: ABdhPJxIfAV3z6uJlwBkYV60uKHDKD7bTc7VufXOdcGoFPLZBt4wuNVLviDWODmk+vIOcrSM8RBz0XipBrUJHq5A9d4=
X-Received: by 2002:a92:c60b:: with SMTP id p11mr16113909ilm.137.1591633581806;
 Mon, 08 Jun 2020 09:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200608140557.GG3127@techsingularity.net> <CAOQ4uxhb1p5_rO9VjNb6assCczwQRx3xdAOXZ9S=mOA1g-0JVg@mail.gmail.com>
 <20200608160614.GH3127@techsingularity.net>
In-Reply-To: <20200608160614.GH3127@techsingularity.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 8 Jun 2020 19:26:10 +0300
Message-ID: <CAOQ4uxh=Z92ppBQbRJyQqC61k944_7qG1mYqZgGC2tU7YAH7Kw@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > What this work does essentially is two things:
> > 1. Call backend once instead of twice when both inode and parent are
> >     watching.
> > 2. Snapshot name and parent inode to pass to backend not only when
> >     parent is watching, but also when an sb/mnt mark exists which
> >     requests to get file names with events.
> >
> > Compared to the existing implementation of fsnotify_parent(),
> > my code needs to also test bits in inode->i_fsnotify_mask,
> > inode->i_sb->s_fsnotify_mask and mnt->mnt_fsnotify_mask
> > before the fast path can be taken.
> > So its back to square one w.r.t your optimizations.
> >
>
> Seems fair but it may be worth noting that the changes appear to be
> optimising the case where there are watchers. The case where there are
> no watchers at all is also interesting and probably a lot more common. I

My changes are not optimizations. They are for adding functionality.
Surely, that shouldn't come at a cost for the common case.

> didn't look too closely at your series as I'm not familiar with fsnotify
> in general. However, at a glance it looks like fsnotify_parent() executes
> a substantial amount of code even if there are no watchers but I could
> be wrong.
>

I don't about substantial, I would say it is on par with the amount of
code that you tries to optimize out of fsnotify().

Before bailing out with DCACHE_FSNOTIFY_PARENT_WATCHED
test, it also references d_inode->i_sb,  real_mount(path->mnt)
and fetches all their ->x_fsnotify_mask fields.

I changed the call pattern from open/modify/... hooks from:
fsnotify_parent(...);
fsnotify(...);

to:
fsnotify_parent(...); /* which calls fsnotify() */

So the NULL marks optimization could be done in beginning of
fsnotify_parent() and it will be just as effective as it is in fsnotify().

Thanks,
Amir.
