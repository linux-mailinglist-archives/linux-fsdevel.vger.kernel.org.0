Return-Path: <linux-fsdevel+bounces-14563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966687DD18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5ED2813B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23311B28D;
	Sun, 17 Mar 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC2nRfm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A612E68;
	Sun, 17 Mar 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710676663; cv=none; b=u29NzIpy09j/zEYmd6Ps3UUy/yHxZ0KqGvQsq1nxSux4JMQ4kM0CjX3yX8etzSJ03wxTdCDKybueGPzL171U3bHngKEtxAbGRtahwrbQu+kDuaEaLZny1LtEa9wxIrTq19MrBE0fPj9XAkNEUpvayX1niVBmk5PbCii/Aesu44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710676663; c=relaxed/simple;
	bh=so+Pp5q2nVXLPCBvmzcb6VV8T7os/RMzpR2I/Zoh0dk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uL1OYZxXVwvGG5MNvvGDjiDCaxAR1VvL6HT7lHwf6hImMJ1ub7fq39Ads5ibT6D6WTj6V+qnQ8qjmkY4RXa6OasKNEmNIyQCbPqivjZXSAJ4TgTrv3ZeZRgVln9P4dEwSh+xNkOc4jy1i4jibjD7Y1DarEcoGAtX6v6IUqv8kBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC2nRfm/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso410343066b.3;
        Sun, 17 Mar 2024 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710676660; x=1711281460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXEfLve6reVSvUgG/A3DS1NEL2c38fHzUXI9ox73bX4=;
        b=YC2nRfm/pVliDq3Xm0Xma7HxhoQlvAz+iNJcdgOmXgqcmAl212p1NzJay2DUo1sg8u
         5rypOjzgEmilnWxpJW7+gv3CbqkF5q/Aol2pb3g7Da9xdIajEi2mmdLSk5svWhQKvOVW
         orgPIeOuuPgHuwis8h887K+DFZnU9OzNi+RUOGmbsH5hjKQTp4U3uBiA6r4trL9XtzFk
         ue2q+G71DwOvaVpAikBqaVtui09gv2g3D/J7utYyIgVcQIcX/1mEDTzdQSqHhqTnyjdm
         MNJCTZzdboYpL3Lmzx8yRtauq0pVODdxrnfhtx1eYMK86DAhuTfTWOkpIfUThlICqBlX
         JC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710676660; x=1711281460;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXEfLve6reVSvUgG/A3DS1NEL2c38fHzUXI9ox73bX4=;
        b=Z1MNzhvvps5vcsD5qAoJ+KtsTNcmeE8gm+yif+au3ZUaGWdg2TJAnodX5F4huQ9Bdv
         2U2MydWHzCQ1rrR0G/t4azaUZgaiGJFtoZhn9jpgJcLwC1nq8gAQWO7s1txPD9YHuohj
         T1M9BfgL2gclIKREq/En6KXnLjXSp40ikKLfUpesh3BGoLBdHaOl9MN3E42BhhYYBqny
         Dj+WNEORb0TKtDdMKZ9ccJwy+4TeBravtiPhMh4HGn2yC89zmbWJQvMlwLzjcSRSVyJV
         vtltL20eH5ouvaS9mClDu2h3yHN6kiKjsVkweBlvY/XV66knQRwgdE9XtpazwRLkg+QR
         xUdg==
X-Forwarded-Encrypted: i=1; AJvYcCUgGm0N7V5phVSeA9YBaB/O2m0veUEOiexrszlA0lxDVc+n7m+xaBgrYd/bfkJbWysQYiRLmQRZ1EpdjEXXE4JOHA6gxTdUr69pFlHlAnpVE+e+NzkM1LHmIn3SAeHHAfK3F1wFxkI08di/PA==
X-Gm-Message-State: AOJu0YydQJRgLbuGtk28T52U1gP507NTH6omrRR8+Rx0EnZ+BcduJMCn
	PHE9gJJNNNWyrRZVLg4zWkp4gYW8c1jCw3E31qKd7NxzLxeG1gdeaIFgXjTl9HoNuIG9YgEAOqx
	g0Ymc0yXwBujZpWJo71KxxDxA6qXYBnivMVdv3g==
