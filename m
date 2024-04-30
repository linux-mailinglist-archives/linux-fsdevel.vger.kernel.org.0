Return-Path: <linux-fsdevel+bounces-18306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E078B6C5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 10:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2A0283E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939545026;
	Tue, 30 Apr 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sysophe.eu header.i=@sysophe.eu header.b="WJc7dvxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hygieia.sysophe.eu (hygieia.sysophe.eu [138.201.91.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47E54676;
	Tue, 30 Apr 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.91.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464017; cv=none; b=KPsCPucBgrNHZTV7SHWB2/pYSJsr/Lz+4ILvvXnRDM9afV0WKHVzYsgkOUr+1N48oZi+iqJL0NNJKKjpaHDp5nKsxMr0rQ0pb1nBIrhCsS2Bc7UqjLHRe27JfFypP+DKLUtptUh9VDbk4e7z6W5XU6XHQSLWs29YWK7iX98OCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464017; c=relaxed/simple;
	bh=+v2I/ss7RNt6Oyx8bGWBHXm9Te+cwsqYzc96gK+yXCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s+JoAi1ytTohC9Qegr8N6l80USXXo2jt4sOqe2i2vFIjvNWf/9izhUsLi7R5lhkoNsUPo6o5uLUkkl/d6TrZpFGt3NYeeE7jXyutkbWEKsAMn+E1mVJAIURdWQJ1H2COxuA17PcRQLX/qcI52Ohq6PFxjEZwRjYL+Psea0j4Sew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysophe.eu; spf=pass smtp.mailfrom=sysophe.eu; dkim=pass (1024-bit key) header.d=sysophe.eu header.i=@sysophe.eu header.b=WJc7dvxe; arc=none smtp.client-ip=138.201.91.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysophe.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysophe.eu
Received: from pluto.restena.lu (pluto.restena.lu [IPv6:2001:a18:1:10::156])
	by smtp.sysophe.eu (Postfix) with ESMTPSA id 9BA1D425E0A5;
	Tue, 30 Apr 2024 09:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sysophe.eu; s=201205;
	t=1714463410; x=1714549810;
	bh=+v2I/ss7RNt6Oyx8bGWBHXm9Te+cwsqYzc96gK+yXCo=;
	h=Date:From:To:Cc:Subject;
	b=WJc7dvxeMgMlfSgpu4njNTDVBkSmlR+dtiFvleCGG0NJfalcanomK01v39wt08Zub
	 KHxMOFotgrUH3wMb0+u3+t0DEG0gHL9bhdtyCgq6I8QJz1/G4JH5AAh67JYfPQe4V5
	 fkeUwqtfgPS/Pe8jW+1tRTNYb217aGC6Ca2RdFsc=
Date: Tue, 30 Apr 2024 09:49:50 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@sysophe.eu>
To: David Howells <dhowells@redhat.com>
Cc: <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
 linux-cifs@vger.kernel.org
Subject: [BUG] 6.8.x general protection fault during cifs/netfs write
Message-ID: <20240430094651.17461d73@hemera>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Importance: high
X-Priority: 1 (Highest)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

I've been experiencing general protection fault during cifs IO recently
with 6.8 kernels (6.8.7 and 6.8.0).
For the 6.8.7 it was during a `cp -a $localdir /path/to/cifs/mount`.

