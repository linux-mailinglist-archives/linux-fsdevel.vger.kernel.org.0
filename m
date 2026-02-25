Return-Path: <linux-fsdevel+bounces-78337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H9EDfNnnmmWVAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 04:09:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2961911FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 04:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE0F3084BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5728FFE7;
	Wed, 25 Feb 2026 03:09:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A727280F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988970; cv=none; b=RAydjsJckl9sHajzVY2vBBZD0UtTfZWopol+h1ArEtHyvGIK5sD1kKUq5zgWstbTFEgJNPcN1BW8owEL/ze2sr/8OjJAafk7N40p8OXth4hcsLyd22hTqLvu1opfKL7Xo8dG7azmUhtKTKX7pu66SRsIz/62+5tCCduEad3viCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988970; c=relaxed/simple;
	bh=FCLy/p/RqGxzSDoGn73X8Ry/hUJOKX7wa/NWxU9Rm+8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aDTrLOGf6wrq37V149Ske5agGaK3dkMk9vzCbqZlwMQZ1X+zJxsJtTApV7AMNF+eBM9nv5TigaDBaWdYST6Linj4nkOx/l7Mn5k6zbicbRBVLCVpl0uUxZP0PxHp664rPnCbd1z4ZxMEpmLmK4mE7lXGQKDhqDWkwCPx51xTVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679862e4413so102950363eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 19:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988967; x=1772593767;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EL7M3bd4yijGcAxsMbmxxz5lO6yXPYmbt5FWso09qU=;
        b=Fuhw6wLpsT2mvuVbR7f3g32EkN1lj2bXWp/6eZJE6OPYQM7Vo60KpA1dYfcx9k7azj
         2kFeQzrp7ZxPjVKAi/7ulrOx8aW8hyWXUzB/CBJO8FPKiYd4fizgby/EwaDI6px1jSQV
         KCWp0dAPOFT20CV13z4DHn2/uo0TuvEORGyzm7s9/fHDXiaJqOPDdxqEt/b3cvcX+hXT
         w+QEhj/i2fn9XB97Cyk5wyHLOpywzy+ZF1bAysy756o/ZKfs/YGnSlvrcKKHxc548FCn
         45VSegXWZtG/2fRt4V7XT/y+Y8qfKxm4ynBmZCnF0RFCkBtuSki0OwCbt0yVqi9Ad8P7
         ONLg==
X-Forwarded-Encrypted: i=1; AJvYcCWYC0vP9sLQMhH8kxMRBacXnt/OkjFigLfFcuVt4mFrUWNSqdX4rBwYtVxXK2lc6CTaTJaLZSEjQTDu0Qw2@vger.kernel.org
X-Gm-Message-State: AOJu0YyZwqOCdO+FggdQa0BLm2zVeVr/ADd5f67I8sBpKLC338OObN9n
	YVFEgBvHwr1zpZHLXPJtO/rPn7GSaEVkLumSLQuRLrFDOmNZ964E7qyygpbcuS17iNeM3QoVPHw
	RFcPNqtNLW/COoWmNcgcrCVRY9IerglNE4UccT/WYnupPqM3jOQbohK9EQFQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d899:0:b0:679:c549:202c with SMTP id
 006d021491bc7-679c549210cmr5391925eaf.14.1771988967598; Tue, 24 Feb 2026
 19:09:27 -0800 (PST)
Date: Tue, 24 Feb 2026 19:09:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699e67e7.a00a0220.301b66.0000.GAE@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in generic_file_write_iter (4)
From: syzbot <syzbot+9dd2144719bb071036a4@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78337-lists,linux-fsdevel=lfdr.de,9dd2144719bb071036a4];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url]
X-Rspamd-Queue-Id: 7E2961911FD
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    a95f71ad3e2e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14385722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb
dashboard link: https://syzkaller.appspot.com/bug?extid=9dd2144719bb071036a4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1175c55a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8676ab01a8b8/disk-a95f71ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3314e350353/vmlinux-a95f71ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e2905ccbd1e/bzImage-a95f71ad.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a8adaa9093f/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16fbbc02580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9dd2144719bb071036a4@syzkaller.appspotmail.com

