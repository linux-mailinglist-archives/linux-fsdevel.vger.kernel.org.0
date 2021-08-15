Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720913EC986
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 16:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhHOOOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhHOOOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:14:48 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09829C061764;
        Sun, 15 Aug 2021 07:14:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h18so15915562ilc.5;
        Sun, 15 Aug 2021 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwNI0p+kAxekQFEgThqJO01pCQz3VjRuWiNMPrnWSjo=;
        b=EqJ6nAzEj98U58CglqH779zZgDCiRPuLUXMjDIrQ3Z0QpN1iMwN7FLIcm0ggEeo5Vy
         jwq1LRP2mSo9gxBuDvlVtjEXv4rapF92dVf7TEOWKSTpOfMHxJw1TMGpI2R3H2fqzfhA
         N91ZM4GFdQ34DhdtDrwMYzNo4Pegynvpykt2ifU8sHBwVjYl/tVVS0KZmhqRvOrV+4E7
         fD4Oxez1J4NFPIaWX0NvfZPYoxUteTHVPz0UkDRbzagT5PONUM/IjuLBy6GDdeihzpNl
         GDTzukVa0NEHjur3qybFDdVl3YL6G6By51pPV/EYyJWOszz6Gah0R7y+5IGyoKkYs++J
         +F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwNI0p+kAxekQFEgThqJO01pCQz3VjRuWiNMPrnWSjo=;
        b=lw+MpZPnrKsCBWbwIemMiY74KxiRDZzJPAO7NH2Do81AOueA1jywa346hkX1djfzwZ
         74KYrYpjyclJ+4B+oivps2uAy8VbZa/ZwwWaRwZKxiVo47uWSwR+EgdLhAPqz4UcD0db
         5ctRUGndtEK2IU20nM4VD2rUCzcH1V2zh+Xr33jOCgHlAvhofcW0AmgdTaQ2LiF11wuo
         IGT9GypTT9VC7TTPGBGK2jgMVV+XTIg43s3W1h0xhDFz3XTlrzsLcl9QvpeGrWhj3FWP
         Ack2Qyxywdu7d9jztRYYnzc4/PUPqqQ24j0e4Hm7Rf2lab+nmfSH90CWclCotteqCojp
         KRlg==
X-Gm-Message-State: AOAM533sCxR5xClR5uQaoam6mTF7vf9PGQ5717rEKl/cNxizO/PRhoXz
        otiUPoJUAmoxtjIQkzUNy+ewDeC+43EuB8vqxqM=
X-Google-Smtp-Source: ABdhPJwNCreaQS58j6/gBrdWWYCDmy26VPMH/XtAO27zsOZ8kEsHU1jV2ag80Zzo7fTl6l8aQrejDT4T9bZOUDzaGD8=
X-Received: by 2002:a92:8702:: with SMTP id m2mr8765875ild.250.1629036857397;
 Sun, 15 Aug 2021 07:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-6-groug@kaod.org>
In-Reply-To: <20210520154654.1791183-6-groug@kaod.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 15 Aug 2021 17:14:06 +0300
Message-ID: <CAOQ4uxh69ii5Yk-DgFAq+TrrvJ6xCv9s8sKLfo3aBCSWjJvp9Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] virtiofs: propagate sync() to file server
To:     Greg Kurz <groug@kaod.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Robert Krawitz <rlk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

Sorry for the late reply, I have some questions about this change...

On Fri, May 21, 2021 at 9:12 AM Greg Kurz <groug@kaod.org> wrote:
>
> Even if POSIX doesn't mandate it, linux users legitimately expect
> sync() to flush all data and metadata to physical storage when it
> is located on the same system. This isn't happening with virtiofs
> though : sync() inside the guest returns right away even though
> data still needs to be flushed from the host page cache.
>
> This is easily demonstrated by doing the following in the guest:
>
> $ dd if=/dev/zero of=/mnt/foo bs=1M count=5K ; strace -T -e sync sync
> 5120+0 records in
> 5120+0 records out
> 5368709120 bytes (5.4 GB, 5.0 GiB) copied, 5.22224 s, 1.0 GB/s
> sync()                                  = 0 <0.024068>
> +++ exited with 0 +++
>
> and start the following in the host when the 'dd' command completes
> in the guest:
>
> $ strace -T -e fsync /usr/bin/sync virtiofs/foo
> fsync(3)                                = 0 <10.371640>
> +++ exited with 0 +++
>
> There are no good reasons not to honor the expected behavior of
> sync() actually : it gives an unrealistic impression that virtiofs
> is super fast and that data has safely landed on HW, which isn't
> the case obviously.
>
> Implement a ->sync_fs() superblock operation that sends a new
> FUSE_SYNCFS request type for this purpose. Provision a 64-bit
> placeholder for possible future extensions. Since the file
> server cannot handle the wait == 0 case, we skip it to avoid a
> gratuitous roundtrip. Note that this is per-superblock : a
> FUSE_SYNCFS is send for the root mount and for each submount.
>
> Like with FUSE_FSYNC and FUSE_FSYNCDIR, lack of support for
> FUSE_SYNCFS in the file server is treated as permanent success.
> This ensures compatibility with older file servers : the client
> will get the current behavior of sync() not being propagated to
> the file server.

I wonder - even if the server does not support SYNCFS or if the kernel
does not trust the server with SYNCFS, fuse_sync_fs() can wait
until all pending requests up to this call have been completed, either
before or after submitting the SYNCFS request. No?

Does virtiofsd track all requests prior to SYNCFS request to make
sure that they were executed on the host filesystem before calling
syncfs() on the host filesystem?

I am not familiar enough with FUSE internals so there may already
be a mechanism to track/wait for all pending requests?

>
> Note that such an operation allows the file server to DoS sync().
> Since a typical FUSE file server is an untrusted piece of software
> running in userspace, this is disabled by default.  Only enable it
> with virtiofs for now since virtiofsd is supposedly trusted by the
> guest kernel.

Isn't there already a similar risk of DoS to sync() from the ability of any
untrusted (or malfunctioning) server to block writes?

Thanks,
Amir.
