Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81EDC61A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408531AbfJRNbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 09:31:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45416 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408509AbfJRNbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:31:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id z67so5230288qkb.12;
        Fri, 18 Oct 2019 06:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpuqPfUBPTEqWzHgbYNa7ad4BsKzW7eS2KnXx2Hiqco=;
        b=txP5fwCI3WUIZws4MVeGifPoLuCDRPA7Plw7TyNdkA53uP+G8MWtyuFOH+lfR22JFj
         +DroiMesz8CxtTpkRL1TAWOLARyE8GPTdVUuz4VBpaxHcrcDh8SsaP5rNqfgP3gm7+PN
         ECLoGVu53k9z9B41BZ7G2Fvj0FV7WIWC1JQEOUlKpxpz7LN7w/P/x4aumhm3oFXKXMrz
         y/kizVxtj4OOLWW7XnSkC4aRq9wCoSX/ADsRGlobqepGAglSjvtLxnjF1zOmbc9K9jIv
         OkOv9fmie4IjnvHRGizDncx3j1RD4EriOoE4zj41tho/ptxHB3XqvWyImDxmI3/gdHPL
         k8zQ==
X-Gm-Message-State: APjAAAUC6wfDQkGolXKY+AfONn+/eXLzKpkD+4amJQt1tzKwYOpq3Nd1
        JaV54ly69MkRPgWEKu6Y9s0c+pEdrVdr+1Oyi8o3zqo+
X-Google-Smtp-Source: APXvYqzOMqpWH53nssj4UOb90GoWE0aTwtTW8fdt3FuVvxqZJH/Yp7jjOPhd0gjMwu9H15wolHwF2BSyXBxNndzQuco=
X-Received: by 2002:a37:9442:: with SMTP id w63mr8599892qkd.138.1571405492947;
 Fri, 18 Oct 2019 06:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-32-arnd@arndb.de>
 <1984049ff0e359801401fbbcbdbc21ee0a64c1a9.camel@codethink.co.uk>
In-Reply-To: <1984049ff0e359801401fbbcbdbc21ee0a64c1a9.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Oct 2019 15:31:16 +0200
Message-ID: <CAK8P3a2V_xP44X-Y3Mx1jX_16wKbc+T_REUP-jzj8bxPMVnifQ@mail.gmail.com>
Subject: Re: [Y2038] [PATCH v6 31/43] compat_ioctl: move WDIOC handling into
 wdt drivers
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 18, 2019 at 2:49 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Wed, 2019-10-09 at 21:10 +0200, Arnd Bergmann wrote:
> > All watchdog drivers implement the same set of ioctl commands, and
> > fortunately all of them are compatible between 32-bit and 64-bit
> > architectures.
> >
> > Modern drivers always go through drivers/watchdog/wdt.c as an abstraction
> > layer, but older ones implement their own file_operations on a character
> > device for this.
> >
> > Move the handling from fs/compat_ioctl.c into the individual drivers.
> >
> > Note that most of the legacy drivers will never be used on 64-bit
> > hardware, because they are for an old 32-bit SoC implementation, but
> > doing them all at once is safer than trying to guess which ones do
> > or do not need the compat_ioctl handling.
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/powerpc/platforms/52xx/mpc52xx_gpt.c |  1 +
> >  arch/um/drivers/harddog_kern.c            |  1 +
> >  drivers/char/ipmi/ipmi_watchdog.c         |  1 +
> >  drivers/hwmon/fschmd.c                    |  1 +
> >  drivers/rtc/rtc-ds1374.c                  |  1 +
> [...]
>
> It Looks like you missed a couple:
>
> drivers/rtc/rtc-m41t80.c

No idea how I missed this. Adding it now.

> drivers/watchdog/kempld_wdt.c

This one is covered: the watchdog_ops->ioctl is called by
the wdt_dev_ioctl() function as a fallback.

After checking once more, I did find another instance I missed
though: drivers/hwmon/w83793.c, I'm adding that as welll now.

m41t80 does not seem to have any 64-bit machines using it,
but w83793 does, and they clearly both should have been
changed.

Thanks for the review!

     Arnd
