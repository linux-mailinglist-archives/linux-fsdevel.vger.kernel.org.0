Return-Path: <linux-fsdevel+bounces-77199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mYa1LgNIkGnrYAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 11:01:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA12313B98A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 11:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050173025282
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02A253932;
	Sat, 14 Feb 2026 10:01:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5727707
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771063288; cv=none; b=I3Dv1bhy/0tDucqrOMahR3r0asp0/YWweccJHuO9OywlTv1ftqeTk+P9lLxmy19w41TnbpK+2aXtqRYFP3UbyW8K9bWhtSRaGr0E173z5bFvpcfEq8Z3G1AgKQVz4k9+klaFZh/stEV70LreV9y7WVA9gln+nr6v757iWTD+uaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771063288; c=relaxed/simple;
	bh=JzvvAQDo255Uoa9Wkt+7EbYcAopXLh91XzbMxFg4iTk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M1Ys1MPtq2u2JeSpfIngioJkYJAAoaohFoxJ5HZW8Xsay00V4iy97PbhTIdrwyM41iaWdsjrw2LQ5DmsOnOhDUO9hkAhhSWbequSdpDuqG2c1qzZAYBqRU4xQKfdXrlxjNmPRfkJMpnHTFxtviIoShs+iXh4PWMO7D4OKne9Boo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6783a925862so3961082eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 02:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771063286; x=1771668086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpJnN0LSuWvQ/aJ10zmSMRns/brlshB95NlgWxlHqWQ=;
        b=uvPNOCSIanfT8eKeHeVDQgCrNXsRKTL4v2mClKRMHoh5H1a8BS2o21TgT6oH1cQ2Ek
         QD95WKYUJC+oCmuf3F5SeQP6IGwd5jX98xzFEKjmETkM0mFILjWSIZ+Og6FzGHdWTJHE
         R39Wek2mwAK2v0Vdwm9/05rTCWXyzenwRu58vv2qIBAzUaRXh1dDnDTWs4YGD659P4bq
         VIRuibZ+bXl1ALArKfceATKG87gQX4S9N7AyWpWaWIVa1UTLePsxuJ3omj1+Jy3GeIaM
         7LxoOT2waGyfOszoSHtEqBxZrZT/Y8TvE6eqnEHKFILZYuV+2COwBUTDAQrnBWPpABfG
         J3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb7oxG884sPgQwPz4vXEhiAb8yMWES2e2HkyEUSVHDz2DP5DdFcnoxFzbdhkBPANECk4CQXHBVjlcUIDQ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1bBPYUPMrCwxDN5dbUU50+uTp32aIuuBiMrBnYenmGEpuOvk
	1Jd85B6Ttg6IgFyE3mFKTzGzuIIK8V9aIN+DTGKQuaiRNTwZIqchlU95EHmQ1sCq02+5TON2M3g
	4Jn1VzaRXJRofU54Ya3b0VXpmr7a83qt+h5fYh8BuRDGWqNk7j2y+uCygg2M=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1791:b0:66f:4458:67ca with SMTP id
 006d021491bc7-6785b1c2611mr1154986eaf.40.1771063286201; Sat, 14 Feb 2026
 02:01:26 -0800 (PST)
Date: Sat, 14 Feb 2026 02:01:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699047f6.050a0220.2757fb.0024.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in clone_mnt
From: syzbot <syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6428d17febdfb14e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77199-lists,linux-fsdevel=lfdr.de,a89f9434fb5a001ccd58];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,appspotmail.com:email,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: EA12313B98A
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    c22e26bd0906 Merge tag 'landlock-7.0-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c6a6e6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6428d17febdfb14e
dashboard link: https://syzkaller.appspot.com/bug?extid=a89f9434fb5a001ccd58
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b33c549157ca/disk-c22e26bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34c7ded19553/vmlinux-c22e26bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66faec2158ed/bzImage-c22e26bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x4e/0x130 lib/list_debug.c:29
Read of size 8 at addr ffff8880341bcb40 by task syz.6.5169/22925

CPU: 1 UID: 0 PID: 22925 Comm: syz.6.5169 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __list_add_valid_or_report+0x4e/0x130 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 clone_mnt+0x447/0x9a0 fs/namespace.c:1275
 copy_tree+0xde/0x930 fs/namespace.c:2159
 copy_mnt_ns+0x24d/0x990 fs/namespace.c:4246
 create_new_namespaces+0xcf/0x6a0 kernel/nsproxy.c:98
 unshare_nsproxy_namespaces+0x11a/0x160 kernel/nsproxy.c:226
 ksys_unshare+0x4f4/0x900 kernel/fork.c:3174
 __do_sys_unshare kernel/fork.c:3245 [inline]
 __se_sys_unshare kernel/fork.c:3243 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3243
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff48d79bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff48b9f6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ff48da15fa0 RCX: 00007ff48d79bf79
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000002a020400
RBP: 00007ff48d8327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff48da16038 R14: 00007ff48da15fa0 R15: 00007ffc92e1ac28
 </TASK>

