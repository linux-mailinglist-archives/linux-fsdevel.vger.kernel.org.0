Return-Path: <linux-fsdevel+bounces-76728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGY4EeEmimlKHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:26:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C911385A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0132F3022F50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6A38A717;
	Mon,  9 Feb 2026 18:26:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92A2FE07D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661589; cv=none; b=iGH0D9dgxRu4jYFGRfLefxsgEzf6G4s7t4FKIGmdwJn67Iy+usDYy36hnL/HP0HUKGpuCZyPMVT6PjqrRNY+mjL5gWI1/XBm2L8qhl3lRxFBXp4RkWhc7cfWP84cXzk2Ghgh/aJeFPl4WTMY65ZL/oqzkJ2wYSosMaiHltCvXRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661589; c=relaxed/simple;
	bh=HG95PQJVI3xsJX+xbET3uPBA3Y8W8WUTHh5Zwq0DNY8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cXDnWROKtw2sbTYXh927b4nC0nxUGUgDehyGVsAAN1lMVZ4pNoi4gN9oR5qI4B0Y0aW2oaTEll22DV3OycriIfRHeTR09ml+d7megfzNYfELc1r09l5n9EAMJNmE1XEfq8MNnC5JWIEMW65SxixQcdz1XvajlNaiHDUsoU2yAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-662f839d680so8386409eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 10:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661588; x=1771266388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHb1csLytyyiMKOXyYY5iKGtJrwFDhra+RzcW23fs9U=;
        b=f41iPXxPP7bgip+GtKJd3sMEiQTFoe2ZAno/LqJxAWd1zy/d/mE0QHC1T+WYp3V2aD
         zCUM9cHVQRQLOXh0pRDxAD9HIAnk3Ar6xaqScvSGgAhOuH5wBnB6A99ClsQsIX6ePUo3
         Bhmi6aCUxLOVit1WzmeWOMA/jo9/fw7uShjG8uY/tdkC2bUSJEAdYSuH5xeWzg718H6m
         gtalujqGKBM8hZ8UeUhrKehTSKrwn3cs7WjgCb8BzZuFdm3k5ZYZxC9uk5PCuXlXHvNN
         xgaRmo3ZzxzDDwIhJmIe2e4hE0EUL+qt0RmZn9Xzm0nJax/z4AHo73WBXs5R6lOqMSN0
         WvPw==
X-Forwarded-Encrypted: i=1; AJvYcCVqol5cl1ygFjCVmkvzJAxLVrRAn+8qnjnyv1KZatHDVSfbWHuigeokXs6fyrlYcZoGXTSbzbFKMU8Wtkfc@vger.kernel.org
X-Gm-Message-State: AOJu0YzphQhsiGgvPHs5ynnUQKDnxhsVY0aANxLCUc0xuj5G7Kh5h0rq
	MfsEDRiaDdHEZ6OuX91EMPgbUSznQoiaD0Hp6RX5gx2Ha0E7fEuC1b9kPb2Po/9TmoRgmBI1kJ+
	+mZBVFrNunVxLNTyJoOtLaZ+xUJwVLUCEV6Sl27kyTBprhWs8RtRkrRBAOF0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1614:b0:663:bad:9727 with SMTP id
 006d021491bc7-66d0d10b432mr5479618eaf.78.1770661587911; Mon, 09 Feb 2026
 10:26:27 -0800 (PST)
Date: Mon, 09 Feb 2026 10:26:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
Subject: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org, 
	jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76728-lists,linux-fsdevel=lfdr.de,cae7809e9dc1459e4e63];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,googlegroups.com:email,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC0C911385A
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    e7aa57247700 Merge tag 'spi-fix-v6.19-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122ae7fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130e2944580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/28d29c9b5ae2/disk-e7aa5724.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0683244c7a0f/vmlinux-e7aa5724.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd8cc5cb8b94/bzImage-e7aa5724.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f78f58e821b0/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10f7165a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888113218600 (size 512):
  comm "sed", pid 6046, jiffies 4294945902
  hex dump (first 32 bytes):
    00 8e 13 29 81 88 ff ff 00 12 86 27 81 88 ff ff  ...).......'....
    00 5a 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  .Z..............
  backtrace (crc 49909e19):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    alloc_empty_sheaf+0x36/0x50 mm/slub.c:2618
    __kfree_rcu_sheaf+0x155/0x210 mm/slub.c:6304
    kfree_rcu_sheaf mm/slab_common.c:1631 [inline]
    kvfree_call_rcu+0x202/0x3d0 mm/slab_common.c:1981
    ma_free_rcu lib/maple_tree.c:208 [inline]
    ma_free_rcu+0x29/0x40 lib/maple_tree.c:205
    mas_free lib/maple_tree.c:1174 [inline]
    mas_replace_node lib/maple_tree.c:1581 [inline]
    mas_wr_node_store+0x5fc/0x730 lib/maple_tree.c:3553
    mas_wr_store_entry+0x4eb/0x760 lib/maple_tree.c:3764
    mas_store_prealloc+0x358/0x740 lib/maple_tree.c:5169
    vma_iter_store_overwrite mm/vma.h:544 [inline]
    commit_merge+0x28e/0x490 mm/vma.c:763
    vma_expand+0x264/0x460 mm/vma.c:1200
    vma_merge_new_range+0xe3/0x350 mm/vma.c:1099
    __mmap_region+0x54b/0x15b0 mm/vma.c:2747
    mmap_region+0xfb/0x1e0 mm/vma.c:2830
    do_mmap+0x7ac/0xb80 mm/mmap.c:558
    vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
    ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604

