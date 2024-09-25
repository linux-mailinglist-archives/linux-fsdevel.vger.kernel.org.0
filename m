Return-Path: <linux-fsdevel+bounces-30107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D13986422
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68EC1F269A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1C21AACB;
	Wed, 25 Sep 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb17EgjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3F20B22
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279432; cv=none; b=cQi7jyIumm4PvQsE+dS/zgJ4sNsP8ON0DVBgybvXJq+cTrxaJw0nzhUy1gPf1MMHLXklBV5JGJWWI9JCbx7g/LutRvhS9RCTfNz4yvuiaIi+kpGTGi4yFLL7E2w6BOHVCg+W005EzVfdQBqCxZu77+hgAt6bszlIBNXrXy2iWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279432; c=relaxed/simple;
	bh=pjuXSKNBJFJmRN701jOqrpujudqW8Qb0hSxjDE9RccU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ey54YXUSyztXaLbGaUEnj7VcLxaC1EHc3C8qGhG4W/e8KgcAJBCFA8TeLnsImLHOgtyWqsi4V/mt+sqOTcGJHpBmf5HMaYh37o7ce8fpguqoNUFGcB6vxVoK1NHu/7vaeEcwAFPV597KV1rI4M4hoHfs7nh8EC3FlZ1gqQV65BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb17EgjX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75d044201so570191fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727279429; x=1727884229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MGvxJOx0m15ElP+Cb7no83FvsGsOuHFHbLocdN/sFIY=;
        b=Gb17EgjXPkqP/iTa2HwV/nYNv71wawsng8FcZRfYUqlRmgUYsRflwOY6moJcYSOi2x
         VUHMwVhB25tUVQok16Mcn7HPynxiVrujTAnonPFDpK1Puh6nuKDFaW8Ee+bXOr8q3wmz
         Kz66UXjQSy6v+gdwmz86ldfOvNhwShvuV4ZoL0id3sPMdjo3zR/odIOTs+7Dw786+Gah
         vOI5MloFopJdSSagF6RmlVCXiUHL9ithWJTZ6DHMlMHxnAT2AvbAieD/ygysWq9Tq6JE
         Pr2MRE3Nk5j+he7szBzqLP2RMvo13nGInJ+JRTQ9hdqMqSdcumR9WaBsx8wyqJYP3FzG
         PHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279429; x=1727884229;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGvxJOx0m15ElP+Cb7no83FvsGsOuHFHbLocdN/sFIY=;
        b=kDIo4rAQmJ5y68N7DzHO2vcyJzQOULoB4ny2RlkMoLVQiH1E9FbYdLNiDBw8LWRhmy
         GI6yGh/UO3c4WCfaBSUTbaJXeEo9eR1S+Gz7LlujSUCxOIHl53zRffZA653Rz0EZpUfR
         bQAfm2xaZcwVbhIpPMKXnFy05B/jR3GHjgg0DXRnpSEpiWwOojHQEO+GLO1nOAXM80dP
         QmdMoCikAQL0XM8sShjN46/Sr7m6eF5sAnAo3KAbvv1fUjwL12ylI+FHaaBUKHveUq2n
         UOqWAXPxiE2zhNRg5ag6lGriJocvcgMZUU1AnZ46lufj7h1oDGhq7pny8cJ7kqKHuJmZ
         7jqA==
X-Gm-Message-State: AOJu0YymLP5wow2pfAPF+hzPcygPTth5xCg6UjDvzg6PSImStqUGXjbN
	I4ynQb4BxEyWY9WEF0rga01GDvuRP7YuI3+5LOxcsGDCjz35FI2JQFRU6/BFAT832ODvICtafLu
	jVmydx0UqHWDgRjJXKMvx5fffdyKStlvY8Qc=
X-Google-Smtp-Source: AGHT+IFoShcjBVDfC6i7WUK42U9XZqvsCm2IthDwvL0s/zi55MBgaAv1Y2lwbBwolklL/VIltkwGGdUSc1mW2g7n3hQ=
X-Received: by 2002:a05:651c:1546:b0:2ef:21a6:7c82 with SMTP id
 38308e7fff4ca-2f9c6d5a95emr143161fa.20.1727279428498; Wed, 25 Sep 2024
 08:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Wed, 25 Sep 2024 11:50:17 -0400
