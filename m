Return-Path: <linux-fsdevel+bounces-41775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D1A36E2D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D391616F792
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA221ADC8F;
	Sat, 15 Feb 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="EXMC1qvz";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="S8CsQ5JK";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="lTa9zUMI";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="w9c6U+ly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F6748D
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Feb 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739623217; cv=none; b=FPB7tFFVuxWYydXXozTNxT5JjlkyK1+Sl17A+kAjqoEHQUyYZQeAwT9AFZY2GqjDNO1Ex6xQzd+ZIVqtaEXz3+oxyA5fZ7vLgp2lW+pWfuIlAvVRpirMpKZ1CoeutLl+GtO9ucAvHcv7jDMZmOxEgh2SiRZik631v5bRvns8ByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739623217; c=relaxed/simple;
	bh=4Me3tq187CJqjKZNxE4uX5x4ec+XCIKou+0o7H0prQw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DyAH2xBig9yXBwP0F9L0CyI6REBQIz/5+azbmHh9Uc5WEKqMjyKhF2NBxPRprEv3omZ5O27tG5Bqlm0jzIY6o0Xjs3ZcqvgDI1fiSqA31LobqGu5jVarVlglWRDZwmMShejV1ZkVbU3ZHulWO9/MGOdBptAHVuUC/74jggtpTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=EXMC1qvz; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=S8CsQ5JK; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=lTa9zUMI; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=w9c6U+ly; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:73d2:3698:9cbf:e408])
	by mail.tnxip.de (Postfix) with ESMTPS id 3555B208C9
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Feb 2025 13:34:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1739622877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAjAZKVIatXynFH5H/vLQ+HOBY8dTC3ZiCaNubT/v9w=;
	b=EXMC1qvzPDGdV+aAwuqzXpXfjMiI5/1YuDt6645r/oBJUt5QOrMQ8pUGonHWX0+FoLQ/qK
	jQs4LteFzPlXPVrnpPWAXoNqdZf/MhfKTeVyBRMrSCdSLzrqZ04ODmS/JoyAkaeDShqo+Z
	FTgPI3PcA0hrTJOgnxWLXCsRkA12Bhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1739622877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAjAZKVIatXynFH5H/vLQ+HOBY8dTC3ZiCaNubT/v9w=;
	b=S8CsQ5JKFgiWpObJPpszWKUX5h9rgRXJH/RU11dnQO/6HeTRKEhXrXb1Vw4sqHCAvRBc/5
	Wz0RqoTDo4LDs3DA==
Received: from [IPV6:2a04:4540:8c0a:7600:11ef:cffe:93dd:6a59] (unknown [IPv6:2a04:4540:8c0a:7600:11ef:cffe:93dd:6a59])
	by gw.tnxip.de (Postfix) with ESMTPSA id EBD4330000000002E1306
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Feb 2025 13:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1739622877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAjAZKVIatXynFH5H/vLQ+HOBY8dTC3ZiCaNubT/v9w=;
	b=lTa9zUMIy+xu2AXsUJcjoxFqxblTiqFHAbr+ilDQK2TJ4YvGmNWHot3abzvlalwGcdOzgi
	sfDkxsh2sZTljVVuKwdJLYXQcg9ZLVzG8q4icpxglRe4c7XBryRtfMZZ29FZfAFIgDV2QQ
	oKzT+/Kp/ljeHyB1wH7MPePfs69rHg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1739622877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAjAZKVIatXynFH5H/vLQ+HOBY8dTC3ZiCaNubT/v9w=;
	b=w9c6U+lyKehwYEzauMdoxUkqQk+G1kOW4dH35As5bnQAw8iaNdS001rH2zkac1EEdpYf9s
	hDL+ERcjmLoLxLBw==
Message-ID: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>
Date: Sat, 15 Feb 2025 13:34:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: en-US, de-DE
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
Subject: Random desktop freezes since 6.14-rc. Seems VFS related
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 
reproduce this, but it tends to happen when I delete stuff on /tmp (tmpfs) using
KDE's dolphin. I usually loose the ability to switch vtys or launch new terminals,
so by chance I had dmesg running and got the call trace below when things started 
to go south. At this point dolphin was defunct state, and was consuming 100% CPU.
'perf top' was showing xas_find, __lock_acquire, lock_release and sched_clock_noinstr
with highest percentage. Since I also have current bcachefs merged in my kernel I
already checked with Kent, but nothing seems to point to bcachefs. Also my other
(non-desktop) systems running the same kernel do not show this behavior. 
Hopefully someone in here can make sense of this ...


