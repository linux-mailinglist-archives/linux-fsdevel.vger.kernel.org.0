Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF4F613D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 20:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfKITrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Nov 2019 14:47:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42254 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:47:32 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so1569807ioa.9;
        Sat, 09 Nov 2019 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYKraXNLfxX+pdU2SRbr9VE2F1NNmALzbKmry2lE1P8=;
        b=RgxIqeT9ziuhPt7/nmRv46wUR0tgtdu74j+LSBw2ygr0tPA4a8KREtYS9SrirCL5Bl
         eluTT5/0duKvdPwOQUD+dsczctSkwjAdC5BsA6Ql6DerKWb6GKsejPqQ8z5DSIWFRxDV
         FTogcF9BmQvts21TmGqSUvCjPD3QXHjcvyti5tRQDltSYhNycYv6DcVfVJQwpWF9CJ9f
         th7TDf2hvpi0zAVpYCOK72qQ/zhAtEYQaOcJN4hZv5e0sluL2YR4/V4OWvZi1d8wJru6
         mISjfAuKIdvrViAMylxNnJnM2Bj75aZSesQlRCWIW3X+00V/2UlruMb3Uul0zXEt9yiS
         +IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYKraXNLfxX+pdU2SRbr9VE2F1NNmALzbKmry2lE1P8=;
        b=R/07ucVkOVx0asJyLMQWzBlW65hwr8qS8vmZ0YRU9HnTaoYbk49EKCRCqMtGTACeAx
         q5Uslik79aKbqc8ugK569LKBfxuKAx1Dz5xC9reaKN9QE2osMITL+8MNtcd/VOkbXU83
         3uet78+YKrdBv/Kr+yGvfPCEzqt6Z8hPCxhy1cLshJOgpvwGFh6f8S3wHcocYaz+X7q2
         yrG7nyPQXUrofbLVQwJfmKesO4Im6YlplyOkGfdFfLbH75bDCB10t1IOs4A4LSjcGywB
         +FYxPEVsvRdabi6z/9FpuMlHGfQz1vuPO/7qjz/hafIVymCn6osb+PggslCERWc77GGx
         Wg8w==
X-Gm-Message-State: APjAAAVixIfaD3oRQdksFiqS2vN+uEYSVeP3IFpCE7UILqVNTHna8l8A
        YXuLhySiKcHijadqClsU9TBEMYO+iHFm5bnn7KM=
X-Google-Smtp-Source: APXvYqxQozrzEI7fYRnCyVA+GaNGj8YjwHGQ/ZUu8YOrBajjJAIwh0Vg6PpX315+Z5e1EA0+UqxSKEijlKAnV9ryv8M=
X-Received: by 2002:a6b:ba04:: with SMTP id k4mr1312722iof.131.1573328850900;
 Sat, 09 Nov 2019 11:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20191108185319.9326-1-mchristi@redhat.com>
In-Reply-To: <20191108185319.9326-1-mchristi@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sat, 9 Nov 2019 20:47:54 +0100
Message-ID: <CAOi1vP8UrtQKYFFiqBtGcZR5chkhBkCCTpxMNy9GVd5SYscboQ@mail.gmail.com>
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V3
To:     Mike Christie <mchristi@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, martin@urbackup.org,
        Damien.LeMoal@wdc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 8:24 PM Mike Christie <mchristi@redhat.com> wrote:
