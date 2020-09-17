Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F026DDF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgIQOUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 10:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727395AbgIQOMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600351922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR+OFEhqsq1gVLf6zpsYsKeQ3pVZfx+fnc/+TQD3mqQ=;
        b=Y2QC/AebUEzROk9TUqzPs4OGm5Tex/Q3B+5XeBtojz0PGut8c1typorDIiS4gO/S7uJmcx
        YwXTsLW2BmrL9wAWCaFscQMpPjnK4m8OuOHSHqf7nr8WQHIHeVqfxgDxa9bSatpWQbgeYy
        yxUZNFTxIryWsjmc3AXcAmclQoWSzAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-OpmtRC7gMS-SaPYfvGLN1A-1; Thu, 17 Sep 2020 10:10:30 -0400
X-MC-Unique: OpmtRC7gMS-SaPYfvGLN1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B3610BBED5;
        Thu, 17 Sep 2020 14:10:29 +0000 (UTC)
Received: from ovpn-66-148.rdu2.redhat.com (ovpn-66-148.rdu2.redhat.com [10.10.66.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 549DC78803;
        Thu, 17 Sep 2020 14:10:28 +0000 (UTC)
Message-ID: <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
Subject: Re: slab-out-of-bounds in iov_iter_revert()
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 10:10:27 -0400
In-Reply-To: <20200917021439.GA31009@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
         <20200911235511.GB3421308@ZenIV.linux.org.uk>
         <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
         <20200917020440.GQ3421308@ZenIV.linux.org.uk>
         <20200917021439.GA31009@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-17 at 03:14 +0100, Al Viro wrote:
> On Thu, Sep 17, 2020 at 03:04:40AM +0100, Al Viro wrote:
> > On Wed, Sep 16, 2020 at 05:09:49PM -0400, Qian Cai wrote:
> > > On Sat, 2020-09-12 at 00:55 +0100, Al Viro wrote:
> > > > On Fri, Sep 11, 2020 at 05:59:04PM -0400, Qian Cai wrote:
> > > > > Super easy to reproduce on today's mainline by just fuzzing for a few
> > > > > minutes
> > > > > on virtiofs (if it ever matters). Any thoughts?
> > > > 
> > > > Usually happens when ->direct_IO() fucks up and reports the wrong amount
> > > > of data written/read.  We had several bugs like that in the past - see
> > > > e.g. 85128b2be673 (fix nfs O_DIRECT advancing iov_iter too much).
> > > > 
> > > > Had there been any recent O_DIRECT-related patches on the filesystems
> > > > involved?
> > > 
> > > This is only reproducible using FUSE/virtiofs so far, so I will stare at
> > > fuse_direct_IO() until someone can beat me to it.
> > 
> > What happens there is that it tries to play with iov_iter_truncate() in
> > ->direct_IO() without a corresponding iov_iter_reexpand().  Could you
> > check if the following helps?
> 
> Gyah...  Sorry, that should be
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This is now triggering:

[   81.942804] WARNING: CPU: 24 PID: 1545 at lib/iov_iter.c:1084 iov_iter_revert+0x245/0x8c0
[   81.942805] Modules linked in: af_key mpls_router ip_tunnel hidp cmtp kernelcapi bnep rfcomm bluetooth ecdh_generic ecc can_bcm can_raw can pptp gre l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppoe pppox ppp_generic slhc crypto_user ib_core nfnetlink scsi_transport_iscsi atm sctp rfkill nls_utf8 isofs intel_rapl_msr intel_rapl_common sb_edac kvm_intel kvm bochs_drm drm_vram_helper irqbypass drm_ttm_helper ttm rapl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm i2c_piix4 joydev pcspkr vfat fat ip_tables xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg ata_generic crct10dif_pclmul crc32_pclmul crc32c_intel ata_piix virtiofs libata ghash_clmulni_intel fuse e1000 serio_raw sunrpc dm_mirror dm_region_hash dm_log dm_mod
[   81.942870] CPU: 24 PID: 1545 Comm: trinity-c0 Not tainted 5.9.0-rc5-iter+ #2
[   81.942871] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[   81.942879] RIP: 0010:iov_iter_revert+0x245/0x8c0
[   81.942882] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 ce 05 00 00 49 29 f5 48 89 6b 18 4c 89 6b 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b e9 3e ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 18 48
[   81.942884] RSP: 0018:ffff8886bf637b60 EFLAGS: 00010286
[   81.942886] RAX: 000000000000028b RBX: ffff8886bf637dc8 RCX: 1ffff110d7ec6faf
[   81.942888] RDX: dffffc0000000000 RSI: ffffffffbe4a754d RDI: ffff8886bf637d68
[   81.942889] RBP: ffff8886bf637d68 R08: 0000000000000004 R09: ffffed10d7ec6ee2
[   81.942890] R10: 0000000000000003 R11: ffffed10d7ec6ee2 R12: 0000000000000000
[   81.942891] R13: ffff8886eaa62d80 R14: ffff8886bf637dd0 R15: ffff8886bf637d78
[   81.942893] FS:  00007fc78f78d740(0000) GS:ffff8887d2000000(0000) knlGS:0000000000000000
[   81.942897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.942898] CR2: 0000000000000008 CR3: 00000007cadba005 CR4: 0000000000170ee0
[   81.942899] Call Trace:
[   81.942909]  generic_file_read_iter+0x23b/0x4b0
[   81.942918]  fuse_file_read_iter+0x280/0x4e0 [fuse]
[   81.942931]  ? fuse_direct_IO+0xd30/0xd30 [fuse]
[   81.942949]  ? _raw_spin_lock_irqsave+0x80/0xe0
[   81.942957]  ? timerqueue_add+0x15e/0x280
[   81.942960]  ? _raw_spin_lock_irqsave+0x80/0xe0
[   81.942966]  new_sync_read+0x3b7/0x620
[   81.942968]  ? __ia32_sys_llseek+0x2e0/0x2e0
[   81.942971] ==================================================================
[   81.942984] BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x693/0x8c0
[   81.942995]  ? hrtimer_start_range_ns+0x495/0x900
[   81.942997]  ? hrtimer_try_to_cancel+0x6d/0x330
[   81.943002] Read of size 8 at addr ffff88867e6a6ff8 by task trinity-c21/1600
[   81.943005]  ? hrtimer_forward+0x1b0/0x1b0

[   81.943026]  ? __fsnotify_update_child_dentry_flags.part.12+0x290/0x290
[   81.943030]  ? _cond_resched+0x15/0x30
[   81.943041]  ? __inode_security_revalidate+0x9d/0xc0
[   81.943047] CPU: 12 PID: 1600 Comm: trinity-c21 Not tainted 5.9.0-rc5-iter+ #2
[   81.943050] Hardware name: Red Hat KVM, BIOS 1.14.0-1.module+el8.3.0+7638+07cf13d2 04/01/2014
[   81.943053]  vfs_read+0x22b/0x460
[   81.943056]  ksys_read+0xe5/0x1b0
[   81.943058] Call Trace:
[   81.943061]  ? vfs_write+0x5e0/0x5e0
[   81.943069]  dump_stack+0x7c/0xb0
[   81.943074]  do_syscall_64+0x33/0x40
[   81.943077]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   81.943081] RIP: 0033:0x7fc78f09d78d
[   81.943084]  ? iov_iter_revert+0x693/0x8c0
[   81.943097]  print_address_description.constprop.7+0x1e/0x230
[   81.943100] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 01 48
[   81.943117]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[   81.943119] RSP: 002b:00007ffe01a9e168 EFLAGS: 00000246
[   81.943128]  ? _raw_write_lock_irqsave+0xe0/0xe0
[   81.943129]  ORIG_RAX: 0000000000000000
[   81.943133] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc78f09d78d
[   81.943136] RDX: 000000000000028b RSI: 00007fc78d282000 RDI: 00000000000000f2
[   81.943140]  ? iov_iter_revert+0x693/0x8c0
[   81.943142] RBP: 0000000000000000 R08: 19d504e75f9b0c9b R09: 00000000000000ff
[   81.943146]  ? iov_iter_revert+0x693/0x8c0
[   81.943148] R10: 00000000d9d9d9d9 R11: 0000000000000246 R12: 0000000000000002
[   81.943153]  kasan_report.cold.9+0x37/0x7c
[   81.943155] R13: 00007fc78f786058 R14: 00007fc78f78d6c0 R15: 00007fc78f786000
[   81.943158]  ? iov_iter_revert+0x693/0x8c0
[   81.943161]  iov_iter_revert+0x693/0x8c0
[   81.943163] ---[ end trace ee32e92b96589675 ]---
[   81.943172]  ? dentry_needs_remove_privs.part.30+0x40/0x40
[   81.943181]  ? generic_write_checks+0x1d2/0x3d0
[   81.943185]  generic_file_direct_write+0x2ed/0x430
[   81.943195]  fuse_file_write_iter+0x5d8/0xb10 [fuse]
[   81.943209]  ? fuse_perform_write+0xed0/0xed0 [fuse]
[   81.943215]  ? kasan_unpoison_shadow+0x30/0x40
[   81.943221]  do_iter_readv_writev+0x3a6/0x700
[   81.943224]  ? no_seek_end_llseek_size+0x20/0x20
[   81.943228]  do_iter_write+0x12f/0x5f0
[   81.943233]  ? timerqueue_add+0x15e/0x280
[   81.943236]  vfs_writev+0x172/0x2d0
[   81.943240]  ? vfs_iter_write+0xc0/0xc0
[   81.943245]  ? hrtimer_start_range_ns+0x495/0x900
[   81.943248]  ? hrtimer_run_softirq+0x210/0x210
[   81.943252]  ? _raw_spin_lock_irq+0x7b/0xd0
[   81.943256]  ? _raw_write_unlock_irqrestore+0x50/0x50
[   81.943269]  ? perf_syscall_enter+0x136/0x8a0
[   81.943276]  ? perf_call_bpf_enter.isra.21+0x1a0/0x1a0
[   81.943283]  ? alarm_setitimer+0xa0/0x110
[   81.943287]  do_pwritev+0x151/0x200
[   81.943291]  ? __ia32_sys_writev+0xb0/0xb0
[   81.943296]  do_syscall_64+0x33/0x40
[   81.943301]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   81.943306] RIP: 0033:0x7fc78f09d78d
[   81.943312] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cb 56 2c 00 f7 d8 64 89 01 48
[   81.943314] RSP: 002b:00007ffe01a9e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
[   81.943318] RAX: ffffffffffffffda RBX: 0000000000000148 RCX: 00007fc78f09d78d
[   81.943320] RDX: 000000000000004b RSI: 0000000001ae7790 RDI: 00000000000000f2
[   81.943323] RBP: 0000000000000148 R08: 0000000075f74000 R09: 0000000000000001
[   81.943325] R10: 00830624a1148006 R11: 0000000000000246 R12: 0000000000000002
[   81.943328] R13: 00007fc78f6f3058 R14: 00007fc78f78d6c0 R15: 00007fc78f6f3000

