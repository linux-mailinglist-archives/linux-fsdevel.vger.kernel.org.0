Return-Path: <linux-fsdevel+bounces-79294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCaBBVlwp2kEhgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 00:35:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC421F8683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 00:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848F03088275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 23:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E556358D00;
	Tue,  3 Mar 2026 23:35:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C73537FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580938; cv=none; b=hSSI4bO+ZqFgY/NdkFMYAMXEgwkchszjyPEZ3QWMt8t3LP08fsF0C0ZDaBpeJQ+SBj6r2UIo6gZIK+RVJoVOgSdJpwaipbE/sbFhYyGfW+GsXrlTRJ+hlFZjGe8K+yYtWaBiucVJR//mrsMO2lS1IFWWP55SfHzrG1oxE0mwti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580938; c=relaxed/simple;
	bh=kVTnC0+56tfwA4HyP59iocW+Qy9UW8CTECYtbNRkRXM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=LinXnAACEVBlSzZ2hf6QrVhd6LUZIsKvHT99IOAwtNG+hBamHgTRISoS9PbZKfn8hwWLvqPIuNojeLNZ+LlWjrjj4bVzUOsXmp2/XBqA5I/1/L45Hz2ZC9sPZMa5v2H+maBdroi+GETLtrG8wajioX5KSu9x2ZyP6R6NAk+f/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d195fe3eb4so105487876a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 15:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580935; x=1773185735;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge7xU02yubf1DGANi/nBCzXv9dbYn3ROxI+6J8VSmQU=;
        b=Qc1MPY6sjgEZTD8jecdCYaplQYT9v4aCGbNF/4PVIf98dbxSszQGQo96oFZGZGCTce
         gpYfgPe+hk5XBkEjC2cbQgFOSDzmrFf3+iofaE8wI6FKtTiUeOEYp/DQ8/dTmh9IZeMT
         ZFHyAsTYdkroWoUVW06Zq+lBU66wApLS8ccy4MN26HP8XcmCK28hJPpJVwMEY5YLdxwI
         uRIh+y9ZNlN7ZZCb5LKo6RM7QjZrjWOREhqUNGpLY8HoSvwPpJFEaYwjoZeraeKjrBHq
         P+kk0CHBcj6okiZqxal+oUxizeaDcULMtpsBs8qop+LH75JRDpW3RECr89C5mi/+dM/N
         bvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvMyntGeX1itlc6ReVtsNce6cP0Lc14Kl2SXYsxmBeDkwzkrNJ/bfALhZnqPNMNTq4J79PC67XuJu2TZ+c@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhiNMaqOQ3T6uLdrpOAqWqEOLuUpMsz3y5n+O/CYWxl+aGno2
	VBYifWYt1hHcSdY/b4NbdNfaOnA4zwN3swffiIWYXsvt65aOPcKF0Gji2cwy0tUgRGCJh7v9YVK
	32WzFX43jVPQiEF/oEuCJZFCTT30US8lsuMuUWGv6ANQDiESeX9kW2GSLUbo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1798:b0:679:a57c:c84e with SMTP id
 006d021491bc7-67b176e76bamr197868eaf.5.1772580935135; Tue, 03 Mar 2026
 15:35:35 -0800 (PST)
