Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E079528E9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbgJOBYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbgJOBYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:24:37 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9AC045700;
        Wed, 14 Oct 2020 18:07:59 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h6so839991ybi.11;
        Wed, 14 Oct 2020 18:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+PgrjkcIkmu+076L7tWgIroll5ax17nHCM3RZy5YJY=;
        b=WT2Rj2jw0/E5FIZbOZ0S882a+YX0FFzXV11/lzknamJ1ZSbdOQFQLRP8acyzhESnju
         HerOSpCkFQsDI31snh3zgOEMCUddiS4ae2VNDilEqftnwDThN/oD0sfdnkaybjXckrQG
         Hp4T2R4A8dHnk2JNMkle2mLly0Y+yiMxK4tyWci2fOp/TwMl8WN2fLL41CKUTig/UzkY
         7pubICVz3XncFyDl/0CtZfJ5zVy/GJ7uX1ybvxF7wKqad6PavHwzBPo4jg8TtRN1SkoU
         SCMsFjn4oC7Sxrg/PCVqFSDK0u0nlTWx4gUeqUcHCbLA39nwoKlORGvsLzgc0HJQ/qXN
         7jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+PgrjkcIkmu+076L7tWgIroll5ax17nHCM3RZy5YJY=;
        b=dAjFh4VqZHziNqc2S2pnF2F/HPsOVr02j+MvcF3AcqlB6mJjo24aG7TU96ny80OaAq
         I4zbIN2W/MzJiUTaS7GBowTd5twT/yfK0miQrR+vvQl9M7K8bM2VFUFEm05Egubzr5xD
         KcB+hV36OLKaUz2zxtR6+S4ya2mpvGunVAJveGrINMw75SqXeNqCspdm+LR7/Gq3SVsu
         WrMuCw3IF9a3BhAYcj0gHRq/kc5XGaeKNXjSI5eudb/dYgeJQkSn4nzY4qBuQZ/YeCoK
         R8c25Aq5sCIIsdiMJUuJnW5DSg9EOue7Pi5Lum2Gp/m8MNM6ebmFhhU0TmRS8ARJFweQ
         /djw==
X-Gm-Message-State: AOAM5318jwmj4WOEeKoWA/HAdipskCUdBsoxgoOIMU2utJmBoQ24K3BC
        zMw6Y1ixJEQkaBxDF8k7J8l3A583dhugpq9LuFs=
X-Google-Smtp-Source: ABdhPJyn6PZb5Tce9qU8H9wCf29g15keBR5Bt+3V81qDyDp+sifB49fkwStSiZ4BgmTqR+i8EP8BJkwNrJBg144oHzI=
X-Received: by 2002:a25:2687:: with SMTP id m129mr1993747ybm.425.1602724079004;
 Wed, 14 Oct 2020 18:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201014204529.934574-1-andrii@kernel.org> <20201014230812.GK3576660@ZenIV.linux.org.uk>
In-Reply-To: <20201014230812.GK3576660@ZenIV.linux.org.uk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Oct 2020 18:07:48 -0700
Message-ID: <CAEf4BzZQdkJaaqx7CQ6kjA+_nKuE3N1sBzR933wohmB+a5GvpA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in prepend_path()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 4:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Oct 14, 2020 at 01:45:28PM -0700, Andrii Nakryiko wrote:
> > Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
> > holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
> > might re-read the pointer again which could be NULL already, if in between
> > reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
> > to NULL.
>
> Cute...  What config/compiler has resulted in that?  I agree with the analysis, but

Don't know for sure, but nothing special or exotic, a typical Facebook
production kernel config and some version of GCC (I didn't check
exactly which one).

Just given enough servers in the fleet, with time and intensive
workloads races like this, however unlikely, do surface up pretty
regularly.

> I really hate the open-coded (and completely unexplained) use of IS_ERR_OR_NULL()
> there.
>
> > -                     if (is_mounted(vfsmnt) && !is_anon_ns(mnt->mnt_ns))
> > +                     mnt_ns = READ_ONCE(mnt->mnt_ns);
> > +                     /* open-coded is_mounted() to use local mnt_ns */
> > +                     if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
> >                               error = 1;      // absolute root
> >                       else
> >                               error = 2;      // detached or not attached yet
>
> Better turn that into an inlined helper in fs/mount.h, next to is_mounted(), IMO,
> and kill that IS_ERR_OR_NULL garbage there.  What that thing does is
>         if (ns == NULL || ns == MNT_NS_INTERNAL)
> and it's *not* on any kind of hot path to warrant that kind of microoptimizations.

Sounds good. I didn't know code well enough to infer NULL ||
MNT_NS_INTERNAL instead of IS_ERR_OR_NULL from is_mounted(), so just
open-coded the latter.

>
> So let's make that
>
> static inline bool is_real_ns(struct mnt_namespace *mnt_ns)
> {
>         return mnt_ns && mnt_ns != MNT_NS_INTERNAL;
> }
>
> turn is_mounted(m) into is_real_ns(m->mnt_ns) and replace that line in your fix
> with
>                         if (is_real_ns(mnt_ns) && !is_anon_ns(mnt_ns))
>
> Objections?

Nope, I'll send a follow-up patch, thanks.
