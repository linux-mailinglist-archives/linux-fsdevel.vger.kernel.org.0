Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2737D2152C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 08:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGFGqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 02:46:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727089AbgGFGqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 02:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594017963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARowG2upYL1FRBFOB0ffQO34fUJQ8qsd+4GQ3s8Aw0w=;
        b=QMKzNuFqi45lWp9Ohs2Px3kpddwS0d+LtraufIZVpX49hkeqIkqlRvCkH1j4KvO5dbKIUO
        fKfnvLyInx/NWI6iXpy9z2eu5XdMe/VYRqGsiCorfCcuYssPyAP2/vkXOfx4AR9/i+1ny9
        kzrdN7Yr5m54V/WWgQpvwfM2J8NoFSk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Nbj0IJzSPPqcJzCTqB4FgQ-1; Mon, 06 Jul 2020 02:46:01 -0400
X-MC-Unique: Nbj0IJzSPPqcJzCTqB4FgQ-1
Received: by mail-wr1-f70.google.com with SMTP id w4so39261165wrm.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2020 23:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARowG2upYL1FRBFOB0ffQO34fUJQ8qsd+4GQ3s8Aw0w=;
        b=lQVbjkB9FhS3MoE5cNUcZXrcqDx2Weq5pa0OAnnF53YZYLJNtl3mhsiyippwcXgmlq
         Mpy+k79yRSvK+gS60SIYWtDzPfjrwOVTPvwuuRoGBLn6XPyAy1gV5bjsUuj22pAlEI2Y
         20m11wEFDlj382M6ey5BMjUFtcdwx9szugF3bZTFzcmdvAZnbrQtUGASHOr5aGx0kKuZ
         7F+tzT/WZWC/jcP8qRIh+Ijvjlg0CWSuY3aiaUKa9Pism6WqrEa0kPHgZC+G7BE1w5Tq
         wfjgwqmebWOkcW05vvno+fsCynL4+506ZN1nr8XIKBCGpEjtzs7UDFIGDEe52kL4XMPO
         WPpA==
X-Gm-Message-State: AOAM5314cf2PhgZkfNlkD61l6RsJ8BLyvkEpHXCz84/r1Zj/ffwjuhLQ
        gLxNWproerOAVRwQGrj+QUv89zybc+FOhnsxeHKw3UixUMJi2B7d8IkI0KDctlaQg7bNZ9H5lT6
        NBFgoTP2HNQzzYwmlCyuCpn/uGw==
X-Received: by 2002:adf:c551:: with SMTP id s17mr45472947wrf.330.1594017960089;
        Sun, 05 Jul 2020 23:46:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXKRgv2Yi4GtFNaRL7lNBSGMigmOVf2YwXXf+1ouKxxO0A6r9m6n7Qd3x6f9RjD+e21Ty2cw==
X-Received: by 2002:adf:c551:: with SMTP id s17mr45472928wrf.330.1594017959736;
        Sun, 05 Jul 2020 23:45:59 -0700 (PDT)
Received: from localhost.localdomain ([151.29.90.54])
        by smtp.gmail.com with ESMTPSA id 92sm24328066wrr.96.2020.07.05.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 23:45:59 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:45:57 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200706064557.GA26135@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/07/20 19:11, He Zhe wrote:
> 
> 
> On 7/3/20 4:12 PM, Juri Lelli wrote:
> > Hi,
> >
> > On 10/04/20 19:47, zhe.he@windriver.com wrote:
> >> From: He Zhe <zhe.he@windriver.com>
> >>
> >> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> >> introduces a percpu counter that tracks the percpu recursion depth and
> >> warn if it greater than zero, to avoid potential deadlock and stack
> >> overflow.
> >>
> >> However sometimes different eventfds may be used in parallel. Specifically,
> >> when heavy network load goes through kvm and vhost, working as below, it
> >> would trigger the following call trace.
> >>
> >> -  100.00%
> >>    - 66.51%
> >>         ret_from_fork
> >>         kthread
> >>       - vhost_worker
> >>          - 33.47% handle_tx_kick
> >>               handle_tx
> >>               handle_tx_copy
> >>               vhost_tx_batch.isra.0
> >>               vhost_add_used_and_signal_n
> >>               eventfd_signal
> >>          - 33.05% handle_rx_net
> >>               handle_rx
> >>               vhost_add_used_and_signal_n
> >>               eventfd_signal
> >>    - 33.49%
> >>         ioctl
> >>         entry_SYSCALL_64_after_hwframe
> >>         do_syscall_64
> >>         __x64_sys_ioctl
> >>         ksys_ioctl
> >>         do_vfs_ioctl
> >>         kvm_vcpu_ioctl
> >>         kvm_arch_vcpu_ioctl_run
> >>         vmx_handle_exit
> >>         handle_ept_misconfig
> >>         kvm_io_bus_write
> >>         __kvm_io_bus_write
> >>         eventfd_signal
> >>
> >> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> >> ---- snip ----
> >> 001: Call Trace:
> >> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> >> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> >> 001:  handle_rx+0xb9/0x900 [vhost_net]
> >> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> >> 001:  vhost_worker+0xbe/0x120 [vhost]
> >> 001:  kthread+0x106/0x140
> >> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> >> 001:  ? kthread_park+0x90/0x90
> >> 001:  ret_from_fork+0x35/0x40
> >> 001: ---[ end trace 0000000000000003 ]---
> >>
> >> This patch enlarges the limit to 1 which is the maximum recursion depth we
> >> have found so far.
> >>
> >> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >> ---
> > Not sure if this approch can fly, but I also encountered the same
> > warning (which further caused hangs during VM install) and this change
> > addresses that.
> >
> > I'd be interested in understanding what is the status of this problem/fix.
> 
> This is actually v2 of the patch and has not got any reply yet. Here is the v1. FYI.
> https://lore.kernel.org/lkml/1586257192-58369-1-git-send-email-zhe.he@windriver.com/

I see, thanks. Hope this gets reviewed soon! :-)

> > On a side note, by looking at the code, I noticed that (apart from
> > samples) all callers don't actually check eventfd_signal() return value
> > and I'm wondering why is that the case and if is it safe to do so.
> 
> Checking the return value right after sending the signal can tell us if the
> event counter has just overflowed, that is, exceeding ULLONG_MAX. I guess the
> authors of the callers listed in the commit log just don't worry about that,
> since they add only one to a dedicated eventfd.

OK. I was mostly wondering if returning early in case the WARN_ON_ONCE
fires would cause a missing wakeup for the eventfd_ctx wait queue.

Best,

Juri

