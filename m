Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93515164756
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBSOng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 09:43:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39487 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSOng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:43:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so343737oty.6;
        Wed, 19 Feb 2020 06:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI+CJ/G50gsVNVKzRUAej0N+x0HPvxzRhBEt0CmEOv4=;
        b=O4kaAy7AIhR1NLc6+2vVsQ01doofABLF10YOp8B2IzClQuf2KeE/D8D1loW9kykCjO
         fWIIx1a6vpgt9ZvnJ7mYe0+gHuK/WsmybGR4v1+ga2dQkesUhCLA9+NQPfOcz9M8wtE/
         AQOIPIXOwzBXF0NAxY35aI9oHYRMHArwXpQRpc0cy6iq0KjEV99QKhTY68wutH5OphFt
         WUgCHSnMuylxN5w6M10dyX0cyJmi8KKkspss3tgQHD9Q780qh7BgkkuC0aPy8Nd2yS0G
         Xf9U/MXAlFttpTxz/qRTSp3Yrq/B9kDabvbPVCuP7QXdRS9L9as+UZbRJ0jBMx9OcJJb
         tLwg==
X-Gm-Message-State: APjAAAXt0ipIuVxNaAGU6oE6id8duxoa6mpiBcFd40S18CRjgv1i2n6i
        kNTj0n5m5wCmCF59HaAzN/kXmsZM+dvWaF8Ji24=
X-Google-Smtp-Source: APXvYqz6vvsBuRLR7XGtF/ZPU030W55DJK8XF7uQ8QaeNP2kBIMaRgUkAoRiWtPgZhb0bZcUYYMNnN6xisPOAfgtI0E=
X-Received: by 2002:a05:6830:1d4:: with SMTP id r20mr5686997ota.107.1582123415662;
 Wed, 19 Feb 2020 06:43:35 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
In-Reply-To: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Feb 2020 15:43:24 +0100
Message-ID: <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@vger.kernel.org, linux-cifs@vger.kernel.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Wed, Feb 19, 2020 at 3:36 PM David Howells <dhowells@redhat.com> wrote:
> Add system calls to create and remove mountpoints().  These are modelled
> after mkdir and rmdir inside the VFS.  Currently they use the same security
> hooks which probably needs fixing.
>
> The calls look like:
>
>  long create_mountpoint(int dfd, const char *path,
>                         const char *fstype, const char *source,
>                         const char *params);
>  long remove_mountpoint(int dfd, const char *path);
>
> Creation takes an fstype, source and params which the filesystem that owns
> the mountpoint gets to filter/interpret.  It is free to reject any
> combination of fstype, source and params it cannot store.  source and
> params are both optional.
>
> Removal could probably be left to rmdir(), but this gives the option of
> applying tighter security checks and also allows me to prevent rmdir from
> removing them by accident.
>
> The AFS filesystem is then altered to use these system calls to create and
> remove persistent mountpoints in an AFS volume.  create_automount() is
> something that AFS needs, but cannot be implemented with, say, symlink().
> These substitute for the lack of pioctl() on Linux, supplying the
> functionality of VIOC_AFS_CREATE_MT_PT and VIOC_AFS_DELETE_MT_PT.
>
> Also make them usable with tmpfs for testing.  I'm not sure if this is
> useful in practice, but I've made tmpfs store the three parameters and just
> pass them to mount when triggered.  Note that it doesn't look up the target
> filesystem until triggered so as not to load lots of modules until
> necessary.
>
> I suspect they're of little of use to NFS, CIFS and autofs, but probably
> Coda and maybe Btrfs can make use of them.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks for your patch!

The above nicely explains what the patch does.
However, unless I'm missing something, this fails to explain the "why"
(except for the vague "[...] is something that AFS needs ...".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
