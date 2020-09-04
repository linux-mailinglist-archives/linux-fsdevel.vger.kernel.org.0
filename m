Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1030D25D55F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgIDJqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIDJqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:46:07 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188DC061244
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2020 02:46:06 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id e5so1504264vkm.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2020 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXzRjhwn8e2J5zYTCR4K+ZTW1our2Q6VsUPgVktuBLs=;
        b=LdTO8+I8XHmU+YCHchiFOBlCOwF2mhR5dAZx74JAbUsVoRU33CWaY86v/bbMDVm7wP
         oYKi0OpxacAUC3LC5vNhWGHA87ywut6e9wR3KE1bYg6VrM/LVLbCgXWuQc77HjQQITD7
         g2yIZPsT16veeMHQ81rSKzD82ttwqwbK+LSB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXzRjhwn8e2J5zYTCR4K+ZTW1our2Q6VsUPgVktuBLs=;
        b=gqYz82HB0xnfAnn4XncBu9VtJ8E0xqTHr/4lWHgfgpbpwmXsbP5ebBlrmo+pTcPoVW
         fftr0UUrYljTEMtssWTwL+8Dsn4DFeOcMw+6vx46BMLpD1QAdBPSEzrS8A6kzntj57Yk
         QOE+KAJQwUr6/mUZt9ULuFwC60Gs3pTD4BT54TOgUGJAWFmhjGsCAYGSulhy8pdR6y+1
         BsuMiZz7Wh5IH+MC1qVMFOBxpYOGCpT2U7jFO08IsfVlp5ShK1gAXo23AV2COpUedmBk
         K+KRnJQPeB/u3A4AQ9vPguEVzNt984GmOyDb6TkOd+03leANFT8qXbRwnGilEVXyuzvE
         lCXw==
X-Gm-Message-State: AOAM533phdcg0kyLhkqzBADzPJFgXk+A6B7hKJWVYFzKHEu52BTcGrFy
        LPtm2T2GPVISeAW9pO8QWY3onTYsR0Mz2uRJFR7KvQ==
X-Google-Smtp-Source: ABdhPJzKB0NthI1LuTW6BHdNzilpfWpk2QEHQQe0FwPk9KShrU/6mTQNOyDLitbHJZ+h9jU58BKRQz7JNrryVXRgnbw=
X-Received: by 2002:a1f:a0c3:: with SMTP id j186mr4756203vke.76.1599212765024;
 Fri, 04 Sep 2020 02:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142634.1227109-1-vgoyal@redhat.com>
In-Reply-To: <20200901142634.1227109-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 4 Sep 2020 11:45:53 +0200
Message-ID: <CAJfpegtBA6XSbb+futZGt=NY-VjnN_GWFmnNfGjLfgnZ1ynM0w@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse, dax: Couple of fixes for fuse dax support
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 1, 2020 at 4:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi Miklos,
>
> I am testing fuse dax branch now. To begin with here are couple of
> simple fixes to make sure I/O is going through dax path.
>
> Either you can roll these fixes into existing patches or apply on
> top.
>
> I ran blogbench workload and some fio mmap jobs and these seem to be
> running fine after these fixes.

Thanks for testing and fixing.

Pushed a rerolled series to #for-next.   Would be good if you cour retest.

There's one checkpatch warning I'm unsure about:

| WARNING: Using vsprintf specifier '%px' potentially exposes the
kernel memory layout, if you don't really need the address please
consider using '%p'.
| #173: FILE: fs/fuse/virtio_fs.c:812:
| +    dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx
len 0x%llx\n",
| +        __func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
|
| total: 0 errors, 1 warnings, 175 lines checked
|
| NOTE: For some of the reported defects, checkpatch may be able to
|       mechanically convert to the typical style using --fix or --fix-inplace.
|
| patches/virtio_fs-dax-set-up-virtio_fs-dax_device.patch has style
problems, please review.

Do you think that the kernel address in the debug output is necessary?

Thanks,
Miklos
