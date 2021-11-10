Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C33E44C4A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 16:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhKJPx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 10:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKJPxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:53:25 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890DC061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 07:50:37 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id v3so5599450uam.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 07:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ils0Ihsgc+3lafginTjRrUuOrkE1KFLAxF2SapgVpEE=;
        b=MIiYBsiv4ir1sg3tjLjl+mzTBSjNaVPWy0dpyN40WowP5omnhJklHq6sbS+JuBC7tS
         rpa5LRt1w87ygb6t5T9vPn6VFAZhGHwbC/O3bb+cYbsWyvI1oXIdqcN2yvSHGIHClD1g
         MgxN0TDt5KptUSdZ3BvWXso1ddvNAii+P90/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ils0Ihsgc+3lafginTjRrUuOrkE1KFLAxF2SapgVpEE=;
        b=oIir8rnK8s1SPxz5p2uZuRxp7ueJRZEimbauKy7PFyJj0dzZbfpxDsDLinXWzdETSu
         t/s+KESz/BLC5+6z94LEL6wSqIrCVzWeMIt2EV9Y62kZ0k6N2hFPDQDPfagmkoyAmkfJ
         yTH44DZDdY4kEwWTF1INKo9s+slpMoSjFIUPU5UVTMylTE5L/VV6ql8qThsXgTpNFIt6
         X0ax5zGiNKJz+uyxlN8RXkViMAtj8XdyBJikx0d9uYXhHnNBAz4auo0WPZbKdTL08CRD
         i4QNz8qLJzcx86Dsvx+wPldBXtmxbYkdoa4gkhu9zF8BHdZ5GncUn+u5/mEpYMlipBMC
         gC0w==
X-Gm-Message-State: AOAM532sYvlzju+q1xhikIawYlhVHB9Iv63BRBEa4pYd1eeqh3q8pxzH
        69uyjXhQMa4O6XYvBKLHrssLs2vbiuQevzuX7Q03Ms5zES4LXg==
X-Google-Smtp-Source: ABdhPJyF/O2PSupNs3PNOcr3PF4LhVcse1f0uAWMok/YeI5Iyuy1P+vrDjE4MaZAhmjf6QIhfD9k4fyt7n20MFe1DPw=
X-Received: by 2002:a67:e109:: with SMTP id d9mr985174vsl.19.1636559436979;
 Wed, 10 Nov 2021 07:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com> <20211102052604.59462-7-jefflexu@linux.alibaba.com>
In-Reply-To: <20211102052604.59462-7-jefflexu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 10 Nov 2021 16:50:25 +0100
Message-ID: <CAJfpegvfQbA32HjqWv9-Ds04W7Qs2idTOP7w5_NvKS_n=0Td7Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] fuse: mark inode DONT_CACHE when per inode DAX
 hint changes
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2 Nov 2021 at 06:26, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> When the per inode DAX hint changes while the file is still *opened*, it
> is quite complicated and maybe fragile to dynamically change the DAX
> state.
>
> Hence mark the inode and corresponding dentries as DONE_CACHE once the
> per inode DAX hint changes, so that the inode instance will be evicted
> and freed as soon as possible once the file is closed and the last
> reference to the inode is put. And then when the file gets reopened next
> time, the new instantiated inode will reflect the new DAX state.
>
> In summary, when the per inode DAX hint changes for an *opened* file, the
> DAX state of the file won't be updated until this file is closed and
> reopened later.

This patch does nothing, since fuse already uses .drop_inode =
generic_delete_inode, which is has the same effect as setting
I_DONTCACHE, at least in the fuse case (inode should never be dirty at
eviction).   In fact it may be cleaner to set I_DONTCACHE
unconditionally and remove the .drop_inode callback setting.

Thanks,
Miklos