Message-ID: <CA+-ZZ_gDJ02P46ee08sFcFGUWCyS37nbybcRALnBkGhSPkB-fQ@mail.gmail.com>
Subject: Report "WARNING in putname"
To: viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following error when fuzzing^1 the Linux kernel 6.10 and
we are able
to reproduce it. To our knowledge, this error has not been observed by SyzBot so
we would like to report it for your reference.

- Crash
WARNING: CPU: 1 PID: 2687 at fs/namei.c:263 putname+0x114/0x140
linux-6.10/fs/namei.c:263
Modules linked in:
CPU: 1 PID: 2687 Comm: syz-executor Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:putname+0x114/0x140 linux-6.10/fs/namei.c:263
Code: 5d 41 5c 41 5d e9 8c 4b cc ff e8 87 4b cc ff 48 89 ee 4c 89 ef
e8 fc 0d f5 ff 5b 5d 41 5c 41 5d e9 71 4b cc ff e8 6c 4b cc ff <0f> 0b
eb d1 4c 89 e7 e8 30 9e fa ff e9 3a ff ff ff 48 c7 c7 b8 37
RSP: 0018:ffff88800b7dfe50 EFLAGS: 00010293
RAX: ffff88800c80c300 RBX: dffffc0000000000 RCX: ffffffff817771a5
RDX: 0000000000000000 RSI: ffffffff81777284 RDI: ffff888008a82210
RBP: ffff888008a82200 R08: 0000000000000001 R09: ffffed1001150443
R10: ffffed1001150442 R11: ffff888008a82213 R12: ffff888008a82210
R13: ffff888008a82200 R14: 00000000ffffff9c R15: ffff888007180128
FS:  0000555593f1ba00(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f754e228d50 CR3: 0000000009bca003 CR4: 0000000000170ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_mkdirat+0x184/0x280 linux-6.10/fs/namei.c:4169
 __do_sys_mkdir linux-6.10/fs/namei.c:4180 [inline]
 __se_sys_mkdir linux-6.10/fs/namei.c:4178 [inline]
 __x64_sys_mkdir+0x65/0x80 linux-6.10/fs/namei.c:4178
 do_syscall_x64 linux-6.10/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 linux-6.10/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f0e7fe1778b
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 53 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcacc14348 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f0e7fe1778b
RDX: 00000000000000cb RSI: 00000000000001c0 RDI: 00007ffcacc145b0
RBP: 00007ffcacc145bc R08: 000000000000000d R09: 0000000000011dcc
R10: 7fffffffffffffff R11: 0000000000000246 R12: 00007ffcacc145b0
R13: 00007f0e7feafec0 R14: 00007ffcacc14370 R15: 8421084210842109
 </TASK>
---[ end trace 0000000000000000 ]---


- reproducer
syz_genetlink_get_family_id$mptcp(0x0, 0xffffffffffffffff)
syz_open_dev$usbmon(&(0x7f00000004c0), 0x0, 0x0)
setxattr$trusted_overlay_opaque(0x0, 0x0, 0x0, 0x0, 0x0)
socket$nl_generic(0x10, 0x3, 0x10)
openat$null(0xffffffffffffff9c, &(0x7f0000001180), 0x0, 0x0)
r0 = openat$urandom(0xffffffffffffff9c, &(0x7f0000000040), 0x0, 0x0)
read(r0, &(0x7f0000000000), 0x2000)
shutdown(0xffffffffffffffff, 0x0)
r1 = syz_open_dev$sg(&(0x7f0000000040), 0x0, 0x0)


- kernel config
https://drive.google.com/file/d/1LMJgfJPhTu78Cd2DfmDaRitF6cdxxcey/view?usp=sharing


[^1] We used a customized Syzkaller but did not change the guest kernel or the
hypervisor.

