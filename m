Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4589524678F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHQNoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgHQNoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:44:19 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A506C061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 06:44:19 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id e20so4747271uav.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YK1g7CpAj1uxdUMop0TAQ/KlG7NubSk4gl7YMK07x3k=;
        b=ckeoC9vO/EDF3YhPTlzEiluCGyrsP53BCP34FHVrdI8dpxxDV3K+SwS1hVvx0mZcmM
         e2O91NKmU+NTYcN/tz61BiWW9QlDpE/ctnp1RkSV1f3S0tJquoPdWFtFvwbM/qj+ig42
         Zx0Etpm3KzjpWimA7LfYgeTbvIYJ+MqLP2/1WK0GsLq/AJ4Gq3/IYaIVHao2TI3hcZfP
         68I7yu3R0UWmbe6eTH+cBL+DEwLUN/83wu07NWUwmKKz3AZctOS6JJatO5ps/e1MpIEc
         FG4FYDE5qqMgZ9NiMEdTtKRZS7MBhdsf9UCzEXzeLnjCseF8vqop52zofptLynay9JjQ
         6qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YK1g7CpAj1uxdUMop0TAQ/KlG7NubSk4gl7YMK07x3k=;
        b=iHpkV/2jsFLG3xowtTybLcUptBzgKu9PVeFpLlYXiO8B8cvZwHtTNUK/OeAA+vJDjw
         VmLOyxj9brQDxIuZA/Yfpr2rWi5UvGum3hiF+79B4zMQRCr80oIYozKmHgj7Rb/8uw8L
         T/tz8H8bbPY3onXePW2N6zP0Moi886GUjXpxKfRbJUasFZqH+IIAgLPHedTvFr0o3lmk
         txuY9Pn1GwNDSwF4IoIq7WGgKNRVBxvYQKULyH2Zn6CmGHvP9fwbJr3JvPgycx0aBAEI
         QPDpxix+ZBgYKoZ9JSNt9dqDt75U53dTJTO2JePXDqRT6k5rV+E239Y8ZANU5ZDexALx
         sN5Q==
X-Gm-Message-State: AOAM5302qh5Sq7OeBKj6LBTg8FyNm/FYlitxd1wqbylHAQW0Pue0xgMI
        MmKjs2qsj66I4hkLboIJNAl1cQ4AY89xfQtqrGSZSw==
X-Google-Smtp-Source: ABdhPJx2boyWtvrgXSxzxAFNpocIavvkFNhc8FhgjvFzGZM8f5Qera674/ApAjhCKTryvJlmcUOHc2HfleHlukxtHlM=
X-Received: by 2002:a9f:35d0:: with SMTP id u16mr7432899uad.113.1597671858524;
 Mon, 17 Aug 2020 06:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200728163416.556521-1-hch@lst.de> <20200728163416.556521-3-hch@lst.de>
 <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 17 Aug 2020 19:14:04 +0530
Message-ID: <CA+G9fYs4w46bZtgaKTzTLgaqNDcw3vdRaKWuGJ4wN4SSKJqUKA@mail.gmail.com>
Subject: Re: [PATCH 02/23] fs: refactor ksys_umount
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        chrubis <chrubis@suse.cz>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 Aug 2020 at 20:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 28 Jul 2020 at 22:04, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Factor out a path_umount helper that takes a struct path * instead of the
> > actual file name.  This will allow to convert the init and devtmpfs code
> > to properly mount based on a kernel pointer instead of relying on the
> > implicit set_fs(KERNEL_DS) during early init.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/namespace.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 6f8234f74bed90..43834b59eff6c3 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c

<trim>

>
> Regressions on linux next 20200803 tag kernel.
> LTP syscalls test umount03 mount a path for testing and
> umount failed and retired for 50 times and test exit with warning
> and following test cases using that mount path failed.
>
> LTP syscalls tests failed list,
>     * umount03
>     * umount2_01
>     * umount2_02
>     * umount2_03
>     * utime06
>     * copy_file_range01

The reported issue has been fixed in linux next 20200817 tag by
below patch.

fs: fix a struct path leak in path_umount
Make sure we also put the dentry and vfsmnt in the illegal flags and
!may_umount cases.
Fixes: 41525f56e256 ("fs: refactor ksys_umount")

- Naresh
