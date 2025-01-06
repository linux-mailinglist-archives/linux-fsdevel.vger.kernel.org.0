Return-Path: <linux-fsdevel+bounces-38441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74031A02983
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57380163F88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBB1DB92A;
	Mon,  6 Jan 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="NW6q7gDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59960154C04;
	Mon,  6 Jan 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177046; cv=none; b=tzVfcVEE831eAtcfbnJRpVlK0pWL6CAL7sKINExt2854AmhQ/r6y4iuQ1fQGNkXpfRqVYuKnBTH5f8iCXXdoqge1g1dfcd6NzXBG/EQPVIFh4zzMnfYuVfv79VTIRt+JZAGhMM5ajb5pbWWvIr+Wjp9EgL3pJCBFpYC3rtvDABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177046; c=relaxed/simple;
	bh=fxSgDt60zcL+3CW55B4XYEg7wKyaL6BXeypntWdy/LY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=gBYEhOLux9SsEJhXzgETv5zj/Xsl/avrb1r0G59YKTr8UqpamEGax08dN/xB3X1khK3lgZ33MUxPG9qsnshnUI3RQDxtDb0SMtgMoIzjn74iwPlNyKqSS9o467ZCsAcMYQdUI+CKLtRlKEm+EbBoKEBxZwKNbs0R4IGkVI4cdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=NW6q7gDJ; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736177003;
	bh=Cq2xcaHLQKJAhuOpAKYTN4K/W80BTyI7yXAQLYQwLao=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=NW6q7gDJf4RrtwYefYWOjSJp320dpQ+8DRIulmnMn9ANNUHkkxwvMOtxPn2j+879b
	 wf+nTkphL0yIfNDFoMZ/kJ7cOutU5fsOdObAGTngzemghtEM0PHblnat0RWvm9IuIL
	 MGN7HDUMF/60vWglQ4Ed53ZsMvaY4IPeCYKHfBGU=
X-QQ-mid: bizesmtpip2t1736176997t8qjydv
X-QQ-Originating-IP: KTQ/epWGZ7j0mf57YCjXuLD8SbgBzF98muvREf+5Azg=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 23:23:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11619406230069990510
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Bug: slab-out-of-bounds Read in hfsplus_bnode_read
Message-Id: <9ABB0414-3FEF-476C-B2E8-00B6DC2685CC@m.fudan.edu.cn>
Date: Mon, 6 Jan 2025 23:23:05 +0800
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
To: akpm@linux-foundation.org,
 fmdefrancesco@gmail.com,
 ira.weiny@intel.com,
 slava@dubeyko.com
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OdhiZWMXRsv3dW7hTl2WfP7HIg3D3otre83on5p9JqSkjstU0GSzouRZ
	vORpkXy2FeoHvO85wl6uDGOprTZ4mtKvULFW/ELIavGZSUwOW76jHlj1pJfHta0DhYEq/KA
	C1cqzmopH260SMOutIIOpkAPVAFXNgR1W8lZHpgQG8PtJofAglTzjWo4U/m5BbfFO9CPixi
	/MhU3ZjFrvnTuG28ok450GnLoT+EcSLhYZUydylYgEWPS01ypegB8RRpDcUEtq5/zL5sTLj
	3K7TvceF5X4aHv45Rhf694zhFaOW1IRP+gBorQKpxkpbze9kaX13ztPiXKVoDFw5ko6eSRQ
	nuZY3fOjBKDMq9+RUnXPaBia0opIhp4jf3zB26HpeZa+jk8ano2qZvgkqHiJZpBz0ozU1ZF
	uRLYT3R5d1ADKX3FWqLE+1r1U5Gvzcw04rmYuMY+hz+2q//v9BGQdG68npCDLhPbE/qOOQG
	d7t8rcvd/JCKN5zYA8Mfm1+bVr5oZszBgsC4jQP8jVcnIIBzF5+s0z+zQUaM+sLKRY9kx6P
	oItwjYR6+6yAAKD+dI96mnnYojxAIs3HZ4tjZNzX0biloHvTIMQ76sU0b0zHH5OL9SHfST7
	bdOm8yO0FU7F2WFgPDxOu57SD1RMBGmbLGTyZAeIegckqzZYup+u+mipHVFmVkppZzYvNWC
	Ozc8QDsxVvL0Lt0nLVhOHNypnaQRxP/CebDp0ywixkrzNQV//0VoYW/KUo1Us22gAAtvBGj
	iAvUJDRWxlDoQF/lBouXWzmEdzPIfvPiIkyuX6tUMxwBxiGErcpCv6rl6xrkPh0zzdK04Qv
	e232AhzGFJr/InmaPa2/OQFkB2Pl7Z3xlOjdtLe8x5AvkRiJhsoiLA4UAsCPhO3rJtBpzji
	8xJabPQ1/a9nh0mTzwKTMM+8GVH34+AkGcTdlVu2AGma0gH4ZCnTDrooO2pCcJAZhXLJ2Ta
	wdnPDdhKMpUm2WEqoeEHIhjpHU1dNFegn4emSBjwdaTKRiTWbGyfWgSWy
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash
was triggered.