Date: Tue, 03 Mar 2026 15:35:35 -0800
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a77047.050a0220.21ae90.0011.GAE@google.com>
Subject: [syzbot ci] Re: fs: Move metadata bh tracking from address_space
From: syzbot ci <syzbot+ciaf5532c890030251@syzkaller.appspotmail.com>
To: agruenba@redhat.com, aivazian.tigran@gmail.com, 
	almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, bcrl@kvack.org, 
	brauner@kernel.org, david@kernel.org, dsterba@suse.com, gfs2@lists.linux.dev, 
	hirofumi@mail.parknet.co.jp, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-aio@kvack.org, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	muchun.song@linux.dev, ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	osalvador@suse.de, tytso@mit.edu, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6CC421F8683
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79294-lists,linux-fsdevel=lfdr.de,ciaf5532c890030251];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,paragon-software.com,kernel.dk,kvack.org,kernel.org,suse.com,lists.linux.dev,mail.parknet.co.jp,suse.cz,evilplan.org,linux.alibaba.com,vger.kernel.org,linux.dev,suse.de,mit.edu,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.311];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] fs: Move metadata bh tracking from address_space
https://lore.kernel.org/all/20260303101717.27224-1-jack@suse.cz
* [PATCH 01/32] fat: Sync and invalidate metadata buffers from fat_evict_inode()
* [PATCH 02/32] udf: Sync and invalidate metadata buffers from udf_evict_inode()
* [PATCH 03/32] minix: Sync and invalidate metadata buffers from minix_evict_inode()
* [PATCH 04/32] ext2: Sync and invalidate metadata buffers from ext2_evict_inode()
* [PATCH 05/32] ext4: Sync and invalidate metadata buffers from ext4_evict_inode()
* [PATCH 06/32] ext4: Use inode_has_buffers()
* [PATCH 07/32] bfs: Sync and invalidate metadata buffers from bfs_evict_inode()
* [PATCH 08/32] affs: Sync and invalidate metadata buffers from affs_evict_inode()
* [PATCH 09/32] fs: Ignore inode metadata buffers in inode_lru_isolate()
* [PATCH 10/32] fs: Stop using i_private_data for metadata bh tracking
* [PATCH 11/32] gfs2: Don't zero i_private_data
* [PATCH 12/32] hugetlbfs: Stop using i_private_data
* [PATCH 13/32] aio: Stop using i_private_data and i_private_lock
* [PATCH 14/32] fs: Remove i_private_data
* [PATCH 15/32] fs: Drop osync_buffers_list()
* [PATCH 16/32] fs: Fold fsync_buffers_list() into sync_mapping_buffers()
* [PATCH 17/32] fs: Move metadata bhs tracking to a separate struct
* [PATCH 18/32] fs: Provide operation for fetching mapping_metadata_bhs
* [PATCH 19/32] ntfs3: Drop pointless sync_mapping_buffers() call
* [PATCH 20/32] ocfs2: Drop pointless sync_mapping_buffers() calls
* [PATCH 21/32] bdev: Drop pointless invalidate_mapping_buffers() call
* [PATCH 22/32] fs: Switch inode_has_buffers() to take mapping_metadata_bhs
* [PATCH 23/32] ext2: Track metadata bhs in fs-private inode part
* [PATCH 24/32] affs: Track metadata bhs in fs-private inode part
* [PATCH 25/32] bfs: Track metadata bhs in fs-private inode part
* [PATCH 26/32] fat: Track metadata bhs in fs-private inode part
* [PATCH 27/32] udf: Track metadata bhs in fs-private inode part
* [PATCH 28/32] minix: Track metadata bhs in fs-private inode part
* [PATCH 29/32] ext4: Track metadata bhs in fs-private inode part
* [PATCH 30/32] vfs: Drop mapping_metadata_bhs from address space
* [PATCH 31/32] kvm: Use private inode list instead of i_private_list
* [PATCH 32/32] fs: Drop i_private_list from address_space

and found the following issues:
* BUG: spinlock bad magic in region_del
* KASAN: slab-use-after-free Read in region_del
* general protection fault in mark_buffer_dirty_inode

Full report is available here:
https://ci.syzbot.org/series/3cf14b16-7f50-44ce-9f95-8ac4b86cf294

***

BUG: spinlock bad magic in region_del

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      f50c6ce7bf30099042dac755fbd1e97da456f5ec
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/e716ec88-6c00-48e7-868d-3f4cb3999d4b/config
syz repro: https://ci.syzbot.org/findings/0d1bc933-ce69-432e-a2d5-b2411fe4cfec/syz_repro

BUG: spinlock bad magic on CPU#0, syz.0.151/6273
 lock: 0xffff8881165dc808, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
