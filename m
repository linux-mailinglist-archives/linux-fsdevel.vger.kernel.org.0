Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5592B1F9AC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgFOOsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgFOOsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:48:40 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69523C061A0E;
        Mon, 15 Jun 2020 07:48:39 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c8so18137913iob.6;
        Mon, 15 Jun 2020 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFYHq9QU1VF3rchooKVX3EvDkFFGgQYVgoX+nSdXTuc=;
        b=PRxkgdzs6hj4NpKjLdU4+mZo+kiLgpl3v8qO3FUtkLItVntqN/v1UtTbvyh1fAkJDQ
         /r/QUNFX0i3kNhar6p3HMQRIc0/hnPpxSyfCSOk/7QGhSriP8dugDYCbD3NVmr3r39T+
         L0RU8h1FEoVzRUIqiHPXWetm4KkkvOZ8sZuPa8pJIZPJbfJz9/qmImf4Haoxykq/U+Wm
         z0McY86vBdXb73lWVCJytm+tusWr8I6JfrKJ++433fcbFQ7IdZZfKn+gl9mRtO93JHfb
         KS+ugwQDy31DiZDXPTjkRurzgAFvHZ4Gbe2s6FFN7LQGjbdA1Klosmt+SwHoidzFhQqC
         XkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFYHq9QU1VF3rchooKVX3EvDkFFGgQYVgoX+nSdXTuc=;
        b=gu9PBb2xVGRKsDeAvPl9dTwQsZgQo83ED5+xLkeqKLebPGrluehaGJyzD5Rog37869
         LNj/HGqUyMaGNCUgXT9+XI9PEnVluj/BcfKm0wxHhbU/ioq3FO+/ZNrlkPKvcb/ya5yY
         JsM93Nk4l4fGc5QIJft26rXR6n8qQamrRMInu3+WjuwcIKpfBeFbga9nuAHF2Qe0I90i
         Ec0UT8XIXr5COHFwYhXQF74UzQm/MUxiNlFJIphd5FbuvrIbfU5pXTi3x4uu9LfQC4Zr
         hQGVdXPJPsPJdcMxMR8tjNSFkOnVbTQvGpljZ1CIZ6pUew1wb1E7Ot8Erpy96GGBxyam
         q5Gg==
X-Gm-Message-State: AOAM5300G7d+CpmXZt7VC/rgKW4r+5pLQX89/wkvCN3fmcBqLrzWnYbP
        TUFgxN7kWSNPd5Vw3QkzK3q0J/YecSriAkDCuE//
X-Google-Smtp-Source: ABdhPJyd6RZmdZpxGVu6c3gRb+Y3l0bsTdnHuSOZYnX1P537cI9jfkNEPZLpydEoTLgL6kUKfHIZe+3b9Hy/JybhE4I=
X-Received: by 2002:a02:3501:: with SMTP id k1mr6072971jaa.133.1592232518583;
 Mon, 15 Jun 2020 07:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de>
In-Reply-To: <20200615141239.GA12951@lst.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 15 Jun 2020 10:48:26 -0400
Message-ID: <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:
> > >  #ifdef CONFIG_COMPAT
> > > -       if (unlikely(argv.is_compat)) {
> > > +       if (in_compat_syscall()) {
> > > +               const compat_uptr_t __user *compat_argv =
> > > +                       compat_ptr((unsigned long)argv);
> > >                 compat_uptr_t compat;
> > >
> > > -               if (get_user(compat, argv.ptr.compat + nr))
> > > +               if (get_user(compat, compat_argv + nr))
> > >                         return ERR_PTR(-EFAULT);
> > >
> > >                 return compat_ptr(compat);
> > >         }
> > >  #endif
> >
> > I would expect that the "#ifdef CONFIG_COMPAT" can be removed
> > now, since compat_ptr() and in_compat_syscall() are now defined
> > unconditionally. I have not tried that though.
>
> True, I'll give it a spin.
>
> > > +/*
> > > + * x32 syscalls are listed in the same table as x86_64 ones, so we need to
> > > + * define compat syscalls that are exactly the same as the native version for
> > > + * the syscall table machinery to work.  Sigh..
> > > + */
> > > +#ifdef CONFIG_X86_X32
> > >  COMPAT_SYSCALL_DEFINE3(execve, const char __user *, filename,
> > > -       const compat_uptr_t __user *, argv,
> > > -       const compat_uptr_t __user *, envp)
> > > +                      const char __user *const __user *, argv,
> > > +                      const char __user *const __user *, envp)
> > >  {
> > > -       return do_compat_execve(AT_FDCWD, getname(filename), argv, envp, 0);
> > > +       return do_execveat(AT_FDCWD, getname(filename), argv, envp, 0, NULL);
> > >  }
> >
> > Maybe move it to arch/x86/kernel/process_64.c or arch/x86/entry/syscall_x32.c
> > to keep it out of the common code if this is needed.
>
> I'd rather keep it in common code as that allows all the low-level
> exec stuff to be marked static, and avoid us growing new pointless
> compat variants through copy and paste.
> smart compiler to d
>
> > I don't really understand
> > the comment, why can't this just use this?
>
> That errors out with:
>
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> `__x32_sys_execve'
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> `__x32_sys_execveat'
> make: *** [Makefile:1139: vmlinux] Error 1

I think I have a fix for this, by modifying the syscall wrappers to
add an alias for the __x32 variant to the native __x64_sys_foo().
I'll get back to you with a patch.

--
Brian Gerst
