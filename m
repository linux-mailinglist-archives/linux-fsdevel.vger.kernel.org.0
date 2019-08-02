Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE7C7ED3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbfHBHPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 03:15:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38299 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbfHBHPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:15:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so72906749qtl.5;
        Fri, 02 Aug 2019 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMXU/Q1UCc6A820QQy1c6BMDY+exoOtiPs0ry5ZLZE4=;
        b=on9SHantLjGeDOpHD4VHvthdEKHbuIrBX6lLTPBgyH/PLmJum1bFjqg/j7SFs+pUzg
         8Tul/0miNnOFbiOVvmukqokQAshzyUrtuGKchu6sLnCo/gsfmXZFuJDM0jv6iyKYSWMZ
         rIuFUQNyZoOtmODJ2RyHM62BwUv8iiaoDJI3OSvLpSs8uUAYCQ2mRQnXKwq7fGu0iO3m
         moPLyawWr+JZVZb07CEIYdqfitVrlCOe3wH4ORSTqTjQ3csxfJWHyHz6ruAke2003HoM
         5fwFUgHCCh3c3PVlrGeG3nQRWxj09Hf+Ks1a0gOfD5FOvoNIw0qiJDRHTJpptiwwxjTZ
         pQTw==
X-Gm-Message-State: APjAAAXvyzKFcQmkxkgS5t8JzyUWvRfhlrx58JdmyTDSRC32uqsJEhi8
        BMyozK90RmA9p194shK95yaL8wkCRLmVNShwKcc=
X-Google-Smtp-Source: APXvYqzqfMW/bMSnK54LXWjk3hHMGCjxM9SuNy+53tZzW6vs/h8P/P3Hx1sP4LmK97Xx1YKvE5PpQWED7TwWBc6OtRY=
X-Received: by 2002:ac8:f99:: with SMTP id b25mr86332658qtk.142.1564730135063;
 Fri, 02 Aug 2019 00:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-20-deepa.kernel@gmail.com>
 <201907292129.AC796230@keescook> <CAK8P3a2rWEciT=PegCYUww-n-3smQHNjvW4duBqoS2PLSGdhYw@mail.gmail.com>
 <CABeXuvrmNkUOH5ZU59Kg4Ge1cFE9nqp9NhTPJjus5KkCrYeC6w@mail.gmail.com>
In-Reply-To: <CABeXuvrmNkUOH5ZU59Kg4Ge1cFE9nqp9NhTPJjus5KkCrYeC6w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Aug 2019 09:15:18 +0200
Message-ID: <CAK8P3a3DyWcvOpMsc__CZDmG50MXRisbBt+mTtwWCGKaNgg_Gg@mail.gmail.com>
Subject: Re: [PATCH 19/20] pstore: fs superblock limits
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 2, 2019 at 4:26 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Tue, Jul 30, 2019 at 12:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Jul 30, 2019 at 6:31 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Mon, Jul 29, 2019 at 06:49:23PM -0700, Deepa Dinamani wrote:
> > > > Also update the gran since pstore has microsecond granularity.
> > >
> > > So, I'm fine with this, but technically the granularity depends on the
> > > backend storage... many have no actual time keeping, though. My point is,
> > > pstore's timestamps are really mostly a lie, but the most common backend
> > > (ramoops) is seconds-granularity.
> > >
> > > So, I'm fine with this, but it's a lie but it's a lie that doesn't
> > > matter, so ...
> > >
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > >
> > > I'm open to suggestions to improve it...
> >
> > If we don't care about using sub-second granularity, then setting it
> > to one second unconditionally here will make it always use that and
> > report it correctly.
>
> Should this printf in ramoops_write_kmsg_hdr() also be fixed then?
>
>         RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
>         (time64_t)record->time.tv_sec,
>         record->time.tv_nsec / 1000,
>         record->compressed ? 'C' : 'D');
>     persistent_ram_write(prz, hdr, len);
>
> ramoops_read_kmsg_hdr() doesn't read this as microseconds. Seems like
> a mismatch from above.

Good catch. This seems to go back to commit 3f8f80f0cfeb ("pstore/ram:
Read and write to the 'compressed' flag of pstore"), which introduced the
nanosecond read. The write function however has always used
microseconds, and that was kept when the implementation changed
from timeval to timespec in commit 1e817fb62cd1 ("time: create
__getnstimeofday for WARNless calls").

> If we want to agree that we just want seconds granularity for pstore,
> we could replace the tv_nsec part to be all 0's if anybody else is
> depending on this format.
> I could drop this patch from the series and post that patch seperately.

We should definitely fix it to not produce a bogus nanosecond value.
Whether using full seconds or microsecond resolution is better here,
I don't know. It seems that pstore records generally get created
with a nanosecond nanosecond accurate timestamp from
ktime_get_real_fast_ns() and then truncated to the resolution of the
backend, rather than the normal jiffies-accurate inode timestamps that
we have for regular file systems.

This might mean that we do want the highest possible resolution
and not further truncate here, in case that information ends
up being useful afterwards.

         Arnd
