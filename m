Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF747A9E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 13:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhLTMuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 07:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhLTMuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:50:05 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50CC06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 04:50:05 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id c10so3266818vkn.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Dec 2021 04:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mebw+t+6AZGZkXmp7vDvG7ApJYeVNYn7Za2C9wEefaI=;
        b=keM546ZVFFY7h+ySf8UPE/BR4WPf6nIR/oud8lzcFMmsUIRn/5xDfjXOKshw/TvhjS
         gOdGtopoEPiz83D+JA9aRr5js22m+Od50s37c3zjkulqv8xF0zznlVyzFpyB3+hJgRlQ
         HHNj2qzinTd0e6RP6cM/DvqaSZo5pbWSgiClw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mebw+t+6AZGZkXmp7vDvG7ApJYeVNYn7Za2C9wEefaI=;
        b=DdddeJENvFo1KqlADpzntZkx6Ns/Ox6qotHOGEf8FdxaZnUE1oO5LVU+Rm4TkfXua7
         OP8koqA7BrAC36M+0TGhhm8A6isS7JDSxqXeuNg/H5mAXPi5PquFtK5QDKNN9iO027zj
         wVradnGlweIP3L6hVgAP00tqtNbCcp8forBj2Ovv36OzF+1z7Sdyn+1dfY2L8lWGjiSG
         U561GdQH7+rZLO2UdSWfyygw8S+w3n/Xl+mXhk8wcjyWOjP8HxK7nctsyS4azt1RwWyg
         UDln7PLWiBiLbJksVJu714m+0a/0i1K5tCOq6jpXMP4mKs7dONf/YEh1TAPRtJk0xdl6
         wphA==
X-Gm-Message-State: AOAM531RPcaXCBlR4Fc8aRJwIjp33DQyJITqxnmjYVwiGB+TZqN51/2T
        nNTVRWNKuRX3VqY5DW4plaM/0PgPo6D7AGjIant6tXErl/gXvQ==
X-Google-Smtp-Source: ABdhPJxLi7dYvgVXTw3RKjMCy6zDRgzU5qsr8lQryPwB1pb3R1jBRbvjqe/N/HUAouhiNhYAaHVuoEFdX4st1ZpxUOA=
X-Received: by 2002:a1f:52c7:: with SMTP id g190mr5544848vkb.1.1640004604088;
 Mon, 20 Dec 2021 04:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20211216144558.63931-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20211216144558.63931-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Dec 2021 13:49:53 +0100
Message-ID: <CAJfpegvQCmBOD4XDncijGaFDgrmKhtWK1-h28VCUELPXdgw0JQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix deadlock between O_TRUNC open() and non-O_TRUNC open()
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 Dec 2021 at 15:46, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> fuse_finish_open() will be called with FUSE_NOWRITE set in case of atomic
> O_TRUNC open(), so commit 76224355db75 ("fuse: truncate pagecache on
> atomic_o_trunc") replaced invalidate_inode_pages2() by truncate_pagecache()
> in such a case to avoid the A-A deadlock. However, we found another A-B-B-A
> deadlock related to the case above, which will cause the xfstests
> generic/464 testcase hung in our virtio-fs test environment.
>
> Consider two processes concurrently open one same file, one with O_TRUNC
> and another without O_TRUNC. The deadlock case is described below, if
> open(O_TRUNC) is already set_nowrite(acquired A), and is trying to lock
> a page (acquiring B), open() could have held the page lock (acquired B),
> and waiting on the page writeback (acquiring A). This would lead to
> deadlocks.
>
> This commit tries to fix it by locking inode in fuse_open_common() even
> if O_TRUNC is not set. This introduces a lock C to protect the area with
> A-B-B-A the deadlock rick.

Okay.

One problem is that this seems to affect a number of other calls to
invalidate_inode_pages2(), specifically those without lock_inode()
protection:

- dmap_writeback_invalidate()
- fuse_file_mmap()
- fuse_change_attributes()
- fuse_reverse_inval_inode()

fuse_change_attributes() is especially problematic because it can be
called with or without the inode lock.

The other issue is that locking the inode may impact performance and
doing it unconditionally for all opens seems excessive.

If there are no better ideas, then the brute force fix is to introduce
another lock (since the inode lock cannot always be used) to protect
fuse_set_nowrite()/fuse_clear_nowrite() racing with
invalidate_inode_pages2().

Thoughts?

Thanks,
Miklos
