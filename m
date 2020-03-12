Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F9B182C3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLJTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 05:19:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLJTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584004784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cebT1xfNS3y+c47GKwv5O86T3MTCOvSqywcwIcOoei8=;
        b=i1qJa+hBxrVMwrL1wnN0Fr3MB3SmbmEsgIkyh1XEVtj5DOVlbMksgUe9NvoZMmNtAQZxoL
        acehMLc2VsM2IkQiLhNsjf/kA4DPYal4I+1Hz/bDdjpvq4/PFm/kb380fAfDtat4SPM1CV
        b63X9tLDbWZhaHnG32luLg+r+GIFGZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-F4ZQQTecNNiS7CP1ngpYwA-1; Thu, 12 Mar 2020 05:19:43 -0400
X-MC-Unique: F4ZQQTecNNiS7CP1ngpYwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF2D100550D;
        Thu, 12 Mar 2020 09:19:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D91A95D9C5;
        Thu, 12 Mar 2020 09:19:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     mbobrowski@mbobrowski.org
cc:     dhowells@redhat.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Is ext4_dio_read_iter() broken?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <969259.1584004779.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 12 Mar 2020 09:19:39 +0000
Message-ID: <969260.1584004779@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Is ext4_dio_read_iter() broken?  It calls:

	file_accessed(iocb->ki_filp);

at the end of the function - but surely iocb should be expected to have be=
en
freed when iocb->ki_complete() was called?

In my cachefiles rewrite, I'm seeing the attached kasan dump.  The offendi=
ng
RIP, ext4_file_read_iter+0x12b is at the above line, where it is trying to
read iocb->ki_filp.

Here's an excerpt of the relevant bits from my code:

	static void cachefiles_read_complete(struct kiocb *iocb, long ret, long r=
et2)
	{
		struct cachefiles_kiocb *ki =3D
			container_of(iocb, struct cachefiles_kiocb, iocb);
		struct fscache_io_request *req =3D ki->req;
	...
		fput(ki->iocb.ki_filp);
		kfree(ki);
		fscache_end_io_operation(req->cookie);
	...
	}

	int cachefiles_read(struct fscache_object *obj,
			    struct fscache_io_request *req,
			    struct iov_iter *iter)
	{
		struct cachefiles_object *object =3D
			container_of(obj, struct cachefiles_object, fscache);
		struct cachefiles_kiocb *ki;
		struct file *file =3D object->backing_file;
		ssize_t ret =3D -ENOBUFS;
	...
		ki =3D kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
		if (!ki)
			goto presubmission_error;

		ki->iocb.ki_filp	=3D get_file(file);
		ki->iocb.ki_pos		=3D req->pos;
		ki->iocb.ki_flags	=3D IOCB_DIRECT;
		ki->iocb.ki_hint	=3D ki_hint_validate(file_write_hint(file));
		ki->iocb.ki_ioprio	=3D get_current_ioprio();
		ki->req			=3D req;

		if (req->io_done)
			ki->iocb.ki_complete =3D cachefiles_read_complete;

		ret =3D rw_verify_area(READ, file, &ki->iocb.ki_pos, iov_iter_count(iter=
));
		if (ret < 0)
			goto presubmission_error_free;

		fscache_get_io_request(req);
		trace_cachefiles_read(object, file_inode(file), req);
		ret =3D call_read_iter(file, &ki->iocb, iter);
		...
	}

The allocation point, cachefiles_read+0xd0, is the kzalloc() you can see a=
nd
the free point, cachefiles_read_complete+0x86, is the kfree() in the callb=
ack
function.

Most of the time it works, but just occasionally the callback happens firs=
t.

David
---
EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: user_xatt=
r
FS-Cache: Cache "mycache" added (type cachefiles)
CacheFiles: File cache on sda3 registered
CacheFiles: Dirty object in cache
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in ext4_file_read_iter+0x12b/0x181
Read of size 8 at addr ffff8883577d7700 by task bash/5140

