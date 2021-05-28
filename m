Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0587B393E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhE1Hiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhE1Hix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 03:38:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22AC061574;
        Fri, 28 May 2021 00:37:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c15so4041348ljr.7;
        Fri, 28 May 2021 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ONSQ40tIX1ptfs2rDe/1Z7im0fRwlSIOjAYodAV+kg=;
        b=j8cy13UgmiAo40bozT8Y7ei8oSr3b/Lanx19OnthKFxwgaZHcP9ON3iG/gEln8f4Q7
         2MAxPRJ+JcQBvd9moH8Sw9yOYzlBdMJ7Lg9oh6ZSlR5ybiRRSBAtDMZOtvXRsPKwVNWC
         0RvHBJ8+rZQ8QKEY49wFatP5C9mvB64+K4EwQ9x4km4ibccuCnCiy6ezKuNxwPcYZPeZ
         Wbikl+sew11fe4nTD2Swlw8fZ32P6l+QCKIRIW0GixoAPeiv52k/J+VOxZsfHoWMuPIj
         U2HUsOUQ9F+nO2qbhzAvxqH6APXyXbQpvuk7WonfAZS5qhPc1iVYBLNYn3Cy10CFER/+
         nS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ONSQ40tIX1ptfs2rDe/1Z7im0fRwlSIOjAYodAV+kg=;
        b=UxOYXbgmohDw4tTvRklmLVNssrTSHIovmRNWSeB5MpWTGF39NzNzgL0NIVvvf9Ryd3
         eZn8RVRaN5gx9bJN6KAk/K+FdCq4G8sH1e4pftz+vS+qZkUMqj0U1/JVnpkjBKsf06Me
         5SnGxpyD2imh8/xn50AOsOZPDSwGD9EGmdkNM2m4dhtO1zuKsUO8QHB8bQDrct0SdXW9
         diH9trknnMLIOGRCA3/JyDVqxDcXcbwO9n/ThECop3www/8yGhiy/KOfVDjjhmIF7OZf
         bj98opbxS9J+ikdczK9zRYf/CaLcQn8AvdT324At/hGb8mh0KgO5cB1vFFNRTWDWsHeW
         jMQg==
X-Gm-Message-State: AOAM532eTOnZR6Ch6nh8glo/Qps2/UqlZoKbLIs35v694bwaUzIQr3zS
        9vWsQijdKbsuPVp/gKNJdnWXFPOKPu5TypgYxQE=
X-Google-Smtp-Source: ABdhPJy8hzG6ArAkBmVLvXTuiaRdlXzfdXO30Wqd2Q7RaHsUh3dZH54r8BKswOmxCnVov7D4fziEdukPng9iXCsvHUY=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr5545313ljj.89.1622187437475;
 Fri, 28 May 2021 00:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210525141524.3995-1-dong.menglong@zte.com.cn> <20210528161012.c9c8e25db29df3dbc142c62e@kernel.org>
In-Reply-To: <20210528161012.c9c8e25db29df3dbc142c62e@kernel.org>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 28 May 2021 15:37:04 +0800
Message-ID: <CADxym3ZjQOmruJXZxR=LwtQRCKQiDFGXNAq+Yk_-+vLJcGchvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] init/initramfs.c: make initramfs support pivot_root
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        masahiroy@kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        joe@perches.com, Jens Axboe <axboe@kernel.dk>, hare@suse.de,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Barret Rhoden <brho@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        Chris Down <chris@chrisdown.name>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org, mingo@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        jeyu@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri, May 28, 2021 at 3:10 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
[...]
>
>
> This idea sounds good to me. I have tested it with MINCS container shell
> script (https://github.com/mhiramat/mincs).
>
> However, I found different issue on init_eaccess() (or symlink lookup)
> with this series.
>
> I'm using a busybox initramfs, and it makes /init as a symlink of "/sbin/init"
> (absolute path)
>
> When CONFIG_INITRAMFS_USER_ROOT=n, it booted. But CONFIG_INITRAMFS_USER_ROOT=y,
> it failed to boot because it failed to find /init. If I made the /init as
> a symlink of "sbin/init" (relative path), it works.
>
> Would you have any idea?
>

Thanks for your report!

I think it's because of the path lookup on '/'. With LOOKUP_DOWN
set, the lookup for '/' of '/init' will follow the mount. However,
during the follow link of '/sbin/init', the '/' of it will not be followed,
because LOOKUP_DOWN only works one time. I'm not sure if this is an
imperfection of 'path_lookupat()'.

I'll fix it in the next series.

Thanks!
Menglong Dong
