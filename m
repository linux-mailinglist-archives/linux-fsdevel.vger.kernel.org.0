Return-Path: <linux-fsdevel+bounces-28005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F881965EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE561286C58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760919006E;
	Fri, 30 Aug 2024 10:19:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1018FDC4
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013144; cv=none; b=LCB5Jl8eMOLktAfq1WFYC070ps4AJSA/EL1Dua+I6vc1aFKS+3dWCNuTs7vq1nmI4UJ2t7sDUEACptj+NDKUi7SVDZ51R7vRdL8G7emONA2ZwPYIOJpn6sSfnhmh4GAZ4TMvurBLognd809auEnD2zUU66c/QoBHakxj5Gy53qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013144; c=relaxed/simple;
	bh=E92vPcDUNH2H6tXKAyZSvRlnQzJMyeSx5qItmxkxsNE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tg30GDe+aAegRyTVM1EMv6nsEA1FXKFz6pGHbOrLVoNaqghOXTkk6IMurtv1mTw9GfeWC5CfBxwle6iULylyC2cgrvB7N9Jf02CrSFfr/rhyWYRH7kgQJ2rO/gTrKAE3PrfXxUKL3y+8NCmebQ9MNyXiSFDbBZvs2uNH60RFRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a2723a5aeso56793939f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 03:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725013142; x=1725617942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZwEs243YnoTjv7mRJam4tBLXDmD+xDF+1bP+8r8g0E=;
        b=iVAsKml3/TvcUSnbeIlDBN/Assf0QvDqZk/0yZhxZr+e4Y8dLr07+QStANBZpKrY0Q
         f+yOOV20RJoCWUcimzC+VaI32jUwRzvBRnGOaPxoWIN1YN8MsvEomp/7R2P6gouENXgW
         nOXxylpuvpSP6s7qzfN2BChVi9NN5AEx8khtuH9S8ChTNnk4WGgNMukRWa17nqsNEFfR
         JbpECVWhKnEIz6rBJOJcTBr2gKR1ABlkOL0OfzNwT12/O8c/0IWm4TqZF0aW/3M+5N15
         k0XK7Fpz+AuJfp/K9J1EcqrgwpLTcd305NsZC2W6HBIQnhuNpqToXYOqKqNU+eIOdNnG
         uq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV71j6AV1QclHGhoML34POVaqAcSJG4R0huTNcMHGDGT6cxzFaCZABXdry/fsBW65bnt7wDTq9YQG7IOJx8@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOw53QvYrDLLOmHcwnDqi5ON3iHvijFiMnoim5HNv28b/QGMx
	fmkbW5GuMWrQq97JN5uQKy0FenqHuzr0oqQIOSNiorYL2zhhMdqRd08OCsi2sBb137VfDCYrx2a
	qvI/Qc/e7P0mk57jFgoOwziZPiNpalW7YALinfTvTVdi4+AkQ9d8hbXA=
X-Google-Smtp-Source: AGHT+IFMiJ32db5lCffYpTxI1K34TKvT7SlmN4c4BQpJtea95Em5wyGT7ZDH04JbzrzXtpNDNJ8O69kA7RP2TO2zuSXuSjgMhZLg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1507:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4d017ee3993mr59704173.5.1725013141879; Fri, 30 Aug 2024
 03:19:01 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:19:01 -0700
In-Reply-To: <df7fc9c1863f353091cfcb84f04e365aa4609bab.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e11ef0620e3eb6a@google.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>
To: brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, sunjunchao2870@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in iomap_write_begin

XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6077 at fs/iomap/buffered-io.c:727 __iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
WARNING: CPU: 0 PID: 6077 at fs/iomap/buffered-io.c:727 iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
Modules linked in:
CPU: 0 UID: 0 PID: 6077 Comm: syz.0.15 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
RIP: 0010:iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
Code: b5 0d 01 90 48 c7 c7 a0 54 fa 8b e8 da 19 2b ff 90 0f 0b 90 90 e9 74 ef ff ff e8 5b f1 68 ff e9 4b f6 ff ff e8 51 f1 68 ff 90 <0f> 0b 90 bb fb ff ff ff e9 e9 fe ff ff e8 3e f1 68 ff 90 0f 0b 90
RSP: 0018:ffffc90003e977c0 EFLAGS: 00010293
RAX: ffffffff822a858f RBX: 0000000000000080 RCX: ffff888020aeda00
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000000
RBP: ffffc90003e97a50 R08: ffffffff822a8294 R09: 1ffff11004494cf9
R10: dffffc0000000000 R11: ffffed1004494cfa R12: ffffc90003e979b0
R13: ffffc90003e97bf0 R14: ffffc90003e97990 R15: 0000000000000800
FS:  00007f4d396276c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000023f3a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_unshare_iter fs/iomap/buffered-io.c:1351 [inline]
 iomap_file_unshare+0x460/0x780 fs/iomap/buffered-io.c:1391
 xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1681
 xfs_file_fallocate+0x6be/0xa50 fs/xfs/xfs_file.c:997
 vfs_fallocate+0x553/0x6c0 fs/open.c:334
 ksys_fallocate fs/open.c:357 [inline]
 __do_sys_fallocate fs/open.c:365 [inline]
 __se_sys_fallocate fs/open.c:363 [inline]
 __x64_sys_fallocate+0xbd/0x110 fs/open.c:363
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d387779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4d39627038 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f4d38905f80 RCX: 00007f4d387779f9
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000006
RBP: 00007f4d387e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4d38905f80 R15: 00007ffd9e61c108
 </TASK>


Tested on:

commit:         ee9a43b7 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=173e3eeb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b67cdb980000


