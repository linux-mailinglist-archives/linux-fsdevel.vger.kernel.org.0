Return-Path: <linux-fsdevel+bounces-66651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB74C275C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 03:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF03B1886790
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 02:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21523D7DB;
	Sat,  1 Nov 2025 02:11:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27E28E00
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761963091; cv=none; b=Md+Gl4d3NFhpYoSCCM+OrBLDuWRdqIiFGb2M5NOwDBOLI+kuGIx2weNiihJYTz7F8bEmFCbSNouui0e/8+A5uxS7LpR7TrMoxJuIHTxu/KwT4/+phm27rDa50dXWjK9UMFnt7jjJUjUlagkCsSkQXWIJI7eY7xdADYFmtzpGqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761963091; c=relaxed/simple;
	bh=K8ImMs6n9uySCZYArV5RIiG8bIqLyPLzV1sXOzBoRtY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hJIeFRBLpiQf/KcvScMvdU3FjUm0R1qBNeHZYKlMkl5ebCLEAwYr5Bk98vhDXtErANnduLtbv2qBJQpnWcA0mpdN9eT8ZWUjFMFV8l4QwkYr/1S7nTCzB31rSShUpQDNl7iCR/zxDSdpKk/68SLGK8vE2O45WQFBIVggskWw5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43322c01a48so702775ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 19:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761963089; x=1762567889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8wH2JlkS8rwz4h7Dq6s8besfCrkPbJyaWFvQHAG38c=;
        b=CYtcFucAdwbWtZ0ve5WJ9bJ8/2JyCsOaumS/FmW53+7jUBVwDo758oQO5raPpprtHL
         Y+0MlE6kbNQ7z90+/cYHR6qJyXlxoLekqpYzBFGBoJ6bP/CWhqKN4zOoWBHC+OAMfYg4
         aGlEMpXM0DyCQYwiHWC7hVl0UhOeMPJI3K4xilRDohZfFvdUq3RXFhw5TGd13loCv4ZC
         /8sAjxfelbP+FRioR23nJxzTTN5kiQi5imBiHNYAbFsb3+WSDYAgDPsoAMYo6Eh9SdPo
         3MdMmmNwOuOS8HA80w3OeGzCkoi+2mJzPpGK8Re6AwaqFSWhKo9zEQM0BsDIF4DdMwIN
         cZEw==
X-Forwarded-Encrypted: i=1; AJvYcCXHsCR5yUx+BH6aBUFhcInlGO/ZTkmFzS2o3ij7LGyH4c/E5NRYto0EvTKz4OGl9xjNfamqCvBN7qWtVoSJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxI16Ey3We4jWfJZ8IlscSml5u1P6RLyury3AIdBgxqDXSZ4m2d
	wtokNepFAnUuIk+/IixwAD+Fzo2yNYYuBErNT4OPlD5qSRT1q9KipfOBjZ468vDVNEgbKmR6yIV
	XTFxWkLMX9qGUor+ig9eUQ+gi7EcqecagBcMikEjaigcRtVUJqhh9jY13nbo=
X-Google-Smtp-Source: AGHT+IEzesGSsLWX/EFccy4sTErr4FvPtAfe/c1E2omwJKxtrILDrP3iAzGkXHjWDghJqUY1wFYh1OAqdHkvq30NnOikP4OVaNgf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4a:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-4330cf069bdmr81980165ab.11.1761963088808; Fri, 31 Oct 2025
 19:11:28 -0700 (PDT)