[19136.543931] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[19136.543938] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 16-31): P314703
[19136.543943] rcu: 	(detected by 29, t=21002 jiffies, g=8366533, q=26504 ncpus=32)
[19136.543946] task:KIO::WorkerThre state:R  running task     stack:0     pid:314703 tgid:314656 ppid:3984   task_flags:0x400040 flags:0x00004006
[19136.543951] Call Trace:
[19136.543953]  <TASK>
[19136.543958]  __schedule+0x784/0x1520
[19136.543963]  ? __schedule+0x784/0x1520
[19136.543966]  ? __schedule+0x784/0x1520
[19136.543969]  preempt_schedule_irq+0x52/0x90
[19136.543972]  raw_irqentry_exit_cond_resched+0x2f/0x40
[19136.543975]  irqentry_exit+0x3e/0x50
[19136.543977]  irqentry_exit+0x3e/0x50
[19136.543979]  ? sysvec_apic_timer_interrupt+0x48/0x90
[19136.543982]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[19136.543985]  ? local_clock_noinstr+0x10/0xc0
[19136.543987]  ? local_clock+0x14/0x30
[19136.543990]  ? __lock_acquire+0x1fd/0x6c0
[19136.543995]  ? local_clock+0x14/0x30
[19136.543997]  ? lock_release+0x120/0x470
[19136.544000]  ? find_get_entries+0x76/0x2e0
[19136.544004]  ? find_get_entries+0xfb/0x2e0
[19136.544006]  ? find_get_entries+0x76/0x2e0
[19136.544011]  ? shmem_undo_range+0x35f/0x520
[19136.544027]  ? shmem_evict_inode+0x135/0x290
[19136.544029]  ? lock_release+0x120/0x470
[19136.544031]  ? evict+0x1a8/0x340
[19136.544036]  ? evict+0x1c5/0x340
[19136.544038]  ? lock_release+0x120/0x470
[19136.544040]  ? iput+0x1f2/0x290
[19136.544044]  ? iput+0x1fa/0x290
[19136.544047]  ? do_unlinkat+0x1e7/0x2c0
[19136.544051]  ? __x64_sys_unlink+0x20/0x30
[19136.544053]  ? x64_sys_call+0xa9a/0x20a0
[19136.544055]  ? do_syscall_64+0x58/0xf0
[19136.544057]  ? entry_SYSCALL_64_after_hwframe+0x50/0x58
[19136.544063]  </TASK>
[19157.614008] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[19157.614014] rcu: 	Tasks blocked on level-1 rcu_node (CPUs 16-31): P314703
[19157.614019] rcu: 	(detected by 8, t=21002 jiffies, g=8366553, q=40992 ncpus=32)
[19157.614022] task:KIO::WorkerThre state:R  running task     stack:0     pid:314703 tgid:314656 ppid:3984   task_flags:0x400040 flags:0x00004006
[19157.614027] Call Trace:
[19157.614029]  <TASK>
[19157.614033]  __schedule+0x784/0x1520
[19157.614041]  ? irqentry_exit+0x3e/0x50
[19157.614043]  ? sysvec_apic_timer_interrupt+0x48/0x90
[19157.614046]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[19157.614048]  ? find_get_entries+0x76/0x2e0
[19157.614052]  ? local_clock_noinstr+0x10/0xc0
[19157.614055]  ? local_clock+0x14/0x30
[19157.614057]  ? __lock_acquire+0x1fd/0x6c0
[19157.614061]  ? local_clock_noinstr+0x10/0xc0
[19157.614063]  ? local_clock+0x14/0x30
[19157.614065]  ? lock_release+0x120/0x470
[19157.614068]  ? find_get_entries+0x76/0x2e0
[19157.614071]  ? find_get_entries+0x76/0x2e0
[19157.614073]  ? find_get_entries+0xfb/0x2e0
[19157.614075]  ? find_get_entries+0x76/0x2e0
[19157.614080]  ? shmem_undo_range+0x35f/0x520
[19157.614096]  ? shmem_evict_inode+0x135/0x290
[19157.614098]  ? lock_release+0x120/0x470
[19157.614100]  ? evict+0x1a8/0x340
[19157.614105]  ? evict+0x1c5/0x340
[19157.614107]  ? lock_release+0x120/0x470
[19157.614109]  ? iput+0x1f2/0x290
[19157.614113]  ? iput+0x1fa/0x290
[19157.614115]  ? do_unlinkat+0x1e7/0x2c0
[19157.614120]  ? __x64_sys_unlink+0x20/0x30
[19157.614122]  ? x64_sys_call+0xa9a/0x20a0
[19157.614124]  ? do_syscall_64+0x58/0xf0
[19157.614127]  ? entry_SYSCALL_64_after_hwframe+0x50/0x58
[19157.614132]  </TASK>


Kind regards
Malte


