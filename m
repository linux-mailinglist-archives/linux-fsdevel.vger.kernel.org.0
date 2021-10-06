Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A78423E44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhJFM5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhJFM5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:57:20 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B90FC061749
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 05:55:28 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id f2so2793429vsj.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjaBcZgjWLTrEHTtpDCJSULsNJuoblFy/BpOMSjwvEM=;
        b=M34nstMF9w2PwEwyxxptnoQ8LOk/1NPBmX32lqdND3qyVp6xLvFK0yrAJdQFU4tGIz
         7Osj4zYB4Foho1S1nJ9vbuKIYTY1kcayIlEmEtWA+638OgJPgM9AamWuTQzESJMnbxEU
         Gpyk5AuqeHBZPoxyGfqs2SNlgJurH2qrOg3r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjaBcZgjWLTrEHTtpDCJSULsNJuoblFy/BpOMSjwvEM=;
        b=qObN+rmLm6V4g0rFvC/T7ODb5TRXdNWk8O16U1a12vnzg9YaPqx5YhHIZnp7u9sfan
         9zcnFldhS++Lf8cua08xBRihF0UXgRiopOVIXXrYKjirDCRsdXF5MAzoL4gDmnFaPL75
         iVz8RHMmGKLhfM+GChSqmQgRQMn39Xjnx0FQQZnyj7LfTgrbzsSGY7KKKxXAO5xrgdxg
         FEK0bJ+kyaP0PACuky/GbizO4/57PBht7oD7efanYlF0MlrAX3hlS5R0UgAwCjp+J3Si
         vH+2LuRQ89RU9qjXiZB6xMMI08mzDKFNjlTB9jniZFoCnNttbOqpxUBcpxISY6e12TZl
         Zk4A==
X-Gm-Message-State: AOAM531JkoW0GGyYdtNKIOCXnFFZzt4OIFdOxG68iSgzFYMTE+3td74j
        JArx2vdsNYvW1oSv+IQagmC6GEELBiZS1y9huhS2hnWkw3A=
X-Google-Smtp-Source: ABdhPJwh7Gc7cIgax3L4/UB9KQJU/bZN/8U2nMsbYWUylT55JmzO7Ud720ofMjwjg11PbD5WnAYKQBf5hmEhtkrcddE=
X-Received: by 2002:a67:ec94:: with SMTP id h20mr23413522vsp.59.1633524927204;
 Wed, 06 Oct 2021 05:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210930143850.1188628-1-vgoyal@redhat.com> <20210930143850.1188628-8-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-8-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 6 Oct 2021 14:55:16 +0200
Message-ID: <CAJfpegu5Y5X_CcKS9hsoW3ao5+WPJjm-6hsMVEiGU8PjSKy2gg@mail.gmail.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> sent by file server to signifiy that a previous locking request has
> completed and actual caller should be woken up.
>
> As of now we don't support blocking variant of posix locks and daemon
> returns -EOPNOTSUPP. Reason being that it can lead to deadlocks.
> Virtqueue size is limited and it is possible we fill virtqueue with
> all the requests of fcntl(F_SETLKW) and wait for reply. And later a
> subsequent unlock request can't make progress because virtqueue is full.
> And that means F_SETLKW can't make progress and we are deadlocked.
>
> This problem is not limited to posix locks only. I think blocking remote
> flock and open file description locks should face the same issue. Right
> now fuse does not support open file description locks, so its not
> a problem. But fuse/virtiofs does support remote flock and they can use
> same mechanism too.
>
> Use notification queue to solve this problem. After submitting lock
> request device will send a reply asking requester to wait. Once lock is
> available, requester will get a notification saying lock is available.
> That way we don't keep the request virtueue busy while we are waiting for
> lock and further unlock requests can make progress.
>
> When we get a reply in response to lock request, we need a way to know
> if we need to wait for notification or not. I have overloaded the
> fuse_out_header->error field. If value is ->error is 1, that's a signal
> to caller to wait for lock notification. Overloading ->error in this way
> is not the best way to do it. But I am running out of ideas.

Since all values besides -511..0 are reserved this seems okay.
However this needs to be a named value and added to uapi/linux/fuse.h.