HEAD commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
git tree: upstream
Console output: =
https://drive.google.com/file/d/11umUDd-AW4Eoiwuv5-OZqJOiROjQR9uB/view?usp=
=3Dsharing
Kernel config: =
https://drive.google.com/file/d/1RhT5dFTs6Vx1U71PbpenN7TPtnPoa3NI/view?usp=
=3Dsharing
C reproducer: =
https://drive.google.com/file/d/1imunz7iet5HWcByt1zPKMzSD2fy8lWK6/view?usp=
=3Dsharing
Syzlang reproducer: =
https://drive.google.com/file/d/1jxwxWRJ78vUQ_HNKPw_Dy1SMge0ZXM0g/view?usp=
=3Dsharing


This bug seems to have been reported and fixed in the old kernel, which =
seems to be a regression issue? If you fix this issue, please add the =
following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>

hfsplus: request for non-existent node 67108864 in B*Tree
hfsplus: request for non-existent node 67108864 in B*Tree
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x31d/0x380 =
fs/hfsplus/bnode.c:32
Read of size 8 at addr ff11000007a625c0 by task syz-executor633/418

CPU: 1 UID: 0 PID: 418 Comm: syz-executor633 Not tainted 6.13.0-rc3 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcf/0x5f0 mm/kasan/report.c:489
 kasan_report+0x93/0xc0 mm/kasan/report.c:602
 hfsplus_bnode_read+0x31d/0x380 fs/hfsplus/bnode.c:32
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
 hfsplus_bnode_dump+0x2c7/0x3a0 fs/hfsplus/bnode.c:321
 hfsplus_brec_remove+0x3e4/0x4f0 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr fs/hfsplus/attributes.c:299 [inline]
 __hfsplus_delete_attr+0x290/0x3a0 fs/hfsplus/attributes.c:266
 hfsplus_delete_all_attrs+0x13f/0x270 fs/hfsplus/attributes.c:378
 hfsplus_delete_cat+0x681/0xb70 fs/hfsplus/catalog.c:425
 hfsplus_unlink+0x1cf/0x7d0 fs/hfsplus/dir.c:385
 vfs_unlink+0x30e/0x9f0 fs/namei.c:4523
 do_unlinkat+0x574/0x750 fs/namei.c:4587
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x40/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5da2761f5b
Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e =
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff14c29d38 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5da2761f5b
RDX: 00007fff14c29d60 RSI: 00007fff14c29d60 RDI: 00007fff14c29df0
RBP: 00007fff14c29df0 R08: 0000000000000001 R09: 00007fff14c29bc0
R10: 00000000fffffffb R11: 0000000000000206 R12: 00007fff14c2aef0
R13: 00005555555cebb0 R14: 00007fff14c29d58 R15: 0000000000000001
 </TASK>

Allocated by task 418:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x1ef/0x570 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 __hfs_bnode_create+0x106/0x710 fs/hfsplus/bnode.c:409
 hfsplus_bnode_find+0x1cc/0xb80 fs/hfsplus/bnode.c:486
 hfsplus_brec_find+0x2b3/0x530 fs/hfsplus/bfind.c:172
 hfsplus_find_attr fs/hfsplus/attributes.c:160 [inline]
 hfsplus_find_attr+0x12e/0x170 fs/hfsplus/attributes.c:137
 hfsplus_delete_all_attrs+0x170/0x270 fs/hfsplus/attributes.c:371
 hfsplus_delete_cat+0x681/0xb70 fs/hfsplus/catalog.c:425
 hfsplus_rmdir+0x106/0x1b0 fs/hfsplus/dir.c:425
 vfs_rmdir fs/namei.c:4394 [inline]
 vfs_rmdir+0x2ae/0x680 fs/namei.c:4371
 do_rmdir+0x36a/0x3d0 fs/namei.c:4453
 __do_sys_rmdir fs/namei.c:4472 [inline]
 __se_sys_rmdir fs/namei.c:4470 [inline]
 __x64_sys_rmdir+0x40/0x50 fs/namei.c:4470
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ff11000007a62500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 40 bytes to the right of
 allocated 152-byte region [ff11000007a62500, ff11000007a62598)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 =
