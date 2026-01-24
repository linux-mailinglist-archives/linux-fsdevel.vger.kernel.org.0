Return-Path: <linux-fsdevel+bounces-75337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDD3JhUYdGmQ2AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:53:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D9A7BCF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD60C3004422
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717931531C8;
	Sat, 24 Jan 2026 00:53:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF25EADC
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216013; cv=none; b=ZMpyahzGrqZC2zIgzCyazz7eHXCmH/3A54nMXWDXXtOd9kxLKUNdyld2UR6BHXZxPtgxgWbILhApLdFmb4MBLw82eRTHlt6YfVWm3hsebYPWsWR9VaBQLHKx2gBP3eEqz1Xn8juDFTCqwcJWzDMVjqtUdag9Tlt7y+Zm8s94U5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216013; c=relaxed/simple;
	bh=cOpRIaWhU/1GMapNed1tZuhkZfCYTYZbZVa77vCLzpM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GA2fsRk8q8R0bUNeMGDpYv2H0h+McSns/ZdKaRErWAWPh+0YU3VsvMS7aRY84siOQkEGrZAtoBkn2NxWjooJGJ1AOV3PskK3cDr/1JzVCnbOFmfeR0auqyd+7J3v5+kqaIinahnGsWApTAKFZL47BoOQQp5SiSycn2cFrW8hRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6611cbc47a2so5088791eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 16:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769216010; x=1769820810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jncET4YqsZZdaLQmmwDUYTVvd/cAUSYLlltIWGYRi/M=;
        b=MwNtWVU1FK871yhdWjfTrvIxG0jC0GksI1di2UHrFUVywy/q5SWk9RYBnV+Lp0urrH
         3bpVESUS2lPZqBsIvdHAHxSriaKb3/tL5AIUuD9nJ6HtyEZK2m7+SVNRG1RWCONcQpg9
         4xsvNtNLn6NVbqN/+GlqFgZ7TCl4P1TEE/eshneK2xBBQvQdzz07os7bd9+Gm5qT7X65
         WsDhgpqUlZNASPfESw9H5+MsoKsNMsGrpl6R+W+ml2mxt2oMT6b19WkUNnLoYxOzOuBB
         l+efOYKYdYgqynEhcbMN4dSj6laUeYWw4zbASNJxqD6zQalBHPiObAB69/JI61mygLOx
         wMCg==
X-Forwarded-Encrypted: i=1; AJvYcCWdyvciLfNXi1waozkcE7IChJz+OZCElUKZ97pVSL+pclmGt2lzsanQDP6+rcjULiI4rAk0NJIyKiauNroM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MtaROCZrh+PAsiuZDh18xvFMzh7v/Xku/V3C7epxibSX8d3x
	MK2OMACUDEs9cI+WT02s7/fWuVLlq33UmpnhTkkcDg8LLf49UBvw4QPTjedblap/nnHz14jZnPk
	RonpIi8dxm+KQYombBcjlfsJD1MS1T6lMimCsysR59isgKsbsKz9J/yPYXZI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e843:0:b0:65d:d0b:fd3b with SMTP id
 006d021491bc7-662caad7245mr2275161eaf.15.1769216010492; Fri, 23 Jan 2026
 16:53:30 -0800 (PST)
Date: Fri, 23 Jan 2026 16:53:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6974180a.050a0220.1a75db.0327.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in dqget (2)
From: syzbot <syzbot+e7e874621d086b64b4ca@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=323fe5bdde2384a5];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75337-lists,linux-fsdevel=lfdr.de,e7e874621d086b64b4ca];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3D9A7BCF8
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    24d479d26b25 Linux 6.19-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f033fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=323fe5bdde2384a5
dashboard link: https://syzkaller.appspot.com/bug?extid=e7e874621d086b64b4ca
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8c35233e7ff/disk-24d479d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c81ccfef24a/vmlinux-24d479d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/302d8a96d2a0/bzImage-24d479d2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7e874621d086b64b4ca@syzkaller.appspotmail.com

JBD2: Ignoring recovery information on journal
ocfs2: Mounting device (7,5) on (node local, slot 0) with ordered data mode.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.5.1831/13251 is trying to acquire lock:
ffff8880417e40a8 (&dquot->dq_lock){+.+.}-{4:4}, at: wait_on_dquot fs/quota/dquot.c:357 [inline]
ffff8880417e40a8 (&dquot->dq_lock){+.+.}-{4:4}, at: dqget+0x72a/0xf10 fs/quota/dquot.c:975

