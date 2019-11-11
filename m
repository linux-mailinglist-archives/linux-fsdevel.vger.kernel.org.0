Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE24FF77C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKKPes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 10:34:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbfKKPer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573486485;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKIg2qZjecddKZ7Jr+8BQ/R4X4wOCT3J0z5mvON0mkc=;
        b=Vr6gGUD2OIlN+pvCjhzO0KmAJGb95lUZp83DYDmGRdNxYauPbSh414yG52iKs4kQDI1bfT
        5meTg7uef6s84LCq3lVTPWfIrVnBr8YHId9Kxm80DnD2Ole3VjZWMdaI56wgztvhJXplxs
        KpqT72KtD/7H/XwjS9OqPfC/pWGS3Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-fmBZr0vqOu-b3E3K2GlFRQ-1; Mon, 11 Nov 2019 10:34:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE903107ACC5;
        Mon, 11 Nov 2019 15:34:40 +0000 (UTC)
Received: from mchristi.msp.csb (ovpn-126-72.rdu2.redhat.com [10.10.126.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE8885D6A3;
        Mon, 11 Nov 2019 15:34:38 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V3
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, martin@urbackup.org,
        Damien.LeMoal@wdc.com
References: <20191108185319.9326-1-mchristi@redhat.com>
 <CAOi1vP8UrtQKYFFiqBtGcZR5chkhBkCCTpxMNy9GVd5SYscboQ@mail.gmail.com>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <6866412f-46d2-28ff-c833-e9006a46913c@redhat.com>
Date:   Mon, 11 Nov 2019 09:34:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAOi1vP8UrtQKYFFiqBtGcZR5chkhBkCCTpxMNy9GVd5SYscboQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: fmBZr0vqOu-b3E3K2GlFRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/09/2019 01:47 PM, Ilya Dryomov wrote:
> On Fri, Nov 8, 2019 at 8:24 PM Mike Christie <mchristi@redhat.com> wrote:
>>
>> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
>> amd nbd that have userspace components that can run in the IO path. For
>> example, iscsi and nbd's userspace deamons may need to recreate a socket
>> and/or send IO on it, and dm-multipath's daemon multipathd may need to
>> send SG IO or read/write IO to figure out the state of paths and re-set
>> them up.
>>
>> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
>> memalloc_*_save/restore functions to control the allocation behavior,
>> but for userspace we would end up hitting an allocation that ended up
>> writing data back to the same device we are trying to allocate for.
>> The device is then in a state of deadlock, because to execute IO the
>> device needs to allocate memory, but to allocate memory the memory
>> layers want execute IO to the device.
>>
>> Here is an example with nbd using a local userspace daemon that performs
>> network IO to a remote server. We are using XFS on top of the nbd device=
,
>> but it can happen with any FS or other modules layered on top of the nbd
>> device that can write out data to free memory.  Here a nbd daemon helper
>> thread, msgr-worker-1, is performing a write/sendmsg on a socket to exec=
ute
>> a request. This kicks off a reclaim operation which results in a WRITE t=
o
>> the nbd device and the nbd thread calling back into the mm layer.
>>
>> [ 1626.609191] msgr-worker-1   D    0  1026      1 0x00004000
>> [ 1626.609193] Call Trace:
>> [ 1626.609195]  ? __schedule+0x29b/0x630
>> [ 1626.609197]  ? wait_for_completion+0xe0/0x170
>> [ 1626.609198]  schedule+0x30/0xb0
>> [ 1626.609200]  schedule_timeout+0x1f6/0x2f0
>> [ 1626.609202]  ? blk_finish_plug+0x21/0x2e
>> [ 1626.609204]  ? _xfs_buf_ioapply+0x2e6/0x410
>> [ 1626.609206]  ? wait_for_completion+0xe0/0x170
>> [ 1626.609208]  wait_for_completion+0x108/0x170
>> [ 1626.609210]  ? wake_up_q+0x70/0x70
>> [ 1626.609212]  ? __xfs_buf_submit+0x12e/0x250
>> [ 1626.609214]  ? xfs_bwrite+0x25/0x60
>> [ 1626.609215]  xfs_buf_iowait+0x22/0xf0
>> [ 1626.609218]  __xfs_buf_submit+0x12e/0x250
>> [ 1626.609220]  xfs_bwrite+0x25/0x60
>> [ 1626.609222]  xfs_reclaim_inode+0x2e8/0x310
>> [ 1626.609224]  xfs_reclaim_inodes_ag+0x1b6/0x300
>> [ 1626.609227]  xfs_reclaim_inodes_nr+0x31/0x40
>> [ 1626.609228]  super_cache_scan+0x152/0x1a0
>> [ 1626.609231]  do_shrink_slab+0x12c/0x2d0
>> [ 1626.609233]  shrink_slab+0x9c/0x2a0
>> [ 1626.609235]  shrink_node+0xd7/0x470
>> [ 1626.609237]  do_try_to_free_pages+0xbf/0x380
>> [ 1626.609240]  try_to_free_pages+0xd9/0x1f0
>> [ 1626.609245]  __alloc_pages_slowpath+0x3a4/0xd30
>> [ 1626.609251]  ? ___slab_alloc+0x238/0x560
>> [ 1626.609254]  __alloc_pages_nodemask+0x30c/0x350
>> [ 1626.609259]  skb_page_frag_refill+0x97/0xd0
>> [ 1626.609274]  sk_page_frag_refill+0x1d/0x80
>> [ 1626.609279]  tcp_sendmsg_locked+0x2bb/0xdd0
>> [ 1626.609304]  tcp_sendmsg+0x27/0x40
>> [ 1626.609307]  sock_sendmsg+0x54/0x60
>> [ 1626.609308]  ___sys_sendmsg+0x29f/0x320
>> [ 1626.609313]  ? sock_poll+0x66/0xb0
>> [ 1626.609318]  ? ep_item_poll.isra.15+0x40/0xc0
>> [ 1626.609320]  ? ep_send_events_proc+0xe6/0x230
>> [ 1626.609322]  ? hrtimer_try_to_cancel+0x54/0xf0
>> [ 1626.609324]  ? ep_read_events_proc+0xc0/0xc0
>> [ 1626.609326]  ? _raw_write_unlock_irq+0xa/0x20
>> [ 1626.609327]  ? ep_scan_ready_list.constprop.19+0x218/0x230
>> [ 1626.609329]  ? __hrtimer_init+0xb0/0xb0
>> [ 1626.609331]  ? _raw_spin_unlock_irq+0xa/0x20
>> [ 1626.609334]  ? ep_poll+0x26c/0x4a0
>> [ 1626.609337]  ? tcp_tsq_write.part.54+0xa0/0xa0
>> [ 1626.609339]  ? release_sock+0x43/0x90
>> [ 1626.609341]  ? _raw_spin_unlock_bh+0xa/0x20
>> [ 1626.609342]  __sys_sendmsg+0x47/0x80
>> [ 1626.609347]  do_syscall_64+0x5f/0x1c0
>> [ 1626.609349]  ? prepare_exit_to_usermode+0x75/0xa0
>> [ 1626.609351]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> This patch adds a new prctl command that daemons can use after they have
>> done their initial setup, and before they start to do allocations that
>> are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE
>> flags so both userspace block and FS threads can use it to avoid the
>> allocation recursion and try to prevent from being throttled while
>> writing out data to free up memory.
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>> ---
>> V3
>> - Drop NOFS, set PF_LESS_THROTTLE and rename prctl flag to reflect it
>> is more general and can support both FS and block devices. Both fuse
>> and block device daemons, nbd and tcmu-runner, have been tested to
>> confirm the more restrictive PF_MEMALLOC_NOIO also works for fuse.
>>
>> - Use CAP_SYS_RESOURCE instead of admin.
>>
>> V2:
>> - Use prctl instead of procfs.
>> - Add support for NOFS for fuse.
>> - Check permissions.
>>
>>
>>  include/uapi/linux/capability.h |  1 +
>>  include/uapi/linux/prctl.h      |  4 ++++
>>  kernel/sys.c                    | 26 ++++++++++++++++++++++++++
>>  3 files changed, 31 insertions(+)
>>
>> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capabi=
lity.h
>> index 240fdb9a60f6..272dc69fa080 100644
>> --- a/include/uapi/linux/capability.h
>> +++ b/include/uapi/linux/capability.h
>> @@ -301,6 +301,7 @@ struct vfs_ns_cap_data {
>>  /* Allow more than 64hz interrupts from the real-time clock */
>>  /* Override max number of consoles on console allocation */
>>  /* Override max number of keymaps */
>> +/* Control memory reclaim behavior */
>>
>>  #define CAP_SYS_RESOURCE     24
>>
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 7da1b37b27aa..07b4f8131e36 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -234,4 +234,8 @@ struct prctl_mm_map {
>>  #define PR_GET_TAGGED_ADDR_CTRL                56
>>  # define PR_TAGGED_ADDR_ENABLE         (1UL << 0)
>>
>> +/* Control reclaim behavior when allocating memory */
>> +#define PR_SET_IO_FLUSHER              57
>> +#define PR_GET_IO_FLUSHER              58
>> +
>>  #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index a611d1d58c7d..08c6b682fa99 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2486,6 +2486,32 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
>>                         return -EINVAL;
>>                 error =3D GET_TAGGED_ADDR_CTRL();
>>                 break;
>> +       case PR_SET_IO_FLUSHER:
>> +               if (!capable(CAP_SYS_RESOURCE))
>> +                       return -EPERM;
>> +
>> +               if (arg3 || arg4 || arg5)
>> +                       return -EINVAL;
>> +
>> +               if (arg2 =3D=3D 1)
>> +                       current->flags |=3D PF_MEMALLOC_NOIO | PF_LESS_T=
HROTTLE;
>> +               else if (!arg2)
>> +                       current->flags &=3D ~(PF_MEMALLOC_NOIO | PF_LESS=
_THROTTLE);
>> +               else
>> +                       return -EINVAL;
>> +               break;
>> +       case PR_GET_IO_FLUSHER:
>> +               if (!capable(CAP_SYS_RESOURCE))
>> +                       return -EPERM;
>> +
>> +               if (arg2 || arg3 || arg4 || arg5)
>> +                       return -EINVAL;
>> +
>> +               if (current->flags & (PF_MEMALLOC_NOIO | PF_LESS_THROTTL=
E))
>=20
> I think it needs to be conditioned on both flags instead of just one of
> them, for consistency with SET.  Seems worth a define too, PF_IO_FLUSHER?
> Or something local to this file at least.

Yeah, that was a mistake. Will fix.

>=20
>> +                       error =3D 1;
>> +               else
>> +                       error =3D 0;
>=20
>   error =3D (current->flags & PF_IO_FLUSHER) =3D=3D PF_IO_FLUSHER;
>=20
> Thanks,
>=20
>                 Ilya
>=20

