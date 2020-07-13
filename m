Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E98821DB5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGMQOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMQOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:14:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD4C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:14:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d18so14150488edv.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7J/dIrjZFio1lV9NcYy8QCYPiQ6BKOzuPMbzTW6hKs=;
        b=jZ8C1lVMF7Tzy4ozH3eARzBxNxa9AIKbhB4vTgGwEfjvMCcNh0hz1RIR3OcaIj7wTk
         6EtwLWhVjnRBWdizDDwNsRm9wBP+TfCyFgZ+dA+7hP13C8kt0HVbfG5jOOt7NrVOSZPz
         wsAwP1yxi6uvhgjRVGawUaT1ZuygIX8yggZUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7J/dIrjZFio1lV9NcYy8QCYPiQ6BKOzuPMbzTW6hKs=;
        b=nYSDA4S/bLWexnZ9wuMWcus4OsT6elsMwquYsPFz6lWp0vsVB03od3/fCWKhzpK4wQ
         SzXE9HXlwBFp08ws62TAOWDaqRcUyYLLQdOBwX4oe7IC2wkf32MB1XHdoh7yE9Hb4YIk
         0S0N9yi9P/1hZ4t9BTAvHBdFbxzkP5O9sYTnbbDwxFevmHR/OJGQhlezIMc3RohDhh3j
         phgiQW8LZ1NFwuq2YPGksV8W1jdyWRjiPOv4lKs2jPlmOoSJ9QA1yMz6vyhcU4kqWoz7
         wW3uIwsYezrP9VmTL+wy+phKRltco9Lj11gzRtlrTiXZEOaragftwLNyzrXx2GDLYBe2
         PLdg==
X-Gm-Message-State: AOAM533k3tMHMlqDn17pgHKv+hBnMgVCrQutwVjP6fqJzdaD/V1Kb/L+
        Mwd68ephTta7Se+62OuPN4GIzxs/6Ek5qjT1r530zQ==
X-Google-Smtp-Source: ABdhPJzXRGJE3TcK5wECCdKKfoKHfG85l1u/aM1eJ1RxfsXlJyiUiSBf3ojXMDQKJF70SFgMqKDXfR09Gt/l9JKhYqY=
X-Received: by 2002:a50:f413:: with SMTP id r19mr165397edm.17.1594656869606;
 Mon, 13 Jul 2020 09:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com> <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com>
In-Reply-To: <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jul 2020 18:14:16 +0200
Message-ID: <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 7/11/20 7:01 AM, Miklos Szeredi wrote:
> > On Thu, Jun 25, 2020 at 11:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >>
> >> In current implementation fuse_writepages_fill() tries to share the code:
> >> for new wpa it calls tree_insert() with num_pages = 0
> >> then switches to common code used non-modified num_pages
> >> and increments it at the very end.
> >>
> >> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
> >>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
> >>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
> >>  Call Trace:
> >>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
> >>   write_cache_pages+0x171/0x470
> >>   fuse_writepages+0x8a/0x100 [fuse]
> >>   do_writepages+0x43/0xe0
> >>
> >> This patch re-works fuse_writepages_fill() to call tree_insert()
> >> with num_pages = 1 and avoids its subsequent increment and
> >> an extra spin_lock(&fi->lock) for newly added wpa.
> >
> > Looks good.  However, I don't like the way fuse_writepage_in_flight()
> > is silently changed to insert page into the rb_tree.  Also the
> > insertion can be merged with the search for in-flight and be done
> > unconditionally to simplify the logic.  See attached patch.
>
> Your patch looks correct for me except 2 things:

Thanks for reviewing.

> 1) you have lost "data->wpa = NULL;" when fuse_writepage_add() returns false.

This is intentional, because this is in the !data->wpa branch.

> 2) in the same case old code did not set data->orig_pages[ap->num_pages] = page;

That is also intentional, in this case the origi_pages[0] is either
overwritten with the next page or discarded due to data->wpa being
NULL.

I'll write these up in the patch header.

Thanks,
Miklos
