Return-Path: <linux-fsdevel+bounces-66846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C63C2D545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3579188EEA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9331D74E;
	Mon,  3 Nov 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgSNdV/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171B31D736
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189114; cv=none; b=q9L810odTHT3qezzxBBz6MU11vTcz8z5S9bH4wHiGNsqJzsj/YJop/SlhV/+GnIpjBc0yyjx8WMj9pu+0BPoY23IvoTO2PSDvUgle/rGwUi/ZZ+ONginQ4g1H+7ywRVClvWRW/QEML/uTnphPHR4qFgHaK4tGEsUgUhT8RlizT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189114; c=relaxed/simple;
	bh=b0O3GE4qbZNbg0oDGHxasBjYudlii3ZM6j4y5Cr/l5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLxfEya+EvDr9eD/WHIISIQtHkVQOTtNXpE2ut+7Xk1VG5uDFn4Z5A//malkmSbXP0ZtzI3LCZRMDy06pCPVkqeduHzszn3T0utfEswPLI6eG7O0mFIquNYNwqlFnVYU3WSyNVqHDzmHBLLsJYpmEZN50Pz5YZl9/5o7LavRH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgSNdV/7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ecee585f23so29946681cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189111; x=1762793911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mTsTlYaKlSyBQb/TNu3wRr8ckz09pUbjw64hL0b7SA=;
        b=BgSNdV/7fYcawu86Vprj4piD9mA6QYHDGBDcmYm2fLXK4hRHjjKuMhNmYs7sAN7qMy
         6aY5E1uBpvxUa2VyFxyTIbHoDlJitWdKYjjXh1r0B90tBbeL+1cQ23UqigUOPgoiM7K+
         MDM4VqY3IVlSVpLFUPyg7TujDLirAMRRmn9PlcBvjVSdfD+VdV38CmmVndVWIT5UJV96
         V7d80IZCUE5W/Hs2+5+oMbjsUVtHptCaN0xLW+cDqVU2OYpDJdLsFMHMpNsSGiH9tckX
         JBEbw9g2g3V57Qjm59LD5YxyMLCFCeFslqUaEyc1ObHrCuwY5hkOSqsZY4Uyhw/RNq2K
         6u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189111; x=1762793911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mTsTlYaKlSyBQb/TNu3wRr8ckz09pUbjw64hL0b7SA=;
        b=OQj35bCDuN4iTg0e8QgvUvt9eizpxF0z/jA0mxPuTpN7P/fiCO1ETRsY04PdWNdh9+
         /F81JG/0D1naL4+hD7OVVu/pf59DjsfQ7S/UtAt1m+xWEqXTsopJ8cRWsUwdoZDZtjSN
         ypcGpDs2LUwjfuBYlMccfdDbYlhEZldUenG0OtUfWoL5G6RMe+lBB0xZ+x9mnCCjHP6s
         8clsOhhO4pJ8q3tH8/7dLa7bLsZHuFvrx5S5pE4JibboByclUL9KAHqDPpKtsIc9C5Ap
         X8w0+l27rL9uG/gIoJjN4i8MWi3DkRT98ihKeadZvUNfrANu2RCmHeGKTvW31r/62cSg
         KuYw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYxE3hm7EGlAKKSgO+O2Szo61iN8lySJfooNioKiMEQrbBQF1VjlaXocOBme+zjXkiEvpJFbDziZc5fv0@vger.kernel.org
X-Gm-Message-State: AOJu0YyBz0I61Ff2oSnwA0l6YZm1yNSM0rSvHUwGlKLrrzWD7+n2ZsSm
	fA8mZ3I1kQwBOspnve6LaaEIMXaJVDkfAvP6pNG4Fvrczu26/Rsxi9YTx47lv9FbpCdQLLz45T6
	WQfr1NrAmyF4mqlbue8HyuGyfv87W7/A=
X-Gm-Gg: ASbGnct5qktdMNGfXrVIZnq8ZQBjAW+oEwWHiciV8zK1OV6M8LvdGgm/6BH+hWLpsrz
	VoN4O0xVvz4aTUslxU03loS4L23eNYj9QGA3mdmhQNOoY5mcuCpoNSz661vyvMiZdC1BfOmuSSP
	p+FtKfwntK1o6gx5zjpSbEpgW6dET//5JGR5m6XXlD6ls4bbWTG9PA62UDVqfTMae6v7j6HJ00Q
	cT5XWlX9I47YtABu8yBkRriRn2vviKYGZdOKexQ9R4es3kKf2YRkYobuumhIvzlQCpkiJpOzIrA
	ESAd8jnOSAVY4J3LST9VnMopi9Ny7gtHQO+rfMW+MLM=
X-Google-Smtp-Source: AGHT+IHyI72HABW//cHBarLcnu9+Ba1MPRR6bZ6mJXb7LBAoEIMFtTzlhgqDHkzZb+vCZHWzUpZ0aVzufuIm9gLbSlg=
X-Received: by 2002:ac8:7f81:0:b0:4e6:ef26:3152 with SMTP id
 d75a77b69052e-4ed310d1aa1mr166286551cf.80.1762189111384; Mon, 03 Nov 2025
 08:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68cc0578.050a0220.28a605.0006.GAE@google.com> <69056c50.a70a0220.1e08cc.006c.GAE@google.com>