>
> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
> amd nbd that have userspace components that can run in the IO path. For
> example, iscsi and nbd's userspace deamons may need to recreate a socket
> and/or send IO on it, and dm-multipath's daemon multipathd may need to
> send SG IO or read/write IO to figure out the state of paths and re-set
> them up.
>
> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
> memalloc_*_save/restore functions to control the allocation behavior,
> but for userspace we would end up hitting an allocation that ended up
> writing data back to the same device we are trying to allocate for.
> The device is then in a state of deadlock, because to execute IO the
> device needs to allocate memory, but to allocate memory the memory
> layers want execute IO to the device.
>
> Here is an example with nbd using a local userspace daemon that performs
> network IO to a remote server. We are using XFS on top of the nbd device,
> but it can happen with any FS or other modules layered on top of the nbd
> device that can write out data to free memory.  Here a nbd daemon helper
> thread, msgr-worker-1, is performing a write/sendmsg on a socket to execute
> a request. This kicks off a reclaim operation which results in a WRITE to
> the nbd device and the nbd thread calling back into the mm layer.
>
> [ 1626.609191] msgr-worker-1   D    0  1026      1 0x00004000
> [ 1626.609193] Call Trace:
> [ 1626.609195]  ? __schedule+0x29b/0x630
> [ 1626.609197]  ? wait_for_completion+0xe0/0x170
> [ 1626.609198]  schedule+0x30/0xb0
> [ 1626.609200]  schedule_timeout+0x1f6/0x2f0
> [ 1626.609202]  ? blk_finish_plug+0x21/0x2e
> [ 1626.609204]  ? _xfs_buf_ioapply+0x2e6/0x410
> [ 1626.609206]  ? wait_for_completion+0xe0/0x170
> [ 1626.609208]  wait_for_completion+0x108/0x170
> [ 1626.609210]  ? wake_up_q+0x70/0x70
> [ 1626.609212]  ? __xfs_buf_submit+0x12e/0x250
> [ 1626.609214]  ? xfs_bwrite+0x25/0x60
> [ 1626.609215]  xfs_buf_iowait+0x22/0xf0
> [ 1626.609218]  __xfs_buf_submit+0x12e/0x250
> [ 1626.609220]  xfs_bwrite+0x25/0x60
> [ 1626.609222]  xfs_reclaim_inode+0x2e8/0x310
> [ 1626.609224]  xfs_reclaim_inodes_ag+0x1b6/0x300
> [ 1626.609227]  xfs_reclaim_inodes_nr+0x31/0x40
> [ 1626.609228]  super_cache_scan+0x152/0x1a0
> [ 1626.609231]  do_shrink_slab+0x12c/0x2d0
> [ 1626.609233]  shrink_slab+0x9c/0x2a0
> [ 1626.609235]  shrink_node+0xd7/0x470
> [ 1626.609237]  do_try_to_free_pages+0xbf/0x380
> [ 1626.609240]  try_to_free_pages+0xd9/0x1f0
> [ 1626.609245]  __alloc_pages_slowpath+0x3a4/0xd30
> [ 1626.609251]  ? ___slab_alloc+0x238/0x560
> [ 1626.609254]  __alloc_pages_nodemask+0x30c/0x350
> [ 1626.609259]  skb_page_frag_refill+0x97/0xd0
> [ 1626.609274]  sk_page_frag_refill+0x1d/0x80
> [ 1626.609279]  tcp_sendmsg_locked+0x2bb/0xdd0
> [ 1626.609304]  tcp_sendmsg+0x27/0x40
> [ 1626.609307]  sock_sendmsg+0x54/0x60
> [ 1626.609308]  ___sys_sendmsg+0x29f/0x320
> [ 1626.609313]  ? sock_poll+0x66/0xb0
> [ 1626.609318]  ? ep_item_poll.isra.15+0x40/0xc0
> [ 1626.609320]  ? ep_send_events_proc+0xe6/0x230
> [ 1626.609322]  ? hrtimer_try_to_cancel+0x54/0xf0
> [ 1626.609324]  ? ep_read_events_proc+0xc0/0xc0
> [ 1626.609326]  ? _raw_write_unlock_irq+0xa/0x20
> [ 1626.609327]  ? ep_scan_ready_list.constprop.19+0x218/0x230
> [ 1626.609329]  ? __hrtimer_init+0xb0/0xb0
> [ 1626.609331]  ? _raw_spin_unlock_irq+0xa/0x20
> [ 1626.609334]  ? ep_poll+0x26c/0x4a0
> [ 1626.609337]  ? tcp_tsq_write.part.54+0xa0/0xa0
> [ 1626.609339]  ? release_sock+0x43/0x90
> [ 1626.609341]  ? _raw_spin_unlock_bh+0xa/0x20
> [ 1626.609342]  __sys_sendmsg+0x47/0x80
> [ 1626.609347]  do_syscall_64+0x5f/0x1c0
> [ 1626.609349]  ? prepare_exit_to_usermode+0x75/0xa0
> [ 1626.609351]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> This patch adds a new prctl command that daemons can use after they have
> done their initial setup, and before they start to do allocations that
> are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE
> flags so both userspace block and FS threads can use it to avoid the
> allocation recursion and try to prevent from being throttled while
> writing out data to free up memory.
>
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
> V3
> - Drop NOFS, set PF_LESS_THROTTLE and rename prctl flag to reflect it
> is more general and can support both FS and block devices. Both fuse
> and block device daemons, nbd and tcmu-runner, have been tested to
> confirm the more restrictive PF_MEMALLOC_NOIO also works for fuse.
>
> - Use CAP_SYS_RESOURCE instead of admin.
>
> V2:
> - Use prctl instead of procfs.
> - Add support for NOFS for fuse.
> - Check permissions.
>
>
>  include/uapi/linux/capability.h |  1 +
>  include/uapi/linux/prctl.h      |  4 ++++
>  kernel/sys.c                    | 26 ++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 240fdb9a60f6..272dc69fa080 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -301,6 +301,7 @@ struct vfs_ns_cap_data {
>  /* Allow more than 64hz interrupts from the real-time clock */
>  /* Override max number of consoles on console allocation */
>  /* Override max number of keymaps */
> +/* Control memory reclaim behavior */
>
>  #define CAP_SYS_RESOURCE     24
>
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 7da1b37b27aa..07b4f8131e36 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -234,4 +234,8 @@ struct prctl_mm_map {
>  #define PR_GET_TAGGED_ADDR_CTRL                56
>  # define PR_TAGGED_ADDR_ENABLE         (1UL << 0)
>
> +/* Control reclaim behavior when allocating memory */
> +#define PR_SET_IO_FLUSHER              57
> +#define PR_GET_IO_FLUSHER              58
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a611d1d58c7d..08c6b682fa99 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2486,6 +2486,32 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error = GET_TAGGED_ADDR_CTRL();
>                 break;
> +       case PR_SET_IO_FLUSHER:
> +               if (!capable(CAP_SYS_RESOURCE))
> +                       return -EPERM;
> +
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +
> +               if (arg2 == 1)
> +                       current->flags |= PF_MEMALLOC_NOIO | PF_LESS_THROTTLE;
> +               else if (!arg2)
> +                       current->flags &= ~(PF_MEMALLOC_NOIO | PF_LESS_THROTTLE);
> +               else
> +                       return -EINVAL;
> +               break;
> +       case PR_GET_IO_FLUSHER:
> +               if (!capable(CAP_SYS_RESOURCE))
> +                       return -EPERM;
> +
> +               if (arg2 || arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +
> +               if (current->flags & (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE))

I think it needs to be conditioned on both flags instead of just one of
them, for consistency with SET.  Seems worth a define too, PF_IO_FLUSHER?
Or something local to this file at least.

> +                       error = 1;
> +               else
> +                       error = 0;

  error = (current->flags & PF_IO_FLUSHER) == PF_IO_FLUSHER;

Thanks,

                Ilya
