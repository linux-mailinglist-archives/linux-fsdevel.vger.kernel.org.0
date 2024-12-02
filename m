Return-Path: <linux-fsdevel+bounces-36262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF09E064D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C5168FCA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E039209F58;
	Mon,  2 Dec 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViNNdAcd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78410209F4A
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150232; cv=none; b=sRKZbcBO26zMuMB5BmaT+EqHgVv5KHEXXOslOQtvs2vbsrWeq4fXZqYU0cclWLKu62E6JIhGmIjF4+CqGemyC0C51ZTB7LYpen4I1j63tPI93ChTZCo3MiOt4guL+jzv/gMKXaCvXEkD2yR+U4X80cfPzP2w6bNZQWmXfjmE59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150232; c=relaxed/simple;
	bh=keUBHf4LT1c2qqH4FDB+AMc9qYCoa58p0VJTpR2WbZU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lKeAl7jC0/3Hknr4leXpMYVJB02rUmviMH+8HpZ15gOgwjSpbTVlx/Xpv/6GhIcIeZGeP7GhO7SJwOEO5L0g8yDKCExyLqLCSSs3TkLU4buTGzxak+lG9xHC3+RTpsLIDDYMW9lCCkhjpsHf6M5OTEukKct6TX8eXxmgfDD8jEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViNNdAcd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b66a740de4so302073585a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 06:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733150229; x=1733755029; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SaJBge//+fhCg4NDL5ctvf2DAR7dYtWsFFyuIREUVfc=;
        b=ViNNdAcduFlyB2vn20IwwUDo3tNOQo3ZEbopupNZNUxyKWdkUKcEvMDerNRsNR9uLs
         1tSsc39OFFcba5OdUuVWR0uU6iBTV8fY+8mCja3c9cidftiQFre++spkoEgY3utiwe/a
         xLRIt/PMEUhpl7S6sys/+gG6+0J6ViS135bLmGc59wRqCff6aWzIGY+fzZC4YZsvC7KO
         ebbHdlsVh/X0vAQe4L8RA3IzmZ90f7ZDAuqO0a/GGoiVEQhad4/Abtqzfiw7Q7uxfvKF
         SB0PZa0bb9bjFAaX4N9SNrAfdM5YbUQP40WoS8V4EQA1bw109lUPu/JTWMfPiICaJ4Pr
         qR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150229; x=1733755029;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaJBge//+fhCg4NDL5ctvf2DAR7dYtWsFFyuIREUVfc=;
        b=pi9mWzJiQmrzqJnCr/YwRu0tEgqIvFUSIJuG1kEcu1WAWCYiQpzsWCob/mKSstzNSi
         bvSQp+vcnzepHFwzAn2ImHiEnuayy2h2WsANAqJdgVIrHPmgyk+Rbui6hlw4Tt3mJw6j
         cflWMka3D8yrBneojOPjJVBBEJmaNJzY8sXKHONGiYXQP+Xqh60jZp8RuHRwQmVWprfY
         8CmNPKt79L/bfrb0m3oer2ZofFUCprMo+DiEFI9elWrtBx4bU9xENJFqydXtRF87UFxL
         QOx345qM2R5fjCgQvCsbjoh4N1chxz7NhZZMc8/CXbUkBtzEF6MbGVe2NQVdLg4kCXMs
         qAFw==
X-Forwarded-Encrypted: i=1; AJvYcCXWM+sa9Slko5P6k+4ByK4qBfuWKIz25TeDdpCeAJeVOND1o/ASw8rbe4NioBJchh4etXFEQ6ce/eBmyxEa@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIcZ0J9PzDnXp0SFZitDaZt3yq9O0CQwgHPd91XXepFg9j3K4
	d5M9ylrSIQqrHHvhxoWpqa61zuVfvfA7Rk8Tj65dDDcQxBY7DG9qqnJtPHcdXnSxngrCs5Ctb3d
	zN5P6qggoY2t9HZajv7j4Cy04Tpo=
X-Gm-Gg: ASbGncsJ4YOGyV3WNBe2Z88GeedxZqRUtp5xmJ+i2Ey0urxAJ2DaUwEs6pme+ujuc5I
	FAOSqGUzLR6YCP7fmVEisGZMe7kY+My+4SD1hFik7Hw==
