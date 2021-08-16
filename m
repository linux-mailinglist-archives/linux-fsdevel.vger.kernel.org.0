Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5EA3EDE06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhHPTqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:46:55 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D137C061764;
        Mon, 16 Aug 2021 12:46:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b200so4111967iof.13;
        Mon, 16 Aug 2021 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jMgE24VfD9cKFTXWDSvOslcHjMiN2+6gaRxcaSd4AcY=;
        b=BQOwjOp0YUFU4qmCqhl/8uiu7gdPCDYWwtStWJJqqFrkKAuujQl79BwOvz1C7U5WMO
         mMB50crR2WL0+xogA7CN8PIr+QD2/JIcYazMdeXrRWUrk4uu+dz8aq2PXlYhCtpxNgDu
         poy+CqQKLI+doFQtFiUNm84Q8+Cn/FoSNKax0HnRcjZXMvUsC7/vHmHfEtUJ0oXqWj4u
         rP6DbGj2gMU+nD6W+1bOmGiTF4Kze8GWXAN42msKz59wiQGo8rvb9dhAw4klnam3Nl6o
         qn3UH5IrSNlyu6wEcGbV4dQzxIBWO6EuvV6sWarM/PHp8qgxBbBti7h5K5emE/J2Uu4w
         KfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMgE24VfD9cKFTXWDSvOslcHjMiN2+6gaRxcaSd4AcY=;
        b=dcE5timHCBhCs0iQL0yRksOpxFtKyI8psSdyL3V+I7+I+eCnxpk36UE4TEfLZQAU/v
         vBhIKzKvgzP1km9dVr60Ecg4+2Azo8jb8NrUbb6+MMcSq7nnmWfPcpbfwY+TVNKj3pL3
         TSmgbIczPUC7mOiMjjWJ5AQmL4+OcRtECPIeO6sjVB69h5Qk1VhV0I3vH4LT4Te9etlf
         9Z5JH9KaQcwiHQVDN9IMGEMPi56wINTAAa0MYuykc152hZ0SIGsLasHbWvopbjRcYx5F
         g2u68VfrX6yPkC5oKLQt/TVLLOMwQjZSjTw7Pih0GJ1eY3PShh+knWNrSj40hCDy85FC
         y4dA==
X-Gm-Message-State: AOAM532DfmK9pziN5Dl+H5KaZj3cAvUaGSLT2JpHORLGWihR+EAPd/AK
        9RZ/VBeLSAe15Xfgo9RY0U/lGr7RHeb3nlAMUs4=
X-Google-Smtp-Source: ABdhPJzwdVZFYrd1Xmfcp5sfTEpkgjlzBKzTLvtuSUpltTHJtJH+gBldvhuSiHxJwVIn9x7t5TxmLuXKrriBLffHLaE=
X-Received: by 2002:a6b:e712:: with SMTP id b18mr433761ioh.186.1629143182752;
 Mon, 16 Aug 2021 12:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-6-groug@kaod.org>
 <CAOQ4uxh69ii5Yk-DgFAq+TrrvJ6xCv9s8sKLfo3aBCSWjJvp9Q@mail.gmail.com>
 <YRqEPjzHg9IlifBo@redhat.com> <CAOQ4uxg+UX6MWRv9JTQDmf6Yf_NyD+pJ438Ds270vGr9YSSPZw@mail.gmail.com>
 <YRq4W1zcsAZh3FLX@redhat.com>
In-Reply-To: <YRq4W1zcsAZh3FLX@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Aug 2021 22:46:10 +0300
Message-ID: <CAOQ4uxiezabg0U3tGmpH8J4u7OUbB2KMXexZ7yQzujj0vAWirw@mail.gmail.com>
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

