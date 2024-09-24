Return-Path: <linux-fsdevel+bounces-29980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7106D9848F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399C62845CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5651ABEA1;
	Tue, 24 Sep 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPKBZ9dS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0091AB6D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193447; cv=none; b=fcHBpgg8M/ujZgJgyA1L8F1EPo6nLIKe1BSOdDISdYhTUuo5XfxP1gOzXJwOPLoNOw0ez8zMLPRpqiRnohF0M5FbBtiTzuhzJ/Kgaz98P4F22296aZUecL+B4X7K+6rt2lX5CDV4bWi8T7+0byz6TtT1L6Ptj8Iq2LAHjTVUIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193447; c=relaxed/simple;
	bh=6qB2Y/v8lHK5nxyWIAPnNhL9lVPTxYVgvNq5DmY/uxw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C1EChz7T8bzVh5saoKntRN/zFc5ipM2Bj6NuhWtRREQveuysrLFUJToT/FgMNPW7BVaeKiRTAgfPdUAJ9qHzIyefnmCr2pzytsFuXBf8YG/RJFdgUlH+L6lx5Lv0DY9yOXSDex1sHZsNbKz/Tx9EOgSNYVyl1xURVQoG0ZdSlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPKBZ9dS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so30935051fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727193443; x=1727798243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWjBZ6ePnJ3ZvXHUOjr3QzL91L445uJTvSbMxhDQZXw=;
        b=DPKBZ9dSwLIAEFzEI8O7MPIe7bZJ9+Wyh+/I8NnyCzsPXTx63Zvq/60NpGKxk0KjDF
         VJM/j9tp8TJDq/IB7rEyY+5D1+PHxTBBXP+F1xgkmEWw/PnmgtgAop6laDdnkaqXlW41
         oV6nxKvTnR+JFA4In6nG4fvaVZye+iMuX5vLHnQO39fGZ9XBYctfn6cfuX1kqDWWklMv
         8CRatjFHxY2xtNKp6NedC57dfPTe/CSVMU+GhyFhKe4PGi0AZOz8PDQmuote2KW8PLYH
         proIDyNskwc81ZhaX9JcpAcYlZRDIHnYqH3GjTX/1dh1+LlT/ZyX/7+pZIRVDTAOWByS
         c7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193443; x=1727798243;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWjBZ6ePnJ3ZvXHUOjr3QzL91L445uJTvSbMxhDQZXw=;
        b=CtiEaeVzXHpXu6WWEWD3hEwGpR7wRI6dfDFFJDaEn0fnySDg7XdvEZ6GH286JnudNX
         kndC1OWQAKOOFJLUp6JJRDjW6JhGzyh0MVxBkC8N7yieemXAJ8KphvqXxcOCiu0vKd3s
         Yi6iv+zG4Gt2X5f+/x1BE0OPEntbdvuYKEH14klgdLYjFFmJ0RMnpwDcKQiDw94H9ZHV
         2hURsDWG+4cOG1pJ2n643OrwVnVRY4jd1O1srSaRbVoVfW8cwzfWNC/FNmCKora0NqwA
         XXdO/kUSTN1g4NtPkLTmEU2/k3wOm6E/VwXnjeghMbBYZIhgihF5fH/s0tA8JLuaqGCe
         zRPA==
X-Gm-Message-State: AOJu0Yyg2Q3ax8SlXUe0mVgILRGWYLUGgf+G/qAFSEGTJ1SeIwBeJkOc
	YCe8W3rPqhmxoUKZiJ1a5MinGkuOafTwngAM8XCvgBW5yIinSLPNwTGNVhasU39onaJWm9c88ot
	SU0m8e0ascXrkGUTIIB2dYGatRrU=
X-Google-Smtp-Source: AGHT+IFYAOXNjuXPP9f6EsMGAOmIFiAbkb4OFJH8aUJPd1m6k7DW/6F07t8iJ06j/7enxNn8YdIvkQL3KqHrhgMVZs8=
X-Received: by 2002:a05:6512:3b92:b0:536:5810:e89 with SMTP id
 2adb3069b0e04-536ac33f3f3mr9940820e87.49.1727193443132; Tue, 24 Sep 2024
 08:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Tue, 24 Sep 2024 11:57:12 -0400
Message-ID: <CA+-ZZ_iZFM6s5d9T8yL5Pb1u_VtkAyZHvm-L=N=XoOXAb5rT3Q@mail.gmail.com>
Subject: Report "general protection fault in do_select"
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following crash when fuzzing^1 the Linux kernel 6.10 and
we are able
to reproduce it. To our knowledge, this crash has not been observed by SyzBot so
we would like to report it for your reference.