Date: Fri, 31 Oct 2025 19:11:28 -0700
In-Reply-To: <68cc0578.050a0220.28a605.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69056c50.a70a0220.1e08cc.006c.GAE@google.com>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
From: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    98bd8b16ae57 Add linux-next specific files for 20251031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163b2bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63d09725c93bcc1c
dashboard link: https://syzkaller.appspot.com/bug?extid=3686758660f980b402dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176fc342580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10403f34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/975261746f29/disk-98bd8b16.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad565c6cf272/vmlinux-98bd8b16.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1816a55a8d5f/bzImage-98bd8b16.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d6d9eee31fdb/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17803f34580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3686758660f980b402dc@syzkaller.appspotmail.com

 vms_complete_munmap_vmas+0x206/0x8a0 mm/vma.c:1279
 do_vmi_align_munmap+0x364/0x440 mm/vma.c:1538
 do_vmi_munmap+0x253/0x2e0 mm/vma.c:1586
 __vm_munmap+0x207/0x380 mm/vma.c:3196
 __do_sys_munmap mm/mmap.c:1077 [inline]
 __se_sys_munmap mm/mmap.c:1074 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1074
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1530!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5989 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:folio_end_read+0x1e9/0x230 mm/filemap.c:1530
Code: 79 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 9f df 2e ff 90 0f 0b e8 d7 79 c7 ff 48 89 df 48 c7 c6 40 63 74 8b e8 88 df 2e ff 90 <0f> 0b e8 c0 79 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 71 df 2e ff
RSP: 0018:ffffc90003f8e268 EFLAGS: 00010246
RAX: c6904ff3387db700 RBX: ffffea0001b5ef00 RCX: 0000000000000000
RDX: 0000000000000007 RSI: ffffffff8d780a1b RDI: 00000000ffffffff
RBP: 0000000000000000 R08: ffffffff8f7d7477 R09: 1ffffffff1efae8e
R10: dffffc0000000000 R11: fffffbfff1efae8f R12: 1ffffd400036bde1
R13: 1ffffd400036bde0 R14: ffffea0001b5ef08 R15: 00fff20000004060
FS:  0000555572333500(0000) GS:ffff888125fe2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57d6844000 CR3: 0000000075586000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 iomap_readahead+0x96a/0xbc0 fs/iomap/buffered-io.c:547
 iomap_bio_readahead include/linux/iomap.h:608 [inline]
 erofs_readahead+0x1c3/0x3c0 fs/erofs/data.c:383
 read_pages+0x17a/0x580 mm/readahead.c:163
 page_cache_ra_order+0x924/0xe70 mm/readahead.c:518
 filemap_readahead mm/filemap.c:2658 [inline]
 filemap_get_pages+0x7ff/0x1df0 mm/filemap.c:2704
 filemap_read+0x3f6/0x11a0 mm/filemap.c:2800
 __kernel_read+0x4cf/0x960 fs/read_write.c:530
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x85e/0x16f0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x428/0x8f0 security/integrity/ima/ima_api.c:293
 process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:405
 ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:656
 security_file_post_open+0xbb/0x290 security/security.c:2652
 do_open fs/namei.c:3977 [inline]
 path_openat+0x2f26/0x3830 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b08d8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec6a5d268 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0b08fe5fa0 RCX: 00007f0b08d8efc9
RDX: 0000000000121140 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f0b08e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000013d R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0b08fe5fa0 R14: 00007f0b08fe5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_end_read+0x1e9/0x230 mm/filemap.c:1530
Code: 79 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 9f df 2e ff 90 0f 0b e8 d7 79 c7 ff 48 89 df 48 c7 c6 40 63 74 8b e8 88 df 2e ff 90 <0f> 0b e8 c0 79 c7 ff 48 89 df 48 c7 c6 20 6d 74 8b e8 71 df 2e ff
RSP: 0018:ffffc90003f8e268 EFLAGS: 00010246
RAX: c6904ff3387db700 RBX: ffffea0001b5ef00 RCX: 0000000000000000
RDX: 0000000000000007 RSI: ffffffff8d780a1b RDI: 00000000ffffffff
RBP: 0000000000000000 R08: ffffffff8f7d7477 R09: 1ffffffff1efae8e
R10: dffffc0000000000 R11: fffffbfff1efae8f R12: 1ffffd400036bde1
R13: 1ffffd400036bde0 R14: ffffea0001b5ef08 R15: 00fff20000004060
FS:  0000555572333500(0000) GS:ffff888125ee2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30063fff CR3: 0000000075586000 CR4: 00000000003526f0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

