Return-Path: <linux-fsdevel+bounces-29982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15763984901
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90092842EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE41AB6D1;
	Tue, 24 Sep 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm1rl5dl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253E1B960
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193759; cv=none; b=eJbRtlF8KNR5/uuNkeeE1vGjBEeVNCqPJH1AQXbeDw2eaT/jSXhrfWfA+WFZ+EydCIokaVBv7HNadZGIZzw3D/6wEFFhSqZ5xxIga/8oE/pIwN4hFlfQW3UueBEeA9ACCWL79xdSJabxbHPnzZ/WT5Xe5eh/OQZqZ/8EtIGmBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193759; c=relaxed/simple;
	bh=PDn7BazEK7HzBhPgaFj+gXrLfZTQaRkPPDxzjSQXQLw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KMH8egY7w+DtVUy3w1dEoIZRJzfqgUySFDhxYBwpAEYrdz5rDh53PelyYIAiKQGKy1TOrGj8gXS56VPZKZECunETQkUYN64P/VjXbVJbwp91VHvf7lZn46oqQjnh4hZ3GokUiSdEmOY68fmTXxXwGsGMvO9gQhhbvZIDh8VpJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm1rl5dl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53653ee23adso5222331e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727193756; x=1727798556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZiTdE29oqwnW5C5Onivrj18Z78Ip8/3m3kjogssD/MM=;
        b=Nm1rl5dlt1sBrrDD2A6mfXymWx3RUkTSgz0IPuqWK3k3IGKzGjzOBlMNB9lGTN/K/c
         BjdW40msddTQ0QaIzi3oLAMLXRw3jF/LsADEjtiSW00WB0rn2Ryt6LqccHMDFwga/0Ll
         qZRnfvCplxZ9ntvtbCUH+iuuvUKInXrFLyiDaUiBMsZxzSu9uf/qGE7uRtKQCcSg6wYZ
         ShuOZOVoc9siE2MwzmcXfR5nF/KitQ9wrcR4BM9+xxhdst/Awki7yO4LXAyr2hQd9A0b
         OTma5L0nTWM+74plpiTS0ddTCEMy328OHqpi54rOYdcAMEdnriArLPul63uYqmi1csNd
         GO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193756; x=1727798556;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZiTdE29oqwnW5C5Onivrj18Z78Ip8/3m3kjogssD/MM=;
        b=T5xrgQ4aNJRRPZlOR5RfHvdGvT+/YmqbsWfPN0R3H1CQukSI8BCvIxfKH8y5H4lxoa
         S8aZorAYom5oHm4373vAEPdpunzILY/Cwf3FPC08/6FWDmRPwoKhR9TUm5Awe1yQbjg3
         TYux5I966Rgm0Tgv7pPrfDigzkdTsLZgSwKs44sIq4liDi5ItPv9y/7SPvWNiRGK4SHf
         f3EWF1nMrCp3nyK2piDhZK1PVRQKR7v20SD23w0RoMHm+M5sBDgG42g7/LXMZYjx8bcN
         2jjf4uGz/xkpg338B3YYjKeFicXoxa59w1ZhQ0l1IXgvuuHmUH/0/NnZAOh3hgdesh61
         x2CA==
X-Gm-Message-State: AOJu0Yy/RLvRd55swdLpe5s6jX7UcrdsGRy4cfxjJndw2nXFcDb8lfPp
	5pIx2LczPohw7klaZ2mb3yqsrS3vajY8n4Y0QP70EsSrOW2nx+B9BCZagA5n3RP9hlYUKypHuB0
	xyOx9FjMNHx1Vwso1iuZsSixALPY=
X-Google-Smtp-Source: AGHT+IHJAtkiuQ9cWhmJb18o4Q2D315aoxm9f71kRlzFR+NkqnffhPG/NJkH+oUrzRyRwRoO5iof8aQ1Z8IEdy/348g=
X-Received: by 2002:a05:6512:33d0:b0:536:53dd:6584 with SMTP id
 2adb3069b0e04-536ad180828mr7662063e87.34.1727193755367; Tue, 24 Sep 2024
 09:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Tue, 24 Sep 2024 12:02:24 -0400
Message-ID: <CA+-ZZ_joZSUoev=XvOC0+uOAgdpufO8P=v3nO9Y_9o1KTmFafw@mail.gmail.com>
Subject: Report "general protection fault in sysctl_print_dir"
To: mcgrof@kernel.org, "kees@kernel.org" <kees@kernel.org>, j.granados@samsung.com
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following crash when fuzzing^1 the Linux kernel 6.10 and
we are able
to reproduce it. To our knowledge, this crash has not been observed by SyzBot so
we would like to report it for your reference.