In-Reply-To: <69056c50.a70a0220.1e08cc.006c.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Nov 2025 08:58:20 -0800
X-Gm-Features: AWmQ_bkDsSgdQVUGrhQNkWuvMPjtQkwEYu3HRdCHE9EaMTy5z14J08E7zjkious
Message-ID: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
To: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 1:26=E2=80=AFPM syzbot
<syzbot+3686758660f980b402dc@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    98bd8b16ae57 Add linux-next specific files for 20251031
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D163b2bcd98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D63d09725c93bc=
c1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3686758660f980b=
402dc
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D176fc342580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10403f3458000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/975261746f29/dis=
k-98bd8b16.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ad565c6cf272/vmlinu=
x-98bd8b16.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1816a55a8d5f/b=
zImage-98bd8b16.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d6d9eee31f=
db/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=3D=
17803f34580000)
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3686758660f980b402dc@syzkaller.appspotmail.com
>
>  vms_complete_munmap_vmas+0x206/0x8a0 mm/vma.c:1279
>  do_vmi_align_munmap+0x364/0x440 mm/vma.c:1538
>  do_vmi_munmap+0x253/0x2e0 mm/vma.c:1586
>  __vm_munmap+0x207/0x380 mm/vma.c:3196
>  __do_sys_munmap mm/mmap.c:1077 [inline]
>  __se_sys_munmap mm/mmap.c:1074 [inline]
>  __x64_sys_munmap+0x60/0x70 mm/mmap.c:1074
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1530!

I think this is the same bug that was fixed by [1].

[1] https://lore.kernel.org/linux-fsdevel/20251031211309.1774819-2-joannelk=
oong@gmail.com/

> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5989 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:folio_end_read+0x1e9/0x230 mm/filemap.c:1530
> Code: 79 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 9f df 2e ff 90 0f 0b e8 d=
7 79 c7 ff 48 89 df 48 c7 c6 40 63 74 8b e8 88 df 2e ff 90 <0f> 0b e8 c0 79=
 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 71 df 2e ff
> RSP: 0018:ffffc90003f8e268 EFLAGS: 00010246
> RAX: c6904ff3387db700 RBX: ffffea0001b5ef00 RCX: 0000000000000000
> RDX: 0000000000000007 RSI: ffffffff8d780a1b RDI: 00000000ffffffff
> RBP: 0000000000000000 R08: ffffffff8f7d7477 R09: 1ffffffff1efae8e
> R10: dffffc0000000000 R11: fffffbfff1efae8f R12: 1ffffd400036bde1
> R13: 1ffffd400036bde0 R14: ffffea0001b5ef08 R15: 00fff20000004060
> FS:  0000555572333500(0000) GS:ffff888125fe2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f57d6844000 CR3: 0000000075586000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  iomap_readahead+0x96a/0xbc0 fs/iomap/buffered-io.c:547
>  iomap_bio_readahead include/linux/iomap.h:608 [inline]
>  erofs_readahead+0x1c3/0x3c0 fs/erofs/data.c:383
>  read_pages+0x17a/0x580 mm/readahead.c:163
>  page_cache_ra_order+0x924/0xe70 mm/readahead.c:518
>  filemap_readahead mm/filemap.c:2658 [inline]
>  filemap_get_pages+0x7ff/0x1df0 mm/filemap.c:2704
>  filemap_read+0x3f6/0x11a0 mm/filemap.c:2800
>  __kernel_read+0x4cf/0x960 fs/read_write.c:530
>  integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x85e/0x16f0 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x428/0x8f0 security/integrity/ima/ima_api.c:293
>  process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:405
>  ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:656
>  security_file_post_open+0xbb/0x290 security/security.c:2652
>  do_open fs/namei.c:3977 [inline]
>  path_openat+0x2f26/0x3830 fs/namei.c:4134
>  do_filp_open+0x1fa/0x410 fs/namei.c:4161
>  do_sys_openat2+0x121/0x1c0 fs/open.c:1437
>  do_sys_open fs/open.c:1452 [inline]
>  __do_sys_openat fs/open.c:1468 [inline]
>  __se_sys_openat fs/open.c:1463 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1463
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0b08d8efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffec6a5d268 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f0b08fe5fa0 RCX: 00007f0b08d8efc9
> RDX: 0000000000121140 RSI: 0000200000000000 RDI: ffffffffffffff9c
> RBP: 00007f0b08e11f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000013d R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0b08fe5fa0 R14: 00007f0b08fe5fa0 R15: 0000000000000004
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:folio_end_read+0x1e9/0x230 mm/filemap.c:1530
> Code: 79 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 9f df 2e ff 90 0f 0b e8 d=
7 79 c7 ff 48 89 df 48 c7 c6 40 63 74 8b e8 88 df 2e ff 90 <0f> 0b e8 c0 79=
 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 71 df 2e ff
> RSP: 0018:ffffc90003f8e268 EFLAGS: 00010246
> RAX: c6904ff3387db700 RBX: ffffea0001b5ef00 RCX: 0000000000000000
> RDX: 0000000000000007 RSI: ffffffff8d780a1b RDI: 00000000ffffffff
> RBP: 0000000000000000 R08: ffffffff8f7d7477 R09: 1ffffffff1efae8e
> R10: dffffc0000000000 R11: fffffbfff1efae8f R12: 1ffffd400036bde1
> R13: 1ffffd400036bde0 R14: ffffea0001b5ef08 R15: 00fff20000004060
> FS:  0000555572333500(0000) GS:ffff888125ee2000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30063fff CR3: 0000000075586000 CR4: 00000000003526f0
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t
master