but task is already holding lock:
ffff888048d85f40 (&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
ffff888048d85f40 (&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]){+.+.}-{4:4}, at: ocfs2_reserve_suballoc_bits+0x164/0x4600 fs/ocfs2/suballoc.c:789

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]){+.+.}-{4:4}:
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       inode_lock include/linux/fs.h:1027 [inline]
       ocfs2_remove_inode fs/ocfs2/inode.c:733 [inline]
       ocfs2_wipe_inode fs/ocfs2/inode.c:896 [inline]
       ocfs2_delete_inode fs/ocfs2/inode.c:1157 [inline]
       ocfs2_evict_inode+0x1507/0x4040 fs/ocfs2/inode.c:1299
       evict+0x5f4/0xae0 fs/inode.c:837
       ocfs2_dentry_iput+0x247/0x370 fs/ocfs2/dcache.c:407
       __dentry_kill+0x209/0x660 fs/dcache.c:670
       finish_dput+0xc9/0x480 fs/dcache.c:879
       end_renaming fs/namei.c:4061 [inline]
       do_renameat2+0x604/0x8e0 fs/namei.c:6058
       __do_sys_rename fs/namei.c:6099 [inline]
       __se_sys_rename fs/namei.c:6097 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:6097
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_sysfile_lock_key[ORPHAN_DIR_SYSTEM_INODE]){+.+.}-{4:4}:
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       inode_lock include/linux/fs.h:1027 [inline]
       ocfs2_del_inode_from_orphan+0x134/0x740 fs/ocfs2/namei.c:2731
       ocfs2_dio_end_io_write fs/ocfs2/aops.c:2306 [inline]
       ocfs2_dio_end_io+0x479/0x10f0 fs/ocfs2/aops.c:2404
       dio_complete+0x25b/0x790 fs/direct-io.c:281
       __blockdev_direct_IO+0x2e63/0x3490 fs/direct-io.c:1303
       ocfs2_direct_IO+0x25f/0x2d0 fs/ocfs2/aops.c:2441
       generic_file_direct_write+0x1db/0x3e0 mm/filemap.c:4248
       __generic_file_write_iter+0x11d/0x230 mm/filemap.c:4417
       ocfs2_file_write_iter+0x1582/0x1cf0 fs/ocfs2/file.c:2475
       iter_file_splice_write+0x972/0x10b0 fs/splice.c:738
       do_splice_from fs/splice.c:938 [inline]
       direct_splice_actor+0x101/0x160 fs/splice.c:1161
       splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
       do_splice_direct_actor fs/splice.c:1204 [inline]
       do_splice_direct+0x181/0x270 fs/splice.c:1230
       do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
       __do_sys_sendfile64 fs/read_write.c:1431 [inline]
       __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       ocfs2_create_local_dquot+0x19d/0x1a40 fs/ocfs2/quota_local.c:1227
       ocfs2_acquire_dquot+0x7ff/0xb10 fs/ocfs2/quota_global.c:883
       dqget+0x7b1/0xf10 fs/quota/dquot.c:980
       dquot_set_dqblk+0x2b/0xfa0 fs/quota/dquot.c:2823
       quota_setquota+0x4b7/0x540 fs/quota/quota.c:310
       __do_sys_quotactl fs/quota/quota.c:961 [inline]
       __se_sys_quotactl+0x279/0x950 fs/quota/quota.c:917
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&dquot->dq_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       wait_on_dquot fs/quota/dquot.c:357 [inline]
       dqget+0x72a/0xf10 fs/quota/dquot.c:975
       __dquot_initialize+0x3b3/0xcb0 fs/quota/dquot.c:1508
       ocfs2_get_init_inode+0x13b/0x1b0 fs/ocfs2/namei.c:206
       ocfs2_mknod+0x858/0x2030 fs/ocfs2/namei.c:314
       ocfs2_create+0x195/0x420 fs/ocfs2/namei.c:677
       lookup_open fs/namei.c:4449 [inline]
       open_last_lookups fs/namei.c:4549 [inline]
       path_openat+0x18bb/0x3dd0 fs/namei.c:4793
       do_filp_open+0x1fa/0x410 fs/namei.c:4823
       do_sys_openat2+0x121/0x200 fs/open.c:1430
       do_sys_open fs/open.c:1436 [inline]
       __do_sys_openat fs/open.c:1452 [inline]
       __se_sys_openat fs/open.c:1447 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1447
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &dquot->dq_lock --> &ocfs2_sysfile_lock_key[ORPHAN_DIR_SYSTEM_INODE] --> &ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]);
                               lock(&ocfs2_sysfile_lock_key[ORPHAN_DIR_SYSTEM_INODE]);
                               lock(&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]);
  lock(&dquot->dq_lock);

 *** DEADLOCK ***

3 locks held by syz.5.1831/13251:
 #0: ffff8880279a0420 (sb_writers#20){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499
 #1: ffff888052e9df40 (&type->i_mutex_dir_key#13){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff888052e9df40 (&type->i_mutex_dir_key#13){++++}-{4:4}, at: open_last_lookups fs/namei.c:4546 [inline]
 #1: ffff888052e9df40 (&type->i_mutex_dir_key#13){++++}-{4:4}, at: path_openat+0xb47/0x3dd0 fs/namei.c:4793
 #2: ffff888048d85f40 (&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #2: ffff888048d85f40 (&ocfs2_sysfile_lock_key[INODE_ALLOC_SYSTEM_INODE]){+.+.}-{4:4}, at: ocfs2_reserve_suballoc_bits+0x164/0x4600 fs/ocfs2/suballoc.c:789

stack backtrace:
CPU: 1 UID: 0 PID: 13251 Comm: syz.5.1831 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
 wait_on_dquot fs/quota/dquot.c:357 [inline]
 dqget+0x72a/0xf10 fs/quota/dquot.c:975
 __dquot_initialize+0x3b3/0xcb0 fs/quota/dquot.c:1508
 ocfs2_get_init_inode+0x13b/0x1b0 fs/ocfs2/namei.c:206
 ocfs2_mknod+0x858/0x2030 fs/ocfs2/namei.c:314
 ocfs2_create+0x195/0x420 fs/ocfs2/namei.c:677
 lookup_open fs/namei.c:4449 [inline]
 open_last_lookups fs/namei.c:4549 [inline]
 path_openat+0x18bb/0x3dd0 fs/namei.c:4793
 do_filp_open+0x1fa/0x410 fs/namei.c:4823
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25fc18f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f25fd085038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f25fc3e5fa0 RCX: 00007f25fc18f749
RDX: 0000000000105042 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00007f25fc213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f25fc3e6038 R14: 00007f25fc3e5fa0 R15: 00007ffe63c93778
 </TASK>


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