- Crash
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 0 PID: 239 Comm: syz-executor Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:vfs_poll linux-6.10/include/linux/poll.h:82 [inline]
RIP: 0010:do_select+0xaa7/0x13f0 linux-6.10/fs/select.c:538
Code: c1 e8 03 80 3c 30 00 0f 85 c7 07 00 00 4d 8b ac 24 b0 00 00 00
48 ba 00 00 00 00 00 fc ff df 49 8d 7d 48 48 89 f8 48 c1 e8 03 <80> 3c
10 00 0f 85 b9 07 00 00 4d 8b 6d 48 83 e3 01 4d 85 ed 0f 84
RSP: 0018:ffff88800bed7740 EFLAGS: 00010206
RAX: 0000000000000009 RBX: ffff88800a608780 RCX: 1ffff110017c30d4
RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: 0000000000000048
RBP: ffff88800bed7be0 R08: 0000000000000000 R09: ffffed10017c30d1
R10: ffffed10017c30d0 R11: ffff88800be18683 R12: ffff88800a608780
R13: 0000000000000000 R14: 000000000000001e R15: 0000000040000000
FS:  00005555585f49c0(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f4ae87930 CR3: 000000000a098001 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 core_sys_select+0x270/0x5f0 linux-6.10/fs/select.c:681
 do_pselect.constprop.0+0x159/0x1a0 linux-6.10/fs/select.c:763
 __do_sys_pselect6 linux-6.10/fs/select.c:804 [inline]
 __se_sys_pselect6 linux-6.10/fs/select.c:795 [inline]
 __x64_sys_pselect6+0x154/0x1d0 linux-6.10/fs/select.c:795
 do_syscall_x64 linux-6.10/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 linux-6.10/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f2210e3194b
Code: 29 44 24 30 4c 89 4c 24 40 48 c7 44 24 48 08 00 00 00 64 8b 04
25 18 00 00 00 4c 8d 4c 24 40 85 c0 75 2c b8 0e 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 7d 48 8b 4c 24 58 64 48 33 0c 25 28 00 00 00
RSP: 002b:00007ffe3c6a17c0 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f2210e3194b
RDX: 0000000000000000 RSI: 00007ffe3c6a1940 RDI: 000000000000001f
RBP: 00007ffe3c6a1c10 R08: 00007ffe3c6a17f0 R09: 00007ffe3c6a1800
R10: 0000000000000000 R11: 0000000000000246 R12: 0000555558611e80
R13: 0000000000000001 R14: 0000555558612d50 R15: 00007ffe3c6a1cf0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_poll linux-6.10/include/linux/poll.h:82 [inline]
RIP: 0010:do_select+0xaa7/0x13f0 linux-6.10/fs/select.c:538
Code: c1 e8 03 80 3c 30 00 0f 85 c7 07 00 00 4d 8b ac 24 b0 00 00 00
48 ba 00 00 00 00 00 fc ff df 49 8d 7d 48 48 89 f8 48 c1 e8 03 <80> 3c
10 00 0f 85 b9 07 00 00 4d 8b 6d 48 83 e3 01 4d 85 ed 0f 84
RSP: 0018:ffff88800bed7740 EFLAGS: 00010206
RAX: 0000000000000009 RBX: ffff88800a608780 RCX: 1ffff110017c30d4
RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: 0000000000000048
RBP: ffff88800bed7be0 R08: 0000000000000000 R09: ffffed10017c30d1
R10: ffffed10017c30d0 R11: ffff88800be18683 R12: ffff88800a608780
R13: 0000000000000000 R14: 000000000000001e R15: 0000000040000000
FS:  00005555585f49c0(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f4ae87930 CR3: 000000000a098001 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

- reproducer
syz_genetlink_get_family_id$mptcp(0x0, 0xffffffffffffffff)
unlink(0x0)
syz_genetlink_get_family_id$nl80211(0x0, 0xffffffffffffffff)
r0 = socket$nl_generic(0x10, 0x3, 0x10)
openat$null(0xffffffffffffff9c, 0x0, 0x0, 0x0)
socket$inet6_tcp(0xa, 0x1, 0x0)
syz_genetlink_get_family_id$ipvs(0x0, r0)
r1 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
read(r1, &(0x7f0000000000), 0x2000)
r2 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x0)
ioctl$SCSI_IOCTL_SEND_COMMAND(r2, 0x1,
&(0x7f0000000000)=ANY=[@ANYBLOB="000000001d00000085", @ANYRES8=r2])


- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=sharing


[^1] We used a customized Syzkaller but did not change the guest kernel or the
hypervisor.

