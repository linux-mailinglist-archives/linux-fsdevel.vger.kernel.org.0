Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5EFB561
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKMQlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:41:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36550 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfKMQlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:41:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so2378393oib.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVfwiSp+CCVuO7gwDDwfVCYiALcYNYj8C4nivlUEYh4=;
        b=hEU4Jc+TMKFYo/hClXe4LbEOv2c6xDkpCXQqwl0Z22xOispCr4ItFBq6P3SIqqjsFY
         VMPkl2Ip3H8rGxZ+odTDTzTUfRJqbARb1f9rXcXv9CUCREofvYLctcVawyyirByAJMwN
         ei9fYe5bFlcuSzGJ5HwVndtFoKKv1vq4h+2X/TvDP618luMx3USRKABKneg9QTW0bRYp
         tkrge1Oo0QMqdYnIZnCmlxjw8E75S707Q2y3nfSTEUBKrhHBJIA0SMfHFNrHUt2bVP/7
         ZCtGzajbwdi4S8LQsNV+0V9OHy41RBEk3rr3XBiAVi05uEylHilzdK2PGwAkDhAT7pE1
         m7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVfwiSp+CCVuO7gwDDwfVCYiALcYNYj8C4nivlUEYh4=;
        b=FaLXFb2rAj/b9e0qXTk/qcNOwTLbdIoL499IhfirBwp0p9U3jJe2QojGSTi+q9zsmE
         T5JegDL7N9qlbOFoutDvQD1CwPkrjuLJ+kxWRdLmFvn0MIcfPzsRoDaU3CAmpMGLwaBX
         QaX7B6ZyjkgstTr63sMhkd+bWweOG0Q9Zzi3WKXAh5sUzp4q+sou+PhxLbFFETv77DAN
         Gnxr0sgNmY0Z5eMCTgz2hooSs9PsQmx7s4XZ2rNWGkPw7FsvGCp4wqCTGajT3M3cE9Fv
         lH2K+LXRo2uFInyzPDHkUgzwKekGgrnq8A4M/BKp8K+GFqKggsawrst7U9VpORYNaGIa
         IJgQ==
X-Gm-Message-State: APjAAAXhLI9hLxvjRCHU/A02bLLIoMHH87vHU2HhI1NJXXMS5r7Z+UId
        PEutOq5EUx7ATE4D5VAiqo8jL8KntWWJ9G0vuyHEmA==
X-Google-Smtp-Source: APXvYqxsagONtdiNjq6NZ5m7sI0CzPjh/C+hYdKwSFkcYayF5GIcMok6FIb/ScIimmm+EHJtckaZo27u5SdUKfTZ9s8=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr4473205oig.175.1573663259884;
 Wed, 13 Nov 2019 08:40:59 -0800 (PST)
MIME-Version: 1.0
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191112232239.yevpeemgxz4wy32b@wittgenstein> <CAG48ez0j_7NyCyvGn8U8NS2p=CQQb=me-5KTa7k5E6xpHJphaA@mail.gmail.com>
 <13bc7935-8341-bb49-74ea-2eb58f72fd1f@gmail.com>
In-Reply-To: <13bc7935-8341-bb49-74ea-2eb58f72fd1f@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Nov 2019 17:40:33 +0100
Message-ID: <CAG48ez1qtVXSBCmLCWdRwfemw6u5d-Zargm-MNJV_N0WAAoVwg@mail.gmail.com>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 5:19 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 13.11.2019 18.00, Jann Horn wrote:
> > On Wed, Nov 13, 2019 at 12:22 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> >> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> >>> Several items in /proc/sys need not be accessible to unprivileged
> >>> tasks. Let the system administrator change the permissions, but only
> >>> to more restrictive modes than what the sysctl tables allow.
[...]
> > In kernel/ucount.c, the ->permissions handler set_permissions() grants
> > access based on whether the caller has CAP_SYS_RESOURCE. And in
> > net/sysctl_net.c, the handler net_ctl_permissions() grants access
> > based on whether the caller has CAP_NET_ADMIN. This added check is
> > going to break those, right?
> >
>
> Right. The comment above seems then a bit misleading:
>         /*
>          * sysctl entries that are not writeable,
>          * are _NOT_ writeable, capabilities or not.
>          */

I don't see the problem. Those handlers never make a file writable
that doesn't have one of the three write bits (0222) set.
