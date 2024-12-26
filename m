Return-Path: <linux-fsdevel+bounces-38134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1839FC80D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 06:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CF51882D4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 05:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5F14C5B3;
	Thu, 26 Dec 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="MX25MOXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33B22615;
	Thu, 26 Dec 2024 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189688; cv=none; b=NKGJcHYMzOwVszrDik6+6wKVL7JKxzvwIzPCYf4xijQgL/BryJJoaZ6f4Hml16+Kfo2N9x99aKkdylIF17uP8tl+rXdCtNDywVb3uk7UWHv/Sn2nVgxX1UKqa/LE1HTyRBwUfwPkBrADpCiuMWxXSNS2usJd3fof67vhd0DxRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189688; c=relaxed/simple;
	bh=5EUaAckvARDDWrmteBmnN3IIE7Bx2Qz3A8pqvJO6mPM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=kzrZ0K/plPsN2bULM399fnEKrftd8EtDJ64wFOVoHeoms/4cO2wnoqrXZHCqNZeRRIjth0zbK5NTnVeh6XNjIaMvip4Ub403yCctlX/ZWMtEkkl/KWH29kBsolnxAP27bJI4EXjohRas26NOFzdvCZ/ET+7Wd3n2uBD02djth9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=MX25MOXO; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1735189647;
	bh=5EUaAckvARDDWrmteBmnN3IIE7Bx2Qz3A8pqvJO6mPM=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=MX25MOXOBxyvAhLfRP/qcT91QVW8CuLZ857tcfieG5QswHT1Xrn7redLVkMMEJWyR
	 57IhGhjwl8LZ4Sttecw2P+Uj1Z89BoKWWLMFrfo3XzWGf72hrBlZU1AUsVTpl1SNf9
	 m//7am0TwWGC0ZasEAsHOK3IoPWkLMgqkWvYtWFo=
X-QQ-mid: bizesmtpip2t1735189640t1oqjlz
X-QQ-Originating-IP: ebKYFgrpDKhbCVgmE/PH/5yE0Ovfo1woJOSOrBjBpQY=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Dec 2024 13:07:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4293687976867961101
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Bug: slab-out-of-bounds Read in isolate_migratepages_block
Message-Id: <459D284B-D291-46DF-9984-604BA4733B1A@m.fudan.edu.cn>
Date: Thu, 26 Dec 2024 13:07:08 +0800
Cc: linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org
To: akpm@linux-foundation.org,
 willy@infradead.org
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MNQjv1tu7dtWAVboe8k9P5C32SWCHVDoQEux+rhh2ZpTRByWhZ0XtUag
	SvguCm8A8yibZCXcpg18ki6q7NGDAf5c+Siq5UMPiKum2Ti0Tsmoo+8l0iJtEvjv/iwYfyR
	ngHJh4QjDijqQahnnFHJVALFmk9sdJv7oA5+C3mq9Ra8A1qHR3W87S9deVvL/c+8X2T+ZaG
	ZxGb4ARc09haNFUi5YeXhooK4c4G5+c1mNXMJh1qPasE8LgyC8SPKLXyKa2/zFT+clEzCM3
	zGY3wscXnPbeGLbxhZuMhBpZ5Ghhg0SKTSjtlKKZRkweDl0R/ZVwe1anNl2KT/SJHdJJhdo
	M/Qfabzo24Rih79nz2ZdFZCwKIrdr2O2I36dv3ZvjaIjU59nrM+pugf/oqjO1v7I0oVFQFm
	KBJl0kMx/aexAxNCx+LeR2Adxq2ApZ0j8yS3tHWgZPfqZ0qouoA6lasXsNYMSXwp1GzFhxO
	VjP0ScbRSNMIx73bG5jJdGEWc9120ogexg54Bn5PTWHzrCFiQtdkpsalpb98bxhLI3DNeD8
	+dPzwUdIlNeyuUMyBbUxHQz3lFZBepqvcu8jUiNV2XyE1TrZuYF/0aMqfYRlyUSNnWFI5+D
	KecuhxTkEdec5NpqWLUyYf458OfnwUPTURvBsT4TL49SCXynvnNJT58dazk7UYn5oiMt4K2
	JGO0Qp9eTp/djXjEzfGv9et6LECsoIwAZxidk2jEY72mV2kALp7DU/+SW6TrGO+5lvHAUgQ
	VZ9LAp+wJ30OQsMidWZij/NSpKZyoX71P3U/4nRfeAt1dtPztIN3AlTKYwrmzkG4BA6nx/7
	28UEdyMoWAuihVV3Y1T2URokcL+e5/qUp0M9MdYXD0AyNkSq6Q/KB9DqcCIoh52MfsCFU6R
	Xy/9ZWQlCRvC92D6KA9AnifMwGwaNcp4mtfhVf7wQEi+DKF1JbRcVgLStfXmpx5DPtzOMBK
	iNO/pBUzXFtjfVXrxYnqIscDR
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hello,