Allocated by task 22855:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4459 [inline]
 slab_alloc_node mm/slub.c:4788 [inline]
 kmem_cache_alloc_noprof+0x33b/0x680 mm/slub.c:4795
 alloc_vfsmnt+0x23/0x420 fs/namespace.c:287
 clone_mnt+0x4b/0x9a0 fs/namespace.c:1246
 create_new_namespace fs/namespace.c:3098 [inline]
 open_new_namespace fs/namespace.c:3168 [inline]
 vfs_open_tree+0x507/0x1040 fs/namespace.c:3217
 __do_sys_open_tree fs/namespace.c:3227 [inline]
 __se_sys_open_tree fs/namespace.c:3225 [inline]
 __x64_sys_open_tree+0x96/0x110 fs/namespace.c:3225
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 20:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2670 [inline]
 slab_free mm/slub.c:6082 [inline]
 kmem_cache_free+0x185/0x690 mm/slub.c:6212
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core kernel/rcu/tree.c:2869 [inline]
 rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3251
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 task_work_add+0xb6/0x440 kernel/task_work.c:70
 mntput_no_expire_slowpath+0x70c/0xbd0 fs/namespace.c:1379
 create_new_namespace fs/namespace.c:3162 [inline]
 open_new_namespace fs/namespace.c:3168 [inline]
 vfs_open_tree+0xe17/0x1040 fs/namespace.c:3217
 __do_sys_open_tree fs/namespace.c:3227 [inline]
 __se_sys_open_tree fs/namespace.c:3225 [inline]
 __x64_sys_open_tree+0x96/0x110 fs/namespace.c:3225
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880341bca80
 which belongs to the cache mnt_cache of size 352
The buggy address is located 192 bytes inside of
 freed 352-byte region [ffff8880341bca80, ffff8880341bcbe0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880341bda40 pfn:0x341bc
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880341bc171
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff888140412780 ffffea0001036010 ffffea000100bc10
raw: ffff8880341bda40 000001c00012000f 00000000f5000000 ffff8880341bc171
head: 0080000000000240 ffff888140412780 ffffea0001036010 ffffea000100bc10
head: ffff8880341bda40 000001c00012000f 00000000f5000000 ffff8880341bc171
head: 0080000000000001 ffffea0000d06f01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 18378, tgid 18375 (syz.6.3692), ts 1535437491766, free_ts 1534179924298
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x28bb/0x2950 mm/page_alloc.c:3950
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5245
 alloc_slab_page mm/slub.c:3238 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3411
 new_slab mm/slub.c:3469 [inline]
 refill_objects+0x334/0x3c0 mm/slub.c:7091
 refill_sheaf mm/slub.c:2787 [inline]
 __pcs_replace_empty_main+0x328/0x5f0 mm/slub.c:4536
 alloc_from_pcs mm/slub.c:4639 [inline]
 slab_alloc_node mm/slub.c:4773 [inline]
 kmem_cache_alloc_noprof+0x433/0x680 mm/slub.c:4795
 alloc_vfsmnt+0x23/0x420 fs/namespace.c:287
 clone_mnt+0x4b/0x9a0 fs/namespace.c:1246
 copy_tree+0x3d4/0x930 fs/namespace.c:2194
 get_detached_copy fs/namespace.c:3044 [inline]
 open_detached_copy+0x23e/0x5a0 fs/namespace.c:3060
 vfs_open_tree+0x490/0x1040 fs/namespace.c:3220
 __do_sys_open_tree fs/namespace.c:3227 [inline]
 __se_sys_open_tree fs/namespace.c:3225 [inline]
 __x64_sys_open_tree+0x96/0x110 fs/namespace.c:3225
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5166 tgid 5166 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xfd0/0x1160 mm/page_alloc.c:2973
 __slab_free+0x24f/0x2a0 mm/slub.c:5490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4459 [inline]
 slab_alloc_node mm/slub.c:4788 [inline]
 kmem_cache_alloc_noprof+0x33b/0x680 mm/slub.c:4795
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x2e/0x250 fs/namei.c:182
 getname include/linux/fs.h:2512 [inline]
 class_filename_constructor include/linux/fs.h:2539 [inline]
 do_sys_openat2+0xca/0x200 fs/open.c:1365
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880341bca00: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880341bca80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880341bcb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880341bcb80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880341bcc00: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

