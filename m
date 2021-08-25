Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4B3F70C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhHYH6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 03:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhHYH6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:58:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B2AC061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 00:57:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r19so35589428eds.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3eDvUGO7s6rgbcqfVCZxuvxMbSRmJ1Jj8MfBoaTMPU=;
        b=I0obnZsM9J3DhGn8Ys+njqxlL+bvBvgmQCONvmFRG3akvZreIl/ty1+M2K3Frb8Fb2
         hSsA5AFpaI9srN6CIlMZizcgQO8A3NxT+xtcTgs9d/8FlFmBT0j8teuNajfiQhV4UrlU
         DI4rUsLWVef+y7quOM7/ssYW5S0FO4s1op+sfCFZlto6iKWSI6BCPaEtzhirnHYYVo06
         mikpSeFfIaI0sbYIAkO/PbG1HKRbajG9sRnjQyNlbNYpw7ddU/f5Svq12UMTS5SgkREH
         pYTyBM0g3UtNqg9Y7/2GqaKcShwxlSMVjWTG9unOAYYzvataVgFp+/PCUmIBVtPe6b1G
         9T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3eDvUGO7s6rgbcqfVCZxuvxMbSRmJ1Jj8MfBoaTMPU=;
        b=OsndC4BRsBPxJGzgbfoFyobwf6aXP38IMa+aUaCaYq6/ca6i72OVXhpwaCc/mDBwKT
         m3tNYRHsjeATTLCvYYojWUmg6ORn82sgcYyrhn1tE/c2cLFx/YuY1mNLSRH2U8Z0aZIK
         Hw9tVxvDJGNePuo9rViomEFV1VpOZwdICpgwjD6WS7F05Ym0XQkD8TeZlFz9t+QGrAYU
         NN80L+X9vt7KcCXNA+98ekwMhH8srvKi0bNoxWCPB6FemKtRtf/uBvfQ/Vtbqbo/tOji
         zzw1sVuz3iwm9tA5jmbnLUmRSIwXBdb8qODEylF3Ak2rcy/QrfsUMw4VYfZ6F6qXIb6N
         wbaw==
X-Gm-Message-State: AOAM533iqkgEIHlumcOc9M5we/sdBpA25miO8MCczfhkIHaX/SAn1fxi
        XNdPSVYMWMHyahWZfSjnKitcB5nogU0vqlD54IgS
X-Google-Smtp-Source: ABdhPJx++s4yL0aljTFECCTgTqB0y8G0ZDiiFqmfkcPa/z8HtCB9PzVuE2+kCr4soT/hE2Bnuo8u47S4GL5NNC9DCyc=
X-Received: by 2002:a50:eb95:: with SMTP id y21mr46534633edr.5.1629878239593;
 Wed, 25 Aug 2021 00:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
 <20210618084412.18257-1-zhe.he@windriver.com>
In-Reply-To: <20210618084412.18257-1-zhe.he@windriver.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 25 Aug 2021 15:57:08 +0800
Message-ID: <CACycT3sri2-GyaW08JhS2j1V2DRc7-Cv-tm6-T-dD7XVO=S6Vw@mail.gmail.com>
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
To:     He Zhe <zhe.he@windriver.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian.brauner@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        qiang.zhang@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi guys,

Is there any comments or update for this patch?

Thanks,
Yongji

On Fri, Jun 18, 2021 at 4:47 PM He Zhe <zhe.he@windriver.com> wrote:
>
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
>
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
>
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
>
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
>
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
>
> The credit of modification for eventfd_signal_count goes to
> Xie Yongji <xieyongji@bytedance.com>
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  fs/eventfd.c            | 3 ++-
>  include/linux/eventfd.h | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..add6af91cacf 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -71,7 +71,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>          * it returns true, the eventfd_signal() call should be deferred to a
>          * safe context.
>          */
> -       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +       if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
> +           EFD_WAKE_COUNT_MAX))
>                 return 0;
>
>         spin_lock_irqsave(&ctx->wqh.lock, flags);
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index fa0a524baed0..74be152ebe87 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -29,6 +29,9 @@
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
>
> +/* This is the maximum recursion depth we find so far */
> +#define EFD_WAKE_COUNT_MAX 1
> +
>  struct eventfd_ctx;
>  struct file;
>
> @@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
>
>  static inline bool eventfd_signal_count(void)
>  {
> -       return this_cpu_read(eventfd_wake_count);
> +       return this_cpu_read(eventfd_wake_count) > EFD_WAKE_COUNT_MAX;
>  }
>
>  #else /* CONFIG_EVENTFD */
> --
> 2.17.1
>
