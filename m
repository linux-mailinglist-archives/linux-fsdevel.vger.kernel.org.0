Return-Path: <linux-fsdevel+bounces-75469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKYUJCt1d2n7ggEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:07:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE08951C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D7BE3006692
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87991CF7D5;
	Mon, 26 Jan 2026 14:07:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9F2D061C
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436454; cv=none; b=L1LQQq+mKqnTtyquFWwmg6XTW/r+USEzzP7WJKTLwTlpZgwMxOGmhs0ukbDJSS7x6+GaNqtm/riheIiBJnCtuIk/o4AKynDzq8eUzMR0iNqvF4Yts9oLna8Hg5semHJ+g98lCwH9ibnTvTEh6Tz1+4nQ3GTgPJ21FAhPQYL2Pf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436454; c=relaxed/simple;
	bh=PUJPhOJ4AZ2lB4sT5ZrEb+XeEdqEQ9/Hnw47hjixBKQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f4tBpDZqk8UlGNycQCR1LtGxtS5/EtrvlahaTiO6Ar5AM+A+gQs1h0njaorrR0RhKaFe0HUbflkXgoF8x+HHuycwwUVNH0LFvz3p100X7cCsEzd4IDJELh1ybr1XeVOB/T5KDE8VR1MNMYQNsi89AeKq+A5eMw+RHm8TadsLlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7cfdd2f521bso6238164a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 06:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769436452; x=1770041252;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YOXJTvQa35EfB+oi4pMAGZpTsTQpaRB63oI/VpRPtY=;
        b=V/v2HKKoKWHCQC9Dm4C1J5ASc+JNpynmqD3o0ZAFnu4B4ojVIoqSiHd78t5UbW7lor
         pEpJc2A8b6vK/pEVPDhy4xJ98ODo1M0knjow62pOEyLame3qVKhCrk2/a1hHO62FJG1q
         JrzQ5D/LWPa3ezFIbXR3jOkelgOWLUiEvj+QbuPg69sQ4h5qa+jT5W9w/0koQRghicDO
         ztjYSQEZc0juw7KEPo3d5iLTVccKys3O1t2o1Zu9S/ckvciop3HdlemcsYs/I4vYsVE/
         KrV5tGQ/MZcByEV/Fw/5fEqHZLhPWnwvVHVshCs5l7SFZ0Ddc4R+m2yuL/hDhpfZZ4Fr
         VA4w==
X-Forwarded-Encrypted: i=1; AJvYcCXr0VXj5+daaHH8q9Hv0Mvp2SsbUGLqIo6hHAjtADyeaoCIRMyvBRC8acwDgYz87iqqFO+4j0nL+S/DeRJX@vger.kernel.org
X-Gm-Message-State: AOJu0YwEwgCs/zkg0C3Z/EI8cwzmJs6x1zfSgAWTQnCJz3zX4J4cMQCf
	67SckV3VjPH75V+zvfiBjCNI8rE4slxnGnu+As0MmMQgUtWaN/8QngSELKAXuJEdY5Mqw1KpMJa
	RMc7RU3zijFaMN8SSsRrHnUkhcQtmOgqyuJCE8eoCiHTX7TNWXowbm0NmE1w=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1886:b0:65b:2a82:d700 with SMTP id
 006d021491bc7-662e044e138mr2042204eaf.44.1769436451887; Mon, 26 Jan 2026
 06:07:31 -0800 (PST)
Date: Mon, 26 Jan 2026 06:07:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69777523.050a0220.1d05e9.0018.GAE@google.com>
Subject: [syzbot] [iomap?] WARNING in iomap_iter (6)
From: syzbot <syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=312c0a6c03e6d7df];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75469-lists,linux-fsdevel=lfdr.de,bd5ca596a01d01bfa083];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,goo.gl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlegroups.com:email]
X-Rspamd-Queue-Id: 21FE08951C
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    a66191c590b3 Merge tag 'hyperv-fixes-signed-20260121' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10db3e3a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=312c0a6c03e6d7df
dashboard link: https://syzkaller.appspot.com/bug?extid=bd5ca596a01d01bfa083
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f802af648f7a/disk-a66191c5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f28f489fe55/vmlinux-a66191c5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c44005e0c3c/bzImage-a66191c5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com

------------[ cut here ]------------
iter->iomap.offset + iter->iomap.length <= iter->pos
WARNING: fs/iomap/iter.c:36 at iomap_iter_done fs/iomap/iter.c:36 [inline], CPU#0: kworker/u8:26/9724
WARNING: fs/iomap/iter.c:36 at iomap_iter+0x982/0xf30 fs/iomap/iter.c:114, CPU#0: kworker/u8:26/9724
Modules linked in:
CPU: 0 UID: 0 PID: 9724 Comm: kworker/u8:26 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
Workqueue: loop6 loop_workfn
RIP: 0010:iomap_iter_done fs/iomap/iter.c:36 [inline]
RIP: 0010:iomap_iter+0x982/0xf30 fs/iomap/iter.c:114
Code: ff ff ff e9 86 fa ff ff e8 ab 6d 65 ff 90 0f 0b 90 e9 06 fd ff ff e8 9d 6d 65 ff 90 0f 0b 90 e9 3b fd ff ff e8 8f 6d 65 ff 90 <0f> 0b 90 e9 97 fd ff ff e8 81 6d 65 ff 90 0f 0b 90 e9 c4 fd ff ff
RSP: 0018:ffffc9000cdcf268 EFLAGS: 00010293
RAX: ffffffff825d2b81 RBX: ffffc9000cdcf3c0 RCX: ffff88806e5d1e80
RDX: 0000000000000000 RSI: 8000000000083fff RDI: 0000003e80000000
RBP: ffffc9000cdcf3f8 R08: ffffc9000cdcf3e8 R09: ffffc9000cdcf430
R10: dffffc0000000000 R11: ffffffff8473db20 R12: 8000000000083fff
R13: ffffc9000cdcf402 R14: 1ffff920019b9e79 R15: 0000003e80000000
FS:  0000000000000000(0000) GS:ffff888125928000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000031712ff8 CR3: 0000000043618000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000083
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_file_buffered_write+0x275/0xa30 fs/iomap/buffered-io.c:1187
 blkdev_buffered_write block/fops.c:736 [inline]
 blkdev_write_iter+0x524/0x710 block/fops.c:802
 lo_rw_aio+0xc7a/0xf00 include/linux/percpu-rwsem.h:-1
 do_req_filebacked drivers/block/loop.c:434 [inline]
 loop_handle_cmd drivers/block/loop.c:1947 [inline]
 loop_process_work+0x61d/0x11a0 drivers/block/loop.c:1982
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
 worker_thread+0x89f/0xd90 kernel/workqueue.c:3421
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

