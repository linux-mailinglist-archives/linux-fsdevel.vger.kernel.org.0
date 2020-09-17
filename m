Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE18526E2B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIQRnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbgIQRnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600364570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgqzC2uP//BIVKZcw7lMl5RY0vMY3ovWMucpMupndP4=;
        b=ZQ2HXihuXTtgQNIIpkGc6fbfTyx6/wYCYjrYzSBiwJS4yGQg52pNcx9+wnNSX9YJ78Kbgm
        VlkhAC0DfxR21YaDAtGy2zPMxtBHm7uoBU7hhLWb8I/Lhq6O4v/4xVVKiSOmySqux2rvE+
        Nk0HAZOpnoxIe7fUAt/8x5zp10VMd9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-4LgNS7NSOkOv1deXlcSG1Q-1; Thu, 17 Sep 2020 13:42:47 -0400
X-MC-Unique: 4LgNS7NSOkOv1deXlcSG1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B2C100A615;
        Thu, 17 Sep 2020 17:42:45 +0000 (UTC)
Received: from ovpn-66-148.rdu2.redhat.com (ovpn-66-148.rdu2.redhat.com [10.10.66.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75E45D9CC;
        Thu, 17 Sep 2020 17:42:44 +0000 (UTC)
Message-ID: <c68eb9de3579cb56b8c6559a1e610ade631a9d60.camel@redhat.com>
Subject: Re: slab-out-of-bounds in iov_iter_revert()
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 13:42:44 -0400
In-Reply-To: <20200917164432.GU3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
         <20200911235511.GB3421308@ZenIV.linux.org.uk>
         <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
         <20200917020440.GQ3421308@ZenIV.linux.org.uk>
         <20200917021439.GA31009@ZenIV.linux.org.uk>
         <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
         <20200917164432.GU3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-17 at 17:44 +0100, Al Viro wrote:
> On Thu, Sep 17, 2020 at 10:10:27AM -0400, Qian Cai wrote:
> 
> > [   81.942909]  generic_file_read_iter+0x23b/0x4b0
> > [   81.942918]  fuse_file_read_iter+0x280/0x4e0 [fuse]
> > [   81.942931]  ? fuse_direct_IO+0xd30/0xd30 [fuse]
> > [   81.942949]  ? _raw_spin_lock_irqsave+0x80/0xe0
> > [   81.942957]  ? timerqueue_add+0x15e/0x280
> > [   81.942960]  ? _raw_spin_lock_irqsave+0x80/0xe0
> > [   81.942966]  new_sync_read+0x3b7/0x620
> > [   81.942968]  ? __ia32_sys_llseek+0x2e0/0x2e0
> 
> Interesting...  Basic logics in there:
> 	->direct_IO() might consume more (on iov_iter_get_pages()
> and friends) than it actually reads.  We want to revert the
> excess.  Suppose by the time we call ->direct_IO() we had
> N bytes already consumed and C bytes left.  We expect that
> after ->direct_IO() returns K, we have C' bytes left, N + (C - C')
> consumed and N + K out of those actually read.  So we revert by
> C - K - C'.  You end up trying to revert beyond the beginning.
> 
> 	Use of iov_iter_truncate() is problematic here, since it
> changes the amount of data left without having consumed anything.
> Basically, it changes the position of end, and the logics in the
> caller expects that to remain unchanged.  iov_iter_reexpand() use
> should restore the position of end.
> 
> 	How much IO does it take to trigger that on your reproducer?

That is something I don't know for sure because it is always reproducible by
running the trinity fuzzer for a few seconds (32 threads). I did another run
below (still with your patch applied) and then tried to capture some logs here:

http://people.redhat.com/qcai/iov_iter_revert/

- virtiofsd.txt: fuse server side log until it triggered.
- trinity-post-mortem.log: AFAICT, it was the final syscall of each child.
- trinity-child9.log: the child actually triggered it.

The last syscall of child9 is:
pwritev2(fd=230, vec=0x293d3f0, vlen=1, pos_l=120, pos_h=0x200000, flags=0x3)

[   77.125816] BUG: KASAN: stack-out-of-bounds in iov_iter_revert+0x693/0x8c0
[   77.127079] Read of size 8 at addr ffff8886efd5fda8 by task trinity-c9/1593
[   77.128292] 
[   77.128581] CPU: 10 PID: 1593 Comm: trinity-c9 Not tainted 5.9.0-rc5-iter+ #2
[   77.129798] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[   77.131175] Call Trace:
[   77.131934]  dump_stack+0x7c/0xb0
[   77.132500]  ? iov_iter_revert+0x693/0x8c0
[   77.133254]  print_address_description.constprop.7+0x1e/0x230
[   77.134287]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[   77.135103]  ? _raw_write_lock_irqsave+0xe0/0xe0
[   77.135933]  ? iov_iter_revert+0x693/0x8c0
[   77.136651]  ? iov_iter_revert+0x693/0x8c0
[   77.137345]  kasan_report.cold.9+0x37/0x7c
[   77.138033]  ? iov_iter_revert+0x693/0x8c0
[   77.138768]  iov_iter_revert+0x693/0x8c0
[   77.139433]  ? dentry_needs_remove_privs.part.30+0x40/0x40
[   77.140684]  ? generic_write_checks+0x1d2/0x3d0
[   77.141477]  generic_file_direct_write+0x2ed/0x430
[   77.142601]  fuse_file_write_iter+0x5d8/0xb10 [fuse]
[   77.143857]  ? fuse_perform_write+0xed0/0xed0 [fuse]
[   77.145062]  do_iter_readv_writev+0x3a6/0x700
[   77.146071]  ? no_seek_end_llseek_size+0x20/0x20
[   77.146568] kexec-bzImage64: File is too short to be a bzImage
[   77.147277]  do_iter_write+0x12f/0x5f0
[   77.149501]  ? timerqueue_add+0x15e/0x280
[   77.150187]  vfs_writev+0x172/0x2d0
[   77.150837]  ? vfs_iter_write+0xc0/0xc0
[   77.151493]  ? hrtimer_start_range_ns+0x495/0x900
[   77.152316]  ? hrtimer_run_softirq+0x210/0x210
[   77.153087]  ? _raw_spin_lock_irq+0x7b/0xd0
[   77.153842]  ? _raw_write_unlock_irqrestore+0x50/0x50
[   77.154733]  ? do_setitimer+0x2e5/0x590
[   77.155393]  ? alarm_setitimer+0xa0/0x110
[   77.156059]  do_pwritev+0x151/0x200
[   77.156657]  ? __ia32_sys_writev+0xb0/0xb0
[   77.157336]  do_syscall_64+0x33/0x40
[   77.157928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   77.158762] RIP: 0033:0x7fb8beed278d
[   77.159316] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 08
[   77.162391] RSP: 002b:00007ffcc8dcabc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
[   77.163672] RAX: ffffffffffffffda RBX: 0000000000000148 RCX: 00007fb8beed278d
[   77.164921] RDX: 0000000000000001 RSI: 000000000293d3f0 RDI: 00000000000000e6
[   77.166115] RBP: 0000000000000148 R08: 0000000000200000 R09: 0000000000000003
[   77.167315] R10: 0000000000000078 R11: 0000000000000246 R12: 0000000000000002
[   77.168494] R13: 00007fb8bf57c058 R14: 00007fb8bf5c26c0 R15: 00007fb8bf57c000
[   77.169656] 
[   77.169914] The buggy address belongs to the page:
[   77.170723] page:000000006280f5ba refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6efd5f
[   77.172271] flags: 0x17ffffc0000000()
[   77.172906] raw: 0017ffffc0000000 0000000000000000 ffffea001bb87308 0000000000000000
[   77.174299] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   77.175651] page dumped because: kasan: bad access detected
[   77.176583] 
[   77.176848] addr ffff8886efd5fda8 is located in stack of task trinity-c9/1593 at offset 184 in frame:
[   77.178352]  vfs_writev+0x0/0x2d0
[   77.178924] 
[   77.179158] this frame has 3 objects:
[   77.179823]  [32, 40) 'iov'
[   77.179824]  [96, 136) 'iter'
[   77.180269]  [192, 320) 'iovstack'
[   77.180788] 
[   77.181768] Memory state around the buggy address:
[   77.182927]  ffff8886efd5fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
[   77.184704]  ffff8886efd5fd00: f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 f2
[   77.186457] >ffff8886efd5fd80: f2 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00 00
[   77.188214]                                   ^
[   77.189388]  ffff8886efd5fe00: 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00
[   77.191019]  ffff8886efd5fe80: 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 00 00
[   77.192846] ==================================================================
[   77.194428] Disabling lock debugging due to kernel taint

