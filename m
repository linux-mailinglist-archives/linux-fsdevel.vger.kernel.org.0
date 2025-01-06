Return-Path: <linux-fsdevel+bounces-38408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1BA01FDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 08:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D13A1884F17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D31D6DA5;
	Mon,  6 Jan 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="ALGVNN3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEB1D61B9;
	Mon,  6 Jan 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736148243; cv=none; b=BtpjFGa/AbHBXmouMVFHwvGaSJ+poAWcw46zfl5lQiLkFdDFyUMp0qk+1kGK+y9WERCqesh2UdCm4JCtyqwuIbZFiPpwTNkHShNXA/n9lebNLCH3tchmcJ7+wNL+iJQWnQLRdVpm8GEBfbC8Rm1A1uMA3kHYoGiqh/pq7+fr9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736148243; c=relaxed/simple;
	bh=+V65Imnv+Tvn73/Xvz1ZXUW/HhYKQwcKPucmItPXqlY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=CT3BLRXW4et+Y7MX+ptp+ZT763PfefEK3A0u8JZXpyI2vVf29Ev0ydzthdow0D0ba/XcqMoSy5JNbN/0d9osjkSaT9ek35MAJMrKKts29UkyWszRwVKs8ZygrU+6mGSqUzA9lYgTijV/Uh4eULSknS9TVx+80Tldm77hntpfxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=ALGVNN3n; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736148205;
	bh=60qdLsafybpRiNbXIy7sj8aOcSWykjzujico41ZLi+c=;
	h=From:Mime-Version:Subject:Message-Id:Date:To;
	b=ALGVNN3nb1fsEpen9xQ6bDCaZaTqjq0PJR9eknjibnCoQXYQYdWdavMRwHiVafFwO
	 8HREyqiXrw2sgSdbnNsQ+Lc6psJpNBGS8ByS7orNTgu7vDSrV2bKF5oGIfK7S7sxE2
	 l2+svfgKyi8B58cxRrVZqVI+0S0QJ9EJVX0ooGc0=
X-QQ-mid: bizesmtpsz13t1736148198tdmmbz
X-QQ-Originating-IP: tOLh7ra5Ue+Kv2O5SQjmTxzo1PRGcQJoC2zekDjr4Kg=
Received: from smtpclient.apple ( [202.120.235.227])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 15:23:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9369401867067891742
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
Subject: Bug: slab-out-of-bounds Write in __bh_read
Message-Id: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
Date: Mon, 6 Jan 2025 15:23:06 +0800
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
To: viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 jack@suse.cz
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NMGzQWUSIfvT7hcupXFFaqMpsSIrL7KrP/bynifEMAdeBClGD06LEkeB
	mpVMUDe+ZXBVuGZLnM8NBayOaIjIOr/4DSwDAEUshTyGUBFfxkCofCH6+TOZuL3Ef2bPTJb
	OBLzamT3NQk0nZLkTJVwwuUSX3tH+QbAnCsHJ08aZl7joSyKye2z1C7cbwvXMA5I417u/3n
	Ak1uB8EBhnQfHbIut9JU0rqfh1XVn/yToKVU4xV0pez0+PXxE4QwuP02rTNwVmEL7KF6xVf
	DGAzj9ri01bogzIXuZqaQQoGs2SbDo2mylIclZiP1W3X3+bSAgU8ZWl2BrfHfmZ58otwkIT
	hG9AnDh2XgV/I+vqjic1+txheTL3u6BY3Ls+p/LPQrSF7AwU0dPCzuRPcFTSBpv3F96q9hh
	q84BdXEPSPzghOtEdtDtTt6Xh24UrChMnB8Bl9sgGziitFVVQgwyOhbaxDBNg1tssgZ563r
	7a6JauXDGOWa7Eqgsl3DtHH7kf26txctnVU5zinivGO6IxkNn1nTZVJr8VNRJODYVgQVbZB
	zbsoOzBn0CEWTm5+azoqpgnMpBcFqx10euECDJ8/vwKsiKlaeVyIw+J1e2mGXwLQubqmqSV
	8XfjVaYcaTxFOUk9kMuizH5VPfO+q8DC70QS4IqTeXKU3IQuBHTGdvJH9GvziYbxNMTb21s
	DVZu7pSF5qIV4g4vhk/VmoKmHPQD+qLoZZywRYj/lDw0lPcNOc3RbOOyssECQJsUAaqW7hO
	8aQ2lsPG4Jj6nnG43rMLjO/EOoRdvMAb50ElDFbaEQeJ3nkApsLaNl6omjaQOqmRcIA7R+X
	njQ31/9xrsXYkh8zIU+OpN7YI+uIk4rPyHuhqZIBt/KRuiv4vH4hzfLY4q90aMjiCmufNcr
	4XpapG8tounOcmdEl220CocM27eIUfvIgFe/Lxy5y++mT67nn8cS0q3jBkabkOupWJqbBjT
	nL1YEoAWZYC5pCuObYKQP5POZFVeDCv1OvdoriJPNs0gCNSY/p3wD8scN3SWObBEdbR6ZT6
	uYHgT1Ig==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hello,

