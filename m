Return-Path: <linux-fsdevel+bounces-24049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E76938B85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869371F210C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD67167DA8;
	Mon, 22 Jul 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQq9SBxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835608F66;
	Mon, 22 Jul 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638386; cv=none; b=ogmE7nITZSaptBA6mc4C6uJYv849sgcoATUzOoXQ+/6yeIVk60B1nFqn5hRCI1Ev2sh4ZAwcsfC2sS2joqEbsO8gGKtolU5cH2Ua2nMzDMpDshD2SOfBDRToPur7Iu9fiev+qykyOA8EvnCiZNcuabJ7X0qU19APDFEoqLozaxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638386; c=relaxed/simple;
	bh=9DDOShtjPdOTEUiU4gaefYy78nZkFm4knEUdX7dutwg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rFE6OCJluZhMlNzPov6NeeWcxJjEF46+ZVn+4RUI6DL+E9oLZb1OtTddGImxlQpFa8Ujt9f7K7Nbucq7Ks8tnsDH28rUe37xpL3oX+OIuqie2zAsTu76F5Zyl/NPps1j+zeukBEruSvcCT46V7MwTiSt1bguN7ytAEf59xixu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQq9SBxf; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d94293f12fso2437442b6e.3;
        Mon, 22 Jul 2024 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721638384; x=1722243184; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgyUp37D+oZuQgyHubUu/VMC/vhsx9B1nh6d2LUzw0E=;
        b=LQq9SBxfyTy8wjqYGsgcBjpu/di4MVuWDZ9ZChWNN2DHbFfOVjdB3fhDv/Dqhgb564
         pGBPTxaxUJaBadzbIL/FgyAUsoaqd/F5aYW3IpLgkJPlSqghXOSUHeJv0lQ6OwSfDcvq
         dR04dWV3ttYTz8K2ZXrOSDOyAqQ8zS5B7h/KLpROc6fppHhtF2kXq15AFY12VrSruET2
         IHDoW4BO7mJCAUFTp+zw5TBH1R0w3/JYoPYxBBD9n0gwHv3jSNiS7CBW/vuCULJLz6UM
         CZe3fN+T9yueq7lxfOQyjY4m4miMU2j0msc8cHEXYaaWLhJ4NcZyZBLDk7o+AmxeasxK
         eO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638384; x=1722243184;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgyUp37D+oZuQgyHubUu/VMC/vhsx9B1nh6d2LUzw0E=;
        b=aRLKJkMicclmOhhrT+fC+1wk3o0d8lr9TCt5NpiA6c3Y/HZMvphhY70IwrnIvJEWph
         fq3dB9HSrm1IF6J0FwCY3cpiu47r9EpfU9ELnJ2w9+3nHbgLKogFvSbuY2nnrdQToMGs
         cfxyg77jROmgbtw/eWJk7umIA/MQmW9EQzyei2c7CfCgc8CUVUzaFG+TfwssPTvmXslD
         WlsU3itxvmcts5EOVQkOqJ9BGkoHi0WvOZWiR7/IN7WIkqOKVjQHRcq8bFuGSz96swKw
         waoA8feG9mBkgR7aIYxozoSIY6bTCLP9yFaDD4nQbWKg/hmiwz92wVCH0Igr6Y6mtG+d
         kVWA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Rb32W3dqS3VZ47k4N5N/2pIPXrKHOwX6aGL53k+7Gf/iPYVUaJDYrl70Alm9qOwN4S/nFCFBIcuVmZFFE2eKIisAKmX9MtSb/JvjrRsgZRiLSRNOyaHsyeagm+ryVuPEHGp/Rw7MQhM9qQ==
X-Gm-Message-State: AOJu0YzjQPEsCGF7QXXu7q6v1Ph2oOPWpFbbg72muczP6QaCuNNUdBT6
	6Y9xe/Rh7PkIPclylDcuvZpAGMxB1M+AKkeOjVtEKdbHczzRmL1A
X-Google-Smtp-Source: AGHT+IHXAtrevfwh01sQw7QcQYj/+dwxUfSdpRtHETu3548X1HQiRuuQOSGOHqrRlxrrB6+bay9bAw==
X-Received: by 2002:a05:6808:148c:b0:3d9:385d:8754 with SMTP id 5614622812f47-3dae6008f56mr9155561b6e.47.1721638384362;
        Mon, 22 Jul 2024 01:53:04 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d183fe85dsm2607600b3a.133.2024.07.22.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:53:03 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paulmck@kernel.org
Cc: qiang.zhang1211@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] nsfs: Fix the missed rcu_read_unlock() invoking in ns_ioctl()
Date: Mon, 22 Jul 2024 16:51:49 +0800
Message-Id: <20240722085149.32479-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Currently, the syzbot report follow wanings:

Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 0 PID: 3460 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0x354/0x49c
Call trace:
rcu_note_context_switch+0x354/0x49c kernel/rcu/tree_plugin.h:330
__schedule+0xb0/0x850 kernel/sched/core.c:6417
__schedule_loop kernel/sched/core.c:6606 [inline]
schedule+0x34/0x104 kernel/sched/core.c:6621
do_notify_resume+0xe4/0x164 arch/arm64/kernel/entry-common.c:136
exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
el0_interrupt+0xc4/0xc8 arch/arm64/kernel/entry-common.c:797
__el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:802
el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:807
el0t_64_irq+0x19c/0x1a0 arch/arm64/kernel/entry.S:599

This happens when the tsk pointer is null and a call to rcu_read_unlock()
is missed in ns_ioctl(), this commit therefore invoke rcu_read_lock()
when tsk pointer is null.

Reported-by: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=784d0a1246a539975f05
Fixes: ca567df74a28 ("nsfs: add pid translation ioctls")
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 fs/nsfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a4a925dce331..e228d06f0949 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -188,8 +188,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			tsk = find_task_by_vpid(arg);
 		else
 			tsk = find_task_by_pid_ns(arg, pid_ns);
-		if (!tsk)
+		if (!tsk) {
+			rcu_read_unlock();
 			break;
+		}
 
 		switch (ioctl) {
 		case NS_GET_PID_FROM_PIDNS:
-- 
2.17.1


