Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460F310C466
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 08:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1Hmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 02:42:47 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:34407 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1Hmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:42:47 -0500
Received: by mail-il1-f179.google.com with SMTP id p6so23446011ilp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pD/mTkWcKezUCQxY5cso9hi2rhVzk4pk/wrhuo+DIQA=;
        b=UcgWqxVvSWYY8FEkGu0uUNoKegVaLEauuw3ZD/Gn19/Y9rZ30sf+5P8PMpiO3G+8r9
         8/hqHRaHVcJHRzMMwyDhaKcDydhbmsk0GI7XxzIUOg8rU50/eNOEwl+Q8xRBppbHH4Dj
         0AxrQKPNxSaX0nWNEOnMk8GzhX2vICbxeQNlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pD/mTkWcKezUCQxY5cso9hi2rhVzk4pk/wrhuo+DIQA=;
        b=qt7uxXkn6EnjS3PxW6/e7m3+2ZJ73Ha8g1MGajSAM22k2wqinHKF35Z52lt6XpAPR5
         o4d+ucDPYVm8fND//d/4D9GcsAyL6bszIdfSxEYsCriGalmsmeFLGQD1y6qwB4JgeIf8
         gLTEAaIKLnnpS6nexW/UJPDVYDTpZZvaDNAXGqGBXeQiKviBGi0F0UrWNBvAIWdy7Scm
         OcWLYxofxDVS4UpC8/L5MRLdtubh22nFq4tu5WJpWNZZbavhiWvLosYNqHU9ljdnCQkv
         jS2q8k0NNMHBr/tDAfMzUeJQFgiHyNUf7WBOfc3/qXi62ccXnM/7HxHGK6MrwNEQrq/w
         Te4g==
X-Gm-Message-State: APjAAAUjhpKlca7SiFL60mZt80YejsY5V9BPGRIn5DCynl43Ncy3HjK1
        Xn668KcnfkoWBNSbOSv4zzYThMvHvsg6o2Vg34+KNw==
X-Google-Smtp-Source: APXvYqwOStMjl4lyL8tZ8r17cZjGYSF4W86pzI2nHec3NvEKDE1vr6JL3YzvuA/dybzcvr9iiGWBWQtUSYRr0cp4gcU=
X-Received: by 2002:a92:320f:: with SMTP id z15mr29924285ile.252.1574926964737;
 Wed, 27 Nov 2019 23:42:44 -0800 (PST)
MIME-Version: 1.0
References: <8736e9d5p4.fsf@vostro.rath.org> <CAJfpegtOf6mV4m3W1v2N8eOD-ep=tFOhKDCFk+-M3=tzc7wVig@mail.gmail.com>
 <87muchyrct.fsf@vostro.rath.org>
In-Reply-To: <87muchyrct.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Nov 2019 08:42:33 +0100
Message-ID: <CAJfpegsZBLZ=w_tsk8AzV-kcmu0_PpfP86G9tuEnyuP+-19r-Q@mail.gmail.com>
Subject: Re: [fuse-devel] Handling of 32/64 bit off_t by getdents64()
To:     Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 9:52 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Nov 27 2019, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> Is there a way for a 64 bit process (in this case the FUSE daemon) to
> >> ask for 32 bit d_off values from getdents64()?
> >
> > Looking at ext4 d_off encoding, it looks like the simple workaround is
> > to use the *high* 32 bits of the offset.
> >
> > Just tried, and this works.  The lower bits are the "minor" number of
> > the offset, and no issue with zeroing those bits out, other than
> > increasing the chance of hash collision from practically zero to very
> > close to zero.
> >
> >> Would it be feasible to extend the FUSE protocol to include information
> >> about the available bits in d_off?
> >
> > Yes.
> >
> > The relevant bits from ext4 are:
> >
> > static inline int is_32bit_api(void)
> > {
> > #ifdef CONFIG_COMPAT
> >     return in_compat_syscall();
> > #else
> >     return (BITS_PER_LONG == 32);
> > #endif
> > }
>
> Thanks for the quick response!
>
> Is there a way to do the same without relying on ext4 internals, i.e. by
> manually calling getdents64() in such a way that in_compat_syscall()
> gives true even if the caller is 64 bit?

Generally that's not doable.   Might be able to do a 32bit syscall
specifically on x86_64, but I don't know the details.

Thanks,
Miklos