X-Google-Smtp-Source: AGHT+IHVUsA14uvH5cdRm1hbC9FRNg26SX36cSw+9ytENyZ0GuswsCIEAvjwzSVxCZc/roem6A6mk/t2rinKz/MZwgk=
X-Received: by 2002:a17:907:1909:b0:a46:716d:7f7f with SMTP id
 ll9-20020a170907190900b00a46716d7f7fmr7416932ejc.24.1710676659541; Sun, 17
 Mar 2024 04:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sun, 17 Mar 2024 19:57:28 +0800
Message-ID: <CAKHoSAsAt3hsZeqDBA6T_HkqgPWwrgmeBrZ+g7R5Wtw6auChKA@mail.gmail.com>
Subject: VFS: Close: file count is zero (use-after-free)
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)

git tree: upstream

console output: https://pastebin.com/raw/nWDbVZij

kernel config: https://pastebin.com/raw/4m4ax5gq

C reproducer: https://pastebin.com/raw/0ZSaae7K

Syzlang reproducer: https://pastebin.com/raw/RbiX9xe6

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

VFS: Close: file count is 0 (f_op=0x23b70e000000000)
BUG: unable to handle page fault for address: ffff88810a878000
WARNING: CPU: 1 PID: 1 at fs/open.c:1507 filp_flush+0x16f/0x1c0 fs/open.c:1507
hrtimer: interrupt took 15451 ns
#PF: supervisor read access in kernel mode
#PF: error_code(0x0009) - reserved bit violation
PGD ae201067 P4D ae201067 PUD 100316063 PMD 10a877063
BAD
Oops: 0009 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 307 Comm: syz-executor861 Not tainted 6.8.0 #1
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

RIP: 0010:memmove+0x1e/0x1b0 arch/x86/lib/memmove_64.S:44
CPU: 1 PID: 1 Comm: systemd Not tainted 6.8.0 #1
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 f8 48 39
fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 89 d1 <f3> a4
e9 d6 84 1a 00 66 2e 0f 1f 84 00 00 00 00 00 48 81 fa a8 02
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RSP: 0018:ffff8881049bf828 EFLAGS: 00010216
RIP: 0010:filp_flush+0x16f/0x1c0 fs/open.c:1507

RAX: ffff88810a40f03c RBX: ffff88810a40f000 RCX: ffffffffffb9700c
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75
59 48 8b b5 b0 00 00 00 48 c7 c7 00 a9 30 a1 e8 b2 76 9e ff 90 <0f> 0b
90 90 e8 c8 67 ce ff 45 31 ed 5b 5d 44 89 e8 41 5c 41 5d e9
RDX: ffffffffffffffc4 RSI: ffff88810a878000 RDI: ffff88810a877ff4
RSP: 0018:ffff888100227f00 EFLAGS: 00010282
RBP: ffff88810a40f002 R08: 0000000000000000 R09: fffff9400081772e

RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9df67582
RDX: ffff888100218000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88810a686000 R08: 0000000000000001 R09: ffffed10235e5121
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff8881001dc000
R13: ffff88810a686018 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0c74a8d900(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e6578bda78 CR3: 0000000100f18006 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __do_sys_close fs/open.c:1548 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x81/0x120 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f0c75257c2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c
24 0c e8 a3 4d f9 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 e1 4d f9 ff 8b 44
RSP: 002b:00007ffd7894ebb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f0c74a8d6c8 RCX: 00007f0c75257c2b
RDX: 00007f0c7533abe0 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000000 R09: 00007f0c7533abe0
R10: 0000000000001000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffd7894ee40 R14: 0000000000000004 R15: 0000557f4bad8bb0
 </TASK>

