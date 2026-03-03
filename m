Return-Path: <linux-fsdevel+bounces-79121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKjxFj+SpmnxRAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 08:48:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC51EA5AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 08:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2B39302C76A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8663845BF;
	Tue,  3 Mar 2026 07:48:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0225F7A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524082; cv=none; b=ROomIb3huvoVSQGky5B2zy6LbcaRy0ZsPGSIEuZEEM9MHIQWI6jKv+EBnIwG7uNct7yRXaNH2D1QviglT7VYdrvb89q+0o4bkYFPW81+IVRyH/a9q/A/1eZwAVFYQ1ZuTtwEPnXJhvfGvQRAQV1BTaoBLjefySODgksC7w2q25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524082; c=relaxed/simple;
	bh=PryYiRm7m4CL8+3XZlvd0rdRGUP5bNRl9ZInxLdgC/Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=SWjdVO9LIJ/zOUpDiQlXKTwrKuZvR9RUwnUDWirPitHT8rGTk7MdbigHHuJlh/So4iN4/xvPvWxBItz5QQJ+RfKES9ff5WpCQp9N9MAaq6HjMABPr+Wx6NskzAJ2BWv0P2JcNB4gcnt7ayq6ISekAGMpJUROln/07ZV/QGyLoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679c978c609so44048568eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 23:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772524075; x=1773128875;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scK59keY/cdU6zkX1nVuCmRk+gCP5uPE2KYVk3Neojs=;
        b=nfugTe3UVY6FmK5lXgwmMRfKCYeEjur2z+/HZNox1s+TW4dLfmtHYAf0xj4JgXOSoM
         B/CRMCfAuul7+4Htfs8ILfZRmXaAawjqf8yj1uFr/wFqul5H6a99E4zOARkSFLFuuJmO
         AOqQYj8zWnf9OzJhPlhX03k3C/mRRdRZAPfyrcwUTyoQ+kGfwipk6gSGbsE7ktqTj9gM
         irPkiAwvMhPrc8FJgU6L2cJB8gnhR5EQxMdWi1+p8ND1c0YZcer4h5GL98WxtnD465iG
         lO30hsHRI/3v6mYKwck9SxO+4rSCOb5NlV+BcR584uUKS77OZjJMnM9wD/K4Lp0Ts9ry
         np5w==
X-Forwarded-Encrypted: i=1; AJvYcCWphpF+IAkh0aeMg+yKQZ+rLMr8o3dDkEG9GUq4FZka634juhT9MpP29TfHT/apEeWmdhINMiUwOPmDisVN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1siN9GJ7buLPHa0QMKMs55FNVkGTtIIYK7XpyAsWuUAWWvFrL
	dpetTvfRLc4szeaTz2Uff/YlR23fVi4gmen/jg01+tlIAbPAoTvTknk+jMLrDDIJEMd7m83ccRH
	FfJOZlbjSAZLaJkBZxzTxYQSDCXF8e2Newypbuld9fpy0hf61uj3b2FgN3yY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c94:b0:67a:1c77:4bc9 with SMTP id
 006d021491bc7-67a1c77519dmr1250435eaf.24.1772524074855; Mon, 02 Mar 2026
 23:47:54 -0800 (PST)
Date: Mon, 02 Mar 2026 23:47:54 -0800
In-Reply-To: <tencent_13E236704A527419766767443D6736EE9609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a6922a.050a0220.21ae90.0005.GAE@google.com>
Subject: [syzbot ci] Re: ext4: avoid infinite loops caused by data conflicts
From: syzbot ci <syzbot+ciae141d84d9b3e0d1@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot@lists.linux.dev, 
	syzbot@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E7FC51EA5AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79121-lists,linux-fsdevel=lfdr.de,ciae141d84d9b3e0d1];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,qq.com,suse.cz,vger.kernel.org,lists.linux.dev,syzkaller.appspotmail.com,googlegroups.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.741];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email,googlegroups.com:email,syzbot.org:url]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v2] ext4: avoid infinite loops caused by data conflicts
https://lore.kernel.org/all/tencent_13E236704A527419766767443D6736EE9609@qq.com
* [PATCH v2] ext4: avoid infinite loops caused by data conflicts

