Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607041B397D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDVH4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbgDVH4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:56:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C41C03C1AA
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 00:56:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so797176edv.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1biaZy6y7PqsHY/+KktbP6zQiSCk/Tgyi9hv1rSztM=;
        b=bq86XvJQnxv50SBPGcKLs3Fr8gh99Hv1Y4lzJCnHBgVuYJVbw6RrjrVKfGtFku6EZG
         kO4dXzupMYLoia0Lmt+RHfv1Xuu9JA4Y2Vmd3a8UrJgbKKxBUsTKJGojbSu5aJgfhEmo
         5EM4zr0i3Guzu9oLNTActfb698GxdY2nsEaBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1biaZy6y7PqsHY/+KktbP6zQiSCk/Tgyi9hv1rSztM=;
        b=iqE3BbQdGt/V0ppxyqK4nOcbxuggHEBKeIqXIODnN7lpZvjgLJRjR/0RDuAmgZhOgy
         waVPd9PCXBowOwfYuCc7+hSyejrcscNoYrQ82JsHWwZRuEKXw5oCzkBM/bKvMFRckhLH
         M8V9K6+MrIe5X/oXcrTKiyGPDn7zQdOMSGTxzO6ZlIiZvrnKq0ovQPIKF2ILj2gIkcHO
         UF8guORjFZ5gC7/G5jd4GAVdhAbQvPjBMFSby/q7FTGE0zKPFRHI0Q5LC8bTURPJgiEc
         flSNemQ/Cq8ep/iu6f9gx88xtzjz+8Ck6Ny1dBT4itfRTv1Kc47N+RsVI++0ZUno2uz0
         keag==
X-Gm-Message-State: AGi0PuZHFVzHeFGF1LlyPGy7Gm/WJj0ScCK3lDYHR2B58tfsw51t0HAb
        Nh4xRQy+mSocwhkC3A3Z/R0Kkwnbm2a4gYuqzKz9mBOLVEM=
X-Google-Smtp-Source: APiQypK9NkZBpfIRxtVZgJkwWgqgZC5WwR3a2fRu7Zp4jUgGSYA2Xwz4zVEf0igsy8uL0etsgNy6Z5nE2u7gSECiDNk=
X-Received: by 2002:a05:6402:22ed:: with SMTP id dn13mr21651703edb.212.1587542168000;
 Wed, 22 Apr 2020 00:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587531463.git.josh@joshtriplett.org> <9873b8bd7d14ff8cd2a5782b434b39f076679eeb.1587531463.git.josh@joshtriplett.org>
 <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
In-Reply-To: <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 22 Apr 2020 09:55:56 +0200
Message-ID: <CAJfpegt=xe-8AayW2i3AYrk3q-=Pp_A+Hctsk+=sXoMed5hFQA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, io-uring@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 8:06 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> [CC += linux-api]
>
> On Wed, 22 Apr 2020 at 07:20, Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > Inspired by the X protocol's handling of XIDs, allow userspace to select
> > the file descriptor opened by openat2, so that it can use the resulting
> > file descriptor in subsequent system calls without waiting for the
> > response to openat2.
> >
> > In io_uring, this allows sequences like openat2/read/close without
> > waiting for the openat2 to complete. Multiple such sequences can
> > overlap, as long as each uses a distinct file descriptor.

If this is primarily an io_uring feature, then why burden the normal
openat2 API with this?

Add this flag to the io_uring API, by all means.

This would also allow Implementing a private fd table for io_uring.
I.e. add a flag interpreted by file ops (IORING_PRIVATE_FD), including
openat2 and freely use the private fd space without having to worry
about interactions with other parts of the system.

Thanks,
Miklos
