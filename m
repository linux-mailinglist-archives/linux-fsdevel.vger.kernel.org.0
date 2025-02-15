Return-Path: <linux-fsdevel+bounces-41773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C368A36D1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 10:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B4A168026
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12261A08AF;
	Sat, 15 Feb 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b9GFdi0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792819E994;
	Sat, 15 Feb 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612944; cv=none; b=kBiBSSjUSOdUluKX1/pRrdhDh4mLOgha7l/JxzFswZ6WZsCg5XeG4wig8PcI43y3pzncHA3IWtmEVyYpFLhgRxUu4Y5P2WNWY5Dk0jCjzHQCMtfZIemcmZCO3n0wBOGvRXcL7dLWh4uFZLOTNUCCQYUgW0+6Pep6qACHsMVl/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612944; c=relaxed/simple;
	bh=cxIcYvYbN420hPxCQbul/gDIJI7OOe0kWWX3eO1us80=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LBGxqYzL1gHmFvyFCC2k+Otd/rvljHLNFmdZVYDWrGh3SDbbRhyEXyoz/qgchqTYuk7gNXbhoJjaGvQtDi7SZ4JNsKTwkGnZeG/ExslfO6/4+bC9Pe78I7K/8wJCXHs3pJTVhHV+DQA1OUmt7HTKWPvSaZVD+EoQLay+GbZNAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b9GFdi0D; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739612935; bh=j+lzSf6hELg3pWvNzrH7DjLjZY0p3smjmjuuq5jxhFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b9GFdi0DbR+Q/mQK6pnWwtPWp6t85+USD6ipC4Qoj5T/LlyKi/phGQzOFe1agwX4T
	 D9h3C49XejIGLTglA/1ACkY81M94jiysx/zAcaw4BPOJDQ4hdJXyEEbnIcdB8keSPK
	 ThEDn1fuFQWyWeYY5oeblXFits7+zcOZbmKFDrfU=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id A9FB68C3; Sat, 15 Feb 2025 17:42:31 +0800
X-QQ-mid: xmsmtpt1739612551ts3nrljyw
Message-ID: <tencent_9A6EC28CB2A7D206CA92E6066E098A2ED106@qq.com>
X-QQ-XMAILINFO: MvM61XSVXCtDXgLvihEWjeBEmS51vxJOHY9Ne+JQEQ+1mbiipicGcDrQQS4QqQ
	 HNSrFcLw4TMlPzHIxNhNRTXNjxN4eYCThyiGJgoXzQ9AL5jBkAax7xiFVtFK/BTNmuB/dmXZ4Nak
	 Cx7Ba9/Hzi0Vs5rdTh+iCXB8xBhQU/VrNKrSgLn8caiMrdIrhjkZmPu0w3tcQDpTEalV+HPZaIBM
	 pS8gL5+LmbevYcQARzS7YzKwe2VldMwWAp6RwO8PPWs+KA01DgJrw/uEioMj2ONjeOzZ14XVcfGr
	 1ONzL4BPsk5zEF9QK/JjwuWf8Yx8x738rQzJncxCkxSaccS43J1eXRgAKS5ZqLw17FQHyFyLA1yc
	 UZ87WBrXA+fK8nRpClfSySOeHKQabzDI3cA2TOrZSb5OohTISIEWWySfEyVr0toiX0rlfsqf9ck3
	 FybtM0VX+jmOv0DRvbmNrfDSdI2Gq00UmUSdjbB+YAu6027gpHsFy5ScNAkADNEmmrs64JAkB1c1
	 MYxjiOxzlD/7sA2XBF5wzirqqtp0X0vM4B4LLZVdH7h0flcyIb+tzTpGkquOysF8kaZmVFYx29WF
	 3+hWJ5t4tbZYr7hpXvUdtaQKv5BYimd1X9AQmQdVcriLaGKfz9n4zBxmgrenOJNGpmVdixp7nEUT
	 m4tWpuRRZddjjQpqd2B7/JWbaPIaeM/JBT8h7NYIPSQil/USSuH7B3pZmHzTk+Jzv0zbp9/RRs33
	 5dsIQHVOTE3nSTrjfUDBuY0vCRzUHmWavXwjmZ76KseXR2tpFv+06r9fcqE+eMrv+oMHE1cEJTdL
	 rerHPFsKUytAmkb0sLfVYmfG3zI4+zXkO+aEIrUB0TftMlX3E8ZmujWJJulQlZ/L+lINmjoPnEsT
	 wdeTuLlqVWLvH6IrXoG3gYFjbujWTVBPvXBMB80ipcCWz0gdrRSgQDDDt0UoAuKw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] netfs: Prevent race conditions between aio read and read collection worker
Date: Sat, 15 Feb 2025 17:42:32 +0800
X-OQ-MSGID: <20250215094231.1510604-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67aedac7.050a0220.21dd3.002d.GAE@google.com>
References: <67aedac7.050a0220.21dd3.002d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a slab-use-after-free Write in io_submit_one. [1]

netfs_read_collection() can be reached by two paths: netfs read collection
worker and aio read.
In aio_get_req(), ki_refcnt is set to 2.

                CPU1                                     CPU2
	   ==============                          ==================
	   io_submit_one
	   ->io_get_req
	   ->__io_submit_one
	   -->aio_read
	   -->v9fs_file_read_iter
	   -->netfs_unbuffered_read_iter
	   -->netfs_unbuffered_read                process_one_work
	   -->netfs_dispatch_unbuffered_reads      netfs_read_collection_worker
	   -->netfs_wait_for_pause                 netfs_read_collection
	   -->netfs_read_collection                netfs_rreq_assess_dio
	   -->netfs_rreq_assess_dio                aio_complete_rw
	   -->aio_complete_rw                      iocb_put
	   -->iocb_put
	   ->iocb_put

