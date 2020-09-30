Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74F427EDB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgI3PpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3PpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:45:08 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B57C0613D0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 08:45:06 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 5so1188100vsu.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApvBKc8Khxg0IoEksSg3GInYcR+U6xm2yDW9gWHbZWY=;
        b=peW6K2GBAkpVrhNuGiGONtsbqNn3KO8HZw8ixAOOhnbRJIZabs2ua7ORJscfylzLKD
         0dA911UyQL46gahT488TSi9oZZNJYgvIeCpKeJpQcQLr2Q0oqN0MH+CAlfYyn98t55Z8
         IyhwzOppuPYsddcdr4di4nVskmt73wt6fK3+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApvBKc8Khxg0IoEksSg3GInYcR+U6xm2yDW9gWHbZWY=;
        b=cDfaZwKQT9353Ssmdp0y5trKl10w6FWziF8D+e82AEDa2m+5xGjfBnaj3F2+UGsZ8D
         rECqeCjS1BozvCWXELLtXnknyKQlVvPliZ7cP/Q0Xo3FchX8LZBilAqUUEnxmyFg7D+Z
         dpo52I9Ck/0rq5RtWlKoVyYZs4J135CLCIxPaJzGZwesZgAIom7PnS5v2RDneFf68kvD
         yjLqbmKBSo/eOVPFrkEbp2hXA2gf5LYCeQvHzQZOJ/lgfGW+sjsMuReWS+w2eiWMBHLh
         RM/1+4kxjR9/uy48GLBp280jxUoB1v4BJ86dENM9wEMZ7z5OFtx5lSn2n/59oIDJuGei
         Teow==
X-Gm-Message-State: AOAM5330BhkZvGrIyJX66/IE25918UDyIpBurL1n27la3FAqLFZra3ty
        WC8/KSO4Qr5vvm/KbnvVzjBMXoyijgXNM9Z9VDOyOg==
X-Google-Smtp-Source: ABdhPJxumN4h6iGLvR5ObOrFqwk8EkF5bJbF39rhN5043r3Ml389oAO96ocWz71kNFzko+iDwCClq7JcI8Kx7XOz5qg=
X-Received: by 2002:a67:6855:: with SMTP id d82mr1876811vsc.46.1601480705468;
 Wed, 30 Sep 2020 08:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com> <20200924131318.2654747-2-balsini@android.com>
In-Reply-To: <20200924131318.2654747-2-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 17:44:54 +0200
Message-ID: <CAJfpegvB7XJH7sPni7Vj7R4ZwSrDfevfeRRBgvESSgGg=C5tdQ@mail.gmail.com>
Subject: Re: [PATCH V9 1/4] fuse: Definitions and ioctl() for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
>
> Introduce the new FUSE passthrough ioctl(), which allows userspace to
> specify a direct connection between a FUSE file and a lower file system
> file.
> Such ioctl() requires userspace to specify:
> - the file descriptor of one of its opened files,
> - the unique identifier of the FUSE request associated with a pending
>   open/create operation,
> both encapsulated into a fuse_passthrough_out data structure.
> The ioctl() will search for the pending FUSE request matching the unique
> identifier, and update the passthrough file pointer of the request with the
> file pointer referenced by the passed file descriptor.
> When that pending FUSE request is handled, the passthrough file pointer
> is copied to the fuse_file data structure, so that the link between FUSE
> and lower file system is consolidated.

How about returning an ID from the ioctl (like the fuse2 porototype)
and returning that in fuse_open_out.passthrough_fh?

Seems a more straightforward interface to me.

Thanks,
Miklos
