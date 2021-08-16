Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1F3EDD6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 20:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhHPS5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHPS5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:57:51 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77043C061764;
        Mon, 16 Aug 2021 11:57:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id j18so9021958ioj.8;
        Mon, 16 Aug 2021 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMleuJXp1BFCMdO8pZ1Sh8yv+RZboiDdVagdPozQ5ro=;
        b=rVPf3iXZoTd8p7ZHahrvHPzYSd/MUXUnZeEzWnBewZlgSqqXY4fM7Mn1EIRT4f+CKK
         TTKD2pXtnyHXpQE1/05m79f/n6MzvLHklC4bnUfEsV0M9WRQ7+H2IE11fblFD2S19n0A
         5EFPf6uxcJgRoMqu8DuKYBeizu7xU05CP8OvDv0Ck2bkju5FS6LJMqHnAqM4aP1kWjgQ
         /CtbFj3l/dP/o/Ef2MI6JH6lLmnvc7oUtuhka8nHI/bXEGGMqcr0GOkbyaQtx8MrXoN9
         545LRX7cXWlNbTuzy6U14v7UoRCZLiHFyCfwMQ1KZemnltv2T0MYrVXAg7w9g3+K8HhA
         D/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMleuJXp1BFCMdO8pZ1Sh8yv+RZboiDdVagdPozQ5ro=;
        b=DoN/znVXYysavTRFWPLQkZs6GNhLz1HazaHdGbCBGpo6SZeH0wRzD7wnqZFuiTn0ao
         8l/gMpb3qKI7l+Jq+aBMm3mfi7S5IR4PZT8TrWLEUlG+KXdfLcjDtE0IIiHgsQh52/NQ
         iTX20LbolrYm6l4ZVsi3WsNYGG/yKmP1HJAlL8B75xvlkN5tfbst5P/WAZvHxpIlFNZI
         dTJWCrmAfgulr7GFSOn/UsoW/wn4ao1+NVLCsKCnldBJVryI9B1EVIjDNykCsQlK5sKf
         peCxrpI62k9a3y/t9PIjHAiHA7fHrZs0YDDBasVXhkY1JqYGp+xaRgvVg491JUIDtygQ
         X2vQ==
X-Gm-Message-State: AOAM533c1yqaZrNAhJacWRnXp7J1UmuzszadZIZew7CxqexF8pwewEyf
        ZNLezwY7+TSDq5+sAPi+FmvW/wdDOo6/KL9qh0U=
X-Google-Smtp-Source: ABdhPJy0tRoG6FBen5yt+VzBIYWsQhzTFtpHKMLJbMIqvDPpi5Dm27dM+T37+tBuaCr5qtt0wylZgt06rnUlgSMa5+8=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr261937ion.203.1629140238928;
 Mon, 16 Aug 2021 11:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-6-groug@kaod.org>
 <CAOQ4uxh69ii5Yk-DgFAq+TrrvJ6xCv9s8sKLfo3aBCSWjJvp9Q@mail.gmail.com> <YRqEPjzHg9IlifBo@redhat.com>
In-Reply-To: <YRqEPjzHg9IlifBo@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Aug 2021 21:57:08 +0300
Message-ID: <CAOQ4uxg+UX6MWRv9JTQDmf6Yf_NyD+pJ438Ds270vGr9YSSPZw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] virtiofs: propagate sync() to file server
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Greg Kurz <groug@kaod.org>, Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Robert Krawitz <rlk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 6:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Sun, Aug 15, 2021 at 05:14:06PM +0300, Amir Goldstein wrote:
> > Hi Greg,
> >
> > Sorry for the late reply, I have some questions about this change...
> >
> > On Fri, May 21, 2021 at 9:12 AM Greg Kurz <groug@kaod.org> wrote:
> > >
> > > Even if POSIX doesn't mandate it, linux users legitimately expect
> > > sync() to flush all data and metadata to physical storage when it
> > > is located on the same system. This isn't happening with virtiofs
> > > though : sync() inside the guest returns right away even though
> > > data still needs to be flushed from the host page cache.
> > >
> > > This is easily demonstrated by doing the following in the guest:
> > >
> > > $ dd if=/dev/zero of=/mnt/foo bs=1M count=5K ; strace -T -e sync sync
> > > 5120+0 records in
> > > 5120+0 records out
> > > 5368709120 bytes (5.4 GB, 5.0 GiB) copied, 5.22224 s, 1.0 GB/s
> > > sync()                                  = 0 <0.024068>
> > > +++ exited with 0 +++
> > >
> > > and start the following in the host when the 'dd' command completes
> > > in the guest:
> > >
> > > $ strace -T -e fsync /usr/bin/sync virtiofs/foo
> > > fsync(3)                                = 0 <10.371640>
> > > +++ exited with 0 +++
> > >
> > > There are no good reasons not to honor the expected behavior of
> > > sync() actually : it gives an unrealistic impression that virtiofs
> > > is super fast and that data has safely landed on HW, which isn't
> > > the case obviously.
> > >
> > > Implement a ->sync_fs() superblock operation that sends a new
> > > FUSE_SYNCFS request type for this purpose. Provision a 64-bit
> > > placeholder for possible future extensions. Since the file
> > > server cannot handle the wait == 0 case, we skip it to avoid a
> > > gratuitous roundtrip. Note that this is per-superblock : a
> > > FUSE_SYNCFS is send for the root mount and for each submount.
> > >
> > > Like with FUSE_FSYNC and FUSE_FSYNCDIR, lack of support for
> > > FUSE_SYNCFS in the file server is treated as permanent success.
> > > This ensures compatibility with older file servers : the client
> > > will get the current behavior of sync() not being propagated to
> > > the file server.
> >
> > I wonder - even if the server does not support SYNCFS or if the kernel
> > does not trust the server with SYNCFS, fuse_sync_fs() can wait
> > until all pending requests up to this call have been completed, either
> > before or after submitting the SYNCFS request. No?
>
> >
> > Does virtiofsd track all requests prior to SYNCFS request to make
> > sure that they were executed on the host filesystem before calling
> > syncfs() on the host filesystem?
>
> Hi Amir,
>
> I don't think virtiofsd has any such notion. I would think, that
> client should make sure all pending writes have completed and
> then send SYNCFS request.
>
> Looking at the sync_filesystem(), I am assuming vfs will take care
> of flushing out all dirty pages and then call ->sync_fs.
>
> Having said that, I think fuse queues the writeback request internally
> and signals completion of writeback to mm(end_page_writeback()). And
> that's why fuse_fsync() has notion of waiting for all pending
> writes to finish on an inode (fuse_sync_writes()).
>
> So I think you have raised a good point. That is if there are pending
> writes at the time of syncfs(), we don't seem to have a notion of
> first waiting for all these writes to finish before we send
> FUSE_SYNCFS request to server.

Maybe, but I was not referring to inode writeback requests.
I had assumed that those were handled correctly.
I was referring to pending metadata requests.

->sync_fs() in local fs also takes care of flushing metadata
(e.g. journal). I assumed that virtiofsd implements FUSE_SYNCFS
request by calling syncfs() on host fs, but it is does that than
there is no guarantee that all metadata requests have reached the
host fs from virtiofs unless client or server take care of waiting
for all pending metadata requests before issuing FUSE_SYNCFS.

But maybe I am missing something.

It might be worth mentioning that I did not find any sync_fs()
commands that request to flush metadata caches on the server in
NFS or SMB protocols either.

Thanks,
Amir.