BUG: memory leak
unreferenced object 0xffff888127861200 (size 512):
  comm "udevd", pid 6236, jiffies 4294948784
  hex dump (first 32 bytes):
    00 86 21 13 81 88 ff ff 18 e0 05 00 81 88 ff ff  ..!.............
    00 5a 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  .Z..............
  backtrace (crc 5b72581e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    alloc_empty_sheaf+0x36/0x50 mm/slub.c:2618
    __kfree_rcu_sheaf+0x155/0x210 mm/slub.c:6304
    kfree_rcu_sheaf mm/slab_common.c:1631 [inline]
    kvfree_call_rcu+0x202/0x3d0 mm/slab_common.c:1981
    ma_free_rcu lib/maple_tree.c:208 [inline]
    ma_free_rcu+0x29/0x40 lib/maple_tree.c:205
    mas_topiary_node lib/maple_tree.c:2311 [inline]
    mas_topiary_node lib/maple_tree.c:2299 [inline]
    mas_topiary_replace+0xb0f/0x1400 lib/maple_tree.c:2410
    mas_wmb_replace lib/maple_tree.c:2433 [inline]
    mas_spanning_rebalance+0x14e1/0x24b0 lib/maple_tree.c:2738
    mas_wr_spanning_store+0x983/0x10d0 lib/maple_tree.c:3479
    mas_wr_store_entry+0x4d5/0x760 lib/maple_tree.c:3767
    mas_store_gfp+0x341/0x640 lib/maple_tree.c:5138
    vma_iter_clear_gfp include/linux/mm.h:1141 [inline]
    do_vmi_align_munmap+0x259/0x2d0 mm/vma.c:1574
    do_vmi_munmap+0x17c/0x280 mm/vma.c:1627
    __vm_munmap+0xec/0x200 mm/vma.c:3247
    __do_sys_munmap mm/mmap.c:1077 [inline]
    __se_sys_munmap mm/mmap.c:1074 [inline]
    __x64_sys_munmap+0x1f/0x30 mm/mmap.c:1074
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812c458000 (size 4480):
  comm "udevd", pid 5181, jiffies 4294950983
  hex dump (first 32 bytes):
    01 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00  ................
  backtrace (crc ad4af9e6):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_node_noprof+0x422/0x590 mm/slub.c:5315
    alloc_task_struct_node kernel/fork.c:184 [inline]
    dup_task_struct kernel/fork.c:915 [inline]
    copy_process+0x286/0x2870 kernel/fork.c:2052
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881274a1540 (size 184):
  comm "udevd", pid 5181, jiffies 4294950983
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 54e589bc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x412/0x580 mm/slub.c:5270
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x2870 kernel/fork.c:2086
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888109639020 (size 32):
  comm "udevd", pid 5181, jiffies 4294950983
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 52 86 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
  backtrace (crc 336e1c5f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_cred_alloc security/security.c:209 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2763
    prepare_creds+0x395/0x600 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x2870 kernel/fork.c:2086
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888126fdbd80 (size 64):
  comm "udevd", pid 5181, jiffies 4294950983
  hex dump (first 32 bytes):
    c0 c3 4e 46 81 88 ff ff 00 00 00 00 00 00 00 00  ..NF............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 508a43e4):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x465/0x680 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_task_alloc security/security.c:244 [inline]
    security_task_alloc+0x2a/0x260 security/security.c:2682
    copy_process+0xf07/0x2870 kernel/fork.c:2203
    kernel_clone+0xac/0x6e0 kernel/fork.c:2651
    __do_sys_clone+0x7f/0xb0 kernel/fork.c:2792
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