INFO: task syz.0.17:6090 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:28864 pid:6090  tgid:6084  ppid:5926   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:1028 [inline]
 generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb97161c629
RSP: 002b:00007fb970c55028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb971896090 RCX: 00007fb97161c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fb9716b2b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb971896128 R14: 00007fb971896090 R15: 00007fff19dbf018
 </TASK>
INFO: task syz.2.19:6098 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:28920 pid:6098  tgid:6094  ppid:5931   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:1028 [inline]
 generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c0760c629
RSP: 002b:00007f3c06c45028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3c07886090 RCX: 00007f3c0760c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f3c076a2b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3c07886128 R14: 00007f3c07886090 R15: 00007fff24e91218
 </TASK>
INFO: task syz.3.20:6100 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.20        state:D stack:28648 pid:6100  tgid:6096  ppid:5939   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:1028 [inline]
 generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc0a48cc629
RSP: 002b:00007fc0a3f0d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fc0a4b46090 RCX: 00007fc0a48cc629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fc0a4962b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc0a4b46128 R14: 00007fc0a4b46090 R15: 00007ffd7a419a68
 </TASK>
INFO: task syz.1.18:6104 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:28840 pid:6104  tgid:6099  ppid:5932   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:1028 [inline]
 generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b4e2ac629
RSP: 002b:00007f5b4d8ed028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5b4e526090 RCX: 00007f5b4e2ac629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f5b4e342b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5b4e526128 R14: 00007f5b4e526090 R15: 00007ffe2deb5398
 </TASK>
INFO: task syz.4.21:6108 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.21        state:D stack:28704 pid:6108  tgid:6106  ppid:5938   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:1028 [inline]
 generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f81ffc6c629
RSP: 002b:00007f81ff2ad028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f81ffee6090 RCX: 00007f81ffc6c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f81ffd02b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f81ffee6128 R14: 00007f81ffee6090 R15: 00007fffb07d9958
 </TASK>

Showing all locks held in the system:
3 locks held by ksoftirqd/0/15:
1 lock held by khungtaskd/38:
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5549:
 #0: ffff888037eae0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13c0 drivers/tty/n_tty.c:2211
2 locks held by syz.0.17/6085:
3 locks held by syz.0.17/6090:
 #0: ffff88803e18ff28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff88804d77c480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff88804d77c480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805fe73a68 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805fe73a68 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.2.19/6095:
3 locks held by syz.2.19/6098:
 #0: ffff88803ae8fb28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff88803fce0480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff88803fce0480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805ff5a598 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805ff5a598 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.3.20/6097:
3 locks held by syz.3.20/6100:
 #0: ffff88803b2cbf28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff8880289bc480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff8880289bc480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805ff589d8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805ff589d8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.1.18/6102:
3 locks held by syz.1.18/6104:
 #0: ffff8880319dd728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff88802abf4480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff88802abf4480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805fe76af8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805fe76af8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.4.21/6107:
3 locks held by syz.4.21/6108:
 #0: ffff88803c18f728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff88803c510480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff88803c510480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805ff5f8d8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805ff5f8d8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.5.22/6230:
3 locks held by syz.5.22/6237:
 #0: ffff888034873928 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff88805d8d2480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff88805d8d2480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805fe71ea8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805fe71ea8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.7.24/6246:
3 locks held by syz.7.24/6250:
 #0: ffff888034641b28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff888033b68480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff888033b68480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805fe702e8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805fe702e8 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
3 locks held by syz.8.25/6249:
3 locks held by syz.8.25/6252:
 #0: ffff8880312b8728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff888034d42480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff888034d42480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff88805ff5c848 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff88805ff5c848 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.6.23/6253:
