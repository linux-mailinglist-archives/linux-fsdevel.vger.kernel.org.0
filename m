Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4160FCF40F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfJHHiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:38:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32880 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfJHHiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:38:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so15729298qkb.0;
        Tue, 08 Oct 2019 00:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbd4LwTe2nWyrbyUcSTPuXGgKbWXcMoJfVlsDK0/Jr0=;
        b=Z1Ij7QRNg4zLVC35kvIKtGkNYSV/s8iqVlzbAK39GeCzlQiOXci6EibabfemuxseHf
         wcKtjFaXpb8JJaPv+ly9Ihu4G+YJs1mAGSmkLrjeZZL3eyxWLQ2SV8KSbb0Tc1IhxqdJ
         SSnUsnov9cQu076XyR98/FHObi3heTsm8iMftoBR+7mW2CvPXQcDaAtSKiACH27L1Gt2
         0FxcdovCxwuX+1Iquk5CgyvO8N2sqdS9pzlC70J8CghMrddc1PkDxdMf3QadXo0Dodyg
         GzDAoIII0EwxrVyCEQ6+/+k/tYLWZKPK0GIyHTpwgZ132CERnRGMtY2uXPJcBXFMVDkA
         yAhw==
X-Gm-Message-State: APjAAAWbOhyRuGfZhdykUQhKx9hwQyKFvSc15VaavV/5VzSPhuPaG/I7
        +i/D+L2euI7d0JHiO5uuBrF6IRUp4xhQAIK/8KV2elPE
X-Google-Smtp-Source: APXvYqzcf+5doqvGjsXoxwiYZc2Sqxk+klm8vj61NWmH76ms0Hh79Gy5LC/8cZSjDzvTebNc9s0wYAimZ+IphWx8mVo=
X-Received: by 2002:ae9:f503:: with SMTP id o3mr27266851qkg.3.1570520329521;
 Tue, 08 Oct 2019 00:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-6-arnd@arndb.de>
 <20191007232832.GA26929@roeck-us.net>
In-Reply-To: <20191007232832.GA26929@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Oct 2019 09:38:33 +0200
Message-ID: <CAK8P3a3bDnHRexRP7xntE_r=E4TfdnYqzAF_wrHwA35KjtGsfA@mail.gmail.com>
Subject: Re: [PATCH v5 05/18] watchdog: cpwd: use generic compat_ptr_ioctl
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 8, 2019 at 1:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Aug 14, 2019 at 10:42:32PM +0200, Arnd Bergmann wrote:
> > The cpwd_compat_ioctl() contains a bogus mutex that dates
> > back to a leftover BKL instance.
> >
> > Simplify the implementation by using the new compat_ptr_ioctl()
> > helper function that will do the right thing for all calls
> > here.
> >
> > Note that WIOCSTART/WIOCSTOP don't take any arguments, so
> > the compat_ptr() conversion is not needed here, but it also
> > doesn't hurt.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> This patch made it into the kernel, but the infrastructure didn't make it.
> Do we need to revert it ?

Sorry I had not realized that this patch got queued in the watchdog tree
and relied on the other patches. I ended up not sending the series after
a runtime regression in another driver, combined with the series not
having spent much time in linux-next before the merge window.

I've sent a fixup patch now that will make it do the right thing
regardless of my series, please apply that for v5.4.

        Arnd
