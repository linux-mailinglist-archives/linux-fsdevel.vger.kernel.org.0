Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B507D53735A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 03:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiE3Blv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 May 2022 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiE3Blq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 May 2022 21:41:46 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128DDA2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 18:41:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v106so9770681ybi.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 18:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS0rBnqOnJwywVyggv6WLP51bLfritdDS+YaRb6g8Nc=;
        b=aS+aaNRTQ+HPNZXIUQ1ZY9Z98ln0UL2QNqEGotUtIAi4tvJ/68702ZzyURBI1Wzv2W
         VgPb5S1xvJIXqpCzD5yWXvdy6yFKaskDltTmKAhTTrFgTe9dd0gkeAiDaM2X35jZnxre
         2KFRVXubZxahujg/CDEhPDZ2WherDnbm2TyEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS0rBnqOnJwywVyggv6WLP51bLfritdDS+YaRb6g8Nc=;
        b=PQdv3cuVGCxzyFqG3/QOKXdULZlXX7IZAOt81GoGMCyU9Vg1LbQRxt4fMm2uwS95RU
         zhE+xWgK5CQ7DgIj2+DxXfMOHIjXkie7kScbC3Kpr59u6kx4W+xrssbhrNLnkCdcNJ5p
         ASRDA6zJ4nfERG0U4dxdbsAwEEz2SDqwhPP9xzIesfdwgsIbBWYC8l6PGKg8uEIM+9UO
         Ta+NUviXF9DBK/MeM7P7VqkR9UQHiEYFa23Z4fbmcpgiBoGiqkkxHRtxrQ/EPcKtLsoz
         b5+Y9qLuCXEMorpCXVOwZylXGou3S8grxLhkTVLO3/xLZPZUkrgkuUmHw7hMUMMDediM
         F8sw==
X-Gm-Message-State: AOAM531iC8SWEpTa+CRjZww/MQgP84RhHnVDIb0BwrT3o/w9/rtFZX3/
        YruF7nq1mleI7l0vKB4/utDSA17ljca6NOX0gVj+2A==
X-Google-Smtp-Source: ABdhPJxSxkOYJZAAfx/jQvadZj/iy531I7ErK03nLA+3xCq24960xPRCwn96ehAoYQmM8dl/cYhhXbDaqlMAp+SKm2A=
X-Received: by 2002:a25:a4aa:0:b0:650:1a22:ffe1 with SMTP id
 g39-20020a25a4aa000000b006501a22ffe1mr31292961ybi.573.1653874901359; Sun, 29
 May 2022 18:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
 <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com>
 <CAONX=-do9yvxW2gTak0WGbFVPiLbkM2xH5LReMZkvC-upOUVxg@mail.gmail.com>
 <CAONX=-ehh=uGYAi++oV_uS23mp2yZcrUC+7U5H0rRz8q0h6OeQ@mail.gmail.com>
 <CAJfpegsPjFMCG-WHbvREZXzHPUd1R2Qa83maiTJbWSua9Kz=hg@mail.gmail.com> <CAONX=-d-6Bm9qGQyhmpkMQov+wjgH3+pAMHdSsifM6FpmHNPFg@mail.gmail.com>
In-Reply-To: <CAONX=-d-6Bm9qGQyhmpkMQov+wjgH3+pAMHdSsifM6FpmHNPFg@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Mon, 30 May 2022 11:41:30 +1000
Message-ID: <CAONX=-cSHJX8Zqj9suXp+cwYf9FCxmCkWrDPKz+5Nttqf6Ewqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have prepared the v3 patch as described in my previous email. PTAL.

Thanks,
Daniil

On Wed, May 25, 2022 at 8:44 AM Daniil Lunev <dlunev@chromium.org> wrote:
>
> > Calling bdi_unregister() might be okay, and that should fix this.  I'm
> > not familiar enough with that part to say for sure.
> > But freeing sb->s_bdi while the superblock is active looks problematic.
> Tracing the code, I see that, yes, in general that might not be safe to call
> the "bdi_put" function for any FS - because it might have in-flight ops even
> with force, where they will routinely access the members of the bdi struct
> without locks. However, we do replace the struct with a no_op version,
> and specifically for the FUSE case we sever the connection first, so no
> in-flight ops can actually be there. And I am not sure if other FS may
> need to do this retirement, given they don't have these
> user-space/kernel split. It would make sense however to delay the actual
> put till  the actual super block destruction, but that would require
> introducing extra state tracking to see if the block is or is not registered
> anymore. It can be piggybacked on the v1 patch where I have an explicit
> state flag, but not on v2.
> Miklos, Al, will the following work and be acceptable?
> Get v1 patchset[1], in fuse_umount_begin do bdi_unregister and set
> the flag, but do not do bdi_put or replacement with no_op. And then in
> generic shutdown super if the bdi is not no_op and the 'defunct' flag is
> set, skip unregister part.
> Thanks,
> Daniil
>
> [1]
> https://lore.kernel.org/linux-fsdevel/20220511013057.245827-1-dlunev@chromium.org/T/#u