The netfs read collection worker calls ki_complete() once, plus aio_read calls
ki_complete() once, causing iocb to be released before iocb_put is executed
in io_submit_one(), which triggers [1].

The aio read and netfs read collection worker are synchronized by locking
"rreq->lock" in netfs_rreq_assess_dio(), and iocb is set to NULL to prevent
ki_complete from being executed repeatedly by aio_read and worker.

[2] This is also caused by the race condition between aio_read and netfs
read collection worker mentioned above. We deal with it here by expanding
the lock range of "rreq->lock" for both to ensure that stream->front will
not be modified by the other party before the remove is executed.

[1]
BUG: KASAN: slab-use-after-free in io_submit_one+0x4e5/0x1da0 fs/aio.c:2055
Write of size 4 at addr ffff8880317b3b08 by task syz-executor210/6000

CPU: 3 UID: 0 PID: 6000 Comm: syz-executor210 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:264 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 iocb_put fs/aio.c:1208 [inline]
 io_submit_one+0x4e5/0x1da0 fs/aio.c:2055
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9104587229
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9104537168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f910460b408 RCX: 00007f9104587229
RDX: 00004000000002c0 RSI: 0000000000000001 RDI: 00007f9104516000
RBP: 00007f910460b400 R08: 00007f91045376c0 R09: 0000000000000000
R10: 00007f91045376c0 R11: 0000000000000246 R12: 00007f910460b40c
R13: 000000000000000b R14: 00007fff6ba87360 R15: 00007fff6ba87448
 </TASK>

Allocated by task 6000:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x226/0x3d0 mm/slub.c:4171
 aio_get_req fs/aio.c:1058 [inline]
 io_submit_one+0x123/0x1da0 fs/aio.c:2048
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6000:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x2e2/0x4d0 mm/slub.c:4711
 iocb_destroy fs/aio.c:1110 [inline]
 iocb_put fs/aio.c:1210 [inline]
 iocb_put fs/aio.c:1206 [inline]
 aio_complete_rw+0x3ec/0x7b0 fs/aio.c:1507
 netfs_rreq_assess_dio fs/netfs/read_collect.c:375 [inline]
 netfs_read_collection+0x30ae/0x3cb0 fs/netfs/read_collect.c:438
 netfs_wait_for_pause+0x31c/0x3e0 fs/netfs/read_collect.c:689
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:106 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:144 [inline]
 netfs_unbuffered_read_iter_locked+0xb50/0x1610 fs/netfs/direct_read.c:229
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:264
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 aio_read+0x313/0x4e0 fs/aio.c:1602
 __io_submit_one fs/aio.c:2003 [inline]
 io_submit_one+0x1580/0x1da0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[2]
WARNING: CPU: 1 PID: 81 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 81 Comm: kworker/u32:4 Not tainted 6.14.0-rc2-syzkaller-g78a632a2086c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_read_collection_worker
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 c8 5a f5 fc 84 db 0f 85 66 ff ff ff e8 1b 60 f5 fc c6 05 d7 5c 86 0b 01 90 48 c7 c7 c0 00 d3 8b e8 77 99 b5 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 f8 5f f5 fc 0f b6 1d b2 5c 86 0b 31
RSP: 0018:ffffc9000162fab8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a1229
RDX: ffff888020af2440 RSI: ffffffff817a1236 RDI: 0000000000000001
RBP: ffff8880305354a0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000005
R13: 00000000000006ed R14: 0000000000000001 R15: ffff8880305354a0
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7675a2f98 CR3: 000000000df80000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 netfs_put_subrequest+0x2c1/0x4d0 fs/netfs/objects.c:230
 netfs_collect_read_results fs/netfs/read_collect.c:300 [inline]
 netfs_read_collection+0x25af/0x3d00 fs/netfs/read_collect.c:422
 netfs_read_collection_worker+0x285/0x350 fs/netfs/read_collect.c:469
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
Tested-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/netfs/read_collect.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index f65affa5a9e4..6f3c0404f4b8 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -207,6 +207,7 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 	 * in progress.  The issuer thread may be adding stuff to the tail
 	 * whilst we're doing this.
 	 */
+	spin_lock(&rreq->lock);
 	front = READ_ONCE(stream->front);
 	while (front) {
 		size_t transferred;
@@ -288,7 +289,6 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 
 		/* Remove if completely consumed. */
 		stream->source = front->source;
-		spin_lock(&rreq->lock);
 
 		remove = front;
 		trace_netfs_sreq(front, netfs_sreq_trace_discard);
@@ -296,12 +296,12 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 		front = list_first_entry_or_null(&stream->subrequests,
 						 struct netfs_io_subrequest, rreq_link);
 		stream->front = front;
-		spin_unlock(&rreq->lock);
 		netfs_put_subrequest(remove, false,
 				     notes & ABANDON_SREQ ?
 				     netfs_sreq_trace_put_abandon :
 				     netfs_sreq_trace_put_done);
 	}
+	spin_unlock(&rreq->lock);
 
 	trace_netfs_collect_stream(rreq, stream);
 	trace_netfs_collect_state(rreq, rreq->collected_to, notes);
@@ -369,12 +369,17 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		}
 	}
 
+	spin_lock(&rreq->lock);
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+			rreq->iocb = NULL;
+		}
 	}
+	spin_unlock(&rreq->lock);
+
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
 	if (rreq->origin == NETFS_DIO_READ)
-- 
2.43.0