On Mon, Aug 16, 2021 at 10:11 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Aug 16, 2021 at 09:57:08PM +0300, Amir Goldstein wrote:
> > On Mon, Aug 16, 2021 at 6:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Sun, Aug 15, 2021 at 05:14:06PM +0300, Amir Goldstein wrote:
> > > > Hi Greg,
> > > >
> > > > Sorry for the late reply, I have some questions about this change...
> > > >
> > > > On Fri, May 21, 2021 at 9:12 AM Greg Kurz <groug@kaod.org> wrote:
> > > > >
> > > > > Even if POSIX doesn't mandate it, linux users legitimately expect
> > > > > sync() to flush all data and metadata to physical storage when it
> > > > > is located on the same system. This isn't happening with virtiofs
> > > > > though : sync() inside the guest returns right away even though
> > > > > data still needs to be flushed from the host page cache.
> > > > >
> > > > > This is easily demonstrated by doing the following in the guest:
> > > > >
> > > > > $ dd if=/dev/zero of=/mnt/foo bs=1M count=5K ; strace -T -e sync sync
> > > > > 5120+0 records in
> > > > > 5120+0 records out
> > > > > 5368709120 bytes (5.4 GB, 5.0 GiB) copied, 5.22224 s, 1.0 GB/s
> > > > > sync()                                  = 0 <0.024068>
> > > > > +++ exited with 0 +++
> > > > >
> > > > > and start the following in the host when the 'dd' command completes
> > > > > in the guest:
> > > > >
> > > > > $ strace -T -e fsync /usr/bin/sync virtiofs/foo
> > > > > fsync(3)                                = 0 <10.371640>
> > > > > +++ exited with 0 +++
> > > > >
> > > > > There are no good reasons not to honor the expected behavior of
> > > > > sync() actually : it gives an unrealistic impression that virtiofs
> > > > > is super fast and that data has safely landed on HW, which isn't
> > > > > the case obviously.
> > > > >
> > > > > Implement a ->sync_fs() superblock operation that sends a new
> > > > > FUSE_SYNCFS request type for this purpose. Provision a 64-bit
> > > > > placeholder for possible future extensions. Since the file
> > > > > server cannot handle the wait == 0 case, we skip it to avoid a
> > > > > gratuitous roundtrip. Note that this is per-superblock : a
> > > > > FUSE_SYNCFS is send for the root mount and for each submount.
> > > > >
> > > > > Like with FUSE_FSYNC and FUSE_FSYNCDIR, lack of support for
> > > > > FUSE_SYNCFS in the file server is treated as permanent success.
> > > > > This ensures compatibility with older file servers : the client
> > > > > will get the current behavior of sync() not being propagated to
> > > > > the file server.
> > > >
> > > > I wonder - even if the server does not support SYNCFS or if the kernel
> > > > does not trust the server with SYNCFS, fuse_sync_fs() can wait
> > > > until all pending requests up to this call have been completed, either
> > > > before or after submitting the SYNCFS request. No?
> > >
> > > >
> > > > Does virtiofsd track all requests prior to SYNCFS request to make
> > > > sure that they were executed on the host filesystem before calling
> > > > syncfs() on the host filesystem?
> > >
> > > Hi Amir,
> > >
> > > I don't think virtiofsd has any such notion. I would think, that
> > > client should make sure all pending writes have completed and
> > > then send SYNCFS request.
> > >
> > > Looking at the sync_filesystem(), I am assuming vfs will take care
> > > of flushing out all dirty pages and then call ->sync_fs.
> > >
> > > Having said that, I think fuse queues the writeback request internally
> > > and signals completion of writeback to mm(end_page_writeback()). And
> > > that's why fuse_fsync() has notion of waiting for all pending
> > > writes to finish on an inode (fuse_sync_writes()).
> > >
> > > So I think you have raised a good point. That is if there are pending
> > > writes at the time of syncfs(), we don't seem to have a notion of
> > > first waiting for all these writes to finish before we send
> > > FUSE_SYNCFS request to server.
> >
> > Maybe, but I was not referring to inode writeback requests.
> > I had assumed that those were handled correctly.
> > I was referring to pending metadata requests.
> >
> > ->sync_fs() in local fs also takes care of flushing metadata
> > (e.g. journal). I assumed that virtiofsd implements FUSE_SYNCFS
> > request by calling syncfs() on host fs,
>
> Yes virtiofsd calls syncfs() on host fs.
>
> > but it is does that than
> > there is no guarantee that all metadata requests have reached the
> > host fs from virtiofs unless client or server take care of waiting
> > for all pending metadata requests before issuing FUSE_SYNCFS.
>
> We don't have any journal in virtiofs. In fact we don't seem to
> cache any metadta. Except probably the case when "-o writeback"
> where we can trust local time stamps.
>
> If "-o writeback" is not enabled, i am not sure what metadata
> we will be caching that we will need to worry about. Do you have
> something specific in mind. (Atleast from virtiofs point of view,
> I can't seem to think what metadata we are caching which we need
> to worry about).

No, I don't see a problem.
I guess I was confused by the semantics.
Thanks for clarifying.

Amir.