and found the following issues:
* KASAN: slab-out-of-bounds Read in ext4_xattr_block_csum_set
* KASAN: slab-use-after-free Read in ext4_xattr_block_csum_set
* KASAN: slab-use-after-free Read in ext4_xattr_set_entry
* KASAN: use-after-free Read in ext4_xattr_block_csum_set
* KASAN: use-after-free Read in ext4_xattr_set_entry

Full report is available here:
https://ci.syzbot.org/series/ccbb03e4-9312-48f0-808d-923f86d83f2f

***

KASAN: slab-out-of-bounds Read in ext4_xattr_block_csum_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      11439c4635edd669ae435eec308f4ab8a0804808
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/330c6289-adc9-452b-b12f-000d32045593/config
syz repro: https://ci.syzbot.org/findings/ddaf8105-c8d7-4a57-87ef-ee750875c5c7/syz_repro

fscrypt: AES-256-CBC-CTS using implementation "cts(cbc(ecb(aes-lib)))"
==================================================================
BUG: KASAN: slab-out-of-bounds in crc32c_base lib/crc/crc32-main.c:54 [inline]
BUG: KASAN: slab-out-of-bounds in crc32c_arch lib/crc/x86/crc32.h:44 [inline]
BUG: KASAN: slab-out-of-bounds in crc32c+0x3cc/0x470 lib/crc/crc32-main.c:86
Read of size 1 at addr ffff88816a0ea0b0 by task syz.0.17/6006