When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash
was triggered.

HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
git tree: upstream
Console output: =
https://drive.google.com/file/d/1-YGytaKuh9M4hI6x27YjsE0vSyRFngf5/view?usp=
=3Dsharing
Kernel config: =
https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDWM_N1Pqz73/view?usp=
=3Dsharing
C reproducer: /
Syzlang reproducer: /

We found an issue in the __bh_read function at line 3086, where a =
slab-out-of-bounds error was reported. While the BUG_ON check ensures =
that bh is locked, I suspect it=E2=80=99s possible that bh might have =
been released prior to the call to __bh_read. This could result in =
accessing invalid memory, ultimately triggering the reported issue.

Unfortunately, We can=E2=80=99t get stable reproducers yet. Could you =
please help check if this needs to be addressed?

If you fix this issue, please add the following tag to the commit:
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin =
<jjtan24@m.fudan.edu.cn>


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read_write =
include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-out-of-bounds in atomic_inc =
include/linux/atomic/atomic-instrumented.h:435 [inline]
BUG: KASAN: slab-out-of-bounds in get_bh include/linux/buffer_head.h:296 =
[inline]
BUG: KASAN: slab-out-of-bounds in __bh_read+0x6f/0x1f0 fs/buffer.c:3086
Write of size 4 at addr ff110000026598e0 by task syz.2.15/1705

CPU: 2 UID: 0 PID: 1705 Comm: syz.2.15 Not tainted 6.13.0-rc5 #1
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
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
 get_bh include/linux/buffer_head.h:296 [inline]
 __bh_read+0x6f/0x1f0 fs/buffer.c:3086
 bh_read_nowait include/linux/buffer_head.h:442 [inline]
 __block_write_begin_int+0x156d/0x18c0 fs/buffer.c:2145
 iomap_write_begin+0x581/0x18d0 fs/iomap/buffered-io.c:827
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x402/0xbe0 fs/iomap/buffered-io.c:1039
 gfs2_file_buffered_write+0x40b/0xb10 fs/gfs2/file.c:1060
 gfs2_file_write_iter+0x6c9/0x1080 fs/gfs2/file.c:1164
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write fs/read_write.c:679 [inline]
 vfs_write+0xb9b/0x10f0 fs/read_write.c:659
 ksys_write+0x122/0x240 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65c364471d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f65c2297ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f65c3806f80 RCX: 00007f65c364471d
RDX: 0000000000001006 RSI: 0000000020001240 RDI: 0000000000000007
RBP: 00007f65c36b9425 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f65c3806f8c R14: 00007f65c3807018 R15: 00007f65c2297d40
 </TASK>