CPU: 0 PID: 5140 Comm: bash Not tainted 5.6.0-rc1-fscache+ #1285
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
Call Trace:
 dump_stack+0x97/0xd3
 print_address_description.constprop.0+0x1c/0x2b5
 ? ext4_file_read_iter+0x12b/0x181
 __kasan_report+0x144/0x189
 ? ext4_file_read_iter+0x12b/0x181
 kasan_report+0xe/0x12
 ext4_file_read_iter+0x12b/0x181
 cachefiles_read+0x381/0x459
 ? trace_event_raw_event_cachefiles_map+0x14d/0x14d
 fscache_read_helper+0x9a6/0xa5f
 ? fscache_read_helper_single+0x387/0x387
 ? kmem_cache_alloc_trace+0x13f/0x167
 ? test_bit+0x1d/0x27
 afs_prefetch_for_write+0x2d4/0x397
 ? afs_req_issue_op+0x9d/0x9d
 ? hlock_class+0x27/0x86
 ? mark_lock+0x97/0x2d5
 ? timestamp_truncate+0xda/0x175
 ? inode_init_owner+0x114/0x114
 afs_write_begin+0xc8/0x354
 generic_perform_write+0x154/0x29c
 ? filemap_range_has_page+0x171/0x171
 ? file_update_time+0x11e/0x1c0
 ? alloc_inode+0xbf/0xbf
 ? generic_write_checks+0x139/0x17c
 __generic_file_write_iter+0x16e/0x1c3
 generic_file_write_iter+0x62/0xc6
 afs_file_write+0xdc/0x125
 ? new_sync_write+0xfc/0x186
 new_sync_write+0x10c/0x186
 ? __lock_is_held+0x2a/0x87
 ? new_sync_read+0x17e/0x17e
 ? rcu_read_lock_any_held+0xa5/0xe8
 ? rcu_read_lock_sched_held+0xc5/0xc5
 ? vfs_write+0xd1/0x144
 ? rcu_sync_is_idle+0x46/0x4f
 ? __sb_start_write+0xc1/0x162
 ? vfs_write+0xd1/0x144
 vfs_write+0xef/0x144
 ksys_write+0xd2/0x147
 ? __ia32_sys_read+0x41/0x41
 ? get_vtime_delta+0x9c/0xaa
 ? mark_held_locks+0x1f/0x78
 do_syscall_64+0x6e/0x8a
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fe0ecdc0ff8
Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48=
 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
RSP: 002b:00007ffd5f2ca6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007fe0ecdc0ff8
RDX: 000000000000000b RSI: 0000564008fe1b30 RDI: 0000000000000001
RBP: 0000564008fe1b30 R08: 000000000000000a R09: 00007fe0ece52e80
R10: 000000000000000a R11: 0000000000000246 R12: 00007fe0ece94780
R13: 000000000000000b R14: 00007fe0ece8f740 R15: 000000000000000b

Allocated by task 5140:
 save_stack+0x1b/0x6a
 __kasan_kmalloc.constprop.0+0x84/0x95
 kmem_cache_alloc_trace+0x124/0x167
 cachefiles_read+0xd0/0x459
 fscache_read_helper+0x9a6/0xa5f
 afs_prefetch_for_write+0x2d4/0x397
 afs_write_begin+0xc8/0x354
 generic_perform_write+0x154/0x29c
 __generic_file_write_iter+0x16e/0x1c3
 generic_file_write_iter+0x62/0xc6
 afs_file_write+0xdc/0x125
 new_sync_write+0x10c/0x186
 vfs_write+0xef/0x144
 ksys_write+0xd2/0x147
 do_syscall_64+0x6e/0x8a
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 19100:
 save_stack+0x1b/0x6a
 __kasan_slab_free+0xd9/0xf9
 kfree+0x10d/0x140
 cachefiles_read_complete+0x86/0x111
 iomap_dio_bio_end_io+0x1b2/0x1e5
 blk_update_request+0x335/0x45b
 scsi_end_request+0x4f/0x27d
 scsi_io_completion+0x22e/0x5a7
 blk_done_softirq+0x142/0x17a
 __do_softirq+0x22b/0x492

The buggy address belongs to the object at ffff8883577d7700
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff8883577d7700, ffff8883577d7740)
The buggy address belongs to the page:
page:ffffea000d5df5c0 refcount:1 mapcount:0 mapping:ffff8883ce400380 index=
:0xffff8883577d7000
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea000d8cdd08 ffffea000dc0af88 ffff8883ce400380
raw: ffff8883577d7000 ffff8883577d7000 0000000100000013 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8883577d7600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8883577d7680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8883577d7700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff8883577d7780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8883577d7800: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Disabling lock debugging due to kernel taint
BUG: unable to handle page fault for address: 0000000100000058
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 =

Oops: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 5140 Comm: bash Tainted: G    B             5.6.0-rc1-fscache+=
 #1285
Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
RIP: 0010:touch_atime+0x82/0x137
Code: 00 00 48 89 44 24 58 31 c0 e8 8a bf fb ff 49 8d 7c 24 08 4d 8b 34 24=
 e8 7c bf fb ff 49 8b 5c 24 08 48 8d 7b 58 e8 6e bf fb ff <48> 8b 5b 58 4c=
 89 e7 48 89 de e8 b4 fd ff ff 84 c0 74 6e 4c 8d 63