CPU: 1 UID: 0 PID: 6006 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 crc32c_base lib/crc/crc32-main.c:54 [inline]
 crc32c_arch lib/crc/x86/crc32.h:44 [inline]
 crc32c+0x3cc/0x470 lib/crc/crc32-main.c:86
 ext4_chksum fs/ext4/ext4.h:2553 [inline]
 ext4_xattr_block_csum fs/ext4/xattr.c:147 [inline]
 ext4_xattr_block_csum_set+0x241/0x330 fs/ext4/xattr.c:172
 ext4_xattr_block_set+0x2494/0x2b00 fs/ext4/xattr.c:2165
 ext4_xattr_set_handle+0xe37/0x14d0 fs/ext4/xattr.c:2458
 ext4_set_context+0x233/0x560 fs/ext4/crypto.c:166
 fscrypt_set_context+0x397/0x460 fs/crypto/policy.c:791
 __ext4_new_inode+0x3158/0x3d20 fs/ext4/ialloc.c:1314
 ext4_mkdir+0x3da/0xbf0 fs/ext4/namei.c:3005
 vfs_mkdir+0x413/0x630 fs/namei.c:5233
 filename_mkdirat+0x285/0x510 fs/namei.c:5266
 __do_sys_mkdirat fs/namei.c:5287 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5284
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb60ad9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb60bd17028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fb60b015fa0 RCX: 00007fb60ad9c799
RDX: 00000000000001c0 RSI: 0000200000000180 RDI: ffffffffffffff9c
RBP: 00007fb60ae32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb60b016038 R14: 00007fb60b015fa0 R15: 00007fff4bbf7228
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4515 [inline]
 slab_alloc_node mm/slub.c:4844 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4851
 __kernfs_new_node+0xe9/0x8e0 fs/kernfs/dir.c:637
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 __kernfs_create_file+0x4b/0x2e0 fs/kernfs/file.c:1057
 sysfs_add_file_mode_ns+0x238/0x300 fs/sysfs/file.c:313
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x673/0x1180 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:229 [inline]
 sysfs_create_groups+0x59/0x120 fs/sysfs/group.c:255
 device_add_groups drivers/base/core.c:2836 [inline]
 device_add_attrs+0xdd/0x5b0 drivers/base/core.c:2900
 device_add+0x496/0xb70 drivers/base/core.c:3643
 __video_register_device+0x3e40/0x4d20 drivers/media/v4l2-core/v4l2-dev.c:1076
 video_register_device include/media/v4l2-dev.h:390 [inline]
 vivid_create_devnodes+0xc5e/0x2bf0 drivers/media/test-drivers/vivid/vivid-core.c:1471
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:2042 [inline]
 vivid_probe+0x510d/0x72b0 drivers/media/test-drivers/vivid/vivid-core.c:2095
 platform_probe+0xf9/0x190 drivers/base/platform.c:1446
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:661
 __driver_probe_device+0x18c/0x320 drivers/base/dd.c:803
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:833
 __driver_attach+0x3e7/0x710 drivers/base/dd.c:1227
 bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
 bus_add_driver+0x345/0x670 drivers/base/bus.c:715
 driver_register+0x23a/0x320 drivers/base/driver.c:249
 vivid_init+0x561/0x5f0 drivers/media/test-drivers/vivid/vivid-core.c:2294
 do_one_initcall+0x250/0x8d0 init/main.c:1382
 do_initcall_level+0x104/0x190 init/main.c:1444
 do_initcalls+0x59/0xa0 init/main.c:1460
 kernel_init_freeable+0x2a6/0x3e0 init/main.c:1692
 kernel_init+0x1d/0x1d0 init/main.c:1582
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88816a0ea000
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 0 bytes to the right of
 allocated 176-byte region [ffff88816a0ea000, ffff88816a0ea0b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16a0ea
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff8881012d3dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000800110011 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 19200276917, free_ts 4632825873
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3269 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3458
 new_slab mm/slub.c:3516 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7153
 refill_sheaf mm/slub.c:2818 [inline]
 __pcs_replace_empty_main+0x2b9/0x620 mm/slub.c:4592
 alloc_from_pcs mm/slub.c:4695 [inline]
 slab_alloc_node mm/slub.c:4829 [inline]
 kmem_cache_alloc_noprof+0x37d/0x650 mm/slub.c:4851
 __kernfs_new_node+0xe9/0x8e0 fs/kernfs/dir.c:637
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 kernfs_create_link+0xa7/0x200 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x83/0x110 fs/sysfs/symlink.c:44
 device_create_sys_dev_entry+0x122/0x190 drivers/base/core.c:3515
 device_add+0x733/0xb70 drivers/base/core.c:3659
 cdev_device_add+0x1d6/0x390 fs/char_dev.c:553
 media_devnode_register+0x287/0x420 drivers/media/mc/mc-devnode.c:247
 __media_device_register+0x15c/0x3c0 drivers/media/mc/mc-device.c:753
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3398
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88816a0e9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88816a0ea000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88816a0ea080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00
                                     ^
 ffff88816a0ea100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88816a0ea180: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================


***

KASAN: slab-use-after-free Read in ext4_xattr_block_csum_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      11439c4635edd669ae435eec308f4ab8a0804808
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/330c6289-adc9-452b-b12f-000d32045593/config
C repro:   https://ci.syzbot.org/findings/bee8f041-a020-4e43-a068-e014486583d9/c_repro
syz repro: https://ci.syzbot.org/findings/bee8f041-a020-4e43-a068-e014486583d9/syz_repro

ext4 filesystem being mounted at /0/file0 supports timestamps until 2038-01-19 (0x7fffffff)
fscrypt: AES-256-CBC-CTS using implementation "cts(cbc(ecb(aes-lib)))"
==================================================================
BUG: KASAN: slab-use-after-free in crc32c_base lib/crc/crc32-main.c:54 [inline]
BUG: KASAN: slab-use-after-free in crc32c_arch lib/crc/x86/crc32.h:44 [inline]
BUG: KASAN: slab-use-after-free in crc32c+0x3cc/0x470 lib/crc/crc32-main.c:86
Read of size 1 at addr ffff88816c2f9000 by task syz.0.17/5966

CPU: 0 UID: 0 PID: 5966 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 crc32c_base lib/crc/crc32-main.c:54 [inline]
 crc32c_arch lib/crc/x86/crc32.h:44 [inline]
 crc32c+0x3cc/0x470 lib/crc/crc32-main.c:86
 ext4_chksum fs/ext4/ext4.h:2553 [inline]
 ext4_xattr_block_csum fs/ext4/xattr.c:147 [inline]
 ext4_xattr_block_csum_set+0x241/0x330 fs/ext4/xattr.c:172
 ext4_xattr_block_set+0x2494/0x2b00 fs/ext4/xattr.c:2165
 ext4_xattr_set_handle+0xe37/0x14d0 fs/ext4/xattr.c:2458
 ext4_set_context+0x233/0x560 fs/ext4/crypto.c:166
 fscrypt_set_context+0x397/0x460 fs/crypto/policy.c:791
 __ext4_new_inode+0x3158/0x3d20 fs/ext4/ialloc.c:1314
 ext4_mkdir+0x3da/0xbf0 fs/ext4/namei.c:3005
 vfs_mkdir+0x413/0x630 fs/namei.c:5233
 filename_mkdirat+0x285/0x510 fs/namei.c:5266
 __do_sys_mkdir fs/namei.c:5293 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5290
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb91ff9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3b8b33f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007fb920215fa0 RCX: 00007fb91ff9c799
RDX: 0000000000000000 RSI: 0000000000000142 RDI: 0000200000000300
RBP: 00007fb920032bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb920215fac R14: 00007fb920215fa0 R15: 00007fb920215fa0
 </TASK>

Allocated by task 5807:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5358
 kmalloc_noprof include/linux/slab.h:950 [inline]
 slab_free_hook mm/slub.c:2644 [inline]
 slab_free mm/slub.c:6143 [inline]
 kmem_cache_free+0x15b/0x630 mm/slub.c:6273
 anon_vma_free mm/rmap.c:137 [inline]
 __put_anon_vma+0x12b/0x2d0 mm/rmap.c:2889
 put_anon_vma mm/internal.h:215 [inline]
 unlink_anon_vmas+0x58b/0x730 mm/rmap.c:529
 free_pgtables+0x663/0xb70 mm/memory.c:414
 exit_mmap+0x490/0xa10 mm/mmap.c:1314
 __mmput+0x118/0x430 kernel/fork.c:1174
 exec_mmap+0x3b4/0x440 fs/exec.c:893
 begin_new_exec+0x134a/0x24a0 fs/exec.c:1148
 load_elf_binary+0xa47/0x2980 fs/binfmt_elf.c:1011
 search_binary_handler fs/exec.c:1664 [inline]
 exec_binprm fs/exec.c:1696 [inline]
 bprm_execve+0x93d/0x1460 fs/exec.c:1748
 do_execveat_common+0x50d/0x690 fs/exec.c:1846
 __do_sys_execve fs/exec.c:1930 [inline]
 __se_sys_execve fs/exec.c:1924 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:1924
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5807:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2692 [inline]
 slab_free mm/slub.c:6143 [inline]
 kfree+0x1c1/0x630 mm/slub.c:6461
 slab_free_after_rcu_debug+0x5e/0x220 mm/slub.c:6195
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 slab_free_hook mm/slub.c:2656 [inline]
 slab_free mm/slub.c:6143 [inline]
 kmem_cache_free+0x439/0x630 mm/slub.c:6273
 anon_vma_free mm/rmap.c:137 [inline]
 __put_anon_vma+0x12b/0x2d0 mm/rmap.c:2889
 put_anon_vma mm/internal.h:215 [inline]
 unlink_anon_vmas+0x58b/0x730 mm/rmap.c:529
 free_pgtables+0x663/0xb70 mm/memory.c:414
 exit_mmap+0x490/0xa10 mm/mmap.c:1314
 __mmput+0x118/0x430 kernel/fork.c:1174
 exec_mmap+0x3b4/0x440 fs/exec.c:893
 begin_new_exec+0x134a/0x24a0 fs/exec.c:1148
 load_elf_binary+0xa47/0x2980 fs/binfmt_elf.c:1011
 search_binary_handler fs/exec.c:1664 [inline]
 exec_binprm fs/exec.c:1696 [inline]
 bprm_execve+0x93d/0x1460 fs/exec.c:1748
 do_execveat_common+0x50d/0x690 fs/exec.c:1846
 __do_sys_execve fs/exec.c:1930 [inline]
 __se_sys_execve fs/exec.c:1924 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:1924
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88816c2f9000
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff88816c2f9000, ffff88816c2f9020)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16c2f9
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff888100041780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5807, tgid 5807 (sshd), ts 57508476883, free_ts 57508008939
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3269 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3458
 new_slab mm/slub.c:3516 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7153
 refill_sheaf mm/slub.c:2818 [inline]
 __pcs_replace_empty_main+0x2b9/0x620 mm/slub.c:4592
 alloc_from_pcs mm/slub.c:4695 [inline]
 slab_alloc_node mm/slub.c:4829 [inline]
 __do_kmalloc_node mm/slub.c:5237 [inline]
 __kvmalloc_node_noprof+0x657/0x8a0 mm/slub.c:6730
 proc_sys_call_handler+0x3d1/0x830 fs/proc/proc_sysctl.c:583
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x582/0xa70 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5807 tgid 5807 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 tlb_batch_list_free mm/mmu_gather.c:161 [inline]
 tlb_finish_mmu+0x144/0x230 mm/mmu_gather.c:533
 unmap_region+0x2a5/0x330 mm/vma.c:488
 vms_clear_ptes mm/vma.c:1284 [inline]
 vms_complete_munmap_vmas+0x493/0xc60 mm/vma.c:1326
 do_vmi_align_munmap+0x3b7/0x4b0 mm/vma.c:1585
 do_vmi_munmap+0x252/0x2d0 mm/vma.c:1633
 __vm_munmap+0x22c/0x3d0 mm/vma.c:3254
 __do_sys_munmap mm/mmap.c:1078 [inline]
 __se_sys_munmap mm/mmap.c:1075 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1075
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88816c2f8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88816c2f8f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88816c2f9000: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff88816c2f9080: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88816c2f9100: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