index:0xff11000007a62100 pfn:0x7a62
anon flags: 0x100000000000000(node=3D0|zone=3D1)
page_type: f5(slab)
raw: 0100000000000000 ff1100000103c3c0 0000000000000000 dead000000000001
raw: ff11000007a62100 000000008010000d 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ff11000007a62480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ff11000007a62500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ff11000007a62580: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ff11000007a62600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ff11000007a62680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oops: general protection fault, maybe for address 0xffa000000008f888: =
0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 418 Comm: syz-executor633 Tainted: G    B             =
 6.13.0-rc3 #5
Tainted: [B]=3DBAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
Code: 69 25 fb e9 d5 fe ff ff 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 e9 =
68 40 23 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
RSP: 0018:ffa000000008f7f0 EFLAGS: 00010202
RAX: ffa000000008f888 RBX: 0000000000000232 RCX: 0000000000000002
RDX: 0000000000000002 RSI: cb91514000006232 RDI: ffa000000008f888
RBP: 0000000000000002 R08: fff3fc0000011f11 R09: fff3fc0000011f12
R10: fff3fc0000011f11 R11: 0000000000000001 R12: 0000000000000002
R13: ffa000000008f888 R14: ff11000007a625c0 R15: ffffffffa48811f0
FS:  00005555555c5880(0000) GS:ff1100006a280000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f237f8ddbe0 CR3: 0000000005224004 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
 <TASK>
 memcpy_from_page include/linux/highmem.h:417 [inline]
 hfsplus_bnode_read+0x13b/0x380 fs/hfsplus/bnode.c:32
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
 hfsplus_bnode_dump+0x2c7/0x3a0 fs/hfsplus/bnode.c:321
 hfsplus_brec_remove+0x3e4/0x4f0 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr fs/hfsplus/attributes.c:299 [inline]
 __hfsplus_delete_attr+0x290/0x3a0 fs/hfsplus/attributes.c:266
 hfsplus_delete_all_attrs+0x13f/0x270 fs/hfsplus/attributes.c:378
 hfsplus_delete_cat+0x681/0xb70 fs/hfsplus/catalog.c:425
 hfsplus_unlink+0x1cf/0x7d0 fs/hfsplus/dir.c:385
 vfs_unlink+0x30e/0x9f0 fs/namei.c:4523
 do_unlinkat+0x574/0x750 fs/namei.c:4587
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x40/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5da2761f5b
Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e =
0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff14c29d38 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5da2761f5b
RDX: 00007fff14c29d60 RSI: 00007fff14c29d60 RDI: 00007fff14c29df0
RBP: 00007fff14c29df0 R08: 0000000000000001 R09: 00007fff14c29bc0
R10: 00000000fffffffb R11: 0000000000000206 R12: 00007fff14c2aef0
R13: 00005555555cebb0 R14: 00007fff14c29d58 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
Code: 69 25 fb e9 d5 fe ff ff 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 e9 =
68 40 23 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
RSP: 0018:ffa000000008f7f0 EFLAGS: 00010202
RAX: ffa000000008f888 RBX: 0000000000000232 RCX: 0000000000000002
RDX: 0000000000000002 RSI: cb91514000006232 RDI: ffa000000008f888
RBP: 0000000000000002 R08: fff3fc0000011f11 R09: fff3fc0000011f12
R10: fff3fc0000011f11 R11: 0000000000000001 R12: 0000000000000002
R13: ffa000000008f888 R14: ff11000007a625c0 R15: ffffffffa48811f0
FS:  00005555555c5880(0000) GS:ff1100006a280000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f237f8ddbe0 CR3: 0000000005224004 CR4: 0000000000771ef0
PKRU: 55555554
----------------
Code disassembly (best guess), 2 bytes skipped:
   0: fb                   sti
   1: e9 d5 fe ff ff       jmpq   0xfffffedb
   6: 66 0f 1f 44 00 00     nopw   0x0(%rax,%rax,1)
   c: 90                   nop
   d: 90                   nop
   e: 90                   nop
   f: 90                   nop
  10: 90                   nop
  11: 90                   nop
  12: 90                   nop
  13: 90                   nop
  14: 90                   nop
  15: 90                   nop
  16: 90                   nop
  17: 90                   nop
  18: 90                   nop
  19: 90                   nop
  1a: 90                   nop
  1b: 90                   nop
  1c: f3 0f 1e fa           endbr64
  20: 66 90                 xchg   %ax,%ax
  22: 48 89 f8             mov    %rdi,%rax
  25: 48 89 d1             mov    %rdx,%rcx
* 28: f3 a4                 rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping =
instruction
  2a: e9 68 40 23 00       jmpq   0x234097
  2f: 66 66 2e 0f 1f 84 00 data16 nopw %cs:0x0(%rax,%rax,1)
  36: 00 00 00 00
  3a: 66 90                 xchg   %ax,%ax
  3c: 90                   nop
  3d: 90                   nop


=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu=

