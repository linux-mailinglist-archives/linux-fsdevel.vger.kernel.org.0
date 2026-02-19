Return-Path: <linux-fsdevel+bounces-77738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ImIMth3l2nVywIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:51:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75251162795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA16A3012D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43F3271F0;
	Thu, 19 Feb 2026 20:51:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5052318EE1
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534289; cv=none; b=Ot/IYwU2YtV7czrWsSIlu9doyAT3LZD28kl+xKcFsRSFSLeCwc+yBc26yBlF7Xj64j/7VrB2ykymeYYVzR+7i4wGHMVvryJWOvDRfZtLCXGuk9KWQ2Itewb3q8oCw1UPBDcHMG0TEZYNqxH8Uro2LZD8K+yOfyUTVbTHd808DlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534289; c=relaxed/simple;
	bh=bhTCVlVvMiw/CS5qSjmp96mJm0jg9pUbJJAGN51ggDU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qcby13dDjqO6EUWFOe0WAoKE1RIyv+QNh1XqhzLBG/tgP/el74kXdZP46FGqJjLzjIXXBXR0RWublCS7XifmysLr5BVhYOa4d2O/hI1CiITw5lAsEQ3S3qnqKfJ1bpZJE26ldiwJyYs46dum29+VDsPC+pac6gMvRq8pU5N3wRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6795b040562so8057030eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 12:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534287; x=1772139087;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJjfOm3xHv1STTMig9wkib+KS54oRvgqT9llxyCjsmo=;
        b=o2uPgfhSWsxQ+SpoFYCkw1JSf0ppvp2nsmwQP6OnvNy9gT00xV0hljx5K1dNOhKKy5
         LkvMcKZMPHrCsgvUgFHzNx54Aa+mB5yBXSYJ2U2vwQ2WNH2c/4/QRbD7ky2W1dTx34f6
         PxMwZ0icL8A43TyCiub9g1AkNXGwJEbeaUPJi3l37eNkL+x8f7QPd18ASJyOZT45ZhRG
         gEyuPcyT2z1qEdQ05qPyCfvW29Qj/FbCFZj0F3WkUCbzA/jwMiHx0ABJMvdlOOEuPNZ8
         y1UqJYEPDHM2lBvKZvS1gI+ldDokiHz0v6VI7qY6I82KAm3zpWXR6sR63muKdJsb90cp
         V4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWZhzPBK1pGeYTWmYBO1rT/LHSXhV+kA10xGc857qmiGfT4bInY8PqH1xKEoFrqB1jWMylqF76aC9YVnu0y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7yUA8EP0zU5xlfWYFMxegYIOuib+Tea9/3UkSLyz6FfjCUQOM
	pdAI3cRYyA6UjfDqLYRtpdv30L+Dr79D6yZDmm8YqUpAjY47kb3QiaM6DYVpALj14lJTwhooiOB
	mFpCS6+QMSqx9yTdgjczGXqRqBPjLuMdEsY1gkp43YZVZW0W3dz1aZw/vMqg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1689:b0:662:f30e:d56d with SMTP id
 006d021491bc7-67766ad58d2mr10720204eaf.7.1771534286753; Thu, 19 Feb 2026
 12:51:26 -0800 (PST)
Date: Thu, 19 Feb 2026 12:51:26 -0800
In-Reply-To: <6968a164.050a0220.58bed.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699777ce.050a0220.b01bb.0031.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in ifs_free
From: syzbot <syzbot+d3a62bea0e61f9d121da@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77738-lists,linux-fsdevel=lfdr.de,d3a62bea0e61f9d121da];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 75251162795
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    2b7a25df823d Merge tag 'mm-nonmm-stable-2026-02-18-19-56' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c21722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e
dashboard link: https://syzkaller.appspot.com/bug?extid=d3a62bea0e61f9d121da
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1501dc02580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1357f652580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2b7a25df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3a54d09b17c/vmlinux-2b7a25df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb704901bce5/bzImage-2b7a25df.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b778b9903de5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3a62bea0e61f9d121da@syzkaller.appspotmail.com

------------[ cut here ]------------
ifs_is_fully_uptodate(folio, ifs) != folio_test_uptodate(folio)
WARNING: fs/iomap/buffered-io.c:256 at ifs_free+0x358/0x420 fs/iomap/buffered-io.c:255, CPU#0: syz-executor/5453
Modules linked in:
CPU: 0 UID: 0 PID: 5453 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ifs_free+0x358/0x420 fs/iomap/buffered-io.c:255
Code: 41 5f 5d e9 7a fb bd ff e8 45 5a 5e ff 90 0f 0b 90 e9 d0 fe ff ff e8 37 5a 5e ff 90 0f 0b 90 e9 0a ff ff ff e8 29 5a 5e ff 90 <0f> 0b 90 eb c3 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 06 fe ff ff
RSP: 0018:ffffc9000dfcf688 EFLAGS: 00010293
RAX: ffffffff82674207 RBX: 0000000000000008 RCX: ffff88801f834900
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
RBP: 000000008267bc01 R08: ffffea00010fb747 R09: 1ffffd400021f6e8
R10: dffffc0000000000 R11: fffff9400021f6e9 R12: ffff888051c7da44
R13: ffff888051c7da00 R14: ffffea00010fb740 R15: 1ffffd400021f6e9
FS:  0000555586def500(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555586e0aa28 CR3: 00000000591fe000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 folio_invalidate mm/truncate.c:140 [inline]
 truncate_cleanup_folio+0xcb/0x190 mm/truncate.c:160
 truncate_inode_pages_range+0x2ce/0xe30 mm/truncate.c:404
 ntfs_evict_inode+0x19/0x40 fs/ntfs3/inode.c:1861
 evict+0x61e/0xb10 fs/inode.c:846
 dispose_list fs/inode.c:888 [inline]
 evict_inodes+0x75a/0x7f0 fs/inode.c:942
 generic_shutdown_super+0xaa/0x2d0 fs/super.c:632
 kill_block_super+0x44/0x90 fs/super.c:1725
 ntfs3_kill_sb+0x44/0x1c0 fs/ntfs3/super.c:1889
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0f859d897
Code: a2 c7 05 5c ee 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd23732b28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fb0f8631ef0 RCX: 00007fb0f859d897
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd23732be0
RBP: 00007ffd23732be0 R08: 00007ffd23733be0 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd23733c70
R13: 00007fb0f8631ef0 R14: 000000000001b126 R15: 00007ffd23733cb0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