***

KASAN: slab-use-after-free Read in ext4_xattr_set_entry

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      11439c4635edd669ae435eec308f4ab8a0804808
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/330c6289-adc9-452b-b12f-000d32045593/config
syz repro: https://ci.syzbot.org/findings/703aaa0c-3de2-4301-b1d3-6310fbf18b70/syz_repro

==================================================================
BUG: KASAN: slab-use-after-free in ext4_xattr_set_entry+0x179e/0x1e20 fs/ext4/xattr.c:1740
Read of size 260 at addr ffff88811a37e000 by task syz.2.19/5991

CPU: 0 UID: 0 PID: 5991 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 ext4_xattr_set_entry+0x179e/0x1e20 fs/ext4/xattr.c:1740
 ext4_xattr_block_set+0x636/0x2b00 fs/ext4/xattr.c:1961
 ext4_xattr_set_handle+0xdc2/0x14d0 fs/ext4/xattr.c:2432
 ext4_xattr_set+0x255/0x340 fs/ext4/xattr.c:2560
 __vfs_removexattr+0x431/0x470 fs/xattr.c:518
 __vfs_removexattr_locked+0xe2/0x280 fs/xattr.c:553
 vfs_removexattr+0x7f/0x230 fs/xattr.c:575
 ovl_do_removexattr fs/overlayfs/overlayfs.h:335 [inline]
 ovl_removexattr fs/overlayfs/overlayfs.h:343 [inline]
 ovl_make_workdir fs/overlayfs/super.c:760 [inline]
 ovl_get_workdir fs/overlayfs/super.c:840 [inline]
 ovl_fill_super_creds fs/overlayfs/super.c:1453 [inline]
 ovl_fill_super+0x4c09/0x5e00 fs/overlayfs/super.c:1564
 vfs_get_super fs/super.c:1327 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1346
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7facfdf9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007facfd5fe028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007facfe215fa0 RCX: 00007facfdf9c799
RDX: 0000200000000440 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 00007facfe032bd9 R08: 0000200000000280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007facfe216038 R14: 00007facfe215fa0 R15: 00007ffdb6825fe8
 </TASK>