RSP: 0018:ffff8883c8617800 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000100000000 RCX: ffffffff812f3d9f
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000100000058
RBP: ffff8883c8617880 R08: 0000000000000003 R09: 0000000000000001
R10: fffffbfff05f7dc5 R11: 0000000000000000 R12: ffff8883679d5010
R13: 1ffff110790c2f00 R14: 0000100000000000 R15: ffff8883577d7720
FS:  00007fe0eccd0740(0000) GS:ffff8883d0200000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000058 CR3: 000000037201c002 CR4: 00000000001606f0
Call Trace:
 ? atime_needs_update+0x1bb/0x1bb
 ? __kasan_report+0x169/0x189
 ? ext4_file_read_iter+0x12b/0x181
 ext4_file_read_iter+0x147/0x181
 cachefiles_read+0x381/0x459
 ? trace_event_raw_event_cachefiles_map+0x14d/0x14d
 fscache_read_helper+0x9a6/0xa5f
 ? fscache_read_helper_single+0x387/0x387
 ? kmem_cache_alloc_trace+0x13f/0x167
 ? test_bit+0x1d/0x27
 afs_prefetch_for_write+0x2d4/0x397
 ? afs_req_issue_op+0x9d/0x9d
 ? hlock_class+0x27/0x86
 ? mark_lock+0x97/0x2d5
 ? timestamp_truncate+0xda/0x175
 ? inode_init_owner+0x114/0x114
 afs_write_begin+0xc8/0x354
 generic_perform_write+0x154/0x29c
 ? filemap_range_has_page+0x171/0x171
 ? file_update_time+0x11e/0x1c0
 ? alloc_inode+0xbf/0xbf
 ? generic_write_checks+0x139/0x17c
 __generic_file_write_iter+0x16e/0x1c3
 generic_file_write_iter+0x62/0xc6
 afs_file_write+0xdc/0x125
 ? new_sync_write+0xfc/0x186
 new_sync_write+0x10c/0x186
 ? __lock_is_held+0x2a/0x87
 ? new_sync_read+0x17e/0x17e
 ? rcu_read_lock_any_held+0xa5/0xe8
 ? rcu_read_lock_sched_held+0xc5/0xc5
 ? vfs_write+0xd1/0x144
 ? rcu_sync_is_idle+0x46/0x4f
 ? __sb_start_write+0xc1/0x162
 ? vfs_write+0xd1/0x144
 vfs_write+0xef/0x144
 ksys_write+0xd2/0x147
 ? __ia32_sys_read+0x41/0x41
 ? get_vtime_delta+0x9c/0xaa
 ? mark_held_locks+0x1f/0x78
 do_syscall_64+0x6e/0x8a
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fe0ecdc0ff8
Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48=
 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
RSP: 002b:00007ffd5f2ca6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007fe0ecdc0ff8
RDX: 000000000000000b RSI: 0000564008fe1b30 RDI: 0000000000000001
RBP: 0000564008fe1b30 R08: 000000000000000a R09: 00007fe0ece52e80
R10: 000000000000000a R11: 0000000000000246 R12: 00007fe0ece94780
R13: 000000000000000b R14: 00007fe0ece8f740 R15: 000000000000000b
Modules linked in:
CR2: 0000000100000058
---[ end trace 051c3ce276c972cc ]---
RIP: 0010:touch_atime+0x82/0x137
Code: 00 00 48 89 44 24 58 31 c0 e8 8a bf fb ff 49 8d 7c 24 08 4d 8b 34 24=
 e8 7c bf fb ff 49 8b 5c 24 08 48 8d 7b 58 e8 6e bf fb ff <48> 8b 5b 58 4c=
 89 e7 48 89 de e8 b4 fd ff ff 84 c0 74 6e 4c 8d 63
RSP: 0018:ffff8883c8617800 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000100000000 RCX: ffffffff812f3d9f
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000100000058
RBP: ffff8883c8617880 R08: 0000000000000003 R09: 0000000000000001
R10: fffffbfff05f7dc5 R11: 0000000000000000 R12: ffff8883679d5010
R13: 1ffff110790c2f00 R14: 0000100000000000 R15: ffff8883577d7720
FS:  00007fe0eccd0740(0000) GS:ffff8883d0200000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000100000058 CR3: 000000037201c002 CR4: 00000000001606f0

