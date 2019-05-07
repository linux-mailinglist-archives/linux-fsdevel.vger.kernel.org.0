Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5EE15ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 10:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfEGIHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 04:07:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34018 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfEGIHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 04:07:34 -0400
Received: by mail-io1-f65.google.com with SMTP id g84so5511701ioa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEZVy9C+Z3ICJpvsn26xeqhO1e763sY5Q6qDpaKXZYs=;
        b=JciVvm+L8utAHEyD6sXVzJvXBWDDmLzUDru6e2Z6O7UUhE2uYt6t01+U9KuovpPXFK
         SVoBnOMRpR/M0jYtVyra7OBS30QfLjlk+10q3bu8kYLImeYysyY5BCIcTiaH8mJwq+lF
         dWqGpCsk3fQOh11X0sH7ux9nl+jIhQyw49PY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEZVy9C+Z3ICJpvsn26xeqhO1e763sY5Q6qDpaKXZYs=;
        b=mHr7K37GlWx7bAuczNm/5QW4V6Y1DsmB2sBZcSjAgAuT+cJxNTMYU2vSJtF1R96KqT
         wZ48Gow0Xcw0R0T8qKVPsHS6uhsoBNN6ZtxlY4UKws6ebrEmJpJ0His8rhJWoSIETz7/
         UXpC/Fp+O4225bEiQgorrdRbqNhlMNp2rSgySIovQngP/rKd0LR38qEmhwg7xzd/IVZy
         MBKemrXCfGeL5Y577Pb0stLu8CELaF8THf5EDu58H/wIIG/D4I8Wv+l5qJpjx2fshwTL
         2PCrjPsp/m3OZEtTVpECNp/jMLQb3DnAOfNJEprKmyVLc4uN+nfemronlHp2cRCZ0knS
         RjUA==
X-Gm-Message-State: APjAAAV5yPbhCiKnDVA3jKBm+MhKEu+XnE2wMoLMqeB2OwrbXBAEkIAF
        F7kqfFKwOehElg6ZPqXrwXjVBxCMxFs9/S1Lc0gfng==
X-Google-Smtp-Source: APXvYqwG7Qhlz0ih1MCulvyvogd0VnUgA/VyGWATqTE+j80uOQBpCOYbueOcG/IyjFlZNjhBSEPaLFPbgVREQTdhdl0=
X-Received: by 2002:a6b:ee04:: with SMTP id i4mr1817315ioh.246.1557216453174;
 Tue, 07 May 2019 01:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
In-Reply-To: <20190503153531.GJ12608@fieldses.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 May 2019 04:07:21 -0400
Message-ID: <CAJfpegv-0mUs=XRgerxR_Zz_MvYuDvb95v0QZeBUcHNnenusnw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 3, 2019 at 11:35 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, May 02, 2019 at 12:02:33PM +1000, NeilBrown wrote:

> >  Silently not copying the ACLs is probably not a good idea as it might
> >  result in inappropriate permissions being given away.  So if the
> >  sysadmin wants this (and some clearly do), they need a way to
> >  explicitly say "I accept the risk".
>
> So, I feel like silently copying ACLs up *also* carries a risk, if that
> means switching from server-enforcement to client-enforcement of those
> permissions.

That's not correct: permissions are checked on the overlay layer,
regardless of where the actual file resides.  For filesystems using a
server enforced permission model that means possibly different
permissions for accesses through overlayfs than for accesses without
overlayfs.  Apparently this is missing from the documentation and
definitely needs to be added.

So I think it's perfectly fine to allow copying up ACLs, as long as
the ACL is representable on the upper fs.  If that cannot be ensured,
then the only sane thing to do is to disable ACL checking across the
overlay ("noacl" option).

Thanks,
Miklos