- Crash
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 59 Comm: kworker/u8:1 Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:sysctl_print_dir.isra.0+0x6e/0xa0 linux-6.10/fs/proc/proc_sysctl.c:94
Code: 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75
2b 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 89 da 48 c1 ea 03 <80> 3c
02 00 75 1b 48 8b 33 48 c7 c7 c0 19 2f 84 5b 5d e9 3b 85 98
RSP: 0018:ffff88800ab27840 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88806d2288c0
RDX: 0000000000000000 RSI: ffffffff8191d8a3 RDI: ffff88801a00a400
RBP: 0000000000000000 R08: fffffbfff09d8001 R09: ffffed1001564ece
R10: ffffed1001564ecd R11: ffff88800ab2766f R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801a00a400
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb37bb683a8 CR3: 000000000ac4c004 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 put_links+0x214/0x490 linux-6.10/fs/proc/proc_sysctl.c:1480
 drop_sysctl_table+0xce/0x350 linux-6.10/fs/proc/proc_sysctl.c:1494
 unregister_sysctl_table linux-6.10/fs/proc/proc_sysctl.c:1520 [inline]
 unregister_sysctl_table+0x30/0x50 linux-6.10/fs/proc/proc_sysctl.c:1512
 neigh_sysctl_unregister+0x5f/0x80 linux-6.10/net/core/neighbour.c:3882
 inetdev_destroy linux-6.10/net/ipv4/devinet.c:333 [inline]
 inetdev_event+0x486/0x1390 linux-6.10/net/ipv4/devinet.c:1633
 notifier_call_chain+0xef/0x2a0 linux-6.10/kernel/notifier.c:93
 call_netdevice_notifiers_info linux-6.10/net/core/dev.c:1992 [inline]
 call_netdevice_notifiers_info+0x9b/0x100 linux-6.10/net/core/dev.c:1977
 call_netdevice_notifiers_extack linux-6.10/net/core/dev.c:2030 [inline]
 call_netdevice_notifiers linux-6.10/net/core/dev.c:2044 [inline]
 unregister_netdevice_many_notify+0x6b7/0x1400 linux-6.10/net/core/dev.c:11219
 cleanup_net+0x4df/0x930 linux-6.10/net/core/net_namespace.c:635
 process_one_work linux-6.10/kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x91e/0x10d0 linux-6.10/kernel/workqueue.c:3329
 worker_thread+0x431/0xa30 linux-6.10/kernel/workqueue.c:3409
 kthread+0x2c4/0x3c0 linux-6.10/kernel/kthread.c:389
 ret_from_fork+0x45/0x80 linux-6.10/arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 linux-6.10/arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sysctl_print_dir.isra.0+0x6e/0xa0 linux-6.10/fs/proc/proc_sysctl.c:94
Code: 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75
2b 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 89 da 48 c1 ea 03 <80> 3c
02 00 75 1b 48 8b 33 48 c7 c7 c0 19 2f 84 5b 5d e9 3b 85 98
RSP: 0018:ffff88800ab27840 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88806d2288c0
RDX: 0000000000000000 RSI: ffffffff8191d8a3 RDI: ffff88801a00a400
RBP: 0000000000000000 R08: fffffbfff09d8001 R09: ffffed1001564ece
R10: ffffed1001564ecd R11: ffff88800ab2766f R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801a00a400
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb37bb683a8 CR3: 000000000ac4c004 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
note: kworker/u8:1[59] exited with preempt_count 1
----------------
Code disassembly (best guess):
   0: 89 da                mov    %ebx,%edx
   2: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
   9: fc ff df
   c: 48 c1 ea 03          shr    $0x3,%rdx
  10: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1)
  14: 75 2b                jne    0x41
  16: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1d: fc ff df
  20: 48 8b 1b              mov    (%rbx),%rbx
  23: 48 89 da              mov    %rbx,%rdx
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e: 75 1b                jne    0x4b
  30: 48 8b 33              mov    (%rbx),%rsi
  33: 48 c7 c7 c0 19 2f 84 mov    $0xffffffff842f19c0,%rdi
  3a: 5b                    pop    %rbx
  3b: 5d                    pop    %rbp
  3c: e9                    .byte 0xe9
  3d: 3b                    .byte 0x3b
  3e: 85                    .byte 0x85
  3f: 98                    cwtl


- reproducer
socket$inet6_tcp(0xa, 0x1, 0x0)
syz_genetlink_get_family_id$mptcp(0x0, 0xffffffffffffffff)
socket$nl_generic(0x10, 0x3, 0x10)
socket$inet6_tcp(0xa, 0x1, 0x0)
r0 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
read(r0, &(0x7f0000000000), 0x2000)
r1 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x0)
ioctl$SCSI_IOCTL_SEND_COMMAND(r1, 0x1,
&(0x7f0000000000)=ANY=[@ANYBLOB="000000001d00000085", @ANYRES8=r1])

- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=sharing


[^1] We used a customized Syzkaller but did not change the guest kernel or the
hypervisor.