Allocated by task 5825:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4515 [inline]
 slab_alloc_node mm/slub.c:4844 [inline]
 kmem_cache_alloc_noprof+0x2bc/0x650 mm/slub.c:4851
 __kernfs_new_node+0xe9/0x8e0 fs/kernfs/dir.c:637
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 __kernfs_create_file+0x4b/0x2e0 fs/kernfs/file.c:1057
 sysfs_add_file_mode_ns+0x238/0x300 fs/sysfs/file.c:313
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x673/0x1180 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:229 [inline]
 sysfs_create_groups+0x59/0x120 fs/sysfs/group.c:255
 device_add_groups drivers/base/core.c:2836 [inline]
 device_add_attrs+0xdd/0x5b0 drivers/base/core.c:2900
 device_add+0x496/0xb70 drivers/base/core.c:3643
 netdev_register_kobject+0x178/0x310 net/core/net-sysfs.c:2358
 register_netdevice+0x12c0/0x1cf0 net/core/dev.c:11422
 __ip_tunnel_create+0x3e8/0x560 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x2e7/0x840 net/ipv4/ip_tunnel.c:1147
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0x118/0x340 net/core/net_namespace.c:446
 copy_net_ns+0x50e/0x730 net/core/net_namespace.c:581
 create_new_namespaces+0x3e7/0x6a0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0x11a/0x160 kernel/nsproxy.c:226
 ksys_unshare+0x51d/0x930 kernel/fork.c:3174
 __do_sys_unshare kernel/fork.c:3245 [inline]
 __se_sys_unshare kernel/fork.c:3243 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3243
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2692 [inline]
 slab_free mm/slub.c:6143 [inline]
 kmem_cache_free+0x187/0x630 mm/slub.c:6273
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 kernfs_put+0x18e/0x470 fs/kernfs/dir.c:591
 kernfs_remove_by_name_ns+0xb7/0x130 fs/kernfs/dir.c:1723
 kernfs_remove_by_name include/linux/kernfs.h:633 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xfc/0x2e0 fs/sysfs/group.c:328
 sysfs_remove_groups+0x54/0xb0 fs/sysfs/group.c:352
 device_remove_groups drivers/base/core.c:2843 [inline]
 device_remove_attrs+0x229/0x280 drivers/base/core.c:2979
 device_del+0x51f/0x8f0 drivers/base/core.c:3877
 unregister_netdevice_many_notify+0x1e0e/0x2370 net/core/dev.c:12447
 ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
 ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248
 cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88811a37e000
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 0 bytes inside of
 freed 176-byte region [ffff88811a37e000, ffff88811a37e0b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811a37ee10 pfn:0x11a37e
flags: 0x17ff00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 017ff00000000200 ffff8881012d3dc0 ffffea000468fed0 ffffea000468df10
raw: ffff88811a37ee10 000000080011000a 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5822, tgid 5822 (syz-executor), ts 67128981798, free_ts 62919905097
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3269 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3458
 new_slab mm/slub.c:3516 [inline]
 refill_objects+0x331/0x3c0 mm/slub.c:7153
 refill_sheaf mm/slub.c:2818 [inline]
 __pcs_replace_empty_main+0x2b9/0x620 mm/slub.c:4592
 alloc_from_pcs mm/slub.c:4695 [inline]
 slab_alloc_node mm/slub.c:4829 [inline]
 kmem_cache_alloc_noprof+0x37d/0x650 mm/slub.c:4851
 __kernfs_new_node+0xe9/0x8e0 fs/kernfs/dir.c:637
 kernfs_new_node+0x102/0x210 fs/kernfs/dir.c:718
 __kernfs_create_file+0x4b/0x2e0 fs/kernfs/file.c:1057
 sysfs_add_file_mode_ns+0x238/0x300 fs/sysfs/file.c:313
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x673/0x1180 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:229 [inline]
 sysfs_create_groups+0x59/0x120 fs/sysfs/group.c:255
 device_add_groups drivers/base/core.c:2836 [inline]
 device_add_attrs+0x1bf/0x5b0 drivers/base/core.c:2911
 device_add+0x496/0xb70 drivers/base/core.c:3643
 netdev_register_kobject+0x178/0x310 net/core/net-sysfs.c:2358
page last free pid 5809 tgid 5809 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 vfree+0x25a/0x400 mm/vmalloc.c:3479
 kcov_put kernel/kcov.c:442 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:543
 __fput+0x44f/0xa70 fs/file_table.c:469
 fput_close_sync+0x11f/0x240 fs/file_table.c:574
 __do_sys_close fs/open.c:1509 [inline]
 __se_sys_close fs/open.c:1494 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1494
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88811a37df00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88811a37df80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811a37e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88811a37e080: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
 ffff88811a37e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


***

KASAN: use-after-free Read in ext4_xattr_block_csum_set

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      11439c4635edd669ae435eec308f4ab8a0804808
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/330c6289-adc9-452b-b12f-000d32045593/config
C repro:   https://ci.syzbot.org/findings/e7360798-7b84-42ba-9afb-319d10454142/c_repro
syz repro: https://ci.syzbot.org/findings/e7360798-7b84-42ba-9afb-319d10454142/syz_repro

fscrypt: AES-256-CBC-CTS using implementation "cts(cbc(ecb(aes-lib)))"
fscrypt: AES-256-XTS using implementation "xts(ecb(aes-lib))"
==================================================================
BUG: KASAN: use-after-free in crc32c_base lib/crc/crc32-main.c:54 [inline]
BUG: KASAN: use-after-free in crc32c_arch lib/crc/x86/crc32.h:44 [inline]
BUG: KASAN: use-after-free in crc32c+0x3cc/0x470 lib/crc/crc32-main.c:86
Read of size 1 at addr ffff88811f068000 by task syz.0.17/5956

CPU: 0 UID: 0 PID: 5956 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 crc32c_base lib/crc/crc32-main.c:54 [inline]
 crc32c_arch lib/crc/x86/crc32.h:44 [inline]
 crc32c+0x3cc/0x470 lib/crc/crc32-main.c:86
 ext4_chksum fs/ext4/ext4.h:2553 [inline]
 ext4_xattr_block_csum fs/ext4/xattr.c:147 [inline]
 ext4_xattr_block_csum_set+0x241/0x330 fs/ext4/xattr.c:172
 ext4_xattr_block_set+0x2494/0x2b00 fs/ext4/xattr.c:2165
 ext4_xattr_set_handle+0xe37/0x14d0 fs/ext4/xattr.c:2458
 ext4_set_context+0x233/0x560 fs/ext4/crypto.c:166
 fscrypt_set_context+0x397/0x460 fs/crypto/policy.c:791
 __ext4_new_inode+0x3158/0x3d20 fs/ext4/ialloc.c:1314
 ext4_create+0x233/0x470 fs/ext4/namei.c:2820
 lookup_open fs/namei.c:4483 [inline]
 open_last_lookups fs/namei.c:4583 [inline]
 path_openat+0x1395/0x3860 fs/namei.c:4827
 do_file_open+0x23e/0x4a0 fs/namei.c:4859
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb6f179c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb6f26cf028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fb6f1a15fa0 RCX: 00007fb6f179c799
RDX: 0000000000101042 RSI: 00002000000002c0 RDI: ffffffffffffff9c
RBP: 00007fb6f1832bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb6f1a16038 R14: 00007fb6f1a15fa0 R15: 00007ffe4cb28f88
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xc1 pfn:0x11f068
flags: 0x17ff00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 017ff00000000000 ffffea00047c0f08 ffffea00047c1648 0000000000000000
raw: 00000000000000c1 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5966, tgid 5966 (modprobe), ts 74332946165, free_ts 74344928310
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 folio_alloc_mpol_noprof mm/mempolicy.c:2503 [inline]
 vma_alloc_folio_noprof+0xea/0x210 mm/mempolicy.c:2538
 folio_prealloc mm/memory.c:-1 [inline]
 do_cow_fault mm/memory.c:5822 [inline]
 do_fault mm/memory.c:5934 [inline]
 do_pte_missing+0x4ea/0x3750 mm/memory.c:4477
 handle_pte_fault mm/memory.c:6316 [inline]
 __handle_mm_fault mm/memory.c:6454 [inline]
 handle_mm_fault+0x1bec/0x3310 mm/memory.c:6623
 do_user_addr_fault+0xa73/0x1340 arch/x86/mm/fault.c:1334
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
page last free pid 5966 tgid 5966 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 free_unref_folios+0xed5/0x16d0 mm/page_alloc.c:3040
 folios_put_refs+0x789/0x8d0 mm/swap.c:1002
 free_pages_and_swap_cache+0x2e7/0x5b0 mm/swap_state.c:423
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:398 [inline]
 tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:405
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:530
 exit_mmap+0x498/0xa10 mm/mmap.c:1315
 __mmput+0x118/0x430 kernel/fork.c:1174
 exit_mm+0x168/0x220 kernel/exit.c:581
 do_exit+0x62e/0x2320 kernel/exit.c:959
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88811f067f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88811f067f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811f068000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88811f068080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88811f068100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


***

KASAN: use-after-free Read in ext4_xattr_set_entry

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      11439c4635edd669ae435eec308f4ab8a0804808
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/330c6289-adc9-452b-b12f-000d32045593/config
C repro:   https://ci.syzbot.org/findings/f2e1c927-88dd-48df-af44-6348bc760ced/c_repro
syz repro: https://ci.syzbot.org/findings/f2e1c927-88dd-48df-af44-6348bc760ced/syz_repro

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
ext4 filesystem being mounted at /0/file0 supports timestamps until 2038-01-19 (0x7fffffff)
==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x179e/0x1e20 fs/ext4/xattr.c:1740
Read of size 260 at addr ffff88811cde4000 by task syz.0.17/5956

CPU: 0 UID: 0 PID: 5956 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 ext4_xattr_set_entry+0x179e/0x1e20 fs/ext4/xattr.c:1740
 ext4_xattr_block_set+0x636/0x2b00 fs/ext4/xattr.c:1961
 ext4_xattr_set_handle+0xdc2/0x14d0 fs/ext4/xattr.c:2432
 ext4_xattr_set+0x255/0x340 fs/ext4/xattr.c:2560
 __vfs_removexattr+0x431/0x470 fs/xattr.c:518
 __vfs_removexattr_locked+0xe2/0x280 fs/xattr.c:553
 vfs_removexattr+0x7f/0x230 fs/xattr.c:575
 ovl_do_removexattr fs/overlayfs/overlayfs.h:335 [inline]
 ovl_removexattr fs/overlayfs/overlayfs.h:343 [inline]
 ovl_make_workdir fs/overlayfs/super.c:760 [inline]
 ovl_get_workdir fs/overlayfs/super.c:840 [inline]
 ovl_fill_super_creds fs/overlayfs/super.c:1453 [inline]
 ovl_fill_super+0x4c09/0x5e00 fs/overlayfs/super.c:1564
 vfs_get_super fs/super.c:1327 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1346
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3839
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f60b0d9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcaa4270a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f60b1015fa0 RCX: 00007f60b0d9c799
RDX: 0000200000000b80 RSI: 0000200000000000 RDI: 0000000000000000
RBP: 00007f60b0e32bd9 R08: 0000200000000100 R09: 0000000000000000
R10: 0000000000000804 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f60b1015fac R14: 00007f60b1015fa0 R15: 00007f60b1015fa0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x39c pfn:0x11cde4
flags: 0x17ff00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 017ff00000000000 ffffea0004737948 ffff888121040d70 0000000000000000
raw: 000000000000039c 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5919, tgid 5919 (syz-executor), ts 71335198059, free_ts 71626869117
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2484
 folio_alloc_mpol_noprof mm/mempolicy.c:2503 [inline]
 vma_alloc_folio_noprof+0xea/0x210 mm/mempolicy.c:2538
 folio_prealloc mm/memory.c:-1 [inline]
 do_cow_fault mm/memory.c:5822 [inline]
 do_fault mm/memory.c:5934 [inline]
 do_pte_missing+0x4ea/0x3750 mm/memory.c:4477
 handle_pte_fault mm/memory.c:6316 [inline]
 __handle_mm_fault mm/memory.c:6454 [inline]
 handle_mm_fault+0x1bec/0x3310 mm/memory.c:6623
 do_user_addr_fault+0xa73/0x1340 arch/x86/mm/fault.c:1334
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
page last free pid 5920 tgid 5920 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 free_unref_folios+0xed5/0x16d0 mm/page_alloc.c:3040
 folios_put_refs+0x789/0x8d0 mm/swap.c:1002
 free_pages_and_swap_cache+0x537/0x5b0 mm/swap_state.c:426
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:398 [inline]
 tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:405
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:530
 exit_mmap+0x498/0xa10 mm/mmap.c:1315
 __mmput+0x118/0x430 kernel/fork.c:1174
 exit_mm+0x168/0x220 kernel/exit.c:581
 do_exit+0x62e/0x2320 kernel/exit.c:959
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

Memory state around the buggy address:
 ffff88811cde3f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88811cde3f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88811cde4000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88811cde4080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88811cde4100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

