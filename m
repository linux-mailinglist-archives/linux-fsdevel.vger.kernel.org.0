Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3A3AC4AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 09:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhFRHJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 03:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhFRHJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:09:35 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB195C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:07:25 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l25so4432044vsb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlodzRLKjYsmSIvJvfyHmyRZLG20ROka1PyN+VfwfnY=;
        b=mdFl213r1n1uA6uKofvIKHWo5sizoJZyxajbWz27X3DF1VPnIRBBR8iCB7pGgabrWv
         0JKDQLz2F+SRodYFTB4NF/9URm8CCY9XPrzZ1jV7oFeOJOBt9hKPZOhLFvkyBXgOXhd8
         hA8SqcnfTAKYGkMOMHfAzHP2bOY32bYG7Hw8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlodzRLKjYsmSIvJvfyHmyRZLG20ROka1PyN+VfwfnY=;
        b=HN4xFCwXJ5y4wrt7QM3SrIWBtzL+sbTX6XuHaHS8xGNlPJbPlwe/6eYOtiiBpAvGtl
         kUBcOZ/w87hHbd9+nxgJo9NOdd3NbULpXHUI61uhIDKKncdzvcKiFiJ7RQ9R+lg0nbRW
         f50ewLhWo5MwD3y4mPUdClFquMHP7g/WtW+tVrpx+/yNmiYzOtmUn8l0Soi8LrdNhfJd
         DLxzxZMR5ruUVYsgnHt8rQt6/90DX+bGSLon1H1BrUVUzSzP3TkiG5RyJLtUkTeZ1uCD
         Cm9LPoyOheVgoMgLhYqzwU+S4slWsdfLDNdak86sw1GiZzQu41R6FhzXZUD+qGiYvpU7
         SEFw==
X-Gm-Message-State: AOAM530qY5F35PVk65dFP7f/uG/UEVxaSz2RfvQ0u17tXI0qWDk5fW8j
        G3GZtRE3vKLLl040+fDmH311dKoA2EGYy5dL3HUtdw==
X-Google-Smtp-Source: ABdhPJyvf5sruheatAks9eE+EGnBl6isJKiLy/2d9eFZrcjA+lnmitpD0wWr1RLBJMvgKuMZ7wE0T+qIjzgo250CRGI=
X-Received: by 2002:a67:bb14:: with SMTP id m20mr5468628vsn.0.1624000045114;
 Fri, 18 Jun 2021 00:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210614174454.903555-1-vgoyal@redhat.com> <20210614174454.903555-2-vgoyal@redhat.com>
In-Reply-To: <20210614174454.903555-2-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 09:07:14 +0200
Message-ID: <CAJfpeguD+F3Ai01=-JYNTKS4LP4d879=+8T7eOBewZpevTRbJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] init/do_mounts.c: Add a path to boot from tag
 based filesystems
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Jun 2021 at 19:45, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> We want to be able to mount virtiofs as rootfs and pass appropriate
> kernel command line. Right now there does not seem to be a good way
> to do that. If I specify "root=myfs rootfstype=virtiofs", system
> panics.
>
> virtio-fs: tag </dev/root> not found
> ..
> ..
> [ end Kernel panic - not syncing: VFS: Unable to mount root fs on
> +unknown-block(0,0) ]
>
> Basic problem here is that kernel assumes that device identifier
> passed in "root=" is a block device. But there are few execptions
> to this rule to take care of the needs of mtd, ubi, NFS and CIFS.
>
> For example, mtd and ubi prefix "mtd:" or "ubi:" respectively.
>
> "root=mtd:<identifier>" or "root=ubi:<identifier>"
>
> NFS and CIFS use "root=/dev/nfs" and CIFS passes "root=/dev/cifs" and
> actual root device details come from filesystem specific kernel
> command line options.
>
> virtiofs does not seem to fit in any of the above categories. In fact
> we have 9pfs which can be used to boot from but it also does not
> have a proper syntax to specify rootfs and does not fit into any of
> the existing syntax. They both expect a device "tag" to be passed
> in a device to be mounted. And filesystem knows how to parse and
> use "tag".
>
> So there seem to be a class of filesystems which specify root device
> using a "tag" which is understood by the filesystem. And filesystem
> simply expects that "tag" to be passed as "source" of mount and
> how to mount filesystem using that "tag" is responsibility of filesystem.
>
> This patch proposes that we internally create a list of filesystems
> which pass a "tag" in "root=<tag>" and expect that tag to be passed
> as "source" of mount. With this patch I can boot into virtiofs rootfs
> with following syntax.
>
> "root=myfs rootfstype=virtiofs rw"

The syntax and the implementation looks good.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