X-Google-Smtp-Source: AGHT+IFvtmM8vUXqMdqFmEK616TPm1JoVINN7Ae3LMcge7a+N5M5I9gDAa3ghf51QqX9CBFEvt5HnNlvXlJYNvqqIK4=
X-Received: by 2002:a05:620a:198c:b0:7a2:2cc:83d7 with SMTP id
 af79cd13be357-7b67c250541mr3596927785a.6.1733150229245; Mon, 02 Dec 2024
 06:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Mon, 2 Dec 2024 22:36:58 +0800
Message-ID: <CALf2hKt8y5czY8JU88gc0KvUnr6opu-Rt0sCv+iQNN2cjzokOA@mail.gmail.com>
Subject: [Kernel Bug] WARNING in bfs_rename
To: aivazian.tigran@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Dear Developers and Maintainers,

We found a Linux kernel bug titled "WARNING in bfs_rename" on
Linux-6.6.63 through our modified tool. We also tested the reproducer
on the latest Linux-6.13-rc1, where the PoC can still crash the kernel
through WARN_ON. Here are the relevant attachments:

kernel config: https://drive.google.com/file/d/1wog0WflzY_EuOPj-n7iUHAyILxSZCwks/view?usp=sharing
crash report: https://drive.google.com/file/d/1oZcZLgQpPvQ5tZ7tTYmt0bk6NaPt7MVV/view?usp=sharing
repro report: https://drive.google.com/file/d/1Cw1dB8aO40lMS_a2EpL-jj2GM-8Tz18o/view?usp=sharing
syz reproducer:
https://drive.google.com/file/d/10fNQMrcHhUT0VoEopMjvuNPtxM2KVk-d/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1t-Pk6w76Xzes-j6Mg8oCTgo3XxzABHtz/view?usp=sharing

[Basic Cause Analysis]
In the bfs_rename function, the link count of new_inode is decremented
via inode_dec_link_count(new_inode) without first checking if
new_inode->i_nlink is greater than 0. If the i_nlink is already 0,
this causes an invalid decrement, triggering the WARN_ON and
potentially corrupting the filesystem state. This situation may occur
if the new_inode has already been marked as deleted (i.e., i_nlink ==
0) or if its link count has been improperly modified by other
operations.

[Possible Fix]
1. Check new_inode->i_nlink before calling inode_dec_link_count to
ensure that it is greater than 0. This prevents invalid decrements of
the link count.
2. Ensure consistent inode link count management across the file
system code, particularly during file rename or deletion operations.
Link counts should be updated properly and consistently to avoid such
errors.
3. Implement additional validation checks for inode link counts to
ensure that file system operations like renaming are safe and do not
operate on inodes with an invalid state.

Hope these would help improve the kernel security. If you fix the
issue, please add the following tag to the commit:
Reported-by: Zhiyu Zhang<zhiyuzhang999@gmail.com>


------------[ cut here ]------------
WARNING: CPU: 0 PID: 9422 at fs/inode.c:332 drop_nlink+0xab/0xd0 fs/inode.c:332
Modules linked in:
CPU: 0 PID: 9422 Comm: syz.7.210 Not tainted 6.6.63 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:drop_nlink+0xab/0xd0 fs/inode.c:332
Code: 43 48 8b 5d 38 be 08 00 00 00 48 8d bb 78 07 00 00 e8 29 27 e9
ff f0 48 ff 83 78 07 00 00 5b 5d e9 da 4e 93 ff e8 d5 4e 93 ff <0f> 0b
c7 45 58 ff ff ff ff 5b 5d e9 c5 4e 93 ff e8 40 20 e9 ff e9
RSP: 0018:ffffc90002f6fab0 EFLAGS: 00010283
RAX: 0000000000004e2c RBX: 0000000000000000 RCX: ffffc90003561000
RDX: 0000000000080000 RSI: ffffffff81f4149b RDI: 0000000000000005
RBP: ffff88803642f058 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88803642faa8
R13: ffff88803642ba68 R14: ffff88803642f058 R15: ffff888036a4ee20
FS:  00007ff30b784700(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c31eff8 CR3: 00000000331c7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2340 [inline]
 bfs_rename+0x42c/0x730 fs/bfs/dir.c:247
 vfs_rename+0xf83/0x20a0 fs/namei.c:4872
 do_renameat2+0xc3c/0xdc0 fs/namei.c:5025
 __do_sys_rename fs/namei.c:5071 [inline]
 __se_sys_rename fs/namei.c:5069 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5069
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x68/0xd2
RIP: 0033:0x5687ad
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff30b783bc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000715fa0 RCX: 00000000005687ad
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000020000140
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000715fac
R13: 0000000000000000 R14: 0000000000715fa0 R15: 00007ff30b783d40
 </TASK>