When using fuzzer tool to fuzz the latest Linux kernel, the following =
crash
was triggered.

HEAD commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
git tree: upstream
Console output: =
https://drive.google.com/file/d/1pviuAgkWIVfra8dE2JLEcnUhHX3_inDL/view?usp=
=3Dsharing
Kernel config: =
https://drive.google.com/file/d/1RhT5dFTs6Vx1U71PbpenN7TPtnPoa3NI/view?usp=
=3Dsharing
C reproducer: /
Syzlang reproducer: /

Unfortunately, we're getting a stable reproduction of the program. If =
you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read =
include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-out-of-bounds in _test_bit =
include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-out-of-bounds in mapping_inaccessible =
include/linux/pagemap.h:335 [inline]
BUG: KASAN: slab-out-of-bounds in =
isolate_migratepages_block+0x31dc/0x43c0 mm/compaction.c:1180
Read of size 8 at addr ff1100000750bea0 by task kcompactd0/48

CPU: 2 UID: 0 PID: 48 Comm: kcompactd0 Not tainted 6.13.0-rc3 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:94 [inline]
dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
print_address_description mm/kasan/report.c:378 [inline]
print_report+0xcf/0x5f0 mm/kasan/report.c:489
kasan_report+0x93/0xc0 mm/kasan/report.c:602
check_region_inline mm/kasan/generic.c:183 [inline]
kasan_check_range+0xf6/0x1b0 mm/kasan/generic.c:189
instrument_atomic_read include/linux/instrumented.h:68 [inline]
_test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 =
[inline]
mapping_inaccessible include/linux/pagemap.h:335 [inline]
isolate_migratepages_block+0x31dc/0x43c0 mm/compaction.c:1180
isolate_migratepages mm/compaction.c:2164 [inline]
compact_zone+0x1987/0x3ee0 mm/compaction.c:2611
compact_node+0x19c/0x2d0 mm/compaction.c:2910
kcompactd+0x3ca/0xa00 mm/compaction.c:3208
kthread+0x345/0x450 kernel/kthread.c:389
ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
</TASK>

