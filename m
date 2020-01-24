Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA077148BED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 17:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgAXQWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 11:22:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727233AbgAXQWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579882965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxZZMWVN9sCwtfhMOOkZma/glfhYI1JkiSjCb7Jkp9w=;
        b=U/xynMRKMq285Uw5IZng0OY1lZzUhgx9y3dxCf0Hmo/9stGLC+IUkmM98SEaw2Mhth1JyN
        wakncVuQaFOPzf16mkkqW2tH7fqkQlwghJxB4yc78cqdzWBWXJkB7zy0d85pbemDZsj3pl
        3Xo2gh5GwQXoKWr1rK2t5XZockWZZvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-egqxvG0NOou3RdXE19F3uA-1; Fri, 24 Jan 2020 11:22:41 -0500
X-MC-Unique: egqxvG0NOou3RdXE19F3uA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A91C90AFD5;
        Fri, 24 Jan 2020 16:22:37 +0000 (UTC)
Received: from [10.10.125.90] (ovpn-125-90.rdu2.redhat.com [10.10.125.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 896875C28D;
        Fri, 24 Jan 2020 16:22:34 +0000 (UTC)
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V4
To:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191112001900.9206-1-mchristi@redhat.com>
 <CALvZod47XyD2x8TuZcb9PgeVY14JBwNhsUpN3RAeAt+RJJC=hg@mail.gmail.com>
Cc:     linux-api@vger.kernel.org, idryomov@gmail.com,
        Michal Hocko <mhocko@kernel.org>, david@fromorbit.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com, Michal Hocko <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E2B19C9.6080907@redhat.com>
Date:   Fri, 24 Jan 2020 10:22:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CALvZod47XyD2x8TuZcb9PgeVY14JBwNhsUpN3RAeAt+RJJC=hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/05/2019 04:43 PM, Shakeel Butt wrote:
> On Mon, Nov 11, 2019 at 4:19 PM Mike Christie <mchristi@redhat.com> wrote:
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
>> network IO to a remote server. We are using XFS on top of the nbd device,
>> but it can happen with any FS or other modules layered on top of the nbd
>> device that can write out data to free memory.  Here a nbd daemon helper
>> thread, msgr-worker-1, is performing a write/sendmsg on a socket to execute
>> a request. This kicks off a reclaim operation which results in a WRITE to
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
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Tested-by: Masato Suzuki <masato.suzuki@wdc.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> 
> I suppose this patch should be routed through MM tree, so, CCing Andrew.
>

Andrew and other mm/storage developers,

Do I need to handle anything else for this patch, or are there any other
concerns? Is this maybe something we want to talk about at a quick LSF
session?

I have retested it with Linus's current tree. It still applies cleanly
(just some offsets), and fixes the problem described above we have been
hitting.

