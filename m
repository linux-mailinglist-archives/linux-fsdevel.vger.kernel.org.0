Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9641D783F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgERMPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 08:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgERMPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 08:15:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D28C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 05:15:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i16so3808810edv.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 05:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RDSyGRpw2VRf31bxawCo734Y2yQmHYTppNEBtUFy1U=;
        b=O5Xa9XcVP4RwdKpVI1k4ps0IER5omUHFawIxpk5Ybxlk9fTdR2HkLbmmgySRZZleUZ
         Y4uhpBdv1uADkBZpmeQcC2FNKVG8Bs4de8RCzkQUybqChWSsbGpB4c3xL/xOX2aV7kv3
         DizqHRexmJk5lBp10WaPkb9GltwF2YLEfzTYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RDSyGRpw2VRf31bxawCo734Y2yQmHYTppNEBtUFy1U=;
        b=T9B9pNOBacLBljo5qDTUy8TcnfVzhKyyPQ9ADUsmi2W4bHxGJ49JD/5CBLcyfu6Srs
         yLFUy9vhD4tj2h9NhLCl8meTmgo01FCGiYscQ1boxDY42j6FlwxcL19KSlFepvcDweAk
         srAo4EDfDTkSGYsDvoSv3/0sabdYWnk1dq/N+eIdENxPOVRhn6LRWGuCWZ+rRmMcwPte
         m1tTgNJoLlqklQH2/UYLslxqlVCjk9AyrdKit7QPz6tSJxY78IhS5WsOfI9dX8tM7h6P
         eeWkWceliyCJjQUPGRFKfg45sXE2oRMACRyB5Ii0EjRYBJPkTD2MJr8E4PTAwXfyy+ye
         0Cgw==
X-Gm-Message-State: AOAM530gcWpZEHFuEIrO0TybtrXrAZhMi2DImiJI3qJxPLbABNf76vIc
        s2Zt6IDVP/RZA8KcWqfpKWqP6mJCABDxjspuPWYN0w==
X-Google-Smtp-Source: ABdhPJzI0Ub5Al1xdFnJCP0SMRPXQ0Ztlfu42nRd6872odMbrU3TIaoyOW2X8zB1zBv95JpmlYvjE37eFjf6f2D8SYA=
X-Received: by 2002:a05:6402:1296:: with SMTP id w22mr12510290edv.364.1589804132909;
 Mon, 18 May 2020 05:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200430171814.GA275398@redhat.com> <CAJfpegt9XraNpzBK+qOo2y-Lox3HZ7FBouSV6ioh+uQHCtqsbg@mail.gmail.com>
 <20200504183315.GF9022@redhat.com>
In-Reply-To: <20200504183315.GF9022@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 14:15:21 +0200
Message-ID: <CAJfpegtoNV9HzFu1WE_hPZ_uxXH7iDb1Yfbzv3FBzXku3yQ7Gw@mail.gmail.com>
Subject: Re: [PATCH][v2] fuse, virtiofs: Do not alloc/install fuse device in fuse_fill_super_common()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Chirantan Ekbote <chirantan@chromium.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 4, 2020 at 8:33 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>

> Subject: virtiofs: Do not use fuse_fill_super_common() for fuse device installation
>
> fuse_fill_super_common() allocates and installs one fuse_device. Hence
> virtiofs allocates and install all fuse devices by itself except one.
>
> This makes logic little twisted. There does not seem to be any real need
> that why virtiofs can't allocate and install all fuse devices itself.
>
> So opt out of fuse device allocation and installation while calling
> fuse_fill_super_common().
>
> Regular fuse still wants fuse_fill_super_common() to install fuse_device.
> It needs to prevent against races where two mounters are trying to mount
> fuse using same fd. In that case one will succeed while other will get
> -EINVAL.
>
> virtiofs does not have this issue because sget_fc() resolves the race
> w.r.t multiple mounters and only one instance of virtio_fs_fill_super()
> should be in progress for same filesystem.

Thanks, applied.

Miklos