[276389.427110] general protection fault, probably for non-canonical addres=
s 0x5a5a5a5a5a5a5ae2: 0000 [#1] SMP NOPTI
[276389.427129] CPU: 4 PID: 4373 Comm: cp Not tainted 6.8.7 #2
[276389.427137] Hardware name: LENOVO 20N4S13W00/20N4S13W00, BIOS N2IETA2W =
(1.80 ) 06/21/2023
[276389.427143] RIP: 0010:__fscache_use_cookie+0x1e/0x2b0
[276389.427156] Code: 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55=
 41 54 55 53 48 83 ec 48 65 48 8b 04 25 28 00 00 00 48 89 44 24 40 31 c0 <4=
8> 8b 87 88 00 00 00 89 c5 83 e5 01 0f 85 c3 01 00 00 4c 8d 6f 14
[276389.427164] RSP: 0018:ffffaf3e85053ca8 EFLAGS: 00010246
[276389.427173] RAX: 0000000000000000 RBX: ffff9b8feefd1ef8 RCX: 0000000000=
000000
[276389.427178] RDX: 0000000000040004 RSI: 0000000000000001 RDI: 5a5a5a5a5a=
5a5a5a
[276389.427184] RBP: 5a5a5a5a5a5a5a5a R08: 0000000000000000 R09: 0000000000=
000000
[276389.427189] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9b8fee=
fd1ef8
[276389.427194] R13: 0000000000001000 R14: ffff9b8feefd2070 R15: ffff9b8fe2=
db4a00
[276389.427199] FS:  00007fac30b10740(0000) GS:ffff9b922e700000(0000) knlGS=
:0000000000000000
[276389.427206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[276389.427211] CR2: 00007fac30aa8000 CR3: 00000001dcafa006 CR4: 0000000000=
3706f0
[276389.427217] Call Trace:
[276389.427223]  <TASK>
[276389.427227]  ? die_addr+0x2d/0x80
[276389.427239]  ? exc_general_protection+0x2ba/0x340
[276389.427251]  ? asm_exc_general_protection+0x22/0x30
[276389.427262]  ? __fscache_use_cookie+0x1e/0x2b0
[276389.427269]  ? queue_delayed_work_on+0x27/0x30
[276389.427280]  netfs_dirty_folio+0x8b/0xa0
[276389.427290]  cifs_write_end+0x145/0x1d0
[276389.427299]  generic_perform_write+0x11e/0x230
[276389.427308]  cifs_strict_writev+0x256/0x2d0
[276389.427318]  vfs_write+0x274/0x420
[276389.427326]  ksys_write+0x66/0xf0
[276389.427332]  do_syscall_64+0x49/0x120
[276389.427340]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[276389.427351] RIP: 0033:0x7fac30c02264
[276389.427358] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00=
 00 00 00 00 f3 0f 1e fa 80 3d 05 31 0d 00 00 74 13 b8 01 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
[276389.427364] RSP: 002b:00007ffd93d03ac8 EFLAGS: 00000202 ORIG_RAX: 00000=
00000000001
[276389.427372] RAX: ffffffffffffffda RBX: 0000000000099ec3 RCX: 00007fac30=
c02264
[276389.427378] RDX: 0000000000099ec3 RSI: 00007fac30a0f000 RDI: 0000000000=
000004
[276389.427382] RBP: 0000000000099ec3 R08: 00007fac30a0f000 R09: 0000000000=
000000
[276389.427387] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fac30=
a0f000
[276389.427392] R13: 0000000000000004 R14: 0000000000099ec3 R15: 0000000000=
099ec3
[276389.427398]  </TASK>
[276389.427401] Modules linked in:
[276389.427409] ---[ end trace 0000000000000000 ]---
[276389.427414] RIP: 0010:__fscache_use_cookie+0x1e/0x2b0
[276389.427421] Code: 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55=
 41 54 55 53 48 83 ec 48 65 48 8b 04 25 28 00 00 00 48 89 44 24 40 31 c0 <4=
8> 8b 87 88 00 00 00 89 c5 83 e5 01 0f 85 c3 01 00 00 4c 8d 6f 14
[276389.427427] RSP: 0018:ffffaf3e85053ca8 EFLAGS: 00010246
[276389.427433] RAX: 0000000000000000 RBX: ffff9b8feefd1ef8 RCX: 0000000000=
000000
[276389.427438] RDX: 0000000000040004 RSI: 0000000000000001 RDI: 5a5a5a5a5a=
5a5a5a
[276389.427442] RBP: 5a5a5a5a5a5a5a5a R08: 0000000000000000 R09: 0000000000=
000000
[276389.427447] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9b8fee=
fd1ef8
[276389.427451] R13: 0000000000001000 R14: ffff9b8feefd2070 R15: ffff9b8fe2=
db4a00
[276389.427456] FS:  00007fac30b10740(0000) GS:ffff9b922e700000(0000) knlGS=
:0000000000000000
[276389.427462] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[276389.427467] CR2: 00007fac30aa8000 CR3: 00000001dcafa006 CR4: 0000000000=
3706f0


This looks like the delayed work is suffering from some use-after-free.
Note that I have `slub_debug=3DZP` on my kernel cmdline which will make
use after free issues more visible.

The kernel not being built with debugging symbols, here is what I get
from objdump:
0000000000001130 <__fscache_use_cookie>:
__fscache_use_cookie():
    1130:       41 57                   push   %r15
    1132:       41 56                   push   %r14
    1134:       41 55                   push   %r13
    1136:       41 54                   push   %r12
    1138:       55                      push   %rbp
    1139:       53                      push   %rbx
    113a:       48 83 ec 48             sub    $0x48,%rsp
    113e:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
    1145:       00 00=20
    1147:       48 89 44 24 40          mov    %rax,0x40(%rsp)
    114c:       31 c0                   xor    %eax,%eax
    114e:       48 8b 87 88 00 00 00    mov    0x88(%rdi),%rax
                ^^^^^^^^^^^^^^^^^^^^
    1155:       89 c5                   mov    %eax,%ebp
    1157:       83 e5 01                and    $0x1,%ebp
    115a:       0f 85 c3 01 00 00       jne    1323 <__fscache_use_cookie+0=
x1f3>
    1160:       4c 8d 6f 14             lea    0x14(%rdi),%r13
    1164:       48 89 fb                mov    %rdi,%rbx
    1167:       41 89 f4                mov    %esi,%r12d
    116a:       4c 89 ef                mov    %r13,%rdi
    116d:       e8 00 00 00 00          call   1172 <__fscache_use_cookie+0=
x42>
    1172:       b8 01 00 00 00          mov    $0x1,%eax
    1177:       f0 0f c1 43 04          lock xadd %eax,0x4(%rbx)
    117c:       8b 43 08                mov    0x8(%rbx),%eax
    117f:       8b 03                   mov    (%rbx),%eax
    1181:       0f b6 b3 90 00 00 00    movzbl 0x90(%rbx),%esi
    1188:       40 80 fe 04             cmp    $0x4,%sil
    118c:       77 26                   ja     11b4 <__fscache_use_cookie+0=
x84>
    118e:       40 80 fe 02             cmp    $0x2,%sil
    1192:       77 7b                   ja     120f <__fscache_use_cookie+0=
xdf>
    1194:       40 84 f6                test   %sil,%sil
    1197:       0f 84 0f 01 00 00       je     12ac <__fscache_use_cookie+0=
x17c>
    119d:       45 84 e4                test   %r12b,%r12b
    11a0:       0f 84 fd 00 00 00       je     12a3 <__fscache_use_cookie+0=
x173>
    11a6:       f0 80 8b 88 00 00 00    lock orb $0x80,0x88(%rbx)
    11ad:       80=20

Unless I'm misreading code that feels like the cookie was freed
already and the first access at cookie details crashes.


A previous trace with 6.8.0:
[1164231.756488] CPU: 7 PID: 23080 Comm: cp Tainted: G      D            6.=
8.0 #1
[1164231.756491] Hardware name: LENOVO 20N4S13W00/20N4S13W00, BIOS N2IETA2W=
 (1.80 ) 06/21/2023
[1164231.756493] RIP: 0010:__fscache_use_cookie+0x1e/0x2b0
[1164231.756500] Code: 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 5=
5 41 54 55 53 48 83 ec 48 65 48 8b 04 25 28 00 00 00 48 89 44 24 40 31 c0 <=
48> 8b 87 88 00 00 00 89 c5 83 e5 01 0f 85 c3 01 00 00 4c 8d 6f 14
[1164231.756502] RSP: 0018:ffffaedd076cfca8 EFLAGS: 00010246
[1164231.756504] RAX: 0000000000000000 RBX: ffffa3179d9863b8 RCX: ffffa3179=
d9864a0
[1164231.756506] RDX: 0000000000040004 RSI: 0000000000000001 RDI: 5a5a5a5a5=
a5a5a5a
[1164231.756507] RBP: 5a5a5a5a5a5a5a5a R08: ffffa3179d9864a0 R09: 000000000=
0000000
[1164231.756508] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa3179=
d9863b8
[1164231.756510] R13: 0000000000001000 R14: ffffa3179d986530 R15: ffffa3161=
7172c00
[1164231.756511] FS:  00007f66d8685740(0000) GS:ffffa31a2e7c0000(0000) knlG=
S:0000000000000000
[1164231.756513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1164231.756514] CR2: 00007f66d8589000 CR3: 00000001b9dce001 CR4: 000000000=
03706f0
[1164231.756516] Call Trace:
[1164231.756518]  <TASK>
[1164231.756520]  ? die_addr+0x2d/0x80
[1164231.756526]  ? exc_general_protection+0x2ba/0x340
[1164231.756531]  ? asm_exc_general_protection+0x22/0x30
[1164231.756535]  ? __fscache_use_cookie+0x1e/0x2b0
[1164231.756536]  ? locked_inode_to_wb_and_lock_list+0x3b/0x130
[1164231.756541]  ? __mark_inode_dirty+0x12e/0x220
[1164231.756543]  netfs_dirty_folio+0x8b/0xa0
[1164231.756547]  cifs_write_end+0x145/0x1d0
[1164231.756552]  generic_perform_write+0x11e/0x230
[1164231.756556]  cifs_strict_writev+0x256/0x2d0
[1164231.756559]  vfs_write+0x274/0x420
[1164231.756563]  ksys_write+0x66/0xf0
[1164231.756565]  do_syscall_64+0x4e/0x120
[1164231.756568]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[1164231.756573] RIP: 0033:0x7f66d8777264
[1164231.756576] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 0=
0 00 00 00 00 f3 0f 1e fa 80 3d 05 31 0d 00 00 74 13 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
[1164231.756577] RSP: 002b:00007ffea7f86228 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
[1164231.756579] RAX: ffffffffffffffda RBX: 00000000000059d5 RCX: 00007f66d=
8777264
[1164231.756581] RDX: 00000000000059d5 RSI: 00007f66d8584000 RDI: 000000000=
0000004
[1164231.756582] RBP: 00000000000059d5 R08: 00007f66d8584000 R09: 000000000=
0000000
[1164231.756583] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f66d=
8584000
[1164231.756584] R13: 0000000000000004 R14: 00000000000059d5 R15: 000000000=
00059d5
[1164231.756585]  </TASK>
[1164231.756586] Modules linked in:
[1164231.756589] ---[ end trace 0000000000000000 ]---
[1164231.756591] RIP: 0010:__fscache_use_cookie+0x1e/0x2b0
[1164231.756593] Code: 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 5=
5 41 54 55 53 48 83 ec 48 65 48 8b 04 25 28 00 00 00 48 89 44 24 40 31 c0 <=
48> 8b 87 88 00 00 00 89 c5 83 e5 01 0f 85 c3 01 00 00 4c 8d 6f 14
[1164231.756594] RSP: 0018:ffffaedd03103ca0 EFLAGS: 00010246
[1164231.756595] RAX: 0000000000000000 RBX: ffffa3179d9825d8 RCX: 000000000=
0000000
[1164231.756597] RDX: 0000000000040004 RSI: 0000000000000001 RDI: 5a5a5a5a5=
a5a5a5a
[1164231.756598] RBP: 5a5a5a5a5a5a5a5a R08: 0000000000000000 R09: 000000000=
0000000
[1164231.756599] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa3179=
d9825d8
[1164231.756600] R13: 000000000000005c R14: ffffa3179d982750 R15: ffffa316e=
1f66e00
[1164231.756601] FS:  00007f66d8685740(0000) GS:ffffa31a2e7c0000(0000) knlG=
S:0000000000000000
[1164231.756602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1164231.756604] CR2: 00007f66d8589000 CR3: 00000001b9dce001 CR4: 000000000=
03706f0



Cheers,
Bruno