Allocated by task 1705:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x1ef/0x570 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ifs_alloc+0x1c9/0x400 fs/iomap/buffered-io.c:202
 __iomap_write_begin fs/iomap/buffered-io.c:707 [inline]
 iomap_write_begin+0xa54/0x18d0 fs/iomap/buffered-io.c:829
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x402/0xbe0 fs/iomap/buffered-io.c:1039
 gfs2_file_buffered_write+0x40b/0xb10 fs/gfs2/file.c:1060
 gfs2_file_write_iter+0x6c9/0x1080 fs/gfs2/file.c:1164
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write fs/read_write.c:679 [inline]
 vfs_write+0xb9b/0x10f0 fs/read_write.c:659
 ksys_write+0x122/0x240 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ff11000002659880
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 16 bytes to the right of
 allocated 80-byte region [ff11000002659880, ff110000026598d0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 =
pfn:0x2659
anon flags: 0x100000000000000(node=3D0|zone=3D1)
page_type: f5(slab)
raw: 0100000000000000 ff1100000103c280 ffd40000010501c0 dead000000000005
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ff11000002659780: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
 ff11000002659800: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ff11000002659880: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                                                       ^
 ff11000002659900: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ff11000002659980: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: unable to handle page fault for address: ffffffffffffffff
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 2fcf2067=20
P4D 2fcf3067 PUD 2fcf5067 PMD 0=20
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 1705 Comm: syz.2.15 Tainted: G    B              =
6.13.0-rc5 #1
Tainted: [B]=3DBAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
RIP: 0010:_test_bit =
include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
RIP: 0010:compound_order include/linux/mm.h:1112 [inline]
RIP: 0010:page_size include/linux/mm.h:1311 [inline]
RIP: 0010:bh_offset include/linux/buffer_head.h:176 [inline]
RIP: 0010:submit_bh_wbc.constprop.0+0x37d/0x640 fs/buffer.c:2801
Code: 00 00 4c 89 e7 48 89 44 24 08 e8 3e 64 e9 ff 4c 89 e1 48 b8 00 00 =
00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 0f 85 16 02 00 00 <4d> 8b 3c =
24 31 ff bd ff 0f 00 00 49 c1 ef 06 41 83 e7 01 44 89 fe
RSP: 0018:ffa0000014c1f5f0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ff11000002659880 RCX: 1fffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffffffffff
RBP: 227ffffd1bbc268c R08: 0000000000000001 R09: ffe21c00012f37ae
R10: ffe21c00012f37ad R11: ff1100000979bd6f R12: ffffffffffffffff
R13: ff11000002659890 R14: ff1100000979bd00 R15: ff11000002659880
FS:  00007f65c2298700(0000) GS:ff1100006a200000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffff CR3: 00000000413da004 CR4: 0000000000771ef0
PKRU: 80000000
Call Trace:
 <TASK>
 submit_bh fs/buffer.c:2819 [inline]
 __bh_read+0xa7/0x1f0 fs/buffer.c:3088
 bh_read_nowait include/linux/buffer_head.h:442 [inline]
 __block_write_begin_int+0x156d/0x18c0 fs/buffer.c:2145
 iomap_write_begin+0x581/0x18d0 fs/iomap/buffered-io.c:827
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x402/0xbe0 fs/iomap/buffered-io.c:1039
 gfs2_file_buffered_write+0x40b/0xb10 fs/gfs2/file.c:1060
 gfs2_file_write_iter+0x6c9/0x1080 fs/gfs2/file.c:1164
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write fs/read_write.c:679 [inline]
 vfs_write+0xb9b/0x10f0 fs/read_write.c:659
 ksys_write+0x122/0x240 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65c364471d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f65c2297ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f65c3806f80 RCX: 00007f65c364471d
RDX: 0000000000001006 RSI: 0000000020001240 RDI: 0000000000000007
RBP: 00007f65c36b9425 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f65c3806f8c R14: 00007f65c3807018 R15: 00007f65c2297d40
 </TASK>
Modules linked in:
CR2: ffffffffffffffff
---[ end trace 0000000000000000 ]---
RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
RIP: 0010:_test_bit =
include/asm-generic/bitops/instrumented-non-atomic.h:142 [inline]
RIP: 0010:compound_order include/linux/mm.h:1112 [inline]
RIP: 0010:page_size include/linux/mm.h:1311 [inline]
RIP: 0010:bh_offset include/linux/buffer_head.h:176 [inline]
RIP: 0010:submit_bh_wbc.constprop.0+0x37d/0x640 fs/buffer.c:2801
Code: 00 00 4c 89 e7 48 89 44 24 08 e8 3e 64 e9 ff 4c 89 e1 48 b8 00 00 =
00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 0f 85 16 02 00 00 <4d> 8b 3c =
24 31 ff bd ff 0f 00 00 49 c1 ef 06 41 83 e7 01 44 89 fe
RSP: 0018:ffa0000014c1f5f0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ff11000002659880 RCX: 1fffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffffffffff
RBP: 227ffffd1bbc268c R08: 0000000000000001 R09: ffe21c00012f37ae
R10: ffe21c00012f37ad R11: ff1100000979bd6f R12: ffffffffffffffff
R13: ff11000002659890 R14: ff1100000979bd00 R15: ff11000002659880
FS:  00007f65c2298700(0000) GS:ff1100006a200000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffff CR3: 00000000413da004 CR4: 0000000000771ef0
PKRU: 80000000
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	4c 89 e7             	mov    %r12,%rdi
   5:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   a:	e8 3e 64 e9 ff       	callq  0xffe9644d
   f:	4c 89 e1             	mov    %r12,%rcx
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 c1 e9 03          	shr    $0x3,%rcx
  20:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
  24:	0f 85 16 02 00 00    	jne    0x240
* 2a:	4d 8b 3c 24          	mov    (%r12),%r15 <-- trapping =
instruction
  2e:	31 ff                	xor    %edi,%edi
  30:	bd ff 0f 00 00       	mov    $0xfff,%ebp
  35:	49 c1 ef 06          	shr    $0x6,%r15
  39:	41 83 e7 01          	and    $0x1,%r15d
  3d:	44 89 fe             	mov    %r15d,%esi


---------------
thanks,
Kun Hu=

