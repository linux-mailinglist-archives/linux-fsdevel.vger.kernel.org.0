Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA61B5650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgDWHp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgDWHp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:45:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6063CC08E934
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 00:45:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so3979456ejd.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/O9lRdDqfFxIFgSwAyPR5AZJG0gGagWbgZwtyqIE1s=;
        b=SZbvfAg3vKXVp2Bj6SzEbypHd8TcS8FOnLIPN3m3fIltj+7zvfKqbglHePHyiMIw4d
         L7y2aQxIghQZ2RRQ8vGfkRng0rgqzmFWYSV1Mdju6SgL14AawzPKICoHD1TS3SAs4iGA
         h5xqKiP5EjUypnsMeu7Jrk9alecd94GKN2TUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/O9lRdDqfFxIFgSwAyPR5AZJG0gGagWbgZwtyqIE1s=;
        b=cRYD6PEe8joixqWSO0yfO6zHu5bvC6P6BckXzqpfy+Mfi8VQbU84/N1Gt39/MPvdJw
         xX2VQ7QQinaMuBbeAwNXk4rPVonpxsYewOG6R+IiV/Y74UQo6fdC/lYAOWyySqX7m7uU
         YpiUqbFQAlntnl5VYBHDzh2ifjTBj1OA6cNUwp8qfpngILZauUJ010EdSvupT8u81/zt
         gOpjK0Yll0C2Z0w9fWj8lWUf73msrTw1/IKbhbuBuLGzEsVvw/TvKFeaOEVjKcHmkfjl
         spAT4bl59s2fLHN6vdfrw12xaNk9BoKXx4flR/4NiUwZVt01tfo9xtaEcwYzL6MZRxNw
         ZA8g==
X-Gm-Message-State: AGi0PuYyJS7DXu1ijzA3aEWryFP7V6pug5rl+WampJvFaLdG7MLtkMx+
        8mA1yuZINGuAbIs7KaBHz+VDU2HE+C2WJnNdNuVJdQ==
X-Google-Smtp-Source: APiQypKsThakU7JoMtp5/87/sxEV0VDVpFD50A8Cf/ebgOwE+JP84OLXxIBKseZGsaecLUzBmkryqccqlSh/P2MUMK4=
X-Received: by 2002:a17:906:3399:: with SMTP id v25mr1527743eja.217.1587627956915;
 Thu, 23 Apr 2020 00:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587531463.git.josh@joshtriplett.org> <9873b8bd7d14ff8cd2a5782b434b39f076679eeb.1587531463.git.josh@joshtriplett.org>
 <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
 <CAJfpegt=xe-8AayW2i3AYrk3q-=Pp_A+Hctsk+=sXoMed5hFQA@mail.gmail.com>
 <20200423004807.GC161058@localhost> <CAJfpegtSYKsApx2Dc6VGmc5Fm4SsxtAWAP-Zs052umwK1CjJmQ@mail.gmail.com>
 <20200423044226.GH161058@localhost> <CAJfpeguaVYo-Lf-5Bi=EYJYWdmCfo3BqZA=kj9E5UmDb0mBc1w@mail.gmail.com>
 <20200423073310.GA169998@localhost>
In-Reply-To: <20200423073310.GA169998@localhost>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Apr 2020 09:45:45 +0200
Message-ID: <CAJfpegtXj4bSbhpx+=z=R0_ZT8uPEJAAev0O+DVg3AX242e=-g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>, io-uring@vger.kernel.org,
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

On Thu, Apr 23, 2020 at 9:33 AM Josh Triplett <josh@joshtriplett.org> wrote:

> > What are the plans for those syscalls that don't easily lend
> > themselves to this modification (such as accept(2))?
>
> accept4 has a flags argument with more flags available, so it'd be
> entirely possible to cleanly extend it further without introducing a new
> version.

Variable argument syscalls, you are thinking?

> > I mean, you could open the file descriptor outside of io_uring in such
> > cases, no?
>
> I would prefer to not introduce that limitation in the first place, and
> instead open normal file descriptors.
>
> > The point of O_SPECIFIC_FD is to be able to perform short
> > sequences of open/dosomething/close without having to block and having
> > to issue separate syscalls.
>
> "close" is not a required component. It's entirely possible to use
> io_uring to open a file descriptor, do various things with it, and then
> leave it open for subsequent usage via either other io_uring chains or
> standalone syscalls.

If this use case arraises, we could add an op to dup/move a private
descriptor to a public one.  io_uring can return values, right?

Still not convinced...

Thanks,
Miklos