[   81.943333] Allocated by task 0:
[   81.943334] (stack is not available)

[   81.943339] The buggy address belongs to the object at ffff88867e6a6000
                which belongs to the cache kmalloc-2k of size 2048
[   81.943342] The buggy address is located 2040 bytes to the right of
                2048-byte region [ffff88867e6a6000, ffff88867e6a6800)
[   81.943344] The buggy address belongs to the page:
[   81.943350] page:000000007cdca305 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67e6a0
[   81.943354] head:000000007cdca305 order:3 compound_mapcount:0 compound_pincount:0
[   81.943358] flags: 0x17ffffc0010200(slab|head)
[   81.943365] raw: 0017ffffc0010200 dead000000000100 dead000000000122 ffff888107c4f0c0
[   81.943370] raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
[   81.943372] page dumped because: kasan: bad access detected

[   81.943374] Memory state around the buggy address:
[   81.943379]  ffff88867e6a6e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.943382]  ffff88867e6a6f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.943384] >ffff88867e6a6f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.943386]                                                                 ^
[   81.943388]  ffff88867e6a7000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   81.943400]  ffff88867e6a7080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   81.943402] ==================================================================
[   81.943403] Disabling lock debugging due to kernel taint

> ---
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6611ef3269a8..92de6b9b06b0 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3095,7 +3095,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  	loff_t pos = 0;
>  	struct inode *inode;
>  	loff_t i_size;
> -	size_t count = iov_iter_count(iter);
> +	size_t count = iov_iter_count(iter), shortened;
>  	loff_t offset = iocb->ki_pos;
>  	struct fuse_io_priv *io;
>  
> @@ -3111,7 +3111,8 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  		if (offset >= i_size)
>  			return 0;
>  		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
> -		count = iov_iter_count(iter);
> +		shortened = count - iov_iter_count(iter);
> +		count -= shortened;
>  	}
>  
>  	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
> @@ -3177,6 +3178,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  		else if (ret < 0 && offset + count > i_size)
>  			fuse_do_truncate(file);
>  	}
> +	iov_iter_reexpand(iter, iov_iter_count(iter) + shortened);
>  
>  	return ret;
>  }
> 

