Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97945306D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 02:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiEWAZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 20:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiEWAZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 20:25:15 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034042E691
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 17:25:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i11so22754762ybq.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPEgF/LXOvUc67RR+bySpSWPvexzgqgYq6xbV2e96Q0=;
        b=LrF9SwHl7tirDLy9Fl17YKhCwdvT/sdMh+BXdFnac/urzE5li6mT9hDQAylZMB2RQ6
         5EIeDdQN97eDsQ+QY7mtLEpf2T8SjUxGVCvP+pWv2K71Pu+AxwzUYHdjxdpZyMWe0cJO
         zjkWnbIs046qkmrW/32PfIgJoNoGw7YkOZjHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPEgF/LXOvUc67RR+bySpSWPvexzgqgYq6xbV2e96Q0=;
        b=ybETSOajQ4SRGgJjStdXBMpralzgqOj8n+QAfJEXRS4triiRkjeoyhLv44ydQ7fqDH
         EgRMkI1ECsmjJwUr7wEEEoxsce6fcagcNj9yIYEvL4EB6HFsRIRJRv1PgE+dkrErkWzr
         H1LSLSj5qnd7tOctMdCz11cGllG6R/b30muStPIsWX6r6fXISUjtP8QnFv7vjKcjnszm
         UW1jT/4W23QwRT/v0rIjkgHBqb1RvIqelKW3rUpMfkRr/aiYB7kjakVkLQajGzMi64dc
         teEg5YRcYp3DOSaePoR5TMJW7E+W3jIAhzts+5BIsrv+mYfEseWOHTVsSwl0RS95y4e9
         fXOQ==
X-Gm-Message-State: AOAM530QxlWNaMewdUpghW28INWACoBMIw9a3BYx6S4PBQtFKexQ4Lus
        R8jvz16Hd5MPXXXlbi70oPhTppwz3e+gSAz/x3cVhA==
X-Google-Smtp-Source: ABdhPJz9YlriiYzrcomdHPuHe/kQwXfhX8JPAuGCWnRcd1I35gKmO4GryXm+whVvIG3pkpbHWaY5N27cCY0whNdnqAw=
X-Received: by 2002:a25:48c7:0:b0:64d:fc43:b23e with SMTP id
 v190-20020a2548c7000000b0064dfc43b23emr20408643yba.62.1653265513235; Sun, 22
 May 2022 17:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220511222910.635307-1-dlunev@chromium.org> <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
 <YoQfls6hFcP3kCaH@zeniv-ca.linux.org.uk> <YoQihi4OMjJj2Mj0@zeniv-ca.linux.org.uk>
 <CAJfpegtQUP045X5N8ib1rUTKzSj-giih0eL=jC5-MP7aVgyN_g@mail.gmail.com> <CAONX=-do9yvxW2gTak0WGbFVPiLbkM2xH5LReMZkvC-upOUVxg@mail.gmail.com>
In-Reply-To: <CAONX=-do9yvxW2gTak0WGbFVPiLbkM2xH5LReMZkvC-upOUVxg@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Mon, 23 May 2022 10:25:02 +1000
Message-ID: <CAONX=-ehh=uGYAi++oV_uS23mp2yZcrUC+7U5H0rRz8q0h6OeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So, I tried this patchset with open bdi elements during force unmount
and a random file open [1], and didn't see any major drama with
force unmounting the node, after re-mounting, read on sysfs node
returned "no such device", which is expected.
With private bdi flag patch, unless bdi is unregister on force unmount
in fuse, it will complain on name collision [2] (because the patch
actually doesn't do much but unregisters the bdi on unmount, which
seems to happen ok even if node is busy).
Let me know if I am missing anything or if there are any other
concerns, and advise what would be the best way to move this
forward.

Thanks,
Daniil.


[1] Python shell
>>> f1 = open('/sys/class/bdi/8:0-fuseblk/read_ahead_kb', 'r')
>>> f2 = open('/media/removable/USB Drive/m1', 'w')

[2]
[  149.826508] sysfs: cannot create duplicate filename
'/devices/virtual/bdi/8:0-fuseblk'

On Thu, May 19, 2022 at 8:55 AM Daniil Lunev <dlunev@chromium.org> wrote:
>
> > Yep, messing with the bdi doesn't look good.  Fuse always uses a
> > private bdi, so it's not even necessary.
>
> The reason I needed to remove the bdi is name collision - fuse
> generates a fixed name for its bdi based on the underlying block
> device. However, those collisions of mine were conducted on a
> version prior to the private bdi introduction, I am not sure if that
> is supposed to fix the collision issue. Need to check
>
> Thanks,
> Daniil
