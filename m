Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5353C76D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhGMTSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 15:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGMTSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:18:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD6C0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 12:15:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h9so16274219ljm.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M18otY56PpJwNrQJZprVka1qTQakvoKBClejDnSkTrE=;
        b=Rw5P0JTho1kjLZqea6CQ8gUagVJNs4k3emejx1WscQgRmsreZEOQiJc8y++sSNzf0m
         yUK2cGVT6b3RBD//TAYSElF0ZPAUW145ztuAEdq517sQsSfp0z+NSo1QNXrpyx8J+aXd
         SWZpFinMKDaD5pO2gHyIUWmKwlMrim3t2qYNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M18otY56PpJwNrQJZprVka1qTQakvoKBClejDnSkTrE=;
        b=C1l63ipcbrivnNzvjzZhJK/3m+h3g8qB6COyGaLtV7aEMI/4QTLCPgRaNXYAyimxxu
         3haxEeC6ydUVeosfLZzY4xA7YloxYeIAqc8Rm5T3uXbFzWIFy7UrK82/x7IqkPUzAtvK
         xALz5c4hSwbz4uEwCrk90vesELPTV/7ljTrBgPB1G1TZOg1drar41sdBhWZFgnZ6hJoI
         BAp5ukhJBUNKrrinT1fJoJQ4QQ9n1n4Mxl+YAt9qdRl5hNdw1k+EHqKMiAsfmUACrQY1
         rko0BfM+G+oO3ha6mha0BCGQ/+WT/cgqvPOagZ9Bc0dI1EaU3PUkR3CxOo1Payb1WDyQ
         bIYA==
X-Gm-Message-State: AOAM533Cx/7mkDJ1jnusp/15WqKaFYyK9pxNFHolltiBXnN82BowdmnK
        Kxz0d3vo930qNtMjpkZRvA/+iW0Lboao21dzDEI=
X-Google-Smtp-Source: ABdhPJxtqCNwaedK3X6p6gGbwYuF4llEKTwdEpeIQf4FXNB3FB9eMVVmvPXVu41lv78uUoYyK2NGYQ==
X-Received: by 2002:a2e:9a53:: with SMTP id k19mr5476457ljj.482.1626203729688;
        Tue, 13 Jul 2021 12:15:29 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r3sm1652767lfc.280.2021.07.13.12.15.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 12:15:29 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id n14so52208548lfu.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 12:15:29 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr4501282lfc.201.1626203729021;
 Tue, 13 Jul 2021 12:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
In-Reply-To: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jul 2021 12:15:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
Message-ID: <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 3:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Linus, sorry for sending this directly through you, instead of going
> through some other tree, but trying to get this upstream through the
> linux-fsdevel list / patch-review simply is not working.

Well, the filesystem maintainer sending their patches to me as a pull
request is actually the norm rather than the exception when it comes
to filesystems.

It's a bit different for drivers, but that's because while we have
multiple filesystems, we have multiple _thousand_ drivers, so on the
driver side I really don't want individual driver maintainers to all
send me their individual pull requests - that just wouldn't scale.

So for individual drivers, we have subsystem maintainers, but for
individual filesystems we generally don't.

(When something then touches the *common* vfs code, that's a different
thing - but something like this vboxsf thing this pull request looks
normal to me).

Even with a maintainer sending me pull requests I do obviously prefer
to see indications that other people have acked/tested/reviewed the
patches, but this is fairly small, simple and straightforward, and
absolutely nothing in this pull request makes me go "oh, that's
sketchy".

So no need to apologize at all, this all looks very regular.

               Linus
