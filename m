Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC035C985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbhDLPRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbhDLPQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:16:59 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C6C06138C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 08:16:41 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id j8so1857014uak.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKoalR9J+WU3bjJGvLXhcQGEnQVWi1PGcVr9Ehq2xVw=;
        b=fO8IYqoAwqhSlT3rrWn1yQEJTVt/QiQ4YaIlpZNtUdao/p4yykiL30R1EcDI+8i3+r
         U1TwTh50+L3N2MWymVR8NBXzztI/a3DCetrwXiLjJTqgFbzHBt/ZL2A54f+a3qXJYySM
         bW+ItRLEPOg5Gy7H+mSdpK8NM7IVQeI/qIgmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKoalR9J+WU3bjJGvLXhcQGEnQVWi1PGcVr9Ehq2xVw=;
        b=DqEq56OtPXuflSG/be4yTzHvJCbrdZWnz5/JR448MZUjATRjp/8Agf8EzEaEOAIsbu
         nXn9GRd2MzciTBDBCm8fWXzJrDBa0QqymTYhyr55nuL6Sb1q9KOEWvDvNiAat0UQAQJ3
         PVGnKWjhLJR4p1Vw1himynQsPjqGDqtLkQRBMz04BLAyThE/ebTvcPNBxUSbKoSaiwk3
         Xdf8ixZBZB1lEV488NLN8GIxDJJX41mSRJ8KGpzBvHt385Hews7Igwu3ASzD6Yz56vSn
         v7NIagAsOI5X4b497uX/6/u/8V2pFJNLK6uepEyjG1AN6sv+1M6bckjogD7HGj7M2YPX
         mxuw==
X-Gm-Message-State: AOAM5307GuuK4ee4pmaWbN8qv44yKPo7ReS7nouEBVrqtczug5Ji9TYc
        zHkpYFvYdf97NnbLU5nK5QzyFBcD7JfsMGnU+nAncTOtkashRg==
X-Google-Smtp-Source: ABdhPJx7WMmWIuHW3B5LRNks0ayocnAf7srp3lJ5T4Pa8mkw2i97DNxtvD8EHogi1SzNYImjKt1Lul6E1xtFYqkcP7I=
X-Received: by 2002:ab0:3570:: with SMTP id e16mr5987892uaa.13.1618240600915;
 Mon, 12 Apr 2021 08:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210317084443.22657-1-lhenriques@suse.de>
In-Reply-To: <20210317084443.22657-1-lhenriques@suse.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 17:16:29 +0200
Message-ID: <CAJfpegtpjw8OEvVwxvhz91jozt4GU6XxWB4MrKmjNOWVPf_qdw@mail.gmail.com>
Subject: Re: [PATCH v2] virtiofs: fix memory leak in virtio_fs_probe()
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:43 AM Luis Henriques <lhenriques@suse.de> wrote:
>
> When accidentally passing twice the same tag to qemu, kmemleak ended up
> reporting a memory leak in virtiofs.  Also, looking at the log I saw the
> following error (that's when I realised the duplicated tag):
>
>   virtiofs: probe of virtio5 failed with error -17
>
> Here's the kmemleak log for reference:
>
> unreferenced object 0xffff888103d47800 (size 1024):
>   comm "systemd-udevd", pid 118, jiffies 4294893780 (age 18.340s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 80 90 02 a0 ff ff ff ff  ................
>   backtrace:
>     [<000000000ebb87c1>] virtio_fs_probe+0x171/0x7ae [virtiofs]
>     [<00000000f8aca419>] virtio_dev_probe+0x15f/0x210
>     [<000000004d6baf3c>] really_probe+0xea/0x430
>     [<00000000a6ceeac8>] device_driver_attach+0xa8/0xb0
>     [<00000000196f47a7>] __driver_attach+0x98/0x140
>     [<000000000b20601d>] bus_for_each_dev+0x7b/0xc0
>     [<00000000399c7b7f>] bus_add_driver+0x11b/0x1f0
>     [<0000000032b09ba7>] driver_register+0x8f/0xe0
>     [<00000000cdd55998>] 0xffffffffa002c013
>     [<000000000ea196a2>] do_one_initcall+0x64/0x2e0
>     [<0000000008f727ce>] do_init_module+0x5c/0x260
>     [<000000003cdedab6>] __do_sys_finit_module+0xb5/0x120
>     [<00000000ad2f48c6>] do_syscall_64+0x33/0x40
>     [<00000000809526b5>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
> Changes since v1:
> - Use kfree() to free fs->vqs instead of calling virtio_fs_put()

Applied, thanks.

Miklos
