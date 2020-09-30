Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2042727EA10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgI3Niu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgI3Nit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:38:49 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91154C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 06:38:49 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j3so1002743vsm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7xiJvvblsTV5IXytyvrj4LJ0qb4rQ21aY+usBJ+RoI=;
        b=HxqnyvOm30lKHERhqJk/wrxbr+pxSYu4X6waf5EP+c/lFbNZQRCn8itQSf5q5CYQFt
         ZaU+CX1yKRUWoYsg4LzOYBmP8vhap1oc8jmpUCRlQF0g4HLEQ+2pBhJ6iIYNaBNum7sy
         RwWsh5KBUiGtJoBv7n0Ltk1p8iw2zdsz8ot1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7xiJvvblsTV5IXytyvrj4LJ0qb4rQ21aY+usBJ+RoI=;
        b=prXIH5EUPiJh9Ry1GP8egqfB3s3FXokdOP94PlJU1XpWpqQ/sXeVJ++3BIM1wOTHRs
         Ocuf4Al1ZrDXgF8UQQBtIZhPFAF8LQaoUPHzI3z72iV1p//vUIaZvMqyV+RFvPs2cFHT
         vmAU9xY2naHgMqOs5MgveK7JDu2/MZLYHxqel100UV8FD9/cghcAbbc6s+J/5xCIq7/l
         tiRUdw0I+A7JjyqYRcAdDJlplpwVbswQeOo05xhuckSLJldEviMzY8fdfsForbFjhm7w
         7dohFJCrAd2ImynjPy7n/rvlgCQt8BvRuNXtrKMjh7wE3nciX7zFBA68aXfzTs5/my7a
         WZfQ==
X-Gm-Message-State: AOAM533j0UUxN0oio/wMGNItXZ6hjjVuZ4Tq35VvG6zNqEVGOYuN5zwV
        zKevVI0Wd+DWYfZ4Bi7kIVh3kMboMvqX5QVvFRN7swg+JSU=
X-Google-Smtp-Source: ABdhPJxkRpuTXXfCcc13VG54+e2YdFj1jWhE440jm2NswkiL0koUQ7FdAnp4i4MSr1nMrf0zFSCAoA5ggtS4brwU7yc=
X-Received: by 2002:a67:6855:: with SMTP id d82mr1259012vsc.46.1601473128766;
 Wed, 30 Sep 2020 06:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200929185015.GG220516@redhat.com> <CAOQ4uxgMeWF_vitenBY6_N3Eu-ix92q8AO5ckDAF+SVxHTBXXw@mail.gmail.com>
 <20200930130222.GA267985@redhat.com>
In-Reply-To: <20200930130222.GA267985@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 15:38:37 +0200
Message-ID: <CAJfpegvJOwd8-x8WJCY5disScnGrRXN3t+pD2O6_iYQMxdKcLQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: update attributes on read() only on timeout
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 3:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Sep 30, 2020 at 07:35:57AM +0300, Amir Goldstein wrote:

> > I wonder out loud if this change of behavior you proposed is a good opportunity
> > to introduce some of the verbs from SMB oplocks / NFS delegations into the
> > FUSE protocol in order to allow finer grained control over per-file
> > (and later also
> > per-directory) caching behavior.
>
> May be. How will NFS delegation help with cache invalidation issue. I
> mean if client B has the lease and modifying file, then client A will
> still need to know when client B has modified the file and invalidate
> its own caches.

Right.   So the way it would work in the mixed read-write workload is
that the client tries to obtain a WRITE lease for the file.

a) it could obtain the lease: it can do cached reads and writes
without having to go to the server until the cache is flushed
naturally or the lease is revoked.

b) it can't obtain the lease: client will disable cache and let server
manage coherency (cache=none basically).

For a read-only workload the same happens but only a READ lease is
requested.  The nice thing  is that multiple entities can have a READ
lease on the file as long as it is not being modified.

So this is best of both worlds, optimized for the non-contended case,
but still consistent for the case when the file is being read/modified
by more than one entity.

Thanks,
Miklos