3 locks held by syz.6.23/6256:
 #0: ffff8880375c0728 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff888032a3a480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff888032a3a480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff8880601dba68 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff8880601dba68 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.9.26/6258:
3 locks held by syz.9.26/6259:
 #0: ffff888036d13f28 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff88805570c480 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff88805570c480 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff8880601db378 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff8880601db378 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: generic_file_write_iter+0x11f/0x690 mm/filemap.c:4454
2 locks held by syz.0.268/7113:
3 locks held by syz.0.268/7119:
 #0: ffff888038ce5528 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1261
 #1: ffff888033dc4480 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2710 [inline]
 #1: ffff888033dc4480 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x22d/0xba0 fs/read_write.c:684
 #2: ffff888064bee598 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff888064bee598 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: shmem_file_write_iter+0x82/0x120 mm/shmem.c:3492
3 locks held by syz.4.270/7118:
4 locks held by syz.2.271/7122:
1 lock held by syz.1.272/7124:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfd9/0x1030 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 7124 Comm: syz.1.272 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:470 [inline]
RIP: 0010:lock_acquire+0x10d/0x2e0 kernel/locking/lockdep.c:5870
Code: b4 24 88 00 00 00 41 56 e8 80 02 00 00 48 83 c4 28 48 c7 c7 c7 76 7b 8d e8 50 f4 81 09 b8 ff ff ff ff 65 0f c1 05 23 0d ae 10 <83> f8 01 0f 85 b0 00 00 00 9c 58 a9 00 02 00 00 0f 85 c3 00 00 00
RSP: 0000:ffffc90006c9f9d8 EFLAGS: 00000057
RAX: 0000000000000001 RBX: 0000000000000046 RCX: 0000000080000002
RDX: 00000000038e8b00 RSI: ffffffff8d7b76c7 RDI: ffffffff8ba64380
RBP: 0000000000000000 R08: ffffffff8193b67b R09: ffff88805aea4730
R10: dffffc0000000000 R11: fffffbfff1ed4477 R12: 0000000000000000
R13: ffff88805aea4730 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f1a29ce66c0(0000) GS:ffff888126442000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1a21bf3000 CR3: 0000000034962000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:162
 _task_rq_lock+0x5b/0x470 kernel/sched/core.c:745
 __set_cpus_allowed_ptr kernel/sched/core.c:3104 [inline]
 ___migrate_enable+0xbb/0x1f0 kernel/sched/core.c:2378
 __migrate_enable include/linux/sched.h:2425 [inline]
 migrate_enable include/linux/sched.h:2474 [inline]
 rt_spin_unlock+0x17d/0x200 kernel/locking/spinlock_rt.c:81
 spin_unlock include/linux/spinlock_rt.h:109 [inline]
 do_anonymous_page mm/memory.c:5322 [inline]
 do_pte_missing+0xf8a/0x2d30 mm/memory.c:4475
 handle_pte_fault mm/memory.c:6316 [inline]
 __handle_mm_fault mm/memory.c:6454 [inline]
 handle_mm_fault+0xd0a/0x13c0 mm/memory.c:6623
 do_user_addr_fault+0xa73/0x1340 arch/x86/mm/fault.c:1334
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f1a2a543b0e
Code: c1 49 39 4f 08 72 54 8d 4d ff 85 ed 74 3b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 39 f0 72 1b 4d 8b 07 49 89 c1 49 29 f1 <47> 0f b6 0c 08 45 84 c9 74 08 45 88 0c 00 49 8b 47 10 48 83 c0 01
RSP: 002b:00007f1a29ce5470 EFLAGS: 00010206
RAX: 000000000032d001 RBX: 00007f1a29ce5530 RCX: 000000000000003c
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007f1a29ce55d0
RBP: 0000000000000102 R08: 00007f1a218c6000 R09: 000000000032d000
R10: 0000000000000000 R11: 00007f1a29ce5540 R12: 0000000000000001
R13: 00007f1a2a742200 R14: 0000000000000000 R15: 00007f1a29ce55d0
 </TASK>


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

