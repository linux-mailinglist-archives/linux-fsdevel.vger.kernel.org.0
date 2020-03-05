Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3325017B1B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 23:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgCEWp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 17:45:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35693 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCEWp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so347047wmi.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2020 14:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9sq0PtD8PNHpFz8zMGkeDZ+7pm8RbcY+CPM2RzsDCk=;
        b=eP4PywIzRgVit2fpuHBiJTdsQvjshoxSOh+qwoBlcybf0i9xDogLqT85o71Fi+P/9R
         HqEZaI2rHhglnVfO4somc6sf5/USl645wLlCurxZb506neBqVAeK3vvwdyzZulnC4Pvw
         RDa21VXWYGFnhH5bAKrAPk8ugJx7zo2dBEoVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9sq0PtD8PNHpFz8zMGkeDZ+7pm8RbcY+CPM2RzsDCk=;
        b=s5nfCXLOZo0gTeWT8A9ZMwebhFyvJAWGqx7Z/ZN/sFjkd9yM/IlspuzQCDapeWAZLN
         N/mMaBXXkrNOKBKb923uJm0Qj+cGwScLHoNsZoPDIskgyCqnoUyysWQxQeYPxdaU8f76
         OaREflyTHLJWBMj+T/tFcKAShw3rIKRm4+6OIaPZY9FU6uuw/L+BHTLtAAD0bg73ygjt
         xbkPPmQKEdUiNgxmbZs/rsw6c54RbgOFlik5IK2uEOXgb2yigSBSibgSVrqCqgbi5ACi
         C3gp0YdJMPDadmmXahlYK41BBAH4exaYRciTObOaDRCNwZdgNXY82BfT2susIxNsN6r7
         9prA==
X-Gm-Message-State: ANhLgQ1qYlC7SvVE7TxOXskaBmd49FK6M+3akfGxZAQeSXw7s5Tv2r7+
        9mc5iq/Ct8MvpXJN8mDjU3dzDpi/JlLrNg/GOj4S1A==
X-Google-Smtp-Source: ADFU+vvqVjTvY+ZvpBG/SyVlH1n2le8rs/DsJ6zfYE+D9t4+SBuVLkfUK8u0gAALeIFdhOzKl45G1+kCL0B1PLJNdRM=
X-Received: by 2002:a05:600c:291a:: with SMTP id i26mr29766wmd.161.1583448355691;
 Thu, 05 Mar 2020 14:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20200305193511.28621-1-ignat@cloudflare.com> <20200305202124.GV23230@ZenIV.linux.org.uk>
In-Reply-To: <20200305202124.GV23230@ZenIV.linux.org.uk>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 5 Mar 2020 22:45:44 +0000
Message-ID: <CALrw=nF-0E2icB85aU6hDoGmukQ0Hp_b0Un0savTco=meQV4uw@mail.gmail.com>
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 5, 2020 at 8:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Mar 05, 2020 at 07:35:11PM +0000, Ignat Korchagin wrote:
> > The main need for this is to support container runtimes on stateless Linux
> > system (pivot_root system call from initramfs).
> >
> > Normally, the task of initramfs is to mount and switch to a "real" root
> > filesystem. However, on stateless systems (booting over the network) it is just
> > convenient to have your "real" filesystem as initramfs from the start.
> >
> > This, however, breaks different container runtimes, because they usually use
> > pivot_root system call after creating their mount namespace. But pivot_root does
> > not work from initramfs, because initramfs runs form rootfs, which is the root
> > of the mount tree and can't be unmounted.
> >
> > One can solve this problem from userspace, but it is much more cumbersome. We
> > either have to create a multilayered archive for initramfs, where the outer
> > layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
> > does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
> > kernel cmdline option, unpack initramfs to rootfs, run a script to create our
> > target tmpfs root, unpack the same initramfs there, switch root to it and again
> > properly cleanup the old root, thus unpacking the same archive twice and also
> > wasting memory, because kernel stores compressed initramfs image indefinitely.
> >
> > With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> > cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> > before the initramfs handling code, so initramfs gets unpacked directly into
> > the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
>
> IDGI.  Why not simply this as the first thing from your userland:
>         mount("/", "/", NULL, MS_BIND | MS_REC, NULL);
>         chdir("/..");
>         chroot(".");
> 3 syscalls and you should be all set...

(sorry for duplicate - didn't press "reply all" the first time)
Container people really prefer pivot_root over chroot due to some
security concerns around chroot.
As far as my (probably limited) understanding goes, while the above
approach will make it work,
it will have the same security implications as just using chroot: we
trick the system to perform
pivot_root, however we don't get rid of the actual host root
filesystem in the cloned namespace.
