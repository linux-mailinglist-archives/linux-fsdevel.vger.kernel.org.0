Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64E43BA7CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGCIdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 04:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230094AbhGCIdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 04:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625301073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5pLvLjSYytl9fxuQeHwRO0qsjIw9mqvaKkb7Y9O3i8=;
        b=eFY+saDpB3yRNFoGN+HMUaDEsl//zqpPAP2m8INoI0g88LjWeljAwDhPKO9+2qQu9/yJQz
        Fsm2VO8hiFKUuX6ccqdanskY9dD8rzh56sgJlptp3HjhYsm735axJtu+fMP2FCGwLpsvfe
        hC+PSk5KhNz0tcILfT5du3nZqIGheVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-2tpo4PLKPk6xtHo_2KLetw-1; Sat, 03 Jul 2021 04:31:10 -0400
X-MC-Unique: 2tpo4PLKPk6xtHo_2KLetw-1
Received: by mail-wm1-f71.google.com with SMTP id z4-20020a1ce2040000b02901ee8d8e151eso7514605wmg.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jul 2021 01:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A5pLvLjSYytl9fxuQeHwRO0qsjIw9mqvaKkb7Y9O3i8=;
        b=RbnYKdsOI3P/WqIccnpys8J7jXLY1oyiTP4TPPVBhAy4H+4p1i6cA7W1AhGDuhgZz6
         aKThY+GFqxpKrdH0J2qahltujSOnWqOcQwi+wrJY25r5cPZANkc8H11tjtKZ27Hd9j6p
         pH9ybZFs22JAWm+gVSy/V3RY29USZ4YEHJlvqusOveuR4McQkikjqYo2nSx2J5cptu8s
         ouj/JHAROHnolVECNDvce9gal2S4VgEG2gSyjaQe4kPBkdzKHKBbWJsjZO8fj2l9k+q2
         rPADOyIz5nJ29GsbyPrvbYzp+G6Km+pcA/hZXKLoGnLaFcWc2ohdm9FbKjSOdlb2Ss1Z
         OCcA==
X-Gm-Message-State: AOAM5335hvUhNDYqf7Uc2dxCxJttuqUaDjM3hTSnJylKYAR+hu19LLxk
        /0S0rWYt9s2Nu4fqr88JboZdELSist/ljA1qWSvcyOBcql1GDajyL7MQhniHqO1shZSIFqM1DPK
        /XeDu5nYaAgAJd0CKyRKVRoUccw==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr3900756wmk.17.1625301069176;
        Sat, 03 Jul 2021 01:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrvv4LtZcQ7zdL29oxvTkKz5qNfM0qWp0wXMltlMPDTMTgPHfjYLGKI6BE2STBxqHT1590MA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr3900747wmk.17.1625301069032;
        Sat, 03 Jul 2021 01:31:09 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id k5sm5943632wmk.11.2021.07.03.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 01:31:08 -0700 (PDT)
Date:   Sat, 3 Jul 2021 04:31:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qiang.zhang@windriver.com
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20210703043039-mutt-send-email-mst@kernel.org>
References: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
 <20210618084412.18257-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618084412.18257-1-zhe.he@windriver.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 04:44:12PM +0800, He Zhe wrote:
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

And maybe:

Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")

who's merging this?

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
>  	 * it returns true, the eventfd_signal() call should be deferred to a
>  	 * safe context.
>  	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
> +	    EFD_WAKE_COUNT_MAX))
>  		return 0;
>  
>  	spin_lock_irqsave(&ctx->wqh.lock, flags);
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
> -	return this_cpu_read(eventfd_wake_count);
> +	return this_cpu_read(eventfd_wake_count) > EFD_WAKE_COUNT_MAX;
>  }
>  
>  #else /* CONFIG_EVENTFD */
> -- 
> 2.17.1