Allocated by task 469:
kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
kasan_kmalloc include/linux/kasan.h:260 [inline]
__do_kmalloc_node mm/slub.c:4298 [inline]
__kmalloc_node_track_caller_noprof+0x1ef/0x560 mm/slub.c:4317
kmalloc_reserve+0xeb/0x2b0 net/core/skbuff.c:609
__alloc_skb+0x162/0x370 net/core/skbuff.c:678
alloc_skb include/linux/skbuff.h:1323 [inline]
nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
nsim_dev_trap_report_work+0x358/0xd20 drivers/net/netdevsim/dev.c:851
process_one_work kernel/workqueue.c:3229 [inline]
process_scheduled_works+0x5ee/0x1ba0 kernel/workqueue.c:3310
worker_thread+0x59f/0xcf0 kernel/workqueue.c:3391
kthread+0x345/0x450 kernel/kthread.c:389
ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 469:
kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
kasan_save_free_info+0x3a/0x60 mm/kasan/generic.c:582
poison_slab_object mm/kasan/common.c:247 [inline]
__kasan_slab_free+0x54/0x70 mm/kasan/common.c:264
kasan_slab_free include/linux/kasan.h:233 [inline]
slab_free_hook mm/slub.c:2353 [inline]
slab_free mm/slub.c:4613 [inline]
kfree+0x120/0x3e0 mm/slub.c:4761
skb_kfree_head net/core/skbuff.c:1086 [inline]
skb_free_head+0xe0/0x1d0 net/core/skbuff.c:1098
skb_release_data+0x782/0x900 net/core/skbuff.c:1125
skb_release_all+0x4e/0x60 net/core/skbuff.c:1190
__kfree_skb net/core/skbuff.c:1204 [inline]
consume_skb net/core/skbuff.c:1436 [inline]
consume_skb+0xf5/0x2c0 net/core/skbuff.c:1430
nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
nsim_dev_trap_report_work+0x263/0xd20 drivers/net/netdevsim/dev.c:851
process_one_work kernel/workqueue.c:3229 [inline]
process_scheduled_works+0x5ee/0x1ba0 kernel/workqueue.c:3310
worker_thread+0x59f/0xcf0 kernel/workqueue.c:3391
kthread+0x345/0x450 kernel/kthread.c:389
ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ff1100000750a000
which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3744 bytes to the right of
allocated 4096-byte region [ff1100000750a000, ff1100000750b000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 =
pfn:0x7508
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x100000000000040(head|node=3D0|zone=3D1)
page_type: f5(slab)
raw: 0100000000000040 ff1100000103d040 ffd400000026ea00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 0100000000000040 ff1100000103d040 ffd400000026ea00 =
dead000000000002
head: 0000000000000000 0000000000040004 00000001f5000000 =
0000000000000000
head: 0100000000000003 ffd40000001d4201 ffffffffffffffff =
0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff =
0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ff1100000750bd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ff1100000750be00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ff1100000750be80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ff1100000750bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ff1100000750bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oops: general protection fault, probably for non-canonical address =
0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 2 UID: 0 PID: 48 Comm: kcompactd0 Tainted: G B 6.13.0-rc3 #8
Tainted: [B]=3DBAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:move_to_new_folio+0x1a7/0x720 mm/migrate.c:1052
Code: 48 c1 ea 03 80 3c 02 00 0f 85 ea 03 00 00 49 8b 9d 18 01 00 00 48 =
b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 =
00 0f 85 d9 03 00 00 48 8b 5b 60 48 85 db 0f 84 e9 00 00
RSP: 0018:ffa00000003574f8 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff9a06ee21
RDX: 000000000000000c RSI: 0000000000000008 RDI: 0000000000000060
RBP: ffd4000000196bc0 R08: ff1100000750be98 R09: ffe21c0000ea17d5
R10: ffe21c0000ea17d4 R11: 0000000000000007 R12: ffd40000018435c0
R13: ff1100000750bd80 R14: 0000000000000000 R15: ffd4000000196bd8
FS: 0000000000000000(0000) GS:ff1100006a300000(0000) =
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffd86e5d80 CR3: 0000000037902004 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
<TASK>
migrate_folio_move mm/migrate.c:1368 [inline]
migrate_pages_batch+0x1861/0x2590 mm/migrate.c:1899
migrate_pages_sync+0x10d/0x8d0 mm/migrate.c:1965
migrate_pages+0x1988/0x2130 mm/migrate.c:2074
compact_zone+0x1bac/0x3ee0 mm/compaction.c:2641
compact_node+0x19c/0x2d0 mm/compaction.c:2910
kcompactd+0x3ca/0xa00 mm/compaction.c:3208
kthread+0x345/0x450 kernel/kthread.c:389
ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:move_to_new_folio+0x1a7/0x720 mm/migrate.c:1052
Code: 48 c1 ea 03 80 3c 02 00 0f 85 ea 03 00 00 49 8b 9d 18 01 00 00 48 =
b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 =
00 0f 85 d9 03 00 00 48 8b 5b 60 48 85 db 0f 84 e9 00 00
RSP: 0018:ffa00000003574f8 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff9a06ee21
RDX: 000000000000000c RSI: 0000000000000008 RDI: 0000000000000060
RBP: ffd4000000196bc0 R08: ff1100000750be98 R09: ffe21c0000ea17d5
R10: ffe21c0000ea17d4 R11: 0000000000000007 R12: ffd40000018435c0
R13: ff1100000750bd80 R14: 0000000000000000 R15: ffd4000000196bd8
FS: 0000000000000000(0000) GS:ff1100006a300000(0000) =
knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffd86e5d80 CR3: 0000000037902004 CR4: 0000000000771ef0
PKRU: 55555554
----------------
Code disassembly (best guess):
0: 48 c1 ea 03 shr $0x3,%rdx
4: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
8: 0f 85 ea 03 00 00 jne 0x3f8
e: 49 8b 9d 18 01 00 00 mov 0x118(%r13),%rbx
15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
1c: fc ff df
1f: 48 8d 7b 60 lea 0x60(%rbx),%rdi
23: 48 89 fa mov %rdi,%rdx
26: 48 c1 ea 03 shr $0x3,%rdx
* 2a: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1) <-- trapping instruction
2e: 0f 85 d9 03 00 00 jne 0x40d
34: 48 8b 5b 60 mov 0x60(%rbx),%rbx
38: 48 85 db test %rbx,%rbx
3b: 0f .byte 0xf
3c: 84 e9 test %ch,%cl


---------------
thanks,
Kun Hu=