CPU: 0 UID: 0 PID: 6273 Comm: syz.0.151 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 spin_bug kernel/locking/spinlock_debug.c:78 [inline]
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x1e5/0x2f0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:341 [inline]
 region_del+0xbe/0x950 mm/hugetlb.c:863
 hugetlb_unreserve_pages+0xfa/0x230 mm/hugetlb.c:6757
 remove_inode_hugepages+0x1036/0x11a0 fs/hugetlbfs/inode.c:613
 hugetlbfs_evict_inode+0xaf/0x260 fs/hugetlbfs/inode.c:623
 evict+0x61e/0xb10 fs/inode.c:841
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 do_one_tree fs/dcache.c:1657 [inline]
 shrink_dcache_for_umount+0xe1/0x1f0 fs/dcache.c:1671
 generic_shutdown_super+0x6f/0x2d0 fs/super.c:624
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e0f19c799
Code: Unable to access opcode bytes at 0x7f6e0f19c76f.
RSP: 002b:00007f6e101360e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f6e0f415fa8 RCX: 00007f6e0f19c799
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f6e0f415fa8
RBP: 00007f6e0f415fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6e0f416038 R14: 00007fff1de1a520 R15: 00007fff1de1a608
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 6273 Comm: syz.0.151 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:region_del+0x108/0x950 mm/hugetlb.c:864
Code: 24 20 49 29 c4 4c 03 23 48 89 03 48 8b 5c 24 40 4c 39 eb 0f 84 64 05 00 00 e8 74 c0 9c ff 4c 89 64 24 10 49 89 df 49 c1 ef 03 <41> 80 3c 2f 00 74 08 48 89 df e8 b9 d8 06 00 48 8b 03 48 89 44 24
RSP: 0018:ffffc90003b17330 EFLAGS: 00010246
RAX: a69e65823ec40000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90003b172a0
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000762e54 R12: 0000000000000000
R13: ffff8881165dc848 R14: 1ffff11022cbb909 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88818de67000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc23744ea7c CR3: 000000000e54c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 hugetlb_unreserve_pages+0xfa/0x230 mm/hugetlb.c:6757
 remove_inode_hugepages+0x1036/0x11a0 fs/hugetlbfs/inode.c:613
 hugetlbfs_evict_inode+0xaf/0x260 fs/hugetlbfs/inode.c:623
 evict+0x61e/0xb10 fs/inode.c:841
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 do_one_tree fs/dcache.c:1657 [inline]
 shrink_dcache_for_umount+0xe1/0x1f0 fs/dcache.c:1671
 generic_shutdown_super+0x6f/0x2d0 fs/super.c:624
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e0f19c799
Code: Unable to access opcode bytes at 0x7f6e0f19c76f.
RSP: 002b:00007f6e101360e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f6e0f415fa8 RCX: 00007f6e0f19c799
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f6e0f415fa8
RBP: 00007f6e0f415fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6e0f416038 R14: 00007fff1de1a520 R15: 00007fff1de1a608
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:region_del+0x108/0x950 mm/hugetlb.c:864
Code: 24 20 49 29 c4 4c 03 23 48 89 03 48 8b 5c 24 40 4c 39 eb 0f 84 64 05 00 00 e8 74 c0 9c ff 4c 89 64 24 10 49 89 df 49 c1 ef 03 <41> 80 3c 2f 00 74 08 48 89 df e8 b9 d8 06 00 48 8b 03 48 89 44 24
RSP: 0018:ffffc90003b17330 EFLAGS: 00010246
RAX: a69e65823ec40000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90003b172a0
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000762e54 R12: 0000000000000000
R13: ffff8881165dc848 R14: 1ffff11022cbb909 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88818de67000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc23744ea7c CR3: 000000000e54c000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	24 20                	and    $0x20,%al
   2:	49 29 c4             	sub    %rax,%r12
   5:	4c 03 23             	add    (%rbx),%r12
   8:	48 89 03             	mov    %rax,(%rbx)
   b:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
  10:	4c 39 eb             	cmp    %r13,%rbx
  13:	0f 84 64 05 00 00    	je     0x57d
  19:	e8 74 c0 9c ff       	call   0xff9cc092
  1e:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
  23:	49 89 df             	mov    %rbx,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	41 80 3c 2f 00       	cmpb   $0x0,(%r15,%rbp,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 b9 d8 06 00       	call   0x6d8f2
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


***

KASAN: slab-use-after-free Read in region_del

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      f50c6ce7bf30099042dac755fbd1e97da456f5ec
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/e716ec88-6c00-48e7-868d-3f4cb3999d4b/config
syz repro: https://ci.syzbot.org/findings/df3f89db-a2df-4664-973c-472164179e0a/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
Read of size 1 at addr ffff888114425020 by task syz.2.313/6592

CPU: 0 UID: 0 PID: 6592 Comm: syz.2.313 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x79/0x2e0 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:341 [inline]
 region_del+0xbe/0x950 mm/hugetlb.c:863
 hugetlb_unreserve_pages+0xfa/0x230 mm/hugetlb.c:6757
 remove_inode_hugepages+0x1036/0x11a0 fs/hugetlbfs/inode.c:613
 hugetlbfs_evict_inode+0xaf/0x260 fs/hugetlbfs/inode.c:623
 evict+0x61e/0xb10 fs/inode.c:841
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 do_one_tree fs/dcache.c:1657 [inline]
 shrink_dcache_for_umount+0xe1/0x1f0 fs/dcache.c:1671
 generic_shutdown_super+0x6f/0x2d0 fs/super.c:624
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6b41f9c799
Code: Unable to access opcode bytes at 0x7f6b41f9c76f.
RSP: 002b:00007f6b42db90e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f6b42215fa8 RCX: 00007f6b41f9c799
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f6b42215fa8
RBP: 00007f6b42215fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6b42216038 R14: 00007ffd7b00f490 R15: 00007ffd7b00f578
 </TASK>

Allocated by task 6005:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5339
 kmalloc_noprof include/linux/slab.h:962 [inline]
 resv_map_alloc+0x51/0x2c0 mm/hugetlb.c:1108
 hugetlbfs_get_inode+0x5d/0x680 fs/hugetlbfs/inode.c:932
 hugetlbfs_mknod fs/hugetlbfs/inode.c:987 [inline]
 hugetlbfs_create+0x59/0xf0 fs/hugetlbfs/inode.c:1009
 lookup_open fs/namei.c:4483 [inline]
 open_last_lookups fs/namei.c:4583 [inline]
 path_openat+0x1395/0x3860 fs/namei.c:4827
 do_file_open+0x23e/0x4a0 fs/namei.c:4859
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_creat fs/open.c:1450 [inline]
 __se_sys_creat fs/open.c:1444 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1444
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6005:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2687 [inline]
 slab_free mm/slub.c:6124 [inline]
 kfree+0x1c1/0x630 mm/slub.c:6442
 hugetlbfs_evict_inode+0xe1/0x260 fs/hugetlbfs/inode.c:628
 evict+0x61e/0xb10 fs/inode.c:841
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1147
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1174
 shrink_dcache_tree+0xcf/0x310 fs/dcache.c:-1
 do_one_tree fs/dcache.c:1654 [inline]
 shrink_dcache_for_umount+0xa8/0x1f0 fs/dcache.c:1671
 generic_shutdown_super+0x6f/0x2d0 fs/super.c:624
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x69b/0x2320 kernel/exit.c:971
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 get_signal+0x1284/0x1330 kernel/signal.c:3034
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x86/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888114425000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 32 bytes inside of
 freed 512-byte region [ffff888114425000, ffff888114425200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888114424000 pfn:0x114424
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x17ff00000000240(workingset|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000240 ffff888100041c80 ffffea00044b8a10 ffffea0004539010
raw: ffff888114424000 0000000000100009 00000000f5000000 0000000000000000
head: 017ff00000000240 ffff888100041c80 ffffea00044b8a10 ffffea0004539010
head: ffff888114424000 0000000000100009 00000000f5000000 0000000000000000
head: 017ff00000000002 ffffea0004510901 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5267, tgid 5267 (udevd), ts 28927219244, free_ts 28922963584
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3255 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3444
 new_slab mm/slub.c:3502 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7134
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2b9/0x620 mm/slub.c:4578
 alloc_from_pcs mm/slub.c:4681 [inline]
 slab_alloc_node mm/slub.c:4815 [inline]
 __kmalloc_cache_noprof+0x392/0x660 mm/slub.c:5334
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1200 [inline]
 kernfs_fop_open+0x397/0xca0 fs/kernfs/file.c:641
 do_dentry_open+0x785/0x14e0 fs/open.c:949
 vfs_open+0x3b/0x340 fs/open.c:1081
 do_open fs/namei.c:4671 [inline]
 path_openat+0x2e08/0x3860 fs/namei.c:4830
 do_file_open+0x23e/0x4a0 fs/namei.c:4859
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5265 tgid 5265 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __slab_free+0x263/0x2b0 mm/slub.c:5532
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4501 [inline]
 slab_alloc_node mm/slub.c:4830 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4837
 lsm_inode_alloc security/security.c:228 [inline]
 security_inode_alloc+0x39/0x310 security/security.c:1189
 inode_init_always_gfp+0x9c8/0xda0 fs/inode.c:305
 inode_init_always include/linux/fs.h:2925 [inline]
 alloc_inode+0x82/0x1b0 fs/inode.c:352
 iget_locked+0x131/0x6a0 fs/inode.c:1474
 kernfs_get_inode+0x4f/0x780 fs/kernfs/inode.c:253
 kernfs_iop_lookup+0x1fe/0x320 fs/kernfs/dir.c:1241
 __lookup_slow+0x2b7/0x410 fs/namei.c:1916
 lookup_slow+0x53/0x70 fs/namei.c:1933
 walk_component fs/namei.c:2279 [inline]
 lookup_last fs/namei.c:2780 [inline]
 path_lookupat+0x3f5/0x8c0 fs/namei.c:2804
 filename_lookup+0x256/0x5d0 fs/namei.c:2833

Memory state around the buggy address:
 ffff888114424f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888114424f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888114425000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888114425080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888114425100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

general protection fault in mark_buffer_dirty_inode

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      f50c6ce7bf30099042dac755fbd1e97da456f5ec
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/e716ec88-6c00-48e7-868d-3f4cb3999d4b/config
C repro:   https://ci.syzbot.org/findings/670a21ca-1447-4fda-909b-5098c9c0cdd9/c_repro
syz repro: https://ci.syzbot.org/findings/670a21ca-1447-4fda-909b-5098c9c0cdd9/syz_repro

EXT4-fs (loop0): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 r/w without journal. Quota mode: none.
ext4 filesystem being mounted at /0/mnt supports timestamps until 2038-01-19 (0x7fffffff)
fscrypt: AES-256-CBC-CTS using implementation "cts(cbc(ecb(aes-lib)))"
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 5946 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 79 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 40 6a 80 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90003c9f380 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffffff8bafae9e RCX: 0000000080000002
RDX: 0000000000000000 RSI: ffffffff8bafae9e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff2023057 R12: 0000000000000000
R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000001
FS:  0000555590824500(0000) GS:ffff8882a9467000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e763fff CR3: 000000016fa5e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x79/0x2e0 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:341 [inline]
 mark_buffer_dirty_inode+0xe3/0x2f0 fs/buffer.c:748
 __ext4_handle_dirty_metadata+0x27a/0x810 fs/ext4/ext4_jbd2.c:393
 ext4_xattr_block_set+0x24ff/0x2ad0 fs/ext4/xattr.c:2168
 ext4_xattr_set_handle+0xe34/0x14c0 fs/ext4/xattr.c:2457
 ext4_set_context+0x233/0x560 fs/ext4/crypto.c:166
 fscrypt_set_context+0x397/0x460 fs/crypto/policy.c:791
 __ext4_new_inode+0x3158/0x3d20 fs/ext4/ialloc.c:1314
 ext4_symlink+0x3ac/0xb90 fs/ext4/namei.c:3386
 vfs_symlink+0x195/0x340 fs/namei.c:5615
 filename_symlinkat+0x1cd/0x410 fs/namei.c:5640
 __do_sys_symlink fs/namei.c:5667 [inline]
 __se_sys_symlink+0x4d/0x2b0 fs/namei.c:5663
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe222b9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf34afb88 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00007fe222e15fa0 RCX: 00007fe222b9c799
RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000200000000080
RBP: 00007fe222c32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe222e15fac R14: 00007fe222e15fa0 R15: 00007fe222e15fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 79 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 40 6a 80 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90003c9f380 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffffff8bafae9e RCX: 0000000080000002
RDX: 0000000000000000 RSI: ffffffff8bafae9e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff2023057 R12: 0000000000000000
R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000001
FS:  0000555590824500(0000) GS:ffff8882a9467000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e763fff CR3: 000000016fa5e000 CR4: 00000000000006f0
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	0f 1f 40 00          	nopl   0x0(%rax)
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  18:	48 c1 ef 03          	shr    $0x3,%rdi
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
* 26:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2a:	3c 08                	cmp    $0x8,%al
  2c:	0f 92 c0             	setb   %al
  2f:	e9 40 6a 80 09       	jmp    0x9806a74
  34:	cc                   	int3
  35:	66                   	data16
  36:	66                   	data16
  37:	66                   	data16
  38:	66                   	data16
  39:	66                   	data16
  3a:	66                   	data16
  3b:	2e                   	cs


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

