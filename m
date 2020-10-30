Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2B2A0A26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgJ3PqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgJ3PqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:46:13 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A328C0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 08:46:13 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id d19so3625701vso.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFcH78Yw0pfxvt3AwM9fYeXCITwB39A7gKKajxur5/0=;
        b=FgyeQX4aoiBbFM79EBFleLczgQbrNa2HsouqPxpbgexC5/AI1Hhd5zzIZYFgf8IXUq
         pAarAosw+OfibouTp7RrVPFobobEau7rYvSuJ1vXunTL1MR/t8IAzrEKkDFq+0vTNGYT
         9B6R2nxmqxrZqXn2SfZi2FTHBFfQwSWjiqKOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFcH78Yw0pfxvt3AwM9fYeXCITwB39A7gKKajxur5/0=;
        b=Jv5EGsTc2Fw7bAgxQ0yWVnvhxz55QT1GIzLQL4AVgcNB5bmEv8z+k0VG8vtXdFESBi
         FdgKgoAewsbW2QhWkJW+Jp9bSOa38eIqjGh+Op+kxnGWLJ4u+RF7/bhHouxVQvEMwpFh
         lMfi2HKVl3/gaKF2iKgvTEnMyp8aK9yXXYH2o9A+dBAJRN9Io6hRSp97AzgLslLSaHmv
         DTC9s63dYMGP5qo03b6bZjq1Jh4sVRbw2BxpDT0QbcngD/d+i5TL4+q9dBvU36XPKZPi
         posnTOsRbvup8FYLBVq8khiBLMoIHS1fu9TV5bOETxFF7HL3OwAJVvJpYX2q9Ksb4H1X
         EfDQ==
X-Gm-Message-State: AOAM5332GEytLUQwZa2s32ibgJWQ1HouCNcGqlC1glq3KiFOsBm5v0Ko
        4QGCMnlNEdv+qPAOUMFrP5ugKO1wT/XEEamuh2lBOg==
X-Google-Smtp-Source: ABdhPJzgkbkcDlD/QWNYdVwGIN85FgPiKqcrWoajHn+aHB4z4aaAgVMPRcxnlcxrnWFoVc15DrfrayMXQxD31PHZfT8=
X-Received: by 2002:a05:6102:2ec:: with SMTP id j12mr7559124vsj.21.1604072772593;
 Fri, 30 Oct 2020 08:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201025034117.4918-1-cgxu519@mykernel.net>
In-Reply-To: <20201025034117.4918-1-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Oct 2020 16:46:00 +0100
Message-ID: <CAJfpegu-bn2BjkLaykk-gZLRv71n=PgrsrwBnuAav1GHzWO5iQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] implement containerized syncfs for overlayfs
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 25, 2020 at 4:42 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Current syncfs(2) syscall on overlayfs just calls sync_filesystem()
> on upper_sb to synchronize whole dirty inodes in upper filesystem
> regardless of the overlay ownership of the inode. In the use case of
> container, when multiple containers using the same underlying upper
> filesystem, it has some shortcomings as below.
>
> (1) Performance
> Synchronization is probably heavy because it actually syncs unnecessary
> inodes for target overlayfs.
>
> (2) Interference
> Unplanned synchronization will probably impact IO performance of
> unrelated container processes on the other overlayfs.
>
> This series try to implement containerized syncfs for overlayfs so that
> only sync target dirty upper inodes which are belong to specific overlayfs
> instance. By doing this, it is able to reduce cost of synchronization and
> will not seriously impact IO performance of unrelated processes.

Series looks good at first glance.  Still need to do an in-depth review.

In the meantime can you post some numbers showing the performance improvements?

Thanks,
Miklos
