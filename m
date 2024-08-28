Return-Path: <linux-fsdevel+bounces-27658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38989633B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83121F232AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A041ACDF0;
	Wed, 28 Aug 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pxLWG6tk";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="aNQF0bHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F045C1C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879808; cv=none; b=u1gm440eeKEUZ/MoWonntYgNAm4LwIP1b+DEI1O4naNH16NJzNPvSdDXVTRzxm0BgMOmvTjZgM5U37JdGKWyxxmP2cJq7MF8l5rnf2dEhmvP0m7EBh09Z09TMi7+1L66olMwTdH16R/afUrk8kQ1cskPDPxy3H9oU53ZB0BrhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879808; c=relaxed/simple;
	bh=DdLdQ0lOYPW51S1sfSh2vR6kyccpb2I0rHjrvTJ2zvo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cVloyntAOq/cjtalKcyvR0vUTKTgJ5vjyAzrjSH3/rw7Tz2H/w2cAohafxm9avnIVWu7jNVVHyJDOUZRaxaYF875OQZBNlf1naIXIAEXaST3iefKm0a75QOZDFoS5v2lFA4ZYvOiJ2EeDwfsUI0OE9lw5Ufrfq90MMER/iq5AOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pxLWG6tk; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=aNQF0bHi; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724879806; x=1756415806;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=DdLdQ0lOYPW51S1sfSh2vR6kyccpb2I0rHjrvTJ2zvo=;
  b=pxLWG6tkHVj95xW6X30xwIwMZfBDRd1WSxdLubP4lg21acX7bUHhobeW
   JUU5Cj7UQufLaFY2bpCVarqm8Ggy2jkcn+83fU6Fz8fBcAIz5zcvOhVj5
   kPfBTQggLU/3kjW3ClTpm63ALzB0u1h7BFT+jvwGM95xP0CbdOAbEE8NX
   /hBNpVbkjyzwmTU3zr9g+jXp0tOLYkNBlQF5h3qD0YoM8Mp36Yyhj6CXD
   nZkRotDKc2pM5Fb7OL4U7CaQ5RTeuaDN7YFhlQ2TnkJDLMkRolYjizfeA
   HG6IDLFViPxB7Xi7JNDkEjbavneyciUVfUYaEPO2q3JY4/i/yH9tir/CC
   A==;
X-CSE-ConnectionGUID: Tuicn4OdSfGL9CuXycjScw==
X-CSE-MsgGUID: 0N3icrxsQ0ON7SP53EhtCA==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 14:16:45 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3c4d321f4so7360520a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724879805; x=1725484605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bpKn7T7eSfRucTzjSNDV0Z1NPz4ViGohQ5LbBcV1I44=;
        b=aNQF0bHi/TkQzpo1Xz7BYLm+N+3STS9HGURhgvwJeoXMaJH6tfMSria0uNPjZugbmP
         cVQriNP9uwQEZYH18qHCGIYFVOljRLPJjz1ul45rcFTubZeo8D7sxHavsSLY7TKqQvT4
         1MDziFSEA5HkWuCME6nquagGnv3Sb7vJxczdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879805; x=1725484605;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpKn7T7eSfRucTzjSNDV0Z1NPz4ViGohQ5LbBcV1I44=;
        b=tSkMSftRK6dM9uDc8odZfXCJGAUE8K/z6w4WWc8hEoJEB7F8Sl9ClS6PP5Z654wRPy
         x2yEpBrAWnobgjv5ivNMPf8DxqxhvXvzLvt+QjaZAPJgJnx454JPQuXRdgKydqC+/Uh5
         M8nbBxJWrfoiQRb1MRaYjHgc0tqfchn0vMqnKk8W60YJWFV1eAyVHqOhb2HzZak7P6IQ
         0ifkEH1GmX+Dd2nGJsJ9HyF8yDm39Gap4aKAtLyxej+0iOos5PAilhEssrlc4EQWXLZY
         E6faZalVZOAs3BjVA+t24h5MjFDDy3awYzUI3CqGPgEre4ZkiOUb0GXAwTw0Cgw2+yAa
         4BaA==
X-Forwarded-Encrypted: i=1; AJvYcCUCdHsAQa66SY1fSMvlEEYjcp9/LiWDiZaI1vxf3FRRaA8ofIvGuKEFI4EAx21AQ1d6DMX5FLsVppJafiId@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOXmqjFfN+q+CAkVNtuJyr9DuBKXe05NGlbw7gwQrc2lVUspN
	3Rvrq2cQm22Ix0zPuupIk7nlAGXG8V4zeh3r/pkCCBcFvMvUBngAMMmH+KVDjNKcgEcI/4HDELk
	H/8fQqcDI6uf15roohFhB62wNoHWYJUg5yB/fBpN5PElOd0qG+4mmHZwoFXVWUhj3EFoRbLkNVr
	m1O/pyq4DcDU6w99jZ2OatgX/JwuiqM04k924YN4A=
X-Received: by 2002:a17:90a:c912:b0:2c9:67f5:3fae with SMTP id 98e67ed59e1d1-2d8563a0391mr600569a91.28.1724879805279;
        Wed, 28 Aug 2024 14:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5/cbKaWahfvf1Ls+XNN78PGGItQzDGcMnYxsa9ddu9OSSPU6khAYGMeAHk99SriBkg5jxRez3w4n/gwvoOY=
X-Received: by 2002:a17:90a:c912:b0:2c9:67f5:3fae with SMTP id
 98e67ed59e1d1-2d8563a0391mr600550a91.28.1724879804852; Wed, 28 Aug 2024
 14:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 14:16:34 -0700
Message-ID: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>
Subject: BUG: WARNING in retire_sysctl_set
To: mcgrof@kernel.org, kees@kernel.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It is possibly a logic   bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
------------[ cut here ]------------
WARNING: CPU: 0 PID: 27 at fs/proc/proc_sysctl.c:1536
retire_sysctl_set+0x3e/0x50
Modules linked in:
CPU: 0 PID: 27 Comm: kworker/u4:2 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:retire_sysctl_set+0x3e/0x50 fs/proc/proc_sysctl.c:1536
Code: 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 44
a1 c6 ff 48 83 3b 00 75 07 e8 19 96 63 ff 5b c3 e8 12 96 63 ff <0f> 0b
5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55 53 48 89
RSP: 0018:ffffc900001e7ad0 EFLAGS: 00010293
RAX: ffffffff822dbb4e RBX: ffff88801b87bc68 RCX: ffff8880137a3c00
RDX: 0000000000000000 RSI: ffff8880137a3c00 RDI: ffff88801b87bc08
RBP: ffffc900001e7bd0 R08: ffffffff910fc58f R09: 1ffffffff221f8b1
R10: dffffc0000000000 R11: ffffffff8ab261b0 R12: ffff88801b87b980
R13: 1ffffffff1e0aec8 R14: ffffffff8f057620 R15: ffffffff8f057640
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005599fcd69b18 CR3: 000000003c258000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>


-- 
Yours sincerely,
Xingyu

